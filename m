Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 53D072027C
	for <e@80x24.org>; Tue, 30 May 2017 23:32:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751204AbdE3Xcy (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 May 2017 19:32:54 -0400
Received: from mail-pf0-f169.google.com ([209.85.192.169]:35001 "EHLO
        mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751022AbdE3Xcw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 May 2017 19:32:52 -0400
Received: by mail-pf0-f169.google.com with SMTP id n23so697227pfb.2
        for <git@vger.kernel.org>; Tue, 30 May 2017 16:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=DH/n5ZMargWrxK2zC6BLaIBJoWSzDetQnHyQHCz2c+M=;
        b=XIf7X6MovzKk5tc4yalAQQRNRp37LE8Pzx1i3ZFJ+DXzucCrBJpuzjphjOMDgoe7Wq
         BTc/CKQgv0psfKKg2MNOgBZdB6BgLbVxW4iVDEQYEkmmqrqizj7R9IcUXdzZzN5cbn0P
         y2iO4OYr1+GMAXprUnpBDkrkDRpSZhTVrnM6jXGb6icxuDbHD0Fq+aiT5WYXma3BfNAB
         fPYvMQcyPVQVgQowbMxGWeTQxgRkOdiLcRlQkv+ulR5N/r/S5U8/OlGH0EjfUZYpE7az
         ybJ4fjVbQFrle9+/YA0W+39K8VebEIf0y8P4ngv9Dusi9zg4Yyw+c6xPXsa9ynopXf3y
         8Mfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=DH/n5ZMargWrxK2zC6BLaIBJoWSzDetQnHyQHCz2c+M=;
        b=lQpZ7b6Fw7Us+7FCx9bWzxdG4BUm8ATLsiXQXwuKutW7oimtCCUnM4YUn9573A42ti
         OoYa6m57kI+QEgeETFNogTctso1dbF5129wxEwLCl667wGkPDkRlVtQQ2CiQWDblWEHt
         A10+o3R+qQXn3UjGi88VA0OHsrCM/oIPyhwBAvA4uRwXLVeCMnfdonPnkKD5Fz33Ffi5
         v1ZdP8svMSJJcZnL05cCjtbqe5xVSHYzRkUiNlC/awdt6iaV2F1Co2MUUVcXyohw6ASQ
         +qdfOfnqfKoKovQBzzGzF2EOKx1I/zVc8+a8qCvsfpZRupH+y4v3TNtrTuOBj0ZJI0p7
         gtHw==
X-Gm-Message-State: AODbwcB5Kctg2WJafVkB/4sriZ3s9JyWce2mnG2TUvysLBaC6TdT635h
        KdmKN1scVJaOpH+S6jGAh+9Tu1X7HD1f
X-Received: by 10.99.188.9 with SMTP id q9mr28355837pge.178.1496187171775;
 Tue, 30 May 2017 16:32:51 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.170.200 with HTTP; Tue, 30 May 2017 16:32:51 -0700 (PDT)
In-Reply-To: <xmqqk24y9bph.fsf@gitster.mtv.corp.google.com>
References: <CACsJy8CzgHc=qe5w=FGJJ=ZU0a+JiqBrjWHV7SH3rAPKmOOKoA@mail.gmail.com>
 <20170526033510.1793-1-gitster@pobox.com> <20170526033510.1793-14-gitster@pobox.com>
 <CAGZ79kZC4WM=aXPO9Rk1GQ7+XKUhoWUZefjM6Trk-11QcrhBYA@mail.gmail.com> <xmqqk24y9bph.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 30 May 2017 16:32:51 -0700
Message-ID: <CAGZ79kY+KzU5-gqSdV-orPBd71=53UXC4TbD7weqRtJtRjwdWw@mail.gmail.com>
Subject: Re: [PATCH v3 13/13] is_missing_file_error(): work around EINVAL on Windows
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Sixt <j6t@kdbg.org>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 30, 2017 at 4:17 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:

>> cc'd people knowledgeable of Windows.
>
> This has been resolved I think with J6t/Dscho's patch yesterday.
>
> Thanks.

Yeah I saw those patches after reviewing this series.

Sorry for the noise,
Stefan
