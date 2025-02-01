Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5556433BE
	for <git@vger.kernel.org>; Sat,  1 Feb 2025 09:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738402377; cv=none; b=At2Pa53IzzzHy1ovVnkDPPALsW0tZct6Lj+lNT80viH95u1/eKwz4hiUZm1FboolCIJ+2XQT5Mm59DSBfmo8nX5SI6cB1RBkYGcFXexS701CUvD9htkZW94KjzBDGw36QTETfyOdLrtw/SzAiC4QGbHBD0XtQlhLTxm4eMq2phI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738402377; c=relaxed/simple;
	bh=PreuGU3tQwgEDQUa1bFnR9IJ/qjk/M4IDMy9JlohWqQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RUbDZ7Osa1aoMexgbWqkAefGy4v2ZZIsGkxFHsx+bnkwRUgqjs07B+hdEJe5flE04ptlQnhJZC9MVhU3K+j+6URi2bFPljw8GAvPgfN4EUpYrLcdMkpQNIg+/r0lCHimpAGIh34JyHdnD1UqHcyX5KeN/VdR3ORKQ+2TzJdY0ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IWAHA6Ie; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IWAHA6Ie"
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-53e3778bffdso2846525e87.0
        for <git@vger.kernel.org>; Sat, 01 Feb 2025 01:32:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738402374; x=1739007174; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=h9TXi67gUMS1YHlXlO+4LyPIRPh3dbGiAPFYNZKKleQ=;
        b=IWAHA6IegM8nbUe4Nl2Iri0wNo7sUilzloyHKrKnIitue4wW7QwzolcVmfx+EoHqoY
         lrGKdBMMSZ+MK6eDGQvf+7QoZW9vU7sqK4iOpx0i/WKiLLoTqAM87zX79p7ZH4XiUTxo
         XIHglp7wcK3iz76ET/vZSnEipDOA1aVvZq0/r6e8WNS+LGklXhVl/UogESPZvjjll5aa
         aXD70+p8bJRAZxcqgLH755iXx7Cf+rADj19UzBwO6G5mHVV1WZiEcYbMUMsGs5qc2E83
         v2uscXnUvnvcMyYtSrWib9irponI6sfKWv9Waeg31T8s8yZf3O6wRG9oxGk5qSHSxbnp
         rk0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738402374; x=1739007174;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h9TXi67gUMS1YHlXlO+4LyPIRPh3dbGiAPFYNZKKleQ=;
        b=Bulca1LkjA4bhxwHB26oOuU5zIA9Ocq1T0yPPOWRlr50yZCYIjoDXQSs8P5RxuKAgA
         Ujby7ucP0thrCMFRgfLrS4iWX984tAGcot7HqiSKzsulVBLOCH2hf+J9l72bPPCjuIS2
         F4/esXC7na4ME9iGh3GPaC6RDVxi5ve7/mL3AFYz/5joL5x7P5TUe04jnKl1cr++bEtn
         oei4tkdCIbQ4cayH9sLz4sYNYvqYfUF8edJtJ1FLXBD5PPBzaVchFg/U13X5SQfcNzVW
         g2IRBHa/0d64V1WDMG6aEIiG1JtIGRyuFghN27Sf+q4EicHPhIxJvKRKpMbBX1TERi9H
         sCAg==
X-Gm-Message-State: AOJu0Yzbc1P8+uwpi6gntqfZCaLKl4r9aeMOhu//s6NLTuul+dpp4mXm
	cj6aYwas0dJAX+QrDVY9kBKCxsT1HAsjq5AK5zpZU3I4I7SgMKlX9VlrCvQS20rR2a0z80yLbF2
	Z7M3SUUh58EsZxJMmu01hkn/IcZo=
X-Gm-Gg: ASbGncvC9s4QfLDvdYPxrrIhwcqsfkfFUA76NsSxG5PeO2/eppHWv61iJoY+FjzDfWt
	vMet+QRGQFA3DwxmXX8b3l5YRZHbj3iQS5LEAIt9HNjtgGKAZOefvX5nqzfqyqEu0kIZEgYZmaC
	I=
X-Google-Smtp-Source: AGHT+IGf/mNUv85BNF77sz419r0wa2efn/ANOseOROVWyN5SMpFdVhgvSN8TWaNcb3QRDhe7WRFXRlv1hmbfkEo2iG8=
X-Received: by 2002:a05:6512:2389:b0:542:9a0a:131c with SMTP id
 2adb3069b0e04-543e4bdef4dmr4817344e87.11.1738402373623; Sat, 01 Feb 2025
 01:32:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250201071210.30509-1-amch9605@gmail.com>
In-Reply-To: <20250201071210.30509-1-amch9605@gmail.com>
From: Meet Soni <meetsoni3017@gmail.com>
Date: Sat, 1 Feb 2025 15:02:42 +0530
X-Gm-Features: AWEUYZm4JZe3XI_cvyVe5YTLXaicjIODRjMaSm8u8laqR1LlXjWUPkdHCV_i0Kc
Message-ID: <CAPhwyn0tGHuX_Gh=rno9wj8fLb6zG4M3QAZyQDQ8qZyE+Uyg_Q@mail.gmail.com>
Subject: Re: [PATCH 1/1] t5401: prefer test_path_is_* helper function
To: ambar chakravartty <amch9605@gmail.com>
Cc: git@vger.kernel.org, ambar chakravartty <chakravarttyambar@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Hi Ambar
On Sat, 1 Feb 2025 at 12:43, ambar chakravartty <amch9605@gmail.com> wrote:
>
> From: ambar chakravartty <chakravarttyambar@gmail.com>
>
>     test -f does not provide a nice error message when we hit test
>     failures, so use test_path_is_file instead
>
> Signed-off-by: ambar chakravartty <amch9605@gmail.com>
> ---
Instead of sending a separate cover letter, you can add it here between
"---" and diffstat.
cf. https://github.com/git/git/blob/58b5801aa94ad5031978f8e42c1be1230b3d352f/Documentation/MyFirstContribution.txt#L1220
>  t/t5401-update-hooks.sh | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/t/t5401-update-hooks.sh b/t/t5401-update-hooks.sh
> index 723d1e17ec..17a46fd3ba 100755
> --- a/t/t5401-update-hooks.sh
> +++ b/t/t5401-update-hooks.sh
> @@ -64,14 +64,14 @@ test_expect_success 'updated as expected' '
>  '
>
>  test_expect_success 'hooks ran' '
> -       test -f victim.git/pre-receive.args &&
> -       test -f victim.git/pre-receive.stdin &&
> -       test -f victim.git/update.args &&
> -       test -f victim.git/update.stdin &&
> -       test -f victim.git/post-receive.args &&
> -       test -f victim.git/post-receive.stdin &&
> -       test -f victim.git/post-update.args &&
> -       test -f victim.git/post-update.stdin
> +       test_path_is_file victim.git/pre-receive.args &&
> +       test_path_is_file victim.git/pre-receive.stdin &&
> +       test_path_is_file victim.git/update.args &&
> +       test_path_is_file victim.git/update.stdin &&
> +       test_path_is_file victim.git/post-receive.args &&
> +       test_path_is_file victim.git/post-receive.stdin &&
> +       test_path_is_file victim.git/post-update.args &&
> +       test_path_is_file victim.git/post-update.stdin
>  '
>
>  test_expect_success 'pre-receive hook input' '
> --
> 2.48.1
>
>
The patch looks great! Thanks.
Meet
