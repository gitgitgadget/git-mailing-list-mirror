Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3641930F7FF
	for <git@vger.kernel.org>; Mon,  5 Oct 2026 18:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791226220; cv=none; b=BuZygWDUjmRK4OUpsrJTOVk04k6pEZFawxGIOVgSYmBYgE+HN54kejQTQopah2wknLVDWi40g4vYh8ASl/6x4occJx8f2H2m2zsGL87DQlpl2H5mX3AzusCvzEikqyvNBqdNSBVvfehGWPrUEE0QNO5wjyT7QgBIh6o0TTWim5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791226220; c=relaxed/simple;
	bh=5r1HK+h20F5QCjA9FD/dS3dFC/T2dgbvBIqdmMkgG/o=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=AvNoAAwANpduD6GlWlIsq5c27BfDd3nczNQAWV8aqgoZFKqW5TO3QUAjGTomlpTY/KNVSdFT/bTcGHfTMplY4kxx2i+CETv/aDXhflN4sMsrg7Qv0pOnxAARm0de1aU98XoNgmBQHVNsuUrVVHzOMsXlpfkNIPM5oCFFfkTribQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca; spf=pass smtp.mailfrom=jvns.ca; dkim=pass (2048-bit key) header.d=jvns.ca header.i=@jvns.ca header.b=cQawg2pP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NZM8w4Qo; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvns.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jvns.ca header.i=@jvns.ca header.b="cQawg2pP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NZM8w4Qo"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 46B3FEC08DB
	for <git@vger.kernel.org>; Mon,  5 Oct 2026 14:50:17 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-04.internal (MEProxy); Mon, 05 Oct 2026 14:50:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvns.ca; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1791226217;
	 x=1791312617; bh=CVsbwIcbJLuFTUX+w29e/S3e7D7teDPcKyMvBtvg7Bc=; b=
	cQawg2pPCxPyvtk0xfwrBbExj9snWonTCLJs+8ZXqwd0d8dS+ygXYRvYH37SKhEu
	Knj7EYM8VY+t7iAXxPJGqhqTCEURgUFO+sIZCLjQ4P0na4H03mm9K7CTFf3YNR+K
	dj9R39mXGoHd3EF8jubwKGnV06mDyTbJVW8+Mgl2H6f5hjO8PRaRP5lUDeXT/JWx
	rRYBjeE+U5YJER/K4js/beD6Itx/TiBQtZhzhnu2M5x1te36GpP/pem9slh1thmh
	nn4jeELuWGcrYKj/VDvIq28wU4BomJI0cePGJlrZiPCxR0Qiw9FMbqNFOyWOQjM2
	YHnOCAyzlX0rI1YV0w509g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1791226217; x=
	1791312617; bh=CVsbwIcbJLuFTUX+w29e/S3e7D7teDPcKyMvBtvg7Bc=; b=N
	ZM8w4Qo9rvgooqGGoPKymRD8AekOBGIgp8Hi1M/4zXuYZxvZ/B78QZIzvOdLeRFS
	Bef7gsMyNG32GtmdZtFv9TrLycL9MIPAvolRSenyxR8PggOVkRO0WgXwPi93gISz
	Woh4RLiRJ9lgCwWgPbf6B8IzmsVWXrjWHgisWBfbcYpX1Tvg0WZDLUfyurTf46Oa
	lXm0SK6K78VjRksr0/QoTUjc5iAXlfxK3EB667rcafKOEZnp/II40mCzMlqFetuP
	zvtJZmRAMtxl+piMSZwV7tD3eYv77G3E/qaS2C+SvUPYRhmRPOse2PyxT/j8WyjK
	PPLaAVYaa0cuKbyuUknNA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=sign d=jvns.ca a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791226217; d=jvns.ca;
	mf=PGp1bGlhQGp2bnMuY2E+; rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:O85kaDBZMJup/VQHrwWWsOojURd4W67F+2fZa6TpeH29gpx
	brMwJBvt3XNwx1RZu3dEYl50il0W+kQhQU72XuZGQ4UJpBRo5sVxObtuFiNIrDYm
	ZWsHa49T7LJZg4+260Zyppsx2lYIa7RwWpeZldfUVfW/gOoQjZriuXeXSt7HA3N+
	UZ1JMn0zXRq2LcYsOFPGM3TH1w85az122mLRfG2uM0XxZZXdkqFYpXIV6l4COf0g
	08UtkzEqyylHye5/jBzuXFdpUmzw848ECiRsd9t3tMrA1wv9J6dSXfhEWgtG9w9E
	l2SGiy3f6sriA6QycskZTA2xhZdXGrCdCMm03TA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:JA80plYvENpv/z9p4xvbC3cvphlUZGBBX8DvhUm7Jgw=:5r1HK+h20F5QCjA9FD/dS3dFC/T2dgbvBIqdmMkgG/o=;
