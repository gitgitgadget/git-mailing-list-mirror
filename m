Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 323BE4A01
	for <git@vger.kernel.org>; Tue,  4 Feb 2025 00:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738627861; cv=none; b=MlpiWL8wIzZ00ck9xv//Zr4sM7f1NPDEUfTSLzr+gvjYlilT32V5QUctJk46CmPvvqf2lEu0jIbJOgIkFB2ccg785JXx6g1f1xkQ7ypE9OLb+7tm4RSWFl9+hVm/YzLr/ln5NVvck+RXjCRQETHetdHDLPLgND9TOeOQVr/hGBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738627861; c=relaxed/simple;
	bh=8m9WFy0ppiDox2ssVl7TWLxM2/1HuGvo6HwTeRYhi0w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BRk3ra6dkExNJkpnT6crRg+WfXz6bQUm8+/Ag3Tzd8k+Yu6Fe/QWddFX3O5X631vZGbau2J2sw0WKeSsZPsw/C/X0QYuijlbmyuz2lxerfQg0+Ubn0lA/1qgymGK1aD4yP6KgJvTHaCebKwnVPKwpXFpVZybMToCY6p5mFnQgvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Fj7Rumlb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rolr67l3; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Fj7Rumlb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rolr67l3"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 26DD51140209;
	Mon,  3 Feb 2025 19:10:58 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-07.internal (MEProxy); Mon, 03 Feb 2025 19:10:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1738627858;
	 x=1738714258; bh=VoLmbv1d88OsHM0rpPRC9s4DsqWJF5hiWoQWoLqdFw4=; b=
	Fj7RumlbD0nqizp3twOM4WGe0QGi4EkFAlwHguc3NM2o4K7roqGY/3Cqmtnis3la
	QoI0ESH2u5osvwNYSmI16oWlSEeWVCOShi7ChQv+g6HT37TJf1kJi8rwB432QZVv
	uUG4wLcN6F9PrbVz1P2Szz712dpbx4chTmO01Jc33gUFvzK0D/EbfnfK9GNqEYGC
	YwVTyad8d557TAkG7BT7aeYax1FootiyE3VnD2bx2c5qRT1HTALOk9PWK0RqQ3UI
	jhWf1twrHdAz81Uvwqds2mViobZBn6ljeY5jeTAuCBMGBaZA2hoXUhWn4CFUHHYJ
	yjhGj2mIjUYBZT4GncEMFg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1738627858; x=
	1738714258; bh=VoLmbv1d88OsHM0rpPRC9s4DsqWJF5hiWoQWoLqdFw4=; b=r
	olr67l3OlWPoUfbpQj2LeEjE6SUo9s55csGxvgPhdrO1d+CDGLrBeDcp5+9+0OV3
	SDqaFepQNZM6y1+Cmb/WqM2juqTUpv587bBb/0h2fgMH0UkGwTDhJU9iFadCLg+m
	plrtNjEyKlqWd+cXU95R1CX7OKtKsKxblLmXFaGSr8swMma+qPNOSjVqKoW5Gknm
	5Rp7+M5x5Uf6Ww044QrnqZvuYYR4Z0WTzdMgcrSYI5+aHFyB+VRXcfhvC0zZKmqB
	TfqzEbaPOBRywL7YF94YG51MeXJ2TNg9BEit9SA7mnX6Hc2mF15fDiketb17b5Jz
	AItrUZNY5nNp8EsrdLuMw==
X-ME-Sender: <xms:EVuhZ-4tO_v7bgU7C7ZluNDpbWJJg6JrOYaG70qkWyz-IwkjNJTdqw>
    <xme:EVuhZ35-1CaHeI56Wue-yVIZT_N7S-vsE5g1c9F49AezEPTYB6Rr83_o0n-KexkLX
    cvoP9u-hrLQLhXJkg>
