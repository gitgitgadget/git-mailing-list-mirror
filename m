Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 100685EE6F
	for <git@vger.kernel.org>; Tue, 13 Feb 2024 15:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707839304; cv=none; b=dPXJ8t+XIkm1SijuablV2dcr1eXwz1aGo7PsC+QYKVVVK0YYhF2ws/HnqH4LeHgWeIo2T+zjDM0Y1aTWZJW8AGSfD+eoswpe3WEqJ1lj6yHGdEzetRemqojyTjNnrvvfOt8v7ecBSz4TaVb/IdDM1WEaD5jlz5NG2ur1AQi85sY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707839304; c=relaxed/simple;
	bh=QmZOAPAEYZvyjdsd5CmS8jaeg7cyF9R9NPc6aTlNH6o=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZMFJcdmyj/6rxwawAC7YH0PghXHFVySqNkvNk3+1rTy4lvuHQAltsrv6Zvl75NEYqw1unPf+FWaJ/mZuE2k+9A/XmrURHeQ/mrsWzdWIiPrd5vYNSMl117K0/Ej6EvVnPITwTXk7Hw7P/mwBKevSVkb6g07jHTPlt/bTQdPj5Sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PKDPW9Oo; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PKDPW9Oo"
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-59d84559ffdso95529eaf.0
        for <git@vger.kernel.org>; Tue, 13 Feb 2024 07:48:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707839302; x=1708444102; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=+UQi9i3TzEj+zvVXkECB0ksNhHpa4nVspayTyuaNyqk=;
        b=PKDPW9Ooxi1HwDeORrJFk9MFoK1TkA5KmOiCgn7ZUuKFq3ZrBROnzdHePa954C8kDN
         E/EsWj9GHu4o5QtJGZxWp1inHPFyiTM3xCWpfwH3EY1VnKbM+7UHKmqoOz7JUQ5XU3PH
         TR4N0jl86JP6/Qb0oKWIvvoeed5U245pcmpaF0SFERTRmbv5TgrHfvZGy3TfFDKzSw/F
         mK9cyq19vb3NiWgEPzRmWq1JUChrsIpBqZUXogWesi/y4qX6l4xZaAkSN+fHg51io9Av
         QNDdYX2+9DjXKeIt9iY2YSgqqlUGZP+r84BwLKcsW8tiYs5wSaPLsP+NRNbIAtJaZfpN
         UvOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707839302; x=1708444102;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+UQi9i3TzEj+zvVXkECB0ksNhHpa4nVspayTyuaNyqk=;
        b=RYVdU01QhGMgpaYAl6fFxCz6NtA/bHqoFm7/o3O8eRRGIRz5CAy4GDaCg9H4uRvZ2O
         BdrEF3Rv4/VYNY9+jYGcYm5PNFiWeh2uEkGQ26QPqr+rN16Kr15IGt2Zmd/N1tjIAA2Y
         TQOELOHsaagy9OmHH89InXWDBuhm2rWjF4oBiqVqfzgHS/S3dy2TQ1Y4dX1ekzzgJuKn
         sqqn+T28hpq9pq/qDQETRW2yUK+9Zu6jRZ5lUqIQ5/NyzWML/jrnFJ0IRfUwvmgEtqfB
         7Ekf6Yronnv0dTq7+mV8h9H0cHp7rLGJU0TTg7dgnTiMb0nba6MPxl05yLzx1HMpCwb/
         3zDg==
X-Gm-Message-State: AOJu0YwUMjp4lmkGc16zhMaMhwdXVpqqMOEdImN8DqEGyR7BW1kSI72c
	FmZhQt3MV7V1lrK9r5EG31+tJo5TynTwxfKkTNSwKxMCHCRAFax0yqHvLITel+ohm1wqap5nVdz
	RXmb4DHVklHArbnqh0ZbQ+aXV+QY=
X-Google-Smtp-Source: AGHT+IFqqlGXjzrh+L5O220MA9H2qcfHW1TkLplgrXcUq5bV+IhMQoA1/nyy2+Rs+kjoSbIwtCn6pD7MDjkYJzU97AY=
X-Received: by 2002:a05:6870:ecac:b0:219:30b9:fc22 with SMTP id
 eo44-20020a056870ecac00b0021930b9fc22mr12284039oab.25.1707839301841; Tue, 13
 Feb 2024 07:48:21 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 13 Feb 2024 07:48:20 -0800
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <ZcoTbRxIaGmTd4fJ@tanuki>
References: <20240119142705.139374-1-karthik.188@gmail.com>
 <20240211183923.131278-1-karthik.188@gmail.com> <20240211183923.131278-2-karthik.188@gmail.com>
 <ZcoTbRxIaGmTd4fJ@tanuki>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 13 Feb 2024 07:48:20 -0800
Message-ID: <CAOLa=ZSQMqhBbOUtiqRbS+ftmB=C8wn8N7pcsC0izVXLsSCQsw@mail.gmail.com>
Subject: Re: [PATCH v4 1/5] refs: introduce `is_pseudoref()` and `is_headref()`
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, gitster@pobox.com, phillip.wood123@gmail.com, 
	Jeff King <peff@peff.net>
Content-Type: multipart/mixed; boundary="000000000000eba189061145523b"

--000000000000eba189061145523b
Content-Type: text/plain; charset="UTF-8"

Hello,

