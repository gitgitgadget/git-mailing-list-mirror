Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84C9A1FA15E
	for <git@vger.kernel.org>; Wed, 10 Dec 2025 10:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765361092; cv=none; b=MLrXkmffOpY2HRkDeIR9F7R/IJYkJj2Hg8Il93uzYQtJ9U/y247nmsSI7PiN0qIACLzReznXYmIFmJAvsQJG5OZzOrfWHzuCsmaPJ5z7DU5yk0H1Z6wrLq+FJxmB78cz/navkNYTpYPT3VyozT4Asa9NG34UdkE+D5mKWSa7bkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765361092; c=relaxed/simple;
	bh=7ENTQhxMX9HsD4Kqa3y5Fl7RVSDyQuS4QGLo7A3ghJA=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W8OnW0RHDTBVvnLg7QXZ+vGZgn5oVurws2YL6KFtNaVbYMKwCGyIoEuDZ6J6gOXAUT4sydAgoWuqrN87gYASOx+6aFfnZp9/JXCOIoJAnkL+yQjkqiWXWKvTi6RspQZnt0t1FrcqM/RUee2YLaNavoZ1B82CODZBSnj2qCA2Dx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EelWSsBW; arc=none smtp.client-ip=209.85.222.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EelWSsBW"
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-93518a78d0aso3753951241.3
        for <git@vger.kernel.org>; Wed, 10 Dec 2025 02:04:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765361089; x=1765965889; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=k4DlDEhBj1vAqjJzFcOR0B9uLR4Z76Lvxuci7uhhGnk=;
        b=EelWSsBW64sBmJJtixH6VwGoh1rdrYfUC47kdU5b/6AWyMKlRLtr7jsz3TeF+aLd2E
         +E8YzxqFW+QCrm5LNdEY7WYUHHQk7MN4hDcLvAPMbtx8Rouo7IswRljpyeZAft5eeyqL
         iS6cg5rugWjDhhIy7Vs2WpVuJ+VlC1vSV4wRy7OeF7H6mnop7U3t4p57Eow0/oXWl0oZ
         uKUL/wdLQXqwqwbLbGwRQjbKwJJlAn4B34bv/lJlDN0n3SzOtAHxeHXBQud219tve3By
         MNJytOFOV1JBR/wvW4HovgPEZWKCM7yuBD4N4R7Uc/W3H4HHxV9rRZkU9lmrKzkfMFCR
         p7zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765361089; x=1765965889;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k4DlDEhBj1vAqjJzFcOR0B9uLR4Z76Lvxuci7uhhGnk=;
        b=VS7yO1GrhuRr9mUBcGBvxiP6fgFZolW09LTj+YSIUMuMCQJDW2TZQo1F8jK+w8qX+J
         mknrp5pE86d9aR7gHtByXWn0x2YnHGhA7wEXgSXnB6g4ZMn34mnQCZUr0I11mtWk4KRP
         JV4f0E9xXSalE7nJoAWoHLD56oRZPd3msvfmDi+X8HP/G9MRRNJXeVSO135r9ehhBcRz
         mn4WdjXPhI5jmBJBemujgOZjUWymaHp3ONU1dqMDCI2W8KMtTkqsZwGS3nqLUUSN+fSq
         qr7aay4Ya5/sANXL7A2m8Zphi9KMkgk87o093zosLtp9M5JBGzVVj2G5RdcvzlJjd//v
         xH6g==
X-Gm-Message-State: AOJu0YyUnwVTYinkNKpb8h0XghsiK5g31BV/Zn/ZR2X4WMYcP5dot2K6
	KrKIcvpjgZBwdN8+ZXWHDIyed/EqmuLp5cPBmWd5a0pTNWqOd0ztID+j9RgJW0E1zh1jj7bS2Q2
	qWABkPqXBMErBMkF2TgCFdoIhVkIuE6U=
X-Gm-Gg: AY/fxX7a02n4WDc4PpxNMIgd5ViIYSTQ7i5eZB4nQo9Aa+28fsyM+5iePyBiz7OLt06
	Amfhcua9a34rUjx/8IWjslw3X81DdvowmT0qWWGBlOeb9gk6ldg6EEC5oyTMVoRWTGmAWSZelvU
	zv6+Wk6ozurnRX6zuVxOyXd1e+FswUoM/JlsKjE1m+UMbzJxTAalFs6nPQs3a5yp4pBLFZrx9cY
	SURsjWcPxGwkcbyHkgrhzGl+H864SrO8Kw+K8XQd7XV+8X/DndJsb9CrexUGiJzvxy9uaW2nrJO
	N+ENlOjAklfOaOjBrUW0sWthv8d55w==
