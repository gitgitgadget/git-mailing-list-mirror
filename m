Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05CC13932F7
	for <git@vger.kernel.org>; Wed, 26 Aug 2026 10:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787739599; cv=none; b=CdCPpm3FRxjAvi7Oa0O+tRVMNiGpt2n7yWLywmsbPl0RHNRImXjHcI2tMW4jA8JqYf/wqf8GYQzDEAki5wv01tb4Yr78Y3ojxLVEkjDO9bpXKTcSJwPAlfjmy3odTB8bbLZ8U3TG89DSrJ6N880mkLbrIz8YXiHfX7G2yka+F1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787739599; c=relaxed/simple;
	bh=B3SN1ATBJKX3LmJdjOWVjgZEUDVqoHrUxRmQ64Qoiy8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=i8J40UsHuNcibIVWNU465TSVdi7TuS9EeZV+5wmYtDdpvrVo8WeiwJhDxV7CuY8RtizfjqtblVHBiUDw07EMcUjFJjdcWimHQRARoGKXsZ+/R0x47e/bhb0UjPFsuw/e195I7TWj2Iq+mz4eMk8D0A0b/CItzqx7GG8O6+3DyQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rUGWVMfv; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rUGWVMfv"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-c15e2dab83eso116195666b.1
        for <git@vger.kernel.org>; Wed, 26 Aug 2026 03:19:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787739596; x=1788344396; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NT7FFAMbwOQgFc1vopNGO2ONJTF4p93UwimeTPLGLgI=;
        b=rUGWVMfvJECjf3S7NIkt4FRZx3tYmcJKEUOzB1TZTw3lkzoXiC5/hXzGnwU3NOd40S
         nmSLzP7vh0uB4Vs3wHSMKaBMsJiAGvabV1rKhtnFST2cnY/G9GpvwtIuhkU1CexlfsD0
         CsHOZyaGCwL/e75JO/JvyMcu8oVsq3GT/xNLvdLOpAtQ3t4/JtmDiFthI58E3069gT20
         T6cfW5pP3AcPmRPPITHqTO6kjXd95+BAu/n1WcAMULCvOtTAHFXDDvuAoWInAxINQRcE
         GMDX8iT9Jc4sue2Hgc7JMuIeR6G+Oa8u/T9aFaqOVZljXUDzIpwidyTEXU//tVBDvmNk
         9FVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787739596; x=1788344396;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NT7FFAMbwOQgFc1vopNGO2ONJTF4p93UwimeTPLGLgI=;
        b=hPRDbh46qa102y1FvvV7XPMTVhh6+m9RBKIXSAYOVwbDcLC2DFAOdTYkwYAhMzgkQ/
         NPOoMmDix4uWYm8Y3t/GTLYw6LBd5Srtp2rbdB5K6e6NLvcRjbpQjC5pVZ/PQuP1DBb/
         ab7x0Clcyk8soQyMcK2iJ/birk28WJT2iUe65h+J0xDiF8XThe6OmmQz6tA3gB+uiXm6
         a8zWC47kvI+kF6kPUzPZmSj4C98mW8vGjq/yfWQSfYTmxmmqudhPhhC1t/G9TJmmagiB
         ce0GOhnGvu3cHevaEhjNd9ItnX+5KQeLdk33Pvzstqtib4Do2IHH/oDc4lmBWIq8zBzA
         0HxQ==
X-Gm-Message-State: AFuF++nSceu47AxEdhcLUzYB4dl0KKqhWranSmmw8hrRjmDYjjOVvTCe
	yL8cl8rJ4LpjDmllERpa9lOuSkkKH3cArFn5DOdyZXu74AbKuFGJv97c5iVst2Pp
X-Gm-Gg: AR+sD134TSXOjQrCUOriQdmYV0JJOscT9ubtqmOdHaw8fWacN7jNkcBq0Bxi/U8ouEf
	VA20XmKmRzLa1WZdAg2iiaejCpOaMxrQIus1RPKvnosnthoo3INlvL4LAXx/BC0TaiST9EWlipH
	3f4ii2TYIe6Uwf+p2PW9MecY5xYrzB7idLS2XfgoxE0c1+FBxIAanEY6JO4SY65NMXGtwWALLmi
	yuJB9Ur1/pnZytA55DaBejyBT0tkMmUwNeCuviFk/zWXezxeD//iGkW7zICjcylsMMkVdLwMrhf
	x1FHHvY1tA4WeAajaT7GUnRELddIfd+PgsnKwWRXsPqCNBXqIu1VR8J3oegBoZi++RmqrBJgbyq
	C2EK5sChB2Er9s8ZMr1DR7CWQQF3f2QeOOyxOF9K5Y3okA4nUKWVURiQ54aCl/5j2zrERboTvUI
	mvSyfntdpZhMuValujUovrtEORD2rlFHPziaqed1POaGmiIvLot760iHKxajYmVgIOCLkfNDUkY
	yHHCLWuX7CWuqHW7g6DPgg/HYw=
