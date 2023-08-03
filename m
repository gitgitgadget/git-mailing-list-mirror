Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D11DDC04A6A
	for <git@archiver.kernel.org>; Thu,  3 Aug 2023 03:23:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232089AbjHCDXS (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Aug 2023 23:23:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231651AbjHCDXQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Aug 2023 23:23:16 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90767C3
        for <git@vger.kernel.org>; Wed,  2 Aug 2023 20:23:15 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-583b0190db4so822957b3.0
        for <git@vger.kernel.org>; Wed, 02 Aug 2023 20:23:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691032994; x=1691637794;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ciFqmv8hzPx0bZsTxLxEa3s+6omg3c5oo1Net4gEnJI=;
        b=ADxSjWkSusRlJboZ4+94j+hd0L0JEzx0qwQxuqyySZ6xsEpVnKueXuIWXpIn3j7bq0
         LCVURlLqTpvG6qeaCPR2+wFBtQZcjT9UobXG/UJSXL9ry8c7mBqrMTOhELmoFlDVtPfe
         QPEzk+511Eh19PmNDzAkcoERnWIyUmCXVlNOMRlqWEarWyD4m9q3bsYmJZ9wm/6SfWJ9
         UxmlOMmYbxsvWtblbbf82GNRraFeqiRWpnBoYRYwbJb8rzRr4FqL01zSYuAaptJaobKK
         k1WRZI3ugfwS8zUCvQs4Oe0PvUCkx6CXv2kt6dH/lGhfu7ck32Pqn+Anw/UN8ST3zkuT
         rbkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691032994; x=1691637794;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ciFqmv8hzPx0bZsTxLxEa3s+6omg3c5oo1Net4gEnJI=;
        b=KFNrsefhRAC+YjdAEVixmUxkljZmi33z4l3qNaDST30450htW/6s2lfaiIM4rMI9NQ
         /nuJjtflOeRmDyawd2/qzY93Uf4vBs3CCPnA3c4kNYR0af+9dz/9Chr43VJqsjZiAcPE
         Mau9Sm0vfN8ey8U4IFjf3h+/BZ6T9ftKtACPdzFMiFMj0zhekf4+q1MdYwgrrhYFZ+hn
         1dv/4swYRuJUr4EM8gwgvn5cImhnaOPhnAdXsBvuGirk8hgl6kuxosa8RIO+uprabu/u
         ORc2SdwU/bVMN6tBpXLstYtuhjO6PGueRQi/yFIwZC/nJLmVrR7L3naKV5fDeS3nUTRN
         /aWw==
X-Gm-Message-State: ABy/qLbcnPY3JR3h+7coNk9VVfgXwIO2Nfsn0g/OaM3+TyJUlPX7o2DM
        Q0SlpFYp944QNd7cra7ZQ17ZjnYIw+yJNMNuXLZc6i8mW8c=
X-Google-Smtp-Source: APBJJlH2vn+rWPXo+1JRgd7Wp0dl+Sarw2CeFEMdWIMhKK05d0jaWXR7KdPOltcMfI9gjFlMVU8Czo1EZIGSQ80Uel8=
X-Received: by 2002:a25:a363:0:b0:d1a:cfb0:1805 with SMTP id
 d90-20020a25a363000000b00d1acfb01805mr6184214ybi.0.1691032994634; Wed, 02 Aug
 2023 20:23:14 -0700 (PDT)
MIME-Version: 1.0
From:   Aleem Zaki <aleemzaki@gmail.com>
Date:   Wed, 2 Aug 2023 20:23:03 -0700
Message-ID: <CA+sf2-+499Nfu00ciJeLwjRmBE7Bb-WZcZuCXY2-JXs88Pwz-w@mail.gmail.com>
Subject: .gitignore is not enough
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There are files which one would like to pull from a remote branch but
not have git register said person's changes on said files

Let's have a file named:
.gitpullfromremotebutdonotregistermylocalchanges

Of course, we can think of a better name

By register I mean detect, like when git status detects changes that
are not staged for commit

Use case:

On GitHub, you clone a repo with a default config file (skeleton)
You custom the config file with personal tokens and values
If the config filename was in .gitpullfromremotebutdonotregistermylocalchanges
Then the following don't have to be worried about:
1. The developer (the remote branch maintainer) doesn't have to not
have a default config file (skeleton) because it was in .gitignore
2. Pushing your secrets
-- 
Anonymous
