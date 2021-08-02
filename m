Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F606C4338F
	for <git@archiver.kernel.org>; Mon,  2 Aug 2021 16:17:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB3CC60FC1
	for <git@archiver.kernel.org>; Mon,  2 Aug 2021 16:17:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232532AbhHBQRl (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Aug 2021 12:17:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232426AbhHBQRi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Aug 2021 12:17:38 -0400
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com [IPv6:2607:f8b0:4864:20::c32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8311FC0613D5
        for <git@vger.kernel.org>; Mon,  2 Aug 2021 09:17:28 -0700 (PDT)
Received: by mail-oo1-xc32.google.com with SMTP id s21-20020a4ae5550000b02902667598672bso4510393oot.12
        for <git@vger.kernel.org>; Mon, 02 Aug 2021 09:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jvJmFLDrt6Z8+WVRJo49W+xNfANbOV5mAtoS83LbROE=;
        b=YwJwlZJZNds3S79FPW2OBqEMSzk/wZk1Bxc5U4dgZe6Iyd6lWhNGmnh62OCBTP4mrG
         wDlY4eTnc4vTFuM2sL0VfPyogvWymgudXFQPcyulFUsVJmqcIe6Komv1hpgLbsh9Ou55
         CbsAsyzP4/aM7VNA3gq/DHZXMphtHjnxK4pB3ywOOAh3B06+IgnjZivH9vY+MI5VSRKu
         P9B1EQJpe8ypc/w3PwA+mfVhzYAORmBQ0CRtwOZTJQbr84HSxv2H88sD2oyLiXaQwd/A
         l783k0a0FpCraaR2Z+jgxh+wD0hK/Vn5cifjcznhEnbJKo/yXjDaTRkK+fPRhgJFMZzU
         5awA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jvJmFLDrt6Z8+WVRJo49W+xNfANbOV5mAtoS83LbROE=;
        b=jImdS1guSPw4S8Sgbgik3wuVLEgjWeDHt1hB5Ug58KWhE/u9ONuDk3BecXrTyyc0E5
         h4VP9RsjOcTMRqChV7msQSXKOZZJ+QC0YlfSFOmg5Ll1NtSwSe0J+1uB4JEhVzJCRxrO
         SWgAnaJ5FzXGmhp8LmHyEDEJTZ7/pkwu05ZJ8vJLUY0MdsfEh1Qtk2ek5xiwwErbvnii
         vKxH8X5NH7qPoN2cRar2xNM2DNGi4pP6Ps4f5ID2GLhjPjaAP2O1qDuS26gb9w0Kagkz
         x+hF7l2J2ZUVHnJac9Kt2qO957XffWIlH9upASU2RpBWDSicbeJC7WjjNHrgV9dvmwza
         9q4A==
X-Gm-Message-State: AOAM531DQfXUOAKUeziSm1YQqhweanfxAXpAyF+Ql8W6SPfZLHn+Fodw
        yUyChcNEunRkVtijoN8eKgpLLsTqtMxDXJldqRs=
X-Google-Smtp-Source: ABdhPJy4vyL0jrWsv1jhbhKSCqUA9F/2iiKp+0FzFzXpn6am8gKdaCFqsT97J34RiWj+Lkf+vGJbVCSqbLthgiMaVGc=
X-Received: by 2002:a4a:a385:: with SMTP id s5mr11134369ool.7.1627921047897;
 Mon, 02 Aug 2021 09:17:27 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1009.git.1627579637.gitgitgadget@gmail.com>
 <9212bbf4e3cab20fe49ab8e6dd4ac0277c4f2805.1627579637.git.gitgitgadget@gmail.com>
 <CABPp-BGbRbyCYYS+NcYrC-T4hJf7BCoLE2HsXFM4K51A0wSgcg@mail.gmail.com> <76639e16-204d-7812-d4c5-56c70e280bed@gmail.com>
In-Reply-To: <76639e16-204d-7812-d4c5-56c70e280bed@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 2 Aug 2021 10:17:17 -0600
Message-ID: <CABPp-BE1aKAsp6yKAzM-djRHuiP=GHC_Q7xZxMWPJ=f28bOeUg@mail.gmail.com>
Subject: Re: [PATCH 2/2] sparse-checkout: clear tracked sparse dirs
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 2, 2021 at 8:34 AM Derrick Stolee <stolee@gmail.com> wrote:
>
> On 7/30/2021 9:52 AM, Elijah Newren wrote:
> > On Thu, Jul 29, 2021 at 11:27 AM Derrick Stolee via GitGitGadget
> > <gitgitgadget@gmail.com> wrote:
...
> >> +                */
> >> +               if (S_ISSPARSEDIR(ce->ce_mode) &&
> >> +                   repo_file_exists(r, ce->name)) {
> >> +                       strbuf_setlen(&path, pathlen);
> >> +                       strbuf_addstr(&path, ce->name);
> >> +
> >> +                       /*
> >> +                        * Removal is "best effort". If something blocks
> >> +                        * the deletion, then continue with a warning.
> >> +                        */
> >> +                       if (remove_dir_recursively(&path, 0))
> >> +                               warning(_("failed to remove directory '%s'"), path.buf);
> >
> > Um, doesn't this delete untracked files that are not ignored as well
> > as the ignored files?  If so, was that intentional?  I'm fully on
> > board with removing the gitignore'd files, but I'm worried removing
> > other untracked files is dangerous.
>
> I believe that 'git sparse-checkout (set|add|reapply)' will fail before
> reaching this method if there are untracked files that could potentially
> be removed. I will double-check to ensure this is the case. It is
> definitely my intention to protect any untracked, non-ignored files in
> these directories by failing the sparse-checkout modification.
>
> > My implementation of this concept (in an external tool) was more along
> > the lines of
> >
> >   * Get $LIST_OF_NON_SPARSE_DIRECTORIES by walking `git ls-files -t`
> > output and finding common fully-sparse directories
> >   * git clean -fX $LIST_OF_NON_SPARSE_DIRECTORIES
>
> I initially was running 'git clean -dfx -- <dir> ...' but that also
> requires parsing and expanding the index (or being very careful with
> the sparse index).

`git clean -dfx -- <dir> ...` could also be very dangerous because
it'd delete untracked non-ignored files.  You want -X rather than -x.
One of those cases where capitalization is critical.
