Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D05A4168C4
	for <git@vger.kernel.org>; Fri, 19 Apr 2024 21:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713561690; cv=none; b=FomO1BR3U+QO6SnoKI1wqzldQz/Y6Bs3QRbUHkUe0HZOUOssIf+FhABhN7RIzBGiiYLQ6f6uptT9gzAVXls71DIl95Vtkwa/3dwVGn3FdwmVTLdrq0fvk0RaYVVpNQEu6YrxpYdBSrALXc1/iekbfhXsLR4E0qIZWvFPp1GjdPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713561690; c=relaxed/simple;
	bh=X0hDZ6cUQN08l3Lg4U3N1NbxRSElH+eJTLTmf6SIw+c=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RqRWQeh3v64xcI8GXaTvCVNRWWLKJRhM1kctiVT7/ZUh2tvkDFDxId27MZuO+6i0uMq6ktK7ALKKrmPCuPjmEGpvOyp5PcVhySXIRPB9xoG5NtSlHCFMR+TeO8aStNcyyF9d7AAjlwPszZtcNXNmac295FS+TtrbXwiz86gCtss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eezcVPaV; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eezcVPaV"
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-22edbef3b4eso666058fac.3
        for <git@vger.kernel.org>; Fri, 19 Apr 2024 14:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713561688; x=1714166488; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=fmrZgdakbUt6KUMynK29IxL0tWdCQ8N/Vg3+CmJ6lXw=;
        b=eezcVPaV9O4jBoykmI5ClvxTzVHzu+jJ8uycbmGQSXXHFkdvVtzyKKsLo0lc01jVz0
         kIOaJz9llcCHsAzfl5J0Xl0qM6RvaFSHhYtmsgObIbQXCFdpeqvfvrFu0zuOSRuarl9t
         Xh1ouLIdE3E4xKnbSsPALvzB/rMqW9C8nS22vlVulUWqDHMMkm/oGL1lYF7M5MAU9IHz
         0FQokZsUc7rBmzouDGoJ/oQE5mX8a1LjC2P7s8feWxzZjleUMKouHqfIovbeNp8S1re1
         RF1kAFULNKNLNQF+VlPlHWp2iFjvX5Pb31Ud3z4jf8iWVv8lcGc3ZXquLU1G+zb2LZaX
         /9iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713561688; x=1714166488;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fmrZgdakbUt6KUMynK29IxL0tWdCQ8N/Vg3+CmJ6lXw=;
        b=XyCoMobqpUyzAcSHre1pV4QTSMDEQH7geWSE3RV2nh6zBoD+oLP6Z4o7fbn5Ikv9iA
         Dn/FoSq9DVQsfRO1J+t4suHkiCMAzuPgrefjehYlMxZ2RjplWoAvNidF7vt7pEBgGAJu
         Cucdbt2yXLF3QaWKVmLdQ9AQrWR8q+F79beLvU4+p7VKY9L0MHqnGWwrLVxJHqTYfwq2
         MIAFlyn1SDhlgOD0xk1HjwoTzL5pplWOj5VKraKp/+47tMG5CRamM34P+a1n00aQTkdR
         sQ1qyv49K23kGkGSE9Tq7agkl6aT9XZsYtr9LzQbPyR18R1jUtvL40p5Ew93aO8gjCPd
         26vw==
X-Forwarded-Encrypted: i=1; AJvYcCUWDyNUH9FPgfQ4k2c3Xb25ZV6wbjCFF/ttFNhQQDUHNPwp7E2sMx5Oln3j8u7bLAvLM/vHcxnFD8R6EuiaexzY9llX
X-Gm-Message-State: AOJu0Yw9m2qyKrjQrwszg6sV0pfd+SSeO5vKxKqj6omHmDVsict9hUpg
	M82VaG8iPbmMVGmmR56wYNpdJhWKr8xVIx8oJQ5861vaFPWBondiDpkwNoGhp19PDAJhThJbXG4
	GiHZWjOyT6xoMsgHfQpZCnrAZzK8=
