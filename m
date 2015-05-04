From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] fixed translation errors
Date: Mon, 4 May 2015 19:38:53 -0400
Message-ID: <CAPig+cTHqwsmk4xiHG3v6d9uwTmz08NFP0mihRdnTiXQe5E68Q@mail.gmail.com>
References: <5547675a.274ec20a.69fb.ffffce22@mx.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Alangi Derick <alangiderick@gmail.com>,
	Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue May 05 01:39:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YpPwx-0001A6-ES
	for gcvg-git-2@plane.gmane.org; Tue, 05 May 2015 01:39:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751200AbbEDXiz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 May 2015 19:38:55 -0400
Received: from mail-ie0-f171.google.com ([209.85.223.171]:34315 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750990AbbEDXiy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 May 2015 19:38:54 -0400
Received: by iedfl3 with SMTP id fl3so161100404ied.1
        for <git@vger.kernel.org>; Mon, 04 May 2015 16:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:content-type;
        bh=9+hVz9QrpgpkE7I7rmwyjB2rqAAsP8ll7G17BCXZbWk=;
        b=AtRhMWpXPDigWf+opJlk9JMvs5ld6l6qEptq5EL5kIdgQD+i6mHfJMiwfxEyQ8yLUY
         +1qfQT9t7dnVkNQVu3zIBWsvnGKgcUFzfwYA4F0UqDF5chSDkUcS1ARfgqoeQD3TUeOJ
         uzavBmyYz08MxooA4zE7Ky4YaCtLbWvddEqDJ4KT+0G0uAJMJ/4+LhQkJAeNfAsityRA
         TW3j6Ppm2RqQ7m77WZzc1AvV03F2f28rnH9TUBgg6/JSpShuft5wDfnBL6tGgiCOAuLT
         rEHo/iK0J52uFqD0ccOkVKtA2e5W5XS2/EUJ5TDDOM87zfhmkMdO0hcGN7KNggzoL6b+
         1L4w==
X-Received: by 10.107.31.134 with SMTP id f128mr31154240iof.19.1430782734008;
 Mon, 04 May 2015 16:38:54 -0700 (PDT)
Received: by 10.107.28.132 with HTTP; Mon, 4 May 2015 16:38:53 -0700 (PDT)
In-Reply-To: <5547675a.274ec20a.69fb.ffffce22@mx.google.com>
X-Google-Sender-Auth: tOJ6c0v-urQWfnvPrTxvtQEXxC8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268373>

On Sun, May 3, 2015 at 6:19 PM, Alangi Derick <alangiderick@gmail.com> wrote:
> Signed-off-by: Alangi Derick <alangiderick@gmail.com>
> ---
> diff --git a/builtin/apply.c b/builtin/apply.c
> index 0769b09..66d2aba 100644
> --- a/builtin/apply.c
> +++ b/builtin/apply.c
> @@ -2237,7 +2237,7 @@ static void update_pre_post_images(struct image *preimage,
>         if (postlen
>             ? postlen < new - postimage->buf
>             : postimage->len < new - postimage->buf)
> -               die("BUG: caller miscounted postlen: asked %d, orig = %d, used = %d",
> +               die(_("BUG: caller miscounted postlen: asked %d, orig = %d, used = %d"),
>                     (int)postlen, (int) postimage->len, (int)(new - postimage->buf));

This condition represents a bug in Git itself, which should never
trigger. As such, there's probably very little value in having it
translated, and doing so would make extra work for those translating
the messages.

>         /* Fix the length of the whole thing */
> @@ -3342,7 +3342,7 @@ static int load_current(struct image *image, struct patch *patch)
>         unsigned mode = patch->new_mode;
>
>         if (!patch->is_new)
> -               die("BUG: patch to %s is not a creation", patch->old_name);
> +               die(_("BUG: patch to %s is not a creation"), patch->old_name);

Ditto: Internal Git error.

>         pos = cache_name_pos(name, strlen(name));
>         if (pos < 0)
> @@ -3572,7 +3572,7 @@ static int check_to_create(const char *new_name, int ok_if_exists)
>
>                 return EXISTS_IN_WORKTREE;
>         } else if ((errno != ENOENT) && (errno != ENOTDIR)) {
> -               return error("%s: %s", new_name, strerror(errno));
> +               return error(_("%s: %s"), new_name, strerror(errno));

There isn't a whole lot here for translators to work with; no context
or indication of what this message is about. (Perhaps the only thing a
translator can do is adjust whitespace around the colon.) This might
be the sort of case where you want to submit a separate patch which
both fleshes out this error message with enough context for
translators to sink their teeth into, and make the string
translatable.

>         }
>         return 0;
>  }
> @@ -4599,9 +4599,9 @@ int cmd_apply(int argc, const char **argv, const char *prefix_)
>                         apply_usage, 0);
>
>         if (apply_with_reject && threeway)
> -               die("--reject and --3way cannot be used together.");
> +               die(("--reject and --3way cannot be used together."));
>         if (cached && threeway)
> -               die("--cached and --3way cannot be used together.");
> +               die(("--cached and --3way cannot be used together."));

You forgot the '_' in '_(...)' on both of these.

>         if (threeway) {
>                 if (is_not_gitdir)
>                         die(_("--3way outside a repository"));
> @@ -4659,8 +4659,8 @@ int cmd_apply(int argc, const char **argv, const char *prefix_)
>                                whitespace_error),
>                             whitespace_error);
>                 if (applied_after_fixing_ws && apply)
> -                       warning("%d line%s applied after"
> -                               " fixing whitespace errors.",
> +                       warning(_("%d line%s applied after"
> +                               " fixing whitespace errors."),
>                                 applied_after_fixing_ws,
>                                 applied_after_fixing_ws == 1 ? "" : "s");

This sort of pluralization (adding "s") only works in some languages.
To translate this properly use Q_(...). See [1] for details, as well
as existing uses of Q_(...) in Git.

[1]: http://www.gnu.org/savannah-checkouts/gnu/gettext/manual/html_node/Plural-forms.html

>                 else if (whitespace_error)
> --
> 2.4.0.2.g3386abe.dirty
