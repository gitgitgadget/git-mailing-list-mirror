Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50EF935C695
	for <git@vger.kernel.org>; Mon, 28 Sep 2026 15:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790607640; cv=none; b=j6JwSVx1fNINZQd8Vwv15ZoPMhuwkP6qjWT5NgyMx87bgOvHxGcyZrF8fLuQiP4tBGkQmCCkrSxp3c9wbUCWectd+18nc4djeOOpfkAvihld+Ij4Qcn2Z8LYxgPomJMct2MqEp1BlYd064ODg18xl8NX1IcKgOREZg/PFcf91kI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790607640; c=relaxed/simple;
	bh=HYU6XC0ce2vRzo/+8Yf80sjIfR2q/nz293fJ3+7BAbk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cbEvhIBHI2MqtYS/GulrXqgfOeJiQQ1ApRIaO4H1KE7XbzLZkUsBOl6sndrS8J/RR1qud2LT5lRrztHbshBSxN/GEpYn0MUOpzuf0plaR5/897p4R4jRdg5iOjwrO0wA0KERbdWGDjVbXnPnNjdyQ2OTjr8OQ4kmk+JaEfsYH/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=HPuBHW5v; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=okogAxRt; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="HPuBHW5v";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="okogAxRt"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 5E1C21400120;
	Mon, 28 Sep 2026 11:00:38 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Mon, 28 Sep 2026 11:00:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1790607638; x=1790694038; bh=V4adR8jdbd
	rmtCIYcnKT3VvXAGYZHlKc8TZueg/Iq2s=; b=HPuBHW5vxsemReynE7xTb/o555
	FCqeiIEUmASXLF8xaoGMci//VZaGcXCO8suuvffu1xMbZN5bSjAY5ogbMOv8Q06S
	8nn0z9cSnY117QY4JapqAx/kuygvk4h9EVRIqzpMn4/IFWwN2fhAR0RLoteFhb/o
	4Msl8tCBGT6YxFrFAxfyBAIAwqwdpetVB5HBr/IfNAJ/qNotRToctKZ9zKh9dQT6
	HIJeCWr/bpSzDxLy+4VxmoGtC6C/4YIGA5oauWAuGESx1jmoqAg/6Jl7iDq9a9cS
	4eBGpmKYuu0OZaXc2FVDqTVyxD9d9aX9MBW4YXZjj2xg8onUDseo8t341+cQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790607638; x=1790694038; bh=V4adR8jdbdrmtCIYcnKT3VvXAGYZHlKc8TZ
	ueg/Iq2s=; b=okogAxRthj/idUJ0lT6xS81jbGiUEwQWL8wGX5SdJyUOuixriME
	gkS3QjtqQ3fsYyw+stXfdVrtW55QImpm2EcyhJjYMMnbntbFyBPU9sxDfYAZMJy0
	qPxffpcwypNxa/qdWRCa7DMO3qCo/QEAlI8cHCCxGdMcY4ATFQDMtsE7CDwHmwfC
	vnP9C2KLSP8Xt/4tT5GWY+Yvswc+/Zo/PFWDy9SFe/XucgydLQAGWcpDkCdWv31N
	b9gWaxaC0W10XnU+rbuK5MmBf6x5MQ5j9MI3NETi1boPToYdWKEU53BcZBX0BhIB
	8anPzKLSB5LY1+q5aIcEv4JmrmFtcVi4gdg==
X-ME-Sender: <xms:FoG6atuOl-fd3Z73a14oPrOPSNDCU6ZcCdqOYgzYZnJ4LijddKs5Rg>
    <xme:FoG6atdV88TzmKGUXXo2lb83ZQTz7ptI18J3vW2CpnvWDsOqKd0NpIvWyWrR_CwCt
    hvnV2wqzMuV-On12Ik_6jvRmvRyCGkNmWHbrGlnrgo3eSk3CeiO>
