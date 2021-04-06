Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3314C433ED
	for <git@archiver.kernel.org>; Tue,  6 Apr 2021 16:23:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8751A613CC
	for <git@archiver.kernel.org>; Tue,  6 Apr 2021 16:23:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346383AbhDFQYA (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Apr 2021 12:24:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346372AbhDFQX6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Apr 2021 12:23:58 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AFACC06174A
        for <git@vger.kernel.org>; Tue,  6 Apr 2021 09:23:50 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id r22so4804429edq.9
        for <git@vger.kernel.org>; Tue, 06 Apr 2021 09:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7COXwaMpqbPIACtMXHrIKzKoABS86rkjkecznWfRGTg=;
        b=BbXBuVgdnHUZ79Mjk+zsRgrH2keRcj457KbOGQWRO/rcZsDKr2Q+VYSABe2QTtx1+Y
         PCZ2UQZuytPMDm0QPyjKykYMkhJ11AOBpK5+3QiunTiJu3gqCPhDAr1ePpFaA4Prz/rN
         N8bqCpv69tdredcXFhWeJRSFbnn/zkRipqoINoA9dlpVdER9K9BdFZOFul2k4hutvogc
         +ZpUVXl24rlJVcxiiokH8lJ1O/zH5r8ncl19kp0BDUJ6aYB6hVbwe3tKZ3DWCcbaEfjv
         QyrDuQscZjNopSMwPNDLhtiUc2PPvx1PWp+8UnVYkVXmE5P6oWUB7NKEeUDNdrY8e1mL
         ua4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7COXwaMpqbPIACtMXHrIKzKoABS86rkjkecznWfRGTg=;
        b=FBrtP3vb/23EcFp/6ByJtBARFUuVCVy1NFyq/D0fMrcEPFaBLY4kYNIMuimjagdGVq
         B3WbnVPXR0kJtY0MI6IXbJyGzEAd+Ko2exS92ael6jHFaFBhtt59eXlpxA7Z3j8mQ0qV
         y+2M6XHnIfyvRcZD7HBR0nIM++nZE88jBpuVpqteA6pv+qmUuC0XtvcKRRqs+1tq+ydL
         YY5gkOqqpXaesJI8zTTvWLZgBvm45uDlgklcmlnbj1mO8BhtrT55UwBvoHnOwRNmoaPY
         0Ug3mbaB4N5wjjVn1HT4xgA5H8vun28QeGa8fMHt767Kn3tldUzn+wPqTRlvF1WoD7lC
         c57g==
X-Gm-Message-State: AOAM532OAYIvrBG3HUMykDws/Kqona+Rygs6JqUlyn7KnVZxsC/+k86i
        YBf6YGSLbohBO9fn49MFVnPfU9XE/3VwwxiQ1CQGuvG+ZsH9Ug==
X-Google-Smtp-Source: ABdhPJzuEkIka8V6Qcn9e5BYYYIYaRA0UzzQXTr8xIGMQDaL+JcvYWyHX/3Cd2ThlxOMKsApLh7qf2gBca/RRzn6fts=
X-Received: by 2002:a05:6402:48c:: with SMTP id k12mr38998633edv.237.1617726229019;
 Tue, 06 Apr 2021 09:23:49 -0700 (PDT)
MIME-Version: 1.0
References: <pull.913.v6.git.1617369973328.gitgitgadget@gmail.com> <pull.913.v7.git.1617541912381.gitgitgadget@gmail.com>
In-Reply-To: <pull.913.v7.git.1617541912381.gitgitgadget@gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Tue, 6 Apr 2021 18:23:37 +0200
Message-ID: <CAP8UFD3Ga=HR4YsS8UvgEQF9982be_wa8dUzniGsri+6qoEMHg@mail.gmail.com>
Subject: Re: [PATCH v7] [GSOC] trailer: add new trailer.<token>.cmd config option
To:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        ZheNing Hu <adlternative@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Apr 4, 2021 at 3:11 PM ZheNing Hu via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: ZheNing Hu <adlternative@gmail.com>
>
> The `trailer.<token>.command` configuration variable
> specifies a command (run via the shell, so it does not have
> to be a single name of or path to the command, but can be a
> shell script), and the first occurrence of substring $ARG is
> replaced with the value given to the `interpret-trailer`
> command for the token.  This has two downsides:
>
> * The use of $ARG in the mechanism misleads the users that
> the value is passed in the shell variable, and tempt them
> to use $ARG more than once, but that would not work, as
> the second and subsequent $ARG are not replaced.
>
> * Because $ARG is textually replaced without regard to the
> shell language syntax, even '$ARG' (inside a single-quote
> pair), which a user would expect to stay intact, would be
> replaced, and worse, if the value had an unmatching single

s/unmatching/unmatched/

> quote (imagine a name like "O'Connor", substituted into
> NAME='$ARG' to make it NAME='O'Connor'), it would result in
> a broken command that is not syntactically correct (or
> worse).

Good explanation of the issues with ".command"!

> Introduce a new `trailer.<token>.cmd` configuration that
> takes higher precedence to deprecate and eventually remove
> `trailer.<token>.command`, which passes the value as a
> parameter to the command.  Instead of "$ARG", the users will

s/a parameter/an argument/
s/the users will/users can/

> refer to the value as positional argument, $1, in their
> scripts.
>
> Helped-by: Junio C Hamano <gitster@pobox.com>
> Helped-by: Christian Couder <christian.couder@gmail.com>
> Signed-off-by: ZheNing Hu <adlternative@gmail.com>
> ---
>     [GSOC] trailer: add new trailer..cmd config option

Maybe <token> has been removed from "trailer.<token>.cmd" above
because it has been interpreted as an HTML or XML tag?

>     In https://lore.kernel.org/git/xmqqv99i4ck2.fsf@gitster.g/ Junio and
>     Christian talked about the problem of using strbuf_replace() to replace
>     $ARG:
>
>      1. if user's script have more than one $ARG, only the first one will be

s/user's script have/the user's script has/

>         replaced, which is incorrected.
>      2. $ARG is textually replaced without shell syntax, which may result a
>         broken command when $ARG include some unmatching single quote, very
>         unsafe.

Yeah, good summary of the issues with ".command"

>     Now pass trailer value as $1 to the trailer command with another
>     trailer.<token>.cmd config, to solve these above two problems,
>
>     We are now writing documents that are more readable and correct than
>     before.

Yeah, correcting the doc is a good thing to do. By the way, as I said
to Junio, it might be better to make the doc for ".command" more
readable and correct in a first patch separate from the patch
introducing ".cmd".

If you really want to do both in the same patch you should tell that
in the commit message too, not just here after the "---" line.

>  Documentation/git-interpret-trailers.txt | 86 +++++++++++++++++++----
>  t/t7513-interpret-trailers.sh            | 87 +++++++++++++++++++++++-
>  trailer.c                                | 37 +++++++---
>  3 files changed, 186 insertions(+), 24 deletions(-)
>
> diff --git a/Documentation/git-interpret-trailers.txt b/Documentation/git-interpret-trailers.txt
> index 96ec6499f001..83600e93390d 100644
> --- a/Documentation/git-interpret-trailers.txt
> +++ b/Documentation/git-interpret-trailers.txt
> @@ -236,21 +236,36 @@ trailer.<token>.command::
>         be called to automatically add or modify a trailer with the
>         specified <token>.
>  +
> -When this option is specified, the behavior is as if a special
> -'<token>=<value>' argument were added at the beginning of the command
> -line, where <value> is taken to be the standard output of the
> -specified command with any leading and trailing whitespace trimmed
> -off.
> +When this option is specified, the first occurrence of substring $ARG is
> +replaced with the value given to the `interpret-trailer` command for the
> +same token. This option behaves in a similar way as ".cmd", however, it
> +passes the value through $ARG.

Maybe this last sentence could be replaced with "Otherwise this option
behaves in the same way as 'trailer.<token>.cmd'."

> -If the command contains the `$ARG` string, this string will be
> -replaced with the <value> part of an existing trailer with the same
> -<token>, if any, before the command is launched.
> +".command" has been deprecated due to the $ARG in the user's command can

s/".command"/The 'trailer.<token>.command' option/
s/to the $ARG/to the fact that `$ARG`/

> +only be replaced once and the original way of replacing $ARG was not safe.

s/only be/can only be/
s/and the/and that the/

> +Now the preferred option is using "trailer.<token>.cmd", which use position

s/using//
s/use/uses/
s/position/a positional/

Also please make sure that trailer.<token>.cmd and
trailer.<token>.command are always quoted in the same way. I think
single quotes are used in the current doc, so please keep using single
quotes.

> +argument to pass the value.
> ++
> +When both .cmd and .command are given for the same <token>,
> +.cmd is used and .command is ignored.

Please spell and quote ".cmd" and ".command" consistently, so for
example like: 'trailer.<token>.cmd'

> +trailer.<token>.cmd::
> +       The command specified by this configuration variable is run
> +       with a single argument, which is the <value> part of a
> +       `--trailer <token>=<value>` on the command line. The output
> +       from the command is then used as the value for the <token>
> +       in the resulting trailer.
> ++
> +When this option is specified, the behavior is as if a '<token>=<value>'

s/'<token>=<value>'/`--trailer <token>=<value>`/  (let's try to be as
explicit as possible)

> +argument were added at the beginning of the "git interpret-trailers"

s/were/was/

> +command, the command specified by this configuration variable will be
> +called with an empty string as the argument.
> +
>  If some '<token>=<value>' arguments are also passed on the command
> -line, when a 'trailer.<token>.command' is configured, the command will
> -also be executed for each of these arguments. And the <value> part of
> -these arguments, if any, will be used to replace the `$ARG` string in
> -the command.
> +line, when a 'trailer.<token>.cmd' is configured, the command is run
> +once for each `--trailer <token>=<value>` on the command line with the
> +same <token>. And the <value> part of these arguments, if any, will be
> +passed to the command as its first argument.

Yeah, it's much better than it was, but I think we can do better. I
will try to come up with something soon.

Also as I said above and in reply to Junio, I think it might be better
to split this in 2 patches.

>  EXAMPLES
>  --------
> @@ -333,6 +348,53 @@ subject
>  Fix #42
>  ------------
>
> +* Configure a 'cnt' trailer with a cmd use a global script `gcount`
> +to record commit counts of a specified author and show how it works:
> ++
> +------------
> +$ cat ~/bin/gcount
> +#!/bin/sh
> +test -n "$1" && git shortlog -s --author="$1" HEAD || true
> +$ git config trailer.cnt.key "Commit-count: "
> +$ git config trailer.cnt.ifExists "replace"
> +$ git config trailer.cnt.cmd "~/bin/gcount"
> +$ git interpret-trailers --trailer="cnt:Junio" <<EOF
> +> subject
> +>
> +> message
> +>
> +> EOF
> +subject
> +
> +message
> +
> +Commit-count: 22484     Junio C Hamano
> +------------
> +
> +* Configure a 'ref' trailer with a cmd use a global script `glog-grep`
> +  to grep last relevant commit from git log in the git repository
> +  and show how it works:
> ++
> +------------
> +$ cat ~/bin/glog-grep
> +#!/bin/sh
> +test -n "$1" && git log --grep "$1" --pretty=reference -1 || true
> +$ git config trailer.ref.key "Reference-to: "
> +$ git config trailer.ref.ifExists "replace"
> +$ git config trailer.ref.cmd "~/bin/glog-grep"
> +$ git interpret-trailers --trailer="ref:Add copyright notices." <<EOF
> +> subject
> +>
> +> message
> +>
> +> EOF
> +subject
> +
> +message
> +
> +Reference-to: 8bc9a0c769 (Add copyright notices., 2005-04-07)

The added examples look good!

> +test_expect_success 'with cmd' '
> +       test_when_finished "git config --remove-section trailer.bug" &&
> +       git config trailer.bug.key "Bug-maker: " &&
> +       git config trailer.bug.ifExists "add" &&
> +       git config trailer.bug.cmd "echo \"maybe is\"" &&
> +       cat >expected2 <<-EOF &&
> +
> +       Bug-maker: maybe is
> +       Bug-maker: maybe is him
> +       Bug-maker: maybe is me
> +       EOF
> +       git interpret-trailers --trailer "bug: him" --trailer "bug:me" \
> +               >actual2 &&
> +       test_cmp expected2 actual2
> +'

I guess this shows that the command is called multiple times, the
first time with an empty first arg.

> +test_expect_success 'with cmd and $1' '
> +       test_when_finished "git config --remove-section trailer.bug" &&
> +       git config trailer.bug.key "Bug-maker: " &&
> +       git config trailer.bug.ifExists "replace" &&
> +       git config trailer.bug.cmd "echo \"\$1\" is" &&
> +       cat >expected2 <<-EOF &&
> +
> +       Bug-maker: me is me
> +       EOF
> +       git interpret-trailers --trailer "bug: him" --trailer "bug:me" \
> +               >actual2 &&
> +       test_cmp expected2 actual2
> +'

I guess this shows that the argument is also available as "$1".

> +test_expect_success 'with cmd and $1 with sh -c' '
> +       test_when_finished "git config --remove-section trailer.bug" &&
> +       git config trailer.bug.key "Bug-maker: " &&
> +       git config trailer.bug.ifExists "replace" &&
> +       git config trailer.bug.cmd "sh -c \"echo who is \"\$1\"\"" &&
> +       cat >expected2 <<-EOF &&
> +
> +       Bug-maker: who is me
> +       EOF
> +       git interpret-trailers --trailer "bug: him" --trailer "bug:me" \
> +               >actual2 &&
> +       test_cmp expected2 actual2
> +'

Ok, this shows how `sh -c ...` can be used in ".cmd".

> +test_expect_success 'with cmd and $1 with shell script' '
> +       test_when_finished "git config --remove-section trailer.bug" &&
> +       git config trailer.bug.key "Bug-maker: " &&
> +       git config trailer.bug.ifExists "replace" &&
> +       git config trailer.bug.cmd "./echoscript" &&
> +       cat >expected2 <<-EOF &&
> +
> +       Bug-maker: who is me
> +       EOF
> +       cat >echoscript <<-EOF &&
> +       #!/bin/sh
> +       echo who is "\$1"
> +       EOF
> +       chmod +x echoscript &&
> +       git interpret-trailers --trailer "bug: him" --trailer "bug:me" \
> +               >actual2 &&
> +       test_cmp expected2 actual2
> +'

Ok.

>  test_expect_success 'without config' '
>         sed -e "s/ Z\$/ /" >expected <<-\EOF &&
>
> @@ -1274,9 +1337,31 @@ test_expect_success 'setup a commit' '
>         git commit -m "Add file a.txt"
>  '
>
> +test_expect_success 'cmd takes precedence over command' '
> +       test_when_finished "git config --unset trailer.fix.cmd" &&
> +       git config trailer.fix.ifExists "replace" &&
> +       git config trailer.fix.cmd "test -n \"\$1\" && git log -1 --oneline --format=\"%h (%aN)\" \
> +               --abbrev-commit --abbrev=14 \"\$1\" || true" &&
> +       git config trailer.fix.command "git log -1 --oneline --format=\"%h (%s)\" \
> +               --abbrev-commit --abbrev=14 \$ARG" &&
> +       FIXED=$(git log -1 --oneline --format="%h (%aN)" --abbrev-commit --abbrev=14 HEAD) &&
> +       cat complex_message_body >expected2 &&
> +       sed -e "s/ Z\$/ /" >>expected2 <<-EOF &&
> +               Fixes: $FIXED
> +               Acked-by= Z
> +               Reviewed-by:
> +               Signed-off-by: Z
> +               Signed-off-by: A U Thor <author@example.com>
> +       EOF
> +       git interpret-trailers --trailer "review:" --trailer "fix=HEAD" \
> +               <complex_message >actual2 &&
> +       test_cmp expected2 actual2
> +'

Ok.

>  test_expect_success 'with command using $ARG' '
>         git config trailer.fix.ifExists "replace" &&
> -       git config trailer.fix.command "git log -1 --oneline --format=\"%h (%s)\" --abbrev-commit --abbrev=14 \$ARG" &&
> +       git config trailer.fix.command "git log -1 --oneline --format=\"%h (%s)\" \
> +               --abbrev-commit --abbrev=14 \$ARG" &&

This is just an indent change. I am not sure it's worth doing in this
patch. If you think that the file needs better indentation though,
then you might do it in a separate preparatory patch at the beginning
of the current patch series.

If there is only this place in the file where such an indentation
improvement is needed, this might be ok, but please mention in the
commit message that while at it you are also doing this small change.

The other parts of the patch look good to me.
