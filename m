From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3] write_pack_file: use correct variable in diagnostic
Date: Sun, 2 Mar 2014 13:42:21 -0500
Message-ID: <CAPig+cSuBfuzL-NXYkvFoz5+jPrEUNfTqoMf-iAYyMSv3jDsqg@mail.gmail.com>
References: <1393745411-30980-1-git-send-email-sunheehnus@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>
To: Sun He <sunheehnus@gmail.com>, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 02 19:42:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WKBLH-0004Sg-2K
	for gcvg-git-2@plane.gmane.org; Sun, 02 Mar 2014 19:42:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753025AbaCBSmW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Mar 2014 13:42:22 -0500
Received: from mail-yk0-f172.google.com ([209.85.160.172]:39591 "EHLO
	mail-yk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752512AbaCBSmW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Mar 2014 13:42:22 -0500
Received: by mail-yk0-f172.google.com with SMTP id 200so8170533ykr.3
        for <git@vger.kernel.org>; Sun, 02 Mar 2014 10:42:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=IoFBU17gjAuEW5foipBqohqph1X3Gp3XRLZJih6dB0A=;
        b=LWxdBjOR3B+EJHxOfF4B9MNBUOdgiXHg+/CUNkNAka5rl/ZEtrj2dFjlMRi9xvcEXp
         jZYUtegx2im5Q6XKwS+ZeyST2Z5fjbCtFBtAa9XwfYZH1HQd3yGSOmlPoNNQQPYB/xdw
         wqi07mWLRU3rduxefFdrMb7owuPQoxssaUTarIomp3NHFnRBgWXt1QCsScFQIeSvJf7m
         pZTotkwn9zLJXsDEnUL5Sly0kXlgzyk2YrZ6E5dkXm2aDYz2cxOwhsG0UE1tXXo+wC0Z
         LjTp0QAK+p2VtSYQLHqUxFd0TVYsRZ+rOHSsePDF7WdJ9orjC7cWEFYuRMTRS7m3FkYs
         mNEw==
X-Received: by 10.236.8.68 with SMTP id 44mr16282588yhq.39.1393785741236; Sun,
 02 Mar 2014 10:42:21 -0800 (PST)
Received: by 10.170.180.195 with HTTP; Sun, 2 Mar 2014 10:42:21 -0800 (PST)
In-Reply-To: <1393745411-30980-1-git-send-email-sunheehnus@gmail.com>
X-Google-Sender-Auth: oUwGx0Oh56Vd9Xah7Url9H2jV9Q
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243154>

On Sun, Mar 2, 2014 at 2:30 AM, Sun He <sunheehnus@gmail.com> wrote:
> 'pack_tmp_name' is the subject of the utime() check, so report it in the
> warning, not the uninitialized 'tmpname'
>
> Signed-off-by: Sun He <sunheehnus@gmail.com>
> ---
>
>  Changing the subject and adding valid information as tutored by
>  Eric Sunshine.
>  Thanks to him.
>
>  builtin/pack-objects.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
> index c733379..4922ce5 100644
> --- a/builtin/pack-objects.c
> +++ b/builtin/pack-objects.c
> @@ -823,7 +823,7 @@ static void write_pack_file(void)
>                                 utb.modtime = --last_mtime;
>                                 if (utime(pack_tmp_name, &utb) < 0)
>                                         warning("failed utime() on %s: %s",
> -                                               tmpname, strerror(errno));
> +                                               pack_tmp_name, strerror(errno));
>                         }
>
>                         /* Enough space for "-<sha-1>.pack"? */
> --
> 1.9.0.138.g2de3478.dirty

Nicely done. Everything is where it ought to be.

As this is an actual bug fix (not just a GSoC microproject):

Reviewed-by: Eric Sunshine <sunshine@sunshineco.com>
