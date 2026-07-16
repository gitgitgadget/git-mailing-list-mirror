Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DBED2D2385
	for <git@vger.kernel.org>; Thu, 16 Jul 2026 03:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784172203; cv=none; b=pP3ImkCXz7/VBqIJAx/DT9ZlMPDpT7Fxcid6ee5IEbves0tXB7tE1zNZcAMHsGiqtPjfuURmefSKye2mwPW2njh4pGgGMiS0Pu/vKsLGbuLpOC+s1vGxee95l0H/22jFIT0QUh3btAS6AUWcE5qikUYX3+9nGG2nqCt3r4F7I8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784172203; c=relaxed/simple;
	bh=tJagM0gGmmtnCjae9x38v/iUTfcX1f/g/7iJI9126fE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=G0KubDkUl95kTSK5v3rbaDPwMYHg1ExfN8gXKf5kytDGlYLZ3pL63FQhN0cRo/1lI3QmF37kh4a+tktvVIENBCCAJl+kqsvbvhjkYfqDMWCZZ3AMfg5a5eXC4NoG5Ozim/H9dq/0PT0hxfP6N1QRSpMyTueIIRiVNADNfFhv3ZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=sqnIYGrQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ry4vMCo0; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="sqnIYGrQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ry4vMCo0"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 23603140008A;
	Wed, 15 Jul 2026 23:23:20 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Wed, 15 Jul 2026 23:23:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1784172200; x=1784258600; bh=WYxmp4DXWk
	hZfn0CgM0ycuzneTAkORK3xl1KfNJZO0Y=; b=sqnIYGrQPSrkjyYu29Nxlc9Del
	eKlcSt/RZywghT1cNBMsqzJfH9hQNdpbQOPDJmX/R4O5qnKooEjKqkIv3NyERVRa
	FSKsG1l4S8NSy6ix5e/tKFICQxHxDoln9O5b6ETdNZ+e1ZcOdE1aYsvtYkG0UTwC
	Lrj9TJtQbiM3Jpe9G8E0+Br/j5GAVaWkOdbVlJ5gQR8cPHsH6E7SGwOxN2f3ytpR
	jyEzdzalycPOLd0IcIx21OTj8WS9q5qODcZlQj6yzaP7ARb12o781BQQ1uAK/j0k
	iC70/9SCZL9tF3BpiqG6cb3nV1aLPq0fVOeF2n7iW/7AM3sSTx8x+w4MnPuw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1784172200; x=1784258600; bh=WYxmp4DXWkhZfn0CgM0ycuzneTAkORK3xl1
	KfNJZO0Y=; b=Ry4vMCo0utJtcsdXR+IiCivHnmiFUUEC5VPuiekL4Y93a2Hk03i
	fUVwLXA2uX2KhH50D5gRelOsuga1F2v1NG7hU2Z9kQeZxHusrbTy8P5hW3bvnSSv
	0LA528kp6CgqQmdFKEoRxfEk1DbCouzQAZzoi3fZxLnnNUF70Q926h9ro3dWNwaN
	kBPlJGSr3STWBE9xVhmNhirWfwHC6Jm7DwjEEaB1CLXZYZXyEFk/IX5/YCqVFJdK
	VKl0qdSAiEOSkVEVJUtDfS4/hMJKGyvDFUno7DVnQlf6KNkNVllGlINdVHMBBuKJ
	Fpwa/1KQe+U8LXSNi9j7tM/OpfEpi0KHCyQ==
X-ME-Sender: <xms:qE5Yave5gBtKnVZyoXQgylinI04f5SQ4E9bQ6_H31ZBbo5K0Xj3xOg>
    <xme:qE5YasH-wxlY2y97glLhR6HQ2ZrTx0jBWRC1jg7dU6ESzbsg3b1OD7zuk3x3vKySP
    6EYJ48uBTpnPppVWizAkC7Dt4KyP4iN4rywbDx3KwgGfSqnPEWhPcw>
