Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DEA14A4F09
	for <git@vger.kernel.org>; Fri, 11 Sep 2026 21:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789161691; cv=none; b=CUrYPHXSCo6/C5CnEZMNkBkNlksyeOhfQ7v4mvyrMcCe5Bh3nGTIUsQXpKOjafDcmJQUCsGb5SM6vHp+Zd6V25PMRh+1SnGwlCZo+DZC17jePF7FfVo8dt1cBLL3Kts6T+/MPs8fqbIY/5EMxi6hHrkSdJbTzQWWFPNMPDydQbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789161691; c=relaxed/simple;
	bh=FWFx7SINTPmDC7CuXz7gSPL7MUyvJRrD2DwiymbCh70=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pM8t8mpRHQUf00AvKGC2ITzOZCwCXtwkq+QVrs5zFanFzo/D/LoAttLyZu5v8a7driiNL9wOMhHgwGkV5PR7l6mNciPJhV7htLnQ+ZrKA4TxD4L63d5pbQwCLcUrKohfsRihdMicFE1onzOoGRve+ZX0rlDXeOerlaYd4tUOli4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e3V0qOnP; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e3V0qOnP"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-485888b3c3dso1320153f8f.2
        for <git@vger.kernel.org>; Fri, 11 Sep 2026 14:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789161688; x=1789766488; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Q2AZUquSvjrwUZJ3/kpV0yA7yWlFvh3bckc30B8aF9I=;
        b=e3V0qOnPrKa6d5OKbM7fXfIT+TGEh8wYBq8xgKfYXPpwMjOdNiiwSQ//0ofYpUca2V
         PRoVA7Q/PnwjsBWxzijYr6H4GYkie+XmeiB0oABza1Fzfg6sGfbZnGIDnNSlcbpUSH+j
         34PSo5al8138umJxM8l/B/2rfoXphSDucJg7zNlb2g8nYgcwiNdKZjK/w3FbFJZexwgl
         F24UhehVX7WsWpiFGzjgPt80xX6CNTZkDrtU5WTUL9wksS0vublgdatoHe0W5EkqRyrB
         zasaPf0Vlun1PFmPGe3qL5hfQUJBoKSUGKDz+Yz9Dv018wRVdVpXT5w5c1wV54tPLOBZ
         y7ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789161688; x=1789766488;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Q2AZUquSvjrwUZJ3/kpV0yA7yWlFvh3bckc30B8aF9I=;
        b=BR5MEPEy4C6ssnV/nkPRjVKP/1tnWDYpDxrPbjyw4vRnOVfynOhZ57F/ByRCzXdKUb
         GPbLE1WTPes91kZHp2LS9J+ngDKCwzl7IwQwPXqoxjGQ4JBR6uU0lZYGHJtS95fAbd1+
         bjEmBEXA3D5+x08skvyuzcMffPvyt4r4UyLe2aQOdetOHX1vW9HJgToB0KzRYeUDppTc
         P41rkIVlBJU0K+prwbAPxCahLF6yLYfZ8ldWR4urFFQS7ViIifens56nxvV/uVj9L40M
         Vswe+QzOXTvPAOOCidgA9Ao0vYXMuRi9yj3NT8GYjQ/nxsRQY1XHvcL0tVWut06zOV1Y
         bmJA==
X-Gm-Message-State: AFuF++mc5sM8O2EIljoLzyL57zKXt2Vx13mICimBssiw2q6X4umIogTo
	lk1PlUWFC7Oe4zYY4V7qe/Nd0TKMKcnkwaqrtrDtpHV4GPovW/rWE2qfAhGCVg==
X-Gm-Gg: AYBFou0XEGdlDOgzJHxwB8RiQoJREJlTaLGJEQh4mCjV74R4zVgcOL0QX83od/UhvYA
	jnSUbgQKQn7FCz9ToaQKOkcChMlP+PI0hK1/czv/FQRguxrNH2Wstj01aUfmY03Kuwb9YAfIrKj
	8OIVZsT+LCoK7/vvVFVrTTT1aTW+WJI8PdzJe4pETTEhjIvEAwI4h0E6yOhwLoSUi6MJzLUF1vn
	uxUtOD5A/Zns23wUA6KE0hxuqVfickKzE5Y+DP27X+BA8FS4GqEn57J3CiE42Z5ZB5nMRU1g7ul
	2zh2wFXVmgsEgCR+CQ6O5HMDtO25cStMv2C1GAsuBVRW4Id94T2/mrMd9MECtGdo3ZHuOluLxvN
	kolqU9okM9mf4KS736nduMwwyknS+45IbbSNrbpD2aeYqFdxOcoQ7AWrZdHwg//OtKjDAqtzjLl
	nlGlKT89qAG4CbNofzoG4JGxgSUdbBPmDl0ebB0qDjPL4WDWDnT/bgNIM2RhZ8QLDuyavPewIdm
	pHGyhXp72F7T+ChHe8gFjOiZfJ4/y6eLBJ5SA==
X-Received: by 2002:a05:6000:607:b0:486:e300:a0c3 with SMTP id ffacd0b85a97d-486eace4e5dmr7450005f8f.12.1789161688245;
        Fri, 11 Sep 2026 14:21:28 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:8109:d906:4e00:3cb1:ed0d:e325:5fc9])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-486eb2ecf2esm9435939f8f.2.2026.09.11.14.21.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 14:21:27 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Thu, 10 Sep 2026 23:54:07 +0200
