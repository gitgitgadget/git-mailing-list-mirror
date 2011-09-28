From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: Re: Re* [PATCH 2/2] grep --no-index: don't use git standard exclusions
Date: Wed, 28 Sep 2011 21:19:08 +0200
Message-ID: <CAKPyHN3=mbtEkyFUBdZAJCEVXfJhwPVhVFWkNNfX-yhtw9498w@mail.gmail.com>
References: <2f376e61802a1a38c67698d5ec263d1807b1fcee.1316110876.git.bert.wesarg@googlemail.com>
	<7b3551dd84a2bfec78c8db1d14dd2d0e6dda35f6.1316110876.git.bert.wesarg@googlemail.com>
	<7vmxe5pp4n.fsf@alter.siamese.dyndns.org>
	<CAKPyHN2ewwLf6am3VQr_z4c3_Q5=saeLcZtuY-fEtUGr-41rKQ@mail.gmail.com>
	<7vty7xwrsf.fsf_-_@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 28 21:19:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R8zf3-0000qG-4J
	for gcvg-git-2@lo.gmane.org; Wed, 28 Sep 2011 21:19:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755191Ab1I1TTM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 28 Sep 2011 15:19:12 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:49305 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753599Ab1I1TTK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 28 Sep 2011 15:19:10 -0400
Received: by bkbzt4 with SMTP id zt4so8374340bkb.19
        for <git@vger.kernel.org>; Wed, 28 Sep 2011 12:19:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=k51SZjGX6aa13jwWzCtzmgHq8QqBb9peEIYx8X/p6ck=;
        b=bPIg6E8Nege9AKDjhrQK7BnHeUj2Qzj0fTmFZKcqqO5Blk0p/o/+mUuCoE9BePsrpv
         K7342/+jXMGzie8zFwVCuPg1ryJsl0CasKN6dtYSJ1GN6bUUt7J24T1oMzLGPy38XmB2
         REQD27mbiEkcWPK0CtVLLzOrt2dZDmU/4KG4g=
Received: by 10.223.6.26 with SMTP id 26mr3906847fax.40.1317237549304; Wed, 28
 Sep 2011 12:19:09 -0700 (PDT)
Received: by 10.223.100.9 with HTTP; Wed, 28 Sep 2011 12:19:08 -0700 (PDT)
In-Reply-To: <7vty7xwrsf.fsf_-_@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182361>

On Wed, Sep 28, 2011 at 00:21, Junio C Hamano <gitster@pobox.com> wrote=
:
> Bert Wesarg <bert.wesarg@googlemail.com> writes:
>
>> Would '--untracked-too' only be a synonym for '--no-index
>> --exclude-standard', i.e. the current behavior?
>
> That basically would be the idea. Perhaps something like this on top =
of
> a9e6436 (grep --no-index: don't use git standard exclusions, 2011-09-=
15).
>
> -- >8 --
> Subject: [PATCH 1/2] grep: teach --untracked and --exclude options

I would still vote to name the option --exclude-standard, like it is
done in 'git ls-files'. Which also has a --exclude=3D<pattern> option.
And I think a --exclude=3D<pattern> option would be useful for 'git
grep', too.

Else:

Acked-by: Bert Wesarg <bert.wesarg@googlemail.com>

Thanks.

Bert

>
> In a working tree of a git managed repository, "grep --untracked" wou=
ld
> find the specified patterns from files in untracked files in addition=
 to
> its usual behaviour of finding them in the tracked files.
>
> By default, when working with "--no-index" option, "grep" does not pa=
y
> attention to .gitignore mechanism. "grep --no-index --exclude" can be
> used to tell the command to use .gitignore and stop reporting hits fr=
om
> files that would be ignored. Also, when working without "--no-index",
> "grep" honors .gitignore mechanism, and "grep --no-exclude" can be us=
ed
> to tell the command to include hits from files that are ignored.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
> =C2=A0Documentation/git-grep.txt | =C2=A0 15 ++++++++++++++-
> =C2=A0builtin-grep.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A0=
 25 ++++++++++++++++++-------
