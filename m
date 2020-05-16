Return-Path: <SRS0=AWh0=66=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9554CC433E0
	for <git@archiver.kernel.org>; Sat, 16 May 2020 11:03:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6696D20727
	for <git@archiver.kernel.org>; Sat, 16 May 2020 11:03:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CPKE3V8D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726210AbgEPLDW (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 16 May 2020 07:03:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726170AbgEPLDW (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 16 May 2020 07:03:22 -0400
Received: from mail-ua1-x941.google.com (mail-ua1-x941.google.com [IPv6:2607:f8b0:4864:20::941])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E740C061A0C
        for <git@vger.kernel.org>; Sat, 16 May 2020 04:03:22 -0700 (PDT)
Received: by mail-ua1-x941.google.com with SMTP id 36so1743826uaf.9
        for <git@vger.kernel.org>; Sat, 16 May 2020 04:03:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DKTGUdaQvuUUYIBgdU+saZNL7InfEaCsmCi9f3bymJQ=;
        b=CPKE3V8DmiL5RBIMKZEpdSfnRZr50DgChFkHrElkK0uI5oFhU29ooVEjJiMzBLqkpK
         Cntehwfz3QikaQGgLBTimFtQv3bxLawcqgS8yDPnKmIAo/3+6owWrg82aIhVLjjHYAx7
         bYx5cfU1lWe73Zd0O8T0aybC9fpKn3p+D0O/l2yJwiRrOlyT3WmDH3sIXzTpKVo966cO
         tCTtiB8XLSFmf+nj8ORQxf9lc5YsiJLt4YWalRswDvtjzVzTALAzSFwRN2a92ZAZuTRq
         QlRmCJ88VLZX1BhTiuOvlpH5gi+vLIAOdByEjfNu0KLRsRcs/qRsLx0oZUkOsC2PnGg9
         a9dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DKTGUdaQvuUUYIBgdU+saZNL7InfEaCsmCi9f3bymJQ=;
        b=cfXKEJEcAXSQLLjsOzEgLiP7GdsuvaqBwRgwXZDpinsBvVAJC2emENFpZAglW7EzcP
         TGl/ShwG8oaIbKBtdqw5ehDbPHaBcsuePq9TKlVmbe66iJ11ia0JhOKlHtvPwfznmpDZ
         Oyx4jvHHRmWRtFEvDy50CxwOU0/cCCHX5bmzxqDBdbK41Nq3byheelXqzuB4adw4Tip6
         dV93YQhCdANIjU9MTAC9ci4mkCOsICfN+OjoXmuOWnJoagso6KTVkxNTmkYON3Wl9HmY
         G15MuwRd2rCJElrVgQhGLUivFAeqvuV8QTFHSxL7/OoQLwlFYXKX8BRy+4qByg91QjrZ
         CGdQ==
X-Gm-Message-State: AOAM531W3x9x3lE9/MDlYQsfeFE+NHL1WovU0lZnyVCXyPqlF4VfXeaj
        w9kAzvFSqGRSeeiS+2aLYGQtoXrNqvWzz4S0o+k=
X-Google-Smtp-Source: ABdhPJxGSJZs9Mg4Ywj2czyB9geLnlS5sXCLLyRG9Xuh80XswxnWZj99Eg3pOQ27PtTO50RBCwcN0PJTpKb742SMKTU=
X-Received: by 2002:ab0:1e4:: with SMTP id 91mr839326ual.112.1589627001375;
 Sat, 16 May 2020 04:03:21 -0700 (PDT)
MIME-Version: 1.0
References: <20200513005424.81369-1-sandals@crustytoothpaste.net> <20200513005424.81369-23-sandals@crustytoothpaste.net>
In-Reply-To: <20200513005424.81369-23-sandals@crustytoothpaste.net>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Sat, 16 May 2020 13:03:10 +0200
Message-ID: <CAN0heSrGJV4u2JJW98AbmQum-=KgDeBsDvRUU_RzbPHNfbcaUg@mail.gmail.com>
Subject: Re: [PATCH 22/44] fetch-pack: parse and advertise the object-format capability
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 13 May 2020 at 02:56, brian m. carlson
<sandals@crustytoothpaste.net> wrote:
>
> Parse the server's object-format capability and respond accordingly,
> dying if there is a mismatch.

> +       if (server_feature_v2("object-format", &hash_name)) {
> +               int hash_algo = hash_algo_by_name(hash_name);
> +               if (hash_algo_by_ptr(the_hash_algo) != hash_algo)
> +                       die(_("mismatched algorithms: client %s; server %s"),
> +                           the_hash_algo->name, hash_name);
> +               packet_write_fmt(fd_out, "object-format=%s", the_hash_algo->name);
> +       }
> +       else if (hash_algo_by_ptr(the_hash_algo) != GIT_HASH_SHA1)
> +               die(_("the server does not support algorithm '%s'"),
> +                   the_hash_algo->name);

Micronit: "} else if (...) {", i.e., join to one line and add braces.


Martin
