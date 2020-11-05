Return-Path: <SRS0=KwJF=EL=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11E5FC00A89
	for <git@archiver.kernel.org>; Thu,  5 Nov 2020 06:30:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9149F2071A
	for <git@archiver.kernel.org>; Thu,  5 Nov 2020 06:30:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=txture.io header.i=@txture.io header.b="EWtnlcQl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729880AbgKEGa5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 Nov 2020 01:30:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728827AbgKEGa4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Nov 2020 01:30:56 -0500
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80AE0C0613CF
        for <git@vger.kernel.org>; Wed,  4 Nov 2020 22:30:56 -0800 (PST)
Received: by mail-lf1-x144.google.com with SMTP id 126so647267lfi.8
        for <git@vger.kernel.org>; Wed, 04 Nov 2020 22:30:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=txture.io; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OgaqdAz26UcPZxfzKsqaJ1Wj5qgJVepJbkz+mm7A7Vo=;
        b=EWtnlcQljThkwPavk+SsQ+nME8IFdvKBikUl93vdq7gN2G5STm48GcFBu9xn8AK/j+
         lkLivOqMIiraVzMUhFRfMGk1t3rm0lY/ZGCGflG0z/oHD3Dv0HvZdu1UeZeUtZ8Bwad4
         BywVGJP6igU/VfkKWqs3D1z0GTpWG1gdUpxNuM7VnOq2aG+ivbhCa5iELPnaVLVgn4Iz
         g3Cid6D15HBk7oA1ZB2Ih1HFSwF7v0//jHEF/WO5+qHH2r3urIqITU1mVCuB1F/dEU7D
         F7+ooe1UcM+B4aDXiIdmNm53Mqx16TCH9UGw8h0b4C4j5uEOV5dwNiG2uU4nqtT9OX3o
         pkBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OgaqdAz26UcPZxfzKsqaJ1Wj5qgJVepJbkz+mm7A7Vo=;
        b=o33kEmRDASi35+/049lFqFnuXUujKaoCSsHAeDkgBRVcZM6bK5YoTx2X4O4EuAy8/D
         ltKSt11rv2heAMVbg7KzrJ+ThoZ/5BAVsPx5PrCK3kyWWOoj48hC6ANkLrIla20Sru0f
         I3loyn8WpXyk4z4nA1nB0lK3zTTtWZX/YijTI6RS2hwF3YbMn1TRRDV73JcA8C1U7S7c
         FAn1/k24lTCs/qEJE5oVlCLU/NAqxHzzt3Y3/KcdP1eCla8MLX5KQfevt8EFqVBWNbP1
         SPOX61l669etYkQhL8DdiMKu8Vc/if0hw1abxTaKrq8CASzJW7YAcmxcjBORJSmKIrQH
         Mj/Q==
X-Gm-Message-State: AOAM533G/A/dNwguJuY2MqLO8YNWf4ZqzMTXNAGnqaX4MHUIN/Gb9AXr
        4HAy0+8bF6S9KSdfoAGyLeregpw/BQNfAwF2eOcS5Hn3dCGzuLhr
X-Google-Smtp-Source: ABdhPJx/Ud+LaKnL7F1cTuF3bRpPKRIt0U8wbOPnbbCWdubJE8HMwe1lEIVILXGXi5lbCeo5ILh8Y5c5SQN7zYfoExE=
X-Received: by 2002:a19:8b8b:: with SMTP id n133mr393610lfd.202.1604557854695;
 Wed, 04 Nov 2020 22:30:54 -0800 (PST)
MIME-Version: 1.0
References: <CAO9fQ5pm2vCGrnj59QZg-fJ8VpnrsNoaVXRqd_Lsuw6rEaN3XQ@mail.gmail.com>
 <20201104132428.GA2491189@coredump.intra.peff.net> <20201104192645.GA3059114@coredump.intra.peff.net>
