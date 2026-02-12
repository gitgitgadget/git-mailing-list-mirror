Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A7432673B7
	for <git@vger.kernel.org>; Thu, 12 Feb 2026 07:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770879615; cv=none; b=lIy+auoalvtj3f3P/aJk0e32RZs4GJ/tQEvB1uz22XxIlcdnrhWgl7IP2Wc+4G/6Hd5+sWTL1oCedHhWmezv1TH+8WPL4sxkKU7+JhVTapzFkymVcF0cd9sAcuf7SIOlKZSbRAWcOI5AjRCtBoSab6O8/sSA56bxl007jx+TOQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770879615; c=relaxed/simple;
	bh=wzNmTjjJauhidK1KGQoanRkUoYepNcLV/Oy97iEfdGY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Fj1QROjd5QhUmGVAJUDPSMet68Qd17Eyu8J0yhtrik0NsvLl77gUhYGVXRvJWRW5toDYtY/7IgqPy1tfwfGnyA8Op4DdHS/DJcJdDvsrLodGINQ2LRyMh+qDEsH+2hEFeI5fKrSLNydqSKxc2lodtotBe+diAYlF+bhzYi7Yp1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Tml+Opnw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qaHrHk5A; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Tml+Opnw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qaHrHk5A"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id A90FEEC05C5
	for <git@vger.kernel.org>; Thu, 12 Feb 2026 02:00:03 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Thu, 12 Feb 2026 02:00:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1770879603;
	 x=1770966003; bh=2+IEx2g/oP6PwH1e500VvXrDG5UsjSKmpBeWMTXJ4Is=; b=
	Tml+OpnwfLiFmzrYFKC+F1dYIjTXmh2kEmYLLl9d8Huo1gwVqbzlm/Ed9TDQYvQ0
	WxhOpl8o/w5GEVXczv4mQFrNzNRS8bBWeoP7/c18fd8C9tcpjeKbDDZ6snNxH3jJ
	00uTLVxvTV7bZCasJa+ekXnYZeDDk5lXfmUs4RYINKCaRG8OqauCEBOC4T/OnhNQ
	ky7sZLHPrwWzM0qJrPC5hGh+UezDI2dN/WPbMADqbd4eERRT1Kx9MziaezGmfL4A
	UkdECK27grW0v4+86PjJKWb+jiNcAuny7gw8Uwso61KGo4pj7kb2KGibBdMclKki
	G8omec2ZfGA1kGR4HdlInA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1770879603; x=
	1770966003; bh=2+IEx2g/oP6PwH1e500VvXrDG5UsjSKmpBeWMTXJ4Is=; b=q
	aHrHk5ATSbFwoMhbIU9yne2Qs3sBzE4/hkYhwNAcivvGrb+cswY9dokdqteWLQUe
	CO0V986KNI5+ANS4cj8y4dvm2fccjRy48L+kUFSPZKl+jNBItDo16OJGRgzzvK3z
	7gOo22OnysBXNGnI15K9XeZE5qUPNP8z7jgPUqP9Ks3aJYCi9qo3poKkojCecQQr
	/A4VNi9aliyoIlW1fEckgZ06OYqY2WflCJM4rNc3Fu3TZ6jz1d9JIAqddsxFGsZ3
	vYeQAfEjZiBu0Vm9KaNEkSFqYF3ltyeGLteih9Wl9+vteVooRqMgTJWnfWWeLfu0
	zgLlscaFUiXrcU4w89H9A==
X-ME-Sender: <xms:c3qNaWdxrIYCCPlLIXkZh-_FQcSs-J6saMkxaz9s7HEJXohHPKi41g>
    <xme:c3qNaXLn4sguWB1H7MF2DJVKOalBUhrZ6DhtAwHfBbNpYtXyDWvW0FDU_r6KVfjkA
    DQ1ebM68oFjyIz4fIiskyWq3XEbLZzIt4b9jkvebQJ3Zi9L9IYb>
