Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99BEF22FE0E
	for <git@vger.kernel.org>; Tue,  3 Jun 2025 14:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748961717; cv=none; b=H4/aMFBERSxwUjAM5keu/ONgTHBg0VsriXjFwYAsw3oVIFzqsKioTbjc9RGD/5GmjzlX5GIw2i/mSiNaGIyOl1xWkJCn18lG3qeoSFbjDkkR25jxwwsg8xTeVDfKviPOQgK5kLeu/NdUUfQCt8MLk9XMCB04iSwlrlr0gZgFg/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748961717; c=relaxed/simple;
	bh=Dgg+OG2QXNFR1phlccMXO5E1B6aMvv5+1YlNF0Gv2H4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WIyZbyBSXYgGSdvSWIfnVX6GnnUyQbaI5GMb2I29nhbtHvKDY0iAaaX+ejJwlopvxIxnsD5fDVxIZRUdftGepokZ49CaVGNuGeQ/G+KuX9qxawa6BwB6gDP7qyaZCn0MUgVydpzvosm7i99ycGZmQYU+2cDkmLf45v81ttlg9WQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jcy3r4VI; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jcy3r4VI"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4a589b7dd5fso36496761cf.0
        for <git@vger.kernel.org>; Tue, 03 Jun 2025 07:41:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748961714; x=1749566514; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hZsIp/VDvdKQgJUEN+pBtZlPaOvzjGyl3SAt7gMXDcY=;
        b=Jcy3r4VI25+yCOk/BLPz4PjJ9ImK/wBpUSMhZA71GwNaMOtCqb8I0QKjB9gP0qZRAE
         GJELKnLRn7+7E0k9EH47tiwkxxHnaANZUyLbvZbgWu6J+ptKJjXnFJ9SAckCh/YSXckj
         81gyTUCaTLtx93lBpUustLIdKgzz+MqEvl/T5dfK6KTtxKHsoiH9S4+TdrgRJvCVRC8V
         YuS5m0iV/p++Bht5nnQqWucYpAEpQJd7bfbKrzL9IecH4OJxJrHaZDGcYiqCOHDbY65S
         nBc3FhFa6FLuRWNliaNT1kbsJZmTsRDAv8sKGNv/4Jb36DdLYTS2GaYudz+L0jAeaVjC
         /NIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748961714; x=1749566514;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hZsIp/VDvdKQgJUEN+pBtZlPaOvzjGyl3SAt7gMXDcY=;
        b=QWVF9qCM1oa+Osfi94JrrAUkhRA45nEnKIqlb548Xku6lhJff6cPVl4l52J+d/kth5
         ppPygYECdpVVJvafxPYp8qCQ4uhBERfWujWgCIhMXFPDoHCUbk14SUjjCJJ52R5Vqf5V
         THuhvVCpHXNhytMyXC1jMv4Ah3G2Q4SqeZydKMYDuX3bI+zLanWoO0fmfwjXIjFI8zQI
         7oxXm8wF18bSVwlyJXNttPOcWuekljZs2kZZ21Rw5gcu+JLmkCFdijyHkraAOtAMDO2a
         5jBdI0M4AIf1yuEohM12fjf4LqH4L0vMnjtQkD1KovJbZV6ZniVekrWJ24WCpfcH/aiR
         AIzA==
X-Gm-Message-State: AOJu0YyHn/G/74VurH91IxlRgoMxE6ke2/J/cpus0SuHG7UK1jg2NCHi
	ySQQff5IlmQjnDnLf1K4yMkVaUCJY/+lLLjc/2RR30B5nYvQYBvMhKjokUEe76LIX6C2dxeyOjE
	Yoc6PAamitoNr5GfumxIpdOexUwNjCKA=
X-Gm-Gg: ASbGnctl5Y52rCCrPC2kWCyMKKeFPeek/6k9Lj70mRI2vt2Y8s6C7ubgiioDRkbHvD9
	bYpmh/39Dc1wBjgGfIE/Xc77LxE4c6l2KlSUfL26O0NUcuZtJuH6aEkWtHRa3nTGUgs4fZDg7gj
	HaDE1O/x2wQYlZIefQ6SGYw3OfM99CsA6GGsaH97qfIH3r80tsKqk4RRePBci6SxBN
