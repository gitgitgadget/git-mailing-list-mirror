Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2460F7BAED
	for <git@vger.kernel.org>; Fri,  9 Feb 2024 18:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707503262; cv=none; b=XbQSEeczg+9mwSGWijA5z9OcxxgLA6ur4yMywJ3SVVnTJFZoYEhAcTWEuEjAjCT17lHH1LH9iJDs4dH/h8oMTnQ/9ZuOPPfRtqOEsE/JuwatPTdIrSVzUuygaH3rrJEFsH3Ap2+RGwDWJO47PG6P763lZn2+hiazvT/3Ga2zrCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707503262; c=relaxed/simple;
	bh=KGsaMId3LMpoGE6ckW/o1qVoWvNDMRAegEUw1yHDDpk=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sdLdMeiMZ0+RcB3mQsMwiVOSnBl7/kbajvMSrZ8WzlCw4OToxnq4ij7WxIBz84sCsLW4cjHIU/LVR7w3FSx+3X8Dbf2jCe7ekiKABX0oP+u8VRJT2t7nL26RRVKlhR42yAHPKqTYrDwOW7AXQN5llTA8rJQm6hqzi009bSnNkf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WNbY1U06; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WNbY1U06"
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3be48947186so611217b6e.3
        for <git@vger.kernel.org>; Fri, 09 Feb 2024 10:27:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707503260; x=1708108060; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=HChu5gnjeonaab8xGMWsDrmuGQrdMidrN1bgB4ItVRk=;
        b=WNbY1U06W1sjPOdokW/iImukiubldoQrTNu/Z/sT4UzoJhyu95XtrdybPdd3rffX6I
         2YtqQdu7T2+9tjKWpGIWqoVSezoL3U4EkulMWIVpGiROO0wBsTAAInMW8zDXqmn94jn+
         Q6WNS73j2p4FOc8eJ4sCUk8NUkXzEkt4NDftTL7NkR9qDLxjsfYtsCgeNkLoCw47w8Vb
         vQVJ3ZdtzaQVypXwsXzW8Vot83/Mpweu40cH/dVoqi9ToRpO+8NrN7pUg2V48QKU9Gls
         4JFgA7on+d/XUmbvMbYbr1WlTATop0YkFTxZ1MUgcbQS9cv+eNs5whvrVutNH/oqwegz
         aB2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707503260; x=1708108060;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HChu5gnjeonaab8xGMWsDrmuGQrdMidrN1bgB4ItVRk=;
        b=NoBNoNrlGk+/LF5L63S4recuYrLpn2flP3PZ7XjvO41cMSVdHsNQu3FuzsRqlrs1r9
         0hd6t4aN56yA3YxwnbYQlGrSi3brhqs+S+jOENzJMdHvuIT/gu2YhjpEC2hjmhiG9exM
         11gxDQ/cWYCS7FFxVStCYHhUbL50GqAdVA3nGtySfDfKaDVfBPRz3zlOaWAQjSGuLYGH
         oWhQfTaVNX4W3+70rRxinMFCUmyCzv2d9upNDPyO1NUYsdWZkU8ceBGATpizAVUS7+ia
         ROWFwH47fkpYFO1Zl6fEaeYVzBNgFDii0zSXPBsMHI/8zfysewrgPqIwTHoB0SNfgJE/
         p7Vg==
X-Forwarded-Encrypted: i=1; AJvYcCUaL7UByJmML+06bGyfOPMLdhApQ90Qectdldn5y4xCN9wJ9ocFHl0/ZXrcgK9ic2+UIqfSBjQAOZYR67RQuXiWjTrk
X-Gm-Message-State: AOJu0Yz3kNTlFRg+nDOsvC1x3Ohx7cWMDzJC7u3T3Nx0vSUxSQtl8KDL
	ZMn7sFVWUwtZtmKR1XQmmVhJVg5BLsWG3pZPqIYM15OZx3ky+cAWpHVP1EsK9kg/aPVAPplr0QN
	Lv60PfFouY1gx+x1LRF+8CIHt2NE=
