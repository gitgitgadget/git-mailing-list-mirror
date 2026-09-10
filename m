Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24F003CB550
	for <git@vger.kernel.org>; Thu, 10 Sep 2026 15:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789054624; cv=none; b=sccnruZzeBjtdtilKaAfbg60VQQzykKJdCCkKFtKPYGbyNSwc67auj8/kmjFGRQZVvd2bKgccXhz7m6W9GZ1NKsLlMSgK2rgZcnkUNjGflEFwwXbDurtxgY4uoGCBDVLKihZbD3VeDagdzCoXb6QBoOfVKMjbZGSpfgsEBmMRUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789054624; c=relaxed/simple;
	bh=eXfY8cCxJ18QcZIn6eJVZztVmqAgGhem6YBocBlNULk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mD70oSC2JyQUJaeLdNKmB/la0uv8Tk+MjZcIH7+JVota1V4pPFi/mvZGq44rH9NlF480Y1SSZhSc3ypBMz+rMftn1WwgoIwwy4xaOs8V2yJGe+I8BsS+0tZw3aO6oh7HSbGDtJ2fcNcXN/HVHJtZ4RHtvlUDPG9mUr+BW16UkjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=caZZqaiz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ctdB0+ZY; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="caZZqaiz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ctdB0+ZY"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 1E5D5140011C;
	Thu, 10 Sep 2026 11:37:02 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Thu, 10 Sep 2026 11:37:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1789054622; x=1789141022; bh=+aZR8HrhUz
	TvEg0C14f1C3hJ4VY8pXIw+oUKBgMdCT0=; b=caZZqaizgK3wBTw7bP9MfqOVhZ
	uUP+Q83+RIc/mtg6DyVu8tbbECJQyzGn89CZOFg1/8dwWS8p0UhqChBnuRvIWf02
	wFOINr94Q8eNKn+ZcZ+Wfi7rQLsp7e7g4b6Hfl9wiqdUfqmTfXI7FYiwhK1yA4LJ
	dDI70r2cqaIeSUcDQwcyBA3wO9CD4D6cfSAo8Gb9GlH5rChLqmQp/YWjeCFF8mKs
	wQCx4SoYFyIaz3sjSz2VPnDMumtRcTwEvmvtQexIlByfSotXnnHY1VATEBpwonMc
	GEHWmEKXMaD4srnJnADjEjmvXT38cPaD39rVVYyaNPpEZDwgKcm0709sSsVg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1789054622; x=1789141022; bh=+aZR8HrhUzTvEg0C14f1C3hJ4VY8pXIw+oU
	KBgMdCT0=; b=ctdB0+ZYuTQ8gxvIiORmfdibVn6NkCasC/9PRHonKB+6Z5h4o4K
	JG3QE5EPjQ++nDIp6GrsaKKWIcsIbJAw4TBwTO3xwbW6ceG44k5DmBRh6be12VJf
	zdcq4xcYzF9LNQrmwyHrVmzkh3So0DIDmbmuIYmma20YQTp3Ts4WJMpaUo1ZmOMn
	Q2ezmUzashDjfZbUzbhVtCCgqIDQAhZ/KDHXUJtrzMh4MBvhi/PO+W8+xvSOK4+G
	yHlHmnj8aSyVK3nW8N0+TM6P2Mz+JbL8M5eU8LlyD02h/SjQuskVjEuA7k0uM+Ff
	ZLEWBU1nILCtlY97z3s3ZRu637st/yLvLjg==
X-ME-Sender: <xms:nc6iahiAw3dTBPVfaWhBZydrHZzYUUtkS6y3p6XbEviDE0LimlDVSg>
    <xme:nc6iaptb5IC-YhtpzEn67riq52Up7vUOfrFgSG1hKY4hOh5Zg0dbGx4B1SrM6p0ss
    fLmbz9Yihm0w4ax0XFRIBI0_BBUDrCvEfQ85_AMZMjCoBJAk-JAcrs>
X-ME-Received: <xmr:nc6iaq6dLzGNjI67WwrICqzVnLfE02a84aT8wC5nOlzLOsJ3U1hYjupv6VkFPDGORBn85uG8QrDBRorl9A1qipwUrSVVtONeCEry>
X-ME-Proxy-Cause: dmFkZTEwe584kR1DZiyGCPHJPfVqtul/qsBD9HEO3sOaM3fAfg2f0MpihJyZ5fXkF88CPf
    9Qw7GRuhXt8AglgOMc2PO1WIeKEd7WOuigJKlz4Punk5hRKBmih+YrbUjSQqcwsa6Y7nqY
    9GRlnHwrB91uc9EtHELx9oTntSljFzv3ymukNxA3pCdmAaE+LfCpj9sIWCyoX9iS6n3Q/X
    NYbX0QpXXjAgeP/J8t94zk9cXLHNeSUkHoUbPpMyuAXC8IMovnBZlwxaDzJxZtUTSA9wC9
    zPjRdB5ZVFsAG4Cwh0167PXaDDKhQupbxt1PJ85Ok6nmmIjvXkSgqV9/KmbxHreQbInPqA
    aEpuA8wj93AIq+6+pGq7nlcRnsBFyw1/6PUUszvlXcUqyIW2+kT9TmRyF/8Xv1K2vlgmIF
    e3CrZCpj/P8fXn3KYSBoJV1SvdlBIJYNpfXW8P5ckjOA88T87fgmJtzC/MvSykW1kkY1lc
    TiHM6o2Ys+DxqwxWbGBMidYkjSBfRC8hnx0s+d/vzhVO/dp96KGsO2qBe7cQ4S3SF5vpZg
    RnsT+GZvMeXczen5he1ti4xQpnBNIXcco+snWV3GOk50xe+SsQdykk7a0BUuQQyxOIkxk5
    e1+TTNoEzN6uZmrQ5KBObs3bSgL9DynTiu605V5aPTeAFzok871jerzK91Fg
X-ME-Proxy: <xmx:nc6iatPmRd1jcxkhwO5_SjgGlT6jILTY6mgd7k6WOPBEY2imDJsy9Q>
    <xmx:nc6iagupHi9LJoEItwnltPKpwfEyWGHNtRkrGeBmEVPTXuafl7LMow>
    <xmx:nc6iaob6QYu57fNe-Kaw_68ZVBzOqAqLOP6dn5awmXJe7VCQb1j-Tw>
    <xmx:nc6iaqyFvMd3hLx8rJIAja-eOfLUNXrFjpmhW0iJhJwSc_lKIDOGFA>
    <xmx:ns6iaqIZvX1XZsByX7Pa5rgifOqfGeuUqb1g5RSmkbDQXujPoagLxP5q>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 10 Sep 2026 11:37:01 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Vsevolod Myalitsin <ub4nal@mail.ru>
Cc: git@vger.kernel.org,  ben.knoble@gmail.org,  gitster@pobox.me,
  peff@peff.net
Subject: Re: [PATCH v4 2/3] advice: introduce advice scoping mechanism
In-Reply-To: <20260910085353.109373-3-ub4nal@mail.ru> (Vsevolod Myalitsin's
	message of "Thu, 10 Sep 2026 11:53:52 +0300")
References: <20270829004959.90983-1-ub4nal@mail.ru>
	<20260910085353.109373-1-ub4nal@mail.ru>
	<20260910085353.109373-3-ub4nal@mail.ru>
Date: Thu, 10 Sep 2026 08:36:59 -0700
Message-ID: <xmqqzexpf78k.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Vsevolod Myalitsin <ub4nal@mail.ru> writes:

> @@ -109,8 +117,21 @@ static void vadvise(const char *advice,
>  	strbuf_vaddf(&buf, advice, params);
>  
>  	if (setting && setting->level == ADVICE_LEVEL_NONE) {
> +		const char *scope = "";
> +		switch (setting->scope_hint) {
> +		case CONFIG_SCOPE_LOCAL:
> +		case CONFIG_SCOPE_UNKNOWN:
> +			break;
> +		case CONFIG_SCOPE_GLOBAL:
> +			scope = " --global";
> +			break;
> +		case CONFIG_SCOPE_SYSTEM:
> +			scope = " --system";
> +			break;
> +		}

make DEVELOPER=YesPlease would die due to

advice.c: In function 'vadvise':
advice.c:123:17: error: enumeration value 'CONFIG_SCOPE_WORKTREE' not handled in switch [-Werror=switch]
  123 |                 switch (setting->scope_hint) {
      |                 ^~~~~~
advice.c:123:17: error: enumeration value 'CONFIG_SCOPE_COMMAND' not handled in switch [-Werror=switch]
advice.c:123:17: error: enumeration value 'CONFIG_SCOPE_SUBMODULE' not handled in switch [-Werror=switch]

We probably should have

		default:
			BUG("advice settings at wrong config scope");

or something there.

>  		strbuf_addf(&buf, turn_off_instructions,
> -					setting->key);
> +				scope, setting->key);
> +	}
>  
>  	for (cp = buf.buf; *cp; cp = np) {
>  		np = strchrnul(cp, '\n');
