Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DB78402B8F
	for <git@vger.kernel.org>; Thu, 28 May 2026 20:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779999164; cv=none; b=sk4l71ODqS6BtkcdPGX/SZaVenxAAR1fqko7tup8m6eZ6izFo9x6kc7r9SQWcUSGE/7o1UyAH+F68XyhUvp0wa8Q7MxpXz9Ueu09eD+BntDjaOSP0DWMq3YjxPAT0qq461mLtCF4KUoLtS7wWt7vHj/TtvKA9DTKY3puaGrkf5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779999164; c=relaxed/simple;
	bh=vdjZ2kFwVNmjXGJSU9f55o3hVOrvOH11BdFUbEQlIMk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JceZ4MZ92Ruj3gnoQ7FheDRFUPlZqOFjMLl8O2tCwmv7qrG/C72VYgd+qyKQmKI6Itzt01dYLgoiSVtciz8GrIi4tuiCYv9bKE6DSDSI67YUYeUlOPwqDQiJH3nOd7tKwRvJTcX3WXS2BJvfos5wdQDptd0/dY3vNzeeRdcNG2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=gXpNUzks; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=u0lf2FaN; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="gXpNUzks";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="u0lf2FaN"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E15581400060;
	Thu, 28 May 2026 16:12:41 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Thu, 28 May 2026 16:12:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1779999161; x=1780085561; bh=L8eNtCa0wK
	chBVmT7+p5/siDRWLuhBKdtvp+ruIwE7A=; b=gXpNUzkskwzCo/Kt1dZqo9euWo
	jLzPYYAdcyaqgwngz8p2xO3ocON2WdZAFEZzoVdxZgkHOd5UOrQMvur8tb7lTuxW
	3LRNsx6ClL3wKcAAFYLn4oSM08h8ztdkUQiE8eNso3kInPteajMeK+miZGNgougv
	BbgOhUGwObBV9MMKQ6K5onbZbtzYWaZQfazczkDuK/0NRxKxgSqvPEw268QBf7W+
	vCucjjItpKO/U006Id4NethZrQxA8BUmNQ5cur8WZ+erOQAPnV6uv6cvIuX/i/uo
	lYhccd31CAMLHv3JBk2no9x5f60VQV/vn4t5AwHtCdkZEd9CytesBS0FKrUw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1779999161; x=1780085561; bh=L8eNtCa0wKchBVmT7+p5/siDRWLuhBKdtvp
	+ruIwE7A=; b=u0lf2FaNG56fS9+7oHogSgwmG4A2KwsxfI9VBba5jnnCDD3oP5S
	PFjhKZKtQKzUO3KjHV4r1LVT26NR+dEEWgkBCNsfcpZBFMCfdcIdV1d9pzOZLagn
	AeO2NGOir0L0N8h84c0rLlQFwhM+pFNYAVrtH6SwND54LGPY/sNOLtvvq2gdKPcL
	+b4r+28Tk7hL0oC0KHHtSQBYqxShMTZAXatEQm3Ix5z2XTwZQtijDUepyCtpabso
	gyx1OtvHZl3c6fLZ65cjQy1VwmX4yYznzAEKNtE7Y0gwdytFdwt7ystvgv4tA6Y7
	pZPezZZEa8/nJUEuT4lpAld2Xyom2mjqzoA==
X-ME-Sender: <xms:uaEYahDaLo8YuPkxHwLMIxVohTFsxaWLfFijGzkgQrJ8cWSJqF8weQ>
    <xme:uaEYamj5y1jj_oTFb6yMNc3WLIDNrYUvIk3Esqw3QdrYRQ8CO6nRFwlMV04UoEsCB
    7jyr7gdars5THoDPKpYIW3pnh0zhOeoJqDMauCltqUpwT97JG0v>
