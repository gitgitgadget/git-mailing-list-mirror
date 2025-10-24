Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76DF3230BDF
	for <git@vger.kernel.org>; Fri, 24 Oct 2025 02:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761272571; cv=none; b=pJ6rPJAKRqOwKUES13wO+MbB9Q2AeM+Jn8xG7hA8zoJUu8PWSPqJt8tqJmMLJN/e+qi5qbwuYntv2vzussZ9jamzv0QR3AGQaJBFyMsihhz7wSu8EKGi3w/FHb+t5+POMrb0ZtlKk9ZnvaHfPkAYgVnWiVeqIgyVqySMjJIsB9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761272571; c=relaxed/simple;
	bh=jjaUcFyDkbS544UTXgQyFyBYyVUo1lISSi54KzcLhV4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Yvv304vbwre8t/5sJcENlCYzH4Pin59a3dKk/xDHqRChPgJlTWkWtJryANvxf0cokZM7twOql+Ve4cqMB12yA76Psqebri8JVI5li+g/N+5WGUay9SIf8405GD2qIMPTd1rqEmLrTvykjTCTFQSbVrb82llTBMn9HI+x5YN4BYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KxR43xz4; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KxR43xz4"
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-430ccd45f19so16444425ab.1
        for <git@vger.kernel.org>; Thu, 23 Oct 2025 19:22:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761272567; x=1761877367; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sHjIOWElwNEBqG/lFk1aNq8O2YvUHh0zcY7f4eNrOrI=;
        b=KxR43xz4nWc0TFTL7AZuXzZ9WAc+WcTG/PLlSOJm0vwk5ywk517Sw/XQikybWSXg9D
         j5Qkm99whSwtIvzd09FJ0rT2PLRr5gqfyAkn2KBhbFS4d2GJvPHZbpX0Zq4mEhPwJo74
         9qt69oL0SaekPHvh8ikXiHR9CN5v6q66hrPQfsqhSz7R2TR2v4LA76RQwj/kbeegckFd
         u5fIw9VNn+0JFpIrwKbidH8Ee9jxG5d2BXlXSJDvSHfQw35+Kq1oOyoAoZ7EOKPSO5r2
         7jz26lXzAmb321tVu1YOqQSix84ROrHWi7losSI8lgZLv2HBr4Ai/cXrKyJ5LbphzQYJ
         IhZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761272567; x=1761877367;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sHjIOWElwNEBqG/lFk1aNq8O2YvUHh0zcY7f4eNrOrI=;
        b=lJ8sdRUu0mDhm/nARYMvllrb4YjDRs2vnDrW5Sst5VONJ6G6TFK/7N68dxJAoV/5dh
         apQh27RcH0EW5EGKYpLhiTpodV2UuILTm9F3fUuyz2SuJ3AIGjVeYfLXEYB2JFMUPmkY
         BwAx74YjpLQjXNfYF4C912rYEtWNG/mm4AgciaJRlFId2Bgeh5vf4zoTx1cckqzlKf9m
         RCDpQ/poFa9clf+sPzAYL6sOSQPDx+TMMUOHzyJAlrncK+UCmo1B4U6KaDqXBfr+MtHK
         h9hEk25Nk3PJW0Oxuo5Jhpy+Dz4qe2G2I8FI9c2K66/lMzzM9rRCdr64nmXKHm1/5104
         /rFQ==
X-Forwarded-Encrypted: i=1; AJvYcCVU4NqQBUDC0w5TAismukTR0JQWCZMMxT2bQ7G438P3ldXn1mfGurDl4Cba7dT1wU9+ibM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7q0mlgjlpsAJFlXwS225ykRmI2Nyi4HdpfeSBoxhIfE/2g7MW
	5N0yEuSUAqVWmoBKZY5QkXSCir6e0KO/CvURbk8oo9KdkVojrSfFhuBAa/fuIE/A1JN32do0GIp
	10mzzaR4u2APRk5/ZFb8SR85EVnxeIE0=
