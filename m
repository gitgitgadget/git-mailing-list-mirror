Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B46CD1CEAD8
	for <git@vger.kernel.org>; Thu, 10 Oct 2024 19:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728589765; cv=none; b=oFplsiIIKmOEwxJznPYPcYV1VPoeXk3YHxn4dx1X9hbRzcgMsehD0OLSMbGVi+YplBRUHqRV4lvnmMVKpmsWqnjZIuxBLD24+MXZupQt7mhVynQeV8oKnfG4EQ/HyPzacgQ69AJF2WlGJopiF9O4RePsoLTLIAtyZW1yZYyL3+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728589765; c=relaxed/simple;
	bh=KoqNEuPSlAIyf6VPvF5JIrNzM7Q83MgDfZUjufVTklk=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c3/ku9Z8ks546q+miw1Z/jvWkP9pbGT2SOpqCD+AYeIXyzBGo/eKXNg5ZgOHWJC5r7VY+02KHMeI14wFMAkAE3XQMykgNVCy2G2/OPUr0vzitbrDTmGOhmdMCcZePJaCEvnxf4ZQmNt6Xad3IpHQ4TfMYpI9+mnWhXInYG5uK2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R7qRZj3a; arc=none smtp.client-ip=209.85.222.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R7qRZj3a"
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-84fd616acf0so314014241.0
        for <git@vger.kernel.org>; Thu, 10 Oct 2024 12:49:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728589763; x=1729194563; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=awUwU8wZipWUKhPAXYXosuiggD37mY3pCWJCZxVy11g=;
        b=R7qRZj3a3aRO2lgKVULLCgv0s/V4/qD4L3Ygg0DNSGv9KrfMZRGTelu5bYxOTeLnsL
         ok9fQbbGCDZxlYLc/MSoV9apfZXFmjz0At7Cx0IG5F4JkSzTYVG2zZM5Ju8KERTpISD8
         j2O5pOU37ww6IsK4iDHqX6kW9u0f90G5Ck2zKa4Gz2ai7V25bDzDVZhAgXdJVk3ViSEy
         NK0fbUf5/1BrmBGrjYKZi2mxH0PPu8STufnbXOwDF98umMHHNqEC7JEtPRqZBoLkxwGQ
         gddr48DOXrNtAvOiszG2VuP9gUwv5UG5o9EpxBYXIdSADYonWzkvYIa5ZxFLIZiSo50b
         fNbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728589763; x=1729194563;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=awUwU8wZipWUKhPAXYXosuiggD37mY3pCWJCZxVy11g=;
        b=Z59UQLZxAW9UIc8mCSN9zjvSsGVBVcS3tC7OYUBn80eOuF2+MqkQ2oawjKLkyqRHCe
         VQC7a1KazSqRau6muAkYvKj1zK6qKOrktBpGetFhotUH85If2LDUMTCGFF/a8nmElFCN
         QcHC4Hbfo76tqBHymVlNBI6EnZDVj1C0HybK1Gp3AoargwWBfnXmXakAQQQHKrs6drzE
         M1/OkYqypLGb4z+ClZ+s1cWCGvuUNtvJRHsd9bX+qzjfz77OaFjguqNqwOYIGlMUPvb6
         2sn7s6nfKwivVm7pJQ6IDMO3nqB3Zx/0X9JmXacl9NukznC9vCq2NAaePRn0fn9x0zod
         5llQ==
X-Gm-Message-State: AOJu0YzRYeOoDKpbUOGLHJW75gCdLMhFVXn2RHJfVvIQlGyEgayyjIwZ
	9FDvAHQCC2hLSVKhIROck+AFqvLbAZe44LSx/Uckgc65wXci0nqUukIJTgLWuY8GDxi8I68IWB8
	eYkQeRnlLiTQa1U9AfTEb/qA9YNjASqPk
X-Google-Smtp-Source: AGHT+IGwfAomsoDHJ2fgPMnowZbglif3KQOtSfClOQ578lQgN8xP0/GUvx8b/TwAyHKqUJ2HKxTj1lhYcgV7AtDmPi4=
X-Received: by 2002:a05:6122:2021:b0:50a:c31b:33d6 with SMTP id
 71dfb90a1353d-50cffbd14f5mr6068245e0c.9.1728589762593; Thu, 10 Oct 2024
 12:49:22 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 10 Oct 2024 12:49:21 -0700
From: karthik nayak <karthik.188@gmail.com>
In-Reply-To: <CAO_smVjuseH6WJgU5CRg5kyZ7J1mgqLjrvxzapR0xB6XvQ7VdA@mail.gmail.com>
References: <cover.1728582927.git.karthik.188@gmail.com> <e22ffbe0f65971579809d817984766af12898127.1728582927.git.karthik.188@gmail.com>
 <CAO_smVjuseH6WJgU5CRg5kyZ7J1mgqLjrvxzapR0xB6XvQ7VdA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 10 Oct 2024 12:49:21 -0700
