Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C6CBDF49
	for <git@vger.kernel.org>; Fri,  4 Apr 2025 15:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743779819; cv=none; b=kJaWzSbvSqjeNhLyJkTHibOGJgVQMs6M/7OcPHtiQAinDuTfK75Tmza61VrcerEHIymqS+y6ahyUx2HSvHUSdmWkbe6bb36KIfqBB5atnQhfehwxhNJ04+nDLT9m3p3WKAuAmkpTiQ8RfEyo4N6EUxmblJ/iVf9x7Uzq1XvS9Yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743779819; c=relaxed/simple;
	bh=2ECPt3TdDtg4FR6wr2mj0Yr8k9IGdBofRw31YSh89qc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XlVv1V52QN98gvolmBcA9sIvKPt9EZceQBTmK4HtYTOj5Wr6/FidXQ/k2yo7iNdv/T7x5O0U0pPMpP1L8WvG/EVkD8bsrUch1YlcPSRKgTpM/CxoVjDWpxwanorAkDEVxkR7611AAOU3SYFk688Am6jfAmdQl77HYUk/YAu+AQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I8eJaK4o; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I8eJaK4o"
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-54acc0cd458so2653224e87.0
        for <git@vger.kernel.org>; Fri, 04 Apr 2025 08:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743779815; x=1744384615; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KUOPmu85fL6ey1621MhgXAFEp1PXQppsjQYauZvJhrg=;
        b=I8eJaK4o+a1Nn5aUlg0L3h/BnlBZy7eOXy1mW6EN431QAtFXJzmC+6d8UyELHGsYqZ
         qSzLlpeNk39qyFA9+ohbE5AEnTMCd8Tp++4QTRnIgzhNOOvQId3aEglHJM7FRJ7XzzSi
         WP4BX44hAewqjRBeWvcV/HOy7ePcJqevkSlkxADHs4Yafr+iNGEBVa0cFy9iSyCnb1RJ
         1ntLcq6hCp8WgGCNZUXJwTUlptKrfz2vOqCoHMySa8ugfjMK2DmnSRiE9QInPdZlqxs3
         VEb81xdlcw7EMUp74sNE6y8RmYyIj0BC7JOHacIVFITsfKcNvgkAyOIbaea479gymZnd
         bgDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743779815; x=1744384615;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KUOPmu85fL6ey1621MhgXAFEp1PXQppsjQYauZvJhrg=;
        b=GfK4a+EwBVoVqcLy85J7dL4tlGe4ZXGDma46IXJOQmn6AccLV1SRVIxaxZQO/h4IYK
         q5hMNUABV1tC3CAz1kirpGu0I1UPXKnc+0c4wsiA8NiETCiTfnFHXMYuMLx2mOpi77LC
         VRlF/+N/sYs6D9uo0gRg10ZUbKxCYEV63+JeK+XzUQpA6qiuqgGS1b2w+ZmnxYmLshlN
         tb9qV8HTBHjMA3Dkb8oXVu0DuVkzIisg3U21Mcw6lSlmRZSesd+wtLhwIUKtKlbJ1/lk
         zgtN/WsAdZ+hmh/9CGPMdxkJtburTI/dr3nNyc3vFKjx9zKd9Dhej9eOEa/AIPMLuz8J
         S5kw==
X-Gm-Message-State: AOJu0YxAw5fXPau+JFuqS0PgKdLHNLKKlBw1jSpiybYQp9xuP0YBfDwk
	xff88V9BlnXaTsHxogotpwicO+dcMVzPlBo6JGLPaBaJmL39dDFzeyl/+/s0bs3NhAVbCHCPITS
	MrQhHL5ypyOjd8iw2NOdda8lth8DW4veCCoPO2w==
X-Gm-Gg: ASbGncvJOFtSDBLKqKOvzp1MA9xPrTAggM63qk8KMP4Jls4EX1ubANR9lAKea1erpBr
	AuxMrx8TBER2INo2nN+OVeHBqPZcNFJcCQxeuSTK+auwJKpVFy62hieJ5eIAbc6BccA0PHA/veD
	R6ixH2gP/AwP/bs2a+Dy0oRLQvx+gM942vadOJnBwwEQdQucRiDJlO8Py5lzjlF8SP6jQ0AgA=
