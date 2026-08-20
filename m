Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBE34233954
	for <git@vger.kernel.org>; Thu, 20 Aug 2026 21:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787260564; cv=pass; b=WL3pHVBQAWdUKgP9Ce2KThQnoZ5+Ml6XQiBaGEMt8elRvqYf8yOzwnh0jc25AY51Edrh6SpCYqVIX2QYXY8us36tpi5EDuD1ioRkFVSgmp5gbFAhw1RYyTLfIXG1lHnZu7EsmDMKtNfNJLZGE/vnAS8aG+pqN7tA03T3e87/up0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787260564; c=relaxed/simple;
	bh=W5LZ9zcdrdHHOvguXnjI0Q1PSwK9G0nv+q79P/TZ+is=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MAeJIyyC60lMPusBFSoCBlF6aaZUuurUgvAI35KJutkz/6aODsWIlO5BJyq14ZzMbLS+WLsZ7FXTAB3/7wsYBoyjxTa1C3TN9H3mccbOSbxFBUVjpIPohhfw0egyBSLAOrFOibe3N/ZGuqfYeYaJy7iOtt8Hfmm333dZ6ajpzxk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K3L4JBc2; arc=pass smtp.client-ip=209.85.217.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K3L4JBc2"
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-7389cff36bdso141861137.1
        for <git@vger.kernel.org>; Thu, 20 Aug 2026 14:16:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787260560; cv=none;
        d=google.com; s=arc-20260327;
        b=bsDfR/9k6/gyTx0r3Ysk25atN975rzCYLc4hYDbqjKgET5TWiW4aZ9TpDBWIOzGhbK
         t0moFJ0aILxNxvE7//W/GZ7JYi9CDgZC+ChNtR8tNuF6RX4U/gUD5QmaE4/dvntlGfm0
         qchspcgenF1la3AD/gkuO7lRv7tr/9dZlf9kpaAQRL2MAD9qqbvE19paM7GBHUH2W2GK
         RS+im6mRILgsGXRwQpYRzxeis8M3Tx+KQT6IbTdNvxdilU1Ba1gU4xxkd+heoI9WLh90
         z0MgZYUjg2CrvRQFfs5L3G/BxjJreVZmN8+xEQxdwwSIvDFjuwkeOMJHWEfVoVU1uG1F
         ucaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=wqzRC37m13/N0VAR0Xs7WYfk7Vc4ezJCTiyyZehVdio=;
        fh=srcJZvoPaibvbIlhT283AwHZnyoMxgxRItf21iMUxkE=;
        b=RLWvZedy5MgBRYxgzHW4lCBG5IHAQQaATszHL2s9flRwipgsbyIs0FXLnOmREFECvF
         lOfI8somWhHJbqNbImaj1KmoX+avwNk9iGCaEn5/daMgVBDRMagmFwiHQXHlhC0tRhTy
         GpdIaaE9CRir4DPX/50Tkc3KS4cjCV2wfcwx2FOcuG0g3sm4frq15lODv14wdSg2/AYs
         fwzL0pDJGwQiBt3Wx3XOJZmAI49LTRT0Gnv7glM6w1pFc69Qr06fJ2UdZNnv+qvm2AdT
         6mkXl+6yEOnKzgenh4uIulPjP4wg6ioIpKkMOx8BvswCmRpaMfEMvC9Ig1HhUwz1p5EJ
         AHTw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787260560; x=1787865360; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wqzRC37m13/N0VAR0Xs7WYfk7Vc4ezJCTiyyZehVdio=;
        b=K3L4JBc2+WzVYogmCdPL6AKApjX+fRKjl5/jnlOyutY/wmmeVmc/GKw/9cU++wlwja
         hwnG2hR5Bz5S2U5Qn0jsjbY4CLMgK3aD0gbh5zgQEPAPG5YNnrx61lgB9AGCJtyFY1iR
         BArBNqqXhYCrQPLOgMmX/4f5ZqHVAEHA2Jo/echZpa3buD/umXsvUSZitPnD6kK9c3Rn
         klFFj+babSFsW8ok8/m7JKk/MKYUfZvpVY6l3jzz0Gopk0nC56IyDBW93jrYBmOoIxUl
         iHwWkUXSgBaiaUhKj48mpmW+PnvsO0tPQGj/4iq9dN26AhIm/cO1omuolDmBrt2v62EO
         X4Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787260560; x=1787865360;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wqzRC37m13/N0VAR0Xs7WYfk7Vc4ezJCTiyyZehVdio=;
        b=WBVXdRUJJW0F6W2ZS17Ov36BZ5he8NZNE239myz7cytdrrz7xSuABc2UpHht/S5v3J
         dZw8d1fHfL/7FBZ0mw9ciXaZPwcHEtllLPFM3W4QTVP7RcHA2B/oEsI6MPtCp/f9E5TS
         X/279Cc+MLmricvVbX7bo090sub1JdTaTgvaj4OnQ/Pq8JahkB0j+udzCHBAS1hqOoYP
         F9F/fYbHuTISozfkb9Jv8mwZXJXwlJddpkF0McNsJgRfpmUmbdXP+dWO447gfYRhWWq3
         QJ2+jDetQ9xz+h1QKiNWFvfZMBZ0ZylOsAgIVcnj51m5qD9BV1T7r4/GB36DSa1grc3a
         3rYg==
