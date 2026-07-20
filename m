Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF129371D0A
	for <git@vger.kernel.org>; Mon, 20 Jul 2026 12:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784552380; cv=none; b=b+t8Y9PcfSUOxbA6AEWOpDRnc26+PdTSochkC2Bmr4+Akp07nH3lnUUwxPHG8leU6M/fgG0afN2buG5FrlGzGnOj9notolPeR1zqhOfVQOssSo7DkFuM7MHl/760/UjDreabjCWuXlWAyrI+NRxZnIgDneA5b6Ps9IjITLKWt34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784552380; c=relaxed/simple;
	bh=/hgxJJHZKzSLfmsxi9D78DJ9mxUU7VYCuwYUxVKRLu4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tgOfMarSMaWoJJNxBt1ny+vFat63nUGcSUjcnu/HOF7h1WL/33xqGzCVlkQuV/zRhM8UhUSIxY/FvT74BVy9X9cZp4P7fc0dDod56IWZkDIgri+p61c2kJkY70htd3IhBTzyr+E268Tfn10HE/kHPCxm9x8ksKZsrsnKCeqzf1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=l34PHWxe; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SAXhHAYb; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="l34PHWxe";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SAXhHAYb"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id BDF73EC0184;
	Mon, 20 Jul 2026 08:59:37 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Mon, 20 Jul 2026 08:59:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1784552377; x=1784638777; bh=TIRZ1MAc9m
	1c234Jyep2WZbiPjEs3e/EZ7Fc/MHYGds=; b=l34PHWxeTT8Nq7rJaHjVAGlAQE
	pIOnhEuwfFIjv/7Q+owZ2djQEO6OEqPH7Gi4h27VrH9XVieVQjrOo/FWqu5SXvb+
	4IKkxha2/fQYDM1Zhe0tThkfetjeW4gRon2vc+jtzcE6x2t7EdzO1kdK0UVuOS3P
	qG/VufFPIkdOelqhHgFAY59AYPSD1WGkCFwGWRH7WAPSZj0MSx0EE7goGNxk3q2J
	w68mWXLWJo+wOrQJ27yJYDccLb1+TZatRbZr2OVEI90yUnfDo0Te7j6Uo6dPZHry
	ai33RaTMXi2Pij5QoQ+F9aRls4yi4zDjxfU/C/oNlcBcJ1UBvuElxIiDGfpg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1784552377; x=1784638777; bh=TIRZ1MAc9m1c234Jyep2WZbiPjEs3e/EZ7F
	c/MHYGds=; b=SAXhHAYbrAdyo78FpTXnvBURWod1FIEZH9MlrmG3IW88ntOHc42
	X8iYATmVV0RKPouhbz6Ln8jIR3Yk1EuBlL4tgpe4WpJzQ/1n8SFtq7XwD+sU0/oq
	q9Mj8h5kM4ZrTs3IuDwqI+CG0pEEfKgzIJ0BUruJTKnC0/2f5Si7GAbMnFMDb0ik
	ZxE07GacJ2i3cVp8OPM+VX0YqEgawiRdvKN7gP9N56qg3EzIvHNUMJlTgAQtoTx1
	krSgJLGbJ2XEw6kyXh3P6MEPubcW/X/2FO5Ubyw4UkMLseKTJYBYf7GV8mQKP++E
	yj9tI4yCjWUxfUvBJanKTt1w+MCr4hw+60Q==
X-ME-Sender: <xms:uRteaiGq58iJbebB2DdZO4sLLiE4IJ1OkoBM2JyI0VC9oLSD8WlaNw>
    <xme:uRteaqwNu9NT25Te1ONGvGTrJL4pfZ8vw-l4kZhiaVa9s2NW5y1wdWZlatieBiws-
    a6yibaGDtQhTxNg8CKyD9sXec4G07Z-ugMmReAwj0E-gMW-K6VlQA>
