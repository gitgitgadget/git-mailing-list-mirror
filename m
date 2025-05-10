Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E152011712
	for <git@vger.kernel.org>; Sat, 10 May 2025 04:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746851902; cv=none; b=hfGB14uon+nLOftGYEi0wfnhF55wtz97abB/7jmf9X0if7kV4YQn/qV1TkRao2P2R2GQewgNPCXdiP0vA1quFQivOm8RkLv+7J7fHIgdnqynntxeGPbMS8icRM9hLgrlmzuktc+aCaQyOCXjw36363FdjP5HJQvj6oqclGMbd6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746851902; c=relaxed/simple;
	bh=iFwd3bXFWIvbsSNRCnUiQ4CVXsrAQjWkE+zxayKTlSg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C5NZtWFLgGZL7gPH32gh1RgPPvv+1Qm0IOIrPKu0Ys3LZmwgB0s6Tpff9J4OE9ZeHwEaAGhV9/4hZbbCyW0QAdv/wPT4kM1kFmPjr7n2plpXsxGdIHjEUBeXeVhxYulNascaxT649XeVZ9I4umk7UDSXWYgtrXmAfTSJNGv8ik8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PKPjjDs0; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PKPjjDs0"
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-3cfce97a3d9so22913075ab.2
        for <git@vger.kernel.org>; Fri, 09 May 2025 21:38:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746851900; x=1747456700; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NnROFuDbNjDT/huVCR3q+45omHXJ866rQxEiu3pn77A=;
        b=PKPjjDs0JoIXNGBZrzsPxxlUlDNe/RGLH+3Q/TGATubFWOa3Xy9eU7kV0wozTjGOuQ
         X0VbFDvhNPut62CLUI11PtcCd0Nk7PCEefSqhGLdpqJPP8CdXw2QxcMJ4yYqkHCCUx+q
         15+MV35ByiTJj6RD0xCPHVJJuyHVNByRYfulkfWxSEDn67FJArKyK0n+bVMWtwr4Vgor
         EwE3G1P/R90Rkit2kWy7ziYTvjxql7ukPnV97feGCAdrlXSscKnlePRFFDnccRsgl84r
         yaWnspFJjp6XQAzbW65TdzFWKkByhmMIy7AB/6DdbSczazYauGH79CpDlu4lZwF1aDFB
         tOww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746851900; x=1747456700;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NnROFuDbNjDT/huVCR3q+45omHXJ866rQxEiu3pn77A=;
        b=m+RXwsRob4H8tAxoxup86VC+ckHC+EbD0ixAiauLBC7asDB63e9xomj+q8vi/YRHk+
         PaoGLaw4W7pAEVykC2aeZipWVUxHpnfdkPOmWMRpYIujAZRkqW5UwqD8ZEJvZ3SJWPeQ
         VzAj/3oU0lN1p8k5vJ/BmgwYGrHm3RkI9hMfgYxArhH1yFmIwVbo4qH6k+Bh0+KrQ0cG
         ABLg4iv18K7l9c809/VDi0GBMMaDM6modBP2JGzo+7NcYOfKde+hZZJ6YDnGNzDHqCzg
         PON2hFbr3/YRqso9xdd+UXHU8Ezj6DbIx+dOA067DN1kGUB9/u3vP56xf8U/lQfYEg/6
         qZ6w==
X-Gm-Message-State: AOJu0Yyx6XjtcM3xTKZT2XIdYDAIcgC/aqQi/P+5r0/eyNC3h6Ap/Fd6
	fWXfQA4kDh/QwDPvdRD0OpKO+0zxTj+t8wbZbX2Tst+sbhDEhougF5aNes+1bnF8IGl4ss5XAVf
	eUT6dPIseOXz5f+jTNIg/YTKJIX4=
