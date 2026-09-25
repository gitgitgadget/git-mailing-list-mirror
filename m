Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE8DD3B6367
	for <git@vger.kernel.org>; Fri, 25 Sep 2026 17:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790357133; cv=none; b=ACa4F6zn8evOpIYWQWHI9U+hyT9m/VgUYpno2ymkWi2P/bCbjEM6OlKyYNTrrWxte3uG17WFhWFArcH5WAn3MEcqC4snjVx9kssMowUYgD82vsIDTmJvTXY9e1AnCcbNEFjhxWEqZ3QsC/Qi/RGhIwalZIhR8Oie757LH0OY5oM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790357133; c=relaxed/simple;
	bh=QgYWryX3jPyPkB+cVLpzJK9NLVch6DXZYXiorIMONO4=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=NMk0bvyigh/aeULc3KLWM2x3v1ab3q+JV1XhY2+oZgJQMVXEggSpUsxlfR6zo7fpuyAFtZZJz+PkI/1rUzYfGtd49uLj44s91ba7E6hsmcxZe/Sda3JTxMW6FCvVDC9BBeHwJEq+BNH6YS9BfnZvdfN5XLTxfYOrKO9WeM/yqoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca; spf=pass smtp.mailfrom=jvns.ca; dkim=pass (2048-bit key) header.d=jvns.ca header.i=@jvns.ca header.b=U4GcbOzw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=I6jXq961; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvns.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jvns.ca header.i=@jvns.ca header.b="U4GcbOzw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="I6jXq961"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A4E671400122;
	Fri, 25 Sep 2026 13:25:30 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-05.internal (MEProxy); Fri, 25 Sep 2026 13:25:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvns.ca; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1790357130;
	 x=1790443530; bh=995iGsrYYD1WnQRGdkKDGekV80deF8N9YqKA8OH2roQ=; b=
	U4GcbOzwzGuvJUX/uaQpyo1V55LDVpdnV0Z8LFVHWjURCPwceqpfR8hDPVXlPrib
	L9lWHNqLtL1qTFRVacRoqdJlEhLM5AwVX2f3eLOyaDJ6XBDoxr4ZuBy8vUTwq3h4
	07G5936M+mFs0u7QmWWbF1hHljfGYgPd6FuNutsvLpNxACeB7W0750k5F0y9DRE9
	SdqaOJfrN/Er+0h1IEiGKlnbH1glJw2DyaOQAoANGsVQI+2aE56NDYLXXDRf3uqE
	T4+Ez1imNOMy4JtqVkUyXlsWqp8srCiFZgKcVN3G48QD6M46v8IwPgiO3JaheAM/
	EDdPrhsYawAWCeajDxYOCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1790357130; x=
	1790443530; bh=995iGsrYYD1WnQRGdkKDGekV80deF8N9YqKA8OH2roQ=; b=I
	6jXq9616xQ4WE7cZe6QUM45J5Q+3w4nb5A8RRBSgrASwWTY0hGC3cBY7UM0FG1H2
	pB0XTeCKhS6guOdNYqW+U1bIx0PPtrZXNgzqhvsblrzAWd0LRtmIkUuKvop2O5GS
	izJyWxN1bFwjYRHkFbSHHQ6ZrswdffMtj7PeC4qRBanrKrqKp9g0uTsgDuEHpf2U
	RO7Ti+PFRIvS7zh6RXCpRRXErosgEoSuNDBZhzrSAEZoSkgxzH27yk7hnG4C5wPf
	JzbLcufWObH8q3xlz6wcMBnpdEGPfRsP+MEyXlNiOihD6qJburXtcpNjY9L5nw0h
	Y3erl6jWo6tkcMFfTB+dg==
X-ME-Sender: <xms:iq62aj1mtpNo00nNykZqfo9oD4dqajx258x5XRbMgi6dAKH435ZmQQ>
    <xme:iq62as4pT8bTwqsx8qO9W6Q-vMcr110hIWU523Cs7Xgd-SKkHOzu7AUF9b_9pPE3O
    EZJ6LiBW2nBQfp8rXNnpml1wydVh_hG_0hZbVhzuY-IBvQa6V50jCzV>