X-ME-Sender: <xms:afHDasAhR-tGfMAMxzuuL5cyzGmDPvYZktEifBflCrsFjhQ0kJv8fg>
    <xme:afHDapHshSD96G9tFZfxWYnO0vsRHNi9gmihkPoPxglQdV3C2Mzfbaezk4COnMiWv
    Dv1mBNaDeRPQCr75lZGDLYFzasDtfgqRSaYGevXk8nXAtC6teZ2ANrx>
X-ME-Proxy-Cause: dmFkZTGZyvi2bhPMI/fLbv9BFXjH/yn8A5XaWge4rn9znKlIv/Gjyda56w4lIzUylm/++h
    XePV47U5+CD1ZfK/qaRIGjuldnuYz6kwLhtZYX9dJRFXwqVuh0Zfq3Q5cHvXsOJl1pT3tT
    py6vRoHFTX0a2jWnUOOMHUjIrjtTJquy9v7Ukc03uy6jgqnWaoupsxnKmBWV1k+BwibTbY
    3Ded7tTgszJVIV7syBQnEMoEd+vN6LPnO3py7Y+dvfm2R35Gu/U2d5MxEYbz4eYN9K+G5z
    r8YT/z2gcxdC8zMoamoLWFhjJJ2D5PIdNCvVtrZtVtI4JxFJnoaCf+06XGXrFYmAxVNwO0
    Yx3IIeYePl69w49T9MG/M+G+Nh1r9mspgb4cXnSQ9lZMdFnp6K34QI9WuNbUhEG95hbP9a
    1keDeYjztgk95+Uxaz1hg2oOIFVuM5Wtf81ldB/FeSmKvWhkMOBbGV8n0+PqYPvtSYY/Qr
    GhNdVYO5WzaLOWy60pd+6brzuWDcnuekQs+tDIjb6MNwrMy3LDoIRZwOQm6LcMtHr2kMCl
    CitsOMnS8YvEaYBDzKWLwndHxZatwQRxX2L6XKgFEUo1baaw2x8wIqp31cmqoY9IRHt8yf
    QJk4p2tkXAUS1fO/njeruXnQxIa4peYYVgU0wcfy04I/m/X4FSPoQKLTdLaQ
X-ME-Proxy: <xmx:afHDauuQz26tR0ficPGj0zqs1CZwE6Vy-u7aHPNBLTJ-4R8dcXhkCQ>
    <xmx:afHDaqMm-48oDhaxx0T_HOTvCVlQxsiuf_fWYGkw4lSyMa5q938OMg>
    <xmx:afHDarjFnR2h83HSChWQ99X0MtDR2OZ6I6E35v8hSbqInMxnQT90bQ>
    <xmx:afHDak5UjrhV3LPXUPxg5HxI-soK9CfGBs2VRbxVtKsp5E19_kiW8A>
    <xmx:afHDak38NShJYvbm2p7M2IerdvXyldWjljMGe6cQ0_j-tLbHJutMDXrM>
