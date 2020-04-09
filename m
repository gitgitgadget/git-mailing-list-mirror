Return-Path: <SRS0=Te6D=5Z=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DFDEC2BA2B
	for <git@archiver.kernel.org>; Thu,  9 Apr 2020 10:57:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00D7520A8B
	for <git@archiver.kernel.org>; Thu,  9 Apr 2020 10:57:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HCZZkVfL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726523AbgDIK5R (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Apr 2020 06:57:17 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:39022 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725970AbgDIK5R (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Apr 2020 06:57:17 -0400
Received: by mail-vs1-f66.google.com with SMTP id u9so6656123vsp.6
        for <git@vger.kernel.org>; Thu, 09 Apr 2020 03:57:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vSqhxmg4lKyGSvVJaKSF8rtnsBudSdpiP++ZL8KpGuw=;
        b=HCZZkVfL0aO2PE+YitHYCYJN+pmvju2VFf/6wH6tR4YQOz8Ltra5s3pukObQvF0DPU
         NokPTB+wUoEF4yJOFQdS3180Qw81SOh8NgCFLZdRcpo9lRf7CZDj3PgPlwf+8x4mqBaX
         JaTwHxZZtD3zGbj5S2vLNk5bgVpfJ3w1W+cO1m+tbaPlbxo3KD/SjiyhuRdr5SZW5R4X
         qB/XSXvN/CwHSF/HCll9mWSQkDe11y7uW97ftZ30yvKHK4cB5fdo+8XiaWjUeZlepOsu
         JVZlPjpKfNtUSLGEJApmZQrEQXUndepumVjjSdQbfZvb1R7i2sfCakDrqWCk6vX7ZN8i
         NO9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vSqhxmg4lKyGSvVJaKSF8rtnsBudSdpiP++ZL8KpGuw=;
        b=KMO4oSw22qrKjSd4c8nnHDLysAABh3z7epj8ooBig42kewqS0RMH2hImdOLlkc9v4F
         qLpGw2vvtd8Zsj8e8VOEvQAlkuBq8D8uoXqAqN29bkDopcaT6d/Ho5RsYPMA6AnlVRT6
         2QV7FH0wlZbERQus+C2pnQuq+5TbqTUti9vNNnptseWnTQEoXbb8q/ac0HOez5FeTg1A
         kNc/piMNXMoIa7mkp+BCNXb4yoUM8NCeA+SI51+O8oLCI6CYtfTM+kKuhuoiEcHABzFq
         4oH/dsDg6sTFQpw9NvCIGXgTr/VanIA6zqVigfJvwqp3gFVIY5TXcCbpq97qvRO/tYFc
         e5jw==
X-Gm-Message-State: AGi0PuZcxg/om9lhe2LA22dHT+nYtk+TQDYtZz0nuSlwxzgiyT++Cpj/
        T3WvhnJOnD57mrHTI9e9mZw6bRjXk+vcGqNS7cTPMyfX
X-Google-Smtp-Source: APiQypL/59GKdP8BNmFdy5w32iFbXGOV+Ff+FIiCqyBsM6zSJT/vlDkgW9xroLxZHA8CU7ZO/3cWKltRouyZ+XT2ih8=
X-Received: by 2002:a67:3201:: with SMTP id y1mr10019319vsy.54.1586429836371;
 Thu, 09 Apr 2020 03:57:16 -0700 (PDT)
MIME-Version: 1.0
References: <pull.756.git.git.1586427853403.gitgitgadget@gmail.com>
In-Reply-To: <pull.756.git.git.1586427853403.gitgitgadget@gmail.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Thu, 9 Apr 2020 12:57:03 +0200
Message-ID: <CAN0heSrvZb3z3JdYSXs4Dy4nBwPYBAQZ5Zf2f9RSeUnyQSLeeg@mail.gmail.com>
Subject: Re: [PATCH] mingw: cope with the Isilon network file system
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Nathan Sanders <spekbukkem@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, 9 Apr 2020 at 12:26, Johannes Schindelin via GitGitGadget
<gitgitgadget@gmail.com> wrote:

>         handle = CreateFileW(wfilename, FILE_APPEND_DATA,
>                         FILE_SHARE_WRITE | FILE_SHARE_READ,
>                         NULL, create, FILE_ATTRIBUTE_NORMAL, NULL);
> -       if (handle == INVALID_HANDLE_VALUE)
> -               return errno = err_win_to_posix(GetLastError()), -1;

(This code, which is being removed, used "," to avoid having to introduce
braces. There's another instance of this pattern a bit above.)

> +       if (handle == INVALID_HANDLE_VALUE) {

(Adding a brace here.)

> +               DWORD err = GetLastError();
> +               /*
> +                * Some network storage solutions (e.g. Isilon) might return
> +                * ERROR_INVALID_PARAMETER instead of expected error
> +                * ERROR_PATH_NOT_FOUND, which results in a unknow error. If

s/ a / an /
s/unknow/&n/

> +                * so, the error is now forced to be an ERROR_PATH_NOT_FOUND
> +                * error instead.
> +                */

"is now forced" sounds more like it describes this change/commit, rather
than this piece of code. Maybe this final sentence can be scrapped
entirely, since the forcing/translating/mapping is obvious from the code
anyway? The remainder of the comment goes into *why* and looks more
useful. Just my 2 cents.

> +               if (err == ERROR_INVALID_PARAMETER)
> +                       err = ERROR_PATH_NOT_FOUND;
> +               return errno = err_win_to_posix(err), -1;
> +       }

Now there's no need to avoid introducing braces, so maybe split this
into two lines for a lower huh-factor?

  errno = err_win_to_posix(err);
  return -1;

Martin
