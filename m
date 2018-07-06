Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5C1541F62D
	for <e@80x24.org>; Fri,  6 Jul 2018 05:54:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934649AbeGFFwl (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Jul 2018 01:52:41 -0400
Received: from mail-yb0-f193.google.com ([209.85.213.193]:39528 "EHLO
        mail-yb0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933859AbeGFFwj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Jul 2018 01:52:39 -0400
Received: by mail-yb0-f193.google.com with SMTP id k127-v6so4126963ybk.6
        for <git@vger.kernel.org>; Thu, 05 Jul 2018 22:52:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Xa/dDLGRJiMfXJYQjk+/8rJiDKGGKltFLjVNKtc4PG4=;
        b=ZHJlvwdhBOhPmse0hnTkzadn+emICaKsSQ8ifcuq21R4Hgy3hdLOrZQLS9afwPdkF3
         l/+yjDBLhmEKTCCO8Xs/wzic7IekbTZcLV6OoFCLpaAR6Ax4kt318+utSEYsVttSXkzL
         YO5RFJkXDJ9EcLUqzCn3lCtox2bgyVSjVrXdOBMIzjRMKW5EoMjbDVqhSqN7YnCodtuZ
         QClzHYbFnNtXPkO0aYE4aXdXgaiedevqRH0Rj8X4IEFKO3u3mLDdMXsw7WyO/maOfB7W
         zaT0BDzuTYnCz2c10Y2sB4LP9/kYIM749cEQmv6WHRK7nIKcv7udnERmiDnmKtkFDVIP
         tvRg==
X-Gm-Message-State: APt69E2xA3mpX7OIgdEPi+q2litff7M/FnYTVoJeimMkKLXgZqP4Xsw7
        Rh63StFvOy9n4fd84YbSmOF5WxahEFHudqMOUck=
X-Google-Smtp-Source: AAOMgpeON7m6X7nee/QiZf9gd94hqfbBwHXO2dWCnMf/7XAIFuUErCiym8u9jSevcNc2qFc7ee4FNcH5ogv9UYfVuTE=
X-Received: by 2002:a25:d38f:: with SMTP id e137-v6mr4477696ybf.287.1530856358383;
 Thu, 05 Jul 2018 22:52:38 -0700 (PDT)
MIME-Version: 1.0
References: <20180625143434.89044-1-dstolee@microsoft.com> <20180706005321.124643-1-dstolee@microsoft.com>
 <20180706005321.124643-25-dstolee@microsoft.com>
In-Reply-To: <20180706005321.124643-25-dstolee@microsoft.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 6 Jul 2018 01:52:27 -0400
Message-ID: <CAPig+cRm0VykJWvMLqaKDDRk1mcG_kDDPeo64jJCoVZ1i+k9wg@mail.gmail.com>
Subject: Re: [PATCH v3 24/24] midx: clear midx on repack
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 5, 2018 at 8:54 PM Derrick Stolee <stolee@gmail.com> wrote:
> If a 'git repack' command replaces existing packfiles, then we must
> clear the existing multi-pack-index before moving the packfiles it
> references.
>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  builtin/repack.c |  8 ++++++++
>  midx.c           | 12 ++++++++++++
>  midx.h           |  1 +
>  3 files changed, 21 insertions(+)

This seems like a pretty important bit of functionality. Is there any
way to add a test of it to t5319 or would it be too difficult (or not
important enough)?
