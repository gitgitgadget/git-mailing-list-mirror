From: Gabriel Ganne <gabriel.ganne@gmail.com>
Subject: GIT_WORK_TREE not set as expected when changing git repository from a
 script using a git alias
Date: Fri, 4 Dec 2015 10:54:54 +0100
Message-ID: <CAE1CpdRY4fdppx35FyK9fqY8YNzrxvW+WPgqb73mh32tJUF3vQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=94eb2c07f940d525be05260f7fbf
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 04 10:55:14 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a4n58-0003eV-20
	for gcvg-git-2@plane.gmane.org; Fri, 04 Dec 2015 10:55:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756024AbbLDJy5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Dec 2015 04:54:57 -0500
Received: from mail-io0-f173.google.com ([209.85.223.173]:34231 "EHLO
	mail-io0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755672AbbLDJyz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Dec 2015 04:54:55 -0500
Received: by ioir85 with SMTP id r85so110585853ioi.1
        for <git@vger.kernel.org>; Fri, 04 Dec 2015 01:54:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=oCXtc87jpS9kUDfjxyVfo8ZPs5f9YUuDuVrXZlonMj0=;
        b=puoj68QkFCi/3/ogQAab6HSfT/dyTUrlaaG4yZ8xrGZaeoL47PpyLpV0NPNorREZl3
         NjrTm9iVQlMMWvGNAJja8NWDYTsRIsvY9xxfnnY9zmACTzP/wrPhz1pIrA16mYvob8LI
         b4L2KzIxwK1m/ZLPKXuZz3UsDEVY60FcMCtpKRBRlnAuuXPSqXC2QgfGZZfyiUTRcKYI
         3Fgpw43oBcKohHFKypxKvI8CLiGH1dfC0ZwZn4zllISgMcQloe3f+rZct7yOgup93xSL
         5scDZXq4cC2oS+HWF0R2f0e1NEkUPl90CPf8obZWtdGRjDOE0JSYrJsCUhlfK14LYSpC
         bhsg==
X-Received: by 10.107.184.139 with SMTP id i133mr15416669iof.42.1449222894584;
 Fri, 04 Dec 2015 01:54:54 -0800 (PST)
Received: by 10.36.75.7 with HTTP; Fri, 4 Dec 2015 01:54:54 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281979>

--94eb2c07f940d525be05260f7fbf
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi,

Following commit d95138e695d99d32dcad528a2a7974f434c51e79 (since
v2.5.1) the following workflow I use seems broken :

I wrote a script to list all git repositories that can be found from
where I am, and then call for each repository a given command.

Given the following tree, where "a" & "b" are git repositories,
=E2=94=9C=E2=94=80=E2=94=80 a
=E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 a_file
=E2=94=82   =E2=94=94=E2=94=80=E2=94=80 b
=E2=94=82       =E2=94=94=E2=94=80=E2=94=80 b_file

If I call the script from a git alias, the content of "a" will be
listed as untracked files from "b".
This is true only when called using the alias.

For example :
$ git all status # called from repository a
 [a]
On branch master
Untracked files:
  (use "git add <file>..." to include in what will be committed)

        b/

nothing added to commit but untracked files present (use "git add" to track=
)
 [b]
On branch master
Changes not staged for commit:
  (use "git add/rm <file>..." to update what will be committed)
  (use "git checkout -- <file>..." to discard changes in working directory)

        deleted:    ../b_file

Untracked files:
  (use "git add <file>..." to include in what will be committed)

        ../a_file
        ./

no changes added to commit (use "git add" and/or "git commit -a"

I am afraid I did not understand the commit
d95138e695d99d32dcad528a2a7974f434c51e79, and do not know how to fix
this.
I am working around the issue by setting GIT_WORK_TREE manually.

I attached a sample with my example, the script, and the alias I used.

Best regards,

--
Gabriel Ganne

--94eb2c07f940d525be05260f7fbf
Content-Type: application/x-gzip; name="git_all_issue.tar.gz"
Content-Disposition: attachment; filename="git_all_issue.tar.gz"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_ihrhufwg0

H4sIALlhYVYAA+1XW2/bNhT2M3/FqSys8YMly44dIJmNdolRFFvmwsvQhyxwKOnIIiJTni5x2yD9
7TukZdlJGxQr5vRh/F54EXm+cyE/2o7b2Ds6hKN+X7XekefpdtAZ6PkKDa876HW6NDugdZ7Xowb6
+3et0SjzgmcAjTmXEuf8yXUFBrEUf5f4HE49Hxx3LooZTxInj/fF8Y36e33vqK5/r0/fvR6hAZ19
ObSL/3n9my9cX0jX53nMmqwJQhY4z3ghUgk8Bw50PIAnQvVziNIkXcExrfvsOvQlSGUk5jS81Euu
qAe0OoEhgPUiOmjBHWzPF9iv4ATuTyCyGGsSWxNueSa4n2CuxrQ7IIIsZ6eqmU2iaPjyL7zsLF6y
X95kiFIPvZNeV81MMdyMPRqz08n5+evfz4aW/cpi0/G7yey3t39cDK2aLCploAJbk21GKuSszMUt
zoSM0oMWu2MUBVC9U2gjWPbdmvxe+W/f1b7dW+CNfuqy+439BReyiiMSMtSJUOnLcJnmokizj8QF
eem3C7LHojTTyVnyIlYf7AO9q118XCJQK/mC2FWarRYLU+3UTlh23Wf2QSgyvdzeGGxZtEWi8gU/
YKD9CNLFghMDESMPYu2X9kJ1tAdbkxWfiOAS2iHYesmVnitilLqjsCzzePPZG7kh3rqyTJL6+8Pk
gnV5TUcN176+e392fWXpM6NRJQRuMctVmWA0hK7Td7ztEuJJeICwEpSzTTw+qlNZpLBKsxvgWVrS
JHkJIs9L3G5+8/Zi9n4y/XV2MR2Ph9fLVXit+ezq5NROf3VymS7DL0KMRJVm/EB7OuxHX+d/Dced
jl+fnY/3yaFEfnB4+LT+dzb63x9QS/rf7R72jf4/B5owR4kk+LiWKabOvpBK9FlAEuYyrYN8FokE
AUZVTy/jYbg7VNeRmvYCrO0Xa2vQVwb9yqC/NjiqOrU9/0l7fmVPSZq+2IBRhEHB7OqNSoBKWZQ5
0DNCIyShy9LFrvpyRg/VFbCJBD/jkiRwwfMCM/YnqRQPbtQW4siP6W4flDmp78atn9X8yHEcS+mM
kEFShqgkcxXzgtSIyH2sPC4wbLFaNihgJtMiFnKuLBEFGahC88sCyofUsMyQ9LF4yK9Z9boWheB/
LYTTmMs57SculYc5ap2vmL4IyM0Wj2Iql6E6BE/Fs7s/iDG4Scn3dvuRkVDkAc9CWrF2RiWINFnF
Ti8UFYuqsJObEBMk68eq7zhuVft9VoNYqhNbz+j61B4/LtGjMtBz41JWrd3zyel5/tHX+LtR//6f
6TvlkBg680//Lcc39P/h/78j9fu/3+t2jf4bGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBh8D/4BfRti
PQAoAAA=
--94eb2c07f940d525be05260f7fbf--
