Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.8 required=5.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 33C1F1FE4D
	for <e@80x24.org>; Thu, 16 Jun 2016 18:55:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754220AbcFPSzE (ORCPT <rfc822;e@80x24.org>);
	Thu, 16 Jun 2016 14:55:04 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:34296 "EHLO
	mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753976AbcFPSzD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Jun 2016 14:55:03 -0400
Received: by mail-io0-f194.google.com with SMTP id 100so6864403ioh.1
        for <git@vger.kernel.org>; Thu, 16 Jun 2016 11:55:02 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=T9Dx8FKpqA/HqELJE3aPY/tV1U0+6QCdkq/DiBS6Wxo=;
        b=qCpv90mRi9YFcFKSLBedb39ysfdbbxEt4DqGxCAAO+JSLf0+woe1yUdzkkXCc9zfjK
         Q/zCv9hDRHRjguyLYKIHd6oqyP4W7KAFdRZAI+Dhcx/qA5Of4dr1k/SLA81kiG/ibzwi
         wPTPaBu1ucXIRnn0PASO00FQDcGwMxI3fes6lfAFUevofFHrOFF6htrL9qVX2GllHHNl
         cHgtX0Ub8nKUe0Oaqiu75nDeAfbcBoHzidqy29ODzAibnJdh1NLsI4hcO9qTU9w4fcbt
         uOqzT0S4tp4tZ5yrfmuD6834h+sY0gwgMZghMihVi+U/Bvh3wh9SIoNJZcZV0CKVG9Va
         juUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=T9Dx8FKpqA/HqELJE3aPY/tV1U0+6QCdkq/DiBS6Wxo=;
        b=DutFvN+P186a1SIWmYeSiQwc0co9PucMUTZbk9SkIHQlDxlhX7ytgX/a2k0ygnPCEP
         et3H3EUvyzrOgLzcb2mpWUz04DTP5TbxHfMOupXgsyKUDDdmedvJ0Psy1Zz0FdqpF8t+
         1dlO4IFaVazwiQFD5mu/rAnnKp8RnRw9QmzJicqi1mBX8DgM6L9QwgXnYH67h5efxe4O
         ZWhAglI0OK54qzW6i4uZC35p9gABVVb61uV90c3+keL6USCaI1JHB5LwIuURvNKFPCue
         wffZLl4tQDDnGMpbfOdlFOiVgNtk3QmJyuju8FHo0GSNQxkOxFo8cDn81fIZjlzzzRq5
         2wyQ==
X-Gm-Message-State: ALyK8tIThigThffLUVhOPqSG9ZomuyBQs7p/quEhDnENcdw70350zY2W0OcGtu8rCMZOE3PzGkV0PuuPvBOJ3w==
X-Received: by 10.107.25.13 with SMTP id 13mr10349534ioz.104.1466103301592;
 Thu, 16 Jun 2016 11:55:01 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.0.30 with HTTP; Thu, 16 Jun 2016 11:55:01 -0700 (PDT)
In-Reply-To: <20160615140026.10519-7-pranit.bauva@gmail.com>
References: <20160607205454.22576-1-pranit.bauva@gmail.com>
 <20160615140026.10519-1-pranit.bauva@gmail.com> <20160615140026.10519-7-pranit.bauva@gmail.com>
From:	Eric Sunshine <sunshine@sunshineco.com>
Date:	Thu, 16 Jun 2016 14:55:01 -0400
X-Google-Sender-Auth: 36I-9SDZvpDxUqyTez1wjuBbzHo
Message-ID: <CAPig+cQV3FTGJBvS0Kuc3CNPiwZMZtApT6r8+Ojhw3y7O2VTiw@mail.gmail.com>
Subject: Re: [PATCH v2 6/6] bisect--helper: `bisect_write` shell function in C
To:	Pranit Bauva <pranit.bauva@gmail.com>
Cc:	Git List <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Lars Schneider <larsxschneider@gmail.com>,
	=?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Wed, Jun 15, 2016 at 10:00 AM, Pranit Bauva <pranit.bauva@gmail.com> wrote:
> Reimplement the `bisect_write` shell function in C and add a
> `bisect-write` subcommand to `git bisect--helper` to call it from
> git-bisect.sh
>
> Using `--bisect-write` subcommand is a temporary measure to port shell
> function in C so as to use the existing test suite. As more functions
> are ported, this subcommand will be retired and will be called by some
> other methods.
>
> Note: bisect_write() uses two variables namely TERM_GOOD and TERM_BAD
> from the global shell script thus we need to pass it to the subcommand
> using the arguments. After the whole conversion, we can remove the extra
> arguments and make the method use the two variables from the global scope
> within the C code.

You could do this now rather than waiting for later. Instead of
passing these arguments to bisect_write(), create global variables in
this patch and assign them in the BISECT_WRITE case of
cmd_bisect__helper() before calling bisect_write().

Not necessarily worth a re-roll, but would save you the effort of
having to explain it here and then change it in some later patch.

> Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
> ---
> diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
> @@ -192,6 +193,55 @@ static int check_expected_revs(const char **revs, int rev_nr)
> +static int bisect_write(const char *state, const char *rev,
> +                       const char *term_good, const char *term_bad,
> +                       int nolog)
> +{
> +       struct strbuf tag = STRBUF_INIT;
> +       struct strbuf commit_name = STRBUF_INIT;
> +       struct object_id oid;
> +       struct commit *commit;
> +       struct pretty_print_context pp = {0};
> +       FILE *fp;
> +
> +       if (!strcmp(state, term_bad))
> +               strbuf_addf(&tag, "refs/bisect/%s", state);
> +       else if(one_of(state, term_good, "skip", NULL))
> +               strbuf_addf(&tag, "refs/bisect/%s-%s", state, rev);
> +       else
> +               return error(_("Bad bisect_write argument: %s"), state);
> +
> +       if (get_oid(rev, &oid)) {
> +               strbuf_release(&tag);
> +               return error(_("couldn't get the oid of the rev '%s'"), rev);
> +       }

Minor: If you move the get_oid() conditional before the one above it,
then you won't have to worry about releasing 'strbuf tag' at this
point.

> +       if (update_ref(NULL, tag.buf, oid.hash, NULL, 0,
> +                      UPDATE_REFS_MSG_ON_ERR)) {
> +               strbuf_release(&tag);
> +               return -1;
> +       }

If you release 'strbuf tag' right here, after it's final use, then you
won't have to worry about releasing it anywhere below (particularly in
the error cases).

> +       fp = fopen(git_path_bisect_log(), "a");
> +       if (!fp) {
> +               strbuf_release(&tag);
> +               return error_errno(_("couldn't open the file '%s'"), git_path_bisect_log());
> +       }
> +
> +       commit = lookup_commit_reference(oid.hash);
> +       format_commit_message(commit, "%s", &commit_name, &pp);
> +       fprintf(fp, "# %s: [%s] %s\n", state, sha1_to_hex(oid.hash),
> +               commit_name.buf);
> +
> +       if (!nolog)
> +               fprintf(fp, "git bisect %s %s\n", state, rev);
> +
> +       strbuf_release(&commit_name);
> +       strbuf_release(&tag);
> +       fclose(fp);
> +       return 0;
> +}
> @@ -241,6 +295,11 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
> +       case BISECT_WRITE:
> +               if (argc != 4 && argc != 5)
> +                       die(_("--bisect-write requires either 4 or 5 arguments"));
> +               nolog = (argc == 5) && !strcmp(argv[4], "nolog");

This is minor and won't matter in the long run when this code goes
away later in the C conversion, but this differs from the shell code
which only cared that a (non-empty) fifth argument was provided but
didn't care about the actual value, whereas this code expects the
argument to be exactly "nolog".

> +               return bisect_write(argv[0], argv[1], argv[2], argv[3], nolog);
>         default:
>                 die("BUG: unknown subcommand '%d'", cmdmode);
>         }
