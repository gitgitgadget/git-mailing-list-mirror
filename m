From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git checkout's reflog: even when detaching the HEAD, say from where
Date: Mon, 06 Aug 2007 20:56:53 -0700
Message-ID: <7v8x8o9euy.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0708070242140.14781@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Aug 07 05:56:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IIGBm-0001b5-Nt
	for gcvg-git@gmane.org; Tue, 07 Aug 2007 05:56:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1765822AbXHGD4z (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 6 Aug 2007 23:56:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1765724AbXHGD4z
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Aug 2007 23:56:55 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:36240 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1765607AbXHGD4y (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Aug 2007 23:56:54 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070807035655.SCXH2095.fed1rmmtao101.cox.net@fed1rmimpo02.cox.net>;
          Mon, 6 Aug 2007 23:56:55 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id Yrwt1X00P1kojtg0000000; Mon, 06 Aug 2007 23:56:54 -0400
In-Reply-To: <Pine.LNX.4.64.0708070242140.14781@racer.site> (Johannes
	Schindelin's message of "Tue, 7 Aug 2007 02:42:27 +0100 (BST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55214>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> @@ -272,7 +272,8 @@ if [ "$?" -eq 0 ]; then
>  		fi
>  	elif test -n "$detached"
>  	then
> -		git update-ref --no-deref -m "checkout: moving to $arg" HEAD "$detached" ||
> +		old_branch_name=`expr "z$oldbranch" : 'zrefs/heads/\(.*\)'`
> +		git update-ref --no-deref -m "checkout: moving from $old_branch_name to $arg" HEAD "$detached" ||

Can't old_branch_name be empty here if you are already detached?

>  			die "Cannot detach HEAD"
>  		if test -n "$detach_warn"
>  		then
> -- 
> 1.5.3.rc4.17.gb980
