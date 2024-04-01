Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3279F56B89
	for <git@vger.kernel.org>; Mon,  1 Apr 2024 22:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712011040; cv=none; b=p6Q4b4KDcDaducFsFG2IOAbis5rrJJRu1NQsBfSy0L+CBSoNxYdFgvkOvlhWbbnilN2818GCpvtkV+vq/6VINYf1zoO/vAqgbYEi0wtJKoUsl/1DpW87KHib4tofc6CIm2CILSOyFeBLPuLEAunhZW017x2gdvLuBQdbmHGGR1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712011040; c=relaxed/simple;
	bh=JOI4JI9v7Y+wnk9E9RTUM/dF33ZU6gfne//COqMozLU=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O5yLcDezrn6qY3aZovluBL6rpcNC6FqlNrsMrWvc3rM0UGWfFLz6ckU0HsIf5i7jhpVWt66IweCTkOdpi6lY0Gr3+h183dK8brxL6/WQPEWIdwcDmsw2YyxshUagvgTAjNZL2Hcy1QQvpNALQkjvriYjjfekFF0euUYyxeDznKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J45AzqPh; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J45AzqPh"
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-229661f57cbso2600217fac.1
        for <git@vger.kernel.org>; Mon, 01 Apr 2024 15:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712011038; x=1712615838; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=J1dW/MZxJefl/u3K1TqNKtBX4wGxxx/eG10j3VkgXPA=;
        b=J45AzqPh3cv9j7Q/AlJ+jks/+hVmr7RVEBT5/Wvyt7iWzVGGkUHOUqxD0TYqLnaO8+
         Hch9s7PbQe/9vCmTOU/vlkJ57qS0oQWmIoNcQGRSSpWwhoGap/rR3ApAirdEEdp8rKRn
         OsJ//9xVWQYUfsOh8PgBbnr0qD0828hqL5L2TvpeSz/Z3exaU50vws1OiARgXIQU9OEz
         E7c1yltddD1hwp4/oZx9ho/mDeLkKGQHqd5j6gwKtU7t5RxmZWfP0xA9Z1wyeaRZW8Yu
         1+G0Ypi9F66UTLn+syNI48smc9iIqXJVkYQGq8I70Nuv+9s7HFaS+EpxdfMEhCKMiltz
         0wgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712011038; x=1712615838;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J1dW/MZxJefl/u3K1TqNKtBX4wGxxx/eG10j3VkgXPA=;
        b=dWpOVXQT+Mmrpxbx/C7kpab42vquDH80RzG/jwGV5Ve3/efGLzlsprPWbH4YW3LIa4
         Xk3T8D5gFr6WPsRfek0wsCV6AiX9z+JmFRStR5Qi2SIRpOAZpdwKOvxvZGn1dzXbthvt
         i089OnJkSe7zNMZsje16ylPky4h90Ryy/wT1UAw9amLQ1F/4110mdNJhLivUVII2tCqX
         lpr8U0LpJzt5W6kUfecFsQT7s34fN+Pc0LxaEXQH7biOgpVMVk/ytYnsFpOxoBqF1z1m
         G2HtSGsFyUcO/aC6VSCVubFcY3u4RluMiCtxlXVxx/JbgKk/dg/nZmuaIO/VjuDsruV2
         fQTg==
X-Gm-Message-State: AOJu0YxyB5DHhkBMKxghmqIOTYjexJ662MGGFs5yZkK/SbnKqUvwC0Mi
	QNtmk1nNtQ6c20iV1ZXo5lp+74ASXmhyya1GEKGKBjmNi1UiIHXv3Bqxj78JZqCAMlXKLBaZsqI
	15KqAkEZVq2qAT7ShnRFfvVP0uymcXgJg
X-Google-Smtp-Source: AGHT+IHBQmdBIYkuhmNLEANZ/hsu8nmib9jDjrp1zueVUyVF5/ToBxQEt6AtrAksjOTvHew++z2GtLYBax4tBuw8h50=
X-Received: by 2002:a05:6870:b6a6:b0:22d:f836:4d4a with SMTP id
 cy38-20020a056870b6a600b0022df8364d4amr12153523oab.37.1712011038089; Mon, 01
 Apr 2024 15:37:18 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 1 Apr 2024 15:37:17 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <xmqqv851awgq.fsf@gitster.g>
References: <20240330224623.579457-1-knayak@gitlab.com> <20240330224623.579457-8-knayak@gitlab.com>
 <xmqqy19yf40l.fsf@gitster.g> <CAOLa=ZTLv39b4Q=AAUA39tXKgOSuu54xk3-r9OUenzxR-6qcag@mail.gmail.com>
 <xmqqv851awgq.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 1 Apr 2024 15:37:17 -0700
Message-ID: <CAOLa=ZSo7ngBUxkfR+EEojhr4a-mM+3=f-P1H36hnhJukEqGVA@mail.gmail.com>
Subject: Re: [PATCH 7/8] refs: add 'update-symref' command to 'update-ref'
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, ps@pks.im
Content-Type: multipart/mixed; boundary="000000000000c7039e061510a124"

