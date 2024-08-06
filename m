Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF14047F4D
	for <git@vger.kernel.org>; Tue,  6 Aug 2024 19:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722972272; cv=none; b=kKXgeAqh8lRB4AOOdSEN6IodleCJNLwjRFqmzm/KMKguCYaq3eUZ94RN6B61HwoR9nCUbRonqOsHJW+iCXB6KkCEtbS3+3cj0ZH++Q46C1rexQ0P/9K2KkmdT6c6xfXD/NOoP9JBjReA+zHNIaI+hUvjuRYRNjcRP7grLohYtyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722972272; c=relaxed/simple;
	bh=7l6sdCo9zIEn++L4EoJIWrofq6zGB5xZmpGs2hbCMjY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rvt5VTPI78tYUv8WaJbR7Lgz7gdw9/DyuG7PWoPKn0O/gffWNZn4HKPrA3NvX+uDRMqwni4+OIcEBUujt9HtLaCmDWeRg9QbO2n2FMJx+scu7R7zKS+V0kaOYQLXsa3baZm9QWbxxwLzlv1S0qegLxASqNzNyb92C/caeeaESV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZzHshuCL; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZzHshuCL"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-428243f928cso7066815e9.3
        for <git@vger.kernel.org>; Tue, 06 Aug 2024 12:24:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722972269; x=1723577069; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Cfl584q6fKrCXF0C7fcGhFh2Xxaim2iIzAtkmzW50es=;
        b=ZzHshuCLdhIfiQ5hsSvcpuugI16BUg8wypyJmaGuPANOllBdFHyJTfyEDAp/eAMIUv
         JIgpeyHzDyGM72UmyGxocDFrASycYmVyZ8BVwvGUDp6doIO3LGpSOWWc06RbnjwuEmJW
         fWT7xGMSDtj46L4DOLZD5QEY78nOC46cbnGwi5ER7v2u6ZtbGgseZeUcPIEV6D+5cgnV
         anbo2dzvbGj53qKqHJigapQKSmjmYFUGks5tLxNS4dVVVOSllfxHo5n3WW97WwrXEAmo
         vJmEFs6EZgvsVIMkWevUKhqMn+EKeiRi5pss80EOis1YjXWAuYLA4tSrpPBR2lUwibCR
         QHZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722972269; x=1723577069;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Cfl584q6fKrCXF0C7fcGhFh2Xxaim2iIzAtkmzW50es=;
        b=k4THA1gHGulYBAYG79PJ4apBxWdsFyDgL5XZiB9qAcQyCs3YzwGe2fKRn10xaaPJmx
         +SNdiJgW0HH9duO1wicqU5au9fE4VpKkfsLAWvjiqhxyU5pq1AfnVP0BlV3l+F08XwD0
         ndS0suAQAlGxozXUmeftTSDV63exSYrExXzjm3KWswvbn0f1+0CHxKkb4FED25LdDCS6
         fH1f+WT/PKUly9eQrPBu5wO2TZ1AYi3Oc1s11UNdqhBBoV+IKfCl19VI+S0lAeiTrWWL
         iNAgPCT0zobSIU6U79SF63KQCmYlKbQ0vGnpoozyfaktCLxnp4TE4TPWYuLlMg7vJ+VD
         wnAg==
X-Forwarded-Encrypted: i=1; AJvYcCVFTSrgJOl7txfvia78m0jra47Kbo1mbRbMlXMgK8nbcIc3xFMQBdZi9q0hF3kQUDrd31Fo/BSSPT8rgEn/9lIlirdH
X-Gm-Message-State: AOJu0Yz2IfusYQPPjZr+4Mje4tRuV3pjdLj5ERQK7xyzyvGkcYRtNbbk
	FhD0yREmlTMY4Z8UsZgopFxRcBhDIkwEAFQH/FEtdEH1PsZ7ZUx3R49DGKqRwKaY3lnsdO3cJUL
	VenwbH9Upl5vtzAhn0zq/pkdPtNX9XFO5xtQ=
X-Google-Smtp-Source: AGHT+IHQVyTrIktjpHyhiGWdCTKOpexYZpP8/R1gw7y2qTG9higZlEyakcvlwOMioNmtXFHUngcnNQEkQlgdTFL43pI=
X-Received: by 2002:adf:e411:0:b0:364:3ba5:c5af with SMTP id
 ffacd0b85a97d-36bbc1c34e2mr11537389f8f.61.1722972268763; Tue, 06 Aug 2024
 12:24:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240806003539.3292562-1-gitster@pobox.com> <20240806003539.3292562-2-gitster@pobox.com>
 <ZrG_A3UQk56aYJ_m@tanuki> <xmqqed71vbps.fsf@gitster.g> <xmqqmslptw3u.fsf_-_@gitster.g>
In-Reply-To: <xmqqmslptw3u.fsf_-_@gitster.g>
From: =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date: Tue, 6 Aug 2024 21:24:17 +0200
Message-ID: <CAN0heSpAVinS8tuUr-o4Js3SymP_aFRpQgTVZYVVtJHVoL-uxw@mail.gmail.com>
Subject: Re: [RFC] usage_msg_opt() and _optf() must die
To: Junio C Hamano <gitster@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 6 Aug 2024 at 19:11, Junio C Hamano <gitster@pobox.com> wrote:
> I am very much tempted to suggest us do this.
>
>  void NORETURN usage_msg_opt(const char *msg,
> -                  const char * const *usagestr,
> -                  const struct option *options)
> +                  const char * const *usagestr UNUSED,
> +                  const struct option *options UNUSED)
>  {
> -       die_message("%s\n", msg); /* The extra \n is intentional */
> -       usage_with_options(usagestr, options);
> +       die("%s", msg);
>  }

Yes, I'm very much in favor of this. I know I've been greeted by a wall
of usage text more than once and it does feel kind of intimidating.

I just tested this using a silly

  git clone a b c d e f

and the user experience is so much better after this patch. It's simply
"fatal: Too many arguments.", which is kind of neat, all things
considered. While one can always polish each error message individually,
hiding it behind a big usage dump feels wrong.

Martin
