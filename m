Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB1EA35CB7F
	for <git@vger.kernel.org>; Thu,  7 May 2026 19:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778182500; cv=none; b=CdiN3QwpnRO+1LWNTQzYcXozOriY8osy7ojgWqTOQmUckiI6yRjbUQQnttJwmmqJu+YIRMXTm7W+94BQMCUTX1LWQ0E5Vu+22PiUuz5ENONVJrNSxyNxdidRFrTAtfUoKIJ2BdEYv8DI4WJReySNhUzU+J9BLl2XhYVR0oFR6UU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778182500; c=relaxed/simple;
	bh=vSdKdgLF/kpwIQThsr/tX0GbbWG25qfbnmgA4Cp+ZZU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O4jqfaFR+7IJsTFCYv/tPVqYBMzLIEuVGD5WC4wAJlT5xWvr1no7oUlaYGm71BsSGwx0uh6QGzNsV0PphOY6TCw2FMW1k2r9cVCeZzPO2UosmeHem0X3aiMPXC5C38qnh9rgMwUCYM+agD8tvZ85fkeMLdRp5XO5UPm/7BPw3fM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=Lw/bchHl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EDQhzawG; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="Lw/bchHl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EDQhzawG"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 34F5DEC00D8;
	Thu,  7 May 2026 15:34:58 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Thu, 07 May 2026 15:34:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1778182498; x=
	1778268898; bh=pY+H8NwtO+t1ql7YvawMFRtzssRl5Duf8w45sdQE8+g=; b=L
	w/bchHlj+CSTQNXgxU/V/HKnrYfX/mFT6ibmI1pZvhx/7z55MkA940fuOtPgKMat
	E9wwyihsqDMIanpwRzWmQJYMB5glMQNLBfYRGtTGDgEi9mSFttpltyA999m6e9RM
	+1YfPQ9MbdqWQBp4kvrmLh0gfU1RQOSOOcqsOsMCgLcwlXKqWG3CEv34MWHchJuT
	EJCY3jt1gLufvoSjBlHWjTpTNIa84pKsYeO6zQ/tdgwzOYNpXZ3bGUWcLh7Nrc72
	YumoWBzDOrX8/g0RQSkHCSKkxI/mwqiroIDgz3bF1WEgq8RaR4CTfJYaELupraus
	ljpm2Omze81PQkDNJsnGg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1778182498; x=1778268898; bh=p
	Y+H8NwtO+t1ql7YvawMFRtzssRl5Duf8w45sdQE8+g=; b=EDQhzawGICEiQyRj2
	x+bTnHONs6xPPJlekgSBBGBh8m5A6XpAZ1ZmX2wpStvvUWr7vGYM89bNesv/NNeZ
	FGkv83124Qn/mbgCu0ZewwN5dPIqlGACrLemjYxPaTQmecBvTdWeWU4pcrnzJVvn
	kuii5hXyx7OpqnFCFzVDtFkLXMiD8DRDw+gc6E+qCpskm6fs7/KJzO/QLsL+zj6B
	V0vp1H4kEKLjUcm6lmo+5l2NcChljzLszKLwCYAfq90qmqg7y6yhLgvZXeuNE0AH
	HeqtohBkbzVFqBvk90q7a3G34OvjJ9X+F8Ir9u00AjCsLfu7nL3PMa2FW1YSPDS2
	bvq2g==
X-ME-Sender: <xms:Yun8aZmBr3NAbrM3mSBQG-7VR66vonrVnnrNBx7ZKQsIOBLf_X5F3OI>
    <xme:Yun8adz9MRtAnUPD9yhEx8y0WWhrJcDkfU7d9dIOBz9eMiJllJfxhIqh0nhqIjRPa
    LqqauyXNEHkb8bfJ_X982UpzHPmL0rA7k_3wgxz3DGff3zrtwi_eQ>
X-ME-Received: <xmr:Yun8abMGZqNfq9pXIstvhpRkxZquMphLszV6lrf5ihO9WFeRo_0VaYdIHBqg8DMOR7VPNw9ld0NlBPi__W3u2JL2TF3kPwkvbKT-TRw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddutdekfedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnegfrh
    hlucfvnfffucdlfeehmdenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddt
    necuhfhrohhmpehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilh
    drtghomhenucggtffrrghtthgvrhhnpeefheetkeeftdeiffdvjeetueethfeugfetgfdt
    veehhfevffeuffdtheeitdefudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhm
    rghilhdrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtg
    hpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegtohgu
    vgeskhhhrghughhssggrkhhkrdhnrghmvgdprhgtphhtthhopegsvghnrdhknhhosghlvg
    esghhmrghilhdrtghomhdprhgtphhtthhopehphhhilhhlihhprdifohhougesughunhgv
    lhhmrdhorhhgrdhukhdprhgtphhtthhopehrrghmshgrhiesrhgrmhhsrgihjhhonhgvsh
    drphhluhhsrdgtohhm
X-ME-Proxy: <xmx:Yun8aZrt6po5nKdbO0r7jVty6k5blXnYUaz7Y6lVLMd25n09iR1I0Q>
    <xmx:Yun8aUHhOuYD6Ygo8FQIN9ewW4bzARjT3ckPPvcRH7hamXzmjcybAg>
    <xmx:Yun8aWq-S9ekfXIx2oOYf_Zb5cW7NMT6xorTszUD7OMNexD6p9j-FA>
    <xmx:Yun8aVYegZSQFt7jxdOgYgtO8GWXlEjczoTfOMPAjdt-5u6-rhsgUA>
    <xmx:Yun8aVkNXiT2ppx26_Tb8PzZFN1fJlur901_KH44cOz6YkUVw5gP4580>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 7 May 2026 15:34:56 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	ben.knoble@gmail.com,
	Phillip Wood <phillip.wood@dunelm.org.uk>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH v4 1/5] name-rev: wrap both blocks in braces
Date: Thu,  7 May 2026 21:34:20 +0200
Message-ID: <V4_name-rev_braces.6ab@msgid.xyz>
X-Mailer: git-send-email 2.54.0.13.g9c7419e39f8
In-Reply-To: <V4_CV_format-rev.6aa@msgid.xyz>
References: <V3_CV_format-rev.66a@msgid.xyz> <V4_CV_format-rev.6aa@msgid.xyz>
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
2.54.0.13.g9c7419e39f8

