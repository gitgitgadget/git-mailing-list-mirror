Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A4FEC54EBD
	for <git@archiver.kernel.org>; Sun,  8 Jan 2023 15:08:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233169AbjAHPIr (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 8 Jan 2023 10:08:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjAHPIp (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Jan 2023 10:08:45 -0500
Received: from mail-4018.proton.ch (mail-4018.proton.ch [185.70.40.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2591FC777
        for <git@vger.kernel.org>; Sun,  8 Jan 2023 07:08:43 -0800 (PST)
Date:   Sun, 08 Jan 2023 15:08:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nullpo.dev;
        s=protonmail3; t=1673190520; x=1673449720;
        bh=1kn459VYwcZsyhL+Tn46jPFS3+ik1IKcrOHFqB9BjS0=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=BSQk86vpf/cQUOYRFirRlXikpJZPRNkKnOSkmwLlNs3MEkXTq/2o1WB/ogT0sN6Gy
         1ALIRoukO4aVtxSMWL0G4PXACHt5P8AGKlCBReoKArRuXScbVUQbr8Zg5v13eZUWGS
         YvmZJ/q9WTLN60gLo48c6krzrk+q6iU8yMrH2OU7iFMFjYveE/pxswW9lAlqfayRvX
         xvC82SA8aT2lN9eLRjSu+P8yO1C1TnRCNvV5JxAp3a6cZKvtiydqrnsnewbJ2oDptE
         OhlpUXbv0dgr5gFLRUxBRf9Hn7/T4NnoIj3EjbQSnZEh6gf7O/wPgCgJLwfQbRjX0Q
         L7F0vVBBzNV6A==
To:     Junio C Hamano <gitster@pobox.com>
From:   Jacob Abel <jacobabel@nullpo.dev>
Cc:     git@vger.kernel.org,
        =?utf-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?utf-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, rsbecker@nexbridge.com
Subject: Re: [PATCH v7 2/4] worktree add: refactor opt exclusion tests
Message-ID: <20230108150814.sgyaimedaxfqo4na@phi>
In-Reply-To: <xmqq7cxxzefp.fsf@gitster.g>
References: <20221104010242.11555-1-jacobabel@nullpo.dev> <20221104213401.17393-1-jacobabel@nullpo.dev> <20221110233137.10414-1-jacobabel@nullpo.dev> <20221212014003.20290-1-jacobabel@nullpo.dev> <20221220023637.29042-1-jacobabel@nullpo.dev> <20221228061539.13740-1-jacobabel@nullpo.dev> <20230107045757.30037-1-jacobabel@nullpo.dev> <20230107045757.30037-3-jacobabel@nullpo.dev> <xmqq7cxxzefp.fsf@gitster.g>
Feedback-ID: 21506737:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 23/01/08 04:13PM, Junio C Hamano wrote:
> Jacob Abel <jacobabel@nullpo.dev> writes:
>
> > +test_wt_add_excl () {
> > +=09local opts=3D"$*" &&
> > +=09test_expect_success "'worktree add' with '$opts' has mutually exclu=
sive options" '
> > +=09=09test_must_fail git worktree add $opts 2>actual &&
> > +=09=09grep -P "fatal:( options)? .* cannot be used together" actual
> > +=09'
> > +}
>
> Of course, "grep -P" is non-portable and CI jobs are easily broken.
> Isn't -E (ERE) sufficient here?
>
Sorry. Changed. I can push out a new revision with this applied right away =
if
that's acceptable.

