Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fud-cz.20230601.gappssmtp.com header.i=@fud-cz.20230601.gappssmtp.com header.b="zxtR5Xk+"
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29A21182
	for <git@vger.kernel.org>; Mon, 27 Nov 2023 05:21:26 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-6cb90b33c1dso1174280b3a.0
        for <git@vger.kernel.org>; Mon, 27 Nov 2023 05:21:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fud-cz.20230601.gappssmtp.com; s=20230601; t=1701091285; x=1701696085; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LgUc1WrP7/92eXJe/v/ahbgucnvzE9tZ1mTrxvS4XaY=;
        b=zxtR5Xk+hj238KA/9Lb/RpXw/YPzNah80xgKyEpEFaI6rV9+EiSxYQZIYAzpkQfdYY
         MY14FKw/woXmdY44x3dVyk20JkrJ2LZprWv6SahvSDynik1edMSaMPOQKZRn/lHb2O+R
         IR3Mi5k4ZT26ibusUb5uSaic+NeE6/w8cTiNRqMMl+BxOI7H02mKW+t21/mvCbaQZN20
         jWRdt3BoIdIjcLO1yZxbzT/hOd1ZxwCIymDrcfZrQMb7fN9AmZugiR5Mqf4CC4JX+inb
         TQZHCyKq5b/oJc0XcmEFbDa+FDp7/fpkhQeP6DBn2ntgkaB/H3vuONhe8ilsDUszd0Mw
         ff1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701091285; x=1701696085;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LgUc1WrP7/92eXJe/v/ahbgucnvzE9tZ1mTrxvS4XaY=;
        b=M/RRLY3UpzUalfFEAj5bpIdkpJ5iMJFkirswOhU1RBJYsDGHWQzJWeq+zC4plSLnNu
         KSwcEJjLvtDRccIT0Zrqdw5lAttTJoBWfPX0h9iy/j/TOZmU547OZfRHDVO26R+CriNo
         L04BpKmByaFV143P/QMmutygslWX2nvGvsR7PEC685fw09cpwdhRryIqydq08fJ76Ylt
         JesGRDo3WjN6QjcLKcaIShkSsMlFWtCIZ6Cmi1Ke2W1vMowhawXLFDLD8TFV96zMdPAj
         dPkJXLJDlNMJ0klPBN18Dv9oOXT8DbYUkOfu1SY86IkEnBOA4g1159SCABy3M9p4Q4Xo
         EJ3Q==
X-Gm-Message-State: AOJu0YwrSQ/7KosOl6t4AYXBwBSWiUfC0RKbAyETGveeyyxdiyq8eqve
	L5ZUQNTs1CtWaL6LCmFCTQ94A3g3qzLH0JuHGBRtDQ==
X-Google-Smtp-Source: AGHT+IHm6E1Blwp4BotvfrqqRZvxXCr7fHMABzcSBeQwIolShMNoplIckx7KiFZR6nQQDp3zduyfaN6Klwa4AhRKmaA=
X-Received: by 2002:a17:90b:3643:b0:283:a179:963f with SMTP id
 nh3-20020a17090b364300b00283a179963fmr11689575pjb.2.1701091285669; Mon, 27
 Nov 2023 05:21:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAGE_+C6DJMAO0bj5QHoKBBV3gMEMtZ-ajJ9ZnDGYq6eorr-oig@mail.gmail.com>
 <20231115033121.939-1-jirka@fud.cz> <CAGE_+C5pnASOsrDr4ehNj-deYbSTr=pRgPcWqq5VSQs-Y08ttQ@mail.gmail.com>
 <ZVRovA9OSfY5odhy@tanuki>
In-Reply-To: <ZVRovA9OSfY5odhy@tanuki>
From: =?UTF-8?B?SmnFmcOtIEhydcWha2E=?= <jirka@fud.cz>
Date: Mon, 27 Nov 2023 14:21:17 +0100
Message-ID: <CAGE_+C6ZWVP9iZeK8GLuR2VpHz3NZ8nFkJBEb4cJ+zrXwQiDDQ@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] http: reset CURLOPT_POSTFIELDSIZE_LARGE between requests
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>, 
	Jonathan Tan <jonathantanmy@google.com>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"

> It feels quite easy for this list to grow stale whenever we start to set
> a new option somewhere else. Is there a specific reason why we can't
> instead use `curl_easy_reset()` here?

Good point, makes sense. Thanks, Patrick, I will use that instead.
