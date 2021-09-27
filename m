Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78BC2C433F5
	for <git@archiver.kernel.org>; Mon, 27 Sep 2021 17:59:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5923E60F11
	for <git@archiver.kernel.org>; Mon, 27 Sep 2021 17:59:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235759AbhI0SBH (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Sep 2021 14:01:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235807AbhI0SBG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Sep 2021 14:01:06 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0184AC061604
        for <git@vger.kernel.org>; Mon, 27 Sep 2021 10:59:28 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id r4-20020aa79624000000b0044b2d81afd9so10698636pfg.4
        for <git@vger.kernel.org>; Mon, 27 Sep 2021 10:59:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=nmagG1SdcTK8ulVia1pg/V5p36qx3P62RASI3LGemfY=;
        b=QDl6kU/Q9vxkwErubsYszaDEr5+43PXvmItpk4ATbXsZGnvYex12+6VDHTBKrWsih6
         4jAPpz507nkOI5rLkTocMBX79i68oKi3wpwnmqlDW02IlksHZeTBGQJvzmI9LzRitKV0
         5jBDojwb5rCwnb1zKppKg1k0F70Qm1HO+xJc50myDxl3RqK8BtOVgCFdxWj8p9AMxbzJ
         y9B9tYBZOwI7iaA24eyrf2+Lzk9a+3bBMMteJZmIM3fD0PqSSAfUlQi6pfkDtet4O4hY
         ue4D/MiYerHgsRUCephXudyBW9JYJT91vwHIQdQfY8VUeslZDLaNEGBOydNtyYUOT4uS
         t/5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=nmagG1SdcTK8ulVia1pg/V5p36qx3P62RASI3LGemfY=;
        b=uCWJhUUNFTQQ7JxvXI6KnZva8yqwbff3zB3N1Y/+VGzjVnyNbwmRZXwDXzgWVXXWJ9
         uWZaD1rpJTaaAmBAX3s+ZwnFVdFwJ9Hrgx/Hq7odYKF+cT3D6MjICaeA9TkxD5L9Dznq
         U3md52FEzHeAY7zzCsoAAPiG1+mykMPfnixOCJpxpn9bWRW5zeX//kOObTRCJ0d1n6Ta
         iJBmSd1cOFx050VaWdjA0ESBD31oRNUmj7zUdRVCxbek8XAQ+gyfkFhlmKxJDtUNz7/X
         lakPm3dq0CSMPOFVBkl6fu3F2Tt+qY9J09CjFt2cCguFS0KIGJDyNldpEUznFXbuKJOY
         u4LQ==
X-Gm-Message-State: AOAM533eY5AnisQffezjK2coI58nSOiwNHHkJTC+AkeImnDVHl7W2Gnt
        7iVYM1S/txZrZxHRKYucdQTcCsae7DnclSShnDbwSZ3wOXI/+7adLnjq2Uu4EY0kM7LmfUrZ+/x
        9xkC5sHMZKUtLwuIzWFgbiDEMJlrmhF1cZxvKhCrN75oFZRZTVf1tzxl5BBk84Ic=
X-Google-Smtp-Source: ABdhPJyHz5iwF773LS/b4GwBDHgXm3umKFV0zhawC0yPVkosbgMqxyDKvMBC/sh4JsC6f2Bvv4EHCjzDkNKGVw==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:902:6a81:b0:13e:3af4:fbdf with SMTP
 id n1-20020a1709026a8100b0013e3af4fbdfmr1033717plk.84.1632765567327; Mon, 27
 Sep 2021 10:59:27 -0700 (PDT)
Date:   Mon, 27 Sep 2021 10:59:24 -0700
In-Reply-To: <20210917225459.68086-1-chooglen@google.com>
Message-Id: <kl6lh7e53nnn.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <20210913181221.42635-1-chooglen@google.com> <20210917225459.68086-1-chooglen@google.com>
Subject: Re: [PATCH v2 0/3] Use default values from settings instead of config
From:   Glen Choo <chooglen@google.com>
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


I wasn't clear about this in the original message, but I think this is
ready to merge in its current form. I'd love to hear from reviewers who
can poke holes in that :)

Cc Eric and Taylor who have given the most review on v1 (thanks again!).
I believe I've addressed your comments and I'd be interesting in hearing
your thoughts on v2.
