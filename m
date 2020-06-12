Return-Path: <SRS0=soZh=7Z=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 586D8C433DF
	for <git@archiver.kernel.org>; Fri, 12 Jun 2020 08:25:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2000D207D8
	for <git@archiver.kernel.org>; Fri, 12 Jun 2020 08:25:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="apNiwqgQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726323AbgFLIZf (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Jun 2020 04:25:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726264AbgFLIZe (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Jun 2020 04:25:34 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DC6AC03E96F
        for <git@vger.kernel.org>; Fri, 12 Jun 2020 01:25:34 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id x202so7946441oix.11
        for <git@vger.kernel.org>; Fri, 12 Jun 2020 01:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=kKSsQc4snr0OFYCs/pfaje79Xmk1GDCyiZz3sROVEVA=;
        b=apNiwqgQQxIcJs4dN143hTrDY0EuHn9vQIJbvAUXUKbljniicK92X3C7Bly1u21isH
         r0g/BCYAmHobqTvaRVeYKL85WO1vJ/lIZ/IYxcNR6ceKknTU0RNIW8wj94/DFnx6NZn5
         nw8P5HLBtVJcgnbyQ5mJ1Opp39hiiapXhiAgW/OraVj8cPO9M+3w6q7e10w9uMePC2h+
         vRKFYh/wI4QKfGm/kbY4n0jziJ/t3DdS6ZAeY5by+FeQhf9nQ6fU8z5OYmuqrOTU6VD9
         wzAArL6pFk/MfEGmLBL6Rl8rnnU4F8ymZMh9f+ibcL229rq8AVciR0uU7hJJye55jT9x
         Z3Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=kKSsQc4snr0OFYCs/pfaje79Xmk1GDCyiZz3sROVEVA=;
        b=ZMqGk/vIRV6w5GoftIeekSheZZz3Hv5Hfa7BibuWs461t5e5VfiEWeXLmbyUuYozJ5
         RljLKZ1zjWLbh4jAkAnjUxrMWSLeSQskLRqEfsoSXkY/MnvQt97lfo3cwHuxP48jllSM
         7u/rodY6uyS0vXZBlIGxgdaNKGQ7H1qils1sVALByjPvDF2dRla8TnNdeNkyBWR4FW7F
         ED4vjiq6jniXMYKzfRWFdGjnPioG9IzUwe9OagY2HruTRi9V2iqdoaHpnXcT3spdS0uT
         51xP2l/Eez/14ae1ZtuBh7PMvSLALD2CXgokmABCcvkCzWdmM4ZeHxl4KA1t/bNvk+Bb
         xLrw==
X-Gm-Message-State: AOAM531MVXmkYtm5TjZjgMcUZBdZDriSLMpUlL7qaBGkwuO4RuEwYwrj
        DYqpi8gxTBO3Xc2z8VN1Ufpy8TUn/LeishobhyxpQ9sO
X-Google-Smtp-Source: ABdhPJw5Iu2g7fK0PcBSFC4LaOcFoA0VwwPVICRqHFccwfES7TLP7iEjgr9POLzGoKS+gQiHnF2YVY+Zj8pkuk/aqt4=
X-Received: by 2002:aca:f5d7:: with SMTP id t206mr1251702oih.143.1591950333147;
 Fri, 12 Jun 2020 01:25:33 -0700 (PDT)
MIME-Version: 1.0
References: <CA+mQAOXSbwrNcxXYhp=FbPpQP01ENaGCD89AY7sbgfvwzOjyNg@mail.gmail.com>
In-Reply-To: <CA+mQAOXSbwrNcxXYhp=FbPpQP01ENaGCD89AY7sbgfvwzOjyNg@mail.gmail.com>
From:   Alberto Fanjul Alonso <albertofanjul@gmail.com>
Date:   Fri, 12 Jun 2020 10:25:22 +0200
Message-ID: <CA+mQAOVanZ7Sv2q8nDjP+3VkBPBn-HC4bzxyU4RK4PRUu_BBWg@mail.gmail.com>
Subject: Dealing git ignored files
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I developed a custom tool git-ignore to deal with different
buildsystems and developing.

I start it as a helper, really not knowing how useful it will be but
it end being used in any project at some moment (ignoring autotools in
source tree generated files, excluding test generated files, excluding
temp files, ignoring build directories...)

git ignore _build/
git ignore target/
git ignore -i Makefile.in
git ignore -i '*.o' -x dist/

It offers man page, help and autocompletion so:

git ignore --help
git ignore -h
git ignore <tab>

all work as would be expected for any git command

If offers an easy access to `./git/info/excluded` `.gitignore` with:

git ignore -e
git ignore -i -e

Which could fill a gap dealing with this files as `git config` does
with config files

It is maintained under autotools and use sharness as test suite, so It
pretty much mimic the git workflow.

I'm sure it can be improved in several ways, but do you think it is
something that can be added to the standard git tooling?

Any feedback would be appreciated, issue tracker is open to missing features:

https://github.com/albfan/git-ignore/issues

Cheers,
Alberto
