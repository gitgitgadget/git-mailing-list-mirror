Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FA6A12DDBA
	for <git@vger.kernel.org>; Thu,  7 Mar 2024 14:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709821444; cv=none; b=DrW2VmWM0NNRhIaGCt7t7FG/KjaO0y4oS+PnfeC2ACznbtdKiWd69axsPKoue2l9SD496Xz5l3WFvNoUU+4hmyonNWbneNwHtAZh3LraBhVEUmII5f64Tw+fAFuXC+WeHtfLKUhhm6w22UcqzN4FfW8zC/85r83o5xCFERWymJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709821444; c=relaxed/simple;
	bh=ShV+d5lQd9e4gp3hcNtPN8G4UIItfa1KpEpcojGQdRo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=vD8M1mGLUrHWiZ6vV3eUSP71d6y08nHpdaFweJmqeJnhk6vRV91M6PJEgqmr1jJ5foFiAIQVnl/DqmEHQUTmAzxSqdSuv1RWat0Y+kZZnBYQYKbfZ3dOethwF4bkWoO+thOOQ63hfn/PJgVcsFAGORVFJ0I2RIcS6RiTxz0FFsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=POPtSKqs; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="POPtSKqs"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-563d32ee33aso1104320a12.2
        for <git@vger.kernel.org>; Thu, 07 Mar 2024 06:24:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709821441; x=1710426241; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8aKRU24Bzm2D/GKcFciKrG/eKnvvR9HzxLzzDd8luIQ=;
        b=POPtSKqsOBn6uFMF6Oteh9aix37aU1/wnY0Rl3kxq0fie6BuscwnGyCG9qZALnw0Gd
         UY/NtgNxV69G0eJn2MyqJVJO5p5iRrqZhEVQRbKatOUivqVZQqhc8DuBq01EO0AF0N36
         uiyqh3tHKfYieDo3D2o+dzNIUIaNEZLbXr93eu/0ussd9NW8PccfSNVzM3KNp87R86il
         y/4vak3xt4w9q42O+W9XtdBfaegGfRtR0AEzI/bT1rBjwptZ3gYdWrAILu5VwZtlNnWe
         E3WiYN7HHA3TR7NW3hcKu6Q9fbNdCznrjeIT4bt1LR+G+WdK39zZLwnieXbwc4gk27kp
         P72w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709821441; x=1710426241;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8aKRU24Bzm2D/GKcFciKrG/eKnvvR9HzxLzzDd8luIQ=;
        b=GzM7DdNnV1VEFJE/zL01ArgNUEAe2w0jUz92QBMYTiN4pm5CPZrFXM7UQ7a2XBs5x8
         Ie8hKHSMN5AXSje+i0Q1o3LqLJp1rmMpZV6+VxMubMmzv9c/gAVBtf39WD9W1nA09D+n
         gQCTAGmFVqtf/M+4GbFDEAWVHMFoiHOV1Br3PBD0Z9R02MdiTDt4r7WFljwIZSYOXoGD
         TvFNwufgQfZkwICftqGvPyuEr0j/l5tzKdEx2TvnqAnSt4UfnfJZAro2hwJ27URMm8fS
         YNdeGZEk9y7ltXGYCQMvijskxdM0obAg0d7RAuzwGUeoYXRfz1dosp2/QZ/speeBnCfr
         +kBQ==
X-Forwarded-Encrypted: i=1; AJvYcCXhqlTLB4aLlGTdZPedAw89LpCKESrwFjCMIM6fvPyxq1I2KR6GvSt6KhGBjGsdb99Egc8RjTLK/sHuVHYkyKOrbvEs
X-Gm-Message-State: AOJu0Yzb4at0+V6R8BlClEj0Jeje1I5LlHtDm8pqvMpRjp7qbq59gxCL
	YtlBvsFL2R2eUENVX57o8jQI/gGs3Zrn63s5LKzVTC4j5uzpE/poaw9QXdOpy2i6twtuJNH0DYM
	dO3zueA4kS+EAe+DLfv5+HHtYyLA=
X-Google-Smtp-Source: AGHT+IHuYmAYFBeTJFteXigwXcmHBzoUDqVG/UPojXMjqnS2CBjCr085P/YWhRZmkyqO6ZwJL00R5E+VaxTLgzS1PK8=
X-Received: by 2002:a05:6402:5c3:b0:565:7edf:41b0 with SMTP id
 n3-20020a05640205c300b005657edf41b0mr12931689edx.6.1709821440929; Thu, 07 Mar
 2024 06:24:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1675.v3.git.1709676557639.gitgitgadget@gmail.com>
 <pull.1675.v4.git.1709716446874.gitgitgadget@gmail.com> <CAP8UFD31udQB2e=+G-LpCevuS+JxQdWqwaq=5qvGEn21595faQ@mail.gmail.com>
In-Reply-To: <CAP8UFD31udQB2e=+G-LpCevuS+JxQdWqwaq=5qvGEn21595faQ@mail.gmail.com>
From: Aryan Gupta <garyan447@gmail.com>
Date: Thu, 7 Mar 2024 15:23:49 +0100
Message-ID: <CAMbn=B73boxu1HDy2UHGz83wxnE7=udmbSv4nFsV+ngA0Bn0Sg@mail.gmail.com>
Subject: Re: [PATCH v4] tests: modernize the test script t0010-racy-git.sh
To: Christian Couder <christian.couder@gmail.com>
Cc: Aryan Gupta via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	"Patrick Steinhardt [ ]" <ps@pks.im>, =?UTF-8?B?TWljaGFsIFN1Y2jDoW5layBbIF0=?= <msuchanek@suse.de>, 
	=?UTF-8?B?SmVhbi1Ob8OrbCBBVklMQSBbIF0=?= <jn.avila@free.fr>, 
	Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 7, 2024 at 2:28=E2=80=AFPM Christian Couder
<christian.couder@gmail.com> wrote:
>
> On Wed, Mar 6, 2024 at 10:46=E2=80=AFAM Aryan Gupta via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
> >
> > From: Aryan Gupta <garyan447@gmail.com>
> >
> > Modernize the formatting of the test script to align with current
> > standards and improve its overall readability.
> >
> > Signed-off-by: Aryan Gupta <garyan447@gmail.com>
> > ---
> >     [GSOC][PATCH] Modernize a test script
> >
> > Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1675%=
2Faryangupta701%2Ftest-modernize-v4
> > Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1675/ary=
angupta701/test-modernize-v4
> > Pull-Request: https://github.com/gitgitgadget/git/pull/1675
> >
> > Range-diff vs v3:
> >
> >  1:  05ee9e8a458 =3D 1:  14c7137baea tests: modernize the test script t=
0010-racy-git.sh
>
> This tells us that nothing changed in the patch since v3, so we can
> only wonder why you sent this v4.
>
> Did you fix some headers? Please explain.
>
Hey. Sorry for making a lot of mistakes in my emails.

I thought that there were some bugs in GGG due to which it sent some
headers which were not syntactically correct. So I tried sending it again.
And that was the whole purpose of this.

> >  t/t0010-racy-git.sh | 31 +++++++++++++++----------------
> >  1 file changed, 15 insertions(+), 16 deletions(-)
>
> Otherwise, the patch looks good to me. Thanks.