X-Google-Smtp-Source: AGHT+IHbl9TmAzAVZITheFq+wvS1PJU1iXSqY0Qler7Qf1F9+EnvQUPXoGIeWRhNLMl9s+eGNp3gwS/guGEZcZAhZMQ=
X-Received: by 2002:a05:6512:39c3:b0:549:4d7d:b61b with SMTP id
 2adb3069b0e04-54c227dc60emr1071325e87.35.1743779815069; Fri, 04 Apr 2025
 08:16:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250329150248.2274482-1-05ZYT30@gmail.com> <20250403154404.3459805-1-05ZYT30@gmail.com>
In-Reply-To: <20250403154404.3459805-1-05ZYT30@gmail.com>
From: Yuting Zheng <05zyt30@gmail.com>
Date: Fri, 4 Apr 2025 23:16:42 +0800
X-Gm-Features: ATxdqUGyOmsodz1WffCGIw6sa22btGqsUCE-xBv_Ip4I9pHnvu9eOaOyDHM2kDc
Message-ID: <CAMvj1+qx8DgNp7kp==YNT6eTmmdA-zyNuYRuEovk5L+eqGw8xQ@mail.gmail.com>
Subject: Re: Discussion on git-refs list Implementation and Possible Approaches
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, karthik nayak <karthik.188@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi everyone,

Following the initial discussion, I=E2=80=99ve updated the design for the
`git-refs list` subcommand. Below are the key changes and a
discussion about subcommand options.

### `git-refs list implement plan`

1. Output Format:

The default output format now follows the `git-show-ref` style:
`<oid> SP <ref> LF`. This avoids dependency on ODB and aligns with
lightweight ref listing.

2. Option Categorization:

The functionality is now divided into three distinct types of options
(filter, sort, format) that can be combined:

2.1. **Filtering options**
   - In `git-for-each-ref`:
     - `--count`
     - `--points-at=3D<object>`
     - `--merged[=3D<object>]`
     - `--no-merged[=3D<object>]`
     - `--contains[=3D<object>]`
     - `--no-contains[=3D<object>]`
     - `--omit-empty`
     - `--exclude=3D<pattern>`
     - `--include-root-refs`
   - In `git-show-ref`:
     - `--head`
     - `--branches`
     - `--tags`
     - `--exclude-existing[=3D<pattern>]`

2.2. **Sorting options**
   - In `git-for-each-ref`:
     - `--sort=3D<key>`

2.3. **Formatting options**
   - In `git-for-each-ref`:
     - `--format=3D<format>`
     - `--color[=3D<when>]`
     - `--tcl`
     - `--shell`
     - `--perl`
   - In `git-show-ref`:
     - `--dereference`
     - `--hash`

Additionally, for filtering and sorting functionality, the
`--ignore-case` option from `git-for-each-ref` should be
supported across the board.

**Note**: The `--verify`, `--quiet` and `--exist` options in
`git-show-ref` are intended to be implemented as separate
`git-refs` subcommands and are not within the scope of this
discussion.

3. Implementation Approach:

> ### Approach 1:
> `git-refs list` would support both filtering and formatting options,
> meaning it could provide:
> - Filtered output
> - Formatted output
> - Combined filter + format output
>

I will proceed with Approach 1 by implementing `git-refs list` as a
single subcommand that combines filtering, sorting, and formatting
capabilities. To establish a foundation for this, I will first develop
`git-refs show` as a standalone subcommand to replace
`git-show-ref --verify`. The `git-refs list` functionality will then be bui=
lt
on top of the `git-refs show` codebase."

## Discussion About Options

1. Legacy Formatting Options:

Should `--tcl`, `--shell`, `--perl` be retained?

2. New Options:

Have you used these legacy options or needed modern alternatives?
Any pain points?

I would appreciate any feedback or alternative suggestions on the
best way to structure this functionality.

Thanks!
Zheng Yuting
