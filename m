Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EF602420D
	for <git@vger.kernel.org>; Thu,  4 Jan 2024 20:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-5e7467eb93aso8590527b3.1
        for <git@vger.kernel.org>; Thu, 04 Jan 2024 12:55:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704401716; x=1705006516;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5DXj1wGuC5XC+ZDz5PNxzvuzObCYUY9/lNwkiYekr1Y=;
        b=LKouaRnwTqeibP6rzZbmHYU4yq5Nm9RvoZKyTvsuca99yQSBMkQuGpdXaMTHpnYh5U
         Hsl2vh327q1aGfqWwZBbqwXqjs6/0+qz/E1meUcCpAKyLdVBm6dbxEj8gMx/SLszUGOF
         iiQUYqvP8hyqmfKF6rn6/FI3543Oy0++GIDY8wuHB0NWTvlDlh72Y4lyAY6pNV64PbaY
         IcQ1gwehMsxUCUGsPfFU1qKC2YFlUZUpSLQpAPfeKLB4RgVkh223QPX7uzaU4zlvxJ5J
         qPwDwSXA5br69KgCx1tqgoQ0g4E9R6pbiYMvMGF1NM9AoMi+QevuWvGu2tYGEUEVu9VN
         7KtA==
X-Gm-Message-State: AOJu0YxIClkwB60hu+uhWb+fMxXOndLzesc2nvLv9BeKXfcQS5MbMyux
	1jLMNBsFM3dP1zKcS9++gkYHOHpalBbS3OIJyK09fV/q
X-Google-Smtp-Source: AGHT+IHwfuXSN2r4M0skOETY9QZ6kdE4mfKfIyo31s9qCwBm21Bn0zzEObn8qKzSCeiSijxVV733PS+XwnTqGQcl2ik=
X-Received: by 2002:a81:7e07:0:b0:5ed:600a:2433 with SMTP id
 o7-20020a817e07000000b005ed600a2433mr387867ywn.55.1704401716385; Thu, 04 Jan
 2024 12:55:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cc74dc58-4fbe-470d-a212-4c2d2249918c@tb6.eu> <20240104202605.7382-1-dev@tb6.eu>
In-Reply-To: <20240104202605.7382-1-dev@tb6.eu>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Thu, 4 Jan 2024 15:55:05 -0500
Message-ID: <CAPig+cRYmPj6s0SHHnG5GYaDGE7t-2qADB+VD4PMec39YHoaRQ@mail.gmail.com>
Subject: Re: [PATCH] fetch: add new config option fetch.all
To: Tamino Bauknecht <dev@tb6.eu>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 4, 2024 at 3:26=E2=80=AFPM Tamino Bauknecht <dev@tb6.eu> wrote:
> diff --git a/t/t5514-fetch-multiple.sh b/t/t5514-fetch-multiple.sh
> @@ -24,6 +24,15 @@ setup_repository () {
> +test_expect_success 'git fetch (fetch all remotes with fetch.all =3D tru=
e)' '
> +       setup_test_clone test9 && (
> +        cd test9 &&
> +        git config fetch.all true &&
> +        git fetch --all &&
> +        git branch -r >actual &&
> +        cp ../test_fetch_all_true/expect . &&
> +        test_cmp expect actual)
> +'

I forgot to mention that the formatting and subsequent indentation of
the subshell is a bit unusual and out of line with project style. We
normally format subshells like this:

    setup_test_clone test9 &&
    (
        cd test9 &&
        ...
    )

where the code outside the shell is indented by one TAB, and the code
inside the subshell indented by two TABs.

That differs from what is in your patch, in which the code inside the
subshell is indented by a TAB followed by a space.
