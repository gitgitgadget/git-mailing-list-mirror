Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA9CE7404B
	for <git@vger.kernel.org>; Thu, 15 Aug 2024 18:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723747881; cv=none; b=A3gcAZ2Wz4qVIt4FXTRfir6rXAeb2gwJd12Aljo6EoiBS1dKBzDxVPx6ci5pxBeLNaG0KZSX1YGyC1Vdld2Vuv8uPzX2QP9+995fR0pCcNbwJJT8Ex3btcUdSb+0vwDU0dop3sFwjGzYGyVNM3A7aTcI8pzwZEDZgjCOnAxe0Tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723747881; c=relaxed/simple;
	bh=EcaP9x+Om0GFs3VoO59QALnr54Ua1XUE1sTt/nTO5MY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=GWbQIi6aTG4CrGDVYkzKhrrhx3wP/5GofR5LlEnjOb+O3BQyceCa7McpDOkemUTBLhY118nk/mmelvickWLjRln6bwfXfmFhgQPHPAOuSjEk1W/Obpi3GAB0N8iTil92u7UPScU8TTLrtiP7D8JfPs5a4Cjl3qWPHcbP9wywiss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--steadmon.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XwaZ97SS; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--steadmon.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XwaZ97SS"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e0be7c74d79so1716377276.0
        for <git@vger.kernel.org>; Thu, 15 Aug 2024 11:51:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723747879; x=1724352679; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pU5s2jbiLc0srigci70hTSMUU5bSY7UQBp6w90A+WOo=;
        b=XwaZ97SSL3r/fwN+PPpGWQge4yKj5fBa8JNWXxVa2ufXIuqsu/7GuCtvmrf2THl8gn
         flF2KeyQpfHEj8GXD7YlgTorcg9j7+naYlU+sBw8xKC/WlRMuuFySRMdfRDlQ/i8A1AB
         2pFFKWdVwVhT/vm1QzTaPI2sA8SeBRfU20Wr8nFMSE5GkL07AYUQnewM5o7+3Rvll5qM
         c+06i9buvxZJePEYGzRgQFCY7hpUXizDkptOqa6/SRmTxvnVBobPKgNP9e368NnYT8E3
         hdN4CCtgTJ8Vaxd3jcrQ5gMumWqX8kEiMEE46qcSSuCj3TgGsfhBTKkY31VHtExZepSk
         DDqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723747879; x=1724352679;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pU5s2jbiLc0srigci70hTSMUU5bSY7UQBp6w90A+WOo=;
        b=gqubx3+Cvww2K2VnFaSC7WJeFKi1fnICO0+VRj8gvciYzG0TKJv9WY6Vf4zwo9aLva
         3+h1X6vJu++0ys4ELWEchG40X6GsO2mlLpBepheT0BNNKdQ4CglI67vzHOjKev/tL5xJ
         /jLFVsBzDNSVUFYQFQ30NEFMH6d3SCz/Gu21X1suq6/nwuWruuQlBBt72m1HYiMkrHGw
         gx0OVualj6PwZWAFZ4juTHHp9hNbT0bn1QUyjITTu7F67jxy+lWZmD0JiMm2jzs3nRT9
         umClEQPvj/rE2WlibfimETVoUQQLokeYXReXEe3cegbZQuPH8WDBV9NLLGNZO3wV50XJ
         YZOg==
X-Gm-Message-State: AOJu0YwHcWrsntzP3gC/vKC6KxhSXY9I4FhPApOuXkP7raKkcbwCEILj
	25I7tdkT2uAxdgz+4ri8alj6i0UACPGJyhVXcIbBwaUyEBN1GqwqSJPK4zifecMBzFSqVvbTvKr
	ZEVGAIU5gOBN6qh/iEz1IQBEm9OocmFm7fIkeA8/3p/cAXzp+RWgWdQirWpEVglVzYrzK4qrv7u
	I75/nkqpttgp7N81QUX3e5Lyezx8dGUoU809BKBog=
