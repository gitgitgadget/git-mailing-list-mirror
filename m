Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D70442E428
	for <git@vger.kernel.org>; Tue,  1 Sep 2026 15:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788275976; cv=none; b=MRyjEgEh2YhZA9l15ft0g9Fb+Nj7Ya3ftkPErpNio+wkhuDt3eZQg3XAJzxvg/3qJ6YXcNWRpoQy9bEZXITf4o6t5rnPYe8oUa0qXnMHoQ8qQRe/GGv26BBLXuJnT02l3DAo9myC9PeAQXfnYx5UjKt9jicaBfHyrKVkukORsRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788275976; c=relaxed/simple;
	bh=AHqwKnTBfFEGGTiZEqw/kOQB8rkzxXA0tAmuYQP5/W0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VAXVjf2uz3/ayRag9QWpwBRqQLhBBAYltlp7quJ/zCoMYOSJl2gKtqt0kq+rceeumGIGgurwGLnh+KDtWhGRxkj0Z0EV1shlWMcr7hdV69LjMSfn70Hk4iA88E03Zpy1qJATGGuukaV23hjVbP1b3bSpuOAiF1dUXZwWD/XtrZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zyd7rr6V; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zyd7rr6V"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-49b9320423cso49118125e9.0
        for <git@vger.kernel.org>; Tue, 01 Sep 2026 08:19:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788275973; x=1788880773; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2s1GudZ9IQm3hhjrSqXZZmPbWmqFGWtZmbLs4tnsNiU=;
        b=Zyd7rr6VQ5xRfTgJhuQTVmus3+Usece9S/dUREP5QQHBoblz7aWWIQ19UnEmmgr59H
         MHPQ6yc52fSi3rHPlU7/6AlGBnA5m/03MiOm1vMJlLIIfi+8LPn3nS4AlOh3UpeNyKiF
         ZQHMVFIBoaJGlPlUJZyVayyIO9BYbhE26xLMZanCeaKM/Yzhp0U0+LNDbev2QjMnXe1Z
         S/5sKkbel/j3y4fm2DuPwh6zrBoEw58pPau1CcCsdvPBugZYQ8WAED9H8zhgWEMk9ZHV
         w/+RWvTb7GuPM38uON2dYOip/HZ7g/MQDBNoaLmRQNqjwdH0zBkJx0tPBvcGV4vnQHSd
         K1nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788275973; x=1788880773;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2s1GudZ9IQm3hhjrSqXZZmPbWmqFGWtZmbLs4tnsNiU=;
        b=mJKLR6fR7759UvFLrK1k+jeDNjeBxy0ODVP5B3TupJ0Xw3ZdwPGSKmQkuwb/mUfy0L
         pYcupwFSuD1C8ItzOvPayoI1zaew0WmcdcXdx2DLcF3lDUttUSOfNPslk9KsQuF+jMHj
         lc1zvF5RnaDsJc67MVp/JueTknLXC3Y7ST54jloQhwjeEaWtq2m4cfZBrlSurMQR/Mrp
         59sB3h79/Xv/EAxp2bp0ZyD6oyXuFdpBZJfg6u9kwDPk84yExW4ImvcLwHYYvOYURSNW
         M7tcQZ+sOS/an75BhuC+Nwrl/YSu0aq82cbOlszL69pWrrxmyuDg7Ep1pBiWvMx4Fl2P
         a96w==
X-Gm-Message-State: AFuF++kCquxioPt6rm+KJdTyvgBUdiofWIwkIHs+5KEUpY/C6sziLbP8
	cj5ZzoHkKReGkUNunuVcS4U8cDuBZ0m5kXOE0eW2NjculmN7iKBF7ZsZ
