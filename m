Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7DAE4B0493
	for <git@vger.kernel.org>; Sun,  9 Aug 2026 20:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786306195; cv=none; b=L+/eBEMMoDEPY6dh9wEThOCIRY2yIoeilEv87ZtnGPj6J7RbanXHbpd3OZUzSTGwxphltB/W12+NPtFVEPqT9cCAEo27feC7leWx5eu8wh6LTMpqE1AA1U4Hzh8w0cop064XHWXS2tVSeKblDZuxMWsd4s2fek1nh+a0sgFaOo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786306195; c=relaxed/simple;
	bh=lJAiJnX/QZWF9DGc14FSYJUxkq4oFshbX64WXY6Ezww=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BHe94Z3zle5c6c2nsl/FrlNRJMFmeKQAFMUxzd4Zu8fKuJaF3IfYFok9QKRDHccH5/qv6EHxevQPGly8cjod/UQeuqKCQdU5VYYndz1Dd/t34NkLBBgyxBHZNFXIf4mvEYwJRS0eUv+r2/IqHdvUGn0FmmUJY8uZTsi0y9hwqgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=hkF75OLf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EW3rkvSb; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="hkF75OLf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EW3rkvSb"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id D75E91D00128;
	Sun,  9 Aug 2026 16:09:52 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Sun, 09 Aug 2026 16:09:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1786306192;
	 x=1786392592; bh=M3FliLxcIiFaQCQMmzQ7/NuGEYeA79nZeJuEHNnHv+w=; b=
	hkF75OLfU+UiZWn21H9LjHWICsU1kvou1H3YLwYznyp49iHl4UORUFKw3zRVQMQD
	meQXw9wfs+zZjdEs9+YjQ0Zit63mO3J8tUR1T6lFhpzKyP6o9j14bIz20VncXmV9
	8nWoJgpyS8ldvK8DHw4jHtNBiNxWvClbkV2Z0Qbptgz1SQbWL5JEt/KBOKZ9TrFK
	XkCmaDY+6SlmiFH0XxYzWh7OSvno/L64/9TwaaQw3n6GNlkdNWAJe1/JZ2O7jjVb
	oXR2HtqPrP5VBZcHdNWEM1iBUxr4RXRarPFzZuQpum7uodGlS73Fgzw4laBfsOEu
	eTVLn1p0bR4k71nFUDqU6Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786306192; x=
	1786392592; bh=M3FliLxcIiFaQCQMmzQ7/NuGEYeA79nZeJuEHNnHv+w=; b=E
	W3rkvSbL2DN62TcL0UDhLbh3H0JCez9OtOTNtjf91ZT3OYplnpBDEC/R/dcG6h2Q
	X1BXcTvEbUTqOm+DZysg1S3M56ga1pjRuoT3xhtBk0Z4zJuC4ihIuJznx0PpyUvH
	t1i5ThcCte5ly2JNxootJp+ThHz4Ste/vM40+sWjVmmyEBVok/PALrBdTcjqogNU
	CepR8Pfm/XhTjk2iNnpnAApuuaIORZfDWz+0tjD7zpSxXbjLRF9V3s64UXSNDxNn
	/yphEZLw/eWZeTl262gyRjs0GM44AbL1eM05Lw+8PDUjdIVH7TjXF9W+sfh6XZrt
	keS1YGBzjaJKSHENh6ECg==
X-ME-Sender: <xms:kN54avJ2-AE2kKndSRZmVvuw6xl-i8gwzNoZruAVOUaP_YvsaVwdc9U>
    <xme:kN54alvxc8dGX7EF6Gt7MApQ4wGQll3vIT3v-KaVfn_EWBtCpcwTx60IOJleMLwkA
    Pn1x3QOKy84aa7xSqyk9dHslTg9dUtVHeSAOGsdw8Ve3jJ2jE1o1g0>
