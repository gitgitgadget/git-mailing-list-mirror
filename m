Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51F52227BB5
	for <git@vger.kernel.org>; Tue,  2 Jun 2026 13:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780408210; cv=none; b=Qvn2tPxrt8laI5asWbRJgWeBvfbzxpn5MIKjjihYID1ZhWmoQkpFgK4D+2usM9J1beqER4qtxngSTtt9iuadCCU13OxkxYJUmBMlcf/6CoedNkiZj7/USaGi/GN71/7oMOCnUy+SyyiJ9OAoWK2O+zGZDPQA6bxPo3GCcitYumM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780408210; c=relaxed/simple;
	bh=80/+KjNTfCEzFmRU/Mz79o7UHXILO1LFA/PlzAE8acs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Bp/+s/ZLWqnegUdcijV3nprGG1l0PNmVetMfv8qeWFXHJv2KIQGAH64G0LzRWYM2nKSzmkaQt9gwiMQp3LmdJ8ur1UT10CHu8ZZo12FLnpk/YujEN9TTMpIhUAbOeJ7EzZCYfAF2ZKildUcmAmUUdKuwERYP+zj/axieMdwecdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=XsM34bII; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gS2cM+vx; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="XsM34bII";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gS2cM+vx"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id A781D1D0010C;
	Tue,  2 Jun 2026 09:50:07 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Tue, 02 Jun 2026 09:50:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1780408207; x=1780494607; bh=4+HnQ532xW
	B8YPytWT3GUnwe+EvAFMiaYD2mf3aivmk=; b=XsM34bIICgN9+/WiK+3FNGub6A
	T79QNdkrKxuEB9cH3Wq+wRt19CqaYIFDo2hLc+PVfhX7KSSaDrVIHj5bIoWOFaM9
	r6nTQ/8pnSXVvNLK7CQQ+F2nAJ+EW42ibBeB3Usc6nOtEKWl4wSa8kIX2dCs4QnM
	1zxLM5EFcWqn30gRMHqwUNRdz35WAMPf3rvvP2irFt8+dng3SVamzwum9g82JZml
	w02qnQnG42TN5Xbe7LtAH06uNPilMEHQzorA2A8cUT8Z5BrdAUqLg9vdCQu/SZXL
	F/bGRbtMBcUVMYSXQLg7woJbYTSGHqRR/xqosuyRGV5j5CBbDTXWdVzektrg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1780408207; x=1780494607; bh=4+HnQ532xWB8YPytWT3GUnwe+EvAFMiaYD2
	mf3aivmk=; b=gS2cM+vxb9b6JQXDMEELRyMXtHf8IEG8HbyOlmDFeyMIy9YJikm
	u6X7341bg7ydxXTQKJsYRcWbOGVz6gmpeKP+CxIBAt+SN14PoSXrX2A5j+SeTErO
	mCMwTZjmTr8WR7KpWo3s5jnGSKeGzJfAHK0e2FgmkDhJYlgq2FJnM4fAjVysveEq
	4J+s8eammjr7Rsbw/OhtZ++NLwWflMEUDbd8CVBq0CsAq9QaMszmD37izmH1whbB
	onyhmzujlO7oGI9v40XTlBsewUIF+GpsQf39C5hYbRRe1YjIZypPn/kF7aGk7gGb
	SUnWTm3LAhCyYLwTY2gCHWD5qbVgD6GOEAw==
X-ME-Sender: <xms:j98eas11oXgplVISD9NdubT6x9BEjsGxK7E6T9bcSYmOMQ0ydxg3cQ>
    <xme:j98eagbGfq_hZQym-rIrc41fVS6sQ_22WunaJ_j2xnMiYjBsJBHlvYnjW9c_qhBCB
    koMi8lacD5XhaLt1OgoSEE8_b_eQpGclX5XaeNKngv7GAL19Lm5aNk>