X-Google-Smtp-Source: AGHT+IENHgmu+sXxeXCSY/za4DEIhJP/6Jft9OjkO1Tj01E4zvcbm2DZZcTVQxhoMzQ/hGSg5yTALf1j8pMgxw==
X-Received: from lunarfall.svl.corp.google.com ([2620:15c:2d3:204:d4b3:f740:176c:e447])
 (user=steadmon job=sendgmr) by 2002:a05:6902:8d:b0:e0b:958a:3344 with SMTP id
 3f1490d57ef6-e1180f9e125mr27773276.10.1723747878894; Thu, 15 Aug 2024
 11:51:18 -0700 (PDT)
Date: Thu, 15 Aug 2024 11:51:13 -0700
In-Reply-To: <cover.1723747832.git.steadmon@google.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1723747832.git.steadmon@google.com>
X-Mailer: git-send-email 2.46.0.184.g6999bdac58-goog
Message-ID: <d57f258026f941e7bc05de8dac359fc1e2e42bee.1723747832.git.steadmon@google.com>
Subject: [PATCH 2/2] send-pack: add new tracing regions for push
From: Josh Steadmon <steadmon@google.com>
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Calvin Wan <calvinwan@google.com>

At $DAYJOB we experienced some slow pushes and needed additional trace
data to diagnose them.

Add trace2 regions for various sections of send_pack().

Signed-off-by: Josh Steadmon <steadmon@google.com>
---
 send-pack.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/send-pack.c b/send-pack.c
index fa2f5eec17..de8ba46ad5 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -512,8 +512,11 @@ int send_pack(struct send_pack_args *args,
 	}
 
 	git_config_get_bool("push.negotiate", &push_negotiate);
-	if (push_negotiate)
+	if (push_negotiate) {
+		trace2_region_enter("send_pack", "push_negotiate", the_repository);
 		get_commons_through_negotiation(args->url, remote_refs, &commons);
+		trace2_region_leave("send_pack", "push_negotiate", the_repository);
+	}
 
 	if (!git_config_get_bool("push.usebitmaps", &use_bitmaps))
 		args->disable_bitmaps = !use_bitmaps;
@@ -641,10 +644,12 @@ int send_pack(struct send_pack_args *args,
 	/*
 	 * Finally, tell the other end!
 	 */
-	if (!args->dry_run && push_cert_nonce)
+	if (!args->dry_run && push_cert_nonce) {
+		trace2_region_enter("send_pack", "push_cert", the_repository);
 		cmds_sent = generate_push_cert(&req_buf, remote_refs, args,
 					       cap_buf.buf, push_cert_nonce);
-	else if (!args->dry_run)
+		trace2_region_leave("send_pack", "push_cert", the_repository);
+	} else if (!args->dry_run) {
 		for (ref = remote_refs; ref; ref = ref->next) {
 			char *old_hex, *new_hex;
 
@@ -664,6 +669,7 @@ int send_pack(struct send_pack_args *args,
 						 old_hex, new_hex, ref->name);
 			}
 		}
+	}
 
 	if (use_push_options) {
 		struct string_list_item *item;
@@ -686,6 +692,7 @@ int send_pack(struct send_pack_args *args,
 	strbuf_release(&cap_buf);
 
 	if (use_sideband && cmds_sent) {
+		trace2_region_enter("send_pack", "sideband_demux", the_repository);
 		memset(&demux, 0, sizeof(demux));
 		demux.proc = sideband_demux;
 		demux.data = fd;
@@ -719,6 +726,8 @@ int send_pack(struct send_pack_args *args,
 			if (use_sideband) {
 				close(demux.out);
 				finish_async(&demux);
+				if (cmds_sent)
+					trace2_region_leave("send_pack", "sideband_demux", the_repository);
 			}
 			fd[1] = -1;
 			return -1;
@@ -743,6 +752,7 @@ int send_pack(struct send_pack_args *args,
 			error("error in sideband demultiplexer");
 			ret = -1;
 		}
+		trace2_region_leave("send_pack", "sideband_demux", the_repository);
 	}
 
 	if (ret < 0)
-- 
2.46.0.184.g6999bdac58-goog