X-Google-Smtp-Source: AGHT+IEk1upYTxt+hfb40E4Q3JQz1Bsr6owcj2cOfsUjfInrEKzYeOQFglt/QI1tprMDPVUy87MiR/P23gQdfOAKQYw=
X-Received: by 2002:a05:6870:b026:b0:239:52f9:7f15 with SMTP id
 y38-20020a056870b02600b0023952f97f15mr3546289oae.26.1713561687817; Fri, 19
 Apr 2024 14:21:27 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 19 Apr 2024 16:21:26 -0500
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <CAP8UFD2bqdMujHgS9oPn4Xqzu=EhGMPms7ftOB7uf-AHke79AQ@mail.gmail.com>
References: <20240330224623.579457-1-knayak@gitlab.com> <20240412095908.1134387-1-knayak@gitlab.com>
 <20240412095908.1134387-3-knayak@gitlab.com> <CAP8UFD2bqdMujHgS9oPn4Xqzu=EhGMPms7ftOB7uf-AHke79AQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 19 Apr 2024 16:21:26 -0500
Message-ID: <CAOLa=ZSFXH=xGYF0on3B2YeiudJBGMpjctHazLcn-fyO=UR4yA@mail.gmail.com>
Subject: Re: [PATCH v2 2/7] update-ref: add support for symref-verify
To: Christian Couder <christian.couder@gmail.com>
Cc: chris.torek@gmail.com, git@vger.kernel.org, gitster@pobox.com, ps@pks.im
Content-Type: multipart/mixed; boundary="000000000000b42998061679abc5"

--000000000000b42998061679abc5
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Christian Couder <christian.couder@gmail.com> writes:

> On Fri, Apr 12, 2024 at 11:59=E2=80=AFAM Karthik Nayak <karthik.188@gmail=
.com> wrote:
>>
>> From: Karthik Nayak <karthik.188@gmail.com>
>>
>> In the previous commit, we added the required base for adding symref
>> support in transactions provided by the 'git-update-ref(1)'. This commit
>
> s/by the 'git-update-ref(1)'/by 'git-update-ref(1)'/
>

will change.

>> introduces the 'symref-verify' command which is similar to the existing
>> 'verify' command for regular refs.
>>
>> The 'symref-verify' command allows users to verify if a provided <ref>
>> contains the provided <old-ref> without changing the <ref>.
>
> What if <old-ref> looks like an oid? Will it work if <ref> is a
> regular ref that actually contains this oid?
>

This would fail, since we parse and check the ref entered.

>> If <old-ref>
>> is not provided, the command will verify that the <ref> doesn't exist.
>> Since we're checking for symbolic refs,
>
> So if <ref> isn't a symbolic ref, it will fail? I guess the answer is
> yes, but I think it would be better to be clear about this.

Will try and clarify more in the commit message.

>> this command will only work with
>> the 'no-deref' mode. This is because any dereferenced symbolic ref will
>> point to an object and not a ref and the regular 'verify' command can be
>> used in such situations.
>>
>> This commit adds all required helper functions required to also
>> introduce the other symref commands, namely create, delete, and update.
>
> Are these helper functions actually used in this commit? If yes, it
> would be nice to say it explicitly. If not, why is it a good idea to
> add them now?
>
> Also I think we prefer imperative wordings like "Add all required..."
> over wordings like "This commit adds all required..."
>

Will clarify and make it imperative.

>> We also add tests to test the command in both the regular stdin mode and
>> also with the '-z' flag.
>
>> When the user doesn't provide a <old-ref> we need to check that the
>> provided <ref> doesn't exist.
>
> That the provided <ref> doesn't exist or that it isn't a symref?

That it doesn't exist. I don't know if it makes sense to make it 'that
it isn't a symref'.

>> And to do this, we take over the existing
>> understanding that <old-oid> when set to its zero value, it refers to
>> the ref not existing. While this seems like a mix of contexts between
>> using <*-ref> and <*-oid>, this actually works really well, especially
>> considering the fact that we want to eventually also introduce
>>
>>     symref-update SP <ref> SP <new-ref> [SP (<old-oid> | <old-rev>)] LF
>>
>> and here, we'd allow the user to update a regular <ref> to a symref and
>> use <old-oid> to check the <ref>'s oid.
>
> This means that the ref actually exists but isn't a symref.
>
> So if I understand correctly, for now it will work only if the ref
> doesn't exist, but in the future we can make it work also if the ref
> exists but isn't a symref.

