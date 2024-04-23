Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 781F7612EB
	for <git@vger.kernel.org>; Tue, 23 Apr 2024 10:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713869536; cv=none; b=snQZnEuduY2dMzFcRXkwWnnRboF6I+UwByvQ2WevW+86KmcjcQ/pNzzhcqo4/LLwrmjsXXVgFUwdJCTYNYiMN5JI5rszyF+6ScnvyGsIACwy5PXgqOut9a06xSRaYPU5u5GpxdZgB01uG4TOt5VaDQeQH0EomM6R8V/ZyD/7kUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713869536; c=relaxed/simple;
	bh=GVVVa5kaHBt4t4/UIyU9KgrK4l1j0T0o4Zu4sP9MZDY=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HbjO08cXhQC1wGsoJKiBmeQ80toV3isUqBFBn7+7v5ZOR8Kc7C+Y8uymGYILGm0N8t5TGGxTF1ED85wIs3n3I8hBXaKvgVvtpnyZOWFxuk1vioZPqDa7+IcBltmq4V2gnyLj0SY59znbQTQPShRCuwzQAuIuSTf3DGuLy3/8Ib0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Oijgjuj5; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oijgjuj5"
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-22edec341c2so2670620fac.0
        for <git@vger.kernel.org>; Tue, 23 Apr 2024 03:52:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713869534; x=1714474334; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=xoZ1iDa30OXLjJzeQItJpNnT4ffuYlTTr5USrVia35Q=;
        b=Oijgjuj5Se2lQtY7HOOAhlRa0Nht6KJaMo8ckI+/XoBuMLfsPS5k1RTjxCrBX4Huay
         FsTipWEp7Ov664AQ8cmV3FQGOQx3lJoln0RGpbF/elrlxnMmMU/TK1ABIsUMcxBRVpAN
         N/Hem/fNY4QeAp+sEpZNdowKJ/bS/1ad0FyKucXpBUIJqXUj3x/FOlWOLouD4xtlZKs5
         lbPaSBhbjDayy+lK/KL/dl8BgH1jM61FlUtZDAfvU3/efCOJBPCdGWSpNZBvFQBRvISe
         iRxaFACaAhAAAFigVg71cwJOXr+BKZYE5cTVHvRxIcUIzLOWhUVMaqT+bc6mKj1SaYhy
         h+oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713869534; x=1714474334;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xoZ1iDa30OXLjJzeQItJpNnT4ffuYlTTr5USrVia35Q=;
        b=N8/uRvrQ8vcWoTulY9slSyVVesex9Eu1cGLhZj4rB4xl1zVlMAGuvYfncvps1fNzZG
         26wIRrpaGrJ2Yx0jVyQMjzhr5VZudmDjFn6Qva/W/ZIPw7o0UsZjguPYzAhwR0sN75X/
         9nqf86rpC25qRMZSeaCkuUzu/8HLYcWFFF6HWTH/vRdh3m2sDln7Kqg2qvrBX7pIhjkb
         IPAsMMuyQovYVwN5xQ++j4wPcdOSHZlmdXs4NlknxGzvsDoMGQbRgzHFWswWSD7eIwBR
         52d7U1N9VX/En6PpiU6dDJOdDJttOmIeoymkLZ22u6qYT1bLgs3TeyJwCMpPS86Gb13L
         NLHg==
X-Forwarded-Encrypted: i=1; AJvYcCVN0m3ko0jW4S5ggQ3hOmCj7Qyw1cbm0WHvRz0OMYA4PrV/peekz8n812ApvwsHki0MCrTHQbMiIk7CB3pwgQoG3I82
X-Gm-Message-State: AOJu0YwgAfOC+pDPliMbBEzi9WrOnHyFMtGAcU3UsbQ26QbGOTtvBdx1
	AkUcd8bVlAwtr2R5rRphCXF+3iVvaj1aVlykEZrgjG83Cefs/jPrtIHpBm1uyA0BQU2pqzmmR7v
	8di0OwULjtUXdnc6w81nb1LKj6Xk=
X-Google-Smtp-Source: AGHT+IF1O7GloKV6exNSJvwsjUQuFoWGJCa3IJDoy3drz1qD89ZwRjwHAc6FdtN1ZCVNnj1syJK1momApbt5GEjisRY=
X-Received: by 2002:a05:6870:80ce:b0:233:b575:4b4a with SMTP id
 r14-20020a05687080ce00b00233b5754b4amr17327656oab.36.1713869534461; Tue, 23
 Apr 2024 03:52:14 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 23 Apr 2024 03:52:13 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <ZidXrdi7hXdAnDhy@tanuki>
References: <20240330224623.579457-1-knayak@gitlab.com> <20240412095908.1134387-1-knayak@gitlab.com>
 <20240412095908.1134387-6-knayak@gitlab.com> <ZiI8GaGupNzbLqnE@tanuki>
 <CAOLa=ZSvx4bOmJY+P5j3fJTqfjY37teMHQhOYDjTM4oJtnv_qw@mail.gmail.com> <ZidXrdi7hXdAnDhy@tanuki>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 23 Apr 2024 03:52:13 -0700
