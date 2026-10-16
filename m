Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C3A83BE17E
	for <git@vger.kernel.org>; Fri, 16 Oct 2026 09:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792142319; cv=pass; b=LUmCw94S22aMU2Ef3cqwj1bXiCX4XJ+U63xvxQbL2iyN3v/Ct/XF/khySZK7bSqC/IQ8Y4o+dSSmcXczu0Q+GN/XAcDRgVWvy/ZCpHALggYehd054CwlPIeX4Js9NiaA5/MDvpYwtSTXLGUz/F0Um8+VIL26q+wadX3K2laelqk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792142319; c=relaxed/simple;
	bh=8d6yY0zombhpdW5xhE6AEVn/0fMu5YKNuHqg0uVxSmE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N9WHz3FWwevaoq4iV7CgxcGIxdCHMJNXH9zJKD8sm5UmoUHKYJBR8QTChG/mAqEkANUoqaUJCFWn9jMWvN3ymxEYRWknO1XSHUj9/BeY1Z41wFt5boXwcnj91Gmt7PPHGAg/eKmtIQl8FRwoNnELybGgWtZNtq2gWVkeg5gc9nE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oFjHQRHJ; arc=pass smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oFjHQRHJ"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6b167ffd132so10069498a12.1
        for <git@vger.kernel.org>; Fri, 16 Oct 2026 02:18:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792142317; cv=none;
        d=google.com; s=arc-20260327;
        b=ejcSEanzF0bXjdl2M430CMpJVRx+PyJmEFSnQ1+h//Lr8+NU1Q0rjEfjX29/IOfoGM
         1sZXFE3unVqf7swRNIfXTX7TP/w/rLU4As85S2pUmjDoCmlmflg7/x/1zmJiYw4W6kgw
         rAKI3WSyr+MuydnmblWN8SkQvfpooCX4tE1HARDx0vUDv8eca4R8T6XDboMoDFDFdEMw
         1iGUMbQW7oS2A0I1KR6PyL4wd3oWpxkvB5Uow3H523IPRaks1x1C9Y33Dyf5er7Bn5/p
         JizCvLOvibYqKwStWDFBf/kDHm4T1St6wqeW8DmbR6WxrLqecA3o6Ub2gLpfIvr0H1TO
         4D0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=f4ENMpy8qWxaveD24VNd83NaVXTkMSCJ2wXjKu1Nlek=;
        fh=GV+q3+xoptdzTjdo/fAURyeoLF5hkow4oLuqL90b9Bg=;
        b=k0W7R3aSFCuSCYaEVJutrmcs9mIa5jxpIWVUMRfq7UNpSfpqKeY9QN48xoD9Q3ClHZ
         pYubHyBf4vi4gl4xeYSlrh4rVoJfGJ/3NYDGsjoEeBRPT0HxRY5v/uvbZsQMr709LVam
         cphT079on5lml21IIl97fLmwuZFZxx9ZKy5cnmHkF62WSva2gyn++R9pgazuc/ZG132B
         lB+mUyUyakR8UkI+9kawyJMx1LzfPvJJwJ/0cb4+MFxy3rRATxF+f9+HvjbPrDAC+kOW
         xMEcRHXUTzzLaT/I48VSFozBavwrssOlzIg0Z39uvKmZKbfsrEA+2vo+EipehNVW8hIC
         o9Bw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792142317; x=1792747117; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=f4ENMpy8qWxaveD24VNd83NaVXTkMSCJ2wXjKu1Nlek=;
        b=oFjHQRHJEUH5CcgXkPQpzIXfJVH7li0wz7kYBCGibuTv/uil7Rv1ENihwzc4fbPBL9
         IrfLrAx3SOecQXGGBjW9Jyw8u7J840AQ5IrN/geDZRsxkLC9n7KGmt0NxK++LSp5TcAb
         AZ2PwKT3AOBkxQldTKtO6KBGkjDZWBOUggC4TrPVxAN2pj4+urE+DHwcCXJLWf4VuQG1
         iIZJkweCyjG9yoes4d4jB2cKqWd8/xvxIFmtfTGPuKR6sjisjIsujH3tBGAR5bXnmDOM
         5uI16RS3dkpIhz0GwvqvfLSPRaoAlyL/zJ+lWWTh+hrQbbIxD4gwD9kflEE7KQCSZr9g
         I3rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792142317; x=1792747117;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=f4ENMpy8qWxaveD24VNd83NaVXTkMSCJ2wXjKu1Nlek=;
        b=NygW5VpXG0rxGrZ44OLh8J6gr6DFYwAipmUqY0fhNttRsame1tjiCZU1D7jDy/aGlv
         WIN7GSAd8xJWTdyc2B2fv/do3+xvOJYs/ax5PkrUASbhgpet5tC9zrmTnImAI6XLSdbm
         vczCsEQ9EF0Y3t7lYTZmMyrzdJld0w7aknzV1ESjIyl1GQK67898tfLgqkgl08bsvS3Q
         0EzWImqX/tlo9yQ561U8TlsXfDGuGxeRPq5apqFeZ+P82PxrevXBY3st+PrNEcWQPFY6
         c2K5AcjUJgZ7xJNt5u4KjB1ARODvtFXIPtFyt2EtC+EeECHx+yyHrYyij4h+5XB9TL3x
         chZQ==
