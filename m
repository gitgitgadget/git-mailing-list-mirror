Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F287185954
	for <git@vger.kernel.org>; Wed, 11 Sep 2024 15:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726069994; cv=none; b=lAeOfD1bua0e92fu40Ubl288ZHKDzjhQ8DDUrhl0ezkgdknBNcG30uJVrcJDd+TKKSG1hG/0vp2BRDUXt8qyOs1cOoCNevltxuaj7y67HAeUPdyt5cJxG6aXm3ETZyUGu6TOa0qaSpQhGd/B0tStAvabLAn4QiSM+lwSiaWohZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726069994; c=relaxed/simple;
	bh=GsvouaRJXgB//8TrwU3cRxsxHQv1f0fAnzLOwz2igxw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Pxm2ISTyttl373YVH+VssfNo/X9dLF8MXQhtomz46sSxXQgerlE3+WchMK5GsREouJjtJTXdvcwfML+bUtO90Lh6GR30xsfpZd7gSl27y0VZ0wBbW1L7kfmjwTrxcgrBLo+fx+rlRBr5vVfFUa/iSiaoCUVxqlbBSSPo/me0JUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=GSp3l8ea; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="GSp3l8ea"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 17E1019FEA;
	Wed, 11 Sep 2024 11:53:12 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=GsvouaRJXgB/
	/8TrwU3cRxsxHQv1f0fAnzLOwz2igxw=; b=GSp3l8eavlI9ZgYM66HhikM30/SV
	pFKXmlY8ONDwW0puOHKqtFpybPElFvOb52FpOCp2iRJMLc82ZoLT7bGRtqebPUw5
	pKwycAeOm58HdSXSwlSPEq7PNch7YLCa8trqlhzvUFdo6Txi//I8gb+YF3H/7fzn
	1VpeTsRAt4D4qZ4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 10EDC19FE9;
	Wed, 11 Sep 2024 11:53:12 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 67C1119FE8;
	Wed, 11 Sep 2024 11:53:11 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Cc: git@vger.kernel.org,  Jeff Hostetler <jeffhostetler@github.com>
Subject: Re: [PATCH 0/2] add missing LIBCURL prereq to a few tests
In-Reply-To: <cover.1726049108.git.martin.agren@gmail.com> ("Martin
 =?utf-8?Q?=C3=85gren=22's?=
	message of "Wed, 11 Sep 2024 12:30:58 +0200")
References: <cover.1726049108.git.martin.agren@gmail.com>
Date: Wed, 11 Sep 2024 08:53:10 -0700
Message-ID: <xmqqwmji9ogp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 F27A1512-7055-11EF-AFE4-2BAEEB2EC81B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable

Martin =C3=85gren <martin.agren@gmail.com> writes:

> Hi,
>
> I recently had reason to build Git without libcurl. That surfaced two
> test scripts that use `git http-fetch` or similar without giving the
> LIBCURL prerequisite.
>
> Martin
>
> Martin =C3=85gren (2):
>   t1517: add missing LIBCURL prereq
>   t0211: add missing LIBCURL prereq
>
>  t/t0211-trace2-perf.sh  | 6 ++++--
>  t/t1517-outside-repo.sh | 2 +-
>  2 files changed, 5 insertions(+), 3 deletions(-)

Thanks.
