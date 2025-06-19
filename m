Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CDA624729D
	for <git@vger.kernel.org>; Thu, 19 Jun 2025 20:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750364723; cv=none; b=Ki96FuXbqhDXnmGAfhMZD6rmmWuOhofw+zG8SEHaW/+4JiKOHithvxArDpxrHiAK9TNVbA21iD4EqSuvgjmPfwv9dmGY9GpuBg1KfhF+J/2TrH92/ywqMeCPYXmKxVvSq682el180vZzv8kH2EBGgkR5h4XeWaDYpDzVoCRf2Bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750364723; c=relaxed/simple;
	bh=2PvWkBXIpgF2m/v7SlWMgmd641M/NQnfAmwnFmR3RlU=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G88W0VYok26F9W8NDC2j3il+EwB2+znlHua4lTpFOAtI6F1pd9ny8k3pSZG2pR8YukuePVs/DeCea/aJ95hHsfSJqAraLcBlTWgOTD9kIVaaPPAAq2wfAmyN9YisOPfW3hRhpCkm65871SxN/sMJquM4SWYow23rEwvRA2Y4I+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eNS+yXD4; arc=none smtp.client-ip=209.85.222.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eNS+yXD4"
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-86dc3482b3dso850690241.0
        for <git@vger.kernel.org>; Thu, 19 Jun 2025 13:25:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750364720; x=1750969520; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=eoTo8CKOhsQ5TZBNbQ2aee+m3Og0NaLdqI+d3ChXhko=;
        b=eNS+yXD4gWgFgpB0WZ0RcTkdMdDTPECs2udB2YAvIyoVminqbd+4s/sCRJPBqaHxtE
         6dmyX5PZNSmhopnGlwrvnAyC6I4b/NXz7dOJ6T/YymFU+5Du0IKaMpqljdCgWjC1Pigy
         j5+BeWnGnmNoYdjlJ3/JTUmk0X2yRxQ+kJ5ESlnnbeCnTGfp2cEyWUNdZFvyEs0xhQnC
         v5JyKWHNXsIXBstSMUvCjbjntbo8Rj9ouqZFemZq3cegBDRpgJNom6atj5RoyKZ6tlgK
         GJ1YsjhgKc1ZKtM16Ip+7iSi3vAkYeTtIPOQmGGMor0oqX7Bi1enJLBAC1cMHbTa7xBL
         xkLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750364720; x=1750969520;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eoTo8CKOhsQ5TZBNbQ2aee+m3Og0NaLdqI+d3ChXhko=;
        b=oIeQv85RxSRLLPoL95YTolyEWwjXMl7dWucUKatUrnCcBFLDZSPVgTGobuXGCpAXrI
         9TMlMX6lqcl41+B5aubx3lMkSHJuAKuY65uF4dDck+fgtkF/gq0Flj75k4B+S5/7PECd
         mGnUsKY0tVsJIB4U7cTvkNHJYpopxhGd+rYyvbNia4RKNzFCwj5tFQxdgn1CESBfHUXv
         jbASl1oJwcim7bPpQ4AjUjGAiX0B5MeFzTOcQzUpgYmakolZ/Q0wTPQn/F1vZBTFmGKA
         xhKSEv+RmwSJ/SCn1nN9hCs5gGkRHxJBJ8E1WH+BmBQIxPbw7ZhVOOh7cI+ZiBJQeKqD
         DQzg==
X-Forwarded-Encrypted: i=1; AJvYcCXgCFCgEeMMdmvhK5Q0Y80k6YnwtdapQuC3VyqzqKXrzOtcKHn9ZfSSeX4Qq0lm32X/IUA=@vger.kernel.org
X-Gm-Message-State: AOJu0YycPBWNYQ7Nk11IcYYxi6IDE2JdCnE3lKDmI5yXcB+02Cj2gQ8Z
	9oW41zoFIa2vsYwuw9Xncl061nfNm7vGerJIZprgAnlpR5msttne3JyVE20AtebLHYbXYTRqQPo
	n4vMw1VekMJKneB4YWgPHlQtVyW7dqbj96GjgPCc=
