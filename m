Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7DD036195B
	for <git@vger.kernel.org>; Tue, 29 Sep 2026 19:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790709074; cv=none; b=RiV833Oimo4MuNEc7o7zH2X+3T7G8xxPr2UTtN9U1LOyGvQiLg2IkmPnKwfvXXZwvg41jbgR7P5HVXA+qd3SuqXaz2igCvh1+DwXcDgKBV8HGXtev7g+iMJnnsCdalZ5FPQIp7s3HLJ/c6oHig2wZI9PfjD2uar29asO9qUpUeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790709074; c=relaxed/simple;
	bh=RJxif8qBXefj3JqZeSz6YMOMe+dPx74+I/T+gSGkUUU=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=CrEHnU1otJ3jtgp6mgNOPyTvvC+LrIl0rVAVWTGAnnoImk0yGxMT4rCGzBqqBMZy7ib5sMhaoX/Q3mzEDCfbf0Z2OG8UyRB+k18OWT0SWKVGeSAgpwjB7USo2MHsDE7klGKRrqbHAVK80YHU/XfbjiwE1qLjUoueUnW9mTtAdwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=T+oNULhE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pBgu1iNe; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="T+oNULhE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pBgu1iNe"
Received: from ams-compute-01.internal (ams-compute-01.internal [10.64.2.61])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 635371400124;
	Tue, 29 Sep 2026 15:11:11 -0400 (EDT)
Received: from ams-imap-15 ([10.64.2.35])
  by ams-compute-01.internal (MEProxy); Tue, 29 Sep 2026 15:11:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1790709070;
	 x=1790795470; bh=gzE3u0wviRjmNykwO6t/IbvKcjSqR4scZMyUNxiEnTE=; b=
	T+oNULhEwH2C2g+aeBQ0DL6UsLn77ymzX/zG7ff5BC5JNB8pRLRCycVBpkgaOmSR
	dMKaU57e7uGm+zZl+YD/RZp/j+PbX0a6gOUCP74SF7iLlz9F1O11pgUIBWxr5iM9
	d1QsXlXUAeupfGIXeJm9Z7snOUOOIegplV/TCKq83uDFm4czEBtv7wJGvj48lIoF
	hRtoE30ZUvOj7qSEuk4nxQpYCXJKhjBBfSMIfQSFSZzqls7IhrIUcwd4wU3VJcAw
	ji5ay6C7gATYlLRwCnroUc7HjBhqF5zRRkE+KJyRIOtJOBQAtwOhdlr1ZHwuYWs5
	UR3ELC4ai1DB1qCah0EupQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1790709070; x=
	1790795470; bh=gzE3u0wviRjmNykwO6t/IbvKcjSqR4scZMyUNxiEnTE=; b=p
	Bgu1iNe7GSv7OpOBntroB0EiNh/FS431AWcn5ZH/XL3NlQcjwOnhiJkK3IgSY2jF
	phC2Aox5XNp7nHpvMexLy0R3O9k26J1dtS6O/U9GeSASR1LGV26cgC+dUHgeo5zV
	3zbe2q7zUUymFuA+ogSfQmWjCtLKvNX4hQF3yxAq97YVhWmu23wgm4PrVepjA0FD
	t16CRQx3Z938ZhPSe3mvLTSFJ9kJ7ylA0HgG+dCAEU6N3uSTm0bjlxUoxOXlcqkG
	8qtLr1t1ZGWz/3YovGbsERnzadD1uFGZrrPeDm7Slx7BluKrimRxc3NL5iCzaS/X
	jYml7aOvltxRy9HFsqtZg==
X-ME-Sender: <xms:TQ28ar4NEkQA8aQholr-Npdsgo8DNAemMCRDRkyQJqx2eFP18ZSNpsE>
    <xme:TQ28arthv367DSCf175KeI0HYbR4kOYCstEVr_Zq2WoKo3pO8JEDYgs4bQScAMocA
    7PIxrytvNnz7o-BJeNZxiGTPqAAvrMEIlMNEQ6Twuo2moWI_ul2>
