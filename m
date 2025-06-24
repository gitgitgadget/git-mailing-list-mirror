Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42E0F13C81B
	for <git@vger.kernel.org>; Tue, 24 Jun 2025 23:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750807769; cv=none; b=TwT9FroZuV8GrB1G4YgC37xF4YySD2XRcn5zIGWuX3jbvvVnwuYKgUAYlCSc4I2n6uVuP7yqGxDL+1gm9G/Rlpy3A3csiTArR/88KUu73GHWsDLmviUf494YZyl8GcV8agPafVsm3Wxd8MVOvyG1J+uuXY7Tb1Qau+lHAbP7T+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750807769; c=relaxed/simple;
	bh=kRrJxHM555yHop4KrrEB0MoInBXC3f+66UXgeDA/1og=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Content-Type; b=q+IUomC9Wx7GwBnS388UNe0HNtMUNyLXPv7TIy89IlAJLjWsd/2tZN287373Hx5Q5Pr8y05MQDifL39HhlTbFugYlyg2upRmNE0DU/S14pvqTNDMNraLtFwElLN2e60t9C7ZynbeXYsEnHJuMhj3kbwro0qUdzz0Azkzsl2S7OY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gbzganON; arc=none smtp.client-ip=209.85.217.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gbzganON"
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-4e7f367ea11so329745137.3
        for <git@vger.kernel.org>; Tue, 24 Jun 2025 16:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750807767; x=1751412567; darn=vger.kernel.org;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=U+7urhYAVma7x9qOPhjVlxx91WL9NHPD/DmYv3j2F5Q=;
        b=gbzganONzl5Kh/vY2SjrY6pNwscKJOXKaGcRkYhuPdBY0jDukH0E6hp29P4yOWIsLn
         UasSC4/sl/PHyth4UiPUpzJvLsZK6Bjdb0jcsRNzGlqtZV1ToBp5KSBeKY5EPAykc/R1
         qD4K9QWGfkXLKGlKSe9jfDaKGVaBEEGFfp9QdVv3s8JaSAZG/OwGLan6brzDfJD7W5yw
         +nQ7ksL0m/v/y9tqutvr9eFhA07/ul0Y0D/ayFKso5nQjBc184K7D/l6vNfKosaOiUUA
         tlwOW4EpnDktAVQssGinWoA0CcmImZNZm9rQubXLuTyM/avYWJuiACk0TRAz2plVXeyR
         Nm9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750807767; x=1751412567;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U+7urhYAVma7x9qOPhjVlxx91WL9NHPD/DmYv3j2F5Q=;
        b=f0IXNK2HMHLRrxob0365k95wqyBV1Neyq50CLj6AC6siq5vyGfcmhw6Dk2O77TSiV4
         fC8oSS9xNmdniUGpW9OJ7/Oh8W+kboOShqinGXfFwp9HLc+wCsxf9KeSN1ihZ6kVmqwt
         IcYYBjK6ce2E8Vdo5HUTcIvsRLiq99sGj/7pm/l3b4GSBITOUl6ryoKDUuTRkymN8Own
         KGFRf0I71vktXM3T6qev92H+r7oOTYAqELxpa2vId65CrCXI/NiuRMxjPT01OgQghPfx
         P8HkKnMQaRDQvtzPDsEzFs0igLHB6bt1o4z0YyqSOLZoMKQ7nk+M9GKZwLcVFBJGfQDD
         5/Rw==
X-Forwarded-Encrypted: i=1; AJvYcCWG2Y5S3fEDjl8F3FkvnJQ/7r42pVdtd9Kg7VcCtxLaneimTa+4afI+Jttv61na231ixKs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXfhviDhciC6K27d4Cp/F92d6uTAAC5LUTZZtgst318gf6G8hI
	AmeBAT9uNNVrEvgRNp2NUxJhLTmCWB/YrwJXaUJvw11nsTDMKXffpgn3n/vPjCVPkgwf2OJ9nxu
	DWqSboalt3PlwSpagB4NwMhwHXPo0+2w=
X-Gm-Gg: ASbGnctz8TH9ZZRcRd9yJjIllKmtnc+qdTLzcF2mcUWvQWmMvSRFr6vR/l64WAkrZ9l
	qM/UKJSSExnAreEhQXlKM0mUSoYmbUxig1d0jz1/E0fGljqu5e+LR6cDjRmLPFJyDZUbrIIYmXc
	Xg6r80pUFtzZwAQHmOjWoSzKUOmXExvRh+B6K2ni3ilqnh/FVhfrDr2em5vYS7t9WgYwA9eP2Xh
	OYc5g==
