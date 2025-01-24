Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 110B91CDA01
	for <git@vger.kernel.org>; Fri, 24 Jan 2025 10:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737715093; cv=none; b=FW7ytlZTSTOES1xxCmnBlfJpVtZv6F4tw2NIFNN5dqYcC2SXlW18zSkYMDM/nOSXVKmdswirRSzZE5jQWmknGv3JSlc5eWg479/aV7ZQMylCyyFy9oH8vzQ5Qb6P6VdPsAYPH2Pb+2N2bqPPdGHZOCkLL8dA4fno9+PzmdQUj1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737715093; c=relaxed/simple;
	bh=6h0j3PMI8HSsEclIz31Eeem4wUUXGcZcvrBhHtFZMtc=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XshEuXtlLPtoOYoYYPFr+7yl/yXQIeFuKYcsP5FWOwVQdviGer28rlJHj5eAhXvQTf/jEWC2PyVKiJ5DToTAfC/Kg2R5xT0NyOs0aT8Ll+Bn0MDSwSyOFmjTu5aciwIgAVF96nrtk70xUI/+csCbeoxA2Hh7IAkkOFt4bfAOJSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dmHc/sIu; arc=none smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dmHc/sIu"
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-51c68d851feso643951e0c.2
        for <git@vger.kernel.org>; Fri, 24 Jan 2025 02:38:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737715091; x=1738319891; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=uk9fjYfrMG+eHqFjZhgWlzbPSFb2fH3z6BZF949XZNg=;
        b=dmHc/sIuJn33KqNLEX2Y+yMp9nIkXhp8+m1MtqcHiTk5Azs6eEmh3OfDsUyEHFgzqa
         ki0nNC41jz4w8Fm2ODcugpRu8QoMdKmpMkzSNZjQizgATB88bixT43MXFDJEvrCBClNl
         HTrkE2AHjufoAzgNtxZShUEjuFvNQ3zdZpjFUFt1LfHm7xgruqOltv7oip7RbJAoYi/W
         WJyPZ+Wtm6mn78cXjqujFznQNtEU/AzPtJUktcF9xRpQMeeGLTwmYpP+MK7FpNuqf5PU
         1+3PAd0CIfZeyxRP6P2D39VqUakUg1HhdIC9Gdn37v2vVjmHaiG0KIQCrAY5QR0b5jr0
         7LRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737715091; x=1738319891;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uk9fjYfrMG+eHqFjZhgWlzbPSFb2fH3z6BZF949XZNg=;
        b=OcQb1A60neJ2NOSnuFqLNB//CaQYPLWX/OLHxAKqLguVZcQDeLWI3qsa51iZHbKExy
         Zf70CJTsnB8sFOGvo/VMtP+LVDzOE/dbckeupd7GgtzX8zp8dBKpYVh9ylYvmZbNYWZ/
         SLA0oRueaSFK6xTgi6I8Jf977X3lHTOO37VMuwNbwPa9eiFEYNcuJSDMimVnv9jR5Frb
         zh4HD8L0OBX27APFoohv2j/cI2uygro3eoNOj6XOjsRaB2gy7ZuIV1gnDLJbHqHTXP29
         wUtR297dq0pDoDuaLWcghtEvupIShyF8xvtLunyVw+TRTZlBDEZ9e2qNjYr9d6QODiuV
         BGAw==
X-Gm-Message-State: AOJu0Ywfn+D35U8brDF2Ijj5cLPY7yNfjkwuVSZu1PbskXi8T2BAerRM
	fiLzuA4cghjPA7GPJBnDlIHyoK1fiZI4DpFzDaDHnsW/+JOgj0E1f5RAGrjP+cmGmaQmcEolMxF
	9vIPeWAkKwU7S9yyZx911llLkYc/G70S3
X-Gm-Gg: ASbGncuXxPCYNghCOQnP5a1dzM8PeYz2cKV0Ixpta7byBwZHBFLVYdR7d/gKdGwfbCR
	cWhaS6SgvvRaotioVX9KdWcXOFMN680+RO0eqQ4RFvf5Iwbn5ZULuINmeYUYxwAopcjJq0HsVaW
	ZOqXte67UeL1BVSx9x4CLW
X-Google-Smtp-Source: AGHT+IGlPSfd33Ivqbn8/WWgs0Xt6vQNlrptufQ9BTluKSsAP7Lsc3ICgX0nTKHfBI8IJRDmB41UBG9K/LxcHptY7ec=
X-Received: by 2002:a05:6122:370f:b0:514:eeba:517 with SMTP id
 71dfb90a1353d-51d5b3768ccmr24790270e0c.10.1737715090648; Fri, 24 Jan 2025
 02:38:10 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 24 Jan 2025 02:38:09 -0800
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <xmqqv7u5s9cq.fsf@gitster.g>
References: <20250122100319.2280647-1-karthik.188@gmail.com>
 <20250123112944.3922712-1-karthik.188@gmail.com> <xmqqv7u5s9cq.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 24 Jan 2025 02:38:09 -0800
X-Gm-Features: AWEUYZmEX2Bji65DDvlMWRQnl_SvnQ6QsD8_-mp8uRWTZeJtJUroCGWpBNqN38U
Message-ID: <CAOLa=ZTPy_gMkG0gPeasATdudynDY2uATvHUS3dpiqdgqZtR0g@mail.gmail.com>
Subject: Re: [PATCH v2] refs: fix creation of corrupted reflogs for symrefs
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, nika@thelayzells.com, peff@peff.net, ps@pks.im
Content-Type: multipart/mixed; boundary="000000000000b30f84062c7152b9"

