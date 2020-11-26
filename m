Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90041C56202
	for <git@archiver.kernel.org>; Thu, 26 Nov 2020 10:24:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 17D5B20DD4
	for <git@archiver.kernel.org>; Thu, 26 Nov 2020 10:24:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ESdD83ov"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387674AbgKZKYz (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Nov 2020 05:24:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732480AbgKZKYy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Nov 2020 05:24:54 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98F37C0613D4
        for <git@vger.kernel.org>; Thu, 26 Nov 2020 02:24:54 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id p8so1547621wrx.5
        for <git@vger.kernel.org>; Thu, 26 Nov 2020 02:24:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=Q+R5+e2RwqK9li7Ml9sSIqy38W9FkJV36j3z3tfTZ40=;
        b=ESdD83ovbgqEFDjHnopZwLF0ZjbAvibL/HIGL/ecJd/32L8VLirA8KKTs0s96WiPFJ
         AasJ6mxr4s7O+Xo1AQIvCqA/1AsX+MTHavZzQ1u6LAVwjAfWpYUcV+NDK3LOU333rpcg
         kz8iMhhWx6HCTmS7kfKKcVahAbXExQvzt1bvU18l4uoJjIADNQDF3x7QCLPi9r+6XzIs
         RjarS45scbFdQZPEuosg2aViccNnnrjybnlnsMxFyCdgqFxAUbcNXyHaBLFrSenOhaVv
         gtWZizzcS1MnFU71wWnzjGE7XXZxt9u0tKUvW755gQVyq799KPAex+doFNTy7l+pYEbm
         U5AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=Q+R5+e2RwqK9li7Ml9sSIqy38W9FkJV36j3z3tfTZ40=;
        b=Dt/E9RQjzXClO5zhagQNLZx7FwzsJKdRDRg9axcJUjVXsoDZTkUMHweJ7Ih/J9tRip
         t0NoS3eBYPBDj5qmskSmxDXoGzY25YPmDBYrydF6dcbZxdfGvm1A/Bev4VoBHXqLCMpw
         BJTIGBifl1Y/1RlaVIjYzbEKYh26oAjAvRnvxRoGrZub8azbZk/IREEtt5QLEoHQ+y27
         ZrTZOgJfQ5G0y+TYUud2TNhzmR5L32fMycvLC70SDxr7GiDLvtuyAgs0sM1fvhz/qEeO
         SQZSbH5vqLjyP4gnXAVDA5yXPWODy7SKNcEqjMKKIakFCk4vmcS/6GnjsrphD/EEZBfh
         J7nQ==
X-Gm-Message-State: AOAM533rC3cRnKX7IReIEPQ4O+L+c8YxS4XL3PWoANulDLBrP/e+y3AR
        SUgXJmXub9UIYwgE3QfImrP4u7tZe119RI8ObXYA7tHKh4JkCg==
X-Google-Smtp-Source: ABdhPJwTArBkEK/TmiPP7BsTra1OVQDRZr6XbOdR0qjozAO+B7XRyisGuzjjI3lEk4sqHURX3FrtEVUCbXzlfUiEAmQ=
X-Received: by 2002:a5d:4349:: with SMTP id u9mr2831776wrr.319.1606386293179;
 Thu, 26 Nov 2020 02:24:53 -0800 (PST)
MIME-Version: 1.0
From:   Felipe Contreras <felipe.contreras@gmail.com>
Date:   Thu, 26 Nov 2020 04:24:42 -0600
Message-ID: <CAMP44s1D-Zp3KDS+Hi74a=Lkc7Nc_0qiEzQEF0Pmj=bD8i+=JQ@mail.gmail.com>
Subject: New sharness/test vim syntax
To:     Git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

It gets a bit tedious to see all the tests in the same color, so I
wrote my own vim syntax file so that at least the body of
test_expect_success is highlighted properly.

I've updated it to make it handle more cases, and the result doesn't
look bad at all:

https://i.imgur.com/qDgvjtu.png

You can find it on my dotfiles:

https://github.com/felipec/dotfiles/blob/master/.vim/syntax/sharness.vim

What I do is place it on ~/.vim/syntax/sharness.vim, and then add the
following to my ~/.vimrc:

  au! BufRead,BufNewFile */git/t/*.sh set ft=sharness

I hope you find this useful.

Cheers.

-- 
Felipe Contreras
