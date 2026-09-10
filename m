Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25DD5486406
	for <git@vger.kernel.org>; Fri, 11 Sep 2026 21:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789161692; cv=none; b=Q5/OkEi/+Gyv3LiawmvAbO558C8AcEKGVSzVlC76+nckOVUMxsk4C8JOTCcjzPdfoUJLvaC2uX28TxBzAB9PNLpXsaTGglWhh5/XUE7m0B29X5ixRF/32wooS4yZ5fhjtjVwjdBlFg6r+8JlIMPxWCjwXQ2jEOmZi0LQkJ9H09Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789161692; c=relaxed/simple;
	bh=VZ3sDnAeCMUk7YrkNhij3rSE+gNcXj0BugteXwoYJxs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=m5H57g+Ovm/msSJ0Sdab8VAiHe9X/+hedQohfMw9dhADWwGELl1VT4aiTMeEINeyEESQ2IQllmpoG1JnMWjzBBg3Ojii7lOMQA794PqJ7O/uPD3neXDoHbsVCwzEeTzwXlzJVybu5uZ5VJekF3gxDvuIo/zLQuPEt7d/rPBSaBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fNM6qKSD; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fNM6qKSD"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-482dd6ee390so1223315f8f.3
        for <git@vger.kernel.org>; Fri, 11 Sep 2026 14:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789161689; x=1789766489; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=f9IigmYKqv60F0rri056n1Aqe9AqJzetp7JeXofJwHg=;
        b=fNM6qKSDEZnVG0fljh2lYPeAdPdTRzHMjsx6NWcDbMEWONpSIql5lHyqO77Pp/RxRt
         xvFTJbdHs2Qx0umgkha0lgPXRE5Kc3y3isYJQkDBA4wrmxoGVAAgZNZIfNmWPUQqHRmo
         OZuCrRVRWNgdryqnOPWuz5Qig/LhJ7gt0vQ6l1xL8NHEYTxcGoT9qWxZPvtFR5vDMq4s
         8f0gOE2XUeXLHV0bjda9zPhPt/Px+BCB1I8y6t3/c8ScBc18+55IHq+0qfv41yPppSo0
         WfNiX5P60/l87X1a4yymnyNU99ezxfOC8KEY1v6s5Shnbo/MCul7rOHG+6fajSI2FQ4l
         aRDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789161689; x=1789766489;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=f9IigmYKqv60F0rri056n1Aqe9AqJzetp7JeXofJwHg=;
        b=H3avufI7NGpWvquP3TlQVMuNsTNA4e2JMezruBdEImVUzehknYOr6c4emQnCoTNAbX
         dpAR8c+UHKiI6iT5bmXTUkYESLSNe8Fwz0YYVw7Im7qp3VBCaQax1LUPOBUhklel8+Bu
         tyk5Er6AqtP+Hxn+O5sNVuZ3Am7EVkOfIhG+kB5gB+TwgvEHU9wDicN/Ik8MTh6/tptV
         ILi4BQ7VPfixWE3TmL9eJDfnLLaO7e/EDkp6vp3UcMNynVx4w503gZ0/bHmB2j8QTBBa
         jRYhx8tu2cL0lvtfCnl6kIouuoahF9FIhE86o/87DdBQ1q5hY0A64an9313yDn/ZjU+3
         Ry8g==
X-Gm-Message-State: AFuF++mqKxJ8G4VL5m/tUM7dQTtt5fN4bwqG7ZrUQ5qor7R+Zx28y/Uf
	YS55fix7AM7acecWa+ggnzZRbvaWZUrVD28dQ8dV5mWXV8T9Dw7LsWbY
X-Gm-Gg: AYBFou2Vr4qrT/klGpHzVOANGgVtw4waJwI3DhvtBxXh8FrPsVPbKYUicjfVHvyxs7g
	60ZW4lwbxpGBt1eaH9Usv0Wu6KulUA5vzqKbQRtqFVhkRM9TxU69k8dv/7suLz/cSnbHATr/Mc4
	KvSOzkBhBkSwbV49B7i5mQL95Akk/S87nbXseBmt+ARYEu/A1oC2bBfgLe5DNg1iJQzCtHvBwlZ
	AbY2z1eIJ4vzjP+SK4bzqhYxqtf2LJOzVWHdxptNZ3wKMISU/nLZRFJoaKmxfNqxz8a8UKc2b4E
	ulEjPv/UMBSLAYRbBVJY6M3hKqe3GmE2Oq/T+b6XTsF2de0GKCxiDNjYCH36bQQLzqqZ+3o8kzn
	iM1HkKicjEXPk5LmwjRMtYLt/ipV37C0QEmlXOOIEQ9aZzp2rA471zM83Ay91HJBLqgQFJaSeoV
	4mpG04oun5BOC/NvZh0H6zwt6QpNlJYAyQZjzXLQPScL+D6Zb282tEHIq6wHoiEuxkh8MjpbAMo
	m30MOUYzfje97iX70QXEjch71kIG79l3GAjyQ==
