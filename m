Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1EAC2FDC20
	for <git@vger.kernel.org>; Tue,  6 Oct 2026 16:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791304969; cv=none; b=d2+qfxUSnjxOaR3j/uHKVWNNVGkGqRk/QmABivHj926M612WQlJ/XhFoI3GPnnRgJzDvApmCmBfeP/3HIo8DlXH6bZLW8wU+KG/JW+0BSMQ70oADk8qEjK7ATMIrL9MM8KcxWKq+BcdiLrLPSuNm4k0QKu75nzJSjfwBFbdt/LU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791304969; c=relaxed/simple;
	bh=fRBIy4YIQmnRqficuw4LMMPPLcNPF8Llch6XRUZJEus=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=pApYOjB+647JOUBVtri1rvzpXaGrFhDP3+oQnhcYjlCCA/dx0qqTMjuwVaRFIw9hpmwd/Dy8voSeJpIJMerFpU7yb51FjPEFyBY0QIm7fFv4rl2C9oObGSVPgAf5RrDKkPq9BoDgN/00MXfb2FPyUquee5QhTvtMpZoeSB055oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=Wf/ihTi5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kElbZQof; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="Wf/ihTi5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kElbZQof"
Received: from ams-compute-01.internal (ams-compute-01.internal [10.64.2.61])
	by mailfhigh.phl.internal (Postfix) with ESMTP id C301514000A2
	for <git@vger.kernel.org>; Tue,  6 Oct 2026 12:42:46 -0400 (EDT)
Received: from ams-imap-15 ([10.64.2.35])
  by ams-compute-01.internal (MEProxy); Tue, 06 Oct 2026 12:42:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1791304957;
	 x=1791391357; bh=81HZ3jJRtH9aLlxBgJUpVjZ6PYXTDswkejkD55T6eRs=; b=
	Wf/ihTi5PDYCXx/Ni3RiqFBmc1dNIwyeXGZGgA9kNCdV+zOjusyScWFi+ArswlUj
	WUcw7ydrs1290Did7uYkTfiX5oPkALRzHnVQP3ja8dOJe5likouhvc+PEBRjcaFf
	K7jTEpk8IoUlXLSwfOrE176yL5++BJ8OuFbAbhkq/Rgry9YfisW5r1EipbajUYng
	nIszIgHyqNxQmoBe6fAInjJF6dn7hM9SnF1MlXgLXGym0gzuuCOk2/RaGUmc+V1R
	msit4y+hYKJcjCmLvslIiuI2tsH2FMwkvfDvLrjgB6A5UWzMT+/56iQ0mArLWN+z
	jwQAOTu0S0gfomDPtIVtAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1791304957; x=
	1791391357; bh=81HZ3jJRtH9aLlxBgJUpVjZ6PYXTDswkejkD55T6eRs=; b=k
	ElbZQofE70+OXbvVJQNxhE3KvX+hElunSYEnYe+I5WgnVz8rUAwDavSHQs5hd/8v
	/YI17b2C+Yu35tl2O7IDf6WqIM5drsNw2jkwH5cXt5Ez9uX7LzfZvtD+lvER9A7I
	778I5RwyTs03+gopwsXWoDIyyirzZc9p2LINHvq52/BH3EUixh/cbYQRo7nfSNTj
	UrZFq+l6wXieqbbZcmxkFjxf3hHswfwzYEhdxFIUvr8EmZSmlR55zC8/VfhF2Joi
	iSXkVmGx+9h+7yweIy5JezXHNZAra6/NR031krhxCrbW9hzh0QEjSqCRPTpp7Abl
	IhYsQuIT7cSzEaMUsBlUQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=fastmail.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791304957; d=fastmail.com;
	mf=PGtyaXN0b2ZmZXJoYXVnc2Jha2tAZmFzdG1haWwuY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:ZQ0TU8Uw4bLFPE4ghJP+fnvwunSZxbmtGRV4QyxOp/GgAon
	MD7oa+ziRO9cHfYkcu6l9hMzwGRjtWKoZ3KPqbvEagodi5xtYLqrlkcETttypvVu
	L2vPpZfuX7MB1LT495lIb5GQm+lc5oxK0Yyzi+uPecUNNd+0VRmiTOTT0Ni8Q8jw
	drF6/FM6aLbiVxC+Ls7O/HPA1xPofdxhYRhVhGaImeFtcicdVhCeyW3HFir09/Dw
	F5xgAuIF0sPHkI7CrvyCnXoxnelMFYuBvvycpdGZSJd1jiaYjGVu7TexOHrTZvyY
	7dkxSjUnjZZ7qGE5JjixWhcajyVvYPTINo1qh9g==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:6fY0pAenWzEZZo9Mkhr7wLtRwZDfvW94txriYTube60=:fRBIy4YIQmnRqficuw4LMMPPLcNPF8Llch6XRUZJEus=;
X-ME-Sender: <xms:-CTFahLeiCzTPCy91zgZCHngJYn7jTfrA10Ym4ixNJLPHmb0uYZNz5M>
    <xme:-CTFan-N8R2P200xhtEnZw6lZXxjHambj3ZsOI1VscPWfhRM0PK7jf-fEXUqGxsgM
    XB19TCDeohioWjwI9tRUk3LVtqbh3xDvrr3ogmJaBosej3z5o47ig>
