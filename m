Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 243D4192B96
	for <git@vger.kernel.org>; Thu, 16 Jan 2025 07:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737012551; cv=none; b=lN71tNt3sZQf26q1n30ULT8fQAOrvyPOhaCQ+zSzlapIAd5uRXtapF1WN8/f85UJtYN4V6I0YpMOAmNyNKZTsrQf6Icit8mdTizI63a14J+veZnz5ZoOmFl6ZDH3hsE2Pe2tdgbQiBIUqQphRfnERan2Qk3+m74Ot9d1cr0p09E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737012551; c=relaxed/simple;
	bh=mp978kuaHJlRvC5buyeYuJsRRyioGSOY2fhk8ZmBhTc=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D7N7s39Gy2LGEtzMbFALoLLTmv9sWMNUkg2cG19k+RqjF7a6a9zshgDtssicdgzvfxRme6KGCc7RtGvKS5ig4G8UYiENXkBT9ocMBfgv2eo73p49/qqLkjeE22ABj5M/vsZE9ulTsyHiCPnCw0h66sDNxPgPvTC39POECh5DO2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KX95az9j; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KX95az9j"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2ee67e9287fso1149064a91.0
        for <git@vger.kernel.org>; Wed, 15 Jan 2025 23:29:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737012549; x=1737617349; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=RQkbUDgIIfevLarB/bOu2z45bdaXNEUuFSW2r8o9Vdc=;
        b=KX95az9ju8eFY7Ej7lnYJvZVUKOoa+D08/V0/ZwCkqb69Suc0CaTVJF7AksrrNb1ES
         Y0VpiDePv2JO1X+WGEW3KC/HqlN7valslgmDE2LbQR5YpUsso2jIMVnJYEWmYJiI8VMJ
         oi/NZ+XxwezHVL3W50meO4519BMK4NTBjVIXGR3r/ZDm9piJUMoeosBlhfY7L2nEAU+3
         MiVfdryYVu0CZfUvRyHOR/bDbBFl1I8S0Z0NfXR1Qyip0XtRmWZ79kYA9BJj63UtTgO6
         8iPpZ0zQ0C5Za4WucbcR0LQUwEzyn9kl7/K/V04unS+Anijli1JoZZoE/t1FhcIZYsVx
         qheg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737012549; x=1737617349;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RQkbUDgIIfevLarB/bOu2z45bdaXNEUuFSW2r8o9Vdc=;
        b=tU/Brjaoczvp8tiKfTuk9w7KXriku1u0M7+Jy6M8SF1PFEqLJQNbGNNcYh+YhfTbvQ
         RreUTmKqyY45pnkmAesB+7JQ5fSKXFdGBsAY0oD2oPZBBjSnJ5Zcx6692WWQSWHvtR/f
         0Lns+22FlZIRWYHqbEkvP9aXxKT85ESThh6VJKRYJLFK+wYnENDnJ/FOhTj3kjq3ajyP
         HXHrfqqQ/JTMrlxOFTTsZLeXqLNZ8BHY9lWu57WDnn2X7uc99R7Dfhl62m71zXI81ubo
         Gmf3d24F7BJrbELrqvG0EO/jh1a64DqZZSIg0hRg8vgIRi647Lk37WLg0ZcmRBX0FJr5
         TUbw==
X-Gm-Message-State: AOJu0Yy85O66Uah3M4xq/Ic1ONHZx2E+MXKxK3GWZw2MCgvbLJQdjEkr
	DHy7Au0UQZNX6CwhOtoibDS822HqiBjGfXTeY9jFNPx+aFKAdsK2M9hcJw5zMDhaSGYBkuX1E2y
	ddjQB2I4qaYEGFTM7aIZ/+3thfL0=
X-Gm-Gg: ASbGncv7LWvRfnYWflWCeX5SIw/HEP5ZX10B+pXc11aeugz6Qyppn/a8gcqYjKTVa3r
	a16mKJFVbUFPtENYYrW4+KP8p40yhNFlTqfFPFus=
X-Google-Smtp-Source: AGHT+IFzeg5iZb5qAHkFr74KIZ3/TODLXasaUnqkVy3ksYp1clC+iiCpbZdEuSsq6O5vvPFfc5OzRIhpN1ywkRC38v8=
X-Received: by 2002:a17:90a:d448:b0:2f2:8bdd:cd8b with SMTP id
 98e67ed59e1d1-2f548f603e7mr46051217a91.29.1737012549375; Wed, 15 Jan 2025
 23:29:09 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 16 Jan 2025 02:29:07 -0500
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <Z4hpXwtv-ChwAGeG@tapette.crustytoothpaste.net>
References: <Z4UbkcmJAU1MT-Rs@tapette.crustytoothpaste.net>
 <CAOLa=ZTL9n_DPhNr49XAd6bT838kc09oVx_AH7Pb4o8VK_xQ9w@mail.gmail.com> <Z4hpXwtv-ChwAGeG@tapette.crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 16 Jan 2025 02:29:07 -0500
