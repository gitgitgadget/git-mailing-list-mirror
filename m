Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51FB23C81B9
	for <git@vger.kernel.org>; Fri,  2 Oct 2026 17:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790963941; cv=none; b=BAb7cFFCbxD/yfX4cnrj6j4fDdseOW3SKwbW5gTyx4iq7x3OkQPKhu0cDnL8K/1m08NUicMPHzC+UyMW+1VF1q+1BAJQnjFyYp1zK+EfLTgg0G0WOD2HsbyRNHHQqj1d+R5WpaCh5vaTXNYrGv6u5/giGUXXDDA8K4V5fklRjc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790963941; c=relaxed/simple;
	bh=mh9aNFctGBcrC7W7oLCIWOtpY/6cYStEfbOyfMe7BYY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TggL414rzAUoOMgTc+ssFnnlpgH0baB3zHnGX4Akg4y+ye8j/CvdYyIVc45vLKOyV/cLKIvEQ34kqBA6tb7XI2dJte9+e9y8wntG3h4i7+JFEY/pZ/ezZoZqwt8zY9EdoOY2kaz1MDeTrXITKFi+3giLDLCk1Jnnk2SwiW9hXMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=El+0eAK1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ig4yH1eW; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="El+0eAK1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ig4yH1eW"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B9AAA7A010C
	for <git@vger.kernel.org>; Fri,  2 Oct 2026 13:58:55 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Fri, 02 Oct 2026 13:58:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1790963935; x=1791050335; bh=rCE5nbzgcy
	brR1dpuuDAnK1o2iMasmzPVm5/kq252Jc=; b=El+0eAK1rJDTb0ZCcmWI51Pl7t
	yMfvDw2sVggmzbAW6e1+N+onh/+CITDxtoPlJiCM2/KAoR/Bzq00teTw86jQqxOV
	2DhezKj6GJKhhd+WQ9i5YzpPLQljg6CTiqgiE9lNM2ZthmNEX0YsuYatrgfelFZR
	UAEj/2T1rXyghX+Y3lYx3f/SILFHMvyoIueJu5DJQo6qf/j7MRndChFMD5YfIMQd
	OHjZdO6qsoUZRVXZAdzcbK4qQQ1NTBGsVF/eUEU3dtLzB5WvkHI65KP0ZS5K/qxt
	ht3jOYon9nkGlqtiTcLUy023OnhQclcE69NaCuKNJxCnCEPZ5UXY6QI4rtsg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790963935; x=1791050335; bh=rCE5nbzgcybrR1dpuuDAnK1o2iMasmzPVm5
	/kq252Jc=; b=ig4yH1eWfuptiH/8tHsLwXuruIQ9OfOGZjlhA4BnT3cxvpkPlyr
	e86NuJoHluDXzkgsPfJefkkE+1QAR1GaWKvcLsedt492GhP4WengPy7gNTBEtY7K
	MtTE60okklIHUk8wo41DPQa1PY/NyO7pFn038bNJnsdFHE9530yP1MVxHFR9EleS
	/hjtXxmQ+q+kExie1ZtdB/avI3nFAAQkRHTzQ86AetcUxjs2+Xf4QCTwYhbPAQsQ
	QkoqEa3+mEIQdINvy7uMgxhO1z199ct0BZouQEvfPBRTDRC8CxB+LDSV1jzKUwSN
	4LsMQ1ArENJoi2gREmwfujg4XEebmXgKWnQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1790963935; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:leO3y8LCXLLBxGqMmEHFy3A6w7SXAtjm8ne2UsdBpVDlyWC
	PbpuDH3cft22WmPYkgSiO/kNrWqxxgAxt8QcAsxLywkXE91XGZ+HBmzighGH5t2x
	yhz//CV61jC90mXNofX00Qf9F3vd0gd4htpMBm5ABpF0OE0cVrratj1q7kSa8M4G
	XG93kW9ol+A7zBCp9R9NynNtbwgFlx67kcNgfEAlWM9E5+VDU7Ygkm7pux1ir0Ol
	EtXNjRTuUfzF50zpGkcrqs8uK1lgpsbOMi1xaDZAIo4qeUd35Z9BhNhee4gTcSfK
	1JkXdKmIN52rTUXTZYI/eFbZL6UyVp/fD8z91nA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:7hgveKjf/VeZm/auShw4q9kKFNah1zyOvEPOp1OtJyU=:mh9aNFctGBcrC7W7oLCIWOtpY/6cYStEfbOyfMe7BYY=;
X-ME-Sender: <xms:3vC_ah-_MsAr4OKg29ZN_OV6sYm9ol6dWkXKn5-ZkyNvzb9raQK1EA>
    <xme:3vC_askgEpsnoV4AtcIiCRskaA_gxCoAmVOUM0jzLo5S71bPOjHWx7E-X_FknKrFO
    OXjGWlrfDqhD5azzvCff7F4o5bWoDroa3lj0pVjPXlBSCBq5Y4LTSg>
