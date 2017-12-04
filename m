Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 15C6720954
	for <e@80x24.org>; Mon,  4 Dec 2017 23:59:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751756AbdLDX7M (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Dec 2017 18:59:12 -0500
Received: from mail-pf0-f195.google.com ([209.85.192.195]:38224 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750995AbdLDX7I (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Dec 2017 18:59:08 -0500
Received: by mail-pf0-f195.google.com with SMTP id u25so9798943pfg.5
        for <git@vger.kernel.org>; Mon, 04 Dec 2017 15:59:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ER7Xijl1ZztSl9Vl5Zd8y8+vksF9HiZJfUJOBoh/5Ek=;
        b=r5O+Zi/7GQeCgDlv97X6dsr+1ktYB7KfIqTx6oZq4SBQs44Pn0CeT+bHpiKZOQ2rXL
         OynjdKeLNaerDYcnEY7rYnQa0SkXNy2EL0xvrBc7TLpn3AdtUXinY2mptYCxuVuHETwj
         /Dl5zRrBVJc70FoVlba2fuTvETItdNm2AkVNyi9wKUeRLLlVphyvcsU2/dOHbcxmJw9n
         Yn5O1snKtt4MU6HSgXOFTPYYjx/jUKCKyIr5xHetzNyQJXVzZ7D+3WoON7yn0cyXOYTH
         hEWhiP5zvbIfYldcSKjpFSjfHwAaUH6us3nVi8ivZ8A+RJZMpLPldhG1ItaI8t7h6HsA
         dwmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ER7Xijl1ZztSl9Vl5Zd8y8+vksF9HiZJfUJOBoh/5Ek=;
        b=lxuSbfmcxky1w7rnd8Ad7Hejvnrq1l7xsRVm1EE6OKYg+OY1n3zH7mRdveOlqhMchi
         EAd+MqnPp0Oa/GUovRhwtr3wwXReFAQBkKP8ex3jzM+j9yUiQDSUOUPSsrTaEKOCtPSz
         7nVDzXHdmWfLbejE+/5sW95cBH51calo5VYtt0IFH+IE9BBGsktoPbRsPnOjwgJE2yZV
         OLfIfqRsHIxgSA3xw+zTNXb/4xPnNwDLeSq0ndyVHpkmGYNRhFoMnCpoc1lcwSvTp+OC
         JmImxUkNFSbO3dabn9BzDSgdSFLQIMjc6iPIjeXB7aEnXZw4PkIAzF8GvQqIho6UPAx8
         M/rg==
X-Gm-Message-State: AKGB3mJFyQVvo9m7DZBi4/J0Q44fThavfuzugEVT+wn04/VZKyu18srX
        2w+lEHlaINf2wVrGHdsANf2TpIRDClQ=
X-Google-Smtp-Source: AGs4zMZzjESgm+3a/3q5Q4B7WP/n+BjYPvkIi+/UIfqxJ8wv/Qg1OUQSntrdzBH5GIZlWyIkkyElwA==
X-Received: by 10.99.151.2 with SMTP id n2mr2446018pge.374.1512431947664;
        Mon, 04 Dec 2017 15:59:07 -0800 (PST)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id b187sm24939223pfg.109.2017.12.04.15.59.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 04 Dec 2017 15:59:06 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>
Subject: [WIP 02/15] pkt-line: introduce struct packet_reader
Date:   Mon,  4 Dec 2017 15:58:10 -0800
Message-Id: <20171204235823.63299-3-bmwill@google.com>
X-Mailer: git-send-email 2.15.1.424.g9478a66081-goog
In-Reply-To: <20171204235823.63299-1-bmwill@google.com>
References: <20171020171839.4188-1-bmwill@google.com>
 <20171204235823.63299-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sometimes it is advantageous to be able to peek the next packet line
without consuming it (e.g. to be able to determine the protocol version
a server is speaking).  In order to do that introduce 'struct
packet_reader' which is an abstraction around the normal packet reading
logic.  This enables a caller to be able to peek a single line at a time
using 'packet_reader_peek()' and having a caller consume a line by
calling 'packet_reader_read()'.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 pkt-line.c | 61 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 pkt-line.h | 20 ++++++++++++++++++++
 2 files changed, 81 insertions(+)

diff --git a/pkt-line.c b/pkt-line.c
index ac619f05b..518109bbe 100644
--- a/pkt-line.c
+++ b/pkt-line.c
@@ -406,3 +406,64 @@ ssize_t read_packetized_to_strbuf(int fd_in, struct strbuf *sb_out)
 	}
 	return sb_out->len - orig_len;
 }
+
+/* Packet Reader Functions */
+void packet_reader_init(struct packet_reader *reader, int fd,
+			char *src_buffer, size_t src_len)
+{
+	reader->fd = fd;
+	reader->src_buffer = src_buffer;
+	reader->src_len = src_len;
+	reader->buffer = packet_buffer;
+	reader->buffer_size = sizeof(packet_buffer);
+	reader->options = PACKET_READ_CHOMP_NEWLINE | PACKET_READ_GENTLE_ON_EOF;
+
+	reader->line = NULL;
+	reader->line_peeked = 0;
+	reader->pktlen = 0;
+	reader->status = PACKET_READ_ERROR;
+}
+
+enum packet_read_status packet_reader_read(struct packet_reader *reader)
+{
+	if (reader->line_peeked) {
+		reader->line_peeked = 0;
+		return reader->status;
+	}
+
+	reader->status = packet_read_with_status(reader->fd,
+						 &reader->src_buffer,
+						 &reader->src_len,
+						 reader->buffer,
+						 reader->buffer_size,
+						 &reader->pktlen,
+						 reader->options);
+
+	switch (reader->status) {
+	case PACKET_READ_ERROR:
+		reader->pktlen = -1;
+		reader->line = NULL;
+		break;
+	case PACKET_READ_NORMAL:
+		reader->line = reader->buffer;
+		break;
+	case PACKET_READ_FLUSH:
+		reader->pktlen = 0;
+		reader->line = NULL;
+		break;
+	}
+
+	return reader->status;
+}
+
+enum packet_read_status packet_reader_peek(struct packet_reader *reader)
+{
+	/* Only allow peeking a single line */
+	if (reader->line_peeked)
+		return reader->status;
+
+	/* Peek a line by reading it and setting peeked flag */
+	packet_reader_read(reader);
+	reader->line_peeked = 1;
+	return reader->status;
+}
diff --git a/pkt-line.h b/pkt-line.h
index f1545929b..2b5c7cf11 100644
--- a/pkt-line.h
+++ b/pkt-line.h
@@ -104,6 +104,26 @@ char *packet_read_line_buf(char **src_buf, size_t *src_len, int *size);
  */
 ssize_t read_packetized_to_strbuf(int fd_in, struct strbuf *sb_out);
 
+struct packet_reader {
+	int fd;
+	char *src_buffer;
+	size_t src_len;
+
+	char *buffer;
+	unsigned buffer_size;
+	int options;
+
+	enum packet_read_status status;
+	int pktlen;
+	const char *line;
+	int line_peeked;
+};
+
+extern void packet_reader_init(struct packet_reader *reader, int fd,
+			       char *src_buffer, size_t src_len);
+extern enum packet_read_status packet_reader_read(struct packet_reader *reader);
+extern enum packet_read_status packet_reader_peek(struct packet_reader *reader);
+
 #define DEFAULT_PACKET_MAX 1000
 #define LARGE_PACKET_MAX 65520
 #define LARGE_PACKET_DATA_MAX (LARGE_PACKET_MAX - 4)
-- 
2.15.1.424.g9478a66081-goog

