Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E500C25B4E
	for <git@archiver.kernel.org>; Fri, 20 Jan 2023 15:31:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230390AbjATPbc (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Jan 2023 10:31:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230226AbjATPbb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Jan 2023 10:31:31 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07506C64A
        for <git@vger.kernel.org>; Fri, 20 Jan 2023 07:31:30 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id a11so8738470lfg.0
        for <git@vger.kernel.org>; Fri, 20 Jan 2023 07:31:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fF5NClrWe/cu7Zs1wk53Qngrt5teAt90kY+bghTIxEA=;
        b=HsJJbS4+hQmP9ATltA/RVe+xa1Hapn4rfA7WIFzmtE2cfFc7I6sP0BiXYqCYVFdRps
         QQIf/hcCx7ZW+GYM8qyT0rRR5TH4EEKFXy8FaZAwdJSSf6sNAU+Cq3nV/ZScOMLhS2Cn
         zMS/scCGJQ9ZKno2nhTkEEF6vPj+eobZMYP/jX9ZXDCn3YY5RuES8Ru23M3DbFdBbTMs
         ZTLaTCthHEChx3+1rPEiCTRg0ghS6s97I66zRwmJJ04KB4VtH36WOQp3ExeNX5Wkm3cD
         fNaI0YQTozCBEveBFv7vwGSd6lS+c90SJZlSYd8vULbXDVjkmJfgr9V7cydDqVgu8gf1
         Ojig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fF5NClrWe/cu7Zs1wk53Qngrt5teAt90kY+bghTIxEA=;
        b=qVt+3J8uku560JcZimhhnY7ZgRhy75C/JNzrSXSQH6L+C440NWPIkwLKc2JnFmEpnE
         aGBEH4J0NzyEsDwru666J3qxEH2q6K5DIwew6Q/Pf3o+gGKE3ouBU8CsSUHRK/E9HJKw
         T521Gg5uVG66NyEYxb6ETwUAA/BC8SJo8TtF4D4brdyrVH5fU2mVFB4f4D9cPNY7YUiT
         m0Zt9I9P9dJEzo0PeQTA3y055KrzDTzINR4x1+xKcx4yhxbvSa8Hj4aINZN3er9JK0+Z
         YLficthb4YnutGIoEUz6nergjuFKIBF1GzZHObJH8sBS8OosDgOWIL2dRcj6RGquq7vA
         Tq+w==
X-Gm-Message-State: AFqh2kqnIicf6qgq7tEnDC/hrvC6txAe+n4Z2SRoNuiOTCAnpRM5ZUDb
        TUFLUZ/qJ7wzZE35nbwo42w6DZFTL4BEKJzM5jk=
X-Google-Smtp-Source: AMrXdXvnHTvzJLh5Ye/ZDl4rzRKZKU9CPacj6gSqESjMBOn+9y/kdazbAWrjotOh5brzIFNllMQLS1vJYwYxbjrgUsQ=
X-Received: by 2002:a05:6512:3e11:b0:4cb:d46:94b7 with SMTP id
 i17-20020a0565123e1100b004cb0d4694b7mr783975lfv.405.1674228688173; Fri, 20
 Jan 2023 07:31:28 -0800 (PST)
MIME-Version: 1.0
References: <pull.1466.git.1674106587550.gitgitgadget@gmail.com>
 <pull.1466.v2.git.1674190573.gitgitgadget@gmail.com> <a0f8f5fac1c3f79cd46b943e95636728677dffef.1674190573.git.gitgitgadget@gmail.com>
 <xmqq5yd1za0t.fsf@gitster.g>
In-Reply-To: <xmqq5yd1za0t.fsf@gitster.g>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 20 Jan 2023 07:31:15 -0800
Message-ID: <CABPp-BFakaEqnpW4Xn1rzcOC6oVmcEz+OxBV4dKA_TJZ-xbTvg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] rebase: remove completely useless -C option
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 20, 2023 at 4:05 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > From: Elijah Newren <newren@gmail.com>
> >
> > The `-C` option to rebase was introduced with 67dad687ad ("add -C[NUM]
> > to git-am", 2007-02-08).
> > ...
> > As per the git-apply documentation for the `-C` option:
> >     Ensure at least <n> lines of surrounding context match...When fewer
> >     lines of surrounding context exist they all must match.
> >
> > The fact that format-patch was not passed a -U option to increase the
> > number of context lines meant that there would still only be 3 lines of
> > context to match on.
>
> I am afraid that this is only less than half true.  Isn't the
> intended use of -C<num> similar to how "patch --fuzz" is used?
>
> That is, even when a patch does not cleanly apply with full context
> in the incoming diff, by requiring *smaller* number of lines to
> match, the diff *could* be forced to apply with reduced precision?

Oh!  Reducing the number of lines of context to pay attention to never
even occurred to me for whatever reason.  I'll drop the patch.
