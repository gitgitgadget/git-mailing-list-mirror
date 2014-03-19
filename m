From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH][GSOC] Selection of the verbose message is replaced with
 generated message in install_branch_config()
Date: Wed, 19 Mar 2014 05:21:59 -0400
Message-ID: <CAPig+cQLACyFwVypi08ZGQ14mpc0zt0fRRNhPzswRjsTaFQz2A@mail.gmail.com>
References: <1395050104-19152-1-git-send-email-moxobukob@gmail.com>
	<loom.20140318T124348-742@post.gmane.org>
	<lg9l22$qto$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>
To: Aleksey Mokhovikov <moxobukob@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 19 10:22:09 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WQChM-0007ev-0f
	for gcvg-git-2@plane.gmane.org; Wed, 19 Mar 2014 10:22:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758675AbaCSJWD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Mar 2014 05:22:03 -0400
Received: from mail-yh0-f54.google.com ([209.85.213.54]:58935 "EHLO
	mail-yh0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758036AbaCSJV7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Mar 2014 05:21:59 -0400
Received: by mail-yh0-f54.google.com with SMTP id f73so8225783yha.13
        for <git@vger.kernel.org>; Wed, 19 Mar 2014 02:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=foAOxCpy8dyN+D6fF2EDslvBd7dIGtkORjVuNvnn30s=;
        b=Q5mq5w3F57UyUp+aMk4zpkeWgUgtCpDtosHvTZFICwNejTrBfNbWh1WJ2xdANLhSFz
         U/sAD8ie7wso+iBoCXxW5xKqjI/Eln+nEDX2J1Wb50K/dRZRSilcDB4Ru3+NJY5/n3hr
         2WFHHuPpRHONzmwPgFORuJo46IMybx9O8vqqN470OaIL8BDWhtEO7OzXyw7dV7A/IoEw
         MU1esdos//YRpzL2DEgYUm7XeEdKL2jfoQhPEbzWWKcdvv4kqo6EneosLkNfJuFA2L3N
         f/ZccJ3yBBrxgwNhX+P1/3852XmFe/TGTgnBtjQW0TwE3g1gwJKV2jqEmqzHuD6jikgS
         J7Bw==
X-Received: by 10.236.229.130 with SMTP id h2mr24833136yhq.68.1395220919198;
 Wed, 19 Mar 2014 02:21:59 -0700 (PDT)
Received: by 10.170.180.134 with HTTP; Wed, 19 Mar 2014 02:21:59 -0700 (PDT)
In-Reply-To: <lg9l22$qto$1@ger.gmane.org>
X-Google-Sender-Auth: HcY_u7cjFbWHKKso4TYNKGJRIj4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244424>

Thanks for the resubmission. Comments below...

On Tue, Mar 18, 2014 at 10:33 AM, Aleksey Mokhovikov
<moxobukob@gmail.com> wrote:
> Subject: [PATCH][GSOC] Selection of the verbose message is replaced with generated message in install_branch_config()

Say [PATCH v2] to indicate your second attempt.

This subject is quite long. Try to keep it short but informative.
Mention the module or function first. Use imperative voice. You might
say:

    Subject: install_branch_config: replace if-chain with table lookup

> This patch replaces if chain with
> 2 dimensional array of format strings and arguments.

This _is_ a patch, so no need to say so explicitly. Use imperative
voice. You might say:

    Replace if-chain, which selects message in verbose mode, with
    table-driven approach.

> Signed-off-by: Aleksey Mokhovikov <moxobukob@gmail.com>
> ---
> This patch is unrelated with previous one, but related to GSoC.
> So I don't know if I should create new thread for this patch.

Keeping it in the same thread provides continuity which can help
reviewers. Providing a link to the previous attempt, like this [1], is
also courteous to reviewers.

[1]: http://thread.gmane.org/gmane.comp.version-control.git/244237

> Compare with original construction
> Pros:
> 1) Remove if chain.
> 2) Single table contains all messages with arguments in one construction.
> 3) Less code duplication.
> Cons:
> 1) Harder to associate the case with message.
> 2) Harder for compiler to warn the programmer about not
>    enough arguments for format string.
> 3) Harder to add non-string argument to messages.

Nice summary. Do you draw any conclusions from it? Is the new code
better? Easier to understand? Would it be better merely to refactor
the 'if' statements a bit instead of using a table?

> If !!(x) is out of the coding guide, then message_id construction
> can be rewritten in several other ways.
> The guideline tells that !!(x) is not welcome and should not be
> unless needed. But looks like this is normal place for it.

Curious. !!x is indeed used regularly. Where did you read that it is
not welcome?

> P.S.
> Thanks to comments I got, so
> I've read more GNU gettext manual to get info
> about translation workflow. When I posted a first patch
> I've passed the same message format strings to gettext /*_()*/
> as in original, to save the context of the message. And they
> will be translated if every possible string combination
> will be marked separately for translation. Because of
> xgettext can extract string from source automatically,
> it ruins the idea to generate message from parts. Even if the
> exaclty same message format string is passed to gettext.

Indeed, it's a common and understandable misconception.

