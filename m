Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73213C4332F
	for <git@archiver.kernel.org>; Thu, 15 Dec 2022 12:27:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229620AbiLOM12 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Dec 2022 07:27:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbiLOM10 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Dec 2022 07:27:26 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE0B0E03B
        for <git@vger.kernel.org>; Thu, 15 Dec 2022 04:27:25 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id w23so6656194ply.12
        for <git@vger.kernel.org>; Thu, 15 Dec 2022 04:27:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E5Re+VGPrEJn8ym0/dM3iSIhRMWWS+h5HK0+QLM12bk=;
        b=Cki5bjjb/wCBJ7no60Tl97a42uovcb7s38wRQSWrp9MBGGJqFz+Z9abCSLnwyOtcm0
         V4ipYzzX2vXMfnS+Kv12eO4zAeKt0cyFAn1t05wok15z6+02G/YhMivbR3P+LLxa07fZ
         ojxceAGySVNIzQSI5vbeNyXfzBRWqKrAhBCYiBfmnk4UcRIU+TNxxqSklvE4+QAtDQ3l
         ncIuJUKZhOc23h/IqHqAhW4oTcsj42dKtKPGjoAHSaav0PGp+QfrjbU0Kjbuftki0NTC
         8HRQgTNw0Sw64J/0EDwjkjDNRWchs1PU4vrsnSSFJl02hZ7mpZfqihSWEuxai6dSIzHi
         bnvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E5Re+VGPrEJn8ym0/dM3iSIhRMWWS+h5HK0+QLM12bk=;
        b=t92SBo9Aobnrp9SiLmnnH7HF6w+2QfNXgVc16AxI4G1VbcobCMZdLPMz4g4M/pL5c0
         CvA4uDw70InK3qkpAr4td2CcNicYZFZNyUWiS9zf8wwJvrZXqN+U4UF6lcAVXVmBOaG8
         zmWYGn1nGeizKyjx9u7k9912bBVnQHZO8I3XNp+SGyBp7RaRD7l9zO5QxYG5K22nfPBy
         a4iSYaaOUhPPOjnu48vqyJJLjvc84Dg/v9LEwLdnnD0zNVRh0NvNi7CfPXd3R4gi829h
         SpwuJ4BotBELFs1HxQYmPqy+astZdYshgvWNdyI76xJGe3g4/TVUCh9gKnge/R+iimZE
         jIfg==
X-Gm-Message-State: ANoB5pnHGGBYf2GgoSAfExBZxX5SCYQLdE94ODtBFTtPiqFcvzR5n/45
        hPvep/YlBV2EH+4h+H3U/7zXwk5Z79d1vkRy
X-Google-Smtp-Source: AA0mqf6EXeAQX1Lj17j0+SmZ8kpjIA3pJsmvcqnCLSz/84HAZoEQNTZDwLZN4ogXZKf9oRp8LnEuUQ==
X-Received: by 2002:a17:90b:eca:b0:219:1767:da71 with SMTP id gz10-20020a17090b0eca00b002191767da71mr29830002pjb.27.1671107245359;
        Thu, 15 Dec 2022 04:27:25 -0800 (PST)
Received: from localhost.localdomain ([47.246.101.63])
        by smtp.gmail.com with ESMTPSA id co10-20020a17090afe8a00b0021806f631ccsm3106400pjb.30.2022.12.15.04.27.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Dec 2022 04:27:24 -0800 (PST)
From:   Teng Long <dyroneteng@gmail.com>
X-Google-Original-From: Teng Long <tenglong.tl@alibaba-inc.com>
To:     gitster@pobox.com
Cc:     --cc=avarab@gmail.com, dyroneteng@gmail.com, git@vger.kernel.org,
        me@ttaylorr.com, tenglong.tl@alibaba-inc.com
Subject: Re: [RFC PATCH 0/1] push: introduce '--heads' option
Date:   Thu, 15 Dec 2022 20:27:19 +0800
Message-Id: <20221215122719.11996-1-tenglong.tl@alibaba-inc.com>
X-Mailer: git-send-email 2.39.0.rc1.5.gad6de9d3003.dirty
In-Reply-To: <xmqqilippgp2.fsf@gitster.g>
References: <xmqqilippgp2.fsf@gitster.g>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> My knee-jerk reaction is to avoid "--heads" and instead use
> "--branches", if this is about pushing all local branches.  The
> option "--heads" may still remain in some commands added to the
> system in the earliest part of our history, but soon we started
> to use "branch" over "head", as it is a more commonly used word.

OK, that's true, I just misled by some existing '--heads' in other
commands.

> How should it interact with --follow-tags?  Just as if you listed
> all local branch names on the command line?  I.e. is

Actually I didn't try '--follow-tags' before, but the documentation
about it is a  ittle hard to understand for me on first reading. Then,
I think it supports to use as negative '--[no-]follow-tags' but not
marked in the git-push.txt documentation.

>     git push $URL --heads
>
> equivalent to the long-hand
>
>     git push $URL $(git for-each-ref --format='%(refname)' refs/heads/\*)

git push $URL $(git for-each-ref --format='%(refname)' refs/heads/\*\*) maybe
to recursivly subdirectories matching?

Actually I didn't get why you represent this, maybe try to let's us know there
is another way we could make it as the same result?

> and because of that, does
>
>     git push $URL --any --other --option --heads
>
> behave identically to the long-hand with these other options added?

I think you concerned about the compatibility with the interaction of
the options, if so, I think a direct way is to keep --all and --heads
both have the some behavior when interact with other options, a little
confused why we have to use the long-hand to do that.

By the way, it seems like there are no specify tests for '--all', maybe
we can add some tests about '--all' first if this RFC patch is worthy to
continue.

Thanks.
