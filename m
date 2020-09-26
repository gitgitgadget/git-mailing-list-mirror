Return-Path: <SRS0=tECa=DD=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D082C2D0A8
	for <git@archiver.kernel.org>; Sat, 26 Sep 2020 12:31:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E86C238E6
	for <git@archiver.kernel.org>; Sat, 26 Sep 2020 12:31:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cXOY/1w6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727017AbgIZMbq (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 26 Sep 2020 08:31:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726183AbgIZMbp (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 26 Sep 2020 08:31:45 -0400
Received: from mail-ua1-x942.google.com (mail-ua1-x942.google.com [IPv6:2607:f8b0:4864:20::942])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C649DC0613CE
        for <git@vger.kernel.org>; Sat, 26 Sep 2020 05:31:45 -0700 (PDT)
Received: by mail-ua1-x942.google.com with SMTP id f15so558009uaq.9
        for <git@vger.kernel.org>; Sat, 26 Sep 2020 05:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/qdzVahygGaiu7HH2fupQKNWStj0MhhO/jpOnR+98AI=;
        b=cXOY/1w6pptnNIRRctuB5Y+zV2Yh8J7Ox80JOrPMeEiZ0QWu60BG/8MvKxxe3rimtZ
         piXBKWiOiA8jbnzKRL8nJDuMopeF6EcLlP7XDUoa766mWwTLmoBtAbrh+SyXFrAmYtFY
         Oeqah1USVqOd/WFParzGk7FB9oeuZtNtq5JpSRf8UB0jaXZomO22+N74/wciLIV14C9Z
         Q1ql1Xz7owA+W1NdaOZrHnz8JHEWHH54yj8mY09+FalwTtMymYVJ32REzEGgHiwJsccK
         SHxslOiTG/4XHtgIu89n1islPgDtWOwQAA5TKGp2TReVvR0CuYqJ+FplAaq9OtzlfVQ5
         YSMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/qdzVahygGaiu7HH2fupQKNWStj0MhhO/jpOnR+98AI=;
        b=DPjn3qX1K0T/5roz+4eSd2QH2OjgU5Z/u4B+cx8n3UezYUloB1wM8MO8akC3Cd8sEp
         clFNbYmiPxK8UkqWqk9Y2clRE8b1f6Ydn5FE2w4unbp4JTc6Af1NVVTCJVs4ICeL6E7R
         QV73IYqnE0jzJwdFMYDsa0/+M/nx5g/zXqiVS7zu/RgHS7rH864Y8iKbXUlj7nHDUy4N
         HTHFLGkSCDMuG1BX5DstycH9SQ3b3yYpjN+jqko3tKQG4iX7xJ0aev+bBkXa5if6RwRX
         AZUuZuwasx7AtO4rot9kpYkZZrsAQkqE3EvXVtgMP9elhWvRTL83SZfw9ZLH7g+rJll7
         hJmg==
X-Gm-Message-State: AOAM532Z5HGGR8lQw4tDmGJ6V38eK0plCdx0Q60sqdCO3I787ulN2Jv6
        LqMDYJeAl+q60RMECcnQTVyVo2Ie47REUSWHJ7CyLRbgP7A=
X-Google-Smtp-Source: ABdhPJwu4o3IDTBiiedjFapgBOC4BfnsSKsetTkjKy4m1jBXVzbKD8koKq9J9jJcKQ9HYAVtfNdQ7CIt+yNSrhNeA1Y=
X-Received: by 2002:ab0:2904:: with SMTP id v4mr1491868uap.15.1601123504981;
 Sat, 26 Sep 2020 05:31:44 -0700 (PDT)
MIME-Version: 1.0
References: <20200925070120.GA3669667@coredump.intra.peff.net> <20200925070211.GB62741@coredump.intra.peff.net>
In-Reply-To: <20200925070211.GB62741@coredump.intra.peff.net>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Sat, 26 Sep 2020 14:31:32 +0200
Message-ID: <CAN0heSoS837ZCLt8WLRBrthXgOErwz-vXW8Af9v2ZdCcCpWRiw@mail.gmail.com>
Subject: Re: [PATCH 2/8] shortlog: refactor committer/author grouping
To:     Jeff King <peff@peff.net>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

Some random thoughts follow on this patch and a few others.

On Fri, 25 Sep 2020 at 09:04, Jeff King <peff@peff.net> wrote:
>
> In preparation for adding more grouping types, let's
> refactor the committer/author grouping code. In particular:
>
>   - the master option is now "--group", to make it clear
>     that the various group types are mutually exclusive. The
>     "--committer" option is an alias for "--group=committer".

I think this is more than a refactoring of the code. The user interface
is also refactored (if that's even the right word). From the subject and
the first sentence above, I did not expect this first "-" item, nor that
the patch would touch Documentation/.

> +       enum {
> +               SHORTLOG_GROUP_AUTHOR = 0,
> +               SHORTLOG_GROUP_COMMITTER
> +       } group;

You could reduce the patch noise by adding a trailing comma, see
cc0c42975a ("CodingGuidelines: spell out post-C89 rules", 2019-07-16).
(I do realize that you later redefine all values anyway.)

Martin
