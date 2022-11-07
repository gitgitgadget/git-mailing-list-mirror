Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32399C433FE
	for <git@archiver.kernel.org>; Mon,  7 Nov 2022 20:31:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232370AbiKGUbi (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Nov 2022 15:31:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232483AbiKGUbg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Nov 2022 15:31:36 -0500
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F7BD2790F
        for <git@vger.kernel.org>; Mon,  7 Nov 2022 12:31:35 -0800 (PST)
Received: by mail-io1-xd29.google.com with SMTP id n191so9856263iod.13
        for <git@vger.kernel.org>; Mon, 07 Nov 2022 12:31:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XBDbNMgxVLceI9YD7j4oJaC9XvSMEnBLs34O4TloGK0=;
        b=dCNUMZGxUUN9ssEfDrlMWNfRBKdXnMUItxIj3g6/46U4ssGXb1WdIaCbHiuAxSIV/D
         n1WU1FTNjLnHhXruASVaVtDk1sp29fGdmMCWET+h7Ju07a7Abve9BlbZzI7LhJ+jhT/G
         a1FLgcXAyPnUKLJ/OK6zQRVlgUA79EshJt35dboo7Utu31wQWxK9MuLUvJtbAhVFPyO4
         m9XpnX5NE1+D/fkzQT+r3WwkU2lZilEJO4TqwDJv5JFsQRMPr5+rQ2PD9BUZv3pRsxHA
         ZgAfEEhq17+1utcistuNwMY68WQNbQfc3tEUKWKjW5BEc1K3f/oUC8ApRMZb0U5S/MeZ
         qEaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XBDbNMgxVLceI9YD7j4oJaC9XvSMEnBLs34O4TloGK0=;
        b=PhjgwtfEoE05ULWG4U/OY7JRojhxFxDvaYCCGq1o58FJXtSOIX1B0q3KJro2z61WkF
         YXSeZSplE1u6Fnnpi8CY21EFBUDbJP/H2E2evdfgUoaCapAgXV3pjs3tnCtT73/flGo5
         qpKQ6J9d9Lvimtb8S8cg8uE2R0pVIR2MDI4Iskp1foxnVjtOfsUSLjKtzR1zna+svB64
         z5SeXhrd+ud/R3fD03fLA79hBzugEZcxwW5ZFBvpfxrV0pb+DLgNfTvr1RmuMzBv0iwz
         ZOc0ijcvuzwrcZH1ZMcLzyeKg+fEzIZmusuD1TGo1HciTsYIU4wVCmEKm7pxMSjHmufd
         Wvjw==
X-Gm-Message-State: ACrzQf0ubQP0qQVzl+X+TKNGp/UWDcZbQ+xg380IfxysGSKFl3wmvpLx
        0Q2FDN7vlYjfNKN2PApq4JJeu6QJ2HWh0+o6q68=
X-Google-Smtp-Source: AMsMyM6S1CovGuX0/2B8ZbodZQSAP0o79oS45ub/rBSLjqRQ975sgV1+ymtfW6E3zxpFKhWjGkLJeuGAWQAMk3VMqSA=
X-Received: by 2002:a05:6602:14d5:b0:6d8:4a18:9d9f with SMTP id
 b21-20020a05660214d500b006d84a189d9fmr10116589iow.100.1667853094351; Mon, 07
 Nov 2022 12:31:34 -0800 (PST)
MIME-Version: 1.0
References: <pull.1384.v2.git.1667002005494.gitgitgadget@gmail.com>
 <pull.1384.v3.git.1667424467505.gitgitgadget@gmail.com> <0e2de99a-da7e-f65f-aefe-117fb468ce55@github.com>
 <CAPig+cTHbM6sXCkMHaDVNs6JJG-5pN-4Nf5tpBrOtYC82=8VvQ@mail.gmail.com>
In-Reply-To: <CAPig+cTHbM6sXCkMHaDVNs6JJG-5pN-4Nf5tpBrOtYC82=8VvQ@mail.gmail.com>
From:   Rudy Rigot <rudy.rigot@gmail.com>
Date:   Mon, 7 Nov 2022 14:31:23 -0600
Message-ID: <CANaDLWLVjWkSmSteNT8bi2ys3Ocg0uBUF=JouvdEB88+zE07KA@mail.gmail.com>
Subject: Re: [PATCH v3] status: long status advice adapted to recent capabilities
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Rudy Rigot via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jeff Hostetler <git@jeffhostetler.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks to both of you Derrick and Eric, this is all great feedback.
I've been through all of it, it's all crystal clear, and I'm planning
to just integrate all of it as is. I'll have a new iteration later this
week (it's small stuff, I know, but I'm volunteering as a poll worker
today and tomorrow).

Thanks again!
