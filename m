Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com [209.85.222.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08D661A9F84
	for <git@vger.kernel.org>; Sat, 15 Nov 2025 22:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763244993; cv=none; b=C90R1u6Dd2/cKERhqK2Osr4FHcVdOzmzMnLAfJ8Tllpm+FTqFfwYyDXIykJ2nIIA2R4MxLsV/MvzqCo4Mj3++lEl6DX3RqFucOaEOtEjDJnbhYTQ6mAujJZnB8CPvXF0b4FAZF4Be/snyzgPF4sY1PD492VmgeMyyb5NdyZVL2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763244993; c=relaxed/simple;
	bh=kEIQUjeJXYkqNkiwDB0kVR3piIaYe9SSkkviiBkjTWk=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lbsGStyFzO1ctYnpOa3lh4Jp2vJXawG76x4/fOHXkUt6LvQWs5URN0fGk22jKx8irw203zMP+b9y1kqE6SiNuwnGOUr3e+KZXQlr3zz6Gr5mAo5ieyeSYh+9vWppX05JL+o8OSlLvaP0aYAcolBr9/pUIdt1++yNqHysdJ+M0TU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DhZQcN5Y; arc=none smtp.client-ip=209.85.222.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DhZQcN5Y"
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-9372634aca2so929062241.2
        for <git@vger.kernel.org>; Sat, 15 Nov 2025 14:16:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763244991; x=1763849791; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=s7sq4plfQyQEW5lecHzkNyX6O5pDYU/LvJLhNFQoESg=;
        b=DhZQcN5Y7M4Si/Ng4b5jfEDgvLHo/tM/c3PW9ClXZYZTLI/nBk6cXeTjEvkY/dyCm1
         Zwrd0EBnl4AtIXhdmW/ijYxGbGfqJ59ryhhk6VUEHFKTi4uIwG0Rmuwwlz7g2aKCRCZz
         naVEbF3VBqPwD71qj5XqnEXJtsXIjrptarqrd2QhQgX6H/aVBK7oPB5AvycUPzHHRUij
         f+rwuP/TuWSSuTjJ7+0KW26meb2maz6EAKcZjmOQa/7ikSd2mLGJAxMrjsHGYgk+YdcZ
         vpG22Hi9VA+53Vv8KPOSX/LrkJZ2uHAYwt4bgbeEQ/ZBOqvcAqXKCiPFtMoccVaXEoMC
         4n5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763244991; x=1763849791;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s7sq4plfQyQEW5lecHzkNyX6O5pDYU/LvJLhNFQoESg=;
        b=BR3OgVWX7E07wlbKz4Z5yvGyAtUltFMrefz5pI+MlbO72kRGn94idZdl4eosspGno3
         qCde2BTKMFzAcyhuuF7yRv6CGZkjk4DpKnjMYZvfT34wREA2m2XE2150VxtokxTOQYHM
         YHioyvO1x5aGzUNFo5fuvDd/NpUu+FE0YB2ATB+g0VMDFJ9lmaDexuMm+7nJwJneMQX7
         jvTxTpXfm2UvpQ4qvKd6XfD5N9h2I+8NN2qs+nBErVT4zoK+UB7SL1ZrQLgZKrC8Ipjc
         F3dgUmjdrvuOMtzLxzEs5rDVUbnjafE3SjULddy5oPdGw8cMzwnY4BFKcEtDfdraf4y5
         6xbw==
X-Gm-Message-State: AOJu0YyNJMwUx4a6EhCgbPG4SbQBcBa2kpkOMEBGplaCk8UruwtoY/sw
	3cA4PA1PmiyIwrOb4nTtbgeK0xM7VHUe6dYKLdhJX3+mX/6jzb1sjKAD7jmFX+K/51FVFoyODlp
	tf4qI2NYE4mZ/H2q0m1HvSjIBx8zGML8=
X-Gm-Gg: ASbGncvTeGBtdpyGd89VzUkIyIxmadO3ikmqPOQW+ZkZenFMtaFrZobvh6VyOa+dnZR
	tCUfp+5ub0t4cyDgcWCv1Cbl60tPnUeGeVJTvGqr4v6IYCJs1U1UY9WBwIGzygVG4k7VkVU5TNy
	MPEdQaOU55mh5Sl7+rlJ8kqaoypDM9BsUysSMnASSRHsZBVhgoICacH3lPrzhmIoGfe2hVbvnHH
	DZUAEV606fn+boao4l1Z+k71jJtesJdSPUnarQ+nTGYrbbIoQ2aNQBZ3uo9KXCK5+kViVsON8jp
	WbK5DyXsplPA1z4q0S2gSm+bkg==
X-Google-Smtp-Source: AGHT+IFoomCdsSESiDYfc3Zub38Zo4Z8b7viJD9gfYfv/ed9qg6nx3eHUWSZfZodm9mgT+Bh2WuOLz7vffy5O0/GAIc=
X-Received: by 2002:a05:6102:424b:b0:5db:f710:497e with SMTP id
 ada2fe7eead31-5dfc5b70395mr2639841137.21.1763244990842; Sat, 15 Nov 2025
 14:16:30 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 15 Nov 2025 22:16:28 +0000
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 15 Nov 2025 22:16:28 +0000
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <xmqq7bvtlj8v.fsf@gitster.g>
References: <20251113-fix-tags-not-fetching-v5-0-371ea7ec638d@gmail.com>
 <20251113-fix-tags-not-fetching-v5-2-371ea7ec638d@gmail.com> <xmqq7bvtlj8v.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sat, 15 Nov 2025 22:16:28 +0000
X-Gm-Features: AWmQ_bk-N6nEtLt3lPehOabgQXmD4JCv9w2CsrUf1zgWv8tuT4tw0KjcP2-XWpE
Message-ID: <CAOLa=ZT9wv8B7EKXJQvwR07bUT7Jx0nJSwGGyUZ8+GN3-xdRag@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] fetch: fix non-conflicting tags not being committed
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, jltobler@gmail.com, ps@pks.im, 
	David Bohman <debohman@gmail.com>