X-Google-Smtp-Source: AGHT+IHTAUhaekj9Gnbgh/QQ5UN3Tmz9+kU+yVumTL8XiOJBVgSHB1ndrfRx4M+OoN5KQ0LYka389xOz1zsRiC/e5YM=
X-Received: by 2002:a05:622a:5c93:b0:4a4:4166:6076 with SMTP id
 d75a77b69052e-4a443c4dd8cmr295252901cf.5.1748961714281; Tue, 03 Jun 2025
 07:41:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <771677b1-2ce5-40ce-a704-752ff57ba0d3@ramsayjones.plus.com>
In-Reply-To: <771677b1-2ce5-40ce-a704-752ff57ba0d3@ramsayjones.plus.com>
From: JAYATHEERTH K <jayatheerthkulkarni2005@gmail.com>
Date: Tue, 3 Jun 2025 20:11:42 +0530
X-Gm-Features: AX0GCFuJVoqNxIJcjJExZz7ETjEQ_QSAvsd4Q4NTutG8lxfmwVJNVsMVnPqgLJk
Message-ID: <CA+rGoLcbtYCZ6Jr8YtinTq+KrdJBCv6JgA9+OQ1Hvj0+Yr1Hig@mail.gmail.com>
Subject: Re: v2.25.0-rc0 test failure on cygwin
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc: GIT Mailing-list <git@vger.kernel.org>, Adam Dinwoodie <git@dinwoodie.org>, 
	Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ramsay,

On Tue, Jun 3, 2025 at 4:03=E2=80=AFAM Ramsay Jones <ramsay@ramsayjones.plu=
s.com> wrote:
>
>
> I noticed on Friday, while testing the v2.25.0-rc0 build, that test t6137
> failed on cygwin:
>
>   $ tail test-out-2-50-rc0
>   Test Summary Report
>   -------------------
>   t6137-pathspec-wildcards-literal.sh              (Wstat: 256 (exited 1)=
 Tests: 25 Failed: 11)
