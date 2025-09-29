Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C37A81EBA14
	for <git@vger.kernel.org>; Mon, 29 Sep 2025 14:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759157274; cv=none; b=ZCVoxcSlDsf9I8+tTVMkJ8kKRymKY3wUwF443nRCSeGl8lfbmCF6LTjVQGRl6Mxez5V3ayoHrIjDXy6/EFIDvqG6ieiQMxP+j5Nr8Tq563t3aL983LJR+1v44byLelPvZaxmw6eN1dUI6thym/cznVVAe8asI7JBEg+X9cpXQAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759157274; c=relaxed/simple;
	bh=tUr5It9yCjZ0g6UAMSzpmhqam9mM/9H6U6cPfVcWkA8=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ou3/MVe5ZhIcsXFPLH809tJMfL1tWUQKaotmoksrhMkpFmOnSGuuVKgWFwacQBefMoTO5nwnLxSy8XmxM3MIkBQPtM8NhF3tkqHwG9rWxlTDf/+tvFGVg+B+4XPLoCI0HSXVN9B6ep35eBNEPIN5iomAsWNQsTazPuaP5oJECqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jjp8tYgW; arc=none smtp.client-ip=209.85.217.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jjp8tYgW"
Received: by mail-vs1-f54.google.com with SMTP id ada2fe7eead31-5c7fda918feso1344813137.0
        for <git@vger.kernel.org>; Mon, 29 Sep 2025 07:47:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759157271; x=1759762071; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=8P0Jlt1j232DGnwvoVAETaEwZWjGPaIuBkMos5LwioE=;
        b=Jjp8tYgW36hWZMrRimrZP7GXwr8UJtXtPHF8VA0D54lKpfRgiL2Bo/a9D0bB8HFi/r
         Zqg0wkqR5hRXnRN6pK0xOgL30w05MOF/xOqHBRAytv2Z/vH/uWsTvkvwSIlhFxMzSUeW
         v5eYP5ChIEz/xiai3bpZA9iV98qrezSUxpp9/iU4w9pL4zGn2LPM57rQvUv4xVKxDUqC
         dqaMOuyuga+l2uLAvrZH4ftH0XBkTZcxf86N+xtv36bqGhonsSIDw7D3iCTPgoOPPAsd
         EU/qWBSs2eEDfSrzB+sW8Fw+BitexDKpg0jdZ5r5ycIJiLVV1B89QBjMM6eStQSzlXvz
         Pv6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759157271; x=1759762071;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8P0Jlt1j232DGnwvoVAETaEwZWjGPaIuBkMos5LwioE=;
        b=tjBrGp8KmYW6Wemuhna/6U7JYtNeLVd+aOi+32XRU/Sp9Yb84vWcvbzzo+I+LH4BBx
         GmKsfTve2HIkGjtagVhynRoTG7Yjuq3g3OXdT6H3kj1CwFkSY7efSWr0SpCu8cDOskNz
         +JtThM8K9V0DI+e0HsnMfc6nt7dRSVV5y75LZzHGjLGf0NtFDJDsreSiaQg8q6ZdoTSf
         qT70XatJ1N3/HhNkOXkgK9jlYMmGOJSqNni1Fo8BzXqIm8naIDi6xj3mZRPfjziinli0
         S8wzv6K8zmFF5lQFRlMpomkDk+WSIhxYOXHVMq3UIgzwxgNAkz79b3mC4roCqsJNABlM
         jMAg==
X-Gm-Message-State: AOJu0Yw50d/MReTugMDDL3/cmkxGJEwxHvRhGDmeMkWM/hgG0BuPaQoM
	9VlfsMJz0lms3FFHjBTqRRyN+d+AQP+pXE+SLBwFjp6OlUZzw7VqZn2ATJa9jJ63FQVimFBmoWs
	XAVPRrypT79CAKSULcwpNBu0lDtYjbxNpzGeA
X-Gm-Gg: ASbGncs6rxvDsQr4x5ks3HZFAzLXLKp557wgez6FdLAiH/1iuCx8b/gX8OSZ50Mw4rK
	arqhLBlFow4M+RHURHAKbmz0+DerGQWio8ubGuwwZps4PPplUJRK9sPNoawwiRF2oQmaIboaclt
	uWrfOPeTqSz/SDT2g0rF3rK4OPbOrV7nKmGqrX8nX7c4Tvwz5utKaH9m0TevE+7m58zg57ZUw/e
	WjK3zwxwSg4cKKZXpxT39wQ4y/gLEy53vLBX2gwPw==
