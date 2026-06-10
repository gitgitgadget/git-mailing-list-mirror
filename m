Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 252BC348C70
	for <git@vger.kernel.org>; Wed, 10 Jun 2026 17:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781113548; cv=none; b=eH1y46RM99B+pkoyXoWyOydAFT/+GN/BY9xnJi1GYtEUIlSP3QGCGzrWffslf3H8ekmBlEbTbHjHjnX+cU4tzsH3eBaEsfgslsbXyz1uDDp6wpHhwxtyeJ3F7lzpXGs1yvatKJqRWH1Ay/qjTYob1n5BhwAQsFqVvIowc85IDDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781113548; c=relaxed/simple;
	bh=xORc+sSVQ/a8/pwim73kDYT9J6l1MkXtnghIlOPrmMo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KNgIkml5rzfFm5qShGzzUVVvIN7cpgh1Lvw5+j/5EGVImhw8i/t8qvGMM+tuOvcOuyBtQz1EarVNBdfTHZcsn2SZXdVHvzU56nLeX4rIxL4AmYnIDdrTOvcV15fCv7XDB6gwT+yv/CUC3kudHd1Y7abjJxX+i+wwMjmDVBZ3lX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=aUpD9lql; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=i5l85srF; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="aUpD9lql";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="i5l85srF"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 6A896EC00D4;
	Wed, 10 Jun 2026 13:45:46 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Wed, 10 Jun 2026 13:45:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1781113546;
	 x=1781199946; bh=xORc+sSVQ/a8/pwim73kDYT9J6l1MkXtnghIlOPrmMo=; b=
	aUpD9lqlKZpMrk0ZyyuIBISLC27F7YQv+1iEqtPNzE3o6Xu/lO6Y7TZ06nGmPv8l
	iH5/4ZhqsLC+KXXMPT3CktKnKWrfEOTeRuTSeB5uShIy6d0f/ot044pDStkTjVHt
	Q2iTj1sYctMsLEpBX968j26QJMlmhvUjpYkcPv3YCW+Obq2TNS70KGufA4tGlTfC
	Th7UA1WWnEd/Fl42iM67NUoH9k3ZU5WP2MC80QPI7VlcpqIYuwtGKLJfrcB2aP1O
	WAGOLKLqaxc7PJsd3P05cKl7XMhxgSsX2iGGkE9Fo7ObuEPvwb9KzAAnXhKdd+vi
	9F3A2b2HQddLQsPCLHL9FA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781113546; x=
	1781199946; bh=xORc+sSVQ/a8/pwim73kDYT9J6l1MkXtnghIlOPrmMo=; b=i
	5l85srFjl5T9t2XXICm1eDV2Xg1ijw7k8Vu9y41O/dhwDxrpsFYnqrrw9XcdJb1I
	vUMg177NCShDUVxPmvIALxbMwhVKHoZotaLSuYjLnToSM6ubPEdjyRvES65Li86p
	LWfDH77nTUDruXvzS2uADTM9tOKDO1JFyXTBpqXNaktgzr8IrfQ7A1t5WGI5KAW8
	82xf/cGm4gMDY2reaUtlf/934iA1uVn16HpCyZY8L96LkM1ipYKL3S8fx+gjvzeA
	VVDqoGTeYBnOHRwWsO4hU0idZ5fbrjKJ05c2lpdoDsEuz2OzDC3soGpI90q+KKTS
	zNkxUBLsVWe6Vqn+wYxvg==
X-ME-Sender: <xms:yqIpan2hOXBFMyWDc5DFcrMyRDBUvfJXLL80JdHDklMcGIcRqdSPWQ>
    <xme:yqIpas_2CPDxEgzJ0ANeKFBVBhm5tmA8-ky9feysM74MYahYcshnWb0Pk1kB7LYaD
    dCMMWweB7NWA6Y0yV9E9hT_8lFsjqYAB6rPlSy7h9I571ljAuqUqJM>