X-Gm-Message-State: AFuF++lM4Y+wARq7jEV6MsB3CL1VvJaWTDnR22wCXxyspuRK/R9VF7T5
	A/E0I7z7vtGkehbyO03WcfNzo6NC80Pbk9xcR5C6lGHg+XjemIq2ouG62h/3hEmK7ew2glcI/tn
	JwWAp5xDovi3qOvMw6ZRb8CDijnJ0p2/eGHvD
X-Gm-Gg: AR+sD120hdSgVwXydkGjuJkWagcfpiRh9MGl9OEJvVgCEHJ64GT1On7dIT0iuBSPGoA
	5i38UdVMYxHADy0R6pN0u3s83OOctjs4AjaJqH1KA9QKM2qyKpRb5H6cTRkzqKW6exW+2BpxLc2
	LRj23cH5PL1IIVPqicq+OI9MNQAB4zwGOwyNKDZL4BNYJF+2dwPOxtVHuByo1owzIOPBpx97wGa
	9/q/EktIrrHMwuY0xSIHf+6HC17PtH0xMuAM4HOEkM/CoOBYcKGulwiaCSFZ9yQTQ0jVGoSKblt
	Lv+bp/K0lEehhgk4jlWUd8rriBEaSRUUNbXs+TT79GknV8pqH7JRyAaFWwb8ES+jPkX7a800vIm
	y1S1g8aMjhPT9rYNrdwGOTIwJ8MAqmMP74ZkRECTBb9HVLZA=
X-Received: by 2002:a05:6102:2b88:b0:77a:3431:669f with SMTP id
 ada2fe7eead31-77a63f32c5dmr716337137.7.1787260559734; Thu, 20 Aug 2026
 14:15:59 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 20 Aug 2026 14:15:58 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 20 Aug 2026 14:15:58 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <aoXUrsAiDvgS2s6H@denethor>
References: <20260819-740-optimize-reloading-the-reftable-stack-v1-0-6bf5305d4e43@gmail.com>
 <20260819-740-optimize-reloading-the-reftable-stack-v1-1-6bf5305d4e43@gmail.com>
 <aoXUrsAiDvgS2s6H@denethor>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 20 Aug 2026 14:15:58 -0700
X-Gm-Features: AcwNN1WKaT6p0NTKd8yxkzZwXkVH8BBhb9jdDkaEORMFgsGzx9306koKaF-Ny48
Message-ID: <CAOLa=ZRa9Dfdoj4XCpjhDJRn_mqyZ+91LNi5KTocyi6OrbsHbQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] reftable/stack: remove `REFTABLE_STACK_NEW_ADDITION_RELOAD`
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000c8d6cb0659810686"

