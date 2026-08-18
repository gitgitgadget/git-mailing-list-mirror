Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19A6B3A7F58
	for <git@vger.kernel.org>; Tue, 18 Aug 2026 09:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787047110; cv=none; b=f0OjliKbcl2QCp3pTK1VyP+VuscjbTL2i6elC+oXxGfzNW783xSf3r1URKfet7cV1FuZHb+PxANG3G0XpHy1Ml9Q08IICIbu30g7jO8hQk7sFX2OMhwhq0kA9g6oReto/KtfscOohzP+TL2mElGgaWmyeyT449af1ojvBUze7t4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787047110; c=relaxed/simple;
	bh=NWrMTVSYI1mtPYnOyv1jR/vMuHBVXY+XQOrSavKnIHA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YgBQ5kRujoiEqVH8ZoasMvuvRsBKansyebq5/s2aWQ05QqqHokzGyLkilsZ3PYRqk2W6UACmYJ0xq9iRJ0NObB/pb3QrosiJhFC1hK2VnxH9b/R4kdVXvK61OG/6yxiOSr35R5NNVEJjXtuvKsDPtP1O8qezwWe3OV4W67mYd/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=dO2Ajg0a; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LSewX7jZ; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="dO2Ajg0a";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LSewX7jZ"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 4970914000E5;
	Tue, 18 Aug 2026 05:58:27 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Tue, 18 Aug 2026 05:58:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1787047107;
	 x=1787133507; bh=NYmC1Y5tgvfI/zaguUYlsRZvYjXsQlU5nhhG13Z5DuQ=; b=
	dO2Ajg0ahOvH79CDMu/ADJZ3hXQLLXPIF+P2ZVNvhD7mXHrQ8jxfWCCxIZD7nTix
	8I4fiBT4Pnoo7d0d+hQsqeCWcQ93cQNIPECLfwQTurVlPfFMu7czlMDQlMuHBoyz
	1LKeyZ+bxHz7T35yTtg5uNzjyiMafFrS+AVACB4tgerAabHOFzkveJcwyD4JqNhy
	QftGneaJ96NuK9iOej5hBoqi2CYUxJOKrftV19RA7cE80j1GUwyVeKNAwFIMjzOy
	jJZEe7Q0AnLTID1sSp09vq7kr13FB4f5FCS+9ZVHOqz1SO0w4FpUbR/BAvGZofY9
	vo52MrcclczkfzZGMrOkEw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1787047107; x=
	1787133507; bh=NYmC1Y5tgvfI/zaguUYlsRZvYjXsQlU5nhhG13Z5DuQ=; b=L
	SewX7jZhKf92XCwvuuAYnbHccvRtQqSqJiGuqJGyU0p48V/WleuUm7jw0IkpVKsc
	2+NfDp37IxqucCCiTXyPQJfUyg2PVcZsVtcgtgh9+JRTjMj9VYlQwgd3ky0NTtGZ
	3aJBqI4HCF1fL4MkIEgndKVjEQH7taSFXb6QAcGp51/tPwBPFt/HlcT6ap3HwDK6
	RssH6yQ1G6CLwlK2s7IsMhCttsU6phbwnf6+anV0imx2aY7gx8+FDyox9qzlRYgc
	OMzfjv53OALMp/A9u2cJMFy46/COV2IeC3UtZ06dxu5eQNECiBl3c8m2wWCSDl9S
	UQxZaqIxClRhM1kDswE6Q==
X-ME-Sender: <xms:wyyEatvdETxiSpLTMWz-YgHxjOofyqwCnjq48ECWICR6VNci-Q50tAU>
    <xme:wyyEasfXZelkuGoCZvO3gZKA22dG92KvNukZ8tlz3r3jmN5NDPlVq3ES69cegBtBA
    CF08PYRohEwATXrT1b9J-BzMt1IOQUaBytZpgHgei77Crb5YqntLZI>
