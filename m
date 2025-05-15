Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DFB729A9FB
	for <git@vger.kernel.org>; Thu, 15 May 2025 13:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747314719; cv=none; b=HQWrZMg3IogpKJX2DiT7NJD/HGaLufJkFBFQAhCj9U1/MQFpXnSN/1yOCGEEc8J6jQYlCMRhZE5yfSgcYSoTHtYCit80gIHZoLdUBgiPcmmBuwnnKvcNV9hwU2F03a4vRr5f0rf3kD6oZvVMkCF6FB4xFKbur17hIr7IFdUOZUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747314719; c=relaxed/simple;
	bh=kSty278w4892/MHPEmM6umMji8svjjciBegcKcH/Y/g=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=X/Nb/haNorxzgwUheLefEpsn9bsZYJgouNXA/+GY6bcBXv6e8iom/NIzy/KBKtLwy75lF7Tu8gJO5EPIpoQINA+Z5YF1BM2tHWmFFKHX6Cz5Qy7NRWjaXhPlpNVWpEUBlRx9mlFz+gRZAbsqEQGHdTV/HYzXI+rZnWr7OSsGCEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qj+u89An; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qj+u89An"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-442e9c00bf4so7034675e9.3
        for <git@vger.kernel.org>; Thu, 15 May 2025 06:11:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747314715; x=1747919515; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hY8dN0w7A04kZxdn0GgdjQaTyQislXxtEnIBMXbiUo4=;
        b=Qj+u89AnIRoCrHIhi3Kf0VMPf9tbfGr2hg6aPta5vloAkVhejBQPHrnQVFnnCL5enY
         4s0u2YaGIhUZ+0bcrH+JZg5AbUJc7/1LBg0ysvEm2KVNSI4VcmOMkFdtmtV4y0WF9DMq
         bIIt5pfMVSVqgDYTIdpuXcNUm+2h5Jl7lDw3vY9Q0iOKEXpPgVuaF+wzqNjQDzHQlru6
         LExX+xLe2hDGXT/U2oUrrFeeaw4697RqMJBeMpDOAv9YQ2M5LHN6gB7GuiaLfxaV1a7R
         3uA2Tpw3AYHYFaeib7757D241Bg/MvTBqXYr2TrMnnt5onhS1nt7hLRUJL3sywviQ+VS
         AW+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747314715; x=1747919515;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hY8dN0w7A04kZxdn0GgdjQaTyQislXxtEnIBMXbiUo4=;
        b=ZMQvZoOhf7UFcRsFtQCq/FMZNdG8UE7HzQi5GPBP+klYBRooIRGg6B/Zjj8KBjkA/V
         vGjxxoJ/5hAWLoC388GHTsGcLusNTr7R67m4teKXP0lOh0vtFFkBAQZDpICE9MnL/uQU
         zqXMJkUQLlIqAhvCVGHI1Ck+NLIi1ReyR+J9vpKOaIG+4vfaPV36KB+931oo2ijFECEr
         TZboQh5BTWKcljOVq/CpcYjCjRJTDc+naJZPG3fngAn/rwEjntpEwHMuQXkbL9q86AJO
         NkvyqhSAFy4evYbT8HH8JaaNzE9ZyPsR551wBMvFvuYwhRX54embgpuwBQ0BV5Ym2kyE
         up7Q==
X-Gm-Message-State: AOJu0YxNwpjtj/9htTxDqKVO93LCn/XKiw0qYe5JD25FepUBI8BKEr4o
	ylpWhMQ108ewCXB0f65QXjfpOnPnKCJcBvorAQGxNS8evLmrruSQ/SqPeQ==
X-Gm-Gg: ASbGncuUGhXrzx39H/TeaTlJsQx8sWX5ecEWqzTMCrFgLwh7aqO1ECy9+jBq1Sa3Qwf
	KxGZRo+w4sh3qzFWZjWulNfN2FbF8oqPQPPxdXq85bES89J9xheAkCtXiQZUO8FxYUzq6R1PL0B
	Pd0hHIOJPY61XC79eSIR4jzRYaIzyJkbWR9svvg8RraweN8+G5klxS+1rlE8DmLufkw8gntuRU9
	34gCMhDd2iV/hLeX0wFMkNAU0/NtWQB2Hs1i/EaKyOpfbYWEFvzSH8MuK2YveNbhu1YMsNKxz9n
	Vey59jB8sfDBDbS3+FqccS/JZdIES+iOuVBfN837Dt1WXCmglfuy
