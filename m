Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D59E492188
	for <git@vger.kernel.org>; Tue,  1 Sep 2026 17:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788284905; cv=none; b=cQowZUciKk8CWRy9G9mgN/OZ82bbBCYtIrxp1+0GLozBDlTQBwBc34qVREaB+NIiqxiI8/yTsaRzHFjWVZ015xdzqDOOGufq2Ko6+LtHfnVEmYEp9a/e/+0rNYsmdbmnPdmoKnVVx5IOT9QVWwIUX5OmGBaGjTjz9I771iPgazQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788284905; c=relaxed/simple;
	bh=6ft9Iskh7kgEE2xx+7E+ulBGpRhFEOqCPEgzenC8SS4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nCgy7m2mrx1Ey5qG3xu72bBFs7frdy9Fz8gS11EnJtDBN79tSg7GSV4Sn6DgxnZ7Yp4o0d7TtWeOFLW74NyEHPdZQS3d59jswOnyLNcFd4nEWuX+k3C9mQFmVxCpZC+jG4FSsIOMCZICUhrt4KMWTOBacZiGMerw7/dKWSsiKwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=lKdSX1Fz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Bqwro2Ch; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="lKdSX1Fz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Bqwro2Ch"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 3C4A51D0012D;
	Tue,  1 Sep 2026 13:48:23 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Tue, 01 Sep 2026 13:48:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1788284903; x=1788371303; bh=EYc0Pv7rXj
	aWANwBHd+n4cD9GthpBFZUxikpav1snqQ=; b=lKdSX1FzDROskb00m4FYSpC0eX
	bp0wuybMO1qIwpClIaIc0W6aMzsfmpT9Dh7bATVAM1eq1mIQRs3ypa5i7P2A0e3x
	Ze+cLhf/zEhkVbqzmXkOjgmvKVAdRrTdNnATqVqecH+9NQ/z7VicTBgsPcIwEDdQ
	jCHjJOuNyrBYm6nNkQSeuOpcAbJB7j5HY6b2XZjZvKJbn8a+qsbXfpNJtZuzhSuW
	omLiat+T0j2D2pEUZlhpzO30CHjAABJtcQ1UdWZy7iFBvLCDwrMUO0xipPALD3BX
	C8iptNAXcrGeRJD5pi6Ghitcvpsd+BK9ImyvBLAI3xEfgtaKo+gV7oIKuEOw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1788284903; x=1788371303; bh=EYc0Pv7rXjaWANwBHd+n4cD9GthpBFZUxik
	pav1snqQ=; b=Bqwro2ChguAsg+j3leOYoUyKDLov/h1MALVE6fpQTteKeuVgRdr
	xtRuZnE6BLopIFwhawaBVPHr2YoGkBsmipHeXMcLL6sd2poe1OzOrFGOQU+WGkXM
	g/WWmci1NmsqewsTjUDAAgFgQgkhpivOjR2J9USdCqH1hXgwYpnukG2b3XDnL+3c
	fx4pzGI0F7tkGiBNJVbQS13CX1lQq5roHZvsABSiszJfHTtAmFUxIv1PzY6DZnL7
	8gIdxvQelJOfXlOZ/50AfG/ej8NgMfsowXd4Fi9QTV4fQbz78EOzUrgGqW/0YZM6
	68sgeXdyIVoyDXQuLSnAkukICvIftYph+Ow==
X-ME-Sender: <xms:5w-XatTffEOfOl_RXcybi-KTOPhVh-RLeTMLH31SGT9JwDqLHqbelw>
    <xme:5w-XauO8hc539uwgJuDSyye1bjcXEtFlx9tsmbmbH-EWfTR5xmSMid9FU1nbr9zZR
    2U98zPEcFPg6Tyvs3dVQsd7SS277nFnmSl8wHKEH9jX2zxh_PPKjg>
