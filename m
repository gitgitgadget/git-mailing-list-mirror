Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1098A165FB6
	for <git@vger.kernel.org>; Thu, 18 Apr 2024 14:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713450349; cv=none; b=F4ir9oq3ZUpuQNMF90AQKiHIQu3UFwl+xlyDyYjUf+LBwXdKnVdDC2Goc/cniPe60qDtjtQZE3qeINBHmz47IJOTCrxPK9mmR+P3LMxwBi6UYG/xXrG0LVzhpZPuZrD4cW3zbjImH7QxKS0A4msVaEI7tM3yZK9IovuAd/tRJMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713450349; c=relaxed/simple;
	bh=f6v3bmB7yaAiSuUR3oP/scWsSSU/dnJiiTItd9LNBWw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=amuUTFsQPdcNEyEvVzMb7NER7Hnj5979JYVS1tO+1LCQYks7rQz06Glkc7QnPKYzazF4GV/A7W9l0U0S7ISg/2n8hBNbYOhT6hdTvuZ20JFS0EpDl5yGwoHCkN5sJlgfqdc/z995nsLnY8TeSMNmGG+SEb8Y5pJxIKBhrM/KbjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VUWLXnpW; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VUWLXnpW"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-571c301760cso329687a12.3
        for <git@vger.kernel.org>; Thu, 18 Apr 2024 07:25:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713450346; x=1714055146; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NOmHJojCfglAx4UG1CxAqwKTkz982xcpwfOP+pDk8w8=;
        b=VUWLXnpWeSRfg6LI7+CHlWFHHmnYyh0Jp7h1Buib+TnBBPxDGUTZrvKEPZywRoPhM2
         pdJcVdXVdeL53stkMcSoPXL5nwnBLclDI3GunlRA0k4YkvUsMzLpqCq7iLUcgN0h+/gl
         jbBXFRK1B2vDx6L8Tg7DLrSLA/GCCdx1KUxD+E/0EnIYB8y5/7V3AghW9j3dwKXMyPWz
         VguDi48Z8KToK7KAu9vYA5E7Hc/ZLC9SZQJeC5DOjJd1rUcu8a0OJ+O4U6n0xkzi2Gs/
         mkMGu0Zyhae3gw0ew14yOrGqtVlgiQ6lqgTGWWDAVxLN0nhMOT59fCnqsVQCg+6VCXoj
         F6Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713450346; x=1714055146;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NOmHJojCfglAx4UG1CxAqwKTkz982xcpwfOP+pDk8w8=;
        b=lFzFJEc0PmZOrTNxrdJ6aSt4ML1ocpvo9x8hEhr8oRefg3Mxwgqc3Nplhx5Z/iSAut
         YjGTN4Vio9A5Jqqp3X4mZJFfFn40hBTL4z6uQHfMUx71WbpQsZbqV6Jlv+6D9zu5U/bV
         WWuDcmHEGhNKCrtlcSvUZ6yQAYb1QHDXpzTBNFHEnjCsXFwE9rbNBzEpyNlIpvJOynGv
         AOagDGAmK4HKmHSwfrRgiKSHIZBN38E/X66NGiev9Vn7gSe6wBvCRi7li31rlOLpLgjZ
         Bf0LVFIdLSlyTP+dLkx2VQKZzRuyWwmVAMHz6by2Q59e2AVIAc6s6kedtkrA3pwBG2Wb
         UpZw==
X-Forwarded-Encrypted: i=1; AJvYcCUT/GhC0Pjk1MxzXsOwGzkQSUkWp9ggWyHo/CNkktD4yQDxYi14uqdPrQeFwM8WKWHOqfGGzTZupt2dxQ38QfRWq5Ko
X-Gm-Message-State: AOJu0Yz8S9VWY8oP0GBUKpeanmQF5sV19B/QHFCKTH8EOAkWDK7xdGFD
	VDy3ptLnE4XjpufrnayXKL962ObaLMyEvMTf/UWXfSkH0t2CMqA/vVzIZgezXFUngseSGZbFxym
	43HDr2zqsTmoFm4/rJFdxCcV99WI=
X-Google-Smtp-Source: AGHT+IERz2nEc2KHdESTllMjwhT6As12+QuaBsL+7mo2npKuutgFJ6TH+Uv6wa7YCsfSGpXYyvBKMHDLgP0wcFsWLow=
X-Received: by 2002:a50:9987:0:b0:56e:368c:b09d with SMTP id
 m7-20020a509987000000b0056e368cb09dmr1790761edb.24.1713450346009; Thu, 18 Apr
 2024 07:25:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240330224623.579457-1-knayak@gitlab.com> <20240412095908.1134387-1-knayak@gitlab.com>
 <20240412095908.1134387-2-knayak@gitlab.com>
