Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE70640D580
	for <git@vger.kernel.org>; Wed, 10 Jun 2026 21:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781126649; cv=none; b=MWZUG9M287gtUTexgHiwMXYtm8cwcB9Ww5CGFmwQrmaCGQ/mQD0+x+ztcZHvIlu6bwN6BbubLgAmKGWiDTocITNKWRMvfNxTcJRCVORKhrJ+7wzygkQaGWamH2CI44qZ4VYyGTEjLj/kJUrb+FF2jfUrdoVICr9FX8MXwliI3cM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781126649; c=relaxed/simple;
	bh=IXlTucbKz3k4sdnHz4KMYGJfj/AO52qKww4CUcf5Ma0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cY+Zpl1QD0tGbZvGPMu3qcjEqCCVJ7vTpPEyUBZHpST5A92F1vPPVZCviR/++b0nSikBbNd3Oj0xS1UpSwZClHyTHdFIdduwLNzAsdQ5FWocOIUHL+3JcPsfQiAxjGYZXUrKvLijsiiVjj8qpATCXWgP6EMHWPPcD0I3/CMDVyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=hAwyuUyG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=P8guvzap; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="hAwyuUyG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="P8guvzap"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 137227A0190;
	Wed, 10 Jun 2026 17:24:07 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Wed, 10 Jun 2026 17:24:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1781126646;
	 x=1781213046; bh=PT5z1Fjjrnu1+4ZqIoY1ZXo2iXnKwYvD8vA45fIibD8=; b=
	hAwyuUyGRwuVed8M2ME/GO5wjcWI/DYmO1hqurShvuegxnQek/NvTobExkcRE0NK
	g25NwHsVeovp9OeEeMQiW+2knhFAOWorQLZ1MTbqvQ8XqT7ppSr70ZC7e2qQOn4F
	jcIbHTHLkxHr0C3J4yhwO/Y2hJEM6l0hbRotuLKZD4lvKardnms5a9ZyuQ9AczQD
	EuOsHB9x3BFZOfpGaM8ZKzqm/DabzLz9NxaeFkphw1DBEuGaeyQ8BEig6AjICc/o
	X49NFT78JX+VfVl9lDdeDfrrX7W6iuZpO5xXGL2lQ+kMiYZ56IZRY1UohxAMdbc+
	JAYOklY5UogO6Fh0eYCyXw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781126646; x=
	1781213046; bh=PT5z1Fjjrnu1+4ZqIoY1ZXo2iXnKwYvD8vA45fIibD8=; b=P
	8guvzaplo2xcAm6N0SlKTjbUfMLtCDw9tf0siNK4qxE4X8SHFYvNTtg/4kmhIWf3
	QnVyEM+2VQ13699s0AQyiAfP/rKwpZ5aOu7mx1LpHT4EwegmRiFiTDwjCl7VPyhm
	Vmjfqw52cQ9/nrNtmk6p51NdOT1TQjUvmLjFeO8eFjLTR9xVCgONE7ATwZNocZ6I
	P/wKm6K/tJH6KI4oAPdlFYImQtXJOz1e2Qgo8H/G82RKw/R0CI/UMSYA9pe2l2Pk
	PQyDkn9t5R5Kknwhhv3YcSr5QeTGbuKS75Mhm4jo882UCpjy6uFPDR5dSFtmuT0Z
	2o9NIuYIdMX0V374AZ6xg==
X-ME-Sender: <xms:9tUpamCBiL1UvS3I7lC78MbTZ_ZCAypJlT3hwn7kDriU4uhjThbrEo4>
    <xme:9tUpaixaqdqrpMCa8cuHnpfBuInqxELYbDTPy5qZFi20rP57xfiVkIdTiZwlVzc5p
    BD1qu0xr49-uI9KtKwWnRpi6K8PV3IFtBxkiX1abqhoJsrKdoop>
