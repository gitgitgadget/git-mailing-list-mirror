Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9436C604A9
	for <git@vger.kernel.org>; Mon, 29 Jan 2024 11:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706526456; cv=none; b=qNo90t8XWu6dMXSS/dMMYAd0cnWZpSZDCPySzWyv+s5dyZY8wk0pHQ5IeO93L9Ut1UKea+CFDgrtAzgw+toV4QjdVjs4Aajc9DzPu1YFR78kpxWjcedJGNAusBTj26zxe870i/QhWEKQYIhSYlItwXppBq7mJa5OGY1Iw7Kqvd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706526456; c=relaxed/simple;
	bh=ntfjAFz3M47F4GQu3erSD2IODFnNNCqHeU8x2SlSppM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iYjsq94ABc38Zkx4iedCPXW64O/wjvp24ETWpT8UJFhzZoqC3mk3HzXsrtcjpK6+Iz3MQHax0mwU+MqVcC6hnklYZcP5MB2Y4JX7ImyACFHyROyy1oHx5sTmlTtuoaMPrQME//z7HKXpWe/P2x1OLOj90hggRBTi8ZcCGJk6qk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Bsh7AvuO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EwzuXYX2; arc=none smtp.client-ip=66.111.4.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Bsh7AvuO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EwzuXYX2"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id DB4E35C00C0;
	Mon, 29 Jan 2024 06:07:33 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Mon, 29 Jan 2024 06:07:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1706526453; x=1706612853; bh=8+j06/YAai
	udvI8aRGXMYIFG1c3kLJAkNnalicSfw+U=; b=Bsh7AvuOSXWWNunkZxP0GAUGte
	4JiHMpa+aYdNCzrUa2XrL7nWSXkVwi6Q310AnzPTjOjcm0CSl+w1Sxkew/fY3gQA
	8MUUaKMCA2ufHXAuTe9r26r+RgHYKCd1nkwTTFNoWwDAeEbUN1da7+ImBnP7q7Fd
	EauKvaTy6hV39QMsLxW5+7RnBvMWT+iPa1tlkK7qpJyfqPbJESp1aaHppqwja/zy
	xj/THBM9/ixQoZp7P0P+ByLPpiuUGANNdiAarYAkB4fESrYGMjQWoldeU8SRLPti
	FP64yXTEv31fhr42YlK3iC3x1twBwLuuWNjAz6Q9l+dGM9Kw09FWsWLs6yng==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1706526453; x=1706612853; bh=8+j06/YAaiudvI8aRGXMYIFG1c3k
	LJAkNnalicSfw+U=; b=EwzuXYX2a9H8r0a2mSq1B3x3LtXa/jt7lHU6pTJkFCGm
	EsLKfJXLN8JzFB+h7D1mjWa+pGsHSTZI7hDOtd9erhmhyvGx3K/N9ZqlVnMuKzP9
	q5CTfBjJhrPMRDRej+1sQOfl+dz9p6qFyAsAYk4cVaUgYgE1N+nwOg+7qcoLoJ5a
	E6wYPQn5QLYtDrsfitAKfs3/f83Y9PEKi0kmu4xvzCCJsJ4IvXvvvytgZUMT902q
	aXYKF8HRTL0yQCr7eIQVROQMvaEp6m5A95gaACocMUz2G6Yey+X3M0fnoqGS47sa
	L/BmIsdIUYh38nhFYHzyqBIOMTZpSHqjCGB3ZC0tKA==
X-ME-Sender: <xms:9Ya3Zb1nC6qtZdkay1tw0x3ycULC7uDhusJdwRFwSfBOpv_fQDUFCQ>
    <xme:9Ya3ZaEVQXai1sCvCy_IbDztk4EbtNNjPOpMjtLvGIzcmNOBDwS5xz9T2p0bgbxdC
    nupWQkfdGb81GJgNA>
X-ME-Received: <xmr:9Ya3Zb4z8VjOFqEILPbBXp0CwqOV-SJSKmunNlw5FdDiKW7081TCt5iXHlpUbqpT8X_4sT1XnenGr6d3EBdqdvV5jLuxjjMqbG8KbwZCqH3XKhxE0Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfedtgedgvdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:9Ya3ZQ0oO08CcFMxcfKdfCjfpULE8P9baKRGoyCV1_nKcpqdwAD_yQ>
    <xmx:9Ya3ZeF_a1BKNDSXa43E8igaZPukVlbfGAxzMy5Dv_xhBr9lGizhvg>
    <xmx:9Ya3ZR81_FQC7m1z-_CRj6idV3s-ibU9R5KFw-ORXk8MdFdaEssEBA>
    <xmx:9Ya3ZbOrTM9uqpzwmcIWBk5NFpQmGQrsgcUOLrX0Mt_W5uP97AZPzA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 Jan 2024 06:07:32 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 6cb32538 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 29 Jan 2024 11:04:15 +0000 (UTC)
