Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0CB141FA7B
	for <e@80x24.org>; Fri, 16 Jun 2017 15:45:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751639AbdFPPo6 (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Jun 2017 11:44:58 -0400
Received: from mail-pf0-f173.google.com ([209.85.192.173]:35560 "EHLO
        mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750792AbdFPPo5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Jun 2017 11:44:57 -0400
Received: by mail-pf0-f173.google.com with SMTP id l89so24117970pfi.2
        for <git@vger.kernel.org>; Fri, 16 Jun 2017 08:44:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=XNJxwuD9bMniz9mj/rKbKgJkHGtxM7C9wwoePo2KrGQ=;
        b=uLOiinFKnokRqVn1bqRh5wGBOGE+PHSjjsssQItIXlolMs1xu6LEsPSY0n/b8Rs2iI
         0r+Jjf9eLPoNcW55ByC356TEioXBeQbak8w7nRcTpQPkCdIZkRV5esDEzNvJuSPdQ4OT
         QNzQIKWB8oxIRoAR8lerySEtbmocyOZ16JuM7IhPnd4usAJzi5TLJbP6iynmI2rjaq1r
         6InizeUCZwe47WGe6yaT+jWHkYQWFQOPThu+d12TEjHMXoBwV6XY5/2v+qaPLDneqfuZ
         FI41Kf5TNkQ+fL7EtjcEOZYHdhVWGZj8tG8jac+YxuAxDz8zKdT2WRx6xkzty7sl4ZNo
         ln1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=XNJxwuD9bMniz9mj/rKbKgJkHGtxM7C9wwoePo2KrGQ=;
        b=IPdjA4uExmTHupFSaMb+AcCI6PbeoiDyxBC/r6fiNXp3YMJL3XcjlvVit4MA5K0yeO
         sOvBOgMyxyAWFuNo9XCO0T0Snl6f7UypFRXkvtv//9OzpSZUbIg8CU/YeFmrkdJRdO5K
         35EJJu72c8fGa8fq55GQS186NsM6kQpw3mnMh1HHmVMZDwErsaq/otame+Hx4/WKQZEM
         riaq1bp7ZA9PILf3INLrXsRelDF8vAZjUPutWjCzTNZ0sGx1+BwUZ+DiGyrqPVnjm7F2
         blQbrH+4laT09IhJnmaRKNj4aLXPoExDdiKDn4cRh2kIGXYl1uYot8ghO58Bs2YIazEP
         a+ZQ==
X-Gm-Message-State: AKS2vOygamMbzrpU3MfdOX4FRuA9BhVrl9icO0NlmInfGfGyiyj5LCyD
        6c7ITyMgtBMZqP9njpI063WctRzEIjf7
X-Received: by 10.99.120.199 with SMTP id t190mr11015712pgc.176.1497627896622;
 Fri, 16 Jun 2017 08:44:56 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.218.134 with HTTP; Fri, 16 Jun 2017 08:44:56 -0700 (PDT)
In-Reply-To: <bf1fcee3-2f2f-b153-5774-dee5b2a2790d@alum.mit.edu>
References: <cover.1497534157.git.mhagger@alum.mit.edu> <eea8f3d25e9d3d3a0b63604338f10cfa658bbb43.1497534157.git.mhagger@alum.mit.edu>
 <CAGZ79ka3u_otP6M+oRBb4dQdMQx6kFHaXihLsBpM23gqzwqOGw@mail.gmail.com> <bf1fcee3-2f2f-b153-5774-dee5b2a2790d@alum.mit.edu>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 16 Jun 2017 08:44:56 -0700
Message-ID: <CAGZ79kbavn0QdqaoJJ+DXh28OLb1jDgdqA01soawQZ86fp0XkA@mail.gmail.com>
Subject: Re: [PATCH 04/28] packed_ref_store: move `packed_refs_lock` member here
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        David Turner <novalis@novalis.org>,
        Brandon Williams <bmwill@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 15, 2017 at 11:43 PM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> I chose that name because it is a `ref_store`, with `packed_` being a
> short prefix that tells what kind of `ref_store`.
>
> The next question is, why `ref_store` as opposed to `refs_store`? To me
> it sounds more natural in English for the reasons that you mentioned.

Yeah after some thought on language this sounds good to me, too.
I still have to work on natural. ;)
