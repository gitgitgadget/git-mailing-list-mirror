From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] Make the exit code of add_file_to_index actually useful
Date: Mon, 3 Mar 2008 07:57:41 +0100
Message-ID: <20080303065741.GA2916@steel.home>
References: <47C95E34.1050306@dirk.my1.cc> <20080302154154.GC2973@steel.home> <20080302154238.GD2973@steel.home> <alpine.LSU.1.00.0803021555500.22527@racer.site> <7vtzjpoye6.fsf@gitster.siamese.dyndns.org> <20080302214241.GB13954@steel.home> <85ablgkcjo.fsf@lupus.strangled.net>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Dirk =?iso-8859-15?Q?S=FCsserott?= <newsletter@dirk.my1.cc>,
	Junio C Hamano <gitster@pobox.com>
To: Joachim B Haga <cjhaga@fys.uio.no>
X-From: git-owner@vger.kernel.org Mon Mar 03 07:58:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JW4dR-0005g2-Jg
	for gcvg-git-2@gmane.org; Mon, 03 Mar 2008 07:58:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752485AbYCCG6G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Mar 2008 01:58:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752494AbYCCG6F
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Mar 2008 01:58:05 -0500
Received: from mo-p07-ob.rzone.de ([81.169.146.190]:12254 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752412AbYCCG5p (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Mar 2008 01:57:45 -0500
X-RZG-CLASS-ID: mo07
X-RZG-AUTH: z4gQVF2k5XWuW3CculzzcFzzec4=
Received: from tigra.home (Fac78.f.strato-dslnet.de [195.4.172.120])
	by post.webmailer.de (mrclete mo3) (RZmta 16.8)
	with ESMTP id g047d7k234xfw7 ; Mon, 3 Mar 2008 07:57:43 +0100 (MET)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id EF407277BD;
	Mon,  3 Mar 2008 07:57:42 +0100 (CET)
Received: by steel.home (Postfix, from userid 1000)
	id 0E60056D24; Mon,  3 Mar 2008 07:57:42 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <85ablgkcjo.fsf@lupus.strangled.net>
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75893>

Joachim B Haga, Sun, Mar 02, 2008 23:04:43 +0100:
> Alex Riesen <raa.lkml@gmail.com> writes:
> > Junio C Hamano, Sun, Mar 02, 2008 17:59:13 +0100:
> >> Why is this even needed to begin with?  I am aware of Dirk's original
> >> issue discussed elsewhere, but we try fairly hard to be A-O-N when we can
> >> afford to, and this option deliberately breaks it.  What is the real
> >> reason why such an unreadable (either for privilege or for I/O error)
> >> file should not live in .gitignore?
> >
> > Another program keeps the file open. There is an exclusive mode for
> > opening files, which locks the files for everyone. I believe it is
> > even default mode, unless selected otherwise.
> 
> Another minor annoyance in this area, is when a wildcard add fails
> because of ignored files:
> 
>   potassium ~/svn/Deformation|master 0$ ls EpetraMatrix.*
>   EpetraMatrix.cpp  EpetraMatrix.cpp~  EpetraMatrix.h  EpetraMatrix.o
>   potassium ~/svn/Deformation|master 0$ git add EpetraMatrix.*
>   The following paths are ignored by one of your .gitignore files:
>   EpetraMatrix.cpp~
>   EpetraMatrix.o
>   Use -f if you really want to add them.
>   potassium ~/svn/New-Deformation|master 0$ git status
>   # On branch master
>   # Changed but not updated:
>   #   (use "git add <file>..." to update what will be committed)
>   #
>   [...]
> 
> I don't want to add them, I just want to ignore them completely (i.e., 
> add the un-ignored ones).
> 
> Would this case also be covered by the new switch?

No. This is entirely different usability issue