X-ME-Received: <xmr:wyyEauaf9pE-WYqUeFODZYBjEXtUm_qzumnd0hfz-eBmnwVviXybOuHMINRqlLim8g0JcW8fMdz1ejlLqXfWT9CpvrfER_FQA4WsPoQ>
X-ME-Proxy-Cause: dmFkZTEoL7jzuvUOkrqm+feHKW+91xO6FjvywBQa6CPyBvINuP2bU60ZYwdo92R9ykpDpS
    IKxP9LC943/X23ogaJXN/avIdMAAEhqi67Vi1HNavw0ImZ6CUdZE+DtkCe/gqqoqS7CSNM
    39QLANb8G/GH8qjsXJPDLz9rX99aj3wwHn0/WGSXM55SxSf4e8zUIcgI4IDAeDCpyG/L8A
    cVLBQzY2at17/HFbwCIxH/ohjigFTSF27cMDUJ+wiDwJ/nXE2JxsPZHIY/c2dh7FACxxt8
    7zvCoI7LHYXc/8qKm+bjNE5Z6nQ0JU8bC6WRUT5ttv1jZjmgXE/Xpitp1Cy2pk2xl2jRGK
    Wa3mYw4V04AxC3QVG61HJNwMS2XwXKMnECyJx6TolXXw2SCa4Q6IvSO+IYDKCT2vPz+App
    CbUJovD7dLNR/1x3iiISh2eWvPYcE7Qkfdso5fpn0AfBiZoHTrO0BG9BALe5EJ+VPZ0HQL
    Z2X6Z/lgkrA19W3xZw81o9qFvz/isiLoQhhTLT4hM526KeyOCK/8FfSWsGzus/fAkSAAy5
    jRIrZXR+r0u3VKTYI/G0qKmArGw20hJaZIIHupmEbT0cFwnIlyxq5+lypdT2vQ8HUIDWWf
    UVe1SDIKkzVEAdIiHWroZzNIPvJjWmx8I4DuQq76l+FL8Raq5OR9v0+h6ktw
X-ME-Proxy: <xmx:wyyEavUBjb2T7IFCwkQSU7GlXxgdMar-Caoitn-RsS3uUn9Hcsf_Ww>
    <xmx:wyyEaghxbpJcKoPLLJQF3ktoXkUtp1jPfpAiUFw0Hp_EUSYRaTE0RA>
    <xmx:wyyEatU7i1PrGeFGYh85QtoeFiHLZbOIq3af5VXnogh9M2rJProhKA>
    <xmx:wyyEanOK-mO2Ftcqg4bVbvMuKGFh35jqEyPWB7w1Q5hHp8XQ1o5PvQ>
    <xmx:wyyEapH1aYLKfKET8zkNEX4XMKXmT-RzKNgWMe5dnKLdBp8RR-tP04i3>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 18 Aug 2026 05:58:26 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>
Subject: [PATCH v2 2/5] format-rev: place BUG calls first in callback
Date: Tue, 18 Aug 2026 11:57:31 +0200
Message-ID: <V2_BUG_preconditions.bd5@msgid.xyz>
X-Mailer: git-send-email 2.55.0.13.g85d2d65e389
In-Reply-To: <V2_CV_format-rev_three_more_opts.bd3@msgid.xyz>
References: <CV_format-rev_three_more_opts.b80@msgid.xyz> <V2_CV_format-rev_three_more_opts.bd3@msgid.xyz>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

I added these parse-options `BUG` statements based on existing examples;
one `BUG` check per flag. Now, of course the code as-is will not call
this callback with `unset` set to `0`, or with an argument
string. Rather, these preconditions defend against `opts[]` getting
changed *without* changing this callback.

And I copied the existing examples that I found down to
the placement. And the placement doesn’t matter here; we just
unconditionally set two variables. Failing on `BUG` before or after
that makes no difference to the user. Still, it is better style to
test function preconditions as early as possible. So let’s move them
to the start.

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---

Notes (series):
    v2: • [new]
        • https://lore.kernel.org/git/0bd9c642-9e88-4c82-81ee-20fdeb3c2797@app.fastmail.com/

 builtin/name-rev.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/name-rev.c b/builtin/name-rev.c
index 254c88199fd..d6686bbdbb9 100644
--- a/builtin/name-rev.c
+++ b/builtin/name-rev.c
@@ -782,10 +782,10 @@ static int format_nul_cb(const struct option *option,
 			 int unset)
 {
 	struct format_nul_data *data = option->value;
-	data->nul_input = 1;
-	data->nul_output = 1;
 	BUG_ON_OPT_NEG(unset);
 	BUG_ON_OPT_ARG(arg);
+	data->nul_input = 1;
+	data->nul_output = 1;
 	return 0;
 }
 
-- 
2.55.0.13.g85d2d65e389