X-ME-Received: <xmr:qE5Yag1xU-rVOKlmwDeGme0lkLfqDBexQJoyRvqq5RHG4CGTIOaHDrv2rQ0Q5-ln4ZJh0rE0XR8wwbuYnOjRwI8X8bn4tN1pAhEfTwg>
X-ME-Proxy-Cause: dmFkZTFjyxMI3pxBxbt23zB3KoxGfwbdbFK0+WuYaUvK12gUrKSJvadcFXDy1X3GmqlGp5
    MRSmaEWJQkYGI/WyF83NmqgcFBI2MLpyfM55LlHJPNAlPb6v55wIujDMwIpkhJEg21ilRT
    V5PcJ1JVJo2ISn0uoGo9rzm0IAFXyt6+KYVrRKcDKr64TA0YepcuG92FuYtlFgqDx/0Woz
    RuYSugCTLKeBVYBHvHPis6JI1aG71/gWvE+wOmlypl667XebpEI4myQJ3UO01qVsiZKDu0
    n0cJPx+35AAV+1LO9PSZ3ogx1KvzSf/+sPq1cd+zyUiyHwOGZWtkrlteB838RplJ5PYKTe
    BthXd84LQi88PZPf+Lgd+8UquhBLNUlEq5I+NthVWNLbYGCnU4/IVWCY0I334Yas00lIhl
    xGAWE8Zwq4c8bWGR011Mx765nyNIjnuYkcTQImGBozgMxP+Xmr/6MHK7r+6j+8K/aM6r2M
    U9qtY+XpNPIKvanLNZ4tm5kyyvhlQmWSsfgaFQOzP8CPAFBYOqbednyfg9U2eyWPXlWzW/
    6qC0oE959NpUYrU1ZA+TJsAs2USn1OA+/75hoLt17OtOU+0JJeYqXHT0xX8EoRgGuEadbX
    b/bPdG3tyPT4R+ZUzsRhPL2Ix+PU88g8btySs7nGjxhgHfQRRknat6nkZGmQ
X-ME-Proxy: <xmx:qE5Yasn6tcCkxhd9mK0_eyg6kchgqOPQenRj-5cB-pCTFv11e9HcnA>
    <xmx:qE5Yao8aLkGp1DzAJNpb73ESVPFDyw3JMw0Kapjt552sKLcUcd4ukw>
    <xmx:qE5YapoiTq6fR24jwAZphPj6euOF-b5Z71HV8-9iuxlyAdS0RZZn2w>
    <xmx:qE5YaplfjDLiT_ALM-bmdVENY2v6YPFc_OKOtBCSSN92YUQd5NKGtw>
    <xmx:qE5Yaj1SpZLJybFX4WPgetv50fEtDH0ipy-2IIhGNBe30phTfn6AkOaU>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 Jul 2026 23:23:19 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
Cc: git@vger.kernel.org,  jltobler@gmail.com,  lucasseikioshiro@gmail.com
Subject: Re: [GSoC Patch 7/7] repo: add path.git-prefix path key validation
In-Reply-To: <20260716012138.6714-8-jayatheerthkulkarni2005@gmail.com>
	(K. Jayatheerth's message of "Thu, 16 Jul 2026 06:51:38 +0530")
References: <20260716012138.6714-1-jayatheerthkulkarni2005@gmail.com>
	<20260716012138.6714-8-jayatheerthkulkarni2005@gmail.com>
Date: Wed, 15 Jul 2026 20:23:17 -0700
Message-ID: <xmqqech3k47u.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

K Jayatheerth <jayatheerthkulkarni2005@gmail.com> writes:

> diff --git a/builtin/repo.c b/builtin/repo.c
> index a97ad71649..00d5064281 100644
> --- a/builtin/repo.c
> +++ b/builtin/repo.c
> @@ -1,3 +1,4 @@
> +#include "compat/posix.h"
>  #define USE_THE_REPOSITORY_VARIABLE
>  #include "builtin.h"

The first include must be <git-compat-util.h> or common include
files that include <git-compat-util.h> as the first thing, like
<builtin.h>.

As the file already includes <builtin.h>, extra inclusion of
<compat/posix.h> before everything else is an absolute no-no.

By the way, I do not see any "validation" in the patch as the title
claims.  Perhaps retitle it to "repo: add path.git-prefix key" or
something simpler like that?

