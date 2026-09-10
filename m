Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 767C14825A8
	for <git@vger.kernel.org>; Thu, 10 Sep 2026 15:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789052973; cv=none; b=fCo62liFiAPYB5oh/7XP7P7T+33fTNVKGuGdM9gB4amL8YoKyv/nT0B9QHBX0sPIMtHcfzD8qcTU9RlO24kftiyRL9DX9ixWoi9+3+9T7RDDSwHmD6pcFenNJSKYHBZm5Ts8b3aaP1dajREy26PwNIw1GThl4JzX45bS9X/gKic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789052973; c=relaxed/simple;
	bh=+VE8+YCDezKsP4dnIrSnN4dWSWQ0iSVo63eNy2cDSCc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PNJtMsyzNJ1wXJJIcayVNB3FORufKKKAL/ALDCXYPL1QKN1tDoF6fLctFVoLAX5hanhF68rLA8nvFfSBag5ssHrS8RAofViy1vcSnOnHjbmFxsn/k3Es/mwj3p2uMJvjsTv30JhtNYeBnnfTWq2aSj2LO5fwkemAECIanczlcPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=GPeV4b0m; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=wGayX9UB; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="GPeV4b0m";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="wGayX9UB"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 17AFFEC00DB;
	Thu, 10 Sep 2026 11:09:25 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Thu, 10 Sep 2026 11:09:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1789052965;
	 x=1789139365; bh=j4sXwgH9ZxIakiSIYcmiSscvVEz4QlbALuL6jLg5Soc=; b=
	GPeV4b0m5q5wSxxUV93OzECHo3kYm2UvbIrXkTXB2QJgXOvNI7cPMxKwTaA7WmPq
	dSG/r4E2DQdbZpVIZr32/zzNQ8ISYC2UjOE90Cs3raC4MaIQ6DjUgibby0KRUuVB
	SaLZ5cApGeBzpfaHdbd6oL3dAINQTr5L4AvNP5GqfHwwxInw6MJjTKy94v1NZDy3
	rnABwRtKE61+EhtzCvzKnBvuS/DJOG8S6qQA4hfSRDLTlFyGU9kopCVxlLxflGJK
	clkLcrvGzrlKU06ClIErKzbtQd/vMAqXpCR0aytoLYsYkgQJJFTy+hxjViMvvzTD
	Q8Saebbj/B5Xxd3EN8dtoA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1789052965; x=
	1789139365; bh=j4sXwgH9ZxIakiSIYcmiSscvVEz4QlbALuL6jLg5Soc=; b=w
	GayX9UBrTJ+4F+cnK7Jug1RdHgs2+Qav/zRgftc0R1Pctnz2oQHjt+BSco3y1+cd
	EkduwGe3jP10MsQWk0xZCjkpG6GCmod/jYSbpwWrAZlqjzTJPNBtFPUQFOjFP9rU
	STABMxZod7r9Tp8n7AgBPdq7t3VvCi2Tc66jX/ekumb0/fTKNdt0EyHVwC/tNyjO
	NH72YFtml6TcYPkJC+GsOFsG30Qlj08Nnj8kfJo2ntwAqR7Pwmuphb9AHVbNSQc0
	dX4lnzZKuNtGxtKSs+R2iWRLa9JQ+Wfv2Qun2nauy2J8gBk6GlP/DCq/4J1OMxyP
	h05nbdoggINTghg3Ky3tA==
X-ME-Sender: <xms:JciiakhhFBDn3zDzdbv3YWi5LXiqDHk8wvUK4rc-qvAX_R6VTBppEQ>
    <xme:Jciiaj4CoWHw5_2otiMx0MoZNyHOwonn-I401dAVi2hjdEdi3N0xKzAti1jhAyitR
    2UcqWPIwQsVTx0JWimlKEDL9KWPe25T6JalPi78PFjsJNsR8Zn2sio>
