Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8419522FF4F
	for <git@vger.kernel.org>; Mon,  3 Mar 2025 20:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741032277; cv=none; b=BipabfT9XeUUXSloP6BYTIYTIcLs+ladl8NLxO763fCaBoBForeEoYDUaFTLmTGoDG/iJiHeboIxAF2Eu7hUCrAWVTp1IvdlG3qu6NGSvcEIXtQ5OSkhxcsG6Kwxb+ajG7TwoGmrUk3CyIX5/CAFhtKVb2L9iL8Dnhn0ySi8WTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741032277; c=relaxed/simple;
	bh=0nAY2Qn34pPDbxixs7DSO/24Om+oNsOcM2X9vykegcU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SJaD63NjCPkQfwT5TVRfNLfPhQQBp0G0FW9trYj2bk9LxRwHs483Rqv8XiqpxRd9wX0Ja6X5XSw+yLD044GgggOdSkhsi/fiTQv29AWMZGszh8g8Wv9T7vUA/j7M0fBLGKA88/0Z4moS6TYyd9QGa8adddYFF2F467NrC07c6aI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G2vLfvs7; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G2vLfvs7"
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5493b5bc6e8so5674563e87.2
        for <git@vger.kernel.org>; Mon, 03 Mar 2025 12:04:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741032273; x=1741637073; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8WIauFtBtRpkwGXat4WSarC8sOAsyz2Q9Xa/cBaDqhA=;
        b=G2vLfvs7NEX3ovt1fM7feKXBKAn4Wc4+DE/oGES1oRv3GCIfcqcWu9wiyZ06DxXsgW
         ZYiZgUWW2J/SpgJP1zoXzS9OnCvKsexSp3KDQ6RQlZ6r8so5k2WNAqFwid4FOr2A59eR
         uVam/8dJNf+Jqe6SGRQWa+nRBKyOachmKc4UrssUsHN5y5m+ZbXhFqeqgvmJZkJ6Ztov
         pUKg+NkYO50EQBO6ZzXUybz59bB/aJQm9q6dln9nqh3mhgLGkpWNYhv7wA7Kd3tapfo+
         amiTPMUyq6wsfmT0gG5KEgiytZxyFob7ny2Q2+LXeULUAT81xcdr8zmhHfOJdIx7mDNS
         CPgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741032273; x=1741637073;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8WIauFtBtRpkwGXat4WSarC8sOAsyz2Q9Xa/cBaDqhA=;
        b=eAOJzX/zKb6nL9dV1TR9zcrhPrqAIdyDEefqw4EYKgX6UFkV3E5CePEsWuDhEThjem
         lCAmZNSkXIcA+zeuWq1EzQ/JY/UnkxA7A4yAdxDvVj0rBOgsDRT2lH0rIYVOquPRokmu
         j+Ax2kzH1Eq04QGbLGPbw4RrqrvtCbiiEOm0C9A2LXlTYWH/K4xO1fgsn7y/Y3ZTjMkK
         MYHB2Vi4qTR1BpOF6gLnkw8VM7C70x2di2mQo6Wm3hWdi2MYtJX2OOuN3pKYRPLV9kZm
         I6v0jqrTIBkgZLf1X62p91eMA1SRJudd5bUgm/Yp1ydpF+bc0htFUZgoxwgmwdMYenVu
         s6uw==
X-Gm-Message-State: AOJu0YxiOWwjACM+9gKH1MhZACIfWljKC3fG7MhEqVv9yJtpf8Yuoz4d
	8nUpJGuftynq4N1iNdYQNdmRkm0gB97/rpF9oTRMO30s1qOjCCecFk4iek5WNNpOOeBy2PziYbR
	0UKpMlFCD2oFW8DVXz6EslVoud3c=
X-Gm-Gg: ASbGnctb5dEd8IhM8X5jKQVNPJVHoCxzK15rdx9oH3yvaYVSobQXRxP/NkD/W0NL/lM
	FZ9eiqk9UQxD7Y958+HW8CebCxqhwVY2jy/zpMpMSKWUde6frMzNc52TKcN6pxRHIb77jPx7iGK
	FqqH3b82A8D4cOSvsFRU0LCvzUO7XJsiiUjKjYo4VqBDknUSVjFHSzug3B/BY=
