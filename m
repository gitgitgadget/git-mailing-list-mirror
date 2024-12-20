Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 084DF1BEF63
	for <git@vger.kernel.org>; Fri, 20 Dec 2024 11:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734693812; cv=none; b=FEJE9Fjrh69xlkC7+ISZs6w6UEhPaKBLs6RKLhk19jmal4pJLHpAa4lR75srF+jrPPZhhXEcL+QFNruGvfJQspRRWzHXFSHXzx30W9FCBlJMLv9bu5u27pEEp5iv3QA26MbKuzxddxp52pIfKxr/F4NllgWJ1v/wmtamIRRJbhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734693812; c=relaxed/simple;
	bh=h0rH67niSIzZUa10oGdM772sNK4VyrHlfm3R8Xj2N0w=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dHf/PLRjoBvaMPf3JBEN3N2a2IzNzQxXa5U9Lbh4eWwnTtfI8GFqT5UVnpRWRNhllIGWctxx+1LchAdautqEliOpN8BtbU0lDDBXi/f7LBhOMTdr5NCdMfY378vm2KJwypKlw9EDpcdeURxCGSpsfdYU+VXyCTP0x9g3mdR8dxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YZv+wSTH; arc=none smtp.client-ip=209.85.221.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YZv+wSTH"
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-51623968932so958037e0c.1
        for <git@vger.kernel.org>; Fri, 20 Dec 2024 03:23:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734693810; x=1735298610; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=B5O3OzAVx+K7F5nxKpPDbWizfTcnlz6EDYfPF6chXxM=;
        b=YZv+wSTH1lFPBhGYsGpA64GZqhT7AT88SFUE5HZjBCxEJei3/IWcgnL4OIFLgxJ08J
         4gFCScT5KEVXdlRo2uIS2MeJkbn9NRWwZqIhJqDbk+xBaZ1y8VMGRRQyb9Bt29DsDTcf
         Ga8S2JgVqagZ8TBVBWPo0qYpzWUdM+y5+v/LhsEo9QSNwHQdHcezQf8Bd1QQQiJ56s79
         n+yZJCj1OSROuaideNRG3O2o1uYUOlIaMYNAIy1dQLMHti5NbjjlSzChxpSbnNpTT9sT
         5feHkk3+ivMBQSRJkqLMklVVsA0MP3d+mBVljXgWfxBMWbL8+FphsD40y7KV2vhGzdEA
         tDdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734693810; x=1735298610;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B5O3OzAVx+K7F5nxKpPDbWizfTcnlz6EDYfPF6chXxM=;
        b=OlLjw7hLnMyewGJkS1JdBI0b44hh+pvST9JrKqNoN35Gu/QR3o6z0iZh5FOHVE3DqN
         /K7ydQaIzLQM+DKzXupQIB13RX8isOLisTr/9k2d+VxVkYjoNjBFce7Ne/hr7J8axVnm
         kR6lcuJfisNIucxUOVQ+r60XXeOcbF5D0ctZJLj5fBjDP9o3a23c7HLocM6ZlX0TGlEz
         5sq/hRYXn05eB8ip/y9YndkRKqFtI2Kye4NWCsaV2ATmz6XkEPbJNiaSH/v4cRjuTcdR
         4zDwrIORFvyy0811TH77mrYcYrx2Ye0v/ow5hb+1Q6e1zrlA0D2B7EycrFA8PCMc8jEZ
         IHpg==
X-Forwarded-Encrypted: i=1; AJvYcCW/FK5t9nztBIHBzcFsJ5YhGCNk9CyvWqhG5oErLXpVWZHWq9DM+lMknW/bNLhPnpLwIjs=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywhh9WH09GyHOPm6kcIIfox0Ca1As59HWW9zF/kgVskl/1RvVbT
	O4lFuCHXLaLXrjoTm2yGP7i6s8nb4Gv3MabM5v6Ojjjo32wC6IuXxrivA6Szdt53vFbj/vCNYJA
	9oB+ZcuX0FZ4d4ovHhFHxjqEVL+Q=
X-Gm-Gg: ASbGncsBCnJ0p+hrCXhLTS/1o14j/6XjWiBkrMF8BVaQay9rVTL+zPtoaf6bBL2s+hf
	rn0GV/y4qd79ZscnOTnQ1qsc7gGWnT0G/qT0v
X-Google-Smtp-Source: AGHT+IEx5xJ2kPqq/c0eCudEHxtgTbxPY8a3NdIJuXNbtIqBLKMIA8feUF3R8tbCStCMlr3MFHxOy2WQsiuC3isZszQ=
X-Received: by 2002:a05:6122:8c15:b0:518:9582:dba2 with SMTP id
 71dfb90a1353d-51b75d67f88mr1678974e0c.10.1734693809860; Fri, 20 Dec 2024
 03:23:29 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 20 Dec 2024 03:23:29 -0800
From: karthik nayak <karthik.188@gmail.com>
In-Reply-To: <874j2zh3jv.fsf@iotcl.com>
References: <20241215-320-git-refs-migrate-reflogs-v3-0-4127fe707b98@gmail.com>
 <20241216-320-git-refs-migrate-reflogs-v4-0-d7cd3f197453@gmail.com> <874j2zh3jv.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 20 Dec 2024 03:23:29 -0800
