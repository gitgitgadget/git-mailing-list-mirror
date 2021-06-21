Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C685EC4743C
	for <git@archiver.kernel.org>; Mon, 21 Jun 2021 21:58:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A403060C3D
	for <git@archiver.kernel.org>; Mon, 21 Jun 2021 21:58:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231653AbhFUWA7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Jun 2021 18:00:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231159AbhFUWA6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Jun 2021 18:00:58 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3D28C061574
        for <git@vger.kernel.org>; Mon, 21 Jun 2021 14:58:42 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id u13so13300344lfk.2
        for <git@vger.kernel.org>; Mon, 21 Jun 2021 14:58:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=rYXjXagctadh3DRRytHuIQhWuIGNLb82oBK4EPcZ+8M=;
        b=fWUgJE4quF8ItT4dmP4p5WqhOZsEJ3JXeaXbLmQZChW+z89T7Uw7WckYfSEn8PU9Q0
         CYKhoi17/1IkNFue3+mrd1IxgE1V5XLzh2nfQUds81DOnlCB0vrgVmzR/QwbS3JtKE54
         vvXNIYWocbW1uZyPWqBzZjO1JeMFev3o4P8ZRj30p1HD7kHuu8fTUI6IsXwOrppMSMcj
         Rbcoe7ctGBvub3ExTL+b/1aBGjEl0nFas+S1rG96nbKQziugPvs71V8KCOD4G6zgUQ6X
         pa129YB9ZuoZ4wQUrLYO7Xi/bWsA/oW9V3PrCOyIFmq3NqM8LUbZfOEj8UtxI07oJzeu
         f5hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=rYXjXagctadh3DRRytHuIQhWuIGNLb82oBK4EPcZ+8M=;
        b=Dyt3LKldBVv1MuNA+acnuMvbtR1T1eh484SqyU8hiR0Aosxs0oNQJczy/PgGEOnRZZ
         9+hJjDqVkeFmgueAKAMQsyp0dkJ5jkEghVwbekRbAfR+wQoMAHfkN4od3n5MPKE2ZdjA
         ehE99vH09ha6Itm53rIqy38bad2jEG1pFzBg5Crpwz/VZFUClQf20XBWhS+aFEaAmFuC
         DbIETEfCP6sdghwLrKXAzQNRriqntu/ka1QIu4Q4Y+UK0F8wI964iAVp2B0mjdXdfjjs
         fiCkoVeA+Trycyq4BJwtDnhpXY8HAimz3uaTIFCURJBCJ2LLzU9dFq1kRoniS0Ask2ZN
         Bm4Q==
X-Gm-Message-State: AOAM530NYtT+oPI6P4/DZz9w0hBcTD5VwQfYL8IuMAy5VZKCbhebdSSZ
        k23uIVs6BnKJj7kU0CsmmgAXOZlgE42CQSjY4Fiat2MKDYc7NcLt4ss=
X-Google-Smtp-Source: ABdhPJwIpskt9FK9Uc3wmJYbsQeJ+scTEZRe3ficI5pNBoHcWCx1KNMJfobtp3EMaPTndBFq/CdnSwxnBbxPvyZP5BY=
X-Received: by 2002:a19:2d01:: with SMTP id k1mr267720lfj.461.1624312720902;
 Mon, 21 Jun 2021 14:58:40 -0700 (PDT)
MIME-Version: 1.0
From:   Hongyi Zhao <hongyi.zhao@gmail.com>
Date:   Tue, 22 Jun 2021 05:58:29 +0800
Message-ID: <CAGP6POJErqxTf1=u=N0Fg28Fz+8t3Y8o1peiGP1nqEuttKgN2w@mail.gmail.com>
Subject: About the usage of core.gitproxy.
To:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Ubuntu 20.04, I noticed the following document for `core.gitProxy':

$ man git-config |egrep -A13 -i '^[ ]*core.gitproxy'
       core.gitProxy
           A "proxy command" to execute (as command host port) instead
of establishing direct connection to
           the remote server when using the Git protocol for fetching.
If the variable value is in the
           "COMMAND for DOMAIN" format, the command is applied only on
hostnames ending with the specified
           domain string. This variable may be set multiple times and
is matched in the given order; the
           first match wins.

           Can be overridden by the GIT_PROXY_COMMAND environment
variable (which always applies
           universally, without the special "for" handling).

           The special string none can be used as the proxy command to
specify that no proxy be used for a
           given domain pattern. This is useful for excluding servers
inside a firewall from proxy use,
           while defaulting to a common proxy for external domains.

For my case, I've a local socks5 proxy running on "127.0.0.1:18888",
how should I set the above option so that the following command can
pick up this proxy:

$ git clone git@github.com:torvalds/linux.git

Regards
-- 
Assoc. Prof. Hongyi Zhao <hongyi.zhao@gmail.com>
Theory and Simulation of Materials
Hebei Vocational University of Technology and Engineering
NO. 552 North Gangtie Road, Xingtai, China
