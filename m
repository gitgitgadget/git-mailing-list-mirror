Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EDCA1A285
	for <git@vger.kernel.org>; Mon, 22 Dec 2025 22:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766441092; cv=none; b=AHH24bQWCVZdmeetYNwalp0WEShztCiW8Z2L56rZg5tLSJIXKFc/DjfXFhDtycTBm3Vn+ezvfet3p5k24GPFMLuycxWJSfaMt69EAT5ueKDm/G762V4xJtl3nUMoxr7d3axGK1CoA9OTll2rUVBtkV96B+yauiLrLDhJIv79CSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766441092; c=relaxed/simple;
	bh=oiMz6JuZjHhrhYdfvBtKp3gRDW4uA609CcM9we+Rxi4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WSzYjlE2AY8GeLvITrpfIMw66BkwR8igtniNIl2oEr8YOEmdamD+6yrVIzZbAfMn/4PV9j4UOjcKW47gV3V6rH0QWzoNDHCIuZKbncXmbB0/3gPKPcW0FmWYtv7zixmzzYmnWmQMs3ODGzF09JlBLW/2LrCnoJf70nHNoWROqqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=ljSajjNM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TWxyTyjT; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="ljSajjNM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TWxyTyjT"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 7F1CD7A00B0;
	Mon, 22 Dec 2025 17:04:48 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Mon, 22 Dec 2025 17:04:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm1; t=1766441088; x=1766527488; bh=tf
	Sf44IB6+G43gIb0+Pv1C1dTTJR92hddxSyxFc5SXw=; b=ljSajjNMK+l9xv4H3f
	6PoYMpFiByPxORFN6uMpFlXtEvziTjCFGfIr1xhSsPga/7Ludd/5LrCl5/G1K+Zx
	zZaE0HLNaLINVyvKc2uKc3vjrnp0vYIc+uRSEMiqe9NLXyYlG3knDFjnd4zagbKM
	9wtQjtk69y/mFfgJJK1SzH5tgMzknhfn7YFRJVfolWs8tqebuVLYlcJrC5rTMmDN
	CiHiOpLb7Nf+iXrjh/Z4dfHDFUD5HX/rAUtt692j5B1LHuwOXqqb6EIH7VgJmven
	WNJ8fX0SinaBwLtHvzgrbwrn/g8MbbWsDAEOzpYjolP6kCjcyX7W8CjwMeTi3IFK
	2StA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1766441088; x=1766527488; bh=tfSf44IB6+G43gIb0+Pv1C1dTTJR
	92hddxSyxFc5SXw=; b=TWxyTyjTtN2A2OwBoKPiqWDh9p2dRr9q3wJpoR8D0lcd
	Wmh/erRWKTaLdsz6n+5rCAhdNhjmQ2MyENneWzlzd1RdFFAWE932Pq91rpem/C26
	Pv1Lt05bJMhbfy+kLmLhpzc7aU9CUg3YZljwDrBk0rtPj1OHdFvGirfZirBDRR1z
	fuanruh+uEcykOL+pug+0jrCnwmZQCUXzBhwcGB25LcNV9D3AJcJ2AdzLqtWpuY4
	wqpZaMCOis+yHbT1r+AgFRrAht5TsEBSYaNZlI8g+Jj9NEnnaG/i+mL6zCcGdRox
	rAfDNYGIrPiTVybW3wm3YF+sXXfEIfX086hbEx3bGA==
X-ME-Sender: <xms:gMBJaQNtJGpDq8X7_J0FIuTAiyGRVHDmxj1lZj6Vf_-92y2sL40tW7w>
    <xme:gMBJad0CZB-42d0qrS6zbdZY-5xS5a299k3PWiK5gW1V6frQ0CbS5hkRxWPbBUfE3
    dIaLa948RkaGL8EgTniMR_abpOiokUsO7qpaSZVG78FPsdo0iiNNg>
