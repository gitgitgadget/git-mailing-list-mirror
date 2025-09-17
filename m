Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 695752F5A09
	for <git@vger.kernel.org>; Wed, 17 Sep 2025 20:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758141653; cv=none; b=mAoK1ek8sxCHtueKlQPRqdyfthqGaiFCh6iE1SXoHwQtnKyQyeparzuwPqT+niUh9QiirL4GhoC/RV3ViaYxoTpI8OJeiZ1g0xAdkxs6eJjDbXtgRijWEjDdAnqBthio610mSFLi8r7K61nB6s4ULz0AcFeuV++RIo8m4Iz1Avg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758141653; c=relaxed/simple;
	bh=G4wgC2PIxa1mUqwpkJ/cDK8fgsRIGm3MowRO5WOq7xc=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z1sKV8MuuTtAfw+KbLXIiBR8IgM/V6nhNgZ+yR9z1XQKOgQI/BE3Z9yj2cvuNI2Ds1gEqcxho4f72OkO5GP2zLXN5+e6v0p0fqcgjixHCP9l4xgCYivfjrjFEd1MvBH1zyUhFDvVZV2GEDaq/xl1TLaIWtodux1cXJtQXsy/+OE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tyaab44v; arc=none smtp.client-ip=209.85.222.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tyaab44v"
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-8dd35d9d574so157057241.0
        for <git@vger.kernel.org>; Wed, 17 Sep 2025 13:40:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758141650; x=1758746450; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=WKgJ/HugX8xOoN7lPqCKXvdT6JQE9uXsTbS18uxOjpg=;
        b=Tyaab44vyDt2FVgw6UK3LIxviGJ4dBVFF7gIzqaj1kep9sGCI1ifqY2XvJLGP/1ldl
         /huHIqAnj7xIHcfoC8ULGyLTaW/Dma7z/metHLz9BTgfKarhYEsjT/G1hb5sGgbj+ne2
         JlATH8BlpewJMbLR5LxbBxUFcHxa4fyxdEVOha7dXIjRFyYfjvnJTdAFUqyImUMt0D83
         X4oGc8pSksfT2pB0OrQuwBD70y1HNmgeynpOqjPEOpEc0Gr+K7dkBkhKt4yYoicc1xEM
         CqawLVx42zhmpC8Q54YHuCpUtSSbVwI3P0rBD1ZsFQVwSFfxy+4oBtf7B+ssCOxXoBMa
         r0zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758141650; x=1758746450;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WKgJ/HugX8xOoN7lPqCKXvdT6JQE9uXsTbS18uxOjpg=;
        b=Mrd3kdqVuRit+bR8JFb0547EtRR6jhZirXd/jTrkdIvqVa9JQUo1gcWk7CY6C6kynH
         naY26uDKkyDL+IYYUldxAZUjBSNFhVK+CnVfZU/pourQFzfZGWIoiOA2d8e0egJObDFg
         ZnmqW3k/ohvT5K8Mric7SQ5NurKUCa0Hcpa463GzmfwhN1OCjdP1EiTHl5Lo7WcjR8Wz
         JCkveuH1vGASTL8SBYRdQtx8Yggrc0YiahrHk19uA69YCZSFkpW8vk41u9c9DoUe2ayS
         BS12qvg+WbPeBncKB1h9GyLMXpQrCYgbuuApJvDOymbbJ6qJtL36NnSyrNmiQnsiwJBa
         CKog==
X-Forwarded-Encrypted: i=1; AJvYcCVUmCuWKXmyyftB/7QdSVl/TQGYrJ32mww9P2RknJ9YOLoemnwE5BL/rrkKfQERk8SMMzo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTJykDtMIdQ84ZdaY4Mqaov7WLJD0ILRKp9fD5NLcVWEkmxk2H
	K/ImgvAHLRvO5a+hT73yqJ5CnK4TjP/UyJ667ILX+oFxFACU3KnCd2GVRlDW1VCcTxBJ/4NK9E5
	Bls6ImArU+bC2z2GwbYc5f3AS8bRW2nQ=
