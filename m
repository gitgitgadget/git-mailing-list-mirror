From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] filter-branch: Simplify parent computation.
Date: Sat, 09 Jun 2007 13:44:01 -0700
Message-ID: <7vmyz8eu3y.fsf@assigned-by-dhcp.cox.net>
References: <200706082328.39758.johannes.sixt@telecom.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Johannes Sixt <johannes.sixt@telecom.at>
X-From: git-owner@vger.kernel.org Sat Jun 09 22:44:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hx7n6-0000Pu-Vj
	for gcvg-git@gmane.org; Sat, 09 Jun 2007 22:44:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759989AbXFIUoF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 9 Jun 2007 16:44:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759990AbXFIUoF
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Jun 2007 16:44:05 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:52979 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759989AbXFIUoE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Jun 2007 16:44:04 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070609204402.MKMN14072.fed1rmmtao103.cox.net@fed1rmimpo02.cox.net>;
          Sat, 9 Jun 2007 16:44:02 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 9Yk11X00W1kojtg0000000; Sat, 09 Jun 2007 16:44:02 -0400
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49614>

Johannes Sixt <johannes.sixt@telecom.at> writes:

> @@ -332,18 +321,19 @@ mkdir ../map # map old->new commit ids for rewriting 
> parents
>  

Crap.  Why is this patch line-wrapped X-<.

> ... 
>  i=0
> -while read commit; do
> +while read commit parents; do
>  	i=$(($i+1))
>  	printf "\rRewriting commits... ($i/$commits)"
>  

Crap.  Where did that "\rRewriting commits..." come from?
The other Johannes had the same in his patch.

> @@ -398,7 +388,7 @@ while read commit; do
>  		done > ../map/$commit
>  done <../revs
>  
> -src_head=$(tail -n 1 ../revs)
> +src_head=$(tail -n 1 ../revs | sed -e 's/ .*//')
>  target_head=$(head -n 1 ../map/$src_head)
>  case "$target_head" in
>  '')

Crap.  I seem to have "tee" there that stores them to ../map/$commit.

Anyway, I've manually fixed up the offending three patches (two
from you and one from the other Johannes) and pushed the results
out on 'next'.
