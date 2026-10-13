Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DCB8549378
	for <git@vger.kernel.org>; Tue, 13 Oct 2026 20:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791923638; cv=none; b=s7EFmdLlZKGW5B+e54WD44Z91ZL6kEmH3EDEI7zrxs2EjbQasdGT4j2hH6z0bnGHNvNtT3ZDWGMh79s65/Ex/Yif+3/am8gjTLOBeivv3dGMpZH13r/2YvEr1nd4vM0GirJKQDu5H4qio7vlUYoDWyHF7hVjo8grAdWBbhHmYDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791923638; c=relaxed/simple;
	bh=YJ+dWBwVl2OsPuLVIqLRaiGwxJQI0L7xX0pMk9KrA38=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Z+LiduXQWihHqZXJ829qcWcHKc8hY1kLci1urTwM9KJt2Nbg5KM5lu+kRln/Rid+BRNzk38IytjBiOkMTfl8v8ZAhYODcUFCSl9YsD5iv47JG9+l/xZL/iHPmW1NC+yvLFoYmY4b9aLacAbz1H/rj2Pl6BZxlqNgo+cSOt6SLt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=aYYs73aA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AITGIazU; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="aYYs73aA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AITGIazU"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 5C1247A024B
	for <git@vger.kernel.org>; Tue, 13 Oct 2026 16:33:55 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Tue, 13 Oct 2026 16:33:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1791923635;
	 x=1792010035; bh=CX9bAvfX/GDHdPbM7H+SeTgIrRs50j60Op01nK0GuMo=; b=
	aYYs73aAlkdqd86DBJXj7dg4Zc0BbZqNUbMEON7qhh7mAktXlEvwKIzvvZZdB/33
	kPD7/+pxqEcRMKwUDZ+LAgFn7fdgFx/Gkrbfxpv395jxnaSVNxjrfQIOW3Xksd+l
	YPPgjfeALwmbA6KYqfqqRYUUqIVDXNC9sKAjoxA4+41wENBnZ7b762GCVGnO5Nwz
	hbKa/cHvM2moF3r6hI9vIOh5j29y/dmuKoLA5AYotz8poQ3d0A1HkF7wCQ59aGSl
	R3nNpIRgP/ETZkykXGUsEIM7yKAq4cArK5SftXTRkXUsfpKaYINSqR5AHwCKkTkY
	KW3d8GucornYEEJ81LIaTw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1791923635; x=
	1792010035; bh=CX9bAvfX/GDHdPbM7H+SeTgIrRs50j60Op01nK0GuMo=; b=A
	ITGIazU6jcUtWUexRvYiRhwSoplgT/Utl/M4SNKOxwEzmdTsDMXennDQ05uFqK3a
	4XRLG0zKVKZSlddZA9wsNDnf0yB5UZ3cB8jlG+YCRUjcgAsNQoSD86lR1CFn/0ir
	WOxHnlcfJgldub8GsC01jpVK4OOG/aNomEEzKVkGMV4DabYdmBDTrs3jKUjbAY25
	9yRV00Soo8/mfEPwmvVSndUlO4LMlgLTXxrEQlPEE43cE4wArXFi2zEr/nATgvEq
	YhCtzaUTrN8jGXjIvb1nCktSLjpawp8bBmZ3/fE2mShu6fmyBz5mRurbTvHPmFgQ
	u13o10bvp5UTTk9GcAx4g==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791923635; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:lY4EtDZI2YgFGkB13j5LFmpnrVTnSdi+MWXkcqZZpMRyxkQ
	IDBGcp8ArzEPOo3pnjMfagWK29IGUd18euBAoxgegsPSOvG8o9+9/HcbrnlS9AKO
	A2C2e+sBIxiQdHneia0HttnaNmHJgy5fqqOTYLe8YR5Yd6atxuXemEXvS6jd21WV
	GC184N1C/WFp9T+DO9q8uY6RZ1+2kxUz7QNgcxmatdnatLcQwIzBzV1oDf5BHTxS
	gUpOEoIHCX6b3Nwi36B8TTd9RtwavbE8JStvCGLP228bAp4HRQRbS8epYAVNdLtl
	80OhViQqS39BLeVxSYle1cupe5j/JxJysABlcbQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=13;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to,
	user-agent;
Message-Instance: m=1; h=sha256:FB+oxm30FTeMnEGCO8vIBg78CCxqQbepGuZvyFHfDY4=:YJ+dWBwVl2OsPuLVIqLRaiGwxJQI0L7xX0pMk9KrA38=;
X-ME-Sender: <xms:spXOatYI4WEuoo5fjabhJsXoUSVZVstimjDF_3WmtRomMoXLD9dxfQ>
    <xme:spXOamoL15K1PFQkim-33aYdwPVaaOtr8Qy8tl59VYdn1OmiTUjpNJnp9GUDAnM0s
    Xm8Eev47Z6ZRcGdChPILaQG5cN4T29XA7gbreXrM9-Gm8DurUfHros>