X-Gm-Gg: ASbGncveFaRdXumatYA2Y9YxUZbSn9ebTTiZTQMHxXGhBKESeNSjZbZxfnWgtkltgl7
	j4fJLJ31NkiXugWJEyyT2yDJ/jkS4aE/St8CiWbR6aK6eTBGvGlZ2M3rJ7+TtX9MWnfluitGaQA
	0j8g5p7NkMejZE2ge0AX2dkdhTIcFxzr1KDBDlgI+FPcOHetzHxRtm7eSXke3tTBRpX4C+8XUMB
	Y9kFc5lFD36UCttB1jIDVK2/yMV2rUwqu0b07YGqO5qXa4kG9PuUmhssAqlZzw/PLqm9cI=
X-Google-Smtp-Source: AGHT+IE5yU7zqLhETBtJKpRpiVaRR3VAqL4WxwIOyrrsAuzM56q8fxkHiCkh2vOhHkm/scY7bByDGG2pseEkggHmbqo=
X-Received: by 2002:a92:c248:0:b0:430:b05a:ecbe with SMTP id
 e9e14a558f8ab-431ebeb3a9bmr12913165ab.4.1761272567498; Thu, 23 Oct 2025
 19:22:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1941.v2.git.1752716054.gitgitgadget@gmail.com>
 <pull.1941.v3.git.1757673011.gitgitgadget@gmail.com> <a34cc559-5823-4e68-8f3f-07c182f7299b@gmail.com>
In-Reply-To: <a34cc559-5823-4e68-8f3f-07c182f7299b@gmail.com>
From: Elijah Newren <newren@gmail.com>
Date: Thu, 23 Oct 2025 22:22:36 -0400
X-Gm-Features: AS18NWB-aKgag2pf0PkfGuFYOnurcXycI_QuLaoZ1gI_VKSYiwZUs_BXRNaI4pU
Message-ID: <CABPp-BEvCiwxQWSX-JUCA=CGqu6TmuG+vJSUstQ+AediyPKZxg@mail.gmail.com>
Subject: Re: [PATCH 8/8] sparse-index: improve advice message instructions
To: Derrick Stolee <stolee@gmail.com>
Cc: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, gitster@pobox.com, 
	Patrick Steinhardt <ps@pks.im>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 20, 2025 at 10:24=E2=80=AFAM Derrick Stolee <stolee@gmail.com> =
wrote:
>
>  From 0ee829fea73d495dd32deda4553ea00f9299c701 Mon Sep 17 00:00:00 2001
> From: Derrick Stolee <stolee@gmail.com>
> Date: Mon, 20 Oct 2025 10:19:22 -0400
> Subject: [PATCH 8/8] sparse-index: improve advice message instructions
>
> When an on-disk sparse index is expanded to a full one, this could be due=
 to
> some worktree state that requires looking at file entries hidden within
> sparse tree entries. These can be avoided if the worktree is cleaned up a=
nd
> some other issues related to the index state. Expand the advice message t=
o
> include all of these cases, since 'git sparse-checkout clean' is not
> currently capable of handling all cases.

This paragraph feels slightly clumsy or awkward to parse, but...

>
> In the future, we may improve the behavior of 'git sparse-checkout clean'=
 to
> handle all of the cases.
>
> Helped-by: Elijah Newren <newren@gmail.com>
> Signed-off-by: Derrick Stolee <stolee@gmail.com>
> ---
>
> Here is an add-on patch to add to this series to hopefully satisfy
> Elijah's feedback. Sorry it took so long to be able to get back to
> this!
>
> -Stolee
>
>
>   sparse-index.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/sparse-index.c b/sparse-index.c
> index 5d14795063b..76f90da5f5f 100644
> --- a/sparse-index.c
> +++ b/sparse-index.c
> @@ -32,8 +32,9 @@ int give_advice_on_expansion =3D 1;
>         "Your working directory likely has contents that are outside of\n=
"     \
>         "your sparse-checkout patterns. Use 'git sparse-checkout list' to=
\n"   \
>         "see your sparse-checkout definition and compare it to your worki=
ng\n" \
> -       "directory contents. Running 'git sparse-checkout clean' may assi=
st\n" \
> -       "in this cleanup."
> +       "directory contents. Cleaning up any merge conflicts or staged\n"=
      \
> +       "changes before running 'git sparse-checkout clean' or 'git\n"   =
      \
> +       "sparse-checkout reapply' may assist in this cleanup."

I like the message change; thanks for sending this in!

>
>   struct modify_index_context {
>         struct index_state *write;
> --
> 2.47.0.vfs.0.3
