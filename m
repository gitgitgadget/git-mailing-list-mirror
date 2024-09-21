Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com [209.85.222.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99B821EB29
	for <git@vger.kernel.org>; Sat, 21 Sep 2024 16:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726935635; cv=none; b=meohmMbL6VBz+E1MsXErE/5qkWzuMwjpVcldZp5D3w/2tohN+F+mjA2hQD0WG5Lfp1AQ4FQsvg8n3taJTp40kKQ5X+REACEQuz+qFDFyhcU351ezjv+nJJDtt1ElVwyJrw62zIE8DxJ0Qm9uFCZR/PpYK4a2MqPT6cwX5ZnSZe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726935635; c=relaxed/simple;
	bh=Cmx4SwzDUoVDBL3tckWmM0gWGfir42nnjiWia/pD0iI=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Content-Type; b=VMmRumEVH52ddLXxFoagvhQ7NJ4SuQsb1bQHyGYPJNMaradzYKph6lC7JzTdtaxlclcy2VhlMygdsiU9G9rDI5/ya0YkAi76EaGWJfSsKM6QqrKIfpnvWwJ7/wYRxKFfX+p7zT1Mwz7Yj39oVsJIhY0TTF+xRkaxf1VY1zh0Kqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nQlUGdjR; arc=none smtp.client-ip=209.85.222.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nQlUGdjR"
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-846bec788f0so797577241.1
        for <git@vger.kernel.org>; Sat, 21 Sep 2024 09:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726935631; x=1727540431; darn=vger.kernel.org;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=D0ilz7Xh6PywqdUqoEYf3hmh8Vq2yD5BJlncafTxkuA=;
        b=nQlUGdjRcEJto75YYFxH7w/ylK5XseQIeNrQQFQdI+gw/xjQubnftwu+/O2vOHMEYw
         IBdJ3iGSH7n6arT1EKwbY9hE5i+st2/jLG/d1kZ/OQVeHAyiw+n41TMUplz9kWGFJ0te
         iUvseBhDv5iLJbfRLUGHEfzAkzHQp5tS3Dz9Y91RWPRcPRrbPC/IIDgwdVF+bnvpm+BN
         KEcGkYs6xpXu7OjylF3ElavgEOJjl9+FoAXuYTpRdEocyzT7JuPaJI0VlJxpw8zl2u4/
         nO9ktfhUtY5SKaaerSNAj3AAyQ0zGZtJioIRMLl42Nt0LnFLxwC19dN/vMJirP29Y6th
         /L9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726935631; x=1727540431;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D0ilz7Xh6PywqdUqoEYf3hmh8Vq2yD5BJlncafTxkuA=;
        b=o+PfRswTjgOjGz7aCVnMReKB73oN6Ujb/od7ABrevLr+c5SonPiuJRPHQct7XYooMf
         PlR9uIkjHVKugda+QD9Kf1GcVJZFBBwD8AYwFwE/jzWs9GgO5wRFuKZJkJBCnJ6vpadJ
         fCCDqVgtGWVf5GGjMDzBHEvboryRZHtYgjdRWa8PCJcOWyjSDYjSvtg5/2DN5QrILI45
         Em4mwGpMjD8lz5EPVZk6jxsSR9RiaTwK0ZjhkIGEv4YZc9PZ+avuwRmz4MGIVA0DmJ4e
         TFr4ukMj594Xc/G+yK/5Xn3HfQmrfe9Lk9vpOciS4anhZdS+tWdYW4TTClFp8k8yJDrv
         m3Ww==
X-Forwarded-Encrypted: i=1; AJvYcCWN3+TLeK0m/QkvHIVm9FGMOFWKAFsX9JO8V+yWLG6EsJEnQGrjt7nqG1WsRK6e91be0mg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHtvyZ863bCeqU05AoD0VoiYwxACP5D+zLDWyh6mHXWBYsL4pN
	Wre7fk8IbzER8mwW+NlampConx8J3vhROBFpcHALTK+JeEFV+YE7wEBmhoI1gwzQmbHXiNimv0M
	HUYNKUp0klGk6HN2ECLn7XJl+0tpIFdEY
X-Google-Smtp-Source: AGHT+IHoyO+712nXtEsS2lJEBR1JeefTfdrbyGaw7z8QsLbt8sClYY1XuZLqmQ6aAKaLhKxrJRfQ9UC6H3BmcSE8mB8=
X-Received: by 2002:a05:6102:cc7:b0:494:3a8d:c793 with SMTP id
 ada2fe7eead31-49fc767d8c7mr4446142137.28.1726935631394; Sat, 21 Sep 2024
 09:20:31 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 21 Sep 2024 09:20:29 -0700
From: karthik nayak <karthik.188@gmail.com>
In-Reply-To: <CAFRk5Gwt7uzi0ErXrbvVfRAtSbEV615bPzaPnxheFB3=0DJWKw@mail.gmail.com>
References: <CAFRk5Gwt7uzi0ErXrbvVfRAtSbEV615bPzaPnxheFB3=0DJWKw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sat, 21 Sep 2024 09:20:29 -0700
Message-ID: <CAOLa=ZSMFaAiKe5wVck+jikcfLgqjKgvu8qGTi=6kT8-n2BhJg@mail.gmail.com>
Subject: Re: Request for Guidance on Getting Started with Git Contributions
To: Khushi Bansal <iamkb2808@gmail.com>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000dc22db0622a38857"

--000000000000dc22db0622a38857
Content-Type: text/plain; charset="UTF-8"

Khushi Bansal <iamkb2808@gmail.com> writes:

Hello,

> Dear Git Community,
>
> I am writing to express my strong interest in contributing to the Git
> project. I am particularly passionate about command-line tools, and
> Git has always been a technology I admire. I would love to make
> meaningful contributions to the project and learn from the incredible
> community that has built and maintained Git over the years.
>
> As someone relatively new to open-source contributions, I would
> greatly appreciate any guidance on how to get started. Specifically, I
> am looking for advice on the following:
>
> 1. Best practices for setting up a local development environment for Git.
> 2. How to find beginner-friendly issues or areas where new
> contributors can make an impact.
> 3. Resources or documentation that could help me better understand the codebase.

Thanks for taking interest in the project :)