Message-ID: <CAOLa=ZRcp+OxiQxYGJeQ8AEWNk-6SkrRsZdi8bnNtNaWe_zrhg@mail.gmail.com>
Subject: Re: [PATCH v4 0/8] refs: add reflog support to `git refs migrate`
To: Toon Claes <toon@iotcl.com>, git@vger.kernel.org
Cc: ps@pks.im, Christian Couder <chriscool@tuxfamily.org>
Content-Type: multipart/mixed; boundary="00000000000054dd510629b1e03b"

--00000000000054dd510629b1e03b
Content-Type: text/plain; charset="UTF-8"

Toon Claes <toon@iotcl.com> writes:

> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> The `git refs migrate` command was introduced in
>> 25a0023f28 (builtin/refs: new command to migrate ref storage formats,
>> 2024-06-06) to support migrating from one reference backend to another.
>>
>> One limitation of the feature was that it didn't support migrating
>> repositories which contained reflogs. This isn't a requirement on the
>> server side as repositories are stored as bare repositories (which do
>> not contain any reflogs). Clients however generally use reflogs and
>> until now couldn't use the `git refs migrate` command to migrate their
>> repositories to the new reftable format.
>>
>> One of the issues for adding reflog support is that the ref transactions
>> don't support reflogs additions:
>>   1. While there is REF_LOG_ONLY flag, there is no function to utilize
>>   the flag and add reflogs.
>>   2. reference backends generally sort the updates by the refname. This
>>   wouldn't work for reflogs which need to ensure that they maintain the
>>   order of creation.
>>   3. In the files backend, reflog entries are added by obtaining locks
>>   on the refs themselves. This means each update in the transaction, will
>>   obtain a ref_lock. This paradigm fails to accompany the fact that there
>>   could be multiple reflog updates for a refname in a single transaction.
>>   4. The backends check for duplicate entries, which doesn't make sense
>>   in the context of adding multiple reflogs for a given refname.
>>
>> We overcome these issue we make the following changes:
>>   - Update the ref_update structure to also include the committer
>>   information. Using this, we can add a new function which only adds
>>   reflog updates to the transaction.
>
> Out of interest, I see various changes happen around committer info. But
> why is the committer info more relevant for reflog updates, in contrast
> to normal ref updates?
>
> --
> Toon

The committer info is metadata around a ref update. It is only stored in
the reflogs. So they're only relevant for reflogs! For e.g. in the files
backend, we can see:

  $ cat .git/logs/HEAD | tail -1
  7a929cb27ca6df69d4db64b008e27e002c691028
bc8e00178b671da2b845ccbba175f6c093ed6949 Karthik Nayak
<karthik.188@google.com> 1734624674 +0100	commit: c10

Here the 'Karthik Nayak <karthik.188@gmail.com> 1734624673 +0100'
section is the committer_info. Whereas if you see the reference itself

  $ cat .git/HEAD
  ref: refs/heads/master

It only contains reference information. So, the `committer_info` is
not needed for regular ref updates. Earlier we dynamically obtain the
information when a reflog was being created. But for migration of
existing reflogs we need to pass this information from the source to the
ref transaction mechanism. So we pass the `committer_info` through the
layers.

Thank you for the review.

--00000000000054dd510629b1e03b
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: a0a3ee133b24eda8_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ0FBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1kbFU3QVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1md1QwQy8wUzh3M2M2M1Y3NGwwYTRvQ0twSDNZRlRTSgpubnpEZmcrTUo3
UXVsRXh2MXFNU0ZpNm5ZWElkN0dIdFM1UnZNd2RZSERLUksyOTlsdXAyRzRld3BxdjlrUlM0ClVm
cm5xS2VXcVNUUVJOenBBNEcwcHhoUjZSMEsxU1JPSkdJVnp4L1JnU0ZlQm9TN0Y1R3pwWkNNdUVr
RDNPRVoKNkhMNUxpWldaaFpRcVNLRlUzcjJTSytlRmV3NTVBd0VMMkYraElobGc5VGNOTWtPanpy
THcvTTg1dXdBTHlEaQpBcDJGVzdLSUVmcEZjWjZRd0pGMStHNzhRaVFtaEtQaVlhaEU3clVoSlFr
N0NNMTJGdk1yN2JyZnB6S3hxWEx3CkdSL01Vb2g0bnFjdjdTV3J2RHhFNnd5NmxhRkd2bzN1Z0tZ
MXZScG82RlpaZWt6UW42ZE5WelJMZElrRXRjVWkKci9LRitibUFIRTlVNVhHYzB1YU4vYU5NZmht
MGVBbXA0OTk0UFpDb1hxV0twK0xsT1lja3ZyNEVJdk44ZTQ4SwpSVDRWdnJ2UkRKR2g1QmE1V20x
eVVCK2lmZkFIRDF2aGZSUk40bnJ4N0FkVDhqQzhIZTg4VmF5TUxQV2ZlT3JTCjJVU256V2ZwQlU1
ZUJCMWxrZUNmbWJ6Nms5STh4K3hMbUU4OXN2dz0KPTJNcG8KLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--00000000000054dd510629b1e03b--