X-Gm-Gg: AR+sD10Sp30V6SlZbdyJPzscQsLJdACRxMd6REvLnJNK+b7/mXNhREOqDuhQpHrDoha
	pPK/+TOkoqp+cCsuibjgHuNe0yLSdBjvwcqeIU7ywt69tjoex81iuc+KBYxtKFqhMZI61DxcexW
	ATz0sce0rLxWitfdejxah5+A9xI41MgdEsiuzX1xrDEhUTm08qAdnYLolfcZ+YFg8cIhFLrcyq/
	kcxVDh4hbHtnCIJn4na/D2yK1Q9ZfDlL9LpsBqhqjeqZOUuSNP56FeZz90nZjpqFMfcGkqw6EXG
	hwwYZe/oxDM9SiqqcEQm2e7uq4bYVJqOcxNOQATk4amWq5vGgYSTVqsJnHDExS0JBKwU1j6NAvC
	IVvjHduzeuw5fAoP0rL/7AaU57Ri91S2YbDChqNY+tu4k723grVEZtekFjvkQD439siktmQDTt0
	ErafBzlsNFyB3hggUDHM87BBwsFQaRHcWCxbeue/tJMO8+n4GbnBtfC3Y0CFu6mShXVFBwo2+MJ
	XzYM/DU+ZqB6c+OirzdZk0xx5g86VZ/54o1hg==
X-Received: by 2002:a05:600c:4747:b0:499:dbba:9859 with SMTP id 5b1f17b1804b1-49cdc57bf3emr137562635e9.5.1788275972101;
        Tue, 01 Sep 2026 08:19:32 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:8109:d906:4e00:645f:6387:edab:db53])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49ce309e418sm17270605e9.13.2026.09.01.08.19.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 08:19:31 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Tue, 01 Sep 2026 17:19:24 +0200
Subject: [PATCH v5 2/3] receive-pack: move message generation to separate
 function
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260901-758-introduce-hook-v5-2-35cdc6be3cc1@gmail.com>
References: <20260901-758-introduce-hook-v5-0-35cdc6be3cc1@gmail.com>
In-Reply-To: <20260901-758-introduce-hook-v5-0-35cdc6be3cc1@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im, gitster@pobox.com, jltobler@gmail.com, 
 kristofferhaugsbakk@fastmail.com, Karthik Nayak <karthik.188@gmail.com>, 
 Phillip Wood <phillip.wood@dunelm.org.uk>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4403; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=AHqwKnTBfFEGGTiZEqw/kOQB8rkzxXA0tAmuYQP5/W0=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGqW7P8yHgwVSD/WLfOpm4xth+0Vc0GKzrRwZ
 +KaoiJDPwkaT4kBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJqluz/AAoJED7VnySO
 Rox/2UkL/jDkLyfvZ/DrUF5HNBYEkJKS5AA8Qjl7+8rQUDs5uEBunpwV3zRPdcgJ6MRO9P2cJdW
 ujsaik6FQyNWo4cJk96VKy0NGpBsZhnVADmqKlhJSRPXcEy7GujkB8ZHiWhFFxFOhKNfMUrYywe
 FSmskuSGdlOZzrlry98iqIgdGQdmv9nORtNxBoZxOaiFQGi5TJA82qyMUC6MxylRCeTu/29Yg5G
 9Jsko973DzB5yHAks5LfniGRBsfubc6JxclT6yeWm3CXsmnlxX4GRexcw/mxFDKDPQ58E67XcNS
 aWCw4WXwVFvjlAcf3X6mZqRoDv5keVdBdPoMfAr60D6yG1YWnkqxK4fGuPeAxzZ6HLkKgh7LvKd
 XLmC9V8mEWdaajjE/LyQu1iOOhNcNpX0Gy/iWh7TYI7WnGX4lK8P6jFNvj94ohk23+rudqUkd1E
 AucUfbrQ79Vt/fkWTS6/izX1DIegSMmNmo+t9LG/LlUecojfILghuqAr5pPNRqqICc/FFXe14Y7
 HE=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

After git-receive-pack(1) has committed the reference updates, we call
either `report()` or `report_v2()` to report to the client which of the
references we have updated successfully and which updates have failed.
The only difference between those two functions is that the latter also
knows to provide a more detailed report about how exactly a given
reference was updated.

In the next commit we're about to add another site that wants to
generate these reports. Refactor the logic into a shared function that
can easily be reused.

Helped-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 builtin/receive-pack.c | 84 ++++++++++++++++++++++++++------------------------
 1 file changed, 44 insertions(+), 40 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 86933d8d7e..34d5e46097 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -2530,67 +2530,71 @@ static void update_shallow_info(struct command *commands,
 	free(ref_status);
 }
 
