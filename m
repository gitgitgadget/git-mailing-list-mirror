Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 654193AA182
	for <git@vger.kernel.org>; Fri, 19 Jun 2026 14:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781881013; cv=none; b=Eqgyl/n3gVRKyzSTpyddp4fO2Uj3cFJjDlv0JKuBhNTUtZbmFPkzKaozDDnNmRKqt+xukrOAgsZLa+IJc5HZvuswcKRxBukXhe6ttdLd5ysJ5M/iH7g2N0uNg/DVnfkkoOtcNhvSv/V97NLwlkBcNOhqbzpld3b8inzOdsGKKFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781881013; c=relaxed/simple;
	bh=ab8997P9bkPz7CLfx0vv3H3+EvzhTwVJPvuRo4uX8rc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Aare1JuGH1L63G0U+S/WRTKzdAfc4Da966d9lJm/1xw8Vm5jhgPwsCMPgkQMJea0dLq+9uVs2CU+4HW0JZ+SqkvHuH6VUygwLW0nwV17EQ3oO+zqtw4jhYTueCbuktwEpiZ1Bhg2p39feqQ4rr20XKnP01hGTx9cx4FflEfxL1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gfnHWllj; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gfnHWllj"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-49241a577d8so5750455e9.3
        for <git@vger.kernel.org>; Fri, 19 Jun 2026 07:56:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781881011; x=1782485811; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SJPOnbCHz0jFK3fwo3f/cdRWhsjy7kNuO+Vbt00Q+mA=;
        b=gfnHWlljQYxoxnRMdGLT/zrc+l3/jTpkpFKIsNFr6M6XoWiks23edFBmx9tO7QTR3K
         FeSmhqZwC1cLiEtz0Eo9E3EkZIX2dz886rqZr1wcvCwocrYrx14AZxzOBR1hV1eiwAcY
         e8BFXhM0LD2+C331C8uwVNFW8wGxlO1Knd1veHEEAc3CiGUTtxkSJZpmGpA+XfVfmSXw
         NSizQNqFVUGvYeFZOBJfb4PitaLx1sNGkUlRxjdsrDapxUZEhKAQ42vGo91wukCCYpji
         bxNvi6HeMozKh9brvjqWJCrD3G/TcSWOOI8wKX2+jUbnzfpBWPRWxpHsSTrxoTVm6Mnu
         sHbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781881011; x=1782485811;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SJPOnbCHz0jFK3fwo3f/cdRWhsjy7kNuO+Vbt00Q+mA=;
        b=GSfxGTv9EEhes30ihIg4NlRUQdzFcvq87PXgx10T2SmCrgA5b80VN7P1yEHVo0aWO9
         gifvXx5Q/SeClTNc62Q9loezGfhamv7BnZp62IZVjcSXqwAPHqNLVm4UyXT+Fjp27DrS
         RHhV//XlVLgepfrePZ0cvwTMQwEoqKRnO9fPDwN1niBKF7Ft/KHlBPL5ZNgfmiaXk7SP
         bpyZANTt7Vmggy4kA7VyDyp8sh/4GhszLOoJEzhErxmMoqkmOwX0v+y5Xn0tR0cpShec
         wr6AdazVtP3sikXg419LH+igHptWgtGT/IoOXUsTE/eVsBZS0KTMLpyvVhzju9zTdgDu
         Aojw==
X-Forwarded-Encrypted: i=1; AFNElJ+PGPFnMdRO9kX6UHfwDaoLr3lSNBpP6cYUWFzR1ZEHmU1A3B1/nF8qWsQp6/So9fa57Oo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrLAJYxQ8hHxAXy+m/qhtg9V98uyvXtxEXugn/xlu/bOeZjsqO
	Zi17EM4tmxhsDML6oG/K92TNmyt3ja54CcLE+MHoJfBPs5G6D/PHQT4X
X-Gm-Gg: AfdE7cmcALT3+vB+cY/Q6AzO/sH2Jau8O5EJVkrsBMsmwkEcHt3UcuKtDpiAEJtxboc
	OEs3tswyx1sFT3Gcd+HgDrvs5qZYjO6lC7jAMqatGic1xWdw6dRbHSwqW1GIpLUP/rOY/sVCtUf
	Pe4u3WZqn7eA9CixiohqhqFJA+j8E0cxi4QLcbAeIumNY0bK0QCgfJ2Stf4rqyL0vjSD4ArPyso
	qb2MGJdRlApTm0sJ1pzXwK10ahCg11D0IrWkd1zcRu1X652SdQS8AVfZjXBNR1rvzeIptfqjXq7
	S6YbtseMnVgjmpSgnyGqLwS4RxiLUNslMm9p3/GLUJZe/BAYiZXBV47VT56AMMBIZtPBHBUm4FT
	5CUFY1epQbRNbgwMzZDfrH3jTTLNBrgIVJUCWDNJ4i9hLxhcB1Z+hLsn2taszJH3dHLIXQs6w1R
	oBLmOKosDwOS8qeJeTF2uo2wlOv+JPPjaeAaY/ujOOX8ZZlSkMS5pRKuuOGjMHKJFOSneoZt1Pl
	bC7p2I3/XN7KhSO8vPDD7l68ONChqzqhPWS5ZHwAOjM+gw8ferfoMH5ffSLY+mGwTA0xzm5m5Ns
	7nWHSxJD5PSF4UpRW7EGduEwbMDk1e7AvZSQ9/KyLoXyfCgjE9qRGosy8RB4XT9dhdBCGTQc4O+
	QoVYy33ZcCXmJsA==
