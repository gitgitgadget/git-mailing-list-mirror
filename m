Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12E0B2836E
	for <git@vger.kernel.org>; Sun,  2 Aug 2026 02:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785637386; cv=none; b=URo5/iQ6BSfeiVqO4VEQwDgO5kSapSyMk51MfbFCzlNjoLlNWkgwkssHJrXlpXTAEdzjOBhqceh/Pwi7bvlTjCDVsa9kN6oW7YAaeaSs7imr2rwsLa4TF8eC6tT5119PxQ70CQDjTKLLUidJrx5jQ91I7PhUXJcyGjRaafDtez8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785637386; c=relaxed/simple;
	bh=Z/r9vvvmR/+2YRHnRaXzRWOtU6oSvUuJjzTHPFxCsXM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dfxQ1uQqLav7WZPdyyry9ff7TDTQi7QoABWnDy3oEcn2t+8dtg8uZDEgrGgJgkC6wYbn8Xt8sdN6dNjqh/7qTiWp2fiflEXUXuz/NdVsiPEcrh+APa1sfLtaz60T5HlwLRyXnHX1PEsEYS3xp1Zq1lkVWNIl1QfSKnezx4xxxLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=B58ig2fO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XEINIXjf; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="B58ig2fO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XEINIXjf"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 2594FEC011D;
	Sat,  1 Aug 2026 22:23:04 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Sat, 01 Aug 2026 22:23:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1785637384; x=1785723784; bh=4MqVS464Tm
	HgPYLOlFTP9CQ/1pCl6o8z7mFzNlpDtdM=; b=B58ig2fOVL1UgbDVq4Y9AqmZjM
	H7D9ovXNQlQKyT/0QATfdOeQKdJJyeN4FJUflyWvu8BTE+9iIdnmojrOY2XdR+6X
	6yMWkAk7S136zVqa0bexnwRfoA9H7WZZT/fvXgih4WgniZ0P4wfjHg1rEK4q68HJ
	ElME8KguHUi1iIP2e0d7i+5bRUI85kkLOqBOzudtQQEamnsnFVfoqMrcGjBECRs5
	HXQ5F+jtBX9xLV2z9t/l3bcf7c61q23e6lTz47KhdFZNVQ9/BKtk1LTCv7sWKDq/
	rczx1wl/evv4MBfUNZDTfyzm/bqm/wXJC/0D68m8AghhViMZ40wZYTcwHVkw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1785637384; x=1785723784; bh=4MqVS464TmHgPYLOlFTP9CQ/1pCl6o8z7mF
	zNlpDtdM=; b=XEINIXjftQlV+6CLDsvOyDZLj4kGd2PKHbgANg36lzU3bYI4zUs
	PwxjPvPp2JdxZO/ZUZ3heMovXes6Fd+DDdogAbYPeF/mE3v3nkLMvlEtAtPzBGVr
	5oHX/hflMvfS7AghhKngVWK86DCPX2Ft35FfJwYy7il7gZFQYdCTw86bQLyopkLa
	MZRIff9GJ1mCXoqIA3y0EGhj1+xEKyVsfOKQQkdH8J5gRG6edpplmNYCxLnWNAuh
	FfSTgs6z0iiVp6SXgu5zIYhbh0fS1Ya8Y1OzHNDusz5LipRD33Nf43J+Z6+YsOIV
	CUUTxsJecneg1RINZHOvA8VMs9El4dsE77w==
X-ME-Sender: <xms:CKpuatKL4aEdKN7093SJXRFRHdF0EQcYc20JyI0SS-WsZGXJ8wBsYw>
    <xme:CKpuagksEUTz3pBKiI5V1AjgN-6uSZ9yOvzy8cQ9cNq2uPf3jero2ytKxbkWEAFYX
    OAuj4SgAlIEOE6VpRx1_isq2Gv_E78I11v-IEF6eJr-wRBl3l2VFA>
