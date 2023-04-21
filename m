Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75FEDC7618E
	for <git@archiver.kernel.org>; Fri, 21 Apr 2023 19:13:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233236AbjDUTNO convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Fri, 21 Apr 2023 15:13:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231639AbjDUTNL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Apr 2023 15:13:11 -0400
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A63DA10E9
        for <git@vger.kernel.org>; Fri, 21 Apr 2023 12:13:10 -0700 (PDT)
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-5ef5a51d23aso17655896d6.1
        for <git@vger.kernel.org>; Fri, 21 Apr 2023 12:13:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682104390; x=1684696390;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2veretGAse/zWlQmiKkZf613LrDiW+sJ8usJOaIbfmA=;
        b=QLfrkBFEl+2m6xomp8TEsMZfpIksfUV1Epf8tF5vFaLKnrwDSM+yfSp9sJAMahDt8+
         xmevW+G3PMyMmbjeaIvWmAuMD2O/U+Y2KpHMKQwSCI7LCtHWTqwHPtnlq9DO5+gY/eK+
         W640/ENNOJ0i8c++XJCsnKC7wpls6SFLBsjgcohS/eOcxwb4UIxFWRNL/+DTcJjFqk63
         vaNQDpirQBmgIOkazAIMRXQvotWHOhwIlf6gTzLhrfADWgUKbvd24xz0fSwPgbXhEfT/
         aYFLdm7WDbgiawIF/K9xQebxEzmRc4qFHllUJlB3C5fLczmBgjJelwziz0yU9n5axtLD
         7PFQ==
X-Gm-Message-State: AAQBX9dOIvq640upNI4hXTpKRTBJfwggSClUgbO14tKCkRBPgg54J6Il
        rWYjXp/KR5p9DU29G9xvXTcKUajwoLrBP0o43rn3SKsT
X-Google-Smtp-Source: AKy350Zet3G/ETUOvz/mJXW8coyMW5UzbHkeh+F7pF4HrNIO7QJ7bPQpqH1Ya9kNdL9GBpBbcOld1AfT6jMyaiQ8xJo=
X-Received: by 2002:a05:6214:246a:b0:5ef:56e4:f629 with SMTP id
 im10-20020a056214246a00b005ef56e4f629mr12361833qvb.38.1682104389674; Fri, 21
 Apr 2023 12:13:09 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1492.git.1679237337683.gitgitgadget@gmail.com>
 <pull.1492.v2.git.1682089074.gitgitgadget@gmail.com> <31bb644e769a085bd2db97cdb5aae78729efc52d.1682089075.git.gitgitgadget@gmail.com>
In-Reply-To: <31bb644e769a085bd2db97cdb5aae78729efc52d.1682089075.git.gitgitgadget@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 21 Apr 2023 15:12:58 -0400
Message-ID: <CAPig+cT8fccACXvOfd7hFnogy1x7hisb1K-BY+1aVJd2VUXHwQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/6] sequencer: factor out part of pick_commits()
To:     Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Stefan Haller <lists@haller-berlin.de>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 21, 2023 at 11:11 AM Phillip Wood via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> This is simplifies a change in a later commit. If a pick fails we now

s/This is/This/

> return the error at then end of the loop body rather than returning

s/then end/the end/

> early but there is no change in behavior.
>
> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
