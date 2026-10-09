Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1005E399011
	for <git@vger.kernel.org>; Fri,  9 Oct 2026 15:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791561246; cv=none; b=llH/wdSaQaYEX5O4eJLquGB9NJKEv+/IlNdFaA8QY9UNvltCDjfjS+VlhJgg7OxW29KFNn94fExpEOjohUjT6jB3cUKrlpddtJxHgWWAUUv7t2lVXptzKxI6bWMwcr59JNS43CNzFCy/jwPYxX/IQiuh44RujbcB1kjMD237u+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791561246; c=relaxed/simple;
	bh=clUYAs6AbanfRbjFR/dCYwYyr0cjB0slDBYqTZlaqSA=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=tdojR0M8uccLgoac0EGIlVXXkLaiqzXewljBRexDk64N+cSmHXWWJLxx9dG1XAo8aXTNEUw4HnchgMDsyohbjMYfMH9ZvU+JuWEdIfH1lnWMi52EmdoTIdmpv89JcCx+st2dxZlw57eenNblkj3mRRiG4ph7qSDUQ3TkWBGcy4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca; spf=pass smtp.mailfrom=jvns.ca; dkim=pass (2048-bit key) header.d=jvns.ca header.i=@jvns.ca header.b=YWXN0xcO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HVNR+e6V; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvns.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jvns.ca header.i=@jvns.ca header.b="YWXN0xcO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HVNR+e6V"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 1598D14000E6
	for <git@vger.kernel.org>; Fri,  9 Oct 2026 11:54:04 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-05.internal (MEProxy); Fri, 09 Oct 2026 11:54:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvns.ca; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1791561243;
	 x=1791647643; bh=0PfXyNoDjaTHbklUgxxsGYi+v/+JEjkG0NXXKkh8gXo=; b=
	YWXN0xcOo4Hugz7X0a6pz1ATthXLKQDHQyyjgx+T5BlJW+5udBouhUebJescKhJ2
	Cf1s1cYtSVNnmKf9po8Pe2E8mYEplji6KkN9wiTyDY0Dxij2y+GfIEgrHWqTSnVE
	w1kVlWDPTmn3wojCUpW05ldTkxFSH5jdWypEy915AFaue2+qRLCvHTozOMJtHxJF
	pc5b2gElPQ+lFPhfdIAb91bNUNk9Xk8xW1BWCcCQK/avNP+QSuxairgsMDTUEmAl
	6a1HciEWP8+DgS8L8K/RqcMfDMjz2b8kwQVrZd9YwaH6Xk+GXzYtOQ8KX8xRj03u
	5IhLIhPtU4MgyczEmrq8Cg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1791561243; x=
	1791647643; bh=0PfXyNoDjaTHbklUgxxsGYi+v/+JEjkG0NXXKkh8gXo=; b=H
	VNR+e6Vgj+Iy1cGEBAQgbXYlDuAustms7feWQ/NARMYckIdLU7KeJpXGEzMp9qFE
	e38XE7qY+EhXW9LdiaBp5UGt5wjuBQKdseb+lLfIB/eZzi81/Pw4xN+tK8UsKuiG
	tKuIUBawt0qXM77Igzc/b1lB3xZWypLzWmo+nBFQyHyJIPXVbWNRl8Rr+SXIKJp9
	+T9TvfLr3iZRMr+27giTT/cnX7PNpNDrQL5Wqual0CTkNCgonIqDAdQ2csjoO9Nm
	UZqEmWBuXWyBw0Rv4HB+8ksRuP0avGRdI5Q9CNqPDoqESvvGGJG8p2zXrWpWtuzH
	b2Iaz49KMkx3scOujZAsg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=jvns.ca a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791561243; d=jvns.ca;
	mf=PGp1bGlhQGp2bnMuY2E+; rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:acIFPhO82E1fjcjpgZKLSF3940LB53HyHVkukM+navIWJih
	u9qornW5v9fNhzDHkPiYM8FO+R/0aWoibLH65MjHIKjZXdPCaDVBU+ZL7K6foyCV
	ZKcXnqWvCSuL+JIELMZBN3AmRnzH7QJtoEJe9CabF1nmOuwCgGboiD1hElYk8LHo
	ejFysaPr+V/NeFhAT7NdBAHRp6ogAQpHdwZ9e1uLps+TkczqFWQRiLHg6cAi+i+W
	2gg76xzYjxeNT+/gicOwaxDGacWtwnBTESXd1ep/mePfOySZld1JztL38xcJYqli
	6h9Sy1MexKrtABwMKblV9Rcr29FBNURBC+biPhQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:2iMY4GP7d4GwRZjYtuseru5Kk8Z6cRMoCWqI1YvI8AU=:clUYAs6AbanfRbjFR/dCYwYyr0cjB0slDBYqTZlaqSA=;