Content-Type: multipart/mixed; boundary="00000000000054e1c40643a97795"

--00000000000054e1c40643a97795
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> The cleanup section is reached with `retcode` set in several scenarios:
>>
>>    - `truncate_fetch_head()`, `open_fetch_head()` and `prune_refs()` set
>>      `retcode` before the transaction is created, so no commit is
>>      attempted.
>>
>>    - `fetch_and_consume_refs()` and `backfill_tags()` are the primary
>>      cases this fix targets, both setting a positive `retcode` to
>>      trigger the committing of the transaction.
>>
>> This simplifies error handling and ensures future modifications to
>> `do_fetch()` don't need special handling for batched updates.
>
> This may be sufficient to clean out the hanging transaction that the
> original code forgot to commit, but in scenarios where this change
> makes a difference, i.e., where the code does "goto cleanup" before
> it calls commit_ref_transaction() in the main flow of the code,
> there are things that are not performed that we may still want to
> perform.  Namely, we do not
>
>  - call commit_fetch_head()
>
>  - run set_upstream processing
>
>  - honor do_set_head flag that was left for remote that does not
>    have followremotehead=never
>
> but don't we want to do some of them at least?
>

Thanks for bringing this up. I would think we should do all of these,
but not if the '--atomic' flag is used. If the '--atomic' flag is used,
we shouldn't do anything else and simply skip to the end.

> If it turns out that we want to do all of them, I also wonder if the
> resulting code would become easier to follow if we lose the call to
> commit_ref_transaction() in the main code flow, do the above three
> points before committing the ref transaction, and then after the
> cleanup label, make a call to commit_ref_transaction() if we have an
> open transaction and we are not atomic (regardless of the value of
> retcode at that point).  That call may yield another retcode that
> the existing error reporting at the end of this function may have to
> react to.
>

The issue is with '--atomic' again. I could think of this small change
over this topic, which passes the fetch tests.

diff --git a/builtin/fetch.c b/builtin/fetch.c
index b19fa8e966..df11f59f56 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1890,7 +1890,7 @@ static int do_fetch(struct transport *transport,

 	retcode = commit_ref_transaction(&transaction, atomic_fetch,
 					 transport->remote->name, &err);
-	if (retcode)
+	if (retcode && atomic_fetch)
 		goto cleanup;

 	commit_fetch_head(&fetch_head);

I do wonder if we can cleanup this code, it is a bit messy right now.

That said, we could either append this change as a new commit with some
additional tests and re-roll the series or send it as a separate commit
based on this series. I'd prefer the latter so that we have the fix for
fetching tags merged sooner, but happy to do either.

[snip]

--00000000000054e1c40643a97795
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 539fd42fcbe95b80_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1rWSs3Z1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1meU5mQy9vQ1FKaGVuZFhxOUt6ckI0eU45VVN0K0lBZwpYZWtpTzRhK21n
Z2x6Y0hkcmU4VzFteE9nS2tuTjlxeFV5T0szNkM0V3F3MmVIbGR1T2JqbmczeUZYN0k1QnduCnd0
ZTRvKzF3Nmg4V1poZFFvTWVyS0RWd2lBK1RiTjRmTC83OFNFYlUvdnRsaDVYRHhsWFpxbWd4ZmJL
NkMwZkoKU2J3Z3dqTGlZMTVpR3BLNHlNMk5Jd2ZTcFkxYWxzSVhKTnFUK01TbjBXdGE3Q2x2enFR
QnhodXRWejlPR1czRwpUeXZYd2w0dmdTZmdYSHVzaUZvNlNQY1R5Wll5emNEOEhSYUpyZ0ROdXE1
Yitja21vK1ZYMlgzSVIwTWFPY2VqCjZycTU5WGZQNG5GajJVQ1llVnEyOWNRMll4a2QrRjRicDhL
bVFCM0RaVVZNbytNbkUvWDFaS0JmZlIrTGcxSHMKK2NJdzg3LzZUYk1idWpyVDl6akJZd2Eyc05a
aUVaeGpQSUFoSi9XSUlJVnNxYnVmOEU3UVdNZTBWV3NtR1E4QgpiK2RmMGZmUkFYR1JiQmIwRjJl
QmtuZ1pUVGZkMkk4T29KK3lDSVFuczU5RlExRFFXNHQwQnJkTFBpUXBPc2lzCm42QnlNWlFaZHpu
K0Z4eWFyQUFlTTJlVHREUkdXdGRCc0lIZDkvaz0KPU1ES3QKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--00000000000054e1c40643a97795--
