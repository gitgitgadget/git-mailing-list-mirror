Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 860B11F87F
	for <e@80x24.org>; Sun, 11 Nov 2018 10:57:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727427AbeKKUpx convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Sun, 11 Nov 2018 15:45:53 -0500
Received: from locusts.copyleft.no ([188.94.218.116]:50248 "EHLO
        mail.mailgateway.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727344AbeKKUpx (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Nov 2018 15:45:53 -0500
X-Greylist: delayed 974 seconds by postgrey-1.27 at vger.kernel.org; Sun, 11 Nov 2018 15:45:52 EST
Received: from mail-qk1-f177.google.com ([209.85.222.177])
        by mail.mailgateway.no with esmtpsa (TLSv1:AES128-SHA:128)
        (Exim 4.72 (FreeBSD))
        (envelope-from <johan@herland.net>)
        id 1gLnBF-0009To-FY
        for git@vger.kernel.org; Sun, 11 Nov 2018 11:41:25 +0100
Received: by mail-qk1-f177.google.com with SMTP id d135so8891587qkc.12
        for <git@vger.kernel.org>; Sun, 11 Nov 2018 02:41:25 -0800 (PST)
X-Gm-Message-State: AGRZ1gK86RqwKKtI9XbJONXpsTC5e6+3M2iWw8xKAeFxQb+UmjCvAaiQ
        Bq7pQsn8hO4Vr2P47mPMrsWKLXXKr1NAwQoMpvI=
X-Google-Smtp-Source: AJdET5fmaWBpWNeIx+5BYAMJljqbTRHg1/I86CJlbujesLIL5DXBTcLDOP1tufTOOnn1zxsetm8RRZnOfCHB4lVdosw=
X-Received: by 2002:a37:8d06:: with SMTP id p6-v6mr14243157qkd.4.1541932879440;
 Sun, 11 Nov 2018 02:41:19 -0800 (PST)
MIME-Version: 1.0
References: <20181111094933.27325-1-carenas@gmail.com>
In-Reply-To: <20181111094933.27325-1-carenas@gmail.com>
From:   Johan Herland <johan@herland.net>
Date:   Sun, 11 Nov 2018 11:41:02 +0100
X-Gmail-Original-Message-ID: <CALKQrgdCNxXSOG-KRUeNaw2q=hOGh9+-zM5ATHwmDEmOC7UAcw@mail.gmail.com>
Message-ID: <CALKQrgdCNxXSOG-KRUeNaw2q=hOGh9+-zM5ATHwmDEmOC7UAcw@mail.gmail.com>
Subject: Re: [PATCH] builtin/notes: remove unnecessary free
To:     carenas@gmail.com
Cc:     Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Nov 11, 2018 at 10:49 AM Carlo Marcelo Arenas Belón
<carenas@gmail.com> wrote:
>
> 511726e4b1 ("builtin/notes: fix premature failure when trying to add
> the empty blob", 2014-11-09) removed the check for !len but left a
> call to free the buffer that will be otherwise NULL
>
> Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>

Signed-off-by: Johan Herland <johan@herland.net>

> ---
>  builtin/notes.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/builtin/notes.c b/builtin/notes.c
> index c05cd004ab..68062f7475 100644
> --- a/builtin/notes.c
> +++ b/builtin/notes.c
> @@ -255,10 +255,8 @@ static int parse_reuse_arg(const struct option *opt, const char *arg, int unset)
>
>         if (get_oid(arg, &object))
>                 die(_("failed to resolve '%s' as a valid ref."), arg);
> -       if (!(buf = read_object_file(&object, &type, &len))) {
> -               free(buf);
> +       if (!(buf = read_object_file(&object, &type, &len)))
>                 die(_("failed to read object '%s'."), arg);
> -       }
>         if (type != OBJ_BLOB) {
>                 free(buf);
>                 die(_("cannot read note data from non-blob object '%s'."), arg);
> --
> 2.19.1.856.g8858448bb
>


-- 
Johan Herland, <johan@herland.net>
www.herland.net
