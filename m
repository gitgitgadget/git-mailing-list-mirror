From: =?utf-8?Q?R=C3=A9mi?= Vanicat <vanicat@debian.org>
Subject: [Bug] git status -unormal -- 'foo[b]/' won't display content of 'foo[b]/
Date: Sun, 21 Sep 2014 20:04:08 +0200
Message-ID: <87vbogq293.dlv@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git Maling list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Sep 21 20:04:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XVlUj-0004aa-QM
	for gcvg-git-2@plane.gmane.org; Sun, 21 Sep 2014 20:04:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751342AbaIUSEM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 21 Sep 2014 14:04:12 -0400
Received: from mail-we0-f178.google.com ([74.125.82.178]:40987 "EHLO
	mail-we0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751188AbaIUSEL convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 21 Sep 2014 14:04:11 -0400
Received: by mail-we0-f178.google.com with SMTP id t60so1871971wes.37
        for <git@vger.kernel.org>; Sun, 21 Sep 2014 11:04:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:subject:date:message-id:user-agent:mime-version
         :content-type:content-transfer-encoding;
        bh=uneIzotU0ud5SlablTQOptdLFaBu5zP4XJm/6Yvv3sI=;
        b=ZdXTca967aszD36SoycKZ3H5tAlwGYx+A5O+HLqOx86Tr5WjVVRKhK8sDJyQJSex6l
         +ZLuaxmpwCE6DuV/X5JEAZyV3LKU5klVGJuhNgYWK7UlyFNGe/BytEz/aH5PBoNRzc55
         w3Ycb1TDeTIN9tGK11qo0CYc1WdnofYyHDffmwEapt2z/3zLcCUk9fYfVVMFK9MgKzCp
         WTwwQ8GawWBNEmeRrRL6Xk3kuRd+SNOasdH6YugrQRtXxsia/SKiq2rJ9h6yMKej5IES
         LZvnz5O4Fp4k4/JsP6k84zJChCOYdl7HryTdyVzDfyJPC7UZUirfB8/tx+wUoI2B74tu
         YH+g==
X-Received: by 10.180.107.100 with SMTP id hb4mr10172843wib.59.1411322650476;
        Sun, 21 Sep 2014 11:04:10 -0700 (PDT)
Received: from madame ([2001:41d0:fe61:2600:96de:80ff:feb2:56d])
        by mx.google.com with ESMTPSA id ky3sm9600139wjb.39.2014.09.21.11.04.09
        for <git@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 21 Sep 2014 11:04:09 -0700 (PDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257354>

Hello,

I found what look like a bug in git status:
`git status -unormal foo[b]/` won't output the content of the directory
foo[b] when `git status -unormal foo/` will output the content of the
directory foo:=20

  $ mkdir 'foo[b]'
  $ touch 'foo[b]/bar'
  $ git status -unormal 'foo[b]/'
  On branch master
  Untracked files:
    (use "git add <file>..." to include in what will be committed)

          foo[b]/

  nothing added to commit but untracked files present (use "git add" to=
 track)
  $ mkdir 'foo'
  $ touch 'foo/bar'
  $ git status -unormal 'foo/'
  On branch master
  Untracked files:
    (use "git add <file>..." to include in what will be committed)

          foo/bar

  nothing added to commit but untracked files present (use "git add" to=
 track)

The documentation of git status contain nothing about treating bracket
specially. Quoting the brackets do not solve the problem.

see https://github.com/magit/magit/issues/1512 for discussion about it
(in the case of git status --porcelain).
--=20
R=C3=A9mi Vanicat
