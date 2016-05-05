From: David Turner <dturner@twopensource.com>
Subject: [PATCH v8 00/19] index-helper/watchman
Date: Thu,  5 May 2016 17:46:52 -0400
Message-ID: <1462484831-13643-1-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, pclouds@gmail.com,
	Ramsay Jones <ramsay@ramsayjones.plus.com>
X-From: git-owner@vger.kernel.org Thu May 05 23:47:30 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ayR7J-0007jd-HT
	for gcvg-git-2@plane.gmane.org; Thu, 05 May 2016 23:47:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757373AbcEEVrZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 May 2016 17:47:25 -0400
Received: from mail-qg0-f53.google.com ([209.85.192.53]:34913 "EHLO
	mail-qg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755959AbcEEVrZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 May 2016 17:47:25 -0400
Received: by mail-qg0-f53.google.com with SMTP id f74so47439675qge.2
        for <git@vger.kernel.org>; Thu, 05 May 2016 14:47:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6hry4bDqRSWa5aM+E8/64x2+x4S1rQXlv64C38DItiA=;
        b=u0d4pUaytc9rbCBQYtHGQDPOgnWalSyis00d9rBik+qDaksxAzcZoqguEiBuqK8FFp
         cp5u2EluUnAvTQipLsvCDuhFc8Tp5QnTjIz0m8Vd2ESX5ta6uCEP+XYcQcRnTI/7D7gs
         rGvglX3SkDpci0hKV1NFEThntOLloo2dk5ogVnA0uni7g14rdEcI4PLwlQcUmB4ZXqob
         EhRwYIRN52IYl5LjsYD7QusxL/VNHu9YyZL+jTnBJ0/CDDJYjX3vynFdFYu6jgpJMUKw
         hChTgli7d3KIo2xmR4N0aDKBtCkBsJKE8bMEMEiiEucqXAJ9Pjm0hDSU833/Su8C6HwB
         cpaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6hry4bDqRSWa5aM+E8/64x2+x4S1rQXlv64C38DItiA=;
        b=fV/DygKKqt6x23nxPt6A1FNcU6VRAE8ej0PfoJrDX2JhEui+yciD/c+eR06WOITEpz
         Cs+bulcceVRP9cA9F5AYxiVcqquf4YahV0AUQsltJh+CX6NWjG0tOIDO1oMbRnEkkp3N
         6efH9LdWdDno6wiVOGqBEAL5mzR3RKjt2eJsrNjvztfk4skx5mHYgS56XOCmEGV2wNPT
         rspItX7vh+aOIXBhdh5zZno9J9plqyLe0oQWiN8shmN/A+kFvKs3a/eYKCdB4UatQQ5N
         e0UYZCTtX9D/y+vZejq41djIgIlTNOUyO4/T9OTfYKNh8qppfrARV4pWXlymUM5I/Kt4
         Rk1A==
X-Gm-Message-State: AOPr4FUlhmpr9evRveBxvKvYSX+N5fJxtT0JCHPQVIvTKuvN9/2bAJ4BKcjfdeqVTNk32g==
X-Received: by 10.140.236.20 with SMTP id h20mr17730680qhc.49.1462484844051;
        Thu, 05 May 2016 14:47:24 -0700 (PDT)
Received: from ubuntu.twitter.biz ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id g186sm4393740qke.49.2016.05.05.14.47.22
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 05 May 2016 14:47:23 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.767.g62658d5-twtrsrc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293687>

This version corrects defects noticed by Ramsay Jones:
index-helper now works when USE_WATCHMAN is not set
sigpipe is handled
post-test cleanup is improved
a test now uses a more idiomatic check
restored an index verification check from a previous version of the ser=
ies

David Turner (8):
  index-helper: log warnings
  unpack-trees: preserve index extensions
  watchman: add a config option to enable the extension
  index-helper: kill mode
  index-helper: don't run if already running
  index-helper: autorun mode
  index-helper: optionally automatically run
  untracked-cache: config option

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (11):
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
  Add tracing to measure where most of the time is spent

 .gitignore                               |   2 +
 Documentation/config.txt                 |  12 +
 Documentation/git-index-helper.txt       |  81 +++++
 Documentation/git-update-index.txt       |   6 +
 Documentation/technical/index-format.txt |  22 ++
 Makefile                                 |  18 ++
 builtin/gc.c                             |   2 +-
 builtin/update-index.c                   |  16 +
 cache.h                                  |  25 +-
 config.c                                 |   5 +
 configure.ac                             |   8 +
 daemon.c                                 |   2 +-
 diff-lib.c                               |   4 +
 dir.c                                    |  25 +-
 dir.h                                    |   6 +
 environment.c                            |   3 +
 git-compat-util.h                        |   1 +
 index-helper.c                           | 506 +++++++++++++++++++++++=
++++++
 name-hash.c                              |   2 +
 preload-index.c                          |   2 +
 read-cache.c                             | 535 +++++++++++++++++++++++=
+++++++-
 refs/files-backend.c                     |   2 +
 setup.c                                  |   4 +-
 t/t1701-watchman-extension.sh            |  37 +++
 t/t7063-status-untracked-cache.sh        |  22 ++
 t/t7900-index-helper.sh                  |  69 ++++
 t/test-lib-functions.sh                  |   4 +
 test-dump-watchman.c                     |  16 +
 unpack-trees.c                           |   1 +
 watchman-support.c                       | 135 ++++++++
 watchman-support.h                       |   7 +
 31 files changed, 1559 insertions(+), 21 deletions(-)
 create mode 100644 Documentation/git-index-helper.txt
 create mode 100644 index-helper.c
 create mode 100755 t/t1701-watchman-extension.sh
 create mode 100755 t/t7900-index-helper.sh
 create mode 100644 test-dump-watchman.c
 create mode 100644 watchman-support.c
 create mode 100644 watchman-support.h

--=20
2.4.2.767.g62658d5-twtrsrc
