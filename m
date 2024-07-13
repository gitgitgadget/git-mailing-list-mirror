Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80D2D17C73
	for <git@vger.kernel.org>; Sat, 13 Jul 2024 16:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720889180; cv=none; b=Z0ZIvU/UrHd75Pojv651RHL6/eRZaNABh6hBOy76G6tyddfi0NvcPJDB/RILVisYqav7Li77CwXWUI56MvchrgIbEGniKTMkXcQy78Cz2iw9Y25eHoiVHIu8eWtHUatUS2l1L8ebQwzPz0wj9F9Z351LB+4X7NITG4vo0JwfHuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720889180; c=relaxed/simple;
	bh=V3JhWRJdAN1nU99dE5gvdSiHMeuy5ABVeK6vXUoeOOY=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=APzUKUwr2mJWzLgWgCDWTx6gecVfPNDYrdm9igWokFUxG5o3CHAWyEXRoyATc8rh1LyTGFeb9RKI6YomdGR1YHLQEDWhPbZVYlyk+AyQXVtHTAQ0OyQQv/8bv/dNH0dE0dXGL/K2vx5iRLzRrg0CGYB31LxkNyplH5Cp7AXzexk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hsi+zZP+; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hsi+zZP+"
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-704466b19c4so1564251a34.0
        for <git@vger.kernel.org>; Sat, 13 Jul 2024 09:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720889177; x=1721493977; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=UHgtHfwsIAT04KNOGlOS2diq9Ay5uH4vNBH6rfYRYDg=;
        b=hsi+zZP+35kKMm5zD9L2moCdxQezGu/bL2CjUs19pCneeduhLxhFvJV6h6liaLX99Z
         6USWa4xkXGNtP85iycR1NJ29Cvk9NDF1CF3z8UkKiW1bC5coBRZuz5PPFk2x85YR5XZy
         hW7tcOPgag8LZwZ4EZBcSP7HFa0L+dg/NbtTsjyFfgi96VKMGiZ12bTp4Gujenh56zHx
         QWeOfnPPGiUTII+pYpv/IgqnxDYuLVbJojQwCuNjLSiqtFZT8EEqntnMXUDEumnbvASc
         gkBJppD+fFEVutNH/bEK3JKhmZbeAXTlJJRDxpImKl0V58bHvQBYwoT0/vqNpJ0HA0i3
         VjpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720889177; x=1721493977;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UHgtHfwsIAT04KNOGlOS2diq9Ay5uH4vNBH6rfYRYDg=;
        b=vhKvY18OKUJrlymvRKCf3MHfslVlWAqDT9YnSBPO7Dy45xzWEnpcV4Si6+hQLUDDk9
         czjT1CokoHJZ9rauB9Aa/Hl49Ji3Qj/QqzejGpKMZ/TwenAXfVOk2ma++O6vxxJ8GN0j
         o1b8XRi37XRfgEdd4r80LQQagEsXCVSgdOjew4D8zKijE0tTKtK+ibUJpuAEjZPZ8ZAS
         IMp2wPynqSPY7kvb9+MZMPliYySTSYhSkQo35/D5rvKo+y+z+BWDL9pQ5yIdOWFmOOz1
         Q8XTn+jm30cMEVE537B6ccagPsLiXloX0sdBhLA3cP+atSwC7ODpCs2TxsCRUTslVawt
         N+NQ==
X-Forwarded-Encrypted: i=1; AJvYcCXBOajiDFi7Zgfn3FktL12XwJUEC5v2gal29nNdtwQ/LBvVl7AV9vqXyqpms3vuJlW4Sp7N8TbGFCcQ/gTcohCC2ce4
X-Gm-Message-State: AOJu0YyH1LmhGiSU4sAAc05eH9poesEzlR1fynN5c+98ntqQhcPVtOx6
	NNbGdjmW78CYbvIOo9DOOqlKLJlMuPADRR/WAXWgIiBKa2x74oKowCHmXS4Vr4xv+iV5EoZANq0
	GnB/Jsa21bkZPluX0E0nDpjd87DU=
X-Google-Smtp-Source: AGHT+IFYKWkm1g9YuKjqkmccs4vi2zVTXseEeC/CpM2bg648qEHRQWHnm8hYzsydNPNmLyofp/1Yhlp3SAa85z8Gprw=
X-Received: by 2002:a05:6871:5211:b0:25d:f71b:685f with SMTP id
 586e51a60fabf-25eae7ce54emr13664004fac.2.1720889177472; Sat, 13 Jul 2024
 09:46:17 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 13 Jul 2024 12:46:16 -0400
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <xmqqa5ilcngi.fsf@gitster.g>
References: <20240711083043.1732288-1-karthik.188@gmail.com>
 <20240713134518.773053-1-karthik.188@gmail.com> <20240713134518.773053-9-karthik.188@gmail.com>
 <xmqqa5ilcngi.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sat, 13 Jul 2024 12:46:16 -0400
