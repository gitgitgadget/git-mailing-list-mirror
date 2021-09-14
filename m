Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C39DC433F5
	for <git@archiver.kernel.org>; Tue, 14 Sep 2021 19:05:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6DEA561165
	for <git@archiver.kernel.org>; Tue, 14 Sep 2021 19:05:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232527AbhINTGy (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Sep 2021 15:06:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbhINTGv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Sep 2021 15:06:51 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8262C061574
        for <git@vger.kernel.org>; Tue, 14 Sep 2021 12:05:33 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id s12so702091ljg.0
        for <git@vger.kernel.org>; Tue, 14 Sep 2021 12:05:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FW7AGJoNB7i2TzvC9UKHrJ096zRXGQCxY8mE3Dd19Go=;
        b=Xl2W6GMjO4AqvRyy2pJ2LF0mnUjX+2omjaXbNvcU56l1twKwcAr8pUQ2rg50xfAb0e
         6X2HQXslsvo6EIhFoO/F3KcvVTXufsTfHT1NLSmgwO/SsSob10ynscbOauvKgNTHNOSw
         trep+UQtBpdlzDTWziS+8N10Jf8TRITdW3Ol9PMw71PC+tfhRlx0EgtWRatKAuUPqUa0
         OKyC2AfD6SAzVTkOA3q+dnssJgTxd/JScHWQFoxSoAPXjWKezHxqc2+V4aPkAPrJMdI+
         n42vom5STxa90ZvklOkEyqtKsLeyFfH7BqG19MFCxbSJ9p3tJLGjaLtyqzf9HaMEHuOC
         PcPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FW7AGJoNB7i2TzvC9UKHrJ096zRXGQCxY8mE3Dd19Go=;
        b=lurhR+4eL97RBYmftU+uohOo2kFtY5bDQcPqLCJ59gBe2xhb3Z0qO8HrqzRm6WTLDr
         Uggl3capvZNw06efxdEdp48iyW71G1aZGRrxJVEF8HA3bxddb+EAe7ZMW9RT5Le/3+lF
         cIbcP3j+lqYelk7nu2IglxSRcFszCW3r2He5INBGze2j7VqvHzNVJ97knz/X3WgZZePx
         bYnW+Mjnnq8o4Cz35Wv7b/o9NMXTavJ5MSf8t6XmNBkh6l4AEtK4nH267xoG36PvCJjs
         yusXrN4ouAIPHdCwMBcbFAA6p8Tx4WmkLkcQtRxdRzbDW14MLqqcwaBgXO2ZnoJqWBoK
         5kJw==
X-Gm-Message-State: AOAM53203vdffF35+Q+z3tDTpuOeOVJHTI5T2urhu+Ge/NVRuFRC++z5
        XKeEFca+fM/ULhY0ZqxYM6nN/MPDxS4YuW8vX40=
X-Google-Smtp-Source: ABdhPJxToLuCzBziyaUEd8rbJBCZLeZ2mKtWk9apoM5vBS3UIV5yzWW0m0SvAAKHMnG9zKED+aan1FlKi53S/5fB3v8=
X-Received: by 2002:a2e:8546:: with SMTP id u6mr16762640ljj.185.1631646331982;
 Tue, 14 Sep 2021 12:05:31 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1076.v2.git.git.1630108177.gitgitgadget@gmail.com>
 <pull.1076.v3.git.git.1631590725.gitgitgadget@gmail.com> <f8b5b709e9edc363b2de7d4afa443deec0120ca0.1631590725.git.gitgitgadget@gmail.com>
 <b992c83d-747f-55b2-cf58-f39f4ef734aa@gmail.com>
In-Reply-To: <b992c83d-747f-55b2-cf58-f39f4ef734aa@gmail.com>
From:   Neeraj Singh <nksingh85@gmail.com>
Date:   Tue, 14 Sep 2021 12:05:21 -0700
Message-ID: <CANQDOddbWCkRroeQF62GeXTE-fsSWCiXPXVfrwOFcC3zNYX7iA@mail.gmail.com>
Subject: Re: [PATCH v3 2/6] core.fsyncobjectfiles: batched disk flushes
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Neeraj Singh via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Christoph Hellwig <hch@lst.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        "Randall S. Becker" <rsbecker@nexbridge.com>,
        "Neeraj K. Singh" <neerajsi@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 14, 2021 at 3:39 AM Bagas Sanjaya <bagasdotme@gmail.com> wrote:
>
> On 14/09/21 10.38, Neeraj Singh via GitGitGadget wrote:
> > _Performance numbers_:
> >
> > Linux - Hyper-V VM running Kernel 5.11 (Ubuntu 20.04) on a fast SSD.
> > Mac - macOS 11.5.1 running on a Mac mini on a 1TB Apple SSD.
> > Windows - Same host as Linux, a preview version of Windows 11.
> >         This number is from a patch later in the series.
> >
> > Adding 500 files to the repo with 'git add' Times reported in seconds.
> >
> > core.fsyncObjectFiles | Linux | Mac   | Windows
> > ----------------------|-------|-------|--------
> >                  false | 0.06  |  0.35 | 0.61
> >                  true  | 1.88  | 11.18 | 2.47
> >                  batch | 0.15  |  0.41 | 1.53
>
> Interesting here the performance.
>
> You said that core.fsyncObjectFiles=batch performed 2.5x slower than
> core.fsyncObjectFile=false on Linux and Windows, why?
>

The goal of batch mode is to minimize the number of disk cache flush operations.
We still have to issue writes to the disk (and wait for them to
complete) in batch mode,
and on my test system those writes have to cross the VM boundary.  The
Mac is running
macOS natively, so performance of the writes is probably a little better.
