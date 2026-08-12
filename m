Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5025236896D
	for <git@vger.kernel.org>; Wed, 12 Aug 2026 19:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786564294; cv=none; b=TMTjGPO9vzZ/oXFtk5aZh2RUQUN0pjxYwFgCs52yyz6LL/jpDAz1ZvwuJRFpyNIzLHuOQOQIAqH1bAu3ualZ9hd065mveFxsoUmjY3UTnoXsmT7BKRhF7SuVN8AtQJPkhYoDgN19CgYykv9tu3ih4lLwmpHk5f+Bhy9mgkMuPNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786564294; c=relaxed/simple;
	bh=VN4NK0sf+fPRVMXxoI46xg5AoUq7IF5NGjzRYIPrIm8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QCo6szil4G3BSbHBRr726GsEvtN32sinQbhLBRbtYEiNoO1E9ndEvny/WT7y3txmjRyOz7eyHxJIrQjgK11SEwd6/O1LfR1MpTlvGV+7ttxSdW6F0gGvNXJuZhFEagbIiCO7rajbC5AOa4KzYCOXBIGV6Pq/gX2skp9lqr03I0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ipnayLjB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bjNxwElw; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ipnayLjB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bjNxwElw"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 55E411D00144;
	Wed, 12 Aug 2026 15:51:32 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Wed, 12 Aug 2026 15:51:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1786564292;
	 x=1786650692; bh=W6kKAinFVrj9/GFC/ZFh/AYtzx8zZHsNYDUQpyqGg1A=; b=
	ipnayLjB4LwuVJ+FBnEyrQ+9flrvB+QPx1FFz3WbV3OgYsyYMwD0PdHDeelnRunN
	j0NUyrY1iFf2367HgVPBYA4gYKX1RIBSULJ9sTr4XXDZOebPNdnakSMAVQCotRdp
	x6ywIzAEsbUSjRSQ9HVN4VImrupfqiAzU1MlnLPl4FjQu33iw9rcV4/cPyePTq6t
	3m6tEhXQXUO3zxBAGsw65jNtMTyr3VoTKc3BShDuvpRXtTMeW+Hy9PSW8TlyNHqS
	mofCvhvn5v1goz0YZqn1s/mYzEATFEE7XLDNQNfIBBXfuAPiTd9Swy4Z0V0O6Eks
	ZosmG8m2QV1pxEqNslDYLQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786564292; x=
	1786650692; bh=W6kKAinFVrj9/GFC/ZFh/AYtzx8zZHsNYDUQpyqGg1A=; b=b
	jNxwElwGsOE0ioVSO2Jg/mn/2XNX2txLQkORahqkA3lJIUsydb6AJAyeUv+gPKle
	iTX1GuB5gTqTf5FGn1UIltsh5/JBdTwBwykgaApvTZSTRFa6DGQJOKANDxxVJwHz
	uRMaakBMEORMzNDNUG+sv5TpW+WBz1mCg40e9Ge7Lj8QYtzA88301V27UoudyG8L
	AUJB4AfP1DhbmbkkvJuy4YDwyyhhEtKJlY0G6T/kf2gpryMZifwprniXv96zMaTe
	Fm+Z2q0UkGjoUq+aiK+9kt4MfsoqrbOLAwpaYEmKCMmZJy7gYeYzmN1KzywejOV0
	pqbTkyaKjAm++4SyuYCbw==
X-ME-Sender: <xms:xM58ao2PjBBmnkuJIAy05lYqCbkLyGXjyUW4h9gNld3F-JhyAddWqA>
    <xme:xM58ap-z-gsZC_GIOjuxsuBiKsU30gqs8dvNhBkGRKeUG7UGjCaMOaG7xVB44LNxv
    id6h7ULExMdnhcoJjtRmxSLyeCaknYZOsM2tMt6jzDqwusKt4PGwLo>
