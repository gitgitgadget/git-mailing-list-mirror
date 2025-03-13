Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62E4D1EE028
	for <git@vger.kernel.org>; Thu, 13 Mar 2025 11:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741864108; cv=none; b=bq82LkN6PuEUCroERfrGF796u/akCkAQf8EoRvuqy7dykX1VJ/fEjRN2sONtB5BUkKl3O33RFT9B/Ryvw5coT1qi7Ypxau1RPKCcEd3TH5IVXdnNwkf3ZMvLGWN+XZz33xZrRnc2BKSQ1KgrWkz/Qtm83xWIjZtGeMDgqk5G4Yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741864108; c=relaxed/simple;
	bh=R+cmpYkRedFw1bg0KdiBWeYdNx4yihOa+FAWA4+A2KQ=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EhOhoEJxAvde02zFjJzokMlDXOrtz+SSx99rrZjV45SriOqI6nRoCaQFSsV45qOx55FZJ2gU55OcaFuz4cZAQdnSAcixYp6Ga1/BoGDATBMaHwjkWq6nfCcjuQSrTBhXXaG3thJkGLywNPe5OeONatF5rvueCxDaDlsj9zhOSmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V7qQ/Rbx; arc=none smtp.client-ip=209.85.222.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V7qQ/Rbx"
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-86b9d1f729eso355790241.3
        for <git@vger.kernel.org>; Thu, 13 Mar 2025 04:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741864106; x=1742468906; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=kDfrkdwH4S6XQ/meHptiCvoLcW6dpobEsSjzToPDdx4=;
        b=V7qQ/RbxnRVb2fpWPcB7Qj+QmFh4OZwYe0K7ngnqVHYp9y6yVtVx5WuK4figEG4gJU
         3LVxICDpucih2pgnK3+XPi5Df67C68baHJnCMBKlv9+c5/87Ai4qoeV/PPZdHHBmQ1ZG
         RCJItjNV89agFXsmSnLMipAdv98QLruu7IP+nXrMxGG97mxrvKoNfqujeTpQ+mmF6Iza
         2SWtdeWagkba+VhkPg40MKqzghr0FNYhljxCiEIfnzgmAC/rOTDpxp13fNUDxDe3liuJ
         H0+8hZGMhFUBlI125Izs7DgFw6xuVxf6KluHn3SYnVZBU5jXcXsq1GuFsr/LDng9EOkM
         3S5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741864106; x=1742468906;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kDfrkdwH4S6XQ/meHptiCvoLcW6dpobEsSjzToPDdx4=;
        b=U900VBipguSNP2uumH1f8+JCKbIReuxwuGSzppTLl1fHfJX7pfeajlQF9KaEyG47t9
         VGXkWaqs/T5FV6V4m2vi46SKeJhA/+BcAJvX8KUxWb41P0Cs3r9cuESJlIVHM0yFAe3q
         cZTAKGU0uOlHcgjfnAMngUmMPBUyNAXRHL6M27gG0e+sZgiuUdFr2BKnqTaoxD2GveZ3
         j9q5knh8556AXmR3kzH5/9r+RZpYsgXFUgQ0wnDG8RDA3gXOB8e5XmuWIsCgKr3VPXFW
         8zUCl385lknXdaf915J9eDTVXp07YlouMlzUk7ZTHCC7jlQ/BAuNwTvCTfxaItWTXV1v
         qWUA==
X-Forwarded-Encrypted: i=1; AJvYcCVQky4YQXdYkx0k1/T77vHdENxCFQIKZpa0gfvSPqaWkIcdqMDIi/k/AX4Larbg2Jwitbo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1Hf1HOxygsqd+KGquqvaj0XwxEZLTDjslTke7U8KER0u3YpFq
	XnkEzwRD1vpdeqYHbMTDuRWEXgkw40aBFvFupYxEuUAdCcXUU6jKdvPrM0We/MvhFUEE6lz2GGE
	vli4Ih5xu5jEdMk6DeJKg8b+JQnE=
X-Gm-Gg: ASbGncttXi7HXVnzubXeDscSGh62Gij1A6pVVTwxXL8ZdRwsbA09FVwI/mpfGuAUdaR
	zlqPL45kidfxMy93+cHu6qh/ZWUGOl4r9jtRLtklH9iGwssnc4TbVdS/bu74fc6ZadBngRiUHd9
	8HOB/wltEmV7O4PULUNQKUuawbbO8=
