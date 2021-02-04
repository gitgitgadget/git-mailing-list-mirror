Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 010E6C433E0
	for <git@archiver.kernel.org>; Thu,  4 Feb 2021 19:14:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BAEC864F6A
	for <git@archiver.kernel.org>; Thu,  4 Feb 2021 19:14:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239391AbhBDTNp (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Feb 2021 14:13:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239186AbhBDTNe (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Feb 2021 14:13:34 -0500
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12DE8C0613D6
        for <git@vger.kernel.org>; Thu,  4 Feb 2021 11:12:54 -0800 (PST)
Received: by mail-ot1-x331.google.com with SMTP id d7so4513520otf.3
        for <git@vger.kernel.org>; Thu, 04 Feb 2021 11:12:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3pD1nRpNOJIOoiSxGHGvhHx0vwGKu1Q7xUtg9NvEYOs=;
        b=oFSmUDJPnwpARpSD2lboX+XEaWLu7mpaYlwL8Pipgcr7wOYixWQ2EKGEjvsC/j9xne
         e3WczDOYec18yqfOJJgMJ4p5CvEL4ifg53ZF4LOY2OH97j+eaRxDakTVCzwucxjAlIkB
         CbCUewsYH2uiFzsEKocuBvFMuAKsL3mhHCInxTmNEjTixGg7DsJ4WuAsODPO057KWc6/
         NRd28qtAUYRVOy0imX9R52pkaCpfgS8mtJDxWkJ+L31+GsuFG442imP24SrdoSx7BAIV
         afkUhrfD1Syvo6Dc9gosjq07yv+bMOBEGDLuQ1NHrqgR1Lz6pozTK5c2RFXCjBcLY590
         cWog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3pD1nRpNOJIOoiSxGHGvhHx0vwGKu1Q7xUtg9NvEYOs=;
        b=gsmVXrJjUInrqChYHJF1JO3GAlhMZjq2J6W6caD1XeY/nM/OK4uzFVPpCMUZxZeh+X
         zPkhmJI99uEmKMmFPBFUU5t7eDDRclfpay1urgY3qw3Ev47JSL3A9ix0h9LSaWz4EfJM
         us3AvuDA6yi6Z0hUbPF19FvSGENBwgcatAnpVGM0qaz/tJ3jCFjZbEIfXULT6RQrgb7N
         wTXE08Wvu8f6X9APhX57xeUu5w6jKt2XyFJcfnA/jD/dd/R9szZ92nkQjLeli2xG7EjQ
         JWywwIHATBbxfA7o5g0as6FR/rQXwBwiqhgj5bOK69XHljz0GZwYQ3WfCq3rNbJjk42N
         yX9A==
X-Gm-Message-State: AOAM533dKqOl6gK9dk9F+VnraZ/zR+HMBxnE6gH8Q3CI5/xwYEeRybTo
        FLSpmMDrPBuMPk/tX814C2k0P38GBOHQGmpFfEhtJZrEAso=
X-Google-Smtp-Source: ABdhPJwyUgFKQJv8F9McnOmVn/EEUO2bPE7fwYcrYIlMoH2ejKd2DpI6heyN9SWTuxC0lJBC65rb54oLWJD1384cKB0=
X-Received: by 2002:a9d:313:: with SMTP id 19mr652122otv.147.1612465973491;
 Thu, 04 Feb 2021 11:12:53 -0800 (PST)
MIME-Version: 1.0
References: <20210124170405.30583-1-charvi077@gmail.com> <20210129182050.26143-1-charvi077@gmail.com>
 <20210129182050.26143-8-charvi077@gmail.com> <CAPig+cQO_uHurPn3N-k-UwBFgvx2x8Bx2Uy+=sQxhmj3E6rt7Q@mail.gmail.com>
In-Reply-To: <CAPig+cQO_uHurPn3N-k-UwBFgvx2x8Bx2Uy+=sQxhmj3E6rt7Q@mail.gmail.com>
From:   Charvi Mendiratta <charvi077@gmail.com>
Date:   Fri, 5 Feb 2021 00:42:42 +0530
Message-ID: <CAPSFM5eYMRuWoYaVFn9+5kZ16DoaLZ_8Pqu5hScbu9H0twXXiQ@mail.gmail.com>
Subject: Re: [PATCH v4 7/9] t3437: test script for fixup [-C|-c] options in
 interactive rebase
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Eric,

> > +test_expect_success 'fixup -C with conflicts gives correct message' '
> > +       test_when_finished "test_might_fail git rebase --abort" &&
>
> Is there a reason this isn't written as:
>
>     test_when_finished "reset_rebase" &&
>
> which is more common? Is there something non-obvious which makes
> reset_rebase() inappropriate in these tests?
>

I missed this earlier, but I confirmed before sending next version that as
reset_rebase() removes the untracked files so we could not use this as otherwise
it removes the fake-editor.sh file and will be required to set a fake
editor for every
test and also removes other untracked files which may be used to debug.
So, I think it's okay with:
test_when_finished "test_might_fail git rebase --abort"

Thanks and regards,
Charvi
