Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4412213B2B8
	for <git@vger.kernel.org>; Thu,  9 Jan 2025 18:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736447636; cv=none; b=dmz4FK152c1xMFcvQ2cuWWTTurudpcp/X/Zyf2YJFWi/axeXB1RXRhpJrqEHT+qrm2s3GdlyuVGWyxcNK6CMT1jKlWY9OyeBEELE5XGPtHAFddyYuJvLSDnAUqJJaM8OgfcfsoY8kPtm/FFYU1x00Pmr21jhQcYdtIGOP48Lw1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736447636; c=relaxed/simple;
	bh=dWhKCBXxKa18ugh4nV6cF0rPr5rsFoku0MHsnnAy71k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R0r2Zijy5N9v72ZVpYQrrH9S9qPCDa9OXw/PSTBHoVVrSAZEc8+0htHCXZzovlAK6jaYl2GvxZUFyKov3CXGMyz+IY3G7wrsckVeX0cczlaXtUmu4D+2wJa/mnf/2heK5wZklpFCS7ZjLl1LJVYIisVkE6ZVwht9OKJqtWmmlDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hl0bvqgN; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hl0bvqgN"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-43634b570c1so10015075e9.0
        for <git@vger.kernel.org>; Thu, 09 Jan 2025 10:33:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736447633; x=1737052433; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qo3T3QS1qBKofFM0GHRlu2kjbgfGu/Ec83ECR3QvvD4=;
        b=hl0bvqgNKg6Fo74oIaIz3MFfidEcJwNiAXGHjRTEKjyn2lF6RjEWKpColtOiqtsCwo
         6UnTVCHEKBWqQsNXGBRqS96i8TpaPisiGeohuzQJrFSv2Bf0PzOO9ztY0C/x76hyOEx/
         aWDhzfLq1MvvULgfAXjR22AlTt/Tk2pLUR/V6CDt1tya34OtPj3UtgQOo573UzsLfPgx
         YkJVpMucJiBFUhovesnYXGOkFVj1YvgbbWuilT1VuZbYGvO8dSllO/9RHBhjIhLjkXxL
         QYYRMBNVmxzTyFNYoALgIUs+4r6P1lgLUIBbeTcU2hpEM+LFQkoeDu06NQVTtWusV6tZ
         +Z+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736447633; x=1737052433;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qo3T3QS1qBKofFM0GHRlu2kjbgfGu/Ec83ECR3QvvD4=;
        b=OVEulB1MDfoyE4UWhHgw+NesWWqojMToN36NBTtcq8zGHXypO6PZHBZvV6SE3DS346
         w0yzhtsOFoqbMFvFql47cVXQwPVtvS7+qYRDAmAGD63C5BMsiN+Ppjg+Zp3zN9d9rHu1
         iLCBFtKzqEaDIE3F0WgJICSVClrOB9SyDAoijPybWvlRyIDGIm17ZBh8XnPDK5H76cv8
         9NEpo1d+cNjvkRYSmQm0q0Q7+W2W70cSViow845hPf/VcatGhWjCWgXj9MMN9sAAdBkS
         xKHjNGtxGC/dnOG8xIORxvokoTxMD43dd7K8OisGHuS4RdRK76+/XxV5UQavn7Ai8Adt
         ZYZg==
X-Gm-Message-State: AOJu0YwyFltQJ2JAfLJ6IFl5Mpg9hmeLgKqPTMrb3XMUJY2C5NkI4zLE
	qSZRt2xCOPwa5PrOlkTpFmWxiGxedIjlNhvccdJ8CmYzS65WrRm7L5oxFoYhK++S9OXG7hXUves
	ie1voRf3ZSkqf6+teHMH5cD71kng=
X-Gm-Gg: ASbGncsWr3rij/TKiQ4DPvBm7eOSYTykSjEWl7pGq4H6y2fguq6i7Ew7YM7Z1Luanrq
	+wvgFIbOdiQtqlCZgQ+pGyd5k7mkr3mJbWYNdYg==
X-Google-Smtp-Source: AGHT+IGxFBt4PXIns47gTxKuVdeX4EKsB/XVKufeBXeTunfhzReEtlww/Ujp8CQvJ3wqEzPi6P03mCAQHr6OVCbNLKM=
X-Received: by 2002:adf:ab0c:0:b0:38a:8888:c0ef with SMTP id
 ffacd0b85a97d-38a8888c2eemr4951799f8f.52.1736447633400; Thu, 09 Jan 2025
 10:33:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1850.git.1736432663587.gitgitgadget@gmail.com>
In-Reply-To: <pull.1850.git.1736432663587.gitgitgadget@gmail.com>
From: =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date: Thu, 9 Jan 2025 19:33:42 +0100
X-Gm-Features: AbW1kvYONTpzyxk60IuDIbHOM3I6P5LShCYIistzIbhv9ViI0zHaw7VNOkVmW_Q
Message-ID: <CAN0heSo2pFmfx=zJgx2T6y+W1tG_PTXxf6uk2kBgi4c0kXz_oQ@mail.gmail.com>
Subject: Re: [PATCH] GIT-VERSION-GEN: allow it to be run in parallel
To: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>, 
	Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"

On Thu, 9 Jan 2025 at 15:24, Johannes Schindelin via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> And this is how that race surfaces: When calling `make -j2 html man`
> from the top-level directory (a variant of which is invoked in Git for
> Windows' release process), two sub-processes are spawned, a `make -C
> Documentation html` one and a `make -C Documentation man` one. Both run
> the rule to (re-)generate `asciidoctor-extensions.rb` or
> `asciidoc.conf`, invoking `GIT-VERSION-GEN` to do so.

Nicely described. Indeed, there's a reason recursive make is considered
harmful. This is of course not the time or place for addressing that.

> Incidentally, this also fixes something else: The `+` character is
> not even a valid filename character on Windows. The only reason why Git
> for Windows did not need this is that above-mentioned POSIX emulation
> layer also plays a couple of tricks with filenames (tricks that are not
> interoperable with regular Windows programs, though), and previous
> attempts to remedy this in git/git were unsuccessful, see e.g.
> https://lore.kernel.org/git/pull.216.git.gitgitgadget@gmail.com/

> -       "$INPUT" >"$OUTPUT"+
> +       "$INPUT" >"$OUTPUT".$$
>
> -if ! test -f "$OUTPUT" || ! cmp "$OUTPUT"+ "$OUTPUT" >/dev/null
> +if ! test -f "$OUTPUT" || ! cmp "$OUTPUT".$$ "$OUTPUT" >/dev/null
>  then
> -       mv "$OUTPUT"+ "$OUTPUT"
> +       mv "$OUTPUT".$$ "$OUTPUT"
>  else
> -       rm "$OUTPUT"+
> +       rm "$OUTPUT".$$
>  fi

Our `.gitignore` contains an entry "*+" to ignore this sort of temporary
files. Yes, they're supposed to disappear within a second or so, but
according to f9bbaa384e (Add intermediate build products to .gitignore,
2009-11-08), they can linger after interrupted builds. Maybe separate
tooling built around git could pick up these as untracked files for a
second, causing them to come and go in whatever GUI.

You could use "$OUTPUT"."$$"+ to restore this. That of course
invalidates your remark about "Incidentally, ..." above, but might give
this fix a tiny bit less chance of regressing something somewhere?

Martin
