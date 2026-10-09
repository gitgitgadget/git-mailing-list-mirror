Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34CC6371899
	for <git@vger.kernel.org>; Fri,  9 Oct 2026 08:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791534306; cv=none; b=QMNsnk2eTVckBdVLXsKgCxLMQSwnWAo2x/S5TV2VfM83f/Gk6ZZUUmQ8Gsho5PcnaMj4OgcAAQeWpy3xghxFVcZzoG5D/vpwiwwINXHazBi4D+oSZgpVmYS9ub6uxqwD7ZQblAUEhrOJEvUOf9KtxyjqoSf1bCvT2roUqrb8JGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791534306; c=relaxed/simple;
	bh=2LClwQgdAiY14n4/YKvbjXhi13pQMPNfjYLc37CiPNc=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=L9SLlitgWB53QWYOgMWNHH221tQWUyWo7SouZAMIxx7Gx+nQy24cyr20UJogf+bOarCT6nJUZMQVKtsMvRAJGIXjy/IlYXbLiwUo4QheSetSdE5kyF3inExSr2MXAs3BTQGgYTAj+K/UQQFXbdKLdAFK8JivEmVhQi/0UBMk9U0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=J03l4hdf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=I9nBmByG; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="J03l4hdf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="I9nBmByG"
Received: from ams-compute-01.internal (ams-compute-01.internal [10.64.2.61])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E79FA1400069
	for <git@vger.kernel.org>; Fri,  9 Oct 2026 04:25:03 -0400 (EDT)
Received: from ams-imap-15 ([10.64.2.35])
  by ams-compute-01.internal (MEProxy); Fri, 09 Oct 2026 04:25:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1791534301;
	 x=1791620701; bh=d4QapDI+3sO/AcZ7zb/Tt04NeoteLDTSwG/jk20YPZc=; b=
	J03l4hdfd4D1S6yFmFwBKUsOxRg9QCvMWEXxvMn7Hs8ymKC2ldKPyoqptBOZD/sJ
	LweHOrFPOuqWQod4XTKX0Gn+AG5wYH1sCV6bMIj/iXfs2wjbJgc7B8v56kt9pftl
	0OR4SKZxZStT0YQyu+zdb5JqnA4zUeEjFY3v9BfDZIpyt8r3lLysCvCQ9uctvv0h
	oan2nqTsViKduWXPrt3h3hJcdcaSqGrF7IBuLq/D2kIOyrIjuuZAd+fX8VIy2OiB
	4sDm2CJRKvmyuk7xewwir7Hv3FLOPvcJ2J2osFTnx2pVAyymBOcQAscUd/Ea7rnv
	FTQyYnnmzZbgNtU4VKZcpA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1791534301; x=
	1791620701; bh=d4QapDI+3sO/AcZ7zb/Tt04NeoteLDTSwG/jk20YPZc=; b=I
	9nBmByGpeaXB5dWGVRlIAhSxQ/X6hZmKgFynAI7m5g/kcHVvmiEM/OtrIYxZIaVf
	b8s8841PSXCTbTQGndYPMI7D10yj7Rkn2ohhYYKvhi2T+k0M/CoBdLYcO1TtZWmI
	AGC527RoAMXoZmS/Maex9LVcjemDlny5P98v02Qz9IdA6AkN4Z4d5lYyAo/VlIm+
	9OPjSSJc85p270u+PsA6uL2jRW/qMlEnxOkdVNIzzO/N92WPUZCXv2WUqS8LQ/7B
	QBnrDAICvaCkkCIZliqVrenWKnb3NntIcoBP6fPZI9czpDrLtRwHbaMmEpJe0942
	WR9EJPsDglXXTH+j/+OlQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=fastmail.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791534301; d=fastmail.com;
	mf=PGtyaXN0b2ZmZXJoYXVnc2Jha2tAZmFzdG1haWwuY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:HIfaiY1hmpc/IEuhXMKZhzQo78n3Y/+sOy1LEviVmtsjycP
	F0Z7B/kd7X4VIzcb8pCrZM4df2J03+eDZi2oZsMZ7L1pu8xGuGLC/EzyOnhPKZRr
	iARzDxr1rhJBzGBqHzQ2dNzmZC8Owky45eGyIIfpN9LqfHzbvyA5nqZGDkIzRvhI
	i6eZkJ92i6TLGBWzb5stoSW34YAqQRN0T3U+k17Q7TeP+P89whNarRsY0u1rwkzo
	QNqmHyKN8h6ixy/AfmBAmaI0IzJxD38YXxWWOdgrqLTSDUxlpEHHGh8v/esOBXh6
	/lW9nmbxLmKp3RcrASDbrusEFNOmygPJUuQUGyA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:mREOgKeKnqyRR8Iiwvkpp39al9rh+lfraR6lI4F5SDk=:2LClwQgdAiY14n4/YKvbjXhi13pQMPNfjYLc37CiPNc=;