>  branch.c | 53 ++++++++++++++++++++++++++++++-----------------------
>  1 file changed, 30 insertions(+), 23 deletions(-)
>
> diff --git a/branch.c b/branch.c
> index 723a36b..51a5faf 100644
> --- a/branch.c
> +++ b/branch.c
> @@ -47,12 +47,32 @@ static int should_setup_rebase(const char *origin)
>         return 0;
>  }
>
> +

Unnecessary blank line insertion. This adds noise to the patch which
distracts from the real changes.

>  void install_branch_config(int flag, const char *local, const char *origin, const char *remote)
>  {
>         const char *shortname = remote + 11;
>         int remote_is_branch = starts_with(remote, "refs/heads/");
>         struct strbuf key = STRBUF_INIT;
>         int rebasing = should_setup_rebase(origin);
> +       int message_id = (!!remote_is_branch << 2) | (!!origin << 1) | (!!rebasing);

It works, but it's also a fairly magical incantation, placing greater
cognitive demands on the reader. You could achieve a similar result
with a multi-dimensional table which is indexed directly by
!!remote_is_branch, !!origin, and !!rebasing. (Whether you actually
want to do so is a different question.)

> +       const char *message_table[][4] =
> +               {{N_("Branch %s set up to track local ref %s."),
> +                 local, remote},
> +                {N_("Branch %s set up to track local ref %s by rebasing."),
> +                 local, remote},
> +                {N_("Branch %s set up to track remote ref %s."),
> +                 local, remote},
> +                {N_("Branch %s set up to track remote ref %s by rebasing."),
> +                 local, remote},
> +                {N_("Branch %s set up to track local branch %s."),
> +                 local, shortname},
> +                {N_("Branch %s set up to track local branch %s by rebasing."),
> +                 local, shortname},
> +                {N_("Branch %s set up to track remote branch %s from %s."),
> +                 local, shortname, origin},
> +                {N_("Branch %s set up to track remote branch %s from %s by rebasing."),
> +                 local, shortname, origin}};

Indeed, this is a reasonably decent way to keep the arguments and
messages together and can simplify the code nicely. Unfortunately,
this project is still restricted primarily to C89, so using
non-constant C99 initializers is likely to prevent the patch from
being accepted.

> +       const char **message = NULL;
>
>         if (remote_is_branch
>             && !strcmp(local, shortname)
> @@ -68,7 +88,7 @@ void install_branch_config(int flag, const char *local, const char *origin, cons
>         strbuf_reset(&key);
>         strbuf_addf(&key, "branch.%s.merge", local);
>         git_config_set(key.buf, remote);
> -
> +

Unnecessary whitespace change.

>         if (rebasing) {
>                 strbuf_reset(&key);
>                 strbuf_addf(&key, "branch.%s.rebase", local);
> @@ -77,29 +97,16 @@ void install_branch_config(int flag, const char *local, const char *origin, cons
>         strbuf_release(&key);
>
>         if (flag & BRANCH_CONFIG_VERBOSE) {
> -               if (remote_is_branch && origin)
> -                       printf_ln(rebasing ?
> -                                 _("Branch %s set up to track remote branch %s from %s by rebasing.") :
> -                                 _("Branch %s set up to track remote branch %s from %s."),
> -                                 local, shortname, origin);
> -               else if (remote_is_branch && !origin)
> -                       printf_ln(rebasing ?
> -                                 _("Branch %s set up to track local branch %s by rebasing.") :
> -                                 _("Branch %s set up to track local branch %s."),
> -                                 local, shortname);
> -               else if (!remote_is_branch && origin)
> -                       printf_ln(rebasing ?
> -                                 _("Branch %s set up to track remote ref %s by rebasing.") :
> -                                 _("Branch %s set up to track remote ref %s."),
> -                                 local, remote);
> -               else if (!remote_is_branch && !origin)
> -                       printf_ln(rebasing ?
> -                                 _("Branch %s set up to track local ref %s by rebasing.") :
> -                                 _("Branch %s set up to track local ref %s."),
> -                                 local, remote);
> +               if ((0 <= message_id) && (message_id < ARRAY_SIZE(message_table)))

Unnecessary parentheses can make the code a bit more difficult to
read, thus should be dropped.

> +                       message = message_table[message_id];
>                 else
> -                       die("BUG: impossible combination of %d and %p",
> -                           remote_is_branch, origin);
> +                       die("BUG: id is out of range:id=%d (is_branch=%d, origin=%p, rebasing=%d)",
> +                           message_id, remote_is_branch, origin, rebasing);

As this is indicates a programmer error, assert() may be more
appropriate, and placed as near the computation of message_id as
possible. The original code used die() because it didn't detect the
error until the end of the if-chain, but you can detect it as soon as
you compute message_id.

> +               if (!message || !message[0])
> +                       die("BUG: message is NULL. Fix verbose message table.");

Meh. May be overkill. If either of these is NULL, you'll get a crash
anyhow, which is a good indication of a bug.

On the other hand, asserting that message_id is in range is a good
idea since an out-of-bounds array access won't necessarily result in a
crash, thus such a bug could go undetected for some time.

> +               printf_ln(_(message[0]), message[1], message[2], message[3]);
>         }
>  }
>
> --
> 1.8.3.2