X-Received: by 2002:a05:600c:8716:b0:490:c032:ae92 with SMTP id 5b1f17b1804b1-49240ea870emr59133395e9.33.1781881010668;
        Fri, 19 Jun 2026 07:56:50 -0700 (PDT)
Received: from localhost.localdomain (static-204-100-6-89.ipcom.comunitel.net. [89.6.100.204])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49240efc63fsm39430795e9.1.2026.06.19.07.56.49
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 19 Jun 2026 07:56:50 -0700 (PDT)
From: Pablo Sabater <pabloosabaterr@gmail.com>
To: gitster@pobox.com
Cc: peff@peff.net,
	eric.peijian@gmail.com,
	chriscool@tuxfamily.org,
	git@vger.kernel.org,
	jltobler@gmail.com,
	karthik.188@gmail.com,
	toon@iotcl.com,
	chandrapratap3519@gmail.com,
	Pablo Sabater <pabloosabaterr@gmail.com>
Subject: [PATCH GSoC RFC v13 03/12] cat-file: declare loop counter inside for()
Date: Fri, 19 Jun 2026 16:56:32 +0200
Message-ID: <20260619-ps-eric-work-rebase-v13-3-3d4c7315d2f8@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260619-ps-eric-work-rebase-v13-0-3d4c7315d2f8@gmail.com>
References: <20260608-ps-eric-work-rebase-v12-0-5338b766e658@gmail.com>
 <20260619-ps-eric-work-rebase-v13-0-3d4c7315d2f8@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Eric Ju <eric.peijian@gmail.com>

Some code used in this series declares variable i and only uses it
in a for loop, not in any other logic outside the loop.

Change the declaration of i to be inside the for loop for readability.
While at it, we also change its type from "int" to "size_t" where the
latter makes more sense.

Helped-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Eric Ju <eric.peijian@gmail.com>
Signed-off-by: Pablo Sabater <pabloosabaterr@gmail.com>
---
 builtin/cat-file.c | 13 ++++---------
 fetch-pack.c       |  3 +--
 2 files changed, 5 insertions(+), 11 deletions(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 446d649904..fab55c11de 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -723,14 +723,12 @@ static void dispatch_calls(struct batch_options *opt,
 		struct strbuf *output,
 		struct expand_data *data,
 		struct queued_cmd *cmd,
-		int nr)
+		size_t nr)
 {
-	int i;
-
 	if (!opt->buffer_output)
 		die(_("flush is only for --buffer mode"));
 
-	for (i = 0; i < nr; i++)
+	for (size_t i = 0; i < nr; i++)
 		cmd[i].fn(opt, cmd[i].line, output, data);
 
 	fflush(stdout);
@@ -738,9 +736,7 @@ static void dispatch_calls(struct batch_options *opt,
 
 static void free_cmds(struct queued_cmd *cmd, size_t *nr)
 {
-	size_t i;
-
-	for (i = 0; i < *nr; i++)
+	for (size_t i = 0; i < *nr; i++)
 		FREE_AND_NULL(cmd[i].line);
 
 	*nr = 0;
@@ -767,7 +763,6 @@ static void batch_objects_command(struct batch_options *opt,
 	size_t alloc = 0, nr = 0;
 
 	while (strbuf_getdelim_strip_crlf(&input, stdin, opt->input_delim) != EOF) {
-		int i;
 		const struct parse_cmd *cmd = NULL;
 		const char *p = NULL, *cmd_end;
 		struct queued_cmd call = {0};
@@ -777,7 +772,7 @@ static void batch_objects_command(struct batch_options *opt,
 		if (isspace(*input.buf))
 			die(_("whitespace before command: '%s'"), input.buf);
 
-		for (i = 0; i < ARRAY_SIZE(commands); i++) {
+		for (size_t i = 0; i < ARRAY_SIZE(commands); i++) {
 			if (!skip_prefix(input.buf, commands[i].name, &cmd_end))
 				continue;
 
diff --git a/fetch-pack.c b/fetch-pack.c
index 120e01f3cf..f13951d154 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -1388,9 +1388,8 @@ static void write_fetch_command_and_capabilities(struct strbuf *req_buf,
 	if (advertise_sid && server_supports_v2("session-id"))
 		packet_buf_write(req_buf, "session-id=%s", trace2_session_id());
 	if (server_options && server_options->nr) {
-		int i;
 		ensure_server_supports_v2("server-option");
-		for (i = 0; i < server_options->nr; i++)
+		for (size_t i = 0; i < server_options->nr; i++)
 			packet_buf_write(req_buf, "server-option=%s",
 					 server_options->items[i].string);
 	}

-- 
2.54.0