X-ME-Received: <xmr:kN54arVaNwhRTh25uByrRzXXlKQHijCc3jBKEnn2VoB6Aj8HzTkfBoVJbGqqkU2AjhapLplSZN4lYoD88eNvUVYMYWKd7HL67vzkjTII9jgYDoue3w147WA>
X-ME-Proxy-Cause: dmFkZTFYpW11HwjhE/ELhIAn3xyag768DLpRbdbKwLUZljyM6zSmZyLMo/EQnZq4bjpg2l
    ZivuapzoFoxxHSn92aDoaJXbke0qlSpZR8N4cMetpIsTO+1jL+j9SUKUdHDy/d5q75kX+M
    diHKgcntiaboyb4GCkiueekV2dAmZa6VSSdZl4sqBRT7HRyPeUL46B1uTJoJaMJRcrnf7U
    di+tp7/wrOX7PEk7AmJn0jWDbY8t4uvWebKWC3wUvtchBYyzIYUCjEl0EMTWYWEBMaFcjP
    qLrbwBGJWAUBKD8k/C+r9lZNN48OhUnE7siVElLLCm4E9w3w2VPlTP21HgzY1cRukEUCQr
    0rLfZfz10UlmGfWQ4PyZIUgupslyj9RLD0h4Qc7QJFiiaWdqAFucEtkxmg9fkxlMisVjKA
    MJPjQIRyHViSqlzr1CSuQl81Z8jiFBKPs6XflU2oShdZrTNbpLlxIrlukrtpNY6v8gchKD
    AXIF30oDGNtj5q+XszviBpWCBe680kjD0a/CMReiZOgF2d6oNO3t3iE4bZ1IWUaKdYrvQe
    8x72DSAgNjESqwvs/n0kv0hK4SQ5JQMGDvudUgB3fBlJmDRrjbMYV4g2Nfxd7sP7CrXIEu
    3DUA2/T7jyKpSFXcyKjXkpDl3hkFPLq2sOhhMsSImqYHzP+Mn3cItZK9AAIw
X-ME-Proxy: <xmx:kN54aojyeN060R94eV0Hxd-AEgk_hjXNvL-RLeiz-WXx2Dsif-TyRw>
    <xmx:kN54arqjRf3TPiAh2gSrGGElYzpoMcZRbHkAgHQhMHh4AuoveptLYw>
    <xmx:kN54amGI2bRr6MUO0o3xcjtBqtDhjfNQ9Ceu3AqL_Hbgum0TsWj3rw>
    <xmx:kN54ao4zmRENBWfTRuIbP-womRt2zXLK3w5fyus6xuhavZZfTyz8cA>
    <xmx:kN54amFoNIM5TKXpIUT6PkeXUb1EbeGV4KmhRhzsHgWALOC2jt7DTuXV>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 9 Aug 2026 16:09:50 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	christian.couder@gmail.com,
	Brendan Jackman <bhenryj0117@gmail.com>,
	Linus Arver <linus@ucla.edu>,
	"D . Ben Knoble" <ben.knoble@gmail.com>,
	Matt Hunter <m@lfurio.us>,
	Junio C Hamano <gitster@pobox.com>,
	"D. Ben Knoble" <ben.knoble+github@gmail.com>
Subject: [PATCH v5 08/11] doc: interpret-trailers: join new-trailers again
Date: Sun,  9 Aug 2026 22:06:32 +0200
Message-ID: <V5_join_paragraphs.b2e@msgid.xyz>
X-Mailer: git-send-email 2.54.0.22.g9e26862b904
In-Reply-To: <V5_CV_doc_int-tr_key_format.b26@msgid.xyz>
References: <CV_doc_int-tr_key_format.533@msgid.xyz> <V5_CV_doc_int-tr_key_format.b26@msgid.xyz>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

There are three paragraphs that talk about how a new trailer is added.
But the first one is separated from the other two by two paragraphs
about how `key-alias` can make using `--trailer` more convenient. This
short how-to does not follow thematically from the previous paragraph,
and can wait until we have fully described how a new trailer is
added. So let’s move the three paragraphs about the new-trailer topic
together and move the how-to paragraphs after that.

***

Let’s now review the history of the document. Even if the document
is not quite correct in its current state, just doing the apparently
obvious edit without considering the history does not respect the
effort that went into changing the document in the past.

