Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3794331A057
	for <git@vger.kernel.org>; Mon,  3 Nov 2025 16:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762187735; cv=none; b=ZzifOF7upO52WHJv8LcTqQdoUi4tS27IxTmkACNvv4wP1SEF/4bZzxmQ5nW2RtjQK/RsW5Jqf/CZgEPakJACn9MUa/q/Dmdp05nN1G7SorSeaW/3Zn3NiS4iysa0C4Q7Ld1icrsvcL2KI6PaOWN/IYu31cd70cSUJu/NPH1mFj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762187735; c=relaxed/simple;
	bh=QafwzKGM1LwZBZXSicFZ9BdMIkCREAYMyAklxh9TQdw=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q4N3Ubvb8cwH3nDOTWAeO+VbGohoYMW6hQay/yklaA2e1E48dY8K09SsNSNAneb0LNcu2KLPDvIWfvnRJKFPz/qv6bvkKuOjd3SBsfiMbF3hY/dPwUvC4oHjtmaggKkOXi/qcei4qTatiRkXIm6TUQyiTvChn+6LTEjQltQugbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KWsO7meV; arc=none smtp.client-ip=209.85.221.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KWsO7meV"
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-54aa5f70513so1043102e0c.2
        for <git@vger.kernel.org>; Mon, 03 Nov 2025 08:35:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762187733; x=1762792533; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=eJU2e9OUf5OL7va21pTUBBK/mRuyyEsuy+C3VeD6YaE=;
        b=KWsO7meVoikhSDnWPf12Num6mvkoESI3i7s/ZZvf0Ix/tVyJ3r1rf7QpuL1inIgQ9L
         NruCwuNZJ+Hy9g+pYfZ3qxDZH6RsIYeQER87fYvZ9+Vquu667WM2CR3/XAhEkcrFjmNS
         gPamMlETEaLZjA1u3RWYO28eg48SuQmvb1wdhD98Oanhg9Na2qgpx/k/EMprpz5/lb3N
         wXxs54pevm/mqCLr+X3xlcYUXlIVAvYUBo26qkFX9bdbwo4O+pTbedcPTCNYrAVefrHZ
         KcgOzWzbtptZ1fCTlKL1pylpN7ceNdUhFECRMflS2TNWZ+k/Sj28g0XlQY4q9mkE1Z+J
         OVwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762187733; x=1762792533;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eJU2e9OUf5OL7va21pTUBBK/mRuyyEsuy+C3VeD6YaE=;
        b=h0IOD10CTIj1hcSPcGenHnCmDkKxUFY/K/nXeUp8dLUHv5bTHnTJWV7mN9OAOkcCZ3
         ee5Tr5jJCO3JYcCbVoKX6/7tuN4Qt05LNA5n9eG3uhskQ8defpl9A6Ir19xo5q9Qhswt
         3WxzPHdkmvPbumOrZhsK8uTWclDPmJ/sUU9ZVNvxAwMjgo2tTur8/81y8RIYEBuErtrF
         7woTdgEyja1qN+Mg2cT5nBsP19PzA9Bix2GuheD84RoYAGMHivAcSRfOVHAjPFNvTV2B
         9ulJr0yZ0KK8LqIAW/+cHf7nEMo7TdCmh3tQVy6vitKa7w6+2qIBa2yoiVQhPMxjCUrP
         Xv6Q==
X-Gm-Message-State: AOJu0YxNVOvpgYNSCpk7LQCKGxcBqxErbTDAqHHmPR0wJOsgLT4FT7lR
	UeqECIVgD9nw5DsuNF3M0EcC69biIe+6VTnPUNrjmWJDk1TUdwvaNumym9v0ywuNDgga1+LbbpR
	bUzTchyf/qG0P0UmdiTdF3bnF0VS81pUCGdY9
X-Gm-Gg: ASbGncs1704o0Dnmm6pSWhr7XHK27vujqfDSg2x05fRjCua9nCmY9gxuoIgVj9j5N61
	xrAtVL85jjan1D0zFNXkApOhG/QDL31ANAyBwVA20rRV0E4zDAuapoCUHnLg6S3lTUBjX4bx3LX
	pkjjW1wbaupu+ySpZRFySouhVJpXNnVrDQgcYhByB01u4iJNbE7tiJKfU8R2Ev+5OL0TTtgJq9d
	ECT+TcC7EV/S7Xuo2ejSeO2QVegQUpnAfr4sjlu6MZh4xomsL3uSNLM7OJjzILKyUL4iik4VS/Q
	8cFGj+QI2Vnmi5bHeCPiLEWBEZ7E+fwTRbpe
