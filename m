Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20C29299ABD
	for <git@vger.kernel.org>; Tue,  8 Jul 2025 07:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751961481; cv=none; b=PWTePbof7/5nXaMWvqGcaQw5K4B+bo4pTDx0mc83W4wHO+Po6rFqyom+nKUIejUJu4d9GKzdw1pkpW7qf/H00DX8GE94+FqF1P7qRTXm3pLZpnTi4rjjcnX9e3oiG7dCbNfUDReMTfDIP/MGKJPXoWp5Z4cxim9N/Q5uSVjlb68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751961481; c=relaxed/simple;
	bh=Be8lgxdFKx/Pq/H+d7zAXA8D6vFFAjTGer1hDcCSFhE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jvkEOLHU0OUuudCmS9+YFD9IHewRgQlBbtT17bRKNKyDZJddjL4KvmkVsQ6BWwmVCa6g37gmzhEr9RTHSxex0pIrx0ZAhXdPg6PHnFoGbddGyHjwGLCcoH8pCI5kD86uRA2suBIdG6Ma0jW8nChQ04KJaWQPDEmXur/izlWV8G8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=LQfbytN5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hPXG5gpX; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="LQfbytN5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hPXG5gpX"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 1BBDCEC0B64;
	Tue,  8 Jul 2025 03:57:59 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Tue, 08 Jul 2025 03:57:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1751961479;
	 x=1752047879; bh=9/DTGlUpfrY/i+8GsRLlUr6qRRO2rQYSGgQh61GHGoI=; b=
	LQfbytN5vz9uGxUppAnyIZ9q2bxQu1RVH7Xg/UIAvpCn1HNUJW+22xb4MaOMRlFC
	qWRFa8lD9iRx3B77JkHHA9Rt3ZICuv1lErIkrLsYrXzKdsv71YdBzqsjk1OaiwRe
	8+Vuv6pVRCWYR3uj5uD3mh7hEqp16oUckeCstyUj4k1Gh/+a2VxBR69PYzlOmAkD
	uOzdqCjkavbx5ykW8PQDy5MTXUtLF3hLWBmWoc5FVfXi90dwHQ6r7vBgjb51WCpW
	wn0ANgZmN4zKB1Rs8SUMR7ZjZ94iO9+8NmRg4OGCAZm/Gedpkk+gC9pFvfkbmX3v
	6x1lVQwvfLa1pQS79O5V7Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1751961479; x=
	1752047879; bh=9/DTGlUpfrY/i+8GsRLlUr6qRRO2rQYSGgQh61GHGoI=; b=h
	PXG5gpXi6BjoS9M6QR+3BZ4n//D8ZVajt4KtsOxG6m6vj4aBNXNeVm4UU4+Bi6PZ
	9bTCuttauqjFmVK39HH2Q3gZP3bwQdtzc85MjimiaJ6JgY0bvTO9AqY/N67RrXvX
	ArtauKo0CCm+ogaZHwVv/4b8f8B2icZDNXnmjaZpjqhCD64Cxyp4LjMfmc8NrWpU
	7N6mgEwsmbt67mFjRgd6KKNXOHBuwd9li/XBZTz5dUWgW0IabIr6uQ1LEL0V6jL1
	3mu5IlZdtXv1+Ed/ZVIe4oO+z8SCEy8sgKYd/keWg2gYLjnuQsf2buYgBBRPkqs8
	CbC8QOXobtSD42EDc1CMw==
X-ME-Sender: <xms:hs9saMTpzfF_1mRxuaNEb1X1AbDMdheqGWZeul9IlyciT8KnbMoIcQ>
    <xme:hs9saKhv2NMg823_GiCDaiqUD2WqON4UTKBUyrGlPZBN5UCVqk6K1uTOOtr9HQVSm
    S22wqA7dkbRDpjy7g>
