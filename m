Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90F9A2BE7B6
	for <git@vger.kernel.org>; Thu,  2 Jul 2026 01:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782956149; cv=none; b=Tdvpd36gkUOKBfU3vt1zL9J3T4o1iG/e/dhRTxnNAEniOoy0W9N9HCnYtLTofSl/sFAAk8m7R0jfwJGLzRpi0+/P9Oarkie0hotLmcsMxwSC4EZaqxxfhF2mFP6pggVjdJ/fASz8RFdmidvlze2g4KfqzCJJFeWFZZRMIrBdJN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782956149; c=relaxed/simple;
	bh=l5P4qV2gqoy3afIkxGwrtHkIkHwhwpyKlqD7ztyAsF4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LlTCKGWGjHhaiyVDdWm+iCGRd0T4YoRm6mmgfoE3Z/Q34Jm3mib3koNZ+H15lrTL1uTTtNo7UOcFAmK7iPfzSYM5rDergNo4V3BAAGBX6lQHDsX+J/MXRgE7OUZmZyCrGjvRqsG+4w6Es+BHgnI2TZsp1jCQt/XJP0lYrb8Wco0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=nCw6bKvF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=P9T65OiL; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="nCw6bKvF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="P9T65OiL"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id C83D97A00BA;
	Wed,  1 Jul 2026 21:35:46 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Wed, 01 Jul 2026 21:35:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1782956146; x=1783042546; bh=ZGlrQS3lT/
	2+TgnvqNBV8wctuOywsuSdEgK31ogYde0=; b=nCw6bKvFV7Y/KrBBteRc4mgMF5
	hlkOgD+mvFdsDfSakX0QFNgE3M+g2+mD33gHiczEXnHhmJogokoT9nLcAKcq8971
	9wNYJ0MJ/ADelj+cZkHpCaOgopkFGLk/JSe5xBa0dF7WknfYvgIv9g1pq/bJsu0h
	mSQjlihX7CQuRU7S+dyKqjBv6zDKymyzEazQERigjIGHPcoKYocUFoies3axKLTg
	dCjGo4qf9INw7+cRQfFBipy7Sxb1BceSZYNH7lY2TlsK5rkSdXzIM7QhKk1iBhlk
	9X/m14j2b5EbEFrkFBhufmMg3B/U4yG/p74fYKjbvyOD4UiTAFdwi1FW7IIA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1782956146; x=1783042546; bh=ZGlrQS3lT/2+TgnvqNBV8wctuOywsuSdEgK
	31ogYde0=; b=P9T65OiLgwPZR/+280Aahp0YiaMqlwbjOiRUB7khHZJS3713G9K
	+U6XfRmpAA3MFK/slcl3BumhLX4z+JhP5Vbuf6bc40zyqa9p43MMPqW/p1rH/tln
	f3mrjtvxAujwCUNse29rbgJcuAXTXdxtUCDXqY9b1zdQUOyDpq2gZtmYsVVtudF9
	aOCyxh5S3+71IfzEOpljNTS+hAuPmNlVbEwE35jSKLbFiGiasWmhQqfXsYiiuDjE
	xdcq++1bPlOdwwc7b5MkAArD3LBqqacY+reEs9AMWAzubAASbyIdYpY2AyW1GZuv
	i99hy4Cc8+EC0+fBlwZnIUlpOULvbsnPmAQ==
X-ME-Sender: <xms:csBFapzjk5UciU8bVC1hIPhlXEQ1kW7o_tUCcoyPkBEvpQqX-G_nEA>
    <xme:csBFas9St6HIXDY6cuzO0PZW5D81miK7GkYFh75xGpkCj76vgGPzep6szTtH2keUy
    fudyT5K4cNjw61Fik2mRZ6_tr3ik2t6Wz2D2IDayWfGfyJectKiGFk>