X-Google-Smtp-Source: AGHT+IG0q9aLHiXgpp3ZIDKLc8IX9qH/9WHfWqMHQXG44POVTa4TQUTeDFYJc+t14tsjqHXaH4Ch0bdYB2OIVqbsEqc=
X-Received: by 2002:a05:6102:2927:b0:4c3:577:a8e7 with SMTP id
 ada2fe7eead31-4c30a6816aemr18515157137.16.1741864106211; Thu, 13 Mar 2025
 04:08:26 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 13 Mar 2025 04:08:25 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20250312-b4-pks-meson-breaking-changes-v1-0-b89e9a59d228@pks.im>
References: <20250312-b4-pks-meson-breaking-changes-v1-0-b89e9a59d228@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 13 Mar 2025 04:08:25 -0700
X-Gm-Features: AQ5f1JrNYiqv2qRMKboIXYgZQSFBIhXZtHOqPQ_Fb1B9rDBHU1gBrZAXMk3Whi8
Message-ID: <CAOLa=ZR6Y1rE7BmJ-gUov_b9DNPs1q7ZDz0v0uUShkN6vVtDjw@mail.gmail.com>
Subject: Re: [PATCH 0/3] meson: improve handling of `-Dbreaking_changes=true`
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Phillip Wood <phillip.wood123@gmail.com>, Junio C Hamano <gitster@pobox.com>
Content-Type: multipart/mixed; boundary="0000000000004c784f0630375768"

--0000000000004c784f0630375768
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> Hi,
>
> this small patch series improves handling of the breaking changes option
> with the Meson build system as discussed in the thread starting at [1].
>
> Thanks!
>
> Patrick
>
> [1]: <56cf842a-7c1f-4354-b191-35bcc1e139bd@gmail.com>
>

Thanks for picking this up. I think the series looks good, and is inline
with the discussion we had earlier.

> ---
> Patrick Steinhardt (3):
>       meson: define WITH_BREAKING_CHANGES when enabling breaking changes
>       meson: don't compile git-pack-redundant(1) with breaking changes
>       meson: don't install git-pack-redundant(1) docs with breaking changes
>
>  Documentation/Makefile    |  2 +-
>  Documentation/meson.build | 13 +++++++++++--
>  meson.build               | 18 +++++++++++-------
>  3 files changed, 23 insertions(+), 10 deletions(-)
>
>
> ---
> base-commit: 87a0bdbf0f72b7561f3cd50636eee33dcb7dbcc3
> change-id: 20250312-b4-pks-meson-breaking-changes-819afcca2e07

--0000000000004c784f0630375768
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 6622e0b953e10569_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1mU3ZLY1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMGpCREFDUWhxMnZkSmI3YTZxN1pDbkRCM1Q3NEJxNAprMHl6K1pJellC
QUE3M3V5UmhQczJjbG8yZ0M4VHZ0Q0h3cHRwM3RRR1o1STZVcEllOC9uU0lwbVdIN3IzbFZxClgv
Ri9hTmtuUW44cGdab3NadWdJbTV4TUFJd3dTQlpTeHhPM1prWUN5SVR5SFFnbFEwVUxhb2pjMFNX
MkRYLysKaHN6NGY4WTY0dzgvQ1FselMxSkN5S2dLVll5VEJwOUM1MS9lS1dzVFd2QU41M2RPMmdH
NmQ2YXFtK3lVcEREZApMSjZLNnJVRXQ2UEl0VUdUZ0kwU25vcTFYeGtXT25qaWJ3cEwyOXdBem4y
TVRNZTlwMXJ5eDNIbG1pb1Nid0dhCkxQRTFHMGp5UGZzSGVUQjN0ZDdVZE5PdUpYdjBBeGpHaEt2
Uyt1RFlKSyt3UEJ0YUJGbERYWmphM3BOOU84RVMKcThqVElxVVREazhJSUtNVVltNVpCTmdKcUZr
ZFBwdWpMUTcxWTc4dUVRODdVSVFuS3owSmkraG80cDlJaTRjcgpPQWlKZDFUSG1sdEdDYVphWi90
Zmt3Y2JRdjNoQUNqVldUQWlmYTd3VjArSXpEeGtOM01uTWp0TmpBN1Z4WllZClI2a2ovQlB0U05O
WGQrZGZDVVFqNXNGWGNmNU4zc0I2SWRKNDdXVT0KPW5Pd2IKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000004c784f0630375768--
