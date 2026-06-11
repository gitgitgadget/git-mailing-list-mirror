Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97E672E7F39
	for <git@vger.kernel.org>; Thu, 11 Jun 2026 15:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781192909; cv=none; b=gAJ6xOYiTHE7V3h016wK5lZqfwjrr9DVaw1TWs9NRMBhncv3GwYic0J+tQAbTg4K1rMUNFUxf9S0kRqvcAF2R9VucCm31AGUmcuVlJlCqUlY0v62nJDVsbqNIEN0HW0Wu72Vpwdma7cU6gx8KdUfH6zSj+oscsP7rhNJ5WSmkzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781192909; c=relaxed/simple;
	bh=p4ygP9B7xB/FkZJd1+SlSxP3dy6vr1teM/z3orP3YRM=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TzPV0/slHXzg/q6HlLhrZyhDVeJF7tmsu1EIOy1v6FEsPxjRRBlo/mvU+120L4BYj4WD0McV4/1+BtDbVuIKmj3SzzpUZXHqnYJlIe8AY3YXgW0sypGSlf0kuQ/+M/5cb2fl7p5xlWpja+lFklUhyVAnjPEVvS446N6F09sZogM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Y2DEvzKr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UtdcCoyt; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Y2DEvzKr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UtdcCoyt"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id E1D1DEC010A;
	Thu, 11 Jun 2026 11:48:26 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Thu, 11 Jun 2026 11:48:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1781192906; x=1781279306; bh=Bk504lQTKn
	/Cd6SYNZ+qTFuQT3u/8VTIJGiGWdguVg0=; b=Y2DEvzKrYf9Iz9CAPKCBmzzz2b
	EwTl8kUQW//vFsz99hfcAFdc3cE+svpq9QFKcrefFa/SqQE5kr3JGUzrCp79Hu7z
	MuHYB+dYTfJ8joLaLV4kayON3JMn+G8Al3/7Z3dkUKwfTG/f8DrPkWRZWpsrqixA
	ttYVYGztGAQ33xxJOAYQCqrFFPvzRO9oQbIvMGss5VcqtzdIP7wK/68EP4E2FT4X
	sypycouAkrD4xe63Jnfw8abI895fgU3GfXy9Us3yT2A7n7/Okd6lcV7yffKMrUsN
	LCK5G8CixeGf5pW73QnUKRcZsAVAo1Liag2GXpf/juZyVUwwFDpiCL8wcnPg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1781192906; x=1781279306; bh=Bk504lQTKn/Cd6SYNZ+qTFuQT3u/8VTIJGi
	GWdguVg0=; b=UtdcCoytIVJT8mUltPk1wxCQ2naCAmmY3yIJ7wsCXJRnjXdQGCS
	Ep+A7RW/zdXb6zAY/uXANgjDzivEPq7xQHAdcchotgbVbKZASGoUuxQnvQtoo3NT
	c7xpigyj/n6VfJRVKPp6dp4e3GxDaMgyX0626IXpYZczQRU160w0T/MaOgc+rkwk
	jKpNdHi5pteveRi5hXSeozK/IpkGihJlWMnlz58805NCoQJTNMQQl4C+cJiNWrXC
	tP+tXCsrSifSSxMskYGq2zrdpIUbgca5uuGBFMqHlFVNIFzMwhkLjTj3IWnSad6f
	wpJgL1iglZZic0hg4T5wIKFVwqnV90Dt5tA==
X-ME-Sender: <xms:ytgqapc3b2OsHHyx7rt4PYZDdYoEDyDrrdTT2pwLDCA_wpeFbzvKKA>
    <xme:ytgqatP0E0ybjxzzf-Ps_81pCbEpAkPmILKJecKJ-8OBOBTgYJ1J3kKUQxpEIFKji
    xNEUnf4TKLDPdf1-EKm5kdWKhN2PT0_GYUIwj6Na-vGjHILs6F5Lg>
