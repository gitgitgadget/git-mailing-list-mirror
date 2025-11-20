Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22BA6372AB0
	for <git@vger.kernel.org>; Thu, 20 Nov 2025 08:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763626576; cv=none; b=mIMCM9ulBHZYCA77IwVsrSOjGZhpbp4lI+Tms2kOjZdykEYEvzXGLXWv5P4nm9NCivSfTK/rvc+0TjAeHKU3NVKDgNSc1tLdQPvRFk+vtvukhnBloktca98TFcirKzmme0JvDijY7oZWtKSgS05q5poJfUcgUBIEHU+GJb8vjTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763626576; c=relaxed/simple;
	bh=bSJHhKW7OuHmLuLe/qsky51+p/yjMmii1hJYLa2vqS4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qdcX5nCn+cW1dBNhvkxDIe9SfY5wco1dAfsRoG5CUjuFA62uFU9NGpM6Ka0mXqelob2H3qP2sqhYjIocg0YoGe/j/YvhAtH70jZmSNCyT0WxHJz6YH70sRABwxYHdRC9OaHHGQ9X5K4fSb6+yKJaeglZ6uNhUzh1tZz6ggpdxKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=LOSj4Tqq; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="LOSj4Tqq"
Received: (qmail 41713 invoked by uid 109); 20 Nov 2025 08:16:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-transfer-encoding:in-reply-to; s=20240930; bh=bSJHhKW7OuHmLuLe/qsky51+p/yjMmii1hJYLa2vqS4=; b=LOSj4TqqEf05fMdjfld8NZ6zj/FM0YY+SvGrgOBgwkKdsGiLhKcijdBljyHPEwRosDbXDg+QbZ4Ddy+SOPh8hHARUy9dTj2mPRHk/9d5zLfKBTjYYXj7zf+IXNWGac2GsgjoI3IsTkVD1ZApOEVrMXcZnHVSNA3PfppB4KGqBrbvJVoz3E5Nap+ps4QXYuFlWDEujrnPM+oQGTXoTxtk5nntd2D4vhYmv0Zmsux/wS6LpdVbPX6MKKJFmpbpd7h8w/SSR9zO3Appl2NsudHWxMvrOeSrHDKN/ETeXUfY5MUsQzgStNjMwJeMKh92Ot5YgrAIdfGu1nRoa73qFDrdnQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 20 Nov 2025 08:16:13 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 62462 invoked by uid 111); 20 Nov 2025 08:16:16 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 20 Nov 2025 03:16:16 -0500
Authentication-Results: peff.net; auth=none
Date: Thu, 20 Nov 2025 03:16:11 -0500
From: Jeff King <peff@peff.net>
To: Anders Kaseorg <andersk@mit.edu>
Cc: rsbecker@nexbridge.com,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Toon Claes <toon@iotcl.com>, git@vger.kernel.org
Subject: Re: t8020-last-modified.sh failure on s390x (Re: [PATCH v4]
 last-modified: implement faster algorithm)
Message-ID: <20251120081611.GC1283645@coredump.intra.peff.net>
References: <20251023-b4-toon-last-modified-faster-v3-1-40a4ddbbadec@iotcl.com>
 <20251103154726.26592-1-toon@iotcl.com>
 <4dc4c8cd-c0cc-4784-8fcf-defa3a051087@mit.edu>
 <3b24b6a3-61cc-4b9a-a823-f1e58fd9919b@app.fastmail.com>
 <ceacc47b-9d29-4e32-9d83-6bd68279c83c@mit.edu>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ceacc47b-9d29-4e32-9d83-6bd68279c83c@mit.edu>

On Wed, Nov 19, 2025 at 12:06:35PM -0800, Anders Kaseorg wrote:

> On 11/19/25 05:49, Kristoffer Haugsbakk wrote:
> > On Wed, Nov 19, 2025, at 12:34, Anders Kaseorg wrote: >>
> > t8020-last-modified.sh is broken on the s390x platform in v2.52.0.
> >> Bisection implicates commit >> 2a04e8c293766a4976ceceb4c663dd2963e0339e
> “last-modified: implement >> faster algorithm” [1]. > > Does
> `./t8020-last-modified.sh --verbose` give any interesting > output?
> I quoted that output in my previous message. The failures in subtests 16 and
> 19 come with these diffs:
> 
> --- expect    2025-11-19 11:28:57.966106204 +0000
> +++ actual    2025-11-19 11:28:58.110112543 +0000
> @@ -1,2 +1,2 @@
> +ac29b6e974b49803f1c6ec5a705d1bf7dbfa7d2f m1.t
>  m2 m2.t
> -m1 m1.t
> 
> […]
> 
> --- expect    2025-11-19 11:29:03.492349022 +0000
> +++ actual    2025-11-19 11:29:03.648355864 +0000
> @@ -1,2 +1,2 @@
> -b5 file2
> -b2 file
> +da1857e0652b6f264c0038d684ddecddc273e506 file2
> +da1857e0652b6f264c0038d684ddecddc273e506 file

Interestingly, the commits it returns are merges. E.g., here is the
state after test 16:

  $ git log --oneline --graph
  *   ac29b6e (HEAD) Merge tag 'm1' into HEAD
  |\
  | * 53e7187 (tag: m1) m1
  * | 9b81a41 (tag: m2) m2
  |/
  * 08525b6 (master) remove a
  * 664d121 (tag: 3) 3
  * a732b0c (tag: 2) 2
  * 1edf6f6 (tag: 1) 1

Though it is also the first commit we start traversing from. The same is
true after test 19 (da1857e is the tip of HEAD there). So I am not sure
if the bug is "we are not passing down blame from the merge", or just
"we are not passing down blame at all".

I can't help but notice that this same failure is seen on s390x and HP
NonStop[1], both of which are (I think) big-endian. And not on any of
our usual little-endian platforms.

I don't see anything that looks questionable in terms of casting or
integer handling in the patch that introduced the problem, though.
Probably a long shot, but if you are able to build with "make
SANITIZE=address,undefined" and re-run t8020, that would let us check
for endian-specific memory access issues.

-Peff

[1] https://lore.kernel.org/git/003901dc596c$40bfbd80$c23f3880$@nexbridge.com/