X-ME-Received: <xmr:hs9saF-ZiNUz7DzZT6JrWW59G3newMJun9cYhLml8pu_pzWaz3Ez1nA-y38C34eEo1sfi0-PtEDZ6OfQp7JjA18IUvbUHEBVTci-7vbBKdk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdefgedufecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epffeuiedujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehgihhtsehvghgvrh
    drkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepihhrvggttggrrdhkuhhnsehgmhgrihhl
    rdgtohhmpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopegvsh
    gthhifrghrthiisehgvghnthhoohdrohhrghdprhgtphhtthhopehrrghmshgrhiesrhgr
    mhhsrgihjhhonhgvshdrphhluhhsrdgtohhm
X-ME-Proxy: <xmx:hs9saBEekXgKB57ik8wY1kvdRrXn077OhS5AKipzxH8D2-H6UArfiw>
    <xmx:hs9saIkXRyvx2IGKrFDs2s5WUKE1PQb4PCZlUIEfb_uLwK4ZeEi8dQ>
    <xmx:hs9saFb3-bdiGFeM_37E_SkmnwRMi1rUybEFykaX4XEIONP3ZqYTlg>
    <xmx:hs9saNEBnQ9ePsmEOviZke_My9kjcEOY5n1ZBZQ8jskEuRyopP5nbw>
    <xmx:h89saGy6HnEi8iR7kdSkby-TeSJtzna2AtbR7uYIGlOycOSH1Ig1-5Tx>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 8 Jul 2025 03:57:57 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 689c7c5a (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 8 Jul 2025 07:57:57 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 08 Jul 2025 09:57:44 +0200
Subject: [PATCH v2 3/8] meson: improve summary of auto-detected features
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250708-b4-pks-meson-cleanups-v2-3-94ac53cd4b95@pks.im>
References: <20250708-b4-pks-meson-cleanups-v2-0-94ac53cd4b95@pks.im>
In-Reply-To: <20250708-b4-pks-meson-cleanups-v2-0-94ac53cd4b95@pks.im>
To: git@vger.kernel.org
Cc: Ramsay Jones <ramsay@ramsayjones.plus.com>, irecca.kun@gmail.com, 
 Eli Schwartz <eschwartz@gentoo.org>, Jeff King <peff@peff.net>, 
 Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.2

The summary of auto-detected features prints a boolean for every option
to tell the user whether or not the feature has been auto-enabled or
not. This summary can be improved though, as in some cases this boolean
is derived from a dependency. So if we pass in the dependency directly,
then Meson knows to both print a boolean and, if the dependency was
found, it also prints a version number.

Adapt the code accordingly and enable `bool_yn` so that actual booleans
are formatted similarly to dependencies. Before this change:

  Auto-detected features
    benchmarks      : true
    curl            : true
    expat           : true
    gettext         : true
    gitweb          : true
    iconv           : true
    pcre2           : true
    perl            : true
    python          : true

And after this change, we now see the version numbers as expected:

  Auto-detected features
    benchmarks      : YES
    curl            : YES 8.14.1
    expat           : YES 2.7.1
    gettext         : YES
    gitweb          : YES
    iconv           : YES
    pcre2           : YES 10.44
    perl            : YES
    python          : YES

Note that this change also enables colorization of the boolean options,
green for "YES" and red for "NO".

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 meson.build | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/meson.build b/meson.build
index 4e41c3007bb..4f22d72641e 100644
--- a/meson.build
+++ b/meson.build
@@ -2193,15 +2193,15 @@ meson.add_dist_script(
 
 summary({
   'benchmarks': get_option('tests') and perl.found() and time.found(),
-  'curl': curl.found(),
-  'expat': expat.found(),
-  'gettext': intl.found(),
+  'curl': curl,
+  'expat': expat,
+  'gettext': intl,
   'gitweb': gitweb_option.allowed(),
-  'iconv': iconv.found(),
-  'pcre2': pcre2.found(),
+  'iconv': iconv,
+  'pcre2': pcre2,
   'perl': perl_features_enabled,
   'python': target_python.found(),
-}, section: 'Auto-detected features')
+}, section: 'Auto-detected features', bool_yn: true)
 
 summary({
   'csprng': csprng_backend,

-- 
2.50.0.195.g74e6fc65d0.dirty

