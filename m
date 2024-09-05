Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5792188A1F
	for <git@vger.kernel.org>; Thu,  5 Sep 2024 08:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725525847; cv=none; b=BwvDv/+8DwlQneOJlpepNqMDsU73ejAZYz+BPCHnO129OBGEHjUkU/0OTUnnqY9UeqlacHWuld8LDOZFITV3w7CiObPP0ynxMK6Amta6kJK2PypKoRMzwermZYprZ9MXwn7dwR7a7bMYt2MAMoIg2WUAjCI7AeXVNyJQj6j1pvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725525847; c=relaxed/simple;
	bh=iMo125JqDHb0Sxx4F5rvr7u/xuqE6NRVF0bV2VqKvjE=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ed3uQMed2ozp0tgVrFWaLksmaM4/QirKJCohy/5XtJjya36yy2M5QwgrG0ihJYvWo6C8sIkACp5tHzdUeoJmbGngJirw6zBesnzwJzeB0ETW/q0sQw3K9aPCmrYXX5hbFFr+02XdTyHgy5eVIjJd84Cvc+NVg+ZbG5Td5+KPU5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KJwmrrGu; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KJwmrrGu"
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-277ce4bd723so290922fac.1
        for <git@vger.kernel.org>; Thu, 05 Sep 2024 01:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725525845; x=1726130645; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=iMo125JqDHb0Sxx4F5rvr7u/xuqE6NRVF0bV2VqKvjE=;
        b=KJwmrrGuCUtXbzPVLkJLz0AIsvw0iUGL4QgZzMcod/I3JxnM/JLzYaqLsW67goRhqg
         p7ugr+MJ5D+lREa8fKS5/CydXf2Bv4rM0i6RZWJhqCiLAccwj9tT9UJLCXT3I04oVGgq
         IDka4oriOTHdFzqqrLPwiQjjxRo2Syleb1/4p7i7Pkyri6FXF5APi/LFBB4/PdVcY2tD
         lqftb6p2gNtD4V0oeVmi/1NN0203WDbM6Qr2hpKcB+MWh04aUl+sGGVCQJh2fD2Uqgrn
         uwzHvA+PJg3pBikF28gZYtXSVF1WqLKMjRBsz6lmtAYwVpduSa7KEnTIwN9jIOj2TDI2
         obUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725525845; x=1726130645;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iMo125JqDHb0Sxx4F5rvr7u/xuqE6NRVF0bV2VqKvjE=;
        b=FDyfSpPrZ8JnhE8H+heYCAsxLO6EutP8/2JMY8NlsiZU/oByExnCmpK8TXoHEJuNVt
         zUceZbN2PD5x7g7CUFvfRxAT/M9vjGihE+qYgqBY3QGE8opKBFDyGO1Ks3/kCPhYzbOG
         SmziZFI6QPlP6R0X6jwmDjP2sUUjNoRJFc30S17fEfJ5costRUbhf4W2U3CBdgl8EX5g
         9R0+0I7AHPWSnWvMmcvy9nEBBLtEeiCKpSfGp6E4XUVLuPUaM7SDxqxM7Rou3nxgTpW9
         YXj7Tnw2g9GMsqEXcppTztIKl9+K5TzpOy1VXqJc2+xo1/8SH+ZmXXrdcZZ78BULFCug
         fQ7g==
X-Gm-Message-State: AOJu0YwOy7xvlwCay1Uo3HvAShb3iMnApVyzZM3mNkE+yw6RbTk3nILm
	rf8TeE+AMtIx4aVfbFbhHMdOfBNDpSdVS9ZVjHlMnoWvQsmGadnNChxhJbYPCVDZptjp1nbWE9z
	Qwna8zmymRvE3XR+wcjJvmyQDuBeuIK0I
X-Google-Smtp-Source: AGHT+IGlHTamji2ki/T6RG3LFeSWW/d0iyfzxn517egdtQjfgv5Uu56XTUB8SCH4+E1jNMdOHWk6e0/jDKkrOaT/tqk=
X-Received: by 2002:a05:6870:611f:b0:278:2340:a944 with SMTP id
 586e51a60fabf-27b4a11ef12mr2050466fac.15.1725525844757; Thu, 05 Sep 2024
 01:44:04 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 5 Sep 2024 04:44:03 -0400
