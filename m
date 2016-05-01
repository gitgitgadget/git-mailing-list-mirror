From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 63/83] builtin/apply: make apply_all_patches() return -1
 on error
Date: Sun, 1 May 2016 17:03:11 -0400
Message-ID: <CAPig+cSVCDNRup95ay=htiXiw0UCGs6boDuqovGnQJY8imbFhQ@mail.gmail.com>
References: <1461504863-15946-1-git-send-email-chriscool@tuxfamily.org>
	<1461504863-15946-64-git-send-email-chriscool@tuxfamily.org>
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
X-From: git-owner@vger.kernel.org Sun May 01 23:03:17 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1awyWK-00022Z-V3
	for gcvg-git-2@plane.gmane.org; Sun, 01 May 2016 23:03:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752384AbcEAVDN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 May 2016 17:03:13 -0400
Received: from mail-ig0-f194.google.com ([209.85.213.194]:33822 "EHLO
	mail-ig0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752293AbcEAVDM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 May 2016 17:03:12 -0400
Received: by mail-ig0-f194.google.com with SMTP id qu10so8773318igc.1
        for <git@vger.kernel.org>; Sun, 01 May 2016 14:03:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=WKX6PbwOePbiTrEjYm1klJT2Tdht8J+zb8kR+eEvGzo=;
        b=dTENmOfLiGbDyBQ2PHiEM9sxZdBrz9OJznR4jGCTYlA2OPtcKVAB7FyalLL3X8U1PN
         8l1ztw4dnIYh+9fWXFseR8Rek/iTUyhKghvRNmPDXRECz6JOP3rTb6nBjEiZfUT4IOoR
         bPxNLiJK7Pe5fGE/UazOL2vWuWRclb2dHjU/PEgqxzclkqeeG3+gZ5G+6dxAapC23SYH
         B0RK00XpWLaKDW3KcjoO9cvES/kzg5YR1bsKYA/W7aP9iLEBUaY11cWCVO1rjrR1LVtc
         Hdw7WsyPbV33BQNwYwvOxFZD6DJbBnraZ49/WYIhZE3705GFue4EQwxgbaCJ0nGVN758
         4uSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=WKX6PbwOePbiTrEjYm1klJT2Tdht8J+zb8kR+eEvGzo=;
        b=e2thCeGWYq09S3QsnvBtif6SbxKyPLLA66RR0sRmfYTAYQ6pOVoB/D4s+hPoxFOvvN
         3pjOOyoG1E0XGnqqDnUwEpa5DlBtUiBsb0XUeIKYdJItOLJ4AmtpxmeppiHkcFCNyDkZ
         SFGmg8EXTM1+DExkXyeXW4zH+dPtkMyDBjxS/DpwqAu0HjXYqW59I+mIKUqEU+AhMWCM
         hkPV/VlLZ3WPVnMyONWuXmUwLqNulJjJ7TymOz8K3lrqSlXJ5M3qFN2vUGRxWT/1n0gH
         oVq7jbVIOTZYzfmXdG2kvB3VWQyNLL0tuqgBFs+1SHqYtWqc20pjpg0kY8vXG+ZU/ldj
         hLuQ==
X-Gm-Message-State: AOPr4FWWmWgX21oXBksbNlaIYtfotxC9Zf3ldKKHqhURNBxrN6ToUTS9vquFmMQjzw4RB22pT3kJHhrSrfXSyQ==
X-Received: by 10.50.6.15 with SMTP id w15mr17151988igw.91.1462136591552; Sun,
 01 May 2016 14:03:11 -0700 (PDT)
Received: by 10.79.139.4 with HTTP; Sun, 1 May 2016 14:03:11 -0700 (PDT)
In-Reply-To: <1461504863-15946-64-git-send-email-chriscool@tuxfamily.org>
X-Google-Sender-Auth: 2ejwEm3FaYB7hjn9wT_qoCyxzAs
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293214>

On Sun, Apr 24, 2016 at 9:34 AM, Christian Couder
<christian.couder@gmail.com> wrote:
> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> ---
> diff --git a/builtin/apply.c b/builtin/apply.c
> @@ -4562,12 +4562,12 @@ static int apply_all_patches(struct apply_state *state,
>
>                 fd = open(arg, O_RDONLY);
>                 if (fd < 0)
> -                       die_errno(_("can't open patch '%s'"), arg);
> +                       return error(_("can't open patch '%s': %s"), arg, strerror(errno));
>                 read_stdin = 0;
>                 set_default_whitespace_mode(state);
>                 res = apply_patch(state, fd, arg, options);
>                 if (res < 0)
> -                       exit(1);
> +                       return -1;

This leaks 'fd', doesn't it?

>                 errs |= res;
>                 close(fd);
>         }
> @@ -4590,10 +4590,10 @@ static int apply_all_patches(struct apply_state *state,
>                                 squelched);
>                 }
>                 if (state->ws_error_action == die_on_ws_error)
> -                       die(Q_("%d line adds whitespace errors.",
> -                              "%d lines add whitespace errors.",
> -                              state->whitespace_error),
> -                           state->whitespace_error);
> +                       return error(Q_("%d line adds whitespace errors.",
> +                                       "%d lines add whitespace errors.",
> +                                       state->whitespace_error),
> +                                    state->whitespace_error);

How does this new 'return' relate to the logic below which updates the
index? Does the index need to be updated here now too?

>                 if (state->applied_after_fixing_ws && state->apply)
>                         warning("%d line%s applied after"
>                                 " fixing whitespace errors.",
> @@ -4608,7 +4608,7 @@ static int apply_all_patches(struct apply_state *state,
>
>         if (state->update_index) {
>                 if (write_locked_index(&the_index, state->lock_file, COMMIT_LOCK))
> -                       die(_("Unable to write new index file"));
> +                       return error(_("Unable to write new index file"));
>         }
>
>         return !!errs;
> @@ -4698,5 +4698,8 @@ int cmd_apply(int argc, const char **argv, const char *prefix)
>         if (check_apply_state(&state, force_apply))
>                 exit(1);
>
> -       return apply_all_patches(&state, argc, argv, options);
> +       if (apply_all_patches(&state, argc, argv, options))
> +               exit(1);
> +
> +       return 0;
>  }
