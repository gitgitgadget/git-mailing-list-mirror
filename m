Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E6631EB5E1
	for <git@vger.kernel.org>; Wed, 23 Apr 2025 22:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745446353; cv=none; b=dRuajJgoRGBTXYzkp1uo2zcP4UE2hKP6uIiii29kuOWzGG0ocyK2utwsa8bskwqCRlwl5/VwA9ihEZWpYe362Hv7w9TL1DEfDvtvj0dGTsWqDGUtkni4FM3aUQiBiRLXAEZXzBG8AkR0NAvK4qnWg9/EL3+KLxQhRduqHxeDdE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745446353; c=relaxed/simple;
	bh=JqNv/Pfe7v1P0xl5/7yAiE4/tsmnSpujs0BrTGYJSbk=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QQRLDrEpvRoUOByRKttF0FgiD1Ah4+razJdBDCib0bmxm3BNuUTMhgw7XdXhQZFo9XPHnW5Ef0DJyN1ZEGB9eZlxbycYscHryAJYsDDdZvJ7IYRw0rpBDyr0ikOavCnGy/srtd26xCPxqwIQ9kiRsgMIcHf7FYhJAxCgFLk6xJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q5fBJPpB; arc=none smtp.client-ip=209.85.222.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q5fBJPpB"
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-875b8e006f8so172843241.0
        for <git@vger.kernel.org>; Wed, 23 Apr 2025 15:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745446350; x=1746051150; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=TXrRCnd7x2U6FeH1mxkAFVOPjxmZIf06vvFf88i6dZ8=;
        b=Q5fBJPpBVVAutDV/v62SvtWBsmd7fee9AmTztcxDwNWSTp1n/6ODFI4dNVfRLlTIRc
         pgEf3emHR1tR6nvhAS2KjVBspGt/931wbrWHnDzdy568vMBz+9PTqLy7Qx5XqFsbim0A
         IDHM8CQgz+UID2NwSHoz8ULeojrJLdmNkN0UX433TtbmecwEtFQ2qo0R07+gBJkFw2Rx
         6exd8O2HDI8OKSaGS9pPe0mYMnpzAN7lBo7sBVpGlqSkWFAaXa8IBalOPXLRy4m2NSE6
         YmUZHoJwZGdFhk2RQo4UOYSy+7RX7TKVduWbep56EbA5vqJUpLh+82oeTa/yztFeWpr9
         ga7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745446350; x=1746051150;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TXrRCnd7x2U6FeH1mxkAFVOPjxmZIf06vvFf88i6dZ8=;
        b=Rh1exJi8IK4SCW7RFQOxRyJjtMA86Noxi5ZCvMP0PendszBl+JmhTqD6GjHv+jvMDI
         kRKZXeS9jHzbM6Baqz7T4h6NAZKHA3cMb9LsIK68QNRHiVJvg3kkWciywq4dI6gPICJr
         nGzQGVCBltJBxicPVxR89Pj4+tj9+4MVzLK5+gauqd+pkm+cuSuCnmS6dyrL9AdSqdmY
         VD9GGQM1YF1CZSCIgQY0ox7GMmYkE7QDybWmrw+WEEmzyS0LHqVboU5s124Gm2CPL3Ac
         /UFWRNwshZYRF6rRrSfI7otyZ5gSLzu626CWvCpd4X8tRDKseZHTc9UwwRQktGC/PrPH
         wxRw==
X-Forwarded-Encrypted: i=1; AJvYcCUpTz3G38HQbeHmReuz1CfAEKE3l+zYSn1lxht3Wh3eeMVvMPheB981Unk4orEgy5AWNHs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yza7wukIxoav7ud+x6xI5gwGDUtfJi1H43z8MlRypoHsDVYKcbw
	tNvm09gNbkEsDFVPzrghxRFe2qU/NRdoYw/cii6H+J9MFnFRRQvfFp7S/ZyckbleSHoLO5eJY7T
	kPA+X/K5p1j+DqSGN6PO81/IdPSo=
X-Gm-Gg: ASbGncvXh/cSXCeKEJbW4mBwpFjgOPcAfbk7qS6eNeeiqdfmyP2VwSzqP6+/CASYlbG
	LbLDT7FDfRmswIshawjwLCtsaWpBPP6cyfUVuBPYiX4YeCdajmc6w6qqBNqnM8HbWMM/YC2e8fP
	2SEsNaRjf6CRZrWvEsK+wsA68rEWw/z6407g0l9bOgUvF+QkQuXUYsV2j67NLLfG0PdL0=
X-Google-Smtp-Source: AGHT+IHKRjxei7JDE3nCmIxCh0uXecZGkkiLUohIwNzRVhJmySiO14rCJly86NPlZ9Wr+nhG8AydBXwgP9FZsgLZyCQ=
X-Received: by 2002:a05:6102:c50:b0:4c4:e3fe:4af9 with SMTP id
 ada2fe7eead31-4d38d820a3dmr773612137.12.1745446349716; Wed, 23 Apr 2025
 15:12:29 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 23 Apr 2025 15:12:29 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 23 Apr 2025 15:12:29 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <xmqqikmuwnly.fsf@gitster.g>