X-ME-Received: <xmr:EVuhZ9dnp0mw9T6sHRcEKSavBfNuP_aP3BV_MDOw981xT-eoCI4xKHKrOPviv5r7PaVVeDB86as22-9xzi0Y5qR9V6gbw35u0sER>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduledtvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvve
    fujghffffkfgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihhoucevucfjrghm
    rghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpe
    fhtedvjeehudehgeelheefieevtdegleefvdfftdevtdduffeikeeiieejvdelhfenucff
    ohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepmhgrnhhuvghlrd
    hpohhrrdgrtggrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhk
    vghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:EVuhZ7LMqTQHxDafe8IzT2RR4QJc76nws8dS3NdXYZDkb26Dz3omEg>
    <xmx:EVuhZyLYj0Ypdjb4rv_L8aXY_9BYEayeDGNaBUTeSlR5XUVd2YsJnw>
    <xmx:EVuhZ8wurIPVAugcJnLIkQiutVDLyZToiDqmy0W9ypQGdm5pMo1b8A>
    <xmx:EVuhZ2LGCEHXHsNsxKY-Rai02CU47d6VMLc0X6nx7nZQIrdwUT0WFA>
    <xmx:EluhZ-0hZ0dUjxCPxEODISfCPR_CQwMfBziuWv9AyoM8J0ubLgspja_o>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Feb 2025 19:10:57 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Manuel =?utf-8?Q?Qui=C3=B1ones?= <manuel.por.aca@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: Usability issue: "Your branch is up to date"
In-Reply-To: <xmqqh65b2ci3.fsf@gitster.g> (Junio C. Hamano's message of "Mon,
	03 Feb 2025 08:56:20 -0800")
References: <CAPpV+OaMcViVKok5U0-4HaYyPMKEA7BBzw4t113uAaMndjs5Cg@mail.gmail.com>
	<xmqqh65b2ci3.fsf@gitster.g>
Date: Mon, 03 Feb 2025 16:10:56 -0800
Message-ID: <xmqq34guzi0f.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Junio C Hamano <gitster@pobox.com> writes:

> Manuel Quiñones <manuel.por.aca@gmail.com> writes:
>
>> that can be fetched from the remote. My proposal: Add the timestamp of
>> the last fetch to the message. For example:
>>
>> ```
>> $ git switch main
>> Switched to branch 'main'
>> Your branch is up to date with 'origin/main'. Last check was 2 hours ago.
>> ```
>>
>> It looks like the timestamp of file `.git/FETCH_HEAD` would be enough
>> to implement it.
>
> Not generally.  Your last fetch may not have been about origin/main
> (e.g., "git fetch origin next"), or it may even have been about a
> totally different remote (e.g., "git fetch elsewhere").
>
> The timestamp of the last entry of the reflog of origin/main may be
> a lot better place to look for the information, if available.

Unfortunately, this is not quite enough.

I do not think a "git fetch" that noticed that the remote-tracking
branch is up-to-date updates the reflog of the remote-tracking
branch, so if you observed that their 'main' is at certain value 10
hours ago, and if your more recent fetch done two hours ago found
that they haven't made any progress, the reflog says "You observed
that their 'main' is at this commit as of 10 hours ago" and not the
number you want.

However, as I said, the fetch that touched the FETCH_HEAD file may
not have been about the ref in question, so while a two-hour old
FETCH_HEAD can guarantee that update of any ref by fetching
(including a fetch done as part of "git pull") did not happen in the
last two hours, it does not really mean what you have in your
remote-tracking branch is not stale from reality by more than two
hours.

You could inspect the contents of FETCH_HEAD to see if the source of
the remote-tracking branch is listed there, and when it appears in
the file, can use the timestamp of the file.  If you did this:

    $ git fetch origin main

and it left something like

	f93ff170b... branch 'main' of https://www.kernel.org/...

in the file, you can reverse map the URL and the branch using the
remote.*.URL and the remote.*.fetch configuration variables to
figure out that it must have been stored at our 'origin/main'.
At that point, you know that the timestamp of FETCH_HEAD would be
when we observed that value in the 'origin/main'.

But even then, because the FETCH_HEAD file is not versioned, if you
did

    $ git fetch elsewhere main

then the file gets overwritten, and you would no longer know when
was the last time you observed the value of 'origin/main'.

In short, there is not enough information kept anywhere to compute
the number you want to show reliably.
