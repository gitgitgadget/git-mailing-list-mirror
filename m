Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31ABEC4332F
	for <git@archiver.kernel.org>; Tue,  8 Nov 2022 01:17:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233090AbiKHBRi (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Nov 2022 20:17:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233240AbiKHBRh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Nov 2022 20:17:37 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1283F2AC70
        for <git@vger.kernel.org>; Mon,  7 Nov 2022 17:17:36 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id c15-20020a17090a1d0f00b0021365864446so12002585pjd.4
        for <git@vger.kernel.org>; Mon, 07 Nov 2022 17:17:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=cQmBt7pgCUt0UnU5sHQe9SeR2ct+Oy9n4TyXQdtpTbA=;
        b=gJwm+6U1hW/gggp2VYP7tuPinJetB1fyZcfaNL0orCtNt+a7H0N9Q0p6djKYOzq14V
         BAJ76FNdXgZO9LxbaBqxHmxmZ3djggNhl21mbOmjTYclU+14UMR1moGOoFx4DIv10RZs
         8JrvgSuMoyiDuxq7zvWyVKTNzFJ64LfbmUYHspCX2A+8cFRv/PZ+nb6DTrdhJQLWq6Oh
         jrBk7gPPUMliiyWyStiDxO4IvscH84mPHdMWLWc3NlKMORkEjp9XMBAexpAB+xchRnfD
         8OmP0xN20zodKHTnXFdzVjXT7EvnQyyWAyaXfZtXHvGc8b397RsA6XxcC2Tlj0bne2vH
         FI0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cQmBt7pgCUt0UnU5sHQe9SeR2ct+Oy9n4TyXQdtpTbA=;
        b=iUW0RV982ZA+m2RHt+AXadVHfj5zWXjdwFb2DvryJtI98d3pB9l1RA/a/p1A4CH2Ml
         Hqqxi8qVBhqySs+mfK5sYlrvfNOI2f7/lsbB0dTusIVN5t85Pr4XXmlORc3EdBX+kC/D
         PTh/EZiE2NHnR3kD00JmRM4+jtUx79/4UDpHmDBDcFRWogCLthks1RDd6s4WLbpsryNn
         mt2ZS0tkoiyhn+E72l/trw2PsC678juOWn0FQJ6y68xqFZoz5TQWEP/pXzk4+n6fBhif
         bkVhZQuNDourqUpL24J8QyAg9jaPk72Ew61RvcL9FXIEBruwba4RcHsaNY6gmf+psgy7
         CYAw==
X-Gm-Message-State: ACrzQf2366Xs833oMVrU5J3IcQFplcr980YkSgXsY+cbqJIEsDNqLMRJ
        iJHZuTYqy5ZwdgLQR+/RSOo73n8Lt3c=
X-Google-Smtp-Source: AMsMyM6QZD3uXBeARv26K6Zr93e0tes6MBU6Eb1R8oBe/oZwNevuyqOG6iRZUr+zf130ECg0Vscw2g==
X-Received: by 2002:a17:903:228f:b0:186:d89e:c073 with SMTP id b15-20020a170903228f00b00186d89ec073mr51955579plh.48.1667870255519;
        Mon, 07 Nov 2022 17:17:35 -0800 (PST)
Received: from localhost ([2001:ee0:500b:6370:da47:cda5:dbd5:6e77])
        by smtp.gmail.com with ESMTPSA id e13-20020a17090301cd00b001782398648dsm5644924plh.8.2022.11.07.17.17.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 17:17:34 -0800 (PST)
Date:   Tue, 8 Nov 2022 08:17:32 +0700
From:   =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        Jeff King <peff@peff.net>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 01/13] bisect tests: test for v2.30.0 "bisect run"
 regressions
Message-ID: <Y2mtu701F5ZCxHXz@danh.dev>
References: <cover.1667667058.git.congdanhqx@gmail.com>
 <cover.1667667460.git.congdanhqx@gmail.com>
 <5571bc36b84210e16ab8731fea8bf0ed8d62cca3.1667667460.git.congdanhqx@gmail.com>
 <221107.86o7titppp.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <221107.86o7titppp.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2022-11-07 22:31:50+0100, Ævar Arnfjörð Bjarmason <avarab@gmail.com> wrote:
> 
> On Sun, Nov 06 2022, Đoàn Trần Công Danh wrote:
> 
> > From: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> >
> > Add three failing tests which succeed on v2.29.0, but due to the topic
> > merged at [1] (specifically [2]) have been failing since then. We'll
> > address those regressions in subsequent commits.
> >
> > There was also a "regression" where:
> >
> > 	git bisect run ./missing-script.sh
> >
> > Would count a non-existing script as "good", as the shell would exit
> > with 127. That edge case is a bit too insane to preserve, so let's not
> > add it to these regression tests.
> >
> > 1. 0a4cb1f1f2f (Merge branch 'mr/bisect-in-c-4', 2021-09-23)
> > 2. d1bbbe45df8 (bisect--helper: reimplement `bisect_run` shell
> >    function in C, 2021-09-13)
> >
> > Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> > Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
> > ---
> >  t/t6030-bisect-porcelain.sh | 79 +++++++++++++++++++++++++++++++++++++
> >  1 file changed, 79 insertions(+)
> 
> Looks good, if I do say so myself :) (unchanged from my topic)
> 
> But I wonder why your "fix the regression" base topic isn't starting
> with this. I.e. our intial report was about that "--log" issue, but now
> we know we altered the output in ways we didn't intend.

Well, I would like to keep that topic as much short as possible to
have a higher chance of fixing real regression first. Those changes is
error/warning/log are less important as you said below ...
 
> It's fine if we say "that's less important", but then ... something
> should say that .. :)

Sure, I will add it in the next revision.


-- 
Danh
