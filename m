Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DF952472B6
	for <git@vger.kernel.org>; Thu, 23 Jul 2026 14:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784816831; cv=none; b=eEhCgAa6hpxC7a3waseZt2WuJ/ApAR05/j1AfvBN3sWenWvFnsVvWBF0hOpAr0BKvjgClgXKyiXqmhKUvj/KyfZmy5JNktqDz5F8FJvLeDV08FCgyLNLhZezjiC/zuMYAHZX689YmC5d76HEOfD8nd13rcSJ647z3s4SGJ6n8aI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784816831; c=relaxed/simple;
	bh=MgRu3Nn24sxskrfn6OvwzdZHMk2QR73jE1qEAcHoxzY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HERikEKOh3XHlrnBEznYmrN+c1W7OmjWL677DojjdbTGFziYbDcsNHmeUT+eiGg+KKDmrm2F+TidwDAZab1a3X9saTgwUoZQxtlHmEJWoY9WRPjeeRZfwFL45LhmJQeA/s5egYMjh4aKfuBGW+991fEOr67sSEX13PkvebC5jMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=p4hLdTRP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Wi/X2A+I; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="p4hLdTRP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Wi/X2A+I"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 5EB531D00067;
	Thu, 23 Jul 2026 10:27:09 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Thu, 23 Jul 2026 10:27:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1784816829; x=1784903229; bh=82hDNqE3bQ
	wVoGncTCqADo2tUIQpIp+LVavlymeaRw4=; b=p4hLdTRPrlRqxp+8EBN94FEYnX
	0uiXJuTLqhHhRbNp72EK/BgB1q7WzHBnZPONM5Lie40r9owl6VS6uFLq7dai+7H2
	twaAJ5U+1Kbp4YRsPje/IPPNvxzYtzkxeU0CrCND+wOPKul9ClCQLxq7tga4o1SP
	g01nETcJ4VRdW9L1kKHULYjssxfFa65Ok9TjVgdBuC7sWmEUnFE7EAdpWfhQw4NT
	lxnbkRAp4QWaISYcAWACcLG7leFOUEvYOHNy+NdMzO6bm+cDIB0mN65WlBFH7PK3
	xj37KFFbXwObmJRUgny2KWQiEDBijPbH+/6koUh9OLJS8xD8uO0/U0NduG2w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1784816829; x=1784903229; bh=82hDNqE3bQwVoGncTCqADo2tUIQpIp+LVav
	lymeaRw4=; b=Wi/X2A+IUSRevx6UFDHeEuZedPt2o38BLFbW7pZCqhVptJyhYoN
	9oI6fnj5+paCY4IOjxuMZHDPAQ/sIZ5pTwdhl98nH7MLdvBE4foFBTy6v9juzTf1
	Hl7J0SszMYKKhtULZhUp3kTAtyupw1hQMaddk2Mjh/TJ6Qj5XrCi68gC2FLhrWHL
	YkX8DKHsIwF83gQWu6OvxUQdaj7yITyS5eI1l1hWNy09+WMNefABd7rUS0NXXZCm
	qodotJz5qcsXVAmX7isGgwQJD0DnL5DQx41DCyK6BoW6Wcm1XscbgLUal4QZNnZ3
	ELzcWEu0ONhwZVpijMEcRedW6wZbIyjWTJw==
X-ME-Sender: <xms:vSRiapS-Ug0RKMrqPfFWwb3SuwGmtC18Dl3oeDyf5-yt-PJt1yHrYQ>
    <xme:vSRiapoDESfBywbqTtpIYMybcNANt1oBLbQAfmW4IC9lwWcHTUDGW0KxdXP-IexUN
    pp-h1ApMK_iZe_FvhGjitw4sTM_GQDnWxRgaqy5d0q8uBjWqRhetwE>