X-ME-Received: <xmr:JciiakY7zLFxKkeqE0_3WbSAa_0nptpBkkXjNJ-DZMmk93ZJZ8AZoQ>
X-ME-Proxy-Cause: dmFkZTFFdc03CNNyOBWTAt6wx2hbXo4BB0aQpfuJx59h6AO81FoWpJefSQqDmtSVVk3kMY
    WmKKgCE4499x/K8u3l98kvCsn9yKWkukBAlcpIDZrkFCBER5V6HMf2Q1Ib75PcUwVbIWhs
    3aPQ0jJzgntFT7qkbBeUm0BU90Pklp25iryKzyLg8FPcUZTSRMWN/xaGmzz1mC0d4D5KKH
    r2qPRbrVHJudGq0or/8OlnhJYEJ+/Wm30a/eJJslEmdFnsEz7UbDIjUaFERBHxwaj9qiPZ
    u0Uxpq3BZZWicVEex9Az/KhGIzF0HSSgDlPWO4s/kQOEBpcD2meN59AovrL+sZ+fCIf8Z9
    z7wlnEECR8XqJxoehzINZPf1+RA2UWVb/WhdAqWtoVMyCeZXPKHZtSClPpD2MgfXv90yD7
    lyrfOGtLzcgmF2tMIH0dNikojXoj9u2o4oKXTyGcHraODgvtCX+kYPl0SIIOFNz81WVLKe
    c1/NubxNi9WA2GhWzaK3fVdiK9Pzlw/rKBSslQBtwj/48ePgAPj+7oQ1YvmLQ3NCvsWZ/V
    NmF/HEcxugF6Pqi2ty8AEJhJXUFTUkukF0SdG8EXMqRY73Dx6Mox9L2i73wM2ida2+RN+N
    znJ9Qc4rW1MWPohF5En9u39qtstT+2i38gvGhOcrz9Dptodd5dFy83AIoWow
X-ME-Proxy: <xmx:Jciiag5LXw8cuTe4xn4oFPL2FinWCp8xG-7K3udYfAKlEArwUEjOFA>
    <xmx:JciiavBF_7LQle5gm1Hc4zQCP4nUguAiAPbORkX4xQJlI3Hx0g9B7Q>
    <xmx:JciiaufAwixHi_T4RqA5vc5msBoD7a-1WdeVoEokedgZdv-Zb3vpTg>
    <xmx:JciiamL0aIXssGjPsxPpWHgE7NhWvE_AGuM2JYbhY11CZhz8NcZrYA>
    <xmx:JciiaiU_M2wMNCXigfDnTrd7GPbuprqlaGIych0feB9s9C_vHqIAAjdW>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 10 Sep 2026 11:09:24 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id a7da479b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 10 Sep 2026 15:09:23 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 10 Sep 2026 17:09:13 +0200
Subject: [PATCH v5 3/9] builtin/clone: move around `setup_reference()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260910-pks-odb-write-alternates-at-creation-time-v5-3-8d10c4238edc@pks.im>
References: <20260910-pks-odb-write-alternates-at-creation-time-v5-0-8d10c4238edc@pks.im>
In-Reply-To: <20260910-pks-odb-write-alternates-at-creation-time-v5-0-8d10c4238edc@pks.im>
To: git@vger.kernel.org
Cc: Toon Claes <toon@iotcl.com>, Junio C Hamano <gitster@pobox.com>, 
 Justin Tobler <jltobler@gmail.com>, Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15.2

In a subsequent commit, `setup_reference()` will start to call
`copy_alternates()`. Prepare for this by moving the function further
down so that we can avoid adding a declaration.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/clone.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index bdcbd7aa1b..ac5843d7b9 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -179,16 +179,6 @@ static int add_one_reference(struct string_list_item *item, void *cb_data)
 	return 0;
 }
 
-static void setup_reference(void)
-{
-	int required = 1;
-	for_each_string_list(&option_required_reference,
-			     add_one_reference, &required);
-	required = 0;
-	for_each_string_list(&option_optional_reference,
-			     add_one_reference, &required);
-}
-
 static void copy_alternates(struct strbuf *src, const char *src_repo)
 {
 	/*
@@ -228,6 +218,16 @@ static void copy_alternates(struct strbuf *src, const char *src_repo)
 	fclose(in);
 }
 
+static void setup_reference(void)
+{
+	int required = 1;
+	for_each_string_list(&option_required_reference,
+			     add_one_reference, &required);
+	required = 0;
+	for_each_string_list(&option_optional_reference,
+			     add_one_reference, &required);
+}
+
 static void mkdir_if_missing(const char *pathname, mode_t mode)
 {
 	struct stat st;

-- 
2.55.0.1074.ge7621b4bad.dirty

