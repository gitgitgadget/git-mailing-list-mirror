From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH] git bisect old/new
Date: Tue, 12 Jun 2012 07:25:07 +0200
Message-ID: <CAP8UFD1mgKNQRZpuqYgyL__DGpoZ3cOGJC0amoqWT+1Bn_0iTg@mail.gmail.com>
References: <1339466625-17461-1-git-send-email-Valentin.Duperray@ensimag.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Lucien Kong <Lucien.Kong@ensimag.imag.fr>,
	Franck Jonas <Franck.Jonas@ensimag.imag.fr>,
	Thomas Nguy <Thomas.Nguy@ensimag.imag.fr>,
	Huynh Khoi Nguyen Nguyen 
	<Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Valentin Duperray <Valentin.Duperray@ensimag.imag.fr>
X-From: git-owner@vger.kernel.org Tue Jun 12 07:25:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SeJbQ-0008Cs-V9
	for gcvg-git-2@plane.gmane.org; Tue, 12 Jun 2012 07:25:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752019Ab2FLFZJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 12 Jun 2012 01:25:09 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:52264 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751492Ab2FLFZH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 12 Jun 2012 01:25:07 -0400
Received: by pbbrp8 with SMTP id rp8so295616pbb.19
        for <git@vger.kernel.org>; Mon, 11 Jun 2012 22:25:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=NJ0+eQgGO/FpxYeP86E5uUuBocU/JebXaDikNCucklo=;
        b=NU5mGs6YXw4eFVQUXum9GzBfgOzddFYjPRhZ/jc2Nrc+Gp9Si3VCH2tBhoKJ4cSN5d
         YN/nNcnqJugW9rUD8oa8vIVBAblTfGdBDM4pUizJ+Qu4IdNcUxTMlcI/Y8fHGZct5KOP
         BIZeGRM4aAW3UxsA1SFJd3YliGDg3As8OtauLvr00AfoOrS1/w04R5PvT1S4gvCjid5a
         5gZEhbAw52vdp/J1GkOTN2SnWxlgb/FK84D6sDQItwyBS87BVUfEgnnNCaSzjtzh6GN0
         aKBUqe1XMWkBZsAj/oQG2iyZYA4Pk5/wSzqmt8xn1hhLLKExAqC5V282PWe2a8zk92Ia
         l9tA==
Received: by 10.68.197.198 with SMTP id iw6mr34016889pbc.36.1339478707108;
 Mon, 11 Jun 2012 22:25:07 -0700 (PDT)
Received: by 10.142.234.9 with HTTP; Mon, 11 Jun 2012 22:25:07 -0700 (PDT)
In-Reply-To: <1339466625-17461-1-git-send-email-Valentin.Duperray@ensimag.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199763>

Hi,

On Tue, Jun 12, 2012 at 4:03 AM, Valentin Duperray
<Valentin.Duperray@ensimag.imag.fr> wrote:
> When not looking for a regression during a bisect but for a fix or a
> change in another given property, it can be confusing to use 'good'
> and 'bad'.
> This patch introduce `git bisect new` and `git bisect old` as an
> alternative to 'bad' and good' : the commits which have the most
> recent version of the property must be marked as `new` and the ones
> with the older version as `old`.
> The output will be the first commit after the change in the property.
> During a new/old bisect session you cannot use bad/good commands and
> vice-versa.
> Some commands are still not available for old/new:
> =A0 =A0 * git bisect start [<new> [<old>...]] is not possible : the
> =A0 =A0 =A0 commits will be treated as bad and good.
> =A0 =A0 * git rev-list --bisect does not treat the revs/bisect/new an=
d
> =A0 =A0 =A0 revs/bisect/old-SHA1 files.
> =A0 =A0 * thus, git bisect run <cmd> is not available for new/old.
> =A0 =A0 * git bisect visualize seem to work partially : the tags are
> =A0 =A0 =A0 displayed correctly but the tree is not limited to the bi=
sect
> =A0 =A0 =A0 section.
>
> Signed-off-by: Valentin Duperray <Valentin.Duperray@ensimag.imag.fr>
> Signed-off-by: Lucien Kong <Lucien.Kong@ensimag.imag.fr>
> Signed-off-by: Franck Jonas <Franck.Jonas@ensimag.imag.fr>
> Signed-off-by: Thomas Nguy <Thomas.Nguy@ensimag.imag.fr>
> Signed-off-by: Huynh Khoi Nguyen Nguyen <Huynh-Khoi-Nguyen.Nguyen@ens=
imag.imag.fr>
> Signed-off-by: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>

