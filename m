Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33C7A1E893
	for <git@vger.kernel.org>; Wed, 10 Apr 2024 11:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712748920; cv=none; b=gQTnqkLhCg+10+OWnni7pjzQlc68qgxNQFqHFprWMlcUb45gG82JFjoSq6WBIc3Qzeee4CtHmlLG9uqrE1NS0xx7xlla0eEtyYaul2HsuVW6JWs6CUjhSkv3IjDACIpExZmiDm2xejJxo6sWaDHo5xUrSuxoQ6cqcUURyb7rgWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712748920; c=relaxed/simple;
	bh=zjQ/K591/HxuHyzgXhdkI0bhxXbzOsuGOPHiaDBAalo=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rmkaUCwkZLW50KFkaZuduftuVuUbIvCo5qvaFpO4Lm2p6RYCLLcGq72HPNtZC6dO+4ahrVN0U4HXW5szZjsIb9s8QQNz+81HI2scmDMwwHi4jUpCzUhDOlht/YztxSVObHHJAYV7ABJ097Io5v+O6IjBLLoNZw8JsTLciQIAROM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ab76vgch; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ab76vgch"
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-22f078f1aecso2122957fac.3
        for <git@vger.kernel.org>; Wed, 10 Apr 2024 04:35:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712748918; x=1713353718; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=oBA2s+jGukcn/27KESGG2qXYn5T3PUCj0OTaHt0X92c=;
        b=ab76vgchscR0w11aZRCtT6G9Uk52fiJDwRMwz0FHaFpuN10F06ueKQY1N7AscgmB7U
         Z9U2D1/MeVRnuRq51YZI5G4SJhxAkWzHUvSx+w2WSLSbfRMg4Lu7xGAa5hIg+65c66BV
         j4nUxDBNx+8tsnCi0Hq3NGAR8JsjWjAvHGpx6TXfXM5VQn0XFJyfJe42QqLfrtLfeq7o
         F3+yRPFTUqs77mOE7+qvT0ywpqwPAxg07uFDl1egIl7w08/bPJfoTCMCAiqC40p9uK/z
         DC24srjSiRdtypKZoJePfoICIqJ2Z1evDr7rQp3ek07eP6dlqAQTBUxm5uScZJL18Cxw
         lCOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712748918; x=1713353718;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oBA2s+jGukcn/27KESGG2qXYn5T3PUCj0OTaHt0X92c=;
        b=p6aP4qRV0livp6q4xBzZWRCBqOcOhJKk86lS19GeAixaSoTacW6Dg3v6D+iKdVGSsQ
         DYvRIVL1Bo5X4B0U6QgJBW9nW0Cxu+7kL7KnHsWsW62O4hEu+QXxYFWMpVTPLK3l6yfl
         Q0ekq9OQ641gHz+5CEDf9Wma6R7t3f0PZgZ1vu0mobyPwyN4AHTmpSqfxzvy4NQuLTsc
         0EEbeDa0Dy+wLYS7wCggMKSugeep0cSCZ5EP/wJ4/mzGX4mL3O8nFdLqMPoJ4X3wer7i
         Pe/T7OIFhgAAUwemH8/KAk1iRuX9z8leu00rrJvWo58+ysRQtpeuNnDNG6rOrq22cdbB
         ufjw==
X-Forwarded-Encrypted: i=1; AJvYcCUpgn8PejmQbH4RlHA9+XCc2Gm4lZ2/NAv4J/1q2Sm6I7zGd3CAuPneJQJCI3ahR4EwAprQdE8M5ApNaMX52HuiGSTX
X-Gm-Message-State: AOJu0YzC6wM1nA2lgWYBEhoZSJZShF4g9d6u3wgcvFuwJ5ihVp68rzgn
	nRewXC14XVuQHOQNbdq1Dx6uWQb8V4OOtfH9wgTs4i1uuaCLMuEGnGIJUw8svttRkj+ArF8yqZP
	9zW3E4KSYruI3VKOzOWnh9bdrgoGhaE48
