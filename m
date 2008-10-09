From: "Ed Schofield" <edschofield@gmail.com>
Subject: Git newbie question: permissions
Date: Thu, 9 Oct 2008 21:20:10 +0100
Message-ID: <1b5a37350810091320l72ae0a86m39db4258c9f4827e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 09 22:21:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ko20k-0004cT-JE
	for gcvg-git-2@gmane.org; Thu, 09 Oct 2008 22:21:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754870AbYJIUUN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Oct 2008 16:20:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754556AbYJIUUN
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Oct 2008 16:20:13 -0400
Received: from ti-out-0910.google.com ([209.85.142.189]:42431 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754574AbYJIUUM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Oct 2008 16:20:12 -0400
Received: by ti-out-0910.google.com with SMTP id b6so73390tic.23
        for <git@vger.kernel.org>; Thu, 09 Oct 2008 13:20:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=o2X3ceMMsv7Tr/ZQU7l5XRn1ln7j0flgWHs8r3mlDfU=;
        b=JhYOxbgBIPIJuKHbJMg+inadAI8sJWEvZiLJ8BZtYAXUkXxm55qvi85FIalewRT1Ct
         Gv7Lp/lce6uwIWcMlnWU1NpUDlPTrvefWJQQEJZktnDR14b8fR85tB8IBt+qbXIMaNii
         ne/PdD3LD4j0Fc2jC/+2KGWAWRR0/a6zm3h5Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=oJN4Fg9+pLSadh3O6ae3HNX6ZIT70DM4NjdPFJPe4Conu1RS722/zXRFTEnFr3d58W
         jNYQTc6SBidWL+NyQPVc+GSvcSa91bhThP66kkWHKL278Um1ssMt0ODJjk89gWPDqgM/
         mcD6/Aru6CMjWALt3DiMAuAc+Fh8CJdBnVnXQ=
Received: by 10.110.39.20 with SMTP id m20mr472281tim.59.1223583610619;
        Thu, 09 Oct 2008 13:20:10 -0700 (PDT)
Received: by 10.110.31.7 with HTTP; Thu, 9 Oct 2008 13:20:10 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97880>

Hi everyone,

I have a bare git repository that users in a particular group
("webdev") are pulling from and pushing to using the ssh transport.
One of the users has just reported this error during a push:

Counting objects: 103, done.
Compressing objects: 100% (68/68), done.
error: unable to write sha1 filename
./objects/4f/
973ce5c66f082af5087948cec57001f0c4da50: Permission denied

fatal: failed to write object
error: pack-objects died with strange error
error: failed to push some refs to '/var/git/myrepo.git'

I'd appreciate some help on getting my repository back to a sane
state, allowing this user to finish his push, and making sure
permissions are right in the future.

I don't think I specified "--shared=group" when initializing the
repository. Afterwards I manually set all files to have 660
permissions, dirs as 770, and set the group ownership to "webdev", but
I probably made a mistake by not setting the setgid bit on
directories. Now there are some objects directories with 755
permissions and different group ownership (the default groups of the
other users).

I have now run "git --bare init --shared=group" to reinitialize the
repository. This seems to have changed the directories to be g+sx. (Is
this all it did?). There are still some objects directories with 755
permissions rather than 770, which I presume I want, and the group
ownership of these is wrong. Shall I change these by hand? The sha1
files all have 444 permissions; is this right?

The last question I have is how to ensure that git creates object
files etc. with the right permissions when users push in future.

I'd appreciate any help!

-- Ed
