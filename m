Received: from fout3-smtp.messagingengine.com (fout3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C13CF13A276
	for <git@vger.kernel.org>; Mon, 26 Aug 2024 07:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724656921; cv=none; b=WozqsUe0TPL3RRTF0qTofAVEvzwZVIo5Z2SZ9YmpCYlNlRSeO4MFwkcwDPLQGDWxF6NU75tDQv36NZYUaeXUonp1xzS6zyocW5VM7w4K64i8DLX45L+jMyiwuYM23uMPV2/eIkPU4D/EvKR1NkDkCeA8hQs1gCtgittPBFdyUjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724656921; c=relaxed/simple;
	bh=QsTjnut4sWBJ1mSGxPyPAt5uySwb9VafbQQXpj1i96U=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cp6p1ZMzzURhvo10oCDKqk+zZsqwwIbPsLmYO+Erg6QSmmJ9SEOV2MwruSRVFMWpReUfo3uwokMU9AWeBdn/Ip14lQIEd6rY+j4bS/wzvXdPXxSn+vaWrn0NeY+WM3EipxpC4lYfnK4FUUIHuqR7kddZXtP7bJeXSCfgrKERzQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ITC+Bj+1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=uQPe7YS8; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ITC+Bj+1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="uQPe7YS8"
Received: from phl-compute-02.internal (phl-compute-02.nyi.internal [10.202.2.42])
	by mailfout.nyi.internal (Postfix) with ESMTP id CBE10139099A
	for <git@vger.kernel.org>; Mon, 26 Aug 2024 03:21:58 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Mon, 26 Aug 2024 03:21:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1724656918; x=1724743318; bh=A2bKT179M+
	tPuI8jSmR3pgAo9Tb0xaZNpSa1Bmir91w=; b=ITC+Bj+12dlBHt4+zx/w+pNKom
	mz+kil/F/wRUEB8BEa9PyMpZN1yGqcN16JH7v/M41JYW/BdX4fiOnEq1k+yzokCP
	3UeduEA+qnvRb495UOjIyIm+HsY4ucut+YZDQMRAGduXwnCRAUP7RmJOIphknC6E
	Ta7N18oVRRtCuvFYeF9cBPUFSaivcvYOy9siua5kmH1uLKPCu0+0/OJjZ2ipofO6
	G78csopPTEKUVI2P1dNpwP82cQJgOXacj751r5XnOn73MXyZi4RHmaZu9/sQf4uq
	1zJerumkqYMpzcbQoDZ7ruU01ThW3jbpr3QKh5QxPSIzSzNTenTtjaJEn2dg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1724656918; x=1724743318; bh=A2bKT179M+tPuI8jSmR3pgAo9Tb0
	xaZNpSa1Bmir91w=; b=uQPe7YS8LX2JXrg8rijP5dBy54qO/frvDfH7t2S5Wh/z
	z43BJ6+IpKoSnGYA4Rin1AzDMGKS0s6rvdiL9AlkPPsoc5Ut4/K5HwHZosZNd8o5
	9RqAf/TVjD7mE1L88+S96FqLUwdSfFDfT5cW/ohP8wWMiYhMtJUYZQRd0ORNYLz0
	H8gh6dWexTvD1UqE/YE52HVQAKvNZZCAVwkYKRWLgW+QEfF3lWCi96R59IjSmAMW
	E36qU55zRYn1qhWFz+k4qwmtb01XwY2SP+iV0P+XyH2eWXXuJpEIVZ2pyYY5Phi3
	9C3dd/e2i+KbvMhvC+Mz9l4R3Yz7/+vwrlAK1aBguA==
X-ME-Sender: <xms:Fi3MZhRQAwpH55QxXa6LOaN2k4TqV_O74O2WqjN6E8DHUxB2diifAA>
    <xme:Fi3MZqwswa_AC5pupGZdtMSJ7yrJfZZTycOtsF_6QHAKwZMlYEvy06cEDi8RDarse
    1btsuCDGrRiyluoAw>
X-ME-Received: <xmr:Fi3MZm3lUrGBLXF5NbGINkm1odAYJXke23l3T5j0NWhK2Cj6rtSXoOdLIGXInb3djH9UZ5zG5F7Bb03ppfLR854N8yNwFpR-rbBZwvAZv9ywJPs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddvjedguddulecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvf
    fukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeehkeeffeegge
    dvgedvfeefheettddtffejuefflefggfehfeelffeljedvfeehieenucevlhhushhtvghr
    ufhiiigvpedvnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsg
    gprhgtphhtthhopedupdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:Fi3MZpAJy0VnMakUHDLXP8lHgL325KFexE5b91O8W2s1cG0ikJlZDg>
    <xmx:Fi3MZqg2Dg_IsEC19v0o5g50GBVhk8CtYVl9VB5n9XlPCVqaJjpdnw>
    <xmx:Fi3MZtrR7sH-C1WrSf6JJlDWYWMNd1wuA-LXSj1rdlLRlvtEG-y9Ew>
    <xmx:Fi3MZljHzhZ8A9pkKFnEdzkabP14BAFTY7yMBqwQeAQnBwi9yvDK5w>
    <xmx:Fi3MZua2QwdWW1wkL4akDf4PYMZ1xv3CKpK5TwB65xxl7pf5l46FKmcH>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 26 Aug 2024 03:21:58 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 2bcd2255 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 26 Aug 2024 07:21:56 +0000 (UTC)
Date: Mon, 26 Aug 2024 09:21:56 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 08/22] remote: fix leaking tracking refs
Message-ID: <7fafcc53d23672bb0339c44ea3874b3628785f08.1724656120.git.ps@pks.im>
References: <cover.1724656120.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1724656120.git.ps@pks.im>

When computing the remote tracking ref we cause two memory leaks:

  - We leak when `remote_tracking()` fails.

  - We leak when the call to `remote_tracking()` succeeds and sets
    `ref->tracking_ref()`.

Fix both of these leaks.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 remote.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/remote.c b/remote.c
index 8f3dee13186..240311619ab 100644
--- a/remote.c
+++ b/remote.c
@@ -1123,6 +1123,7 @@ void free_one_ref(struct ref *ref)
 		return;
 	free_one_ref(ref->peer_ref);
 	free(ref->remote_status);
+	free(ref->tracking_ref);
 	free(ref->symref);
 	free(ref);
 }
@@ -2620,8 +2621,10 @@ static int remote_tracking(struct remote *remote, const char *refname,
 	dst = apply_refspecs(&remote->fetch, refname);
 	if (!dst)
 		return -1; /* no tracking ref for refname at remote */
-	if (refs_read_ref(get_main_ref_store(the_repository), dst, oid))
+	if (refs_read_ref(get_main_ref_store(the_repository), dst, oid)) {
+		free(dst);
 		return -1; /* we know what the tracking ref is but we cannot read it */
+	}
 
 	*dst_refname = dst;
 	return 0;
-- 
2.46.0.164.g477ce5ccd6.dirty

