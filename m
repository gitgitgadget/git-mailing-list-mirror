Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BCB9F9C0
	for <git@vger.kernel.org>; Thu, 14 Nov 2024 00:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731545945; cv=none; b=Qxs0k3xaueeHCz0hnq2ra1ndsoSBt8ovlEC9Dr/mqQpmtnUfqzFPAhB4Cy+KWPCKOfduh5YFNbkAuSpMZaYvMtV3TUH8zXUOilRhIf0mJ72ywRx9AkZuBdMVdN04ubS58lAd/cGh6HhylBds12tUd5Tlvn50rHV5Oci+FAEP/BY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731545945; c=relaxed/simple;
	bh=0PqSbvcC0nAtsT4MMzt8411Xp6D+VYqzBFsGNQyQq40=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VtW30/dGtANbLgEQ9jNhgngzsxHeC+Ijf+Tom9NLGOAMARdh5H/3Y6nXERbi0BLJUcipBCt2fWUv5viso+7FNCUvxqvk9kcSwW89pBaKhqoq9XdP1heG24zGCZxb4Ow4n5FsXxKySfM/ex1gd/ja6ppwNrgf47DTQM0fL3/jm4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=bwTFjJzS; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="bwTFjJzS"
Received: (qmail 26265 invoked by uid 109); 14 Nov 2024 00:59:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=0PqSbvcC0nAtsT4MMzt8411Xp6D+VYqzBFsGNQyQq40=; b=bwTFjJzSUNXyh+W6FH8wKF25VWH5/eRM8lC70cQUyB5gvcelNIq8eKT8sDvB6jczTRBm97NYx9FRoXJ2mOObAwwyqiaf3eJDXV4vO6xP8U0UE1K7aTzr2yeNQvXblx9kvu8o6l67p+FxwEXyCqk94WkufmmOUk0LWbXGMIraSyVrrkmrb71RlP3irCrvU9r+AwoTJT0RLAqeUIRAEj9Ez7dfpvSRbOCVVAx5Ws+Dw7Wv5Cw82hCqJPUT2ooKhs5vBB9C8nINYVV1WqVpOsOradD3CGN2znj1VhlfJhGU8T895EvmIKLnWR10pHe8r/n7pQNRzVLgE4T2nbFRkHGBSQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 14 Nov 2024 00:59:02 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19890 invoked by uid 111); 14 Nov 2024 00:59:04 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 13 Nov 2024 19:59:04 -0500
Authentication-Results: peff.net; auth=none
Date: Wed, 13 Nov 2024 19:59:01 -0500
From: Jeff King <peff@peff.net>
To: Jonathan Tan <jonathantanmy@google.com>
Cc: git@vger.kernel.org, steadmon@google.com, hanyang.tony@bytedance.com,
	me@ttaylorr.com
Subject: Re: [PATCH v2 3/4] t5300: move --window clamp test next to unclamped
Message-ID: <20241114005901.GD1140565@coredump.intra.peff.net>
References: <cover.1729792911.git.jonathantanmy@google.com>
 <cover.1730491845.git.jonathantanmy@google.com>
 <1526a59e2d4ace2761fd8935c63350f0a41985c6.1730491845.git.jonathantanmy@google.com>
 <20241113073500.GA587228@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241113073500.GA587228@coredump.intra.peff.net>

On Wed, Nov 13, 2024 at 02:35:00AM -0500, Jeff King wrote:

> On Fri, Nov 01, 2024 at 01:11:47PM -0700, Jonathan Tan wrote:
> 
> > A subsequent commit will change the behavior of "git index-pack
> > --promisor", which is exercised in "build pack index for an existing
> > pack", causing the unclamped and clamped versions of the --window
> > test to exhibit different behavior. Move the clamp test closer to the
> > unclamped test that it references.
> 
> Hmm. The change in patch 4 broke another similar --window test I had in
> a topic in flight. I can probably move it to match what you've done
> here, but I feel like this may be papering over a bigger issue.
> 
> The reason these window tests are broken is that the earlier "build pack
> index for an existing pack" is now finding and storing deltas in a new
> pack when it does this:
> 
>   git index-pack --promisor=message test-3.pack &&

BTW, an alternate fix instead of moving the test is below. But maybe not
worth revisiting since it's already in next.

-- >8 --
Subject: [PATCH] t5300: use --no-reuse-delta for --window test

In the test added for 953aa54e1a (pack-objects: clamp negative window
size to 0, 2021-05-01), we expect that dropping the --window parameter
will mean the resulting pack does not have any deltas. But this
expectation would not hold if there are deltas from an on-disk pack that
are reused.

This makes the test fragile with respect to the existing repository
state. It works reliably now, but changes to earlier tests could produce
packs that violate the assumption.

We can make the test more reliable by passing --no-reuse-delta, meaning
we will only output deltas we find in the current run (using --window).

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t5300-pack-object.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t5300-pack-object.sh b/t/t5300-pack-object.sh
index 3b9dae331a..392d6a4d41 100755
--- a/t/t5300-pack-object.sh
+++ b/t/t5300-pack-object.sh
@@ -631,7 +631,7 @@ test_expect_success 'prefetch objects' '
 '
 
 test_expect_success 'negative window clamps to 0' '
-	git pack-objects --progress --window=-1 neg-window <obj-list 2>stderr &&
+	git pack-objects --progress --no-reuse-delta --window=-1 neg-window <obj-list 2>stderr &&
 	check_deltas stderr = 0
 '
 
-- 
2.47.0.527.gfb211c7f3b