If you haven't already, I would recommend reading the following
documentation:
- Documentation/MyFirstContribution.txt
- Documentation/CodingGuidelines
- Documentation/SubmittingPatches
- Documentation/ReviewingGuidelines.txt

For new issues to work on:
- There are usually microprojects [1] that we recommend for newcomers when
applying to Google Summer of Code. But some of these might no longer be
valid.
- Sometimes improvements to be made  are marked with '#leftoverbits'
[2], you'll have to dig around a bit.

>
> I am very excited about the opportunity to contribute and hope to make
> a meaningful impact by improving and supporting Git in any way I can.
> Any assistance or direction you can provide would be invaluable.
>
> Thank you for your time, and I look forward to hearing from you.
>
> Regards,
> Khushi Bansal

Wish you the best, feel free to reach out to the list, if you have any
questions or need advice.

[1]: https://git.github.io/SoC-2024-Microprojects/
[2]: https://lore.kernel.org/git/?q=%23leftoverbits

Karthik

--000000000000dc22db0622a38857
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: d425ec6a1f8d01a1_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ0FBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1idThra1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mL1FiQy8wZTYrRlBPK1dlVDZpNzdhWXE4R1M1Y3NyYQpuNTA2blNCaHhy
NHpEZEtFTlJGYW5LMFJtdE5wamFLam5wZWxYWi90LzlsQldqZUxhdjIwaXQxSTIyUnBXUVg3CkF4
SStmWTdHdTJSdmhhYzF0WFZSWFphazg0Y3RRTStXZnd5dDRFb2VNYlFoN2NVOGdwalhBTktJM2ww
UTM4SjAKZWhwYzRUNTRheGZlY1ZmaG14YXN5YkNxcyt3QjR6a0orbzdBMkNRMEpCaTF1NE05YVE3
bVZMemtFSWpyaGVrNQpnT0N0azdBc0RMei9KbWVHMEU5T1JmMXUraXhxMmxGRVNtNGJocjFoSWp2
QmJuTS81elMzNzU0NUJ0VTFLT3E4ClZreW5KbkY0UXZtb3owOW4wL2cwVVZJRzlkWXFEbGpzQWdl
MmJwanEzWFV2RFV4N2dyLy9sRnZPcjJRV1VIV1UKamZkNzY5REM5RmpiV01reEtHaU5qMXBFU3RU
azM1cUdxNlp2K29udW9KSXhodkI4aGpWM0tXd3hhaXk1clJxeApHMVZqQ0daL3FVS2k2TzJ2THJp
YWZWVmZXQnJESzVtM2psbkpJOG5VMmR6QkNxZE01dDYweFUrWDJhQkF1TkRmCnpZTWRBcWJ1M3hU
M1lzR045YlJBTERNZ3Q2SnBkNHgzWTF0UjdFND0KPUZHbmYKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000dc22db0622a38857--
