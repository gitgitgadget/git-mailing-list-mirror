Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCDB8221DB2
	for <git@vger.kernel.org>; Mon,  9 Dec 2024 11:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733745192; cv=none; b=hxk59kld0AcvYTE5OhD58oDxqBUxFpZQvPXWjtRD6vx/nptv97jf/xpH7E2wyqlkKcRAuFsTrXdbtTUza/bxurb1RKSHqPlDlsdoJaOwVbTRofmfaDY8kQUi8iyWsS9PsgUtPY56GbcsD6xDsbteym3CbC35j6sLsYCRezrMrfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733745192; c=relaxed/simple;
	bh=IWtgFFuftg6jYbVtiMWBsmjkziyZ8O1rCstcpZYFHso=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=to73ldh51ZHW2T5e1UBvQ7DRhDga+DlHp3N9xEM2b2b32feKPSXw8wuyTJL0/7r5D40io9ZJdvX63FwDR6mc3CKoN9vY6MU4WC8pqFLFi80Ayx4R73AZivRqzfbj9E5CwEWMO38+HhCw/ftzVOrg45IhEIJjfUDf2OSkWdqnpu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=MNY7fr/w; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="MNY7fr/w"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1733745181; x=1734349981; i=l.s.r@web.de;
	bh=9s+uas+rFlSf1wRrUVEHfxGG0RyVphSr0FNj2sPtMlU=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=MNY7fr/wKZa223tOmhU3/WgDYxoxE4LWIc3Fo7GYCg8z5m5vqTkl3vf+3rX+b6cn
	 6iKntkTvnQuo6IkGZ7Tu8N6EcF1PuUmt1ifeLWBMC9+Qp9VlQBh/igoVtjsAhl/BI
	 PzutRJxLN5dxKoO83XLly4KsfEMLUA7s2Z2pqq0LWy+pHAiCSFa43qsqedpzQrNwI
	 WvF1wRKRkcOwYwohXgn3GnRexsO0S6fFW8rdb7q5VPHLo7zdhL/PkxUcSE50sq9Ly
	 OG4cjClth51+PTKlWPS6P1/W3tKGLPS6CU4tG7JsMZBL4OMfmoKMzcZvJyV2bKKM7
	 LgDYPk+0NWaMuCDs5g==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([79.203.30.137]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MdwNg-1ts22s0Unm-00hCGR; Mon, 09
 Dec 2024 12:47:40 +0100
Message-ID: <4c8604c2-4287-48dd-b1ec-78ba9c1401f0@web.de>
Date: Mon, 9 Dec 2024 12:47:39 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] object-name: fix reversed ordering with ":/<PATTERN>"
 revisions
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Aarni Koskela <aarni@valohai.com>, Jeff King <peff@peff.net>,
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
 Junio C Hamano <gitster@pobox.com>
References: <20241206-pks-rev-parse-fix-reversed-list-v1-1-95a96564a4d7@pks.im>
 <20241206-pks-rev-parse-fix-reversed-list-v3-1-d934c17db168@pks.im>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <20241206-pks-rev-parse-fix-reversed-list-v3-1-d934c17db168@pks.im>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:PHbeiZ25XpEDs13hqBWdpkvjpqIrmBs5NV9NALFMS4kf303Ld7N
 i647dYbcr+bqdf5Nd0W7cH7PRK2VmOn+61/25WfwoHnBMHlj8OWFQFiMETSWNRZbay3kyYu
 r1wCpXreGLfJli/+W5WDUAHFFSg2mtR8p6paHK2O+4iQD2N+ym/F8aYuDHO/NeN44FyDaEW
 Tvgi9KVqf6mUwOrcn6fYg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:GWpUTqHparE=;D7ZYYCkNUjZLmi1z2CdBUh+U1MK
 dWA7fJZrBiD8DENFLMsSktO3SP4LKjUvLIvH9xfZDPoyNrxwgyrIZ2TE6dxOOaMC53mZOiPMd
 pKzcJZ8+3+lJYL2eqfoaqbZ+uDa7BovD4rT76GwFryUW/Dw4FI5HBm0WUGqBzkiR0yarjsRhy
 TI2PWGaJ3lD7zlU0oFen0OzU8hyXUxln2vPGAAgEdtVOODcJfYj/tTzQmrBifJCeGZbspsFNH
 vNCqhrwAXZh0JbG5ba13G6WvkmxSOhs47GDuExFGmo7Uk6IOK32KAtQ2oz2ClLbkUMQQfgX8F
 ykXvRWYN8WbDed/EfV6eNEOcNYTIo/c3Q1x4kBYO6SaWNMkTNCGqU4vnh3h1i/j0psLyMG7Dq
 z4wQBG7Iz+Q60HI3qVZWIv068xf5tIA34yl4oo2PAv4RYHdcwgwrhZpOYc9i+NMdFpnIMuNi1
 XUWyIsvQuFMrmdLKd1uHmoJEIEExlPvBVCipEomgn8UpF9oDOTAJNcXm5cW4bU5cOx/MJxD99
 4p6ts6DPkIKlrQ2SKaZKTeYQLunqHvTOsBEIGr/xZyhM8wtFlnl1BcmLZk7J7NtBBE0CYz2ah
 jY7AZgBnmRVZJykgtKj0CDu4EB/Glwc/MJY70CH0OimO/3yUTtvcExfw6aD04UZuMCzHE5F3q
 wOl+N45ys8mkmmLl6I3zH1/hNxMgvRoGVnIQc/jAB5Rdc1YO6HrpnT+kCBVvIQxqbZVcvWobG
 IM1m9gfMVNLD/n6X26V0hDeaQz02vXFILwXF/UBMOQgF9pkYPayP1BOOG9tV0aP+BirsN+Aka
 3KQkQZCeHyohUSCPV4XitHctBpQYKdedZretTJBBs82Y+cWwMUpkXu9r3d1+JBUiTU4+pMRo0
 83mYA6ImJWp+bRtlaUeie9Vpjj3fg1NK4qJ/SFHLNTMlVpMS1XJNm7TBTQ2GVQ5Nn94GDliyd
 TWCnkP5ZZgT0MoGNX9eE5WesTNcbqgoHNnlzhyU+pmqcwKU5BFgopPAoLbCizUvG80f/rClAy
 H1o7LXKiGyHRm42Vy/2bnOAX0PFL1uevwpvq8tPRZfW1ELsxyuVOrJ3e4qoJiQDLX8qsOr9aN
 pluTEDxS4=

Am 06.12.24 um 16:45 schrieb Patrick Steinhardt:
> @@ -1423,7 +1423,7 @@ static int get_oid_oneline(struct repository *r,
>
>  	for (l =3D list; l; l =3D l->next) {
>  		l->item->object.flags |=3D ONELINE_SEEN;
> -		commit_list_insert(l->item, &copy);
> +		copy_tail =3D &commit_list_insert(l->item, copy_tail)->next;

OK.  The following does the same while being clearer:

		copy_tail =3D commit_list_append(l->item, copy_tail);

You could get the idea to do that replacement across the whole source
tree.  That would be nice, but must not be done blindly (e.g. with
Coccinelle), as the result will be different if the second argument
can point to somewhere in the middle of the list.  Here it's OK because
we indeed are appending (invariant *copy_tail =3D=3D NULL holds).

Ren=C3=A9