X-Received: by 2002:a17:907:e915:b0:c21:6f8c:2335 with SMTP id a640c23a62f3a-c250c391e16mr657028366b.16.1787739595886;
        Wed, 26 Aug 2026 03:19:55 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:8109:d906:4e00:d310:93d0:2327:2f19])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c250a5d6acasm477971566b.9.2026.08.26.03.19.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2026 03:19:55 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Wed, 26 Aug 2026 12:19:38 +0200
Subject: [PATCH v4 2/3] receive-pack: move message generation to separate
 function
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260826-758-introduce-hook-v4-2-6b14975ad957@gmail.com>
References: <20260826-758-introduce-hook-v4-0-6b14975ad957@gmail.com>
In-Reply-To: <20260826-758-introduce-hook-v4-0-6b14975ad957@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im, gitster@pobox.com, jltobler@gmail.com, 
 kristofferhaugsbakk@fastmail.com, Karthik Nayak <karthik.188@gmail.com>, 
 Phillip Wood <phillip.wood@dunelm.org.uk>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4163; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=B3SN1ATBJKX3LmJdjOWVjgZEUDVqoHrUxRmQ64Qoiy8=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGqOvchqeBYRio/9ZKDsEJ/VbLIjQsucn4YeQ
 rbSyOgse2s3p4kBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJqjr3IAAoJED7VnySO
 Rox/6mAL/0I8GyjNta+snL0C205LGFn2T5Wtn7FgGDMOt/ZMhN5ybc0railuEUNEIqBdgD3lB7L
 PXNTvfT8gxLqkiWio1trGxeEAnmi327W2smHd/9VHLvrqAhgI1VR/10O9J4qDAHQg8ukris1YFR
 5o5PD3vli0A4VEMfJ5Vj3XNskk6/4zzmTu05mQ1t0sHKNzjixcJQjZcf4rTgVugkWzHZYj7QYjG
 hMGGhVfl//3tyzXqJDatP2bHLiBnXufOugLH3gvpBlE1b9UnAq7dqKMht8jskjSQc1wq5+GIbwR
 jyS350dcRWt3ZTVb93Y9h0QHqW9pOvLktXDye/AXD61xTayFs25Rz7RiBUknJqnJxkICA/SZ1+m
 +gs1BdPHWtATbtuDjdSxoGOgVEJl+n85w4Csk5KhykBMOCY5zNHHunJDjupcVi7oEV443nE9f2m
 Us94WeqdVRwn1H/C1zbPJz/PJQ/ofa83v7LnT4O7zoIB6tvs9Pu+4utAdEF9AL209sJhZYjDhK6
 +k=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

Post the reference transaction, both `report()` and `report_v2()`
generate the message to be sent to the client. In v2, we also add
reports for each reference if available. Since they share common code,
move them to a common function. This will also help the following
commit, where we will need to regenerate the message during hook
failure.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 builtin/receive-pack.c | 84 ++++++++++++++++++++++++++------------------------
 1 file changed, 44 insertions(+), 40 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 86933d8d7e..70a686c142 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -2530,67 +2530,71 @@ static void update_shallow_info(struct command *commands,
 	free(ref_status);
 }
 
-static void report(struct command *commands, const char *unpack_status)
+/*
+ * Generate the response to be sent to the client invoking 'git-receive-pack(1)'.
+ * For v2 protocol, set `add_reports` to true, which will also add additional
+ * report per reference update.
+ */
+static void generate_response(struct strbuf *buf, struct command *commands,
+			      const char *unpack_status, bool add_reports)
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
+		if (!add_reports || cmd->error_string)
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
+	generate_response(&buf, commands, unpack_status, false);
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
+	generate_response(&buf, commands, unpack_status, true);
 
 	if (use_sideband)
 		send_sideband(1, 1, buf.buf, buf.len, use_sideband);

-- 
2.55.GIT

