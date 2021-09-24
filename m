Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4581AC433EF
	for <git@archiver.kernel.org>; Fri, 24 Sep 2021 06:08:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 223B06124F
	for <git@archiver.kernel.org>; Fri, 24 Sep 2021 06:08:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244170AbhIXGKO (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Sep 2021 02:10:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244177AbhIXGKN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Sep 2021 02:10:13 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 129D8C061756
        for <git@vger.kernel.org>; Thu, 23 Sep 2021 23:08:38 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id g62-20020a9d2dc4000000b0054752cfbc59so6088240otb.1
        for <git@vger.kernel.org>; Thu, 23 Sep 2021 23:08:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=M9P/4Zf16Hcv/Cf/gq58KUSzi2ULBdXc2udqbLBl470=;
        b=mHZA3zQIOTY/ttvyIZIDH6D/TRbwmKnHgYlgihS431rQ9scIhxR7dbTfzfrvLsWDdw
         UhvCk8SsobaCPS/PQ9TgpociM7iAUkyy2WklejnQ5QJycMaUVV4KWgOZ+8uZxc3MEEQI
         RhwWIE8lkCou1JA4k7A7hb3UqtiIDDpzTLbP8H1U5cqI9fdfvfBoELlQ14xE0TCB+fF0
         sGMid1kdO/lhIqIix7V9H5KaCp8+7iSv6X99QPwpy9sHG9GApnmhI6fMENqCojaF+nqd
         ozuOmvQiH/66x4LtEWDwAMW0y13jUuzA5WtStKzk+oNZb5uMN+CA+AFwfUPjq5UR/nKu
         UOdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M9P/4Zf16Hcv/Cf/gq58KUSzi2ULBdXc2udqbLBl470=;
        b=UcB1qfaSVdrqDjzuy7g1OZBvxWj+Q4EIHq4Aj64FWSIm5oOQoWmCeKiF5dIzIvwe5e
         0bLFKMX8QuXulryk7S2vsbNANVAkHWdBcXky5sR1kCoNwX3zpugM8S3YkRzali5/UOwT
         8gBwgyofJW7X7r4r9BTs/jkxCnWmaDzdjDaoThlT6nhVUEZvGFBTod77D95/5cYq6Pnd
         sUxfRkTOblse37YIhVLnsFPekwSuShSLMqWXDFNySu/Hy+WB4zjZ52NoikdbvNwaU/pc
         0gSGWqCYEEgyOWSVnOYNZnCoufDJ4FLZ6Jgq2bl8aSa7PLOHDb/wv6zq/1EpbFdXZ6hz
         e3CQ==
X-Gm-Message-State: AOAM532TnLWGGGR4td7OFWUKnmzQJf/Gz+SdZmUvV4XnV1GvHizqeZlZ
        YpL8jN18QIGmOwjjkDJMY6eUOz142xp3l9qcXHVTd4qdDG0=
X-Google-Smtp-Source: ABdhPJzVvmpm3zwF8lVo+PPo3C58fsfVthxnju4zZvCEWGPJ+nRoKI+RluvVpPT+NmPMEivTmI713lPO/9DVESlcH4k=
X-Received: by 2002:a05:6830:2b27:: with SMTP id l39mr2503049otv.25.1632463717311;
 Thu, 23 Sep 2021 23:08:37 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1018.v2.git.1631453010.gitgitgadget@gmail.com> <pull.1018.v3.git.1632159937.gitgitgadget@gmail.com>
In-Reply-To: <pull.1018.v3.git.1632159937.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 23 Sep 2021 23:08:25 -0700
Message-ID: <CABPp-BGU3HgG5B7wXc-Wq1gwGYy_R9iveM7VRmUc80YhejLF1A@mail.gmail.com>
Subject: Re: [PATCH v3 00/14] Sparse-checkout: modify 'git add', 'git rm', and
 'git add' behavior
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        Derrick Stolee <stolee@gmail.com>, vdye@github.com,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 20, 2021 at 10:45 AM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> This series is based on ds/mergies-with-sparse-index.
>
> As requested, this series looks to update the behavior of git add, git rm,
> and git mv when they attempt to modify paths outside of the sparse-checkout
> cone. In particular, this care is expanded to not just cache entries with
> the SKIP_WORKTREE bit, but also paths that do not match the sparse-checkout
> definition.
>
> This means that commands that worked before this series can now fail. In
> particular, if 'git merge' results in a conflict outside of the
> sparse-checkout cone, then 'git add ' will now fail.
>
> In order to allow users to circumvent these protections, a new '--sparse'
> option is added that ignores the sparse-checkout patterns and the
> SKIP_WORKTREE bit. The message for advice.updateSparsePath is adjusted to
> assist with discovery of this option.
>
> There is a subtle issue with git mv in that it does not check the index
> until it discovers a directory and then uses the index to find the contained
> entries. This means that in non-cone-mode patterns, a pattern such as
> "sub/dir" will not match the path "sub" and this can cause an issue.
>
> In order to allow for checking arbitrary paths against the sparse-checkout
> patterns, some changes to the underlying pattern matching code is required.
> It turns out that there are some bugs in the methods as advertised, but
> these bugs were never discovered because of the way methods like
> unpack_trees() will check a directory for a pattern match before checking
> its contained paths. Our new "check patterns on-demand" approach pokes holes
> in that approach, specifically with patterns that match entire directories.
>
>
> Updates in v3
> =============
>
>  * Fixed an incorrectly-squashed commit. Spread out some changes in a better
>    way. For example, I don't add --sparse to tests before introducing the
>    option.
>
>  * Use a NULL struct strbuf pointer to indicate an uninitialized value
>    instead of relying on an internal member.
>
>  * Use grep over test_i18ngrep.
>
>  * Fixed line wrapping for error messages.
>
>  * Use strbuf_setlen() over modifying the len member manually.

I see that you and Junio had some interesting comments on the first 3
patches, so I look forward to seeing how those play out, but you
addressed all my feedback from the previous rounds here.
