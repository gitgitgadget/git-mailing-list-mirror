Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3758220012C
	for <git@vger.kernel.org>; Mon, 16 Dec 2024 11:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734349641; cv=none; b=g7Qe7cJ5/ib3pSr51eJIKccmQCh5lm1j/bkjI2Ei/cOpPzjbkN54khj46Ny0j5MGIynFtIlvvoFfYzcilp80MW6h/sEPgwOw2LHQXec70wkGAMmQg8c35sd9flO3gnVfJ+kNxmNXsWtCgmQjFjtsR5zH2xsmAYyijmXCPbWMA6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734349641; c=relaxed/simple;
	bh=xY8yCOiFj3HiNWFQcFdqGiJ/gix5lboBF7KLSrgs8SA=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hokJ3yhvKZ7j7eLP5DmtWeqegKMJKb5eGiQ8F08CCAbGXhLp8ETi4Qb1Ve3gHvH/3paL/+9wwoK3uwqH0qOkyEiU31DKTTuc9NqG5uWl9ftLwM3T0WrN96z68wFD4gV/HkKyKnpoyWWOGF1mEIo0XHfHYR7zkvE38hPElNwUNG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gNLjnqK/; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gNLjnqK/"
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-51882748165so1158940e0c.3
        for <git@vger.kernel.org>; Mon, 16 Dec 2024 03:47:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734349637; x=1734954437; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=3rhJE0wgN6rkpse3NIOezoEbGD0lTh6U4FIgxzNIF5M=;
        b=gNLjnqK/2C/ShKIcBIgvtS6hzzRte1SVBGM6Tgm8TONVzi0ESACBfpt0RFwNeORt64
         buzfn3VCKVIpMgOCpR9+u1aKb4lPVv/C6omtKecQp2+nnvp0JwuSFifGfvbC2BBXPzj5
         V1e12Cl7eOcMRudO6P75SiI67YsGChq5ZgY0dUKpVBCZS/O0ae88cg1Ng4ilr9dKLo60
         zbO3/z2PQuN1WfBuvfjceBDvammJzVLmoZQiXScO1KkjMMCtbuZVLp2kLeFhpPuAqDPG
         AknKVhy8qxguY7e7t+pAA37/6VqdPNwTK1azvcJqBZubkJVLXpx7ZhIQqVdBRNS25PEG
         q2MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734349637; x=1734954437;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3rhJE0wgN6rkpse3NIOezoEbGD0lTh6U4FIgxzNIF5M=;
        b=ieTjEsPt6/Zl1q/ssXLrMwV5TDuj/OzcFr+QvhZJDk5Gdm+lxNBHcgrt3jtGznl0ra
         Cr12NNtZ+0dL6G39WqwAZ46wILJAK3MfNZLsFDDy++Vxc51tZW6WJ96G73PW6J2PaaRG
         Uc9JYwJS7GU3ubGKUD2jnalp7KfBcPs8drW2CwbCHjcj2+Onu0jB81dhJW5as1KzQ1Ud
         Sn6qb7KGHzcBQXrvIgufR65PTYIpa+Bvj8+zCn8QrygecOMp0nuc2ZPcQUfrxJnGxUZH
         WlGFOofL1mLOjtIttLKOSdbv5kYr1QHyTUVzma8+3I1iq33jjeaUHFqBcSex14Qq0PTa
         bYvA==
X-Forwarded-Encrypted: i=1; AJvYcCX/WPZT2o1pff2pIx4sM1zVeI0J+oZQGzux2/Euuu+siUikVa2CYAEvgjCAIjELwrEzy/U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzK2LPb0ehOm10YwQAqek1f1wdEXz6WDY6Gfs0Hk5eBHpS/qGXv
	ENFpkwKmlEJlP/EZ4itv/Kbyx56WxSxuWQ5BnqsRPGO2QiA1HQmJPKsmZ7PkB6CBG/ymt4CI2xE
	dpc0wj8S+za87YXLdBw9fLM1YE0Q=
X-Gm-Gg: ASbGnctRANumPjtHKu/6Tn9Wj8BDmqmRd6IS6xqB5YlKOkG7EQvUlQwBEl2FMt58mcM
	8iCXw1AloRCfV4Ag5BCCh44XAYNCBnzo+RFBc