X-ME-Received: <xmr:csBFatKWC7H8zhQH2aPrJwj3opzzebBBXyed-mSbhb0PuFR4uVY2XyqTnIOmBzRX8xUZIbg0_3-rHyOllg2sS47wadUfC3YSTXwreG0>
X-ME-Proxy-Cause: dmFkZTED3pPgjS9W2YfJQ/5Xni5PvBQb2bKfi1nCu6w1YKjXP5P5WlRR5QQEWo4gkC8WB+
    /jTlIXu8nXWJUarHfH9dqYzg+xZUXVEkNP3FC4GGCkvVoNtY+HI9TeRetHUxTIZjmSU1Y2
    E1BBJMAnEEw/aEnZ/BOUBlCQWhfQ8d5SMq4stJ5CAwvtaOPowHkeHcWuDHXeDkfHvgEMp2
    9MlvN2IYJHbfhqDwaqzPWWa5JcGsbF1rehm5k3jJXh3ndIkQb6F0z04jUeZxhhF4imDO9j
    zRR5hQpjZg1xXH5MNvZpsM6LWhW8Cx8OPLMiaat9srxUwS9hdFKkuzZI5YSIgei6nfmOCs
    4F2YHwWuIpYwVVxuWr5ItY6FOWlG7HG8MmdwTrx1ubkJd7UvbeHIdfYQfFHTqFO+K/v4OW
    76mgNcRQJ3MRz5UbmzoBL+TpDFjOzQyFmqfkogi8kJx/osoHMXPq63HIFCDceAB2lqdQkE
    HZpeoq2vouQLus8wVX3Z6pDIyHq4pKGnowTLLL8ez9/3wiW74DdRqcXDlhpWwQAI97EL/z
    heYAT1JuX0uMVKGWG/+UttGVGabcT6/ymepPfWvkTaRClSraKutDY1lImqKbZNA4uvSkIi
    yCP1dpuXdU7oLQKH3jrZXl0cPXnM3p8SjWilSi/vG7xFQxlrUjevWQA5bUEg
X-ME-Proxy: <xmx:csBFaidT9dQUT4x7_oFgbE6Pgg5krt5P5i8Ma3Y6YSz63dLfzv5CMQ>
    <xmx:csBFas9Ak_XPPlkjl7DqXzqrLlPAbq2O7w6GuOwhTnDJnhds5l6N7g>
    <xmx:csBFavqw8KsXNa96szpGxN8ooHqJsJESTqxAz_-F9KPfPFesB3kC8A>
    <xmx:csBFahBt_HSW8VxHyMj0y6hR_ixmcv7Qml4aHt-Gs3F9yn-d_GLpaw>
    <xmx:csBFakMcqzygJ2q-ozuWtxGl3-Yno0r1hbn8uEPZ9Ao_KQFledpcdea4>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 1 Jul 2026 21:35:46 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Shardul Natu via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  Shnatu <snatu@google.com>,  Koji
 Nakamaru <koji.nakamaru@gree.net>
Subject: Re: [PATCH v2] Makefile: link osxkeychain & support universal Rust
In-Reply-To: <pull.2288.v2.git.git.1782943303219.gitgitgadget@gmail.com>
	(Shardul Natu via GitGitGadget's message of "Wed, 01 Jul 2026 22:01:43
	+0000")
References: <pull.2288.git.git.1778001976709.gitgitgadget@gmail.com>
	<pull.2288.v2.git.git.1782943303219.gitgitgadget@gmail.com>
Date: Wed, 01 Jul 2026 18:35:44 -0700
Message-ID: <xmqqpl16kwb3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Shardul Natu via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Shnatu <snatu@google.com>
> Signed-off-by: Shardul Natu <snatu@google.com>

You'd want to make sure these two match.

> To implement this cleanly without complex shell scripting in recipes:
>   1. We introduce a declarative Make pattern rule (target/%/...) to
>      compile each target-specific library slice (e.g.,
>      target/aarch64-apple-darwin/...).
>   2. We update the $(RUST_LIB) recipe to depend on the list of
>      compiled target-specific member libraries ($(RUST_MEMBER_LIBS)).
>   3. On macOS, if multiple targets are specified, we use lipo to
>      combine them into a single Universal static library at
>      target/release/libgitcore.a.
>   4. If only one target is specified, we copy it to the standard
>      path.
>   5. We enforce that building for multiple targets requires macOS
>      (as lipo is only available there), raising a clear make error
>      on other platforms.
>
> This is a highly elegant and native Makefile solution that avoids
> complex shell scripting in recipes and fully supports macOS Universal
> Binaries.

You're the second person on this list I saw who calls their own
creation "elegant" ;-).

> +$(RUST_LIB): $(RUST_MEMBER_LIBS)
> +	$(QUIET_GEN)\
> +	if [ $(words $(RUST_TARGETS)) -gt 1 ]; then \
> +		lipo -create $^ -output $@; \
> +	else \
> +		cp $< $@; \
> +	fi
> +endif

Do we know that leading directories to $(RUST_LIB) target has
already been created at this point?  If not, we may want to have

    $(RUST_LIB): $(RUST_MEMBER_LIBS)
   +        $(call mkdir_p_parent_template)
            $(QUIET_GEN)\
            if [ $(words $(RUST_TARGETS)) -gt 1 ]; then \
                    lipo -create $^ -output $@; \

on top.

Thanks for making the build procedure better.
