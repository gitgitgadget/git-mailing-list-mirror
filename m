Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D509FC5479D
	for <git@archiver.kernel.org>; Mon,  9 Jan 2023 21:13:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237967AbjAIVNC convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Mon, 9 Jan 2023 16:13:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237841AbjAIVMN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Jan 2023 16:12:13 -0500
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA3E8517F5
        for <git@vger.kernel.org>; Mon,  9 Jan 2023 13:08:12 -0800 (PST)
Received: by mail-pf1-f178.google.com with SMTP id c26so2743088pfp.10
        for <git@vger.kernel.org>; Mon, 09 Jan 2023 13:08:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7KdQKsF5r50OGvgYWPyPn5tZo7DCUa6yZAOd7RqOjVU=;
        b=xC6iBhXi6ZDszKmdMF8bCwaVat1c7+SLqvwsLS/FWnIo5PTv4BL3yKG0dFKy1WPKEx
         kkywZC5OLQJ7JGRjyMOyS/Gf+Cq4u9DSlFeR96Rv9y5zz3V6lHCupREomIwRnIi8otwL
         HgT12T0oETBEtm+RBLxAmOb0JKczi7fOPnNUJrxninjuScyi+g2Xg488V5VN7yior+nf
         dnvdWrhKwHoGC0vYyUWXg6jToSGDV7ZUMAFqcUThg+YQVMi3xK5Ab4rvtWGZzdWOn9ud
         q0twk3eJC1XcqYDW/51wBGn6KJWs+5tadpm2xqPy9S+5kNnMNnjgGJtEDwxoAb3b7OQ0
         3ZJQ==
X-Gm-Message-State: AFqh2kqh1R+Z24G6P/SQLOZ2rtr75fMo+SqV0kmnLCYstWMAMcOhvEt5
        fPKLbeFTJLIoArJC0iKc4ZgHUnlklMNzmH5iA6g=
X-Google-Smtp-Source: AMrXdXtILKtQSwLC6GEW+Pq+L+YzZHow7wHgrdjW7Lcgqb17E2PBZGamCDCe/YLqPvaBIe2T05I058kIr4Lw29ghKrk=
X-Received: by 2002:a05:6a00:1414:b0:580:e5ef:79f2 with SMTP id
 l20-20020a056a00141400b00580e5ef79f2mr3416680pfu.60.1673298492197; Mon, 09
 Jan 2023 13:08:12 -0800 (PST)
MIME-Version: 1.0
References: <pull.1422.git.git.1673166241185.gitgitgadget@gmail.com>
 <xmqqbkn8wcqo.fsf@gitster.g> <018501d9241b$fe4b1270$fae13750$@nexbridge.com>
 <CAPig+cQ1PMYhWiwRiq2eOWzHYmqcCC6QfkHCuVTxaeA7fz0ddw@mail.gmail.com> <01ad01d92464$b62492c0$226db840$@nexbridge.com>
In-Reply-To: <01ad01d92464$b62492c0$226db840$@nexbridge.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 9 Jan 2023 16:08:00 -0500
Message-ID: <CAPig+cTJ7CQpeo6v6j0L1beoTKyKnXcii2vYqRwy40R01vCo+A@mail.gmail.com>
Subject: Re: [PATCH] doc: use "git switch -c" rather than "git checkout -b" consistently
To:     rsbecker@nexbridge.com
Cc:     Junio C Hamano <gitster@pobox.com>,
        Yutaro Ohno via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Yutaro Ohno <yutaro.ono.418@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 9, 2023 at 2:58 PM <rsbecker@nexbridge.com> wrote:
> On January 9, 2023 2:17 PM, Eric Sunshine wrote:
> >On Mon, Jan 9, 2023 at 6:20 AM <rsbecker@nexbridge.com> wrote:
> >> git switch is still marked as EXPERIMENTAL in the online help. I don't
> >> think moving broadly to switch from checkout in the documentation
> >> should happen until the EXPERIMENTAL designation is dropped. After that, then
> >"switch -c"
> >> should be used everywhere instead of checkout (except for in the
> >> checkout documentation).
> >
> >Such a point probably should have been raised when 328c6cb853 (doc:
> >promote "git switch", 2019-03-29) was submitted, but since 328c6cb853 was
> >merged nearly four years ago and has been pointing people at git-switch all this
> >time, it's probably too late to use it as an argument now.
>
> I agree. Perhaps it is time to drop the "EXPERIMENTAL" notices from 'git switch', in that case.

Perhaps. Perhaps not. As I recall, both Felipe and Ævar expressed
rather serious concerns that git-switch is not yet ready as a proper
git-checkout replacement. Samples of their concerns can be found at
[1] and [2], for instance.

By the way, git-worktree is even older and probably more widely used
than git-switch, yet it is still marked "experimental", as well, and
perhaps rightly so. As far as I understand, for instance, it still
isn't compatible with submodules (though there may have been some
recent work from one of the Googlers in that area?).

[1]: https://lore.kernel.org/git/211021.86wnm6l1ip.gmgdl@evledraar.gmail.com/
[2]: https://lore.kernel.org/git/CAPiPmQnb=XMaF2+YkryEbiX8zA=jwa5y=fbAGk9jpCExpbS4Rw@mail.gmail.com/T/
