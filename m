Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E6B7C4332F
	for <git@archiver.kernel.org>; Wed, 16 Nov 2022 02:04:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231590AbiKPCEi (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Nov 2022 21:04:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229923AbiKPCEh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Nov 2022 21:04:37 -0500
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EB9F12A88
        for <git@vger.kernel.org>; Tue, 15 Nov 2022 18:04:36 -0800 (PST)
Received: by mail-io1-xd31.google.com with SMTP id h206so12192577iof.10
        for <git@vger.kernel.org>; Tue, 15 Nov 2022 18:04:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kAzpASrbg54IQwM3LeRDDuzWlHzkVhli8txuRLsuvgE=;
        b=X4WjfN5v/fqYIS2Vc+c2bT2ouT/GUBMIpGL/1QAd271Il4zjlRfiR/DMHFOac117hF
         WaIZ5dQdlwzkPioaD73vbQ0laNIGx5elsVP1hgrK8Q4om1D65cNtWkWJbveNJOV8tgbX
         YES4WNUnJRUsvIsnkhpUwqaMeE5wAF+TejZMa4SDYCRtG53+Gp6GBp0NQca5ST4buDTs
         a8vb20D2mq/f24M7NYvEdR35qQzbyCthu/mUaZJL8/qcfYmCHDKPC253jrqHVopLJRhz
         aKjzJqEtb+C/3Jc1f2Jb/GDEpAqtH9EMzsNIiJiDj8WWOJVgH9zSg0eI3+bMfb+1ppQh
         cFOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kAzpASrbg54IQwM3LeRDDuzWlHzkVhli8txuRLsuvgE=;
        b=UeMHK8p+x8nesOe6jT0DpBy02++F7w3XlHyiAQol4WKW6NRuGKlhQqrA9aPHR8lhRJ
         O12gv3bJYirFzzHH1C3tJzCXNppBQnvorQUyZEUFNlK6RSsIB1yOHponTi9r4+kDTbyX
         AoIiYPU7Z4RgMeAM0oDOLMt+372hgYYNhnfVJrbBAD2K/gySvQRzkaoR9WBH3mq2ypH+
         Ed9p7rBg/CDwPo3tanLic45CyPze6t43GSEE2uFYLs29d5mAjWAK/ronWzbHvEwU+Kcq
         ipZFtzfDQnfDvuHLp/PQ+zwODaFEWu1rbW2Qbxf7WHCIaosxXZ+7IrVnhXX9B7K9i/Hw
         Ns/Q==
X-Gm-Message-State: ANoB5pk/TYambuemBN2gz56XHTKLMDKjybFBWuOU/X4A1IQk9rs05rZl
        P7ZJZlh4PwJAmesnsQEDKbOEUgqDIJ9qyg==
X-Google-Smtp-Source: AA0mqf67MTLtOldqhlGFgV/OsAXjNV1YPu+Xhz/Vwsovvi6uOwCFFMYhwiBGqn5S1ut12lxLAdycTg==
X-Received: by 2002:a5e:c917:0:b0:6d6:d016:b607 with SMTP id z23-20020a5ec917000000b006d6d016b607mr9314664iol.70.1668564275989;
        Tue, 15 Nov 2022 18:04:35 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id j184-20020a0263c1000000b0037508cc0bc2sm5315069jac.12.2022.11.15.18.04.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 18:04:35 -0800 (PST)
Date:   Tue, 15 Nov 2022 21:04:34 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        Jacob Abel <jacobabel@nullpo.dev>
Subject: Re: What's cooking in git.git (Nov 2022, #03; Mon, 14)
Message-ID: <Y3RFMrhgVYLR6nZ4@nand.local>
References: <Y3Mag8qG2D3qjlmg@nand.local>
 <CAPig+cSKaW0ejeVgS7XEphMibdmExxO_T+xjMo6My5SAfwou_Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPig+cSKaW0ejeVgS7XEphMibdmExxO_T+xjMo6My5SAfwou_Q@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 15, 2022 at 03:58:02PM -0500, Eric Sunshine wrote:
> On Mon, Nov 14, 2022 at 11:53 PM Taylor Blau <me@ttaylorr.com> wrote:
> > * ja/worktree-orphan (2022-11-10) 2 commits
> >  - worktree add: add --orphan flag
> >  - worktree add: Include -B in usage docs
> >
> >  'git worktree add' learned how to create a worktree based on an
> >  orphaned branch with `--orphan`.
> >
> >  Waiting for review discussion to settle, but leaning negative.
> >  source: <20221110233137.10414-1-jacobabel@nullpo.dev>
>
> I haven't had a chance yet to look at Jacob's v3, but this series does
> close a gap in worktree usability[*], and v3 addresses a stated
> concern of mine against earlier iterations, so I think a "negative
> lean" may not be warranted.

Thanks for saying so, I dropped this from my notes, so the "leaning
negative" designation will be gone in the next WC.

Thanks,
Taylor