X-Gm-Message-State: AFq9FYIwkz6csZeKJoOH+iGL2iN2YQMZIF0f/ZFDbLCDcraC6mEow19x
	oAaDORx1DtixKj2HBG3p7rAuGbn68iyHahioa3jWneuHfjCYGcXaYTMNtYylZxxdIUlbwtdcNR3
	2sKzpGNSlc2AS9bKsoGIOM1KAiFuEY/4=
X-Gm-Gg: AYBFou0FEBCS8NQPD0kXEoalkwT4osWNmvzz/+igswlCIF1E1ALiHFobWkD2TTkQKv+
	LO0tv7kIra7ubUQvDHYtiBNohjtg2me1jjc+uHq7zQ3PR2+ByRQetQ/F+0jNVgREq9Vz3vEoE2S
	rgy1qend4YwzW6veiwjeSEvdyClasERy0oI7DjjG6QQooGdrsZrfT6qgouwPTNBrBhz0vyGA3Fn
	Xw2MiB0BdGQGDM7BeV4tTKdiJgxfydtLfv5kPhpQJ4B6E2bdiF8zT9UnIvUjJuNq0Y0oNglXRAm
	ueFStUPt+cvh1fYVl6Kc0gB887/Ovvz6fxDBtBvstne3GWB9GW+p3aSZMJp1XxjfU22biotuLR2
	ta9lVapRaeyQWY2aYNYRG4CK9
X-Received: by 2002:a17:907:9801:b0:c2d:be57:f73a with SMTP id
 a640c23a62f3a-c31a9fcedffmr2157906466b.13.1792142316723; Fri, 16 Oct 2026
 02:18:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2256.git.1791978767497.gitgitgadget@gmail.com> <pull.2256.v2.git.1792135548923.gitgitgadget@gmail.com>
In-Reply-To: <pull.2256.v2.git.1792135548923.gitgitgadget@gmail.com>
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
Date: Fri, 16 Oct 2026 10:18:24 +0100
X-Gm-Features: AclHuK8S-8TwpAVcepmCI39ri7Wb_M_9AbBq3dDhFoUBlWuQqhl1Y44RYwwVgPQ
Message-ID: <CAPSxiM9rW9mLdUVjMF9dVYNAPj+FFRShqFrbikqXmbPxd+RSxQ@mail.gmail.com>
Subject: Re: [PATCH v2] [Outreachy PATCH] t2030: modernize test path checks
To: Srujith A Poojary via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Srujith A Poojary <poojarysrujith@gmail.com>
Content-Type: text/plain; charset="UTF-8"

>
> test_path_is_missing for clearer failure diagnostics in test output.
>
> Search with: git grep "test -[efd]" t/
Please, remove this, it is not needed and kindly go through other
comments on other Outreachy applicant patches.
>
> Signed-off-by: Srujith Poojary <poojarysrujith@gmail.com>
> ---
>     t2030: modernize test path checks

> Range-diff vs v1:
>
>  1:  641b9330c9 ! 1:  93cf6c12f4 t2030: modernize test path checks

I will also advise that whenever you are sending your patches or
sending any query, kindly cc'ed
the mentors for visibility purposes.

Thanks for your interest in the Git project.

Usman
