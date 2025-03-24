Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5314325F7BE
	for <git@vger.kernel.org>; Mon, 24 Mar 2025 14:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742826203; cv=none; b=CNiyyWM/tQuBnszn1Ao5I9GE0+ajstJ1J6IJ0Krh00fITt8H9gvHDGptJAnk1BPvyru9t/oCSoyMI5h3b+Qm78uxHhuFVqGH6/qMblzQLcpHTZNnbixpmiTHTYqGds1EPww0hCyTQUf0N02m0YiYR/PZBHr/k9jTULfrVo1tPEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742826203; c=relaxed/simple;
	bh=x9oetzLyRcDBt8pbpFP5kWQT2/K87dTfpxXwVNq0uYA=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KJG4KR6PDe5hzdm9qHTescaOC+NamNsLfWCK337F1MUCcb2qJofQC8tOOmGgbcI7xJFgfj84VRkTyJvsRuHZavvtIDQM2TsXsMGRaG9LNcyo+dhOOLmnXSepNEk/hH4hNEE7sjAEt7u2lhJs7tbYHhUJMdESnakaXOqF7379VtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DmyOlgbN; arc=none smtp.client-ip=209.85.221.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DmyOlgbN"
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-5259327a937so1712626e0c.0
        for <git@vger.kernel.org>; Mon, 24 Mar 2025 07:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742826201; x=1743431001; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=mXbMTT7QOfoD8BUfRXzplMzwX9wP7GhTLgsFtdZtlLc=;
        b=DmyOlgbNXBeGCRHY/c2oIQ09nb/akLHI6V5W02VLnANKZUUoWisxN9IoxbQIegLHhg
         MrTDeg1wzp55m1K1+2/j0/Ydy1nJ++SZjl1HrhkNub9w71FMd3W0YJic/809oMzMHIPT
         Eu0/nyeVrGjJ1MW+PnUCU9gA4JnWf4l7kLSdMC1BfdfbWI380yx+WQZzU8GBrwTFhQv5
         wGKFfgkCeR/QM3Bv0pg6Bf82CrXrYcWdEjduKP0N4YWFlKrmfWOrjJii1q1wwdz/nhZG
         djlyMCEBnz90duoy4xxYVBkB17sIrko4A7qPs2Ei/89paMgCjhrgKANLSe8Q5P2T0ZLX
         CE3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742826201; x=1743431001;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mXbMTT7QOfoD8BUfRXzplMzwX9wP7GhTLgsFtdZtlLc=;
        b=XOMKjCdCzLpopwkXjTqRTM53TrrI2jnaNH6kw+QCeAt9LcxZ3IljfLaSwVCgc+BMPm
         Ag1/Gzkx9CY6tJwfnqzKcH09Bl+8l5d7TCf+QtsOW0ZgXzrLCGFHIETRLB+2ozdZ1/qv
         yIEhtnypZhmQqEtGLcIuXsqe7Hmhtgz6oulyiO85/Uxywnz3GV4Pv/BMXLEeEVXKk4Y2
         dzxY6GMtWmJDxpWkdqD984gfK6bbtMjcQmEgOUvDScN8JP0b1jzHKnpwLRMYml3PKGOt
         PJnDuqyNUyxWk3Ktrq/0oBb/Nem3IJ/lONV1hRNFgPlyz2XwYcEs+mvBcnHN6BfVlGiT
         JIdw==
X-Forwarded-Encrypted: i=1; AJvYcCVFOjutEbcgEOwZKqZ/oE1/uLcEfBSm0sVV0dVNHtcZ54IbcCTiE1H3J87dTv9B3NxYxxw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlbTFuoBppWxbF6ZcVYLzpF47bKs8fp8T0rZTAPyWNr2ynZrgb
	W+hIwv6mQNnXbOOg0a0RwedmeROcYXnojYY2cOAF0toX9YJR/bXLdnizEdVYHglnSCWKJ+6GAC7
	DX3xrLU3c4X3qdpBjdf0Gx/N4loQ=
X-Gm-Gg: ASbGncuVm1IG+nfoieh3G7KZtWWl66KS8UO4ocD18NhaKALAgAGL3n6eKlXO5LKG+F0
	+D/TDOsyTbyAvduUzKnRsuuxtDOeR+ZCy/FPHy1DYaORI9ioAHeR6YLYygXZjpdS5N8vCEBUSK/
	rWmpjyxQS5WkaVwrY6W88Nqv8VB4ZOCX0PsKCHz80qsFwu+lKzunCfTVEo8WpI
X-Google-Smtp-Source: AGHT+IFAuZDARsRuosNAdfMOOEZex8t+yaj9TP9SGv3TFt+fsXN/APAsYigOqq+F8ES0tFaeaKpg8G11dsu7ilRua5U=
X-Received: by 2002:a05:6122:3417:b0:520:5a87:66ed with SMTP id
 71dfb90a1353d-525a837923fmr8891970e0c.5.1742826200918; Mon, 24 Mar 2025
 07:23:20 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 24 Mar 2025 07:23:20 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <CAPig+cRm+sc+Rk-4SuQ5CrPeZLG2Nzz9B7+6OZxCq7tV5mzmBA@mail.gmail.com>
