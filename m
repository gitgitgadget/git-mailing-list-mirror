Received: from fhigh3-smtp.messagingengine.com (fhigh3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E621175D2E
	for <git@vger.kernel.org>; Thu, 22 Aug 2024 09:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724318235; cv=none; b=lpRgsmZoTQCEJ04xUBWeBcxdcawxlvULIHFZrnuvXRHPN0SvRiaWF5n0ehP8kPv+C5ZwkDHa1ua0xsG8DzcUgdiQm5o0Fdo1NEcsJo8IHLMJhXJJkE4uPVyFmyI3VIDoWvRyozSCO3YCnsSacG6YwfzfSu6GrsOFBIVcILvYZ5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724318235; c=relaxed/simple;
	bh=JSmfvtR/Ct2tqfGDjOlz6UwxLrCiRpmHYB+uixyz8DU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rehx4TEMi7NOXzWtWVNMB3SnYv64DklAYdFk1gmPoQe0rc67wfRpKvoPcTxGJFZxU9wff6fSGHx8NpamQ8/wv3maJ8wSIxZCc0echU8gOOlgQkZy6bEn3nvpeaDw863L07eW0J7Lvtogx4LJboWJFRfMjQZs6vctmK1bJcYZXDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=MB0zx1xe; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=O61c4ONM; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="MB0zx1xe";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="O61c4ONM"
Received: from phl-compute-08.internal (phl-compute-08.nyi.internal [10.202.2.48])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 1A35C1151BBA;
	Thu, 22 Aug 2024 05:17:13 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Thu, 22 Aug 2024 05:17:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1724318233; x=1724404633; bh=osC24z7dhB
	sS6tpvNcPKRxMjKSKUX0C6NSUaScxGReA=; b=MB0zx1xe+c4ZsqEt2Djm9yeRw7
	yISChTrtqOdT74SLmK0Vqx2QXZ8293F4cNbOy5HHVeUW2ezsr7QiUQz3B8/OF8rZ
	UdJJH9mBN1Vok2KRNsCQHKJEqncSP4vSmUm8ykZxTbCTUOZK3RwmTc+QAKEMrYDJ
	rLq0KB1jUypdWzDYCe9Ju0K5yot5FIYA8LAT/rYXWowAJ4nuH3ZUq0iGthBGyfHK
	jQnkiowSu4iZ6Tqp0Du4RIAzFpF7iAe4zFtCB4KQPWEznHAf5cJZkE67oYPLp+9S
	ikOQ44k5Cxr9wkZ04eRiA2YoqUbg6mD+T2cXx3PEWcdX6sv5HPtUHWPC58bQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1724318233; x=1724404633; bh=osC24z7dhBsS6tpvNcPKRxMjKSKU
	X0C6NSUaScxGReA=; b=O61c4ONM0tnP0q0jvvFpTq1Rg7rRWBHR6k6VxGPbbl0c
	hwhRYQr8DJBZJls89vIzCqYkFepi2Noqy+XGKEgmHBumpgAde+GznESwD96qGDev
	kxLUiAbTe38VT8iv2j9snpArIkYRx85LYK3NioPjTm5rN570TEO+VIoMY0ipeRT2
	iW+zFMJAH+8It767JBLD1S79xR4JpO4NhxSqSWKPGmx1UqEqBPck9Wk0Kcwh2BlY
	9XK0BRHzOpgKwNBIZIUajLByLL3JNQ7glCDAsTMj2ojCkJAF/kZOOe9BMJmn+R//
	i4TQP6HodGZttFt+oCmXTLqIL1VgYYySct1GZNabPg==
X-ME-Sender: <xms:GALHZm0bUIJ0_GcZAFtSp2L2T21HPlZzUMJkgoJk-FJjSyLnFLingA>
    <xme:GALHZpG3MYvCvVO3XKBCgT3t0TvDla5yY4Gkg-w2RxL4NlG-DluCEFpb_gZMH_JdN
    hTvVnDyrI81yBaB_A>
X-ME-Received: <xmr:GALHZu7GI97TkY0tRg2wmaVjpXXBD691v0SiKF98syQv_e5h_tVop3QaDxHIlDJggvJgAaOro1DB40tWTVJph7EZUCXz5Aa8S5bmLjMBOloriVc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddvtddguddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvve
    fukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhie
    dtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsg
    gprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtshht
    vghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlh
    drohhrgh
X-ME-Proxy: <xmx:GALHZn3zQMbbMGoBwnLfJHRS1PX7EZCVIlsmikt1u6JcOqmCdkFqfA>
    <xmx:GQLHZpG-6d0pysD9FgcrPDgq8cK0l4aRIOTK1RWYegAi1wNOgXuDrg>
    <xmx:GQLHZg8GT2pvK6xUNrQWuH6Kh9aCpjAbQJQ2rSeFzp69UEXACkKJ-g>
    <xmx:GQLHZumfiE3V6Y-5Ll6UQxKP2oUdtWqTkTVneL9geyJUdsOxHDpR3w>
    <xmx:GQLHZuSsPR_IGMxkTQ3oZUIy0bbJc4g0-TCYL3pIzyr-U1N2Lku5G-qI>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 22 Aug 2024 05:17:12 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id f786c936 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 22 Aug 2024 09:16:38 +0000 (UTC)
Date: Thu, 22 Aug 2024 11:17:11 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 01/20] mailinfo: fix leaking header data
Message-ID: <69e30ea5179eff6472be54ebba64ebca3e562f32.1724315484.git.ps@pks.im>
References: <cover.1724159575.git.ps@pks.im>
 <cover.1724315484.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1724315484.git.ps@pks.im>