X-ME-Received: <xmr:9tUpar3I8nQbrgy1J1STRwtCgtiyvLydXp-TEBrnsXxPASo1Pdc9EWlNjQuefatfHHz6h0M4JulcVtuZVoIb8_C05lAilHlQihExw4AVJnP1Gxn75gn9-6OS_g>
X-ME-Proxy-Cause: dmFkZTEg1vhUucWyl77EAlSHnbS/tG/Xdyuf1fVvwxqRm5N2Kkj0nFdbLoRmSgOau6FJCF
    sOpiaPZWXghfSyLOC3wEFOjSiZQa8L7UGGb6qYVEjrfrm7SIzZv9CVhDa5aBeVCmPW972p
    SXsCZ7O7qqCndN2jJh5AyROUtKx3zScXsDOEbYMuh1olOFJVtOFtHBlsa1/kV2tkVIc1M5
    x2ergAsqdsLTlH7PbZeEu0x/llSIt3+39ky9rfErTf8+HVWrRUJOCLZFS3vHrWk+5dKTL2
    dgPKqHMqudwxzHU0py44J0G4KrU8jBF4qzAXyE8dDppggCQh6/RPJNxlFndEDMyG0v5mTh
    iGLeAVMsxTRWBHTQkFtQc7JxeFcvR7eUbXG3OdHnLqBFcGdFO+2tv96nfYgkCL5qZuqHck
    pufN6+mazrwNMIp/4/TQ5E7lHYN5M7CYBB6EjtUannFtPE/vu3ZA9nG300xG1G9zap3x21
    G1BL/0FqIycS7mlbPEzWV8IA7HkiNBrRU+R12ZxJjYipqxXRCzjGk8B/Pf3ACoCt3pNoFc
    9YD9puAFolKmb43DtC7GdzJGHhlueIow90d2cAQC9Q2rKiAmU1BWk1P5aTPich5d+RLYIK
    DuyqS8T1BL4fIuodiErJPHpRonexZR76EsgKXGy0F9E4p+FLt12y3S6ZfWGQ
X-ME-Proxy: <xmx:9tUpaqy0pG5xxUW0KjSUHxhLIeCgIUfiKwA2rOK6dZoHEWSvvbWTqQ>
    <xmx:9tUpaqFJuBTYa2n8NQYqAu_F4rMvHJqcMbLus8t0qa1PXGC6InoE9A>
    <xmx:9tUpalZfVzXLclawiVuLEcOmbBTQre8XDHb5itH0y8nCskx9SIa7mw>
    <xmx:9tUpakA3_SDR8T3mQztSCX83RyfneM-BsMy2VBi8rrHZaGwg8m8u6A>
    <xmx:9tUpaudEbXn-zaJwVxQOefHsVn_vQvokI6-599gTwBGxc1CNG6TTkK5A>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 10 Jun 2026 17:24:04 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	christian.couder@gmail.com,
	jackmanb@google.com,
	Linus Arver <linus@ucla.edu>,
	"D . Ben Knoble" <ben.knoble@gmail.com>,
	"D. Ben Knoble" <ben.knoble+github@gmail.com>
Subject: [PATCH v3 08/11] doc: interpret-trailers: join new-trailers again
Date: Wed, 10 Jun 2026 23:21:26 +0200
Message-ID: <V3_join_paragraphs.8ab@msgid.xyz>
X-Mailer: git-send-email 2.54.0.22.g9e26862b904
In-Reply-To: <V3_CV_doc_int-tr_key_format.8a3@msgid.xyz>
References: <CV_doc_int-tr_key_format.533@msgid.xyz> <V3_CV_doc_int-tr_key_format.8a3@msgid.xyz>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

There are three trailers that talk about how a new trailer is added.
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
    v3: [new]
    • Suggested here: https://lore.kernel.org/git/CALnO6CBiRefHNT6tjskCQRUOj5Y--K3okR_RFPmth6O7s1_VKQ@mail.gmail.com/
    • Msg: Now *this* might definitely make for an *overly verbose* cmt msg[1]
    
      🔗 1: https://lore.kernel.org/git/xmqqpl1zsv8s.fsf@gitster.g/

 Documentation/git-interpret-trailers.adoc | 26 +++++++++++------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/Documentation/git-interpret-trailers.adoc b/Documentation/git-interpret-trailers.adoc
index f215cba4bf0..759cdb6e18e 100644
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

