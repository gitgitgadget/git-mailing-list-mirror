Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5041B20281
	for <e@80x24.org>; Thu, 29 Jun 2017 17:43:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752673AbdF2RnN (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Jun 2017 13:43:13 -0400
Received: from mail-pg0-f47.google.com ([74.125.83.47]:35187 "EHLO
        mail-pg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752343AbdF2RnL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Jun 2017 13:43:11 -0400
Received: by mail-pg0-f47.google.com with SMTP id j186so51228699pge.2
        for <git@vger.kernel.org>; Thu, 29 Jun 2017 10:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=DOdahiq1U71QlNlfpw0xU/aLVWVwtOqprdVFtgWUf3M=;
        b=T169sHh+lrLNWCJDCsYL5MXjZtoCT30X39MwyEijGQzPewWbw3CHMY21fO3G/mUhPF
         CI3XSUJygpadnOVQ7unS8jyZoZrMkxI2/juh/WsDSJixGSwfb8W+W+TVj8W9Th8sOpH/
         1D3g/c+c6rlllwScRLaPR0lD0aIYzhQiPnop8DVHytizEBv3JE8JaeZSp0OeO5xiQ4Wv
         VWG05QZ/Cjl1p9UHPHzndQDcp3elxf55bpqF2gpmx8RMG0fG3MOg2YPiHvpIpIdbPtyP
         ukoRSJaMCPqYu5LlhJvYtkJBNSX5ikzNBv/ErKk3dhegBxt7OuMoVQOJIAZHpLf7bkQ7
         rECA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=DOdahiq1U71QlNlfpw0xU/aLVWVwtOqprdVFtgWUf3M=;
        b=CjP+5vje0DNU9qq2bWaVuGvXR5Ve6Fz5Pc6/10BqCXkEQJQuRKdF8fzBeNrXdw0N0m
         SjDx+UwsB3YVi8eHyVYY0CSWyJiEQqj/ESXqwEkMJ659x11nUnOBMVuUQl1BQwsQrZpg
         ShQ+Z4wPf1Y6zFJ67DckmPenHw0/+hIKboBDvSQicnW2UTwUAPc5qdvxo2jETfNDZFgK
         IIQD88EjtWwylTUu3qI+CI7OG9p+LW5K9T+zcYdBfWGmf4pHlqxl9LxwzFImSjovs+1n
         Y3qXGB2YzCVqHp0UU667U8QAea603QDwGu6FleOsNjmWdvlhtFRPOTVCHBxVpG7GLrc6
         MYEA==
X-Gm-Message-State: AKS2vOxHafxvbxFoH8J2uIPBrY3peT2phtan4tL5cuxALReCTDAE4BRh
        eFTWDaQzesN7KpwFY3Z6ubMVeTcym0oJ
X-Received: by 10.84.232.205 with SMTP id x13mr19726079plm.245.1498758190504;
 Thu, 29 Jun 2017 10:43:10 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.183.170 with HTTP; Thu, 29 Jun 2017 10:43:09 -0700 (PDT)
In-Reply-To: <20170628215809.23060-6-avarab@gmail.com>
References: <CACBZZX6Hp4Q4TOj_X1fbdCA4twoXF5JemZ5ZbEn7wmkA=1KO2g@mail.gmail.com>
 <20170628215809.23060-1-avarab@gmail.com> <20170628215809.23060-6-avarab@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 29 Jun 2017 10:43:09 -0700
Message-ID: <CAGZ79kbOpMpi0Dv6=ViW45gq5E9KHgpz4GE4o8XA-KMaiR78Vw@mail.gmail.com>
Subject: Re: [PATCH 5/5] grep: remove regflags from the public grep_opt API
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, J Smith <dark.panda@gmail.com>,
        Joe Ratterman <jratt0@gmail.com>,
        Fredrik Kuivinen <frekui@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 28, 2017 at 2:58 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> Refactor calls to the grep machinery to always pass opt.ignore_case &
> opt.extended_regexp_option instead of setting the equivalent regflags
> bits.
>
> The bug fixed when making -i work with -P in commit 9e3cbc59d5 ("log:
> make --regexp-ignore-case work with --perl-regexp", 2017-05-20) was
> really just plastering over the code smell which this change fixes.
>
> See my "Re: [PATCH v3 05/30] log: make --regexp-ignore-case work with
> --perl-regexp"[1] for the discussion leading up to this.
>
> The reason for adding the extensive commentary here is that I
> discovered some subtle complexity in implementing this that really
> should be called out explicitly to future readers.
>
> Before this change we'd rely on the difference between
> `extended_regexp_option` and `regflags` to serve as a membrane between
> our preliminary parsing of grep.extendedRegexp and grep.patternType,
> and what we decided to do internally.
>
> Now that those two are the same thing, it's necessary to unset
> `extended_regexp_option` just before we commit in cases where both of
> those config variables are set. See 84befcd0a4 ("grep: add a
> grep.patternType configuration setting", 2012-08-03) for the code and
> documentation related to that.
>
> The explanation of why the if/else branches in
> grep_commit_pattern_type() are ordered the way they are exists in that
> commit message, but I think it's worth calling this subtlety out
> explicitly with a comment for future readers.

Up to here the commit message is inspiring confidence.

>
> Unrelated to that: I could have factored out the default REG_NEWLINE
> flag into some custom GIT_GREP_H_DEFAULT_REGFLAGS or something, but
> since it's just used in two places I didn't think it was worth the
> effort.
>
> As an aside we're really lacking test coverage regflags being
> initiated as 0 instead of as REG_NEWLINE. Tests will fail if it's
> removed from compile_regexp(), but not if it's removed from
> compile_fixed_regexp(). I have not dug to see if it's actually needed
> in the latter case or if the test coverage is lacking.

This sounds as if extra careful review is needed.


>
> 1. <CACBZZX6Hp4Q4TOj_X1fbdCA4twoXF5JemZ5ZbEn7wmkA=3D1KO2g@mail.gmail.com>
>    (https://public-inbox.org/git/CACBZZX6Hp4Q4TOj_X1fbdCA4twoXF5JemZ5ZbEn=
7wmkA=3D1KO2g@mail.gmail.com/)
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> ---
>  builtin/grep.c |  2 --
>  grep.c         | 43 ++++++++++++++++++++++++++++++++++---------
>  grep.h         |  1 -
>  revision.c     |  2 --
>  4 files changed, 34 insertions(+), 14 deletions(-)
>
> diff --git a/builtin/grep.c b/builtin/grep.c
> index f61a9d938b..b682966439 100644
> --- a/builtin/grep.c
> +++ b/builtin/grep.c
> @@ -1169,8 +1169,6 @@ int cmd_grep(int argc, const char **argv, const cha=
r *prefix)
>
>         if (!opt.pattern_list)
>                 die(_("no pattern given."));
> -       if (!opt.fixed && opt.ignore_case)
> -               opt.regflags |=3D REG_ICASE;
>
>         /*
>          * We have to find "--" in a separate pass, because its presence
> diff --git a/grep.c b/grep.c
> index 736e1e00d6..51aaad9f03 100644
> --- a/grep.c
> +++ b/grep.c
> @@ -35,7 +35,6 @@ void init_grep_defaults(void)
>         memset(opt, 0, sizeof(*opt));
>         opt->relative =3D 1;
>         opt->pathname =3D 1;
> -       opt->regflags =3D REG_NEWLINE;
>         opt->max_depth =3D -1;
>         opt->pattern_type_option =3D GREP_PATTERN_TYPE_UNSPECIFIED;
>         color_set(opt->color_context, "");
> @@ -154,7 +153,6 @@ void grep_init(struct grep_opt *opt, const char *pref=
ix)
>         opt->linenum =3D def->linenum;
>         opt->max_depth =3D def->max_depth;
>         opt->pathname =3D def->pathname;
> -       opt->regflags =3D def->regflags;
>         opt->relative =3D def->relative;
>         opt->output =3D def->output;
>
> @@ -170,6 +168,24 @@ void grep_init(struct grep_opt *opt, const char *pre=
fix)
>
>  static void grep_set_pattern_type_option(enum grep_pattern_type pattern_=
type, struct grep_opt *opt)
>  {
> +       /*
> +        * When committing to the pattern type by setting the relevant
> +        * fields in grep_opt it's generally not necessary to zero out
> +        * the fields we're not choosing, since they won't have been
> +        * set by anything. The extended_regexp_option field is the
> +        * only exception to this.
> +        *
> +        * This is because in the process of parsing grep.patternType
> +        * & grep.extendedRegexp we set opt->pattern_type_option and
> +        * opt->extended_regexp_option, respectively. We then
> +        * internally use opt->extended_regexp_option to see if we're
> +        * compiling an ERE. It must be unset if that's not actually
> +        * the case.
> +        */
> +       if (pattern_type !=3D GREP_PATTERN_TYPE_ERE &&
> +           opt->extended_regexp_option)
> +               opt->extended_regexp_option =3D 0;
> +
>         switch (pattern_type) {
>         case GREP_PATTERN_TYPE_UNSPECIFIED:
>                 /* fall through */
> @@ -178,7 +194,7 @@ static void grep_set_pattern_type_option(enum grep_pa=
ttern_type pattern_type, st
>                 break;
>
>         case GREP_PATTERN_TYPE_ERE:
> -               opt->regflags |=3D REG_EXTENDED;
> +               opt->extended_regexp_option =3D 1;
>                 break;
>
>         case GREP_PATTERN_TYPE_FIXED:
> @@ -208,6 +224,11 @@ void grep_commit_pattern_type(enum grep_pattern_type=
 pattern_type, struct grep_o
>         else if (opt->pattern_type_option !=3D GREP_PATTERN_TYPE_UNSPECIF=
IED)
>                 grep_set_pattern_type_option(opt->pattern_type_option, op=
t);
>         else if (opt->extended_regexp_option)
> +               /*
> +                * This branch *must* happen after setting from the
> +                * opt->pattern_type_option above,

I do not quite understand this. Are you saying

  opt->pattern_type_option takes precedence over
  opt->extended_regexp_option if the former is not _UNSPECIFIED ?

As grep_set_pattern_type_option is only called from here,
I wondered if we can put the long comment (and the code)
here in this function grep_commit_pattern_type to have it less
subtle? I have no proposal how though.

I think I grokked this patch and it makes sense, though the commit
message strongly hints at asking for tests. ;)

Thanks,
Stefan