X-ME-Sender: <xms:3KTIaj6G8XGMhaWG4TsTyQSbkJoEPD3j8rhmAq_7cboGSENpzgldx3I>
    <xme:3KTIajuwKOMP5X4UWocoCUpFLlEUWuyXHZYpzhOftpcLnQAJdDog3AmYojxLTcOPP
    OdOm4gPQJhW8qw48Llet5ERKO3hS4ePre5DvtxmoG3Xgc6CPJePYFY>
X-ME-Proxy-Cause: dmFkZTEYcREgcxAuhEbIYz8rDGiYGhBuQ9PA1bFF5M6ykcjp35pleFtlKv+lOBs1gpZkqR
    eEk6VkSGaWsnaUNsG9NI7JsdFnjmemWhpgxXwSRK47GIzLdpFJbRhuyEdDRwXYdUJS+KOO
    0beaM6rzf6kbeBaej7vv6SRBBsUkxk39Met7Zq6YNTCsyo+CAq7u4wzptusZaiwp5cZZ8l
    lKvvG+MJay+AlCw82viY+KyvjcZDbb/tRt0kkw8KIaTuFG8D+qrDOQ966bhFsj0VcCZCil
    PQt2UsZ2evlcsocWFoRHYIb6gPMPoyqXyRReTZM8/mHShuroDbiUIk6ZxUEOsxjwOsafRz
    p8+CMYLM4RA5xfBFQfo7Tdmv71LjdGfSJ+geGTmjxonlaSO4LZBc9tFAJxYtumUyfUvRXG
    ZKD4yji3GklkFLSgjTOyiH6vU/qdM1KBt3+RrYWmAhrIG8V+0fxM9vpid+rZW28VncUTpb
    CxJJ+h5MSpWMpZS70qRzTiYowwDm4Nbjm+LMHurJpv95JFN+rX4p9ylU3grPB+3lUk29Pb
    lpAK/dYgcFUCodkZzbUK54pW1e4kO/2tCvk26WeVTU7LjzVvs3DlZ9AizVySS1dMgdBGwY
    C14dLykwrEOq4k9VVp1BK0DBpp7lfFgnDC2yUYFWgGr/igUWxr/PZOo+8LIA
X-ME-Proxy: <xmx:3aTIaggb4Xj6Pul_OnBKbqmvMWWyad6tSbeOttcu-VlqmrsGhCO3dQ>
    <xmx:3aTIam3AoWp1k2hTK0r7CgyNBJ_dCaE1zUjLsi3P6WUb_BE3lNKXoQ>
    <xmx:3aTIaigSflGwDGPncPphbiAmrWTHCLfhute2LdhReRktaJn2KsiZCQ>
    <xmx:3aTIauf4c7JTwrNChSdp7jLOWOb8oDjGja9EMUpDKYOXZepc9T3QqA>
    <xmx:3aTIatkXA4ciboRfOUKbqgvAYGsHG0NlpCLsWeJpLUXtZ4aHolR8Iddc>
Feedback-ID: i83a1424c:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id EDB3E22C009D; Fri,  9 Oct 2026 04:24:59 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AtO8Ija5835R
Date: Fri, 09 Oct 2026 10:24:39 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: git@vger.kernel.org, "Junio C Hamano" <gitster@pobox.com>,
 "Patrick Steinhardt" <ps@pks.im>
Message-Id: <61c7c9c0-5a78-4e47-82d5-f44965f07d2e@app.fastmail.com>
In-Reply-To: 
 <CALnO6CB8yQy_dtnoTYerqfyY9mcM=rKSWtZkQPtrGuHShoL3VQ@mail.gmail.com>
References: <CV_gitbrchanges7_please.d1c@m5gid.xyz>
 <V2_CV_gitbrchanges7_please.dc4@m5gid.xyz>
 <V2_BrCh_become_manpage.dc5@m5gid.xyz>
 <CALnO6CB8yQy_dtnoTYerqfyY9mcM=rKSWtZkQPtrGuHShoL3VQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] doc: BreakingChanges: transform to a manpage
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 8, 2026, at 21:46, D. Ben Knoble wrote:
> On Thu, Oct 8, 2026 at 3:38=E2=80=AFPM <kristofferhaugsbakk@fastmail.c=
om> wrote:
>>
>> From: Kristoffer Haugsbakk <code@khaugsbakk.name>
>>
>> The breaking changes document is not a regular Git documentation page.
>> That means that you cannot navigate to the doc with git(1), i.e. with:
>>
>>     git help BreakingChanges
>>
>> You instead have to download the Git project source. Or go to
>> git-scm.com.[1] Then you get this disclaimer:[2]
>>
>>     This information is specific to the Git project
>>
>>     Please note that this information is only relevant to you if you
>>     plan on contributing to the Git project itself. It is in no shape=
 or
>>     form required reading for regular Git users.
>>
>> But this document is relevant to *all* Git users. Everyone should have
>> as easy access to it as the other doc and guide pages.
>
> Sorry for not mentioning this earlier, but you can (depending on your
> distribution's package?) find the document under "git --html-path" for
> example

That=E2=80=99s handy. Thanks!

I wonder why `git help help` has nothing to say about =E2=80=9Chtml-path=
=E2=80=9D or
=E2=80=9Chtml path=E2=80=9D.

>[snip]
