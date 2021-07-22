Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8433DC6377B
	for <git@archiver.kernel.org>; Thu, 22 Jul 2021 01:27:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F0BA61261
	for <git@archiver.kernel.org>; Thu, 22 Jul 2021 01:27:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230135AbhGVAqh (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Jul 2021 20:46:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbhGVAqh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Jul 2021 20:46:37 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14966C061575
        for <git@vger.kernel.org>; Wed, 21 Jul 2021 18:27:12 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id s186-20020a252cc30000b029055bc7fcfebdso5608097ybs.12
        for <git@vger.kernel.org>; Wed, 21 Jul 2021 18:27:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:subject:from:to:cc
         :content-transfer-encoding;
        bh=3LeAk584/Mq3DJ6gi8lONrMu5bbEMneIQWT0ehlFoCY=;
        b=qVJYzQloK0OpycJE/NnrRt0xihhB4W+AVPTYcC6i1W6dnv1yN1pDRmIcMG7baSLOvb
         9Q7RgyskmCwx3UyePxNyBmpSwt0j/hxfTDynU4Dg2g8jkiaO73e5IA41iQakB940ftTg
         Z8g0Tp2CzHk8ObUvVS8IeMTlfN1+bNBgalCDuy+WdpGOIfetY8ELVl26uFlqrgr4dB0V
         dfLv/QqgPU4o0smjAgjZ0RmQ5IAWZMWaCgz/W4N/wTXCKeRZKP4Cu+mbJPlcE1yEes2V
         i94OSGAtMa2sCR/yowbib9Ik7UPjQgvBUqMP7VFHT36tiABpWSz8IasYD7Kopf4hMls5
         nycQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version:subject
         :from:to:cc:content-transfer-encoding;
        bh=3LeAk584/Mq3DJ6gi8lONrMu5bbEMneIQWT0ehlFoCY=;
        b=JSkgOPNb+lL+dQdVbaE+dlMXn8vxjB1aqv/ylB9QKCN9N2iBTpDqc6sUXh0uKyrckR
         yAKogPlvKoA5q1xLP5jT8llR4rQ89TMWnmJp8lsxyLpGCKt9djO47miZyU/DEJ9vUc8l
         cdCY45LSCMSbPB3yLpE+pTHErbMz50AND0Yd/QFp58W9FYJRmZo2ldv+kp6etc2CFdaI
         PzUR9ZSUEz+GLT0RRPSBryw4Mwj8K1ijMXWxKHD4iISblcUSkw8ZQRQccNUtCbzDHfmG
         i4Nv6bPQYe/zR41cAyMlb9jysrc6dGFLtxbI/uBg9ypPdr3ntaJbthjwbhzBY5guvTVB
         UOGw==
X-Gm-Message-State: AOAM5338GME/QMCP2VoFSF9E9XEhfkUr9LdQU38/Tdjy+OjkAcID249e
        ZXQc7TqbHFxr40Atj2rO38sHqQTzRPWl1SA0foIZqp/v0KMLBfpZcgrUmfYq0uU6h7z8cA1U1yL
        9LXg4A6HcU8k/tKIDDIQCTv3tNSB4Vm1v4IbpO1+omp14gQhVCUW2Ai+CMKBvKVPj8/PdcvXxKw
        ==
X-Google-Smtp-Source: ABdhPJxKFSJXsVx5DOZU44eErbOw7EG/5krIPKts4G4IIOYjnvDVCBs6eNO0FZo0e0gJWJ8Ok8sIyf70sn5U4SpeZnw=
X-Received: from podkayne.svl.corp.google.com ([2620:15c:2ce:200:83f3:cefc:ff34:3095])
 (user=emilyshaffer job=sendgmr) by 2002:a25:4f08:: with SMTP id
 d8mr12249868ybb.10.1626917231135; Wed, 21 Jul 2021 18:27:11 -0700 (PDT)
Date:   Wed, 21 Jul 2021 18:27:05 -0700
In-Reply-To: <20210608221059.1935021-1-emilyshaffer@google.com>
Message-Id: <20210722012707.205776-1-emilyshaffer@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.32.0.402.g57bb445576-goog
Subject: [PATCH v6 0/2] tr2: log parent process name
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>,
        "=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?=" 
        <avarab@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        "Randall S. Becker" <rsbecker@nexbridge.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since v5, I reshuffled some of the platform-specific compilation recipe
around per Jeff H's comments on v5. I think these are at odds with
=C3=86var's comments, though, so I guess let's take a look and see how
strongly we feel? :)

Otherwise I also made the logic inversion Junio suggested to make the
logic easier to follow in procinfo.c:trace2_collect_process_info.

Thanks,
 - Emily

