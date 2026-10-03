Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F68242C512
	for <git@vger.kernel.org>; Sat,  3 Oct 2026 15:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791041232; cv=none; b=EatWbdmgK38y1/V4TIn1GiyRwuXiw5WCfEprBobEV5RG8JhoQ7SPCZtt32sS3V4EftQ+CT8LVo78oj8sKxd96VGd636qGNkJ4rLphdg1VsCB0HBuzl0fRSU/kwX1P5/8miE3ZahEJvLusC25UZVcuVveEBqN2mvyyvxr3RbD+S0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791041232; c=relaxed/simple;
	bh=q7U0kIfTNPBqYBqUMAtqndV21wKbxBSzBfQGNbEIEe8=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=KEW8UmS4lSI9sfd7myOcLbbfm8l4RFiyr3NPrNq3wXFm7OKnnikkb3PKn35fIQNbp1na7qsraBNgr9U2ixWXjDHzjUJyL9GL/SfQdD7qQ0pt52Zexvpky3nS7wAe04ib/8x1Q9BH11RyGViGbms+F0adfgO2Dj9C1rLvsHEgkfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=KTvruP2O; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JLXV4PF7; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="KTvruP2O";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JLXV4PF7"
Received: from ams-compute-01.internal (ams-compute-01.internal [10.64.2.61])
	by mailfout.phl.internal (Postfix) with ESMTP id 0008EEC02D8
	for <git@vger.kernel.org>; Sat,  3 Oct 2026 11:27:08 -0400 (EDT)
Received: from ams-imap-15 ([10.64.2.35])
  by ams-compute-01.internal (MEProxy); Sat, 03 Oct 2026 11:27:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1791041227;
	 x=1791127627; bh=q7U0kIfTNPBqYBqUMAtqndV21wKbxBSzBfQGNbEIEe8=; b=
	KTvruP2OiE7QGX7QjF1s1Q/dJ/D1psFLDLTYjXiURFqUNW38CPlcK6Dwp5iEQ+So
	Zkvg1URBtgGNcz7XHivYAvoK9e1Q7UhJruZP7npsRh0YwHpvaCKXbIAEl1CmvcMd
	6b6jkP8iQgUgntMYAUOz1ox18SXwP08Dy5G3weKtWIWC1Lv3Hr/4soQodVp6rsgx
	YyEQl6YpOtLrWn9MwI1OIyN/rL7TY1SUYUuypcvq2r7bMl0rpmvi78cUpH5tt1qL
	BRJTyby6X9BuactnU8ozHEbjf1+pL3rG/nWwV1YMk5b47D5dYz20jwyV/b9Z7SSE
	VYM+1kpYhAPkzadO5YVxSw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1791041227; x=
	1791127627; bh=q7U0kIfTNPBqYBqUMAtqndV21wKbxBSzBfQGNbEIEe8=; b=J
	LXV4PF70T8oNVZuzz1MrDNnFCxYhh/fkrbaMC/4/O1JpyaxHk6TtjTr2pYQdk+ts
	qJb5SvSyO/frx/7jeqUN6g4UoRz2lYn7bYvSMnThbgzviXqxhQt4mB6JHBDEfo85
	jkgxXvLgcIF1bwujicdMtUEqdmP87NOaWlhnL+WAkCGp4ow76AL8NDHSP4ZokryG
	jo3zskaoBTQ0pHidA2ss/8pm+NvfKs6iFEye3yHmLuPPUmz0Si76nKZ5vP2cxwPu
	JdlEC9WsPxr8scdjR6aGj3MjK6mHHui4g6xc3lbdM52IPUJT8M89ZRMSpfTFr2BO
	bAPjXXnF4TdJAuOEGDnGw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=sign d=fastmail.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791041227; d=fastmail.com;
	mf=PGtyaXN0b2ZmZXJoYXVnc2Jha2tAZmFzdG1haWwuY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:Zk8Q3dHtEhPZgll9bpdjebZGP+0CXttlLxypxRIg5X4m7QG
	3U9daVFY8nN/h1kG8uWb9GyhLsaPcz6+MK02dc5VVyJqHPOqtb+lOsnA4ALQNsWN
	dsQESuKm9aYodV2c2Y815nFjbsWoooiUeHZwuzYc38koTl866ieu1aI1FUDtzmtb
	cFdX/eUbpH1JwuPUyuhBexY2o/LZi0z/fHZ+wynhesWb8xRUDm5h8zYRSzJgRp8n
	rXTySfTYSEb4qBWrLyTn4OJtD+JXbvn38GZsbx5K8o0xq8my4Hjlu8ISCGFmq0Y/
	nBkhcFyceaVlqhEV37kVWN1jPh2RiRZ0TYudKig==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:NRNwYdiGrVS3XmM89tqdK1xbDdHhmwwWzCv4dnPaJv8=:q7U0kIfTNPBqYBqUMAtqndV21wKbxBSzBfQGNbEIEe8=;