X-ME-Received: <xmr:c3qNadJixxl0UrkueB1STUxQJCT4dnaW8cTPq7VWGSt9yUvUNW8x9YavBHfWmx_ibdW_i43yn9gbdKbF-Hm8qySGsMS91H5suA4y0HTQZMQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvtdegjeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejre
    dtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeule
    etkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrgh
X-ME-Proxy: <xmx:c3qNaZFAu7rlcLOEe9E8OCQE-lrRTGFoYOQj4t5WwkgvC8WPQ_T0Tg>
    <xmx:c3qNaSm5jaI_7UET0stckZB2J2AX822nzLSp1fqtKzWwaQgRr93KYw>
    <xmx:c3qNaWKZKYxRjrtPI-FoovYGrmT4oo9nc5hdTtKFB5fDPQsxhaaeKg>
    <xmx:c3qNaTZk236BmikEBNWY3MFOGy1hrxGauSIljUMsnm4jHZTWGwcyqw>
    <xmx:c3qNaUPWtOMPG7fnTej0D1_IWXarq1KToaC-ceFwp3HqGpxgN4IBsPqz>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Thu, 12 Feb 2026 02:00:01 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id ce62c75d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Thu, 12 Feb 2026 07:00:01 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 12 Feb 2026 07:59:41 +0100
Subject: [PATCH v2 5/5] odb: convert `odb_has_object()` flags into an enum
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260212-b4-pks-read-object-info-flags-v2-5-3bfa9bb149ef@pks.im>
References: <20260212-b4-pks-read-object-info-flags-v2-0-3bfa9bb149ef@pks.im>
In-Reply-To: <20260212-b4-pks-read-object-info-flags-v2-0-3bfa9bb149ef@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.3

Following the reason in the preceding commit, convert the
`odb_has_object()` flags into an enum.

With this change, we would have catched the misuse of `odb_has_object()`
that was fixed in a preceding commit as the compiler would have
generated a warning:

  ../builtin/backfill.c:71:9: error: implicit conversion from enumeration type 'enum odb_object_info_flag' to different enumeration type 'enum odb_has_object_flag' [-Werror,-Wenum-conversion]
     70 |                 if (!odb_has_object(ctx->repo->objects, &list->oid[i],
        |                      ~~~~~~~~~~~~~~
     71 |                                     OBJECT_INFO_FOR_PREFETCH))
        |                                     ^~~~~~~~~~~~~~~~~~~~~~~~
  1 error generated.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 odb.c | 2 +-
 odb.h | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/odb.c b/odb.c
index d437aa8b06..2bbbfb344a 100644
--- a/odb.c
+++ b/odb.c
@@ -964,7 +964,7 @@ void *odb_read_object_peeled(struct object_database *odb,
 }
 
 int odb_has_object(struct object_database *odb, const struct object_id *oid,
-	       unsigned flags)
+		   enum has_object_flags flags)
 {
 	unsigned object_info_flags = 0;
 
diff --git a/odb.h b/odb.h
index e94cdc3665..f7368827ac 100644
--- a/odb.h
+++ b/odb.h
@@ -395,7 +395,7 @@ int odb_read_object_info(struct object_database *odb,
 			 const struct object_id *oid,
 			 unsigned long *sizep);
 
-enum {
+enum has_object_flags {
 	/* Retry packed storage after checking packed and loose storage */
 	HAS_OBJECT_RECHECK_PACKED = (1 << 0),
 	/* Allow fetching the object in case the repository has a promisor remote. */
@@ -408,7 +408,7 @@ enum {
  */
 int odb_has_object(struct object_database *odb,
 		   const struct object_id *oid,
-		   unsigned flags);
+		   enum has_object_flags flags);
 
 int odb_freshen_object(struct object_database *odb,
 		       const struct object_id *oid);

-- 
2.53.0.295.g64333814d3.dirty

