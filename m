From: "Ciprian Dorin, Craciun" <ciprian.craciun@gmail.com>
Subject: Git push failure in the case of SSH to localhost
Date: Wed, 11 Feb 2009 18:24:29 +0200
Message-ID: <8e04b5820902110824u1ab99cc1r4df6349b20d62f84@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 11 17:26:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXHuh-00068F-Gy
	for gcvg-git-2@gmane.org; Wed, 11 Feb 2009 17:26:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755970AbZBKQYl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Feb 2009 11:24:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754592AbZBKQYk
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Feb 2009 11:24:40 -0500
Received: from mail-fx0-f20.google.com ([209.85.220.20]:59268 "EHLO
	mail-fx0-f20.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754567AbZBKQYj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Feb 2009 11:24:39 -0500
Received: by fxm13 with SMTP id 13so776509fxm.13
        for <git@vger.kernel.org>; Wed, 11 Feb 2009 08:24:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=VUVWdUs7IZeNebhLeLDJL+TxKF2sCw4blz60Xa+95LU=;
        b=SG1iHrzH6kBkBFh1LH/ROZLMD5SdYYhtYo+nghnDJU0aKCL8TD5xTUmtVD/fb4i3pm
         1h+dxwZTxjUfhygtcNaKCzlRmREreD5HTA2RFXxn0P9x/hWWthh6pf3vMrXiB5VuZXoQ
         z/ae/rmoSDGONkQCbMEwQqXS387SDN+w8fEp8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=w8ppPC3ghJ5mPYTRpZgXsgsnv8O5xXmN7tbCB2YlssoczTCUKfHqV8hzNmDBXgM7J0
         FETlReywfGPO7o3eUGnzqWG2K4uYIZjVb9vjBy837DkqXf+PwtXXgkgv2jkfJuIOre6O
         Z7gAbmrggeZQBs/QPaO5R9tQWTzvdVKl9/2dw=
Received: by 10.181.144.11 with SMTP id w11mr1357499bkn.27.1234369469828; Wed, 
	11 Feb 2009 08:24:29 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109438>

    Hello all!

    I've encountered the following error situations: git fails to push
a branch over ssh to localhost, even with file: protocol it has the
same behaviour... Please see the transcript... (Git version is
1.6.1.1) I don't think I'm doing something wrong, because this works
just fine with a real remote host...

    Thanks,
    Ciprian Craciun.

    P.S.: I'm using a slightly modified version of Git, but this patch
affects only the PATH-like search mechanism for git commands.

----

    0  git version
git version 1.6.1.1.dirty

    1  cd /tmp
    2  mkdir r1
    3  cd r1
    4  git init
    5  cd ..
    6  mkdir r2
    7  cd r2
    8  git init --bare
    9  cd ..
   10  cd r1
   11  echo a>a
   12  git add .
   13  git commit -m '--'

   14  git push ssh://localhost/tmp/r2 master
Counting objects: 3, done.
Writing objects: 100% (3/3), 197 bytes, done.
Total 3 (delta 0), reused 0 (delta 0)
error: unpack should have generated
ea8c5601f49a4bdeea03db3adb909d590ea730d3, but I can't find it!
To ssh://localhost/tmp/r2
 ! [remote rejected] master -> master (bad pack)
error: failed to push some refs to 'ssh://localhost/tmp/r2'

   15  git push file:///tmp/r2 master
Counting objects: 3, done.
Writing objects: 100% (3/3), 197 bytes, done.
Total 3 (delta 0), reused 0 (delta 0)
error: unpack should have generated
ea8c5601f49a4bdeea03db3adb909d590ea730d3, but I can't find it!
To file:///tmp/r2
 ! [remote rejected] master -> master (bad pack)
error: failed to push some refs to 'file:///tmp/r2'

    16 git push ssh://hephaistos.tartarus./tmp/r2 master
Counting objects: 3, done.
Writing objects: 100% (3/3), 197 bytes, done.
Total 3 (delta 0), reused 0 (delta 0)
To ssh://dom1.hephaistos.tartarus./tmp/r2
 * [new branch]      master -> master
