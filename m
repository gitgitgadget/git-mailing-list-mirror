From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 73/83] builtin/apply: make write_out_results() return -1
 on error
Date: Mon, 2 May 2016 13:42:55 -0400
Message-ID: <CAPig+cTpTYowkeO-cDd-87aAw_tRHvdhV4BaBveg25MvsDAd4w@mail.gmail.com>
References: <1461504863-15946-1-git-send-email-chriscool@tuxfamily.org>
	<1461504863-15946-74-git-send-email-chriscool@tuxfamily.org>
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
X-From: git-owner@vger.kernel.org Mon May 02 19:43:04 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axHs5-0001Ib-G5
	for gcvg-git-2@plane.gmane.org; Mon, 02 May 2016 19:43:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754681AbcEBRm6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 May 2016 13:42:58 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:36501 "EHLO
	mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754224AbcEBRm4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 May 2016 13:42:56 -0400
Received: by mail-io0-f194.google.com with SMTP id k129so23207625iof.3
        for <git@vger.kernel.org>; Mon, 02 May 2016 10:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=EIOT9t+89CUS175s6DYoLkkpd9IU+hu4LTgQPBuM3dI=;
        b=arRtnCdwwYFt6RnM75hjiACv9Mnx3hO4bYhq8/egSVTB7P3PZ5NF55On1Wpd/sCtku
         Aryd9AePvWixX31nDTfm/fp5EyKtx37qxFB/bD02PhCZr90LlAkciI0r2ydgEuso9gh+
         pkDZGvCL2ClkLo6qku3KZnDMdZWzZGbHEri6lz8t2ekkf5an5N3C6sTBKeimgzVl6i09
         rbjH++dQe5QEvBQky1nD8solcuT3O/om5QaODNmlAYbEJXcU8/DK77Wri877P9nha51m
         +2ydG+xsEaMQrOkxlEsJ7DtvrDP+RacMknyCFeLaN2z1AJ2Wu6e9mwWkaun0We0KiCIV
         k0aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=EIOT9t+89CUS175s6DYoLkkpd9IU+hu4LTgQPBuM3dI=;
        b=c9vpCrxurugq5MSp8Da4IjXtlWbVwt7e63VBJ+ENRpdEXS6Dls4orPK7/LBImh4nQt
         pdU6Dbqu5LTFOAKM8SaxIgFxP7BaDTovrGvrkEpmgLnDR8PmkDDUCRqPunCuwTRiZufv
         ANJAoetj0rEcw00pDm9USCG9fBdUnoz67jk3i3ffKrdhpXXkIKz66XukdojZjOkCA9N2
         dYwzApIsKSOOQFAKZCvwi9RLvKIi6S8Rv4qnz2ySqjLiv2xeTkeyZQXVWGdNPhjqnkYF
         pbfcOYa/WtBsr0RB/Jex+fMn7xI9tBKvQp3a6KvBU/+QtcwLJNK9QsNoQVNClK2H6idJ
         bppA==
X-Gm-Message-State: AOPr4FWsiYyhY9ixnJ5Vkzx2QbhadH95vLWMWxQNAzxGHCp26mYe8Uvkau6+r40cLUl+fsYcfsp5FW35fbIxyQ==
X-Received: by 10.107.9.102 with SMTP id j99mr41583871ioi.104.1462210975957;
 Mon, 02 May 2016 10:42:55 -0700 (PDT)
Received: by 10.79.139.4 with HTTP; Mon, 2 May 2016 10:42:55 -0700 (PDT)
In-Reply-To: <1461504863-15946-74-git-send-email-chriscool@tuxfamily.org>
X-Google-Sender-Auth: KBpXeAGMgpdlBTMJ9Ij761eWpDo
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293247>

On Sun, Apr 24, 2016 at 9:34 AM, Christian Couder
<christian.couder@gmail.com> wrote:
> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> ---
> diff --git a/builtin/apply.c b/builtin/apply.c
> @@ -4381,7 +4387,7 @@ static int write_out_results(struct apply_state *state, struct patch *list)
>                                 errs = 1;
>                         else {
>                                 if (write_out_one_result(state, l, phase))
> -                                       exit(1);
> +                                       return -1;

Isn't this leaking 'string_list cpath'?

>                                 if (phase == 1) {
>                                         if (write_out_one_reject(state, l))
>                                                 errs = 1;
> @@ -4484,11 +4490,16 @@ static int apply_patch(struct apply_state *state,
>             !state->apply_with_reject)
>                 return -1;
>
> -       if (state->apply && write_out_results(state, list)) {
> -               if (state->apply_with_reject)
> +       if (state->apply) {
> +               int res = write_out_results(state, list);
> +               if (res < 0)
>                         return -1;

Mentioned previously: Leaking 'list', 'buf', 'fn_table'.

> -               /* with --3way, we still need to write the index out */
> -               return 1;
> +               if (res > 0) {
> +                       if (state->apply_with_reject)
> +                               return -1;
> +                       /* with --3way, we still need to write the index out */
> +                       return 1;

Not the fault of this patch, but this 'return' in the original code
was also leaking 'list', 'buf', 'fn_table', right?

> +               }
>         }
>
>         if (state->fake_ancestor &&
