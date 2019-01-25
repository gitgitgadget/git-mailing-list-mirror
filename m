Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E39511F453
	for <e@80x24.org>; Fri, 25 Jan 2019 17:52:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729626AbfAYRwY (ORCPT <rfc822;e@80x24.org>);
        Fri, 25 Jan 2019 12:52:24 -0500
Received: from mail-vk1-f196.google.com ([209.85.221.196]:34453 "EHLO
        mail-vk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729190AbfAYRwU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Jan 2019 12:52:20 -0500
Received: by mail-vk1-f196.google.com with SMTP id y14so2326484vkd.1
        for <git@vger.kernel.org>; Fri, 25 Jan 2019 09:52:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=6XVHJ9T2M2bErgVKQIPEGwbyTu5aoOge7WqFIx2oSHc=;
        b=H2lQ/Pch4wbLdI0GNYHgegqI5FHeqDilpTGfCUW/jwTRe6qp7oW6bkTNtNxNiH3Msi
         te0wMLIcLB3FB2IAU60jcWmBGPkbI7ufCyFzvMwabcW2PBta+MCw0plwehg25aRmfnuF
         k+9VLq6gOR5Mk0sFRYOhmUSjZQH6zzRz32dmwTYItWP1wZZXsuH6Bt5ngDVjE3qMimw3
         84E2gsBUVG49zV54DQyMffwGs8Pi5dmiERfV9oIQ6/sekAF2sKO/+Si/R5MetCs5JEmX
         s+xe/YLvH1s4xQ9Z3PbKUjWZUem6aVd2VcezN0vCG9/yiHx/ntFkjNsnTngQ0FWXFUgV
         zNuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=6XVHJ9T2M2bErgVKQIPEGwbyTu5aoOge7WqFIx2oSHc=;
        b=Nv5VU88AvCSWMtmA817PpkIY9NOXZ40JtdaHNMNk/NJKL3yXYWoXNt/QVRI1gg1hjH
         uqict/yk8TeUDVyojuwTLUmVvO4Vq513Ig7TvVOxQag1CN/z1Q6XkzY5MP+YCrFvrLi5
         EOgpZ2hABkxtHnFoMwcARr4Q/sBzz3dVzV4dzm9wTAia7rrB6ophj9s4TeAezoz0RPsh
         hQM0CKO+Yc2LV0Z2yLrxLRR1peKdVFF+VUJy6Ae8v1jwoaxdaIuyh8F9FXHxUgMlGqIT
         eWrAPhZ1MWTFPo1baLeWTG+/cKijGRHtK8rjqzNIcX4Edm1+eW/MX7l0m4CUjpOdkJH2
         B+/w==
X-Gm-Message-State: AJcUukf5dIpiV10b/0oMDSKnPC4E2n+OYLvDuHA9v5Gdy5Lx8zeb+NVR
        Zn91EdpmuAQp1nN+gnpd+j2SSuwdxUshZM88ISGozTSC
X-Google-Smtp-Source: ALg8bN4VKbn1te5ljOforh3YlkQvJbN7fpH6sa/tgghOKU0n8ctb7kU0wzeYvCiflKmFnZn/0NTi8LKn3v/VTjES8iQ=
X-Received: by 2002:a1f:a147:: with SMTP id k68mr4768586vke.1.1548438739354;
 Fri, 25 Jan 2019 09:52:19 -0800 (PST)
MIME-Version: 1.0
References: <20190124164654.1923-1-newren@gmail.com> <20190125165416.17473-1-newren@gmail.com>
 <2f785c2d-161c-b6a3-7743-b071969d60d7@gmail.com>
In-Reply-To: <2f785c2d-161c-b6a3-7743-b071969d60d7@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 25 Jan 2019 09:52:07 -0800
Message-ID: <CABPp-BHTsZBO11ykfTaZ_dzpvrww5D3A57qBM05EgP_wK-iM9g@mail.gmail.com>
Subject: Re: [PATCH v2] log,diff-tree: add --combined-with-paths options for
 merges with renames
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 25, 2019 at 9:41 AM Derrick Stolee <stolee@gmail.com> wrote:
>
> On 1/25/2019 11:54 AM, Elijah Newren wrote:
> > +test_expect_success '--combined-with-paths works with -z as well' '
> > +     printf "0f9645804ebb04cc3eef91f799eb7fb54d70cefb\0::100644 100644=
 100644 f00c965d8307308469e537302baa73048488f162 088bd5d92c2a8e0203ca8e7e4c=
2a5c692f6ae3f7 333b9c62519f285e1854830ade0fe1ef1d40ee1b RR\0file\twith\ttab=
s\0i\tam\ttabbed\0fickle\tnaming\0" >expect &&
>
> I'm guessing that you use printf here because the
> 'cat <<-\EOF' approach doesn't work with the special
> tabs? Kudos for putting in the extra effort here for
> the special formatting!

Yeah, I didn't know how to easily get NUL bytes in the stream without
printf, and once I was using printf the EOF HEREDOC no longer had a
useful purpose.  In the first testcase, since there were only
printable characters in the expected output, a HEREDOC worked well.  I
guess I could have just used printf for both testcases, but having the
literal output shown where it's possible for a human to read it seemed
like an advantage worth capitalizing on.  If anyone feels strongly
that I should use printf for both tests, I can switch them though.

> The rest of the patch looks good.

Thanks for taking a look!
