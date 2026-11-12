Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=157.230.60.252
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794497165;
	b=J/bNLYdeLQ9cy6x1mvW9hjELlSn0fUiMheZ1YZjxMyAPhvzg93l9FNghm141eOneAODb
	 LT5huhNSgE319SIzafx+xh+i/Oti55eoMiABTxF7RblVRc7VwzzwvE/+dSjHAhswNxaW1
	 OTWfG53QhHzCsXKPIBRRypWzwNlKcB/SNUrRBPNGR/ulSY/B+YZc4HPwL8hzNfP/zvoI2
	 HkP7lwTckUo+ush2Mz4CmwOUINT1YPiYPg8Tlg2eqSyXB+4/E9h+36M14Oq1KMjT78U8m
	 YejL6kZ5ozYqd1fPO5+WNsXcsstnO/5/+QjmxfA1URv8Ge/6s1CiXEFPofCdBZrW4Nw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794497165;
	h=DMARC-Filter:DKIM-Signature:Received:Mime-Version:
	 Content-Transfer-Encoding:Content-Type:Date:Message-Id:To:From:
	 Subject:Cc:X-Mailer:References:In-Reply-To;
	bh=nPcqw+KvIVqefkDCn0wH5aGRQxoODU/9z4iVEt+LS90=;
	b=z2I+AWijrGz0j7hIBX7V4rITc2k30M+V3+jsjY9ymHubNUn2Y24OEmPmFNfjAgLIFIpw
	 +2QKUfzyAvCU6dV3b3u5tb56pa7IDXJgdYBDkKgyDgFM7kSIlP8iKTwtHOAt3OZmlcPnU
	 zLzfSYO68PMKOWLk82dqkVB56XNgp7BwBnhwA+tDwZiS6x1zrTu33x+dncswFKjwD6R3Y
	 LcE1H1JpF+TX6r0XUKctfchoM2H65LzNlEKILXEv6kvq0hlrm+huIPtbHqYOybq3OPqfe
	 iAyQX9JjYLQqUVtdx7Z8OLI8KHe6GbRXv39XMnXGnagDKhIOopKIolnBvdIXdoIQwdw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lfurio.us;
	spf=pass smtp.mailfrom=lfurio.us;
	dkim=pass header.d=lfurio.us header.i=@lfurio.us header.a=rsa-sha256 header.s=default header.b=FO8BLsPG;
	arc=none smtp.remote-ip=157.230.60.252
Received: from mail.normalmode.org (h01.normalmode.org [157.230.60.252])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16CD6606A339
	for <git@vger.kernel.org>; Thu, 12 Nov 2026 15:26:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 16CD6606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lfurio.us
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lfurio.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lfurio.us header.i=@lfurio.us header.a=rsa-sha256 header.s=default header.b=FO8BLsPG
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lfurio.us; s=default;
	t=1794497158; bh=nPcqw+KvIVqefkDCn0wH5aGRQxoODU/9z4iVEt+LS90=;
	h=Date:To:From:Subject:Cc:References:In-Reply-To:From;
	b=FO8BLsPGMx9QVKpNwvZEMfIVXOTeEDpCNXL7vKLUPupLDoszR7TkZRYhkhkrWBJ65
	 LWTWxB7qERgriyemgHqloosw90m322CFy9kDkzp1rgI32KZhxrhr0EiCaq0FB/72Qw
	 qOB/Oc6F08M66t+46ckSsjgIoQ/u2UE0GFDDREYg=
Received: by mail.normalmode.org (Postfix) with ESMTPSA id 523D6634E5;
	Thu, 12 Nov 2026 15:25:58 +0000 (UTC)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 12 Nov 2026 10:25:49 -0500
Message-Id: <DMTC5DR3ROPP.5V7HNV9ERYFT@lfurio.us>
To: <phillip.wood@dunelm.org.uk>, "Junio C Hamano" <gitster@pobox.com>
From: "Matt Hunter" <m@lfurio.us>
Subject: Re: [PATCH v13 0/6] fetch: avoid fetching every branch of a new
 remote in a shallow repo
Cc: "Harald Nordgren" <haraldnordgren@gmail.com>, "Harald Nordgren via
 GitGitGadget" <gitgitgadget@gmail.com>, <git@vger.kernel.org>, "D. Ben
 Knoble" <ben.knoble@gmail.com>, "Colin Hinton" <colinlewishinton@gmail.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <pull.2412.git.git.1789829246437.gitgitgadget@gmail.com>
 <pull.2412.v13.git.git.1793357550.gitgitgadget@gmail.com>
 <CAHwyqnVJ3eUQ9tkQE3rhQ8jFZjaD0tFUv41unE-NQ1WRiyfjBA@mail.gmail.com>
 <b64387b3-294e-49da-b40a-0e757956bafd@gmail.com>
 <xmqqcxsbnub5.fsf@gitster.g>
 <5566b994-1070-41d3-807b-5fac9ddaa3d8@gmail.com>
In-Reply-To: <5566b994-1070-41d3-807b-5fac9ddaa3d8@gmail.com>

On Thu Nov 12, 2026 at 6:16 AM EST, Phillip Wood wrote:
> On 11/11/2026 17:37, Junio C Hamano wrote:
>
>> In any case, this topic one is keeping a topic by another author
>> waiting to settle, so we have stronger incentive to see it move past
>> the finish line.
>
> What topic is that? - I can't see anything marked as depending on this
> in the latest "what's cooking" email. Would merging the first part of
> this series unblock the other one?

I believe that is ch/remote-defer-follow-remote-head-validation, which
doesn't strictly depend on the changes from this topic, but the two have
textual conflicts that the other author is deferring to resolve when
this one lands.

<CAHeTm9M5maWM=3DyrJPNzCibv_rewH3-yBK8J5-MDyDvPzfihe4A@mail.gmail.com>

It looks like if this topic were merged up to patch 3/6 (fetch: infer
branches to fetch from a refmap-only remote), the situation could
resolve.
