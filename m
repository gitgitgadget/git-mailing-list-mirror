From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 3/7] clean: read user input with strbuf_getline()
Date: Sun, 28 Feb 2016 01:36:05 -0500
Message-ID: <CAPig+cSkV0KMG7gONabPxgQkzWgPU+1YGTMb4SDmpg1QrHxhSA@mail.gmail.com>
References: <56D28092.9090209@moritzneeb.de>
	<56D28203.7040502@moritzneeb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Moritz Neeb <lists@moritzneeb.de>
X-From: git-owner@vger.kernel.org Sun Feb 28 07:36:13 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZuxg-0007LJ-Pa
	for gcvg-git-2@plane.gmane.org; Sun, 28 Feb 2016 07:36:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751230AbcB1GgI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Feb 2016 01:36:08 -0500
Received: from mail-vk0-f65.google.com ([209.85.213.65]:32952 "EHLO
	mail-vk0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750819AbcB1GgH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Feb 2016 01:36:07 -0500
Received: by mail-vk0-f65.google.com with SMTP id c3so7486947vkb.0
        for <git@vger.kernel.org>; Sat, 27 Feb 2016 22:36:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=EXow/2gxuniBeCzOgdHMC2TryN5whCc18PVUcAnN24U=;
        b=G2cqHrMz/QfB4Ly2t9fQN89fN7f/vOepz/Oh6fsMkHZR1CWJo1biJOpPBUJzEnCqYd
         4zdsGQNpOizIzWiva/uZJU8flbKGiijWZoh8vzHM1MUuBEFljx/ntUPHPtPgVdhC5EdK
         ByC+D6nLL5baPts6JuzAjahF3JUOT2CXo1clt968fNsj24h8OC426k1aTWnPP4Nsux5D
         bNKPbEsTbtiVSBLqmTo2c7woo1W9wV+fFyvsbp3/MsKvdA1KmpwECMtoKMO8jh2d9Ur3
         w2yFEzYo1xtYEotYp34h2Ol+WHF3Bqj3Mn0qlD+r2XQwxg7weAI6kru+iDxsYdmGb2V5
         2rnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=EXow/2gxuniBeCzOgdHMC2TryN5whCc18PVUcAnN24U=;
        b=BHGCEY6swQHf4C9qIQjnLsjIpfWL73JBqO8dIp9s0uKo2Gxtj2xkV6vRcsmaU9XwjV
         Gsrq/sh3K+Ftxl3hHYtQwRe9n8jnSGUrcQaXZRm0jC8x6mR+9xfBmc5gv9XVCxuZVR4s
         OBpn4NaDa+V2eayxl8fYFFuYcpBzJleyXxTTozfa9KZBUToQ+zx73rOr1j4HskA2Cl6y
         G5S/G0pa1J3uBewZBbuhyxajAtu2gqtr2s/2Cr5XlNsGKf44N7JKOGv7+5vS6Uyd0QSz
         dPB6hs17ZQi1De7M70p+07d2G/62/BwZRZ6VXmL3vslKsBV/a12Fnxn3YThrMdVuAtop
         VqbQ==
X-Gm-Message-State: AD7BkJKMgIfBGGZCAp1cU3QMQai/7ICif6dQ9fW2RgSet5CrLgJzlJatqrbV6oQ2GUH+VNBERA5ABfALQa8mHw==
X-Received: by 10.31.141.2 with SMTP id p2mr7133475vkd.37.1456641365800; Sat,
 27 Feb 2016 22:36:05 -0800 (PST)
Received: by 10.31.62.203 with HTTP; Sat, 27 Feb 2016 22:36:05 -0800 (PST)
In-Reply-To: <56D28203.7040502@moritzneeb.de>
X-Google-Sender-Auth: Y2AJ-4_VBr1O0MGkGuBcJPDhHPk
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287753>

On Sun, Feb 28, 2016 at 12:13 AM, Moritz Neeb <lists@moritzneeb.de> wrote:
> The inputs that are read are all answers that are given by the user
> when interacting with git on the commandline. As these answers are
> not supposed to contain a meaningful CR it is safe to
> replace strbuf_getline_lf() can be replaced by strbuf_getline().

Grammo: "it is safe to replace ... can be replaced by ..."

> In the subsequent codepath, the input is trimmed. This leads to

How about?

    After being read, the input is trimmed.

> accepting user input with spaces, e.g. "  y ", as a valid answer in
> the interactive cleaning process.
>
> Although trimming would not be required anymore to remove a potential CR,
> we don't want to change the existing behavior with this patch.
> Thus, the trimming is kept in place.
>
> Signed-off-by: Moritz Neeb <lists@moritzneeb.de>
> ---
> diff --git a/builtin/clean.c b/builtin/clean.c
> @@ -570,7 +570,7 @@ static int *list_and_choose(struct menu_opts *opts, struct menu_stuff *stuff)
>                                clean_get_color(CLEAN_COLOR_RESET));
>                 }
>
> -               if (strbuf_getline_lf(&choice, stdin) != EOF) {
> +               if (strbuf_getline(&choice, stdin) != EOF) {
>                         strbuf_trim(&choice);
>                 } else {
>                         eof = 1;
> @@ -652,7 +652,7 @@ static int filter_by_patterns_cmd(void)
>                 clean_print_color(CLEAN_COLOR_PROMPT);
>                 printf(_("Input ignore patterns>> "));
>                 clean_print_color(CLEAN_COLOR_RESET);
> -               if (strbuf_getline_lf(&confirm, stdin) != EOF)
> +               if (strbuf_getline(&confirm, stdin) != EOF)
>                         strbuf_trim(&confirm);
>                 else
>                         putchar('\n');
> @@ -750,7 +750,7 @@ static int ask_each_cmd(void)
>                         qname = quote_path_relative(item->string, NULL, &buf);
>                         /* TRANSLATORS: Make sure to keep [y/N] as is */
>                         printf(_("Remove %s [y/N]? "), qname);
> -                       if (strbuf_getline_lf(&confirm, stdin) != EOF) {
> +                       if (strbuf_getline(&confirm, stdin) != EOF) {
>                                 strbuf_trim(&confirm);
>                         } else {
>                                 putchar('\n');
> --
> 2.4.3