> =C2=A02 files changed, 32 insertions(+), 8 deletions(-)
>
> diff --git a/Documentation/git-grep.txt b/Documentation/git-grep.txt
> index e019e76..2ccfb90 100644
> --- a/Documentation/git-grep.txt
> +++ b/Documentation/git-grep.txt
> @@ -9,7 +9,7 @@ git-grep - Print lines matching a pattern
> =C2=A0SYNOPSIS
> =C2=A0--------
> =C2=A0[verse]
> -'git grep' [--cached]
> +'git grep' [--cached] [--untracked] [--excludes]
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 [-a | --text] [-I] [-i | --ignore-=
case] [-w | --word-regexp]
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 [-v | --invert-match] [-h|-H] [--f=
ull-name]
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 [-E | --extended-regexp] [-G | --b=
asic-regexp]
> @@ -36,6 +36,19 @@ OPTIONS
> =C2=A0 =C2=A0 =C2=A0 =C2=A0Instead of searching in the working tree f=
iles, check
> =C2=A0 =C2=A0 =C2=A0 =C2=A0the blobs registered in the index file.
>
> +--untracked::
> + =C2=A0 =C2=A0 =C2=A0 In addition to searching in the tracked files =
in the working
> + =C2=A0 =C2=A0 =C2=A0 tree, search also in untracked files.
> +
> +--no-excludes::
> + =C2=A0 =C2=A0 =C2=A0 Also search in ignored files by not honoring t=
he `.gitignore`
> + =C2=A0 =C2=A0 =C2=A0 mechanism. Only useful with `--untracked`.
> +
> +--excludes::
> + =C2=A0 =C2=A0 =C2=A0 Do not pay attention to ignored files specifie=
d via the `.gitignore`
> + =C2=A0 =C2=A0 =C2=A0 mechanism. =C2=A0Only useful when searching fi=
les in the current directory
> + =C2=A0 =C2=A0 =C2=A0 with `--no-index`.
> +
> =C2=A0-a::
> =C2=A0--text::
> =C2=A0 =C2=A0 =C2=A0 =C2=A0Process binary files as if they were text.
> diff --git a/builtin-grep.c b/builtin-grep.c
> index a10946d..c6cfdf8 100644
> --- a/builtin-grep.c
> +++ b/builtin-grep.c
> @@ -646,12 +646,14 @@ static int grep_object(struct grep_opt *opt, co=
nst char **paths,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0die("unable to grep from object of type %s=
", typename(obj->type));
> =C2=A0}
>
> -static int grep_directory(struct grep_opt *opt, const char **paths)
> +static int grep_directory(struct grep_opt *opt, const char **paths, =
int exc_std)
> =C2=A0{
> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct dir_struct dir;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0int i, hit =3D 0;
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0memset(&dir, 0, sizeof(dir));
> + =C2=A0 =C2=A0 =C2=A0 if (exc_std)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 setup_standard_exc=
ludes(&dir);
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0fill_directory(&dir, paths);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0for (i =3D 0; i < dir.nr; i++) {
> @@ -749,7 +751,7 @@ static int help_callback(const struct option *opt=
, const char *arg, int unset)
> =C2=A0int cmd_grep(int argc, const char **argv, const char *prefix)
> =C2=A0{
> =C2=A0 =C2=A0 =C2=A0 =C2=A0int hit =3D 0;
> - =C2=A0 =C2=A0 =C2=A0 int cached =3D 0;
> + =C2=A0 =C2=A0 =C2=A0 int cached =3D 0, untracked =3D 0, opt_exclude=
 =3D -1;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0int seen_dashdash =3D 0;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0int external_grep_allowed__ignored;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct grep_opt opt;
> @@ -764,6 +766,10 @@ int cmd_grep(int argc, const char **argv, const =
char *prefix)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{ OPTION_BOOLE=
AN, 0, "index", &use_index, NULL,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0"finds in contents not managed by git",
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0PARSE_OPT_NOARG | PARSE_OPT_NEGHELP },
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OPT_BOOLEAN(0, "un=
tracked", &untracked,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 "search in both tracked and untracked files"),
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OPT_SET_INT(0, "ex=
clude", &opt_exclude,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 "search also in ignored files", 1),
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0OPT_GROUP(""),
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0OPT_BOOLEAN('v=
', "invert-match", &opt.invert,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0"show non-matching lines"),
> @@ -950,18 +956,23 @@ int cmd_grep(int argc, const char **argv, const=
 char *prefix)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0paths[1] =3D N=
ULL;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>
> - =C2=A0 =C2=A0 =C2=A0 if (!use_index) {
> + =C2=A0 =C2=A0 =C2=A0 if (!use_index && (untracked || cached))
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 die("--cached or -=
-untracked cannot be used with --no-index.");
> +
> + =C2=A0 =C2=A0 =C2=A0 if (!use_index || untracked) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int hit;
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (cached)
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 die("--cached cannot be used with --no-index.");
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int use_exclude =3D=
 (opt_exclude < 0) ? use_index : !!opt_exclude;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (list.nr)
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 die("--no-index cannot be used with revs.");
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 hit =3D grep_direc=
tory(&opt, paths);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 die("--no-index or --untracked cannot be used with revs.");
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 hit =3D grep_direc=
tory(&opt, paths, use_exclude);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (use_thread=
s)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0hit |=3D wait_all();
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return !hit;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>
> + =C2=A0 =C2=A0 =C2=A0 if (0 <=3D opt_exclude)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 die("--exclude or =
--no-exclude cannot be used for tracked contents.");
> +
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!list.nr) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int hit;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!cached)
> --
> 1.7.7.rc3.4.g8d714
>
>
>
