Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 477E92F1FF2
	for <git@vger.kernel.org>; Wed, 16 Jul 2025 10:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752661799; cv=none; b=rN3fNzMoeRGkMOZEfP8r7u0/BpAMAeKM4JJcGIaQHViF+K+3QYCAMHSN9xnayuWCa8ProrzMyfk27MSHe1hVW1zWybZdOFFzzeWIspi+d0YFZNMSZk1WuU0UjnOEzNtr+HMtVW3etjXjlhyhbAH4goPVxRfHNI/fRYzJVqgYafE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752661799; c=relaxed/simple;
	bh=b8S9ieMvHQwNJfg56DV1nwWMHNpk0dagVPwB+JkVGKY=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qjdLqWh7fmJdf0rWS3pRLhVTmKUTVT7v2qgeq7HxPWgJTg8JTklkRDz6rTcFxLubzeKECNsHvZjY4OqggQEu44wNj7ofgfqQHR2Jln4nGuw224pEn3SfEhZFBw6lefTbIQTGGMvZRNcrBZhiOGG7i6uO8diIUEPXnbmsxqOllqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hXGxczYd; arc=none smtp.client-ip=209.85.222.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hXGxczYd"
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-87f04817bf6so5942135241.0
        for <git@vger.kernel.org>; Wed, 16 Jul 2025 03:29:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752661796; x=1753266596; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=b8S9ieMvHQwNJfg56DV1nwWMHNpk0dagVPwB+JkVGKY=;
        b=hXGxczYdPJiPcyEL/xD5maEHZFtRuJvC58J91oTBp7161SIkRVQ5Lnov/nqO3cdTXu
         X1qsRAHC4DfbHop7cH0+xoFf+R5FVVoIcmlpkT9Rn4rvyGU7NNvUt6XwSqr0BOqT2BEb
         qdXPmzTMuN7KrSu1vYAHknvZOtKF3Hsx7N3qGezvs/TJsIESx0oQroJOuuYa/Xcxv4cb
         QeEdCQe0vKuJyajEGAbeF1rIvlhFlpkxneM/PliPe4rYyAOAEdO0vHCwmrDcKm6uQqAa
         JRlRQLbvCFM1+2gold4EukIWK6+CMjyNqLmUwcBMxeiKUJrad+7ZXSemVa7nO6Qd0lwn
         hrXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752661796; x=1753266596;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b8S9ieMvHQwNJfg56DV1nwWMHNpk0dagVPwB+JkVGKY=;
        b=dEOINszyVAM8Arb8n7Ig5n9R0SK0Q4dwiIPcSbM2AZgad+TfgJkWNpCq7/1yAYwbOQ
         ajXwbqqGPtYiP8+3jN3gHfbhEAQzglB9HCiJlC3JqTh0rHQrvXUEP5v2eLNdCTp7Y31Y
         xIV0RY4lEyGNjpHsYWynjGxZk0spGApXnFdkrJwucbOo9Vh8AM1Uf5BaK8fxiwqvVtgu
         FHO43NbI3SXpFNe6yo58zT9xkpq/A9bANeuAR+Mn9TyatiL5BUzsghF9P/WPAz+hJJvx
         xzAmzu1O1sLz/Bd/4xPrgiD1VLFvdCY78SW6PEKVGiHAE/kmn0BX8mvJe5/rB35lwt/G
         t9nA==
X-Forwarded-Encrypted: i=1; AJvYcCUrkI31mNLhv9QJmHog4m/eoWG9WluqFjwMrCa+oGXKNCMqQdWYrLJ/wrSP++DpW+WQTiE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJqm7Pj+SausJs1pePgoMDGcW3dwjOK96Bem/hNq0krONmLR5g
	ordNGRp2PlT77HnSYuQJvl6Xk59P2T+OIKwHmPIHR7PPRYrQ9DcJykD4WUSzjrc8G7MtzOLoThi
	1x8gWTKZ9rEGqywbYmifmI6wHwqKowM0=
X-Gm-Gg: ASbGncvXDsT3mr6IQHvNaJixiSZLaKH9LYvsd1B/z0CvYxu7Gjcq+2WAwmc1IfJpdiL
	4LPNmW1tV1JvUrJjz3Vvhu30SCTvlkiQMYI6hcvef1MQ6DrYMe71UIZT7lW7W17FwzK1iQIXUcK
	uxjfugIBHEccwKiNbt2DHx2Oxl0Gy23diBH4LZBEqyRRD73LoE5XiUheulDO00lYS5HxzbafJpx
	H3UbgI=