In-Reply-To: <20240412095908.1134387-2-knayak@gitlab.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Thu, 18 Apr 2024 16:25:33 +0200
Message-ID: <CAP8UFD2s5GZBbZ_oKk6hFCQ+jtjRjx1QgRvLz+1hrBfkWKVCbw@mail.gmail.com>
Subject: Re: [PATCH v2 1/7] refs: accept symref values in `ref_transaction[_add]_update`
To: Karthik Nayak <karthik.188@gmail.com>
Cc: chris.torek@gmail.com, git@vger.kernel.org, gitster@pobox.com, ps@pks.im
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 12, 2024 at 11:59=E2=80=AFAM Karthik Nayak <karthik.188@gmail.c=
om> wrote:
>
> From: Karthik Nayak <karthik.188@gmail.com>
>
> The `ref_transaction[_add]_update` functions obtain ref information and
> flags to create a `ref_update` and add it to the transaction at hand.
>
> To extend symref support in transactions, we need to also accept the
> old and new ref values and process it. In this commit, let's add the
> required paramaters to the function and modify all call sites.

s/paramaters/parameters/

> The two paramaters added are `new_ref` and `old_ref`. The `new_ref` is

s/paramaters/parameters/

> used to denote what the reference should point to when the transaction
> is applied. Some functions allow this parameter to be NULL, meaning that
> the reference is not changed, or `""`, meaning that the reference should
> be deleted.

> The `old_ref` denotes the value of that the reference must have before

s/the value of that the reference/the value the reference/

> the update. Some functions allow this parameter to be NULL, meaning that
> the old value of the reference is not checked, or `""`, meaning that the
> reference must not exist before the update. A copy of this value is made
> in the transaction.
>
> The handling logic of these parameters will be added in consequent
> commits as we implement symref-{create, update, delete, verify}.
>
> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>

> diff --git a/refs.h b/refs.h
> index d278775e08..645fe9fdb8 100644
> --- a/refs.h
> +++ b/refs.h

There is the following big comment in this file:

/*
 * Reference transaction updates
 *
 * The following four functions add a reference check or update to a
 * ref_transaction.  They have some common similar parameters:
 *
 *     transaction -- a pointer to an open ref_transaction, obtained
 *         from ref_transaction_begin().
 *
 *     refname -- the name of the reference to be affected.
 *
 *     new_oid -- the object ID that should be set to be the new value
 *         of the reference. Some functions allow this parameter to be
 *         NULL, meaning that the reference is not changed, or
 *         null_oid, meaning that the reference should be deleted. A
 *         copy of this value is made in the transaction.
 *
 *     old_oid -- the object ID that the reference must have before
 *         the update. Some functions allow this parameter to be NULL,
 *         meaning that the old value of the reference is not checked,
 *         or null_oid, meaning that the reference must not exist
 *         before the update. A copy of this value is made in the
 *         transaction.
 *
 *     flags -- flags affecting the update, passed to
 *         update_ref_lock(). Possible flags: REF_NO_DEREF,
 *         REF_FORCE_CREATE_REFLOG. See those constants for more
 *         information.
 *
 *     msg -- a message describing the change (for the reflog).
 *
 *     err -- a strbuf for receiving a description of any error that
 *         might have occurred.
 *
 * The functions make internal copies of refname and msg, so the
 * caller retains ownership of these parameters.
 *
 * The functions return 0 on success and non-zero on failure. A
 * failure means that the transaction as a whole has failed and needs
 * to be rolled back.
 */

I would expect the patch to update this comment.

> @@ -722,6 +728,7 @@ int ref_transaction_update(struct ref_transaction *tr=
ansaction,
>                            const char *refname,
>                            const struct object_id *new_oid,
>                            const struct object_id *old_oid,
> +                          const char *new_ref, const char *old_ref,
>                            unsigned int flags, const char *msg,
>                            struct strbuf *err);

The patch might also want to update the comment just above the
ref_transaction_update() declaration as it is changing what the
function can (or will be able to) do.

> diff --git a/refs/refs-internal.h b/refs/refs-internal.h
> index 56641aa57a..4c5fe02687 100644
> --- a/refs/refs-internal.h
> +++ b/refs/refs-internal.h
> @@ -124,6 +124,19 @@ struct ref_update {
>          */
>         struct object_id old_oid;
>
> +       /*
> +        * If (flags & REF_SYMREF_UPDATE), set the reference to this
> +        * value (or delete it, if `new_ref` is an empty string).

What if this value is NULL?

> +        */
> +       const char *new_ref;
> +
> +       /*
> +        * If (type & REF_SYMREF_UPDATE), check that the reference
> +        * previously had this value (or didn't previously exist,
> +        * if `old_ref` is an empty string).

What if this value is NULL?


> +        */
> +       const char *old_ref;
> +
>         /*
>          * One or more of REF_NO_DEREF, REF_FORCE_CREATE_REFLOG,
>          * REF_HAVE_NEW, REF_HAVE_OLD, or backend-specific flags.
