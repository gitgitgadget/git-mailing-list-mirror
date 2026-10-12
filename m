Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88D2B392811
	for <git@vger.kernel.org>; Mon, 12 Oct 2026 20:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791837876; cv=none; b=p6EGPN3EJPb7TkbsIfYXrQKJQi20B0oxEc62FXbEbt4KPXH4nXMxcZVhc2465+o4p4zZuQ0VN0dreGJRtBvkngs9CKZiY9gbU3hMtG70DERKqLgi0Ic1eKA6oy61UHxGSbMqCAtVSOz91F6bRppJSxp4G7zzw3Yb/HlnW8aFxN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791837876; c=relaxed/simple;
	bh=mTTZCU1JWtOcKixup9l1XoFdxKf0omPaWlOvcuhJGj4=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=MHZ2ESO32pKAiJAVP6YEHrjku6csVoepUy9WzHZ//Q+7hd1uyVahZRgAjFeetCPolc1z2amHWdtwO9lU36psxMA0IK7ECRaCMaxYaBmOfHfJhUp0/3kodTAnMZPSW+A7oXbLAz/QMX8L0a5aqLL4Up4NjQgisq6ZUfMcLEPUZYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca; spf=pass smtp.mailfrom=jvns.ca; dkim=pass (2048-bit key) header.d=jvns.ca header.i=@jvns.ca header.b=Xsg8Z9GT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mwipn57c; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvns.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jvns.ca header.i=@jvns.ca header.b="Xsg8Z9GT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mwipn57c"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 83A97140011E
	for <git@vger.kernel.org>; Mon, 12 Oct 2026 16:44:33 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-05.internal (MEProxy); Mon, 12 Oct 2026 16:44:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvns.ca; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1791837873;
	 x=1791924273; bh=737r3dkO+KWfKJWDoZfaGkqryVr+gAedgp6u36uF0rE=; b=
	Xsg8Z9GTRcCZnc/vwF/wgd3Fs8eL85AkqqKSWYZ7P1gcg3G6Pe9MbdYKqFzwcdES
	ulmk/hforGGeKuEUEECp/BwmZvJ1Y88usKQH/bEBiCfzDvxzVaceZwNqpUbyt/Wh
	CQxeVm8SU5q0i+IE2Hz8Bnig/ETvgxwhQLY6NgFUNH7RCDH1dE+WOfcH8M0l0G1+
	RmJ+JFYGkXm1GlCioj6arjBz4wfoLtD+fVc/ma+g+pvQk2P/Pa0Pe9SOGznVuf3Z
	LehiQSrNdDo7KkBelMtXQfP9xVHhJgiXyj3GB44D07jNZi3vabwh/vXdQ3NdPW1t
	08Iv7JLbOcjd+d1acFqdIg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1791837873; x=
	1791924273; bh=737r3dkO+KWfKJWDoZfaGkqryVr+gAedgp6u36uF0rE=; b=m
	wipn57cEod8tT2GUF/rGSQ6qpTuKXrLwbckWdyvJxhlnraukDmaP7pUOlOg26Jar
	rctz9th82oTFUOXudEJaJ8yTiSahAXmPPH1q+n8zaJJWSpWdy4jZyXnLNZUC6+gp
	f2d/iEiSY4sAhdBG/RLEWK6FpS9XTnv0ak8k0kKG+Ffku39gNCze7gGVizyFoGIj
	4mnPf5aGKXOTpocki9iRo9f0h/myVN5CjLSMzmcSkOfytLtDUTHFYyNsddMN+KEE
	+ySrYO0QJDrZykHxXVZgSdLRJOm0at2k/E+DAZtd+VzGeJLks9Bs7IJu+r9LnEWl
	xJNv/uK3EAcdUU7etrN4w==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=jvns.ca a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791837873; d=jvns.ca;
	mf=PGp1bGlhQGp2bnMuY2E+; rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:ApRF9ONdBamvyW6E75orqZrr7AB7ozlNoQVa6zNgP+1MzGF
	4aFBFW2P78ftTIvs3VSX+7SM7qlBm+g2jwRQnEhMAM7mRsq+k9adymuSnz0Uwji1
	7BvjvtuE9iF7j2RfwgbIOm3as/eZ3asfVO6SYtZlA6JFaGgAHuFyACPhwxI33cFa
	oD2nVwNr5VAvnzP/tycIMheLh7PaLF6wGK29gJDp46AW/FIL+OYIKmSWyqvti3uD
	VqyR7sojX+xF/Ycu7QudIVgoD3WxD4LmJy+seo5fFVc8QziJgyLzYL9EVn6eD+Ko
	uMSni2bYa+DkZFYoSLLaBZwekwIGjpGSXJddM0w==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:f8t0AiyvnAiSiyuUQa0+72FdrUQGkL6XQ0ItfOy+j/c=:mTTZCU1JWtOcKixup9l1XoFdxKf0omPaWlOvcuhJGj4=;
X-ME-Sender: <xms:sUbNasAzrUIE9Rll-dxE113V93q5BXBfPbYj7U3eIXKiOxJVCP1rWA>
    <xme:sUbNapVczBDDPgjXJPeHsQNaiQ0uhWTfKewCJLf5ZRnKjvg1YSZxKbe0kQNnaI9CW
    FGAzyU3ultg5Sf-ZSzfKqSQfkS2tezEMrltdwhNDvkXFLCh76asgWMT>