References: <pull.1918.git.git.1742299111861.gitgitgadget@gmail.com>
 <CAPig+cQrCdtN4+hyZyPWQuvnoetarbcgkwKU7cD-TpzfzK=jzw@mail.gmail.com>
 <xmqqiko62kw5.fsf@gitster.g> <CAPig+cRm+sc+Rk-4SuQ5CrPeZLG2Nzz9B7+6OZxCq7tV5mzmBA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 24 Mar 2025 07:23:20 -0700
X-Gm-Features: AQ5f1JqwR89smi6ctJRC7GsiatJXu8fp1jA8FKIdV0AAUJPqeKhpLNhGxp0PmfE
Message-ID: <CAOLa=ZTGKDG9tfO-DRqz6A6V7BtQYx-HBS19KvZmM4dH+=BZQA@mail.gmail.com>
Subject: Re: [PATCH] [GSoC Patch] Modernize Test Path Checking: test -(e|f|d)
To: Eric Sunshine <sunshine@sunshineco.com>, Junio C Hamano <gitster@pobox.com>
Cc: Sampriyo Guin via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Patrick Steinhardt <ps@pks.im>, Sampriyo Guin <sampriyoguin@gmail.com>
Content-Type: multipart/mixed; boundary="0000000000009c9dbe0631175864"

--0000000000009c9dbe0631175864
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Tue, Mar 18, 2025 at 3:34=E2=80=AFPM Junio C Hamano <gitster@pobox.com=
> wrote:
>> Eric Sunshine <sunshine@sunshineco.com> writes:
>> > On Tue, Mar 18, 2025 at 7:58=E2=80=AFAM Sampriyo Guin via GitGitGadget
>> > <gitgitgadget@gmail.com> wrote:
>> >>  t/chainlint/chained-subshell.expect | 2 +-
>> >>  t/chainlint/chained-subshell.test   | 2 +-
>> >
>> > Let's not touch any of the "chainlint" files; they are checking
>> > validity of a completely separate tool ("chainlint"), and have nothing
>> > to do with checking Git itself. Instead, pick one of the t/t???-*.sh
>> > files.
>>
>> Yeah, these changes to make them use test_path_* are not "fixes" but
>> something else.  The first step for a contributor is to understand
>> why "test_path_*" are preferred over "test -[def]" and in what
>> context, but touching these files shows that such understanding is
>> missing, unfortunately.
>>
>> I find the "as specified in Git Microprojects" in the patch
>> description the most disturbing,
>>
>>     A simple fix as specified in Git Microprojects.
>>
>> as it may be an indication that some introductory write-up is
>> misleading potential students in a wrong direction.  Our mentors may
>> need a bit more handholding at this early stage of dipping your toes
>> in the water step, perhaps?  Or is it up to the aspiring students to
>> do their homework?
>
> I'm not sure where the GSoC microproject ideas are maintained these
> days, but it may indeed be the case that (at least this microproject)
> could be spelled out in more detail to help lead newcomers in the
> correct direction. If not already mentioned, at least these
> clarifications probably ought to be made:
>
> * only work on t/t????-*.sh scripts
>
> * pick just one script (so as to avoid exhausting the pool for other cand=
idates)
>
> * only convert `test -[def]` instances which semantically are
> assertions (i.e. used as part of a &&-chain)

I think these are really good points, we ought to add to the
microproject page, I've raised a pull request on the repository to do so
[1].

[1]: https://github.com/git/git.github.io/pull/760

--0000000000009c9dbe0631175864
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 942ac40fbb334a32_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1maGF0WVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mK3lPQy85T0lRdWRreGh3d29HcEFwcXVYcFhhRVI3Lwo0UHJURXVWSTJu
V1ZSM2tUZ29FVUJUNDU3RjFtSzVJd2czbHRmbzVGOFFCeWsyWlRYQmd6REdpRE0zcm9vNTRCCmx5
TllxSTZ0dTNkWjgyTzY0bTVHUUR6a2RScytaaTBsK2NnQzlTa3BSNVFDMHV4YlZDZUJkdmV3STJk
ZWUxL0oKMWhKVDVkejBDTFdlVVF3eFdMdnVPLytFdVdodDIrZmtSVEs4NllPT29lVURlWnh5bXhz
MmhqdVZhTmFUa2JqNQpkTEQ4b1pCQUFZSCtsMXViTWhySDh3b005bjlkaDFqU0VtaC9UcVUwL21a
bzRQYmlQUi9pWjJpMGtKd1V2dE5aClJwUFErVkJ1T25WZldWaVdKb3U1Q3FlV1Z3bTZjdEpTUGNs
SVFCNVpLazJzVFQwUVFvN0ZjdTdUeFUxdjR5WEEKQ0phbzdKeUVzclhPVVZzeTcyNTlncWJwMSsy
Z3RvZ2hKQi9lTmpIdHUvL094QVcrRWRqdERmV25yR3NGTTQ5NQo0elNUM1J2WCtiM2RlMlNzRGM0
YlU4ZUJXQ093OGtOaFN2S0x1anorclhWcGtxdmllRDlVUmdMNThzUGp0OGpOCldvMmtWUkhhSU56
UTRvOFpESEFxTGQyUEplVTlPYTErNTEzajBnYz0KPUE2ZkYKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000009c9dbe0631175864--
