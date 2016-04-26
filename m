From: Mike Rappazzo <rappazzo@gmail.com>
Subject: Re: [PATCH 13/21] rev-parse: add '--absolute-git-dir' option
Date: Mon, 25 Apr 2016 22:33:13 -0400
Message-ID: <CANoM8SXO_Rz_CVOz9ptsaVCzcQ2D1FQrSuFFW4vZ4SdRYMzD=w@mail.gmail.com>
References: <1456440650-32623-1-git-send-email-szeder@ira.uka.de> <1456440650-32623-14-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>,
	Sebastian Schuberth <sschuberth@gmail.com>,
	Git List <git@vger.kernel.org>
To: =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 26 04:33:40 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ausol-0005dg-E9
	for gcvg-git-2@plane.gmane.org; Tue, 26 Apr 2016 04:33:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751494AbcDZCdf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 25 Apr 2016 22:33:35 -0400
Received: from mail-io0-f170.google.com ([209.85.223.170]:36674 "EHLO
	mail-io0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750843AbcDZCde convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 Apr 2016 22:33:34 -0400
Received: by mail-io0-f170.google.com with SMTP id u185so4342926iod.3
        for <git@vger.kernel.org>; Mon, 25 Apr 2016 19:33:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Z4qAkRsv8soD8BMoUqDplRU+zgNL6NX97mO24UI8LvQ=;
        b=ZjvAPWcVI4zRjaGZKkZkm0+EpE4Hut+U9o4sPY5SmprmNMKXs8FL5nM2QORLbrFduM
         nFdb1H33TTxbRfuP9fRypKk/vPtHjK2IhMZce+3R7mskbKvDkNuKwTAfrcFzdekpOzTF
         w9Wz8/kF47P1QxRoUUnNxfOxiM+OzqyV8CXncHO9KJ386Qftx6OVEYS6WAoVMRM/FRVr
         pnG8ohtW0OIV96u94h+aRoEcFDJ75bUHIa6rfziCF+T//wVJwuJxW7ppAIhRlr36F1QZ
         hjaDKNZPYPIHl9PBjrWXkmOfc5gP8tmwF793dAY/ii7d2ic1Rib8gCR+kkO6jclKRR59
         hgnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Z4qAkRsv8soD8BMoUqDplRU+zgNL6NX97mO24UI8LvQ=;
        b=kHhGUZn6kiY98UArwnXveZ6rcDI2cNIco5gUQn/mmYOdfYEMUi/c5nnCBofniQvzFE
         2T9mVxjisD/EakCoSeTtcfYbKF20LwfJFV/uz48SKDky7eWt1RYKf9sMLpp6RwFMLLMq
         yPW1fCPngpHCyitztjjJPiUvaLHuQCLuFOBVNgdU//15GgwaAFRsddA+Pu6ZNB425WT1
         jvjF+r1Am7bQfv5tQUmM00ZcsCuCUZVmhs8fX8SF/fT56AUVoyb0kUNbnl8MArwIXNzp
         98b+97UaX77f5BUDvflupBOEEAXUMcSRU1d/taLboMpOmtDsuIc+ltqHOYnGNcBH0GE2
         VLqA==
X-Gm-Message-State: AOPr4FV9hhX+K+uTRk6Enc0AQEKhitiLJ7wjVR2D7s17JY3qIgtCjcZ20+WY0b1pNXgaRxv5+kAG0Srxw438Pw==
X-Received: by 10.107.168.160 with SMTP id e32mr643673ioj.55.1461638013238;
 Mon, 25 Apr 2016 19:33:33 -0700 (PDT)
Received: by 10.107.7.220 with HTTP; Mon, 25 Apr 2016 19:33:13 -0700 (PDT)
In-Reply-To: <1456440650-32623-14-git-send-email-szeder@ira.uka.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292585>

On Thu, Feb 25, 2016 at 5:54 PM SZEDER G=C3=A1bor <szeder@ira.uka.de> w=
rote:
>
> Some scripts can benefit from not having to deal with the possibility
> of relative paths to the repository, but the output of 'git rev-parse
> --git-dir' can be a relative path.  Case in point: supporting 'git -C
> <path>' in our Bash completion script turned out to be considerably
> more difficult, error prone and required more subshells and git
> processes when we had to cope with a relative path to the .git
> directory.
>
> Help these use cases and teach 'git rev-parse' a new
> '--absolute-git-dir' option which always outputs a canonicalized
> absolute path to the .git directory, regardless of whether the path i=
s
> discovered automatically or is specified via $GIT_DIR or 'git
> --git-dir=3D<path>'.
>
> Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
> ---
>  Documentation/git-rev-parse.txt |  4 ++++
>  builtin/rev-parse.c             | 29 +++++++++++++++++++++--------
>  t/t1500-rev-parse.sh            | 17 ++++++++++-------
>  3 files changed, 35 insertions(+), 15 deletions(-)
>
> diff --git a/Documentation/git-rev-parse.txt b/Documentation/git-rev-=
parse.txt
> index b6c6326cdc7b..fb06e3118570 100644
> --- a/Documentation/git-rev-parse.txt
> +++ b/Documentation/git-rev-parse.txt
> @@ -216,6 +216,10 @@ If `$GIT_DIR` is not defined and the current dir=
ectory
>  is not detected to lie in a Git repository or work tree
>  print a message to stderr and exit with nonzero status.
>
> +--absolute-git-dir::
> +       Like `--git-dir`, but its output is always the canonicalized
> +       absolute path.
> +
>  --git-common-dir::
>         Show `$GIT_COMMON_DIR` if defined, else `$GIT_DIR`.
>

After working a little bit with rev-parse [1], I feel that this might
be better served as a
stand-alone option.  Consider that in addition to --git-dir, the
options --git-common-dir,
--git-path, and --git-shared-index produce relative paths.

I propose that it might make more sense to use something like
`--abs-path` to indicate
that the result should include an absolute path (or we could also just =
spell out
`--absolute-path`).  That way we don't have to add additional options
for any other type
that might want an absolute path.

    git rev-parse --git-dir --abs-path
    git rev-parse --git-common-dir --absolute-path

I do understand that this might be more work than is necessary for the
completion series
here.  Would it be unreasonable to suggest a partial implementation
that, for now, only
works with `--git-dir`?

> diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
> index cf8487b3b95f..90a4dd6032c0 100644
> --- a/builtin/rev-parse.c
> +++ b/builtin/rev-parse.c
> @@ -744,17 +744,30 @@ int cmd_rev_parse(int argc, const char **argv, =
const char *prefix)
>                                 putchar('\n');
>                                 continue;
>                         }
> -                       if (!strcmp(arg, "--git-dir")) {
> +                       if (!strcmp(arg, "--git-dir") ||
> +                           !strcmp(arg, "--absolute-git-dir")) {
>                                 const char *gitdir =3D getenv(GIT_DIR=
_ENVIRONMENT);
>                                 char *cwd;
>                                 int len;
> -                               if (gitdir) {
> -                                       puts(gitdir);
> -                                       continue;
> -                               }
> -                               if (!prefix) {
> -                                       puts(".git");
> -                                       continue;
> +                               if (arg[2] =3D=3D 'g') {    /* --git-=
dir */
> +                                       if (gitdir) {
> +                                               puts(gitdir);
> +                                               continue;
> +                                       }
> +                                       if (!prefix) {
> +                                               puts(".git");
> +                                               continue;
> +                                       }
> +                               } else {                /* --absolute=
-git-dir */
> +                                       if (!gitdir && !prefix)
> +                                               gitdir =3D ".git";
> +                                       if (gitdir) {
> +                                               char absolute_path[PA=
TH_MAX];
> +                                               if (!realpath(gitdir,=
 absolute_path))
> +                                                       die_errno(_("=
unable to get absolute path"));
> +                                               puts(absolute_path);
> +                                               continue;
> +                                       }
>                                 }
>                                 cwd =3D xgetcwd();
>                                 len =3D strlen(cwd);
> diff --git a/t/t1500-rev-parse.sh b/t/t1500-rev-parse.sh
> index 48ee07779d64..617fcd821309 100755
> --- a/t/t1500-rev-parse.sh
> +++ b/t/t1500-rev-parse.sh
> @@ -31,23 +31,26 @@ test_rev_parse() {
>         "test '$1' =3D \"\$(git rev-parse --git-dir)\""
>         shift
>         [ $# -eq 0 ] && return
> +
> +       test_expect_success "$name: absolute-git-dir" \
> +       "verbose test '$1' =3D \"\$(git rev-parse --absolute-git-dir)=
\""
>  }
>
> -# label is-bare is-inside-git is-inside-work prefix git-dir
> +# label is-bare is-inside-git is-inside-work prefix git-dir absolute=
-git-dir
>
>  ROOT=3D$(pwd)
>
> -test_rev_parse toplevel false false true '' .git
> +test_rev_parse toplevel false false true '' .git "$ROOT/.git"
>
>  cd .git || exit 1
> -test_rev_parse .git/ false true false '' .
> +test_rev_parse .git/ false true false '' . "$ROOT/.git"
>  cd objects || exit 1
> -test_rev_parse .git/objects/ false true false '' "$ROOT/.git"
> +test_rev_parse .git/objects/ false true false '' "$ROOT/.git" "$ROOT=
/.git"
>  cd ../.. || exit 1
>
>  mkdir -p sub/dir || exit 1
>  cd sub/dir || exit 1
> -test_rev_parse subdirectory false false true sub/dir/ "$ROOT/.git"
> +test_rev_parse subdirectory false false true sub/dir/ "$ROOT/.git" "=
$ROOT/.git"
>  cd ../.. || exit 1
>
>  git config core.bare true
> @@ -63,7 +66,7 @@ GIT_CONFIG=3D"$(pwd)"/../.git/config
>  export GIT_DIR GIT_CONFIG
>
>  git config core.bare false
> -test_rev_parse 'GIT_DIR=3D../.git, core.bare =3D false' false false =
true ''
> +test_rev_parse 'GIT_DIR=3D../.git, core.bare =3D false' false false =
true '' "../.git" "$ROOT/.git"
>
>  git config core.bare true
>  test_rev_parse 'GIT_DIR=3D../.git, core.bare =3D true' true false fa=
lse ''
> @@ -76,7 +79,7 @@ GIT_DIR=3D../repo.git
>  GIT_CONFIG=3D"$(pwd)"/../repo.git/config
>
>  git config core.bare false
> -test_rev_parse 'GIT_DIR=3D../repo.git, core.bare =3D false' false fa=
lse true ''
> +test_rev_parse 'GIT_DIR=3D../repo.git, core.bare =3D false' false fa=
lse true '' "../repo.git" "$ROOT/repo.git"
>
>  git config core.bare true
>  test_rev_parse 'GIT_DIR=3D../repo.git, core.bare =3D true' true fals=
e false ''
> --
> 2.7.2.410.g92cb358
>
> --

[1] http://thread.gmane.org/gmane.comp.version-control.git/292272