--000000000000c8d6cb0659810686
Content-Type: text/plain; charset="UTF-8"

Justin Tobler <jltobler@gmail.com> writes:

> On 26/08/19 03:19PM, Karthik Nayak wrote:
>> In 80e7342ea8 (reftable/stack: allow locking of outdated stacks,
>> 2024-09-24), the `REFTABLE_STACK_NEW_ADDITION_RELOAD` was introduced so
>> that callers of `reftable_stack_init_addition()` can also reload the
>> stack if there was a concurrent update made before the lock was
>> obtained.
>>
>> Then 16684b6fae (refs/reftable: always reload stacks when creating
>> lock, 2025-08-12) updated all of the remaining call-sites to propagate
>> this flag to ensure that we always reload the stack whenever there was a
>> concurrent update.
>
> Ok, if all call sites already wire this flag, then we probably don't
> need if anymore.
>
>> As all calls to `reftable_stack_init_addition()` inevitably propagate
>> the flag, it is safe to remove the flag and its associated code and make
>> the reloading of the stack the default flow. This makes it easier to
>> follow the flow and simplifies the logic.
>
> Makes sense.
>
>> The only exceptions are:
>>
>>   1. Unit tests, where we explicitly do not propagate the flag. These
>>      tests are now modified with the new status quo.
>
> I assume this means we no longer need to test for the case where we
> don't reload.

There is no longer a 'don't reload' flow.

>
>>   2. `reftable_stack_clean_locked()`, which was propagating 0 to
>
> Did you mean `reftable_stack_clean()`?
>

Good catch, `reftable_stack_clean()` calls
`reftable_stack_clean_locked()`, but I should have mentioned
`reftable_stack_clean()`.

>>      `reftable_stack_new_addition()` but was then manually reloading the
>>      stack after. Here the new flow will achieve the same, while also
>>      allowing us to remove the manual reload.
>
> Out of curiousity, was this call site just forgotten previously? Or was
> there any reason a manual reload was useful?
>

My understanding was we added the flag at first for a few sites and then
expanded it. I guess reftable_stack_clean() sending in 0 was the
blocker, but we do indeed reload the stack manually there.

[snip]

--000000000000c8d6cb0659810686
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 75399f44e92c05ea_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1xSGJvd1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1meXliQy8wYWp1a0MyZzNGQVJOQjlqMWVHWnY1SXhLMQpBb3cyaE1tYmJK
SnQyNXJmV25NUzErdFFJUWV6U0NKSE5Va3kzNU5GS3NBa1JmZTB5MVJlWnVFM3hKY2w1M0xyCk1p
WXQwN0dXTVFQbFVwWmNNWVYxc3pJZjdHTjNmWlFuSlhUR0ZvSnhhNTRrbHdCNEdXVWdiUUJwY1k3
MHYzSmoKdFVuQ3J1a1h1Q1V0ZXVPM2xHVmVyWHNYSnVzendQYktTOTFmTEtFVFBNSjhuZWNmbExF
UlB1aXhIU0V5QXAvcwovTzVydTkwMitKNFdFLzNCOU9NVHFWL2RoT21wMzhGWlcwMVJSN1B2TGQ4
Y0JvcmY4SHIwK1lCdDJrbnNpKzNHCndrSFBaTHJPRjJPV0dNM1pjQzdFNzhuSWo2djBQQjlXRUU5
bnp5M1Z1aXVaaFptYm9OdlhZU3VsZjRidWlmeU8Kb0xQTk1IbDFSMFFyMnBPVE1ZUWdaYmJNSHJv
eXV1bFdVMlZvd05rRzFzdVlHYlJNUllCcHFtSlk3NkRjZE92YwoyckhiTHkwVHM0MmlDRTZhQjJz
R0diT01rY1pyeWFQbFkzOXdHdUZIdWhpQWgzdWk5d3MyWm82bjhVNWludkNBCjJaUVprSnNEM3U4
a21ZV1pZcTdJdTdtN29RSnZNdFdoY0w3Q3QyTT0KPWtldVYKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000c8d6cb0659810686--