X-Gm-Features: AbW1kvZD36niWEDokpB5n9i3tqiH_MRiLFO3u_tskiU2bzLmJVthriaPHjQr3R8
Message-ID: <CAOLa=ZS2ZQRSbirW1HLYJ1d1HAwmfugKdNGBCNGtS-yS1rcKEA@mail.gmail.com>
Subject: Re: Bug in 2.48 with `git refs migrate`
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>
Content-Type: multipart/mixed; boundary="000000000000f9f331062bcdbfb5"

--000000000000f9f331062bcdbfb5
Content-Type: text/plain; charset="UTF-8"

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> On 2025-01-15 at 11:54:51, Karthik Nayak wrote:
>> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>>
>> I'm attaching a patch below which should fixes the issue for me and also
>> adding a test to test against the same. I'd be grateful if you could
>> also test the patch against the repositoryies you mention.
>
> Fantastic, I'll try to do that tomorrow and get back to you.  I really
> appreciate such a prompt response.
>
>> diff --git a/refs/refs-internal.h b/refs/refs-internal.h
>> index 16550862d3..aaab711bb9 100644
>> --- a/refs/refs-internal.h
>> +++ b/refs/refs-internal.h
>> @@ -203,6 +203,7 @@ struct ref_transaction {
>>  	enum ref_transaction_state state;
>>  	void *backend_data;
>>  	unsigned int flags;
>> +	unsigned int max_index;
>>  };
>>
>>  /*
>> diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
>> index 00d95a9a2f..289496058e 100644
>> --- a/refs/reftable-backend.c
>> +++ b/refs/reftable-backend.c
>> @@ -942,6 +942,7 @@ struct write_transaction_table_arg {
>>  	size_t updates_nr;
>>  	size_t updates_alloc;
>>  	size_t updates_expected;
>> +	unsigned int max_index;
>
> I wonder if this and the above should be `uint64_t` instead of `unsigned
> int`.  From the file names and the data format, it looks like we
> intentionally use a 64-bit integer.  That's good, because I have
> unfortunately seen some people who have created giant test repositories
> with really unreasonable numbers of commits and I could see us possibly
> exceeding a 32-bit integer here.

Ideally it should be okay, since this only comes into play when we're
migrating reflogs. So the index would be the number of reflog entries
for a given ref. I suppose even for large repositories this number
should be low. But I'd rather be safe here, so let me modify this in the
next version to be 'uint64_t'.

> --
> brian m. carlson (they/them or he/him)
> Toronto, Ontario, CA

--000000000000f9f331062bcdbfb5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 5b19bac3a1b68fc9_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1lSXRVRVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mOFByQy85ZFZzNXNod1pUWVp4eWQ2YlFXUlVMTmd3VApBM2tCTHN2SndZ
ZkZtbzl1aWR6R0J5WnBxMEtjZWgvaHVYQUdiUUI5SUdQTjYrdkN6NXQ5cCtqblM5TXd6bEJvCk1W
RDdmcHpHZlRSN1ZJTTlsOXZXa2tyczlpODAwTElFeEs4di8vK0JsbHRjNXFMa3hmekxXUkZsejdQ
UVYweDgKY3RKZkorbnY1OEJkWVdFaElEa05adUFXb0F4N3V5RHIrdXZLMDZPV3RkUHFwbXY4Rk02
SU5LUnAyamNKOGptbApGVk9uS1dBb1VHTnJzQXpDWGVFdVBGMUJ3L3VqN0xLMWdtZzV5MG1Jb1lT
dTdEejUxMUNIRHhMYlg2c3pMWkxICmxTVlk1UE5MYnhzVjRNWnJ6aGhjbmRSQkZXU2Jtcys0V1Ev
c3p5Q3FCTkNUcWZqcUs4RlFRYm9ZS2d3QmU0YjcKZFhaRHJGR2J3YlVGUDJkak91Zkl0U0tzWEpZ
NUlPZUhTNVFUa1J1SzhIK2tlZ0xrTnora1MrWmY3cnBoeEJWaApta3czbDlQbHVHdGhLaEloWThH
eDI5b2FKaXQxc0NwRE94T0Q3V3lIelFrdmN6dTRtT2dGVFgxT21MekVjMkVFCjNMQXcyMzA2Tlhp
cnoyajB4bTkzRHBacTRXa0U4OGZmMmdzbjRuVT0KPU1xMmcKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000f9f331062bcdbfb5--
