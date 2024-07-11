Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2237E1552E7
	for <git@vger.kernel.org>; Thu, 11 Jul 2024 09:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720690512; cv=none; b=eqLJD8cmXFFOgzt1HTLzyxMV20YJtJr1RT+JYrR3pUGKyttLrvqw62Bs1Lee2G1mvVJZYg480uqrQT3Jy0cVhjEZflxyyqDiUCj0H20KxZr6DKgPenRN74BYN1JmWeDtMUVhDJ5NjaXTJ/11JBlMkE7NgpOl8RrZgHh2AwRbQK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720690512; c=relaxed/simple;
	bh=l3lORvygJA+iZ4RgFURIwcnst4AptY2zAPzSNnak6VQ=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cHfzIN9dFJJQ2F8YIO9NbCF+aiaiJ1FuHIMKMebVNugUxUy4R+itv2IUS7d2e+hpCka5gWB4yhc2gStwVjSFHzMv/rcGh6m/1pp+bKOLk/enoF7DKv2m3oVjFW9h3Grdm05Svjddn8QPLfkqZGUJVMVrMch2amUAJkoZJON/cS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LM37wIRM; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LM37wIRM"
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-25cba5eea69so326892fac.2
        for <git@vger.kernel.org>; Thu, 11 Jul 2024 02:35:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720690510; x=1721295310; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=KdVKK9CzchpKJBdO+F4Q89hw2FryHdyoDiO/CnXVIHk=;
        b=LM37wIRMeMzhgerzNYndGoK7rPHyXsb9VxbpTiXpMvfO6S1XI1S117y/C9yli6h5XG
         pt9zyUgFQ1FtZafzCcOx7N8jFktNcIqH4RWtN4yygsT+LhGgn8O3ZXOOAMcCnuPVH/jU
         peI8HPkTuMVHDLtkvQBJHVH9/wvLag9E1QRUifPOW7t87p3cK4vhfO/PX65jTghu2B2o
         iGDNQ9yLuAaiR/XDsM1Eq4tWPZpT4YVqdl5XymhxrI+SsuQHSOVftUsWBViux9r7uL5r
         vEwP+kjvfSoGJ0Rm6iM+1VpOsY81+LUzF029kOeMzSe6dw2lCT/QAGnzBb5Hf3I5tWyN
         Xatw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720690510; x=1721295310;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KdVKK9CzchpKJBdO+F4Q89hw2FryHdyoDiO/CnXVIHk=;
        b=UhLnq9ouh74zyXY5wuUyv3/ucwbSym05gKfznSj178jtNwEodTXymoHCPKEqebKy8l
         JcEPZbh1V+6vjuxwUgiTS12KsymN6I+d+8s+m+eLw+Gceo196BPyj9zkYMv+8xlbFimS
         CkZNQGAfYz6ZR+zLf/scYOiEzMyqqDl+bxqw/obYRzapsY5IamuSMhGKytQrPL+Bcxdi
         91Z27lP7NczS1eLy1z/l2N5Jq7zv3Jn4i2uEqutzsoiI+zMkhcUHyRrDTEe66NesOV41
         94WDXNOm7iB7wpdoeSXHs6Bhaf/hF69oH5rVuHTkUFob/W5Gg1c+3x/BnsndkJj2U5ZW
         GM9A==
X-Forwarded-Encrypted: i=1; AJvYcCWVGcmU96qOiqU2e+vykNtuBPtIGM2Oxyac4oUsoLqXBrsVWfeUUEHa4xqutHWwP2/Y9zd+WMnAinql7iEYElYVq3Jn
X-Gm-Message-State: AOJu0YxBIrJggKCoEnJ8vISbt6EnYHdg4aHtfFXSXYexteSJYr8P1HtY
	Y6O7iWDheAw2lxLSsz9LX9IPMxC7hOI37GXpqq3vdjUjZPyUEIiTI7w+unWL9DVo91ydA5SLBLt
	UHOujz8yp0pZmPL15zgzBhRwz70k=
X-Google-Smtp-Source: AGHT+IGXN6e/+JcYZR9khx47Nh1udBvVeNtBpxtex8bWYmAOKxC+rMhCT+OMKB6ghtesgSe1VehrCML5zmwq8Z7LVww=
X-Received: by 2002:a05:6870:9a0c:b0:254:a009:4c2f with SMTP id
 586e51a60fabf-25eaebdf9e8mr7078390fac.37.1720690510007; Thu, 11 Jul 2024
 02:35:10 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 11 Jul 2024 02:35:09 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20240710154620.GA3097664@coredump.intra.peff.net>
References: <20240708140350.622986-1-karthik.188@gmail.com>
 <20240709144931.1146528-1-karthik.188@gmail.com> <xmqq4j8yflrq.fsf@gitster.g>
 <CAOLa=ZQXZ6DyE3YjuVU48nQcj0xuW7uPoPvg2yqktk+S6gXwsg@mail.gmail.com> <20240710154620.GA3097664@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 11 Jul 2024 02:35:08 -0700
Message-ID: <CAOLa=ZT-psS1NecoppGOVdxgn+kMqi8qx2vCLMKNXB4n+5hE0A@mail.gmail.com>
Subject: Re: [PATCH v2] builtin/push: call set_refspecs after validating remote
To: Jeff King <peff@peff.net>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="0000000000009e3181061cf57a75"