--000000000000c7039e061510a124
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> Karthik Nayak <karthik.188@gmail.com> writes:
>
>>> So perhaps we can say "update with a concrete <old-oid> will ensure
>>> that the <ref> poitns at <old-oid> before proceeding, but update
>>> with 0{40} as <old-oid> to ensure creation is deprecated.  update
>>> with 0{40} as <new-oid> as deletion is also deprecated.  Use create
>>> and delete for these two deprecated operation modes".
>>>
>>> This assumes that create and delete currently ensures that what is
>>> asked to be created does not exist, and what is asked to be deleted
>>> does exist, before the operation.  If we are loosely doing these two
>>> operations, then we cannot easily deprecate the checking-update,
>>> without breaking existing users.
>
> Note that I did not (and do not) know if "create" and "delete" have
> such checks; I expected somebody (other than me) to check before
> going forward.
>

create does:

$ git update-ref --stdin
create refs/heads/a 53eb33454ce4f3db4d8c79e9c15640c2dffc4a37
fatal: cannot lock ref 'refs/heads/a': reference already exists

delete doesn't:

$ git update-ref --stdin
delete refs/heads/b
% echo $?
0
$ ls .git/refs/heads/
a  master

>> But this still means we need to think of the best output for the
>> reference transaction hook (following commit).
>>
>> My current implementation of:
>>    <symref-target> SP <ref-name> LF
>> Should be changed to:
>>    <old-ref> SP <new-ref> LF
>>
>> But this means, for creation of symrefs <old-ref> needs to be "zero"
>> value. Also there is no way for clients to differentiate between regular
>> refs and symrefs here. I wonder if it makes sense to do something like:
>>
>>    symref SP <old-ref> SP <new-ref> LF
>
> What do clients see for a regular ref?  "<old-oid> SP <new-oid> LF"?
> That would be OK, as "symref" cannot be an object name, I guess?
>

<old-value> SP <new-value> SP <ref-name> LF

Yeah, 'symref' should work.

>> Where symref is a fixed string at the start, used as a differentiator.
>> This however still would leave us to deal with "zero" values for
>> creation and deletion.
>
> Are these two <old-ref> and <new-ref> values optional in the context
> of your discussion?  The review comment was on input from the end-user
> that made it optional to validate the precondition, but this is what
> you produce as a result---if these are not optional, then an empty
> string can be a reasonable "zero" value.  I am confused...
>> Perhaps the best way here to actually be a lot more verbose and have the
>> hook output the following:
>>
>>    symref-create SP <new-ref> LF
>>    symref-delete SP <old-ref> LF
>>    symref-update SP <old-ref> SP <new-ref> LF
>>    symref-update-forced <new-ref> LF
>
> It is unfortunate that the input to the hook for a normal reference
> update uses syntax different from the "--stdin" input format, i.e.,
>
>     <old-oid> SP <new-oid> SP <ref> LF
>
> but it is way too late to change it now.  So to be consistent,
>
>     symref-create SP <new-ref> SP <ref> LF
>     symref-delete SP <old-ref> SP <ref> LF
>     symref-update SP <old-ref> SP <new-ref> SP <ref> LF
>
> would be the three operations.
>
> But this is not an end-user input that tells Git "I do not care
> about precondition, I did not even bother to learn the current state
> to give you as <old-something>, just force it".  The input to hook
> is what we tell the hook what we are planning to do (so that it can
> decline), and we do not need the ability to say "I do not know what
> the current state is".  So I do not think you need any "zero" value
> in the input to the reference-transaction hook.  And I do not see a
> need for the "symref-update-forced" variant, either.

... also from your latest email ...

>> But this is not an end-user input that tells Git "I do not care
>> about precondition, I did not even bother to learn the current state
>> to give you as <old-something>, just force it".  The input to hook
>> is what we tell the hook what we are planning to do (so that it can
>> decline), and we do not need the ability to say "I do not know what
>> the current state is".  So I do not think you need any "zero" value
>> in the input to the reference-transaction hook.  And I do not see a
>> need for the "symref-update-forced" variant, either.
>
> I misspoke here.  We do need "zero" value to indicate that "this
> update is a creation event" and "this update is a deletion event".
> What I meant to say is that there is no need to make the "zero"
> value distinguishable from a "missing optional" value, which was a
> problem on the "--stdin" side with "-z" format, where each command
> is in a format with fixed number of parameters, unlike the textual
> format, where a missing optional argument can be expressed by
> omitting SP before the value and the value itself and it can be
> differentiated from an empty string as an optional value that is not
> missing.
>
> Thanks.

Yup. There is a slight subtlety here though, currently with the
reference-transaction hook:

    When force updating the reference regardless of its current value or
    when the reference is to be created anew, <old-value> is the
    all-zeroes object name. To distinguish these cases, you can inspect
    the current value of <ref-name> via git rev-parse.

I'll keep the same behavior with the symref updates.

> By the way, if we were to use symref-{create,delete,update} here,
> wouldn't it make more sense to name the command on the "--stdin"
> side the same, i.e., not "update-symref" but "symref-update"?