X-ME-Proxy-Cause: dmFkZTEP7t37g5QNrFHJyqztkzIwCPGNJyWDQClrnHwCAxw91jfDNhEngjzJXzMK8kM1aZ
    tW6iavVWzo90ibviuyEqyXCTdvLGUXqK4mMsj9CjHA00II4tYabqiaAzp7hQ8ThdKJjyRH
    VTugtOjpe8SnEC72n9JgnShTJ5e5RTZuyrx9xpINCiHZWHZcyLl3/fHg22rsEDgeuVvASw
    kUrzu5+KmPIoPLixYV5rIfU3jiMahf1F3B89qQUKd+c1ZSRlR1qWcd9U42+PdTZckAyFn3
    K8orTxHPQ4WBrRbeYkHRok4H0/mRZpQMlVme5GppfFHgzen+o/cAcF2aAy81qn0mKVx6mp
    w5v2KGXqHRbKRZvd670aXpHltaWer02uKNMgH9lseO+fASXFj8myjhyBijD2v59JX2jS5G
    t6iiYiD6lQy5zC8OZsFp+74zdCmw9hCJenQUknX0axuc7P7YfNRdBzAPd2R1hBn1VgAmBy
    mCQA90rKbjkkWcFEsC4Xe7b8Ixtul7NEdGJnueYKvQQIob4YTbhHH/9yRA9GYXlVyXlO91
    vEFadnD4/jVLsyo3NmaB1Lbvn3eqEwp0kCwwhSto7074DfBZ5oi5Xg1r1LAyGtYO+YZtK0
    OL/Iz0RDqzgydkUl0LFlsLIG/1UvjNEUIm7d5bcjHJMk5hh0ssLbv/ItjQRw
X-ME-Proxy: <xmx:-yTFandvDpIBCaWQOdRzrzT3Drr4bOzXVm19vQBQNnqYY-ezwmYq2g>
    <xmx:-yTFaun2GH57ldFCaA7l3YmD3RExKXqNtWMDRV6lwfRL46ZHYpskhw>
    <xmx:-yTFapw2-Wba8FAHcCpriuoj9wodZHQ0PwpKAYaBHhH4gjbkya9bcg>
    <xmx:-yTFahMf82KuwtfGb8P6RLScS6aAL-z-T0CgXqLd8bOALOVpicb8cA>
    <xmx:_STFaiYPc58h-6Y98atVU8DfpvxiIXFLi1ZvC98gYWajfLjDuG7MkVrN>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id 1E3D422C0095; Tue,  6 Oct 2026 12:42:32 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AliR8QpupZkJ
Date: Tue, 06 Oct 2026 18:42:11 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Christian Couder" <christian.couder@gmail.com>, git <git@vger.kernel.org>
Cc: "Junio C Hamano" <gitster@pobox.com>, "Jakub Narebski" <jnareb@gmail.com>,
 "Markus Jansen" <mja@jansen-preisler.de>,
 "Kaartic Sivaraam" <kaartic.sivaraam@gmail.com>,
 =?UTF-8?Q?=C5=A0t=C4=9Bp=C3=A1n_N=C4=9Bmec?= <stepnem@gmail.com>,
 "Taylor Blau" <me@ttaylorr.com>, "Elijah Newren" <newren@gmail.com>,
 "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
 "Jeff King" <peff@peff.net>, "Patrick Steinhardt" <ps@pks.im>,
 "D. Ben Knoble" <ben.knoble@gmail.com>,
 "Harald Nordgren" <haraldnordgren@gmail.com>, "Toon Claes" <toon@iotcl.com>,
 "Maciej Ciemborowicz" <maciej.ciemborowicz@gmail.com>,
 DaiAoki <a.dai.0814ap@gmail.com>, Salami <salamiiiiiiiiii9@gmail.com>,
 lwn@lwn.net
Message-Id: <d8660b71-9a2e-4724-a97c-3b82fab22fd0@app.fastmail.com>
In-Reply-To: 
 <CAP8UFD0KAHvXvV-SqLd=sYohTvcgm2Dd52EfEY1XEbt3649Htg@mail.gmail.com>
References: 
 <CAP8UFD0KAHvXvV-SqLd=sYohTvcgm2Dd52EfEY1XEbt3649Htg@mail.gmail.com>
Subject: Re: [ANNOUNCE] Git Rev News edition 139
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 2, 2026, at 18:25, Christian Couder wrote:
> Hi everyone,
>
> The 139th edition of Git Rev News is now published:
>
>   https://git.github.io/rev_news/2026/09/30/edition-139/
>
> Thanks a lot to Harald Nordgren, Maciej Ciemborowicz, Toon Claes,
> @Sal-ami, @DaiAoki and =C5=A0t=C4=9Bp=C3=A1n N=C4=9Bmec who helped thi=
s month!
>
> Enjoy,
> Christian, Jakub, Markus and Kaartic.
>
> PS: An issue for the next edition is already opened and contributions
> are welcome:
>
>   https://github.com/git/git.github.io/issues/872

-

> But AI writes the code for me nowadays. I bring the idea and get a
> first draft (if it=E2=80=99s horrible I start over) and when I have so=
mething
> that feels sound, I =E2=80=9Cquick save=E2=80=9D by committing/pushing=
 and then
> feedback on the solution until it=E2=80=99s nice. I use one AI session=
 per
> topic, and keep them open for the reviews so it maintains the
> context. It=E2=80=99s incredible to have a sparring partner that never=
 gets
> tired!

The reviewers were not untiring.
