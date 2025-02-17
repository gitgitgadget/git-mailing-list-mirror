Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1344F235BF4
	for <git@vger.kernel.org>; Mon, 17 Feb 2025 20:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739824024; cv=none; b=Plty813gh33rcEVLXqblCbuiqqP1O0A4SCUDKJVB27Kp3y4JlyCBotfIgi4gRrng9Z/y0V3rkV0yDI4Q1lHg0zpPuTjdp3PpFMcqXrctEIz1pcEPHawhyX4tqKBlu2F4ujIqcuz5F00SPJxtubAnrIipVlcCClQTauYYhsmbt6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739824024; c=relaxed/simple;
	bh=uElz/jiITYq115OqqjtEwckNRTCqlL7o2ZoSnNDokt0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b/Dy/f8VFAkaqPSKKtPzQrha2ZkL0HkgFC/bvFwSspoiKUenSJsNOQnz6Ha0ZMcAodap9XX4FboTYHevLIljAWO2jvydvgcCjtUQmLKPH2pbINfT++BbRnbrOdO0NorOI3A1I69oFMmADfZB0mjxZVFB4HhfNLSfKNm0jpFElME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Uzv2mnsI; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uzv2mnsI"
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-85527b814abso69656139f.1
        for <git@vger.kernel.org>; Mon, 17 Feb 2025 12:27:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739824022; x=1740428822; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KHjEDa7dgeRxXZwXcj3dtPCdTc7F/kESOjeNym/zbZg=;
        b=Uzv2mnsISmt29w5KP5bN8/1FNXjBsJpPfDNITbwQOrXJkD+9Zj+fajoRuf1D2RWyAh
         16vjSViGpUvXvPrdQsFXxFnJbBrLrgZPN/EtocFj3U2AB2iC3ot7cVp5JaJp/WKFF6M4
         JayFaY6kmkRggBW4xIpJT0TMuWu0qUqrOgAAkFpBIEft8pn9hlP8Yiivx8tmZyVQXFG/
         vj4M459s2upjH+4L8kG4m4Euzm3seOCEYlgA8z94UlQMow7ZGayM8wTebCRSo7WpT8Ia
         kj49hQMyN02NZDra5tJ+GGhTQW40jY2tgRtSmgBRZSaIYjy4BJaIyw/6QOYY2AAvvsb7
         tcxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739824022; x=1740428822;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KHjEDa7dgeRxXZwXcj3dtPCdTc7F/kESOjeNym/zbZg=;
        b=inheaYGlx+4GjSXlPZta+UhGzlYXk6A6XrbLUTmtgVPIHBOuM/9hreMU8lvvZqtczc
         FIAyE/0j0xiKiAMbx0P5ovgoHizG1AOsSkcNI2HzzC9D1iRctpYitg3X9SNrG1W6y3fA
         GitOpHTgzJBpTFD/3mVvAZ5ctoB+DN1VoyzJz80AEpQLIPBv7qcqooUkmj4AtiTWJohz
         BjjN3g7vgjSbYuu5M5KSPiLVmTlPyAeXBmDJsRylPKs0o1AqH2mfKedXyBFQQIbuN3zF
         idoV6Xl+U3mgeTL/W3RAssh2ar0lFr4GJSlku58qAxH6Pi4ya6AkUyg9CXss+C6HC2Ll
         KSGQ==
X-Gm-Message-State: AOJu0YzkaWqtnDUYDI4bjfnUYtYnPVn/bsx5o+P+itYFAEq6pHv/q1x7
	nvu3yWFwPKbl+SxqExUA+bEASGRG5+jtOpaqaxnPOy2tbvzxgbN2EXnFh5c+DL/3e/sq2+5yke9
	flQJqbHUZKmP9LiMgZMJVvXOLyRw=
X-Gm-Gg: ASbGncv1R0iVvyU1npODf1bZisayUisNGXkmdWdVEgNXEJeBaHrvzpbhko0YTw2VTCN
	+OpTU5L2kc83OMZotwbMKYypNlaB8FkMs+FyV3CkPssxmSGUQen0uo5G+V/QOYnCmgs44p/X4ut
	VlK4ElELjyraqeDmgUvWtYd1y6kpSX1w==
X-Google-Smtp-Source: AGHT+IGUxpnwGfbwHf7P3FK18hSuiQVS45OI8dvPABeLo1HarDWf7xIiqr1DHq5l+jtFdUD+CzjWZGBW9XqyXU4fZlU=
X-Received: by 2002:a05:6602:6c0f:b0:855:72ff:9f4d with SMTP id
 ca18e2360f4ac-8557a0a5c14mr1018643339f.1.1739824022015; Mon, 17 Feb 2025
 12:27:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1862.git.1739723829.gitgitgadget@gmail.com> <4c4168506346fa3eed3d01445980044bce6c14ab.1739723830.git.gitgitgadget@gmail.com>
In-Reply-To: <4c4168506346fa3eed3d01445980044bce6c14ab.1739723830.git.gitgitgadget@gmail.com>
From: Elijah Newren <newren@gmail.com>
Date: Mon, 17 Feb 2025 12:26:51 -0800
X-Gm-Features: AWEUYZkB6KFJUNQ1yp7xjD3SdjlpQGD_vhTwqojfLBeuJtjuzAjDpKnh6Sm_W6E
Message-ID: <CABPp-BG13wHuUKLZ6xAJn7z44HbNoO=4D71cY48vmBUnpfoiTg@mail.gmail.com>
Subject: Re: [PATCH 4/5] merge-tree: improve docs for --stdin
To: Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 16, 2025 at 8:37=E2=80=AFAM Phillip Wood via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> Add a section for --stdin in the list of options and document that it
> implies -z so readers know how to parse the output.

Makes sense.

> Also correct the
> merge status documentation for --stdin as if the status is less than
> zero "git merge-tree" dies before printing it.

This also makes sense, but...die'ing still has an exit status
associated with it right?

> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> ---
>  Documentation/git-merge-tree.txt | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/git-merge-tree.txt b/Documentation/git-merge-t=
ree.txt
> index 0b6a8a19b1f..efb16b4f27d 100644
> --- a/Documentation/git-merge-tree.txt
> +++ b/Documentation/git-merge-tree.txt
> @@ -40,6 +40,11 @@ After the merge completes, a new toplevel tree object =
is created.  See
>  OPTIONS
>  -------
>
> +--stdin::
> +       Read the commits to merge from the standard input rather than
> +       the command-line. See <<INPUT,INPUT FORMAT>> below for more
> +       information.  Implies `-z`.
> +
>  -z::
>         Do not quote filenames in the <Conflicted file info> section,
>         and end each filename with a NUL character rather than
> @@ -116,8 +121,6 @@ This is an integer status followed by a NUL character=
.  The integer status is:
>
>       0: merge had conflicts
>       1: merge was clean
> -     <0: something prevented the merge from running (e.g. access to repo=
sitory
> -        objects denied by filesystem)

Should this line be kept but replace "<0" with "128" (the exit status of di=
e)?

>
>  [[OIDTLT]]
>  OID of toplevel tree
> @@ -235,6 +238,7 @@ with linkgit:git-merge[1]:
>    * any messages that would have been printed to stdout (the
>      <<IM,Informational messages>>)
>
> +[[INPUT]]
>  INPUT FORMAT
>  ------------
>  'git merge-tree --stdin' input format is fully text based. Each line
> --
> gitgitgadget
