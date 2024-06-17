Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07B743AC16
	for <git@vger.kernel.org>; Mon, 17 Jun 2024 19:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718652834; cv=none; b=faz/0ncXUC5MKJJtiaxqRoKFqeFKVg7z/5YyI41fw5NZQ52ardKoghpPPiWqwepPeELlUouf5pMczRuqGIE/0t96LQKviP6Y5Feeapt6einxc5my4uuvPt5lNBV7dR58he/B7aIBX9GFasgq2xdTg1rip26wOD3dX9tUIhm11YY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718652834; c=relaxed/simple;
	bh=qVTVsQKPPmmGWgwuKDuYEodfRWSCyuTrrHYL5nlZEQY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZlaTfaaaGHM7V/p2Vdfcq+Vgqv9H8W8GwBg/1dKNvwiv5+mlMKh3TLrSEQM6aTNYoRSKCWKJAHv64s9GY2Nt8ewCp14bIZv3UwxavtIFSCSlXrb7AEBKNDnch4LGU7XP4T7ROsfjCbW97qjQcDiBBAptHvFoSqchiVA2wcC4cpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=GbyhO63j; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="GbyhO63j"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 791A835934;
	Mon, 17 Jun 2024 15:33:51 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=qVTVsQKPPmmG
	WgwuKDuYEodfRWSCyuTrrHYL5nlZEQY=; b=GbyhO63jcrhIfRQseWSjdkN/Ealg
	iKljVb4r4uSWFyFs/yZ6y27Z2tEKJPFHTUNdTLgtLzWdnHdu/mCNeH0T6HIeXMR2
	/F3LxBZ2yn1snfY+thz4e/pJTmFCTn0y1UYheJzSgBRvixlMZdvEWKEOOIQHX3um
	pa9Ggf0Kku1QZ5k=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 717B435933;
	Mon, 17 Jun 2024 15:33:51 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.204.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 1669735932;
	Mon, 17 Jun 2024 15:33:48 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Miguel_=C3=81ngel_Pastor_Olivar_via_GitGitGadget?=
 <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Miguel =?utf-8?Q?=C3=81ngel?= Pastor Olivar
 <miguelinlas3@gmail.com>
Subject: Re: [PATCH 0/2] Symlink resolutions: limits and return modes
In-Reply-To: <pull.1751.git.1718615028.gitgitgadget@gmail.com> ("Miguel
 =?utf-8?Q?=C3=81ngel?=
	Pastor Olivar via GitGitGadget"'s message of "Mon, 17 Jun 2024
	09:03:46 +0000")
References: <pull.1751.git.1718615028.gitgitgadget@gmail.com>
Date: Mon, 17 Jun 2024 12:33:46 -0700
Message-ID: <xmqq34pb749x.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 849EB83A-2CE0-11EF-AB79-C38742FD603B-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable

"Miguel =C3=81ngel Pastor Olivar via GitGitGadget"
<gitgitgadget@gmail.com> writes:

> The current code already provides a limit to the maximum number of
> resolutions that can be performed, and something similar to this is ret=
urned
> to the caller:
>
> loop SP <size> LF
> <object> LF
>
>
> With these patches, we are looking to return the actual information of =
the
> object where the resolution stopped. Something similar to:
>
> <oid> blob <size>\nndata\n

Just a random and idle thought, but is it all that interesting to
learn only about the object at the horizon?

If recursive resolutions are limited to say 3 levels, I wonder if it
is beneficial to give full record from each iteration without losing
information, e.g., saying "A points at B which in turn points at C,
and I stopped there but C is still not the final thing", instead of
saying "I followed links and C was the last one I saw after I
repeated for the maximum number of times the configuration allows me
to".
