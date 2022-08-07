Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 648CCC19F2A
	for <git@archiver.kernel.org>; Sun,  7 Aug 2022 15:40:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234805AbiHGPkA (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 7 Aug 2022 11:40:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbiHGPj7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 Aug 2022 11:39:59 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF2EF626B
        for <git@vger.kernel.org>; Sun,  7 Aug 2022 08:39:57 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id t5so8678145edc.11
        for <git@vger.kernel.org>; Sun, 07 Aug 2022 08:39:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=Wd17ZCJBRQcQJ/IlFhCyaw8VQYEAkluF3FZTyan62ww=;
        b=oybmqkcNkuV6b9F+IrjcyzczOvsT+iWopKF+yXR46lLOg+gRyWGvY78XJ7aM3e1uAJ
         ZHiOPLbBeVUxMmC+aOQ+dUUocQgocv+esHdvFDaS7KO116f43KJQ77onfMnTJX4nMLIg
         ELIuCC8fiKEoeKaQIEujnsNVtG7jcjXavFwVF7RK7Gz/QIGh4/op2k994/nrKEqjEQAD
         ULV1u8q6S7h52iypgTMJEWXtTVyJp4UJm5yeA/7xBX6ubUaIA/+68uUUBKFT7oImwdR1
         sRgKO7b2K2FIcmUx/cSHL7tblu/Z6f9iB65NtVU7ZrLnsDr8BlGSegK4lyqyzDgfWKQY
         VwtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=Wd17ZCJBRQcQJ/IlFhCyaw8VQYEAkluF3FZTyan62ww=;
        b=URQ1/uEp/UiK6rNGA54G/btQkCjHAOGRUhfVn1MttAmFakwCL6Gh7W2yxZuwWJwZ9B
         dwIQF9v8teSrAcSEaISLtCbU6XpXFg058/lhfB/cG3wOgpW8BHKgbaInixxIAkqLRnG2
         n7uT7fuM3bTiDuufSHZ3Bon7qI/QXiuO9LtHj87raCUppxEQWr3SPwoj22GWnH0pESTl
         ksuCWqxUmV8bAUcW2f4yjnIlBmAs8/nuyVOViLKc8/elQuk5oxuYfx2O8ZW/oUztDMvZ
         Yllb65AySeMezn2wXdH0idT/Q+1cuboEwHB1E0jdhs949u9Vfv9isDnI6oln94XMM/Sr
         23EQ==
X-Gm-Message-State: ACgBeo0GAPjtNJBD5eOBmOnaaiSkZgyBUVlNAJ2Zep73qVpgOyOvYXUW
        W+sM+Pdb40GpJsBB8ixv3QU3OGp67yLdjvUA1vp9D3Q0zoY=
X-Google-Smtp-Source: AA6agR439A5v3QhCKVCbc3DFwFaByLmZSJAUdpQkKRpS9LPWa6RbT4Xd9nMj43FxhJbO6V2hHqfcv7eu9iRF+jHw0mM=
X-Received: by 2002:a05:6402:2386:b0:43d:a74:cd44 with SMTP id
 j6-20020a056402238600b0043d0a74cd44mr14417225eda.280.1659886796172; Sun, 07
 Aug 2022 08:39:56 -0700 (PDT)
MIME-Version: 1.0
References: <20220807024941.222018-1-felipe.contreras@gmail.com> <Yu9vvAKJzOpoQ5AS@zacax395.localdomain>
In-Reply-To: <Yu9vvAKJzOpoQ5AS@zacax395.localdomain>
From:   Felipe Contreras <felipe.contreras@gmail.com>
Date:   Sun, 7 Aug 2022 10:39:45 -0500
Message-ID: <CAMP44s2s7QV9+Pgkchfk9=X-6Vwz_QZP0Vd145-euT-SR9Xw6Q@mail.gmail.com>
Subject: Re: [PATCH v2 0/9] mergetools: vimdiff: regression fix and reorg
To:     Fernando Ramos <greenfoo@u92.eu>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Aug 7, 2022 at 2:54 AM Fernando Ramos <greenfoo@u92.eu> wrote:
>
> Thanks Felipe, this new patch is much cleaner than mine.
>
> Just two comments:
>
>     1. Due to the way single windows are now detected, layouts with multiple
>        tabs but single windows on each of them do not work. Example:
>
>          layout = LOCAL + BASE + REMOTE + MERGED
>
>        (we should probably add a test case for this)
>
>        I noticed it did also not work in "master" (but it looks like it does in
>        the patch I sent yesterday)

Yeah, but as you mention that's a problem already, so it has nothing
to do with this patch.

>     2. Tabs with a single window are not highlighted (this was also a problem in
>        "master", I just noticed this when testing your changes)

That's because the diff mode only highlights differences between the
windows in the tab. If you do something like "BASE,MERGED" the diff
won't show colors for LOCAL or REMOTE.

That's why I don't like any mode other than vimdiff3 (and occasionally
vimdiff): because I want to see the diff for all the files, even if I
don't see those files. If I open mergetool with vimdiff and I close
the BASE window I get something better than vimdiff2.

To me if I configure "BASE,MERGED" and I close the first window, I
should end up with the same view as "MERGED", but I don't, which is
why I fundamentally don't like this layout approach.

This could be made to work by opening all the windows and hiding them,
but at the moment it doesn't, only vimdiff (a layout with all the
files in the windows) works correctly for me.

-- 
Felipe Contreras
