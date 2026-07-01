Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C2A03DDDBB
	for <git@vger.kernel.org>; Wed,  1 Jul 2026 20:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782936410; cv=none; b=QCoXIDsn9xLhui1A19tzX/xMdGQtul16AOHmdSeJaCiE0HdCah1r7fVEsYUllIhB12/vGOAyZuOZ4rcBdM1zETZGlxIGwUq01hVBn2C53v9uMuJJG7McjWnlzsGTCXTqlHvrNqbFIeEqXHJzH8F7PAFvImr45JHJOYkAjFvYI/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782936410; c=relaxed/simple;
	bh=qrEFbxnaU1t/6dlEmdhajqs6x2hzet//ve3iAe43N2A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cMssiBt/+AWZBPU950e1DE2eByZrzTeFKPruQiWf6mtqYpozuU8Tq7QG0ZYi+u0lVsTnY+eWzrs+PsInIVlv71idwD02ZikFFbnMhCqaKjv35iCrPr5iKijL5brGdZ6oDSHuVy58SbMX+R7tmfL4RlotHx5j4Xsb9AzmaECHeFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=d4hE3MYG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=N8az38Zr; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="d4hE3MYG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="N8az38Zr"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 6496C7A0055;
	Wed,  1 Jul 2026 16:06:46 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Wed, 01 Jul 2026 16:06:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1782936406; x=1783022806; bh=jJ7SQjHB+x
	IYgVHcC2GSTofpiJcvhknrzQMxEz3pPJQ=; b=d4hE3MYGUhKFaWVYIkZDROxdra
	eodNXVnTUdXMEzt7ni0EkE6q27QV7UobB07+qVB9ujAhei8efOJ1N+k1ZVwRk8yZ
	ANOR0kBfux5X7Df8OP9tIB5cIBWcUo0XzDiGuulNdQeMxcz2S0jjnHkWztpRwmef
	UXmYOKFmyvh534DF/SNpBeLsLllmMpV+kVqosh7I2BX88Z3Q06/fqMXYSsAKfOyl
	8/ab0JVBrEF2sPCixloo/Jea0bQq1Vom/Ug7G4Dqq5E4LB3xJ/V0HmE3gmo1AeVk
	slkVeh3r++Hu9GwuIlvwOglFn7e8trKv+brq57W6aEytzjZGvFUqYpdN02Qw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1782936406; x=1783022806; bh=jJ7SQjHB+xIYgVHcC2GSTofpiJcvhknrzQM
	xEz3pPJQ=; b=N8az38ZrUY8q0FWK0/l1V1mfeCXMhLBYzGz/1x/B/NZw50/YiFv
	M0mZnDFfGWZcw48m3d7mF2B7kkNVrtMOd9I/v8dc/NUTjSg/MdnsvXAALfajbr6K
	OoT7JsjwQMLPQKoNmwbkqvLpBURZi2q+tLjFVuzgmvYdeo6SpWS2e7zB/tZV8Y/2
	KkCYkIbZrlE8GG8VsBEtjA9JuqD944S2ld3gkdmEn315KR3ebGK3V5VxhZ2fKIwN
	o5NXjTkARsIREe9DHq7luOcey4g/39FlVsjLkA/Hgfw6uiUJdUlUG2/+d38HwzeO
	5aKNTjoGew1SwOp/xQsjHbWnEl6K5GneS6A==
X-ME-Sender: <xms:VnNFakb1gIIL4IRcw8h4-NfcUI_hT2N3SQej2nNFm3jHN5-xVdgKow>
    <xme:VnNFamYT_KBrJ-_kGmMbD3nOyFJfYtRDYFKFQ9nnXOXkowIEhaFOl3uu-UnHvPmu0
    qvR-dm7orvpl_DLzFa9LjisXRtoVwW-t40aczb2IqGmdb5jNpeN4Q>