X-ME-Proxy-Cause: dmFkZTGA5yues6Vzw3GbkeBaSxs3NzFjQiK0j/WrJHTayJpeuMyKRyFMIg9KXYxR32OcF3
    1nXpKDwAAN5rS81ZpyhgqBt3J8xZeJzQQTNDFPFxK775E9AQDLaV1ZZBXx7UF8vyWqd+AA
    GOFAvvHHoomuE0t3mcJRR8UnsESoJBJ1EGHP1hGFfeFM3hYt0KTil8oo/yk/a3hMTJUiIr
    LMeRGHIgW+qcjes0IdixAuJHUNbUX2gXbi8RdcfdJcnPInKbmoXC2ZC6joiXPN8KPAr/y/
    ex7tstfeMoqiad24twzDhbrNKb4f2VdYx7KGidcauy/cy8Hh0hCqkZT1JILVWHNOT5Mes1
    fPavq28KTkWv98sPhdukWbAf9m9Uyk3W50pUx2QpkqVS/yXU3V/7KZtGBGvMsmCYJ7OSZP
    nd87y/7sXz3SEMoReQgegW31fLWzksFlIdlX9Gr6td8lYmnvEAPoptCATfaqgF7eyVxKqJ
    SgTicOyrkQNN4dTU36nYq5pMOObZpKQWa1cMBjFIhOhsqOptA5rSAi+1D9kwT9Unh7whHO
    c82A+3oo2CaIDzvrUPlKFS1ZPsAyvE8dHVD/kkc5LlWncYwwsRTDnArQaUhL4WmJHeGDm4
    XqsPuxocx+KNKXf4YCgom6xJmytFhG1NmftIF1InSkGvbFv2pimbwkhiLDLA
X-ME-Proxy: <xmx:sUbNahEWkGx4gYVC_VNeYXhZvicGy2BtDZoTunzyh2QtpT6Cj4l83g>
    <xmx:sUbNan3VeUit-mQIjKn07ya_utu4BNeR4jhrUESZB8Dtmc4KBJQnBw>
    <xmx:sUbNajPx_7sZgYWgm6tsDVaOLiwHsQ-z2f8ZzGLBw_WhYRPs76jxPg>
    <xmx:sUbNam7erZcE6bqmiFqC9cDWNemneTaXdc7bLUZzfSLsvke9adrcKA>
    <xmx:sUbNakZtZyVcNCdJSstMqN06WkLfkqM6gpso9D-vhxU_A8IxzY4chGtf>
Feedback-ID: i2aa947c3:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 4B40678273B; Mon, 12 Oct 2026 16:44:33 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AWFTbsbb2HAJ
Date: Mon, 12 Oct 2026 16:44:13 -0400
From: "Julia Evans" <julia@jvns.ca>
To: "D. Ben Knoble" <ben.knoble@gmail.com>,
 "Julia Evans" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, "Patrick Steinhardt" <ps@pks.im>,
 "Jeff King" <peff@peff.net>
Message-Id: <6dac0b01-3411-4999-b336-453efa8b5bcf@app.fastmail.com>
In-Reply-To: 
 <CALnO6CAL7ogi5MDRJmzTqNjjG-S39rDn=GTx3nwM5ASz_kRZOg@mail.gmail.com>
References: <pull.2237.git.1790261062.gitgitgadget@gmail.com>
 <pull.2237.v3.git.1791816795.gitgitgadget@gmail.com>
 <CALnO6CAL7ogi5MDRJmzTqNjjG-S39rDn=GTx3nwM5ASz_kRZOg@mail.gmail.com>
Subject: Re: [PATCH v3 0/6] [doc] Add new page on merge conflicts
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On Mon, Oct 12, 2026, at 11:53 AM, D. Ben Knoble wrote:
> On Mon, Oct 12, 2026 at 10:53=E2=80=AFAM Julia Evans via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>>
>> Range-diff vs v2:
>>
>>  1:  ab0344f947 ! 1:  7aa0ae7ec3 doc: add new gitmergeconflicts man p=
age
>>      @@ Commit message
>>           place, since it's a really nice example of a place Git has =
a consistent
>>           interface between similar commands.
>>
>>      +    Only discuss merge, rebase, cherry-pick, and revert for now=
 even though
>>      +    there are other ways that merge conflicts can happen becaus=
e it's
>>      +    awkward to talk about `am`, `apply`, and `checkout -m`.
>>      +
>>           Co-Authored-By: Marie Claire LeBlanc Flanagan <hello@marief=
lanagan.com>
>>      -    Reviewed-by: D. Ben Knoble <ben.knoble+github@gmail.com>
>>      -    Reviewed-by: Patrick Steinhardt <ps@pks.im>
>>      +    Helped-by: D. Ben Knoble <ben.knoble+github@gmail.com>
>
> Maybe this got lost in the shuffle, but I do prefer to use
> <ben.knoble@gmail.com> for Git these days, thanks!

Oops, I meant to fix that, thanks for pointing it out!

>>      +    Helped-by: Patrick Steinhardt <ps@pks.im>
>>      +    Signed-off-by: Julia Evans <julia@jvns.ca>
>>      +    Signed-off-by: Marie Claire LeBlanc Flanagan <hello@mariefl=
anagan.com>
>>           Signed-off-by: Julia Evans <julia@jvns.ca>
>
> I don't *think* we need your sign-off twice here, but maybe you
> intended to communicate something by this ordering? I confess I'm not
> sure what it would be ':D

Oops yes that was a copy paste error. Obviously I'm having a hard time
with my trailers as you can see :)
