From: David Turner <dturner@twopensource.com>
Subject: [PATCH v5 00/15] index-helper/watchman
Date: Tue, 19 Apr 2016 19:27:54 -0400
Message-ID: <1461108489-29376-1-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, pclouds@gmail.com
X-From: git-owner@vger.kernel.org Wed Apr 20 01:28:22 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1asf47-00086s-Js
	for gcvg-git-2@plane.gmane.org; Wed, 20 Apr 2016 01:28:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753279AbcDSX2Q convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 19 Apr 2016 19:28:16 -0400
Received: from mail-qg0-f46.google.com ([209.85.192.46]:36302 "EHLO
	mail-qg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751723AbcDSX2P (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Apr 2016 19:28:15 -0400
Received: by mail-qg0-f46.google.com with SMTP id f52so19234059qga.3
        for <git@vger.kernel.org>; Tue, 19 Apr 2016 16:28:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eBEWAKwY7n42ybu992qW8577P+3+CzFd2weVlfp4/zk=;
        b=b1If+Wpt/pe3+FljRomTjrvTKIxVYBfCksE7FDNEcPRKfAvTLbydvd9j5PwoFboF/Z
         7EKcm22VH+IgpgPmUNQDWNyCZWbWjw0KIdE8UvXHx6GIMx7KMrNkIoLQHMC87DgBloWP
         krlNqC7GSc9L0vtfp4q1RxKY+6Vah4sSHeJkv0UYtSnKcsUss1aK4FmPZbaKvl5GQOIn
         Ct9ah1THtcRnhZSQIyQ66utGJ7ZgwnqDXNPovo6Qi0ZsJkrguOa1ulcuj5brP5NAmmya
         4guT7/b1tXysgl58iCn5dxzaIQpsJY31auEuNHit2n1Cen9zsfoVJ6P4ZVPVIUim/DIg
         Y2fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eBEWAKwY7n42ybu992qW8577P+3+CzFd2weVlfp4/zk=;
        b=KiebiDlgHqgruJErosmWSzOvHyFSLz2I+1fGoHQRvQIPUW6M/FpUpu1kyu1rvVNc/c
         iH/1JH9KQ5qoZF9YlBU65hYoYrD/oRe3O7j3NfxJ+v051TKdeTIhh8NnhM480qQJSrZu
         XFwkoiY3kkUh6zW6CCFsazJfitig7LyfLzsoIJQUYKnne0IF837bGHSMkBhVwXzmzfXL
         VrZ1ky4azSCAfmX7udl+k9+oE+pjZtoYBOJ0p5XD/zQVqnsU5EFgbZtNOnmH51nJumGI
         SuyN9VZyL9KdyneMU0BBK/UWJyUjNgAntdO94CbjDqHKBJunl4vsVM7zBRNbXaLF4ElM
         17/Q==
X-Gm-Message-State: AOPr4FWTFFq+1PIIPviuRpk4/vOib8IXGm2nM0h+Tas4ddql+Sw1KAcwxCnm7O+6o8ODtg==
X-Received: by 10.140.82.20 with SMTP id g20mr6913875qgd.69.1461108494004;
        Tue, 19 Apr 2016 16:28:14 -0700 (PDT)
Received: from ubuntu.twitter.biz ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id h34sm29879663qge.30.2016.04.19.16.28.12
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 19 Apr 2016 16:28:12 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.767.g62658d5-twtrsrc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291955>

This version includes the following changes since v4:
1. The last patch has been removed; it's pretty much always a good
idea to wait for the index-helper

2. Documentation for index-helper --kill and --autorun.  Documentation
for update-index --watchman.  Documentation for index-format for WAMA.
Documentation for index-helper suggesting running update-index --watchm=
an.

3. index-helper autorun moved to read-cache so it's only run on relevan=
t
commands.

4. Tests: Broken && chain fixed; removed a subshell

5. A couple of fd leaks fixed.

6. Cruft removed.

7. New perf numbers.

David Turner (5):
  unpack-trees: preserve index extensions
  index-helper: kill mode
  index-helper: don't run if already running
  index-helper: autorun mode
  index-helper: optionally automatically run

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (10):
  read-cache.c: fix constness of verify_hdr()
  read-cache: allow to keep mmap'd memory after reading
  index-helper: new daemon for caching index and related stuff
  index-helper: add --strict
  daemonize(): set a flag before exiting the main process
  index-helper: add --detach
  read-cache: add watchman 'WAMA' extension
  Add watchman support to reduce index refresh cost
  index-helper: use watchman to avoid refreshing index with lstat()
  update-index: enable/disable watchman support

 .gitignore                               |   1 +
 Documentation/config.txt                 |   4 +
 Documentation/git-index-helper.txt       |  75 +++++
 Documentation/git-update-index.txt       |   6 +
 Documentation/technical/index-format.txt |  22 ++
 Makefile                                 |  17 ++
 builtin/gc.c                             |   2 +-
 builtin/update-index.c                   |  11 +
 cache.h                                  |  16 +-
 config.c                                 |   5 +
 configure.ac                             |   8 +
 daemon.c                                 |   2 +-
 dir.c                                    |  23 +-
 dir.h                                    |   6 +
 environment.c                            |   3 +
 git-compat-util.h                        |   1 +
 index-helper.c                           | 454 +++++++++++++++++++++++=
+++++
 read-cache.c                             | 488 +++++++++++++++++++++++=
+++++++-
 setup.c                                  |   4 +-
 t/t7063-status-untracked-cache.sh        |  22 ++
 t/t7900-index-helper.sh                  |  68 +++++
 t/test-lib-functions.sh                  |   4 +
 unpack-trees.c                           |   1 +
 watchman-support.c                       | 135 +++++++++
 watchman-support.h                       |   7 +
 25 files changed, 1364 insertions(+), 21 deletions(-)
 create mode 100644 Documentation/git-index-helper.txt
 create mode 100644 index-helper.c
 create mode 100755 t/t7900-index-helper.sh
 create mode 100644 watchman-support.c
 create mode 100644 watchman-support.h

--=20
2.4.2.767.g62658d5-twtrsrc
