Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9359E33F8C2
	for <git@vger.kernel.org>; Wed, 21 Jan 2026 10:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768991686; cv=none; b=HkcdGbpecWK9M0ODfFWjFGpvmhfw4VMrKtHdhZJ3AO/iuLs4eIQ6PGNDvekD0blavEMraHVkN9UEYb+8BEFJKzSdGIb061q0q47T55Iek3wPYwsEOCWhAc9VXHYmMZ6gRdhaqz1QB1YKRaHQccOeyKkjs/Smz6UAXdDLOgFfs+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768991686; c=relaxed/simple;
	bh=U83ajpDnvuEFvIvUisckGe4Fu0O8pnzlPt1odjHfXdY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ATlMrelDrua+jqTH9Dg5rpFEeUXATzcJt73g/EiAhiufqDF4y9c7L9kFRvQWsv2xEDWkfhWQXWmoWXGOYduOjow229leJhjIPDz2P0jPVoem8pZf/cnCr6PUkIZNNxg+QFdCr5JbKlD+hv6r/yqPkOUhKs/DvF0N7f6Rd2siXek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e1BIbdQm; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e1BIbdQm"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-34e730f5fefso4272800a91.0
        for <git@vger.kernel.org>; Wed, 21 Jan 2026 02:34:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768991682; x=1769596482; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=khQYwC02oSbfy+3LuIFAy0kWRZbUYuB2+Far+vrEWYs=;
        b=e1BIbdQmuPQUJWXpi5qQ7hs/qPXI/lJv+RWbchuRo8nvmBhIVs0Q5hWSAck3dvz0W3
         nakcJGpT2hd+NWeGlhlulEjgF7TOHGgc53fOJI6UsmxzG4C9FO0bDlPAsUfKzFDEVRSG
         jCeBFZCP2wBY40XsVWPd0gJKzWopf9NEB76gW9eMiHeZtRNja414utYxUtOHkSULjHoP
         AgbfXlK9hH9bmMYwQRrmv4nD6LKCZwgcu78oNB1DICBIxtoeEaDX2yA0gQJdNYwkt8Rx
         CTk7EOBwmFjJUYmVmSB082qCHKr93l7DEbrUsruqowvICAxiHdb7iazHTrcsFt5S7zNT
         FY5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768991682; x=1769596482;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=khQYwC02oSbfy+3LuIFAy0kWRZbUYuB2+Far+vrEWYs=;
        b=pEEbKbRE+K1+1vPCuPEmjWHh8J0qsYHmxG26eYBu736N3k5wg6062RCu0mfg5msRWB
         osQzTeGvnbe4T7dVfOSxh6EF3URowvPAjeOZjcD7ZzcVyEfGYLOBcBTMwC1JZTsuzrm4
         nGAgOMoYa69fLXFAj4VlZlnnqalWfxN1qbwuPryrwLAuqYcMYOaHFRE7e2vJaX7iIaN1
         pMhKlI1/MVRxsXY26ilK9rBbZQ+znH1niguggQruROQqXWv8ZZP6OW6PVvDAgJYeC8TM
         qVZ2Mh8fcaE9pOsmUrqLRnl3bpPQOYUL62xA6BkrF9IaJDNoJAS+JXEuSzZM3lMdyyDp
         7Alw==
X-Gm-Message-State: AOJu0YwQdNSDxmTAQbTaVL4HZHDQHBUcN3gmKIbovVpf6j+vGp18AAVt
	Sm1I6GPaQJR8eBMzYHlIxWg+y4eugYwnEKHW5ByLwmdOfdsLaLs0QfIA022vDw==
X-Gm-Gg: AZuq6aJACGbYfBHfByNFlhAVO6NU00aA7OJhubCq+lj4I1T6SwHyS10V+FD3dsA9UcX
	2Yws/9YswHPfm4dvpwyKIE8EB9CDHe4i6iHzsgM6xDxX+48FswvzZ+mVZFmEd57x+9PBhaDhhFE
	CRkUcMSkEZoHfXMzJbU8mZ7p7+LFpsfKOAKiCH07unCr7vXZj3boNhm7XxUZxkY4l6aH5pqkhwH
	9brHEPCxZ32yN1jTWMxanTWzNySjDlDh5PByvlgShEuoiKqzB8ll9mufsPSbRzJhF33wbbIK+bp
	c3PGv6uw+MtauMevyeAbi0kou2y57tzid8Oa5BRIN2neXyCGb1QlItBkAFSwuUzkklKTe0baWru
	KkUD9Ia/G0gHMSsQNBQ+LD3C6FQUPylIFYFBvt8d0GgGfcqhrl+/CvSRiPgZkAHuv7rG68GVAJH
	oE1lx1TcUSoj717v1mqqW6cuxYkkByqsPw0I5nhcDLipf1QTVv8LUm/ek3
X-Received: by 2002:a17:90b:4b0a:b0:34c:99d6:175d with SMTP id 98e67ed59e1d1-352c3e83a77mr4143672a91.2.1768991681943;
        Wed, 21 Jan 2026 02:34:41 -0800 (PST)
Received: from Shreyansh-PC.domain.name ([2401:4900:1cd7:6181:4ac5:7f6c:c462:4847])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-353191d8f5bsm916268a91.13.2026.01.21.02.34.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jan 2026 02:34:41 -0800 (PST)
From: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	ps@pks.im
Subject: Re: [PATCH 1/3] show-index: implement automatic hash detection
Date: Wed, 21 Jan 2026 16:01:47 +0530
Message-ID: <20260121103431.793004-1-shreyanshpaliwalcmsmn@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <aXCJp_rGPetsXE8J@pks.im>
References: <aXCJp_rGPetsXE8J@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit

> On Tue, Jan 20, 2026 at 10:07:42AM -0800, Junio C Hamano wrote:
> > Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com> writes:
> > > @@ -71,6 +60,40 @@ int cmd_show_index(int argc,
> [snip]
> > By the way, what happens if we find SHA-256 also broken and end up
> > choosing another hash function that is 256-bit wide in the next hash
> > revamp?
> 
> Yeah, agreed. The index unfortunately does not carry sufficient info to
> clearly identify the hash function that is in use, and second-guessing
> via the hash length doesn't really seem like a sensible solution to me.
> If we cannot tell for sure what the hash is, then we should rather ask
> the user to specify the object format. And in fact we already do that,
> as we have the `--object-format=` option for git-show-index(1).

Yes this is exactly why I was peculiar about this patch and the
TODO comment, also why I sent it out as an RFC.

I initially assumed that in the near future we’re unlikely to move away
from SHA-256 to another hash, but I agree that relying
on hash length is still a heuristic that won't be a good approach
in the long term as well as it creates ambiguity in the large files
containing 64-bit offsets.

So should we drop this thought entirely and just make sure
that if git show-index is run outside a repo,
it should throw an error asking the the user
to use --object-format option rather than silently
falling back to SHA-1 which is the current approach.

> I think if we wanted to fix properly this we should rather introduce
> index v5 with a header that encodes the hash used by it. Like that we
> wouldn't have to guess anymore. Whether the hassle is worth it might be
> a different question though.

Yes, I agree that the best fix for long term would be an index
that contains header encoded with hash, but I guess
it would require many changes in the whole pack index flow.

Best,
Shreyansh

