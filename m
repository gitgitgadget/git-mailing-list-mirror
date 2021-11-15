Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8854C433F5
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 00:29:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF0796115B
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 00:29:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352482AbhKPAcA (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Nov 2021 19:32:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345565AbhKOT2m (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Nov 2021 14:28:42 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43E83C0AFD6F
        for <git@vger.kernel.org>; Mon, 15 Nov 2021 10:55:48 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id y124-20020a623282000000b0047a09271e49so10391456pfy.16
        for <git@vger.kernel.org>; Mon, 15 Nov 2021 10:55:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=qPoBg7TJumxP821aXVKfoRoNgrdvQsJy/w3hSqflNac=;
        b=gCV0cdB8bAKo4RQbFk0pMeJLSdUrWtUi65id9X7MO2uH5peeA2ZP9mODIT+uQylOtW
         zifTwAjESMGkWnnC3rOqG6g0f2GFqB9RDr64MiU2lQ9pGHudQrYNWcQP8VEORv9CoJkw
         i+pl4Of3MYBN5PCEmsoBtij4cFpjKO795AA+jy2NeW2wSltpPXCZhIvofn7OHLCGIpo6
         9FX1iUZgTt6xydkFbt77FlXr0owk2048C8gbwhq+udnXgqtAlyso+wxoc+2lxqLfuWwK
         gR74WoWL9B3pR81nPO8vedSPmzVeEwTAhrJQpZveRrI7H1meisrHbpdiGXKWqHEgeSFJ
         9KPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=qPoBg7TJumxP821aXVKfoRoNgrdvQsJy/w3hSqflNac=;
        b=5a5Ks/DsF/AHFtoDOQ8W6dt0Dsg2dioxJE39enHOaA102hisxCF53yHC0+jLvkDPar
         aEXhuq9wTWy6EU1FgxjU0D6WS8ys7JRh/guQtirxtcIDCvM3xxKXngb36bhp73SpoVtv
         GbG1SuL4Uz8SOv1VaUeFFpwqlRWmVrbvwM6knXG2U1IQJGgpcgnW5XC8cFVWQbq6tmyU
         EG7unH2RMOr504xRZWCZDusoNQRLS++0q5jLbmTr4cLn2URER9dFCuaoLDM1f72e+vrd
         akA6eURDr2XjlWgo0DPZi5yfVF/hZ9FHT/zAot56AEblpMJlLc+l32GF9RNTOUFlWQLf
         i2qQ==
X-Gm-Message-State: AOAM5311m4Gyn7+qCjcG2mbg3xGYnEcUS3cVKuO5l+iKte6VZqOOPO/L
        3bmFFgAQpaJN/2LrGJH+jOZa5IreEuHpV0NsbALC
X-Google-Smtp-Source: ABdhPJz1UBou5JdvYGhK9z31T3p+kKFR/Sk9/rwGhaxnUrmf3L7sl+wxroFlXKSGgswWUA0T5S6WEEmKU55drYHnSe34
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a17:902:74cb:b0:143:6fe9:ca4 with
 SMTP id f11-20020a17090274cb00b001436fe90ca4mr38632474plt.2.1637002547800;
 Mon, 15 Nov 2021 10:55:47 -0800 (PST)
Date:   Mon, 15 Nov 2021 10:55:45 -0800
In-Reply-To: <20211028183101.41013-7-chooglen@google.com>
Message-Id: <20211115185545.1082815-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <20211028183101.41013-7-chooglen@google.com>
X-Mailer: git-send-email 2.34.0.rc1.387.gb447b232ab-goog
Subject: Re: [PATCH v4 6/6] remote: add struct repository parameter to
 external functions
From:   Jonathan Tan <jonathantanmy@google.com>
To:     chooglen@google.com
Cc:     git@vger.kernel.org, gitster@pobox.com,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Finish plumbing remote_state by adding a struct repository
> parameter to repo_* functions. This removes all references to
> the_repository->remote_state in remote.c - explicit references in the
> function bodies and implicit references via calls to non-repo_*
> functions. However, certain functions still use the_repository to parse
> oids.
> 
> Where a non-static function has the option to call either the static
> "remotes_*" variant or the non-static "repo_*" variant, use "remotes_*"
> in order to be consistent with the static functions. A desirable
> side-effect of this is that it minimizes the number of calls to
> read_config().

I don't feel as confident about this patch as I do about the patches
that remove the global variables - as you said, some functions might use
the_repository to parse OIDs (or do other things). I think that part of
this patch should go into the next series you have planned (as you
describe in the original cover letter [1], when you make future
submodule commands be run in-process), so that they can be tested.
(Removing the global variables was more of a mechanical code change, so
it was easier to see what's going on by just looking at "before" and
"after".)

Overall this patch series looks good with only minor comments from me,
except that I think that this patch (patch 6) should be dropped.

[1] https://lore.kernel.org/git/pull.1103.git.git.1633633635.gitgitgadget@gmail.com/
