Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1788D3A4F35
	for <git@vger.kernel.org>; Fri, 20 Mar 2026 13:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774012223; cv=none; b=VZVA/8BB3c+1rmWh6lMU0+tTG3raPyZ6xuTtlEvZSM2RDblfjyKyS14638Et9U4ufzXxpl9oZlj+s4CocjWyK9Cdn95Ei3u2Wp7fJn+abpjcIw1NEHoVwp5CcAJuf0pWCmOM4RqbucXHH7K0hpJXSoR+F7wI1TDS4u7uM+Xs9j0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774012223; c=relaxed/simple;
	bh=tOOtNE0bEU0YaBa9a7FYEzS2RBsW3zgZNJXjGpJ81RU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GnmgVDCLdRy4HBS1P/J+4xUJjDher/4E+h/tnAHuF4h1Dftzoi6jS4/GWe8WKN+nsP3C9j4Yyw8LVxzoprWJS9g7hNZyQ3nNNdwsWq+BN7yglX/U4f8170CLRnvAHEnJ5kzCDon5+7j07eo6yi2zxwSNdSwbxTTwWh0Fh4KUDR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=Fu2DJds9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mWDd+W43; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="Fu2DJds9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mWDd+W43"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 36F2EEC0195;
	Fri, 20 Mar 2026 09:10:21 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Fri, 20 Mar 2026 09:10:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1774012221; x=
	1774098621; bh=l/DZCcvfOqMBWGvoRkbrMzSlpTAKYleFhpUwq4DtmoY=; b=F
	u2DJds9waZvHJ3gLh2DsFPUEP8Ev2CBsriLsNoOhb7XA5nAIXb75xlngoJTwmsyL
	gxOgu1+5gh8rNpfTMrIHQTnTV4DvUNmJC4U5s13XiWGyLruvXAFsatpO2Cot/s1R
	wYxK7N9Gz7VYBXs7xnG5EfcS+o9dmVCCFbR4PxmWdAsPW7JeTPySZ5Jyf7gA+w4n
	e8ulQnZP6io8GgTiFMg86sqwKiG8U0HDZUh82ojxbIzXiht158WDt40n/4GA8x5+
	y0ow1jQDuY8EVrOeTGNyWBn5x5t4TzS0EK3732LdyuLGPk4nKQEZEL6aYERRDdP3
	ELeZjj3d9AD85eSq+/P3g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1774012221; x=1774098621; bh=l
	/DZCcvfOqMBWGvoRkbrMzSlpTAKYleFhpUwq4DtmoY=; b=mWDd+W43g0qDd1WW0
	1MOiEvcxzgI0ImxOIoyF2PTX2DiCEtANYAa+Z59sjbge3zYXg31I7LAlXGopwRmU
	B3xbHR8oz2PZxlZjIq8vPzdIXJtsZIaKHgspwCTzDeucspCY8+Vd5EYTYdTZiNkV
	GBqIytipGQcrn7Ae2uB4JMxqzdRWQkXQqFPhOIb4MUNytZboUhVkZBgiy0Dk5GkD
	tVs9RryJsUmHHlUsKLFt7gVgfjSBzqMC+IC0tL5/8rZNRwibHtMa2ek4CTJwFIRi
	BDTJNJKE9yYttq/4RvKfWsHteMK1f68FJOXkuBtbpUYHQu1cj36PrjNQtPXsbHG8
	4+3TA==
X-ME-Sender: <xms:PUe9ab9rQssJQdRUgRw-HDT3DyV0GAFKhXaV04_L1xsMfLnP5dAWLf0>
    <xme:PUe9adsZvQZzRfQ0a2hpPOQbBBVa_cLqh6e1elGUZrnoNHaApIDk7Lxs4E8LXrAg8
    idvD6wpJ4qyaElKa-1sfkxnqTB-ja3lomShmUz9_gA2i8I3qhCN1g>
X-ME-Received: <xmr:PUe9aWq667eb57huMjUfhkO5RueUi6XBkc3lCOpsSGyPoUrMsvIKBV5WkTmkQy_hzYj-oABtWfzyPYlRsfj_MU1Gv5ldn0aBnmjJbzA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftdelleekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdlfeehmdenucfjughrpefhvfevuf
    ffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpehkrhhishhtohhffhgvrhhhrghu
    ghhssggrkhhksehfrghsthhmrghilhdrtghomhenucggtffrrghtthgvrhhnpeefheetke
    eftdeiffdvjeetueethfeugfetgfdtveehhfevffeuffdtheeitdefudenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkrhhishhtohhffhgvrh
    hhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdpnhgspghrtghpthhtohepvddp
    mhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlh
    drohhrghdprhgtphhtthhopegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvg
X-ME-Proxy: <xmx:PUe9aSnkawYLmFwol9Th37uYaTcSoALwf9_nyoXwtTPMw5y2NshqFA>
    <xmx:PUe9aSx5f3ikPZtA4uy0Is_xFCo6HEO6dxOKqaN2puhUi2XeH_5tVQ>
    <xmx:PUe9aSkLTE8t5cGZLs76TJv16vM6sxCtsmTjeWyBH2g7jq5Fn2SJVw>
    <xmx:PUe9aTdJyMjww1IzMAu5OLq9ugDXOG1pU6Jg7MoyOWd7kTYlWjG9Cg>
    <xmx:PUe9aXVFC7nw4kDI5lfglNIk56AHm1rajBa5nE0-9ccqptHirCijgJW->
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Mar 2026 09:10:20 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>
Subject: [PATCH v2 1/2] name-rev: wrap both blocks in braces
Date: Fri, 20 Mar 2026 14:09:34 +0100
Message-ID: <V2_name-rev_braces.51c@msgid.xyz>
X-Mailer: git-send-email 2.53.0.32.gf6228eaf9cc
In-Reply-To: <V2_CV_name-rev_--format.51b@msgid.xyz>
References: <CV_name-rev_--format.4ad@msgid.xyz> <V2_CV_name-rev_--format.51b@msgid.xyz>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

See `CodingGuidelines`:

    - When there are multiple arms to a conditional and some of them
      require braces, enclose even a single line block in braces for
      consistency. [...]

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---

Notes (series):
    v2:
    Fix stray formatting of `(p+1)`

 builtin/name-rev.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/builtin/name-rev.c b/builtin/name-rev.c
index 6188cf98ce0..171e7bd0e98 100644
--- a/builtin/name-rev.c
+++ b/builtin/name-rev.c
@@ -466,9 +466,9 @@ static const char *get_rev_name(const struct object *o, struct strbuf *buf)
 	if (!n)
 		return NULL;
 
-	if (!n->generation)
+	if (!n->generation) {
 		return n->tip_name;
-	else {
+	} else {
 		strbuf_reset(buf);
 		strbuf_addstr(buf, n->tip_name);
 		strbuf_strip_suffix(buf, "^0");
@@ -516,9 +516,9 @@ static void name_rev_line(char *p, struct name_ref_data *data)
 
 	for (p_start = p; *p; p++) {
 #define ishex(x) (isdigit((x)) || ((x) >= 'a' && (x) <= 'f'))
-		if (!ishex(*p))
+		if (!ishex(*p)) {
 			counter = 0;
-		else if (++counter == hexsz &&
+		} else if (++counter == hexsz &&
 			 !ishex(*(p+1))) {
 			struct object_id oid;
 			const char *name = NULL;
-- 
2.53.0.32.gf6228eaf9cc