X-Gm-Gg: ASbGncvgYNhnLPoSoS39f+VQbS6YKy1JyJlwIp97GZWBZP/u15MhjBP5r7yXz/Ub4Ql
	TlvYeLwpQQo6Oq+YChztaCB9JSzg2oL3PJ64DcBPWF6AuGZyklW25Qk6YS3MrhKMTUE3uDlUxL8
	v+R6bsVa5Ni/jL6Bvdqp8+RHNTZzw0oDqxN6rdPpOk6Q7vruPsCip6o2xZH5v+KnZuFMnjidOp+
	ZBsyv01AwvBUAPS033BsmdSRTqAzJjFBuwBIygf/HSF8rQpNmhSH31RwhM=
X-Google-Smtp-Source: AGHT+IFg8MkHbvrTeRD3rL95BwX8MNnFYo/Z0X0+kEtKrr23BWAgJI+1+5ekBvPkCHNAHze33arHpdXp+vlAOS1x1MM=
X-Received: by 2002:a05:6102:3a08:b0:4e5:9c40:824d with SMTP id
 ada2fe7eead31-56d64f52030mr1551921137.16.1758141650059; Wed, 17 Sep 2025
 13:40:50 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 17 Sep 2025 16:40:49 -0400
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 17 Sep 2025 16:40:49 -0400
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <xmqqjz1xc8nm.fsf@gitster.g>
References: <20250902-587-git-fetch-1-fails-fetches-on-case-insensitive-repositories-v1-0-35e69bbb507d@gmail.com>
 <20250913-587-git-fetch-1-fails-fetches-on-case-insensitive-repositories-v3-0-195569740b57@gmail.com>
 <xmqqh5x2m5d3.fsf@gitster.g> <CAOLa=ZRvAMq7MNm6=dBneAXdDe6OjQ=NqYA9-Vd7E+nvDWGH0w@mail.gmail.com>
 <874it1noh2.fsf@iotcl.com> <CAOLa=ZSBpSyU0V08OBrr-QPrZPsYnO1bTZewESY=C7Jy4NTcWQ@mail.gmail.com>
 <xmqqjz1xc8nm.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 17 Sep 2025 16:40:49 -0400
X-Gm-Features: AS18NWB-1-_rG76JD_7WWixfu6w2XdEZXt1Uoc9yIIEoEHV7hPz6vceTquSRGWM
Message-ID: <CAOLa=ZSfqcaP1+yxGzY=kEZJPeUqkqm3rO1ak6QihCQ5urT-0A@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] refs/files: fix issues with git-fetch on
 case-insensitive FS
To: Junio C Hamano <gitster@pobox.com>
Cc: Toon Claes <toon@iotcl.com>, git@vger.kernel.org, joe.drew@indexexchange.com, 
	peff@peff.net, ps@pks.im
Content-Type: multipart/mixed; boundary="0000000000008465d5063f054099"

--0000000000008465d5063f054099
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> Karthik Nayak <karthik.188@gmail.com> writes:
>
>>> I've noticed another issue though, at the moment it's possible to create
>>> a ref like `refs/heads/foo.Lock`. I can image this gives issue when the
>>> remote has `refs/heads/foo` and `refs/heads/foo.Lock` and you pull those
>>> in on a case-insensitive FS. Unfortunately I wasn't able to verify this.
>>> But anyhow, I don't think that any reason to hold back on this current
>>> patch series. I approve.
>>
>> We don't fetch locks from remote. The locking mechanism is simply a
>> construct used to update files locally in race-free manner. Locking a
>> file ensures no other concurrent writes can happen.
>
> I am not Toon, but I think Toon meant "foo.Lock" to be a funnily
> named but a valid branch the remote has.
>

