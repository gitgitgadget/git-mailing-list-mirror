From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATHv2] branch.c:install_branch_config():Simplify code
 generating verbose message.
Date: Tue, 11 Mar 2014 06:16:49 -0400
Message-ID: <CAPig+cQdbXz_s2-i0eTOq+rmacNWUvvCbeSZ4Z=JY39oNKFQ_Q@mail.gmail.com>
References: <1394527207-23065-1-git-send-email-pawlo@aleg.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: =?UTF-8?Q?Pawe=C5=82_Wawruch?= <pawlo@aleg.pl>
X-From: git-owner@vger.kernel.org Tue Mar 11 11:17:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WNJk3-0003qc-RS
	for gcvg-git-2@plane.gmane.org; Tue, 11 Mar 2014 11:17:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755211AbaCKKQw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 11 Mar 2014 06:16:52 -0400
Received: from mail-yh0-f48.google.com ([209.85.213.48]:38838 "EHLO
	mail-yh0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754917AbaCKKQu convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 11 Mar 2014 06:16:50 -0400
Received: by mail-yh0-f48.google.com with SMTP id z6so8284018yhz.21
        for <git@vger.kernel.org>; Tue, 11 Mar 2014 03:16:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=muTTzWzpt/wIztfZlUl0NsJzfVLKN5Yy28gDCsaLGh8=;
        b=lgiTESS2kE/RIFVUrfNNPuWUeS12MVdnr43wtozRM9guj4vM2lROm5RLvvuXIQ7uvF
         0GireHNqmLylsDU1Logq0axor1hZOr/QKnD7u3Iz8PU9XuoPTdYHkeST2DRVkNdYRMUl
         Nvc63KCx+vOw1kWJcJ+sQIRkAtUFafADVu29DT8fKi3lH/iwXALeanhQdj3sSTqGsdgV
         mmI3n/FQGRNDpywaF1wkT+HrkIE5ibKRh8C+eTcfARsi13MWmmqLBkO8sfK2yHBRcQXG
         o9myvBbfp65jec72N7bcs0e09mCH2M4eKrLFQ9CIEfKWgTClASCya/+LrfVPVaTB4Wie
         d8YQ==
X-Received: by 10.236.114.43 with SMTP id b31mr28155816yhh.30.1394533009449;
 Tue, 11 Mar 2014 03:16:49 -0700 (PDT)
Received: by 10.170.180.134 with HTTP; Tue, 11 Mar 2014 03:16:49 -0700 (PDT)
In-Reply-To: <1394527207-23065-1-git-send-email-pawlo@aleg.pl>
X-Google-Sender-Auth: 1ORfKhLx0dc4hWtc7ezSg_oWVyg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243852>

Thanks for taking review comments from your previous attempt into
account. This is a more well-crafted submission. Additional comments
below.

On Tue, Mar 11, 2014 at 4:40 AM, Pawe=C5=82 Wawruch <pawlo@aleg.pl> wro=
te:
> Subject: [PATHv2] branch.c:install_branch_config():Simplify code gene=
rating verbose message.

PATCH is misspelled as PATH. Adding the v2 is indeed good etiquette.
It's typical to have a space between PATCH and vN.

Insert a space before "Simplify".

SubmittingPatches suggests omitting the final period in the subject.
Also downcase "simplify".

> Simplify the long if chain in install_branch_config().

A bit misleading. You're not actually simplifying the 'if' chain, but
rather replacing it.

> There is a long chain of if statements. The code can be more clear.
> Replace the chain with table of strings. New approach is more
> compact.

The first sentence merely repeats what was said earlier. It can be
dropped. The second sentence is self-evident since you already talk
about "simplification" and also can be dropped, as can the fourth
sentence. The third sentence is a good explanation of how the code is
being simplified and should be kept. You could, therefore, collapse
the commit message to something along these lines:

    Subject: install_branch_config: simplify verbose diagnostic logic

    Replace the 'if' chain with a table of strings.

> Signed-off-by: Pawe=C5=82 Wawruch <pawlo@aleg.pl>
> ---

It is considerate to reviewers to provide a link to the previous
version of the patch, like this [1], and to explain what changed in
this version relative to the last. This area just below the "---" line
after your sign off is where you would write such commentary.

[1]: http://thread.gmane.org/gmane.comp.version-control.git/243502

>  branch.c | 40 ++++++++++++++++++----------------------
>  1 file changed, 18 insertions(+), 22 deletions(-)
>
> diff --git a/branch.c b/branch.c
> index 723a36b..8d3b219 100644
> --- a/branch.c
> +++ b/branch.c
> @@ -53,6 +53,18 @@ void install_branch_config(int flag, const char *l=
ocal, const char *origin, cons
>         int remote_is_branch =3D starts_with(remote, "refs/heads/");
>         struct strbuf key =3D STRBUF_INIT;
>         int rebasing =3D should_setup_rebase(origin);
> +       const char *messages[] =3D {
> +               N_("Branch %s set up to track remote branch %s from %=
s by rebasing."),
> +               N_("Branch %s set up to track remote branch %s from %=
s."),
> +               N_("Branch %s set up to track local branch %s by reba=
sing."),
> +               N_("Branch %s set up to track local branch %s."),
> +               N_("Branch %s set up to track remote ref %s by rebasi=
ng."),
> +               N_("Branch %s set up to track remote ref %s."),
> +               N_("Branch %s set up to track local ref %s by rebasin=
g."),
> +               N_("Branch %s set up to track local ref %s.")
> +       };

On this project, arrays are usually (though not consistently) named in
singular form (for instance message[]) so that a reference to a single
item, such as message[42], reads more grammatically correct.

> +       const char *name =3D remote_is_branch ? remote : shortname;
> +       int message_number;
>
>         if (remote_is_branch
>             && !strcmp(local, shortname)
> @@ -77,29 +89,13 @@ void install_branch_config(int flag, const char *=
local, const char *origin, cons
>         strbuf_release(&key);
>
>         if (flag & BRANCH_CONFIG_VERBOSE) {
> -               if (remote_is_branch && origin)
> -                       printf_ln(rebasing ?
> -                                 _("Branch %s set up to track remote=
 branch %s from %s by rebasing.") :
> -                                 _("Branch %s set up to track remote=
 branch %s from %s."),
> -                                 local, shortname, origin);
> -               else if (remote_is_branch && !origin)
> -                       printf_ln(rebasing ?
> -                                 _("Branch %s set up to track local =
branch %s by rebasing.") :
> -                                 _("Branch %s set up to track local =
branch %s."),
> -                                 local, shortname);
> -               else if (!remote_is_branch && origin)
> -                       printf_ln(rebasing ?
> -                                 _("Branch %s set up to track remote=
 ref %s by rebasing.") :
> -                                 _("Branch %s set up to track remote=
 ref %s."),
> -                                 local, remote);
> -               else if (!remote_is_branch && !origin)
> -                       printf_ln(rebasing ?
> -                                 _("Branch %s set up to track local =
ref %s by rebasing.") :
> -                                 _("Branch %s set up to track local =
ref %s."),
> -                                 local, remote);
> +               message_number =3D (!!rebasing) + 2 * (!!origin) + 4 =
* (!!remote_is_branch);

Unnecessary parentheses make the code more cumbersome to read and
should be dropped.

> +               assert(message_number < ARRAY_SIZE(messages));
> +
> +               if (message_number < 2)
> +                       printf_ln(messages[message_number], local, na=
me, origin);

Even though the strings are marked for translation via N_() in the
initializer, they still need to be passed through _() when they are
actually used, so the invocation should be:

    printf_ln(_(messages[message_number]), local, name, origin);

Ditto for the printf_ln() below.

See section 4.7 of the GNU gettext manual [2] for an explanation (and
note that N_() is shorthand for gettext_noop() mentioned in the
manual).

[2]: http://www.gnu.org/software/gettext/manual/gettext.html

>                 else
> -                       die("BUG: impossible combination of %d and %p=
",
> -                           remote_is_branch, origin);
> +                       printf_ln(messages[message_number], local, na=
me);
>         }

Although this approach of making message retrieval table-driven does
collapse the code a bit, it's not obvious that it is indeed more
clear. Magical incantations, such as '!!rebasing + 2 * !!origin + 4 *
!!remote_is_branch' and 'if (message_number < 2)', convey little
immediate meaning, demand a greater cognitive load, and may make the
code less straightforward to modify in the future. Have you considered
other ways of making the code table-driven which exhibit fewer
shortcomings?

>  }
>
> --
> 1.8.3.2