X-ME-Proxy-Cause: dmFkZTETJgGqIn8dK8QcTdUP8jlQ1yGrRgxgfZnVnwfkhJG3RSqYWnro4lcMqzIKSbENfH
    PcRPVmIdS0hqnjMloOeT2k2SyKYmUnpcr7OZDuLU0734VuL4GJ/WF3wOyXx5ewsMlPPz2A
    OKkXgDvtMJFplhtsngWOo+wla4e3PFFwRUnRbQdoOQaxQrWsyPVoeZsHu8eT9RArIOH/JK
    xJ3hp2w7Ydq0zFySWsARUNot8AA9f+egBjodtyyA+JBlyghETFrVZEQpSghTWr1k2IleFF
    kglNWS/XLi26uoYkf4JxKDE9hdFNCjIrirUkHePu0jljMF9TD9rCqA+kOb1Rwx9PpRnKpW
    2EGOiim0lS+1ICelGg0VtmF4x3jXQwEO4DFkda3FP8lIzA+NX78LqdL8ai2h+bYJCqCS9M
    OzHiH67WV96IkE6AuJINvjQwrDW6PjTZpROND3Zt3pyLxcDzqUItFq8497AOPiTRaEM4XG
    xzvbQ5MW5qe/rvswWGFC6PpX/A94PbhXjZOr+vyUfUJ13q42R4+m/Wcpi6gDqsH2Q3X73k
    A7en56YcVBx3LRUyBWWjqt8Ej/sPlEUgcIunFft+mpwFYp9kzVxJM2puKQzGhd7SoIGy5Y
    qvUHOtL7dynDyAxjeSrhFu7WPsbD32P08Qlrkj8zKFdGbHG81scyAhzM5fQw
X-ME-Proxy: <xmx:Tg28aqVMJAJiitXxjVNkx6BbLvbOhErDk4_rc1OX3IY5XxJo8i-SqA>
    <xmx:Tg28auVjNy1DaGkSOk0c3oSqM-EzgYeOjrEtfNj8AWtbxWdiPYX7dQ>
    <xmx:Tg28ahfC0hvQBJnKMaFuua2bpn4_30bVixP8BFVROWApTLEhFCHKqw>
    <xmx:Tg28avXO4hwUCSbXG-qWF1K6ypnqfT5qLtR5vLdtacMG1KCzcbYd5A>
    <xmx:Tg28atx_usPkvnoohcs9d2eczyNQxStOUC6qEonhIgYggamYpBxUTl5k>
Feedback-ID: i83a1424c:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id 04A9B22C008F; Tue, 29 Sep 2026 15:11:09 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A23QAdG4rYrw
Date: Tue, 29 Sep 2026 21:10:48 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Junio C Hamano" <gitster@pobox.com>
Cc: git@vger.kernel.org, "ZheNing Hu" <adlternative@gmail.com>
Message-Id: <be487f47-054c-443f-b5cb-b612269fedba@app.fastmail.com>
In-Reply-To: <xmqqh5j9mdpx.fsf@gitster.g>
References: <doc_trailers_cmd_examples.ce1@m5gid.xyz>
 <xmqqh5j9mdpx.fsf@gitster.g>
Subject: Re: [PATCH] doc: interpret-trailers: fix cmd examples
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 28, 2026, at 20:29, Junio C Hamano wrote:
> kristofferhaugsbakk@fastmail.com writes:
>
>> From: Kristoffer Haugsbakk <code@khaugsbakk.name>
>>
>> Fix `trailer.<key-alias>.cmd` examples which have remained unchanged
>> since they were written in c364b7ef (trailer: add new .cmd config
>> option, 2021-05-03). (Modulo formatting changes.)
>>
>> Use this example as a guide for how to phrase it:
>>
>>     Configure a `see` trailer with a command to show the subject of a
>>     commit that is related, and show how it works:
>
> This read as if you are declaring that you use a template that
> invented to consistently give intro for each example, and made it
> look like the use of `see` was as a placeholder.  It would have
> avoided the "Huh?" reaction if it were phrased like so:
>
>     Steal how example to show the `see` trailer is phrased and use
>     it throughout:
>
> 	Configure a `see` trailer ...
>
> Other than that, this looks good.

I=E2=80=99ll make that change.