From: karthik nayak <karthik.188@gmail.com>
In-Reply-To: <ZtgfIPOZO1p4_ExF@pks.im>
References: <cover.1725280479.git.ps@pks.im> <9a63abfe3b812a32d69c7393004bea4f88971559.1725280479.git.ps@pks.im>
 <CAOLa=ZRGvU4LvX9kjvF3dJCTvKR6CC1CwPTp515c3Wt5M8a5vA@mail.gmail.com> <ZtgfIPOZO1p4_ExF@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 5 Sep 2024 04:44:03 -0400
Message-ID: <CAOLa=ZRQW0sUXEVSs8weK-jke7a2rUmG=Bw5q4yZvtFP4wvQKw@mail.gmail.com>
Subject: Re: [PATCH 2/2] refs/files: use heuristic to decide whether to repack
 with `--auto`
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000072b4b06215b4b1c"

--000000000000072b4b06215b4b1c
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> On Tue, Sep 03, 2024 at 02:00:16AM -0700, karthik nayak wrote:
>> Patrick Steinhardt <ps@pks.im> writes:
>>
>> > The `--auto` flag for git-pack-refs(1) allows the ref backend to decide
>> > whether or not a repack is in order. This switch has been introduced
>> > mostly with the "reftable" backend in mind, which already knows to
>> > auto-compact its tables during normal operations. When the flag is set,
>> > then it will use the same auto-compaction mechanism and thus end up
>> > doing nothing in most cases.
>> >
>> > The "files" backend does not have any such heuristic yet and instead
>>
>> Nit: s/instead/will instead/
>>
>> > packs any loose references unconditionally. So we rewrite the complete
>> > "packed-refs" file even if there's only a single loose reference to be
>> > packed.
>
> Revisiting this: isn't the current version of this sentence correct?
> Replacing it with "will instead" certainly makes it incorrect without
> also changing "packs" to "pack".
>
> Patrick

You're right, I did missread.

--000000000000072b4b06215b4b1c
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: d5e79c67e8aeecce_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ0FBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1iWmIwOFdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNzdHQy93S1NXb1AvRGVzK3pEc091d3F5dGU2Q3kwZwo2cHlDTmd3aWtG
bjNXYUhWZDBCdkw1T3hRNzlEMTFYMG5PT096Y1dCQ2NCbVh1ZkRUZ0svQzJGdG5NLzN4eFRzCmsz
LzEwemlKUGdsQlJVbkd4M2tENUhUR1cvMWJEckZtS3Y4dUZnSGMrMmNldVhsV05FNEpjVS80SHBY
aC9mVlcKRXgvODM3enZ6OXlhVUE5UkRjWWFRaUk1aHRnTGRSYXZCQ05nbTBhSFZORytqOXJHOHc1
VXkzdlpoVlNPRzFBQQpsT3BmN3I2QkU4Rm9QZUZTYUpxM2pIVElKNjhEdDlqYUNuRmpOMmUxZ0RC
dFBPQU5yM0tHeGlqZWcwcjRRSTY2CmtxQ2lyTk1ZV3psajZ1WEQyamEzejFzbXdvTi9JYUpUd3ky
LytsamdCRS9oV1I0MCtWeVdnZ2srczJkZE4wNmoKUk15VThTSmVaYU9DcHh5WUxiYVB2RG5lT2xB
d2FtSGZCZzd1RVFvb0NCLzhYTEJzVGFpY2N5ald6dlIzelc1Lwp5a1RGT29kODFvc1ZZeFdxTGRi
aGo3QVdKaWVzWEk2dW5WZ0crbEtTeVZrQWFxYXJxWFpiNnVacjhKaWxWTm1KClpKZ1dzMzEvUkUz
clNTZ3dNUUplNUM1TkZmOWZlMVp3QUV3czI4dz0KPVYrZFoKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000072b4b06215b4b1c--
