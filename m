Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A650938DC6F
	for <git@vger.kernel.org>; Mon,  7 Sep 2026 10:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788776354; cv=none; b=YwnoO07AfCV7LC+6yBAFKYHvZRQSYTUYZ379ntfDI8AZLu/gA+5EUB529912tzfNG+OAEDtdahQAw7gAtPHsnEKV6JcMP+47qd11TFUC1i7CApRoLaandXdmYIWdMkAFaVo7cWnSUnbhUfNF3VhpjhhHzpOax52JCdGEcshR2Lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788776354; c=relaxed/simple;
	bh=tj11UwIGbNo8r6Nw9nTFHHcYsvyoYU+m/+rnSMU8yvg=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=RGQ7Y9sNhtfeUGqkycPn/MNfQZsXkdrex2U7hPyk+Xqu3hFwAAgjHDI8a3dlDGry834ZgFT3hzKULnGRORYMBTwQ082+ORKu3pAb+AjKP5I9RwwQy8/oy9WuuD/IWzdbTpUFTMNfC5x22ogasQtQwDIXBnsmTOBUJUU9KQp1D4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=qr+NEBJ8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fBCfRKQB; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="qr+NEBJ8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fBCfRKQB"
Received: from ams-compute-01.internal (ams-compute-01.internal [10.64.2.61])
	by mailfout.phl.internal (Postfix) with ESMTP id 0DBA4EC022C;
	Mon,  7 Sep 2026 06:19:10 -0400 (EDT)
Received: from ams-imap-15 ([10.64.2.35])
  by ams-compute-01.internal (MEProxy); Mon, 07 Sep 2026 06:19:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1788776350;
	 x=1788862750; bh=ei/mms+GZusNrQYnGcFHBAtSVHeIQFagMclMl+hX+xA=; b=
	qr+NEBJ8XHrAQQg47QglLnLO/K+6kQ0RFZpUm2SXEW53qFEHTSOhJaXDgUBigJdT
	+rXNp1X0kmgQ3JnGeraLh9+prFyuS1h1WMq5Tvb9BeqDjgAie8COQe/+x4ZoF0Ts
	hjV4Ak3KdZXy1E0JlfPcAbnqAwj/YF7W9d0wjGIskkK1qqG574cxCEaDySceLNmZ
	A9i3JeZ2200kYxxgCD79z75XHNF3miCRDiXdTYZdEy+SqdMBp8hL2UUd+903KzZH
	QW2i4VEccT2Fhq3liXSFcWTtEGcjTnutnLpjqgEKgQQNnNAJkGD0O72JzqbtxGg/
	bZHAh83+fFLiaZCtYSRTKg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1788776350; x=1788862750; bh=e
	i/mms+GZusNrQYnGcFHBAtSVHeIQFagMclMl+hX+xA=; b=fBCfRKQBF9kpBpICD
	tSf9wQSwgoTNL9dGss77fUG7oMRgiUFx5Z0tEpvi6A9D2bG3FD5j1ZTWvkceO4p+
	vWyrunGeVMdejHxlc1dmiXrqsfxkQ1Bh6VCB6DWYq02ZjXtsCHJbSH9UOLqreMCB
	d++nmpYGSmRvCqZ9zbsfnAerVBgFAGstI4w3RJtA1L6zKmUjJr0pRcb0EXHqVpjW
	ewK+kn3Dxeyab9EyOrJ80FtcjXxgqo+MUcVXQDebu+PbK5NoBvVmuOCQ1+z3YiU3
	Yb1rnoB+wxJ36XM6FfmphjLsqh3KEheZUF8z9jGSNn6NizQqrPPMyA6PCilLGSc8
	an8xw==
X-ME-Sender: <xms:nI-eapKBdqqSgX1fwx7OHpygj1Ho2OJcXoUkj4794Ia1hOGrwBBN0zQ>
    <xme:nI-eav8qBfebUvj3KpKGD_6OCAqYJIuYZOHf4X1JLBES3Vbpw7Y3kLGRq2TJGCvJx
    irIogxvViz5m6C8ykoHhfPKObkuYTNZ6IMGj87q09AE4uptwfzCUmw>
