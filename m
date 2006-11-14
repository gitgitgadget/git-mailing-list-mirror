X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [GIT PATCH] Makefile missing git-runstatus in PROGRAMS list
Date: Tue, 14 Nov 2006 14:40:56 -0800
Message-ID: <7vmz6ty7lz.fsf@assigned-by-dhcp.cox.net>
References: <FE74AC4E0A23124DA52B99F17F44159701A11D63@PA-EXCH03.vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Tue, 14 Nov 2006 22:41:22 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <FE74AC4E0A23124DA52B99F17F44159701A11D63@PA-EXCH03.vmware.com>
	(Bhavesh Davda's message of "Tue, 14 Nov 2006 12:55:16 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31388>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gk6xh-0000nh-BM for gcvg-git@gmane.org; Tue, 14 Nov
 2006 23:41:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S966197AbWKNWk6 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 14 Nov 2006
 17:40:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966410AbWKNWk5
 (ORCPT <rfc822;git-outgoing>); Tue, 14 Nov 2006 17:40:57 -0500
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:14278 "EHLO
 fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP id S966197AbWKNWk5
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 14 Nov 2006 17:40:57 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao07.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061114224056.ODKJ27894.fed1rmmtao07.cox.net@fed1rmimpo02.cox.net>; Tue, 14
 Nov 2006 17:40:56 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id mmh21V00i1kojtg0000000; Tue, 14 Nov 2006
 17:41:03 -0500
To: "Bhavesh Davda" <bhavesh@vmware.com>
Sender: git-owner@vger.kernel.org

"Bhavesh Davda" <bhavesh@vmware.com> writes:

> Noticed this when trying to use qgit on Linus's kernel git repository. The
> script git-status depends on git-runstatus being in the path.
>
> Adding git-runstatus to the PROGRAMS list in the Makefile, so that it gets
> installed along with the other git executables.
>
> After a "sudo make install", qgit is now happy, since git-status is now able
> to find git-runstatus in /usr/bin.
>
> Thanks
>
> - Bhavesh
>
> Bhavesh P. Davda
>
>
>
> diff --git a/Makefile b/Makefile
> index 36ce8cd..24a0dc7 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -202,7 +202,7 @@ PROGRAMS = \
>  	git-upload-pack$X git-verify-pack$X \
>  	git-pack-redundant$X git-var$X \
>  	git-describe$X git-merge-tree$X git-imap-send$X \
> -	git-merge-recursive$X \
> +	git-merge-recursive$X git-runstatus$X \
>  	$(EXTRA_PROGRAMS)
>  
>  # Empty...

This cannot be right.  There is builtin-runstatus.o defined as
part of BUILTIN_OBJS so you already should have git-runstatus as
a hardlink to other binaries such as git-add, git-apply
etc. in the same directory as you have them.

I seem to have 55 hardlinks to that file under my ~/bin/.

