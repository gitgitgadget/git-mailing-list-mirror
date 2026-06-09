Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3635C275AE4
	for <git@vger.kernel.org>; Tue,  9 Jun 2026 13:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781011415; cv=none; b=IrP6ITlDH/oX1XYDGzJ6iPY8/L41xH1lSsTHXg8BgXaABg9TJE2JWQcSxgu95x1SlYi5bwJewOvxGihInbI62i79vQPUnoilT/t028i44gl/xdC4UZZqNTrycmZxXRDxvDIjwYl8pHCQD8ySHfjFZvYBHM3C+cau4k0VWIIy260=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781011415; c=relaxed/simple;
	bh=XwOYV6Weu+/iq/d9W7ThSb7cWrlk4S7DiS1mTA3D9Zs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OrLpTbtUlDJxMXtGNesIGK0X3lFjKrZcIzf3kRylXxIj3ByuGeUyJpCt3xHgISIKln9IhzqjajOxbu15wSZnyfCs8b1wg/4TIExcFJL25V+3PkT648K41xxONwyEWf8MXzk/Qh7YurMRw2QNQjB8FaBG7dQCnGBiGgfDxGAH8QY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=bBQnhjDN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DyC4bS3V; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="bBQnhjDN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DyC4bS3V"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 60C5E1D00093;
	Tue,  9 Jun 2026 09:23:33 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Tue, 09 Jun 2026 09:23:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1781011413; x=1781097813; bh=OQelTvycXI
	K9Dyp6rS943kQfH1Mold0wo2SwgNJKHK4=; b=bBQnhjDNy0qGxFdjdayjvUfpxC
	oBrdfa90fqHVzZ7jn/TmZnls6arp2vIpL6FjsSqc8dDiBW5PJumALZA5IkGGIfIE
	C41oklcyr++2gi4JCpGIDMl66x46Z6gYRGA5HaZxb+w15wvhUnrfgl20ywIhkyni
	vNrSa9s/gbIInzzGDgQ5iJEo85NTc8U3Qf3Fvlsi7e1+snCTZ0vnMgSmd5eMtQY9
	fHy58k7ZULtd9mGlCXNUxeQ//tywNVeEedNjeaFcbGTPkDZ2Db7SXhxUU9B+PxGz
	xN+NZueaKfl7SOslKYNPupbX9n9/hfP/0AKgFHxQewznmkM99XHsqVvPLBmw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1781011413; x=1781097813; bh=OQelTvycXIK9Dyp6rS943kQfH1Mold0wo2S
	wgNJKHK4=; b=DyC4bS3VWAWfqNpZ+aSYdleJl4oO+x6bBBvNHcFCAMIvh5NvZog
	Mebu6y/GvxHO8kV+f6j0ztM8CGg2NxXb2UdmfWqkl91UlE1/5Di44dtVO0xsAk8N
	VQrjFQcXcEqKpFecOSopQp7MeAYZaNZq1MViTIEcCF33OXAmHANZwOTpKNvhdm4U
	SJOQVT1l88fzUuU5KK4xNW7zY9sZYP76nJI3BwZWJvfVhAJ9oGsQjnjcrVc1Qj6n
	7IZMv1qe9EiNwdL1vvd3pzuzna0sFWEIm/YuABgAfMF2qON01yDla2W+kFEvR9rE
	Fpo+RhBiLEPx05NKutJPcWiVCRt4YFuKIZA==
X-ME-Sender: <xms:1RMoauxmKsMxEccrGDuj9O7zdg2yBFipJFShh4GnTHzOPDPTsZxgwg>
    <xme:1RMoahLBQtZOaWQDVhLx29GTF4zjZSsoJQ3aGUytmMnMNfD2N5efkpRogBd4XTICH
    n5V4iaY0ODUyLKdCah_LGqk2dOA25TLnyt7UHISa4G-iY38XNlcAA>
