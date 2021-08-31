Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 091FEC432BE
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 03:05:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E50746101C
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 03:05:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239467AbhHaDGh (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Aug 2021 23:06:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239451AbhHaDGg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Aug 2021 23:06:36 -0400
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com [IPv6:2607:f8b0:4864:20::c32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D385CC061575
        for <git@vger.kernel.org>; Mon, 30 Aug 2021 20:05:41 -0700 (PDT)
Received: by mail-oo1-xc32.google.com with SMTP id l12-20020a4a94cc0000b02902618ad2ea55so5249979ooi.4
        for <git@vger.kernel.org>; Mon, 30 Aug 2021 20:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9doQ4EnnzkrGmkGEpfpyqw3jNtIoSfQPRr4Wdr9g+5s=;
        b=B5U/0sbHmNvsIBrgjxi60rCnvgZ7NZPol4gdZA+H1llDVyz3gYCTAqkkm15sAYmLJ2
         EifabzL4/2cV71DAXUPzcSdFC77SfVseQTIv1oScTPUwxQId+mvsL0WHEx15viHOFeDq
         8+36MU45MTMcudtfAGGrMNnoi63bZ1/y+1RXOOSDzqTLYbbnCkE4hVvWpvq7jfTyUyL5
         0/lljS11yLhiQrQuq0Q5QjR+9bKn1DSbdmBBxcNoSH9Hql8PuN6z+DQ8oyHelR//FWzh
         AqVlJAkOYiGOcavrAHIt7vIQoddlmdw54FUWCcpYa01lkXLqHQJVaSnz+FSFkaxQngov
         r/mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9doQ4EnnzkrGmkGEpfpyqw3jNtIoSfQPRr4Wdr9g+5s=;
        b=fWSaUZ9epXhjfhS/vrK/mOPNmTEvBhSAfmiGDpWQsBydiWZ1912G5+ElXDRRA7oWN5
         cs2yQA4hQ90RaUP6XGEDTIIXUJZ3B0Xb2TdNeXDLNBhsbR2/vHtIjAGA29bpU2HtY6Sr
         Q9N8hnJNduuM2xtW2ENLMJRiH1em5GnJEaf5bcVEIdPaU8t9FFELCcyz5CXz+Scro3YD
         hmv+dcpM3aWwEL9iYSgxPDQTLM4XegK7TczqILuO7f6Haschxb3y70jaUqYxkO7G2a7d
         R4qL3EOzP1t9BBjzLG+v+QyeBKdCqMkSS46Pnh7FfmG9Vl0Tsnl3DFRgczmaciTCQYh8
         63mw==
X-Gm-Message-State: AOAM530mrddqlmK2SzoCT7OdpJMnFrngSfSK5p9mYDMe7D6qEhUwEy9t
        H9Z87OBhj4tdxh+30FOsuhAtrDbXpPXxQ2z/fkxZiQ/Npre1vw==
X-Google-Smtp-Source: ABdhPJy735//UzGvo64FQ0DFyxyfHfUzh98qCbMPVU51+58zMPKSnlOImPU2pYc/QK51Gwkzc1wnP10NFchodUk8tS8=
X-Received: by 2002:a4a:e923:: with SMTP id a3mr12509061ooe.45.1630379140796;
 Mon, 30 Aug 2021 20:05:40 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1083.git.git.1630379030665.gitgitgadget@gmail.com>
In-Reply-To: <pull.1083.git.git.1630379030665.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 30 Aug 2021 20:05:29 -0700
Message-ID: <CABPp-BEyach6xTxHduUzBLmh9bKG1aFZkBev4dOwWrw55VvNmQ@mail.gmail.com>
Subject: Re: [PATCH] rebase, cherry-pick, revert: only run from toplevel
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 30, 2021 at 8:03 PM Elijah Newren via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Elijah Newren <newren@gmail.com>
>
> Allowing rebase, cherry-pick and revert to run from subdirectories
> inevitably leads to eventual user confusion.  For example, if they
> are within a directory that was created by one of the patches being
> rebased, then the rebase operation could hit a conflict before the
> directory is restored leading the user to be running from a directory
> that no longer exists.  Similarly with cherry-pick and revert, those
> operations could result in the directory being removed.
>
> Similar to bisect, simply require that these commands be run from the
> toplevel to avoid such problems.

See also <xmqqv93n7q1v.fsf@gitster.g> and the rest of the thread.