These three paragraphs were originally next to each other, in the first
version of the doc.[1] But extra sentences about this how-to topic was
added to the first paragraph nine years later:[2]

    [...]
    `': '` (one colon followed by one space). For convenience, the
    <token> can be a shortened string key (e.g., "sign") instead of the
    full string which should [...]

And then it was split into it’s own paragraph a little later.[3]

This evolution shows, in my opinion, that this how-to never followed
thematically from the existing topic. Which means that there is nothing
that was potentially lost to time that we need to restore or respect.

† 1: dfd66ddf (Documentation: add documentation for 'git
     interpret-trailers', 2014-10-13)
† 2: eda2c44c (doc: trailer: mention 'key' in DESCRIPTION, 2023-06-15)
† 3: 6ccbc667 (trailer doc: <token> is a <key> or <keyAlias>, not both,
     2023-09-07)

Suggested-by: D. Ben Knoble <ben.knoble+github@gmail.com>
Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---

Notes (series):
    v4:
    • Msg: Fix word-confusion: s/There are three trailers/There are
      three paragraphs.
    
      🔗 https://lore.kernel.org/git/CALnO6CCg4ubVz_VJuFjn7tvXqADR40AdjCFJ6xfRcms9a+GQWA@mail.gmail.com/
    
      I knew that I was going to fix this when I started on
      version 4. But you would not believe how many times I
      went over the commit log without seeing that I had
      neglected to do this part.
    
    ---
    
    v3: [new]
    • Suggested here: https://lore.kernel.org/git/CALnO6CBiRefHNT6tjskCQRUOj5Y--K3okR_RFPmth6O7s1_VKQ@mail.gmail.com/
    • Msg: Now *this* might definitely make for an *overly verbose* cmt msg[1]
    
      🔗 1: https://lore.kernel.org/git/xmqqpl1zsv8s.fsf@gitster.g/

 Documentation/git-interpret-trailers.adoc | 26 +++++++++++------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/Documentation/git-interpret-trailers.adoc b/Documentation/git-interpret-trailers.adoc
index a0f7ed6fdd9..616f479a367 100644
--- a/Documentation/git-interpret-trailers.adoc
+++ b/Documentation/git-interpret-trailers.adoc
@@ -74,19 +74,6 @@ key: value
 This means that the trimmed _<key>_ and _<value>_ will be separated by
 "`:`{nbsp}" (one colon followed by one space).
 
-For convenience, a _<key-alias>_ can be configured to make using `--trailer`
-shorter to type on the command line. This can be configured using the
-`trailer.<key-alias>.key` configuration variable. The _<key-alias>_ must be a prefix
-of the full _<key>_ string, although case sensitivity does not matter. For
-example, if you have
-
-------------------------------------------------
-trailer.sign.key "Signed-off-by: "
-------------------------------------------------
-
-in your configuration, you only need to specify `--trailer="sign: foo"`
-on the command line instead of `--trailer="Signed-off-by: foo"`.
-
 By default the new trailer will appear at the end of all the existing
 trailers. If there is no existing trailer, the new trailer will appear
 at the end of the input. A blank line will be added before the new
@@ -101,6 +88,19 @@ The group must either be at the end of the input or be the last
 non-whitespace lines before a line that starts with `---` (followed by a
 space or the end of the line).
 
+For convenience, a _<key-alias>_ can be configured to make using `--trailer`
+shorter to type on the command line. This can be configured using the
+`trailer.<key-alias>.key` configuration variable. The _<key-alias>_ must be a prefix
+of the full _<key>_ string, although case sensitivity does not matter. For
+example, if you have
+
+------------------------------------------------
+trailer.sign.key "Signed-off-by: "
+------------------------------------------------
+
+in your configuration, you only need to specify `--trailer="sign: foo"`
+on the command line instead of `--trailer="Signed-off-by: foo"`.
+
 When reading trailers, there can be no whitespace before or inside the
 _<key>_, but any number of regular space and tab characters are allowed
 between the _<key>_ and the separator. There can be whitespaces before,
-- 
2.54.0.22.g9e26862b904

