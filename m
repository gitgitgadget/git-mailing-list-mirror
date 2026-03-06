Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B92CA337BB3
	for <git@vger.kernel.org>; Fri,  6 Mar 2026 23:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772838637; cv=none; b=RouXUaac0uR5xZktDVfWcrzHpUv/aa6iK57L69yR4cwVYzF/MUlOnf8APe7XNB1Gu35Xq5K+BdOzg+ai/1oLSOa+HAhx13gKr2XHv8y0ge4utbMan8G8r5qSng5RHKl9hciC+vUKr4fY5lrdr9MFL0kDAg8zHSKpEhAdw7YcDus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772838637; c=relaxed/simple;
	bh=WvFIgaqI75PjfilAN1vKfuopwvEG/p/oMcnUT9HubpA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QJ3XZ5WaJurQiLpCtNHThxcxzOo1TQDL6rKEi+ldNYBnnJQ3QQ5z8RV2YKJLxLSywUb3LPFMxUIVKNge3H8yEX2WkqXyBlrleZeHnlTUxpNnIwsd5/qestkrjX3mu64FTj9R4IXbzpE9cunrpr0Z5uhb4QqywuUQOnAO4nw6EGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=hv4tNU04; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=r5rzYTMU; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="hv4tNU04";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="r5rzYTMU"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 18B6DEC08E2;
	Fri,  6 Mar 2026 18:10:36 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Fri, 06 Mar 2026 18:10:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm3;
	 t=1772838636; x=1772925036; bh=OpuL/tGujAsr+c3Bd4+ZQoGhNsaQNsi9
	6MWrw+rL1Jc=; b=hv4tNU04SW+eVnqbmDIcy+aw2lYsG8z8Be86Xc+m6VEfImNP
	js+Fs8c3Kjoo7DkDk98wUFPTdJGmRRybvGRHzy+A3T8laeDQHsbEepjMNnuWIX8L
	9kdZGIWz5cV4QFJozq6ShCNmPCxDQ0N3TrVOgPPbgdxXyy78qoTCsz1HxbYQivsl
	WIYuy3nGAKPkqYl9h6THKM69EC9kgrIoHruRcPrXQvbCM1DoguwsKKzWzlHLXOBo
	kWbRPr/4tBww325ZY6mMs14Bg//ZqDQxFjsXsSPgC5YOWt2qB8FHtQ2SNC9pWvRF
	PQCEe486XHQlzbX7n1FZs2i3LcPVm9yDsaucKA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1772838636; x=
	1772925036; bh=OpuL/tGujAsr+c3Bd4+ZQoGhNsaQNsi96MWrw+rL1Jc=; b=r
	5rzYTMUS8WQsWvl6R1QbxWboJWC57WN6k0Go6QfjKtry7ph4aXiYX3VQKV8anDhR
	D6tDICW0AUzcFx0zuQ7FbWMJaKG/0CErev8UJkeiLF1gtE8gq+6XPaUzpCzVC3Wr
	1Z5bO4aCgbJ8N4NSvHnaVKu5Z6Q9/2ncmKy+W8zXfIAse3/MzrP9MFZ7v5mXhBOp
	eKDPEW0kCa9KQpJM6STzmzfoSG4SrQMvrJR7mHWHEPhC9zC0JtyXciBjgCxiQ1AE
	aTgMsI2Bi5+niPH97GwWVAffCP9uzxOZm/paoYh+xhAcdfircTGTlj4bFKurjEnU
	dsV/ECsBWEBRHo7skyP4g==
X-ME-Sender: <xms:616raRc5T3Acfhl-vryZakOoOHujxLxgTvnJE1pGsWQ-VjPO20fgIQ>
    <xme:616raVOYzWrOZcWvxQwQaTY0I5jPj7o90cMLBagmo0xukmuVwMSiK_SRA4Lr-o72O
    uLWit8sEkPBfWGviLs3kwW7-FWpEEu_PiFRcUjJLfCPNa2pVQFlWw>
X-ME-Received: <xmr:616raYJjMcs-eScaVaodklMuZvXduU9CykxoyzNr2PlX8rsl0Es4kzATt5um2rdyz0KKMX85sCEXWIZGZ_N1xU33ED6776LK5g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvjedtheelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkfgggtgesthdtredttdertd
    enucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosgho
    gidrtghomheqnecuggftrfgrthhtvghrnhepveevgfejfeffjeeffffhtdffteffjeejle
    eihfelffduvdegveevgfevhfduteeunecuffhomhgrihhnpeguihhffhdrtgifnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrh
    esphhosghogidrtghomhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhope
    hgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:616raWFzIIMEpWylY0g36i_Tt6USIV6NuLIqlS9NWXtu_z9FMfCncg>
    <xmx:7F6raQTErGHKgr0ZnXVqmljJqW7Movpu6lvhNAaJC_tTzGQXQ683kA>
    <xmx:7F6raSH58pdfpRjKiwAMKK1NfaING0YF9j25I9Q1UV9-QWUbOraX2Q>
    <xmx:7F6rac9rSCIrPqWhY55kN4AVxAZhOusSB7NL336tXv_Mh79dNfyUIQ>
    <xmx:7F6rac2eAW_42jE0sU7vEL2bncbsAvQdLYz1V_uQzYGr8eiGAiwzZJz1>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Mar 2026 18:10:35 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: An annoying "Bug" that we would probably leave as-is
Date: Fri, 06 Mar 2026 15:10:34 -0800
Message-ID: <xmqqh5qswo45.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"git show -U" does not complain.  In an ideal world, it should say
"-U wants a number", just like "git show -Unan" does.

Unfortunately t/t4013/ actually has tests that break if we start
tightening the command line parser for this.

This falls into the "if it hurts, do not do it" category that
somebody might be taking advantage of out there that we might be
better off leaving them broken.



 diff.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git c/diff.c w/diff.c
index a1961526c0..ff79a41cfc 100644
--- c/diff.c
+++ w/diff.c
@@ -5581,15 +5581,14 @@ static int diff_opt_unified(const struct option *opt,
 			    const char *arg, int unset)
 {
 	struct diff_options *options = opt->value;
-	char *s;
+	char *s = NULL;
 
 	BUG_ON_OPT_NEG(unset);
 
-	if (arg) {
+	if (arg)
 		options->context = strtol(arg, &s, 10);
-		if (*s)
-			return error(_("%s expects a numerical value"), "--unified");
-	}
+	if (!s || *s)
+		return error(_("%s expects a numerical value"), "--unified");
 	enable_patch_output(&options->output_format);
 
 	return 0;