We populate the `mailinfo` arrays `p_hdr_data` and `s_hdr_data` with
data parsed from the mail headers. These arrays may end up being only
partially populated with gaps in case some of the headers do not parse
properly. This causes memory leaks because `strbuf_list_free()` will
stop iterating once it hits the first `NULL` pointer in the backing
array.

Fix this by open-coding a variant of `strbuf_list_free()` that knows to
iterate through all headers.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 mailinfo.c          | 17 +++++++++++++++--
 t/t5100-mailinfo.sh |  1 +
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/mailinfo.c b/mailinfo.c
index 94b9b0abf22..a4fa64994ac 100644
--- a/mailinfo.c
+++ b/mailinfo.c
@@ -1290,8 +1290,21 @@ void clear_mailinfo(struct mailinfo *mi)
 	strbuf_release(&mi->inbody_header_accum);
 	free(mi->message_id);
 
-	strbuf_list_free(mi->p_hdr_data);
-	strbuf_list_free(mi->s_hdr_data);
+	for (size_t i = 0; header[i]; i++) {
+		if (!mi->p_hdr_data[i])
+			continue;
+		strbuf_release(mi->p_hdr_data[i]);
+		free(mi->p_hdr_data[i]);
+	}
+	free(mi->p_hdr_data);
+
+	for (size_t i = 0; header[i]; i++) {
+		if (!mi->s_hdr_data[i])
+			continue;
+		strbuf_release(mi->s_hdr_data[i]);
+		free(mi->s_hdr_data[i]);
+	}
+	free(mi->s_hdr_data);
 
 	while (mi->content < mi->content_top) {
 		free(*(mi->content_top));
diff --git a/t/t5100-mailinfo.sh b/t/t5100-mailinfo.sh
index c8d06554541..065156c1f39 100755
--- a/t/t5100-mailinfo.sh
+++ b/t/t5100-mailinfo.sh
@@ -5,6 +5,7 @@
 
 test_description='git mailinfo and git mailsplit test'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 DATA="$TEST_DIRECTORY/t5100"
-- 
2.46.0.164.g477ce5ccd6.dirty

