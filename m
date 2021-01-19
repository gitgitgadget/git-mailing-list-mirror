Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EB30C433DB
	for <git@archiver.kernel.org>; Tue, 19 Jan 2021 04:12:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B4662064B
	for <git@archiver.kernel.org>; Tue, 19 Jan 2021 04:12:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730017AbhASEL5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Jan 2021 23:11:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730649AbhASEJe (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Jan 2021 23:09:34 -0500
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A214C061574
        for <git@vger.kernel.org>; Mon, 18 Jan 2021 20:08:52 -0800 (PST)
Received: by mail-ot1-x336.google.com with SMTP id n42so18517361ota.12
        for <git@vger.kernel.org>; Mon, 18 Jan 2021 20:08:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AAg3s1CzilEkYnH07nVQbwasi7rKWXaPVvn2g76bfKE=;
        b=DaeBfhtJ3XrP592WuTj1CSt/fpeSYAVgOpPnJ67mDXSyw9QZOJMWaOzUl39tw+nTTT
         Rq6axGL3gB2O6c4RkaSmDoG9XeImhZ9Bb+ADp+/rDGcMBg+CC57mNT+JMfFFT5noaYku
         Lr9oesgAQNxktg6cTi7Ms9EyCIPPcni1FFH4SNnkoTU7I7tn5r7arwpbkYwtZs59fuGx
         dUGaaWn/F4PbZI0W2pySEob0BjcGf74zDx6Frm4XTK+vWv+L2iZ3GdYIyPp2Egr4aZ8h
         8ZHAMcO4iQ54sypkYrND3X+OZgsttnQeXjMohcYXKGlS/pTkiWBx5Otx4AEWzdG8B8d5
         SIcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AAg3s1CzilEkYnH07nVQbwasi7rKWXaPVvn2g76bfKE=;
        b=LyZS6TReqaGb59jVd4wGuB503Ar85bkO2rJLcM7/O7dGUNpUnsPvl/sZ+X66um65Te
         SANXHYgldNX+LSdFUL9LswhEmfRXpR9T9PIMaIcBwDyrTkI6hOFyZCDhOyi9VC7xxm8t
         6AR8ib0VSTEpuCN1IS7ASjElTlY1okDFFHIFFRcmWOjygFZU7D2EDeIL2uY2x5I9XQls
         SPWtbijBPs3NwwboYixJ1SVeBMV3FK6TkhSGO9VF+n/CWNOi8r8VqzTtEqirCtnDf2QE
         HkEj73oGnBwu0EHrZ3ySYDTWKHAUH34I+Hob4ucwGTWJNaLDHpTX42UuMcqWODpt2vU0
         gM2w==
X-Gm-Message-State: AOAM533OBUtrwVU1VBqAOTJxz//tilCt/mD/H9RC5gsR39u+PVOptHKr
        tfpGZFXI+85pvaJIGVKPQU+YnZie050d0bnnCsU=
X-Google-Smtp-Source: ABdhPJw83EKpCUQBeXlXZ9feUY/s3/cJuPQy//yV+5mEp5EgVnb5UIJI+RZwNfTGe7LCZYLDASruMeL4XT9HAYQZ02Q=
X-Received: by 2002:a9d:741a:: with SMTP id n26mr2098768otk.210.1611029331396;
 Mon, 18 Jan 2021 20:08:51 -0800 (PST)
MIME-Version: 1.0
References: <20210108092345.2178-1-charvi077@gmail.com> <20210108092345.2178-4-charvi077@gmail.com>
 <X/9DdGnYo7RQz5CE@nand.local> <CAPSFM5fuT0QAK9wJ_HuH3t=qThPx7Opwy0GrYieVntJ8A4ARMA@mail.gmail.com>
 <abc9334d-a9ec-a041-aa04-16cb4f01372a@gmail.com> <CAPSFM5eZ=_yaeNmF_SnL2jx+Tz4HdgROF=SjhbL=UbB75eFHxA@mail.gmail.com>
 <f2085c1b-c6aa-0183-e090-8b2da3cc57c0@gmail.com>
In-Reply-To: <f2085c1b-c6aa-0183-e090-8b2da3cc57c0@gmail.com>
From:   Charvi Mendiratta <charvi077@gmail.com>
Date:   Tue, 19 Jan 2021 09:38:40 +0530
Message-ID: <CAPSFM5dVbj-y=kRVhLC=9pfd3myjFP9R6-iih4CZiO3XSYO+sQ@mail.gmail.com>
Subject: Re: [RFC PATCH 3/9] rebase -i: comment out squash!/fixup! subjects
 from squash message
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip,

On Mon, 18 Jan 2021 at 23:59, Phillip Wood <phillip.wood123@gmail.com> wrote:
> [...]
> > So I added to check the test as here:
> >
> >               -   grep squash commit >actual &&
> >               +   grep -v "squash" commit >actual &&
>
> There is no need to redirect the output of this one - we don't expect
> any output and the test will fail if there is so we want to see what the
> output is.
>

Okay,

> >               +   grep "extra para" commit >actual &&
> >
> >> Looking at the changes to the tests in this commit it highlights the
> >> fact that I don't think we ever check exactly what the user sees in
> >> their editor. We do add such a test for the new `fixup -C` functionality
> >> in a later patch but perhaps we should improve the test coverage of the
> >> squash message presented to the user before then.
> >
> > I agree and in this test  it's now just checking if the commit message body of
> > "squash!" i.e  line "extra para", is added in commit message or not. So, I am
> > doubtful if the above is the right way to test whether squash! line is commented
> > out or not , as "grep "extra para" commit >actual &&" will rewrite the
> > 'actual' file.
>
> The test above gives us reassurance that "squash! ..." does not make it
> into the commit message which is important. We'd want a separate test to
> check the message that is presented to the user however looking at patch
> 7 the test 'sequence of fixup, fixup -C & squash --signoff works' checks
> that a "squash! ..." subject line gets commented out so I wouldn't worry
> about an additional test here

I agree, thanks for confirming.

Thanks and Regards,
Charvi
