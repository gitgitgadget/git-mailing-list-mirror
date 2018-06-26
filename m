Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3B17A1F516
	for <e@80x24.org>; Tue, 26 Jun 2018 20:54:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933472AbeFZUyr (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Jun 2018 16:54:47 -0400
Received: from mail-qt0-f202.google.com ([209.85.216.202]:56179 "EHLO
        mail-qt0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751989AbeFZUyp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Jun 2018 16:54:45 -0400
Received: by mail-qt0-f202.google.com with SMTP id f8-v6so17003449qtj.22
        for <git@vger.kernel.org>; Tue, 26 Jun 2018 13:54:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=YxPHppMxmdEG9nGmLsfoDlKYX/fd24foZCD78c5CFB8=;
        b=VdDSuC3eo9LxlnQlm7xX90BW4ArjXBtTgACO7shTTBa8cx2aRCw7R46sleXF4D/3gk
         GKKLVwKEMwE4zyFmT5CFwCq+H/3nPkxRt0PAkGlw7cTDvTR7H1aWsx2wIlQIX5nrMkM6
         G+bzDtrv6WWZ+xCZeeHEQ9vxWNfovbPrhU9lOZHRUQEnzQSEbEGa9VE/T+Gi9g2HAWqu
         QAUFVeyUI16BrKwuIF7nYkqTxZt9p7TzoIUtgAZ0lEuNKkMlQG83x0H47LzxUfEPFAZl
         6mscYU20ZFin5qY0V+c5yYFjN4Q566KLUmNUvDqEPpJf6tNVpfOVIKoUdY7yb9ui5aUa
         SFkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=YxPHppMxmdEG9nGmLsfoDlKYX/fd24foZCD78c5CFB8=;
        b=kA4hHsPbcIPjeCnHGr/HoH++XuzJM3pmkYtl/nl5Fwthl2M/TrM3dlGBbdXzSt8Y3b
         o8vnHoI2LwS2bYcrr/LIKUdT9Nfs/PmcNqZWxpqvHuWQSvSczro3YN6zBm6/tmbyV6h1
         I48J8bElh2EuN+WJzj8IA2cnzBXGs7zvKs3nopXFaKtmUKcwOBx1ICzEj3ingtFtHbv+
         nUoL9iuziPFk9/sEPIM/HXe4XFGvmIRAIEePiXU5FrLYpye7qqS6fO9qQ5/K0MD/4zaN
         Bn8hxWH8EKu3lSJOvOSip/Ip9Y0Dy5d4buSTyAZB5DUcBokngcrCTHhqJiHWSYjFeNMZ
         ILEg==
X-Gm-Message-State: APt69E2+eWeMRdOxkhe8FgsxJu1+Qh+S6gfgBK/95n3wJHeScNHStj3F
        kvK7vf0PVYB1E0xagqmg3RA9dkb80um7NwRkSJfx/0CCpJqq/+1EfTzsId0OE68IDeITGrlsiem
        4ckpHUfOMKUGh0Vc5NVLSpOi5Ym5FWTFWeWC9EuvCwq09MNnN+x/4ll6qog==
X-Google-Smtp-Source: AAOMgpcJo4WP0Q+hj0hYtuIf970wowXA9vvCC/0nLPStWHUFvKV8LAKIZ9Nl+6YaTxY1gx8nq8FYATQj04E=
MIME-Version: 1.0
X-Received: by 2002:a0c:8146:: with SMTP id 64-v6mr92003qvc.39.1530046484806;
 Tue, 26 Jun 2018 13:54:44 -0700 (PDT)
Date:   Tue, 26 Jun 2018 13:54:31 -0700
In-Reply-To: <20180626205438.110764-1-bmwill@google.com>
Message-Id: <20180626205438.110764-2-bmwill@google.com>
References: <20180625185332.164142-1-bmwill@google.com> <20180626205438.110764-1-bmwill@google.com>
X-Mailer: git-send-email 2.18.0.rc2.346.g013aa6912e-goog
Subject: [PATCH v5 1/8] test-pkt-line: add unpack-sideband subcommand
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     jonathantanmy@google.com, gitster@pobox.com, sbeller@google.com,
        jrnieder@gmail.com, Brandon Williams <bmwill@google.com>
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
2.18.0.rc2.346.g013aa6912e-goog

