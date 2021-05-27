Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 051F8C47089
	for <git@archiver.kernel.org>; Thu, 27 May 2021 07:21:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D3481613D4
	for <git@archiver.kernel.org>; Thu, 27 May 2021 07:21:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233848AbhE0HXN (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 May 2021 03:23:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234950AbhE0HXI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 May 2021 03:23:08 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40167C061574
        for <git@vger.kernel.org>; Thu, 27 May 2021 00:21:36 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id t24so4232253oiw.3
        for <git@vger.kernel.org>; Thu, 27 May 2021 00:21:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=lhnBCgL+Auz6c7OJvv497NgSQmWr5SgvnXW+idOFzrM=;
        b=gUE6E9CiGg9iBuEBRifp3T41zjzd6xssstLSh8gGin7jW87Ae9pYOrCMxpBXpBYtt/
         kHgH9pvda0eMLe6bFd9zQrYMIyGLWTp1c4RkS1yogU/YI++ufz8kWOD5jTHvSqCeMll+
         iCt3xn2tr2YQKuwQUK6WlaJrjLkwba0lqjVUnYoUZPueP5Kf5LQz+qD+O13HgENl6XZV
         kg0cacq08kAnJ0JjBagDBfrJgstv11hxLg9DWElPmgVTbmwiVZ9PTZU3Jpa1IvAmo8pz
         VlDDyqtInxtIHH5vYNsyRo+2Fj3IwNLAd89v43mfELjGt1fMcAgOUqqHqSy2JEY3s16y
         NSfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=lhnBCgL+Auz6c7OJvv497NgSQmWr5SgvnXW+idOFzrM=;
        b=kIHaOscBHNo/Ly/42zkAknk4bb/96IudXZokXzi26pwIPrpcvYIPRCgf4AKsTLg7xN
         z7J4ca5LOzIWHnzwfpqsrzXhcArXtFC6QmA0zOGkqVBaPwxA1TSvdMC8uozJD8KEAUwK
         piRGInV8ZzI1cNm3PbIx6oO+QVIWPd2ydlVFonxVQfhdFw9ZSBuPBX4YhfIK6GiVXYZu
         VK761eDY2qLqZRjjeHjtPFCk1W9eCw+OJY+CDKy9CaFcmspuqZ+pP7xr6AETemJb0Y//
         kMiSfsXRn0K7Xav6PNIE2l6PGk7cik9kVGghVXNwHuTjgseb2Em7pE8Hlc5BmZFz0he5
         LMww==
X-Gm-Message-State: AOAM530rUw66zjzIAHAWXTKfp0luf19TMUl4GgosOGZjJYJys9Qqc5wz
        ebrKfIryjgsMW0iXMfEANsB4TGxK4Lj0Of//Qq8uaalUljM=
X-Google-Smtp-Source: ABdhPJzhdAgFJ/ZD0nus5aTe9F+PVhRmqZYEbvK5Z5B28IFKWve/Wv9yxp6mUaKek1RM3//AhFLTeQQofuw6Cg7bfPA=
X-Received: by 2002:aca:4bd8:: with SMTP id y207mr4635710oia.39.1622100095625;
 Thu, 27 May 2021 00:21:35 -0700 (PDT)
MIME-Version: 1.0
References: <cover-0.9-0000000000-20210512T132955Z-avarab@gmail.com>
In-Reply-To: <cover-0.9-0000000000-20210512T132955Z-avarab@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 27 May 2021 00:21:24 -0700
Message-ID: <CABPp-BEtef+EzZTAQYutU67V4-=EiXHBH7wLm1ZEE5N+_NA5Yw@mail.gmail.com>
Subject: Re: [PATCH 0/9] send-email: various optimizations to speed up by >2x
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Gregory Anders <greg@gpanders.com>,
        =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>,
        Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Wed, May 12, 2021 at 6:50 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> As noted in the subject this speeds up git-send-email invocations by
> ~2x or more, and brings the very slow t9001 test from running in ~26s
> on my box to ~12s. It's no longer consistently the slowest test I run.
>
> This is basically done in two ways: We lazily invoke "git config" to
> get config, before it's very eager, and deferring Perl compilation
> with s/use/require/g.

I know I'm very late to the party, but I just wanted to comment that
this is super cool.  Thanks for speeding this up; some really good
finds here.
