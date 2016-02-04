From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 00/25] More flexibility in making shallow clones
Date: Thu,  4 Feb 2016 16:03:36 +0700
Message-ID: <1454576641-29615-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 04 10:04:25 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aRFpv-0005CI-D0
	for gcvg-git-2@plane.gmane.org; Thu, 04 Feb 2016 10:04:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965374AbcBDJER convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 4 Feb 2016 04:04:17 -0500
Received: from mail-pf0-f170.google.com ([209.85.192.170]:33075 "EHLO
	mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965202AbcBDJEM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Feb 2016 04:04:12 -0500
Received: by mail-pf0-f170.google.com with SMTP id w123so38587719pfb.0
        for <git@vger.kernel.org>; Thu, 04 Feb 2016 01:04:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=ZTrNvenuDea3nSaNnRJ6G7L5XlA1HpVCxsQVks7T2/M=;
        b=WwZYXf0xQOI9j9VmQSQROpQbai5ymLp6V9sJeRm4pDs+qZ1PqVULoc+6K6TyrAngQP
         m5SA6my+RiDdMWxpMriU4wYSsax9P9nY2tjNdNDNje1U25WCUyx0DSxHPcDvFjy5PYWh
         R12Q6dBlU/RkrZgTwV7S3aD9PmHCHv23SCzvT2GkTWNkKxK6HWv8Kt9IW4CEhw+b3cJK
         2FpF6/SMFPQb8mUXDpD2B4jPR4YgNYYz3/sZOWTMJ1kJiQugZRgcA5QUFHOklyuomJh9
         Sgz6HYTeUydZlgWN2o9Q+fbiGupBbyOqOfzmavPhei9D774RCxRDiFcoETCgNhvx1Qwx
         mhMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-type:content-transfer-encoding;
        bh=ZTrNvenuDea3nSaNnRJ6G7L5XlA1HpVCxsQVks7T2/M=;
        b=NqRcBf/8t4EguIPK4pIjGho4QICGUBR0ObrRnijF+3aQLIr1PRrEVBZPrFvjXNP9tc
         TInIXoBq3pOtnZp2FlmouQKS/d6Y/f35Oi3S5SeUdpD5QsdVQt8Rzc5THPeFgi8uSdFt
         zpCjXWTYVuWMjapWaP1erwoZrg7K8ntTOlaILmwW641CM2pGPk1pVQqA5zeG9b+/r6GV
         mWToImZYebabU3ZpHYiw2J8UHJohB3LPD2bEHVHHzCWVTj9VePERtrU6/6Uj/nuP9H6E
         jB6BEjaR5dSUfCAsH01/QNcWQ7potZZvubDx+KbwChnkHDjOpGOfSOaKwrRGb7+Fc71K
         jW/w==
X-Gm-Message-State: AG10YOQip/qo+gnZ7A4vBX4+YPHHgdpNMKKAXQwZ+Fzus6FD/UP0Xk6Z7sWWAOkJhwqBIQ==
X-Received: by 10.66.144.5 with SMTP id si5mr9188268pab.51.1454576651311;
        Thu, 04 Feb 2016 01:04:11 -0800 (PST)
Received: from lanh ([115.76.228.161])
        by smtp.gmail.com with ESMTPSA id m16sm11177417pfi.75.2016.02.04.01.04.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Feb 2016 01:04:09 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Thu, 04 Feb 2016 16:04:23 +0700
X-Mailer: git-send-email 2.7.0.377.g4cd97dd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285414>

This series brings three new options to shallow clone/fetch, to let
you specify cut point by time, or by excluding some refs, or to let
you extend shallow boundary by <N> commits.

The series is now complete. Changes since v1 [1]

 - smart http support
 - option names --not and --since are changed to --shallow-exclude
   and --shallow-since
 - fix the last patch per Eric's comments (the tests were totally
   broken but I didn't realize)

The meat starts since 14/25. Before that is just cleanups and stuff.
Happy (shallowly) cloning!

[1] http://thread.gmane.org/gmane.comp.version-control.git/283110

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (25):
  remote-curl.c: convert fetch_git() to use argv_array
  transport-helper.c: refactor set_helper_option()
  transport-helper.c: do not send null option to remote helper
  upload-pack: move shallow deepen code out of receive_needs()
  upload-pack: move "shallow" sending code out of deepen()
  upload-pack: remove unused variable "backup"
  upload-pack: move "unshallow" sending code out of deepen()
  upload-pack: use skip_prefix() instead of starts_with() when possible
  upload-pack: tighten number parsing at "deepen" lines
  upload-pack: move rev-list code out of check_non_tip()
  fetch-pack: use skip_prefix() instead of starts_with() when possible
  fetch-pack: use a common function for verbose printing
  fetch-pack: use a separate flag for fetch in deepening mode
  shallow.c: implement a generic shallow boundary finder based on rev-l=
ist
  upload-pack: add deepen-since to cut shallow repos based on time
  fetch: define shallow boundary with --shallow-since
  clone: define shallow clone boundary based on time with --shallow-sin=
ce
  t5500, t5539: tests for shallow depth since a specific date
  refs: add expand_ref()
  upload-pack: support define shallow boundary by excluding revisions
  fetch: define shallow boundary with --shallow-exclude
  clone: define shallow clone boundary with --shallow-exclude
  t5500, t5539: tests for shallow depth excluding a ref
  upload-pack: make check_reachable_object() return unreachable list if=
 asked
  fetch, upload-pack: --deepen=3DN extends shallow boundary by N commit=
s

 Documentation/fetch-options.txt                   |  14 +
 Documentation/git-clone.txt                       |   8 +
 Documentation/git-fetch-pack.txt                  |  14 +
 Documentation/gitremote-helpers.txt               |  11 +
 Documentation/technical/pack-protocol.txt         |   4 +-
 Documentation/technical/protocol-capabilities.txt |  25 ++
 builtin/clone.c                                   |  32 ++-
 builtin/fetch-pack.c                              |  31 ++-
 builtin/fetch.c                                   |  41 ++-
 commit.h                                          |   2 +
 fetch-pack.c                                      | 128 +++++----
 fetch-pack.h                                      |   4 +
 object.h                                          |   2 +-
 refs.c                                            |   8 +-
 refs.h                                            |   1 +
 remote-curl.c                                     |  75 ++++--
 shallow.c                                         |  85 ++++++
 t/t5500-fetch-pack.sh                             |  67 +++++
 t/t5539-fetch-http-shallow.sh                     |  72 ++++++
 transport-helper.c                                |  71 +++--
 transport.c                                       |  11 +
 transport.h                                       |  14 +
 upload-pack.c                                     | 301 ++++++++++++++=
++------
 23 files changed, 832 insertions(+), 189 deletions(-)

--=20
2.7.0.377.g4cd97dd
