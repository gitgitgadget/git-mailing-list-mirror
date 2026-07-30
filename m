Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A844F3F0A81
	for <git@vger.kernel.org>; Thu, 30 Jul 2026 09:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785403279; cv=none; b=prQr2v0c69kihXeMTQyCelYPmfyZOnb4WvHU3FBer0OFaaP+agaDTWTr6D7um3s2NbVPbyRBUW6iyGnlU0KORDhtSVTxSjXP2pmVj5BhaK+OnxgeiaDth/5xPvUEDjGtHlE3aHz7TSw8J+FUdGP8DZNmx9QjIlGyQpKvcp4BBCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785403279; c=relaxed/simple;
	bh=lJAiJnX/QZWF9DGc14FSYJUxkq4oFshbX64WXY6Ezww=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z9yNcXf3daJUn58FU7J3T34Ih++331+3uCIMTboE8/lTlChfsgd0ppQaW9i20WndMjabx24A0RRYw+b+h/fxJZdk//0Br4QmjK+QySDYorvreSBxQIXZPyomqgCjPNjf7GiLb/MgWW/gjE3YNO3Q6Hi8iU5uZoB0LhDMFJZu4RM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=leNy/gn0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SfesWzZx; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="leNy/gn0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SfesWzZx"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id D14501D00116;
	Thu, 30 Jul 2026 05:21:16 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Thu, 30 Jul 2026 05:21:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1785403276;
	 x=1785489676; bh=M3FliLxcIiFaQCQMmzQ7/NuGEYeA79nZeJuEHNnHv+w=; b=
	leNy/gn0On1ebWyaaTgDaQvWOhLADhunQBXyE92t3ieW4kLzW+O7+3KGCPKL6Kr5
	P/VVuR0/Zj8+5U6x3/G4kUmsjI76gZpJaBw5OUQEmMMjLNLxiQ5cdHni1baVsFfd
	DBql98XcIMJGkMPAUcz5cOLDiBAL7uC/ApVduh+LjnvikvO30sBO2WnXfNUk+qPd
	XV47AIyZpgdwGl2Om+NXi69bUVwzGGlB4v4OmQy3a0iOrjGhaObWMRCRMjIno3NK
	Zy5onDodAn5cCnJ61YMSKY4sTpGcRu7S/Z2ESmvvYa0U4GSKID2Ogvcz4g2Nggs8
	YZhTk5OA4q4dlNv+SomZMw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1785403276; x=
	1785489676; bh=M3FliLxcIiFaQCQMmzQ7/NuGEYeA79nZeJuEHNnHv+w=; b=S
	fesWzZxe5DSO3dubVOmH88lRziV34yc3+LsNLg9Jj9qcX2KWbAtdpVXKF2ANLGkb
	ibRGg2jZzOjj5Lkuu+g1DWWhQIZX2xMOpVok9sEUr3wGkAT5iJLF9uOBFM0wqsgo
	FNylL9yhQ7E98c+ICtlLEN9S5iyl2NOaF2n2U3AEL89Zzlsehjjo8xeoterSXHfA
	Po0zooo7igdzhZCTcSLnJaPCDbdefkeA2XN1ALw9LFDVshUQHz3UtBtI5FuKQTm8
	0xJsBZg2QLH+Jvse4JB5zYtnw3SSmi/C6nKRH5USFU6KhD0zJaj2ndHLhuLsYhps
	/qkBrlanKsti9UWoFFWNQ==
X-ME-Sender: <xms:jBdravG_I24giw1EYmbjxVVJJU8NmYO2BiqstbU8AGteuBC3EFBqG6E>
    <xme:jBdrau4fiyYAZVk16kIFP1Rl_m7GrspCGfXK1ulTGwHn4ZVDD-MDV5p88h8IAvri2
    FJ_oaIZsBBN-trLR8HrxZj1AK-MFJy9MVUDlAdHMQT7Z-K5FhSw2hE>
X-ME-Received: <xmr:jBdrakxBcsIPYdvAayKn_xxTUNxP2TD8x60oXWsUDuGNVtFNAFvolSqgHfYvLA6fh-O-2IeXLERt1fm4LmBxVfdKdDaWdce80cMFfmItqnWrvLJcwR_38Ww>
X-ME-Proxy-Cause: dmFkZTF06kFJsvSoIsw6Qv9/dT/tfjEOIlcxpE8uYTczI0dNDwFY9/nANZVwEhIcWJmMqb
    sMgf2s99Hj209RT4CH21EZeqAVLXaGeCRTR4rQsUbohKNlBTx4pFhopSbZ+4aRhCmg/Ug/
    xNPksHODrXduWavc2fOuuQ0S1IyaKHSezzs/nDcYAC7m+VUg0pFnikfM7wjWjgcMtON9yL
    iLzb47nlUViVqCAJ/X70/tV1zH+Q+/dh2A/xl8j3pTFhEgTJZ81vLC+nBirRf/fLH01IBK
    nHOKEAL24IvlSZT+UbKCDXDuvq2Zsv/gzgJFXwXU048ShMZJYesjyb/0ZSC+8GYnaRy0Bf
    d2u+xsWwwxoGifgWr47vFBfXpoTSZPpbXhfGZGrqdi9kNkGmkMe9f5lUGIl+th7wromHhO
    G+/MubH4bVYj8W1R4HVcbmrH1J00DGRJ8NAwpq9ckqXdco+d6hP59GyjKpftCdiKvbgx8r
    6BCIfmLwFWceZAkjn1zj4uXMiv9XbEVM6yA4IRnaNp5nzywZzRE4ySEICMRTkq/WtHL+/9
    qYSiEPVc1RHQJXsMLuejH/VWntmpQ1pdFK04caecVMJJft7qTExfEmze8z9rf/ABwbS7mb
    dzE0cVLouOw5Lf1icwsoe+ZD/ld2j1bZZegaR3FBdDTVENKgFJP/ZhSJ4zRA
X-ME-Proxy: <xmx:jBdratPK7Jj-2yFTa-Bn2C_r7mWZAMHN3PW0DLyz8WXiEBUqkjD8TA>
    <xmx:jBdraqkdEFEPnGvVqzZOxf0hubjDzfxzh4hSQB5Yy-Igi1Rw2cnPZg>
    <xmx:jBdraiQt8PXLVIL65TnRfgxR4JHdJU1C7uT6lu2PYFRtX1TMrlhV5A>
    <xmx:jBdrapWMCB5yM-Q9OHLFYhc4vyTmJ_GaAVVwiSi2P-tQDcKf83gYKw>
    <xmx:jBdraiyFJ9QL4NS7HaOqJ9R2Azi2Cytc7N316rLz5_cUry-FUmlWjikr>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 Jul 2026 05:21:15 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	christian.couder@gmail.com,
	jackmanb@google.com,
	Linus Arver <linus@ucla.edu>,
	"D . Ben Knoble" <ben.knoble@gmail.com>,
	Matt Hunter <m@lfurio.us>,
	Junio C Hamano <gitster@pobox.com>,
	"D. Ben Knoble" <ben.knoble+github@gmail.com>
Subject: [PATCH v4 08/11] doc: interpret-trailers: join new-trailers again
Date: Thu, 30 Jul 2026 11:18:21 +0200
Message-ID: <V4_join_paragraphs.aea@msgid.xyz>
X-Mailer: git-send-email 2.54.0.22.g9e26862b904
In-Reply-To: <V4_CV_doc_int-tr_key_format.ae2@msgid.xyz>
References: <CV_doc_int-tr_key_format.533@msgid.xyz> <V4_CV_doc_int-tr_key_format.ae2@msgid.xyz>
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