Message-ID: <CAOLa=ZQsH5=2NqfWUh1HUtGuOkeRwoGdPe_OUqJfvPGda3bHjw@mail.gmail.com>
Subject: Re: [PATCH v2 5/7] update-ref: add support for symref-create
To: Patrick Steinhardt <ps@pks.im>
Cc: chris.torek@gmail.com, git@vger.kernel.org, gitster@pobox.com
Content-Type: multipart/mixed; boundary="000000000000cb1bce0616c1589d"

--000000000000cb1bce0616c1589d
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> On Sun, Apr 21, 2024 at 08:50:07AM -0400, Karthik Nayak wrote:
>> Patrick Steinhardt <ps@pks.im> writes:
>>
>> > On Fri, Apr 12, 2024 at 11:59:06AM +0200, Karthik Nayak wrote:
>> >> From: Karthik Nayak <karthik.188@gmail.com>
>> > [snip]
>> >> @@ -268,6 +268,39 @@ static void parse_cmd_create(struct ref_transaction *transaction,
>> >>  	strbuf_release(&err);
>> >>  }
>> >>
>> >> +static void parse_cmd_symref_create(struct ref_transaction *transaction,
>> >> +				    const char *next, const char *end)
>> >> +{
>> >> +	struct strbuf err = STRBUF_INIT;
>> >> +	char *refname, *new_ref;
>> >> +
>> >> +	if (!(update_flags & REF_NO_DEREF))
>> >> +                die("symref-create: cannot operate with deref mode");
>> >> +
>> >> +	refname = parse_refname(&next);
>> >> +	if (!refname)
>> >> +		die("symref-create: missing <ref>");
>> >> +
>> >> +	new_ref = parse_next_refname(&next);
>> >> +	if (!new_ref)
>> >> +		die("symref-create %s: missing <new-ref>", refname);
>> >> +	if (read_ref(new_ref, NULL))
>> >> +		die("symref-create %s: invalid <new-ref>", refname);
>> >
>> > This restricts the creation of dangling symrefs, right? I think we might
>> > want to lift this restriction, in which case we can eventually get rid
>> > of the `create_symref` callback in ref backends completely.
>> >
>>
>> Yes it does. I thought it'd be more consistent with what update-ref does
>> with regular ref updates. We verify that the object exists. Also this
>> could be an added option 'allow-dangling'.
>>
>> I'm not sure I understand what you mean 'the `create_symref` callback in
>> ref backends completely.'.
>
> Well, once normal reference transactions learn to update symrefs we can
> do the following:
>
>     diff --git a/refs/refs-internal.h b/refs/refs-internal.h
>     index 56641aa57a..2302311282 100644
>     --- a/refs/refs-internal.h
>     +++ b/refs/refs-internal.h
>     @@ -676,7 +676,6 @@ struct ref_storage_be {
>         ref_transaction_commit_fn *initial_transaction_commit;
>
>         pack_refs_fn *pack_refs;
>     -	create_symref_fn *create_symref;
>         rename_ref_fn *rename_ref;
>         copy_ref_fn *copy_ref;
>
> There would be no need to specifically have this as a separate callback
> anymore as we can now provide a generic wrapper `refs_create_symref()`
> (in pseudo-code):
>
> ```
> int refs_create_symref(struct ref_store *refs, const char *refname,
>                        const char *target)
> {
>     tx = ref_store_transaction_begin(refs);
>     ref_transaction_create_symref(tx, refname, target);
>     ref_transaction_commit(tx);
> }
> ```
>
> Patrick
>

Indeed, this is pretty nice side-effect. Thanks for explaining, I'll
remove the explicit check and allow dangling refs.

--000000000000cb1bce0616c1589d
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 27b62b871d70e368_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1Zbmt0d1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMlBIQy85Zmo1YndESlhvVEx0MVVuRG16S0NQU3V4YgpZdVMwVkxlc0RB
bzZLYUMyL2VvL3pET2VZVDg2ckJ0UW5TZFhSQXBXVE9kcWtwVnlXKzlRTU5zUXU0cDJla1NHClJ3
OHVwRHgyUXc1WXlTVHJZcVBMTzZSVEJUem1JREFwMFk3MW5hU3NBUHRHRUNqa1lYLzZBN0FaY2JT
VVZaRXYKdE5qRGZGdHEzYXpOYWd6V0J1b3ZndFp6NVpJNXlrZjExRzEzNjhPM1g5YWE4UGtBOFJD
UFFVVmo3bHpLSUdhVwpNa0YwcS8vTlc3aXE5RWJGcUp4d28yQndyZDhiTzVWUjArUkgzcGVINnQ1
VEhoRGVNRkRzd0FWcWZvdUF2OVVYCjdMaXVuNE9yb0poRjF3dnBlYU5rQjcxVWJQM2w3U3pCNWRr
bnhhU3pNOVZnRFA3UzhsKzQxbExuODhaTmZjb1oKSSsyRVR2dTVBcmlzYWFuSmJrS0FXZXRBMVVM
VUgzTHA2TkQrOXoyR3lOSnFSS1B1dDFwL3NsZmdaYXFjR3dSTApTR0tDQVowbSsvbVd3RzZSL21m
WnVEL09lSmJFbUVTQm9qYnA5dmU5WEJTRG1hTkQ0M0VEOEt3Q3ZFNlB0dXo0CnBkZ3V0SEV4UUhp
Zk95T1ZMckVSYmpNMlVONnNxT1hGM2Z1Mm9tTT0KPUZObEcKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000cb1bce0616c1589d--
