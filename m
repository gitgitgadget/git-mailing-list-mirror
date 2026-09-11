Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D846D4BEE26
	for <git@vger.kernel.org>; Fri, 11 Sep 2026 21:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789163452; cv=none; b=SKUccxl1I5M3uc+329SEbAptvNSMLPPDVx8hyGV2IQ0o1KPtC+GzAheHYsTT1iuWh7WfMVcX30/z38So4Xu0lC9PM6ToELtcjt4qhWW49t5k6NP07A2TjVbMuTFIEX2pqY4DW3gG15nHwHlRvZXSe19IhBlj8sJ6rbUeQj1xDuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789163452; c=relaxed/simple;
	bh=GYSGGIukh8CVJ946hCm5VdAnzxRNbGnbcUBydnu/B6s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=K3urxfVTF5MfNVEUuDCsdnRLOIdkLpBcmjI7FkQA/V5ExEEeREadrLQcGHuEVTvMO3x4SjPPJKf25ehhcijEJqm6nBnktOrRH/n2orN2Yi+pB94hiMroLQfb68qWg8sC7ZLDezx3B1DLhpU+fmZ5isZS9OA7KvxVGX09G9mX2Ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=vqzkPjrL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YNHF+evB; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="vqzkPjrL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YNHF+evB"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id ED4211D000CB;
	Fri, 11 Sep 2026 17:50:49 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Fri, 11 Sep 2026 17:50:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1789163449; x=1789249849; bh=sddGj83gIq
	BPsC7e5GyQLMv7Nfm57w9GHqtg5HOLDsw=; b=vqzkPjrLFHrwkJ3NeU6aSeyjWp
	Lp9vKRjdoh2peUaVCLkDoAs3k1gUOzbMN8X6SBrQ33QyFk1HLMPHplJeYbI61hTu
	NhpnH2sJxHdfGKVd+KpV+Xt0cK0vPYsFPx5qnyIQNB0MZ+dhJKLJAAwnL41Gcb8d
	mOhBuDf2Rk7faLMSPsUgQbhYyHX7DLNbBtx+anfk/B/D636EukNdWD63pL/avRg4
	0aKBPKFeCbr31GNon2mxS/ya+LQt5MKqHWhiIG2SKQQXf9G79axFhX5irVhemr7f
	9L7OqH1sqLAJIzZOT/F/S3wMnGNI1S/SSHK+RylO0buskiWbOzdjC0sBFCxg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1789163449; x=1789249849; bh=sddGj83gIqBPsC7e5GyQLMv7Nfm57w9GHqt
	g5HOLDsw=; b=YNHF+evBOiQt4oJAz4f8WElyIOXYE962rWox2TWohI1ssVgDcAE
	CfKkEcNO5G1X7bD5imc/lkioucivCJYECXJHWl7kntvCXicsD0NPq5B1CasZ378I
	EklfW4ZNeys9Ugj5lZeR+b2Ox++qwFSq1y3391TP/JYtAa/SfW2j48UDUEe1rM67
	kFYC5FTyT0FpIU41nVbqiNGHyxeV1xri1dALWF1sGePwdcQpdEn8rmSm3gtfwbEd
	8YDQOCsl9DtVfU//kowf/KdQyNMg6W33BcTQuuzM43q61bEn6EEhx1OzKhzTVAvE
	YWrkHmnC0riiTfP8O+g9preykto8XJQqKCw==
X-ME-Sender: <xms:uXekaknzIPkcPODiJWf6vj5GGh7eHK2bwkBBFJPYU7rwokkxyr9HpQ>
    <xme:uXekaqsSFF7WNhjjL-o9-8knFTGITDKtavMit9-R_77k94Z4vT3PdtgfQQRHidJay
    BSM5snjz4IyvFSVSmTAogfvhrcHTEQ0-kFzjQapOt88L4iGa-XwOIg>
