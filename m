From: Christian Couder <christian.couder@gmail.com>
Subject: t9700-perl-git.sh is broken on some configurations
Date: Fri, 4 Mar 2016 09:13:51 +0100
Message-ID: <CAP8UFD1z9H=SygaMVzpc__mXTbnFc2XiW0LZ+sfzdCPmrnXW6g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Mar 04 09:14:04 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1abks2-0004yF-U2
	for gcvg-git-2@plane.gmane.org; Fri, 04 Mar 2016 09:13:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751742AbcCDINy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Mar 2016 03:13:54 -0500
Received: from mail-lb0-f179.google.com ([209.85.217.179]:33762 "EHLO
	mail-lb0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751149AbcCDINx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Mar 2016 03:13:53 -0500
Received: by mail-lb0-f179.google.com with SMTP id k15so52320648lbg.0
        for <git@vger.kernel.org>; Fri, 04 Mar 2016 00:13:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:cc;
        bh=K///df/uOBWz8UZbmj6GW3rstx6AoDiYqzmy4pqCeO8=;
        b=oISCTJffwU9zV15zu71qH2mfRXYB6iYdFcjHFPpruYryT9UyY5lqLgFMib8CmiTgVR
         w5afOsZwjgXcP43sRK8/vxDLSEk+F7hENpz0RqOS22U/SGNUmCWOeLPrVAF/RsfU2xWw
         7qtteFonCUBq+UUeqOB2U088RvPk/+WfjHi9gjS05zBGiOiwo2jtVu28foezO1RCP70s
         HauY5crVwChWrXuSibkP4a7hWA3gezhGlzZ/N8MLRVSHtjZWkWdxl2/gNg96VpbeAjY8
         h92WBiUeLeNNpw/D5EAghVG+crRXTICKEVLm2L5R4X4dg7JaE3ifBViBIpqhoKhULRU3
         STWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to:cc;
        bh=K///df/uOBWz8UZbmj6GW3rstx6AoDiYqzmy4pqCeO8=;
        b=Z2o24/td/pEH43uKAVjIOOuhowSwNuen/oGT10xyUTtuTa8AdoIwRefj6CdmR5+zF+
         44FSty2Pddkuj6RGLWU6xAOjpMXPHwTw++Nnxtcz25a6JzI03D6sl51wDtHdzKtwmmqK
         ma+jI9URseiScaw5FR5q0gHPwoWahNz7lmXZfw3bcUKQGKU7YOM7IbM3DPCo9auSaIgZ
         Hbf7fzM5e3vGDx3RSWMD/iB2yCeETfC2d0aX80EOvqG8fFjK9Rrgf+zmbBfQnK7aq2BV
         aR0tscKjOIOKtFSJmXcTMrSVcrhgcQNzuuVpVOYNEf8+M3QZN+jDKosfDKvz3ITjLaoJ
         aoig==
X-Gm-Message-State: AD7BkJJhIPInsuOr07mXZzocgVWi8tkdb5NuXD0K7bEgDLdf/JxNHUHtI+A+lSpKVwuVxG2CGgHBAePY+2/BLA==
X-Received: by 10.25.168.138 with SMTP id r132mr2077667lfe.77.1457079231417;
 Fri, 04 Mar 2016 00:13:51 -0800 (PST)
Received: by 10.25.137.130 with HTTP; Fri, 4 Mar 2016 00:13:51 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288238>

Hi,

It looks like t9700-perl-git.sh is broken on one machine I use but not
on my laptop since commit d53c2c67380f769f91fd45cc8c63a5883245ccca
(mingw: fix t9700's assumption about directory separators, Jan 27
17:19:56 2016).

I get:

------------------------
Initialized empty Git repository in /home/ccouder/git/git/t/trash
directory.t9700-perl-git/.git/
expecting success: echo "test file 1" > file1 &&
     echo "test file 2" > file2 &&
     mkdir directory1 &&
     echo "in directory1" >> directory1/file &&
     mkdir directory2 &&
     echo "in directory2" >> directory2/file &&
     git add . &&
     git commit -m "first commit" &&

     echo "new file in subdir 2" > directory2/file2 &&
     git add . &&
     git commit -m "commit in directory2" &&

     echo "changed file 1" > file1 &&
     git commit -a -m "second commit" &&

     git config --add color.test.slot1 green &&
     git config --add test.string value &&
     git config --add test.dupstring value1 &&
     git config --add test.dupstring value2 &&
     git config --add test.booltrue true &&
     git config --add test.boolfalse no &&
     git config --add test.boolother other &&
     git config --add test.int 2k &&
     git config --add test.path "~/foo" &&
     git config --add test.pathexpanded "$HOME/foo" &&
     git config --add test.pathmulti foo &&
     git config --add test.pathmulti bar

[master (root-commit) fc41470] first commit
 Author: A U Thor <author@example.com>
 4 files changed, 4 insertions(+)
 create mode 100644 directory1/file
 create mode 100644 directory2/file
 create mode 100644 file1
 create mode 100644 file2
[master 6a30dee] commit in directory2
 Author: A U Thor <author@example.com>
 1 file changed, 1 insertion(+)
 create mode 100644 directory2/file2
[master 33414b1] second commit
 Author: A U Thor <author@example.com>
 1 file changed, 1 insertion(+), 1 deletion(-)
ok 1 - set up test repository

# run 1: Perl API (perl /home/ccouder/git/git/t/t9700/test.pl)
ok 2 - use Git;
# test_external test Perl API failed: perl /home/ccouder/git/git/t/t9700/test.pl
# expecting no stderr from previous command
# test_external_without_stderr test no stderr: Perl API failed: perl
/home/ccouder/git/git/t/t9700/test.pl:
# Stderr is:
Bareword found where operator expected at
/home/ccouder/git/git/t/t9700/test.pl line 36, near "s/\\/\//gr"
syntax error at /home/ccouder/git/git/t/t9700/test.pl line 36, near "s/\\/\//gr"
Execution of /home/ccouder/git/git/t/t9700/test.pl aborted due to
compilation errors.
------------------------

Indeed on the command line I get:

------------------------
$ t/t9700/test.pl
ok 2 - use Git;
Bareword found where operator expected at t/t9700/test.pl line 36,
near "s/\\/\//gr"
syntax error at t/t9700/test.pl line 36, near "s/\\/\//gr"
Execution of t/t9700/test.pl aborted due to compilation errors.
------------------------

A quick look at t/t9700/test.pl line 36 was not enough for me to spot
the problem.

Perl version is: perl 5, version 18, subversion 2 (v5.18.2) built for
x86_64-linux

The machine is running CentOS 6.5.

Thanks,
Christian.