X-ME-Sender: <xms:yR7BauUONIxyx9PAcvakwfCVQ_58rTaYObtMqYEwZnFfet5ziw0osss>
    <xme:yR7BalbpNqSNFcetK6CZ60gH7PJUOzmK7gA0x0_G-2Yy3KPyuZuuqg_rnE8DxzqjJ
    -NfrBh1JuuhSmfhY7cgmTxmnAq7cCzXUL7kOU06XfcWLtAUP-hE2g>
X-ME-Proxy-Cause: dmFkZTEcXqZVI4q1ryOPKkaSSCfhkmo5Ma6HL/vBsZTpzjLtZITr4JLCIRrMM6S6TNJgti
    Or5F12FEu/tdWBcYfycNBeSm9cvW0a+/J7wv9h15SB4UWe78LtFC8j1HrGZMTJgOdKXQ8w
    GnU48R6nzndEwoBDYwiwm5obXsQa/HNwj098uzbXt/Y4/4BPC8EWFHBwn2t8BHjiFBhOT1
    jLNuWG0C5atakRyIToosIHagIHZXRKjgWR77Clu39hBlP231FYRxG2LwkoEGwA2+3hs7YT
    qHA18YNRkDRLMaXnlR26pqX/1T/fUtOTkOagG2yzPdexNhqMCQLJhKlAWJK638Ir3fgiJz
    fjXPkkVrx5BCOIf/8ZaPxuFKkA2g+KHMyaio84Z6zfMi/xKLQPJiXy5Q5FBzk6wIQBEHtm
    UVsSwPcfWm1aUselsdLAAYb0XUOJ0hEYnoYQChXqCWvesTtkeE1cR1/rQNvN3uWs1y8cAt
    p82oYS5uYLdF1jJ4cio30gqjWljceS+q5rzRJYTosiTra5H7ZuS6Q0nvQFhBxGvqXLw5lX
    Cd/yC5Ap6I+CXgEFkJ5wNhOFLVX2DsfO6DZIW1QLtiX0bYjnUCfXdsxKgiaLrXkqxmU8cF
    qfuHYjLQEUQVAQ6WARrljPXmhzMKeOon88W9/bUSbGIMmpskGSj2B5KYN30g
X-ME-Proxy: <xmx:yh7BalS2JgkwQWxyw1wxXIk_oEdPRXfj_fT6zXDm0QdQoEE5pfIBdQ>
    <xmx:yh7BamidhYNyy7WA1FMZsnzjVDdFwlZZBRr68PhnamlWdPlQadFDXw>
    <xmx:yh7Bat7wkMHCZkdnwmZKBVpmS8W5xIio09_s57rEv87vIapc4uZrGw>
    <xmx:yh7BarCDVz4KxkicSzLcHF22P58P7RCWIutJF3fcCPVrobtj4UD2FQ>
    <xmx:yx7Baobd2SopAFc7oQK202Hc-RMKO8axo-dzgn4eFBBiFHwhPGQPsb2n>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id 958BB22C0092; Sat,  3 Oct 2026 11:27:05 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A4Wr6J0cY9cF
Date: Sat, 03 Oct 2026 17:26:36 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "D. Ben Knoble" <ben.knoble@gmail.com>,
 "Alejandro Colomar" <alx@kernel.org>
Cc: git@vger.kernel.org
Message-Id: <37597cc9-0cfe-4a1b-8c7e-1d229c9f7cf0@app.fastmail.com>
In-Reply-To: 
 <CALnO6CCUY2KF8rEotihdVNy+D10mmzuW0RXbH8nqhSS9jsgQUg@mail.gmail.com>
References: <asDTWsH-RuIJOyne@debian>
 <CALnO6CCUY2KF8rEotihdVNy+D10mmzuW0RXbH8nqhSS9jsgQUg@mail.gmail.com>
Subject: Re: git-visualize(1) plumbing equivalent
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 3, 2026, at 15:45, D. Ben Knoble wrote:
>[snip]
> On Sat, Oct 3, 2026 at 6:13=E2=80=AFAM Alejandro Colomar <alx@kernel.o=
rg> wrote:
>>[snip]
>> The goal is to know whether git-bisect(1) has found a commit yet or n=
ot,
>> to stop looping.
>
> I think you are probably looking for the (size of the) set of commits
> between bisect/bad and all the bisect/good-* refs. So you might need
> to "git refs list" the good ones, and feed those as negated refs
> alongside bisect/bad to rev-list?

I think you can do that directly with `git rev-list --bisect` and the
other variants that start with `--bisect-`.

I have never used them myself.

>
> In the general case, that wouldn't account for skipped commits as I
> understand it, where multiple commits are left at the end of the
> bisect, but in your script it doesn't look like you skip any.