Feedback-ID: i2aa947c3:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id F3EEA780077; Mon,  5 Oct 2026 14:50:16 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AWFTbsbb2HAJ
Date: Mon, 05 Oct 2026 14:49:56 -0400
From: "Julia Evans" <julia@jvns.ca>
To: "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: "Julia Evans" <gitgitgadget@gmail.com>, git@vger.kernel.org,
 "Patrick Steinhardt" <ps@pks.im>
Message-Id: <623cdf71-8076-4967-aff1-3ebeb57d1e3a@app.fastmail.com>
In-Reply-To: 
 <CALnO6CC+h1y=Fu438nm4cd0K-dfPVYq9MqX_+k8fxBU60ot8KA@mail.gmail.com>
References: <pull.2237.git.1790261062.gitgitgadget@gmail.com>
 <CALnO6CA_=OsznkQ4iT0vBMWf3L=bmVKMBdk1MTHQdaKEcKwn4g@mail.gmail.com>
 <91396552-f86b-47d7-9805-8f6056c2ed66@app.fastmail.com>
 <CALnO6CC+h1y=Fu438nm4cd0K-dfPVYq9MqX_+k8fxBU60ot8KA@mail.gmail.com>
Subject: Re: [PATCH 0/7] [doc] Add new page on merge conflicts
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On Fri, Oct 2, 2026, at 10:29 PM, D. Ben Knoble wrote:
> On Fri, Oct 2, 2026 at 1:40=E2=80=AFPM Julia Evans <julia@jvns.ca> wro=
te:
>>
>> Thanks for the review!
>>
>> >>  * I wrote that git commit does the same thing as git merge --cont=
inue
>> >>    during a git merge , but I'm not sure if that's always true.
>> >
>> > See also discussion in
>> > https://lore.kernel.org/git/CABPp-BEQSx4m3BcT28CpVGCtsH75+x3gmv4OJz=
_ecLVLx+kBWg@mail.gmail.com/T/#t
>>
>> Wow, that's a very interesting read. I'm more informed than I was bef=
ore
>> I read it but also at the same time more confused :). It makes me thi=
nk
>> that "git commit does the same thing as git merge --continue" is maybe
>> not true but also I don't know what the difference might be.
>>
>> I've put an item on my TODO list to remove
>> `git commit does the same thing as git merge --continue`" and to try =
to
>> replace it with a more vague sentence that I guess says you can use
>> either command without being so specific on whether they are exactly
>> the same.
>
> For now I would say the subtleties in that conversation really make me
> lean towards the following:
>
> - "git <thing> --continue" is, for most users in most cases, the right
> thing to do. It's what "git status" recommends and will practically
> never do anything surprising (?).

I was actually surprised to discover that `git status` does not recommend
`git merge --continue`: it recommends `git commit`.
Maybe we should change that though?

I agree it makes sense to be consistent with what `git status` recommend=
s.

> - However, it may not always be exactly what you *want*---and you'll
> usually know when you want to go "outside" the normal sequencer and
> commit directly (because you'll have understood some nuanced details
> about what can happen).
>
> For merge it may be the case that they're the same, I suppose (I'm
> genuinely not sure), but I would prefer to simplify folks' paths by
> recommending one of the few uniform interfaces we have :)

The only other thing that gives me pause about recommending folks
`git merge --continue` too strongly is that as we know Git users are slo=
w to
change their habits, and we don't want to confuse anyone. If someone is
currently using `git commit` I want to know that they can keep doing
it the same way with no worries.

Maybe if we change `git status` to recommend `git merge --continue`,
and we think there are no real advantages to using `git commit` instead
of `git merge --continue`, then we could say something like this:

  NOTE: `git commit` is an older alternative to `git merge --continue`.
  You can use either one after resolving a `git merge`.