X-ME-Received: <xmr:gMBJaflY9iTTM5YEQ9hEaPoy72NRuzh4MMVHhXBOF56vx3nTCM_-QGM349QYZzBwveGQGR_JMLH3DpQvsn7P3BYbkhwZfWBhQblLM78QIyIXr_tQWuya9CM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdehkedtlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenfghrlh
    cuvffnffculdefhedmnecujfgurhephffvvefufffkofggtgfgsehtkeertdertdejnecu
    hfhrohhmpehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtg
    homhenucggtffrrghtthgvrhhnpeetgfekjeffudeffeffgeekvefgvedvgeffueejjeel
    geduhfdtffeikeelfefhgfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghi
    lhdrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpth
    htohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegtohguvges
    khhhrghughhssggrkhhkrdhnrghmvgdprhgtphhtthhopegthhhrihhsthhirghnrdgtoh
    huuggvrhesghhmrghilhdrtghomhdprhgtphhtthhopehnvgifrhgvnhesghhmrghilhdr
    tghomhdprhgtphhtthhopehsihguughhrghrthhhrghsthhhrghnrgefudesghhmrghilh
    drtghomh
X-ME-Proxy: <xmx:gMBJaUXCAIrgrC8zQWVjF2B3q9sj36YLMnu0_2RIN3niMT0n1tx9eg>
    <xmx:gMBJaVtyjpMwMZG3WGEFxfjfrWbzM78PdG6zxy3U6_wjtpEPXtyr0g>
    <xmx:gMBJaXbMRChc7ScoPaUCf7Jbhef1YqIzCjbk417dLIEKwKiv30L_Zw>
    <xmx:gMBJaUVa_hv_3x0sk0NPgyJlcWREH1HctqP0CZJualT_qRcMyKd0LQ>
    <xmx:gMBJabnMae0gZczjfOyAfCn_mv-BXKLZb8kPOHLi7v5FLG4FmBM1YMjW>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 22 Dec 2025 17:04:46 -0500 (EST)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	christian.couder@gmail.com,
	newren@gmail.com,
	Siddharth Asthana <siddharthasthana31@gmail.com>
Subject: [PATCH 0/2] replay: die descriptively when invalid commit-ish
Date: Mon, 22 Dec 2025 23:04:41 +0100
Message-ID: <CV_replay_die_descr.13f@msgid.xyz>
X-Mailer: git-send-email 2.52.0.10.g08704017180
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

You get this error when you for example mistype the argument to
`--onto`:

    fatal: Replaying down to root commit is not supported yet!

Consider that you might not know yourself that you have mistyped
something; then this looks even more puzzling. You might have given a
range like `main..topic` but the command says that it would need to
replay down to the root commit.

The only thing that’s happened though is that `NULL` has been
interpreted in the wrong way.

Let’s instead die immediately when the real error happens, in other
words when we can’t find the commit for the given commit-ish.

Also add more regression tests.

Somewhat unrelated to this change—and caveat not a C programmer—I was
confused by `determine_replay_mode`.  Most of the function deals with
three cases:

    if (onto_name) {
    ...
    } else if (*advance_name) {
    ...
    } else {
    ...
    }

But I don’t get the `else` since you now need to provide either `--onto`
or `--advance`.  And both require an argument.  So when can the
fallthrough `else` happen?

I thought that maybe the `else` was old code that predated `--onto` and
`--advance` being mandatory. But that whole method and this check was
added in the same commit, in 22d99f01 (replay: add --advance or
'cherry-pick' mode, 2023-11-24):

    if (!onto_name && !advance_name) {
            error(_("option --onto or --advance is mandatory"));

But just ignore this section if I’m simply confused.

Kristoffer Haugsbakk (2):
  replay: die descriptively when invalid commit-ish
  t3650: add more regression tests for failure conditions

 builtin/replay.c         |  2 +-
 t/t3650-replay-basics.sh | 43 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 44 insertions(+), 1 deletion(-)


base-commit: 9a2fb147f2c61d0cab52c883e7e26f5b7948e3ed
-- 
2.52.0.10.g08704017180

