Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 237E5C48BE0
	for <git@archiver.kernel.org>; Fri, 11 Jun 2021 17:03:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E75F613CA
	for <git@archiver.kernel.org>; Fri, 11 Jun 2021 17:03:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230488AbhFKRFh (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Jun 2021 13:05:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230493AbhFKRFa (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Jun 2021 13:05:30 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3061AC061574
        for <git@vger.kernel.org>; Fri, 11 Jun 2021 10:03:18 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id t40so6458332oiw.8
        for <git@vger.kernel.org>; Fri, 11 Jun 2021 10:03:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=Xo7TLrO/zmT5OS2MYAM7SKiZzr0SfkdGyUCp7pILi7Y=;
        b=q6ABPCFKIrUMDhQA8vfpMF9n6GUQyZ+Do1FSjg7J4nZtPbV2dtxP4eix5L/XDPqoPt
         Y0TlKTj8Is2r6LsdIbamXl/QJ3fEWzDWrXAshkRfAUrOjUsJKcLrs9L5feBP0QeWVRLG
         MFVX6f2BjPv53i+gzYCFPkCYB/1pGmcAVVxjbhIndQ4icvpbNkoUx69wINmmgsY5xkfE
         Ij3JNSKxquMb7zqE1z51xnkj5RugEZXiP9nE65ilOym/8VlHRdBg/v1q5HW5LXuPsTyM
         vVqHx7HtHQLX969BObTjZ3DSM56yEzTe41j10pPqA5FIUkBxmrXKvPHwtwQucnCXCkHe
         6ObA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=Xo7TLrO/zmT5OS2MYAM7SKiZzr0SfkdGyUCp7pILi7Y=;
        b=UbVYFjxG9oiRJaMS4803bknhCb9OsooCPIeigG1V2BBrbYHWJV7E1Hcx94Uhcngc/d
         o96rVkagDicnDVejiPVZfr4d6eWfp3RmlGxWjp9k9dNHJARr87xB5q10zotWCytI7Z6o
         ZR61p5ec/f71DMVf4+F3pQRQHP0QSPdvAqFakRBORtSwkpxvHSQrRP4Akt9jc0MN57HV
         PGrShLAvXsuBIeQQE1Oa7Y4lGfZ+SoQlIs0ZJW9gehpDq+eV2F990t57wvBgHMh43PLp
         2Wpb3dt+dLaNhwJwULI7HGUKJt5GlmV5xHhUoYEYe756aHZwJlFIv8NRivaCHhD05tf0
         NmFA==
X-Gm-Message-State: AOAM532izwRFwqQoJ/xpPOEHLWAkGqEiD5Zz2WWybRIt06EnBZ/eKS/p
        Jz0QdNF/Q/ub+GneC2nsEcojMbU4028jPA==
X-Google-Smtp-Source: ABdhPJw0Qn9VmIuQJDE2r7aZj9Ft/viz64+MPtQKgWkJSsVhw6gNqIl2r2WJ4VUki/k7s+vUm9nkRQ==
X-Received: by 2002:aca:6106:: with SMTP id v6mr3075903oib.175.1623430997465;
        Fri, 11 Jun 2021 10:03:17 -0700 (PDT)
Received: from localhost ([187.188.155.231])
        by smtp.gmail.com with ESMTPSA id v203sm1262712oie.52.2021.06.11.10.03.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jun 2021 10:03:16 -0700 (PDT)
Date:   Fri, 11 Jun 2021 12:03:05 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Phillip Susi <phill@thesusis.net>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, gitster@pobox.com,
        sandals@crustytoothpaste.net, stolee@gmail.com, jrnieder@gmail.com,
        emilyshaffer@google.com, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Message-ID: <60c39749a3829_8d0f20822@natae.notmuch>
In-Reply-To: <87lf7g76gc.fsf@vps.thesusis.net>
References: <pull.975.git.1623085069.gitgitgadget@gmail.com>
 <afc51c5e6edec7935a6d0d0a05d396e11311ca6c.1623085069.git.gitgitgadget@gmail.com>
 <60be91757c6ca_db80d2086e@natae.notmuch>
 <87czsu98ar.fsf@vps.thesusis.net>
 <60c123edcae35_aa2ee20886@natae.notmuch>
 <87lf7g76gc.fsf@vps.thesusis.net>
Subject: Re: [PATCH 1/4] Documentation: use singular they when appropriate
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Susi wrote:
> 
> Felipe Contreras <felipe.contreras@gmail.com> writes:
> 
> > This is a good use of singular they:
> >
> >   Everyone returned to their seats
> 
> Shouldn't seat be singular there so that it agrees in number with the
> singular their?

Good point.

I do not know, and I didn't pick the example; the American Heritage
Dictionary did.

Translated into Spansih both uses would be correct "seat" or "seats"
(except "seat" wouldn't have "their", but the equivalent of "his/her").

Anyway, even though I don't mind talking about this, I don't think this
mailing list is the place for that. The git documentation has many
problems, but heavily using gendered pronouns isn't one of them.

Cheers.

-- 
Felipe Contreras