If you used some design that was discussed on the mailing list or if
there have been relevant discussions on the mailing list, it would be
nice to have links to the email thread in the commit message.

> ---
> =A0Documentation/git-bisect.txt | =A0 40 +++++++++++++++
> =A0bisect.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 88 ++++++++=
++++++++++++++++---------
> =A0git-bisect.sh =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0113 ++++++++++++=
++++++++++++++++++++---------
> =A0t/t6030-bisect-porcelain.sh =A0| =A0 33 ++++++++++++
> =A04 files changed, 226 insertions(+), 48 deletions(-)
>
> diff --git a/Documentation/git-bisect.txt b/Documentation/git-bisect.=
txt
> index e4f46bc..25673c9 100644
> --- a/Documentation/git-bisect.txt
> +++ b/Documentation/git-bisect.txt
> @@ -20,6 +20,8 @@ on the subcommand:
> =A0git bisect start [--no-checkout] [<bad> [<good>...]] [--] [<paths>=
=2E..]
> =A0git bisect bad [<rev>]
> =A0git bisect good [<rev>...]
> + git bisect new [<rev>]
> + git bisect old [<rev>...]

maybe:

git bisect (bad|new) [<rev>]
git bisect (good|old) [<rev>...]

> =A0git bisect skip [(<rev>|<range>)...]
> =A0git bisect reset [<commit>]
> =A0git bisect visualize
> @@ -104,6 +106,44 @@ For example, `git bisect reset HEAD` will leave =
you on the current
> =A0bisection commit and avoid switching commits at all, while `git bi=
sect
> =A0reset bisect/bad` will check out the first bad revision.
>
> +Alternative research: bisect new and bisect old
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +If you are not looking for a regression but for a change of a given
> +property, you can use:

I would rather say:

Alternative terms: bisect new and bisect old
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

If you are not at ease with the terms "bad" and "good", perhaps
because you are looking for the commit that introduced a fix, you can
alternatively use "new" and "old" instead.
But note that you cannot mix "bad" and good" with "new" and "old".

------------------------------------------------
git bisect new [<rev>]
------------------------------------------------

Same as "git bisect bad [<rev>]".

------------------------------------------------
git bisect old [<rev>...]
------------------------------------------------

Same as "git bisect good [<rev>...]".

> +
> +------------------------------------------------
> +git bisect new [<rev>]
> +------------------------------------------------
> +
> +Mark the commits that have the new version of the property.
> +
> +------------------------------------------------
> +git bisect old [<rev>...]
> +------------------------------------------------
> +
> +Mark the commits that have the old version of the property.
> +
> +For example, when looking for a fix in the code, the "new" commits a=
re
> +the fixed ones and the "old" commits are the unfixed ones.

Please put this in the example section of the doc.

> +------------------------------------------------
> +$ git bisect start
> +$ git bisect new =A0 =A0 =A0 =A0 =A0 =A0 =A0 # Current version is fi=
xed
> +$ git bisect old bugged_version =A0 =A0 =A0 =A0# bugged_version was =
the last version
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 # known=
 to be unfixed
> +------------------------------------------------
> +
> +At the end of the commit session, you will have the first commit tha=
t
> +have the new version of the property ("fixed" here).
> +
> +You must run `git bisect start` without commits as argument and run
> +`git bisect new <rev>`/`git bisect old <rev>...` after to add the
> +commits.
> +The bisect old/new sessions and the good/bad ones cannot be mixed.
> +You must use `git bisect reset` and start again in order to change
> +the mode.
> +
> =A0Bisect visualize
> =A0~~~~~~~~~~~~~~~~
>
> diff --git a/bisect.c b/bisect.c
> index 48acf73..474b615 100644
> --- a/bisect.c
> +++ b/bisect.c
> @@ -21,6 +21,9 @@ static const char *argv_checkout[] =3D {"checkout",=
 "-q", NULL, "--", NULL};
