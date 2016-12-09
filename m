Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A58861FC96
	for <e@80x24.org>; Fri,  9 Dec 2016 12:34:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933337AbcLIMeL (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Dec 2016 07:34:11 -0500
Received: from mail-io0-f193.google.com ([209.85.223.193]:34509 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752375AbcLIMeK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Dec 2016 07:34:10 -0500
Received: by mail-io0-f193.google.com with SMTP id y124so6508051iof.1
        for <git@vger.kernel.org>; Fri, 09 Dec 2016 04:34:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=WUtEgLJfvJ89EIO21053XU055q5tDzIUVwT6FFtQcwg=;
        b=flugZKT2EsReD/HWfxhWDfahg2r7eq1Xj2IuFj9H/z8L7Pua0361GbV/P0MYNSnzkP
         rkXCUiJrbUKV90X5zaSovcOJlbsozEePb0t4aHHkYrdUhwjUoPuWevYKFln/6gGbrzi5
         EcTWXa17vQQolSXk4KjyLJKY4oKugm0+lOzPW4HNMIZ7nqyxu5cbDjwjuOOEV9N/wm4y
         97FFBT1IN1IQ0H1Tbk12h7fw1LQ3cs/NYSD+62nhRNrBfLnOy2oY1+bxA9ExjWd34O5m
         qevyWCSo4eP4UPjipkZEkP7vXPE9OIbAfpELIF1GtdO0IthQeqkM1OtkyjOE21dyvyyx
         uMog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=WUtEgLJfvJ89EIO21053XU055q5tDzIUVwT6FFtQcwg=;
        b=ledVp1kDlgSmDOPgGoncAFd62oCnWdFLEPSc2mM57DxZIJm4VGFx2Nr7ZlxSrXBtx0
         Hs/0H9bdSPmeL70jhlyxzlFIKyuk8TVcZWpeIHWO6abceVIWcMUEsLONYCp5BdWVy1WH
         1GVkX3I0AvJVBTszfCkaQGHY4+M/6qbon0dq1pdf6AiS5Q+Tiv1b8AuM/tkBOO0yk2j2
         B6MlviO88xc6XdckCmmTSfwlD0MmGSfnOi9UAo3VLoJccigpsaU0IfDtk/3N7G/WJ+fz
         j0tCUAOxk28KOVvLy7P/g5NBDDL9Iebnj/18fJR3FN1oU/iWV+XckhK52av4eg+rRNB6
         GA4Q==
X-Gm-Message-State: AKaTC03ZNWhkoo2MpTJ/zz82c91IAWbAGCGbQUG0DwBfBBU626bGjQ9kYkPC0KNIo4jcjzHfKOMuron8PIP4dw==
X-Received: by 10.36.34.196 with SMTP id o187mr6318169ito.3.1481286844952;
 Fri, 09 Dec 2016 04:34:04 -0800 (PST)
MIME-Version: 1.0
Received: by 10.64.69.3 with HTTP; Fri, 9 Dec 2016 04:33:34 -0800 (PST)
In-Reply-To: <1481241494-6861-1-git-send-email-bmwill@google.com>
References: <1480964316-99305-1-git-send-email-bmwill@google.com> <1481241494-6861-1-git-send-email-bmwill@google.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Fri, 9 Dec 2016 19:33:34 +0700
Message-ID: <CACsJy8A2M_G34MeHh6vGsrf5ePOOduM6u=n17_EZLtu31uDAYg@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] road to reentrant real_path
To:     Brandon Williams <bmwill@google.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
        Jacob Keller <jacob.keller@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
        Johannes Sixt <j6t@kdbg.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 9, 2016 at 6:58 AM, Brandon Williams <bmwill@google.com> wrote:
> diff --git a/setup.c b/setup.c
> index fe572b8..0d9fdd0 100644
> --- a/setup.c
> +++ b/setup.c
> @@ -254,10 +254,12 @@ int get_common_dir_noenv(struct strbuf *sb, const char *gitdir)
>                 if (!is_absolute_path(data.buf))
>                         strbuf_addf(&path, "%s/", gitdir);
>                 strbuf_addbuf(&path, &data);
> -               strbuf_addstr(sb, real_path(path.buf));
> +               strbuf_realpath(sb, path.buf, 1);

This is not the same because of this hunk in strbuf_realpath()

> @@ -81,17 +73,18 @@ static const char *real_path_internal(const char *path, int die_on_error)
>                         goto error_out;
>         }
>
> -       strbuf_reset(&resolved);
> +       strbuf_reset(resolved);
>
>         if (is_absolute_path(path)) {

But if you you remove that, then all (old) callers of
strbuf_realpath() must do a strbuf_reset() in advance if needed
(probably just real_path does) which sounds reasonable to me. You're
probably want to be careful about the strbuf_reset() at the end of the
function too.

Other than that, I think this diff looks nice.
-- 
Duy
