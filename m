Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DATE_IN_PAST_03_06,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9EF0A203E2
	for <e@80x24.org>; Fri, 19 Aug 2016 01:12:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754872AbcHSBMH (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Aug 2016 21:12:07 -0400
Received: from mail-io0-f180.google.com ([209.85.223.180]:36526 "EHLO
        mail-io0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754871AbcHSBMD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Aug 2016 21:12:03 -0400
Received: by mail-io0-f180.google.com with SMTP id b62so35216034iod.3
        for <git@vger.kernel.org>; Thu, 18 Aug 2016 18:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=R3hi75tQ6cxYHpUHPoyVMjqNOW/2GH2v+vUXOOEPeFo=;
        b=X+husuwMbQYwTEwtml/6Cf2EGVrTWAIkwytWMiRKzYjRVPNSaYZl4Hq7j1rk05KIP0
         FSGzUfl/JzkSW0gnGaoThXkWOoF1Mto4736cbHREKkLFpyD51Ms4SQ7VqyOA2Avs9bPl
         ZeOGSewqOZXyuYZfb5lZo3YA4DMWyGUygGMuPwzVkHQ9tK1ny1HSOaRfCws3eACu4/w5
         YNb/gyBdK6ZTVm6yyH8um/RM2e45zvXXy/qOBl9jkCZuUEWzIO01dcmj5kBuIjDbC4ep
         35XLAkTM8eJoOmXD8q501okAMj+4YG4vyEobQ6VanJWGeVcYKq+yVd4cJ7LvTtwmWxDV
         Yyqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=R3hi75tQ6cxYHpUHPoyVMjqNOW/2GH2v+vUXOOEPeFo=;
        b=bA6XwIzBQA3mZVBl0NAxZGJE80KBoZxKWu74GMuJfTYXxtij11jL92ek9GsTMIUR29
         H45cQ9Rfo0bv5BLzRUPUUFG+eJ1cwTEkRV20eMz8ZcMpGmxgOG2MSiUijLyQMmZ4S6zb
         2o2k4+2Tpc57b6xR/IsuRDSiP4urSpggP4u3aPppi0lxPuhZN3sG1LzDPB5hYU/G0ENc
         Hwx9mXz1hnV6XZBLyXdZunR/QJ9PG4pyPZdfD4EXJLNFBQux6BU9CGkfiwKlJmkjnccN
         6tu1441P4IZqserOks+W2sw86Snbb/kFjcV9dg6O/KNOvFNvAb8mLYt4JYceyCyRO9AW
         yS6A==
X-Gm-Message-State: AEkoousAJo4NR99VJj2vt9HtdzRZg3WIqTzaupzzPe1ZzMd4gE87CzsnM7BTETUaU9X4+q9sOrDp2oy3bcwOqLbD
X-Received: by 10.107.178.129 with SMTP id b123mr5358998iof.83.1471549655592;
 Thu, 18 Aug 2016 12:47:35 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.128.66 with HTTP; Thu, 18 Aug 2016 12:47:35 -0700 (PDT)
In-Reply-To: <20160818005131.31600-8-jacob.e.keller@intel.com>
References: <20160818005131.31600-1-jacob.e.keller@intel.com> <20160818005131.31600-8-jacob.e.keller@intel.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 18 Aug 2016 12:47:35 -0700
Message-ID: <CAGZ79kbD=4=epNz=rMn=38ZJnd1z3ne4VsmswAqODPDH=gDotQ@mail.gmail.com>
Subject: Re: [PATCH v7 7/7] diff: teach diff to display submodule difference
 with an inline diff
To:     Jacob Keller <jacob.e.keller@intel.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <stefanbeller@gmail.com>,
        Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
        Jacob Keller <jacob.keller@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 17, 2016 at 5:51 PM, Jacob Keller <jacob.e.keller@intel.com> wr=
ote:



>         if (o->submodule_format =3D=3D DIFF_SUBMODULE_LOG &&
>             (!one->mode || S_ISGITLINK(one->mode)) &&
>             (!two->mode || S_ISGITLINK(two->mode))) {
> @@ -2311,6 +2322,17 @@ static void builtin_diff(const char *name_a,
>                                 two->dirty_submodule,
>                                 meta, del, add, reset);
>                 return;
> +       } else if (o->submodule_format =3D=3D DIFF_SUBMODULE_INLINE_DIFF =
&&
> +                  (!one->mode || S_ISGITLINK(one->mode)) &&
> +                  (!two->mode || S_ISGITLINK(two->mode))) {

The ! mode is for added and deleted submodules, I guess?

> diff --git a/diff.h b/diff.h
> index ea5aba668eaa..192c0eedd0ff 100644
> --- a/diff.h
> +++ b/diff.h
> @@ -112,6 +112,7 @@ enum diff_words_type {
>  enum diff_submodule_format {
>         DIFF_SUBMODULE_SHORT =3D 0,
>         DIFF_SUBMODULE_LOG,
> +       DIFF_SUBMODULE_INLINE_DIFF,
>  };
>
>  struct diff_options {
> diff --git a/submodule.c b/submodule.c
> index e341ca7ffefd..e5f1138f4362 100644
> --- a/submodule.c
> +++ b/submodule.c
> @@ -436,6 +436,67 @@ void show_submodule_summary(FILE *f, const char *pat=
h,
>                 clear_commit_marks(right, ~0);
>  }
>
> +void show_submodule_inline_diff(FILE *f, const char *path,
> +               const char *line_prefix,
> +               unsigned char one[20], unsigned char two[20],
> +               unsigned dirty_submodule, const char *meta,
> +               const char *del, const char *add, const char *reset,
> +               const struct diff_options *o)
> +{
> +       const char *old =3D EMPTY_TREE_SHA1_BIN, *new =3D EMPTY_TREE_SHA1=
_BIN;

submodule.c: In function =E2=80=98show_submodule_inline_diff=E2=80=99:
cache.h:957:3: warning: pointer targets in initialization differ in
signedness [-Wpointer-sign]
   ((const unsigned char *) EMPTY_TREE_SHA1_BIN_LITERAL)

submodule.c:446:20: note: in expansion of macro =E2=80=98EMPTY_TREE_SHA1_BI=
N=E2=80=99
  const char *old =3D EMPTY_TREE_SHA1_BIN, *new =3D EMPTY_TREE_SHA1_BIN;



> +       struct commit *left =3D NULL, *right =3D NULL;
> +       struct strbuf submodule_dir =3D STRBUF_INIT;
> +       struct child_process cp =3D CHILD_PROCESS_INIT;
> +
> +       show_submodule_header(f, path, line_prefix, one, two, dirty_submo=
dule,
> +                             meta, reset, &left, &right);
> +
> +       /* We need a valid left and right commit to display a difference =
*/
> +       if (!(left || is_null_sha1(one)) ||
> +           !(right || is_null_sha1(two)))
> +               goto done;
> +
> +       if (left)
> +               old =3D one;

submodule.c:460:7: warning: pointer targets in assignment differ in
signedness [-Wpointer-sign]
   old =3D one;



> +       if (right)
> +               new =3D two;
> +
> +       fflush(f);
> +       cp.git_cmd =3D 1;
> +       cp.dir =3D path;
> +       cp.out =3D dup(fileno(f));
> +       cp.no_stdin =3D 1;
> +
> +       /* TODO: other options may need to be passed here. */
> +       argv_array_pushl(&cp.args, "diff");
> +       argv_array_pushf(&cp.args, "--line-prefix=3D%s", line_prefix);
> +       if (DIFF_OPT_TST(o, REVERSE_DIFF)) {
> +               argv_array_pushf(&cp.args, "--src-prefix=3D%s%s/",
> +                                o->b_prefix, path);
> +               argv_array_pushf(&cp.args, "--dst-prefix=3D%s%s/",
> +                                o->a_prefix, path);
> +       } else {
> +               argv_array_pushf(&cp.args, "--src-prefix=3D%s%s/",
> +                                o->a_prefix, path);
> +               argv_array_pushf(&cp.args, "--dst-prefix=3D%s%s/",
> +                                o->b_prefix, path);
> +       }
> +       argv_array_push(&cp.args, sha1_to_hex(old));

submodule.c:484:2: warning: pointer targets in passing argument 1 of
=E2=80=98sha1_to_hex=E2=80=99 differ in signedness [-Wpointer-sign]
  argv_array_push(&cp.args, sha1_to_hex(old));


/*
 * nit: the following comment doesn't adhere to Gits way of doing comments:
 */

> +       /* If the submodule has modified content, we will diff against th=
e
> +        * work tree, under the assumption that the user has asked for th=
e
> +        * diff format and wishes to actually see all differences even if=
 they
> +        * haven't yet been committed to the submodule yet.
> +        */

Makes sort of sense when new is HEAD.

However if I have given an explicit sha1 in the superproject, e.g.:

    # (in the e.g. gerrit with a dirty submodule, I'd still expect to
    # get the dirtyness ignored, but the diff of those two states?)
    git diff --submodule=3Ddiff  cc82b24..5222e66 plugins/

> +       if (!(dirty_submodule & DIRTY_SUBMODULE_MODIFIED))
> +               argv_array_push(&cp.args, sha1_to_hex(new));
> +


> +# Tested non-UTF-8 encoding
> +test_encoding=3D"ISO8859-1"
...
> +# String "added" in German (translated with Google Translate), encoded i=
n UTF-8,
> +# used in sample commit log messages in add_file() function below.
> +added=3D$(printf "hinzugef\303\274gt")


> +add_file () {
> +       (
> +               cd "$1" &&
> +               shift &&
> +               for name
> +               do
> +                       echo "$name" >"$name" &&
> +                       git add "$name" &&
> +                       test_tick &&
> +                       # "git commit -m" would break MinGW, as Windows r=
efuse to pass
> +                       # $test_encoding encoded parameter to git.
> +                       echo "Add $name ($added $name)" | iconv -f utf-8 =
-t $test_encoding |
> +                       git -c "i18n.commitEncoding=3D$test_encoding" com=
mit -F -
> +               done >/dev/null &&
> +               git rev-parse --short --verify HEAD
> +       )
> +}
> +commit_file () {
> +       test_tick &&
> +       git commit "$@" -m "Commit $*" >/dev/null
> +}
> +
> +test_create_repo sm1 &&
> +add_file . foo >/dev/null
> +
> +head1=3D$(add_file sm1 foo1 foo2)
> +fullhead1=3D$(cd sm1; git rev-parse --verify HEAD)
> +
> +test_expect_success 'added submodule' '
> +       git add sm1 &&
> +       git diff-index -p --submodule=3Ddiff HEAD >actual &&
> +       cat >expected <<-EOF &&
> +       Submodule sm1 0000000...1beffeb (new submodule)

Do we also want to make the 1beffeb a variable?

> +       cat >expected <<-EOF &&
> +       Submodule sm1 0000000...$head1 (new submodule)

In the prior test we have spelled out the sha1s, here we refer to a variabl=
e?


> +       EOF
> +       git config --unset diff.submodule &&

    Use this one weird trick to make the tests more readable!
    Use "test_config" from test-lib-functions.sh
    (# Set git config, automatically unsetting it after the test is over.)
    (I am involved in Git for 3 years now, but just recently was pointed at=
 it)
