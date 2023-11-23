Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z68a9ow9"
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 466FED43
	for <git@vger.kernel.org>; Thu, 23 Nov 2023 11:32:52 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-507bd19eac8so1571943e87.0
        for <git@vger.kernel.org>; Thu, 23 Nov 2023 11:32:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700767970; x=1701372770; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W7u6LUTM5rWg4aE66nCFKc9I9kfzwXOzOCkInDb/msM=;
        b=Z68a9ow90UZZH/k3un4XjqIR521gTIryaJDVu1lnhoTDs9NH3RfSDpB/5bVXa6Wq/a
         HLMXZABNDjwsSdqQVUQluhvuoSB3f7jvQzdL4O+Wc1bzkLUNIcclMhEHml47lFGvJG8p
         K1qAHjnghjDXDLzIfPjgelmsMALvQbGOJuVqN+tOHy22oPp6FbEv5Fu9gwRIGil8BnOo
         kRdpkrJvKmqsN7d5AYIB7DJwGqXRyBBwk05kU4iy4hD7sjj+7p9Cttd6wIoaDQMdfFXL
         JUPsiVmQP0WpHlfUqyfQKAOwfCOvaxKKbWDvX75esgGXZILlyUue5Yeacvg1GijpG3+6
         mQeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700767970; x=1701372770;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W7u6LUTM5rWg4aE66nCFKc9I9kfzwXOzOCkInDb/msM=;
        b=uIp0Z3Z1piHyMxIneOOLWwqmkb2XFy7S+bB5G2suHIEyP7Kpqx+Io0RtTHNz/mqYd2
         VdGxxWRNtqz3s81ATiAXS7N4UaXeUBeUsvWdOJgbt8vdYWaOeDuejUAtZI1U7Syw6xtC
         gDDqgpP3LsQCM9bdv0cj+gfIaND3u+JXppO1oiZjm6Y9+KRURqglmDEbpa+AaC0AS7nH
         7X9V+75t21jZwR4iNYcZtkbBdzqB63Ws3FdzS3yF5XWaYbhHDPMEoeLLREdH0paFyNgl
         xsmdqLH5TwVBBWEef7ZX6aBLykk8M8/8nu7iugvM1h2p0byKAbF6Mecn+5XLQheHRHoY
         1xbw==
X-Gm-Message-State: AOJu0YzEKZpVgPg3nDwQ+BwBwVKOq4QwvjA9fDJ5xuA5vZEXFb837Iyx
	859RNoqSvHgNqe7WWtzlPxJBQZwf50xY8PAx+Rw=
X-Google-Smtp-Source: AGHT+IFfBzeWcMdggqrbM1cMCVYgJsTHZzuSbWbVHlyb48kDEfOGMtgB3GgGmW+2Y4B1uGTFzuLDOFLaDARIQtce4rc=
X-Received: by 2002:a05:6512:114d:b0:509:4599:12d9 with SMTP id
 m13-20020a056512114d00b00509459912d9mr225242lfg.6.1700767970226; Thu, 23 Nov
 2023 11:32:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231102135151.843758-1-christian.couder@gmail.com>
 <20231115143327.2441397-1-christian.couder@gmail.com> <fb6eb685-0af1-082a-b20c-028b06b6914e@gmx.de>
In-Reply-To: <fb6eb685-0af1-082a-b20c-028b06b6914e@gmx.de>
From: Elijah Newren <newren@gmail.com>
Date: Thu, 23 Nov 2023 11:32:37 -0800
Message-ID: <CABPp-BFgJFeL4cUJ8+JZ2ZuM58F3rSYGYu_5w_mDLYWtzO4raw@mail.gmail.com>
Subject: Re: [PATCH v7 00/14] Introduce new `git replay` command
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc: Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org, 
	Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>, John Cai <johncai86@gmail.com>, 
	Derrick Stolee <stolee@gmail.com>, Phillip Wood <phillip.wood123@gmail.com>, 
	Calvin Wan <calvinwan@google.com>, Toon Claes <toon@iotcl.com>, Dragan Simic <dsimic@manjaro.org>, 
	Linus Arver <linusa@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Christian,

On Thu, Nov 16, 2023 at 12:53=E2=80=AFAM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> On Wed, 15 Nov 2023, Christian Couder wrote:
>
> > # Range-diff between v6 and v7
> >
[...]
> Apart from the one little outstanding nit where I would love to see
> `(EXPERIMENTAL!)` as the first word of the synopsis both in the manual
> page and in the output of `git replay -h`, you have addressed all of my
> concerns.
>
> Thank you!
> Johannes

Looks good to me too.  Thanks!
