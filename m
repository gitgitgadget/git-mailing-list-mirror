From: David Turner <dturner@twopensource.com>
Subject: [PATCH v12 00/20] index-helper/watchman
Date: Thu, 19 May 2016 17:45:37 -0400
Message-ID: <1463694357-6503-1-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, pclouds@gmail.com
X-From: git-owner@vger.kernel.org Thu May 19 23:46:45 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b3VmF-0006Um-H1
	for gcvg-git-2@plane.gmane.org; Thu, 19 May 2016 23:46:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754492AbcESVqi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 19 May 2016 17:46:38 -0400
Received: from mail-qk0-f182.google.com ([209.85.220.182]:33918 "EHLO
	mail-qk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754277AbcESVqi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 May 2016 17:46:38 -0400
Received: by mail-qk0-f182.google.com with SMTP id y126so21159546qke.1
        for <git@vger.kernel.org>; Thu, 19 May 2016 14:46:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=svGoGnx/Yv4/b3lOU8OBuo4bvtV0Gn9i1uLEVhPH+NE=;
        b=N9QbXdMQVgacLFU36pklNNiXI33gVW3+Ldu9ISaW6kci5VK632VVNXcZGclEZtsN54
         v6I0nIwGPeeHZHq+ZleHsh0KAHOUunM0tbhRNSPCg4GV3CmwE4IeGWME0oWX5CGHLxl1
         KnRNUZk1crVVyZj19yWGrQGeus8GeaV6UpnRsbTqxhqSwCyCJWYOP9m4HAvgdvjlkC8W
         R34DmuO33WMHctGIK9Awc61XZqb9t7P4Wyc2hohhyEB+jCmAJjyN/NvBeCbZR2Cz0D/B
         X51LaNAFz03/8l80Xub15TRtBriJvON/2Nx/cwR0q+OTFqPI8UZhDX9yik1+9ENiL/MJ
         aJGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=svGoGnx/Yv4/b3lOU8OBuo4bvtV0Gn9i1uLEVhPH+NE=;
        b=by9YL+gJ5qw+3DgoZNPeNQGoAp2o/do0KQr95JL/NMfKJohFjpojO8yiMm8s+Qn4z0
         f+jrUwh/LLqNr39LnikH0pi8A3BV/CoOMK135ak+czQxSBk4BtAhAXmTAzxEgFzaRDMK
         xQkMUi0erdp81oMooNe1A6TJVAAREhqnCjq1QAsfLZYCsAYq6Oe97+kkuHUUNaKfIqlD
         nN5ck8RXLSYeW4O1CCHcj7ucVuEdzJiEVvJ/4N7rQqM+FgI85gwiEnqIN0G+PKAUSGWV
         kUOPUywNAbHhco4hEoyCj9PkMoUBMF7hmyD51fRCbYylG8lhDYBiCSEdVKl0w8Rr9GX7
         4LAw==
X-Gm-Message-State: AOPr4FXQo+M31v/pVEPeEJUHD3av9tZDFMwIi5wzHIgJ0CHRYDYEZyCxP1Pkm0q4NK+0RQ==
X-Received: by 10.55.43.87 with SMTP id r84mr17622824qkh.143.1463694396809;
        Thu, 19 May 2016 14:46:36 -0700 (PDT)
Received: from twopensource.com (207-38-164-98.c3-0.43d-ubr2.qens-43d.ny.cable.rcn.com. [207.38.164.98])
        by smtp.gmail.com with ESMTPSA id r124sm7424730qhr.48.2016.05.19.14.46.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 19 May 2016 14:46:35 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.767.g62658d5-twtrsrc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295106>

Of course, as soon as I pinged on the previous version, I noticed an is=
sue.

In that version, git index-helper --exit-after 0 was documented to
never exit, but it would in fact exit immediately.  This changes patch
04/20.

In addition, I noticed that there was no way to control the timeout on
automatically-run index-helpers, so I fixed that (with a new patch at
the end of the series).

Everything else is the same as the updated version of v11.

David Turner (9):
  pkt-line: add gentle version of packet_write
  index-helper: log warnings
  unpack-trees: preserve index extensions
  watchman: add a config option to enable the extension
  index-helper: kill mode
  index-helper: don't run if already running
  index-helper: autorun mode
  index-helper: optionally automatically run
  index-helper: indexhelper.exitafter config

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (11):
  read-cache.c: fix constness of verify_hdr()
  read-cache: allow to keep mmap'd memory after reading
  index-helper: new daemon for caching index and related stuff
  index-helper: add --strict
  daemonize(): set a flag before exiting the main process
  index-helper: add --detach
  read-cache: add watchman 'WAMA' extension
  watchman: support watchman to reduce index refresh cost
  index-helper: use watchman to avoid refreshing index with lstat()
  update-index: enable/disable watchman support
  trace: measure where the time is spent in the index-heavy operations

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
 contrib/completion/git-completion.bash   |   1 +
 daemon.c                                 |   2 +-
 diff-lib.c                               |   4 +
 dir.c                                    |  25 +-
 dir.h                                    |   6 +
 environment.c                            |   3 +
 git-compat-util.h                        |   1 +
 index-helper.c                           | 491 +++++++++++++++++++++++=
+++++
 name-hash.c                              |   2 +
 pkt-line.c                               |  18 ++
 pkt-line.h                               |   2 +
 preload-index.c                          |   2 +
 read-cache.c                             | 527 +++++++++++++++++++++++=
+++++++-
 refs/files-backend.c                     |   2 +
 setup.c                                  |   4 +-
 t/t1701-watchman-extension.sh            |  37 +++
 t/t7063-status-untracked-cache.sh        |  22 ++
 t/t7900-index-helper.sh                  |  77 +++++
 t/test-lib-functions.sh                  |   4 +
 test-dump-watchman.c                     |  16 +
 unpack-trees.c                           |   1 +
 watchman-support.c                       | 135 ++++++++
 watchman-support.h                       |   7 +
 34 files changed, 1565 insertions(+), 21 deletions(-)
 create mode 100644 Documentation/git-index-helper.txt
 create mode 100644 index-helper.c
 create mode 100755 t/t1701-watchman-extension.sh
 create mode 100755 t/t7900-index-helper.sh
 create mode 100644 test-dump-watchman.c
 create mode 100644 watchman-support.c
 create mode 100644 watchman-support.h

--=20
2.4.2.767.g62658d5-twtrsrc
