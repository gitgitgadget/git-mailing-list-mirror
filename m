Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D9314BD7A8
	for <git@vger.kernel.org>; Fri,  2 Oct 2026 17:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790962822; cv=none; b=hj8s+yg/vnaNN+tNNmn2aUIk/bK/QnHtTWOk6RRXucmtXziyOOQwUv2a08YpRYjc2RjqqVOZO3x8pWDnRFZPWX6TXJ9c3RjZSwHabYIcWJH11bEfRFh5h1fawNlU730skuCCRLOu+KoBS0WvreAZHPpM7Hi3c3dHsFEN0z1Ivyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790962822; c=relaxed/simple;
	bh=iBRdJSPDvd3bWkDHiTL082F/ixkChnD+CYfWYPG+P1E=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=T3watRHgpubUUdus9FZxwVkvOtG0ZBfs8HGnalGrE5ORev98yTWlY7Zmy5miOEaxmqvjWIJV/segyjGz3uxHvdN7ljXANCxZ3vK2waeQkynmVa7REzC3JqHSU8/H1L1Z3pd6F18M6eQCIpvpdqn4P+ZtSuvtkbEOBJnByuUVagk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca; spf=pass smtp.mailfrom=jvns.ca; dkim=pass (2048-bit key) header.d=jvns.ca header.i=@jvns.ca header.b=PFkFZINW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dZDBgJWo; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvns.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jvns.ca header.i=@jvns.ca header.b="PFkFZINW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dZDBgJWo"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 27F8EEC038F
	for <git@vger.kernel.org>; Fri,  2 Oct 2026 13:40:05 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-05.internal (MEProxy); Fri, 02 Oct 2026 13:40:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvns.ca; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1790962805;
	 x=1791049205; bh=q/XA57buOe1qiTcBKL6LK8mn10+zl78hcFO0MmwtcNg=; b=
	PFkFZINWxmJ43bPyHB2NrTgw2PK7V0Z1tuIU7RXH4hMK3gBFrhnEB2moHZN0N+d9
	ygahRaQXcdn9qL+0NJ+TciMnWcXcgozoF/hnUTUSMxR6+2AzAj+LSaU2QSOZFF0W
	YfZP/VV0nHvvD+GVa6uNzBbNpgHUxysX2iYQ7WypBOCHTA8QyguoByw8tjPUXahp
	f0ifFmQx1DjH/FFFuXavmCEPsS3BFoZgv9kQlDVul7zYRuHL7MBhhxpHnpD2+Wqx
	bjQK21fkD/qO66ay1w96EL1yS8TmTfXlx0pTJlIiZ6csZn4y20ewaQGz5Vi8W9nV
	+ZtySoaX1xuGVGyEuD8srQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1790962805; x=
	1791049205; bh=q/XA57buOe1qiTcBKL6LK8mn10+zl78hcFO0MmwtcNg=; b=d
	ZDBgJWonpqItqzvPY5cJiBr3GDxaRrPXaosHH17/8nXdHIe4ISIrfOkz6I7lv+Aw
	pqqkK1AUvFfp2yAa4TXlPQpKwLqcJACMWDhbQENIpMtj3FS5jH4xuOdeGEZrZaj/
	YupW+LsAOcEHLxdwgRJPY8j2s2XP53desxVU6UrcSIUuUwTL6cn/nvlu+8GSEsOk
	aTxxH1Q5fRgVKnmYPZ/s9wMvtUKMkT4D5pvdvAfQaDbmnIe3x/AGS+vhRTMf8ztk
	qFkVpr4kRyIpBVfG4wpQXbeko/TcdJcNHf9Jm2jbti/uovtpZQKpcO/MaJhcOwnF
	0W7OjBDlxXjLPPrr19mag==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=sign d=jvns.ca a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1790962805; d=jvns.ca;
	mf=PGp1bGlhQGp2bnMuY2E+; rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:z2ZkaTaRUsOgelq4t8LIDQi8nliIVZXZToDb2p/DHoHhxAt
	b7VUrd5BHew5iuo5Izu7Ch6UKBuxlPF4HastGeuqdXIJX23KKlCf9NmqklhrkgEi
	hGkBNFtVOeT0CaFy8MoGQycgw3+O3dr34/euDcSgf/ZqZBo3Xf1jWLx7shy/RC98
	q83tuR30Htxa6kTZB27R4BknrWc3zhMt9zSY1PuJOw28gzoZYxSuNbXrbdsQpx4F
	Fulr/iZNblHwZAmguffLlqnWjVq2iRj80K2lQdGNNpoVowyXdeDR/tMHU1mvnrY1
	H9U/oH3u0XiKqT8tAyGOcBi5l2hiN0AZHPGXuMA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:uPwDuYWIVlMrK+Jp/6UC9BalB2ZgrHSeyWfgXW2j5l0=:iBRdJSPDvd3bWkDHiTL082F/ixkChnD+CYfWYPG+P1E=;