X-ME-Received: <xmr:VnNFaj_0s8jTcl9eydKGHYY43PkTyB1zIyh5FNl8hr1UlUx7pxmp1bOE3ms_PoeRJR9kxpDX7B-0-gGs0GOjTtRcZ475uOa7BC-EEx8>
X-ME-Proxy-Cause: dmFkZTGHwFCRTWZsZyXq8+cgh6/ZruMM7YmoUvNfaeB4NGiyoT4MW3iX0Y8t32Z7CikxMR
    3tdruiCdeF1IDpYugKOo9B7ht9rd3YMl8dx6LkDWkpaVhKkFgdjgj29vZVEXMnwlu+JHBd
    bspBpg49a5ZRYiNumbDzsQxLoKfVU1uH+o/0mP+ME5BA99izy3Wg4gTPPNE4PTmLzS/8O2
    +7SOeoIET0AeAla0t05PXLmA7HcStNAA4z+RiYeWd+Gz/bVhHnv4pjOJzNlOfpypV4G2IL
    MjYdoD8rEGzvQrJNqrXRw52q25x87cJe8NU02TZZ7qyCmo7gWJiXv2iOTSdYl+Atz81wfK
    F5Oavvv/3pOBQhO5lKjQeZJl+Wv0wJQf3SbIpUrgD77kfX+w8Ffuv6voPHzzW0JJYv/p3G
    QCle+pWHCP8i6tLYY0pIrpK1330oQogWwYKdYO0TB3p3ebE1YYivXALDjFDjd/oIOtM9H5
    m4L4BYx3SrYSQI29M2uK4xzb7vux354HmCYa3jxGzV8+8jfWs34l56ljRaPSRE9OV94WSe
    1TY/3aFEzH9bhZvCoYoBovLpJdEuU/UXlGqNOc6/J/xthPED51Wm7VZvLotXZV96G8FPOS
    agCL5Ch8LKlFqFmeQw2x9ei+4zt2z6/uBy7wfdraDvjRIEXKmbSheOulqzIA
X-ME-Proxy: <xmx:VnNFatimQ8cClSRTvZiKkOpXPOvpAUJJAnolVapX5VsnGR-W51qm5g>
    <xmx:VnNFardPFWxWVBMWqb7VTM1hal_fZdvqwEdZ4E3NLMLEmulP6KTUPw>
    <xmx:VnNFasqo-6cOdGIydc5esf62jYjPP90hPqcN7NLOMuspxVesr3dEOg>
    <xmx:VnNFaoBt7-3fa4qrWRilU2PyOHIa5p2_lZ2so_4fikGctoJge60hbQ>
    <xmx:VnNFahEhGFf43WUZtychGksY7TEISZu5RgYdyNJjqOONcJRcaF4IBxXy>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 1 Jul 2026 16:06:45 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Kristofer Karlsson via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Kristofer Karlsson <krka@spotify.com>
Subject: Re: [PATCH v5 00/10] commit-reach: terminate merge-base walk when
 one side is exhausted
In-Reply-To: <pull.2149.v5.git.1782923832.gitgitgadget@gmail.com> (Kristofer
	Karlsson via GitGitGadget's message of "Wed, 01 Jul 2026 16:37:01
	+0000")
References: <pull.2149.v4.git.1782649547.gitgitgadget@gmail.com>
	<pull.2149.v5.git.1782923832.gitgitgadget@gmail.com>
Date: Wed, 01 Jul 2026 13:06:44 -0700
Message-ID: <xmqqpl16mq3v.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Kristofer Karlsson via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> Changes since v4:
>
>  * New patch 2/10: added test_trace2_data_singular helper to
>    test-lib-functions.sh. Shows expected/actual values on assertion failure
>    instead of a silent grep failure. Makes iterating on step counts much
>    easier.
>
>  * New patch 6/10: added clock-skew topologies (se-, se2-) that expose
>    side-exhaustion bugs when the commit-date ordering fallback fires with a
>    v1 commit graph. All topologies use a shared skew_commit helper. Includes
>    step count assertions for edge-case tests from patch 3.
>
>  * Folded the nonstale_queue dedup wrapper removal (previously separate
>    patch 6/8) into the paint_state introduction in patch 7/10.
>
>  * New patch 10/10: remove the commit-date ordering fallback in
>    paint_down_to_common(). The fallback (091cf18e) was a performance
>    optimization for v1 commit graphs, but it breaks the generation ordering
>    invariant that both the side-exhaustion and single-result optimizations
>    depend on. With side-exhaustion in place, the fallback is no longer
>    needed. If kept, this supersedes the separate "commit-reach: fix
>    !FIND_ALL early exit with v1 commit graph" topic.

I thought that the plan in

https://lore.kernel.org/git/CAL71e4P4GbYYv1LdarAbeodm06q841wj4gdGpn0QYADQjOB5gw@mail.gmail.com/

was to make this v5 on top of kk/commit-reach-find-all-fix topic.

I tried to prepare a merge of kk/commit-reach-find-all-fix into
v2.55.0 and then used "git am -3" to apply these patches on top,
but there were conflicts, and after resolving 7/10, t6600 stops
passing.

Perhaps it is best to ask you rebase these patches on top of a merge
of kk/commit-reach-find-all-fix into v2.55.0?
