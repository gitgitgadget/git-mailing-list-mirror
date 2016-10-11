Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 41EE62098A
	for <e@80x24.org>; Tue, 11 Oct 2016 18:45:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754482AbcJKSo7 (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Oct 2016 14:44:59 -0400
Received: from mail-qk0-f176.google.com ([209.85.220.176]:36656 "EHLO
        mail-qk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754469AbcJKSo6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Oct 2016 14:44:58 -0400
Received: by mail-qk0-f176.google.com with SMTP id o68so49397632qkf.3
        for <git@vger.kernel.org>; Tue, 11 Oct 2016 11:44:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=N/mA8qgLvActZj0UQ7UnEF1/peQ471PmjdeWw0Fbl6E=;
        b=Iruzktx/MplKXJatQtR/OwVUDOHwvbZspYmfHAb16pn34K5BTcaJ9oTyIVC1EF30SD
         KxzovIX5ND1dk0xTIVy9GuKsGb7rwfsGZU4G6+yl6wMjBlEuc+myV26XV0HQoNDBHNfH
         uZ8KxZNQWDudrpwIbBuWnyhGivvyD1bTx5+2U4p0+yFfMpLQyncpH4jvCjrUrNVBBnJr
         5DaPHs7oYSLeX6QxHGgoxsQDuNvYfQ6J9k4Fylewdc68fXhvitQRAqcqVxW+LCAfpMsz
         FGZrTUMVvp40OBNs0tMPDDKWtMXpdU6uoqp/v+zJCopodajR544uEMCC+LdxDtAm+vEs
         vazQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=N/mA8qgLvActZj0UQ7UnEF1/peQ471PmjdeWw0Fbl6E=;
        b=UwZ8ZZ/FejrSXUc0ZKR5RCjdpSimJf7no5Unjw/4R0KAj7B9+CyWDGbdSdQ9jhvwq4
         MI0aYkury7Z8XXvaxxervr16BEdm5KShJl5LSKZDV2OAqZDEz+LS1+YijxgP67wR6fP1
         UI2tOU8Xk98YjTvqWDndE4WXSMThiJ45Z9NajJlQ0GW1vO9puq86Y4LOzp2pTz4R1syW
         IF9NavDWe5qGENSRZulzEDuTOCTMoosW4aMxK+s9CKPHpXtnjrontn/c+NmBRdH1ifN1
         cGlk201PE9zUCekFI2GMaTWiVIARt16XZExGBEA4V9NDN9j2kkQpuB9k5CA07tCc69oj
         56UQ==
X-Gm-Message-State: AA6/9RkoUSL5SWcxR3MYelMR4HBMQ0U3tQgN6qKR7YyvvfplqHqaoALZqqnG3BvrEe/NEs1jWfBSakEPebJH94FG
X-Received: by 10.55.142.130 with SMTP id q124mr2553290qkd.220.1476211497989;
 Tue, 11 Oct 2016 11:44:57 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.135.40 with HTTP; Tue, 11 Oct 2016 11:44:57 -0700 (PDT)
In-Reply-To: <20161011184010.GA16014@google.com>
References: <20161011002115.23312-1-sbeller@google.com> <20161011002115.23312-18-sbeller@google.com>
 <20161011172805.GB9085@google.com> <CAGZ79kbqikTtUGxXFB3W9k1nL6ST2iwRRi5zEuL9BOpHxZWc8A@mail.gmail.com>
 <20161011184010.GA16014@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 11 Oct 2016 11:44:57 -0700
Message-ID: <CAGZ79kaM_5MGwPPAhQKWgCGirbHvioBY7_PtkKxza8qV6ZyRnw@mail.gmail.com>
Subject: Re: [PATCH 17/28] attr: expose validity check for attribute names
To:     Brandon Williams <bmwill@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Duy Nguyen <pclouds@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 11, 2016 at 11:40 AM, Brandon Williams <bmwill@google.com> wrote:

> Wouldn't a +1 indicate that the attr name is valid while the 0
> indicates that it is invalid?

Right.

>  It looks to me like we are checking each
> character and if we run into one that doesn't work then we have an error
> and return 0 indicating that the attr name we are checking is invalid,
> otherwise the name is valid and we would want to return a +1 indicating
> a success.
>
> Am I understanding the intent of this function properly?
>

I will change it to +1; I was just rambling about when you may
expect -1 in this project. :)
