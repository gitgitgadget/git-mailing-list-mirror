Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C24730FC23
	for <git@vger.kernel.org>; Fri,  7 Nov 2025 08:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762504547; cv=none; b=sm/aF4kme2CAp7WDOhtTtg09DAFq1LOOZEepm8bHSJ1l4Bp0oePjuNaPdp+lYds26xJY0wBLq5yLD21k9r5Hv11X1SqEEIMQF/5RU/HJcTDtjqe8GU/GKI7inswr0Uo/1gIWGIZGF1YlXaMrBKChfSugdmFlkWbo3RqbwvaL4tU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762504547; c=relaxed/simple;
	bh=MYdGDacd7ebHzO6uPjZPqjKYmC7n1kaknqgJWcvjpFs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cd4bz6JxBurU4u/bJehdZx9rS5+kSv8KVc36/xZZAKTapXnUJWBJ0zZhxwPUF+WUv8DdQwEO8bM61o2hw4U+Bc0SoqcL6sDikEjHG8Zsn9OHD9+xM4TEcgX827bQzNCFEJJbebpgg29MyEPCLDixfncWJ5OL32K9u4r22b9seOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nhG3kGi9; arc=none smtp.client-ip=209.85.217.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nhG3kGi9"
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-5db469a92f7so144205137.0
        for <git@vger.kernel.org>; Fri, 07 Nov 2025 00:35:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762504544; x=1763109344; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=SxXFzbLBoibJGbMg/CU4diS/p+eR6pxAwQNzIWPYSzQ=;
        b=nhG3kGi9V+juEXEV0blX3CiDWw6fOEO1rbWG1uCt+CqNlQ0590FdDA/Cb7fuKw3XQX
         kYkCGhy6lWbvIPz2y1KoMv1P0gz8QsOeBZU8OCG4VKk9a/yKIbjbAz80Gf0v3JUyghOA
         1POppjygtPSKdrikY2U2+z+4TKXasUsnvX7gbT1mc/VXzCl8T+NJyoORQ5G5dS+/Yksb
         lFI/U33GqK7xaoFcar8c4vCuRJRIVOOZrZ5OqUc8Fg14kRUcbErpSpyIIVI6YVT/SZep
         kTNt3URi34rMXJuLedN/aisbV8unZewHPcBH8v6OUdOmRrHizDJnrzmhx5t6W3PisaTh
         Eb4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762504544; x=1763109344;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SxXFzbLBoibJGbMg/CU4diS/p+eR6pxAwQNzIWPYSzQ=;
        b=HEhOJMOU0lCZnZfiWKuuXOyC4SQR8CM8CVbNHfu/Y3a0aG+s4x2SA8MMpyr87tmTDo
         YIknT/RX+e/laHk7UIxi2aCvFizDI172TuSfGca9uTbSHh1DGqnwVCZJx4EghVYOPfEw
         gA6o08s4U3yQhRcclLoSLiwuv0QtCOqHibZ1lCu/gbYJZD8XF9f1ESX4pUwfR2lx/sQt
         P7pcP6OwmdfOY8NptcQCoS39yIjDCZ0jsuBbLcZ9667ZZfGlHdoi8aiFuG+PmyuwX0LX
         xBJRpXHSHJj3lA2n2fSDfWhi5lHurkHxW25PV9CkcWawdhzTfiMOJu39KKydio86oHm4
         Ed/Q==
X-Gm-Message-State: AOJu0Yy8DEiV9G32qBcU1TJmIUvAcC3dJ3ASKbMBqbGcGtPCxe/kL5CI
	Hn5hmPBc2j9Kpjl6FyOHqjg8yb7oKdpYgeRqcBng8hGoZLJLlBJaCqdmZx6xnG2nDsAQLaT/Aoa
	u2CgOd8SRrRO09sdZ3rSTmSERdHCYQ1lgDOva
X-Gm-Gg: ASbGncu/DSQG4+buzh4NDpNSwDXnQFQMAzyNZK9qjsO7bEBwpsfNQWITKCIvTB0Shoj
	7nouNnqeRZfIC99HSN1aQQ05JxVdhYl1U2bhdBkOfTcbSUPehNFfxCF5ZhsEIdgVTY1j4notmDB
	LjHUyGTDKyp6eNro11Y6Zpro5pnXaFQ/I97g/W5sgrQCyqZW1pNmNMMXMruF8TR+Is+brH2mqq7
	k0OBCGs6R6Kabic+zbQy5bs2tmSOV1+gPD/kpKfiG+pLcMGb8BMkNn4lK6Tub2WdrrMSgmz