Date: Mon, 29 Jan 2024 12:07:30 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Eric Sunshine <sunshine@sunshineco.com>,
	Toon Claes <toon@iotcl.com>,
	Christian Couder <christian.couder@gmail.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v4 4/6] t1419: mark test suite as files-backend specific
Message-ID: <1faa8687ae201a426e603cd456534775e314108e.1706525813.git.ps@pks.im>
References: <cover.1704802213.git.ps@pks.im>
 <cover.1706525813.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="975hS2BPKgoz2Swv"
Content-Disposition: inline
In-Reply-To: <cover.1706525813.git.ps@pks.im>


--975hS2BPKgoz2Swv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

With 59c35fac54 (refs/packed-backend.c: implement jump lists to avoid
excluded pattern(s), 2023-07-10) we have implemented logic to handle
excluded refs more efficiently in the "packed" ref backend. This logic
allows us to skip emitting refs completely which we know to not be of
any interest to the caller, which can avoid quite some allocations and
object lookups.

This was wired up via a new `exclude_patterns` parameter passed to the
backend's ref iterator. The backend only needs to handle them on a best
effort basis though, and in fact we only handle it for the "packed-refs"
file, but not for loose references. Consequently, all callers must still
filter emitted refs with those exclude patterns.

The result is that handling exclude patterns is completely optional in
the ref backend, and any future backends may or may not implement it.
Let's thus mark the test for t1419 to depend on the REFFILES prereq.

An alternative would be to introduce a new prereq that tells us whether
the backend under test supports exclude patterns or not. But this does
feel a bit overblown:

  - It would either map to the REFFILES prereq, in which case it feels
    overengineered because the prereq is only ever relevant to t1419.

  - Otherwise, it could auto-detect whether the backend supports exclude
    patterns. But this could lead to silent failures in case the support
    for this feature breaks at any point in time.

It should thus be good enough to just use the REFFILES prereq for now.
If future backends ever grow support for exclude patterns we can easily
add their respective prereq as another condition for this test suite to
execute.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t1419-exclude-refs.sh | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/t/t1419-exclude-refs.sh b/t/t1419-exclude-refs.sh
index 5d8c86b657..1359574419 100755
--- a/t/t1419-exclude-refs.sh
+++ b/t/t1419-exclude-refs.sh
@@ -8,6 +8,12 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
=20
+if test_have_prereq !REFFILES
+then
+	skip_all=3D'skipping `git for-each-ref --exclude` tests; need files backe=
nd'
+	test_done
+fi
+
 for_each_ref__exclude () {
 	GIT_TRACE2_PERF=3D1 test-tool ref-store main \
 		for-each-ref--exclude "$@" >actual.raw
--=20
2.43.GIT


--975hS2BPKgoz2Swv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmW3hvEACgkQVbJhu7ck
PpQ83A//cAFvK8jV+9tjeqH5tNcbHdqhuzT/TFtSwFRtTPa5aZzDDlk0PZexukuO
AKZuTknXbSFIsM2Oha3IUTRLlXwAqhBOlv9TedIpO/6su0gDx4S+9/LZN4pj8Su3
gT1RCX88ddb5h/vqGHfwe4eemrMHM/PvwRbVUUqgb7Yg55PoFR7SKcMX3rigCqBN
sJqpX0I4q8NQ5CoX8AkGQqueHji/AxTwSuRRLuuWGZkjUfwqm98L6v70O+uqNoJJ
wth6G5dV+/naRF9tPen+hmMzkFhn8/4akpnfPlL/Qw9D50d2wX81xGhLH92sQuOP
PEc1+rA4YVuqS4hmSexI9TTamy3baVUO/lHEeUv5GQY1v+mYwV6NQP44g1S9fThy
+7UQzWIqY5N+BHNPJCLkfrHghDvrHc8MFdvG0QMlzwbOxr59uPAYa8oxA6+xec91
xTl3ACQ1O7QV0umHWZOu9wqnmUxbvCUMdCooB5jO6UGAm/DrWauLWmvOm64rXmfv
MUX2LG5BTA0ipM+6z+Cpm2oepooVtVIO4L0jKbeWjB0LhWbFT+0XR0bk7k/5WpPT
eIrU+Fu6HnOZ/of5FyZnSppCvmXHF3bbQoKpBnjghfsacCEEOBriDZUaHcfjeOKe
ZlYBCF54F3iDaM7kmRQPunP0Wv3FCgXfk9As4m6OLw1LaIcKqQc=
=isQl
-----END PGP SIGNATURE-----

--975hS2BPKgoz2Swv--