X-Google-Smtp-Source: AGHT+IH4GuD/b7CfEKGC03OzlkPeSx+IMv7x4FiTYKXgwnPe1koxbXgimqbrbOxQ0vC04Aeu2y5hkoFlW15Ml1tnOQA=
X-Received: by 2002:a05:6870:f115:b0:22e:d64e:d5b9 with SMTP id
 k21-20020a056870f11500b0022ed64ed5b9mr2395255oac.55.1712748918215; Wed, 10
 Apr 2024 04:35:18 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 10 Apr 2024 04:35:17 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <cover.1712578376.git.ps@pks.im>
References: <cover.1711519925.git.ps@pks.im> <cover.1712578376.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 10 Apr 2024 04:35:17 -0700
Message-ID: <CAOLa=ZRxQPnPxM+sZtuL-a5DVJL8Xx+D7t2d4cLoPT-hLaK_UA@mail.gmail.com>
Subject: Re: [PATCH v2 00/10] reftable: optimize table and block iterators
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Han-Wen Nienhuys <hanwenn@gmail.com>, Justin Tobler <jltobler@gmail.com>
Content-Type: multipart/mixed; boundary="000000000000dc30cf0615bc6ea3"

--000000000000dc30cf0615bc6ea3
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> Hi,
>
> this is the second version of my patch series that aims to optimize
> the reftable table and block iterators.
>
> Changes compared to v1:
>
>     - The series now deepends on ps/reftable-binsearch-update at
>       d51d8cc368 (reftable/block: avoid decoding keys when searching
>       restart points, 2024-04-03). This is to resolve a merge conflict
>       with that other series which has landed in "next" already.
>
>     - Rewrote a comment to be single-line to fit into the style of other
>       comments better.
>
>     - A new patch on top that avoids copying block iterators altogether
>       for another speedup.
>

Overall this series looks good to me. Thanks

--000000000000dc30cf0615bc6ea3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: e653ece344cd782f_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1ZV2VYSVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mL0lQQy85QXNVYWxtRCtZYmdsVklnbXYrV1N4QzRxVgp0TVIxS00zSU43
eFBSMkkvMFp0SUpiY2FrUmxPcWlMNzZUYmYzdU8xejR4Q0xmd3BKdy9IS01hL2ZFZmRROUozClB3
YmNNR1FleksvQU9acEpkeVBqSnNjd2VwektMVnZKYzRYZFRjL0tFY2dXZ2FZRHkzYmdzOWxPaFpQ
NDhxaUgKQzdaR3dEcU52NGhuaDcvWFZYZnRTN0pvRjR2QlVpSndjRUdzVlhJbGtKNDhCUjVQazZj
NGRVbXhZcithYnBhNQpNYkVYUFNCVzJqN29ZT3lxa1RqZWg1Wis4aHNJN1plaXZkc0ZZQndoclNI
M3JQM0lHQ01kR3ZVZWpQeWV3MXZnCkxuYVlQeU9MMGVWaThZMjBjcDMwVEx6ZmN1ajBpenk4V1hL
OWRtY1hHaVcyOEhQNC9hRkQ5bE9iV3d0eWFwMWMKT3NadklpczBKT3hEb28yUlpiRFJWUk9pZXJx
Um8rUktubEhJakN0L2xuM0drTWc2eVk4WGxjQ2JwWE5jelluVgpqd3JuYVBHWk1sb1poTFgwcDJL
ZTA2TkNPaXMrK3dGTCs3cWc5ZFlnTjJsblpDaEptZ1NnakVtL0RGZ1ZQYWh3CmE5ZWpDcE9GY1Rm
U2hJUUJMSVlFQjJoRWFSSHZkRnNXc2xqUW9YVT0KPTU1OVkKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000dc30cf0615bc6ea3--