X-ME-Received: <xmr:1RMoaorzjG84bQejArN_-pEGx8oQ6F9LTnc3ZQUIApJnnXML4CFkgfcVKSM_wyN005wPcOi9uHS8odDf2OV0xra_B0OkUNglBQ9J>
X-ME-Proxy-Cause: dmFkZTE9GwDoh5MN6c2eDgX1nsGjR8iq4tlWoj71OEwQKRe6CfqBSM24fVmdljkS31lFdt
    LTyu16Gm7++SZc1TI6mc+drbq7I4bot/2i6su9ra3QZGOn3Z1QWPg2wp8KXjWJ6RKpgqG5
    vu5InqwZvZ3FSTNhxQVT7QPYO6+/mQtol0LIdISBzEgA7YRmSMEg8U40J4+/qQ9LEZbpU+
    NdZu6jukKoZKOAL3w69bXa1NokqIGe9THiFS+5Z3RhAG2Pf26YnYRbhvD9H3dJv9WdktHX
    k4ao6dGFqplXukgaNU8vg5Vrme07Kdtg/3/ya1jIkwkz7SvRdk6fG6zCt8iteherEFSlgV
    EjTVyvfODuuyCF0QxcLUSdSopAtXe3ovvULf7uYgqvm7TAwMi6CXN04/VlpLcEi8KFwiv1
    XbbglZsXrh0lxYGh+UHR/hcEaogc5aZ2EXN3GXmun4C2Vz7atMVZN4t/uK6s1aWl0S+Ozi
    aqGA/Em0Yf2VeeS0ofYhPpfFOyv4JoXulyjdYzcZNdV7Y7EbEe5opJHXd7YZDWVQbGJg4r
    Vvxd0hcHD5kRbX2h9p6DC6J9AsEMO2Ox+aijX667mqMfJXRZoEy0XIVx23UIYR6SGjGz09
    V+ZPg3k0k6Y1QqMwgmepRtinZq8zZQ8ZC7wgBFbpGKIl5quFj+eRJZUYiRFg
X-ME-Proxy: <xmx:1RMoagLYqtaJzUFJ6HYANdCs1JXU_0URI7KlrC-q4KDKlhd38Niu7A>
    <xmx:1RMoatSBvfdrhy39hDZdkGFXjdEFlcEjK-XWQvGKZ4YKiuV8lc0lYA>
    <xmx:1RMoavsYwUkdMa4afA8z9dY_PH8r0V9BCsdrnJsNuuXWpjCSO7vyYA>
    <xmx:1RMoauZsRutOqhcDH5qh9PFtiQ3HA6YJD92iqq_I3bCA_XTFyGXRgw>
    <xmx:1RMoakHi6WUeXjQ8UfW2i0dYH9Hy0uk3sDctBMBFy8YM6Xcg-mHA9LLo>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 9 Jun 2026 09:23:32 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Tamir Duberstein <tamird@gmail.com>,  git@vger.kernel.org,  Patrick
 Steinhardt <ps@pks.im>
Subject: Re: [PATCH v2] describe: limit default ref iteration to tags
In-Reply-To: <20260609110957.GB1509396@coredump.intra.peff.net> (Jeff King's
	message of "Tue, 9 Jun 2026 07:09:57 -0400")
References: <20260608-describe-tag-ref-scope-v2-1-256fd36dca32@gmail.com>
	<20260609110957.GB1509396@coredump.intra.peff.net>
Date: Tue, 09 Jun 2026 06:23:31 -0700
Message-ID: <xmqqpl1zsv8s.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> So while it is perhaps reasonable to document every detail in case
> somebody later wants to verify or reproduce timings, it is a little
> overwhelming when trying to tell a story, the core of which is:
>
>   In a repo with ~120k refs, ~300 of which were tags, running:
>
>     git describe --exact-match $some_tag
>
>   went from ~170ms to ~10ms, since we no longer needed to iterate all of
>   those other refs.
>
> That has _way_ less detail, but makes the point succinctly.
>
> I dunno. I am not trying to pick apart your commit in particular, but am
> more interested in the broader use of AI commit messages going forward.
> This kind of verbosity is quite common in the output (from my limited
> experience), and I think creates more work for reviewers. Should we be
> expecting contributors to make things more concise before submitting
> (either manually or through prompting)? Or do people even agree that the
> shorter version is preferable? I could be the only one.

Count me in.  You are the one who often gives us a patch with 60
lines that explains a single line change, but I haven't found these
60 lines are _overly verbose_ in the same way as AI generated log
messages.
