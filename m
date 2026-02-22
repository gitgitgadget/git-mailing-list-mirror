Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02109DF6C
	for <git@vger.kernel.org>; Sun, 22 Feb 2026 05:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771736763; cv=none; b=qP1r8v9zznEuYQOIAUv4LvjvelKpWdq+f3hofB48P3XCcjTEsBZAzYo+dCvLjYH6OIYOcjxBO0OjB2ZKCNCoBzAKsXau+/itIOX3iAzy3sEjpMCVgutLyhg8ov8DPd1VKoPV5DWHwNpKMOjMZBBvHcIWGa8puHXQolm1QkGZp6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771736763; c=relaxed/simple;
	bh=vEOZJl6L//7e6aUY56VTBHsQTQ9aIzTNgLn505Zl7sc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CoKUJV9j6ZQBi2heDbnKjBwLFLoUBZSH6Tc5mTv4zgVOU9exnF/mvZg89IJIdQTecIqOFPxAPccY1F7caDXTmdC5kCNvo5gjSpoDRWHFcLOtO1kGtVgkFVI8D37Cw//oaMOXiJMPpJcMACBIEslKvVHNXOwg2t/XSdE3CeHkDBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=J1Y5xJVK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=vnP7WZvX; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="J1Y5xJVK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vnP7WZvX"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id DDCA57A01DF;
	Sun, 22 Feb 2026 00:05:59 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-11.internal (MEProxy); Sun, 22 Feb 2026 00:06:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1771736759; x=1771823159; bh=j3x6GzoshU
	CQLA9qI8lgUsT2BInZfTS8HAx4b12DfI4=; b=J1Y5xJVKsfN2IVJEnYtLT1aHdt
	L4vKGIdsJ5GeLEDztda6U0UbpfvEB7OwNbVNM1tctMQfRohGhANKpDRALnB225Ry
	imThEBr3DQiRbeRsK+RgUMwhOx+LFCqvMNOF0Un5gM+MSw2wgX7e7HtXZFQHlPb0
	4KRs1FDUMep6ztfbT1O4VvV8YsM2CASHW1UqawfPRtgPkZze6TSjoLjYOjx3gSc7
	XYwWP02gG1ulZ0QxzFP8mPYXgoGcv4Bmqyun2UWEHeWqRItixpjMqv/McogSxcts
	w7Wtx4vVpL9krNtopjGtVNIW4r81w0mKDZAk9OmP2zQedDy1aoAV6cMNjWdg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1771736759; x=1771823159; bh=j3x6GzoshUCQLA9qI8lgUsT2BInZfTS8HAx
	4b12DfI4=; b=vnP7WZvXb2qBnZlCuIrAzh005HXttYD8f+KZWw33k1uspwwsqRD
	waVnnOZ990k8SKvaPVVns9mqUPhexWYFbCHRR9GqaHVPHwNV7gOxFnuVUEjN9poQ
	k1DmRVLUcstU/62qnnqYciMfuTSMGNcUUcG9DGitnH7jhZMCFX/P56/4XAM3+CZs
	omYHv/aeMY9AwhykE8CfYN+oFegoscwZUs8LzRfVPjCcmZOGwpMBXElD8mLo7u8H
	QUfVcdvXMuHZOjVFirCXWi1SY/lmPIEgO46LJR851IADsuDnxHhviri31Ei5jU2e
	V0TwzZ3P6DPehajPvj1l/8adTSRgyrUlYaA==
X-ME-Sender: <xms:t46aaRLJ6rg9R6v6XNb5988uR1x_ASlLIjLOB5ILlAqVvuoetwXVyA>
    <xme:t46aaUCvYsCUpmsd7dI6GKvAzjq6HAVlA_Izxm30iKPirU7L7_dSyJw3AP1Kc2kM4
    VpKClSouAo-Nv_SvO45hCCfxGTRX8m_qJmmMSi_Nj4X1gZaxzBh1Lk>
X-ME-Received: <xmr:t46aaSCxikUp_AkT5w2jyOAtdlfESvL8wgpcbSgTX_bDH9Ixg74L0Yaxyl0KaM7DhcXhmrNgqi_1M9NeNTvlVb0VUbNbUPDGVw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvfeefgedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeive
    ffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegrmhhishhh
    hhhhrggrrggrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopehsuhhnshhhihhnvgesshhunhhshhhinhgvtgho
    rdgtohhmpdhrtghpthhtoheprghvrghrrggssehgmhgrihhlrdgtohhmpdhrtghpthhtoh
    epghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:t46aaeBUUcakQh_26hctBrtmYta2C3Fh9HoiQdRH5yrUN4TpGfMmpQ>
    <xmx:t46aaVogeDav6lUmItQ_H4aLjYUmHbmYnMT2WZb_D8a36u5-u3WngQ>
    <xmx:t46aaQn8KgFNl7cC1zTrvDxh3gnx1zH-S4GsltKpSVln5-qSIx0umQ>
    <xmx:t46aadytQppnO9miIyvSFpRJqiGhZ1CQel0BIVzxrxPxmTdf0pzOsQ>
    <xmx:t46aaXRtmOL1gZ5G7GUVci3XhSRmiBb7MnFxFjs4XHODUuregpXFEPEd>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 22 Feb 2026 00:05:59 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Amisha Chhajed <amishhhaaaa@gmail.com>