X-Google-Smtp-Source: AGHT+IEiQFADGm6AXClA8u1QI2NrFS7pKsCaQxlHjkhzoF03NKbvDi/O1g6RflE1u0jIVd3rE9qyLA==
X-Received: by 2002:a05:600c:a08c:b0:43c:f689:dd with SMTP id 5b1f17b1804b1-442f96edc89mr22997855e9.19.1747314715026;
        Thu, 15 May 2025 06:11:55 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a1f5a4cc44sm22309997f8f.85.2025.05.15.06.11.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 May 2025 06:11:54 -0700 (PDT)
Message-Id: <8d712a0ebc8d5161bdc80bdd7f4d05a967c66a09.1747314709.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1891.git.1747314709.gitgitgadget@gmail.com>
References: <pull.1891.git.1747314709.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 15 May 2025 13:11:42 +0000
Subject: [PATCH 04/11] upload-pack: rename `enum` to reflect the operation
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

While 3145ea957d (upload-pack: introduce fetch server command,
2018-03-15) added support for the `fetch` command, from the server's
point of view it is an upload, and hence the `enum` should really be
called `upload_state` instead of `fetch_state`. Likewise, rename its
values.

This also helps unconfuse CodeQL which would otherwise be at sixes or
sevens about having _two_ non-local definitions of the same `enum` with
the same values.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 upload-pack.c | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/upload-pack.c b/upload-pack.c
index 956da5b061a0..26f29b85b551 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -1780,16 +1780,16 @@ static void send_shallow_info(struct upload_pack_data *data)
 	packet_delim(1);
 }
 
-enum fetch_state {
-	FETCH_PROCESS_ARGS = 0,
-	FETCH_SEND_ACKS,
-	FETCH_SEND_PACK,
-	FETCH_DONE,
+enum upload_state {
+	UPLOAD_PROCESS_ARGS = 0,
+	UPLOAD_SEND_ACKS,
+	UPLOAD_SEND_PACK,
+	UPLOAD_DONE,
 };
 
 int upload_pack_v2(struct repository *r, struct packet_reader *request)
 {
-	enum fetch_state state = FETCH_PROCESS_ARGS;
+	enum upload_state state = UPLOAD_PROCESS_ARGS;
 	struct upload_pack_data data;
 
 	clear_object_flags(the_repository, ALL_FLAGS);
@@ -1798,9 +1798,9 @@ int upload_pack_v2(struct repository *r, struct packet_reader *request)
 	data.use_sideband = LARGE_PACKET_MAX;
 	get_upload_pack_config(r, &data);
 
-	while (state != FETCH_DONE) {
+	while (state != UPLOAD_DONE) {
 		switch (state) {
-		case FETCH_PROCESS_ARGS:
+		case UPLOAD_PROCESS_ARGS:
 			process_args(request, &data);
 
 			if (!data.want_obj.nr && !data.wait_for_done) {
@@ -1811,27 +1811,27 @@ int upload_pack_v2(struct repository *r, struct packet_reader *request)
 				 * to just send 'have's without 'want's); guess
 				 * they didn't want anything.
 				 */
-				state = FETCH_DONE;
+				state = UPLOAD_DONE;
 			} else if (data.seen_haves) {
 				/*
 				 * Request had 'have' lines, so lets ACK them.
 				 */
-				state = FETCH_SEND_ACKS;
+				state = UPLOAD_SEND_ACKS;
 			} else {
 				/*
 				 * Request had 'want's but no 'have's so we can
 				 * immediately go to construct and send a pack.
 				 */
-				state = FETCH_SEND_PACK;
+				state = UPLOAD_SEND_PACK;
 			}
 			break;
-		case FETCH_SEND_ACKS:
+		case UPLOAD_SEND_ACKS:
 			if (process_haves_and_send_acks(&data))
-				state = FETCH_SEND_PACK;
+				state = UPLOAD_SEND_PACK;
 			else
-				state = FETCH_DONE;
+				state = UPLOAD_DONE;
 			break;
-		case FETCH_SEND_PACK:
+		case UPLOAD_SEND_PACK:
 			send_wanted_ref_info(&data);
 			send_shallow_info(&data);
 
@@ -1841,9 +1841,9 @@ int upload_pack_v2(struct repository *r, struct packet_reader *request)
 				packet_writer_write(&data.writer, "packfile\n");
 				create_pack_file(&data, NULL);
 			}
-			state = FETCH_DONE;
+			state = UPLOAD_DONE;
 			break;
-		case FETCH_DONE:
+		case UPLOAD_DONE:
 			continue;
 		}
 	}
-- 
gitgitgadget