X-ME-Proxy-Cause: dmFkZTF7Hb/lCMuIwar/hGUiRVA2a4hHhKyj23sg8puoXbmuxtzUBE3OW/DyMpkPlN4wTT
    nb54JAAEzjLBSCRstDYr8OKmNUqtTTRWcSFBqiUpX6gNrE/GEYyNH2r47LUJTk/ieNlour
    /No6KDqtkSxPz7/bpWKOlHMZ68NeGBfOlzc006BXj+ppK2RcDK866BaX/hYzFORlQobkMX
    jWu9A2mpCbRDyh99sSlAomRT4EtjqQSHFc0y9DySe5oOSF/T0G7fUi4X8QhJhgjzLiQHoo
    FIxQzLWx4OwuSPODKeArIJQxlKe8H9k0QqNWtJJsfwnsl7G8VSIWl/oQjHc+PSReny2NY8
    iZUyaOztjuF5eBeqgW811cAM3He8T6tGCCzIrf8NtPiyXjpNfNQLXemPKOLKd3KOlQWGBM
    JAkbZw8g7MEnvaGG70+jzW4x4BIFjFf8X1Tg37LX0P/PRtqeaF2jgWw+Rnp1s9rxXcSaLy
    wdapp0ENfqKOysua9BEAolsmz786ctSvz7Y1eHUc1BcKCV2aHSk1M/93oS3GIIIscAjYp1
    sb+G4ruCGKQDCOPOSW0Uu1O9kyazRm2WkXlo/OKIk/IURqDBO+FbkhWzujuAlfW4xEAT6m
    57CR/7vprNctK1MfZXQN/0HJvnoY6ccMBoXfs8vA20YD+dUEUrHgse/yBFwQ
X-ME-Proxy: <xmx:iq62aqjWCh0GJHGWsTOctndF_nJ1_RD3T2t5FjOvlhrojmyptsf5dA>
    <xmx:iq62ao-eMtVABd7lD35HXk5xlyuklZpOANSBPznuXu377V0sXLkkfQ>
    <xmx:iq62app6nFhpY6-q3KOGeubatfDdZLjsEu4uN2PCgVoWNxEPuacTGg>
    <xmx:iq62av96VoACU_7JkpTWD6JICBOXtRAD5VyrV6hVgmiWbodlX55IoQ>
    <xmx:iq62asoxP2aE2u9QSGkUrOoYKQOh-6di9DJPD8PmN2dB9fyUsClW0LWu>
Feedback-ID: i2aa947c3:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 75DDE780076; Fri, 25 Sep 2026 13:25:30 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AGBSJuH7AubZ
Date: Fri, 25 Sep 2026 13:25:10 -0400
From: "Julia Evans" <julia@jvns.ca>
To: "Junio C Hamano" <gitster@pobox.com>
Cc: git@vger.kernel.org
Message-Id: <4c9f0480-768a-48ba-9753-b4d34188b1a1@app.fastmail.com>
In-Reply-To: <xmqq7bk9wa4y.fsf@gitster.g>
References: <pull.2416.git.git.1790105342890.gitgitgadget@gmail.com>
 <pull.2416.v2.git.git.1790297546771.gitgitgadget@gmail.com>
 <20260925082723.GB1493716@coredump.intra.peff.net>
 <bd5d9451-ac5a-4274-9a7a-57ae99864fe9@app.fastmail.com>
 <xmqq7bk9wa4y.fsf@gitster.g>
Subject: Re: Rewriting the Git tutorial to cover less content
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

> Omitting some material that is covered in the current tutorial from
> the new one would mean that the topics covered by the remainder of
> the current tutorial have to be sifted into three buckets: one that
> is to be discarded because it is no longer useful to the target
> audience, another that needs to be described somewhere in our
> documentation set, and the rest that need to be taught elsewhere,

I do think there's a cost to keeping guides around that are outdated
and difficult for users to understand.

For example right now `man git` says:

> See gittutorial(7) to get started, then see giteveryday(7) for
> a useful minimum set of commands.

This is a nice friendly statement, but in my opinion `gittutorial` and
`giteveryday` really do not live up to what it promises, and I think
it undermines trust in the documentation.

> though that may be beyond the scope of the project documentation
> and better left to other projects that produce "books on Git".  It
> is somewhat unclear from your description what your plan is to cover
> other topics that should still be taught.

I see a couple of possible strategies.

* We can write new guides which are clearer
* We can link to outside resources (via https://git-scm.com/learn)
  which we think do a good job. Right now that page is pretty
  out of date and it would be very easy to improve.

I think a mix of both is probably most realistic right now.
