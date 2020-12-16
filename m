Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DE42C4361B
	for <git@archiver.kernel.org>; Wed, 16 Dec 2020 21:25:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D332222D2B
	for <git@archiver.kernel.org>; Wed, 16 Dec 2020 21:25:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726437AbgLPVZV (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Dec 2020 16:25:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725274AbgLPVZU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Dec 2020 16:25:20 -0500
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C5FDC06179C
        for <git@vger.kernel.org>; Wed, 16 Dec 2020 13:25:05 -0800 (PST)
Received: by mail-oi1-x232.google.com with SMTP id w124so26306589oia.6
        for <git@vger.kernel.org>; Wed, 16 Dec 2020 13:25:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=OkXEKKHqphxx5Y5rxxMyPanMEFGzQ0j9pOrHu0j4nJI=;
        b=iiAmJwHcD3sB5RjDhNkcPq+6eO2j6DL85DkYc5HnjS/zwSPBY4R1jTe34exBnKXCqC
         p+W/91lYa6UteBbL5E87Vg9Ma7FyFdYgnS1LDacCM0B8iJ7Koe6eUE5VQCd7fTgpYw1P
         bP7fEXvezzxR/wbPhbtNH/vNXRcoEPObc7b72Ex28gAdlEKZP8bi0q4PKxcvBCk+Wfff
         zOqt+Bs0tL2pksg+rHxc27iJvsKWMUjJ9Mo4thNClhYYZttJ3EE+8EaYz+fJxmEd7gPc
         YlY19jqeKBOvZRSP8AGZzt7pXSXmQdnnVOS/8Dy830yHON9uxWKg9xwioAo8MctyR4VB
         ZoHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=OkXEKKHqphxx5Y5rxxMyPanMEFGzQ0j9pOrHu0j4nJI=;
        b=GPO8qVx42v2FEnBuct5FqI1ukqtUsjHmMiAs8G5l/Jm3xsV1uFc5rWd61U0d4l5zIV
         3eOozjr173Z9USPNnbJyRhudqMeP5yspxnDNN/Z4hcZpVDMk5SDcx9GxxGLE4zDTTiHE
         78+PdzXMLdAjwiTuFwbOUrgVMl0yt5r8jPVVH6vnaAFTBlbWiczkAuXDrjwpKHygRPcx
         z21twiDi+8q6n4pF5ApRL2wo6t5DrRKTPq72kG8KWHKtXic0rDn30ZyIl/+49j6kSvaS
         sMVqVBEtVSZtVz2znRwTd6QhYln/qy/6i6aY2LhxuOCBNC6CoOm2f0rEAzzdxQXGhlLx
         2c0w==
X-Gm-Message-State: AOAM531NyzXPvrt/4doxvZusRBnxBGBweyLXjWo4kkWAHu7vitKGS8Sr
        fdpM+A3lsGO0ot6+C0UyWW8=
X-Google-Smtp-Source: ABdhPJxS68DA/jD9xqxOYpeEYt/q8upAkHS3uc4nknDMKT+F2mhe5A2j+N0B2nuJe2tmihIKusET2g==
X-Received: by 2002:a05:6808:210:: with SMTP id l16mr3076648oie.155.1608153904909;
        Wed, 16 Dec 2020 13:25:04 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id r15sm674120oie.33.2020.12.16.13.25.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Dec 2020 13:25:04 -0800 (PST)
Date:   Wed, 16 Dec 2020 15:25:02 -0600
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>
Cc:     Derrick Stolee <stolee@gmail.com>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Message-ID: <5fda7b2ee79df_8c35208e1@natae.notmuch>
In-Reply-To: <xmqqlfdx32ln.fsf@gitster.c.googlers.com>
References: <pull.814.git.1608054807.gitgitgadget@gmail.com>
 <0b455bd6fe7dff72c1849eb8466b97b96b2b90a9.1608054807.git.gitgitgadget@gmail.com>
 <4a4d9d29-ccba-8d39-a7cd-34b1ba785e22@gmail.com>
 <xmqqim914pfs.fsf@gitster.c.googlers.com>
 <CABPp-BG+_4Dv_+HNgQxW8KNe1q04NwuhRpExeOuc=wLeunsj_w@mail.gmail.com>
 <xmqqlfdx32ln.fsf@gitster.c.googlers.com>
Subject: Re: [PATCH 1/3] merge-ort: copy a few small helper functions from
 merge-recursive.c
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> Elijah Newren <newren@gmail.com> writes:
> 
> > I wonder if a slightly different codeflow may be easier to follow
> >>
> >>         struct commit_list *result = NULL;
> >>         while (list) {
> >>                 struct commit_list *next = list->next;
> >>                 list->next = result;
> >>                 result = list;
> >>                 list = next;
> >>         }
> >>         return result;
> >>
> >> if we were to try improving this for readability?
> >
> > Looks like Felipe also came up with the same version you did (modulo
> > the temporary variable name).
> 
> Funny if it was sent as a response to the message that already had
> the same answer...

It's two changes, actually: s/result/current/ and s/next/tmp/.

But yeah, it's interesting that I used Elijahs's version as a basis and
arrived at virtually the same thing.

Cheers.

-- 
Felipe Contreras