X-Google-Smtp-Source: AGHT+IFT5SjN/pQ72Vce1drtpH2ew2aDnmF7Xd8SRWzLfU49eGSV483FEEop76qej/8BRvKvRleYVXhd2uIBCJfzWsQ=
X-Received: by 2002:a05:6102:c4a:b0:5a1:8e46:5c8d with SMTP id
 ada2fe7eead31-5acc76768c2mr5964355137.6.1759157271307; Mon, 29 Sep 2025
 07:47:51 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 29 Sep 2025 10:47:50 -0400
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 29 Sep 2025 10:47:50 -0400
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <xmqq5xd5ch1h.fsf@gitster.g>
References: <20250924-583-git-for-each-ref-start-after-v1-1-c73be2b5db5a@gmail.com>
 <20250925-583-git-for-each-ref-start-after-v2-1-3613b5a27ff1@gmail.com>
 <xmqqbjmyh353.fsf@gitster.g> <CAOLa=ZSfL1CVCNjD0Vi3kpQqLM6t7YVa=G2ChGpaza6WOjZTCw@mail.gmail.com>
 <xmqq5xd5ch1h.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 29 Sep 2025 10:47:50 -0400
X-Gm-Features: AS18NWCnUyPKQpo_nVs8SW7v5rYr5Cf6yyXsNG2fuGoZpNr_JhSVTEj_wppjiBo
Message-ID: <CAOLa=ZSB90Ne=8VdJcXX0U9MhSWGAi1tTdzAkE9KdE=XuaOBCQ@mail.gmail.com>
Subject: Re: [PATCH v2] refs/ref-cache: fix SEGFAULT when seeking in empty directories
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, ps@pks.im
Content-Type: multipart/mixed; boundary="00000000000042cb39063ff1b884"

--00000000000042cb39063ff1b884
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> This wouldn't happen because before the loop starts, we set:
>>
>>    dir = get_ref_dir(iter->cache->root);
>>
>> So, `dir` will always have an entry (i.e. 'refs') in the first
>> iteration, after that, the checks in the while section  of the 'do {}
>> while (...)' loop will kick in.
>
> Ah, OK.  So we know dir->nr != 0 when the loop is entered for the
> first time.  We may descend into a new subdirectory and at that
> point we might hit dir->nr == 0 and that is why we want to catch it
> at the end of "do {} while ()".  Makes sense.
>
>>> I wonder if we can leave at
>>> the beginning of the outer loop, even before sort_ref_dir(dir), when
>>> dir->nr is zero, or something?
>>
>> We could add it there too. I can't see the merit of one over the other.
>
> No, I don't, either.  As long as we know dir->nr != 0 upon the entry
> into the loop, the check at the tail end in while() is sufficient.
>
> Thanks for clarifying.  I wonder if a bit of update to the log
> message would help future readers of the code, though.
>
>     When using the files-backend with packed-refs, it is possible that some
>     of the refs directories are empty. For e.g. just after repacking, the
>     'refs/heads' directory would be empty. The ref-cache seek mechanism,
>     doesn't take this into consideration when descending into a subdirectory,
>     and makes an out of bounds access, causing SEGFAULT as we try to
>     access entries within the directory. Fix this by breaking out of the
>     loop when we enter an empty directory.
>
> or something?  I dunno.
>
> Thanks.

Yeah, I think something like this would be much better, I'll amend the
commit and send in a new version soon.

Thanks!
Karthik

--00000000000042cb39063ff1b884
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 41e4f9413e7eb5ed_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1qYW5CTVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMmEwQy80Z2dqUzNFUnRiVzNwbmc3VzJIQXdmRDVDagpuU1VVVHZGT21z
ZVNVV1hUZy9ZNC9kbXNYL01kc0M4VHZqWXk0UDVuVUhHMnNlclVid1ZYYndWMVdSRUFacnhkCkRi
MnMrT2NLcmlvV252L1pNUW1tMXYwRlZIdlpGcjBzazF6NVp5cTRFUTVGWFZTdEN1L3RrcFBEMEF5
OExQYWcKMndXTDh0eVpYWXJ0bFgyOWVOOTkvclRhRWlBRnliQXdjMWQ4cGJiZncxVmhEYmhURzlh
cWFMaC9FQXdDU0tDVAplZSs3ZTVPZ1FoMXBLa0wwWlEyeXk5aEx1MGN6Y0pEQXNjeUJuWE9USVJW
YkJWTjBrRHg4SE9PajN4emJGSC82CitkL3NoMVdPVzBlbExNMlVDdUJOd2tPUW1xYmZHcmhMRTRv
SzBGcnpJTUxUSjQzWWV6Y1RNU0JDYmFDOFhjY0QKb1dMdGZpc1JNTTRCWUtqZUYyanNNTXdMaGxY
WS9TUjFDL3N1YXJPbjlqcDRRQk1mM2EzOGxaTktwMVR6VGdyYwpNOEpQODIvS1NOZ2krSERQMk9y
S01KdmUrQko1clJncWZqTVphaTJJZmxydkVHYmQ5UTBuWHkvM3N0ckpBNC9wCnFIZzliSC9OQW8x
SzVBMVArcUtISjFvdmtrVldMbEVHV3k3Y0crMD0KPWJaYngKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--00000000000042cb39063ff1b884--