> =A0static const char *argv_show_branch[] =3D {"show-branch", NULL, NU=
LL};
> =A0static const char *argv_update_ref[] =3D {"update-ref", "--no-dere=
f", "BISECT_HEAD", NULL, NULL};
>
> +static const char *bisect_term_bad;
> +static const char *bisect_term_good;
> +
> =A0/* bits #0-15 in revision.h */
>
> =A0#define COUNTED =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(1u<<16)
> @@ -403,9 +406,10 @@ struct commit_list *find_bisection(struct commit=
_list *list,
> =A0static int register_ref(const char *refname, const unsigned char *=
sha1,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0int flags, void *cb_da=
ta)
> =A0{
> - =A0 =A0 =A0 if (!strcmp(refname, "bad")) {
> + =A0 =A0 =A0 if (!strcmp(refname, bisect_term_bad)) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0current_bad_sha1 =3D sha1;
> - =A0 =A0 =A0 } else if (!prefixcmp(refname, "good-")) {
> + =A0 =A0 =A0 } else if (!prefixcmp(refname, "good-") ||
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 !prefixcmp(refname, "ol=
d-")) {

I don't like very much "good" and "old" to be hardcoded here.

> @@ -731,18 +735,25 @@ static void handle_bad_merge_base(void)
> =A0 =A0 =A0 =A0if (is_expected_rev(current_bad_sha1)) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0char *bad_hex =3D sha1_to_hex(current_=
bad_sha1);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0char *good_hex =3D join_sha1_array_hex=
(&good_revs, ' ');
> -
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 fprintf(stderr, "The merge base %s is b=
ad.\n"
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "This means the bug has=
 been fixed "
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "between %s and [%s].\n=
",
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 bad_hex, bad_hex, good_=
hex);
> -
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!strcmp(bisect_term_bad,"bad")) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 fprintf(stderr, "The me=
rge base %s is bad.\n"
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "This m=
eans the bug has been fixed "
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "betwee=
n %s and [%s].\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 bad_hex=
, bad_hex, good_hex);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 fprintf(stderr, "The me=
rge base %s is new.\n"
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "The pr=
operty has changed "
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "betwee=
n %s and [%s].\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 bad_hex=
, bad_hex, good_hex);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }

I don't like very much "new" to be harcoded here too.

>
> =A0/*
> - * "check_merge_bases" checks that merge bases are not "bad".
> + * "check_merge_bases" checks that merge bases are not "bad" (resp. =
"new").
> =A0*
> - * - If one is "bad", it means the user assumed something wrong
> + * - If one is "bad" (resp. "new"), it means the user assumed someth=
ing wrong
> =A0* and we must exit with a non 0 error code.
> - * - If one is "good", that's good, we have nothing to do.
> + * - If one is "good" (resp. "old"), that's good, we have nothing to=
 do.
> =A0* - If one is "skipped", we can't know but we should warn.
> =A0* - If we don't know, we should check it out and ask the user to t=
est.
> =A0*/

I am not sure changing the comments is worth it...

> @@ -825,7 +836,8 @@ static int check_ancestors(const char *prefix)
>
> =A0/*
> =A0* "check_good_are_ancestors_of_bad" checks that all "good" revs ar=
e
> - * ancestor of the "bad" rev.
> + * ancestor of the "bad" rev. (resp. all "old" revs are ancestor of
> + * the "new" rev).

=2E..because we don't change the name of the function anyway.

> =A0*
> =A0* If that's not the case, we need to check the merge bases.
> =A0* If a merge base must be tested by the user, its source code will=
 be
> @@ -838,7 +850,7 @@ static void check_good_are_ancestors_of_bad(const=
 char *prefix, int no_checkout)
> =A0 =A0 =A0 =A0int fd;
>
> =A0 =A0 =A0 =A0if (!current_bad_sha1)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 die("a bad revision is needed");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 die("a %s revision is needed", bisect_t=
erm_bad);
>
> =A0 =A0 =A0 =A0/* Check if file BISECT_ANCESTORS_OK exists. */
> =A0 =A0 =A0 =A0if (!stat(filename, &st) && S_ISREG(st.st_mode))
> @@ -889,6 +901,30 @@ static void show_diff_tree(const char *prefix, s=
truct commit *commit)
> =A0}
>
> =A0/*
> + * The terms used for this bisect session are stocked in
> + * BISECT_TERMS: it can be bad/good or new/old.

I am not sure saying "it can be bad/good or new/old" adds anything.
You could just say: the defaults are "bad"/"good"

> + * We read them and stock them to adapt the messages
> + * accordingly.
> + */
> +void read_bisect_terms(void)
> +{
> + =A0 =A0 =A0 struct strbuf str =3D STRBUF_INIT;
> + =A0 =A0 =A0 const char *filename =3D git_path("BISECT_TERMS");
> + =A0 =A0 =A0 FILE *fp =3D fopen(filename, "r");
> +
> + =A0 =A0 =A0 if (!fp)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 die_errno("Could not open file '%s'", f=
ilename);

This is not very compatible with older git versions.
I know that it's kind of strange to upgrade git in the middle of a
bisection but why not just use "bad"/"good" if there is no file?

> + =A0 =A0 =A0 strbuf_getline(&str, fp, '\n');
> + =A0 =A0 =A0 bisect_term_bad =3D strbuf_detach(&str, NULL);
> + =A0 =A0 =A0 strbuf_getline(&str, fp, '\n');
> + =A0 =A0 =A0 bisect_term_good =3D strbuf_detach(&str, NULL);
> +
> + =A0 =A0 =A0 strbuf_release(&str);
> + =A0 =A0 =A0 fclose(fp);
> +}
> +
> +/*
> =A0* We use the convention that exiting with an exit code 10 means th=
at
> =A0* the bisection process finished successfully.
> =A0* In this case the calling shell script should exit 0.
> @@ -898,6 +934,8 @@ static void show_diff_tree(const char *prefix, st=
ruct commit *commit)
> =A0*/
> =A0int bisect_next_all(const char *prefix, int no_checkout)
> =A0{
> + =A0 =A0 =A0 read_bisect_terms();
> +
> =A0 =A0 =A0 =A0struct rev_info revs;
> =A0 =A0 =A0 =A0struct commit_list *tried;
> =A0 =A0 =A0 =A0int reaches =3D 0, all =3D 0, nr, steps;

We put all declarations at the beginning of functions.

> @@ -920,13 +958,14 @@ int bisect_next_all(const char *prefix, int no_=
checkout)
>
> =A0 =A0 =A0 =A0if (!revs.commits) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/*
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* We should exit here only if the "b=
ad"
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* We should exit here only if the "b=
ad" (or "new")

Again I don't think it's worth changing comments.

> diff --git a/git-bisect.sh b/git-bisect.sh
> index 99efbe8..152b4f3 100755
> --- a/git-bisect.sh
> +++ b/git-bisect.sh
> @@ -1,6 +1,6 @@
> =A0#!/bin/sh
>
> -USAGE=3D'[help|start|bad|good|skip|next|reset|visualize|replay|log|r=
un]'
> +USAGE=3D'[help|start|bad|good|skip|next|reset|visualize|replay|log|r=
un|new|old]'
> =A0LONG_USAGE=3D'git bisect help
> =A0 =A0 =A0 =A0print this long help message.
> =A0git bisect start [--no-checkout] [<bad> [<good>...]] [--] [<pathsp=
ec>...]
> @@ -22,7 +22,15 @@ git bisect replay <logfile>
> =A0git bisect log
> =A0 =A0 =A0 =A0show bisect log.
> =A0git bisect run <cmd>...
> - =A0 =A0 =A0 use <cmd>... to automatically bisect.
> + =A0 =A0 =A0 use <cmd>... to automatically bisect

Why this change?

> +
> +When looking for a change in a given property instead of a regressio=
n
> +you can use
> +
> +git bisect new [<rev>]
> + =A0 =A0 =A0 mark <rev> as not having the property anymore
> +git bisect old [<rev>]

It is: [<rev>...]

> + =A0 =A0 =A0 mark <rev>... as having the property

But anyway if possible I'd rather have:

git bisect (bad|new) [<rev>]
git bisect (good|old) [<rev>...]

> =A0Please use "git help bisect" to get the full man page.'
>
> @@ -32,6 +40,8 @@ OPTIONS_SPEC=3D
>
> =A0_x40=3D'[0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f]'
> =A0_x40=3D"$_x40$_x40$_x40$_x40$_x40$_x40$_x40$_x40"
> +NEW=3D"bad"
> +OLD=3D"good"

Why not BISECT_BAD_TERM/BISECT_GOOD_TERM instead of NEW/OLD?
It should be consistent with bisect.c

>
> =A0bisect_head()
> =A0{
> @@ -66,7 +76,7 @@ bisect_autostart() {
>
> =A0bisect_start() {
> =A0 =A0 =A0 =A0#
> - =A0 =A0 =A0 # Check for one bad and then some good revisions.
> + =A0 =A0 =A0 # Check for one bad (or new) and then some good (or old=
) revisions.

I don't think it's worth changing the comments.

> @@ -184,8 +210,8 @@ bisect_write() {
> =A0 =A0 =A0 =A0rev=3D"$2"
> =A0 =A0 =A0 =A0nolog=3D"$3"
> =A0 =A0 =A0 =A0case "$state" in
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 bad) =A0 =A0 =A0 =A0 =A0 =A0tag=3D"$sta=
te" ;;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 good|skip) =A0 =A0 =A0tag=3D"$state"-"$=
rev" ;;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 bad|new) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
tag=3D"$state" ;;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 good|skip|old) =A0tag=3D"$state"-"$rev"=
 ;;

Why not "$BISECT_TERM_BAD" instead of "bad|new" and
"$BISECT_TERM_GOOD|skip" instead of "good|skip|old"?

> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*) =A0 =A0 =A0 =A0 =A0 =A0 =A0die "$(e=
val_gettext "Bad bisect_write argument: \$state")" ;;
> =A0 =A0 =A0 =A0esac
> =A0 =A0 =A0 =A0git update-ref "refs/bisect/$tag" "$rev" || exit
> @@ -230,12 +256,12 @@ bisect_state() {
> =A0 =A0 =A0 =A0case "$#,$state" in
> =A0 =A0 =A0 =A00,*)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0die "$(gettext "Please call 'bisect_st=
ate' with at least one argument.")" ;;
> - =A0 =A0 =A0 1,bad|1,good|1,skip)
> + =A0 =A0 =A0 1,bad|1,good|1,skip|1,new|1,old)

Idem.

> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0rev=3D$(git rev-parse --verify $(bisec=
t_head)) ||
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0die "$(gettext "Bad re=
v input: $(bisect_head)")"
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0bisect_write "$state" "$rev"
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0check_expected_revs "$rev" ;;
> - =A0 =A0 =A0 2,bad|*,good|*,skip)
> + =A0 =A0 =A0 2,bad|*,good|*,skip|2,new|*,old)

Idem.

> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0shift
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0eval=3D''
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0for rev in "$@"
> @@ -246,8 +272,8 @@ bisect_state() {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0done
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0eval "$eval"
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0check_expected_revs "$@" ;;
> - =A0 =A0 =A0 *,bad)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 die "$(gettext "'git bisect bad' can ta=
ke only one argument.")" ;;
> + =A0 =A0 =A0 *,bad|*,new)

Idem.

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 die "$(gettext "'git bisect $NEW' can t=
ake only one argument.")" ;;
> =A0 =A0 =A0 =A0*)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0usage ;;
> =A0 =A0 =A0 =A0esac
> @@ -256,21 +282,21 @@ bisect_state() {
>
> =A0bisect_next_check() {
> =A0 =A0 =A0 =A0missing_good=3D missing_bad=3D
> - =A0 =A0 =A0 git show-ref -q --verify refs/bisect/bad || missing_bad=
=3Dt
> - =A0 =A0 =A0 test -n "$(git for-each-ref "refs/bisect/good-*")" || m=
issing_good=3Dt
> + =A0 =A0 =A0 git show-ref -q --verify refs/bisect/$NEW || missing_ba=
d=3Dt
> + =A0 =A0 =A0 test -n "$(git for-each-ref "refs/bisect/$OLD-*")" || m=
issing_good=3Dt
>
> =A0 =A0 =A0 =A0case "$missing_good,$missing_bad,$1" in
> =A0 =A0 =A0 =A0,,*)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 : have both good and bad - ok
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 : have both good and bad or old and new=
 - ok
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0;;
> =A0 =A0 =A0 =A0*,)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0# do not have both but not asked to fa=
il - just report.
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0false
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0;;
> - =A0 =A0 =A0 t,,good)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 # have bad but not good. =A0we could bi=
sect although
> + =A0 =A0 =A0 t,,good|t,,old)

Idem.


Thanks,
Christian.