Message-ID: <CAOLa=ZTkYs_Wz2YM82Nm0yPJX8-hYV3WC-aMEqYNRoS+2ZpG3A@mail.gmail.com>
Subject: Re: [PATCH v3 8/8] ci/style-check: add `RemoveBracesLLVM` to '.clang-format'
To: Junio C Hamano <gitster@pobox.com>
Cc: chriscool@tuxfamily.org, git@vger.kernel.org, jltobler@gmail.com, 
	phillip.wood123@gmail.com
Content-Type: multipart/mixed; boundary="0000000000001f20b8061d23bccd"

--0000000000001f20b8061d23bccd
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> +# [1]: https://clang.llvm.org/docs/ClangFormatStyleOptions.html#removebracesllvm
>> +echo "RemoveBracesLLVM: true" >> .clang-format
>> +
>>  git clang-format --style file --diff --extensions c,h "$baseCommit"
>
> Style: lose the SP between the redirection operator and its operand.
>

Will change.

> I know this is well intentioned, but will there be any downsides for
> running the check always against a dirty working tree?
>
> I know during a CI run, the working tree will not be completely
> clean, as we create and leave build artifacts, but this is as far as
> I know the first instance of us munging a tracked path, changing the
> working tree in a way that "git describe --dirty" would notice.
>
> This is done as the last (and only) step of check-style job and the
> ci/run-style-check.sh script may not do anything like "git describe
> --dirty" right now, but things can change.  Perhaps I am worried
> about this a bit too much.
>

Exactly my thoughts too. I did test on GitLab's CI and all other jobs
were unaffected. So I think we're good here.

---

After reading your mail, I figured I should also check GitHub's CI for
this particular change and realized there is a slight issue with my
current series.

GitLab's CI highlights style check jobs which failed with a yellow
warning symbol [1], even with the 'ignore failing check-style'
directive. But GitHub's actions, simply marks the job as successful even
if the job failed [1]. This was an oversight on my side, since I
expected similar behavior. Seems like the required dependency wasn't
even installed on GitHub causing 'git clang-format' to fail.

Unfortunately this means all GitHub workflows for style-check will be
green even if there were style issues found. I couldn't find a way to
fix this from reading the documentation.

This will not be an issue once we enforce, but till then users cannot
rely on the job's outcome for the job's status in GitHub. They will have
to see the logs to know if style check failed.

I will re-roll with a fix, but will wait a day or so, to avoid spamming.

> I unfortunately couldn't find an option to "git clang-format" to
> tell it to read from an extra file in addition to the usual
> ".clang-format" file---if such an option existed, we obviously could
> use an untracked/ignored file to prepare the custom format file and
> use it without making the working tree dirty.
>

This was also something I looked for, but couldn't find. I should have
added that to the commit message. Will do so in the reroll.

> So perhaps the posted change, while making us feel dirty, is the
> best we could do for this step.
>
> Thanks.

Yes, I think it is okay. I'm hoping we can move it in-tree someday.

[1]: https://gitlab.com/gitlab-org/git/-/pipelines/1372326813
[2]: https://github.com/KarthikNayak/git/actions/runs/9921272597/job/27409047062

--0000000000001f20b8061d23bccd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 263adebc8046ce57_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1hU3IxY1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNEplREFDWi9XbkpKYnlFWldBWTNobXVDYk82dkZtbQo4b2YwTEJDTjR2
Z3JjTUMzU0tXMGtWelJ2enRERGFGMU1EYjUwUFB5cGZJNjNDcTRIVGNzNGlKSmVsbzErSktvCk5i
eXdaRUYrZGN2TVhSV1c3K3U3c0xJdzRFcDhwL3BQRmxqMXBudlpMZ2VIYXlhbEJmclptOURUUks4
dExIRnkKcVFBSC80REJOajdBbTZFYUp4RkhLVFFLRnAvcktadFRXQmpNWWx2STZ2L3hyWHBNaTZu
NUVMTVprQWczbk0raApkQlR2WkZ1c09VK0FUcVN6cE9PMCtnWUFkL3k0OE5nanFtRGRhSTRBZEF6
d3U0SE9BdGhNRERmbTlhcU1SdXhRCkhxUHhTbXg4RnkvRCtOeEt4T1JiYSsyeS80emxGT0FvZnA5
TDljK1dTTTA5VVBONkJRZUdJM1pxYjBXYlJNRGcKQ3ZENlZ2R29pR0dsa3dkdnZxa2luYVZtNlZi
cUVRSW0rNGhoUW85TzQzb1RPdHhUQWR3dzZaYnRuaVF3bjd6cQo5Z2ZxRVRCN0t3Nzg1dEFZQzhh
d1RVL3hqMWxJR3B2aEVTc2J2RlZFODNFcFpzRk5IWjYzanNyaUYrQkJCcUdmCldKVlZPa1ZMakd6
Qk9YcytGN1R2YmdNaUNxRGtDQWxJczhkUVN0Yz0KPVpmR2oKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000001f20b8061d23bccd--