X-ME-Received: <xmr:uaEYahmvtpojUIt7lRuZB_f9Z4_901nsoRNBF3xMAYYg_stKkkSZ-2iCZ_UywSZPenxI33gMEEBNjcL0FtJybkoyygZ47-0zfuFb>
X-ME-Proxy-Cause: dmFkZTGDdy9KlDOqBV5MwUSehpu7sRxx3Q7UhZM1RnCcEscMjAMWAXiFi5xF9Clhy2cMXc
    YutOijk4KwEi7LZ6tHxesnIkZf+qkqkbC7VttLH9DBokn9gnuk2OHkJ/EBh8SZzbIgbT2f
    nBEqIr3VWA16nrFYQlb2wgry4iMvmXngRZGjB3atQ5hbXS9vZYc+cFTOl89OkwOyKb7vZF
    KhN0dfna4PnfDv/tj1ZddRFNpKcf4A8IgJRx6pZQr6MyvSv0rzLSBqCzXdXhL19a9BCW8B
    jaToGN8hbsYesalrRinghvfTbOU/OR1d+gyJCQXxiyPd+6QUBZRYwgMRz6eMC+48p6F+UA
    O9QqhgaR9DRlu5Slr/YDa7z3gMblV8OJEO5XUTuhI2FZQgLgIcjxQRXq8ePDBl2iNotEqk
    /FQtVDX0u8C9MZfX97MZOs3ldTeGjZyk9j+1srGBm0D8qrKoBc8GihLcIdJBRDvddBk1GG
    BEYbc/dLM4vhB1XhZ/bogUY0wbxFQfVSfLSwvTpWH8900YqnwTLD/c7hoUah80I5Aze7hf
    GfxNbc5HFSY/oS+aUstpEH9o/6gKS4KYiMuu40gKYIjwKS9c+qUiMnk3YJ2nNbL2IIoy3U
    +v9rNTtxCbVMFpVOA/FwoUoB/USDoJdDdgEh94qqhVIZglAKb+UKBdUHzcJQ
X-ME-Proxy: <xmx:uaEYaqoRRfP4Z_UMEWD4e14tO_5Pj0y6iBlRJ7BBr_m_Jx7RGHSPbw>
    <xmx:uaEYaiF3QASeBkWEbSF4ejEgZnq5gEBJq9Cr7PPpNbjxjxlYzH7MiA>
    <xmx:uaEYauysfHkUoYHTqXqHO0TyaLS9nWvQgcWbqO1wkfIqg6m7csrNTg>
    <xmx:uaEYavq77FaBbT79lxsAVwcXOSR3JB7TqQHXGlf8_34-NvUxnhuFYA>
    <xmx:uaEYapFOKUpKUIqr-fFVYVsoYgr2pC-NN1vR5JINu6PcsE5lCVhVqnlh>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 28 May 2026 16:12:41 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Harald Nordgren <haraldnordgren@gmail.com>
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org
Subject: Re: [PATCH] pkt-line: initialize packet_buffer to avoid macOS
 linker warning
In-Reply-To: <CAHwyqnXgxnDNiq0UWyAsz6CHvroYPZ36EGbaUn=-OmP6w3gsWw@mail.gmail.com>
	(Harald Nordgren's message of "Thu, 28 May 2026 10:14:15 +0200")
References: <pull.2313.git.git.1779901919956.gitgitgadget@gmail.com>
	<xmqqse7cjku5.fsf@gitster.g>
	<CAHwyqnWjHTpWfbMcBHOabny5NQN7xTZmxew2yDWWu3AoosngWA@mail.gmail.com>
	<CAHwyqnXgxnDNiq0UWyAsz6CHvroYPZ36EGbaUn=-OmP6w3gsWw@mail.gmail.com>
Date: Fri, 29 May 2026 05:12:39 +0900
Message-ID: <xmqqjysnjnt4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Harald Nordgren <haraldnordgren@gmail.com> writes:

> So maybe we can do something like this then?
>
> ```
> +       # Silence Xcode 16.3+ linker warning about __DATA,__common alignment.
> +       LD_MAJOR_VERSION = $(shell ld -v 2>&1 | sed -n
> 's/.*PROJECT:ld-\([0-9]*\).*/\1/p')
> +        ifeq ($(shell test "$(LD_MAJOR_VERSION)" -ge 1167 && echo 1),1)
> +               BASIC_CFLAGS += -fno-common
> +        endif
> ```
>
> Harald

I do not exactly know where these magic numbers and patterns for
"ld" comes from, but yes, something like that in macOS specific
section would be what I had in mind.

Thanks.
