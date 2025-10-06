Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FC8824E016
	for <git@vger.kernel.org>; Mon,  6 Oct 2025 19:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759778416; cv=none; b=i64eeVAw6gSSg5erfVTyG47NFZzN30RCTWx1E8ir0rWARdNhX4yUWjNhZlCFrzwYJzJLN/YKHHppIxwp4RhekhtseYtXJtccJSoU//vuQv7xuy160C+0XTRfkSku0OpKgxCxZiWojVv791jGX8EpHS9o9QmCh2Lc47yy0jZCkPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759778416; c=relaxed/simple;
	bh=6/tTMddyvOYV6ShVTvbxdYObdP7oIkeJDNzxYyTB8Sk=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Eo1yPT8lKiDUNttYRKWkqKs6HlsFbTp4G6XdZ+p72ynaRzF2kvUhdeO/PdWzv0QLdody1KI9TK5KMxq5is8HA1gPuOZLfXzctQvbLulWDWC+NqqkgorMWfxybcgh5T1c8i4lBYuQ69YvZ8DJb1URfs3c0IqR6UXGBPHvkFbYX9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=MWb6ENDj; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="MWb6ENDj"
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-91179e3fe34so265537839f.1
        for <git@vger.kernel.org>; Mon, 06 Oct 2025 12:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1759778414; x=1760383214; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4Hb/MyOywy13rbRAea26eUdvF3C0TvacyCCjn3H3yGM=;
        b=MWb6ENDjP6G294F5Vsuh03qkPD5qLLW3i5XJt8tK51NvoBaXdGFOHGKX4KqRXRce3Z
         jv6peMNOpmhFKbHuTIyn12QzouS61gaMp+Uydk/mATBX//TvlyEIH7xt2Lt72VNjhtE8
         6+a+MIfCvGYq0SVCS6cCVAmDSr7zO8u7DfSmisqzj4FkA/PHtkkhk+kVp30rk+YIdURp
         +bfBCxIMrEgYTvz5CDs7PXkoAE/saiJio7u4s44+5hsnfvn0nQO63RJ3TW9GrVsctYfn
         d7DjNV8COqU7t+H7oSq9V3hM68X5H7YgkOK8FADHs/QwrEIbDzDKK18fzoEL4TN8d0j7
         m53A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759778414; x=1760383214;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4Hb/MyOywy13rbRAea26eUdvF3C0TvacyCCjn3H3yGM=;
        b=rzcXkD+IS7pNCgrvgYgg1kRFFfnsRmITcCr9Kofd1sm5wrYIWck15Me4M/+sOb6Pip
         NLD2BE3grNi3xhh5YfyatFTZEBKjObL9O+YwwTijxvGYre4zw7+l8WtRn1BYtBW+2EOM
         bajwRVwv/p0SpqvouoAyKd91oijluqY7kZGNWFXgqBOkrTmSAuL/w2rXhvJBNTDW1y0g
         Zv1nUqgiaX+xkGxxcamDdxsj+/d2VzCm5XTfARIx1+tpe9CGds7mn8IWg+u7tX2LxgZF
         nLwNTqq5BtrXqT52bLGyyI3N6Y1jRv87sFOHBLywoCJT8WGeYzLWVrix/z5Qvmb8tJmJ
         97IA==
X-Gm-Message-State: AOJu0Yz+sf7pDO4+596L5zb2k1/eRLAp6wXXZaQ/hl/jgBIfTxpLX9Yx
	MBWExW6xFYk1a+DqtuEd89hOSkqhRRCbqK3AffHO7oF58wYcTnh3hJsrk98qbb+0HfBhBC/xvCj
	vRJphsYjWGg==
X-Gm-Gg: ASbGncukc4TU1EkX57nib1EGOPho/GcmGUWD6u74JXjOPEFihG0Icq5uzWTNQ2R5sCh
	brApbXmU8C52ESaCc5+r/gd+Lj8JzYgHHvZszk6jg9q8uw8Lm2D/RROO/BpTTni+GDODgf9u/ZV
	B+OkTVZ+Oa9abY5ducoL57YDMtGnahoMVtQFXUD6nsda/AHTdcXgO2LpSuGVGUa6hbrEmDPgPEr
	nTpyB2ucOjoVkU9vynwM+ZG8C7ia8O8IpVevCybrkQMVe4QUg79088X4QVYdfu1JkgqDsB+u/Vw
	l5d2TADPwsztvYEcxWejKY4/rHS3AH8raD8zfGsJEMRS+sWcyu7o7N0hVN+dRUs2iLXL0lXlza8
	xvjPcdEQFBdDV7QDvnXKrOwr44kplX80MNRGy/arzQDhm6zqsNAZZW4lNyfsZQfo2fRgpXXqa/G
	K7W++h/X6eh0ySsxWOxXgGy3/dunGWDmcUkJRA2zvPHw/B0pU9Z6vLIyFSdgdW
