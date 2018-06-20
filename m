Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B3E301F403
	for <e@80x24.org>; Wed, 20 Jun 2018 21:32:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933574AbeFTVcr (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Jun 2018 17:32:47 -0400
Received: from mail-qk0-f202.google.com ([209.85.220.202]:53432 "EHLO
        mail-qk0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933438AbeFTVco (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Jun 2018 17:32:44 -0400
Received: by mail-qk0-f202.google.com with SMTP id u20-v6so823038qkk.20
        for <git@vger.kernel.org>; Wed, 20 Jun 2018 14:32:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=GyOI6UT3VnhSPeVG0JVjOmwv5mcBB3Kwh1J8Fdzf29c=;
        b=PKyr/EzqyLm/xrd8g/zavb5dM0zDL+/78+8xfcxLtgt2TfWhaLFAry5bDU6XQ260/Q
         k/zVUyi6U7pPVwl+bE/6/S+R2FioGxXh9hbEhzP+VvnyWr/ibV0moC467z3NSJZ97tXj
         BTAeyrwrFg9wgqwxqztuAps8+IsXND8z/11GgkmUug/22g6zOHBRufSdWOqVCk8EDhqo
         pmU+qivVmvoreEyETNr7SaXGdZ9SBQCRjXkzV9YG04RnxzqwCFibFn94ZPt0Prboiyz2
         YPGI6sH6nBZS6rGTn7F8Fb73QcIvqfzb++FyWWUYsLFWHw6SZp2wvVw+/jaqo01ziAp9
         fxfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=GyOI6UT3VnhSPeVG0JVjOmwv5mcBB3Kwh1J8Fdzf29c=;
        b=afVL/vo/NyTlA9qIlNuB6yV+IW9V91WkBKiG20ezHR8rTGgjEloITdJUI25P7LOP+2
         PontK0GctGuM+pVCthRn75ULrPfBIZwGuzF060sBalbVlf1SN9XzFhXGSY0iUy0VnEPZ
         QRA8VQu9TxHTfPSgF7GuR3Pu5Us3cBm3f6Ork5fJ4SA0Z1P1mfM+LeSokCD4s/KdgzKj
         cJwt1hJTHLLeTR/lbSJlSpvCxijCHh3zhJ32Ytr94BWVn78zNlDoqI20eQEibCf7ktun
         I75+2RuCEoApW1MfvKQkHEwP0NgkLu/EWYiGWwaCvwY3qHDRsrgtFEor4dl+XtWzMzVa
         cqtw==
X-Gm-Message-State: APt69E26GGGxfqtBSfxjFKK9B2oCGjQjH6Qp6LX/s9kDdvElv9QZGou/
        gf6M2gVvTlLo45M4dyzSpaVGXDh5LQmCNG5jaCqSDqgWG2w/MBf6XQxgEaipdHBeMMsQ1Li0c66
        fHBvUjUbn21A8P+TM0jP000IOSE1Yu9wWgJ2w95Vnm3QAS8hIl/giuDIqXw==
X-Google-Smtp-Source: ADUXVKIsF0N7rtOjqCaxXssIurw9UqpcN34kSXSNLqUE2L0yPiAD/qk81+8e8CXgAmp5yc1QKNRV/Hya4HM=
MIME-Version: 1.0
X-Received: by 2002:a37:a8c3:: with SMTP id r186-v6mr12412141qke.62.1529530363946;
 Wed, 20 Jun 2018 14:32:43 -0700 (PDT)
Date:   Wed, 20 Jun 2018 14:32:28 -0700
In-Reply-To: <20180620213235.10952-1-bmwill@google.com>
Message-Id: <20180620213235.10952-2-bmwill@google.com>
References: <20180613213925.10560-1-bmwill@google.com> <20180620213235.10952-1-bmwill@google.com>
X-Mailer: git-send-email 2.18.0.rc1.244.gcf134e6275-goog
Subject: [PATCH v3 1/8] test-pkt-line: add unpack-sideband subcommand
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     jonathantanmy@google.com, gitster@pobox.com, sbeller@google.com,
        Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add an 'unpack-sideband' subcommand to the test-pkt-line helper to
enable unpacking packet line data sent multiplexed using a sideband.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 t/helper/test-pkt-line.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/t/helper/test-pkt-line.c b/t/helper/test-pkt-line.c
index 0f19e53c7..30775f986 100644
--- a/t/helper/test-pkt-line.c
+++ b/t/helper/test-pkt-line.c
@@ -1,3 +1,4 @@
+#include "cache.h"
 #include "pkt-line.h"
 
 static void pack_line(const char *line)
@@ -48,6 +49,36 @@ static void unpack(void)
 	}
 }
 
+static void unpack_sideband(void)
+{
+	struct packet_reader reader;
+	packet_reader_init(&reader, 0, NULL, 0,
+			   PACKET_READ_GENTLE_ON_EOF |
+			   PACKET_READ_CHOMP_NEWLINE);
+
+	while (packet_reader_read(&reader) != PACKET_READ_EOF) {
+		int band;
+		int fd;
+
+		switch (reader.status) {
+		case PACKET_READ_EOF:
+			break;
+		case PACKET_READ_NORMAL:
+			band = reader.line[0] & 0xff;
+			if (band < 1 || band > 2)
+				die("unexpected side band %d", band);
+			fd = band;
+
+			write_or_die(fd, reader.line + 1, reader.pktlen - 1);
+			break;
+		case PACKET_READ_FLUSH:
+			return;
+		case PACKET_READ_DELIM:
+			break;
+		}
+	}
+}
+
 int cmd_main(int argc, const char **argv)
 {
 	if (argc < 2)
@@ -57,6 +88,8 @@ int cmd_main(int argc, const char **argv)
 		pack(argc - 2, argv + 2);
 	else if (!strcmp(argv[1], "unpack"))
 		unpack();
+	else if (!strcmp(argv[1], "unpack-sideband"))
+		unpack_sideband();
 	else
 		die("invalid argument '%s'", argv[1]);
 
-- 
2.18.0.rc1.244.gcf134e6275-goog