Cc: git@vger.kernel.org,  sunshine@sunshineco.com,  avarab@gmail.com
Subject: Re: [PATCH v3 2/2] help: cleanup the contruction of keys_uniq
In-Reply-To: <20260221162359.43336-2-amishhhaaaa@gmail.com> (Amisha Chhajed's
	message of "Sat, 21 Feb 2026 21:53:59 +0530")
References: <20260212041017.91370-1-amishhhaaaa@gmail.com>
	<20260221162359.43336-1-amishhhaaaa@gmail.com>
	<20260221162359.43336-2-amishhhaaaa@gmail.com>
Date: Sat, 21 Feb 2026 21:05:57 -0800
Message-ID: <xmqqwm05qsei.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Amisha Chhajed <amishhhaaaa@gmail.com> writes:

> From: Amisha Chhajed <136238836+amishhaa@users.noreply.github.com>
>
> +static void show_config_sections(struct string_list *keys)
> +{
> ...
> +}
> +
> +static void show_config_vars(struct string_list *keys)
> +{
> ...
> +}

The striking similarity of the body of the loops in these two
functions bothered me enough to try writing this; the result does
not look too bad, I think.

By the way, I'd really prefer to see contributors *NOT* to use
undeliverable and/or bouncing e-mail addresses when working on this
project, as I'd always have to edit the Cc: list to avoid getting
bounces.

Thanks.

 builtin/help.c | 72 ++++++++++++++++++++++------------------------------------
 1 file changed, 27 insertions(+), 45 deletions(-)

diff --git c/builtin/help.c w/builtin/help.c
index b70de09864..bc5c5a556c 100644
--- c/builtin/help.c
+++ w/builtin/help.c
@@ -120,36 +120,37 @@ static void show_config_human(struct string_list *keys)
 	}
 }
 
-static void show_config_sections(struct string_list *keys)
+static void grab_leading_part(struct string_list *keys, const char *var, int use_dot)
 {
-	struct string_list keys_uniq = STRING_LIST_INIT_DUP;
-	struct strbuf sb = STRBUF_INIT;
-	struct string_list_item *item;
+	const char *cut = NULL;
 
-	for (size_t i = 0; i < keys->nr; i++) {
-		const char *var = keys->items[i].string;
-		const char *dot = strchr(var, '.');
-		const char *wildcard = strchr(var, '*');
-		const char *tag = strchr(var, '<');
-		const char *cut;
-
-		if (dot)
-			cut = dot;
-		else if (wildcard && tag)
-			cut = wildcard < tag ? wildcard : tag;
-		else if (wildcard)
-			cut = wildcard;
-		else if (tag)
-			cut = tag;
-		else {
-			string_list_append(&keys_uniq, var);
-			continue;
-		}
+	if (use_dot)
+		cut = strchr(var, use_dot);
 
+	if (!cut) {
+		size_t prefix_len = strcspn(var, "*<");
+		if (var[prefix_len])
+			cut = var + prefix_len;
+	}
+
+	if (!cut)
+		string_list_append(keys, var);
+	else {
+		struct strbuf sb = STRBUF_INIT;
 		strbuf_add(&sb, var, cut - var);
-		string_list_append(&keys_uniq, sb.buf);
+		string_list_append(keys, sb.buf);
 		strbuf_release(&sb);
 	}
+}
+
+static void show_config_sections(struct string_list *keys)
+{
+	struct string_list keys_uniq = STRING_LIST_INIT_DUP;
+	struct string_list_item *item;
+
+	for (size_t i = 0; i < keys->nr; i++)
+		grab_leading_part(&keys_uniq, keys->items[i].string, '.');
+
 	string_list_sort_u(&keys_uniq, 0);
 	for_each_string_list_item(item, &keys_uniq)
 		puts(item->string);
@@ -159,30 +160,11 @@ static void show_config_sections(struct string_list *keys)
 static void show_config_vars(struct string_list *keys)
 {
 	struct string_list keys_uniq = STRING_LIST_INIT_DUP;
-	struct strbuf sb = STRBUF_INIT;
 	struct string_list_item *item;
 
-	for (size_t i = 0; i < keys->nr; i++) {
-		const char *var = keys->items[i].string;
-		const char *wildcard = strchr(var, '*');
-		const char *tag = strchr(var, '<');
-		const char *cut;
-
-		if (wildcard && tag)
-			cut = wildcard < tag ? wildcard : tag;
-		else if (wildcard)
-			cut = wildcard;
-		else if (tag)
-			cut = tag;
-		else {
-			string_list_append(&keys_uniq, var);
-			continue;
-		}
+	for (size_t i = 0; i < keys->nr; i++)
+		grab_leading_part(&keys_uniq, keys->items[i].string, '\0');
 
-		strbuf_add(&sb, var, cut - var);
-		string_list_append(&keys_uniq, sb.buf);
-		strbuf_release(&sb);
-	}
 	string_list_sort_u(&keys_uniq, 0);
 	for_each_string_list_item(item, &keys_uniq)
 		puts(item->string);