This comment specifically talks about the `symref-update` command which
is in an upcoming commit, in that commit, we do allow users to update a
regular ref to a symref, while also checking the old_oid value of that
ref.

>> This can be extrapolated to the
>> user using this to create a symref when provided a zero <old-oid>. Which
>> will work given how we're setting it up.
>>
>> We also disable the reference-transaction hook for symref-updates which
>> will be tackled in its own commit.
>
> Why do we need to disable it?
>

Historically, reference transaction didn't support symrefs, so we're not
actually changing functionality here. While we can fix that in this
commit and add tests, it makes more sense to tackle it in its own
commit, which we do at the end.

>> Add required tests for 'symref-verify' while also adding reflog checks f=
or
>> the pre-existing 'verify' tests.
>>
>> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
>
>> +symref-verify::
>> +       Verify symbolic <ref> against <old-ref> but do not change it.
>> +       If <old-ref> is missing, the ref must not exist.
>
> "must not exist" means that we will need to change this when we make
> it work if the ref exists but isn't a symref. Ok.
>
>>  Can only be
>> +       used in `no-deref` mode.
>> +
>
>
>> +       /*
>> +        * old_ref is optional, but we want to differentiate between
>> +        * a NULL and zero value.
>> +        */
>> +       old_ref =3D parse_next_refname(&next);
>> +       if (!old_ref)
>> +               old_oid =3D *null_oid();
>
> So for now we always overwrite old_oid when old_ref is not provided.
> So the ref should not exist and the command will fail if it exists as
> a regular ref. Ok.
>
>> +       else if (read_ref(old_ref, NULL))
>> +               die("symref-verify %s: invalid <old-ref>", refname);
>
> So I guess we die() if old_ref is the empty string.
>
> It's kind of strange as in the previous patch there was:
>
>> +        * If (type & REF_SYMREF_UPDATE), check that the reference
>> +        * previously had this value (or didn't previously exist,
>> +        * if `old_ref` is an empty string).
>
> So it said the empty string meant the old_ref didn't previously exist,
> but now it's actually NULL that means the old_ref didn't previously
> exist.
>

Good catch, I initially did start with the empty string idea, but
switched to using zero_oid, since it made a lot more sense, especially
because now it sets interoperability. I will fix that comment.

--000000000000b42998061679abc5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: bd80e987c805eb5e_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1ZaTRGUVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1md3JyREFDY2pYcXZkSjMvMiszRlJXcGFMdG5HY3FUNwp6cW9nbHo0TVJL
M0VtUGo0ZVQwUDltQjY5cll1bnEwNEZ1SlZ2elAwSTJuZFBIdTJ4RGhYQzA2S1RQclFPVmdBCkIy
UTd4ekpVZHppbno3ajRLTENVV1FKZGFEUHdTcUNXMC82M3JWUUlPQXFtRVBiLzd3ZHFYTk9Hbkt0
UkVzeUIKaWJzdWVBVytSSi8wcE10WXNOc2VrSE9LdllKV1F2NkVOZXZJZEs2QUVsSjFIY1IwYlZt
b2lNSGFQczFzajVFUworOVVHWThySUt4RkthbWE4cTY5bG1qRy82cjNyVTJqMEtUWHA4bUh0QlJW
Y0w2ZGVqK1JQYWlpdWF4WGVWK29JCm5KTGZjVzVNNkV3dzFNR3ZIWEhsMTFpZWRUOUlidW94ZXVY
cXdtS1ppMzRxN3RRbGZIZDJvcGdIQ1NIV0l3QWoKTjlDVDA2ZFkrUUtpSTEwK0F6MXNGOWo1bDZK
cUZ0b3JQTERScWZYbVJkTmhxeURnc2tHOFptNU9ST0ZPY3JCTQp3TFovdGcyNWlQb3ZhVVJScHBz
TzV0bHpzLzFoV1diNW13TGRIdDc4Y3ZjTzhpdGNYOVl0M1Z2VC96OWxERFAvCitFZC8yY2trQnA5
RXAxQ1FVWk9FQjRrMy9UVjh5T01SWnA3a3BVcz0KPVJUQksKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000b42998061679abc5--
