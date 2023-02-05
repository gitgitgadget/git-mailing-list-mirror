Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57BAAC636CD
	for <git@archiver.kernel.org>; Sun,  5 Feb 2023 17:01:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229569AbjBERBq (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 5 Feb 2023 12:01:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjBERBo (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Feb 2023 12:01:44 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2965C18A8B
        for <git@vger.kernel.org>; Sun,  5 Feb 2023 09:01:43 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id be12so9545773edb.4
        for <git@vger.kernel.org>; Sun, 05 Feb 2023 09:01:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PWm6sBQqiM/ToNBzIVBKsZjfML8Eyl8jpCupZqERq4M=;
        b=SjXPlKrmDX0CTZm18azATPOsRG0LKctUD/tB0N93WNLlcqAzNvZw4v8eojhLMr7mOd
         YNzAR81y8h7pZwBfm6eLcBasWVxahA9vX5b1aqVybjObxD5EVSpYdPCZeXCnbJbqCsyc
         8ir1ptQSdsX6IKLN5zQBFXFTdIyfsm5fymFhAEJojX1G08daz72vPIMP13OjAjLNTbPp
         gcEdwzyeGp6sLxNE+9ngs7Cz8raFELNCn47e7DlB9RjPL+EGwmfjCNph5ZjQnjSbKW9C
         fPrWiNINl/ZveJy9xGNN/PPUr2ZE5mqoi3673ROkxoElD+UG9xW7aO/J1gEBF08mMSNj
         HYPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PWm6sBQqiM/ToNBzIVBKsZjfML8Eyl8jpCupZqERq4M=;
        b=v3zDxPcLs4+M//rnkt9jVMvmQHKV1yBQlDGBcbin+bigO6vpaJTXMoYvyzMl4Li3us
         eCJGYtkqkdXXgHCUKY1UQYg48AvctA0CoSgaHvUPiX4bVKZ5AQbeoermMMKodyzDPnkE
         nmvHEtW9WXnRLSdv/YmAVL5RWoz7g8ZK1H1vBvOjSKPxfV/4h0/xt9tpPNWx7zlIjA4D
         u5hTCaLaWFhVud/Y5ChLvXFFoJuGbkCMtUmnXqELRzbWTbH6W6X4Zyq47ZOrWS1aC6Gh
         v800MonL7sUxOfG6T9d+Fu8eCsS807opwLBtxOfmzVkubapc+luPvK/VNBCTgq9K4ZcD
         vXug==
X-Gm-Message-State: AO0yUKW/NW1hyLxJmAGZ5kUOzInnECSHc/fWNX1+da8/b/StM+AWK7xI
        HtAig3W6AsMOykvGaVpHlHVGRBBP6dxTE8u7X2M=
X-Google-Smtp-Source: AK7set/ahvuT+KxLdBz8764APmJ0NYeqTvmm+SblyhrmbiWYgWtljT0a+YnE8eGoniS73mSbxc3/t+LN+DPYLKb4OXA=
X-Received: by 2002:a05:6402:1ca2:b0:49e:36d1:16e with SMTP id
 cz2-20020a0564021ca200b0049e36d1016emr5010928edb.42.1675616501575; Sun, 05
 Feb 2023 09:01:41 -0800 (PST)
MIME-Version: 1.0
References: <CADPR2CUgrO6ius5ss9Mgk8Zktf+4zQDq0vP4EEKOMku7K=V6FA@mail.gmail.com>
 <CAN0heSqwVV_G_nrt=omK0UjXVAD+TYPC+oB-1xHF4dG4oovncA@mail.gmail.com>
 <CADPR2CXR_KRKFjPA-0ZuHGHHq_-epHXtJWCuwYx6uvLF_H49mg@mail.gmail.com> <CAN0heSruSHQk8cPZ1-Zhp8dfL+j-OAsASrsBTVdWKQcx14Pxtw@mail.gmail.com>
In-Reply-To: <CAN0heSruSHQk8cPZ1-Zhp8dfL+j-OAsASrsBTVdWKQcx14Pxtw@mail.gmail.com>
From:   Diogo Fernandes <diogoabfernandes@gmail.com>
Date:   Sun, 5 Feb 2023 18:01:05 +0100
Message-ID: <CADPR2CWzjiPJn9ZtkcU0ZTbacq5JQu2vXriuLq+VreqqUo_-dA@mail.gmail.com>
Subject: Re: Bug Report: Superfluous Tab Characters
To:     =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Martin,

I am not personally parsing the output of git. This was rather
observed while using a third-party tool that reads the output of git
as initially pointed out by
https://github.com/trufflesecurity/trufflehog/issues/1060.

I have the latest v2.39.1 from `brew` on macOS and the tab character
is added to the output.

Anyhow, thanks for checking.

Regards,
Diogo

On Sun, Feb 5, 2023 at 4:28 PM Martin =C3=85gren <martin.agren@gmail.com> w=
rote:
>
> On Sat, 4 Feb 2023 at 13:54, Diogo Fernandes <diogoabfernandes@gmail.com>=
 wrote:
> > On Fri, 3 Feb 2023 at 14:43 Martin =C3=85gren <martin.agren@gmail.com> =
wrote:
> >>
> >> On Fri, 3 Feb 2023 at 13:50, Diogo Fernandes <diogoabfernandes@gmail.c=
om> wrote:
> >> >
> >> > I have run into a bug where git seems to be adding superfluous tabs =
to
> >> > the end of filenames that contain a space. I have attached the outpu=
t
> >> > of `git bugreport` for your review. Feel free to have a look
> >> > https://github.com/trufflesecurity/trufflehog/issues/1060 for
> >> > additional context.
> >>
> >> The code that adds this tab in the output of `git log` and friends has
> >> changed a bit since it was originally added in 1a9eb3b9d5
> >> ("git-diff/git-apply: make diff output a bit friendlier to GNU patch
> >> (part 2)", 2006-09-22), but in that commit you can see the original
> >> motivation.
>
> > So, this is by design and not a bug? And is it still current in the lat=
est version of git?
>
> Yes, it appears to be by design:
>
>     Somebody was wondering on #git channel why a git generated diff
>     does not apply with GNU patch when the filename contains a SP.
>     It is because GNU patch expects to find TAB (and trailing timestamp)
>     on ---/+++ (old_name and new_name) lines after the filenames.
>
>     The "diff --git" output format was carefully designed to be
>     compatible with GNU patch where it can, but whitespace
>     characters were always a pain.
>
>     This adds an extra TAB (but not trailing timestamp) to old_name
>     and new_name lines of git-diff output when the filename has a SP
>     in it.  An earlier patch updated git-apply to prepare for this.
>
> From a quick test, this behavior does seem to be in newest git.
>
> I sense there is some sort of ulterior motive here that hasn't come
> across yet. Are you trying to parse the output of `git log` to find
> something? Would `git diff-tree` work, e.g., if you're mostly just after
> the filenames involved?  Depending on what you're trying to achieve, it
> could be a bit simpler to parse `git diff-tree` and other "plumbing"
> commands, rather than `git log` and other such "porcelain" commands.
>
> (Also, note that one person's `git log` output can be different from
> yours, e.g., because of various config knobs being set different ways.)
>
> Martin