X-Google-Smtp-Source: AGHT+IECrXwPSsPfF0YpBOxnUS1OcKbPbRPR4XESCfAUO3+qlH7+zNXiifArNejO4OnUhLM9x7kiQiB7jr3t+IGnLR0=
X-Received: by 2002:a05:6871:581e:b0:219:f674:c693 with SMTP id
 oj30-20020a056871581e00b00219f674c693mr27857oac.35.1707503260056; Fri, 09 Feb
 2024 10:27:40 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 9 Feb 2024 18:27:39 +0000
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <xmqq8r3timnr.fsf@gitster.g>
References: <xmqqcyt9fdc7.fsf@gitster.g> <CAOLa=ZRcWYmEYnxh_=ykOerahZ61xaanLCj_JHHLvtrvN=Xs-w@mail.gmail.com>
 <xmqq1q9oe029.fsf@gitster.g> <CAOLa=ZQzz7_L_9cBmK+pgFwd_DFqfWDVRiaZMAxU+54kBq6Pcw@mail.gmail.com>
 <xmqq1q9ocje3.fsf@gitster.g> <CAOLa=ZQaXxwrXmbmFvGR59EDo3Eqa-Xfc3OG9+6ES-veDU8Bhg@mail.gmail.com>
 <ZcSVx4slikt4xB3D@tanuki> <xmqq7cjeq43t.fsf@gitster.g> <ZcUOP_rWUwymhe5c@ncase>
 <xmqq34u2onaj.fsf@gitster.g> <ZcXddvQzlt6j7T7L@tanuki> <xmqq8r3timnr.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 9 Feb 2024 18:27:39 +0000
Message-ID: <CAOLa=ZS3y=K6SCEoC7hZSi7vhAT1-W4fAzPb3rYaBbGcqO5Cyw@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] for-each-ref: avoid filtering on empty pattern
To: Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
Cc: Phillip Wood <phillip.wood123@gmail.com>, phillip.wood@dunelm.org.uk, 
	git@vger.kernel.org
Content-Type: multipart/mixed; boundary="00000000000044d3f00610f7151a"

--00000000000044d3f00610f7151a
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> Patrick Steinhardt <ps@pks.im> writes:
>
>> Depending on the answer, I think we can go one of two ways:
>>
>>   - Accept the diverging behaviour and add `--include-all-refs`. The
>>     "files" backend does a best effort and only includes root refs, the
>>     "reftable" backend lists all refs.
>>
>>   - Double down on the fact that refs must either be pseudo refs or
>>     start with "refs/" and treat any ref that doesn't fit this bill as
>>     corrupted. The consequence here would be that we instead go with
>>     `--include-root-refs` that can be implemented the same for both
>>     backends. In addition, we add checks to git-fsck(1) to surface and
>>     flag refs with bogus names for the "reftable" backend.
>>
>> While I seem to have convinced you that `--include-all-refs` might not
>> be a bad idea after all, you have convinced me by now that the second
>> option would be preferable. I'd be okay with either of these options as
>> both of them address the issue at hand.
>
> For now my tentative preference is the latter.  If ref/head/foo is
> an end-user mistake with one backend, it is cleaner if it is
> considered a mistake with other backends.
>
> Doesn't our ref enumeration/iteration API have "include broken ones
> as well" bit?  I wonder if this issue becomes easier to solve by
> (re|ab)using that bit.

I'll then go ahead with point 2 then.

I'll modify my patch series for now to fit in and will follow up "checks
to git-fsck(1) to surface and flag refs with bogus names for the
"reftable" backend" in a follow up series.

- Karthik

--00000000000044d3f00610f7151a
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: dd392d5657d709f_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1YR2Jwa1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1md1FWQy80c3NPVkhZZUc5dHhPWUdqYWJ5dFoycGxUbQoyWHhCUXVjRkVn
dlZHODlBTUF0clJLQ0ZVVWpyMTZ5cFoyZWRHS1d2SHRpLzhWRmpXUm03Nll2eXh4M0JCUmp4CkJE
S2p2TXRNb2VseUgxUEo1TWV1UzROUklVTjlVTFJrRUxWS2RuMSszSnVsOVhQVFRGOHkwMXpaOEZv
V0NCU00KNG52b2gxQ0MreDByYnNLb2JmMS8xU2tBYU5iNTBDR3BjSytaQTMvTzNRQk9KYU1CL0E3
SzdwU3VaOFgzT3E3QgpxWjg0OFBhM1h3UFljeDZBQUZIVC9wQ0JIWmdJNWZEMVYzWW9ZQWhIbllz
eXgveFpmUkdaMXJpUFRSNHcrN1ZRCmNEVERBajgzRUhLVDd5Y0hXY1hKd2theWJ6dldZR1R2RG5U
ZTVOak15aG9PK1VSVUFaRHNtczRmR1BzdUxGMi8KY3YwblFmLzdHQlJsVHBSVmU2MFFnUkhWdFd4
QWx5RERiUnpkOTdMczdFYmdCOWcya2Q4dTZncnJudWc1Rkp0TQoyV0JoM2IydU9XWmpmQ21TczBv
YVp3anU1eEwwS2lmQmw0ZHdybXhyelE0cGFUNXY0QjhRR2U0RXhtRXVFUW5JCnJ0ak5acGJBa3Nq
RnNremlGYlp0ZlE5Tm5TTTdFdHNjdjV3WUc2cz0KPUZwN3QKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--00000000000044d3f00610f7151a--
