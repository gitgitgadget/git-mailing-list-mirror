Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6353017DFE8
	for <git@vger.kernel.org>; Wed, 11 Sep 2024 10:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726050626; cv=none; b=L6Ps1aqbFtTN9s4VZUvqFB8ECapGcEDqielImqwKeoNax0XPoi2Fj20L+Jlo0zABKOgJm5vIehe8jQpbSqEB0eVyfvorvSeVICzU5kCPKZoqVEcH+FnvXOHytXFh6g2uMNW5qxP9yGgqiQ7YOpSeQrRqa4DeOLbLa2HJG9o1uF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726050626; c=relaxed/simple;
	bh=5y6RaYlYIpSV9AILHXngH68s8xb70M26Cjz7ayJEFYI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IZgcnQGAknbc7BsZtetWEEermxIStc47IFEeVRgg47M0lZnVZdQcMSnxUg10ePzcL6aY7BgGNh3zcC4MNe5xsE51y9LHyAl5JQGVYWVssSE555LJ3kXUmOz7RZ24VU0oYzVsbVdtj6WoV31s7F7g+uCnLSXYW1SV9DX07yXs8BA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jPu9jJKz; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jPu9jJKz"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-374c4c6cb29so5866250f8f.3
        for <git@vger.kernel.org>; Wed, 11 Sep 2024 03:30:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726050624; x=1726655424; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=npit9VkWX4+trt/TwAafCM/JbnG+70OskAq9gmkz2zw=;
        b=jPu9jJKz+BU7DDUS12uovFt1ti50havgfAdKD3t7XRiSP7npmmu2z8y1Xwqi+htI5P
         S1LGzLTR5aQoLpTZNcJqR7Uen4JMnUfyxWt/OZzamVogcGnin4ev+d9KPeLxMkidO9UH
         sMbUr4xb2+nb1XYPRbNTpyBf5zynnYVBEQAR1N5RZZak7nZaoRCCLb2egF9SZFfx5Rv+
         KRFjSQfwzXNFg3U44tDags945xr09WPgu2aiNJI/tGvufRp2X5rIADKbHYYVTjdCX4GS
         +ljobFxB6ozjIyhNj47rSSfSlikkzXI6RUdOdD6spmdFDX8t8cbOParzaJPSN4eydJgp
         /DDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726050624; x=1726655424;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=npit9VkWX4+trt/TwAafCM/JbnG+70OskAq9gmkz2zw=;
        b=s01PNcOkLyLtsPhT07yEr3TFAwT0zcIQ9jkUWb3ljOLfoThqFDkFyuBpMcD0z8YuB+
         LJkZ4IfBgHwt50n+YNu7lwbMCYH1aZv2Shdl4rOrxZEz1jXTzJcaMuPSWj2ucEjnyJHd
         dhIXWs97ocybKcP8RJWwtvFD5E1q4FRoSBuoCZ9oJ5dQ3MIwUQRV/e2F1/tJLgbQEi3y
         DFgAGzBPxbfyWJiFjPt1yYbNvx4HWtiylPRsOFHYFPpKJ+CuyZw+W/wDNzT/97IxAHVo
         MuFeTRJYFC1OVlaLaiN0RiH+Vwjv1+6fsG1pIhqKZb3Xn3h6ANG68u2TrXhufcVLV01f
         i2AQ==
X-Gm-Message-State: AOJu0YxYpxvv0K2oEtEGX+dAKy36+05FaYTLD83+zqlSVLhRdW7C2Wib
	7ymuoEcoILIizMzqmgikPDPFC5J9zRdbWUvWjk4slyHmWZxOSissTjlvNTfXtVHO6Mh9jEdnmO7
	vkJs7Fs1o50eUr/hahqtmiueM3cgRwOv1
X-Google-Smtp-Source: AGHT+IEvuGSvuAYLRZVYVobw0n5i0+c4JH9alR5PgBQaJ4CSsPPWZjY7jm7+CM3MvGi0LkBBBgHPZ7lx7E5mFx66Vh4=
X-Received: by 2002:a5d:4387:0:b0:374:c160:269e with SMTP id
 ffacd0b85a97d-378922a6d58mr11735294f8f.22.1726050622882; Wed, 11 Sep 2024
 03:30:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANrWfmTz6x0qmTDaTOF_USR+fDcVdwfpUJDhjozb_VzBAnUJsA@mail.gmail.com>
 <20240911064836.GB1538586@coredump.intra.peff.net>
In-Reply-To: <20240911064836.GB1538586@coredump.intra.peff.net>
From: Han Jiang <jhcarl0814@gmail.com>
Date: Wed, 11 Sep 2024 22:30:12 +1200
Message-ID: <CANrWfmQt_krw6pR1W+nXWheUg_wbcJmoC1K8sStu-Ou36=vD4g@mail.gmail.com>
Subject: Re: `git diff --break-rewrites` does not work (otherwise it should
 break rewrite into delete and create, for `--find-renames` to work)
To: Jeff King <peff@peff.net>
Cc: Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thank you for the explanation!
The bug report comes from an attempt to write examples to demonstrate
what those command line options do and how they interact, so currently
there is no real-world case where the limit needs to be loosen.
It would be good to make the limit configurable if many people want
it. For me I just hope the documentation and the actual behavior can
be consistent.

On Wed, Sep 11, 2024 at 6:48=E2=80=AFPM Jeff King <peff@peff.net> wrote:
>
> On Tue, Sep 10, 2024 at 11:07:19PM +1200, Han Jiang wrote:
>
> > Thank you for filling out a Git bug report!
> > Please answer the following questions to help us understand your issue.
> >
> > What did you do before the bug happened? (Steps to reproduce your issue=
)
> >
> > cd '/'; cd '/'; rm --force --recursive -- './test_git2'; mkdir "$_"; cd=
 "$_";
> > mkdir --parents -- './repo';
> > git init './repo'
> > echo -e 'a\nb\nc\nd\ne\nf\ng\nh\ni\nj' >'./repo/file1'
> > echo -e '0\n1\n2\n3\n4\n5\n6\n7\n8\n9' >'./repo/file2'
> > git -C './repo' add './file1' './file2'
> > mv './repo/file2' './repo/file3'
> > mv './repo/file1' './repo/file2'
> > git -C './repo' add --intent-to-add './file3'
> > git -C './repo' diff --break-rewrites=3D'50%/50%' --find-renames=3D'50%=
'
> >
> > What did you expect to happen? (Expected behavior)
> >
> > `git diff` outputs: file1 rename to file2, file2 rename to file3
> >
> > What happened instead? (Actual behavior)
> >
> > `git diff` outputs: file1 remove all content, file2 complete rewrite,
> > file3 add all content
>
> It's because your toy example is too small. Try:
>
>   seq 400 >repo/file2
>
> instead of the 0-9 input, which will then do what you expect.
>
> There is a hard-coded MINIMUM_BREAK_SIZE limit which requires that one
> of the files must be at least 400 bytes, presumably to avoid awkward
> corner cases in the heuristics for very small files. That comes from
> eeaa460314 ([PATCH] diff: Update -B heuristics., 2005-06-03), so quite
> long ago. But I'm not sure if any science went into determining it.
>
> Do you have a real (non-toy) case where it should be triggering but
> isn't? I wonder if we should consider making that hard-coded limit
> configurable somehow.
>
> -Peff
