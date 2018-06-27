Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 46BCC1F516
	for <e@80x24.org>; Wed, 27 Jun 2018 22:30:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966413AbeF0Wab (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Jun 2018 18:30:31 -0400
Received: from mail-yw0-f202.google.com ([209.85.161.202]:44059 "EHLO
        mail-yw0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966251AbeF0Wa3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Jun 2018 18:30:29 -0400
Received: by mail-yw0-f202.google.com with SMTP id f206-v6so2688334ywa.11
        for <git@vger.kernel.org>; Wed, 27 Jun 2018 15:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=V3p8uUCSZWld4vsnS60n1aNOCZz4DG5D3iO5bCaSIKU=;
        b=RsZc0HLFLS8H21fWNv59uwxxv9y9747KcjscAt4LT3GYnrvBQa5T6bZ8cOwiYmgRkh
         boqtyHvYpWVLDDYEdXd2QLRCldqmOkWKj37NFeWJ0zyTtKJdF0N05ilafvWM5lXLSGhw
         CfrwhEM7RPZhIKhGAOqt8VBF9LhhayuhIJhGTrbW0bAQUhe8qsxZz5eR2PMvDnSzim/g
         GsRH81kcjj0lRewvURXQwFNYjZpm85h9PnZmfQZsbm8jSdaElae0agbYsOKz4sbCIgkp
         0D7QkoKHILzBGzSem4zpa5yCxTPpFIg7HUeX2U5h8HfzjA7gF2cRwaYuyk+ShbVjuZwx
         8ZGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=V3p8uUCSZWld4vsnS60n1aNOCZz4DG5D3iO5bCaSIKU=;
        b=ZB7Em4hdDOU8vztdRK8Px9wQEQw5/ZjioMLfOOEC6Bzv0CpKGTARUCxWr03K95trbs
         exFgbB9mJ3UfPRMvSO9dZ714oKKNlBf0Pci6YnDQgE5XSE2ejVRTzrz5tA14GnGDy17w
         2BpHoLPPOUFEHToms72sBnRg2TDrSbXQMyg9UDRDj96W7NusnFh0bihyu0JmB2jq49K4
         +ThecoyJov4Z3QCuFaN+TaBqNNP+m/MV25zARA12orRupSy8M4+5+FQjxLvLTqd0/Vda
         zacMpPH7lG1TKEwXizFUA7KZwl1xuDI6jtDdaHpD+bCvcp5tj8oUZL2GgHNvHEEQa27v
         362w==
X-Gm-Message-State: APt69E0y4UXSe3jwJJU2pN+RYx7J3+nQl9MawIaCv+8zRHOZNbG7ZQyI
        v4PI72kR9slvkSXJ47SU5aId0NtSyXf1HTBGFbxdIcAm38A0gtiZzIiFk2mQLGGPNF1Wt31/x6+
        whZIYqT5Y3fFj5K9EP+KpL4vG1xvTOgwOIjNPEaGJwiZsYKWf/Hn19UHvWw==
X-Google-Smtp-Source: ADUXVKJyDaMa1ARZKb9G+8mqA2D+WV1oh2XGyARFBRgf/5JELnv4fqo12ReZfD7B/P1iQVB6GKbbxmTSD2o=
MIME-Version: 1.0
X-Received: by 2002:a25:640f:: with SMTP id y15-v6mr2235233ybb.9.1530138628748;
 Wed, 27 Jun 2018 15:30:28 -0700 (PDT)
Date:   Wed, 27 Jun 2018 15:30:16 -0700
In-Reply-To: <20180627223023.49659-1-bmwill@google.com>
Message-Id: <20180627223023.49659-2-bmwill@google.com>
References: <20180626205438.110764-1-bmwill@google.com> <20180627223023.49659-1-bmwill@google.com>
X-Mailer: git-send-email 2.18.0.399.gad0ab374a1-goog
Subject: [PATCH v6 1/8] test-pkt-line: add unpack-sideband subcommand
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
2.18.0.399.gad0ab374a1-goog

