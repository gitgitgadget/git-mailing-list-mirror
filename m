Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0300823BCEC
	for <git@vger.kernel.org>; Mon, 30 Jun 2025 08:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751272492; cv=none; b=YqMHpB1FK/aUqyi4P2ciE0N662rZBZ/cEZnD2cdd3sgbtrk3xU4dp5+trFGh0pqN92xvjodE9XnafedylAP5S0/uN7PHEK0u6LEdoFbSpVnJElyWuGmgZjxgsRiy/mr7ZZrreLUggH0tN5Alv6S3ZKKvxXzHyBhpwWzUa0K62Go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751272492; c=relaxed/simple;
	bh=ZSQ7AA8ICD/Zu9f30wRfMiyM9WeMJ2bzbmE5jdssrmk=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CkLQYTnaVQoPABHL6udI0xJLVyD0pwp1XAM0XOFPJnb+JIaxgvvatcSJtDFFEfsCDzBAblrq7KGPNt33eJ+G/+ValH0mQ42cHBMbpN8jZUd2A+H54o134wDo2xBvZMhe0Tw+BJmT4a1YKHwWLKxzPTghLSMUqrfky/ISfpVBNBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HuXLbHSD; arc=none smtp.client-ip=209.85.222.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HuXLbHSD"
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-87ec9aee6dbso834533241.0
        for <git@vger.kernel.org>; Mon, 30 Jun 2025 01:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751272490; x=1751877290; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=8dTsCJP5t130VRtxUhId39omk2UsDQIYzR6ZVKFk4uQ=;
        b=HuXLbHSDzFCU1yvpJdkuPXI6U2M+Pnh1Y6Wa4kWOkrYCTdtH/Tep+6q7hgjDhJRjQE
         i+2DLV8PuE/deM7jc/j6BOxiK8ytEmccIfcoxXYsHEZWu1tWnkzghISRy706h/mS9+S4
         DblQU6A9wgU55T4lNEhWslhn7Um9NbpcOYHkI+TPciBYft/x06ZK6AR/r6F4SESB6GmI
         JgirKXoyzvd8no2sI9SHMGRMCiJa8+6itytmwt8pzlWOPsWYAPeXiauvOxWQu6Oj1Bgg
         gqU1RS9MegnV49F4iKd2ulYIv6hXj0A/zl3x9/gJXsAf6IujRRQToaNY2YdCdvBef7m4
         AFgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751272490; x=1751877290;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8dTsCJP5t130VRtxUhId39omk2UsDQIYzR6ZVKFk4uQ=;
        b=e14OaYK5JQ4ehFJo2vq/cl6F6RVxrwaubbmP5t2OgsdzKiaK0t7t9EuERKLImSBJiL
         qslbI/Dv6fEqHXOL3W7eMHkzzT6yfXR33NWwqIzN5WSJ5NkqclDNd8Oh9GCtpOXcVLhX
         I0VrxE0e67CxBejypLGyppJcST5nndJBaVvyI8cI079AaO9D+u7lvT0R33RTkHciuOxL
         4kqLy3BB9O+657uTZyuVkehDLPllgmtk48aLgYYoTq+iWeiJsRsl3gFmNs0SkDR6SXE0
         GoXn1+A/UOsp6+8biIl72IAqCU72UmtXDrrrm/R+LI0hpnlOA6Sf1UKs1QkNe38rdz1+
         n7Jw==
X-Forwarded-Encrypted: i=1; AJvYcCW7SHHVYrh0gQSqkOboEWLlN7V1ff/ip3WnV65U7RXIZmeR1iH8y85HoUE8/uLqFcjuRoo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCqcdQikoGxaPHqf8cEee4eyscplHT9sYAqJ8ZXKfGeZBNvYgA
	WqfwvcSBDHOUcXZGUUT7KxKltMthjt063cmQo7pNjzPM19C04/5eRyoO+1iv3MB/1c3sbCAt5Vr
	LN3MEMNPpK0Wjjf2tW8e69eI6IuxeoEg=
X-Gm-Gg: ASbGncsbgbEbh663ri8ZAoaX6+MRDmW97q69GBABteX3DCA/1cr0xb4jbPnGJG2nwYH
	yL3aHe06khVppg7m1cYHqMx7n+3AlZkdI5Bfd1PIpIdR5HaO4nuiTu/vlatGfc9qNCoamyEaJ8I
	MnEZicRuLvpS9E8ns6xLqXtzid2iH2ccreM1+D7A000BdHsD53j/4oa84rfvy5jgRd6RZ2g4ER9
	bHmlw==
X-Google-Smtp-Source: AGHT+IHOS9FpRPAlhLlm0ZSHuIPXR2UFNFKhJGIPFdnfwAoaUVz7C+Ekf+miQ8VcuHDmy4EH+KUB4zk/LhL1HYSn7Gc=
X-Received: by 2002:a05:6102:26d3:b0:4e9:ad6a:cd06 with SMTP id
 ada2fe7eead31-4ee4f76a936mr6582977137.13.1751272489734; Mon, 30 Jun 2025
 01:34:49 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 30 Jun 2025 01:34:48 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <xmqqtt418dnw.fsf@gitster.g>