X-ME-Received: <xmr:3vC_anUei3p1m-4mtEJIB2z5bUYs7lB_uEl1H-NSbEHgYWgnpSc0svzyZkmHwqC7WsfaSIV-HKlklSTFubEZ6xAP-_70GfEHX7eF>
X-ME-Proxy-Cause: dmFkZTFn1RwRuVl9I3NjUpBcVe28KxQk7QukoSqfBUnnUJ1QjZk743kCaiaFAP2xKg1l9A
    WuvsqQPLzpSnEtPgNiAd0WRr5djFZZcVgnZtcioqGNota2k75Z7o3nKhBS9svVE+lc1G5m
    6007lyCA4ukanc11uA3TXBFhFhGR844KvBF/2q7PtjNwVJrY5CwDsforrajZAxp41XdlHx
    qxhwa/13P1bxoAU070DBM7Hfm+IkSjE0r6EeXs078g26lsZPI+PosI2GGltZ0wTArOPQwX
    N8wqt42W5imGqVcvwN3F7XMiAWGbQ3Vp4bC2GSsISlQtJEUvr3v4uSsRQ7nm9wdHIt/jW+
    U19w0YgJ1TlznudZBdyx8Qusq1VRvstsxrK7AuNVjTZBNpffAQW0RZboJgWczwz8qGFR+q
    c6tRTyx4kwZPfmyV5+pnWy7KlqTl/ItvKnjBf5cPgAe08S0shMUh++kGohPjCgdo9mCNJr
    x81VRfomG1QEpW+py04t5nuusjUlvaIa2ziDX/57Kl4+jnx2YkbfR/16GBxHcxSHSmrEqY
    ozyBoM0s8rpkOZIgWB6BSI6ZWUyn3oRMeh/KI+f1CZNjF0BfXR5DnaQ/dq14IdKWkCASIC
    sEVF8ol7Uct5StfUwYEJ+y2qBrA1Y8ghtDjP1uAi0BWbI6TugEIP3T05ThNw
X-ME-Proxy: <xmx:3vC_ahFAFjr0txhqt0KSh3CjGyUuv4OtB8GpCi9yBT8KmSqnjDn_EQ>
    <xmx:3vC_ajdKyrs9bso_T03Dd7AMtDxh_M9w5XV6rYAT6FBqR67T9-FQuQ>
    <xmx:3vC_aiJdf9T8Oy9B-ewbIi0f7ur3dmShAwfoEz1gfOYHd1BNRN_xDg>
    <xmx:3vC_aoF7eJXN-GHFH5gCLNKglqoLi69cBm1NKha0zX90bWHR6mb4Yg>
    <xmx:3_C_aoUBzkr-ObX8Ocvg-icabq-echxm3kTll3odVHD5QdqUTnAwqR6R>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 2 Oct 2026 13:58:54 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Julia Evans" <julia@jvns.ca>
Cc: "Patrick Steinhardt" <ps@pks.im>,  "Julia Evans"
 <gitgitgadget@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH 1/7] [doc] Add new gitmergeconflicts man page
In-Reply-To: <xmqqqzia8ohv.fsf@gitster.g> (Junio C. Hamano's message of "Wed,
	30 Sep 2026 13:37:16 -0700")
References: <pull.2237.git.1790261062.gitgitgadget@gmail.com>
	<ad4853dc36cdb883c9a8dc6bda747a5ea318e7a8.1790261062.git.gitgitgadget@gmail.com>
	<ar0MVRV5X8zgZfLy@pks.im>
	<5ba2088c-4919-465f-8892-4ed0685f81ea@app.fastmail.com>
	<xmqqqzia8ohv.fsf@gitster.g>
Date: Fri, 02 Oct 2026 10:58:53 -0700
Message-ID: <xmqqbj9cvvaa.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

>>>> +FRUITS = [
>>>> +    "apple",
>>>> +<<<<<<< HEAD
>>>> +    "cherry",
>>>> +=======
>>>> +    "banana",
>>>> +>>>>>>> add-fruit
>
>> Every time I show people diff3 someone tells me how happy they
>> are to learn it :)
>
> Yes, we should encourage "merge.conflictstyle=diff3" (I feel about
> this strongly enough to think it should become the default).
> Knowing what the original was before one side wanted to say "cherry"
> while the other side wanted to say "banana" sometimes helps a great
> deal to decide what to do with the conflict.

Before I forget, here is a good illustration to tell why diff3 style
is often essential to correct conflict resolution that we can tell
new users.  You may want to throw it in to your new manual pages.

If the conflict looks like this

        FRUITS = [       
            "apple",     
        <<<<<<< HEAD     
            "cherry",    
	|||||||
        =======          
            "banana",    
        >>>>>>> add-fruit

then we can tell that in the beginning there was only 'apple', and
one side wanted to add 'cherry', while the other side wanted to add
'banana'.  It is likely that we would make both sides happy by
adding both of them.

But on the other hand, if the conflict looks like this

        FRUITS = [       
            "apple",     
        <<<<<<< HEAD     
            "cherry",    
	|||||||
	    "banana",
	    "cherry",
        =======          
            "banana",    
        >>>>>>> add-fruit

we can tell that before two sides started editing, we had 'apple',
'banana', and 'cherry'.  While both wanted to keep 'apple', one side
did not want 'banana', and the other side did not want 'cherry'.  It
is plausible that we can please both of them by removing these two.

With just two-sides, the user who is trying to resolve the conflict
cannot tell the difference.
