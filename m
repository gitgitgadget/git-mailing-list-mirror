Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6A42C48BDF
	for <git@archiver.kernel.org>; Thu, 24 Jun 2021 05:55:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 86FCD613AE
	for <git@archiver.kernel.org>; Thu, 24 Jun 2021 05:55:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230393AbhFXF6K (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Jun 2021 01:58:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230252AbhFXF6J (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Jun 2021 01:58:09 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D05C5C061574
        for <git@vger.kernel.org>; Wed, 23 Jun 2021 22:55:50 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id 22so78393oix.10
        for <git@vger.kernel.org>; Wed, 23 Jun 2021 22:55:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=4XWg6bc71TzGzgTY2EHEaYMF3xYypuThUri3y9zI3d0=;
        b=o9/sElX127sokIVOonNyfRD9gykTuduRMYWM/no+xMig0wwzQT+AjHpTleUDexQ2RH
         pPRoo5WylzpmxdLitxgwX7fWVgbaH523bMm3wBQ/XAGuDleL9X1daSCSlr7BS98X0Rn+
         LR7LlLjSxPAM5d/EwOm+ja72mdt9R+V2O7O9SnKZ7PDhr0942txM2YF3seK16D+cuL7M
         RW5wBfsXRmjD4QlMmpFyDu7pPYSUcklrWrXXP/gwotdu3Apa9H/6XPoQT3vP8RfAexAB
         xe4i0FICDPG17tIImzXrPJtP81/cCTFfslsmTtHTcAKFArtU107oDzBOBq44vXHvheIj
         y2Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=4XWg6bc71TzGzgTY2EHEaYMF3xYypuThUri3y9zI3d0=;
        b=I3KMYuO3DE08aACfCx4XU/vrFsVxpZ8kyMjvbeetmhPZZ09hcJ3ClXeqh1+kx3ztsN
         PDtbmCD7mRI5QUGmNePway94TAWb6HyiH/5b1WPvJnRCCE/ED0okVfXgW172hEFEe5oE
         XtUh9qBCbvAbGUDnLqMJWifMi4zhQcDIqyNp2io1VuPg9vgaGTMHe4k5Bp9a9w1NXw1o
         k9zK3pW/6qii6J2FYH5Uu1y722Jt5wT+F84b6y8zcxKw7gLvqMvyX6DyvD+7TctJEVH2
         DEhQzlspg9uF4RT3vxQKIpAlGsDxixmBMgr1G3aAuyjyQIFfV7/FN60L61r+mNShrYsY
         upaw==
X-Gm-Message-State: AOAM53052QG9y+EAYUTScoC+3UDDeUQ/q2n+rki/wk/48CCktUkTQ9Lz
        h95QrR3il67yaoVDPN2zwyg=
X-Google-Smtp-Source: ABdhPJz9rmY6+93Gx9xu8UfA0wBRTTJmQVcLeIfoekPTzOiGaMfba44w+IEF8AswyVxheAT8slFYgw==
X-Received: by 2002:a05:6808:98e:: with SMTP id a14mr2744365oic.139.1624514150244;
        Wed, 23 Jun 2021 22:55:50 -0700 (PDT)
Received: from localhost (fixed-187-189-165-231.totalplay.net. [187.189.165.231])
        by smtp.gmail.com with ESMTPSA id l8sm435525ooo.13.2021.06.23.22.55.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jun 2021 22:55:49 -0700 (PDT)
Date:   Thu, 24 Jun 2021 00:55:48 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Alex Henrie <alexhenrie24@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Elijah Newren <newren@gmail.com>,
        Git mailing list <git@vger.kernel.org>,
        =?UTF-8?B?VsOtdCBPbmRydWNo?= <vondruch@redhat.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Message-ID: <60d41e6464a6c_3d32208a7@natae.notmuch>
In-Reply-To: <CAMMLpeTQjw0W8ZTegPru_9muRBGj7RDfk3WgEEN34vm-PG9Jfg@mail.gmail.com>
References: <20210621175234.1079004-1-felipe.contreras@gmail.com>
 <20210621175234.1079004-3-felipe.contreras@gmail.com>
 <CAMMLpeR2Y_EGwqGJzghSQ1DzpYQyWr6ENmGCvPRdhhYFkTW4yw@mail.gmail.com>
 <60d0df99d91e1_108e902085e@natae.notmuch>
 <CAMMLpeRnUC+nOek=Kz6bj0_R6EUaDr=7ObKF01V641_ByOmk6A@mail.gmail.com>
 <60d10ebd99d86_113139208cd@natae.notmuch>
 <CAMMLpeRa3atkZxEtV--YD6-JSf0Bp9xRw9kS5wSWerxpsGrvrw@mail.gmail.com>
 <CABPp-BF1noWhiJadHzjJmnGo8hdZj6Fk7XnZ=u6BVVSGfHE7og@mail.gmail.com>
 <60d289c84fadf_312208dc@natae.notmuch>
 <CABPp-BHSxNT0rG3LMrDVH64mBwTgeF197oZFnbHvvKk=SB--WA@mail.gmail.com>
 <60d37b3b77aeb_378720834@natae.notmuch>
 <CAMMLpeTQjw0W8ZTegPru_9muRBGj7RDfk3WgEEN34vm-PG9Jfg@mail.gmail.com>
Subject: Re: [PATCH 2/2] pull: improve default warning
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Alex Henrie wrote:
> On Tue, Jun 22, 2021 at 8:20 PM Elijah Newren <newren@gmail.com> wrote:
> >
> > On Tue, Jun 22, 2021 at 2:22 PM Alex Henrie <alexhenrie24@gmail.com> wrote:
> > >
> > > While
> > > we're on the subject, do you have any thoughts on what (if anything)
> > > more should be done before making the switch to aborting instead of
> > > merging with a warning in `git pull`?
> >
> > I think Junio already answered that over here:
> > https://lore.kernel.org/git/xmqq360h8286.fsf@gitster.c.googlers.com/
> > (he discussed it multiple times in that thread, but hopefully that's a
> > good enough example).
> 
> Wow, if I understand correctly from that message, Junio wouldn't mind
> making the switch right away. That's very encouraging.

Junio has not paid enough attention to this topic. He is not aware of
all the problems, and once he does he will very likely change his mind.

> On Wed, Jun 23, 2021 at 12:19 PM Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
> >
> > Similarly, until "git pull" does something sensible by default (which
> > isn't the case now), these debates will continue, and there's value in
> > them.
> 
> At this point, I'm inclined to push for s/advise/die/ in pull.c in the
> next release, without a transitional period, just to end the argument
> over how to best explain the current awkward situation. (I'm sure
> there will be more arguments after that, but hopefully they won't be
> as tiresome.)

Give it a try. You will inevitably stumble upon all the problems I
already fixed.

In the meantime what's the problem with v2?

Cheers.

[1] https://lore.kernel.org/git/20210623004815.1807-1-felipe.contreras@gmail.com/

-- 
Felipe Contreras