References: <20250408-505-wire-up-sparse-via-meson-v1-0-17476e5cea3f@gmail.com>
 <20250423-505-wire-up-sparse-via-meson-v5-0-d1e2be4b2078@gmail.com>
 <8a907622-a975-4f9c-86b3-54b8f5447709@gmail.com> <xmqqtt6ezshm.fsf@gitster.g>
 <xmqqv7quwsob.fsf@gitster.g> <xmqqr01iwruj.fsf@gitster.g> <CAOLa=ZT+hUuvdMbES_k8Pk+dLgrOovZB4fiRjJpS2AUrRrUogg@mail.gmail.com>
 <xmqqikmuwnly.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 23 Apr 2025 15:12:29 -0700
X-Gm-Features: ATxdqUGvcXf_mzidPtia9PHL9mw7QCHnFNv99Ii4pE4jqmsRlWy83E6N0EwhsAk
Message-ID: <CAOLa=ZTK+YFYSMfFwNc=YP5SvMaOa_wABv3G7_Kyi6iqTw74SQ@mail.gmail.com>
Subject: Re: [PATCH v5 0/6] meson: add corresponding target for Makefile's hdr-check
To: Junio C Hamano <gitster@pobox.com>
Cc: phillip.wood123@gmail.com, git@vger.kernel.org, toon@iotcl.com, ps@pks.im
Content-Type: multipart/mixed; boundary="000000000000a65921063379655b"

--000000000000a65921063379655b
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> Junio C Hamano <gitster@pobox.com> writes:
>>
>>> Junio C Hamano <gitster@pobox.com> writes:
>>>
>>>> As it takes quite a lot of time to do full integration of the day,
>>>> during which time GitHub CI is idle, I pushed this branch alone as
>>>> if it were the tip of 'seen', and it seems that quite a lot of CI
>>>> jobs are now broken,
>>>>
>>>> https://github.com/git/git/actions/runs/14624509129/
>>>>
>>>> with "Process completed with exit code 8." at the end of
>>>> ci/install-dependencies.sh step.
>>>
>>> Yuck.  It's JGit download that is failing.
>>
>> Sigh! I did test on GitHub [1], before pushing the patches to the
>> mailing list, so I was really sad to see your first mail. Now I'm not
>> sure if I have good luck or bad luck!
>>
>> [1]: https://github.com/gitgitgadget/git/actions/runs/14604710114/
>
> Yeah, sorry for a false alarm.
>

It's all good, CI reports should _mostly_ be trustable in such regards.
jGit downloads failing is not something to expect.

> With jgit download temporarily disabled, and with all the recent CI
> fixes (like Ubuntu 20.04 updated to newer version, explicitly
> installing gawk to fedora environment), most of the tests are
> passing again, except for linux-musl-meson:
>
>   https://github.com/git/git/actions/runs/14627488066
>

I'm really not sure why this is failing, I see that one of the tests
failed

  2025-04-23T20:37:25.0141268Z  764/1021 t7003-filter-branch
                 FAIL            9.00s   exit status 1

and I also see

  2025-04-23T20:37:25.0161574Z ./t/aggregate-results.sh: line 13:
can't open t/test-results/t*-*.counts: no such file

doesn't seem related to my patches, but again, not sure why this failed,
so possibly could be?

> I would expect win+Meson test (2) would time out again; I do not
> know what is wrong with Windows and have no time to dig further
> there.
>
> The tree getting tested in the above run is 'master' with these 6
> patches merged in, nothing else.
>

Thanks will try and replicate this on gitgitgadget:

  https://github.com/gitgitgadget/git/actions/runs/14629042372

> Thanks.

--000000000000a65921063379655b
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 2be6c24f7c661f7c_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1nSlpjc1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMExSQy80Mjc4WTAzQjJpRlhhUVdaOENiempaTWtXQgpaKzYrMDliM0cy
YVNYT2p2UjIrVmVpUUVVanNtcGtJeW9WWHp6QndSR1pVcXF6ZnJNU3VwWXhDbXRrdTdzeU9xClU1
aGE0bjZ5RFlSb2FvSi8vN2xRait6R0J4Sm9Hb0p0Z2lCZFRoQytQZ3BYMitySUZFekxoenRtUFNs
azVYWUYKbWthZXdYcTFBODEremlxSkN3cVNSREYvWXNxOFR1eTc0SHhReExkMUVmT1E1R3JLV3BD
OXhubjIyM1c1N05TbAozbWswaFVQOHQ3U0dZOTRoSWlCdDEwN3VjNU9RQXBkeUhYdUNaSWorLzRQ
ZXZWMWVORUozaHAwSDJmL0xWY3NmCjRwMk1WekZDQkhSQ1FIK1FVZWpFQ1Fnd3J5UjdweDlOMjE5
Y1lub3BIMnBYTUtIVzlkZnVYcFNWRjFNWWhzdmkKREZhU2NKNlNsdlVsWGgvdWI2SWluWnVwOU9C
Vzl0aWJZRFpOdEZNamdRTEt1dEhBaUk5OEZOWmZsOTVCNFBBRgprQlAzSU1tMGNXejJvTmk4OWd4
OFpLRXU3K1lCZGtObFEvTkhqd0pPMEp5QU1VRjZ2VEVhUjRJN0RCNGNwcmNaCjBWeWg2bFU1eldL
bytuYXRqQXNBNEl1QXo2VzlSUTRKOXJIY2ZETT0KPU1DTWUKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000a65921063379655b--