X-Received: by 2002:a05:6000:61c:b0:485:8c16:a334 with SMTP id ffacd0b85a97d-486eb338fc0mr7618117f8f.41.1789161689255;
        Fri, 11 Sep 2026 14:21:29 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:8109:d906:4e00:3cb1:ed0d:e325:5fc9])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-486eb2ecf2esm9435939f8f.2.2026.09.11.14.21.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 14:21:28 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Thu, 10 Sep 2026 23:54:08 +0200
Subject: [PATCH v10 3/4] receive-pack: move message generation to separate
 function
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260910-758-introduce-hook-v10-3-06f9c506631c@gmail.com>
References: <20260910-758-introduce-hook-v10-0-06f9c506631c@gmail.com>
In-Reply-To: <20260910-758-introduce-hook-v10-0-06f9c506631c@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im, gitster@pobox.com, jltobler@gmail.com, 
 kristofferhaugsbakk@fastmail.com, Phillip Wood <phillip.wood@dunelm.org.uk>, 
 Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4571; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=VZ3sDnAeCMUk7YrkNhij3rSE+gNcXj0BugteXwoYJxs=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGqkcM8WXXqWU7FDd1YuDM5UNAj9ivMJ76Q5P
 jbDWZMmf/r1R4kBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJqpHDPAAoJED7VnySO
 Rox/fqEL/32fqLcFhOb1iRPplFxUc5twuzuUtryApfC+/Ce48HheaElpo1eBLzJMufJab7ANPCu
 JMQTeVp7fC8Zk07vE2Tu5G14F2AFG2SZjDuDtqggZjOQ5/tfcFCumjxG1Dvv0ghnoQTNaLCB2yT
 Ua2FJhekgDiOqTMvy+TYbMtGfOpSxFLGJ6YifiuPN+hYj/w72DLbY2++kc0LZMDBLSROSo08jGQ
 58z21jVuUneefWr16xuB+3IEf0JK4TN4K/Zm69LtkoqtiO3JAUoFeSTTjOpVgrmmKV2L1GLZTGV
 NRto4oU833VELDccnhfwymP9Ldoo1NYnZuTSmT7yUy5NpNqPO7uUNZniqd9rqQ7GaMsOUmqN1L3
 Zv8JWbRBownGmbfLQ5U2tPAAd484A2K09l9HlZwTRSKH+87hagvDaNC4RbIc3vB9SuP8UCAK530
 aMS5YQyqQpcJQGSMKZjamYSxk1K3UA1LbDwwaGUJsvO/5uqkYlRh++WnikDdi4vISGYSiG1Yz06
 kM=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

After git-receive-pack(1) has committed the reference updates, we call
either `report()` or `report_v2()` to report to the client which of the
references we have updated successfully and which updates have failed.
The only difference between those two functions is that the latter also
knows to provide a more detailed report about how exactly a given
reference was updated.

With this, also drop `report_v2()` as both report functions now are
similar in structure with only the `report_status_version`
differentiating them.

In the next commit we're about to add another site that wants to
generate these reports. Refactor the logic into a shared function that
can easily be reused.

Helped-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 builtin/receive-pack.c | 75 +++++++++++++++++++++-----------------------------
 1 file changed, 32 insertions(+), 43 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 75a1788fa5..8b1ae4f7f3 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -2414,67 +2414,58 @@ static void update_shallow_info(struct command *commands,
 	free(ref_status);
 }
 
-static void report(struct command *commands, const struct strbuf *unpack_status)
+/*
+ * Generate the response to be sent to the client invoking 'git-receive-pack(1)'.
+ */
+static void generate_report(struct strbuf *buf, struct command *commands,
+			    const struct strbuf *unpack_status,
+			    enum report_status_version version)
 {
 	struct command *cmd;
-	struct strbuf buf = STRBUF_INIT;
 
-	packet_buf_write(&buf, "unpack %s\n",
+	packet_buf_write(buf, "unpack %s\n",
 			 unpack_status->len ? unpack_status->buf : "ok");
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
-static void report_v2(struct command *commands, const struct strbuf *unpack_status)
-{
-	struct command *cmd;
-	struct strbuf buf = STRBUF_INIT;
-	struct ref_push_report *report;
 
-	packet_buf_write(&buf, "unpack %s\n",
-			 unpack_status->len ? unpack_status->buf : "ok");
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
+		if (version != REPORT_STATUS_V2 || cmd->error_string)
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
+static void report(struct command *commands, const struct strbuf *unpack_status,
+		   enum report_status_version version)
+{
+	struct strbuf buf = STRBUF_INIT;
+
+	generate_report(&buf, commands, unpack_status, version);
 
 	if (use_sideband)
 		send_sideband(1, 1, buf.buf, buf.len, use_sideband);
@@ -2605,10 +2596,8 @@ int cmd_receive_pack(int argc,
 
 		switch (version) {
 		case REPORT_STATUS_V2:
-			report_v2(commands, &unpack_status);
-			break;
 		case REPORT_STATUS_V0:
-			report(commands, &unpack_status);
+			report(commands, &unpack_status, version);
 			break;
 		case REPORT_STATUS_UNKNOWN:
 			break;

-- 
2.55.GIT

