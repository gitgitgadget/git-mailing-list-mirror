Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8D3C12095B
	for <e@80x24.org>; Mon, 20 Mar 2017 12:40:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754113AbdCTMjY (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Mar 2017 08:39:24 -0400
Received: from mail-ot0-f177.google.com ([74.125.82.177]:35550 "EHLO
        mail-ot0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753950AbdCTMiq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Mar 2017 08:38:46 -0400
Received: by mail-ot0-f177.google.com with SMTP id x37so131268764ota.2
        for <git@vger.kernel.org>; Mon, 20 Mar 2017 05:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Lgtvm5mI697o3gXwxIrRwBJnDfBloZ2Yp9yYGp9VsPw=;
        b=tN5gG5FYq/D/0myirFMeEcCz3cCguCaZuNZCdagBcX2iyW+VkwfG+6qQFQK9higWzW
         IwA2MOZb2yAIOAYAbWXoELNAoTZrSnYIKMc7kr554HijNsVFvwG7YnQx270N3kTWPfuf
         bRgj5n2/fhNRwnrkDOwFWihSns+p6LCpsRnUkuBv531YMdwqQYK6GeJGkcaTj2mwGqHH
         eo7xUH8Bc/w9jBXIH/9EmIrE81A4TlvHZx+VyYsht90209WxSa9kdjDtgdgEid1bfSX9
         ugVDLSH3SIb2Yxv47/NhQG5GryC6DacRtV78e1DsU28MPJGlIBaNkZdmq/AX/6DIbR4N
         Mjiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Lgtvm5mI697o3gXwxIrRwBJnDfBloZ2Yp9yYGp9VsPw=;
        b=HojiyGQzXl60mBXWd3doPJcUOkiPHmHqZKuid9tBx3NMtV2nI4u+BHdIfr6B3V2MnI
         ctg+F8fxr2WOzklvKVZcok4as19bNDHVIOBp/Serfp4UzJBHqb/Xn1WojMsT9mVOsDAe
         ZLSYfi1FaTjzAIc3GsUKA1U0AkNkdOF+9b2qfAJ6rbHf8kVHsfUOxgqqz2R6wNW0nyvr
         f8KQqVuVPLItOyCnP2VNzWvNrVfgmO8hmZao92Btdbsi9pPValZhW3PawhfFaXKpGzDw
         42a6rYyC/wb+JbB+xAr5GBzFSFGt2MX0IaGHudnqZYwdd7ZM5QsRy2vV9acq+Fixq1Nj
         jX/g==
X-Gm-Message-State: AFeK/H3YuV2PQa20ND/ZxZvq7WCuwZ56Kks9QhvHZXBJoTYB+nD/LJySBtyehM5zZR6s30YelhbChhdTyjEmcw==
X-Received: by 10.157.18.132 with SMTP id g4mr15974584otg.10.1490011818585;
 Mon, 20 Mar 2017 05:10:18 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.158.84 with HTTP; Mon, 20 Mar 2017 05:09:48 -0700 (PDT)
In-Reply-To: <3738362d-6c76-cba7-824a-d689bbe290c6@alum.mit.edu>
References: <20170222140450.30886-1-pclouds@gmail.com> <20170318020337.22767-1-pclouds@gmail.com>
 <20170318020337.22767-18-pclouds@gmail.com> <3738362d-6c76-cba7-824a-d689bbe290c6@alum.mit.edu>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 20 Mar 2017 19:09:48 +0700
Message-ID: <CACsJy8CHjSMV1qOAB-7-F562jx+3XKtQOjuPOFz0wu-pYR3aeA@mail.gmail.com>
Subject: Re: [PATCH v6 17/27] refs: move submodule code out of files-backend.c
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Stefan Beller <sbeller@google.com>,
        David Turner <novalis@novalis.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 20, 2017 at 4:05 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
>> [...]
>> diff --git a/refs/refs-internal.h b/refs/refs-internal.h
>> index f732473e1d..dfa1817929 100644
>> --- a/refs/refs-internal.h
>> +++ b/refs/refs-internal.h
>> @@ -482,12 +482,11 @@ struct ref_store;
>>  /* refs backends */
>>
>>  /*
>> - * Initialize the ref_store for the specified submodule, or for the
>> - * main repository if submodule == NULL. These functions should call
>> - * base_ref_store_init() to initialize the shared part of the
>> - * ref_store and to record the ref_store for later lookup.
>> + * Initialize the ref_store for the specified gitdir. These functions
>> + * should call base_ref_store_init() to initialize the shared part of
>> + * the ref_store and to record the ref_store for later lookup.
>
> Maybe mention that the function will make its own copy of `gitdir`?

I would think that's the default/sane behavior and not need to be
mentioned? A function that keeps a pointer even after it exits, now
that's something that must be documented.
-- 
Duy