X-ME-Sender: <xms:Gw7JaqraDYQ-nZ0vMp2L5p0ZdfF2oV13KaHbj2HW2Cqd925PMNXcdw>
    <xme:Gw7JajeqoYhe24diQgwGGJReT-_KBDCgEq4nnWLj4qiOjQF8R6KAVm_0pHiiIGsXS
    dLZVNzz9Xur1wug9MSX8UAzvVUMSyKRQBRi05gGgz5wt3oNjlkeH0M>
X-ME-Proxy-Cause: dmFkZTFmbjLhf+mp+vAq21XqgCc6Gw/XgPVoyqBqOyllYnAFevBm5Gdtlz66C6cNM5kCoh
    Ip0dt2Reb6P1enpUkaIDgn7eqIjglj8kOxbQAkwef0A+dxw6RrPCQxu3eYMP9ggvASA6nU
    Q2GPHUb1BXYX+yyxAqji7Yu98nG5/kMNp1BLNoUJou4Vff1ZFudMAqqaoF+fGiIx7Nc8wD
    61teELHQCX07kNv+12P+6VjXkOr2KG9mrvseClL5uULi52a30o+hX6cV/98M4RJAZoyhBM
    zcvWdafwI6xbEvLhud9W4DL3U3ob6qWltzyF5GbufApQE7zV7pGNdIY1hJkQwta1MPqJCI
    5RbUsd/YSq9TnC8sOHSKbSZTzInoxgfjEua/SL9fLPhBlZv9HSFUiRNjs4XVFnvApigGdx
    gEcQz7t2eCHdWFdPQ3NHiXo/7NmhJpLndaIprB/CAvlnbdMJWlYjXnwjK4KbxsHoYdFv+Z
    LXbV9rX0ZVh26nIxF/1nPoEFzpqENHYWsCJ36a4gJUPFEX107FAbXxOOaBg+wz3vGS0rCT
    Ygd+N+zAGHGML1KTV1aXJs/jUSwpQMUayjzmwSzDqGBSheZN70TIaLnthS1A5UI3zVAPH2
    QXrL9ZYbkQn7mPvl2CI5L46P8a7C2xFwcTVX/4riqVt3wEDmYIQh6nJrqKwA
X-ME-Proxy: <xmx:Gw7JaqWnwctrqLc0lKCb4MnKfGELQE8PmxtFFquIIPB-meIBsArMVQ>
    <xmx:Gw7Jav4OHETh2j7YK5zbIDnLDSwtT2Qe3NHmIQkYT51dC_RW6FHWGw>
    <xmx:Gw7JalplCLIQtlNhXpgodiAq2j6lls940l0hguZOoF-zHdrRwOJ65w>
    <xmx:Gw7JaikiymIoNVNPBc-JHzzjQKIkG_1RPmSapYsVcy9V5OugBcIeJw>
    <xmx:Gw7JaoD6flyk56O0uBYQJmqjT4zLlWAqJ8rBleiwNEDP8neXljMQlM0h>
Feedback-ID: i2aa947c3:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id A8EE1780070; Fri,  9 Oct 2026 11:54:03 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AWFTbsbb2HAJ
Date: Fri, 09 Oct 2026 11:53:43 -0400
From: "Julia Evans" <julia@jvns.ca>
To: "Junio C Hamano" <gitster@pobox.com>,
 "Julia Evans" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, "Patrick Steinhardt" <ps@pks.im>,
 "Jeff King" <peff@peff.net>, "D. Ben Knoble" <ben.knoble@gmail.com>
Message-Id: <2a721921-2865-4cc4-8cd2-01eae74f27a5@app.fastmail.com>
In-Reply-To: <xmqqse2evq2k.fsf@gitster.g>
References: <pull.2237.git.1790261062.gitgitgadget@gmail.com>
 <pull.2237.v2.git.1791547213.gitgitgadget@gmail.com>
 <xmqqse2evq2k.fsf@gitster.g>
Subject: Re: [PATCH v2 0/6] [doc] Add new page on merge conflicts
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



On Fri, Oct 9, 2026, at 11:41 AM, Junio C Hamano wrote:
> "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
>>  * [x] list reviewers in Reviewed-by
>
> We may have a bit of misunderstanding in the process regarding this.
>
> . `Reviewed-by:`, unlike the other trailers, can only be offered by the
>   reviewers themselves when they are completely satisfied with the
>   patch after a detailed analysis.
>
> is how SubmittingPatches describes it.

Thanks, put this in my todo list to fix in the next round.
I'll use Helped-by instead.
