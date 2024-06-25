Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B158F17C7B8
	for <git@vger.kernel.org>; Tue, 25 Jun 2024 17:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719336758; cv=none; b=ZsERO6lSVwaIUGBNvsDyzTa5/KMaI+6kqnrUSvT4TQRgDjZWk9LGFvUhIAyU6c1Ic0BKXzvCIV+UlBU8xOX3cWqVgZGRX4fmizkkjh0/zr5plxCUgaKYWhQMleGIuR2OT5RvfX0CEvbgOknUQUsQ3aA6iLgREgiMMH5qjToK2lA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719336758; c=relaxed/simple;
	bh=mpm+b2aVvWhfLlT5qKbHZQnXim3ok+o8uHDqMrKlJBQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AR/iO6PP+jb/IqZcK7gNnucgO+WFPIYtoxSTTkflAEmvtWRReymeOZmBLRoYUUX9n/8juojVLV+SUO0wFn4zwisENdt3DWdseQhqEX+yhe46Y1+OJXZT+9u+d3PgnR2ADW9YT0N3z+PMA3oSFhLvWdTaZCqXXQaD3iesFDqVmmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fn9Uv1qo; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fn9Uv1qo"
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-376243a112cso22069605ab.3
        for <git@vger.kernel.org>; Tue, 25 Jun 2024 10:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719336755; x=1719941555; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O6V3y5KTH2aPzv6uPL0nxu919oGx9ZlPDtOs1kSYMQ0=;
        b=fn9Uv1qoPlgooYN9oH+6XUWRqpI1nHwj8zIyJFkMaR9tdn3dY0EuMFobrdv3Fkwg8S
         V5exakvs49TL3bdRLIAXLd2iheMpCgn4twVMuChFJKkXUOZ0HAQzJM7Ap5spbtBuF7Nk
         8sanPRh/D0iwmUiFGzMShR9pZxvolpiwQhHMUZwPMBXRzBKh7I7JGVejEIVVmgVW/8Dy
         dMZ7M8UvsoS2qgdDwm5fsxkKpJs4D60xnHkyLGwScunbxC9IUN6nlPMDaY4/SkgkLLlD
         fwSE9VhcjAggsRHST/E01NwDaJ8Ia7GSlCScfRdg7Jigc9qL3iAa3fR+67n9YPVRUAUg
         J/ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719336755; x=1719941555;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O6V3y5KTH2aPzv6uPL0nxu919oGx9ZlPDtOs1kSYMQ0=;
        b=O87r9TCbxYMFbSqcdMIyUR0m2FR7Xf+23zETB7R+AJi8mzTKSa0pGTIQCHR30woNW4
         HVO4OcQoMhrh3PL6At8jjqYFAeGCXAKmb4d3aX1j18Wb0vPLocIMaOnP46F5/KOOzykG
         bQRdXLNsgng3vnAYacFsXtRpWOGM73BHleaYOoG+AzOym6L79clnci9vgr6M7rDMwQvu
         +0nqxQVb0aePtmimwspuwtSRjYbCSg2tJKDGe8kxGhpZ44nJZLu6/tsq+IAQdLgGKaEo
         R+I70gpEVJRYqDoajmpPA47Vao0IduqNhnifvoTCriZqI/JhEx2W3a/ObgA6CFAl8Ai4
         NVsA==
X-Forwarded-Encrypted: i=1; AJvYcCU6L/+wkilT1sUiKyp+cltNiixfaX93EJJEn2j2pT2zxE5EtIu5Mj6xpVCLMXBcHdVasFlZlvR0hPQPiMxPEQAj68Ba
X-Gm-Message-State: AOJu0Ywcp3mvV6Ob4hDyUXyGgYISRrC7af8XSCAibvtIhsKYXEHSdB3m
	97K0xBTiRynvyRis8hAWIjsE54Zxe9a6CdsIKLUUeb3lkqHDYpHEwrpr/B9fnqosxRA8s4cO93Z
	Ka2W+j2Pk45axRhPq3QfNdMc/dq0=
X-Google-Smtp-Source: AGHT+IEkQdkXhlLEZRkWPaaGaSOm5CfB6iwNxWDc5cV9FDdYsjsGiLIZjsZv2TuSdqG1Yoy7XbKSZgOiKrWGZkgaVHw=
X-Received: by 2002:a05:6602:1688:b0:7eb:54ad:cf46 with SMTP id
 ca18e2360f4ac-7f3a4dcfdc2mr981024439f.6.1719336755645; Tue, 25 Jun 2024
 10:32:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240614102439.GA222287@coredump.intra.peff.net> <20240614102801.GD222445@coredump.intra.peff.net>
In-Reply-To: <20240614102801.GD222445@coredump.intra.peff.net>
From: Elijah Newren <newren@gmail.com>
Date: Tue, 25 Jun 2024 10:32:24 -0700
Message-ID: <CABPp-BF0Gt5QsbfepJ-NEwdNs_YXeSwpbKXJEkjaXgO47OVx6g@mail.gmail.com>
Subject: Re: [PATCH 04/11] remote: use strvecs to store remote url/pushurl
To: Jeff King <peff@peff.net>
Cc: Junio C Hamano <gitster@pobox.com>, Mathew George <mathewegeorge@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 14, 2024 at 3:32=E2=80=AFAM Jeff King <peff@peff.net> wrote:
>
> Now that the url/pushurl fields of "struct remote" own their strings, we
> can switch from bare arrays to strvecs. This has a few advantages:
>
>   - push/clear are now one-liners
>
>   - likewise the free+assigns in alias_all_urls() can use
>     strvec_replace()
>
>   - we now use size_t for storage, avoiding possible overflow
>
>   - this will enable some further cleanups in future patches
>
> There's quite a bit of fallout in the code that reads these fields, as
> it tends to access these arrays directly. But it's mostly a mechanical
> replacement of "url_nr" with "url.nr", and "url[i]" with "url.v[i]",
> with a few variations (e.g. "*url" could become "*url.v", but I used
> "url.v[0]" for consistency).
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  builtin/archive.c          |  4 +--
>  builtin/clone.c            |  4 +--
>  builtin/ls-remote.c        |  6 ++--
>  builtin/push.c             | 10 +++----
>  builtin/remote.c           | 56 +++++++++++++++++++-------------------
>  remote-curl.c              |  2 +-
>  remote.c                   | 52 ++++++++++++++---------------------
>  remote.h                   | 12 ++------
>  t/helper/test-bundle-uri.c |  2 +-
>  transport.c                |  4 +--
>  10 files changed, 68 insertions(+), 84 deletions(-)
>
[...]

I really like the simplifications this provides in remote.[hc]; the
rest all looks like straightforward translations.