Emily Shaffer (2):
  tr2: make process info collection platform-generic
  tr2: log parent process name

 Documentation/technical/api-trace2.txt | 14 +++++++
 Makefile                               |  4 ++
 compat/linux/procinfo.c                | 55 ++++++++++++++++++++++++++
 compat/stub/procinfo.c                 | 11 ++++++
 config.mak.uname                       |  3 ++
 t/t0210/scrub_normal.perl              |  6 +++
 t/t0211/scrub_perf.perl                |  5 +++
 t/t0212/parse_events.perl              |  5 ++-
 trace2.c                               | 13 ++++++
 trace2.h                               | 16 +++++---
 trace2/tr2_tgt.h                       |  3 ++
 trace2/tr2_tgt_event.c                 | 21 ++++++++++
 trace2/tr2_tgt_normal.c                | 19 +++++++++
 trace2/tr2_tgt_perf.c                  | 16 ++++++++
 14 files changed, 184 insertions(+), 7 deletions(-)
 create mode 100644 compat/linux/procinfo.c
 create mode 100644 compat/stub/procinfo.c

Range-diff against v5:
-:  ---------- > 1:  80084448e4 tr2: make process info collection platform-=
generic
1:  7a7e1ebbfa ! 2:  485f9a24f0 tr2: log parent process name
    @@ Documentation/technical/api-trace2.txt: about specific error argumen=
ts.
      	This event contains the command name for this git process
      	and the hierarchy of commands from parent git processes.
    =20
    - ## Makefile ##
    -@@ Makefile: ifneq ($(PROCFS_EXECUTABLE_PATH),)
    - 	BASIC_CFLAGS +=3D '-DPROCFS_EXECUTABLE_PATH=3D"$(procfs_executable_p=
ath_SQ)"'
    - endif
    -=20
    -+ifdef HAVE_PROCFS_LINUX
    -+	BASIC_CFLAGS +=3D -DHAVE_PROCFS_LINUX
    -+	COMPAT_OBJS +=3D compat/procinfo.o
    -+endif
    -+
    - ifdef HAVE_NS_GET_EXECUTABLE_PATH
    - 	BASIC_CFLAGS +=3D -DHAVE_NS_GET_EXECUTABLE_PATH
    - endif
    -
    - ## compat/procinfo.c (new) ##
    + ## compat/linux/procinfo.c (new) ##
     @@
     +#include "cache.h"
     +
    @@ compat/procinfo.c (new)
     +
     +static void get_ancestry_names(struct strvec *names)
     +{
    -+#ifdef HAVE_PROCFS_LINUX
     +	/*
     +	 * NEEDSWORK: We could gather the entire pstree into an array to mat=
ch
     +	 * functionality with compat/win32/trace2_win32_process_info.c.
    @@ compat/procinfo.c (new)
     +	}
     +
     +	return;
    -+#endif
     +	/* NEEDSWORK: add non-procfs-linux implementations here */
     +}
     +
    @@ compat/procinfo.c (new)
     +
     +		get_ancestry_names(&names);
     +
    -+		if (names.nr =3D=3D 0) {
    -+			strvec_clear(&names);
    -+			return;
    -+		}
    -+
    -+		trace2_cmd_ancestry(names.v);
    -+
    ++		if (names.nr)
    ++			trace2_cmd_ancestry(names.v);
     +		strvec_clear(&names);
     +	}
     +
    @@ config.mak.uname: ifeq ($(uname_S),Linux)
      	FREAD_READS_DIRECTORIES =3D UnfortunatelyYes
      	BASIC_CFLAGS +=3D -DHAVE_SYSINFO
      	PROCFS_EXECUTABLE_PATH =3D /proc/self/exe
    -+	HAVE_PROCFS_LINUX =3D YesPlease
    ++	HAVE_PLATFORM_PROCINFO =3D YesPlease
    ++	COMPAT_OBJS +=3D compat/linux/procinfo.o
      endif
      ifeq ($(uname_S),GNU/kFreeBSD)
      	HAVE_ALLOCA_H =3D YesPlease
    @@ trace2.h: void trace2_cmd_path_fl(const char *file, int line, const =
char *pathna
      /*
       * Emit a 'cmd_name' event with the canonical name of the command.
       * This gives post-processors a simple field to identify the command
    -@@ trace2.h: enum trace2_process_info_reason {
    - 	TRACE2_PROCESS_INFO_EXIT,
    - };
    -=20
    --#if defined(GIT_WINDOWS_NATIVE)
    -+#if ( defined(GIT_WINDOWS_NATIVE) || defined(HAVE_PROCFS_LINUX) )
    - void trace2_collect_process_info(enum trace2_process_info_reason reas=
on);
    - #else
    - #define trace2_collect_process_info(reason) \
    =20
      ## trace2/tr2_tgt.h ##
     @@ trace2/tr2_tgt.h: typedef void(tr2_tgt_evt_error_va_fl_t)(const cha=
r *file, int line,
--=20
2.32.0.402.g57bb445576-goog

