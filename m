Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 652A12BEC52
	for <git@vger.kernel.org>; Mon, 24 Aug 2026 20:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787603138; cv=none; b=IwDd5U7oEAvBYqKzKs1ogMdTQchlqRvjwAC4oLEPsHYbfOrlw9Nz5LlB/RUuzpOleHJUU6Jez2cmrjtrHjbWdTnF95g4GSs86cBnqiJn9qfzivy0ssAevH3PSHiCdiC1J/jydVmUoFvRP1SPEx441n/WQCJzVt4zNp0Y9n0Vswo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787603138; c=relaxed/simple;
	bh=N/vVswanyL2TFDSJwmyNmEK/Lg5Iw9QiXeXD9XSm7yM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=owhwQVBzAky5e6K3kqBhlDE47N/t29S9vOnNaohP6YtmZdBwtqFn8eu2ZV++lfHdt2LLF97o/0PYKmqgaag9fYLtUxlxIdWy781Ev7gRLWy4I4SwqttxWhuXgscPau95DseyIMF+PfC4zNF8mPVRWTZHDmZ3TVp4xlsnuQWr1j8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=oswald.buddenhagen@gmx.de header.b=ds4zdwRP; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=oswald.buddenhagen@gmx.de header.b="ds4zdwRP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1787603134; x=1788207934;
	i=oswald.buddenhagen@gmx.de;
	bh=N/vVswanyL2TFDSJwmyNmEK/Lg5Iw9QiXeXD9XSm7yM=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:In-Reply-To:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=ds4zdwRPQ6IHeLrBtQVI9N6Tl9N2g+6bMXAAuBMAc8JxLuaJtHxifKz7p2qY/jwU
	 azi9NzX8OrOA/aIKtdIy5BqNWpUORUSN5t2GvB4yy/WdwuoogsUsKFNBqTiLZVwKI
	 D3D4ygdm+j/fgSanSpt0e4wuL3sa9tyjrX/jUXwX8DlI5Znwf5+8YAxK9ojzc9TjJ
	 XrKbMWQx3Oau6VBM1d3weJL/1KK9rPSbXR0gx0JhyBUPiqzpU6gSieqnPjbspGCMZ
	 T7sftkXNjEpizQtd2mcRlQOkojrMu1jMvEiMkTqAECqeLC2R9dkhUaJ6kO7VzS+eF
	 irTqtJdkv+NKRwX6xQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N5VHM-1wsSOq1qLS-00x4M6; Mon, 24
 Aug 2026 22:25:34 +0200
Received: by ugly.fritz.box (MasqMail 1.0.0, from userid 1000)
	id 1wybEV-x5U-00; Mon, 24 Aug 2026 22:25:27 +0200
Date: Mon, 24 Aug 2026 22:25:27 +0200
From: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
Cc: Weijie Yuan <wy@wyuan.org>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Alexey Samsonov via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, Alexey Samsonov <vonosmas@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 0/3] treewide: migrate from legacy utime.h to utimensat
Message-ID: <aoyot_mI2uX8VL8c@ugly.lan>
References: <pull.2209.git.1787322203.gitgitgadget@gmail.com>
 <aonIVn-ZQoMKWCAd@fruit.crustytoothpaste.net>
 <xmqqzeyeujde.fsf@gitster.g>
 <aor07LvsXOy1p7vh@wyuan.org>
 <xmqq5x10vowf.fsf@gitster.g>
 <aosVkqwcsmAWrDr6@wyuan.org>
 <xmqqfr04thhe.fsf@gitster.g>
 <aoxkQHCGJENGxV2I@wyuan.org>
 <xmqqjypfqz9e.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <xmqqjypfqz9e.fsf@gitster.g>
X-Provags-ID: V03:K1:tgkAs+pl4hy7t6w/aK22L6qnCzlOl6Tj95fKCWhtqU8X+TRS7C6
 dSKWhd5yavOwsHtemhv7E4PT8KhivTgmZs0QqPLEg5oUIWISW/cx5GPfi5hu7XEl4SS6dVW
 qcpFGicK5YYVO0pNS1LBLSEupm8lfYdx9g1tSv16JKiJ6mRIuu9ZafQ4ppq6/OZD1UJCW/8
 xgLp9dWbVdJx3QTrljXoA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:4lUU6yFp3oc=;NGiu5kSweNhyicqGLlLi8N12/0I
 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
 Dhc9hLEgSqIzdnEjEnmUeMRXOf/TQxi7S8FSrg=
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 24, 2026 at 09:06:21AM -0700, Junio C Hamano wrote:
>By "sufficient due diligence", what I meant was that I trust Dscho
>well enough that he's done a similar analysis to make sure that he
>is copying from ourselves.
>
i think the salient point is that it is never reasonable to make that=20
assumption when an AI tool is used. some of the tools now reportedly=20
detect themselves when they are outright plagiarizing (and identifying=20
the tool in a trailer would actually give some assurance in that=20
regard), but if the tool fails or doesn't have the feature in the first=20
place, then all bets are off. Literally No-one (TM) will use multiple=20
code search engines to check whether the generated code doesn't contain=20
sufficiently large fragments that are (near-)verbatim copies from=20
incompatibly licensed code bases.