X-Google-Smtp-Source: AGHT+IFGYQrh+WIMsm8+fiisB8WlM6Pj6EvVCxq+C3c1MWJmmeM3cSGTcPzhepL2JDs/bUEiVZkXX7Lf3fPFwnYMjRY=
X-Received: by 2002:a05:6512:318c:b0:545:e2e:8443 with SMTP id
 2adb3069b0e04-5494c37d8femr5491922e87.32.1741032273319; Mon, 03 Mar 2025
 12:04:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250303141800.12848-1-ingleprachit101@gmail.com>
In-Reply-To: <20250303141800.12848-1-ingleprachit101@gmail.com>
From: Mahendra Dani <danimahendra0904@gmail.com>
Date: Tue, 4 Mar 2025 01:34:21 +0530
X-Gm-Features: AQ5f1Jo-s0BX6a04dbWOnA8u9W9rlXUAgi_x83HtOSkD3oWOEOXjHAHOlIil_MM
Message-ID: <CABGrwBAhtf0Ua=0i4N7XV-K7d8iphLQfXczPnN+kLRRNE-QxxQ@mail.gmail.com>
Subject: =?UTF-8?Q?Re=3A_=5BPATCH=5D_=5BGSOC=5D=5BPATCH=5D_Modernize_Test_Path_Checki?=
	=?UTF-8?Q?ng_in_Git=E2=80=99s_Test_Suite?=
