From: Jie Zhang <jzhang918@gmail.com>
Subject: Strange line ending issue
Date: Wed, 31 Oct 2012 12:37:51 -0400
Message-ID: <CACYR8yPuZTSWAq=xxAZE6oD==fCB6opgqeYr_VH8s3hrYgOZwQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 31 17:38:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TTbIr-000677-2a
	for gcvg-git-2@plane.gmane.org; Wed, 31 Oct 2012 17:38:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422932Ab2JaQhx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Oct 2012 12:37:53 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:52059 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933109Ab2JaQhw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Oct 2012 12:37:52 -0400
Received: by mail-pa0-f46.google.com with SMTP id hz1so1084310pad.19
        for <git@vger.kernel.org>; Wed, 31 Oct 2012 09:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=Bd4T5rdrsibggKJq8jIooHKVtFlT+gBTfqhtnrz/xB0=;
        b=TXCV4GI2ks0KidFUP2fIBHYJjnNVt1bDjkmt3H9erbH9T8qd3hAg6V5hNgMP4kl5S6
         x7dJpDkMCRFAKYLaIhPLAqncxnCHqo5UWGT9fu1LOmQaObONVPAHkUUyZbDtAlBxMPjq
         Kz3zcqvj1B2PZoIi07MW70yEYnezs2oGN2FF5tS5TLws6spmqpMETfw/OJ7aK2Erel+T
         DD+FeQQ5QbJH8nVGsuM5CiFFjDSZDDg8F4QnjMgLsOglvQ29Y7pTo5kvC4GkqaeXvw+u
         CiClucImlXssKI6E5ABrsswkWf4UTPToByfJBipdwruzNt3ZHswvKw7reX3VyxFUjbJJ
         CW9w==
Received: by 10.68.217.131 with SMTP id oy3mr7374130pbc.145.1351701471987;
 Wed, 31 Oct 2012 09:37:51 -0700 (PDT)
Received: by 10.68.17.135 with HTTP; Wed, 31 Oct 2012 09:37:51 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208841>

Hi,

I have a strange line ending issue with git. I'm not sure if it's a
bug or not. But it's really strange. Below are the steps to reproduce
what I saw:

1. $ git clone ssh://anonymous@firewall-sources.blackfin.uclinux.org:443/git/readonly-mirrors/toolchain.git

   $ cd toolchain

2. $ git status
# On branch trunk
nothing to commit, working directory clean

3. $ rm -rf libusb/msvc/libusb.dsw

4. $ git checkout libusb/msvc/libusb.dsw

5. $ git status
# On branch trunk
# Changes not staged for commit:
#   (use "git add <file>..." to update what will be committed)
#   (use "git checkout -- <file>..." to discard changes in working directory)
#
#    modified:   libusb/msvc/libusb.dsw
#
no changes added to commit (use "git add" and/or "git commit -a")

6. $ git reset --hard

7. $ git status
# On branch trunk
# Changes not staged for commit:
#   (use "git add <file>..." to update what will be committed)
#   (use "git checkout -- <file>..." to discard changes in working directory)
#
#    modified:   libusb/msvc/libusb.dsw
#
no changes added to commit (use "git add" and/or "git commit -a")

8. libusb.dsw is in DOS format. I changed CR-LF to CR-CR-LF in
libusb.dsw with a tool I modified from dos2unix.

9. $ git status
# On branch trunk
nothing to commit, working directory clean

I tested with git 1.7.10.4 from Debian and git 1.8.0 built by myself.
Both have same result.

Thank you.

Jie
