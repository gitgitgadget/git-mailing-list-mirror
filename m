Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FB3CC433DB
	for <git@archiver.kernel.org>; Thu, 11 Feb 2021 22:27:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BDA1C64E38
	for <git@archiver.kernel.org>; Thu, 11 Feb 2021 22:27:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbhBKW13 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Feb 2021 17:27:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229951AbhBKW1Z (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Feb 2021 17:27:25 -0500
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE97AC061574
        for <git@vger.kernel.org>; Thu, 11 Feb 2021 14:26:45 -0800 (PST)
Received: by mail-oi1-x22d.google.com with SMTP id k204so7962110oih.3
        for <git@vger.kernel.org>; Thu, 11 Feb 2021 14:26:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nvOA3i8EANf1COcWR/6MrKQ2Ywjt9CPlG8cu30UMacs=;
        b=P7omfbOwQJ9o9xTuf7D+gECac1d+Dsi4GA3pjA+rmGaUVoEYJUSSH+4ZSpYTbRNqa5
         8gIqHlPzUugcMLIp0631Z4+s+gDfyF+O9/lgeiEUShX42+ZecB1LnVilKY0vupSek2zr
         FY9N8MlVYDcO8jxguFw8oJB4Qz2qYd3QwVn0KqMcLNkZPcL+adFvvQ39nyJCEEO9tZ+k
         AB8sNkIWav9ImiNtn2+Si+5Y4bgQr+zgkK1byrOwMoJdTEHbvbF7WIH3ONecrHcA2eow
         k2bAWotcuqK3WWp/2++WnFbQCceEpKoGuD9LdfC/xoBYz9hYl1C+Dso4TmyKvnZ5ilC6
         pl5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nvOA3i8EANf1COcWR/6MrKQ2Ywjt9CPlG8cu30UMacs=;
        b=e4mxRIv5od7IUqFQOdyMX74IV01izHx+oVkpT4rt0rdnTz1NugT6JGICyVj1ZfV0Pz
         FqXJO/8fp3kGWUc0P402Noqo5S7FEKtjK+QVJBWpKKrImWBT50JaLRkt4I+evkcnU7LA
         q8wer87agqMcs3hiPJjA1qiuGde3Cg9J40wFt/tgH8eq4gtdj0zYuEIhjdo4MdZMVi32
         CMI8AhOO3G2PagawyXtMzuD/G13jke2+5iLkikxpbpVvy3WZa3CVCpUPZ0gP3wX9Doil
         P6pu9gGurlkq3syBsoc1wxgNDcZs1i+r0ORVvc930ohSRBWKWuB1PT2WQZh937gQF5Dg
         oAvw==
X-Gm-Message-State: AOAM5311k7erD88L5zltULBsHANN6+LOqPdmhuFIfnrpMCBcrNDrwSoV
        RzGZ52fP39MXyQ/7SlL0desd3FSLp5jISSNfDlE=
X-Google-Smtp-Source: ABdhPJwjKYfgY2scy4/P8fkY9FkLeGB/PrfqmKdCKdKfq+j0H0RfKT6oSentiARKtGj8IHYKTXsHBEURQSCb5OZSA/Y=
X-Received: by 2002:a05:6808:aa6:: with SMTP id r6mr20346oij.163.1613082405333;
 Thu, 11 Feb 2021 14:26:45 -0800 (PST)
MIME-Version: 1.0
References: <20210207181439.1178-1-charvi077@gmail.com> <20210210113650.19715-1-charvi077@gmail.com>
 <xmqqeehmy129.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqeehmy129.fsf@gitster.c.googlers.com>
From:   Charvi Mendiratta <charvi077@gmail.com>
Date:   Fri, 12 Feb 2021 03:56:34 +0530
Message-ID: <CAPSFM5fWmTXRHKseqXwZyE6MOVccR2OPSs5kyEu-k1K1p01EPw@mail.gmail.com>
Subject: Re: [PATCH v3 00/11][Outreachy] Improve the 'fixup [-C | -c]' in
 interactive rebase
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>, Eric Sunshine <sunshine@sunshineco.com>,
        Christian Couder <christian.couder@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Thu, 11 Feb 2021 at 22:49, Junio C Hamano <gitster@pobox.com> wrote:
>[...]
> Thanks.  Looking good.  Unless there is any other nits, let's
> declare victory and merge the two topics down to 'next' and then to
> 'master' for the next release?

Thanks for confirming. Here in these two topics  `fixup -C` works with
"amend!" commit in interactive rebase and we are still working on some
improvements on the new patch series ( to be sent)  that implements
"amend! " commit . So I think to rebase that  work also on this topic,
to make project history clear and avoid the confusion ( it also
improves the same test script in this topic).

So maybe please wait for that, before merging to master.

Thanks and Regards,
Charvi
