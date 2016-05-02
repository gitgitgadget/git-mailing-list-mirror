From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 74/83] builtin/apply: make try_create_file() return -1 on error
Date: Mon, 2 May 2016 14:01:13 -0400
Message-ID: <CAPig+cQsS7x2qb8SphaAgdfpCLBQ-z=joL3w8RZH0HC9xRG54g@mail.gmail.com>
References: <1461504863-15946-1-git-send-email-chriscool@tuxfamily.org>
	<1461504863-15946-75-git-send-email-chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
	Karsten Blees <karsten.blees@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Christian Couder <chriscool@tuxfamily.org>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 02 20:01:19 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axI9m-0001Ds-Bx
	for gcvg-git-2@plane.gmane.org; Mon, 02 May 2016 20:01:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754748AbcEBSBO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 May 2016 14:01:14 -0400
Received: from mail-ig0-f193.google.com ([209.85.213.193]:35826 "EHLO
	mail-ig0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754672AbcEBSBO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 May 2016 14:01:14 -0400
Received: by mail-ig0-f193.google.com with SMTP id fn8so10930272igb.2
        for <git@vger.kernel.org>; Mon, 02 May 2016 11:01:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=BFwRXK/69GMSXt4pXxBlRhDfSdT6BrZ6AORbvR11uZo=;
        b=epS97mf6kAN7qny0Ph2X/74u4cUTXxaiHvYSIpbLZou8j3+U7iWI+QxO6tJqxfbX0T
         RaNxkGjrIL3svSc3LLmNvjnef8klQaYzdUCbDfuQgg3yI4fixB09rhs7/MNz7PevoSOH
         X0fkEi6t5nmbGfmWth+4JZf2j5WKT/XHAHvWLA9UkS3yptAfReOdEjJhe3t6s4DEZrjY
         OEbgnfERIvYmrnILKapPQiKwT6VhYHOR+reYC81gTVUZXeHrnL0ZcZoifUd1b+a0CuK8
         hi+RmDx4lWUb4sSIbq9YUGYbQR66hjWsxWTUhOHT1O2BsR4Rx6XwW14nzX/0Y+eJdF48
         K/sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=BFwRXK/69GMSXt4pXxBlRhDfSdT6BrZ6AORbvR11uZo=;
        b=T0/TLax1sl3kk+58W558+7zG0EIdSR54S5E8rvTjLZrrOv3ImK+3zqyHi208Xld4Bm
         irgWt1ypZEngBvIPHlZgPeOTCTdeCk1/M6yr4oki6QSCPqtzow9NTu7ZW8RXWEJdxxWq
         C53Qba7Wxp7RHTCz4OHBfET4gq9UFjtYSlgAGA1xYx8d8KQ8bhVEcnByjTHBUrJ7R7Qd
         eYTpTjkIKCAsxvlP+z4cZCIJnn74CT3HlqoYH/WELgVREL5PauOD6mb3MHZ21pK10m11
         ihCQ6lhKps75sHzpkiq3kCpJz5gqoIappRGy4HRx/Hd+WBA6j7FbQGN6sr3GWrkFhYsI
         L5VA==
X-Gm-Message-State: AOPr4FWx7lpEJOxfnOybe3giUNlA3ofT6e0R05GbEXlPrvXSEuDWhrYhIle4Of2AUhyRSPRjde/urZWcP2Cmng==
X-Received: by 10.50.3.105 with SMTP id b9mr19067902igb.17.1462212073124; Mon,
 02 May 2016 11:01:13 -0700 (PDT)
Received: by 10.79.139.4 with HTTP; Mon, 2 May 2016 11:01:13 -0700 (PDT)
In-Reply-To: <1461504863-15946-75-git-send-email-chriscool@tuxfamily.org>
X-Google-Sender-Auth: szkJYfh3TCbPr4qdt0Ptl-5_8no
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293253>

On Sun, Apr 24, 2016 at 9:34 AM, Christian Couder
<christian.couder@gmail.com> wrote:
> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> ---
> diff --git a/builtin/apply.c b/builtin/apply.c
> @@ -4145,28 +4151,32 @@ static int try_create_file(const char *path, unsigned int mode, const char *buf,
>         fd = open(path, O_CREAT | O_EXCL | O_WRONLY, (mode & 0100) ? 0777 : 0666);
>         if (fd < 0)
> -               return -1;
> +               return 1;
>
>         if (convert_to_working_tree(path, buf, size, &nbuf)) {
>                 size = nbuf.len;
>                 buf  = nbuf.buf;
>         }
> -       write_or_die(fd, buf, size);
> +
> +       if (!write_or_whine_pipe(fd, buf, size, path)) {
> +               strbuf_release(&nbuf);
> +               return -1;

This is leaking 'fd'.

> +       }
>         strbuf_release(&nbuf);
>
>         if (close(fd) < 0)
> -               die_errno(_("closing file '%s'"), path);
> +               return error(_("closing file '%s': %s"), path, strerror(errno));
>         return 0;
>  }
>
> @@ -4208,12 +4227,15 @@ static void create_one_file(struct apply_state *state,
>                 for (;;) {
>                         char newpath[PATH_MAX];
>                         mksnpath(newpath, sizeof(newpath), "%s~%u", path, nr);
> -                       if (!try_create_file(newpath, mode, buf, size)) {
> +                       res = try_create_file(newpath, mode, buf, size);
> +                       if (!res) {
>                                 if (!rename(newpath, path))
>                                         return;
>                                 unlink_or_warn(newpath);
>                                 break;
>                         }
> +                       if (res < 0)
> +                               exit(1);

Two issues:

Getting the error case out of the way early (moving this 'if' just
after 'res=...') would make it easier to reason about the remaining
logic.

It's already difficult to understand what the below 'errno' check is
testing. try_create_file(), rename(), or unlink_or_warn()? Plopping
this new error handling conditional in front of it divorces the
'errno' check even further from whatever it is testing.

>                         if (errno != EEXIST)
>                                 break;
>                         ++nr;