X-ME-Received: <xmr:ytgqagLGQTMiuzsvjmzljM4Ar13JH9pzf3qu0XKqO89lv_rkF1tuE6nYSLZUIhhbz4i4MJI7hGJtS7YFFwYzm1nwS10dSJTORsa0>
X-ME-Proxy-Cause: dmFkZTEqh35bwvR3aRbp+PLYUNLOpOJfvY+isaeJLrte8NnMAl7muDkhe2N/+r9TuSVdGV
    XjcTkBXopaMjQSa6tWuJM0ydIS6u71xbtR0HOD4VcXfpj1GAfFtsgXrFuiheyROkES3cUb
    fIbi6TAJKe9bcrIxxC2y9Yb4wGS8qIyxmu2WtEUOXGhFXDflCvLk+6PKvzFB+Fl9qYUxiQ
    tz5sqeFWNciWSzx2yLlpgH/lBzBbhp0gJl1m79LzHqNEgWJ5GmQktgNLqgdh2qxj9iYANp
    fN2Xk0G4NLgB0q3rMG88O5zQGPUxhkJE1umObgz0xbZyFB/GR5wKcCDCi2f9azwrkmh/rJ
    HHoxROmgZb+64ndoLMbruul3oUAfwwqjBeKhvjklEDE3xrDypsSN7z2ICSqYn9CoxoYDn4
    7KtbLA/jL2fb7BsJA1sFO1UU/mlWA1zzGFQSOlkzeXdNmU7k0YVeSEjfsfDLOWs+APBsRS
    nHCpEzbn4r9mSPC8ulaeMKxe8HffQwhqUB4AWxKCLCjXva3k1JT6e2U3+hIT6KIRUr6qDh
    GndSJwtrRMINne8XGv3SbCGVj8gQRAcudG02zp5vUvT/1FmYCEU27YaEzzplZm3fLoUogE
    RrqyYMb2DYr/mua2P6JO08I6nLuGhu7ABCL2qx85ShwwhffCQtLRWVxJh/SA
X-ME-Proxy: <xmx:ytgqauFjmVjZL1k6RfEZbtUgeiwLORZ-vseqA_sSogy3A2I9HG5zUA>
    <xmx:ytgqaoQqPqR7qcYckgf8A49oKilsAKb0h5T0O-9Pq5_I3mjSZYMInw>
    <xmx:ytgqaqGd8g9XGJ7bciz85oeoKixYUbJn6hkdRJkrTHmp2A-CARtGkQ>
    <xmx:ytgqak927I1a8ifXVIAk7OYUAm2b1z3xFL4TH-higiz0EBtwKlRgOg>
    <xmx:ytgqak3dgg5T26DExawC0nC7uMRxuwZUTlasFfEuX8jqIkSToYElaFfX>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 11 Jun 2026 11:48:26 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: Shipping 2.55 with stricter "neuter sideband" topic
In-Reply-To: <20260305233452.3727126-8-gitster@pobox.com> (Junio C. Hamano's
	message of "Thu, 5 Mar 2026 15:34:52 -0800")
References: <pull.1853.v4.git.1770113882.gitgitgadget@gmail.com>
	<20260305233452.3727126-1-gitster@pobox.com>
	<20260305233452.3727126-8-gitster@pobox.com>
Date: Thu, 11 Jun 2026 08:48:25 -0700
Message-ID: <xmqqzf11oz7a.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

Was: Re: [PATCH v5 7/7] sideband: delay sanitizing by default to Git v3.0

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> The sideband sanitization patches allow ANSI color sequences through
> by default, preserving compatibility with pre-receive hooks that
> provide colored output during `git push`.
>
> Even so, there is concern that changing any default behavior in a
> minor release may have unforeseen consequences. To accommodate this,
> defer the secure-by-default behavior to Git v3.0, where breaking
> changes are expected.
>
> This gives users and tooling time to prepare, while committing to
> address CVE-2024-52005 in Git v3.0.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> [jc: adjusted for the removal of 'default' value]
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  Documentation/config/sideband.adoc  | 12 ++++++++++--
>  sideband.c                          |  6 +++++-
>  t/t5409-colorize-remote-messages.sh | 18 +++++++++++++-----
>  3 files changed, 28 insertions(+), 8 deletions(-)

As some of you may have noticed, Dscho's "be more strict about
control code sequences used in sideband output and pass only the
ANSI color sequences by default" series originally had this "but
until Git 3.0, be loose as before" as the last step.  I kept this
step outside 'next' while the remainder graduated to 'master' for
upcoming v2.55.0, hoping that it would give us a chance to measure
how this limiting negatively affects real-world users.

The merge of the stricter version happend about a month ago at
7760f83b (Merge branch 'jc/neuter-sideband-fixup', 2026-05-11).
Luckily, it seems that we haven't heard any complaints after it
happened.

So I plan to hold this step back indefinitely (aka "retract this
step"), which means that the "neuter sideband" topic will ship
in its stricter form in Git 2.55.

Thoughts?