X-Gm-Gg: ASbGncvxu7PQIzh6JgZWVVpPVLIIlO1V4FT7A7akQzLJSFY0zmcaWj+iJiv/cBXiGsd
	9vY6f6By4RI1Jj0R0pFzzpBBkiB+wx7E5v3otLXJHEOveQIzMEJ+gpHatb1PcKct6Yh3GnbthCl
	qSMifUF4qTPJ0O7EW85ZkAzG4QlmcDRRKQmFps1uNX
X-Google-Smtp-Source: AGHT+IH+PV5tfOtk5fLJR2kjwtuh+H1eyPam06k7vE2iz2twfAymKh/srGXBnjD80AK9OHwigOxIHfMMZhxz25luDV4=
X-Received: by 2002:a05:6102:2b99:b0:4e5:9608:1298 with SMTP id
 ada2fe7eead31-4e9c3068848mr198178137.9.1750364720261; Thu, 19 Jun 2025
 13:25:20 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 19 Jun 2025 15:25:19 -0500
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <xmqq5xgrdan8.fsf@gitster.g>
References: <20240718081605.452366-1-karthik.188@gmail.com>
 <20240723082111.874382-1-karthik.188@gmail.com> <20240723082111.874382-7-karthik.188@gmail.com>
 <xmqq5xgrdan8.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 19 Jun 2025 15:25:19 -0500
X-Gm-Features: Ac12FXyW_Bi9psccMBqEYzlGlavJY8P9foKkpije2eOoJmyl4v0T9WlaWRQAa2M
Message-ID: <CAOLa=ZSiGxBHiMZbUoRN0nB24YdAWypgyMYMEe-EW9EHtbx7Kw@mail.gmail.com>
Subject: Re: [PATCH v6 6/6] ci/style-check: add `RemoveBracesLLVM` in CI job
To: Junio C Hamano <gitster@pobox.com>
Cc: chriscool@tuxfamily.org, git@vger.kernel.org, jltobler@gmail.com, 
	phillip.wood123@gmail.com
Content-Type: multipart/mixed; boundary="0000000000006107b40637f28b48"

--0000000000006107b40637f28b48
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Junio C Hamano <gitster@pobox.com> writes:

> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> For 'clang-format', setting 'RemoveBracesLLVM' to 'true', adds a check
>> to ensure we avoid curly braces for single-statement bodies in
>> conditional blocks.
>>
>> However, the option does come with two warnings [1]:
>>
>>     This option will be renamed and expanded to support other styles.
>>
>> and
>>
>>     Setting this option to true could lead to incorrect code formatting
>>     due to clang-format=E2=80=99s lack of complete semantic information.=
 As
>>     such, extra care should be taken to review code changes made by
>>     this option.
>>
>> The latter seems to be of concern. While we want to experiment with the
>> rule, adding it to the in-tree '.clang-format' could affect end-users.
>> Let's only add it to the CI jobs for now. With time, we can evaluate
>> its efficacy and decide if we want to add it to '.clang-format' or
>> retract it entirely. We do so, by adding the existing rules in
>> '.clang-format' and this rule to a temp file outside the working tree,
>> which is then used by 'git clang-format'. This ensures we don't murk
>> with files in-tree.
>>
>> [1]: https://clang.llvm.org/docs/ClangFormatStyleOptions.html#removebrac=
esllvm
>>
>> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
>> ---
>>  ci/run-style-check.sh | 19 ++++++++++++++++++-
>>  1 file changed, 18 insertions(+), 1 deletion(-)
>
> Have we done enough experiment by now and don't we want to move it
> to the set of rules in our tree?
>

Christian and I were talking about clang-format today. So great to see
that you too were thinking about it. I think this particular rule should
be okay to move our tree. For this particular rule, I found one spot it
fails:

  $ ./ci/run-style-check.sh @~1
  diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
  index 1809539201..341d9eac0d 100644
  --- a/builtin/receive-pack.c
  +++ b/builtin/receive-pack.c
  @@ -1929,12 +1929,11 @@ static void
