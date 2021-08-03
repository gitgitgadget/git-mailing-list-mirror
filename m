Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25089C4338F
	for <git@archiver.kernel.org>; Tue,  3 Aug 2021 20:50:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 00E2660EC0
	for <git@archiver.kernel.org>; Tue,  3 Aug 2021 20:50:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231459AbhHCUu7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Aug 2021 16:50:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231351AbhHCUu7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Aug 2021 16:50:59 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1528CC061757
        for <git@vger.kernel.org>; Tue,  3 Aug 2021 13:50:47 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id y200so25824830iof.1
        for <git@vger.kernel.org>; Tue, 03 Aug 2021 13:50:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=WkbOiMO9CCElE/58025aAJW9bGtYhBOmCeHobAodCQ8=;
        b=qtIdqNGfqvFelXOoEoGWphAsrNbvmN3S4WswcB5nsmFjre3UMYNY1x23bTSeEx3ZQ9
         QDqNzUA/7OW9DOEl6D7QX/BSV3XmWWJDfj0f9Ajr9zZyjgBpxmkdccFOJWOHM3QyxTb9
         gSzMXOswiewg3CmauqR+lpXksMLQtyOC37BWZV1RxL8AzjPoUXkAXDjVRhyXlG4hWIlN
         X6aq5S1pU6ZIkCwAnuvkii0uQ6DSL9vy65MQmkdehvAe+WrPIgzRzsGRbeySxJqnDzI9
         l4ybv1F3Yj5iKtT6/3e4I43IPuEM9hqpX/RdDMVmEVymDIcCgONx6F0Z2Az9JbmqyHoQ
         moMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WkbOiMO9CCElE/58025aAJW9bGtYhBOmCeHobAodCQ8=;
        b=jaaWt+EfOCmjdD8+mTdX/M9ZCADREkzTrh73voP5/jWVSVAVn6aLJ27ejXtB93pzYb
         x5K1K2TEGxwHKWNs7x28zbTr7aUDmLVsOtwbTqwPFBzfHZEHCjg0AzWXf0Mow26echUH
         F3MtaMjdS1MK57Xzy3Oz2LgYXJ/PMV9+xZfbIO7e7G3RDgkYKtVdClhVd6kBjqqXuRgQ
         7ehATcydGNE5xplqXp9yWyFL29AB1IUnu1ZaShzEBMTbALOzeWjdpi0/ykKAoVmfdQkv
         5TIkCKf+JP5fyQTCxxU+Ur3VNkUOy1VV+ulUUHmmWO/5zV68Y5b0ZMeO60ubIiRxcL7q
         aqaQ==
X-Gm-Message-State: AOAM531/FXZ9OzChn5N0fZBCq49b9rlapSIwjilGbdCMarGkTOs6FWYy
        ocu1W/b2CD0t5iLiA0P9LhJ6nOKND8mi5v4E
X-Google-Smtp-Source: ABdhPJy6BJPecNcVN3KaE5JwPtBCHHrk/t3NpwdkP13rn/dPd13ZzNq88h2mhgZb981ECpekcU2gCw==
X-Received: by 2002:a05:6602:8c4:: with SMTP id h4mr203933ioz.152.1628023846463;
        Tue, 03 Aug 2021 13:50:46 -0700 (PDT)
Received: from localhost ([2600:1700:d843:8f:a92c:44a1:9adc:e4de])
        by smtp.gmail.com with ESMTPSA id w14sm113784ioa.47.2021.08.03.13.50.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Aug 2021 13:50:46 -0700 (PDT)
Date:   Tue, 3 Aug 2021 16:50:45 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Cameron Steffen <cam.steffen94@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: git revert --continue --no-verify
Message-ID: <YQmsJUe6hAMy/QGA@nand.local>
References: <CAAVFnNkW6Bc4bBDeea2v-VFydvEC0dBw+QXVA0-6OnmF8km3ZA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAAVFnNkW6Bc4bBDeea2v-VFydvEC0dBw+QXVA0-6OnmF8km3ZA@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Cameron,

On Tue, Aug 03, 2021 at 02:17:07PM -0500, Cameron Steffen wrote:
> Today I tried to run this command and I just got a help screen. I am
> using 2.32.0.
>
> git revert --continue --no-verify

I can't think of any sequencer commands that support a `--[no-]verify`
argument. Did you mistake `--no-verify` for something else, like
`--no-edit` or `--no-commit`?

Thanks,
Taylor