Subject: [PATCH v10 2/4] receive-pack: drop static variables to track
 report status version
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260910-758-introduce-hook-v10-2-06f9c506631c@gmail.com>
References: <20260910-758-introduce-hook-v10-0-06f9c506631c@gmail.com>
In-Reply-To: <20260910-758-introduce-hook-v10-0-06f9c506631c@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im, gitster@pobox.com, jltobler@gmail.com, 
 kristofferhaugsbakk@fastmail.com, Phillip Wood <phillip.wood@dunelm.org.uk>, 
 Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3497; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=FWFx7SINTPmDC7CuXz7gSPL7MUyvJRrD2DwiymbCh70=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGqkcM5/U+Sc9ZPqUHGBD88258k+3i8IqufLq
 sbV6teg9AmS1okBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJqpHDOAAoJED7VnySO
 Rox/+Y0L/iAE/p/gmEE41w1bRuC2XSm5UtTcCsJTGszwKkceb0OfxNpalmLL1e0pHKHL7+PFSON
 7ymDE+ift5bvzum5z4ao8e68FR7SFhGo7F3tfyMv+bFbz5BIxR76H0K2s5O7kanTW++Nv7gonIL
 vD7I71wb6k1SPvEnvUzAaFVUyOxGh0HWaKqc/oNrbGbEqXXhig0tSiznkwlMNLnfTkAXQnb+dtH
 /PspZi/GrCnFUvaUGwD7fvU1EDhpRKJBBBTagCTSwwo0Kdm40GZVdK1CDsASes19oOV5e+3byZD
 9xyXIWqzZxU6oX36YjOt0R5OGyXQ0WP82o4Awf/0qeUpiIVFCRcUj6jBZdIiLI0eLOs8OCETsFB
 9Cs6hfYGcfYFqIOTFqr6BQasC+FmTMy3wEdgiphUusTyHuI/bYwSRITZ8eIABFKYbsACQU+aiwI
 s9lRKBwol9Lo3dAaHZ5rcjw5XlcLaRjVg9ePsMELwrg9gWQojjAlAgcGgYU6ZrnUmW6/m/iND58
 h0=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

In 'git-receive-pack(1)', to track the report status version, we use the
static variables `report_status` and `report_status_v2`. As the report
status version is mutually exclusive, using an enum better suits the
requirement. switch to using a new `enum report_status_version`, while
also dropping the static variable to make the flow easier to understand.

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 builtin/receive-pack.c | 30 ++++++++++++++++++++++--------
 1 file changed, 22 insertions(+), 8 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index e6e54ba55f..75a1788fa5 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -53,6 +53,12 @@ enum deny_action {
 	DENY_UPDATE_INSTEAD
 };
 
+enum report_status_version {
+	REPORT_STATUS_UNKNOWN = 0,
+	REPORT_STATUS_V0,
+	REPORT_STATUS_V2,
+};
+
 static int deny_deletes;
 static int deny_non_fast_forwards;
 static enum deny_action deny_current_branch = DENY_UNCONFIGURED;
@@ -64,8 +70,6 @@ static int advertise_atomic_push = 1;
 static int advertise_push_options;
 static int advertise_sid;
 static off_t max_input_size;
-static int report_status;
-static int report_status_v2;
 static int use_sideband;
 static int use_atomic;
 static int use_push_options;
@@ -2191,7 +2195,8 @@ static void queue_commands_from_cert(struct command **tail,
 }
 
 static struct command *read_head_info(struct packet_reader *reader,
-				      struct oid_array *shallow)
+				      struct oid_array *shallow,
+				      enum report_status_version *version)
 {
 	struct command *commands = NULL;
 	struct command **p = &commands;
@@ -2217,9 +2222,9 @@ static struct command *read_head_info(struct packet_reader *reader,
 			const char *client_sid;
 			size_t len = 0;
 			if (parse_feature_request(feature_list, "report-status"))
-				report_status = 1;
+				*version = REPORT_STATUS_V0;
 			if (parse_feature_request(feature_list, "report-status-v2"))
-				report_status_v2 = 1;
+				*version = REPORT_STATUS_V2;
 			if (parse_feature_request(feature_list, "side-band-64k"))
 				use_sideband = LARGE_PACKET_MAX;
 			if (parse_feature_request(feature_list, "quiet"))
@@ -2500,6 +2505,7 @@ int cmd_receive_pack(int argc,
 	struct shallow_info si;
 	struct packet_reader reader;
 	struct odb_transaction *transaction = NULL;
+	enum report_status_version version = REPORT_STATUS_UNKNOWN;
 
 	struct option options[] = {
 		OPT__QUIET(&quiet, N_("quiet")),
@@ -2563,7 +2569,7 @@ int cmd_receive_pack(int argc,
 			   PACKET_READ_CHOMP_NEWLINE |
 			   PACKET_READ_DIE_ON_ERR_PACKET);
 
-	if ((commands = read_head_info(&reader, &shallow))) {
+	if ((commands = read_head_info(&reader, &shallow, &version))) {
 		struct string_list push_options = STRING_LIST_INIT_DUP;
 		struct strbuf unpack_status = STRBUF_INIT;
 
@@ -2596,10 +2602,18 @@ int cmd_receive_pack(int argc,
 				 &push_options);
 		odb_transaction_finalize(transaction);
 		sigchain_push(SIGPIPE, SIG_IGN);
-		if (report_status_v2)
+
+		switch (version) {
+		case REPORT_STATUS_V2:
 			report_v2(commands, &unpack_status);
-		else if (report_status)
+			break;
+		case REPORT_STATUS_V0:
 			report(commands, &unpack_status);
+			break;
+		case REPORT_STATUS_UNKNOWN:
+			break;
+		}
+
 		sigchain_pop(SIGPIPE);
 		run_receive_hook(commands, "post-receive", 1, NULL,
 				 &push_options);

-- 
2.55.GIT