X-ME-Received: <xmr:uRteaphi-yuhX1PSFw3z8OAPZrbMVh5Dvn_PPoMsHEa6pLIpxaZ2rztMD0NDWqt7mFc7AzjoJYuPgcBo9lco0J36Qjq7pnIx5A>
X-ME-Proxy-Cause: dmFkZTEpYfRAmQQ26TohuGhX5QXUej6NphuW6PogCQx0OOB37XPKQN/7RIgaf8THGAMh0y
    z6nl4XOUJscSu6nTnNCg/FKz9csN3aAu36EZUKznNbF0KRH2sSptK8SRRvK5QoaEZ8dxIi
    nlvTtOQNCkt07q9JXEtMYTaA7IaPighQKh88wSj+bLd/qQNfUKMQruVB5lIofA4mDBil7X
    +QSIkib0h4ACBUq3mBBPkMbPq9cb3mqL3UiI7aCZ7Md536+mFwtDVllVtNn+1grDQVbP5T
    VizIqHVVIJ/XVPQTn2eTjaG2rFXxk376+Kks5qwtgzvR1juDs/xUJLCJ24ZrjbJM+VNJQE
    lAjV+AITva97Asfp9ehQwdo8Q0pihjleIJMM5O1vUI3h/iPtv83Khh6WvuWuu+kU1WLj29
    VwquRat/tr0XIRME8r2g0+9ZAoaac8RKuXXNZPkdon6++XAVwNKOwNhmebpZlKBZdxVMXw
    yTl4YHUhLh+GwKxZti3ERu8bJeyCN+MXWcvo82RyDPteSgVXFZK8M3Dy/KWiIA3bykoyTV
    V53PXslUESHhlQ6Khmg1dSnl5KuMZNq9sXzKPBT0n+DkZHC/DxCDaF04GLGn1IzEpE4a7c
    Uv6DxJlp5HEUnJ5oSNGHzypGrDsweqeT/GdpUIYyCDZH/x1Okysns+pdeqYQ
X-ME-Proxy: <xmx:uRtealwOiDHOHJCW8y5eWxoDUiQLUY-1DF7-93Y-yV2aeehsdtOImA>
    <xmx:uRteasJABsNnn1WVK-Yk6wXEM_pTOtHjpdrTP9hoLwWmQ66sfeZB9Q>
    <xmx:uRteasRfQaG5jygjzVuCxnLdqhDSdwKGyFVZw7wWH3DVqwSn9SRwLw>
    <xmx:uRteakroYhN-f3XsZGt3p2oaGPyluoAPCXISDaVcjqIgmsgPxir9nQ>
    <xmx:uRteauwG9geHi3dlq9uiuYE20ji8lf8Jjdid0aIg8T_eM9HsAkTQMdRu>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 20 Jul 2026 08:59:37 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Chris Packham <judge.packham@gmail.com>
Cc: GIT <git@vger.kernel.org>
Subject: Re: import-zips
In-Reply-To: <CAFOYHZBTAGiugQVOJrc4kJQkuhcSDiT1ruim7A1+6EW1iKAUNQ@mail.gmail.com>
	(Chris Packham's message of "Mon, 20 Jul 2026 16:31:19 +1200")
References: <CAFOYHZBTAGiugQVOJrc4kJQkuhcSDiT1ruim7A1+6EW1iKAUNQ@mail.gmail.com>
Date: Mon, 20 Jul 2026 05:59:35 -0700
Message-ID: <xmqq8q75izpk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Chris Packham <judge.packham@gmail.com> writes:

> I wasn't sure if there would be any interest in taking the changes
> back to git.git/contrib (or if the use of AI would rule that out).
> Anyway it's there on my github page if anyone else needs it. If
> someone wants me to turn the changes into a series for git.git I'm
> happy to do that too.

It is wonderful to hear that a piece of software that has long
been abandonware now has someone who 'cares' much more than
anyone who has touched the 'git.git' tree in years.

I would rather remove unmaintained pieces of software from the
'contrib/' directory, and optionally replace them with a pointer
to the location of a maintained fork.  So, no, I would not want
to be a gatekeeper for that part of the 'contrib/' directory
when I do not have a particular need, interest, or the
expertise to properly maintain it, if I can avoid it.
