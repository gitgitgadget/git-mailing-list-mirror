From: Joachim B Haga <cjhaga@fys.uio.no>
Subject: Re: [PATCH] Make the exit code of add_file_to_index actually useful
Date: Sun, 02 Mar 2008 23:04:43 +0100
Message-ID: <85ablgkcjo.fsf@lupus.strangled.net>
References: <47C95E34.1050306@dirk.my1.cc> <20080302154154.GC2973@steel.home> <20080302154238.GD2973@steel.home> <alpine.LSU.1.00.0803021555500.22527@racer.site> <7vtzjpoye6.fsf@gitster.siamese.dyndns.org> <20080302214241.GB13954@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Dirk =?utf-8?Q?S=C3=BCsserott?= <newsletter@dirk.my1.cc>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 02 23:06:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JVwJI-0001dM-2E
	for gcvg-git-2@gmane.org; Sun, 02 Mar 2008 23:05:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751353AbYCBWEz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Mar 2008 17:04:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751287AbYCBWEz
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Mar 2008 17:04:55 -0500
Received: from main.gmane.org ([80.91.229.2]:50647 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751238AbYCBWEz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Mar 2008 17:04:55 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1JVwIe-00005J-Iy
	for git@vger.kernel.org; Sun, 02 Mar 2008 22:04:52 +0000
Received: from 22.80-203-45.nextgentel.com ([80.203.45.22])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 02 Mar 2008 22:04:52 +0000
Received: from cjhaga by 22.80-203-45.nextgentel.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 02 Mar 2008 22:04:52 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 22.80-203-45.nextgentel.com
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
Cancel-Lock: sha1:7qxAzUqtQVhOzTNRH2C7JerVuUI=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75850>

Alex Riesen <raa.lkml@gmail.com> writes:

> Junio C Hamano, Sun, Mar 02, 2008 17:59:13 +0100:
>> Why is this even needed to begin with?  I am aware of Dirk's original
>> issue discussed elsewhere, but we try fairly hard to be A-O-N when we can
>> afford to, and this option deliberately breaks it.  What is the real
>> reason why such an unreadable (either for privilege or for I/O error)
>> file should not live in .gitignore?
>
> Another program keeps the file open. There is an exclusive mode for
> opening files, which locks the files for everyone. I believe it is
> even default mode, unless selected otherwise.

Another minor annoyance in this area, is when a wildcard add fails
because of ignored files:

  potassium ~/svn/Deformation|master 0$ ls EpetraMatrix.*
  EpetraMatrix.cpp  EpetraMatrix.cpp~  EpetraMatrix.h  EpetraMatrix.o
  potassium ~/svn/Deformation|master 0$ git add EpetraMatrix.*
  The following paths are ignored by one of your .gitignore files:
  EpetraMatrix.cpp~
  EpetraMatrix.o
  Use -f if you really want to add them.
  potassium ~/svn/New-Deformation|master 0$ git status
  # On branch master
  # Changed but not updated:
  #   (use "git add <file>..." to update what will be committed)
  #
  [...]

I don't want to add them, I just want to ignore them completely (i.e., 
add the un-ignored ones).

Would this case also be covered by the new switch?

-j.

