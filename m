Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 217BA3191A7
	for <git@vger.kernel.org>; Mon,  3 Nov 2025 16:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762188245; cv=none; b=NTVlF2Ga6/q/WlMPhfqzhCGyV8fXbPK+tltyVenijS+Y9FdQh8/neEcD4ZCP1Z60l+vx1H5gAubu9VZ0iHRg6qjbObZwBsVMSE/jASAmRGNnSJ0EDcI9Uhbv0hY+k6ZClXkHc9fsd6Oh9M7i/JsGpek50ABnbyriIhFt/Y4JeoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762188245; c=relaxed/simple;
	bh=o3hxOZyZnVB7xNNutW9qye+ZUfOv0pDMCRXv5zv8LZU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ETV2UFv+JktjhcU4EXQnJisy9TOBuxuIz1MfDrOF9k0YFMP3CG2Yp1hPzO7y51P8IUKhDnX4IVyyzBeyuk2NV3WM5i/8qfEV0q/hjTc7dGnR87qZrscXNxxzpS806AO+SxuSA2wD6ytLhXR425le+wmJvltUSyc8gExe0CXqCFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=LhsjY0t/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SC88UHaP; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="LhsjY0t/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SC88UHaP"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 2F0AF7A02F5;
	Mon,  3 Nov 2025 11:44:02 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Mon, 03 Nov 2025 11:44:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1762188242; x=1762274642; bh=2+zDOp0Skt
	9aUqT8Vsnh+6Kp2y6ji//P5pBDVHanv2A=; b=LhsjY0t/bEYedYOwE4E0rQmKNe
	aHMwxmpn36BUGCLdIfaHlzBW9Ev0122iaNw5f3eIuzLBNyfjxG5cdpUs/UhhRyr5
	akY1EYjO84L7ASUWYfr9drI3WRITHEknjeo/2RcOK7XG/ddh9cbBlLluZS7li9Sh
	upxeu5Wqrbj92k60ypPMnHgg/FMdI/ubJf0dW6S2+kH/8QHac8QSNZauCHMAUsaa
	HM7X4OCbU2XwQfFksEGfgrsg76FCLcRfoiEb2weAxFwGzaNbx4s56vRsSU+Z4sY8
	oXVYeZdxdFvw1tF4qv0fE0UKyzPm8bE/DRQ2Qk5Rg2wFPiVNj69NvPxfO3Wg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1762188242; x=1762274642; bh=2+zDOp0Skt9aUqT8Vsnh+6Kp2y6ji//P5pB
	DVHanv2A=; b=SC88UHaPRXt2GhneZ3EuvpxqfPUetudzeuHyz/RO+peYVjqHdbV
	amzIBfRWishQvD+MeOcYERvB/RLK3xsx55HpacKKndSbki3HKG3Cenowp0vYD7eN
	s4btMKHpAMG9n2gL8C4U4bGb60WyvxPYaVVxCEScambJfWw+HW716apm1WhGatmN
	Wgpyf+g1tnA89FOjs0A9FOtDyunn01PClcCI1yMX900IDWmTWKxzukUIhDASqsPK
	/LUV3v/4sZZeLaUWl5R4lYr0z/Fr2zmmdfqsoo0dg78F6DMD30zI1EehUWj9dtEg
	wY+Ftg456iyGLVgf9auJC6NJxPfLmHZeu+w==
X-ME-Sender: <xms:0dsIaXhoD4c0OvuyjOqtC2ia7Ob2iMw3cwqvGRbQgw5ZyBnTTA_7sA>
    <xme:0dsIaTFGdEaHCEsvxfdceqjt8jrEhgyZRRW1CA66F7D-4UDvnasYcqyyQBWOTIc3m
    fAFKuxXdIp2Vcsons5OrDm7gVPuAJi_pocK4VoNOQSb7WXIWprv>
