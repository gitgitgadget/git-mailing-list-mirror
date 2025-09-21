Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E6FF14AD20
	for <git@vger.kernel.org>; Sun, 21 Sep 2025 00:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758412817; cv=none; b=OiwnwYvRNfAWUOltWvm14O9+6blRlXbGFOMWbFi17MXLlWp89YbIaY+rSl4pimdaMDldHSScrEfRq42PFgHHXExu2i4hHmaIhqjXhpmLdQ/fTfg8bFkMAOiSlUpwxX7wIP2gVYAuOOVtoNOF8DdzNW3kipJuE6SNNxSz8LhoEVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758412817; c=relaxed/simple;
	bh=3Uw2aQhaAvwrEJBpVuk2MoIdFeZSXlXb0As6WlSN0vA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gP/IsGq5OTh8BJqmaWh6QweSXMEEMtMYH8IvCAzFDuKsYLMWlJgylGPCsHy6XmjP5TkNRyIUL62SJxjhgm8g3qbjrCi/2HEvCKyMoay8BGizJpvPrZduVUeCGZJM2WJKMxZpO6xfkWzyqMWjGe4zoOxhkdPNKV5eQV4AQ3z8wyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=IuPprHw6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Oepth+HJ; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="IuPprHw6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Oepth+HJ"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 4F22514000D5;
	Sat, 20 Sep 2025 20:00:13 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-12.internal (MEProxy); Sat, 20 Sep 2025 20:00:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1758412813; x=1758499213; bh=vle+Txe9nO
	L+xYGK7+cfl3ont2uoa2VSnH1z0+ARM50=; b=IuPprHw6+98uRsoSldWuwkDHHq
	AG6XtB0G+pJpWyUxOksoSyPG3VxS6ABcPhyqOzLm3AQCQpuSIj/VfBngtmMvueDa
	V4p/ldWnPd3cGxKButwkAXP4p2uG1AsfwAfxJaAcm3OOYhwNcK/qLSqkFz1snql9
	M+Dp3QE7looD48ieLAQrL5NDYE12RPFf9X/z2n4DeWh2ClbLXg4c13W7glXffJ89
	3ez2eGGoGKv1Uuc4+EOiJN+PVeTUAtam2ISlY2N4u8zEPZPzQ87qd2SO1uSwFBIR
	BsVw5S2QeNiO+HusWAWoa5ZtPjIYyk25u589zHHT48r7NM7E0jb09TU50l2A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1758412813; x=1758499213; bh=vle+Txe9nOL+xYGK7+cfl3ont2uoa2VSnH1
	z0+ARM50=; b=Oepth+HJJGKDTznIgAZrWzV9uuIetIgmMK90F3t91WVCurWScpD
	Cdh9bJOqbo2MWZC1/dTqdOYE+E+EiffPZQwGeoube8bFohrC3IbzSVmAr9wWHi7a
	qJPFSMFot8hBpR/ZWWxdD4F7TZXHOTJ4WT0RLkR+3/Dmbv69Lw+kd+IXIlEazir5
	0rQUfwKRMkYoCCq2cB+iqGflz7Y5PuD4hVCNjjJBR1fUlV7uq3KCvW8XyOHGO55B
	No6YZsv56jqj64U710bKnmgN9qqr4c/CwpYjJ3MKYbuC3sBLrPT/n1IejFlJNm3u
	XrFLKqT13WEtrthZ+bV4oVTbOQ0EpxBanaQ==
X-ME-Sender: <xms:DUDPaGij3Pjo2MlM06EcN6LaxsxfEjrqNPBJkSjZAS4DEX5t9vKQ5Q>
    <xme:DUDPaEnf5O_a9nyBofujFCSQBa_GNIc3tQcr_CtnZ-GkKVgBoWcmagyfElxDV1faE
    a6_kuQg5dgjzHKhyQ>
X-ME-Received: <xmr:DUDPaEgWCnkYOJL2PUpBPr6mMgXHQDMMU47pk6I3aEfuanb7jtfYuO9fJ8WKnjufFswdiF6GkYrQX5OsjGPU3ytGcUy1WOK3JNZu>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdehfeegkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeejpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomh
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    nhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphhhihhllhhiphdrfihooh
    guuddvfeesghhmrghilhdrtghomhdprhgtphhtthhopegsvghnrdhknhhosghlvgesghhm
    rghilhdrtghomhdprhgtphhtthhopegviigvkhhivghlnhgvfihrvghnsehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:DUDPaA0BZdvj8bJG0X_HuWDYcnWpw8Jq-W8MkRf157LBebOmAgM0og>
    <xmx:DUDPaFKAPLm2Q7fVh0cr6MFJ0yn1Sy_TlV45b9Es-nLTcTt5ZfaNkA>
    <xmx:DUDPaIyqfhWUbKwU78yNzupCc1x9s_upB3i-p7p2wHxcyPlxiO_gbg>
    <xmx:DUDPaLVgoSMs8i30m7lH9_5d81fReyJdOczDD8S8bBMzC5yQ31MlMA>
    <xmx:DUDPaPQw9cECIDYAzHnWcyI0C5xYUwUWzk1iGfXwaInjJbuwAIfS63o->
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 20 Sep 2025 20:00:12 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Elijah Newren <newren@gmail.com>,  Phillip Wood
 <phillip.wood123@gmail.com>,  Ben Knoble <ben.knoble@gmail.com>,  Ezekiel
 Newren <ezekielnewren@gmail.com>
Subject: Re: [PATCH v3 10/10] xdiff: treat xdfile_t.rchg like an enum
In-Reply-To: <1e404c3290bd4ba8b4973a597b976c301138cf73.1758294992.git.gitgitgadget@gmail.com>
	(Ezekiel Newren via GitGitGadget's message of "Fri, 19 Sep 2025
	15:16:32 +0000")
References: <pull.2048.v2.git.git.1758239789.gitgitgadget@gmail.com>
	<pull.2048.v3.git.git.1758294992.gitgitgadget@gmail.com>
	<1e404c3290bd4ba8b4973a597b976c301138cf73.1758294992.git.gitgitgadget@gmail.com>
Date: Sat, 20 Sep 2025 17:00:11 -0700
Message-ID: <xmqqms6owu7o.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> diff --git a/xdiff/xdiff.h b/xdiff/xdiff.h
> index 2cecde5afe..7092879829 100644
> --- a/xdiff/xdiff.h
> +++ b/xdiff/xdiff.h
> @@ -27,6 +27,10 @@
>  extern "C" {
>  #endif /* #ifdef __cplusplus */
>  
> +#define NO 0
> +#define YES 1
> +#define MAYBE 2

<xdiff/xdiff.h> is included surprisingly widely.

I am not comfortable with the idea of exposing a set of overly
genericly named macros like these, especially when they are *meant*
only to be used with xdfile_t.rchg, to those *.c files.  So far,
when they include <xdiff-interface.h> (or <ll-merge.h>), they have
been rest assured that their namespaces won't be contaminated and
they would not risk stepping on others' toes as long as they stay
away from inventing their own xdsomething or s_xsomething (neither
of which is quite similar to how we name our symbols and types).

But these are names that they may legitimately want to use for their
own use.


