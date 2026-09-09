Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73C2D56E07D
	for <git@vger.kernel.org>; Wed,  9 Sep 2026 14:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788965506; cv=none; b=ucwp24u2sHyAW4OP9zsuwvH9zAB2E9qmhZd6G45KsaOcOTtz6xbsS9nEo8Zb0fGhJ3Hk0u8tvPoCqZTJtthfUyODakalNvH0ZuO11FDF/w/n7bEbvZsYQeUjebEWdECBuxoJtPuECLjMxf/KNRFvFT2pL/g+UUJe0WSPhmry/ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788965506; c=relaxed/simple;
	bh=VZ3sDnAeCMUk7YrkNhij3rSE+gNcXj0BugteXwoYJxs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PiUqPB8HNiX1+BJzWZ4B0+xXdvFLpBJ4hI4R6tnbWteIQY/JnGEvFNvBMxGB7HJke/rRYRu+3Fa/c0CEBuD9+6gLUCjdFFSVtg8uiZ4tStE8vQSDJMwf+5SDJqubzMgrw0IDmx0n7OOwlcYujkvWFXovXYLTIUksqufGFydcUNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LTjz6FJM; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LTjz6FJM"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-49b965570d7so66868405e9.0
        for <git@vger.kernel.org>; Wed, 09 Sep 2026 07:51:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788965502; x=1789570302; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=f9IigmYKqv60F0rri056n1Aqe9AqJzetp7JeXofJwHg=;
        b=LTjz6FJMTXkXX+4KfUl3G+MrCz6CL4GMBgAkhwqahNr13/mLd2/OOuVoS9eM72mMQj
         AfcZiGiyUZMbpGqzUhRgVVnGJo9yqpgc+ROyomME1pR21CAa85UGrJsHo1M6pQpxpPZ8
         T3SMG8uKZVUtl3NHis1kuJs95npIXk/L7m0/EEFLbhrpQndmXRuLpGBTbLrCdiQDH4ia
         OZz461BqlxGmNuWw+v+sy1WuH9qh3J4e1GMF09A4oBaOBU91fwYYjwhN3jG7BfAgAchJ
         chcobtPCdpQqBi05/SwzfqYK0heUYE70j78khtkYSjroTMItGGdbATqM08C6hQuIQbJi
         hvQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788965502; x=1789570302;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=f9IigmYKqv60F0rri056n1Aqe9AqJzetp7JeXofJwHg=;
        b=F5+RmT5333M7TpTed2KsFKCThDH4e3FN7F1KR04yu66kNYzGofF9wM8fuNkUOtk3k5
         HSDswBqY1G79afCZvDpUByCtTf7IlsIsJPy5aZKVujaW4QS3Aw7tv257t3ryi/BKbx+8
         I5SMpM5ukk6ZGHbr5xShzKrPaFNcDQE27TSX+s1p2J7cTxE31Vt+ctpKrezXD/uqjUcO
         WxjyYk7wnSQysBECc6tdTqI1fz0rpbfjpTXbNmtXSh+XFBCTbkjEwFb/8z8d5VaTM+ZN
         yhEve8BTODUjfqmKFK6qj+8LM9YT2RJHhPp74z9/9xglsy8E1UTkhqiZ1Y93m3qfHVaw
         lA2g==
X-Gm-Message-State: AFuF++kyA4w83lmJkbK0gUvx+Zx94yrofLRQcbiI60e4PVC+nuFIZYEZ
	V5AuWkRhE+UUW63jn5MNUhXkRo4OW8qvka8zYqKlTmbtXBht6JeRtXyX
X-Gm-Gg: AYBFou00Tk0oA/dA865jdeH01bC1C/iQIfEez10Ff375KIzRfZZnJWktHDr7cyyynzG
	VyVuUp8Qz4ph0M0Zf0/sWvgLf6UCqAmXJKsREZhX+VXPntgsvlIHJ4MD+k8R5oExMy3ey3p1WyH
	//NiLmVyZlKpFAanrnd9BQ0SnaRePPynBsyuNezdU5a6YIU4yixXm/Gc3LlTm90mI5AcjsOOzC6
	K7ozCDJ7f7asO88iaQQGsAI3hsy4TGz2MRkyjHfl9MpveeE6bOEKa9mFIa3Nflr84afO1XFjVso
	TrbOfQ6FUAukvJDY8Itty+9ASPwzvOJ33IdjGNZnwlNQdnOL5gS6+bakeOwDcglq/FOCu0q64ih
	1wdyHmrG5YLNJpqyz/wMLKyASG9IJyw5UNL5uhNLD1Z1FYIy1iLuI3UkfOz3NVrxwMG0+066F5w
	G9n07BMXOLxkhxYIniJPk/oMEmAvoRsWDIQPx17z4i/YwRD6cOSSQR0VUHI44e5zNgFf762jG6v
	iYuQwd2q/hhrxg+1Q6kEMEYpmHsg2j71yjfUw==
X-Received: by 2002:a05:600c:4703:b0:49d:1a02:4797 with SMTP id 5b1f17b1804b1-49d1a0248fbmr102956865e9.17.1788965502000;
        Wed, 09 Sep 2026 07:51:42 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:8109:d906:4e00:a4c9:a6b9:39b9:91bc])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cee7fec25sm661451095e9.13.2026.09.09.07.51.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 07:51:41 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Wed, 09 Sep 2026 16:51:38 +0200
Subject: [PATCH v9 3/4] receive-pack: move message generation to separate
 function
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260909-758-introduce-hook-v9-3-3043d417e0ee@gmail.com>
References: <20260909-758-introduce-hook-v9-0-3043d417e0ee@gmail.com>
In-Reply-To: <20260909-758-introduce-hook-v9-0-3043d417e0ee@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im, gitster@pobox.com, jltobler@gmail.com, 
 kristofferhaugsbakk@fastmail.com, Phillip Wood <phillip.wood@dunelm.org.uk>, 
 Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4571; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=VZ3sDnAeCMUk7YrkNhij3rSE+gNcXj0BugteXwoYJxs=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGqhcnnu/I4dZdSuJt+5xvMlyGRxa6SUpP41c
 ckrV2Oo83eHGokBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJqoXJ5AAoJED7VnySO
 Rox/X+gL/0SSwfIiTffTq1aBdivT6UNBYj4bTBl0uph0TzkqXrdcyU+mp9XSpnvqlGCgNgctRhf
 Kx4Pz6ujHvHOWakX+9Akmp+trdktDaOzenjE0IA4uWMHMhnwAhiHtbfiOnqwn6xdbv8DExkEoLF
 5/smtwlM84W2zfJqGkrc1FKcjAaLSt8NLsELu34C/mJgqKFHAFlglZ/kFhICC7UtIkjHUxw57u9
 0+zldDE11Ikhr70d7SxoANsx1mnAEktjbkEJaEzS6fanysm+KsYRpi5ddYcGJEpBUr9pIXNlp3k
 ievspPiIH+TP70JRIiqqQ6I4/97tkW7wLPicbmYoA+d27FTIQNI4BMlEORll8LIaNwF0fmTf0Yc
 KFr11go8L6WtJR8gDdvTsHyrmHdz4pBHzjyWWljjdJsPX7GQzXqbz120pzJCw0qBMgmzwqusYwO
 pehsRZWmr80rmSemvrrCUA3wCPnsB1gWOv0/a7RzO0okvR82x1MiA3xaKDGGrS+pHaZ5S/tyaG8
 04=
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

