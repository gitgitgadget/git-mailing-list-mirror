X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Make git-commit cleverer - have it figure out whether it needs -a automatically
Date: Fri, 01 Dec 2006 03:15:17 -0800
Message-ID: <7vd573amuy.fsf@assigned-by-dhcp.cox.net>
References: <200612011106.42272.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Fri, 1 Dec 2006 11:15:44 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <200612011106.42272.andyparkins@gmail.com> (Andy Parkins's
	message of "Fri, 1 Dec 2006 11:06:42 +0000")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32896>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gq6MV-0005NL-6w for gcvg-git@gmane.org; Fri, 01 Dec
 2006 12:15:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S936452AbWLALPU (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 1 Dec 2006
 06:15:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936454AbWLALPT
 (ORCPT <rfc822;git-outgoing>); Fri, 1 Dec 2006 06:15:19 -0500
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:13242 "EHLO
 fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP id S936452AbWLALPS
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 1 Dec 2006 06:15:18 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao05.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061201111518.PWDA20330.fed1rmmtao05.cox.net@fed1rmimpo02.cox.net>; Fri, 1
 Dec 2006 06:15:18 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id tPFT1V0081kojtg0000000; Fri, 01 Dec 2006
 06:15:27 -0500
To: Andy Parkins <andyparkins@gmail.com>
Sender: git-owner@vger.kernel.org

Andy Parkins <andyparkins@gmail.com> writes:

> Raimund Bauer offered this suggestion (paraphrased):
>
> "Maybe we could do git-commit -a  _only_ if the index matches HEAD, and
> otherwise keep current behavior?  So people who don't care about the
> index won't get tripped up, and when you do have a dirty index, you get
> told about it?"
>
> Johannes Schindelin pointed out that this isn't the right thing to do for
> an --amend, so that is checked for. Additionally, it's probably not the
> right thing to do if any files are specified with "--only" or
> "--include", so they turn this behaviour off as well.
>
> Nguyen Thai Ngoc Duy asked that git-commit let you know it's done this
> by adding an extra comment to the commit message.

I think another exception should be needed.  If the index does
not match the working tree, it should not default to "-a".

Otherwise,

I want to fix another thing in pickaxe.

	$ edit builtin-blame.c

My wife calls me.  Away from desk for 20 minutes.  Later I come
back.

	$ git update-index builtin-pickaxe.c

I am so used to that name and did not realize that typo, and I
was not paying too much attention.  My wife calls me again.
Away from desk and back in 20 minutes.

	$ git commit -m 'git-blame: Another fix.'

Oops.

So, please turn this "cleverness" off when the index does not
match the working tree.