X-Google-Smtp-Source: AGHT+IH4cXBOWnzW9YILFjEaS4nuHHwlH/EShhdOGWoZuHPpllWfPOCLzLjOCaupJ0kKVgQ8RmXEvpo6TIsZv9MUX24=
X-Received: by 2002:a05:6102:8029:b0:4f3:1731:8c01 with SMTP id
 ada2fe7eead31-4f899960543mr1355143137.19.1752661796113; Wed, 16 Jul 2025
 03:29:56 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 16 Jul 2025 03:29:55 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 16 Jul 2025 03:29:55 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <cover.1752658700.git.phillip.wood@dunelm.org.uk>
References: <cover.1752499610.git.phillip.wood@dunelm.org.uk> <cover.1752658700.git.phillip.wood@dunelm.org.uk>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 16 Jul 2025 03:29:55 -0700
X-Gm-Features: Ac12FXwGZPugOdeT4DA4qeAL7GrcDxn3x3nTRuQ6_X9BTeRqaiDhSTRsUyW6H-g
Message-ID: <CAOLa=ZSk5O0sQRN5Yf+i6Jh2Dk_pafQhLYNY5eBp_S5y-HoC3w@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] C99: declare bool experiment a success
To: Phillip Wood <phillip.wood@dunelm.org.uk>, git@vger.kernel.org
Cc: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>, 
	"Brian M . Carlson" <sandals@crustytoothpaste.net>, Elijah Newren <newren@gmail.com>, 
	Eric Sunshine <sunshine@sunshineco.com>, Jeff King <peff@peff.net>
Content-Type: multipart/mixed; boundary="000000000000c4efa0063a095f01"

--000000000000c4efa0063a095f01
Content-Type: text/plain; charset="UTF-8"

Phillip Wood <phillip.wood123@gmail.com> writes:

> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> We've had a test balloon for C99's bool type since 8277dbe987
> (git-compat-util: convert skip_{prefix,suffix}{,_mem} to bool,
> 2023-12-16). As it has been over 18 months since this was added and
> there have been no complaints let's declare it a success and convert
> the return type our other string predicates to match.
>

Neat, I didn't even know we were running such an experiment. Thanks for
getting around to it, I think the patches look great, added some
complaints from 'clang-format', feel free to ignore.

Thanks,
Karthik

[snip]

--000000000000c4efa0063a095f01
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 94c50c7e7da6a312_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1oM2Z5RVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMDh6Qy85TkNsNWY3eDBUUHAyWlZFZTJUcGtHWlJ5VwpnMWpZNUZhVmNM
Ukl4R1R1MC91cFpUSUFSVWhhdVZYNW5mSDZWQjUyUXRkM216SlN6VlpYclFIdmdBN0dha0pYCkw4
MFh2MGw4U3RXMWxnUlU1SlZ2N3kyUG0wSHA5Q0xqUWZidWdicW8xRzIwKzNXQ2tMY1VGdkFhd280
UW84NUkKc0xmT0tkN2hadWtKT256aWE4V1kxalNmcGQvZW9OZlN3dGJaZDJQNFVhMCtJakk2L3dB
WFgwbXIwQjV2VlhMWgpvdTdtdVFzZHlZMm14Yy9mWDhSSVNKQVlheE9nbFlZUU44OG5jS1E3a2dM
ZnhzcWFHdGtZdzNUNDZQKzBiZHZKCmZqaWs2SC9TaFArbC9yQVFBSWV4VXVxc3hIZ1IrWCtWOTFW
blFhZVVqR0szSmxlVStLOWJ0S3YwSUVRaTRDNGkKcnQxV3N4NEYyZzNKdzdJazcxMUxsTGFPNEl1
azdmMHRreDJLL2p2Y0N2NVVrYWJ4dk1lZ0tqUjdNcmo0bXQ1dAozVEpGV0lmZFFLclJvMlFMdUk1
OU4xb2JZODI0Tzgzc2MxMFRVUjRIK2xXWngzVkJxcHpVVWtRMlZKcWlnM2Z0Cm5KWEhSUm1SVitS
aGszbGIzSnF3NVI4QTQ0WGVHVGZzNVlnSXdTUT0KPVd1R1UKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000c4efa0063a095f01--