execute_commands_non_atomic(struct command *commands,
   			goto cleanup;

   	failure:
  -		for (cmd =3D commands; cmd; cmd =3D cmd->next) {
  +		for (cmd =3D commands; cmd; cmd =3D cmd->next)
   			if (reported_error)
   				cmd->error_string =3D reported_error;
   			else if (strmap_contains(&failed_refs, cmd->ref_name))
   				cmd->error_string =3D strmap_get(&failed_refs, cmd->ref_name);
  -		}

   	cleanup:
   		ref_transaction_free(transaction);

We generally add brackets in such scenarios, but the style-check
suggests to use them instead.

> How often do people use "git clang-format" before they submit their
> series these days, by the way?
>

To be honest, I don't think anyone does. As far as I've seen there is
too many false positives currently.

>> diff --git a/ci/run-style-check.sh b/ci/run-style-check.sh
>> index 76dd37d22b..6cd4b1d934 100755
>> --- a/ci/run-style-check.sh
>> +++ b/ci/run-style-check.sh
>> @@ -5,4 +5,21 @@
>>
>>  baseCommit=3D$1
>>
>> -git clang-format --style file --diff --extensions c,h "$baseCommit"
>> +# Remove optional braces of control statements (if, else, for, and whil=
e)
>> +# according to the LLVM coding style. This avoids braces on simple
>> +# single-statement bodies of statements but keeps braces if one side of
>> +# if/else if/.../else cascade has multi-statement body.
>> +#
>> +# As this rule comes with a warning [1], we want to experiment with it
>> +# before adding it in-tree. since the CI job for the style check is all=
owed
>> +# to fail, appending the rule here allows us to validate its efficacy.
>> +# While also ensuring that end-users are not affected directly.
>> +#
>> +# [1]: https://clang.llvm.org/docs/ClangFormatStyleOptions.html#removeb=
racesllvm
>> +{
>> +	cat .clang-format
>> +	echo "RemoveBracesLLVM: true"
>> +} >/tmp/clang-format-rules
>> +
>> +git clang-format --style=3Dfile:/tmp/clang-format-rules \
>> +	--diff --extensions c,h "$baseCommit"

--0000000000006107b40637f28b48
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: be5732b38a8d57ff_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1oVWNpc1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMkxFQy9zSDJ5WndqK0prT2NrbTJVdWtia3lqOVFZTQpOU0RBR2FmL3d0
bmxEMHZ0cThueHV3MVZ4RFoxUWJ0bUJBcFNOeFpPREl6T1hpZW1RTWZONVd4WjYvOFdzTUpNClFX
Y2hwd21jMW1hTSt6RmxsSVl2enhHS3JaNHovQk1JRjUyd1V2bkxkUC9wYW82MFJEYW83TzlqNEg0
WTk0aUIKaWhLcTNQYVM5RkxLUWw5UUhKZjFxZCtlSWIvaEVsRlRXOGNTRzV4UHhqeEZEU1o5aCtp
Tms4V1NZak5IY2x3WApISk1laFpzSDhNbWxnYkphVHJ2ek9DSHJCNmdHT2s2SkpRWFZmbUxWTkxk
Q3U5TTNROFgrdlk0VFBXRHFmV3dQCkVPcjF1RnY2elo5NlZ2Y1YzSTFFWmtVVUJkeVpVYklUNi9h
cXRzK0pkNnk5UzhvMy9UenlLS1VaUVBLMUo2bXQKNzZ5cFl1Zjd0YzlieUFvTzVrSzhac1g4dHQx
dVJBUHNiLzVBZmtQSThEOTdzeWtVL0w5elVHblhGL3JBbzlCaApKMUJrU2hxK241R3V1N0VDUkgz
c2JtdW00dDh4OTNyTmkrdmpzbFU2dDF3VkF6QVVhekk1dDMzZGRDdTNnd3B0CmZRV21obDEweTVz
UUJZZjlwaUhHSnM0ajY3UWdhQVhKL2FTRkpjZz0KPXJtUlgKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000006107b40637f28b48--