X-ME-Received: <xmr:0dsIadSmSj3MUF-d2XPVfqfnB9UEUY8dkneB8rpRVPyRPW225RF1I4uhp1tM7JeCBNeyykMnINaPp7ss3uuGQ-HByYpY8SQALADn>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddujeekieehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnheptedttdevffeuieeilefffedtiefgfeekveetveevuedtlefhtddugfeltdej
    ledunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhnsggprhgtphhtthhopeekpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehtoh
    honhesihhothgtlhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghl
    rdhorhhgpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprh
    gtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopehmvges
    thhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepsggvnhdrkhhnohgslhgvsehgmhgrih
    hlrdgtohhmpdhrtghpthhtohepshhtohhlvggvsehgmhgrihhlrdgtohhmpdhrtghpthht
    ohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:0dsIaQyeBEM1nPjmaiqPd_Wqat4AIFKG4_L2diSPQmtPa5NwMGml5g>
    <xmx:0dsIaZehRPJv4zmFhYoyZye5Iivj3bkiebtXwqkcXLuhPXgqC6c-Xg>
    <xmx:0dsIaTN1Uprk4xIc4wyvC6ZitQziGkq8fEUA_XJEdWSTRwLFIEUU4A>
    <xmx:0dsIaUsJL5K-CJ2B2Szl7PvH4cVbz-y59cwQyex2KgDPn3YuVBGqBg>
    <xmx:0tsIaVCgz36LJd4yin01puIfrtpIsntMx5CkVA7Sz-qXy6q_yktoj5e0>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Nov 2025 11:44:01 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org,  Karthik Nayak <karthik.188@gmail.com>,  Justin
 Tobler <jltobler@gmail.com>,  Taylor Blau <me@ttaylorr.com>,  "D. Ben
 Knoble" <ben.knoble@gmail.com>,  Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v4] last-modified: implement faster algorithm
In-Reply-To: <20251103154726.26592-1-toon@iotcl.com> (Toon Claes's message of
	"Mon, 3 Nov 2025 16:47:26 +0100")
References: <20251023-b4-toon-last-modified-faster-v3-1-40a4ddbbadec@iotcl.com>
	<20251103154726.26592-1-toon@iotcl.com>
Date: Mon, 03 Nov 2025 08:44:00 -0800
Message-ID: <xmqq7bw7ukvj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Toon Claes <toon@iotcl.com> writes:

> Changes in v4:
> - Use CALLOC_ARRAY() instead of xcalloc() as identified by Junio using
>   'make coccicheck'.
> - Small formatting changes.
> - Link to v3: https://lore.kernel.org/all/20251023-b4-toon-last-modified-faster-v3-1-40a4ddbbadec@iotcl.com

Sorry, but this came way after I started today's integration cycle,
which included merging the fixed-up version to 'next'.  I saw some
"let's drop {} around the body of if/for with a single statement"
changes but each of these single statements was not a simple
statement but an if-statement, and personally I feel that it is
clearer to enclose them in {} (in other words, once the code is
written in that way, it is not worth the patch noise to go and fix
them).  The only regrettable thing without v4 is the double space
between ") {" in the second hunk below X-<, but perhaps it is minor
enough to leave it to the next person who touches the vicinity of
this code ;-).  If you feel strongly about them, please send in an
incremental updates, but as I said, I do not think it is necessary.

Thanks.

diff --git a/b0ecbdc540 b/3028abd25e
index b0ecbdc540..3028abd25e 100644
--- a/b0ecbdc540
+++ b/3028abd25e
@@ -312,10 +312,9 @@ static void process_parent(struct last_modified *lm,
 				bitmap_set(lm->scratch, k);
 		}
 	}
-	for (size_t i = 0; i < lm->all_paths_nr; i++) {
+	for (size_t i = 0; i < lm->all_paths_nr; i++)
 		if (bitmap_get(active_c, i) && !bitmap_get(lm->scratch, i))
 			pass_to_parent(active_c, active_p, i);
-	}
 
 	/*
 	 * If parent has any active paths, put it on the queue (if not already).
@@ -440,12 +439,11 @@ static int last_modified_run(struct last_modified *lm)
 		 * Paths that remain active, or not TREESAME with any parent,
 		 * were changed by 'c'.
 		 */
-		if (!bitmap_is_empty(active_c))  {
+		if (!bitmap_is_empty(active_c)) {
 			data.commit = c;
-			for (size_t i = 0; i < lm->all_paths_nr; i++) {
+			for (size_t i = 0; i < lm->all_paths_nr; i++)
 				if (bitmap_get(active_c, i))
 					mark_path(lm->all_paths[i], NULL, &data);
-			}
 		}
 
 cleanup:
