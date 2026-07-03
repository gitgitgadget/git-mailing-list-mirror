Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB446318ED2
	for <git@vger.kernel.org>; Fri,  3 Jul 2026 05:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783057011; cv=none; b=J2AmUU1HbwswDr2keOsUk2GX4YCJTm5d0CZBS73+Nc4EM1rSdr+pjqUYnTgEiVtn8Br+5Nw+bO0fuVmiYiHBXW0H3AUn9p0GQfvUFkcAVjCypQLyqeLgYh0TreqEVMAYsq9NIt7LsrELOMLigu050OXItOsobD42qYKja/OQO48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783057011; c=relaxed/simple;
	bh=WnfbS60/Kh/4ve6HTgE3hiQgey7b+Jg7TYvlQGx7okM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SETsKiTCMZClpo9OjOHSmhp19Y0/l4IOaUZP00EC0wWGTOJrR8wbfr7B8Yroy/1kI1EU4U7oYU6AI6kP/ikx6U/FUOXK6HxDwzBbMnCLKPAU+I/quEIVxwwqMoaaRcB+TEeGCoScKxiacGmzqAQfXJISQqiV4jJBKtiJlz4AgDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=uUfpIEj4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XQinBLAF; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="uUfpIEj4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XQinBLAF"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id AAD1C14000A7;
	Fri,  3 Jul 2026 01:36:48 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-12.internal (MEProxy); Fri, 03 Jul 2026 01:36:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1783057008; x=1783143408; bh=h6sLHhLSCz
	d3kaPHKWXZgWti30+XpY0FKf9uXHu/Hoc=; b=uUfpIEj4b52+WcZdOR+UhWm+wb
	lWEZnV2lLOsvqU+q/ArkUXScP/QDcuAKb59UObGK7AVjEVUg92IMG4ykSvS2J9lm
	wnyh0Z+vP7G4p+G8BUpOmaC1EaN0rQPsdBpc8qW1zdnlkFcYyLKXk0WL1rm4KB8g
	bdJePwhsbt9AwlbMGAiWWjwOa7lzXopNJvvkFciPE5W+ZQCQsqRQIv91AmZkQB/l
	h4lnzXSL7C6zoKW/qOLooUCNNWBfHHWrVids1aCrQivkg7AZWn30lwHm22y0vasN
	KmxbgdlYGhR6y5LV/SHmVQUMzpIiA2S0ZmwVuoCxxa+dPHWLErw6lMpspRcw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1783057008; x=1783143408; bh=h6sLHhLSCzd3kaPHKWXZgWti30+XpY0FKf9
	uXHu/Hoc=; b=XQinBLAFjR8l8+S1Gb7uYJ6+W6u823f65bb7fo2yWznMosjS1Pr
	JUpRSBk39RdaziRy+BA6hEPzr6oROlK2wVPtKXWyGIuxjx9UHXSESUtXHXlNpeed
	GCUMyeGza760FCfh/MkaY78ksilpaf7Fdb1A8jBldhkDRhfIP664wQTVsBAOmywr
	80SNWu7Ix6aeS51S2FPQS7Eau53yKkU9Dh5IvR4YkehQgY7tBmIFQ5p1PeYnfbrl
	AEiB3D7t7kfDg+QnaY5kr799wq/y0UDMnCvOpZD0Zs1RxGc70MoGJ283SbxMdrTk
	iTR/plGaYCzoHnuSv4RIPumXmwRND1Zjl+g==
X-ME-Sender: <xms:cEpHalE9e91qN_jlSKcanvDVHOQpX-o2hKbDFCjNQiZEw71kfNwXLA>
    <xme:cEpHauAircLu3n4RfJ6zq1SGsCknGL1lLN0lhnWQgNORHCmAMIjp7Lm0S6PhLMnRV
    vYvpveQt54wX2fSJBwHs4Ug1GXUPlPxxfIrqkPEDfpl01lgTZfIag>
