Return-Path: <SRS0=Hc2o=CM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2224DC433E2
	for <git@archiver.kernel.org>; Thu,  3 Sep 2020 06:20:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F342A20758
	for <git@archiver.kernel.org>; Thu,  3 Sep 2020 06:20:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MMJBoLep"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726368AbgICGUV (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Sep 2020 02:20:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726022AbgICGUT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Sep 2020 02:20:19 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12110C061244
        for <git@vger.kernel.org>; Wed,  2 Sep 2020 23:20:19 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id b19so2132703lji.11
        for <git@vger.kernel.org>; Wed, 02 Sep 2020 23:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=aji+p/2ztfqzh0dOhZjriXqPeC/0cMn3MQll2/tAAGc=;
        b=MMJBoLepxpr79CAQN+7LBWfm1rNaGbsxBcAcfDhAEXofa02qRhRIvYYU9Wz8bK65o1
         S4wL/Ubu2slbfWDj9KEIUNJsy2Obl9s/Y6z2wkg0eQ25CYLfJpGDs5eZR3jDVhd3ijoG
         KKIr8b9bw1E8JbzU43nv8IKvUMsd31bRDA/ZyFbtqcguFZJB5Slmuu++0JEoP4O6CKQG
         RT52/2eA3470rX+OkASbbXcEYN1SpTPcbzeUOqO3ifGjdHbchZnbW02Y5CffCns+QVD9
         Fs3I+GmRnSC+RbSoJxzM2hVsJZHrdXt5qT5LrEK9Bx7CKtNkOUzzMifPuiVzdAjS8GCK
         Kbaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=aji+p/2ztfqzh0dOhZjriXqPeC/0cMn3MQll2/tAAGc=;
        b=Dj4Eqr4B7fctIXFxk/6PGCrPmmhPFNvvOExFxYi+RYn8TfbcV4igFrVwU9OXRV3lkZ
         f6AWI/jlqi2Pg7vTsrWZQwa73VQNR97Nsr+DG19S19TD1YnjtNoZYReFa2UtnMQp/aKD
         AM+ZQCYi2beOYorFMTCdo5QORz2mqh8qmyt+Uwnfr6nCQIoKWzM3YD3uVfqvVYtU/BzJ
         gRuivLJvcHLZRPKBxM3+fq2V/vSFXe1Uc52YvwOxl98GwVXr4U5vjd0h9Y+2Y2uxlj/4
         SkaU8y+DPgZmFJ+ZOkxYe3x4wUPWLzEfcMi6Tfdz3BZZx71ptp7hDIZ+4rfbE6V7woOR
         Yypw==
X-Gm-Message-State: AOAM532lHun2EYn3TTftVMZ6y0aFRJxsY1fCXvYIic8e5eja/9aib1uk
        RuOpMuAM0jn54iEwCsRTY6lPh0FGrYCq8QC9N4v0IcekJtQ=
X-Google-Smtp-Source: ABdhPJw1rg1h5YNNLlcSydLYUkxpx+EmC8PHydbMG8kRWkxSR5ooE1Qp6mlQ80afiJ03QaHCDQY9yDNSQi/c3m+VVtE=
X-Received: by 2002:a2e:818b:: with SMTP id e11mr405452ljg.0.1599114016775;
 Wed, 02 Sep 2020 23:20:16 -0700 (PDT)
MIME-Version: 1.0
References: <CANG6M-ri1uvEPCcssP=Q0iM25Vhr5QZ220zUUhMdH4AVR9OLSw@mail.gmail.com>
 <20200902232309.GE241078@camp.crustytoothpaste.net>
In-Reply-To: <20200902232309.GE241078@camp.crustytoothpaste.net>
From:   =?UTF-8?Q?Rafa=C5=82_Grzybowski?= <aguyngueran@gmail.com>
Date:   Thu, 3 Sep 2020 08:20:05 +0200
Message-ID: <CANG6M-p-CEsNNY7jdhw0y5NndruBrwNqrtv_+m+irXFgm8hGkA@mail.gmail.com>
Subject: Re: Repo state broken due to mismatched file name casing during merge
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?Q?Rafa=C5=82_Grzybowski?= <aguyngueran@gmail.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ok, I understand the behaviour now.
Thank you for your help :)