Message-ID: <CAOLa=ZQ=-GwnCX7CP6sqmoArphQuUNbfcCje2_64k9g8yJ1PBA@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] clang-format: change column limit to 96 characters
To: Kyle Lippincott <spectral@google.com>
Cc: git@vger.kernel.org, gitster@pobox.com, jltobler@gmail.com, toon@iotcl.com
Content-Type: multipart/mixed; boundary="000000000000c3264e062424aa89"

--000000000000c3264e062424aa89
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Kyle Lippincott <spectral@google.com> writes:

> On Thu, Oct 10, 2024 at 11:00=E2=80=AFAM Karthik Nayak <karthik.188@gmail=
.com> wrote:
>>
>> The current value for the column limit is set to 80. While this is as
>> expected, we often prefer readability over this strict limit. This means
>> it is common to find code which extends over 80 characters. So let's
>> change the column limit to be 96 instead. This provides some slack so we
>> can ensure readability takes preference over the 80 character hard
>> limit.
>>
>> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
>> ---
>>  .clang-format | 5 ++++-
>>  1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/.clang-format b/.clang-format
>> index 41969eca4b..684ab32d28 100644
>> --- a/.clang-format
>> +++ b/.clang-format
>> @@ -12,7 +12,10 @@ UseTab: Always
>>  TabWidth: 8
>>  IndentWidth: 8
>>  ContinuationIndentWidth: 8
>> -ColumnLimit: 80
>> +
>> +# While we recommend keeping column limit to 80, we want to also provid=
e
>> +# some slack to maintain readability.
>> +ColumnLimit: 96
>>
>>  # C Language specifics
>>  Language: Cpp
>> --
>> 2.47.0
>>
>>
>
> I think this means that the next automated `clang-format` invocation
> will un-wrap lines that were wrapped at 80 columns (not characters)
> but fit in 96 columns. Modifying this setting and running
> `clang-format -i *.{c,h}` produces a lot of diffs of that kind. I
> don't think there's a way of setting a soft column limit in
> clang-format.

Ah! Good point.

> Personally, I'd be fine with a higher column limit, but we'd need to
> make a conscious change to the style guidelines for that.

With this, I would say that the best choice here would be to actually
set it to 0 like the previous version. So that we don't actually enforce
the column limit.

We could perhaps set the value here in the '.clang-format' to 0. While
also setting 'max_line_length =3D 95' in the '.editorconfig'. That would
mean that we don't enforce a width, but we nudge editors to wrap at 95
characters. Here contributors would still have the power to decide the
adequate width as needed.

--000000000000c3264e062424aa89
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 749d3ed64ec57663_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ0FBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1jSUw3MFdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNlFmQy93S1F4emdGdVRJRnljcTNadjB0U0FtYTIrMQppS2hsY1FKd0Uy
dzl5RzRtdkV1Y0lTSUtaUUJjTmJ4cTZ0VllQdWlpTGNvbHhnaUxmdzhrUDRmYktlRnZUY0d5Cmd3
bEtYR1RERlJEczhIa2hlTmk5SEtEZjNIbmlPM3NVY0dwYmx2RWs3MnJKV1pwb3V1cVlFa1ZuTnJj
bjZxL2oKYUdlVFRCdEdOaTB5b0hoM2VmMjhESjl3RENEN2krZGpuMlJSNGFKcWlFeDYvUmx3Vkxm
VWNMZWh0SDNuOGkyYwo4TW9RWDE4MlpNbkgyQkR4emNBbllxOHhMOXQwOW1HM21vZGZRbXJmY21u
aWxxaFM0bUVxVGY5VktnOFZMS2dtCnBPOVpDTGZ4V1RjVXlKQ1JyRE9USS8zWTBYWExqbWJCUUY4
V0VzM3lMbDFkWmNuSVpXSzJud2dlcTFkcWl5VVEKc2E0bVB5NEppTy9pRC9RdnFwUCtBT1dBM1ZS
RmNoNGljR283MG9Wa0hpWFFuNzZ1TFFiM3p3dUVOQ01wcW1PTApCVU5Oc1J6YUUxbnUvTnRqd3pU
TTY4SFVrN24rMldseUNYb3RGT0tha3pWNVkvRkNMV3c1YlkyM1MxaS90MmlTCkZvVyt2U1BSL1dr
ZVR3bjNKVUV5dTdPMjBrdE1xTU5HaVkzNmo5QT0KPS9aKzgKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000c3264e062424aa89--
