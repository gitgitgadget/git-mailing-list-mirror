Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED6F2C433FE
	for <git@archiver.kernel.org>; Tue,  8 Nov 2022 10:51:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233735AbiKHKvW (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Nov 2022 05:51:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233697AbiKHKvM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Nov 2022 05:51:12 -0500
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95047120BD
        for <git@vger.kernel.org>; Tue,  8 Nov 2022 02:51:10 -0800 (PST)
Received: by mail-oi1-x22d.google.com with SMTP id r76so15058756oie.13
        for <git@vger.kernel.org>; Tue, 08 Nov 2022 02:51:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3A36DlCeXplb/KgX1gMDKXD1AONVpRlLAWhUm3wuJqI=;
        b=CjeeXtoDXdEhCwDlwUkLdSLXbTTVBzQSNVEGBdR1AesyExBus2e5QwnIFRuxr51brq
         Khk0afGvC+BuZJGTQCBfRQ/soaXLwtCwEjmeRdPkhQtExwAnEFY34MgTbrnrZxsB2Qka
         nbpy7iO7JyspdP86vjVDlIuHoJD21/5sobkt5dOOQQWBEMPd+8u0xLNvgV4cLQWRlyB5
         vBMXaOoH4ydCtxe6Z87mRLAW142DUwefio+UnXas3BVLX+oK7bUufVLNyJ/h+tzLZgio
         zjLy+ZaA1j8baxmOW79cy4FR9RGGoauwtwLBHI7uuJzutYi9BSBIVrWYo6xqhmqMlPuP
         YS8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3A36DlCeXplb/KgX1gMDKXD1AONVpRlLAWhUm3wuJqI=;
        b=jtOjkU5wnw4KLAj130zw1SOYXuiK2u+PO5l/uWSL2eQLUvhzTaWlwNs5oYtfAezSIz
         FB25xsr32HMycxVuR/48T+WuvX01pff2ZX19Y4C3p+3zTy7P4afAhRFyEkQmYXYXeHnj
         mhj3yF0Gcfx10JFPgo3Ieh1/Af7/TSLgxfTedYaddpO3fzpl5fD8Zvz4YxH1Lenqcrf4
         zftreWE25m+bUj0eRW6/9QPyTEqI4jGXBtuU+y4UcBEYb4iydojkAoorSzyKCgP8kzga
         xHxvfdISjz7PEO9+oD597gaLgVvxhsN1x8erV3VYs44o1UF7TncKuwKVAJSN9agIFRsn
         WHGg==
X-Gm-Message-State: ACrzQf3IFJ/erUHeziUw22vA/QRIf9L/1lHwt2Ugfup0KO/iXsNHfdb/
        XXtt0+BeDCTUR5P49e5J/fJRcx39Lj0mgbyD2b0Dp4XDVx4=
X-Google-Smtp-Source: AMsMyM5dDvreNBmoZjiL7/zSS+j2zdO6wQiWmxkDcm+raBFF5kKzj3u4LFWBgJJbBgQ2lY82fI8AaUjLwIhxrp4Rmco=
X-Received: by 2002:a05:6808:11c1:b0:353:f1a5:207a with SMTP id
 p1-20020a05680811c100b00353f1a5207amr37564437oiv.183.1667904669643; Tue, 08
 Nov 2022 02:51:09 -0800 (PST)
MIME-Version: 1.0
From:   M Hickford <mirth.hickford@gmail.com>
Date:   Tue, 8 Nov 2022 10:50:33 +0000
Message-ID: <CAGJzqskRYN49SeS8kSEN5-vbB_Jt1QvAV9QhS6zNuKh0u8wxPQ@mail.gmail.com>
Subject: The enduring popularity of git-credential-store
To:     git@vger.kernel.org
Cc:     "peff@peff.net" <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Among StackOverflow users [1], git-credential-store appears several
times more popular than any other credential helper. Does this make
anyone else uneasy? The docs warn that git-credential-store "stores
your passwords unencrypted on disk" [2]. Are users sacrificing
security for convenience?

Firstly, how grave is storing credentials in plaintext? Software
development guidelines such as CWE discourage storing credentials in
plaintext [3]. Password managers in desktop environments, mobile
operating systems and web browsers typically encrypt passwords on disk
and guard them behind a master password.

Secondly, the docs recommend git-credential-cache [2] which ships with
Git and is equally easy to configure. So why isn't it more popular? My
hypothesis: while caching works great for passwords typed from memory,
the combination of caching with personal access tokens has poor
usability. The unmemorised token is lost when the cache expires, so
the user has to generate a new token every session. I suspect GitHub's
2021 decision to stop accepting passwords [4] may have inadvertently
pushed users from 'cache' to 'store'.

Thirdly, why doesn't everyone use SSH keys? Unlike HTTP remotes,
upfront set-up is necessary to clone a public repo. For users
unfamiliar with SSH, this set-up may be intimidating. Introducing
users new to Git to SSH at the same time is a significant cognitive
load.

Any ideas how to improve the security of the average Git user?

[1] https://stackoverflow.com/questions/35942754/how-can-i-save-username-and-password-in-git
 probably as good a survey of non-expert users as we can get
[2] https://git-scm.com/docs/git-credential-store
[3] https://cwe.mitre.org/data/definitions/256.html
[4] https://github.blog/2020-12-15-token-authentication-requirements-for-git-operations/
[5] https://lore.kernel.org/git/20111210103444.GL16529@sigill.intra.peff.net/t/#u
discussion at introduction of store helper
