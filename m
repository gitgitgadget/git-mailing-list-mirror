Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6705FC388F7
	for <git@archiver.kernel.org>; Tue, 10 Nov 2020 07:44:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E28D20829
	for <git@archiver.kernel.org>; Tue, 10 Nov 2020 07:44:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AAn06T3A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727991AbgKJHok (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Nov 2020 02:44:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726467AbgKJHok (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Nov 2020 02:44:40 -0500
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B01EC0613CF
        for <git@vger.kernel.org>; Mon,  9 Nov 2020 23:44:40 -0800 (PST)
Received: by mail-ed1-x544.google.com with SMTP id v4so11609136edi.0
        for <git@vger.kernel.org>; Mon, 09 Nov 2020 23:44:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HcV+Zg1wij3L17K8qDCLBG/S3wBpg4hXIBR+4GNh4w4=;
        b=AAn06T3AfQ4Q/roASjmfMGiW3m0xhbMnIB6ch8c1ODcX9YBZ27L4UbL0O0PUBKQ8Td
         J2VO/lxzipkDaCqAAcr+eU3+9GCpz5FdcJhlvo7Vu0ebFOYaK7rXCz+Njcd5BbuqSrXr
         NZFpXG9kkbD2Z3AOFcbtEa77QHAjwkVUeCTIuLe3aDbclPRm2uPOOKhVFKKopH4OtLY/
         2mR67ebUBBRojFdMacbt7EpF8pI7usTQoXRlIbCIUg+k3aGx1ee+mTIij+L5t5EKdfjy
         UIrhqR0ACvccdml3Yz9/g+Kh71pgBKJ0sL0gvPwAvyFiYTevyZgom8c8SEVodKUVKJPw
         PHmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HcV+Zg1wij3L17K8qDCLBG/S3wBpg4hXIBR+4GNh4w4=;
        b=Z1J1pYA30nWhSI73tzG9/VmDQROsP9d/G67W8U4+1IvZnMgiUp/BMQOepthkV7lUNe
         OxUE6xKyP2Z7UW8RQ91oTMINKIS8n1dL5HsiMsTguPB06zkUEY5tCXUbCV+2XJy9Jsij
         58uXX1VgIembFFSwDPlH593MT6gqGNLZfR1mr53LzRm7ZDm/yEQarfXSExaHoD8UfJ+K
         5pznjWDpM+2j7+AFxAux0Vs/r7bXb2HeRx02E81Mu1RXBdFWt2ZHrIpMLygmS7aStac2
         +RcxhOKcD3Dc3pom9bhP0g8za23mLe+NbVgVavIXmz8BZ0mdT973bnHj8rDrG7KEAXGB
         9r/w==
X-Gm-Message-State: AOAM531KD2/Av+e1GIp8vS1cEtMCf65ZFDFbTs2VmGUVAWHAhrnoSSlz
        fbfpsjCS35FwquuUsOq4SXQZupk46s0wci9lJ6Y=
X-Google-Smtp-Source: ABdhPJxjI14bwEXITeLrwr8qqGg1/BSIyYioEdRA8HPDKbXNk+c70QTRxp1MRgz7oB6Cq2nzNRRXohhaRX1/Ue4Vjgk=
X-Received: by 2002:a50:b761:: with SMTP id g88mr19936660ede.387.1604994279036;
 Mon, 09 Nov 2020 23:44:39 -0800 (PST)
MIME-Version: 1.0
References: <20201025212652.3003036-1-anders@0x63.nu>
In-Reply-To: <20201025212652.3003036-1-anders@0x63.nu>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Tue, 10 Nov 2020 08:44:27 +0100
Message-ID: <CAP8UFD1pnZeoL7KFCTKdO8OQm0zh9cJWzkyk4+4ykhvwj1ZkMA@mail.gmail.com>
Subject: Re: [PATCH 00/21] trailer fixes
To:     Anders Waldenborg <anders@0x63.nu>
Cc:     git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Oct 25, 2020 at 10:27 PM Anders Waldenborg <anders@0x63.nu> wrote:
>
>
> This patch series contains a bunch fo trailer related changes. Sparked

s/fo/of/

> from this thread:
>   https://public-inbox.org/git/87blk0rjob.fsf@0x63.nu/T/#r3dc3e4fa67b6fba95e4b2ea2c1cf1672af55a9ee

Ok.

> Most commits are refactors preparing for the others, the actual user
> visible changes are:
>  * Allow using aliases in pretty formatting '%(trailer:key=foo)`
>  * Fixes related to matching prefix rather than full trailer
>  * Tighten up "canonicalization" of trailers
>  * Add --(no-)canonicalize

It's not easy to see which patch(es)/commit(s) correspond to which
change. Maybe you could add numbers like 4/21, 5/21, etc after each of
the above visible changes. Or you could say for example "patches 1/21
to 4/21 are doing this, then patch 5/21 is doing this, then patches
6/21 to 9/21 are doing something else" so it would help us have a
better overview of the series.

Thanks for working on this!