X-ME-Received: <xmr:5w-XagNnZ0ayV-pevVIw6kwgOmZoQTPt9FymdKQ3mftFMWnsjNe6Kvh2qryQPpGakSqmAEQPAksHPd3vyQ0WnPssJoHm9675KQ>
X-ME-Proxy-Cause: dmFkZTFwUf41101ZwrJ3RladqyP0ox7Bhx/Lu3YTqqMou2+dWbPgjNkzIhKxPj2Eak4yuS
    116LfSOywPm0ReORt3ch2iDU+iLcv97bhCGNMtAmUyyFL84sKPjXiQ+mmO1kM+Zbf58Id3
    TCIwmlGE5DMblgBlVxsrrsmebrS+WLp5eYqiM9nfnWS+pNYNsAjpvRGYzg2VSpXp/HfcM6
    SA0mnOwG94uwuiIOyAf5n68FwZVR61tU2rMfHDFYkBebY4kladIUMeIKWToueqdLDopbyv
    9ywbJvBInvMRhTGkiEGEWrqWvaTMm1C/OkjR3b4Aaeh/7kvzoew0X/B+3ZDKoseDwGJaez
    N6e886cNUqhMQZRW7YsYyk/k9cIJekYnQLgNSn4IiXFvcDShNQrYnAyWCb7/EjRdmqeY3o
    Pxu7SK2a6pfdOrvaiSuRSidZqYo6C/iRNiGry76gcxhDVLkR9XMF0kk1UuoAwkFrzkywCF
    8VWEEcK71MHubcSJn42C+/uDqFjfgWgMsSL28RwuWdGGJpVl+RYaUE8wXQRCciaGn+0Cte
    HfhdD/byK6DebAuwUL8s1bBkPGroGEZBi5AauFVDmTc8eHO96Gbvsnt3fyD4zVgHuS6fzs
    jY+xZsrQq/f6ryZOX+3KE7LKgsFad873IVop6E0ACSdAbAWx/m7F0Y10XeWA
X-ME-Proxy: <xmx:5w-XausRIlr0GlZuvtGzug2YH4c7CFnb3uY76IMNaOPrbmi7F_Ly1Q>
    <xmx:5w-XaqU-oLWqh30hpa8saI5Xwpm628Z9fmkMPyjr8NAGDB8q_6bf6A>
    <xmx:5w-XamtrMC6cXISYn-oWGGvNjeZoy3T748LI0vKihTRo--UHpHex0w>
    <xmx:5w-XamXolmnT31pg8_wBkz2Md7Ns6uImYsnVA35iTv307w_3VvF7mg>
    <xmx:5w-XamVYiCQ778O5bHmUW0vRjDd7obtsQcySekqIEjumgn51OSvV3xQ4>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 1 Sep 2026 13:48:22 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Aug 2026, #13)
In-Reply-To: <apa2XPxAFyUXveJY@pks.im> (Patrick Steinhardt's message of "Tue,
	1 Sep 2026 13:26:20 +0200")
References: <xmqq33vuw0ht.fsf@gitster.g> <apa2XPxAFyUXveJY@pks.im>
Date: Tue, 01 Sep 2026 10:48:21 -0700
Message-ID: <xmqqh5k8sw0q.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> On Mon, Aug 31, 2026 at 12:31:10PM -0700, Junio C Hamano wrote:
>> * ps/fetch-packfile-uris-parallel (2026-08-21) 2 commits
>>  - fetch-pack: allow parallelizing packfile URI fetches
>>  - fetch-pack: prepare for threaded fetching of packfile URIs
>> 
>>  The `git fetch` and `git clone` commands have been optimized to
>>  download packfile URIs in parallel when the new
>>  `fetch.packfileURIThreads` configuration is set, significantly
>>  speeding up fetches from servers that advertise multiple packfiles.
>> 
>>  Expecting a reroll.
>>  cf. <apUUiv4SD0-W8QS3@pks.im>
>>  source: <20260821-pks-parallelize-fetching-packfile-uris-v1-0-0df52d9427ce@pks.im>
>
> Please evict this topic for now -- it's creating lots of conflicts with
> a series that Justin is about to send that converts git-fetch-pack(1) to
> use object transactions. I'll then resend my series once Justin's series
> got merged.

Will do.