To: Prachit Ingle <ingleprachit101@gmail.com>
Cc: git@vger.kernel.org, ps@pks.im, karthik.188@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 3, 2025 at 7:49=E2=80=AFPM Prachit Ingle <ingleprachit101@gmail=
.com> wrote:
>
> This patch improves the Git test suite by converting old-style path check=
s to use
> modern Git test helpers. Specifically, we have replaced shell commands li=
ke `test -f`
> and `test -d` with the appropriate Git test helpers, such as `test_path_i=
s_file` and
> `test_path_is_dir`. This enhances the readability and consistency of the =
test suite.
>
> The following tests were updated:
> - t/chainlint/cuddled-loop.test
> - t/chainlint/cuddled.test
> - t/chainlint/double-here-doc.test
> - t/chainlint/dqstring-line-splice.test
> - t/chainlint/dqstring-no-interpolate.test
> - t/chainlint/empty-here-doc.test
> - t/chainlint/exclamation.test
> - t/chainlint/exit-loop.test
> - t/chainlint/exit-subshell.test
> - t/chainlint/for-loop-abbreviated.test
> - t/chainlint/for-loop.test
> - t/chainlint/function.expect
> - t/chainlint/function.test
> - t/chainlint/here-doc-body-indent.test
>
> The changes have been verified by running the test suite to ensure no bre=
aks or regressions.
>
> Command used to find instances: git grep 'test -[efd]' t/
>
> Signed-off-by: Prachit Ingle <ingleprachit101@gmail.com>
> ---
>  t/chainlint/chained-subshell.expect |  2 +-
>  t/chainlint/chained-subshell.test   | 30 ++++++++++++++---------------
>  t/chainlint/function.expect         |  2 +-
>  t/chainlint/function.test           | 30 ++++++++++++++---------------
>  t/interop/interop-lib.sh            |  4 ++--
>  t/lib-httpd/apply-one-time-perl.sh  |  2 +-
>  t/lib-httpd/nph-custom-auth.sh      |  2 +-
>  t/perf/p5302-pack-index.sh          |  2 +-
>  t/perf/p7527-builtin-fsmonitor.sh   |  2 +-
>  t/perf/perf-lib.sh                  |  2 +-
>  10 files changed, 39 insertions(+), 39 deletions(-)
>
> diff --git a/t/chainlint/chained-subshell.expect b/t/chainlint/chained-su=
bshell.expect
> index 93fb1a6578..49efa1301d 100644
> --- a/t/chainlint/chained-subshell.expect
> +++ b/t/chainlint/chained-subshell.expect
> @@ -5,6 +5,6 @@
>  6 ) &&
>  7
>  8 cut "-d " -f actual | (read s1 s2 s3 &&
> -9 test -f $s1 ?!LINT: missing '&&'?!
> +9 test_path_is_file "$s1" || error "$s1 should exist"
>  10 test $(cat $s2) =3D tree2path1 &&
>  11 test $(cat $s3) =3D tree3path1)
> diff --git a/t/chainlint/chained-subshell.test b/t/chainlint/chained-subs=
hell.test
> index 1f11f65398..e167335f1e 100644
> --- a/t/chainlint/chained-subshell.test
> +++ b/t/chainlint/chained-subshell.test
> @@ -1,15 +1,15 @@
> -test_expect_success 'chained-subshell' '
> -# LINT: start of subshell chained to preceding command
> -mkdir sub && (
> -       cd sub &&
> -       foo the bar
> -       nuff said
> -) &&
> -
> -# LINT: preceding command pipes to subshell on same line
> -cut "-d " -f actual | (read s1 s2 s3 &&
> -test -f $s1
> -test $(cat $s2) =3D tree2path1 &&
> -# LINT: closing subshell ")" correctly detected on same line as "$(...)"
> -test $(cat $s3) =3D tree3path1)
> -'
> +test_expect_success 'chained-subshell' '
> +# LINT: start of subshell chained to preceding command
> +mkdir sub && (
> +       cd sub &&
> +       foo the bar
> +       nuff said
> +) &&
> +
> +# LINT: preceding command pipes to subshell on same line
> +cut "-d " -f actual | (read s1 s2 s3 &&
> +test_path_is_file $s1
> +test $(cat $s2) =3D tree2path1 &&
> +# LINT: closing subshell ")" correctly detected on same line as "$(...)"
> +test $(cat $s3) =3D tree3path1)
> +'
> diff --git a/t/chainlint/function.expect b/t/chainlint/function.expect
> index 9e46a3554a..a0a465e6d4 100644
> --- a/t/chainlint/function.expect
> +++ b/t/chainlint/function.expect
> @@ -4,7 +4,7 @@
>  5
>  6 remove_object() {
>  7      file=3D$(sha1_file "$*") &&
> -8      test -e "$file" ?!LINT: missing '&&'?!
> +8      test_path_exists "$file" || error "$file should exist"
>  9      rm -f "$file"
>  10 } ?!LINT: missing '&&'?!
>  11
> diff --git a/t/chainlint/function.test b/t/chainlint/function.test
> index 763fcf3f87..841c60720c 100644
> --- a/t/chainlint/function.test
> +++ b/t/chainlint/function.test
> @@ -1,15 +1,15 @@
> -test_expect_success 'function' '
> -# LINT: "()" in function definition not mistaken for subshell
> -sha1_file() {
> -       echo "$*" | sed "s#..#.git/objects/&/#"
> -} &&
> -
> -# LINT: broken &&-chain in function and after function
> -remove_object() {
> -       file=3D$(sha1_file "$*") &&
> -       test -e "$file"
> -       rm -f "$file"
> -}
> -
> -sha1_file arg && remove_object arg
> -'
> +test_expect_success 'function' '
> +# LINT: "()" in function definition not mistaken for subshell
> +sha1_file() {
> +       echo "$*" | sed "s#..#.git/objects/&/#"
> +} &&
> +
> +# LINT: broken &&-chain in function and after function
> +remove_object() {
> +       file=3D$(sha1_file "$*") &&
> +       test_path_exists "$file" || error "$file should exist"
> +       rm -f "$file"
> +}
> +
> +sha1_file arg && remove_object arg
> +'
> diff --git a/t/interop/interop-lib.sh b/t/interop/interop-lib.sh
> index 1b5864d2a7..b2055d4252 100644
> --- a/t/interop/interop-lib.sh
> +++ b/t/interop/interop-lib.sh
> @@ -21,7 +21,7 @@ build_version () {
>         sha1=3D$(git rev-parse "$1^{tree}") || return 1
>         dir=3D$BUILD_ROOT/$sha1
>
> -       if test -e "$dir/.built"
> +       if test_path_exists "$dir/.built"
>         then
>                 echo "$dir"
>                 return 0
> @@ -37,7 +37,7 @@ build_version () {
>
>         for config in config.mak config.mak.autogen config.status
>         do
> -               if test -e "$INTEROP_ROOT/../../$config"
> +               if test_path_exists "$INTEROP_ROOT/../../$config"
>                 then
>                         cp "$INTEROP_ROOT/../../$config" "$dir/" || retur=
n 1
>                 fi
> diff --git a/t/lib-httpd/apply-one-time-perl.sh b/t/lib-httpd/apply-one-t=
ime-perl.sh
> index d7f9fed6ae..83ede36efb 100644
> --- a/t/lib-httpd/apply-one-time-perl.sh
> +++ b/t/lib-httpd/apply-one-time-perl.sh
> @@ -7,7 +7,7 @@
>  #
>  # This can be used to simulate the effects of the repository changing in
>  # between HTTP request-response pairs.
> -if test -f one-time-perl
> +if test_path_is_file one-time-perl
>  then
>         LC_ALL=3DC
>         export LC_ALL
> diff --git a/t/lib-httpd/nph-custom-auth.sh b/t/lib-httpd/nph-custom-auth=
.sh
> index d408d2caad..c39b816c45 100644
> --- a/t/lib-httpd/nph-custom-auth.sh
> +++ b/t/lib-httpd/nph-custom-auth.sh
> @@ -41,7 +41,7 @@ then
>  fi
>
>  echo 'HTTP/1.1 401 Authorization Required'
> -if test -f "$CHALLENGE_FILE"
> +if test_path_is_file "$CHALLENGE_FILE"
>  then
>         sed -ne 's/^id=3Ddefault.*response=3D//p' "$CHALLENGE_FILE"
>  fi
> diff --git a/t/perf/p5302-pack-index.sh b/t/perf/p5302-pack-index.sh
> index 14c601bbf8..d3a3ea360f 100755
> --- a/t/perf/p5302-pack-index.sh
> +++ b/t/perf/p5302-pack-index.sh
> @@ -9,7 +9,7 @@ test_perf_large_repo
>  test_expect_success 'repack' '
>         git repack -ad &&
>         PACK=3D$(ls .git/objects/pack/*.pack | head -n1) &&
> -       test -f "$PACK" &&
> +       test_path_is_file "$PACK" &&
>         export PACK
>  '
>
> diff --git a/t/perf/p7527-builtin-fsmonitor.sh b/t/perf/p7527-builtin-fsm=
onitor.sh
> index 90164327e8..16e56cc197 100755
> --- a/t/perf/p7527-builtin-fsmonitor.sh
> +++ b/t/perf/p7527-builtin-fsmonitor.sh
> @@ -46,7 +46,7 @@ export TMP_BR
>  REPO=3D../repos/gen-many-files-"$PARAMS".git
>  export REPO
>
> -if ! test -d $REPO
> +if ! test_path_is_dir $REPO
>  then
>         (cd ../repos; ./many-files.sh -d $PARAM_D -w $PARAM_W -f $PARAM_F=
)
>  fi
> diff --git a/t/perf/perf-lib.sh b/t/perf/perf-lib.sh
> index 8ab6d9c469..13eb33ae6f 100644
> --- a/t/perf/perf-lib.sh
> +++ b/t/perf/perf-lib.sh
> @@ -117,7 +117,7 @@ test_perf_create_repo_from () {
>                 "$MODERN_GIT" init -q &&
>                 test_perf_do_repo_symlink_config_ &&
>                 mv .git/hooks .git/hooks-disabled 2>/dev/null &&
> -               if test -f .git/index.lock
> +               if test_path_is_file .git/index.lock
>                 then
>                         # We may be copying a repo that can't run "git
>                         # status" due to a locked index. Since we have
> --
> 2.34.1
>
>

The `test_path_exsists()`, `test_path_is_file()` and
`test_path_is_dir()` helper functions
are expected to be used within `test_expect_success` (or
`test_expect_failure`) blocks [1]. However, in several of the above
scripts, this condition
is not met, making them unsuitable candidates for such modifications.

Additionally, it is a good practice to make separate commits for
logically separate changes
and send multiple patches in a series [2-3], i.e submit one patch per
test script.

Thanks,
Mahendra

[References]
1. https://lore.kernel.org/git/CAPig+cR2-6qONkosu7=3DqEQSJa_fvYuVQ0to47D5qx=
904zW08Eg@mail.gmail.com/
2. https://git-scm.com/docs/MyFirstContribution
3. https://git-scm.com/docs/SubmittingPatches
