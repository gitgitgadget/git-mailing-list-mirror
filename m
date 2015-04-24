From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] blame: add blame.showemail config option
Date: Fri, 24 Apr 2015 01:22:33 -0400
Message-ID: <CAPig+cQrUPHOaKjNhsmLho+bFdAOQxb0NK2YK2QsFmdDBF6h4g@mail.gmail.com>
References: <1429841612-5131-1-git-send-email-qneill@quicinc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Quentin Neill <quentin.neill@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 24 07:22:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YlW4V-0004Y9-6t
	for gcvg-git-2@plane.gmane.org; Fri, 24 Apr 2015 07:22:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754493AbbDXFWe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Apr 2015 01:22:34 -0400
Received: from mail-ig0-f180.google.com ([209.85.213.180]:36183 "EHLO
	mail-ig0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754446AbbDXFWe (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Apr 2015 01:22:34 -0400
Received: by igblo3 with SMTP id lo3so6506206igb.1
        for <git@vger.kernel.org>; Thu, 23 Apr 2015 22:22:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=eHVoGivaXE3MXTH1kuRZ4UQD22/cjVkOLBLMONT151U=;
        b=TheV7n1RCtc1wGt01eDY9aP2qHjXnnkQqjNtcQvP3JVmLcIsP0r1WKS/h2WzaQhK91
         slKM7kA1x3BYLaQ2Eix0cRYjTtJtBK/5NkdK+KeI70KtDlH8lY63z2L0bjiBaBbhEgBq
         t6A6Sij3NQMRmSv5kVEosxDHriIGnFAq14MNFdCP13PnuA0BSUz//iv9rTAuELZr+BKi
         HeI0fwJS6HBb3xieMuh6fGuy18LsI0m3hto+dVuclZIxmS7OGFNZRy2ftSFAEueSOUpr
         MOTgSrWkiRqCMyvM4RVQiOrAXLiVsKufOuXO8pzACTgQRCPmUYq6Z1X1ZS6pL7Ufg9EO
         5MKQ==
X-Received: by 10.42.250.70 with SMTP id mn6mr7966330icb.78.1429852953374;
 Thu, 23 Apr 2015 22:22:33 -0700 (PDT)
Received: by 10.107.28.132 with HTTP; Thu, 23 Apr 2015 22:22:33 -0700 (PDT)
In-Reply-To: <1429841612-5131-1-git-send-email-qneill@quicinc.com>
X-Google-Sender-Auth: 8KezEAm4syC1NAPv5bq3dgKB7RA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267722>

Thanks for the submission. See comments below...

On Thu, Apr 23, 2015 at 10:13 PM, Quentin Neill <quentin.neill@gmail.com> wrote:
> From: Quentin Neill <quentin.neill@gmail.com>

You should drop this line. git-am will pluck your name and email
automatically from the email From: header.

>         If you prefer seeing emails in your git blame output, rather
>         than sprinkling '-e' options everywhere you can just set
>         the new config blame.showemail to true.

Drop the indentation from the commit message.

It's not clear what "everywhere" means in the above. It might be
sufficient to rephrase more simply as:

    Complement existing --show-email option with fallback
    configuration variable.

or something.

> ---

Missing Signed-off-by:. See Documentation/SubmittingPatches.

> diff --git a/Documentation/blame-options.txt b/Documentation/blame-options.txt
> index b299b59..9326115 100644
> --- a/Documentation/blame-options.txt
> +++ b/Documentation/blame-options.txt
> @@ -1,6 +1,11 @@
>  -b::
>         Show blank SHA-1 for boundary commits.  This can also
>         be controlled via the `blame.blankboundary` config option.
> +-e::
> +--show-email::

Insert a blank line before the "-e" line to separate it from the "-b" paragraph.

> +       Show the author email instead of author name (Default: off).
> +       This can also be controlled via the `blame.showemail` config
> +       option.

Despite being case-insensitive and despite existing inconsistencies,
in documentation, it is customary to use camelCase for configuration
options, so "blame.showEmail".

Also blame.showEmail probably ought to be documented in
Documentation/config.txt (although there is some inconsistency here in
that documentation for the other blame-specific variables is missing
from config.txt, so perhaps that's something that could be addressed
separately).

>  --root::
>         Do not treat root commits as boundaries.  This can also be
> diff --git a/Documentation/git-blame.txt b/Documentation/git-blame.txt
> index 9f23a86..50a9030 100644
> --- a/Documentation/git-blame.txt
> +++ b/Documentation/git-blame.txt
> @@ -73,10 +73,6 @@ include::blame-options.txt[]
>  -s::
>         Suppress the author name and timestamp from the output.
>
> --e::
> ---show-email::
> -       Show the author email instead of author name (Default: off).
> -

It's not clear why you relocated documentation of --show-email from
git-blame.txt to blame-options.txt, and the commit message does not
explain the move. If there's a good reason for the relocation, the
justification should be spelled out so that people reviewing the patch
or looking through history later on will not have to guess about it.

It might also make sense to do the relocation as a separate
preparatory patch of a 2-patch series, in which the patch adding
blame.showemail is the second of the two.

>  -w::
>         Ignore whitespace when comparing the parent's version and
>         the child's to find where the lines came from.
> diff --git a/builtin/blame.c b/builtin/blame.c
> index 06484c2..70bfd0a 100644
> --- a/builtin/blame.c
> +++ b/builtin/blame.c
> @@ -44,6 +44,7 @@ static int max_score_digits;
>  static int show_root;
>  static int reverse;
>  static int blank_boundary;
> +static int show_email;
>  static int incremental;
>  static int xdl_opts;
>  static int abbrev = -1;
> @@ -1926,7 +1927,7 @@ static void emit_other(struct scoreboard *sb, struct blame_entry *ent, int opt)
>                 printf("%.*s", length, hex);
>                 if (opt & OUTPUT_ANNOTATE_COMPAT) {
>                         const char *name;
> -                       if (opt & OUTPUT_SHOW_EMAIL)
> +                       if ((opt & OUTPUT_SHOW_EMAIL) || show_email)

The desired behavior is for a configuration setting to provide a
fallback, and for a command-line option to override the fallback. So,
for instance, if blame.showemail is "true", then --no-show-email
should countermand that. Unfortunately, the way this patch is
implemented, it's impossible to override the setting from the
command-line since show_email==true will always win (when
blame.showemail is "true").

More below.

>                                 name = ci.author_mail.buf;
>                         else
>                                 name = ci.author.buf;
> @@ -2185,6 +2186,10 @@ static int git_blame_config(const char *var, const char *value, void *cb)
>                 blank_boundary = git_config_bool(var, value);
>                 return 0;
>         }
> +       if (!strcmp(var, "blame.showemail")) {
> +               show_email = git_config_bool(var, value);
> +               return 0;
> +       }
>         if (!strcmp(var, "blame.date")) {
>                 if (!value)
>                         return config_error_nonbool(var);

You'll also want to add tests for the new blame.showemail
configuration. There's already one test in t8002-blame.sh which checks
that --show-email works, but you will want tests to ensure that you
get the expected results for all combinations of blame.showemail and
--show-email (including when --show-email is not specified).