X-Gm-Gg: ASbGnctmFfDibCJPA1rdc/fvhXWZX2M2t4RTf1idO0Xxx9S8EA2snNyu7Ely0ohlEJV
	HIaAEXZjZknN8/yxSZ5QpCo4is1XgBFZTPEHhBFuVBj42WsrzE2brOsBFZfLyzlhPDTIIqdIaae
	lIp0+/naWIE+gj8FwBcurXOGzsuZ5+ZTzhUGgCnjtaawzsPpzefDmsFpjc6VY/i0bUpA==
X-Google-Smtp-Source: AGHT+IHRpBxx1Ua42lrPHCq+RK9+IROppUuQ4dVNVNJ5p09IrAOnvwtdfg6jCsjzOtAbnh0fGGqh1o+Znu3ksfqO8SI=
X-Received: by 2002:a92:cda7:0:b0:3d9:66c7:d1e8 with SMTP id
 e9e14a558f8ab-3da7e165314mr68885505ab.0.1746851899857; Fri, 09 May 2025
 21:38:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1914.git.1746579320.gitgitgadget@gmail.com> <63caae876343faa9609516b0797fd9ff19f7a881.1746579321.git.gitgitgadget@gmail.com>
In-Reply-To: <63caae876343faa9609516b0797fd9ff19f7a881.1746579321.git.gitgitgadget@gmail.com>
From: Elijah Newren <newren@gmail.com>
Date: Fri, 9 May 2025 21:38:08 -0700
X-Gm-Features: AX0GCFtSN7m0y-OTc5e2AHywsx5yMZaWqCmZNECcWspHldoXTaiAUdzQjefPWxw
Message-ID: <CABPp-BEmMaFQxE9NQgM8M=cgfBHY1p56vnBt7R4CfuiXnq++4Q@mail.gmail.com>
Subject: Re: [PATCH 2/3] git add: make -p/-i aware of sparse index
To: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, Derrick Stolee <stolee@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 6, 2025 at 5:55=E2=80=AFPM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Derrick Stolee <stolee@gmail.com>
>
> It is slow to expand a sparse index in-memory due to parsing of trees.
> We aim to minimize that performance cost when possible. 'git add -p'
> uses 'git apply' child processes to modify the index, but still there
> are some expansions that occur.

still there are some expansions that occur...outside of those child
processes?  Is that what you're trying to say, or was it something
else?

> It turns out that control flows out of cmd_add() in the interactive
> cases before the lines that confirm that the builtin is integrated with
> the sparse index. We need to move that earlier to ensure it prevents a
> full index expansion on read.
>
> Add more test cases that confirm that these interactive add options work
> with the sparse index. One interesting aspect here is that the '-i'
> option avoids expanding the sparse index when a sparse directory exists
> on disk while the '-p' option does hit the ensure_full_index() method.
> This leaves some room for improvement, but this case should be atypical
> as users should remain within their sparse-checkout.

It's not clear whether this paragraph is talking about existing state
(before the patch) or desired state (after the patch).  I think based
on the context it's the former, but the last sentence sounds more like
a future work direction that makes it very unclear, to me at least.