X-Google-Smtp-Source: AGHT+IHdxEqMSm6H4rbtAyp8i8pa06Ch/WzYjjwr2QITscRB8+ff/dy/SkeoVGUJ17/zkILKzaKHBeNJ1ZtM1rpe9kk=
X-Received: by 2002:a05:6102:6486:10b0:5db:2e2c:d6d2 with SMTP id
 ada2fe7eead31-5ddb22a94a9mr612666137.42.1762504544445; Fri, 07 Nov 2025
 00:35:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAEyHQXWd77_jJachC6FYbWMJ+L=KkKoUqiACQ7z8r-ZwYq8JYw@mail.gmail.com>
 <e1fede83-bed0-49e9-84a0-f026b9df6039@kdbg.org>
In-Reply-To: <e1fede83-bed0-49e9-84a0-f026b9df6039@kdbg.org>
Reply-To: bhavikdbavishi@gmail.com
From: Bhavik Bavishi <bhavikdbavishi@gmail.com>
Date: Fri, 7 Nov 2025 14:05:33 +0530
X-Gm-Features: AWmQ_bnDUXLhDi9-pnh8nMhBbInQUsMlVEp-Y2BdBkL6qfyj0Z-dHzlhCRWoBeo
Message-ID: <CAEyHQXWd4kN=ehWh0Y7xNnPGk3ofXEc4=PvSYaZM91TFyLtnpg@mail.gmail.com>
Subject: Re: [Bug report] git cherry-pick silently ignores error whereas git
 apply fails for hunk apply
To: Johannes Sixt <j6t@kdbg.org>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

git apply --3way --verbose ../test.patch ; echo $?
Checking patch mango/connectors/apple/ops/query_check_hierarchy_op.cc...
Applied patch to
'mango/connectors/apple/ops/query_check_hierarchy_op.cc' cleanly.
Checking patch mango/connectors/container/loc_base/util.cc...
Applied patch to 'mango/connectors/container/loc_base/util.cc' cleanly.
Checking patch mango/connectors/container/loc_base/util.h...
Applied patch to 'mango/connectors/container/loc_base/util.h' cleanly.
Checking patch mango/main/http_test_ops/new_entity_op.cc...
Applied patch to 'mango/main/http_test_ops/new_entity_op.cc' cleanly.
Checking patch mango/main/main.cc...
Applied patch to 'mango/main/main.cc' cleanly.
Checking patch mango/main/ops/refresh_apple_entity_hierarchy_op.cc...
Applied patch to 'mango/main/ops/refresh_apple_entity_hierarchy_op.cc' clea=
nly.
Checking patch mango/main/validation_util.cc...
Applied patch to 'mango/main/validation_util.cc' cleanly.
Checking patch mango/conn/ops/apple_box_storage_package_op.cc...
Applied patch to 'mango/conn/ops/apple_box_storage_package_op.cc' cleanly.
Checking patch mango/utils/apple_utils.cc...
Applied patch to 'mango/utils/apple_utils.cc' cleanly.
Checking patch mango/utils/apple_utils.h...
Applied patch to 'mango/utils/apple_utils.h' cleanly.
Applied patch mango/connectors/apple/ops/query_check_hierarchy_op.cc cleanl=
y.
Applied patch mango/connectors/container/loc_base/util.cc cleanly.
Applied patch mango/connectors/container/loc_base/util.h cleanly.
Applied patch mango/main/http_test_ops/new_entity_op.cc cleanly.
Applied patch mango/main/main.cc cleanly.
Applied patch mango/main/ops/refresh_apple_entity_hierarchy_op.cc cleanly.
Applied patch mango/main/validation_util.cc cleanly.
Applied patch mango/conn/ops/apple_box_storage_package_op.cc cleanly.
Applied patch mango/utils/apple_utils.cc cleanly.
Applied patch mango/utils/apple_utils.h cleanly.
0

I've compare the file content of `mango/utils/apple_utils.cc` for `git
apply --3way` and  `git cherry-pick` is same

On Fri, Nov 7, 2025 at 12:07=E2=80=AFPM Johannes Sixt <j6t@kdbg.org> wrote:
>
> Am 07.11.25 um 05:39 schrieb Bhavik Bavishi:
> > What did you do before the bug happened? (Steps to reproduce your issue=
)
> >> ran git cherry-pick command, which went fine without any error, but mi=
ssed to apply change
> >> created patch with 'git fromat-patch' and applied with 'git apply --ve=
rbose', which error for the issue
> >
> > What did you expect to happen? (Expected behavior)
> >> git cherry-pick should fail, since it failed to apply hunk
> >
> > What happened instead? (Actual behavior)
> >> git cherry-pick completed successfully without any error
> >
> > What's different between what you expected and what actually happened?
> >> git apply --verbose, failed with error about the issue, whereas git ch=
erry-pick didn't fail for the same
>
>
> If you use `git apply --3way`, does it still fail, or does it succeed
> and does it produce the same result as `git cherry-pick` or a different
> result?
>
> -- Hannes
>