X-ME-Sender: <xms:dOy_aqevlomWGQ5ePG5IRo3anl4ItobbgWumIWRXf_GJDzp-16DzuA>
    <xme:dOy_avCne5Id-Lt9iTWDmWWuf91mWd0bot-Oo3dvYa-g0TBXFs7iR7M-1qSgwV5lu
    A0cNRb8lkhuI-FPGphHAv2_22arwE_3I4Pho_o3Esn1Bo3L27aWTrQM>
X-ME-Proxy-Cause: dmFkZTFK/2PxuK2epRRSrZzt7TQcq8CcVnthRYgR0tCF9J9+t/UILcU72V07E2ai/UIeqs
    ICdYXXElMvTv7hZreWVfDGzD89n+lr33Bxf4j8Zr2Etss3rMlHVZ6yqlFBbCIGEOOybwjc
    ycvjVxGFlSLGK3YXF2x6L/V7qq8RUV26bRIXzu4aIjWxC3A2OCxWwAfCd4O0Zhe3O2Dc1l
    yajjQUlVH6Q1+YCzZriU1kMvpw4vpm4ARXlid0VwgA/9gPPWDUhD+4yGjbje+uovPyMgD4
    Df6lCpBTSat7zN5a/1ksPkJ2HBnQNLRdUxRaedv91N+K7h16WlgstxyKopAN41NIiWXRV4
    BfYzbd7PRLjt1sefSsnZ06m8fd7db8xm1KrsDuF5g9ZwpwjRm3Y9ysf4wrhyavelwMPdg/
    +5PVGzUng6qSaFDQItE1Uv+HdM46QCeyLqMftWE9JoaB+01m/LPdNB4xqXtFDCt1U7de20
    TmFijS6mhYp1jVQxjwepTSf1cFVhOvLj8O7YcMsSf7DmLq2aETNSlysEFphppRM0zpJVyc
    XSfddYn1DF44fzaaBH8ipLE9OAB3swrZX5Si8UJ+8Im+4e4UcNP7i/U4+HGxfYalMbm+KE
    vEiX8tIZMhxMJ8Of3f+3OsDOTABj+xNnj7cgxSmD2A/Bf+SRJET5XmXwyBWQ
X-ME-Proxy: <xmx:dOy_amHQeIqQD37-AFjvBRurTkTGhm8xZ0UrBIUqlZWvIDhDXbkVOA>
    <xmx:dOy_alLtM5EicgE203N5hz9lfuw_JFeaQ5LVPDQCO-uLQvsXYautgw>
    <xmx:dOy_aqntLAvBaumuZ5lUtWhlQh579fr6pXhplm8uffP7Sx25ZzS0BQ>
    <xmx:dOy_atRUCRSqWnlm0Wkt4AD11jF0Nvj-pSpVKVEy2rqp0VDMzz9MiA>
    <xmx:dey_ajZldgRFXMTfqdaRwU-cWGOXkudmQNCiUUSRseuuspKZaU8nZKYl>
Feedback-ID: i2aa947c3:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id C8F0B780070; Fri,  2 Oct 2026 13:40:04 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AWFTbsbb2HAJ
Date: Fri, 02 Oct 2026 13:39:44 -0400
From: "Julia Evans" <julia@jvns.ca>
To: "D. Ben Knoble" <ben.knoble@gmail.com>,
 "Julia Evans" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, "Patrick Steinhardt" <ps@pks.im>
Message-Id: <91396552-f86b-47d7-9805-8f6056c2ed66@app.fastmail.com>
In-Reply-To: 
 <CALnO6CA_=OsznkQ4iT0vBMWf3L=bmVKMBdk1MTHQdaKEcKwn4g@mail.gmail.com>
References: <pull.2237.git.1790261062.gitgitgadget@gmail.com>
 <CALnO6CA_=OsznkQ4iT0vBMWf3L=bmVKMBdk1MTHQdaKEcKwn4g@mail.gmail.com>
Subject: Re: [PATCH 0/7] [doc] Add new page on merge conflicts
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Thanks for the review!

>>  * I wrote that git commit does the same thing as git merge --continue
>>    during a git merge , but I'm not sure if that's always true.
>
> See also discussion in
> https://lore.kernel.org/git/CABPp-BEQSx4m3BcT28CpVGCtsH75+x3gmv4OJz_ec=
LVLx+kBWg@mail.gmail.com/T/#t

Wow, that's a very interesting read. I'm more informed than I was before
I read it but also at the same time more confused :). It makes me think
that "git commit does the same thing as git merge --continue" is maybe
not true but also I don't know what the difference might be.

I've put an item on my TODO list to remove=20
`git commit does the same thing as git merge --continue`" and to try to
replace it with a more vague sentence that I guess says you can use
either command without being so specific on whether they are exactly
the same.

>> Also if/when the git rebase --squash changes land, then we'd need
>>    to add git history to this list.
>
> I imagine you meant history squash? I also thought that history had
> punted on how to deal with conflicts (rejecting any operation which
> creates them) for now, since we don't have 1st-class conflicts =C3=A0 =
la
> Jujutsu.

Good to know! Removed this from my v2 cover letter draft.