-static void report(struct command *commands, const char *unpack_status)
+/*
+ * Generate the response to be sent to the client invoking 'git-receive-pack(1)'.
+ * For v2 protocol, set `detailed_report` to true, which will also add detailed
+ * report per reference update.
+ */
+static void generate_report(struct strbuf *buf, struct command *commands,
+			    const char *unpack_status, bool detailed_report)
 {
 	struct command *cmd;
-	struct strbuf buf = STRBUF_INIT;
 
-	packet_buf_write(&buf, "unpack %s\n",
+	packet_buf_write(buf, "unpack %s\n",
 			 unpack_status ? unpack_status : "ok");
-	for (cmd = commands; cmd; cmd = cmd->next) {
-		if (!cmd->error_string)
-			packet_buf_write(&buf, "ok %s\n",
-					 cmd->ref_name);
-		else
-			packet_buf_write(&buf, "ng %s %s\n",
-					 cmd->ref_name, cmd->error_string);
-	}
-	packet_buf_flush(&buf);
-
-	if (use_sideband)
-		send_sideband(1, 1, buf.buf, buf.len, use_sideband);
-	else
-		write_or_die(1, buf.buf, buf.len);
-	strbuf_release(&buf);
-}
-
-static void report_v2(struct command *commands, const char *unpack_status)
-{
-	struct command *cmd;
-	struct strbuf buf = STRBUF_INIT;
-	struct ref_push_report *report;
 
-	packet_buf_write(&buf, "unpack %s\n",
-			 unpack_status ? unpack_status : "ok");
 	for (cmd = commands; cmd; cmd = cmd->next) {
+		struct ref_push_report *report;
 		int count = 0;
 
-		if (cmd->error_string) {
-			packet_buf_write(&buf, "ng %s %s\n",
-					 cmd->ref_name,
-					 cmd->error_string);
+		if (cmd->error_string)
+			packet_buf_write(buf, "ng %s %s\n",
+					 cmd->ref_name, cmd->error_string);
+		else
+			packet_buf_write(buf, "ok %s\n", cmd->ref_name);
+
+		if (!detailed_report || cmd->error_string)
 			continue;
-		}
-		packet_buf_write(&buf, "ok %s\n",
-				 cmd->ref_name);
+
 		for (report = cmd->report; report; report = report->next) {
 			if (count++ > 0)
-				packet_buf_write(&buf, "ok %s\n",
+				packet_buf_write(buf, "ok %s\n",
 						 cmd->ref_name);
 			if (report->ref_name)
-				packet_buf_write(&buf, "option refname %s\n",
+				packet_buf_write(buf, "option refname %s\n",
 						 report->ref_name);
 			if (report->old_oid)
-				packet_buf_write(&buf, "option old-oid %s\n",
+				packet_buf_write(buf, "option old-oid %s\n",
 						 oid_to_hex(report->old_oid));
 			if (report->new_oid)
-				packet_buf_write(&buf, "option new-oid %s\n",
+				packet_buf_write(buf, "option new-oid %s\n",
 						 oid_to_hex(report->new_oid));
 			if (report->forced_update)
-				packet_buf_write(&buf, "option forced-update\n");
+				packet_buf_write(buf, "option forced-update\n");
 		}
 	}
-	packet_buf_flush(&buf);
+
+	packet_buf_flush(buf);
+}
+
+static void report(struct command *commands, const char *unpack_status)
+{
+	struct strbuf buf = STRBUF_INIT;
+
+	generate_report(&buf, commands, unpack_status, false);
+
+	if (use_sideband)
+		send_sideband(1, 1, buf.buf, buf.len, use_sideband);
+	else
+		write_or_die(1, buf.buf, buf.len);
+	strbuf_release(&buf);
+}
+
+static void report_v2(struct command *commands, const char *unpack_status)
+{
+	struct strbuf buf = STRBUF_INIT;
+
+	generate_report(&buf, commands, unpack_status, true);
 
 	if (use_sideband)
 		send_sideband(1, 1, buf.buf, buf.len, use_sideband);

-- 
2.55.GIT

