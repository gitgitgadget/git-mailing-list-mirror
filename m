From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] filter-branch: use sh -c instead of eval
Date: Wed, 06 Jun 2007 13:53:48 -0700
Message-ID: <7vd508ztwj.fsf@assigned-by-dhcp.cox.net>
References: <20070605165734.GA21708@moooo.ath.cx> <f44bvq$klu$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Sixt <johannes.sixt@telecom.at>
X-From: git-owner@vger.kernel.org Wed Jun 06 22:54:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hw2W5-0001D3-O4
	for gcvg-git@gmane.org; Wed, 06 Jun 2007 22:54:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935346AbXFFUxv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 6 Jun 2007 16:53:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935311AbXFFUxv
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Jun 2007 16:53:51 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:65013 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934560AbXFFUxu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jun 2007 16:53:50 -0400
X-Greylist: delayed 747 seconds by postgrey-1.27 at vger.kernel.org; Wed, 06 Jun 2007 16:53:49 EDT
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070606205349.OINY5800.fed1rmmtao102.cox.net@fed1rmimpo02.cox.net>;
          Wed, 6 Jun 2007 16:53:49 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 8Lto1X00K1kojtg0000000; Wed, 06 Jun 2007 16:53:49 -0400
In-Reply-To: <f44bvq$klu$1@sea.gmane.org> (Johannes Sixt's message of "Tue, 05
	Jun 2007 21:02:18 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49311>

Johannes Sixt <johannes.sixt@telecom.at> writes:

> Matthias Lederhofer wrote:
>
>> If filters use variables with the same name as variables
>> used in the script the script breaks.  Executing the filters
>> in a separate process prevents accidential modification of
>> the variables in the main process.
>> @@ -349,21 +349,21 @@ while read commit; do
>>  
>>  eval "$(set_ident AUTHOR <../commit)"
>>  eval "$(set_ident COMMITTER <../commit)"
>> -     eval "$filter_env" < /dev/null
>> +     sh -c "$filter_env" < /dev/null
>
> NACK.
>
> The eval is on purpose here. $filter_env must be able export GIT_AUTHOR* and
> GIT_COMMITTER* variables here.

True.  The other hunks may be improvements, though.