X-ME-Received: <xmr:FoG6alzE2HzHahDWCDqAYImDR_KHsTarNnV16t0GaCQgEAYYlZMV1NHRUaE7aahrSho5A-67i4JOZl4YKisG29qYWHrvDFw7EAT9>
X-ME-Proxy-Cause: dmFkZTEzWDde9sGX8y8dWjT1J1HakCTyAdEMMT0Kj7YvQt9pbBB8SWPCjeEekAmPSdhkmG
    7GZ/TDwzZfNqr/RtAs5ludE5mBWGwIGqk0Q5islDQLN1wXpJLjBp8NjVqNHE6oDO5KwQNm
    0a2SswizBhyzNVaOuZpTcBSWWPdx0+RSVxX6hYLYEKtCgDX/MM7nusarbo8q/8vOd/0EuD
    OGDJO49mjP1L6M+Xt7Yjk+TLWUCBtjpxmF5bnJt5c/ggVd7OLRQjSZyJJ/E+OU3hNDVvOs
    oOZb7WLR/mBL8kQ82n+Yyq3sAo9bExUirAa4FSaiBgK1fh/ZUQ+oeAbzJZcsjT81zWWpin
    J2NEqn7C25DBgHFCZfFKAzIGGdSqotjnwJz+M5POy5lyu+H8e8bMeyg5NPEsfqcVB4e2O/
    2qYXAdHHdE9GV8zcDAgqaR5qXYK4v2nru/un6WsRL3+CRticxgaetpgpLu3tOxjhJZrF99
    NQv7VS/ee4/gG4ji0Q5Fxm/F7jR5dD/mVYWupyHOwpJl5QLeZJ+Jpcvkf6hN1L08o8DJ+W
    5dG4S8U+Mx0zlbEm11FqaBPeSkiXDO56daSeuNQpVodjqbfDr3/gNtr/GTJDZ7qNLJlEZI
    pPnrvK62ZaN0FQbF3ydGodyeDL3rJ8taLv3yJwf8Db4IxWTTqlmFaHIE9OwQ
X-ME-Proxy: <xmx:FoG6ajFRpo7vAj0NIYGMBAywuEye1mLALZm1l4S0-fbxW6npK2o3qw>
    <xmx:FoG6apzNLy4K3qqluJKvwHag3zRTjJUCZIf9PuKFWDuYQzaVoL926Q>
    <xmx:FoG6aksBe7-U8vFkkR38c-IOSLSCJ8nP2hSMt4Bq9thCgvz_2aU1Fw>
    <xmx:FoG6am0CmM2YWH6w9woYUT5e0L8BJuHEfUVvCoW1VTrlmX4LsK05Ow>
    <xmx:FoG6asaWm9dHLPnh9Rs4K-ZJvfIIVWUST0Kc3_vTbfz6dbru8H_k84Hl>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 28 Sep 2026 11:00:37 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Souma <git@5ouma.me>,  git@vger.kernel.org
Subject: Re: [PATCH v3 2/2] history: sign rewritten commits
In-Reply-To: <aroX94CD_kOyLnuW@pks.im> (Patrick Steinhardt's message of "Mon,
	28 Sep 2026 09:32:07 +0200")
References: <20260703145037.69832-1-git@5ouma.me>
	<20260912160045.36064-3-git@5ouma.me> <aroX94CD_kOyLnuW@pks.im>
Date: Mon, 28 Sep 2026 08:00:36 -0700
Message-ID: <xmqqtsn9o1yj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> On Sun, Sep 13, 2026 at 01:00:45AM +0900, Souma wrote:
>> Add --gpg-sign/--no-gpg-sign support to git history and honor
>> commit.gpgSign when creating replacement commits. Thread the selected
>> signing key through direct rewrites and replayed descendants while
>> preserving the original author identity.
>> 
>> Cover configuration, command-line precedence, explicit keys, split commits,
>> and replayed descendants with GPG-gated tests.
>
> This is much shorter now, which is good. One question to ask yourself
> though is whether there's any subtleties in the changes you perform that
> might want to be explained.
>
> One such subtlety for example is that you reorder the calls to
> `repo_config()`. It's obvious to me, but it may not be obvious to every
> reviewer why you do that. Pointing out and explaining details like this
> in a sentence or two is useful context.

Thanks for pointing this out.  It encouraged me to take a peek into
the area in the patch ;-).

> Other than these nits about the commit message I'm happy with this
> series as-is. I won't insist on a reroll, but wouldn't mind if you did.
> Thanks!

Thanks for writing, and thanks for reviewing.