X-Google-Smtp-Source: AGHT+IF9NKPDQBoj0Dv0Cp+fk29f/qOvKG9lnfqu/ehK1fj6/ztfC1r854FL9XF7lJ1COylxzqUWcb/5NWYG7+6mD8M=
X-Received: by 2002:a05:6122:1d0c:b0:559:64fe:7d37 with SMTP id
 71dfb90a1353d-55964fe7fe2mr1202081e0c.7.1762187732732; Mon, 03 Nov 2025
 08:35:32 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 3 Nov 2025 08:35:31 -0800
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 3 Nov 2025 08:35:31 -0800
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <aQi1c6ZLM-1dqrCI@pks.im>
References: <20251031-562-add-sub-command-to-check-if-maintenance-is-needed-v1-0-a03d53e28d0e@gmail.com>
 <20251031-562-add-sub-command-to-check-if-maintenance-is-needed-v1-2-a03d53e28d0e@gmail.com>
 <aQi1c6ZLM-1dqrCI@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 3 Nov 2025 08:35:31 -0800
X-Gm-Features: AWmQ_bk-veMQDBC2rNPJuHPOOF2HlaDx0Z4Yn78nsorrR5-mi5HeMPJiIocecxQ
Message-ID: <CAOLa=ZQf_YC4-z8eOa=VaMdHFynfK-aWBC80sV5N4T5gzweq=Q@mail.gmail.com>
Subject: Re: [PATCH 2/5] reftable/stack: add function to check if optimization
 is required
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000d66b3f0642b34d08"

--000000000000d66b3f0642b34d08
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> On Fri, Oct 31, 2025 at 03:22:22PM +0100, Karthik Nayak wrote:
>> The reftable backend, performs auto-compaction as part of its regular
>
> s/,//
>
>> diff --git a/reftable/reftable-stack.h b/reftable/reftable-stack.h
>> index d70fcb705d..a875149439 100644
>> --- a/reftable/reftable-stack.h
>> +++ b/reftable/reftable-stack.h
>> @@ -123,6 +123,11 @@ struct reftable_log_expiry_config {
>>  int reftable_stack_compact_all(struct reftable_stack *st,
>>  			       struct reftable_log_expiry_config *config);
>>
>> +/* Check if compaction is required. */
>> +int reftable_stack_compaction_required(struct reftable_stack *st,
>> +				       bool use_heuristics,
>> +				       bool *required);
>> +
>
> I think the documentation here could be improved a bit. Somebody not
> deeply familiar with reftables wouldn't know what `use_heuristics`
> really is supposed to mean.
>

I agree. I'll add in something.

>> diff --git a/reftable/stack.c b/reftable/stack.c
>> index 49387f9344..18fa41cd5c 100644
>> --- a/reftable/stack.c
>> +++ b/reftable/stack.c
>> @@ -1647,6 +1647,31 @@ static int stack_segments_for_compaction(struct reftable_stack *st,
>>  	return 0;
>>  }
>>
>> +int reftable_stack_compaction_required(struct reftable_stack *st,
>> +				       bool use_heuristics,
>> +				       bool *required)
>> +{
>> +	struct segment seg;
>> +	int err = 0;
>> +
>> +	if (st->merged->tables_len < 2) {
>> +		*required = false;
>> +		return 0;
>> +	}
>> +
>> +	if (!use_heuristics) {
>> +		*required = true;
>> +		return 0;
>> +	}
>> +
>> +	err = stack_segments_for_compaction(st, &seg);
>> +	if (err)
>> +		return err;
>> +
>> +	*required = segment_size(&seg) > 0;
>> +	return 0;
>> +}
>> +
>
> All of these conditions make sense.
>
> Patrick

Thanks!

--000000000000d66b3f0642b34d08
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: d63f6843dd47faf5_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1rSTJkQVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mOWJDQy85NjlIVVA1VENwdjJlL2FVaHNwd3N1YXdMNAppODhXWWhiakdR
SE41RURpakJtTytRdDVlTC9PUjZaaTVMSmtlWHlTRzlxL0tlSFZGSHI3SFJQOGlxd05MVlpXClVV
bTNVcE1XSW56VkRRWWk3NGNwYi8xUDE3SlN5TkNqcUZEN052WVNCMW1KZ1FoOHBrbHpOZjQxQlBh
bEZwSlQKTVJnNkR3OXE2dVhpWU1TM3hFOGY3VjFkVU50Tlp4RWV5MnhodnNoMHJuSHVQMHlodllP
Tnljd3BhU2pIaGRoYQp1dW5MUEV6aTJwZ2ZOemR3RFg2b2FxVWdvTDkxWW1mNmMyZDRsKzFsRWdY
WHJFZHBONC9lS1NBVHNWVmlXUVdoCmtPdVVOZndiOWpUbHA4OW1YUGV2VnZTSkVkYURBaWhxZjVs
UllRTlhUNmQzUXhHZnRwelBMdm5QTzVIYWgwNkcKTVRhWnlocktCWFBFclZTQjNWWmsyNGFadnVX
VEFwaXZvOHBSSmhIZ1JiaXlOaDRkeGZldjdZUWRPdGlJYjRGMAo0THpIT2VXRFJwd3V6TU1aM1d3
RmZNR0NDQUR0TmlheHkycExyUzdVY2d1amUvdktnU0tOaVpDZmtDc1ZCMDR5ClIxbFE2ZDZYM0NM
K1BMZS9NYUt4dFF2SFpySVo2VFhGY1V2ekw5az0KPVJTV1EKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000d66b3f0642b34d08--
