Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A19F83A3E8B
	for <git@vger.kernel.org>; Tue, 29 Sep 2026 07:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790667015; cv=none; b=dXkFDUObqE9C/8mZ4NhpzufemqMQLGT/YLZRDrVfc+R/QGw+PY5nqhwwdVwjzNieFNeTauJk08+YfsAQ8ZYabk7hVAhx7kLoLz63WaO/d0aVpEbxYqkIQVgfRg7/ateeW9wHWPdENKVTLtG80H0FmEOxuKXYOwxbCrWQ+uAtCdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790667015; c=relaxed/simple;
	bh=Qi8A/9Ng1uBkDkyQO/Bb1n1QE2pS2X9vZQJdg4Y7LBw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=b9NP7FVKocZeEPbejBD4IcB47Dxx6hiu5mQsBPiRrWizV10PYk5bqXSvqICLxihMUGZe6rodL0h85DVFl8TX/FRf7DJHxqtzuBf4bmPT+HHi9thETcjj/rl+WKvKRacUV7GbVNckLLHaZVJqyLgssNJoaCLHLKzakMBjnXBJnng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=uOcTo8g3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=v6DSpLm4; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="uOcTo8g3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="v6DSpLm4"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B72C97A00C2;
	Tue, 29 Sep 2026 03:30:12 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Tue, 29 Sep 2026 03:30:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1790667012; x=1790753412; bh=oVxSiZt3nx
	c+XzkgtihZnCTYTbOLEEzPvy/YuQBSov4=; b=uOcTo8g3iAuS7SOLPfIGRVhj1/
	QEjTC8QhutV1IOtsfHFrq9RuYCCmv9B789OVLIZSmoNJfN/IHc9FH4iy/kynbd+6
	fWMxe31RIsIvsnDCm3uQ8VX4+f64uWNTw3/k6biTYXb2Of+a5OFq8iPuv/4QW81H
	7GBglB3LN5PADKaHd3zBb+W9G8khS3J9onuep70P7Bpdllu4jSdRdCunu9KJcxQu
	6KD8s8oonG7UuNLwNRV9QWTmp5uEtOehochf2KmzDMjAWSmIi4Vdv0d8SbtAgf5V
	12fq026DBuCWqpGl18oBV2hJrFOkreK0CVbTs5N3fYeiXbRATzzqKj7NrkhQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790667012; x=1790753412; bh=oVxSiZt3nxc+XzkgtihZnCTYTbOLEEzPvy/
	YuQBSov4=; b=v6DSpLm42Z69DCBlD9nodIG5DM+Ql8NraBRHtFxNNZVBwVKCHTH
	xz+Ni10h4hyEK8o/fLO1Qe17inpa0cH0L0DsqHeeuAtjEptHNuCug06uy3X5dzsc
	3ETOShSgw1W0d/ESXWqBx/T4kfXnPlt9yPZ0x2uRC3nbvQ55zbc4LduPxJi2l4yJ
	l4VzLQ3T5vC3inu+HeoJ0XWPYG1pcF/NsclmD43HTz2ymMZWU1oY0Ycd677XOaTb
	e+p5V+f6wbBcSh+iL0/695o22mHQiv+L4duTUA1RZYuvk5bXoNP3+FIfjDVI4H7r
	YgIL8c6+ZZvcfBfwAye5/X6osx2FGyfC+1A==
X-ME-Sender: <xms:BGm7aoozeH_L1vFhTpqjXXbl9MBBET8QrSySPVOvdUWfLt3Av28Amg>
    <xme:BGm7alqu4taL0VqHEJjLDCrrAb7gfrishc8u6Nh_GtLN6KtQ8rjGGI8uGi2NuV31M
    g0EqAPehraWjznNwPFlCpQt1SMKvl6svzJIFw2osuY_tOJ5Ur8CqQ0>
