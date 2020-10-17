Return-Path: <SRS0=oQO4=DY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE185C433DF
	for <git@archiver.kernel.org>; Sat, 17 Oct 2020 06:44:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7706E2074A
	for <git@archiver.kernel.org>; Sat, 17 Oct 2020 06:44:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HItKytz+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437181AbgJQGoM (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 17 Oct 2020 02:44:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437178AbgJQGoM (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Oct 2020 02:44:12 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29D87C061755
        for <git@vger.kernel.org>; Fri, 16 Oct 2020 23:44:12 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id dt13so6572890ejb.12
        for <git@vger.kernel.org>; Fri, 16 Oct 2020 23:44:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WtHKA7Jr6UjpqNOQA8wDQe7fQnC/TDdtscl/i+r2FCs=;
        b=HItKytz+QBfm1U6sXvdLcjp6ZpMxefElThPGSCX1tOIXZc6BCEJAUD/0SEDxpccx7G
         eabqLsiXF64lM593R6hMyMzrQFO7/0ILrkQFEo3fY8jN9a3GDLQmpiP+DggfXs9d788d
         1PLWFLpgWugCJG9BJ/9oN5V2HK2BbhfUjCMMgK2Ui4gbpqicpiin82VXVPpJrCFmeGu9
         AbUDUZZ1sxmpT/hqN7w6TplqTJEcy5ovrfxoQ0bgfo/L4OmhchbaB+AAqrA+l+q4agXW
         8C6BCyRHurXmlM+n35ppJdoEw9zqaD39MdQ+nzgIssfjyyFQjO2//YBZN5U8B5hnIHv7
         6jWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WtHKA7Jr6UjpqNOQA8wDQe7fQnC/TDdtscl/i+r2FCs=;
        b=dD7M4tkrhXrqrAIlwpPZhqgQ6EuR+4O6yabXnGAtaM/Hoa09uGx089Sma2O7Acj797
         06+eb4ywP+afoxjphHP8/wZPpBYPxvCR3bqquLHDIhWoOYNtnGJ/pK9DctZ+yI2bEBIl
         CLAh1HbkvQgnyraS4uLRghM9igfEqqNxMKQ8uQ3p0BT2xilTP9yd1CKrWx5nXigBid6P
         fxDbcCQWgQ+5EdeM6F7dVMHBBVodVd+f1omTQvC5hN1wo4kaxVo+agfaDXk7/O0bA4nQ
         NvECnrGMcqvndVTVW8h79cGqsRJhzmKbQRZl3msfjcJic4VWfokULgGuvkhRy9tySnA/
         ThCg==
X-Gm-Message-State: AOAM532u/2e0uAB4/gU21aZ2zcSyOURNKoBfIHhM9KbIEtpSMECS6TDr
        xrtpbYo9BzcOOTREzxVhsxViWfGfdpOGTNI0Ulo=
X-Google-Smtp-Source: ABdhPJw34Y8gQNDGFQR2io3jlMJRYu+MKyrhB+nnET2lKLrI2xs39AUJf0NnYUuJ9cSENNFRU7hbhA6taqRry/Hp3kg=
X-Received: by 2002:a17:906:3cc:: with SMTP id c12mr7392520eja.216.1602917050901;
 Fri, 16 Oct 2020 23:44:10 -0700 (PDT)
MIME-Version: 1.0
References: <20201017024353.189792-1-caleb.tillman@gmail.com>
In-Reply-To: <20201017024353.189792-1-caleb.tillman@gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sat, 17 Oct 2020 08:43:59 +0200
Message-ID: <CAP8UFD3=pByaH-bFFo8VVSqt_NVPwpHLx0RQyCDwfWV8OL7TRw@mail.gmail.com>
Subject: Re: [Outreachy] [PATCH 0/1]
To:     Caleb Tillman <caleb.tillman@gmail.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Oct 17, 2020 at 8:06 AM Caleb Tillman <caleb.tillman@gmail.com> wrote:
>
> *** BLURB HERE ***

Cover letters like this are about giving context for a series of
patches. As there is only one patch (1/1) in the series, the context
in the patch itself should suffice, so there is no real need for a
cover letter like this if there is only one patch.

When there is a real need for a cover letter though, the title of the
cover letter should explain what the patch series is about and "***
BLURB HERE ***" in the body of the cover letter should be replaced by
text that explains the context and the reason for the patch series.

Thanks!