X-ME-Received: <xmr:spXOaiP0zBYHOffYb2Iga2ccV8kHQDd_kKLoGuPFDvmbwlMww1V45dPMn7dCdV74EqJgXiGfdwoDTmOf7ROEghx3LnSAxD0jhe20>
X-ME-Proxy-Cause: dmFkZTGFi0feny4lgCzG4qvnoBS80Y4ipx/LN8pU/MKkkrrF9lzy/Rb1DBqZrewkS76obo
    hh8DVXAaSwrb6ssscABGST1JbQgWwk3y/tZdU7l0hMOG+doPppEAL8HeFxj2e4U34TqRXG
    nQxxJtTKb5aeh86j+R1wbvwm8tXQWOiekE1dU2n2Dc6Yg6/2r+xdbs+2sINHmUoA/oDIqZ
    fkW16ZeswVM/Yby60A0DadcIzZBm57smpVBuFKsDIM5Pca5fJvPfZXNmwXCGRT8l4wa5+Y
    zXQLtHLUNT8ps9zh0sqClJLFspBRY566560yQfQeMsrWD7RHC4bDjqKDPFjxa2raX1Zke9
    rC9i1RwIvlaPsftkELSR3RAlaqvdp/G0gkCgg/J2GgzLZxEqNKYi+oJYzJ1F31Lp/NY2QJ
    aeAtM4J0caGev273yu3PQ+PQJzp6+ntF2HgYpOArf6+n9K7ogD3X//2PaVeyecmmx+H9a2
    CwIYXXMFKrNVXE00gTn054IN/QaNKHJnYAh/bK0xOB5T3JAhQjEkgTnoQJMLh2NPTD6sO0
    DFfC3Mc3YsfJFBSbr1T8JtUwl8CrCZITRD1Rg7Ut1ydnF1grcJINhYW3NRCArKViqtI+BJ
    0H56ls9di7FMtxzetBmCkez+rjL0M5m6LwfmVSMIUy295+dVlU/QJji4fUYw
X-ME-Proxy: <xmx:spXOahrTjtGg6ekTeP-FGXJBsTfMXVvkiO6jVzMO15g7JZc9VAgYZA>
    <xmx:s5XOancSJvuZvKICpQ_g0ieniLyJqidlt3ygsGVUZfHTni-XCZrv5A>
    <xmx:s5XOanQmzq1fZY4athl7A4MH2Q8CS4OtcamCbg_jLgRs-0Bx3Huy0A>
    <xmx:s5XOagbzHLYfapGkvQ1mIva3u0RE-9LjXb65PMN83Ym1cEtGovlC2Q>
    <xmx:s5XOarfz6TM2j3mjtH_qcHP86IgY95A8iwrWaXs7Sw6a8gvCmd1qZsmO>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 Oct 2026 16:33:54 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
Cc: git@vger.kernel.org,  christian.couder@gmail.com,
  usmanakinyemi202@gmail.com,  siddharthasthana31@gmail.com,
  kaartic.sivaraam@gmail.com
Subject: Re: [Outreachy PATCH] delta-islands: use Q_() for island count
In-Reply-To: <CAFpMFfAQET2OvZB905cajvhSG6BS9t4zx5G6iGG6BUP_o8wUGQ@mail.gmail.com>
	(Okhuomon Ajayi's message of "Tue, 13 Oct 2026 20:44:12 +0100")
References: <CAFpMFfAFsRvQ1mkmGVkRnLWf_OHN9h3PAThnVZmrbecV_ihRjA@mail.gmail.com>
	<20261013164922.93099-1-okhuomonajayi54@gmail.com>
	<xmqqv775xyz9.fsf@gitster.g>
	<CAFpMFfAQET2OvZB905cajvhSG6BS9t4zx5G6iGG6BUP_o8wUGQ@mail.gmail.com>
Date: Tue, 13 Oct 2026 13:33:53 -0700
Message-ID: <xmqqwlrluyq6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Okhuomon Ajayi <okhuomonajayi54@gmail.com> writes:

> On Tue, Oct 13, 2026 at 7:00 PM Junio C Hamano <gitster@pobox.com> wrote:
>
>> I am not sure of the value in this, though.  You certainly do not
>> mean to say that you updated all of the ones that you found with the
>> above.  You are not inviting others to do the same grep and "fix"
>> any of the hits, as the pattern gives too many false positives
>> (i.e., not all %d are about number of things, like the line number a
>> parser has found the error it is reporting at), and without warning
>> that, it would not be helpful to these others.
>
> You are right, I will remove it from the commit message and send a v2.

I think is is common to have such a "not quite suited for the
permanent commit log message, but may help reviewers and others who
are reading the patch while it is still being worked on" material
under the three-dash line below your sign-off.



>
>> The change itself looks sensible to me.
>
> Thank you for the review.
>
> Okhuomon
>
> Okhuomon
