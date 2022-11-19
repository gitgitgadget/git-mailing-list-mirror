Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E42A6C433FE
	for <git@archiver.kernel.org>; Sat, 19 Nov 2022 01:56:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231969AbiKSB4M (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Nov 2022 20:56:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232171AbiKSBzu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Nov 2022 20:55:50 -0500
Received: from mail-4022.proton.ch (mail-4022.proton.ch [185.70.40.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 986AA102E
        for <git@vger.kernel.org>; Fri, 18 Nov 2022 17:44:53 -0800 (PST)
Date:   Sat, 19 Nov 2022 01:44:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nullpo.dev;
        s=protonmail3; t=1668822290; x=1669081490;
        bh=zWRWl1ADotTUmi3zPMsIjG4rZc4IzOp3PwRyJnwhkUY=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=1H+5N58r1RAC9/dRaf6yx/0cCD0fNtdI03eTNe+HvoBxzlyncNGS++hoRpcy4pYIM
         9k74MlKBAOLreND0rNmAK6jbEy8N9Bf1uiDUUR+1tVzcoSht2vwj7yPNSsoql5IMDF
         k1fzRqL1d6oGvolUtsVUGHnM97EJPiWFn6xq4xmgT6h6ZK6Nb+NqWd+3DZNvqO65JN
         uVY4RtZ2IAjuQR51LWVUNRRKool/i66Xw8oSzuOoT/J+cqcPjwacJaAHvHdQj46Okc
         SeJvN7/FXGGoi0L9M7pURahY7IAc6NKqSXp7sv4fgyfMUTN7xHWx/fXOxV5jXpeCsW
         c6c1XBMo/WRQA==
To:     =?utf-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
From:   Jacob Abel <jacobabel@nullpo.dev>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v3 2/2] worktree add: add --orphan flag
Message-ID: <20221119014436.737kqsmcezkck3do@phi>
In-Reply-To: <221115.86iljfkjjo.gmgdl@evledraar.gmail.com>
References: <20221104010242.11555-1-jacobabel@nullpo.dev> <20221104213401.17393-1-jacobabel@nullpo.dev> <20221110233137.10414-1-jacobabel@nullpo.dev> <20221110233137.10414-3-jacobabel@nullpo.dev> <221115.86iljfkjjo.gmgdl@evledraar.gmail.com>
Feedback-ID: 21506737:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 22/11/15 10:08PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>
> > +test_expect_success '"add --orphan" fails if the branch already exists=
' '
> > +=09test_when_finished "git branch -D existingbranch" &&
> > +=09test_when_finished "git worktree remove -f -f orphandir" &&
> > +=09git worktree add -b existingbranch orphandir main &&
> > +=09test_must_fail git worktree add --orphan existingbranch orphandir2 =
&&
> > +=09test ! -d orphandir2
>
> I'm not sure about "worktree" behavior, but maybe this "test ! -d" wants
> to be a "test_path_is_missing"?
>
> In general we try to test what a thing is, not what it isn't, in this
> case don't we fail to create the dir entirely? So "not exists" would
> cover it?

Ah yes that would be preferable. I've updated it for v4.

This shows up in the file in a few other places in this file as well
(from before this patch). Should I make the changes there as well and put
those changes into an additional patch in this patchset?

