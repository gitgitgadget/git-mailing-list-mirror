Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA76E1CAA3
	for <git@vger.kernel.org>; Mon,  1 Apr 2024 11:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711972086; cv=none; b=k1daJqUnUVrTUfYSfZDCkeAxg26tWCuxr3JH8aiwQ73OjLqAItloy2pvdn3U7/A1RK3N0hwuwP3k9U3ynOyPPcQZ4gna/jUfiqKH6R1abLqvjf7uxLBA0GYqF6cT2Pf6GbjSYNXltrPZcvKm0aFEsA2w+gx6T0zc/7PTaVX8vLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711972086; c=relaxed/simple;
	bh=Wv1LHvThBu4e5VwPZcxAcsHMZ7sEbHxSAD1wIShHRvY=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cpL3OjYSmKSoGPebCV9TZGexyycXcIQqHdUJGAxo04ZVhO3fQnXzDZNyqG/3IO2JrIampqSQWMEYyddMkHdhZCK2y35rnS1vtbvplelO/W2wG4jBgLLe7oV//949+K/ugI3kl0BARwSWBkKlLXyNAB+KzP0syPzz6qMBxQeOkt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KKhilt5z; arc=none smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KKhilt5z"
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-5a496fde460so2514557eaf.1
        for <git@vger.kernel.org>; Mon, 01 Apr 2024 04:48:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711972084; x=1712576884; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=zlMvvWS77hFZKQzGjGlNlR8jjGWIfMewh6O5y295r8w=;
        b=KKhilt5zToX1p9xUrASwHPZrk3rtTcjjmqoKKtt3SL6PtYDdjoAhsIU/K7vAgOF+WF
         mGUwds8AqlnaoUt3SvCp9+VF1aO9niWMvr0QiPCP1ZvGTTbAlf1X/sPbVQwdcN/cPfl6
         7EkjiCMw356r8ruSHqYEUiDhNsfHbSQNGsd2JBYYhapL/IBkGfPWJoO9O0imp7aANyeR
         sS6HRdV71C207aw+piELnITTBiQJbd1dhpd7erEEKBPNvnfaoQ+VH2OBsUp/45b5rBzc
         dGaQoUrS+BsVcgxv9TJ7BjlA51w3/CPDd+rv5PKRFH9aYtpf8PfKcUKifdbDQ6jnTs09
         YdoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711972084; x=1712576884;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zlMvvWS77hFZKQzGjGlNlR8jjGWIfMewh6O5y295r8w=;
        b=VTSGyp/3JFsFIGi1KDFA8NaoBq1yAlo/DdGqAKJ7DP0v08p5NKkqtS2DYjHGvHDdx6
         /UNXS3Qm50RE8smz0BpYnFYe8B2hJp6P8VIsWI2o+17JtWixfIEamLHUI4WDYVvxBYj1
         nUTXXgMS7JbmSjFA/bWvuM/xr/g/dvqQKDHW03ckYVm6pNTFLdgjtJpxf2O8e3Ol5zAq
         64WeJDBJVKgDajjFIlWYnhNF+WsYHysC6oBZgAbYHJsl9hVL1uNhkxn5cw93Hi+c7GQf
         VDffPR9jOPB3Jvb8y9o5yDwPgbZ8e9HC0rmllrZMgtIap3mFwSyxVTzBjDSpy4o2i/xz
         nc1w==
X-Gm-Message-State: AOJu0YzndKQjmRfYd6VUlH0UzskvMccp8fAY9oso0TJm13m96/7aua9m
	NxcsjAVRwp/PQhL46/SwMPJKsBL7SHumOkX40hgzaOr48jVVkSucCCMWwfDTvw53TMlMbETDHBp
	zPIshpGVlnbuWi5Xvn02K9ILAHVk=
X-Google-Smtp-Source: AGHT+IFQNOxVHLRPe8nML8ZEUTxg31XEnzuq5RE5ysbEoXhqasOWu1RH505qFiR17jesOKgHW5Thvnd9gbcxBB2AB2I=
X-Received: by 2002:a05:6870:2c85:b0:22a:7bee:2ba2 with SMTP id
 oh5-20020a0568702c8500b0022a7bee2ba2mr10879379oab.37.1711972083569; Mon, 01
 Apr 2024 04:48:03 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 1 Apr 2024 04:48:02 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <xmqqy19yf40l.fsf@gitster.g>
References: <20240330224623.579457-1-knayak@gitlab.com> <20240330224623.579457-8-knayak@gitlab.com>
 <xmqqy19yf40l.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 1 Apr 2024 04:48:02 -0700
Message-ID: <CAOLa=ZTLv39b4Q=AAUA39tXKgOSuu54xk3-r9OUenzxR-6qcag@mail.gmail.com>
Subject: Re: [PATCH 7/8] refs: add 'update-symref' command to 'update-ref'
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, ps@pks.im
Content-Type: multipart/mixed; boundary="000000000000e83e1b0615078fdd"

--000000000000e83e1b0615078fdd
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> diff --git a/Documentation/git-update-ref.txt b/Documentation/git-update-ref.txt
>> index 0561808cca..2ea8bc8167 100644
>> --- a/Documentation/git-update-ref.txt
>> +++ b/Documentation/git-update-ref.txt
>> @@ -65,6 +65,7 @@ performs all modifications together.  Specify commands of the form:
>
> In pre-context, there is this entry.
>
> 	update SP <ref> SP <newvalue> [SP <oldvalue>] LF
>
> Unrelated to this patch, we probably should say <new-value> and
> <old-value> to follow the (recent) documentation guideline to write
> multiple words concatenated with hyphen.
>
> If we are updating these newvalue and oldvalue anyway, we may want
> to update them to <new-oid> and <old-oid>, as the existing commands
> on refs are about object names, and what we are adding here are not.
>
> I would prefer to see such an update of existing documentation as a
> separate preliminary clean-up patch, so that we can cleanly add the
> "update-symref" that takes <new-symref-target> on top of a
> cleaned-up base.
>
> The <newvalue> ...
>

