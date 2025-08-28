Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0ABE245006
	for <git@vger.kernel.org>; Thu, 28 Aug 2025 17:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756401169; cv=none; b=GQx+mDt1lAJktM6KlO1HuROWyxu3SjdNqcEnp2P5B8a7QbFWjKRJ76gCReL02jbAQHLLw+R6I80Lufa3QKNahDCDi1grzYaQ0waiQfA3BVcR7XcRSWpMA/mpB/azRO8WFTBIYx19/7NSN0oOdaMCzQXiEl83GeDXEmQmOOjmZmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756401169; c=relaxed/simple;
	bh=2Bg8VfOJwRWUJIKQsj4YngqDJZRbllTOrq72YaXW+d4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IRkGroBCs4U2g+q7bA1htjVkDKjZUlX1Kx2z/5Yr/j9ilnH2BpfOy8QnavsINXij+SS9ChoXnEUlwoSnHgEjDiBnnsro9SfvHhtS94/WubcRychy5aRRs4kev356kCZLUihML6D+j6ucjpGDuc2X+A5czmeTej+Tb5zUaPg7r7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UH7UTP0v; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UH7UTP0v"
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-88432ccff13so43177339f.0
        for <git@vger.kernel.org>; Thu, 28 Aug 2025 10:12:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756401167; x=1757005967; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bmOgNjHn3+F8DQBxHMfAqCj+IIFGtjmbN7frSJj9amQ=;
        b=UH7UTP0vRj8UUz1XK5CkVn65RgIkDoEOEVGq8UbzBplLr2b94Y3AECGsa2ewY60ZV6
         I/8zkRWClCgJae1PgxQKdJcys0nv3k7rFpC5stCQFriwZ12Sr+3FBn1jsqk9FJVPk/sv
         MqwFmG7Q898lS2UCp0eyU10GLAEgvES6n0DavmzAAiGXZ9A2urxlRNPbN8Ei76TFCO7z
         MVrLC3pmByEmNEkWDNemVNGKPSAxVawtkVN13NSmZp7otGV064y2mG9Q5vKicJPr6Hdo
         eUb5vXuyQJdapxtg9l6lLxoM4dNTJsrkY53DaFpHAkxFHIW3CaWsihIGv8wxXPrGb+5/
         qHJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756401167; x=1757005967;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bmOgNjHn3+F8DQBxHMfAqCj+IIFGtjmbN7frSJj9amQ=;
        b=rsTv4OwCT1ojzI5r7kVP5wB1bT0lgkCsmC0UP79Woky93tOd9ES5EbwlwNA0A53zNW
         DG7LCNwBjIK2Ltuo8R292jyNCqxdOiTbEDTUJWtkBukMcx9SqULGBBS3qkRq3HabbglQ
         fYy0wlWH7WYTw+UUXeF9vg61tJ01xKCaTkqo0MHaQAxFObLX3+CdVY12JFsC+dr/jR/m
         wvJpq134TF+6Si6YjGYbvw8frYIR+Y1IC7ChMxRYDQzPZ+Y/55QtsnE/dmOQ03bF0Jhk
         TZr0WzAbXlJhTEZTSNxFZZ8td6gOtWrj9ZWZVAKj1cs9aOYUIph+shLTzwjaObBbNi5s
         mUvw==
X-Forwarded-Encrypted: i=1; AJvYcCXJXrg6VtHFHO5MvaWO4cASPGBaWdUGf6s8WWduGoH8lWKskl/P9BMC5V7y8uaVuD/0wqI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUWCA1OAlQ6rwjMNN5t60mNy7Mp/Lx1c24fxKMomr758Lc09/V
	vBbSQqsVRdbXL2YW0t52kC1XktU3Z7U9SZmpkHdK4G5wfjkY/VtjMnsRdMwfE36zcWEnRHVB3Qu
	DCdpmYzweRfgBmjv6MUMenuuspwAAoPGWS+GR
X-Gm-Gg: ASbGnctLoTBpilB7bYtuzdz0q4xFcxl0IwiBkPprmtow0gX+F3v8i3ph3FZgwgoXki/
	oeaHhhr4udqeKmHh4YpdWxcLF0ZLSowTuy44YkF55OOvCQKTyhCl9NQcFpKae8Bcd8mFBTExf4d
	2r7Ilz59Sv48nTUqbtxUZAklZ1qDQ220XIxJhGvGbx/fIvbr6bmnsAD0AdWM9vGGmy9bnrDTF7T
	rnZcz2P767FQJnfiFF+pRa7j0CPGtlzPgARR+lZ
X-Google-Smtp-Source: AGHT+IGfR4q382h7nHrdditYiTJbPXDqzifRL3++DyQ2OicbT1RaN8kyP0HNYztToFucNVnFhGVaxjXF0nKq43t1EDc=
X-Received: by 2002:a05:6e02:16ce:b0:3ea:a3db:ce75 with SMTP id
 e9e14a558f8ab-3eaa3dbdbbemr248003915ab.20.1756401166657; Thu, 28 Aug 2025
 10:12:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1958.git.1756228693233.gitgitgadget@gmail.com>
 <pull.1958.v2.git.1756370289.gitgitgadget@gmail.com> <ec5dcdf9d00473417b1f0b676a485f01076ce075.1756370289.git.gitgitgadget@gmail.com>
 <xmqqa53jxyiz.fsf@gitster.g>
In-Reply-To: <xmqqa53jxyiz.fsf@gitster.g>
From: Elijah Newren <newren@gmail.com>
Date: Thu, 28 Aug 2025 10:12:35 -0700
X-Gm-Features: Ac12FXxSv0aCU81narqKHFl3eoR7L4fhEH0ARYQkMR1cuVukKn4gi6m28wv1L-k
Message-ID: <CABPp-BGRHajFf5z91CvvKvahpknbt1KraCR3_rOmAjvxz36_Ag@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] range-diff: reorder options lexicographically
To: Junio C Hamano <gitster@pobox.com>
Cc: pcasaretto via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Paulo Casaretto <pcasaretto@gmail.com>, pcasaretto <paulo.casaretto@shopify.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 28, 2025 at 8:24=E2=80=AFAM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> "pcasaretto via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > From: pcasaretto <paulo.casaretto@shopify.com>
> > Signed-off-by: Paulo Casaretto <paulo.casaretto@shopify.com>

Same issue with name here.

> I am not sure if "lexicographic order" fits well in the context of
> "git cmd -h" that spews out many many options, shown with related
> options together in groups.  I find it aggressively annoying to show
> left/right-only far apart.  A user unfamiliar with the command would
> look at the list, find "left-only" sitting in the list alone, and
> waste time and break concentration wondering what in the first range
> is so special to deserve such an option, until they see "right-only"
> further down to realize that they are symmetric.
>
> I'd rather not to see this "lexicographic" change done, but others
> may have better justification (note: "for better organization and
> readability" I just disagreed is a good justification) that may make
> me change my mind.
>
> What I would change, if there is something suboptimal in the current
> output from "git range-diff -h" that deserves improvement, is the
> lack of the grouping header before the options for range-diff
> operation (i.e. creation-factor to left/right-only, before the next
> "diff output" group begins).
>
> Thanks.

I do like lexicographic ordering for unrelated options, but I prefer
options to be grouped by intent/use first, then by lexicographic
ordering.  And here, not only are--left-only & --right-only related as
Junio points out, to me --diff-merges and --remerge-diff are a similar
grouping that belong together.  So, my $0.02 is that I'd lean towards
calling both changes in the patch a reduction in organization rather
than an improvement.