X-ME-Proxy-Cause: dmFkZTGzUZdkv50vBBFXH2wYNoZIAs3WfFv7yFrG1+kz1HtTbccG5x0fUa4YOCelprS9ax
    COEAIt2SRMVaYOaAKcbuc6BcR6o8dJy1DoWXzemDZQlfHerMJiA5kmiOWNJJLW5f1WQjfI
    lBeWSDC1i+lPxzqKUX2n9a3oWKJhEn6ztYsBSJuZw6sjppCsboF9dlhdC60ANP1bb9EQBq
    TY5JyrAwyTNXJz63x9tl9FVhfCOjhbDPRf7T0nXmRAU5+nps+DD4eQT6Co7QB+wH4jQXzQ
    99pRRyDMZoTrCJMAW9ugW1Qb9viLZ5KbARsfrmnsuqcGEWg5fyuIwH5u4jDL0ysY6MZHrG
    Nu3aWIQ5IyOL2VhXOQ4RqofKbimyRA+UrQljBp2TGWZWXRf+EvZB6gl1f0jeKIjftRLGvo
    UEhgqiZoUqZfUw5F6vL6KEp+thaMpIQhwtjnmVcHpO4sh+3Su9tg9fHqD6tG7dBEWfIck9
    aunz5HACGjdWmXaPxhgm1wYoITZimYI8254SVtIyikfKn928J3oVv2KKOxoT72oYUau6vx
    kWnRjO26+tNbAx4Rf5m8/hui3Foa+bMpU0xAF0r8dPaTkbSyQ5pJEpN5M0p5vJOG/IL8AG
    xo4AITFLoy9t5PyLrqn4XUl7sfv9xCVXkine1oejRmRPlLdsR1BW3A3prGfw
X-ME-Proxy: <xmx:nY-eajNuYyRrJnEbg1QUcWxh87b1kAAUTuX8BfnwKkVJ8EQGojz4QQ>
    <xmx:nY-eavfn_CnGLyRzodtqY_LTIpDAXvbGa1qSEc41pqMd8DRNE7W-hg>
    <xmx:nY-eaiVr4FdtOIC32kvOMfgaVowmstWrPDFJpzdNk-_o5nrDbZOhgQ>
    <xmx:nY-eang26eqdE0zLPwUBOWMEt_8SIDImactgC4kkMrXjgY9R-j2HJg>
    <xmx:no-ealX6kzFsjbPhTFd5zdaG1tgg5uOpSrixeKjmt9hpkBXl07vZuKqY>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id AC9D822C007F; Mon,  7 Sep 2026 06:19:08 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AdgGK3U4SE6s
Date: Mon, 07 Sep 2026 12:18:48 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Brigham Campbell" <me@brighamcampbell.com>, git@vger.kernel.org,
 "Junio C Hamano" <gitster@pobox.com>, "Patrick Steinhardt" <ps@pks.im>,
 "Taylor Blau" <me@ttaylorr.com>
Message-Id: <9f455224-f156-493f-a21c-27a8922f3360@app.fastmail.com>
In-Reply-To: 
 <20260907-maintenance-doc-bullet-fix-v1-1-dc08dbe61a82@brighamcampbell.com>
References: 
 <20260907-maintenance-doc-bullet-fix-v1-1-dc08dbe61a82@brighamcampbell.com>
Subject: Re: [PATCH] doc: Make asciidoc bullet items separate
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 7, 2026, at 09:15, Brigham Campbell wrote:
> Fix conjoined bullet items in maintenance asciidoc file.
>
> Signed-off-by: Brigham Campbell <me@brighamcampbell.com>
> ---
>  Documentation/config/maintenance.adoc | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/config/maintenance.adoc
> b/Documentation/config/maintenance.adoc
> index da8be9f812..c778ab09ac 100644
> --- a/Documentation/config/maintenance.adoc
> +++ b/Documentation/config/maintenance.adoc
> @@ -41,6 +41,7 @@ The possible strategies are:
>  This repacking strategy is a full replacement for the `gc` strategy
> and is
>  recommended for large repositories. This is the default strategy for
> manual
>  maintenance.
> ++
>  * `incremental`: This setting optimizes for performing small
> maintenance
>    activities that do not delete any data. This does not schedule the
> `gc`
>    task, but runs the `prefetch` and `commit-graph` tasks hourly, the
>
> ---
> base-commit: 3cb9185f65410273787f74333cc027d2ea5daada
> change-id: 20260907-maintenance-doc-bullet-fix-d351253f8a91

I wonder if this gives different results for asciidoc and asciidoctor.

=E2=80=A2 asciidoctor: seems that the bullet list is correct with or wit=
hout
  this change (no change)
=E2=80=A2 asciidoc: needs this change

Note that I=E2=80=99ve made enough asciidoc/tor mistakes so I=E2=80=99m =
not that
reliable of a witness.

I also idly wonder why git-scm renders this bullet list as it ought
to. This hunk has not been modified for a while. The second paragraph
which ostensibly made it conjoined was d9bccf2e (builtin/maintenance:
introduce "geometric" strategy, 2025-10-24).

https://git-scm.com/docs/git-config