Oops. Thanks for explaining.

> Doesn't the remote advertise refs/heads/foo and refs/heads/foo.Lock
> in such a case?  And we can ask for both of them.  When updating
> foo, we would locally create "refs/heads/foo.lock" and then rename
> it to refs/heads/foo", right?

Yeah with batched updates, it would

1. create 'refs/heads/foo.lock'
2. before creating 'ref/heads/foo.Lock.lock', it would try to verify if
  'refs/heads/foo.Lock' already exists. Which it does from #1, so not
  create it at all.

To be honest, I'm not sure what the best way to solve this would be for
case-insensitive filesystems using the files backend.

> I think Toon's point was what happens
> when the fetch of "foo.Lock" from there somehow has completed first.

That shouldn't happen AFAIK since the reference updates are ordered
lexicographically.

> Or we can simply fetch foo.Lock branch and then foo branch in a
> separate invocation of "git fetch"---now wouldn't the second
> invocation have trouble creating the lock file foo.lock for foo on
> certain filesystems?

So if we:

1. fetch 'refs/heads/foo.Lock' to create 'refs/heads/foo.Lock' locally
2. fetch 'refs/heads/foo' after

#2 would fail since it would determine that 'refs/heads/foo.lock'
already exists. This would be the same behavior without batched updates
too though.

---

Overall, I think the only issue left would be when you try to fetch
'refs/heads/foo' and 'refs/heads/foo.Lock' together on a
case-insensitive filesystem with files backend. For such a system, with
batched updates, the latter reference wouldn't be created.

Thinking more about it, without batched updates, both would be created,
since we create the locks individually in separate transactions. But
after the first fetch, we would never be able to update 'refs/heads/foo'
since it would always think that a lock file for that reference exists.
So it was always broken in some sense. Sigh!

>> In-short when you fetch references, the prepare stage of the reference
>> transaction will create the necessary lock files. This locks in the
>> updates with guarantee that no other process can update/create the refs.
>> The commit phase simply removes the lock files post updating the refs.

--0000000000008465d5063f054099
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: f4556b431cd00268_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1qTEhOQVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1meU0yQy80MXFXdmpTa3hSbXpuS292K1dQa09FT0RrQQpkZEM1aXVxSFVn
RVN5LzBXRVA4UnJuMm43Y0YwY2lZVHhiQ1NZaFdUL3N5UkNubHpRUmNGbmE2UVlQeUJ4YUN5CkxC
akpFUEVvN1JyU000WlFjVXJaYjUvc3NGcDRaQnpPdUhWckUzTjhjMlc4eVQvc2RoT1MvMjZPNHln
NlRYc1IKbG1tdFNNUFJlV2UrUUhIcHJLci9zZTMwZzVIRkJBNmlJSSsyQTlsMmJUclBzekdkSWpL
UFdiQlpNRDNXMXNDWQpOZ0crT3YvM3JYT0c4cEdHeS9ZRHhVanI0ZllnWmFVYnkvQlYyTGVMeVRL
T1FxV2loMlRVV2ZEZVVzSDRVRXM5CmUrVkxEL0gwV0VoTUtiRFpqOE12N252K1hva3NUdHN3MXJL
M3NqMEUzM1R0OTdLN3ZUY2w2T2ltYWhScGVVc3IKdDMzVjF6M05WMHFmNGRBM0NnN05pZXNvOGta
ZmF6UnZkdG5MOGJGVi9FQzMzU0FDWStuVUpTYWhwTTVzL1Z4QgpyeThiWm5wTWpZNThBNHVqa0pv
djlFWEc2UVI4bFFFSUtqUnNrMXRiZGZRb0IybU5wUEFYa3FYL3N4TXAwcS8zClpXR1VVWUVJcS9N
aUZKcHo2UE56ZGpDVW90RE11bEh1Q2E4UE1yaz0KPWFKMTEKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000008465d5063f054099--
