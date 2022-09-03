Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8350FECAAD4
	for <git@archiver.kernel.org>; Sat,  3 Sep 2022 05:25:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232129AbiICFZ3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 3 Sep 2022 01:25:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232008AbiICFZ3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Sep 2022 01:25:29 -0400
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33D93B56C4
        for <git@vger.kernel.org>; Fri,  2 Sep 2022 22:25:25 -0700 (PDT)
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-3376851fe13so32589817b3.6
        for <git@vger.kernel.org>; Fri, 02 Sep 2022 22:25:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=XeJGITujBDz+ZgX288VssUuvb46C+gk+p4GIUDiKUXs=;
        b=pylFCZ1AkYS6YBn06RAMuzLUIiKSFNBe9V2B8z7JZIuN7k3s0fFVzjge20pVLDYCMN
         akdLZLmo8YBK4P0H9tZ+/Qs3SI+cakRBHlo5XGCbk8LtLyVYxA2Gu/dTANbUX7jiQNvx
         eX6spYW4ByM5+HInpyzHcRBVMK62EEibXBrQhuprgHl6nErAwDXLD3DgrEt/195xMJYX
         2v70DDvGonUKLe7JVxYQoKJT+V7sWiF5fez2HIXpg35EupAFoSmr7U4nx57si2Lji5XE
         oTBC7o5i8DLlXhkUsSq70d3LTAkNBoAVTwaLj7+VApL4NY0DkAdiA1JcMynUZTrOq8JX
         3IXw==
X-Gm-Message-State: ACgBeo3sy/GFOf7VsInn9GYTjvs88FW9I40cLXPWFDJCQDzPh3vM7sqx
        GC0W1R8urleyf559kQ79wjkd93jYhryXGrSToGY=
X-Google-Smtp-Source: AA6agR7m9kR2gspTJBTJ+0r70+Jpa0fPT/Rfh+KndNxr0NXm5ju8zcrtX70IHH6msVA7oTOF2l8AwtXUXcWXPJULrAU=
X-Received: by 2002:a0d:c807:0:b0:336:cac2:59eb with SMTP id
 k7-20020a0dc807000000b00336cac259ebmr31068563ywd.70.1662182724243; Fri, 02
 Sep 2022 22:25:24 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1322.git.git.1661992197.gitgitgadget@gmail.com>
 <9589f2a6e495034cc4f45bd0bce80dedfcd30f16.1661992197.git.gitgitgadget@gmail.com>
 <CABPp-BHAGb9RU2d7_1ZCDbgKj9aB0JkHUD9_mMnVL=EttqZ4Bw@mail.gmail.com>
In-Reply-To: <CABPp-BHAGb9RU2d7_1ZCDbgKj9aB0JkHUD9_mMnVL=EttqZ4Bw@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sat, 3 Sep 2022 01:24:46 -0400
Message-ID: <CAPig+cS8Udx+ia7PCEGeGLeX_1pxk8FU+-57=NYkTuHdQH4hJg@mail.gmail.com>
Subject: Re: [PATCH 16/18] test-lib: replace chainlint.sed with chainlint.pl
To:     Elijah Newren <newren@gmail.com>
Cc:     Eric Sunshine via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Fabian Stelzer <fs@gigacodes.de>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Sep 3, 2022 at 1:07 AM Elijah Newren <newren@gmail.com> wrote:
> On Wed, Aug 31, 2022 at 5:30 PM Eric Sunshine via GitGitGadget
> > By automatically invoking chainlint.sed upon each test it runs,
> > `test_run_` in test-lib.sh ensures that broken &&-chains will be
> > detected early as tests are modified or new are tests created since it
>
> s/new are tests created/new tests are created/  ?

That does sound better (except perhaps to Yoda).