X-Google-Smtp-Source: AGHT+IFNAOFueJ1vfJlSInFDgAEor+623zM94ncc4wxaCwdJ/nouno/Lw4ITzs/tqGE1XhBggnc81l69Qw0cC44wr5I=
X-Received: by 2002:a05:6122:8cc:b0:518:7ab7:afbb with SMTP id
 71dfb90a1353d-518ca30a781mr9762190e0c.8.1734349636994; Mon, 16 Dec 2024
 03:47:16 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 16 Dec 2024 06:47:15 -0500
From: karthik nayak <karthik.188@gmail.com>
In-Reply-To: <20241206124248.160494-3-christian.couder@gmail.com>
References: <20240910163000.1985723-1-christian.couder@gmail.com>
 <20241206124248.160494-1-christian.couder@gmail.com> <20241206124248.160494-3-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 16 Dec 2024 06:47:15 -0500
Message-ID: <CAOLa=ZS-VYdmk-oDxFVXS93KSozPJWwfyUpp7c8fTaGW8Kib7g@mail.gmail.com>
Subject: Re: [PATCH v3 2/5] strbuf: refactor strbuf_trim_trailing_ch()
To: Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, John Cai <johncai86@gmail.com>, 
	Patrick Steinhardt <ps@pks.im>, Taylor Blau <me@ttaylorr.com>, Eric Sunshine <sunshine@sunshineco.com>, 
	Christian Couder <chriscool@tuxfamily.org>
Content-Type: multipart/mixed; boundary="00000000000007abf0062961be6d"

--00000000000007abf0062961be6d
Content-Type: text/plain; charset="UTF-8"

Christian Couder <christian.couder@gmail.com> writes:

> We often have to split strings at some specified terminator character.
> The strbuf_split*() functions, that we can use for this purpose,
> return substrings that include the terminator character, so we often
> need to remove that character.
>
> When it is a whitespace, newline or directory separator, the
> terminator character can easily be removed using an existing triming

Nit: s/triming/trimming

> function like strbuf_rtrim(), strbuf_trim_trailing_newline() or
> strbuf_trim_trailing_dir_sep(). There is no function to remove that
> character when it's not one of those characters though.
>
> Let's introduce a new strbuf_trim_trailing_ch() function that can be
> used to remove any trailing character, and let's refactor existing code
> that manually removed trailing characters using this new function.
>
> We are also going to use this new function in a following commit.
>
> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> ---
>  strbuf.c         |  7 +++++++
>  strbuf.h         |  3 +++
>  trace2/tr2_cfg.c | 10 ++--------
>  3 files changed, 12 insertions(+), 8 deletions(-)
>

Shouldn't this patch also add unit tests? We already have some in
't/unit-tests/t-strbuf.c'. This applies to the previous patch too.

[snip]

--00000000000007abf0062961be6d
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 7d931d3a0998c056_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ0FBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1kZ0UwQVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNWhNQy85d1hoanJtVC9Yc28xejI2TngvaG1RMlp2VQp4b2h1NDQ0TEpZ
bFg3dmEzRSswY0l0Um9wbXUrRms3WjZaNXYxZWxXYWgwRHVqWFJKOFplbzU1NEVXNWs5S0hpCnB2
dFV0VjdDR1dUQU9GbFhzbDRvOXBod0pXeWFCNm92dG1hN1BPSWxERDF3U01lTlhPeEhQaHQzeEZ6
N2dvSjkKVDFKWWdqaHI4WHZNV3d3Tmptdy95eGttUU5NSDdDL2xXSXBoTjg2OW1SZU1KOHZjdHFZ
RnBXN2R4MURnMzFFaQowTUdZcTk2azdwUmI1M1hrbHpkaXlFNHhGTkRleFhuOFZEZnBTTnBxR0Qy
RUhCZ3ZiMWYxeS9oY1BaMm05WVc0CjdMRFNWZkZNdTRYTTZaSTlhV0JBa0tOR2JNL0pHMFNPVHJZ
dWhhUXBWTzg1TFQ2MS9WOXl2amNFeGg0bFM4bU4KODBaekRhbWU1MFZKRE9HWWdkVnI0cUNrTWxj
SCtZNzV5bTg4WVZvS0xYSjNSWkhHZnAxQ21ONEk1Q01OdkxPQwpYbFN1M2daMlhJS25hZnFvSjNo
Z2lTNEkzVWFVTGpMcGp0WlVBdGkyYlhGeWJacTlVeFJCZ1FBQ013Tk9WdFV5CkpwSG8xOFAyVC9F
ZlpFOEFKbGx0UXltYUF3ektqT2xjazhLMUx1ND0KPXZ6eHEKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--00000000000007abf0062961be6d--
