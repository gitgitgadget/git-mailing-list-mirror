Return-Path: <SRS0=tECa=DD=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62A37C2D0A8
	for <git@archiver.kernel.org>; Sat, 26 Sep 2020 12:48:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1FF1C20BED
	for <git@archiver.kernel.org>; Sat, 26 Sep 2020 12:48:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QfgsD4sa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727072AbgIZMs6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 26 Sep 2020 08:48:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726210AbgIZMs5 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 26 Sep 2020 08:48:57 -0400
Received: from mail-ua1-x942.google.com (mail-ua1-x942.google.com [IPv6:2607:f8b0:4864:20::942])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 952DBC0613CE
        for <git@vger.kernel.org>; Sat, 26 Sep 2020 05:48:57 -0700 (PDT)
Received: by mail-ua1-x942.google.com with SMTP id h15so578097uab.3
        for <git@vger.kernel.org>; Sat, 26 Sep 2020 05:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=j2kAfDpCUKIFIq9HW6Vfu8rtQSBmz9lPdO7cZEq3ZmI=;
        b=QfgsD4sa8KQydMF7ebALLYeSfCj6QWeORBCUVtHvJT8mbuboTi6WmSuCNrVtjGf8A/
         QiMFGVZ97EEFHc/bB2CYXSBLmtLSr8hDXlEzMYlSWbyY6HE8Zip6OknmOw/rEJubOWJK
         Icx0RtPQD03rEWbS0l+To3Jtq2J9jRIAREQ6kW7aesp4zfASQUKagzJ6TsuKyZ8J3LIA
         t6lwKPqIl0s+tcjWyNUOSCvzARWeUignqgfZvrPmWUfbA0bBu1zWWatIrcrBu6rgbRPl
         1yaPuK289mKm/UjjTrxXgw7U7HLICBiOiuWXyk1r1X3iqom4T0NMWWtM+tbtipOJEM+r
         QZWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j2kAfDpCUKIFIq9HW6Vfu8rtQSBmz9lPdO7cZEq3ZmI=;
        b=PT2ER2b90wqw6ySTcqPiWqzvxC4hAmVmlh/mFwFq5ZCKVywP5vZoTNYcThvYxcMHj3
         +Y7aRGtGX8/kekauSPRnhQbZ5Gq0BvVVQijWsjtrXvhh9wdTL4f5JeDr+GIsJ+bfVroq
         G0vP5DCuGEP9oIYT5anUs/GdH04yNVDtoPHHX7RM6V6EcxKQZAvRdlVzILTEqHuEMFlL
         VrEt4htRWjtfI+RkDNp/9AlTdauZ7TBCIHjqQ3s4BkOUhTlrNFZIYsC7d4NLJXBkBXuK
         o+ZTMgQRDhF8BuMXuVeH8Rpi2+5CSU1XOAuj2MXxilY5Ol+JSzmoxHAUg7l5W5aJ1Q26
         4GAQ==
X-Gm-Message-State: AOAM5338hg5NC2tss5uVdthP+SiVUjmpkRlc9xbpp/cOoGUa3K4CXIfP
        ejLQw7+WczVSA+skWN39+e81rxv7RDM2FvlYkMo=
X-Google-Smtp-Source: ABdhPJxh7DqoQVa7zXjwjbvTTCTPOV6sHw4cO66mIkwr+j59WwZJUN3I0Rx3lMqenW82SnHOUMR2hlloN744IUYqLF0=
X-Received: by 2002:ab0:76c9:: with SMTP id w9mr1533000uaq.115.1601124536809;
 Sat, 26 Sep 2020 05:48:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200925070120.GA3669667@coredump.intra.peff.net> <20200925070550.GH62741@coredump.intra.peff.net>
In-Reply-To: <20200925070550.GH62741@coredump.intra.peff.net>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Sat, 26 Sep 2020 14:48:44 +0200
Message-ID: <CAN0heSp5ssE1_-0B4VMGcuOaW63EpWXRVp4E4gy_7zVZ1rWkew@mail.gmail.com>
Subject: Re: [PATCH 8/8] shortlog: allow multiple groups to be specified
To:     Jeff King <peff@peff.net>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 25 Sep 2020 at 09:09, Jeff King <peff@peff.net> wrote:
> +static inline int has_multi_bits(unsigned n)
> +{
> +       return (n & (n - 1)) != 0;
> +}

There's a HAS_MULTI_BITS macro in git-compat-util.h. I like how you came
up with the exact same name. It even makes me wonder if you are actively
avoiding it in favor of a re-implementation, but I can't see why.

>         enum {
> -               SHORTLOG_GROUP_AUTHOR = 0,
> -               SHORTLOG_GROUP_COMMITTER,
> -               SHORTLOG_GROUP_TRAILER
> -       } group;
> +               SHORTLOG_GROUP_AUTHOR = (1 << 0),
> +               SHORTLOG_GROUP_COMMITTER = (1 << 1),
> +               SHORTLOG_GROUP_TRAILER = (1 << 2)
> +       } groups;

Coming back to the comment on 2/8, adding a comma at the end wouldn't
reduce patch noise here and now, but whenever someone touches this place
the next time.

Of my comments in the last few mails, probably the only actionable one
is the truncated sentence in the trailer iterator header file.

Martin