X-ME-Received: <xmr:CKpuajHeqQOeTDcpdkcjyh_8pkMPO0n6D4daOIyUfsgVhrzwEY8T7Uq36Bo--HX0CO-JB9tl1e2EX2oeD1mtvz31W0WZ90Y0Lg>
X-ME-Proxy-Cause: dmFkZTEefD18Xcfar8XBm+guUHRD2PSSwq0ROw4V3mwOFFe/FIBzISQI2fkEdEjIDqU5jo
    7ntafUeTgEReRJmT+K04pteobhik0jkFVaeGdPd70MIg/SJcK57hP71XEUC9dsZHrYWd26
    XajrxcKrvwJWTpoIXHzf4kOb9gjv0/vt3A2Co/B7V3auRbEEAaBGjZtgJUGh28XFSNmdK1
    2s+psFMVGVHSRgT51FW6fVPwvKOGFUY90LFAySDAYt0T/5zFI1WLJQCOZU9k8F1gnrLYUt
    eNgrVMqdijO9TfABHZGyffzAskh3HKX9RTI3F5FpuVEWA+XgH/3qfItfAc3l9ScUSQwuTb
    LzLh1NyfUnBbLzZi7ReS32ZClnFvUZwP67ElaYtp1VLtr1/9MNl3/sjiwDoUeCV46r0iQ4
    bh6xrs2elI3B+6+ijLisxC3Jx0XbhzT7vL0JxiFS0GQtPSXJKIMfH6MSdO7sbpoSQ8r9BO
    3ULVYrUGrUg8hUF1fG5L7Fp1CNeI+H9yUETBWDBfUR/Pc5Hvlz0+BRl9eLRvl9qgGadLPy
    ll2x0rq0MnRX8DxQaU+7Vk7ni+Po2YyYk7owgispT2Qc/rPrhbhGV1n+h4Rn8052XQ89+i
    f/D8IW0hUX14QvTFiX7YR5CYbGDSfG8a/DFvECVeQWsacK09uj+YCsHp0umw
X-ME-Proxy: <xmx:CKpuaoEk6mjtBNEAnjEdXF-J9iAFOKCAyDi52olDuMmqsuFo7LDt5A>
    <xmx:CKpuaoPsyveRp9cK3Zx7Zi1b4txDrcdvZ5_T9rB9oeK8kgCwmzOrCA>
    <xmx:CKpuavHmOX-Z5kK7R4GVngBzxfLh6xPdTnqjoaCLJaNMVfF9S_p8AA>
    <xmx:CKpuanPkIoNj9ULG3FyS2fs3MNweFOht0W1Du_Vs_9BCuqqbl2153A>
    <xmx:CKpuaonbQUMCq2YKaOzSA4Wi7iPDO1V30DYMpFwIGfyHC-ljx8vCjqc5>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 1 Aug 2026 22:23:03 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Michael Montalbo <mmontalbo@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 3/4] add: introduce '--resolved' option
In-Reply-To: <xmqq8q6tc3cy.fsf@gitster.g> (Junio C. Hamano's message of "Wed,
	29 Jul 2026 06:49:49 -0700")
References: <20260728215219.753678-1-gitster@pobox.com>
	<20260728215219.753678-4-gitster@pobox.com>
	<CAC2Qwm+AmeDubDrkLmu8Rz9rtO3697gokwF2=2c5PgP--hZT2w@mail.gmail.com>
	<xmqqcxw5c3na.fsf@gitster.g> <xmqq8q6tc3cy.fsf@gitster.g>
Date: Sat, 01 Aug 2026 19:23:02 -0700
Message-ID: <xmqq4ihd5khl.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

>> I wonder if we should simply write 'addremove', as this part of the
>> change is about rewriting the open-coded die_for_incompatible_opt2()
>> in the original and using die_for_incompatible_opt3() to add a third
>> option.
>
> Not really.  I forgot that addremove is futzed before this part when
> add_resolved is present, so using addremove would mean both
> addremove and add_resolved are on, mistakenly complaining about -A
> that the user never gave us.
>
> So "0 < addremove_explicit" that is.

Well, this episode illustrates that the option parsing in "git add"
is unnecessarily confusing, and I think the reason is because it
conflates the presence of each command line option and the behaviour
the program wants to exhibit into the same variable.  addremove for
example is about "removals are also recorded in the index", and that
becomes effective primarily when "-A" option is given, but "-A" is
not the only thing to turn it on.

Perhaps revamping the way the options are parsed so that the
incompatible options are noticed upfront, and then deciding the
behaviour based on the primary operating mode that was parsed by the
ooption parser in a separate step might make things less confusing?