In-Reply-To: <20201104192645.GA3059114@coredump.intra.peff.net>
From:   Johannes Postler <johannes.postler@txture.io>
Date:   Thu, 5 Nov 2020 07:30:28 +0100
Message-ID: <CAO9fQ5rAjO0Q+AUA_-BqQqhunOhjadUB5YAU7+W2Pwi9OpUyGQ@mail.gmail.com>
Subject: Re: [PATCH v2] format-patch --output
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks a lot everyone for fixing this so quickly!
Please let me know if there is anything else I can do.
Best,
johannes

Johannes Postler
DevOps & Consulting


Txture - The Cloud Transformation Platform
Grabenweg 68
A-6020 Innsbruck
johannes.postler@txture.io
www.txture.io



Johannes Postler
DevOps & Consulting



Txture - The Cloud Transformation Platform
Grabenweg 68
A-6020 Innsbruck
johannes.postler@txture.io
www.txture.io

Follow us:


On Wed, Nov 4, 2020 at 8:26 PM Jeff King <peff@peff.net> wrote:
>
> On Wed, Nov 04, 2020 at 08:24:28AM -0500, Jeff King wrote:
>
> > The issue is that "--output" was never supposed to work with
> > format-patch. But a subtle change in the option parsing a while back
> > caused it to be respected. And as you noticed, the documentation
> > mistakenly mentions the option, since format-patch includes the standard
> > diff-options text.
> >
> > So one obvious fix would be to forbid it and adjust the documentation.
> > But because of the way the option parsers interact, it's surprisingly
> > hard to do so cleanly. It's actually easier to just make it do something
> > useful (i.e., behave like --stdout but sent to a file). So I did that
> > instead.
> >
> >   [1/3]: format-patch: refactor output selection
> >   [2/3]: format-patch: tie file-opening logic to output_directory
> >   [3/3]: format-patch: support --output option
>
> Here's a re-roll taking into account the comments from Eric. The only
> thing I didn't do is rewrite --output as a format-patch option. As I
> said in the thread, I'd rather keep parity with how git-log works here
> (though I don't mind if somebody wants to do further clean up on top).
>
>   [1/3]: format-patch: refactor output selection
>   [2/3]: format-patch: tie file-opening logic to output_directory
>   [3/3]: format-patch: support --output option
>
>  builtin/log.c           | 37 ++++++++++++++++++++++---------------
>  t/t4014-format-patch.sh | 33 +++++++++++++++++++++++++++++++++
>  2 files changed, 55 insertions(+), 15 deletions(-)
>
>
> Range diff from v1:
>
> 1:  49e8b54549 ! 1:  9206d6852b format-patch: refactor output selection
>     @@ Commit message
>          slightly easier to follow now, and also will keep things sane when we
>          add another output mode in a future patch.
>
>     +    We'll add a few tests as well, covering the mutual exclusion and the
>     +    fact that we are not confused by a configured output directory.
>     +
>          Signed-off-by: Jeff King <peff@peff.net>
>
>       ## builtin/log.c ##
>     @@ builtin/log.c: int cmd_format_patch(int argc, const char **argv, const char *pre
>      -  if (!output_directory && !use_stdout)
>      -          output_directory = config_output_directory;
>      +  if (use_stdout + !!output_directory > 1)
>     -+          die(_("specify only one of --stdout, --output, and --output-directory"));
>     ++          die(_("--stdout and --output-directory are mutually exclusive"));
>
>      -  if (!use_stdout)
>      -          output_directory = set_outdir(prefix, output_directory);
>     @@ builtin/log.c: int cmd_format_patch(int argc, const char **argv, const char *pre
>                 /*
>                  * We consider <outdir> as 'outside of gitdir', therefore avoid
>                  * applying adjust_shared_perm in s-c-l-d.
>     +
>     + ## t/t4014-format-patch.sh ##
>     +@@ t/t4014-format-patch.sh: test_expect_success 'format-patch -o overrides format.outputDirectory' '
>     +   test_path_is_dir patchset
>     + '
>     +
>     ++test_expect_success 'format-patch forbids multiple outputs' '
>     ++  rm -fr outdir &&
>     ++  test_must_fail \
>     ++          git format-patch --stdout --output-directory=outdir
>     ++'
>     ++
>     ++test_expect_success 'configured outdir does not conflict with output options' '
>     ++  rm -fr outfile outdir &&
>     ++  test_config format.outputDirectory outdir &&
>     ++  git format-patch --stdout &&
>     ++  test_path_is_missing outdir
>     ++'
>     ++
>     + test_expect_success 'format-patch --base' '
>     +   git checkout patchid &&
>     +
> 2:  884c06861d ! 2:  9dc30924b2 format-patch: tie file-opening logic to output_directory
>     @@ Commit message
>          format-patch: tie file-opening logic to output_directory
>
>          In format-patch we're either outputting to stdout or to individual files
>     -    in an output directory (which maybe just "./"). Our logic for whether to
>     -    open a new file for each patch is checked with "!use_stdout", but it is
>     -    equally correct to check for a non-NULL output_directory.
>     +    in an output directory (which may be just "./"). Our logic for whether
>     +    to open a new file for each patch is checked with "!use_stdout", but it
>     +    is equally correct to check for a non-NULL output_directory.
>
>          The distinction will matter when we add a new single-stream output in a
>          future patch, when only one of the three methods will want individual
> 3:  8befceb150 ! 3:  2b0fab9b50 format-patch: support --output option
>     @@ builtin/log.c: int cmd_format_patch(int argc, const char **argv, const char *pre
>                 load_display_notes(&rev.notes_opt);
>
>      -  if (use_stdout + !!output_directory > 1)
>     +-          die(_("--stdout and --output-directory are mutually exclusive"));
>      +  if (use_stdout + rev.diffopt.close_file + !!output_directory > 1)
>     -           die(_("specify only one of --stdout, --output, and --output-directory"));
>     ++          die(_("--stdout, --output, and --output-directory are mutually exclusive"));
>
>         if (use_stdout) {
>                 setup_pager();
>     @@ builtin/log.c: int cmd_format_patch(int argc, const char **argv, const char *pre
>
>       ## t/t4014-format-patch.sh ##
>      @@ t/t4014-format-patch.sh: test_expect_success 'format-patch -o overrides format.outputDirectory' '
>     -   test_path_is_dir patchset
>     - '
>     -
>     -+test_expect_success 'format-patch forbids multiple outputs' '
>     -+  rm -fr outfile outdir &&
>     + test_expect_success 'format-patch forbids multiple outputs' '
>     +   rm -fr outdir &&
>     +   test_must_fail \
>     +-          git format-patch --stdout --output-directory=outdir
>     ++          git format-patch --stdout --output-directory=outdir &&
>      +  test_must_fail \
>      +          git format-patch --stdout --output=outfile &&
>      +  test_must_fail \
>     -+          git format-patch --stdout --output-directory=outdir &&
>     -+  test_must_fail \
>      +          git format-patch --output=outfile --output-directory=outdir
>     -+'
>     -+
>     -+test_expect_success 'configured outdir does not conflict with output options' '
>     -+  rm -fr outfile outdir &&
>     -+  test_config format.outputDirectory outdir &&
>     -+  git format-patch --stdout &&
>     + '
>     +
>     + test_expect_success 'configured outdir does not conflict with output options' '
>     +   rm -fr outfile outdir &&
>     +   test_config format.outputDirectory outdir &&
>     +   git format-patch --stdout &&
>      +  test_path_is_missing outdir &&
>      +  git format-patch --output=outfile &&
>     -+  test_path_is_missing outdir
>     -+'
>     -+
>     +   test_path_is_missing outdir
>     + '
>     +
>      +test_expect_success 'format-patch --output' '
>      +  rm -fr outfile &&
>      +  git format-patch -3 --stdout HEAD >expect &&