If we were to use symref-*, definitely.

> What I suspect that needs more thought is what should happen when
> you request via "--stdin" to create, update, or delete a symref,
> but <ref> is a regular ref, e.g., "symref-delete <ref>".  For
> "symref-create <ref> <new-ref>", we would fail if <ref> exists,
> whether it is a symref or a normal ref, so that is OK.  For
> "symref-delete <ref> <old-ref>", we would fail if <ref> is *not*
> a symref to <old-ref>, so the case where <ref> is a normal ref
> is already covered.
>
> Should we support "symref-update <ref> <new-ref> <old-oid>" that
> makes <ref> a symref that points at <new-ref>, but ensures that
> <ref> before the operation is a normal ref that points at <old-oid>?
>
> Or should "symref-update" work only on <ref> that is an existing
> symref?
>
> I think I am OK if the answer was "You can only give a precondition
> in the form of <old-ref>, which means you can only turn an existing
> symref to point at a different ref with precondition protection. If
> you want to turn a normal ref into a symref, you have to force it by
> not having a precondition, or delete the ref and then (re)create it
> as a symref".  But we need to decide the semantics and document it.

I would think that doing what you mentioned in the last para to be the
way to go, unless someone thinks otherwise. This allows the ugly mess of
parsing an value as a ref and then as a oid and provides some structure
to what the input cases are.

One more case I'd add is that the <ref> argument for "symref-delete"
should be optional, similar to having forced update, we'd also want to
support forced deletion.

> Junio C Hamano <gitster@pobox.com> writes:
>
>>> But this still means we need to think of the best output for the
>>> reference transaction hook (following commit).
>>> ...
>
> One thing I missed.  We are not currently reporting symref updates
> to these hooks.  Are they prepared to take such extra input?  If not,
> are they going to barf when they see "symref-update" while expecting
> to see <old-oid>?
>
> We may need to make it possible for Git to tell which variant of the
> hook script it was given somehow (the easiest cop-out is to introduce
> ref-transaction-hook-v2 as a separate hook, and use it if exists, or
> fall back to the reference-transaction hook, and report symref updates
> only when we are using v2, but there may be better approaches).
>

Well I was hoping this is okay since reference-transaction and
update-ref never supported symrefs. So after this change:
1. If a user never updates the hook to support symrefs, but doesn't use
symref feature of update-ref, they would be fine.
2. If a user starts using symref features of update-ref, they would see
that reference transaction needs to be updated too.

This especially since the hook's documentation always claimed that
symref support might be added in the future.

   The hook does not cover symbolic references (but that may change in
   the future).

---

In summary the plan going forward from my side would be to:

Implement the following in update-ref:

    symref-create SP <ref> SP <new-ref> LF
    symref-update SP <ref> SP <new-ref> [SP <old-ref>] LF
    symref-delete SP <ref> [SP <old-ref>] LF
    symref-verify SP <ref> [SP <old-ref>] LF

Also on the reference transaction hook, we'll be adding the following
new inputs to the hook:

    symref-create SP <new-ref> SP <ref> LF
    symref-delete SP <old-ref> SP <ref> LF
    symref-update SP <old-ref> SP <new-ref> SP <ref> LF

This either will be added to the existing hook or we would support a new
hook (v2).

--000000000000c7039e061510a124
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 153aea735e808587_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1ZTE54b1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1meEVJREFDa1lGRDEybk9xUCtyU2dmREMzanJRUUVZdgpzM2F3Vkp2UkxX
R3k1azQ0eExyeDRIaG9nbTM3RW93SXRKZVJxVzNqTHRtWURJYmZKeE9aci9GdURvdEFzUzlnCjZh
aEc4QXpzeTVlb2oxSHNlV2JsZDRRaFY4Qi9jU1AzN2h4eTc1dWl5Nk9mQU02aU5DNHNCb1p1Q0t4
UURIc1kKOWN6aUpZTTNQeHNtRWFEc0RHWmxZajNxYysxMW1FVm95ZXVPS1IwbmQxMU41K2FBNWpO
aEY3WXRDQUk2T3A4VgpseERIL282bmlLR0NzUnBFN0lXa3FQUVBtblZpaFBVcHJyME9kYjBmdlU0
eTB5M0tiQWE2eGovdi8rbG1kMXhzCksxUlZzdWt1bW13MGloUjhpR2lGUTR0Z1NWMG55TU16d3ZJ
eTRXMVQvcCszbGJ1SWVOZWhVZytuSk8xOGI2aFUKSkpYZEZ0dUh3ZlFOc3NwY0k1a1p2SVFxMFdE
VFQ3cEMvL0hJZEdMSzN6UUVEVS9LbzNhQVRnK0o4dWZjQ0dROQplK0t4dW9GemZtWEUzV2Q5SUEx
SGM0dStJWjBpOEI0bVFVWFBoRVo0dzBvWWVYZkNnbWozQ1ZNOFdjaFF5K0VUCitIcEovdFRIZkdD
MHVwOXc0eno0Tmljdi91TmFKSVFRdGtjeGIyST0KPTJ5RXUKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000c7039e061510a124--