I agree with your synopsis here, I'll send in a patch for this,
independent of these changes as a precursor, while we discuss the final
design of this series.

>> Chris Torek <chris.torek@gmail.com> writes:
>>
>>> For these reasons, I'd suggest that the all-zero hash be officially
>>> deprecated in favor of create/delete and of course create-symref
>>> and delete-symref. Of course, compatibility requires some sort
>>> of support for the old system for some time.  As to whether that
>>> means something like the suggestion of ".missing" etc, I have no
>>> particular opinion -- but since the symref options are new, they
>>> would not *need* symmetric options, if we just say that "update-symref"
>>> cannot create or delete a symref.
>>
>> I love that simplicity.
>
> Having said that, the loose "update that can create or delete" may
> actually be used by applications that do not care about overwriting
> competing operation, so I am not sure if we can easily deprecate
> that mode of operation.  Saying "update refs/heads/next to point at
> this object" and have it created if it does not exist may be handy
> for some loosely written applications.
>
> So perhaps we can say "update with a concrete <old-oid> will ensure
> that the <ref> poitns at <old-oid> before proceeding, but update
> with 0{40} as <old-oid> to ensure creation is deprecated.  update
> with 0{40} as <new-oid> as deletion is also deprecated.  Use create
> and delete for these two deprecated operation modes".
>
> This assumes that create and delete currently ensures that what is
> asked to be created does not exist, and what is asked to be deleted
> does exist, before the operation.  If we are loosely doing these two
> operations, then we cannot easily deprecate the checking-update,
> without breaking existing users.
>
> As {create,update,delete,verify}-symref do not exist yet, we can
> start with the right semantics from day one.  "update-symref" will
> accept a <old-ref> only to ensure that the symref is pointing to
> that ref and there is no "zero" value based creation/deletion
> validation offered via "update-symref".  "create-symref" will error
> out if the ref asked to be created already exists, "delete-symref"
> will error out if the ref asked to be deleted does not exist.

This seems very reasonable to me. This ensures that each of the commands
do not spill over to the other and most importantly we don't have to
deal with "zero" values.

But this still means we need to think of the best output for the
reference transaction hook (following commit).

My current implementation of:
   <symref-target> SP <ref-name> LF
Should be changed to:
   <old-ref> SP <new-ref> LF

But this means, for creation of symrefs <old-ref> needs to be "zero"
value. Also there is no way for clients to differentiate between regular
refs and symrefs here. I wonder if it makes sense to do something like:

   symref SP <old-ref> SP <new-ref> LF

Where symref is a fixed string at the start, used as a differentiator.
This however still would leave us to deal with "zero" values for
creation and deletion.

Perhaps the best way here to actually be a lot more verbose and have the
hook output the following:

   symref-create SP <new-ref> LF
   symref-delete SP <old-ref> LF
   symref-update SP <old-ref> SP <new-ref> LF
   symref-update-forced <new-ref> LF

I lean towards the latter, because its also much easier to extend in the
future and we don't have to deal with the "zero" values.

I'm against the "zero" values mostly cause there is no nice way to
describe a zero value for a ref unlike OIDs, which is inherently baked
into the type of data.

--000000000000e83e1b0615078fdd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: b0d464be870cd1b8_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1ZS252QVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mKzY0Qy85Ykp2ZkVOb2FpUXhUTExvbTBTL1lMTXNNMQpWQ0dDSHJGYzdJ
Y2paTWM1UXk4aitudHF1TTdnVUZLdGR6c0NUdFRlMTZUa09zdXMxclNuY0cyalhjOEgvcDZmCmw5
SllSWHFhNS9GVzJFTVZnTzFRbnQ5UjdhSzQzT3FzTGJiNzU1OWFWTFAxelV5UUh0YjJkS3pKUUs3
bkdtSzUKSTQxc1Awd3ZyWmRsRm1GM091bWQ1OFk2WTlTckdlcWI2a1JSWVFNZVBBcC9mNmZXSnY3
UHFWM1dMSjRsU3lSUAovUnpVNVVqQXNGNnZ6RzJnNFYwaDNBMWRSbWdudkVLVEdhMjYvd0tLL0ps
MDZadnNWMUFCWmdoNlVZVUhmdnhPCnIrQ2x4Y0pMbnlXTFNwdmhqVlZidmovM2tzZGJNWUZKVWlR
aXFxZTJPa0JzR21wWk5kcXZ1cEhFc1dWOElyQW0KZnlLSnNURExMRmo1YUJ0dEpKQVBOQTNZMG1q
TlRsNE5pOWttK1FSd0gwMkFBUU9LWnpUV0x0REVPUmtsU3ZLcQpNTXZvRTlGZzFmVW5GajZKQzk4
WjQ4aEhIbHRIV3p1dnVrNjlLclpveS9NcjNkbVRwSEl4U3hCRmE3bldDQ1R6ClFSMU5PSFlDZVlw
My8vTXZhL2lUa2NSSDNQcG82aVoycGg1WnVJND0KPXY1d3EKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000e83e1b0615078fdd--