--000000000000b30f84062c7152b9
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> Subject: Re: [PATCH v2] refs: fix creation of corrupted reflogs for symrefs
>
> This may be just me, but every time I see the above title, it read
> to me as if we are on purpose doing "creation of corrupted reflogs
> for symrefs", but we are failing to do so for some reason, and this
> commit is about improving the situation so that we can correctly
> create corrupted reflog entries for symbolic ref updates.
>

Okay. I see what you mean.

> And because the only sensible reason why we may on purpose do
> "creation of corrupted reflogs" I can think of is perhaps we prepare
> such corrupted thing to test how robust the production code is when
> seeing such corrupted data, I would expect to see a change to t/
> hierarchy.
>
> But the patch touches the code, not just tests, which makes me
> doubly puzzled.
>
> It happens every time I see this title and the change.  Perhaps drop
> "corrupted" from the title?
>

Yeah, that would make it much clearer.

>> The commit 297c09eabb (refs: allow multiple reflog entries for the same
>> refname, 2024-12-16) added logic for reflogs to exit early in
>> `lock_ref_for_update()` after obtaining the required lock. This was
>
> I do not think the actor, who "exits early", is not "reflogs".

Took me some time to understand this, but I get what you're talking
about. My sentence adds ambiguity on what we're exactly exiting early.

> Should we have "for reflogs" in the above, or perhaps move it to the
> end of the sentence (i.e. the required lock gets obtained because we
> want to do some operation "for reflogs")?
>

Yeah that would make it much clearer.

>> added as a performance optimization as it was assumed that no further
>> processing was required for reflog-only updates. However this was
>> incorrect since for a symref's reflog entry, the update needs to be
>> populated with the old_oid value. This is done right after the early
>> exit.
>
> "The early exit skipped this required work"?
>

Yeah, that works!

>> This caused a bug in Git 2.48 in the files backend where target
>> references of symrefs being updated would create a corrupted reflog
>> entry for the symref since the old_oid is not populated. Undo the skip
>> in logic to fix this issue and also add a test to ensure that such an
>> issue doesn't arise in the future.
>
> OK.
>
>> The early exit was added as a performance optimization for reflog-only
>> updates, and it wasn't essential to the original changes. As such,
>> reverting it shouldn't cause any further issues.
>
> I am not sure if this is even worth saying, as you already said that
> the early return was done incorrectly assuming that the remainder of
> the function can be skipped as an optimization.  What may help
> readers is to state that all the rest of the code path that was
> skipped by a mistaken optimization is necessary and would not do
> anything unwanted.
>

That was what I was trying to convey.

>> Reported-by: Nika Layzell <nika@thelayzells.com>
>> Co-authored-by: Jeff King <peff@peff.net>
>> Signed-off-by: Jeff King <peff@peff.net>
>> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
>
>> diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
>> index e2316f1dd4..29045aad43 100755
>> --- a/t/t1400-update-ref.sh
>> +++ b/t/t1400-update-ref.sh
>> @@ -2068,4 +2068,13 @@ do
>>
>>  done
>>
>> +test_expect_success 'update-ref should also create reflog for HEAD' '
>> +	test_commit to-rewind &&
>> +	git rev-parse HEAD >expect &&
>> +	head=$(git symbolic-ref HEAD) &&
>> +	git update-ref --create-reflog "$head" HEAD~ &&
>> +	git rev-parse HEAD@{1} >actual &&
>> +	test_cmp expect actual
>> +'
>
> Nice.  We could rename "head" to something more meaningful (like
> "current branch") but I can live with the above version.  It is much
> nicer than assuming on what branch we would be, which was what the
> previous iteration did.
>
> Thanks.

I agree, this is much nicer indeed.

Also I just noticed that you have already amended the commit message
and added it to `next`. Thanks for doing that. Happy to re-roll if
needed!

Karthik

--000000000000b30f84062c7152b9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 70a4b641e0d5c5ad_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1lVGJYNFdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMGNtQy9zRUF6ZzlmYXdnajZXSnZpM09RWWRaMk44VwpGMmhTREsyaUhT
OTN5MzVjWDRJOTlNcUVXTXZMcWF1SE54dmdDaUE4cXRJNE1vSSswSVJDK3VmUjR5MTROQmtmClFs
MUpST2JUaG9wRWlsR2tEV3NJcnlkcitxOGovRk94cEVHUytmTmUyQnVNV2xZaG0xVjlUQXBmVkI1
b2xhb0EKVDYxZTN0Q3A2clNMNnRNSkkwSGo2UVhmNjlwVTEyanE2Tm9sbWRhcFhSeUhCbWVEWHBN
eW9URTArWmlkTXIvMwpMbEdVOXpUVG5iQ2VrWmlZUG9KOEk0cVVxeHEycmxZVGo5TkxOcm1tcHUw
bzRDTThsbzNxRGt2aSswN0xCNUVwCmZSejR1TEljWDhKK3hjK21zZCtoa0lXVStNdEtTeFNjUU9w
SkJieVpUOFpxQmlma1ZQMTd0ZDBtZGVNTlYvK2gKUVkwMTFVVTdnN3oyMUpaaVFqbit1OS9NcmFx
VW82SmlCWWNkSjRlK0hPV3pTNWgxVkVrcG0vOHRIa01aNlpVYgpBSHBmMFgwbi9USkxmUmV5MDJw
MWZsM1Z0ZGxEeXBpZThTUHlXZzM2bTM3d01YeHVkcTFDbnNLK2IvcGozUGRLCnVycDQyaXRPUC9l
c2crcjFNYmJMYkpyRnV1VUU1RUFRZG9GMUdPWT0KPXFaWGwKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000b30f84062c7152b9--
