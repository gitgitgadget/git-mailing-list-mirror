Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A7C342042F
	for <e@80x24.org>; Wed, 16 Nov 2016 17:09:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932629AbcKPRJi (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Nov 2016 12:09:38 -0500
Received: from mail-it0-f66.google.com ([209.85.214.66]:35962 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932301AbcKPRJh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Nov 2016 12:09:37 -0500
Received: by mail-it0-f66.google.com with SMTP id n68so8370035itn.3
        for <git@vger.kernel.org>; Wed, 16 Nov 2016 09:09:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=YCV/ZdPrCKL8nMBWtd0Hq3CXkXuAf29uoG029L2xY2g=;
        b=vunwJ91wZ3EAKvfBbTI6+NVRyef0c7JTIvS6Tc4Usvorl9wJfzPzLg+xBZ+ZHEtp8E
         GHYzbFSeh1itANtz11mb0HGfz6MW6BoURw4V7XQCmvTEu12AcMeGLd2d/TTqN6BaWVGJ
         0sDqTq6Eo+WsHR/kxN/Q6yVeTpEjaMgcG3M0NjFjhen3B5MaXqfG8DIINoJUuzw3BGzZ
         yYmq21a4yJRRJ+Wd2hJJFArj+KkIh6lPKjD8OgCulT8un86uAT0gmXTWWw2dk7djW6Rv
         Xrruf9wVh1hYL+MzaOh2lIid2SyzOqWyo1nJexXxXv5ll6QCS7V0eyNlzx03vkLFopO4
         8JpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=YCV/ZdPrCKL8nMBWtd0Hq3CXkXuAf29uoG029L2xY2g=;
        b=BYt7kNC/LZp/Wn1qfJBiyrhg4cdHpodlddupsciB1D7bEXQ1bzAdFuqvSy/qT4heRT
         Mp6GlOXZKSaUVU4xTC6lL242MfuiCub35iACAf0mrt5DOoIksb0hBUqXeci300P79qWI
         3/slouor1BWee/daLp0OPT7y/tHTOcjTI8H20rnMK655qj1JoggTIGcyS0GZW6iPGlZW
         CH2kkFhP1HHonXbEhBz6Crmy1rlzRUQTOehD+mRL1kQY2anP5g/iz8MvcLL/ManTaSN5
         rK+vSMGx4uXR7atAtFHiX5B/R6kfUS9Aw3h7zk+4HrqLtnlLBWxxwlHF0dqlRU2vuGs+
         ApqA==
X-Gm-Message-State: ABUngvedJLzx/ur9uO3tnnFMLBtweDiUOyYYW4if9jAureEQic2yxn77mTBjmwpnJVLwRYW0jAnSWU2KXmS/VQ==
X-Received: by 10.107.141.211 with SMTP id p202mr3355124iod.47.1479316176159;
 Wed, 16 Nov 2016 09:09:36 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.27.209 with HTTP; Wed, 16 Nov 2016 09:09:35 -0800 (PST)
In-Reply-To: <098cb39e-3c92-df56-1dc9-c529df817262@gmx.net>
References: <01020157c38b19e0-81123fa5-5d9d-4f64-8f1b-ff336e83ebe4-000000@eu-west-1.amazonses.com>
 <01020157c38b1ad3-ea75ed97-2514-427e-8e57-9f10efd4e6e9-000000@eu-west-1.amazonses.com>
 <098cb39e-3c92-df56-1dc9-c529df817262@gmx.net>
From:   Pranit Bauva <pranit.bauva@gmail.com>
Date:   Wed, 16 Nov 2016 22:39:35 +0530
Message-ID: <CAFZEwPOswSePNWn=X-sPf08nGMcKp8m_VkeNdqHfWxsEqu7z7A@mail.gmail.com>
Subject: Re: [PATCH v15 13/27] bisect--helper: `bisect_start` shell function
 partially in C
To:     Stephan Beyer <s-beyer@gmx.net>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hey Stephan,

On Wed, Nov 16, 2016 at 4:49 AM, Stephan Beyer <s-beyer@gmx.net> wrote:
> Hi,
>
> On 10/14/2016 04:14 PM, Pranit Bauva wrote:
>> diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
>> index 6a5878c..1d3e17f 100644
>> --- a/builtin/bisect--helper.c
>> +++ b/builtin/bisect--helper.c
>> @@ -24,6 +27,8 @@ static const char * const git_bisect_helper_usage[] = {
>>       N_("git bisect--helper --bisect-check-and-set-terms <command> <TERM_GOOD> <TERM_BAD>"),
>>       N_("git bisect--helper --bisect-next-check [<term>] <TERM_GOOD> <TERM_BAD"),
>>       N_("git bisect--helper --bisect-terms [--term-good | --term-old | --term-bad | --term-new]"),
>> +     N_("git bisect--helper --bisect start [--term-{old,good}=<term> --term-{new,bad}=<term>]"
>> +                                           "[--no-checkout] [<bad> [<good>...]] [--] [<paths>...]"),
>
> Typo: "--bisect start" with space instead of "-"
>
>> @@ -403,6 +408,205 @@ static int bisect_terms(struct bisect_terms *terms, const char **argv, int argc)
>>       return 0;
>>  }
>>
>> +static int bisect_start(struct bisect_terms *terms, int no_checkout,
>> +                     const char **argv, int argc)
>> +{
>> +     int i, has_double_dash = 0, must_write_terms = 0, bad_seen = 0;
>> +     int flags, pathspec_pos, retval = 0;
>> +     struct string_list revs = STRING_LIST_INIT_DUP;
>> +     struct string_list states = STRING_LIST_INIT_DUP;
>> +     struct strbuf start_head = STRBUF_INIT;
>> +     struct strbuf bisect_names = STRBUF_INIT;
>> +     struct strbuf orig_args = STRBUF_INIT;
>> +     const char *head;
>> +     unsigned char sha1[20];
>> +     FILE *fp = NULL;
>> +     struct object_id oid;
>> +
>> +     if (is_bare_repository())
>> +             no_checkout = 1;
>> +
>> +     for (i = 0; i < argc; i++) {
>> +             if (!strcmp(argv[i], "--")) {
>> +                     has_double_dash = 1;
>> +                     break;
>> +             }
>> +     }
>> +
>> +     for (i = 0; i < argc; i++) {
>> +             const char *commit_id = xstrfmt("%s^{commit}", argv[i]);
>> +             const char *arg = argv[i];
>> +             if (!strcmp(argv[i], "--")) {
>> +                     has_double_dash = 1;
>
> This is without effect since has_double_dash is already set to 1 by the
> loop above. I think you can remove this line.

True. I will remove this line.

>> +                     break;
>> +             } else if (!strcmp(arg, "--no-checkout")) {
>> +                     no_checkout = 1;
>> +             } else if (!strcmp(arg, "--term-good") ||
>> +                      !strcmp(arg, "--term-old")) {
>> +                     must_write_terms = 1;
>> +                     terms->term_good = xstrdup(argv[++i]);
>> +             } else if (skip_prefix(arg, "--term-good=", &arg)) {
>> +                     must_write_terms = 1;
>> +                     terms->term_good = xstrdup(arg);
>> +             } else if (skip_prefix(arg, "--term-old=", &arg)) {
>> +                     must_write_terms = 1;
>> +                     terms->term_good = xstrdup(arg);
>
> I think you can join the last two branches:
>
> +               } else if (skip_prefix(arg, "--term-good=", &arg) ||
> +                          skip_prefix(arg, "--term-old=", &arg)) {
> +                       must_write_terms = 1;
> +                       terms->term_good = xstrdup(arg);
>
>> +             } else if (!strcmp(arg, "--term-bad") ||
>> +                      !strcmp(arg, "--term-new")) {
>> +                     must_write_terms = 1;
>> +                     terms->term_bad = xstrdup(argv[++i]);
>> +             } else if (skip_prefix(arg, "--term-bad=", &arg)) {
>> +                     must_write_terms = 1;
>> +                     terms->term_bad = xstrdup(arg);
>> +             } else if (skip_prefix(arg, "--term-new=", &arg)) {
>> +                     must_write_terms = 1;
>> +                     terms->term_good = xstrdup(arg);
>
> This has to be terms->term_bad = ...

My bad.

> Also, you can join the last two branches, again, ie,

Sure!

> +               } else if (skip_prefix(arg, "--term-bad=", &arg) ||
> +                          skip_prefix(arg, "--term-new=", &arg)) {
> +                       must_write_terms = 1;
> +                       terms->term_bad = xstrdup(arg);
>
>> +             } else if (starts_with(arg, "--") &&
>> +                      !one_of(arg, "--term-good", "--term-bad", NULL)) {
>> +                     die(_("unrecognised option: '%s'"), arg);
> [...]
>> +     /*
>> +      * Verify HEAD
>> +      */
>> +     head = resolve_ref_unsafe("HEAD", 0, sha1, &flags);
>> +     if (!head)
>> +             if (get_sha1("HEAD", sha1))
>> +                     die(_("Bad HEAD - I need a HEAD"));
>> +
>> +     if (!is_empty_or_missing_file(git_path_bisect_start())) {
>
> You were so eager to re-use the comments from the shell script, but you
> forgot the "Check if we are bisecting." comment above this line ;-)

I will add it back again.

>> +             /* Reset to the rev from where we started */
>> +             strbuf_read_file(&start_head, git_path_bisect_start(), 0);
>> +             strbuf_trim(&start_head);
>> +             if (!no_checkout) {
>> +                     struct argv_array argv = ARGV_ARRAY_INIT;
> [...]
>> +     if (must_write_terms)
>> +             if (write_terms(terms->term_bad, terms->term_good)) {
>> +                     retval = -1;
>> +                     goto finish;
>> +             }
>> +
>
> bisect_start() is a pretty big function.
> I think it can easily be decomposed in some smaller parts, for example,
> the following lines ...
>
>> +     fp = fopen(git_path_bisect_log(), "a");
>> +     if (!fp)
>> +             return -1;
>> +
>> +     if (fprintf(fp, "git bisect start") < 1) {
>> +             retval = -1;
>> +             goto finish;
>> +     }
>> +
>> +     sq_quote_argv(&orig_args, argv, 0);
>> +     if (fprintf(fp, "%s", orig_args.buf) < 0) {
>> +             retval = -1;
>> +             goto finish;
>> +     }
>> +     if (fprintf(fp, "\n") < 1) {
>> +             retval = -1;
>> +             goto finish;
>> +     }
>
> ... could be in a function like
>
> static int bisect_append_log(const char **argv)
> {
>         FILE *fp = fopen(git_path_bisect_log(), "a");
>         struct strbuf orig_args = STRBUF_INIT;
>         if (!fp)
>                 return -1;
>
>         if (fprintf(fp, "git bisect start") < 1) {
>                 retval = -1;
>                 goto finish;
>         }
>
>         sq_quote_argv(&orig_args, argv, 0);
>         if (fprintf(fp, "%s", orig_args.buf) < 0 ||
>             fprintf(fp, "\n") < 1) {
>                 retval = -1;
>                 goto finish;
>         }
>
> finish:
>         if (fp)
>                 fclose(fp);
>         strbuf_release(&orig_args);
>
>         return retval;
> }
>
> and then simply call
>
>         retval = bisect_append_log(argv);
>
> in bisect_start()... (This is totally untested.)

I think this would be a better choice. Thanks!

> If you do not want that for some reason, you should at least fix
>
>> +     if (!fp)
>> +             return -1;
>
> to retval = 1; goto finish; such that the other lists and strings are
> released.
>
>> +     goto finish;
>> +finish:
>
> The "goto finish" right above the "finish" label is unnecessary.
>
>> +     if (fp)
>> +             fclose(fp);
>> +     string_list_clear(&revs, 0);
>> +     string_list_clear(&states, 0);
>> +     strbuf_release(&start_head);
>> +     strbuf_release(&bisect_names);
>> +     strbuf_release(&orig_args);
>> +     return retval;
>> +}
>> +
>>  int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
>>  {
>>       enum {
>
> By the way, there are two spaghetti-ish ways to get rid of the
>
>         retval = -1;
>         goto finish;
>
> line pair:
>
>         goto fail;
>
> and below the "return retval;" add
>
> fail:
>         retval = -1;
>         goto finish;
>
> and you can feel the touch of His Noodly Appendage. *scnr*

Nice little trick.

> The other way is to keep the "goto finish" I deemed unnecessary (right
> above the label), and expand it to:
>
>         goto finish;
> fail:
>         retval = -1;
> finish:
>         ...


Regards,
Pranit Bauva