X-ME-Received: <xmr:uXekaq8nCDqieV3IfeY_grCCEJysIZSIlTLyWXcs3Fe57XgoBW4AKekZm7Hp-AJiPS0ZOuZ2BXWZkbhW1UuElilKqiFpcK3E04Su>
X-ME-Proxy-Cause: dmFkZTEwZ61dDkq4n4F7bCnVnuLFqqHo7i/D104EEttkXDaqA6eccQmZtcjFLd+gzicaRm
    fNPj0PHKyEGKqhGyEkxwTvL+L0YhAT3WJpd8Ii0aoyTwf3vfj6Chw/gkTIUMdd7WL3kPjj
    /0wmKDr7jd3+xklVe8uA9fUe6LmPxqNKZVDvN7MKBH6SJRusUZQkagDjTtFvAzizbxhH1k
    vzjh3epGx/fcwZpjo+T5sAdjoovovvg9amH6B/pBCZlbE/WGZgeVNKrApHBiLinxObR7Bk
    0dK5xUPorYSb30HMKTijUCWKJbatbCDAHzbuQH2HQdAjJ74TnNEbSyJvnH4mJdXCtMJwmO
    NZ2B6JDG5R7hZAjqbPKZKmToEP/zCeO7NUudUuqz9Tfd6OufaHF+no3gdNzoySY5Oen7NA
    BIkflWWbQEnFaBhORChpJZMB2nFCtogmzESVAqhSKc8jJn/Lcd+x3u6VdX9vuOEta7fegw
    HSh/NCR7AWZQ3nWSGtV7Hda4FecA/4qou1G/mH8n7vR0kvoCt7ek4ZdwgTXXBnzCU40vwl
    hH0ASAdujx4IsmvMI6B0RGxdwxogk57ArIdjICEf22Dkd7DENUFoQ8EpZDv/+fyuhcwnay
    pCpnu4YD9cYTf6s2eLojvu35KSOlcgEgq+dd9VSpWZKUbZl//Nc7/B/ZOf7w
X-ME-Proxy: <xmx:uXekasNJFebwNSgEGKJAMt0dS_9dzC5_Tr_fIDa0gMUCSye8Cf58eQ>
    <xmx:uXekagFXL2Zzdv4lxpjiyluR6BuYwMj51J5yO1jrpp8Lr_Azp0IPVA>
    <xmx:uXekaiRLOyHEhvhZy545QpN_Yq9HyJrohk2tmBBhgozGidwoiyKSGw>
    <xmx:uXekalueKj9v9eEJti4QFdAPqeL95ZN7l_QT8aJ0Qu9GF3gXhY2qeQ>
    <xmx:uXekajhcZOc9ppdJgJN8bYjzSqwCKkNXESnWtxQQ0YJqrHI_DZc5qH8V>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 11 Sep 2026 17:50:49 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Tuomas Ahola <taahol@utu.fi>
Cc: <git@vger.kernel.org>,  =?utf-8?Q?Jean-No=C3=ABl?= Avila
 <jn.avila@free.fr>,  Jeff King
 <peff@peff.net>
Subject: Re: [PATCH (RESEND)] ci: use system asciidoctor
In-Reply-To: <20260911213338.kLh69%taahol@utu.fi> (Tuomas Ahola's message of
	"Sat, 12 Sep 2026 00:33:38 +0300")
References: <20260902071113.GA70165@coredump.intra.peff.net>
	<20260911195250.31201-1-taahol@utu.fi> <xmqqeceza4k9.fsf@gitster.g>
	<20260911213338.kLh69%taahol@utu.fi>
Date: Fri, 11 Sep 2026 14:50:47 -0700
Message-ID: <xmqqy0d78nk8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Tuomas Ahola <taahol@utu.fi> writes:

> These two were indeed merged:
>
> * 4340a709bf (ci: fix missing Ruby dependency in "documentation" job, 2026-09-01)
> * 1c1eed13bd (ci: drop ALREADY_HAVE_ASCIIDOCTOR variable, 2026-09-02)
>
> But this is a third one (ci: use system asciidoctor)---it seems it was never
> picked up.

Ahh, that was originally 3 patch series.  I see where it went wrong.

Let's queue it on top.

Thanks.
