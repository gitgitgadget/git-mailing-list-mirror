Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35234C4332F
	for <git@archiver.kernel.org>; Fri,  4 Nov 2022 03:58:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230139AbiKDD62 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Nov 2022 23:58:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbiKDD60 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Nov 2022 23:58:26 -0400
Received: from mail-4317.proton.ch (mail-4317.proton.ch [185.70.43.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 044FD2601
        for <git@vger.kernel.org>; Thu,  3 Nov 2022 20:58:23 -0700 (PDT)
Date:   Fri, 04 Nov 2022 03:58:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nullpo.dev;
        s=protonmail2; t=1667534301; x=1667793501;
        bh=jF4WdReemOG8jkkDl1g9YX+fkhLHRl1Y4UNOCqYHdrE=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=Q0seJWsjwQVU9G8kPR08HliA71xno0kQFHR9IAa+f9EnJXXKMQtRiGLKqys0KzIYS
         12bSOy5a45ozIPGsT2uPyWH2zr5g2CG4iC7yjYou/iA1lQZPqzay5k13tuDhK9/8ee
         biRe5VQFhCYZx1JJ5yp3dasDcK98CN9M4G9XKHvsIqrdq4YGH9B6Y+Bh9FTiY6jEO7
         pS/mo7rBFLYjaP6P8sZLVqbI+vkhd+pdr/gZcsodvZI17hjyfQZsW5NhIu9mU1yTTd
         EwY2itKi37GP4WgMIdWIjwkOII5/gCU9sW6kjhlhJ9nqx6QA8DVWN4NxxGVECKSF9i
         XenXKFig4tv5w==
To:     =?utf-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
From:   Jacob Abel <jacobabel@nullpo.dev>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/4] builtin/worktree.c: Update checkout_worktree() to use git-worktree
Message-ID: <20221104035751.nnrfpvbqlqheb57k@phi>
In-Reply-To: <221104.86sfizzeq7.gmgdl@evledraar.gmail.com>
References: <20221104010242.11555-1-jacobabel@nullpo.dev> <20221104010242.11555-3-jacobabel@nullpo.dev> <221104.86sfizzeq7.gmgdl@evledraar.gmail.com>
Feedback-ID: 21506737:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 22/11/04 02:32AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>
> Won't we now start to run the post-checkout when doing this, and is that
> intended?

It appears it will. `git worktree add` runs the hook manually later after t=
he
`done` label so I can suppress the initial hook run in v2. Is there a
sanctioned way to do this beyond `-c core.hooksPath=3D/dev/null`? This seem=
s
hacky to put it lightly.

Alternatively would `git symbolic-ref HEAD "refs/heads/${new_branch_name}"`
work instead (along with reverting the change from reset to checkout)
when creating an orphan branch? It appears to work based on my quick tests =
but
there's something I might be missing.

