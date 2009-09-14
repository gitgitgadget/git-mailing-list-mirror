From: Marius Storm-Olsen <mstormo@gmail.com>
Subject: [RFC/PATCH v2 00/17] Build Git with MSVC
Date: Mon, 14 Sep 2009 15:11:13 +0200
Message-ID: <cover.1252925290.git.mstormo@gmail.com>
Cc: msysgit@googlegroups.com, git@vger.kernel.org, lznuaa@gmail.com, Marius Storm-Olsen <mstormo@gmail.com>
To: Johannes.Schindelin@gmx.de
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com Mon Sep 14 15:12:41 2009
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-vw0-f140.google.com ([209.85.212.140])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MnBMH-0004G0-Cm
	for gcvm-msysgit@m.gmane.org; Mon, 14 Sep 2009 15:12:41 +0200
Received: by vws4 with SMTP id 4so1239080vws.3
        for <gcvm-msysgit@m.gmane.org>; Mon, 14 Sep 2009 06:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to
         :received:received:received:received-spf:received:dkim-signature
         :domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:sender:precedence:x-google-loop:mailing-list
         :list-id:list-post:list-help:list-unsubscribe:x-beenthere-env
         :x-beenthere;
        bh=2Q4iQtrixIhAdMPypI+1+T/FQ5V3c77z3w+IROk5Bws=;
        b=Pw+gs4cB+dJI+5NU7b8H5hga9TiZsm5Jgpmb9B5bCkJ+WuDPg26sbYKTag1pUCjDhR
         x0iRYY56c8QUchKAJSDBAl8gien20tTsL3SQeWb6Fsb0BKh6JSjCMwBUhk3awvNpXXLN
         /LFhpJrk2agmSgDbgjiWohkCgYIeAFc/sIIOk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results
         :dkim-signature:domainkey-signature:from:to:cc:subject:date
         :message-id:x-mailer:sender:precedence:x-google-loop:mailing-list
         :list-id:list-post:list-help:list-unsubscribe:x-beenthere-env
         :x-beenthere;
        b=o2XavlaZgu13z/b223ih8tka2jiUEcdZWnLcEr6iL+X/R4YoeiiMFtsRW565Vom5Hs
         R1Qx9vdTfOvXPNN4OZqjuh4RzgAB/UqtF1nPH7WYtKQdlpW1WfYx7jFsXHgi3f0PTnsr
         QZKGooYXIIUf65xKT1GoY3bcn9h/NHOyDjJpI=
Received: by 10.220.78.202 with SMTP id m10mr1492594vck.27.1252933954521;
        Mon, 14 Sep 2009 06:12:34 -0700 (PDT)
Received: by 10.177.143.21 with SMTP id v21gr6958yqn.0;
	Mon, 14 Sep 2009 06:12:26 -0700 (PDT)
X-Sender: mstormo@gmail.com
X-Apparently-To: msysgit@googlegroups.com
Received: by 10.210.6.8 with SMTP id 8mr794441ebf.5.1252933945098; Mon, 14 Sep 2009 06:12:25 -0700 (PDT)
Received: by 10.210.6.8 with SMTP id 8mr794440ebf.5.1252933945055; Mon, 14 Sep 2009 06:12:25 -0700 (PDT)
Received: from mail-ew0-f205.google.com (mail-ew0-f205.google.com [209.85.219.205]) by gmr-mx.google.com with ESMTP id 15si1275020ewy.4.2009.09.14.06.12.23; Mon, 14 Sep 2009 06:12:24 -0700 (PDT)
Received-SPF: pass (google.com: domain of mstormo@gmail.com designates 209.85.219.205 as permitted sender) client-ip=209.85.219.205;
Authentication-Results: gmr-mx.google.com; spf=pass (google.com: domain of mstormo@gmail.com designates 209.85.219.205 as permitted sender) smtp.mail=mstormo@gmail.com; dkim=pass (test mode) header.i=@gmail.com
Received: by mail-ew0-f205.google.com with SMTP id 1so808483ewy.3 for <msysgit@googlegroups.com>; Mon, 14 Sep 2009 06:12:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=gamma; h=domainkey-signature:received:received:from:to:cc:subject:date :message-id:x-mailer; bh=uuQj3Q1VYSJ9i9PF7+pIL8LvKIPOCRTQHDikh+JW2GQ=; b=wyx8FupGj0dTJ/327ayKLKY4J7aC1+PHrOuuJ6hRG9uL9ZIL0Q/1JTIDM7cW+xr5UJ AdCGfltkyUy9eWQuxRo/iAIHlsAq2/ynOkarffr13GzzvtGc2mluIvrRiKBJ43KI9YG8 COBY5SZp3y4cyDCiwQ3PhIBPeVaDUt116lenw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=gmail.com; s=gamma; h=from:to:cc:subject:date:message-id:x-mailer; b=muRCDaxXm9nVwTHfaQW4CCXfEwyJr/ptKzuX9pGUQCVkugpgSsCS7/BSU7V/gRHTag DkvuohoNG/gb+4iL8XjqnBpI68wCVtMZy6xI5D+5qyW6LlemFruz4/TWy6f//w5SfCje rbLmlSWdpFlwwV1PqEUkTeTh/4kfQRJaVKxII=
Received: by 10.210.7.23 with SMTP id 23mr3140233ebg.38.1252933943868; Mon, 14 Sep 2009 06:12:23 -0700 (PDT)
Received: from localhost.localdomain ([62.70.27.104]) by mx.google.com with ESMTPS id 10sm2690277eyz.2.2009.09.14.06.12.22 (version=SSLv3 cipher=RC4-MD5); Mon, 14 Sep 2009 06:12:23 -0700 (PDT)
X-Mailer: git-send-email 1.6.2.1.418.g33d56.dirty
Sender: msysgit@googlegroups.com
Precedence: bulk
X-Google-Loop: groups
Mailing-List: list msysgit@googlegroups.com;
	contact msysgit+owner@googlegroups.com
