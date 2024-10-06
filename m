Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com [209.85.222.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 100C179D1
	for <git@vger.kernel.org>; Sun,  6 Oct 2024 06:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728196285; cv=none; b=d+8UU305ARUk845x0GRVjhtDRD7w32nBj2IZYI8y5QOOlI2CLAzb2ia58DKK02dk30r6Mm0BuGuu3Nh0mKjnqUBc1r1m/ZfX6YvI+7wF7og2gZ8kidZXyQL3fHqDwioXkKk+eiIJ06y/+b4sSSxsYlqjVW+uzXi6GZFOTL5mfVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728196285; c=relaxed/simple;
	bh=BpL512SDsRS7J4w5MfIKz7Llvw+AoUwJRBmF1qzk4MI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AmQtmhX497bSZQ8RzsdawaWg6fOj70BTNLiYhQfGvOz4d1G1pzz/U9HMn/QAN2/IuO5IGM2Ab8lBplJE5520haLwICj88A/yEfIEr3iKi4HG4nfp0vHXLo/lPmlvNJ9C2xsu5tVe0rJ3QBBEvu2tKBOqarNL3yPBTxqp3AUDjUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VMpiqruK; arc=none smtp.client-ip=209.85.222.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VMpiqruK"
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-84ead864cd4so838036241.1
        for <git@vger.kernel.org>; Sat, 05 Oct 2024 23:31:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728196283; x=1728801083; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+Ovp1SD78QEPEm+6UhMbPE77ccDSjJ6EtprjEyShKUk=;
        b=VMpiqruKXPjXpP61jdiUztQvf0QBbKilej8dh0VpZj5qYHLeVLo7TqyTz5FjBk8/w8
         A/hX1zUEVsJ15U/KCqFWKnQWmMVQX8p+PCio2fPXG/bZqbs6PDwUlmL/sbbMM4z4nCBS
         lOvAxHhQg6UbOxcKRsAecDfiv3EhOAiqclkdBiCpheMa3YVPsMyhzQZGtDyAjgwtr46D
         pINcbrx/CJeHTdXtCbExypDhtC/xKUO/D8ljo7eM0/ZRgsuougKu7s4RrbU4a8BLYkLN
         lqThK24aIMiGBGyw29sskgdfkfbU2LckneuFPOKGLQlearNJWC6VmDQUXob/RJLK/XwK
         34LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728196283; x=1728801083;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+Ovp1SD78QEPEm+6UhMbPE77ccDSjJ6EtprjEyShKUk=;
        b=HOFVhiVsHcNYY2SuqD1+F2Ig0O0A8Lxzjr9EHC7MlP06NeKx+r3xhSSTTQcTu2RwRc
         /2MjFDvjqPUT3Gs54GwJZtwZlJdrU0lSDbHo0Sj6E4J4QVabr/T0lz0Oxq/8UDQiqbF+
         eVKe22+yk1SocizKmPEWog18GFA9e5TrZa7DoRC9cps20ZvIBdJsVeGKgD80NVv7SfIU
         D9TjwLMRyCp1NwZ2Ka7QB3lypLhFkX73wOeLA/VjA5n/dVHM/FFEG/H9MTdppLJ4LGuq
         Iyq0Vor3MDWBrN6kkbj3iUsInUpXVWuERebWvoUmHaQII9JksQNA6ALPWjTBpVs1YGhF
         05zA==
X-Forwarded-Encrypted: i=1; AJvYcCWmZTLxlTNgNzTBkoK9+u3vRCkv9NcOVBIhWC2WvYZK6EiQroxuJWh+cyp8fn2+SazqLj0=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywd1Q4C4aOVfSKOpMOWGbThxY7sRSdAYth7YuxCzPDsiIoh8Kd+
	a8fL3N0PqHG9MJm0zponDDh1xOUoBiEvsRAo7wO562aIRCl85R9kKrsNLxVKgmyOlKrpzzhZr34
	p7NokhWmfi5vv/kMKwXsG/gz11NU=
X-Google-Smtp-Source: AGHT+IFobgP5FvYmzpGiFjkpc09jgKxu76B5XJf4OPlYEpg9tMaa6G+IVVYp5M1PqOn3OOmEkhKCbabdJ9QpQ/W8j6c=
X-Received: by 2002:a05:6122:130f:b0:50a:76c9:1b0 with SMTP id
 71dfb90a1353d-50c8557ee60mr4783793e0c.11.1728196282989; Sat, 05 Oct 2024
 23:31:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1805.git.git.1728192814.gitgitgadget@gmail.com>
 <5dd96eaf14cb6fbe130fb50ce2738646d7d3ac57.1728192814.git.gitgitgadget@gmail.com>
 <CAPig+cTO5_mDyEX=druLh6HkFazi=SBmDser8GdsVQP4iVaKug@mail.gmail.com>
In-Reply-To: <CAPig+cTO5_mDyEX=druLh6HkFazi=SBmDser8GdsVQP4iVaKug@mail.gmail.com>
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
Date: Sun, 6 Oct 2024 06:31:12 +0000
Message-ID: <CAPSxiM9eJafyL4NiKHCjR83ZpL8FA_6sf=SYBjqEXP6tFrTzRw@mail.gmail.com>
Subject: Re: [PATCH 1/2] [Outreachy][Patch v1] t3404: avoid losing exit status
 to pipes
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: Usman Akinyemi via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 6, 2024 at 5:55=E2=80=AFAM Eric Sunshine <sunshine@sunshineco.c=
om> wrote:
>
> On Sun, Oct 6, 2024 at 1:33=E2=80=AFAM Usman Akinyemi via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
> > The exit code of the preceding command in a pipe is disregarded. So
> > if that preceding command is a Git command that fails, the test would
> > not fail. Instead, by saving the output of that Git command to a file,
> > and removing the pipe, we make sure the test will fail if that Git
> > command fails.
>
> Okay, makes sense.
>
> One minor style comment below...
>
> > Signed-off-by: Usman Akinyemi <usmanakinyemi202@gmail.com>
> > ---
> > diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive=
.sh
> > @@ -470,10 +481,10 @@ test_expect_success 'squash and fixup generate co=
rrect log messages' '
> > -       git cat-file commit HEAD@{2} |
> > -               grep "^# This is a combination of 3 commits\."  &&
> > -       git cat-file commit HEAD@{3} |
> > -               grep "^# This is a combination of 2 commits\."  &&
> > +       git cat-file commit HEAD@{2} >actual &&
> > +               grep "^# This is a combination of 3 commits\." actual &=
&
> > +       git cat-file commit HEAD@{3} >actual &&
> > +               grep "^# This is a combination of 2 commits\." actual  =
&&
>
> We wouldn't normally indent the `grep` line like this. Now that you've
> dropped the patch, it would be best to lose the extra indentation, as
> well:
>
>     git cat-file commit HEAD@{2} >actual &&
>     grep "^# This is a combination of 3 commits\." actual &&
>     ...

Noted and thanks.