Patrick Steinhardt <ps@pks.im> writes:
>> +
>> +int is_headref(struct ref_store *refs, const char *refname)
>> +{
>> +	if (!strcmp(refname, "HEAD"))
>> +		return refs_ref_exists(refs, refname);
>> +
>> +	return 0;
>> +}
>
> The same comment applies here, as well.
>
> I also worry a bit about the API we have. It becomes really hard to
> figure out which function to call now as the API surface seems to
> explode. We have:
>
>   - is_pseudoref_syntax
>   - is_pseudoref
>   - is_headref
>   - check_refname_format
>   - refname_is_safe
>

I also found `is_head()` in 'reflog.c'.

> I wonder whether we can maybe consolidate the interface into one or
> maybe even two functions where the behaviour can be tweaked with a flag
> field.
>

You do bring up an interesting point about the APIs present and I agree
that it would be best to consolidate them to something much simpler and
nicer.

> Something like `refname_is_valid()` with a bunch of flags:
>
>   - REFNAME_ACCEPT_HEAD to accept "HEAD"
>   - REFNAME_ACCEPT_PSEUDOREF to accept all of the refs ending with
>     "_HEAD" or being one of the irregular pseudorefs.
>   - REFNAME_ACCEPT_INVALID_BUT_SAFE to accept refnames which aren't
>     valid, but which would pass `refname_is_safe()`.
>
> Another alternative could be something like `classify_refname()` that
> accepts a refname and returns an enum saying what kind of ref something
> is.
>
> Given that this topic won't be included in Git v2.44 anymore, I think
> that opening this can of worms would be sensible now.
>

Over the two I do prefer something like the former method of the callee
using flags to state the requirements, this way the function only does
what is necessary between the listed operations.

Junio C Hamano <gitster@pobox.com> writes:
> Patrick Steinhardt <ps@pks.im> writes:
>
>> I think it's quite confusing that `is_pseudoref()` not only checks
>> whether the refname may be a pseudoref, but also whether it actually
>> exists. Furthermore, why is a pseudoref only considered to exist in case
>> it's not a symbolic ref? That sounds overly restrictive to me.
>
> I am torn on this, but in favor of the proposed naming, primarily
> because is_pseudoref_syntax() was about "does this string look like
> the fullref a pseudoref would have?", and the reason why we wanted
> to have this new function was we wanted to ask "does this string
> name a valid pseudoref?"
>
>  Q: Is CHERRY_PICK_HEAD a pseudoref?
>  A: It would have been if it existed, but I see only
>     $GIT_DIR/CHERRY_PICK_HEAD that is a symbolic link, and it cannot
>     be a pseudoref.
>
> I can certainly see a broken out set of helper functions to check
>
>  - Does this string make a good fullref for a pseudoref?
>  - Does a pseudoref with his string as its fullref exist?
>
> independently.  The first one would answer Yes and the second one
> would answer No in such a context.
>

This does work into the flags based mechanism that Patrick mentioned
too. The users of this new function can then only request information as
necessary.

Junio C Hamano <gitster@pobox.com> writes:

> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> +	if (ends_with(refname, "_HEAD")) {
>> +		refs_resolve_ref_unsafe(refs, refname,
>> +   					RESOLVE_REF_READING | RESOLVE_REF_NO_RECURSE,
>> +   					&oid, NULL);
>> +   		return !is_null_oid(&oid);
>> +	}
>
> FYI. I see
>
> .git/rebase-apply/patch:31: space before tab in indent.
>    					RESOLVE_REF_READING | RESOLVE_REF_NO_RECURSE,
> .git/rebase-apply/patch:32: space before tab in indent.
>    					&oid, NULL);
> .git/rebase-apply/patch:33: space before tab in indent.
>    		return !is_null_oid(&oid);
>
> around here.

Thanks for notifying, Jeff mentioned the same and I thought I fixed it.
I'll have a look at why my editor did this and add some steps to avoid
this in the following patches.

--000000000000eba189061145523b
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 2b8a2998cc9f72a4_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1YTGowSVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNVVWQy80eXhFWWtSMU9abTZUMmJyTjBoR3doek5mOAorVDh1N1o3TUtK
eXZsRThsSGJHUWdwZjhEd01BQUNPUHNLT0NuVmV1dURSM2ZRRTBjNnVpbG5DYzU0Yk5WOFpECkl2
c2FNbVcvWXVMdEIwRlhHcnUySktLWnZ4ME80QlNJK1cydTNxS1lnZUJ6cG52eDJiK1lJZ2l5OXkw
QmxpVUgKclpNK0xLYzNUWW1vTzR4dVNkdVhMK0hXejBKNlExV053Ni92Vi9nUFR6UW4xRWFMbklD
TnEvR2VGNWtGRG1KMQovTlZoSy94ZGVPYlVyaVFpMDhac2lRRG5OckpTYzBlb0w4UVVqeTBEbURv
NnFnOVRYMVkzWkZWdnRVUXBNaWdPClhqS0tva3JKQWNWeGtNZjJ0T1M0TkpTZlVnMzJuS292R09i
b3JtT05CakVjWHAwUDNLck1qS0dyQkFqbjc3SzAKM0NLc3VSZ0RGUThTTEEwcFQzSjgxZmJkU1Zs
QStuUWRicTg4Zi9TVDdZdGxtdi9zc1VvZFVOWHltdFZuUitqegptbTZjUzZOVUE1cWZYamU1cG5V
YmkrNDdvcWxRM21ZRmFNbmxmWjNEejZlVWZZWlBORytHMWZ4SS9JYzNEMmxzClJkd3lidVMzY0VH
dHl3bkVSNVBleG5TVzhRRzJyM0tnWFRVRGtVST0KPUEvOTkKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000eba189061145523b--