List-Id: <msysgit.googlegroups.com>
List-Post: <mailto:msysgit@googlegroups.com>
List-Help: <mailto:msysgit+help@googlegroups.com>
List-Unsubscribe: <http://googlegroups.com/group/msysgit/subscribe>,
	<mailto:msysgit+unsubscribe@googlegroups.com>
X-BeenThere-Env: msysgit@googlegroups.com
X-BeenThere: msysgit@googlegroups.com
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128457>


Here's a second roll of the series for supporting compilation of Git
using Visual C++ (MSVC). (Sorry for the long delay on a followup, time
is in short supply these days)

There's no guarantee that the compiled result will work as well as the
current MinGW compile, or at all. However, I think it's important to
get the Git repo to a compilable state with MSVC as quickly as
possible, to further enable contributions from the Windows developers
which we are sorely lacking at the moment.
I hope that a repo which compiles successfully with the tools they are
accustomed to (also a very good debugger) will entice them to send more
patches.

In addition to this series, I have also setup a repo with binaries of
the required libs to compile Git with MSVC. Only 32bit versions for now.
So, the developer can choose to either use that, or Frank's source code
repo to build Git with MSVC. You'll find the binary repo here:
    http://repo.or.cz/w/msvcgit.git

Note that the binaries will still require the msysgit environment for
execution, due to the non-binary components of Git. (Scripts, gitk,
git-gui, etc). You'll find that repo here:
    http://repo.or.cz/w/msysgit.git

=== V2 2009.09.14 ===
1) Rebased ontop on current git.git 'next'.
2) Fixed code and commit msgs based on the previous feedback.
   Let me know if I forgot anything!
3) Added a proper Makefile patch for MSVC support.
   You now compile with 'make MSVC=1'.
4) Added perl scripts (contrib) which uses GNU Make output to generate
   MSVC IDE (.sln & .vcproj) projects and QMake projects, and picking
   up the project settings from the Makefile, so it's all in one place.
5) Added necessary patches to make things compile ontop of current
   'next'.

=== V1 2009.08.21 ===
So, Frank Li started this series, and I took it upon my self to help
out a bit; cleaning, reorganizing, rebasing the series. Hopefully
we're now a bit closer to including the series into mainline..

Here's a summary of what has happend:
1) This series is rebased ontop of git.git 'next', which needed an
   extra patch to avoid a non-constant array creation, which
   mscv doesn't like.
2) I've polished (tied to anyways) the commit messages a bit.
3) I've applied much of the feedback provided to the first round of
   the patches.
4) I've split, merged and reordered some of the patches, so things
   that belong together are in the same commits, and in a order of
   'importance'
5) I've removed the
       #define func _func
   stuff, as it's not needed and Microsoft cannot really kill the
   compatibility functions anyways. So, adding the define
       _CRT_NONSTDC_NO_DEPRECATE
   will kill the warnings seen without the defines above.
6) ..probably much more as well, but I forget..

Note: I did not sign off on the last two commits, which involve the
adding of the vcproj files, since I don't agree on adding them as is.
We need a Makefile way of compiling primarily, and second, a script
to generate the vcproj, as already discussed. But the commits are
included for completeness, at to let others compile and play with it.

I've kept the original author as is, and just signed the patches..
Thanks for watching, now bring on the comments!

Frank Li (8):
  Avoid declaration after statement
  Define SNPRINTF_SIZE_CORR=1 for Microsoft Visual C++
  Change regerror() declaration from K&R style to ANSI C (C89)
  mingw.c: Use the O_BINARY flag to open files
  Fix __stdcall/WINAPI placement and function prototype
  Test for WIN32 instead of __MINGW32_
  Add MinGW header files to build git with MSVC
  Add platform files for MSVC porting