>     Failed tests:  2, 7, 9, 11, 14-15, 17, 19, 21, 23, 25
>     Non-zero exit status: 1
>   Files=3D1023, Tests=3D30946, 21783 wallclock secs (19.08 usr 42.17 sys =
+ 4031.65 cusr 12965.78 csys =3D 17058.68 CPU)
>   Result: FAIL
>   make[1]: *** [Makefile:78: prove] Error 1
>   make[1]: Leaving directory '/home/ramsay/git/t'
>   make: *** [Makefile:3286: test] Error 2
>   $
>
> A quick squint at the failing tests made it clear that the failure was
> caused by the cygwin build treating a quoted glob character sequence
> (e.g. '\*') as a directory separator char followed by a glob character.
>
> To show this, I quickly hacked up a patch which causes the test to pass:
>
>
>   diff --git a/abspath.h b/abspath.h
>   index 4653080d5e..a5e30a3033 100644
>   --- a/abspath.h
>   +++ b/abspath.h
>   @@ -27,7 +27,7 @@ char *prefix_filename_except_for_dash(const char *pre=
fix, const char *path);
>
>    static inline int is_absolute_path(const char *path)
>    {
>   -     return is_dir_sep(path[0]) || has_dos_drive_prefix(path);
>   +     return /*is_dir_sep(path[0])*/ path[0] =3D=3D '/' || has_dos_driv=
e_prefix(path);
>    }
>
>    /**
>   diff --git a/path.c b/path.c
>   index 3b598b2847..f000b9ffff 100644
>   --- a/path.c
>   +++ b/path.c
>   @@ -1223,13 +1223,15 @@ int normalize_path_copy_len(char *dst, const ch=
ar *src, int *prefix_len)
>         end =3D src + offset_1st_component(src);
>         while (src < end) {
>                 char c =3D *src++;
>   +#ifdef DUMMY
>                 if (is_dir_sep(c))
>                         c =3D '/';
>   +#endif
>                 *dst++ =3D c;
>         }
>         dst0 =3D dst;
>
>   -     while (is_dir_sep(*src))
>   +     while (/*is_dir_sep(*src)*/ *src =3D=3D '/')
>                 src++;
>
>         for (;;) {
>   @@ -1247,10 +1249,10 @@ int normalize_path_copy_len(char *dst, const ch=
ar *src, int *prefix_len)
>                         if (!src[1]) {
>                                 /* (1) */
>                                 src++;
>   -                     } else if (is_dir_sep(src[1])) {
>   +                     } else if (/*is_dir_sep(src[1])*/ src[1] =3D=3D '=
/') {
>                                 /* (2) */
>                                 src +=3D 2;
>   -                             while (is_dir_sep(*src))
>   +                             while (/*is_dir_sep(*src)*/ *src =3D=3D '=
/')
>                                         src++;
>                                 continue;
>                         } else if (src[1] =3D=3D '.') {
>   @@ -1258,10 +1260,10 @@ int normalize_path_copy_len(char *dst, const ch=
ar *src, int *prefix_len)
>                                         /* (3) */
>                                         src +=3D 2;
>                                         goto up_one;
>   -                             } else if (is_dir_sep(src[2])) {
>   +                             } else if (/*is_dir_sep(src[2])*/ src[2] =
=3D=3D '/') {
>                                         /* (4) */
>                                         src +=3D 3;
>   -                                     while (is_dir_sep(*src))
>   +                                     while (/*is_dir_sep(*src)*/ *src =
=3D=3D '/')
>                                                 src++;
>                                         goto up_one;
>                                 }
>   @@ -1269,11 +1271,11 @@ int normalize_path_copy_len(char *dst, const ch=
ar *src, int *prefix_len)
>                 }
>
>                 /* copy up to the next '/', and eat all '/' */
>   -             while ((c =3D *src++) !=3D '\0' && !is_dir_sep(c))
>   +             while ((c =3D *src++) !=3D '\0' && !(/*is_dir_sep(c)*/ c =
=3D=3D '/'))
>                         *dst++ =3D c;
>   -             if (is_dir_sep(c)) {
>   +             if (/*is_dir_sep(c)*/ c =3D=3D '/') {
>                         *dst++ =3D '/';
>   -                     while (is_dir_sep(c))
>   +                     while (/*is_dir_sep(c)*/ c =3D=3D '/')
>                                 c =3D *src++;
>                         src--;
>                 } else if (!c)
>

Hmmm interesting

> In other words, in 'is_absolute_path()' and 'normalize_path_copy_len()', =
then
> just disable the '\' character as a path separator! ;)
>
> This was just to demonstrate the problem, not a serious patch, of course!
>
> I was away for the weekend and was expecting to see a patch to fix this
> on Gfw when I got back, but to my surprise there has been no mention of
> it on the mailing list (having now waded through the backlog!).
>
> To be clear, I can not imagine that this test passes on Gfw. However, thi=
s
> should have been failing the windows CI for ages, so ... perhaps I don't
> have a sufficiently vivid imagination. :)
>
> Anyway, the patch below 'fixes' the issue on cygwin.
>
> Thanks.
>
> ATB,
> Ramsay Jones
>
>
> ---- >8 ----
> From: Ramsay Jones <ramsay@ramsayjones.plus.com>
> Date: Mon, 2 Jun 2025 22:51:33 +0100
> Subject: [PATCH] t6137: disable 'quoted glob' pathspecs on cygwin
>
> The backslash in a 'quoted glob' character is treated as a directory
> separator character on cygwin, which causes all such tests to fail.
> Skip all such tests on cygwin using the !CYGWIN prerequisite. While
> here, fix a few test titles as well.
>
> Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
> ---
>  t/t6137-pathspec-wildcards-literal.sh | 24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)
>
> diff --git a/t/t6137-pathspec-wildcards-literal.sh b/t/t6137-pathspec-wil=
dcards-literal.sh
> index 20abad5667..229e48282e 100755
> --- a/t/t6137-pathspec-wildcards-literal.sh
> +++ b/t/t6137-pathspec-wildcards-literal.sh
> @@ -39,7 +39,7 @@ test_expect_success 'add wildcard *' '
>         )
>  '
>
> -test_expect_success 'add literal \*' '
> +test_expect_success !CYGWIN 'add literal \*' '
>         git init test-asterisk-literal &&
>         (
>                 cd test-asterisk-literal &&
> @@ -125,7 +125,7 @@ test_expect_success 'add wildcard f*' '
>         )
>  '
>
> -test_expect_success 'add literal f\*' '
> +test_expect_success !CYGWIN 'add literal f\*' '
>         git init test-f-lit &&
>         (
>                 cd test-f-lit &&
> @@ -156,7 +156,7 @@ test_expect_success 'add wildcard f**' '
>         )
>  '
>
> -test_expect_success 'add literal f\*\*' '
> +test_expect_success !CYGWIN 'add literal f\*\*' '
>         git init test-fdstar-lit &&
>         (
>                 cd test-fdstar-lit &&
> @@ -184,7 +184,7 @@ test_expect_success 'add wildcard f?z' '
>         )
>  '
>
> -test_expect_success 'add literal \? literal' '
> +test_expect_success !CYGWIN 'add literal \? literal' '
>         git init test-q-lit &&
>         (
>                 cd test-q-lit &&
> @@ -227,7 +227,7 @@ test_expect_success 'add wildcard hello?world' '
>         )
>  '
>
> -test_expect_success 'add literal hello\?world' '
> +test_expect_success !CYGWIN 'add literal hello\?world' '
>         git init test-hellolit &&
>         (
>                 cd test-hellolit &&
> @@ -241,7 +241,7 @@ test_expect_success 'add literal hello\?world' '
>         )
>  '
>
> -test_expect_success 'add literal [abc]' '
> +test_expect_success !CYGWIN 'add literal \[abc\]' '
>         git init test-brackets-lit &&
>         (
>                 cd test-brackets-lit &&
> @@ -280,7 +280,7 @@ test_expect_success 'commit: wildcard *' '
>         )
>  '
>
> -test_expect_success 'commit: literal *' '
> +test_expect_success !CYGWIN 'commit: literal \*' '
>         git init test-c-asterisk-lit &&
>         (
>                 cd test-c-asterisk-lit &&
> @@ -313,7 +313,7 @@ test_expect_success 'commit: wildcard f*' '
>         )
>  '
>
> -test_expect_success 'commit: literal f\*' '
> +test_expect_success !CYGWIN 'commit: literal f\*' '
>         git init test-c-flit &&
>         (
>                 cd test-c-flit &&
> @@ -328,7 +328,7 @@ test_expect_success 'commit: literal f\*' '
>         )
>  '
>
> -test_expect_success 'commit: wildcard pathspec limits commit' '
> +test_expect_success 'commit: wildcard f**' '
>         git init test-c-pathlimit &&
>         (
>                 cd test-c-pathlimit &&
> @@ -346,7 +346,7 @@ test_expect_success 'commit: wildcard pathspec limits=
 commit' '
>         )
>  '
>
> -test_expect_success 'commit: literal f\*\*' '
> +test_expect_success !CYGWIN 'commit: literal f\*\*' '
>         git init test-c-fdstar-lit &&
>         (
>                 cd test-c-fdstar-lit &&
> @@ -379,7 +379,7 @@ test_expect_success 'commit: wildcard ?' '
>         )
>  '
>
> -test_expect_success 'commit: literal \?' '
> +test_expect_success !CYGWIN 'commit: literal \?' '
>         git init test-c-qlit &&
>         (
>                 cd test-c-qlit &&
> @@ -411,7 +411,7 @@ test_expect_success 'commit: wildcard hello?world' '
>         )
>  '
>
> -test_expect_success 'commit: literal hello\?world' '
> +test_expect_success !CYGWIN 'commit: literal hello\?world' '
>         git init test-c-hellolit &&
>         (
>                 cd test-c-hellolit &&
> --
> 2.49.0


This is an interesting breakdown of the problem
thanks for digging into it.
Just to clarify :) My change was limited to a minor condition in
`dir.c` to ensure that `MATCHED_EXACTLY` only proceeds when the
`nowildcard_len` matches the full pathspec length (i.e., it's a true
literal). I didn=E2=80=99t touch the `is_dir_sep()` logic or normalization
functions, so your debug trail really helped surface a side effect I
hadn=E2=80=99t anticipated.

That said, I'm more than happy to help work toward a more permanent
solution if needed, beyond the `!CYGWIN` skip. Let me know how you'd
prefer to proceed.

- Jayatheerth
