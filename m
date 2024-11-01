Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A84D1155725
	for <git@vger.kernel.org>; Fri,  1 Nov 2024 07:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730447489; cv=none; b=Z58Ql0j+kpcmsKMLA9i4y3wBsvVr/paO1CEl050Yr9Gq8yWrpkye10Z65wMjV0gskDUESBsNtcDvV0vBZ/HcFdil5WJ3LxEfjTamiWwu/lH9zjaPMAxe5PANAnbfI3P0OaHcseH/lhbSAhOm9i74XLlPy1uDWHuk6IuYZpEPsw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730447489; c=relaxed/simple;
	bh=t1An2rtqcJHXbALbW68Z1cquPzZrUaIEkQI1zWpLgH0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UArziDcrJdADKZpoZddfNvHi2S7gf78bkmL6xnou7zul2OvKHtsJJNPmAHE23YTW+V7Ui9NQIF/iXk9axyq3EfMZRV85ALwFO+2qbbpfzrI+oP4osut2o+r3Jczi6upQQXrAcgN5U/c2e71FIxU1Sx9o5J0wYtJuf4g7c5LR4Pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CAK2vm4E; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CAK2vm4E"
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e291f1d659aso1545235276.3
        for <git@vger.kernel.org>; Fri, 01 Nov 2024 00:51:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730447486; x=1731052286; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=AiXyPaG+GO6SPCU6qHcmmFxEMYiHl0T7IDw/GUdzbQs=;
        b=CAK2vm4EBCeVVsCvaa0hiFc48l8fmmsvigx0ge3qBEn3EwClnsAkte93AX4mLV1xI/
         GuGVMpGjNnYRMlKt32oAQ5Sd5tyi6Dz5Ae3HJqha8b5Ds34dj0OWPdoSam67f15kCLWI
         /m9fPSFuieQmekjAWaEw5mUjYC8UJLz/Y5H7HgeS9B3RlZhzQeBNXkD2J1vYHtAyq6kf
         ljUoZEkJWC93uJySdYWmBf28kABPUKmc5Y2+ge1vRJPprQdBuPYSgwiK+REL1y9GOyin
         y7sq6rKZaMK9C9uGs6zldGbdBAtjnBC5U9JYa37SCrw2O7as7HZvX4f/Q77ic2kJKpJk
         rftg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730447486; x=1731052286;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AiXyPaG+GO6SPCU6qHcmmFxEMYiHl0T7IDw/GUdzbQs=;
        b=Dk97xwM405ZYyFvwXXjbzqqCaEpiCAR4kURMixuLV+qAWSuwrdMopBAG8JWdPoWbke
         HosCiAQu95T9RN03odJ4AcB3hvQJo+JYJGWbovU5RW5K1K2VbSWTgnwy1RqizX9Yp40h
         RzKa4/MJER9BSgfpfW/x00vGFeYImYTYo8opqrxm1zPufoWZhM4mqVr5rgU/G6F42FVZ
         BLp2gJQiHFZ1cZwZgelkMNmm6IeMju2T9fh2rjE4GP/gbsCviIxl+WRCwFwCDJRIGecp
         kyr1bXc6aG/BOLgEy4QFB6UybpQDa5KwdS/PBjzTdZQn0Asm+w0sledlqUOhETP6U/+G
         07Lg==
X-Gm-Message-State: AOJu0YyR11hgP/156qXcz4nMqGQv/lnygehdGK0SlVl2eQA4UwQ0C+az
	l5c6F/Jv7kttSqoCCHmu43xQNBacZfwT9OyxllXLl5pd26UczMdH/vth2jrQCsgPpBWwKIjHHeM
	jTAQrY3DVWUfXivEwNDkdHvv4QyY=
X-Google-Smtp-Source: AGHT+IFpyhlE5sbiKBQ5c/DuqbgZN5PnQe/XqCp9rpbF6xnOnCkNckdql6AnQ8LgRmOnqounfY9/H4FHlXlvkZKkPq0=
X-Received: by 2002:a05:690c:360e:b0:6e3:1537:3d54 with SMTP id
 00721157ae682-6ea64c33338mr26190087b3.45.1730447486536; Fri, 01 Nov 2024
 00:51:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241031094554.68916-1-kuforiji98@gmail.com> <ZyPlYkwsFrxH+JwE@nand.local>
In-Reply-To: <ZyPlYkwsFrxH+JwE@nand.local>
From: Seyi Chamber <kuforiji98@gmail.com>
Date: Fri, 1 Nov 2024 08:51:11 +0100
Message-ID: <CAGedMteyi0_C4PhfCXcD5gHe38px_g4hbxuG63o8tCSHdLcfGg@mail.gmail.com>
Subject: Re: [PATCH] t9101: Refactor test_expect_success format
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, ps@pks.im, phillip.wood@dunelm.org.uk, 
	kristofferhaugsbakk@fastmail.com
Content-Type: text/plain; charset="UTF-8"

On Thu, 31 Oct 2024 at 21:15, Taylor Blau <me@ttaylorr.com> wrote:
>
> On Thu, Oct 31, 2024 at 10:45:53AM +0100, Seyi Kuforiji wrote:
> > The current script uses an outdated formatting style for
> > test_expect_success blocks, where each argument is separated by a
> > backslash and newline. This style can lead to readability issues and
> > makes it harder to maintain the script.
> >
> > The modern style consolidates
> > the multi-line command arguments into a single quoted block, which
>
> Strange line wrapping?
>

That error probably occurred while I was editing the message. Should I
edit and send an updated patch?

> > improves readability, maintainability, and aligns the code with current
> > coding standards.
> >
> > Signed-off-by: Seyi Kuforiji <kuforiji98@gmail.com>
> > ---
> >  t/t9101-git-svn-props.sh | 48 ++++++++++++++++++++++------------------
> >  1 file changed, 26 insertions(+), 22 deletions(-)
>
> This does not apply cleanly on 'master', so I assume that you wanted it
> based on sk/t9101-cleanup. That's fine, but please let me know in the
> future in case it's every less obvious :-).
>
> The changes themselves all look quite sensible, though.
>
> Thanks,
> Taylor

Thanks, Taylor for pointing out this issue. I have rebased my change
onto the latest master branch and resolved the conflicts for future
updates.

Thanks,
Seyi