References: <20250625-525-make-clang-format-more-robust-v1-0-67a49ecc2fd5@gmail.com>
 <20250625-525-make-clang-format-more-robust-v1-4-67a49ecc2fd5@gmail.com>
 <iutm4xxkhchcpfygtqo2s4nit42sclzen63465ljtovzgdsebr@okpj5jtw62r6>
 <CAOLa=ZSJH-Wji+-oU+ku5aojYzEuC96tUu+24UTuTxCxt9LYNQ@mail.gmail.com> <xmqqtt418dnw.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 30 Jun 2025 01:34:48 -0700
X-Gm-Features: Ac12FXyNP3dCjVASLXVkBIP0adL6Rrhcsn1Rkw--35vQmGxWftqYEPJ8xqRQXp4
Message-ID: <CAOLa=ZQD71Z4GSRNCuV=YL1zwGOXa-sGzpU9=8yfVcg6vJA6SQ@mail.gmail.com>
Subject: Re: [PATCH 4/4] meson: add rule to run 'git clang-format'
To: Junio C Hamano <gitster@pobox.com>
Cc: Justin Tobler <jltobler@gmail.com>, git@vger.kernel.org, 
	Christian Couder <chriscool@tuxfamily.org>
Content-Type: multipart/mixed; boundary="000000000000a7fae70638c5e6e7"

--000000000000a7fae70638c5e6e7
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> Karthik Nayak <karthik.188@gmail.com> writes:
>
>>>> diff --git a/meson.build b/meson.build
>>>> index 7fea4a34d6..578db26df2 100644
>>>> --- a/meson.build
>>>> +++ b/meson.build
>>>> @@ -2144,6 +2144,18 @@ if headers_to_check.length() != 0 and compiler.get_argument_syntax() == 'gcc'
>>>>    alias_target('check-headers', hdr_check)
>>>>  endif
>>>>
>>>> +clang_format = find_program('clang-format', required: false)
>>>
>>> Should we be checking for `git-clang-format` instead?
>>>
>>
>> Yeah. While `git-clang-format` is packaged with `clang-format`, it does
>> make more sense to check for the former.
>
> Just for my education, what does find_program() look for?  Installed
> packages, or a program on your $PATH?  I am guessing that the answer
> is the latter, in which case it is not like "it makes more sense to
> check for git-clang-format"---rather it is "it would not work at all
> if we looked for clang-format", no?
>
> Thanks.

Good question. To quote from the documentation [1]:

  find_program()

  program_name here is a string that can be an executable or script to
  be searched for in PATH or other places inside the project.

So, 'git-clang-format' would work. I've also verified the same on my
end.

[1]: https://mesonbuild.com/Reference-manual_functions.html#find_program

--000000000000a7fae70638c5e6e7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 3f2a364450e03726_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1oaVRDWVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMFJjQy9zSHA0VEdSUElLYVBIUlJBL25Mc1JjYUwragpIa3R2a1lYK3dm
Yk15b251VWM5NG9qRkJncVVDK3B6Mm4wRU9YWjFNbGdCMnFmanVwaHFsdjNxdDBFTFBVeFVqCnox
c2xKUmZaN3pLbzJPclQ5azJ3TCsxOU80R3l2NTlNeERRbjlDZTI4SzFhYlkwcENSTTBhbURmeDQx
OGF6K2UKa1d3NUVvNndpSUN6VHRGOTh4MjlUZWpJaENpam40VEcxdUZTZUVESmptQk1HOG1qbFBm
UDJ1ZGV4aUhEUGhzZgpDcWZaMldqWXM1VmdZQTBRaThBUUJKMDNtNDdwdTk5RlRhc0FQWVRKa0Jv
TmJvVk55VlFSV0ljYXprL0ZZNFBpCkVFdE54MWVNdUZveHhsUmpYVitpMmgyalFjTXpvc2tEeDJY
TDZONGFPS3dnMjZmWWh1OHFVSG14eDU3eDZHcngKK3VWK21HZHRvQllxVDIrU2ZodFZWbDRrL0g1
TVhTV0NHVUVGRzZBVEc3cEF0Tmw3VjN0elE3dTE4SjNBekRTZgpxODVMNHNOd1IvTVFDeSszcVA5
bXFEcHR4K1VmUkU1Z3VYNkN4VENHc3g3ZWdCTTl2Y3V4dnhUa1lock52QWdmCmN6a2Q0ZHNpSXlH
S3BpZW0ySGdDVUsweXJKcWVGK1J5cllvSWdpbz0KPVVFUTgKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000a7fae70638c5e6e7--