X-Google-Smtp-Source: AGHT+IGS1TIuRGQHpP+crkW9XGXI5AEyxb1CAROnUGBA4kVPHzKjagIHVybdV3cxVigWo7IEjLlBdpHc+Lx7aWJffhg=
X-Received: by 2002:a05:6102:290c:b0:5db:1e80:7813 with SMTP id
 ada2fe7eead31-5e571f138c1mr568967137.43.1765361089367; Wed, 10 Dec 2025
 02:04:49 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 10 Dec 2025 02:04:48 -0800
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 10 Dec 2025 02:04:48 -0800
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <xmqqjyyvi743.fsf@gitster.g>
References: <xmqqfr9jjrci.fsf@gitster.g> <CAOLa=ZTeEEntiQdCnDd6B8a_ppJrrZqdURhQJV=bNktnp0JqMw@mail.gmail.com>
 <xmqqjyyvi743.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 10 Dec 2025 02:04:48 -0800
X-Gm-Features: AQt7F2oGI-Fc6tUZrffVCANnDYE6bSMeDKLpI2_mo6P9D7EVwra9BaDu4gKLdXc
Message-ID: <CAOLa=ZTAdpRurHGiBj2rQhtBJxuWPz4__2Q1LgJ4rC2qAdL=0g@mail.gmail.com>
Subject: Re: What's cooking in git.git (Dec 2025, #02)
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000a1e8380645962806"

--000000000000a1e8380645962806
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> Karthik Nayak <karthik.188@gmail.com> writes:
>
>>> * kn/ref-location (2025-12-01) 2 commits
>>>  - refs: add GIT_REF_URI to specify reference backend and directory
>>>  - refs: support obtaining ref_store for given dir
>>>
>>>  A mechanism to specify what reference backend to use and store
>>>  references in which directory is introduced, which would likely to
>>>  be useful during ref migration.
>>>
>>>  Comments?
>>>  source: <20251201-kn-alternate-ref-dir-v3-0-c11b946bc2fa@gmail.com>
>>
>> I'm currently on leave. While I do plan to work on this, my next version
>> which is based on Patricks recent review will be a bit delayed.
>
> Understood.  Thanks for a note.
>
>>> * kn/fix-fetch-backfill-tag-with-batched-ref-updates (2025-11-21) 3 commits
>>>  - fetch: fix failed batched updates skipping operations
>>>  - fetch: fix non-conflicting tags not being committed
>>>  - fetch: extract out reference committing logic
>>>
>>>  "git fetch" that involves fetching tags, when a tag being fetched
>>>  needs to overwrite existing one, failed to fetch other tags, which
>>>  has been corrected.
>>>
>>>  Expecting a (hopefully small and final) reroll.
>>>  cf. <CAOLa=ZQ-O7V9qHbgeuQ78R1bHGDmGEM6fP5Kr9aC0AfvSF8MZA@mail.gmail.com>
>>>  source: <20251121-fix-tags-not-fetching-v8-0-23b53a8a8334@gmail.com>
>>
>> The only change needed from the last review was a typo. I think we should be
>> good as is.
>
> Meaning that we prefer to leave the typo in, or just we won't die
> with a known typo?

The typo was in a comment in the tests, so I thought it wasn't worth
re-rolling, but happy to do so.

--000000000000a1e8380645962806
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 880cc1dd2ca7e174_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1rNVJiOFdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mN0NXQy80c0JNdzc5VnFiUXlJQUY1R3ZPSEI5SDYzaAo0ZkVidHdQejMz
NWVkUjhucjRHVi9SWTN6eG81aGZwUGJKMTkwZHQzNjdxWHJiQityMWNxTUtmU25VMVI5eCtWCnY0
YzRaVE1kaGhicklTbUZSVGZVZUoyZEVSRG5zUEhsaWQwVzdHdHBPd2ljMi9WUmtTWWJac2Nobyt3
SG1HOEMKZDB2RDBvZmZQelA4WUZHWk9TOG1PdGdRRFVEZnhkQUt1bGl5WG1jMEVkUVMvbWRDb2JP
N0tXQ3FUMGFzYkJ6bgpqdkRIeDFEQTNQZ0ltQ1Z0a3hCeU8yenRiek5EM2R4MU1LVXErZDB5RDd0
QUs2UUFjYXNjdFc0SmFZdW1yLytnCnlBd3dTems0M3d6TXBLL3czL1hZY1ZnQ0RtbXhlS09qSHo4
SE0zYWlBSFJISDFydzdVSHhEcENBaUVXTXc4MGgKK3dzdnRWMmhKRVdJenkwTW5mRlJubzQ3QWFs
SHY2enMyMm42dHI0bEg2Z05RRXFUVk9Oc2gvUDF4ZERwd0g0MwpXaEFUVU9FRzZ2K1U2UURuSmVK
dzYyYUNQM2RmOUZnVjFOeVRkUFA2cDk3VXdITVZka0UwNDAyT1dhM1RTTGFaClI0dHBpbDhsNElp
Zm43NFJ3TjNVOGhBWUlaSkp4N1FHSElCM2dGND0KPWJNbUoKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000a1e8380645962806--