Marius Storm-Olsen (9):
  boolean is a typedef under MSVC, so rename variable to 'i_boolean'
  Add define guards to compat/win32.h
  Add empty header files for MSVC port
  Make usage of windows.h lean and mean
  Define strncasecmp as _strnicmp for MSVC
  Add ftruncate implementation for MSVC
  Add MSVC to Makefile
  Add README for MSVC build
  Add scripts to generate projects for other buildsystems (MSVC vcproj,
    QMake)

 .gitignore                                |   11 +
 Makefile                                  |   54 +++-
 compat/mingw.c                            |   22 +-
 compat/mingw.h                            |    2 +
 compat/msvc.c                             |   43 ++
 compat/msvc.h                             |   51 +++
 compat/regex/regex.c                      |    7 +-
 compat/snprintf.c                         |   10 +-
 compat/vcbuild/README                     |   50 +++
 compat/vcbuild/include/alloca.h           |    1 +
 compat/vcbuild/include/arpa/inet.h        |    1 +
 compat/vcbuild/include/dirent.h           |  128 ++++++
 compat/vcbuild/include/grp.h              |    1 +
 compat/vcbuild/include/inttypes.h         |    1 +
 compat/vcbuild/include/netdb.h            |    1 +
 compat/vcbuild/include/netinet/in.h       |    1 +
 compat/vcbuild/include/netinet/tcp.h      |    1 +
 compat/vcbuild/include/pwd.h              |    1 +
 compat/vcbuild/include/sys/ioctl.h        |    1 +
 compat/vcbuild/include/sys/param.h        |    1 +
 compat/vcbuild/include/sys/poll.h         |    1 +
 compat/vcbuild/include/sys/select.h       |    1 +
 compat/vcbuild/include/sys/socket.h       |    1 +
 compat/vcbuild/include/sys/time.h         |    1 +
 compat/vcbuild/include/sys/utime.h        |   34 ++
 compat/vcbuild/include/sys/wait.h         |    1 +
 compat/vcbuild/include/unistd.h           |   92 ++++
 compat/vcbuild/include/utime.h            |    1 +
 compat/vcbuild/scripts/clink.pl           |   48 +++
 compat/vcbuild/scripts/lib.pl             |   26 ++
 compat/win32.h                            |    7 +
 compat/winansi.c                          |    1 -
 contrib/buildsystems/Generators.pm        |   42 ++
 contrib/buildsystems/Generators/QMake.pm  |  189 +++++++++
 contrib/buildsystems/Generators/Vcproj.pm |  639 +++++++++++++++++++++++++++++
 contrib/buildsystems/engine.pl            |  353 ++++++++++++++++
 contrib/buildsystems/generate             |   29 ++
 contrib/buildsystems/parse.pl             |  228 ++++++++++
 git-compat-util.h                         |    9 +
 help.c                                    |    5 +-
 pager.c                                   |    4 +-
 run-command.c                             |   12 +-
 run-command.h                             |    2 +-
 setup.c                                   |    2 +-
 test-parse-options.c                      |   12 +-
 thread-utils.c                            |    5 +-
 46 files changed, 2094 insertions(+), 39 deletions(-)
 create mode 100644 compat/msvc.c
 create mode 100644 compat/msvc.h
 create mode 100644 compat/vcbuild/README
 create mode 100644 compat/vcbuild/include/alloca.h
 create mode 100644 compat/vcbuild/include/arpa/inet.h
 create mode 100644 compat/vcbuild/include/dirent.h
 create mode 100644 compat/vcbuild/include/grp.h
 create mode 100644 compat/vcbuild/include/inttypes.h
 create mode 100644 compat/vcbuild/include/netdb.h
 create mode 100644 compat/vcbuild/include/netinet/in.h
 create mode 100644 compat/vcbuild/include/netinet/tcp.h
 create mode 100644 compat/vcbuild/include/pwd.h
 create mode 100644 compat/vcbuild/include/sys/ioctl.h
 create mode 100644 compat/vcbuild/include/sys/param.h
 create mode 100644 compat/vcbuild/include/sys/poll.h
 create mode 100644 compat/vcbuild/include/sys/select.h
 create mode 100644 compat/vcbuild/include/sys/socket.h
 create mode 100644 compat/vcbuild/include/sys/time.h
 create mode 100644 compat/vcbuild/include/sys/utime.h
 create mode 100644 compat/vcbuild/include/sys/wait.h
 create mode 100644 compat/vcbuild/include/unistd.h
 create mode 100644 compat/vcbuild/include/utime.h
 create mode 100644 compat/vcbuild/scripts/clink.pl
 create mode 100644 compat/vcbuild/scripts/lib.pl
 create mode 100644 contrib/buildsystems/Generators.pm
 create mode 100644 contrib/buildsystems/Generators/QMake.pm
 create mode 100644 contrib/buildsystems/Generators/Vcproj.pm
 create mode 100644 contrib/buildsystems/engine.pl
 create mode 100644 contrib/buildsystems/generate
 create mode 100644 contrib/buildsystems/parse.pl