X-ME-Received: <xmr:j98easKD4cb29WOdGbFXjT032ERDvkP4eCWFFsMHYfBNtvZAlJwJCCgeNUZrPJVGpE-IldLdwlebqbUomfz2d0EIwrHBoRg7lWkq>
X-ME-Proxy-Cause: dmFkZTF8iSTggn2d8TVCIGYWV00WQfTvHG9qxEKz/o6l1LbjSetoqmkUt6+D3SUHwM2h0J
    LSX2s+jel9+woKMaS6rEEs7/3IrqiBMZLg5Zsb1BflsrkmVC0pfPPF9xdWPUPfMv/8ym6W
    vMzVWSem3wc+T5oReih5smR1OP1X8mfoW3S8bTMyAuWtybTbDkTj7x+jWHonKLdTWeTf4A
    B1MwjvTSI3slEksp60Snd8B1dlKPdQwrQVXaZBgvQ2m3C4eXAt8KFXDrflnGadhUwC1a+a
    WF0ZL0A++cOyt82TCe0kLk6pU/s66D8+RHv18ZsMxEe12sZ+BccFJ4t4StegJ3Yaq+lclQ
    dwpbSZi3FrXs5zMNHpi6QJQ84ytQQLGrGU1JO2uPlOLJMjHlMXCsRkZI2X8fUK9E8XJ2rJ
    JYn4l4J3AibIhTEFryF8ewv2QZLbUgzJkkEj6+a2tBVdevv/wl1pglAYjAaX/L/IPTrhSm
    6cK/plPeU79rnEObZcBawVBWcI82mUgjbCFFOToUHZCArxBVQrQw595W07ZVNNYOZTHXm7
    pRAm1uuVKpXO2BYLUt8gfvP/2/bAjfGoTFHGL6UDV+k4jKB+gmXVKdZxn510SH588067XH
    AVSb3Az8wvVpmx6fnKjYmvjzCeSEMgBzA4rGI5H9ufMd3qH5uxSFurzJkXaw
X-ME-Proxy: <xmx:j98eanGEbYydzr15FVGXLnO5Tt59FrmSfpCp_BTLyErkqHLfuckVUw>
    <xmx:j98eartg01OjQDyF_mwx3PFwMr1De3pGEmsm-rYyVW5u94CbKazWyg>
    <xmx:j98eaus1Gu9W7LR3MWc-Vm5Ixm645x1TR8n2Ql3ORq08z19kWjnsoA>
    <xmx:j98eahDzgcT549JeOxFpTip318NI04IyifcYK0aDKXk_VYDzcyEfeQ>
    <xmx:j98eah8Y4xwaN3cT3RDcEjmUgXLq1ArZCR1TrOyFhn79PN90-Wqp_57B>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 2 Jun 2026 09:50:06 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>,  phillip.wood@dunelm.org.uk,  Kristoffer
 Haugsbakk <kristofferhaugsbakk@fastmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH 2/2] builtin/init-db: deprecate alias for git-init(1)
In-Reply-To: <336a4202-a55f-4223-b654-985d47233653@gmail.com> (Phillip Wood's
	message of "Tue, 2 Jun 2026 14:09:39 +0100")
References: <20260601-pks-deprecate-git-init-db-v1-0-ea3e6eebe674@pks.im>
	<20260601-pks-deprecate-git-init-db-v1-2-ea3e6eebe674@pks.im>
	<276a92ac-b2cb-4a89-96d0-9071ab6200be@app.fastmail.com>
	<ah12uk7IFxS92OR1@pks.im>
	<042e66b5-122b-4c86-a9a9-f75f763666a7@gmail.com>
	<ah2VL-ftCQelNoOc@pks.im>
	<336a4202-a55f-4223-b654-985d47233653@gmail.com>
Date: Tue, 02 Jun 2026 22:50:03 +0900
Message-ID: <xmqq5x41vypg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

>> I was wondering whether we want to call `you_still_use_that()` here. I
>> found it to be a bit heavy-handed as it's so trivial to replace with
>> git-init(1), but on the other hand it's a trivial thing to do.
>
> I agree you_still_use_that() is too heavy handed, I was thinking of 
> something like
>
> 	warning(_("this command is deprecated, please use \"git init\""
> 		  "instead");
>
> but that would mean we need to add a separate cmd_init_db() function 
> that prints the warning and then calls cmd_init().

If we do plan to remove it in the future, then something like that
may be needed.

But it is not like having "init-db" hidden but accessible in the
command table is hurting anything.  Other than that those who want
to create their own

    [alias "init-db"] command = foo

that is, and I'd see it a bit crazy.

The "init-db" form is hidden from "git help" listing, and we know
whenever we suggest to run "git init" we do not say "git init-db",
so if we do not have to remove it in the future, I do not think we
even need such a warning().