X-ME-Received: <xmr:yqIpagOjde2z6qNAHOHEL5DzKe46kVIvcDq-uEUScF6T3lIpU-7MP0jUF9FIZLLex4CNiudF_QozWDs1pcElMN0OStJCXJ_kcGRE>
X-ME-Proxy-Cause: dmFkZTGhc32WCZzOJh+vbNst0Xg/ETvs/pLHfFZWPRkVmdIaiSoJNjqF/sqZ0Bi7ubJ70V
    pBpf1bdgVuOY3/RYrdno1pFXkB/FjIkpunpOMa3U4IJRfnhhnawuaPr8ORMogUeIcDwFr8
    vPBkHMhu0yiy+w3wWVZY3zFQC6e/kYhNm/9C6b5AomqTuzbq5K3F66JJ9/Y9zfBUD/Jzeo
    +m4Kk9tZYUA6fJL7GOsf35RDGdIWOCKlsWQJ4r1r+VijwQmU1qZ4X8uJdF2rW14ohtQdv7
    YJ0bT/uMwR8sdWrYMuvkFo7+9HagtwuPw0vYerFPwbKIkKS9VXkQ70WPhb0/EkCFfUJ3ZZ
    NCFZcrljXdF0CHVZe878HFe8NEecXBWGzhBVwq59/wjP4y6BLqoCXaABpIcBi9sfWL7hAP
    oZCa2ie+xvgoLUfDvAXoG9V6hTPsfJQ970YydDvsS0Czi/5MEvYNeWYpJhuCq/Sh1MzFeo
    GRjluPzW5ErVXc8+m5eZWltC5U1WLuziY4aT7bGIAMwylVgVZz1awSSdvAbkid0XMcC/qg
    aCLS3gdl8nFLOINq74/QXhZjdgg0ALMYA2Fy+INknKznnbhbT+ofZQfGCAdA+LZLc1XlyJ
    7ztjjGRWzMC6Z7K3DWbgtQjKzgEMNDVdNHBaOYXBm3fubFtBJsxAEndjtrSA
X-ME-Proxy: <xmx:yqIpaodE8DGDRArzq7rbWLOm0NWN7uqxBgRQsmCtANzTxbpbAbjtGQ>
    <xmx:yqIpanU0aJQu3oJE8523LoIOp3tXwL442O6LKYKsqQx7_Hw9zZp-bg>
    <xmx:yqIpaojNV6UJkVQXHMNEb9GHj7cKl29Yl7V_CZvn7cwG8FVvHYbWEg>
    <xmx:yqIpau_6owjkUPJLxFgCixfJrgr3IZd-BGwspYxS3mGuYH_z3fOQWg>
    <xmx:yqIpai9PkE39j6wxuhiLLzkmsq4Rjb4lAWN9miYCGJQ8Wk-CKOd_cblb>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 10 Jun 2026 13:45:45 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Tamir Duberstein <tamird@gmail.com>
Cc: Jeff King <peff@peff.net>,  git@vger.kernel.org,  Patrick Steinhardt
 <ps@pks.im>
Subject: Re: [PATCH v2] describe: limit default ref iteration to tags
In-Reply-To: <CAJ-ks9kz5JGFSF21aOhuXfgsJ+5aa5xE69RPT2Vhn-CRGyHZ6A@mail.gmail.com>
	(Tamir Duberstein's message of "Tue, 9 Jun 2026 10:44:12 -0400")
References: <20260608-describe-tag-ref-scope-v2-1-256fd36dca32@gmail.com>
	<20260609110957.GB1509396@coredump.intra.peff.net>
	<CAJ-ks9kz5JGFSF21aOhuXfgsJ+5aa5xE69RPT2Vhn-CRGyHZ6A@mail.gmail.com>
Date: Wed, 10 Jun 2026 10:45:44 -0700
Message-ID: <xmqqzf12uw53.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Tamir Duberstein <tamird@gmail.com> writes:

> On Tue, Jun 9, 2026 at 4:09 AM Jeff King <peff@peff.net> wrote:
>>
>> Probably not worth re-rolling on its own, though.
>
> The suggested changes seem reasonable to me. Certainly I am happy to
> make them, and re-rolls are cheap. Do let me know explicitly if you'd
> like that done.

Let's see how much more pleasant to read such an updated version ;-)

Thanks.