X-Google-Smtp-Source: AGHT+IGmx2SayFO2L4l4fiomiIxbyHEJGfb+L9tr5pR0xIVavPsdHMTvjABDacaQC95mb9LhoelNjw==
X-Received: by 2002:a05:6602:2b8d:b0:91b:605f:1f0f with SMTP id ca18e2360f4ac-93bc40ca19dmr127390539f.2.1759778413914;
        Mon, 06 Oct 2025 12:20:13 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id ca18e2360f4ac-93a7d81c1easm508989039f.1.2025.10.06.12.20.13
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Oct 2025 12:20:13 -0700 (PDT)
Date: Mon, 6 Oct 2025 15:20:12 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Subject: [NOTES 08/11] Resumable fetch / push
Message-ID: <aOQWbHzstGKiPUnc@nand.local>
References: <aOQVeVYY6zadPjln@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aOQVeVYY6zadPjln@nand.local>

Topic: Resumable fetch/push
Leader: Caleb (was Scott, but he's not here)

* Is this only client side or server side too?
	* Applies to both as GitButler has a forge too. Would be nice to have protocol
		improvements.
* Both bundle-uris and packfile-uris exist and at least packfile-uris are
	resumable. Both are fetch-only, so push is unsolved.
* Could use single-threaded output or server-side caching to make pushing work.
* Maybe make it so servers could receive a bundle and make that resumable.
* Use cases: Pushing a repo for the first time to a new server, once there's
	good large file support, android/chromium. Also a problem that's independent
	of size in environments with poor connectivity (some countries, Caltrain, …).
* Servers could hand out some kind of opaque data with the fetch to indicate
	what it has cached, clients can re-share that when attempting to resume and
	the server can choose to do something with it or not.
* GitHub support has told people to create a branch with N commits at a time to
	fetch.


Scrambly notes (Jack's notes):


* Specific Forge implementation, http based communication -> easier to set up,
	keen on improvement to protocol that allows large pack files sent between
	client and server
* For packfile uris at least the pack file part that is in the uri is already
	reasonable, for bundle url's may not be the same, might be low handing fruit
* Taylor: push side more interesting: server -> already sent you first m bytes
	of x, need something to send the resumable push
* Consider implications as an attack vector
* Brian: git's pack implementation is deterministic if you don't do
	multithreading, could use returnable mode like gzip has unsyncable mode, for
	client side pack a temporary file, this is resumable with an offset, and since
	pack is cached locally should be something you could resume with push. Some
	possibilities if we cache on the server side or use single threaded output
* an idea from pack file ui which could help solve fetch problem, server provide
	url to the client, let the server be the fetcher
* Emily: that would work pretty ok using a commit cloud server, already serving
	those objects. The server side can resume necessarily.
* Servers don't receive bundles, so would be adding support for server to
	receive bundles. What's the real use case for this? It's worth it's own
	protocol, not just a push protocol. When we try to mirror things in Gerrit it
	fails due to large number of refs - would need an enhancement to handle large
	numbers of refs.
* Caleb: So you suggest some sort of TCP protocol for handling these transfers?
* We have user stored binary and timeout uploading to server, it's not just
	migration path
* Having some way of guaranteeing forward progress on a push or a pull as long
	as you can get some smaller unit of data transfer, don't know how small to go,
	but would be very useful
* We talked about chunk format before, would introducing chunk format, small
	enough chunks help?
* If it's small enough and reproducible
* Elijah: Even if you have small chunks, if they are part of the same
	communication, if they're small enough you'll need to restart it
* If you have to resume now say you have sent X chunks then you have N - X left
* Peff: All you need to know is the byte offset.
* Elijah: Take the objects that you have received and say "I have these objects"
* What if you hash what you got, "I asked for this", the hash was this length,
	give me the rest
* Peff: Has to be able to regenerate everything from scratch, are you caching
	it? Kindof wasteful
* Doesn't need to be cached, just needs to be stable, so if there was a way to
	ask for it in a specific order
* Disable multithreading


* Peff: Looked into this with resumable clones, server can pass out some cache
	tag, here's an opaque tag that may or may not be valid in the future, I got X
	bytes of this tag can you send the rest. Becomes a heuristic on the server
	"I'll choose how much to cache", git doesn't need to know about that it's an
	implementation issue
* With a pack file uri you stop what you're doing talking to the server
* If you were trying to brute force it today, you would brute force sending a
	ref
* Peff: GitHub support has told people to do that