X-ME-Received: <xmr:vSRianJ3hWwn7NXBuYe2My79aaEBr5O9YvCniqOyblpYzsNCDoRbdoKu2tUqiH-rFNC2Z5y2-ZsYt6J_Z5xTCQMxu0sWAtnqSA>
X-ME-Proxy-Cause: dmFkZTG4KTEaj6Ckx88uknbyCJ/bzFsmFHcr2LvmGAgdClyrfIHTBjJMXnh2mLJClK2COC
    AAROY11AGR9aAgbmPWCzRW7ayXCnCB4uJCwkg4YbaYTCcGj84C3mZW9vOJ2TG4lofBHnrW
    udoWmBMcdOQaGZmuLsKJboiL6vVssvk5E3okTZDVXOdThwjijKaNLePpB4sug1ONXZmfFm
    /sZNgoH4CmJN80mAfw9ANi+lqldBEDKWlhrbm+ro2bW3d5bgfXdDhAvthc27IuW/U939sB
    KUvI5hBRMLuHRdTPhX95e+qfK9T0eHHNoEjRaV4hCA7/VMGYkJeuSEQozjCHgQsGAjHgVR
    OAM7ZD7NIUddjO0lrxZC5IhqqH4yy+4VF5MBrfwGAH5zAHcHoH7HHugq6YwZusO4+Hi+Ue
    +RFHMHExY0wbuPEJ3D0RxncJAeHlY+U4ofKU1pzNEapeTm8L9W4B+IwE2Ekq9WzoKh4bRo
    Bl1EG+A7QS6EVCnBPb7gx2/aQs2TcZh93yI1MZeaDxiIQXt/YjgjGhMJNK5IxKE5T3dxUK
    /klXu0mi2CmvgtapsrsS4E90+ziMGSc3ovNnQbTWo+mavbp6pNzv2MtrUPSp1h4FukjDxC
    0IhYyrG59fOekdhfQKjlrH7qjEKHc2ZaDVE/M3HKiDQl+QyIjAGVGnc3ke1Q
X-ME-Proxy: <xmx:vSRiaspx3ZzK_G2cfcZw7BZYJtHRB7e-9siqBwS7aVwg2iMQx-JdRg>
    <xmx:vSRiavyr0gU3sI0NRZZmpzdSA9_EjQwIGDZ-41KXUhZ2EGAV3Npd9A>
    <xmx:vSRiagP8g9k6px8YK7dBD17QypmgqOuCMRPbMOwKXs_Zd62B1rn1KA>
    <xmx:vSRiak5HmnTtzsyEMwwUbOU3tOP-3tMcHkNcNjyHjep91-a-9pyoGQ>
    <xmx:vSRiao53ssLZKNa0sIQAJmr8kqoyOJQZ-NClpgteUaVA-tf3RZHffKYe>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 23 Jul 2026 10:27:08 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Johannes Sixt <j6t@kdbg.org>
Cc: Harald Nordgren <haraldnordgren@gmail.com>,  Harald Nordgren via
 GitGitGadget <gitgitgadget@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH v3 2/2] bisect: add --reset-when-found to leave when done
In-Reply-To: <faa22968-54ac-4e4f-8324-3326ffb00c5b@kdbg.org> (Johannes Sixt's
	message of "Thu, 23 Jul 2026 11:17:28 +0200")
References: <pull.2335.v2.git.git.1784312854.gitgitgadget@gmail.com>
	<pull.2335.v3.git.git.1784538619.gitgitgadget@gmail.com>
	<542f4b2c8065818b887437add90130d2090fa0f2.1784538619.git.gitgitgadget@gmail.com>
	<faa22968-54ac-4e4f-8324-3326ffb00c5b@kdbg.org>
Date: Thu, 23 Jul 2026 07:27:07 -0700
Message-ID: <xmqq33x9n5ms.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Johannes Sixt <j6t@kdbg.org> writes:

> Am 20.07.26 um 11:10 schrieb Harald Nordgren via GitGitGadget:
>> @@ -784,6 +859,10 @@ static enum bisect_error bisect_start(struct bisect_terms *terms, int argc,
>>  			break;
>>  		}
>>  	}
>> +	if (reset_when_found != RESET_WHEN_FOUND_NONE && no_checkout) {
>> +		res = error(_("'--reset-when-found' cannot be used with '--no-checkout'"));
>
> We have a boilerplate text for this kind of error that saves a translation:
>
> 		res = error(_("options '%s' and '%s' cannot be used together"),
> "--reset-when-found", "--no-checkout");

I wonder if we should add a set of helper functions
that return an error instead of dying, to complement
the die_for_incompatible_optX() family of functions.

Are there many other places that would benefit from this?

Thanks.