X-ME-Received: <xmr:cEpHag90UCCj8vRusOHRf_kyn2IdNl7oYOvixFK5Joc6pQqjJ4znXZ2LS1sBLUL9wALDFPc-Za9ibua1kLdMRDBw2iybCTNa4hJzL2g>
X-ME-Proxy-Cause: dmFkZTF4qQ4Ym+TZ/j8/ZaQGANnHx5jkHEfd5swHukHI+jG3xHl5bwvHPHTHAmdfAke+uT
    zPPrZJCA5yYxNL0RD8wU34LHPopKWgwXLgiD7z5M2Be7jA08j/QA7ZMjgc2GF46iREiq6V
    v2Hz1RAR0tv26CvOuhIyXJbMumaLrO6yS78kk1x630/dDVYXzvqtaLK4h2Iw7AFvVUtKn1
    BmuxiuGDxYIsyGenK6S/AUlQ4SdKtXoFwvIWEk0G2XIvwvnZEeSdDVtTpg8lukTzYBr6jD
    uHGhPVjrQ5PgEYQ1fRrmbbteEkaxQ2yhS3lqJRBYMlxkEGd0K8eGVemv9yf1H9dCE7lTAF
    a2sQukozOq8Ck8Q5KA8CNXkoEFo5jGIuUYwpE0V6Lhr4gNx0mq7TWDAsT4zqlRQIEh7grn
    23mtpkyplbIjCaOg1RoEIzZW0DkBjlOHrVJrQTGuDZU2YwL7PM6BHKh9FvrA8UzNnZb4l9
    nZUXfVs6gTDoh9GK9Xec0sP6p9XaNXbfaokHv00hWBickwzLgdIRfakGzknw7kokdKh79J
    NifIPc70Qdoi6zfGOShOZwe6PwIKdxq8PbdWfYHUvY60fYCPgNOkBNnOD4LXDx6NfOR9vk
    qcj90IdEiWbiBBhTb0bSp7TRCyeQPOjgcPC9O6cLKj0fPO8XqXCcNbFE0zOw
X-ME-Proxy: <xmx:cEpHaiBUSO7qVbYhb-__qD1_EFAzk-aCfQOVh8vMcgcfIlC-s1JdXw>
    <xmx:cEpHatRgViSeiWXp0-RyGNUPo-RNw71SiFb4AbG-aSJn042YnSYUXg>
    <xmx:cEpHahvRZb5czkwAm9VQFqlw8jRE-iFXYynMbbw40AIblypl0BFUZw>
    <xmx:cEpHah3BJMgQ2mqQlOKnX3Tcz2FCQ0oN-2SaEa3BjCPRhQyDvUQOcw>
    <xmx:cEpHaoADhYViJS3cC8QTUoapb1JDnk36DZdh4nrG2CvoeCeabRVR_K1l>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 3 Jul 2026 01:36:48 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Shardul Natu via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  Shnatu <snatu@google.com>,  Koji
 Nakamaru <koji.nakamaru@gree.net>
Subject: Re: [PATCH v3 2/2] Makefile: support universal macOS builds via
 RUST_TARGETS
In-Reply-To: <257f5ef42fbb2841036591657e740872635df49b.1783030971.git.gitgitgadget@gmail.com>
	(Shardul Natu via GitGitGadget's message of "Thu, 02 Jul 2026 22:22:51
	+0000")
References: <pull.2288.v2.git.git.1782943303219.gitgitgadget@gmail.com>
	<pull.2288.v3.git.git.1783030971.gitgitgadget@gmail.com>
	<257f5ef42fbb2841036591657e740872635df49b.1783030971.git.gitgitgadget@gmail.com>
Date: Thu, 02 Jul 2026 22:36:46 -0700
Message-ID: <xmqqldbsk51t.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Shardul Natu via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Shardul Natu <snatu@google.com>
>
> On macOS, Universal Binaries contain native executable code for
> multiple architectures (such as Intel x86_64 and Apple Silicon arm64)
> bundled into a single file. This is standard practice for macOS
> distribution and CI packaging (such as internal distribution packages
> or tooling like Burrito/Homebrew), allowing a single build artifact
> to run natively across all Macs without Rosetta emulation or
> maintaining separate packages.
>
> When building Git C code for multiple architectures on macOS, the
> Apple toolchain (clang) natively supports universal builds via
> CFLAGS/LDFLAGS. When "-arch x86_64 -arch arm64" is passed, clang
> automatically compiles and links universal binaries for all C object
> files and executables out of the box.
>
> Cargo and rustc, however, do not support multiple "-arch" flags or
> emitting universal binaries in a single invocation. Instead, Cargo
> requires invoking each target triple independently (e.g., passing
> "--target x86_64-apple-darwin" and "--target aarch64-apple-darwin").

This is much easier to understand for those of us unfamiliar with
the macOS ecosystem.  Very much appreciated.

> +$(RUST_LIB): $(RUST_MEMBER_LIBS)
> +	@$(call mkdir_p_parent_template)

The leading @ is a bit curious because among ~20 existing use of
this pattern, nobody adds it to squelch "mkdir -p".  In fact, the
macro uses the standard pattern to define $(QUIET_MKDIR_P_PARENT)
that does the squelching when $(V) is unset.

> +	$(QUIET_GEN)\
> +	if [ $(words $(RUST_TARGETS)) -gt 1 ]; then \

Recipe parts in our Makefile that are written in bourne shell, the
CodingGuidelines apply.

    $ git grep -n -e 'if \[' ':(glob)**/Makefile'

gives empty.  Probably,

	if test $(words $(RUST_TARGETS)) -gt 1; \
	then \

would fit better.

> +		lipo -create $^ -output $@; \
> +	else \
> +		cp $< $@; \
> +	fi
> +endif
>  
>  .PHONY: rust
>  rust: $(RUST_LIB)

Other than that, looking good.

Thanks.