X-Google-Smtp-Source: AGHT+IEaoeIixznJ/v2i+iwflkNKArExK1SrRjIi6YsbpP+zY0w2NGn4qKJeuIUrxE8PmjeHhr81xmCH1nI+ky6Js5U=
X-Received: by 2002:a05:6102:290d:b0:4ec:c50b:f036 with SMTP id
 ada2fe7eead31-4ecc6a77004mr568629137.7.1750807766937; Tue, 24 Jun 2025
 16:29:26 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 24 Jun 2025 18:29:25 -0500
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <xmqqtt462bye.fsf@gitster.g>
References: <xmqqtt462bye.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 24 Jun 2025 18:29:25 -0500
X-Gm-Features: Ac12FXwzQVivj2f86qJahNP1czUbjr5L2hxAjRKr1n30otkOxthXvJwVAxYkqHo
Message-ID: <CAOLa=ZTXQewoVKLk6DfO79Q9R5keDOeEOWOt9Ejp4O_RQ0Jq8Q@mail.gmail.com>
Subject: Re: What's cooking in git.git (Jun 2025, #08; Mon, 23)
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="0000000000000511e1063859b3d6"

--0000000000000511e1063859b3d6
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> * kn/fetch-push-bulk-ref-update (2025-05-19) 4 commits
>  - receive-pack: use batched reference updates
>  - send-pack: fix memory leak around duplicate refs
>  - fetch: use batched reference updates
>  - refs: add function to translate errors to strings
>  (this branch is used by kn/fetch-push-bulk-ref-update-fixup.)
>
>  "git push" and "git fetch" are taught to update refs in batches to
>  gain performance.
>
>  Tentatively kicked out of 'next' to give its fix-up topic a chance to reboot.
>  source: <20250519-501-update-git-fetch-1-to-use-partial-transactions-v3-0-6cdfd4f769b9@gmail.com>
>
>
> * kn/fetch-push-bulk-ref-update-fixup (2025-06-20) 3 commits
>  - receive-pack: handle reference deletions separately
>  - refs/files: skip updates with errors in batched updates
>  - Merge branch 'kn/fetch-push-bulk-ref-update' into kn/fetch-push-bulk-ref-update-fixup
>  (this branch uses kn/fetch-push-bulk-ref-update.)
>
>  Additional fixes to the base topic.
>
>  Comments?
>  source: <20250620-6769-address-test-failures-in-the-next-branch-caused-by-batched-reference-updates-v5-0-f35ee6b59a82@gmail.com>
>

This was reviewed by Christian and you. The latest version addresses all
the comments, do we need some more eyes here?

--0000000000000511e1063859b3d6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: e2178d73aa5c6cb2_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1oYk5OUVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNjNLQy85dWlOcUZ5SXhkLzY3WjRhbDNVM0NqWm1DdQpDcmMzcjdLL29I
ZlRlZGZIVktZNm55ZnFDVWZyY3c2c1VqTmtUb2djR2wyNUtxeEwvU0xMNHc4YkJjUGdRSzJmCkpL
Skw2NWdRY1FKb1kzRWluQ25jeVdVSTZqZ1V6MFNoR0RBT2ZDVTRIRG93OUpIZmoxaXB2eGM0bHhT
Z25GVmcKMmJRd2V5cGhYWnR2bVM1ajdSa2o5UWM4cWpVRUxrVU1YWDl1UjZQNEhlMVd6MjhKaFRK
ZncyN2ZkRU1SQkVwaApFUkF0bVFvZEE2cjRucUFMOHRWb20yQm5zVXZxSHk4RFZkYzEzSjUzd1V6
MWFacERYSEdYSmYzbnBzZi84emc0CmplbFpJUFV5QUhNTFZNcnU1eW5GbnpYK051NWx4K0NSaEJN
YXlqMEVEMkkrbGJGMVBMUGtxV1RtM1BnWThzMloKMnJseTZ1UCtiU05UNVVuR2NVTitpQmcyUmdz
bnBjTWx2VVIxM3ZSR3dmMVljZ21ETThLUHFMOWFSdnVDZ1NHTgo2RUg3NXJva3czTUl6QVhsZi9T
WW11SFJueEt6RnBwcUF1b2NLS3ExSU8zMGxDK0pxZzMzc0dsZXdqQWF0Y1FFClI2RGN0VUtGL2hm
RnJMbm9CRzFnSGtLbEczQ05yaXdKemtOdVlqbz0KPXZ4L1AKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000000511e1063859b3d6--