X-ME-Received: <xmr:xM58apPnxXKA_XcC4wXQxDQsN8CdTSJ-AVWiaXy62nJ0wgNbh_bNQLSDoTFt-3dPHAqh_-5iDis2lRwQrhKJAp_nw8y4IQ971g>
X-ME-Proxy-Cause: dmFkZTGvRKZxnM06Kpj4Fh49GxtCvthOX5w6fdpK4xu98CJWKHu1903HCSOd+RusFtJG30
    rtlKlkv8drpjQ/Yyxi7KbkaODfC8Jh61E8OlFSdnNaBibnG/0T7almEePN30MpBTtZASaC
    aGVzQiWzPhh9V6I775PbJPmTSMBaki7KetD0IlZ+9zk/waCL1P2lEdj4nzk2Zs6GAtIQGU
    X9gckRxNVW49LKIF2MGzV0hkOOpV8RlCAbFgf5ohOYfmusVgDV9qEbBfTMVrFEMBdPg9kb
    72lYPUMm6GrwFL+dnO1sX3lklbCYn2NaL9xGOO30Phc3SKW4YL4kQdiyr3frZoZ1BG+AHY
    L3tufEVuhQduitBO37iDfgOpozaUm5NfLXltYhzk7mab4NCZx72D3unmZe4xDn0z0TdwqI
    skG1Tn49FR5pU9WiSPRTa/OSlMpaKoiv0QRZRhV9MDTpxMolBmadP8q0VZWTWcdPSDE5+U
    iQbUxPDUExKmWQxyP3RiufkV/E+VuMUcM1oOR3Y6dpiSgSCfJaeSxEZrCSbG6mli/DnamV
    15ir7nnKjel8sesyFl5lOEQzmKAKHet7huV06gL6F4DoRKMNkL9HOymjyBvHRiwTl1wVx5
    tlkbWStWZ+2CFHi6Mrbg6xhbr9SRjfrLXqF7Rj5uTQpHD4Nx3M4jTgX2qCWQ
X-ME-Proxy: <xmx:xM58atfVdidWcXhdIWnJ4DV4qjOk69F2ZDRtgpKPsK59V98XnbRhEg>
    <xmx:xM58aoXzAVsBRm4T4L2MulCXIUx_ANHDDqzpiUrFXq_7L4qjcbUkTg>
    <xmx:xM58aliHNlkuQtPpWafpDIx59YeLBiUHg9RVy107n-Gis0B-YRoyGQ>
    <xmx:xM58an_4KWXvR5sTpmHH9dJL9jC-0HO85gFu9T-rxhHZrI7ikXcbqw>
    <xmx:xM58ar0mbJUZ2Uq5lFwhmNDViogiH99aHukOMj0KaX-EYCJcfBwiEo3Z>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Aug 2026 15:51:31 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Johannes
 Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] packfile: fix perf regression with many packs
In-Reply-To: <pull.2202.git.1786561870638.gitgitgadget@gmail.com> (Johannes
	Schindelin via GitGitGadget's message of "Wed, 12 Aug 2026 19:11:09
	+0000")
References: <pull.2202.git.1786561870638.gitgitgadget@gmail.com>
Date: Wed, 12 Aug 2026 12:51:30 -0700
Message-ID: <xmqqfr0jw20t.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> In one reported use case (https://github.com/microsoft/git/issues/970),
> N equals 37,815 and caused a slow-down of a simple `git rev-parse
> --short HEAD` (which is regularly executed as part of `GIT_PS1`) from
> 0.4s to 4.5s. In another, heavily exercised CI scenario, clone times
> increased from under 2 minutes to over half an hour.

Face with Rolling Eyes (1f644) 🙄

As we grow older, more and more extreme use cases that we initially
thought were simply crazy become reality.

> Let's fix this by establishing a fast path for known-new packfiles.

As long as the caller reliably knows that the pack it has is new and
cannot be on the list, there is no reason to cycle through all the
packs in the ring to attempt removing it in vain.

Clever and clean.

> diff --git a/packfile.c b/packfile.c
> index 0eee45055f..f80f05a1fe 100644
> --- a/packfile.c
> +++ b/packfile.c
> @@ -781,7 +781,7 @@ void packfile_store_add_pack(struct odb_source_packed *store,
>  	if (pack->pack_fd != -1)
>  		pack_open_fds++;
>  
> -	packfile_list_append(&store->packs, pack);
> +	packfile_list_append(&store->packs, pack, 1);
>  	strmap_put(&store->packs_by_path, pack->pack_name, pack);
>  }
>  
> diff --git a/t/perf/p5303-many-packs.sh b/t/perf/p5303-many-packs.sh
> index af173a7b73..4221f9dd70 100755
> --- a/t/perf/p5303-many-packs.sh
> +++ b/t/perf/p5303-many-packs.sh
> @@ -141,4 +141,8 @@ test_perf "load 10,000 packs" '
>  	git rev-parse --verify "HEAD^{commit}"
>  '
>  
> +test_perf "abbreviate with 10,000 packs" '
> +	git rev-parse --short HEAD
> +'
> +
>  test_done
>
> base-commit: 11c6700f10234578d10523faf35656ca491425c9
