Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC78241C31D
	for <git@vger.kernel.org>; Tue, 31 Mar 2026 18:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774980575; cv=none; b=DznFB50kSIlzYHY4AX/1X+JpkINU7BSQuZa1mlEskGEvdp7J1/9k35jIKRCXUd0Jk9V3lOqMEXFv1jY9l1UDFI/fbBUiwf2tLNtxTSpuOZIItMfU5ENRLdXLZZ/ax3d+REgCXEaqDmKdyl3ISnkXE9gzqpviW9UWCcmgBFXe3Fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774980575; c=relaxed/simple;
	bh=B+r49FJGaZq/bGHQlmVmQMHigJ5KxXcYsBlTZ03UZDI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tT2L22P9GC9LPYIAyhLqvBiKkzVRvMzDIQaFiZDo4iAWBU/SjKjeQBgojedfDSrTJKHbxbU9vj/ld3GS089KxDmvSurpt7AS5RaN80OBmE9ByK4AgKfVOz+WPOlcA49z8iplmY9f6DgGjYqSb07ehJ7ScpbMY4VUhlGIt2aX8P0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=H+Lbn/Ho; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=suZy0ZxP; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="H+Lbn/Ho";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="suZy0ZxP"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 618E67A014A;
	Tue, 31 Mar 2026 14:09:33 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Tue, 31 Mar 2026 14:09:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1774980573; x=1775066973; bh=MQ/RamC+cr
	E5YKHygXre1xseIzgnxLGmrc4eNel9Bhs=; b=H+Lbn/HoJQ4njhss0kWAm0PipU
	pmNC8WYqUMQMcJ7ziFur2zUMssozPRnk01H+WXTqJUejnI4fbKwxTzHRsyMmYKl+
	kFMteWrAYQRS62arpNm6xiEAAlP1QQd3sQaLKyhnIjxAaPuresgy9K03lkaGSHlF
	u5LrtMErQdB9ycB9Ne8YhNzaXCtcNrsQtZaihvnOKyHGLqgQdpBx1AX/W8QV06+k
	q+L4B43kGbbXPsFxYs3RZ2W/LIqAB4fY2CFL2chRb4n7z9l0FTgLbzyKxHeRSkC/
	a4LFhdZJndBjUpcYTmHUMypIlRyWuk4yCt/SF2bJcsy51hqP5Bkzy3wEe9iQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1774980573; x=1775066973; bh=MQ/RamC+crE5YKHygXre1xseIzgnxLGmrc4
	eNel9Bhs=; b=suZy0ZxP2IZdRrrsKDvo4cx2zE2GnN3IEvdlQmfoYkfe+3uqXjU
	3uQOCYyrO8PPtMk/J8OCwLnMBIFpwjYqs6m1JeHNRnOwN7Ia6ljwwTHBCZs5AO1y
	fTlcpcWd0fBwZhDTeuCjSn8DcJ/2gPubYelv6sw/bF1DZ6gMNfjz5KN6T5jxxN50
	o4au9Esmi8zWl7xem4AMo0HLDCAQ5NNYJ8jbiKGJibHkqS5EK4tNw/qjT/hn7jb7
	qsZcVHsba3gftIji0OquZQ55Hs7SLfNUSo69NU9Reio/w2Lk6DnJ0yWAqZzigsxB
	PT2vedaTWflERK0CYlogxNPwVK53WjMKhqg==
X-ME-Sender: <xms:3Q3MaSjYf55u15qt8NUQ9EMmtF9CFV0nOjFurZFV10il2s6z_-e_5g>
    <xme:3Q3MaafwVP8wpltbU7JXjAgHyr-q8YoTBoDzqqN-aUFrhwO719apPDAOEE0Xwcgy_
    ibAJ-E66R6zFqWuT0rlhfqHnQQ43lbgf87HQfvhiDUEEdZm4H8guw>
X-ME-Received: <xmr:3Q3MaXeJ0udVQ-rJYW02K1VA1sG60i0N3HKfeEx8MUr4_ZOIsHMFwt9xcWXUwG8wgqtcwmIrPagIGx08ECeZ_b32eAyvZiPlzQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdekkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegrihhl
    ohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpe
    fhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucevucfj
    rghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtthgvrh
    hnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieegieen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtsh
    htvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhp
    ohhuthdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepghhithesvhhgvg
    hrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgt
    ohhm
X-ME-Proxy: <xmx:3Q3MaU_1o7BHUrQmRJl488fcFoDXeTxsJbVHGozkrsd-B97soBAI2w>
    <xmx:3Q3MaTnoaZV0xBAAg2FTf7cyJa68AnX6vfeHEgDlLxYKHOa6jrWOwQ>
    <xmx:3Q3MaW-X2FEi7oTTN8dEQecbcGa6TfUJxapWF1nV6DcZNjN77RYaBA>
    <xmx:3Q3MaRk-bbvKYk6PNxF7Gq-hZGrLY5JpnyVucn3iZnGfQST2iSgGiQ>
    <xmx:3Q3MaSm-cIED1VzC3823mUf1mNAhcri1wbSY6zGrDr9n1mHE89tYOq7C>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 31 Mar 2026 14:09:32 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/6] reftable/stack: don't call fsync(3p) unless provided
In-Reply-To: <20260331-pks-reftable-portability-fixes-v1-2-46bfae55c68c@pks.im>
	(Patrick Steinhardt's message of "Tue, 31 Mar 2026 13:26:48 +0200")
References: <20260331-pks-reftable-portability-fixes-v1-0-46bfae55c68c@pks.im>
	<20260331-pks-reftable-portability-fixes-v1-2-46bfae55c68c@pks.im>
Date: Tue, 31 Mar 2026 11:09:31 -0700
Message-ID: <xmqq5x6b27ms.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> Users of the reftable library are expected to provide their own function
> callback in cases they want to sync(3p) data to disk via the reftable
> write options. But if no such function was provided we end up calling
> fsync(3p) directly, which may not even be available on some systems.
>
> Drop the call to fsync(3p) and rely on the callback function
> exclusively.

Hmph, reftable-backend.c seems to do

	refs->write_options.fsync = reftable_be_fsync;

in its _be_init(), so this change is a no-op in the context of our
system, so this may be _safe_, but for a caller that wanted a fsync
to happen, returning to it without doing anything may be a bit
unexpected.  I am wondering if it should be more like

	if (!opts->fsync)
		/* BUG("whoa where is your fsync callback???") */
		reutrn -1;
	return opts->fsync(fd);

instead.

> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  reftable/stack.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/reftable/stack.c b/reftable/stack.c
> index 1c9f21dfe1..f9ae832e3a 100644
> --- a/reftable/stack.c
> +++ b/reftable/stack.c
> @@ -33,7 +33,7 @@ static int stack_fsync(const struct reftable_write_options *opts, int fd)
>  {
>  	if (opts->fsync)
>  		return opts->fsync(fd);
> -	return fsync(fd);
> +	return 0;
>  }
>  
>  static ssize_t reftable_write_data(int fd, const void *data, size_t size)
