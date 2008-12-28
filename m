From: Jacob Helwig <jacob.helwig@gmail.com>
Subject: Re: [PATCH] parse-opt: migrate builtin-apply.
Date: Sat, 27 Dec 2008 18:05:26 -0600
Message-ID: <82D1BEE0-0DC3-4A90-8E03-D45D66414EFE@gmail.com>
References: <1230419037-14820-1-git-send-email-vmiklos@frugalware.org>
Mime-Version: 1.0 (iPhone Mail 5G77)
Content-Type: text/plain; charset=utf-8;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Rene Scharfe <rene.scharfe@lsrfire.ath.cx>,
	Git <git@vger.kernel.org>
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Sun Dec 28 01:08:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LGjDF-0005eY-DG
	for gcvg-git-2@gmane.org; Sun, 28 Dec 2008 01:08:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754536AbYL1AFo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 27 Dec 2008 19:05:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754347AbYL1AFn
	(ORCPT <rfc822;git-outgoing>); Sat, 27 Dec 2008 19:05:43 -0500
Received: from yx-out-2324.google.com ([74.125.44.29]:9487 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754163AbYL1AFm convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 27 Dec 2008 19:05:42 -0500
Received: by yx-out-2324.google.com with SMTP id 8so1363333yxm.1
        for <git@vger.kernel.org>; Sat, 27 Dec 2008 16:05:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:references:message-id:from:to
         :in-reply-to:content-type:content-transfer-encoding:x-mailer
         :mime-version:subject:date:cc;
        bh=VS2ldiHGttm5tKZ3jEzqqbheIiCNLwPeHi+uf/tK1fY=;
        b=sGeiDR/CnO/ogVPfJb11ymqiKqWDN/7CcBUT5xoi7u6uXiLrbA/VCjbFD49bEDC0yt
         n8C+xQKa1Qj07Rga1wuIS05jHeXqhim4A/xC8rjkRTI0y1dq+oHSIDPPNXLoMLNOy0Zl
         mypP+5ZG+XDVoY6gMu0MA4CAz0Tm7NRpkrzVM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=references:message-id:from:to:in-reply-to:content-type
         :content-transfer-encoding:x-mailer:mime-version:subject:date:cc;
        b=vE0tLDL4yodPA/djam5ctyrU2Vo12iDUu9+o+rE03fdsjCXaqOvFZdA+ejbkTe5IPb
         Wh0Wy5l6alUgluiOGUJx0E1Eb6420NFzxx2lkgOaV+g4hqaJs7tU5UFzp9ZHNuNhkGJK
         rcCtm8uiyBmMuNjJ/L65PjgOeKKjjt3dFeG2U=
Received: by 10.65.141.5 with SMTP id t5mr9444386qbn.85.1230422740691;
        Sat, 27 Dec 2008 16:05:40 -0800 (PST)
Received: from ?10.51.247.133? ([32.145.173.131])
        by mx.google.com with ESMTPS id k29sm21212946qba.7.2008.12.27.16.05.25
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 27 Dec 2008 16:05:39 -0800 (PST)
In-Reply-To: <1230419037-14820-1-git-send-email-vmiklos@frugalware.org>
X-Mailer: iPhone Mail (5G77)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104032>

s/how have to use/now has to use/ ;-)

On Dec 27, 2008, at 17:03, Miklos Vajna <vmiklos@frugalware.org> wrote:

> The only incompatible change is that the user how have to use '--'
> before a patch named --build-fake-ancestor=3Dsomething.
>
> Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
> ---
>
> On Sat, Dec 27, 2008 at 10:53:43PM +0100, Ren=C3=A9 Scharfe <rene.sch=
arfe@lsrfire.ath.c=20
> x> wrote:
>> Miklos Vajna schrieb:
>>> -static const char apply_usage[] =3D
>>> -"git apply [--stat] [--numstat] [--summary] [--check] [--index] =20
>>> [--cached] [--apply] [--no-add] [--index-info] [--allow-binary-=20
>>> replacement] [--reverse] [--reject] [--verbose] [-z] [-pNUM] [-=20
>>> CNUM] [--whitespace=3D<nowarn|warn|fix|error|error-all>] <patch>...=
";
>>> +static const char * const apply_usage[] =3D {
>>> +   "git apply [--stat] [--numstat] [--summary] [--check] [--=20
>>> index] [--cached] [--apply] [--no-add] [--index-info] [--allow-=20
>>> binary-replacement] [--reverse] [--reject] [--verbose] [-z] [-=20
>>> pNUM] [-CNUM] [--whitespace=3D<nowarn|warn|fix|error|error-all>] =20
>>> <patch>...",
>>> +   NULL
>>> +};
>>
>> A useful convention with parse_options is to display "[options]" as =
a
>> place holder instead of listing all options explicitly in the usage
>> string.  They are listed and explained in the full help message =20
>> anyway
>> shown by "git apply -?").
>
> True, changed.
>
>>> +static int option_parse_recount(const struct option *opt,
>>> +                           const char *arg, int unset)
>>> +{
>>> +   options |=3D RECOUNT;
>>> +   return 0;
>>> +}
>>
>> OPT_BIT?
>
> I haven't discovered it, you are right. :-)
>
>>> +           OPT_INTEGER('C', NULL, &p_context,
>>> +                           "ensure at least <n> lines of context =20
>>> match"),
>>
>> p_context is an unsigned long variable; OPT_INTEGER expects a pointe=
r
>> to an int.  You'd either need an OPT_ULONG macro or change p_context
>> to in int.  Doing the latter fixed the two test cases t4105 and t425=
2
>> for me.
>
> Thanks, the trick was that the test did not fail on i686, just on
> x86_64. I have changed it as you suggested and it now passes for me o=
n
> x86_64 as well.
>
> Documentation/git-apply.txt |    4 +-
> builtin-apply.c             |  281 ++++++++++++++++++++++=20
> +--------------------
> 2 files changed, 154 insertions(+), 131 deletions(-)
>
> diff --git a/Documentation/git-apply.txt b/Documentation/git-apply.tx=
t
> index e726510..9400f6a 100644
> --- a/Documentation/git-apply.txt
> +++ b/Documentation/git-apply.txt
> @@ -10,7 +10,7 @@ SYNOPSIS
> --------
> [verse]
> 'git apply' [--stat] [--numstat] [--summary] [--check] [--index]
> -      [--apply] [--no-add] [--build-fake-ancestor <file>] [-R | --=20
> reverse]
> +      [--apply] [--no-add] [--build-fake-ancestor=3D<file>] [-R | --=
=20
> reverse]
>      [--allow-binary-replacement | --binary] [--reject] [-z]
>      [-pNUM] [-CNUM] [--inaccurate-eof] [--recount] [--cached]
>      [--whitespace=3D<nowarn|warn|fix|error|error-all>]
> @@ -64,7 +64,7 @@ OPTIONS
>    cached data, apply the patch, and store the result in the index,
>    without using the working tree. This implies '--index'.
>
> ---build-fake-ancestor <file>::
> +--build-fake-ancestor=3D<file>::
>    Newer 'git-diff' output has embedded 'index information'
>    for each blob to help identify the original version that
>    the patch applies to.  When this flag is given, and if
> diff --git a/builtin-apply.c b/builtin-apply.c
> index 07244b0..7603658 100644
> --- a/builtin-apply.c
> +++ b/builtin-apply.c
> @@ -14,6 +14,7 @@
> #include "builtin.h"
> #include "string-list.h"
> #include "dir.h"
> +#include "parse-options.h"
>
> /*
>  *  --check turns on checking that the working tree matches the
> @@ -45,9 +46,11 @@ static int apply_verbosely;
> static int no_add;
> static const char *fake_ancestor;
> static int line_termination =3D '\n';
> -static unsigned long p_context =3D ULONG_MAX;
> -static const char apply_usage[] =3D
> -"git apply [--stat] [--numstat] [--summary] [--check] [--index] [--=20
> cached] [--apply] [--no-add] [--index-info] [--allow-binary-=20
> replacement] [--reverse] [--reject] [--verbose] [-z] [-pNUM] [-CNUM] =
=20
> [--whitespace=3D<nowarn|warn|fix|error|error-all>] <patch>...";
> +static unsigned int p_context =3D UINT_MAX;
> +static const char * const apply_usage[] =3D {
> +    "git apply [options] [<patch>...]",
> +    NULL
> +};
>
> static enum ws_error_action {
>    nowarn_ws_error,
> @@ -61,6 +64,8 @@ static int applied_after_fixing_ws;
> static const char *patch_input_file;
> static const char *root;
> static int root_len;
> +static int read_stdin =3D 1;
> +static int options;
>
> static void parse_whitespace_option(const char *option)
> {
> @@ -3135,150 +3140,168 @@ static int git_apply_config(const char =20
> *var, const char *value, void *cb)
>    return git_default_config(var, value, cb);
> }
>
> +static int option_parse_stdin(const struct option *opt,
> +                  const char *arg, int unset)
> +{
> +    int *errs =3D opt->value;
> +
> +    *errs |=3D apply_patch(0, "<stdin>", options);
> +    read_stdin =3D 0;
> +    return 0;
> +}
> +
> +static int option_parse_exclude(const struct option *opt,
> +                const char *arg, int unset)
> +{
> +    add_name_limit(arg, 1);
> +    return 0;
> +}
> +
> +static int option_parse_include(const struct option *opt,
> +                const char *arg, int unset)
> +{
> +    add_name_limit(arg, 0);
> +    has_include =3D 1;
> +    return 0;
> +}
> +
> +static int option_parse_p(const struct option *opt,
> +              const char *arg, int unset)
> +{
> +    p_value =3D atoi(arg);
> +    p_value_known =3D 1;
> +    return 0;
> +}
> +
> +static int option_parse_z(const struct option *opt,
> +              const char *arg, int unset)
> +{
> +    if (unset)
> +        line_termination =3D '\n';
> +    else
> +        line_termination =3D 0;
> +    return 0;
> +}
> +
> +static int option_parse_whitespace(const struct option *opt,
> +                   const char *arg, int unset)
> +{
> +    const char **whitespace_option =3D opt->value;
> +
> +    *whitespace_option =3D arg;
> +    parse_whitespace_option(arg);
> +    return 0;
> +}
> +
> +static int option_parse_directory(const struct option *opt,
> +                  const char *arg, int unset)
> +{
> +    root_len =3D strlen(arg);
> +    if (root_len && arg[root_len - 1] !=3D '/') {
> +        char *new_root;
> +        root =3D new_root =3D xmalloc(root_len + 2);
> +        strcpy(new_root, arg);
> +        strcpy(new_root + root_len++, "/");
> +    } else
> +        root =3D arg;
> +    return 0;
> +}
>
> int cmd_apply(int argc, const char **argv, const char *unused_prefix)
> {
>    int i;
> -    int read_stdin =3D 1;
> -    int options =3D 0;
>    int errs =3D 0;
>    int is_not_gitdir;
> +    int binary;
> +    int force_apply =3D 0;
>
>    const char *whitespace_option =3D NULL;
>
> +    struct option builtin_apply_options[] =3D {
> +        { OPTION_CALLBACK, '-', NULL, &errs, NULL,
> +            "read the patch from the standard input",
> +            PARSE_OPT_NOARG, option_parse_stdin },
> +        { OPTION_CALLBACK, 0, "exclude", NULL, "path",
> +            "don=C2=B4t apply changes matching the given path",
> +            0, option_parse_exclude },
> +        { OPTION_CALLBACK, 0, "include", NULL, "path",
> +            "apply changes matching the given path",
> +            0, option_parse_include },
> +        { OPTION_CALLBACK, 'p', NULL, NULL, "num",
> +            "remove <num> leading slashes from traditional diff =20
> paths",
> +            0, option_parse_p },
> +        OPT_BOOLEAN(0, "no-add", &no_add,
> +            "ignore additions made by the patch"),
> +        OPT_BOOLEAN(0, "stat", &diffstat,
> +            "instead of applying the patch, output diffstat for the =
=20
> input"),
> +        OPT_BOOLEAN(0, "allow-binary-replacement", &binary,
> +            "now no-op"),
> +        OPT_BOOLEAN(0, "binary", &binary,
> +            "now no-op"),
> +        OPT_BOOLEAN(0, "numstat", &numstat,
> +            "shows number of added and deleted lines in decimal =20
> notation"),
> +        OPT_BOOLEAN(0, "summary", &summary,
> +            "instead of applying the patch, output a summary for =20
> the input"),
> +        OPT_BOOLEAN(0, "check", &check,
> +            "instead of applying the patch, see if the patch is =20
> applicable"),
> +        OPT_BOOLEAN(0, "index", &check_index,
> +            "make sure the patch is applicable to the current =20
> index"),
> +        OPT_BOOLEAN(0, "cached", &cached,
> +            "apply a patch without touching the working tree"),
> +        OPT_BOOLEAN(0, "apply", &force_apply,
> +            "also apply the patch (use with --stat/--summary/--=20
> check)"),
> +        OPT_STRING(0, "build-fake-ancestor", &fake_ancestor, "file",
> +            "build a temporary index based on embedded index =20
> information"),
> +        { OPTION_CALLBACK, 'z', NULL, NULL, NULL,
> +            "paths are separated with NUL character",
> +            PARSE_OPT_NOARG, option_parse_z },
> +        OPT_INTEGER('C', NULL, &p_context,
> +                "ensure at least <n> lines of context match"),
> +        { OPTION_CALLBACK, 0, "whitespace", &whitespace_option, =20
> "action",
> +            "detect new or modified lines that have whitespace =20
> errors",
> +            0, option_parse_whitespace },
> +        OPT_BOOLEAN('R', "reverse", &apply_in_reverse,
> +            "apply the patch in reverse"),
> +        OPT_BOOLEAN(0, "unidiff-zero", &unidiff_zero,
> +            "don't expect at least one line of context"),
> +        OPT_BOOLEAN(0, "reject", &apply_with_reject,
> +            "leave the rejected hunks in corresponding *.rej files")=
,
> +        OPT__VERBOSE(&apply_verbosely),
> +        OPT_BIT(0, "inaccurate-eof", &options,
> +            "tolerate incorrectly detected missing new-line at the =20
> end of file",
> +            INACCURATE_EOF),
> +        OPT_BIT(0, "recount", &options,
> +            "do not trust the line counts in the hunk headers",
> +            RECOUNT),
> +        { OPTION_CALLBACK, 0, "directory", NULL, "root",
> +            "prepend <root> to all filenames",
> +            0, option_parse_directory },
> +        OPT_END()
> +    };
> +
>    prefix =3D setup_git_directory_gently(&is_not_gitdir);
>    prefix_length =3D prefix ? strlen(prefix) : 0;
>    git_config(git_apply_config, NULL);
>    if (apply_default_whitespace)
>        parse_whitespace_option(apply_default_whitespace);
>
> -    for (i =3D 1; i < argc; i++) {
> +    argc =3D parse_options(argc, argv, builtin_apply_options,
> +            apply_usage, 0);
> +    if (apply_with_reject)
> +        apply =3D apply_verbosely =3D 1;
> +    if (!force_apply && (diffstat || numstat || summary || check || =
=20
> fake_ancestor))
> +        apply =3D 0;
> +    if (check_index && is_not_gitdir)
> +        die("--index outside a repository");
> +    if (cached) {
> +        if (is_not_gitdir)
> +            die("--cached outside a repository");
> +        check_index =3D 1;
> +    }
> +    for (i =3D 0; i < argc; i++) {
>        const char *arg =3D argv[i];
> -        char *end;
>        int fd;
>
> -        if (!strcmp(arg, "-")) {
> -            errs |=3D apply_patch(0, "<stdin>", options);
> -            read_stdin =3D 0;
> -            continue;
> -        }
> -        if (!prefixcmp(arg, "--exclude=3D")) {
> -            add_name_limit(arg + 10, 1);
> -            continue;
> -        }
> -        if (!prefixcmp(arg, "--include=3D")) {
> -            add_name_limit(arg + 10, 0);
> -            has_include =3D 1;
> -            continue;
> -        }
> -        if (!prefixcmp(arg, "-p")) {
> -            p_value =3D atoi(arg + 2);
> -            p_value_known =3D 1;
> -            continue;
> -        }
> -        if (!strcmp(arg, "--no-add")) {
> -            no_add =3D 1;
> -            continue;
> -        }
> -        if (!strcmp(arg, "--stat")) {
> -            apply =3D 0;
> -            diffstat =3D 1;
> -            continue;
> -        }
> -        if (!strcmp(arg, "--allow-binary-replacement") ||
> -            !strcmp(arg, "--binary")) {
> -            continue; /* now no-op */
> -        }
> -        if (!strcmp(arg, "--numstat")) {
> -            apply =3D 0;
> -            numstat =3D 1;
> -            continue;
> -        }
> -        if (!strcmp(arg, "--summary")) {
> -            apply =3D 0;
> -            summary =3D 1;
> -            continue;
> -        }
> -        if (!strcmp(arg, "--check")) {
> -            apply =3D 0;
> -            check =3D 1;
> -            continue;
> -        }
> -        if (!strcmp(arg, "--index")) {
> -            if (is_not_gitdir)
> -                die("--index outside a repository");
> -            check_index =3D 1;
> -            continue;
> -        }
> -        if (!strcmp(arg, "--cached")) {
> -            if (is_not_gitdir)
> -                die("--cached outside a repository");
> -            check_index =3D 1;
> -            cached =3D 1;
> -            continue;
> -        }
> -        if (!strcmp(arg, "--apply")) {
> -            apply =3D 1;
> -            continue;
> -        }
> -        if (!strcmp(arg, "--build-fake-ancestor")) {
> -            apply =3D 0;
> -            if (++i >=3D argc)
> -                die ("need a filename");
> -            fake_ancestor =3D argv[i];
> -            continue;
> -        }
> -        if (!strcmp(arg, "-z")) {
> -            line_termination =3D 0;
> -            continue;
> -        }
> -        if (!prefixcmp(arg, "-C")) {
> -            p_context =3D strtoul(arg + 2, &end, 0);
> -            if (*end !=3D '\0')
> -                die("unrecognized context count '%s'", arg + 2);
> -            continue;
> -        }
> -        if (!prefixcmp(arg, "--whitespace=3D")) {
> -            whitespace_option =3D arg + 13;
> -            parse_whitespace_option(arg + 13);
> -            continue;
> -        }
> -        if (!strcmp(arg, "-R") || !strcmp(arg, "--reverse")) {
> -            apply_in_reverse =3D 1;
> -            continue;
> -        }
> -        if (!strcmp(arg, "--unidiff-zero")) {
> -            unidiff_zero =3D 1;
> -            continue;
> -        }
> -        if (!strcmp(arg, "--reject")) {
> -            apply =3D apply_with_reject =3D apply_verbosely =3D 1;
> -            continue;
> -        }
> -        if (!strcmp(arg, "-v") || !strcmp(arg, "--verbose")) {
> -            apply_verbosely =3D 1;
> -            continue;
> -        }
> -        if (!strcmp(arg, "--inaccurate-eof")) {
> -            options |=3D INACCURATE_EOF;
> -            continue;
> -        }
> -        if (!strcmp(arg, "--recount")) {
> -            options |=3D RECOUNT;
> -            continue;
> -        }
> -        if (!prefixcmp(arg, "--directory=3D")) {
> -            arg +=3D strlen("--directory=3D");
> -            root_len =3D strlen(arg);
> -            if (root_len && arg[root_len - 1] !=3D '/') {
> -                char *new_root;
> -                root =3D new_root =3D xmalloc(root_len + 2);
> -                strcpy(new_root, arg);
> -                strcpy(new_root + root_len++, "/");
> -            } else
> -                root =3D arg;
> -            continue;
> -        }
>        if (0 < prefix_length)
>            arg =3D prefix_filename(prefix, prefix_length, arg);
>
> --=20
> 1.6.1.rc1.35.gae26e.dirty
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