> Signed-off-by: Derrick Stolee <stolee@gmail.com>
> ---
>  builtin/add.c                            |  7 +--
>  t/t1092-sparse-checkout-compatibility.sh | 56 ++++++++++++++++++++++++
>  2 files changed, 60 insertions(+), 3 deletions(-)
>
> diff --git a/builtin/add.c b/builtin/add.c
> index 747511b68bc3..7c292ffdc6c2 100644
> --- a/builtin/add.c
> +++ b/builtin/add.c
> @@ -390,6 +390,10 @@ int cmd_add(int argc,
>
>         argc =3D parse_options(argc, argv, prefix, builtin_add_options,
>                           builtin_add_usage, PARSE_OPT_KEEP_ARGV0);
> +
> +       prepare_repo_settings(repo);
> +       repo->settings.command_requires_full_index =3D 0;
> +
>         if (patch_interactive)
>                 add_interactive =3D 1;
>         if (add_interactive) {
> @@ -426,9 +430,6 @@ int cmd_add(int argc,
>         add_new_files =3D !take_worktree_changes && !refresh_only && !add=
_renormalize;
>         require_pathspec =3D !(take_worktree_changes || (0 < addremove_ex=
plicit));
>
> -       prepare_repo_settings(repo);
> -       repo->settings.command_requires_full_index =3D 0;
> -
>         repo_hold_locked_index(repo, &lock_file, LOCK_DIE_ON_ERROR);
>
>         /*
> diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-ch=
eckout-compatibility.sh
> index ab8bd371eff3..0dc5dd27184d 100755
> --- a/t/t1092-sparse-checkout-compatibility.sh
> +++ b/t/t1092-sparse-checkout-compatibility.sh
> @@ -384,6 +384,38 @@ test_expect_success 'add, commit, checkout' '
>         test_all_match git checkout -
>  '
>
> +test_expect_success 'git add -p' '
> +       init_repos &&
> +
> +       write_script edit-contents <<-\EOF &&
> +       echo text >>$1
> +       EOF
> +
> +       # Does not expand when edits are within sparse checkout.
> +       run_on_all ../edit-contents deep/a &&
> +       run_on_all ../edit-contents deep/deeper1/a &&
> +
> +       test_write_lines y n >in &&
> +       run_on_all git add -p <in &&
> +       test_all_match git status --porcelain=3Dv2 &&
> +       test_all_match git reset &&
> +
> +       test_write_lines u 1 "" q >in &&
> +       run_on_all git add -i <in &&
> +       test_all_match git status --porcelain=3Dv2 &&
> +       test_all_match git reset --hard &&
> +
> +       run_on_sparse mkdir -p folder1 &&
> +       run_on_all ../edit-contents folder1/a &&
> +       test_write_lines y n y >in &&
> +       run_on_all git add -p <in &&
> +       test_sparse_match git status --porcelain=3Dv2 &&
> +       test_sparse_match git reset &&
> +       test_write_lines u 2 3 "" q >in &&
> +       run_on_all git add -i <in &&
> +       test_sparse_match git status --porcelain=3Dv2
> +'
> +
>  test_expect_success 'deep changes during checkout' '
>         init_repos &&
>
> @@ -2391,6 +2423,30 @@ test_expect_success 'sparse-index is not expanded:=
 git apply' '
>         ensure_not_expanded apply --cached ../patch-outside
>  '
>
> +test_expect_success 'sparse-index is not expanded: git add -p' '
> +       init_repos &&
> +
> +       # Does not expand when edits are within sparse checkout.
> +       echo "new content" >sparse-index/deep/a &&
> +       echo "new content" >sparse-index/deep/deeper1/a &&
> +       test_write_lines y n >in &&
> +       ensure_not_expanded add -p <in &&
> +       git -C sparse-index reset &&
> +       ensure_not_expanded add -i <in &&
> +
> +       mkdir -p sparse-index/folder1 &&
> +       echo "new content" >sparse-index/folder1/a &&
> +
> +       # -p does expand when edits are outside sparse checkout.
> +       test_write_lines y n y >in &&
> +       ensure_expanded add -p <in &&
> +
> +       # but -i does not expand.
> +       git -C sparse-index reset &&
> +       test_write_lines u 2 3 "" q >in &&
> +       ensure_not_expanded add -i <in

This has the same error as patch 1, in that you assume your reset
above (which wasn't even a reset --hard) will re-sparsify the index.
Since it doesn't, your test is misleading and only shows that when
already expanded to include the files of interest it doesn't expand
any further.  To re-sparsify your index before the `add -i` call,
you'll need to do a `git reset --hard && git sparse-checkout reapply`
and then recreate folder1/a with "new content" again...and then run
your 'add -i' command.

Anyway, now I think I understand the expected meaning of the final
paragraph of your commit message, but you were tripped up by assuming
the index was re-sparsified between your steps when it wasn't.