X-ME-Received: <xmr:BGm7aiMmC1w9HI1pQwQtJKPuMibQCiOD3BM6gbvFSfjRqYFDHt7cDqFkBNByMiWruA9as8tBX_cFnGM3WrDerVLKp6zIYZr_RLX_>
X-ME-Proxy-Cause: dmFkZTEvQT8Bom0+VTwvnVn4TpiWtJ7In8fgUvK7nR3ZmgjVZ9/FlrwaEp1i/yXtg/PnuR
    VgCFO3AGPkl0ZwjN+UI++po2vTXSqKngKBTXA5EW3lSZfbPA4oaAmFyoF5es+H+duh0osu
    VvpvvWFvNGnACFGp3Qcgd6kUWKGlckXGZiiZtvzSqCCpmo4xqrqD4Dgmaz05UNLPxqfLvC
    duLM5W1fk6SKpLhSzmjkxO2wNR/hl3QeZhySW+VbRE2L5TDTSQQnhtku/cJDTRuI8TzjIN
    lEYUrp2YnX62y52DNzNNTchkFKVArYSZJ8TvQG6huGNEOr2cPyz5XqVWI90f7jK45cgXd7
    Yt0TMMXYAuXNzwo+Bl+/WJPlf9bfsU3WCE/iPUFFWHEGSUq1TPryktMB/TBNamHuj/nF6P
    iafuMaD11V/jZs6wu581aMThi2vm0G3c2x4fZhru6ZL4PNLAGwBnKO4+hCztlaY01OtNPu
    tHVXNM5howSzYeNunxeDY4L7Ab+URB2VFZS1ZuePfwyjmqSAwoc/nyKwS50RX+dTs2LSmL
    KCotGS0KMSJaEByC7RgIvZnPjuBKIIjnXoPt4dRaWLgicEVF5XWaMcXQwWOUD5K4/TFfBE
    e7qRpYD00b5ObEHpuMLoZW7MZwO++/1l08x7UCSlZhf7BK/ov6Ghaw2F1nCg
X-ME-Proxy: <xmx:BGm7auy8ZpBW2qbnnVizgoLHbJXZde9LdSEHPN4j7y6xXP8emEKPrA>
    <xmx:BGm7ajuuS0jdiPt80oTCIRh0gzRwfqFAMGUXEb0GLyevT4mgUm6xQA>
    <xmx:BGm7av5-vN2v_eHpTlEnjqej5WbcwK8oPSR3Js6P6b_0UzuH7gTx6Q>
    <xmx:BGm7aqRZbaHejghjtfIOAoqe2Opy8aVptKgvTAKy4JHpC7tYTkSzmQ>
    <xmx:BGm7anmNCd1oMpOXyjBXppbgk0AJhItquTnluv5FjpOFZxg-_VmUc2Ql>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 29 Sep 2026 03:30:12 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 0/4] Add a compile-time option to use the new, very fast
 sha1dc Rust crate
In-Reply-To: <pull.2240.git.1790610691.gitgitgadget@gmail.com> (Johannes
	Schindelin via GitGitGadget's message of "Mon, 28 Sep 2026 15:51:27
	+0000")
References: <pull.2240.git.1790610691.gitgitgadget@gmail.com>
Date: Tue, 29 Sep 2026 00:30:10 -0700
Message-ID: <xmqqa4p0jz0d.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> I stumbled across this new Rust crate last week. Its performance numbers are
> quite impressive. Naturally, I want to make use of this and get for Windows,
> which is used on many monorepos where this makes a real difference: In a
> pretty fast and loose test, I verified that a git index-pack runs roughly
> three times faster solely due to using those SIMD-based optimizations!
>
> As a safety precaution, because this sha1dc crate is quite new, I wanted to
> introduce an escape hatch: core.sha1dcBackend=c, but turn it on by default,
> which is the reason for the three additional patches. Should these patches
> be undesirable for the Git project? I would not be mad at all if they were
> simply dropped.
>
> Johannes Schindelin (4):
>   libgitcore: add `sha1dc` as an optional feature
>   sha1dc: allow selecting the C backend without rebuilding
>   pthread: provide `pthread_once()` shims for Windows and for
>     NO_PTHREADS
>   sha1dc: make `sha1dc_init()` thread-safe

The feature sha1dc_choose() means that you can between Rust and C
implementations of sha1dc pick at runtime and I was confused by the
"compile-time" in the topic title, which is misleading.  From the
end-user's point of view, being able to choose between the two at
runtime gives them a lot bigger value, even though from the point of
view of the developer who added the feature to allow users to do so,
that feature being a compile-time choice might matter more.

How close are these two implementations?  Do they implement the same
idea but the details may differ?  Do they both faithfully implement
what the same paper wrote and given the same fudged input they will
always detect the attempted attack the same way?