--0000000000009e3181061cf57a75
Content-Type: text/plain; charset="UTF-8"

Jeff King <peff@peff.net> writes:

> On Wed, Jul 10, 2024 at 06:12:21AM -0700, Karthik Nayak wrote:
>
>> > In any case, an obvious additional fix on top of your change might
>> > be to do something like this:
>> >
>> >         diff --git i/remote.c w/remote.c
>> >         index 5fa046c8f8..d7f9ba3571 100644
>> >         --- i/remote.c
>> >         +++ w/remote.c
>> >         @@ -682,7 +682,7 @@ remotes_remote_get_1(
>> >                 struct remote *ret;
>> >                 int name_given = 0;
>> >
>> >         -	if (name)
>> >         +	if (name && *name)
>> >                         name_given = 1;
>> >                 else
>> >                         name = get_default(remote_state, remote_state->current_branch,
>> >
>> > which would give us the default remote name, and we would not call
>> > add_url_alias() with a bogus empty string to nuke the list.
>> >
>>
>> I'm a bit skeptical of making this change. Mostly from the user's
>> perspective.
>>
>> With my patch currently:
>>
>>     $ git push "" refs/heads/master
>>     fatal: bad repository ''
>>
>> But with this added, we'd be doing
>>
>>     $ git push "" refs/heads/master
>>     Everything up-to-date
>>
>> This is because we actually obtained the default remote here. Isn't this
>> confusing from a user's perspective? I mean I agree that an empty repo
>> name is something we should support, but it also shouldn't be something
>> we simply ignore?
>
> Oh, I misread Junio's patch in my earlier response. I was focused on not
> setting name_given, which I thought would result in a NULL return value,
> and didn't notice that it would also mean using the default remote.
> Something like:
>
> diff --git a/remote.c b/remote.c
> index 7f6406aaa2..883cf6086e 100644
> --- a/remote.c
> +++ b/remote.c
> @@ -703,7 +703,7 @@ remotes_remote_get_1(struct remote_state *remote_state, const char *name,
>  		if (!valid_remote(ret))
>  			read_branches_file(remote_state, ret);
>  	}
> -	if (name_given && !valid_remote(ret))
> +	if (name_given && *name && !valid_remote(ret))
>  		add_url_alias(remote_state, ret, name);
>  	if (!valid_remote(ret))
>  		return NULL;
>
> was more what I was thinking. That is, inhibit the empty string
> explicitly rather than letting the emergent behavior of add_url_alias()
> do it for us. Or maybe even just:
>
> diff --git a/remote.c b/remote.c
> index 7f6406aaa2..a0b166131f 100644
> --- a/remote.c
> +++ b/remote.c
> @@ -690,9 +690,11 @@ remotes_remote_get_1(struct remote_state *remote_state, const char *name,
>  	struct remote *ret;
>  	int name_given = 0;
>
> -	if (name)
> +	if (name) {
> +		if (!name)
> +			return NULL;
>  		name_given = 1;
> -	else
> +	} else
>  		name = get_default(remote_state, remote_state->current_branch,
>  				   &name_given);
>
>
> to bail immediately.
>
> But all of that would be internal refactoring / cleanup on top of your
> patch. The user-facing behavior would be the same.
>
> -Peff

These should work as intended on top of my patch. But I will skip doing
these changes for now. I do see the merit but I think it is also okay
the way it is now.

--0000000000009e3181061cf57a75
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 78c498e96ba5435c_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1hUHAwZ1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mOThLREFDYldGUTZZSlB2WUJTZ3JQZFBIWHhneWRVUQoxdFFXV2p5ZGM4
YWx6WTVML24rR0x0a3g5N3VoTVdkZmlQKytwWk9LTGhCcXRBOUllN2dudWc5TWtiWldBSGhhCndL
My9NRDQ2bE1IbjBQVEpMMTc5dXJZTUpFUW9SRkw5VHA3dUhHeHdwZ2ppTjlUczRTLzJYZnJvTHFX
bEt6d3UKbjhwNUhETXhrNWpxUUhjOCtVeVNjRTRkZVRjRklsRk1yNWM2RDhTSzNLeUZSVy9YSVg4
dWVuZkM4ZXlyTTVRRgplM0hJbzdLUWxlRG44S0NGQzhDdXRiNVFsQjVCaUo3d0h5NzNOa1JreFlz
aHFuSXdRbmhSZE5EMGlqRkNGYm5pClRacVU4OFVpaVhlRkoxZmhnQllpSjQrcVZ2M0w5a2I1dWpX
bEVad3kyekJYZ01qSUFKYnEwc0xxSnl3cU5ldEIKYTFxbmhaSlZRTFY0M2xKQmw1TXNhbnJyVlVn
YXJ3S3RMMjYxSDlCR3VhNFZXKy93OWcyTEEraCtheHFQcjJyZQo1SEd3eElleFdPTER3U01lT2Vq
MkJYdjQ1WmVJN3JFdHJmQThHRnJmcVhxWDNUeldUYzZrajhHaFFUUGFMY1BRCm5lV3FNYzhvWWMx
OG5DZXZjSGpiTXNNWVVFSkRBSXJCaU5rYVFUST0KPUVsOXkKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000009e3181061cf57a75--
