Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 398F1C433E0
	for <git@archiver.kernel.org>; Thu,  4 Mar 2021 00:22:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0495F64DDA
	for <git@archiver.kernel.org>; Thu,  4 Mar 2021 00:22:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355304AbhCDAWN (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Mar 2021 19:22:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1582026AbhCCHeq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Mar 2021 02:34:46 -0500
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01A20C06178B
        for <git@vger.kernel.org>; Tue,  2 Mar 2021 23:34:03 -0800 (PST)
Received: by mail-ot1-x32c.google.com with SMTP id e45so22649661ote.9
        for <git@vger.kernel.org>; Tue, 02 Mar 2021 23:34:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OD4Qr3p8EgipnLEiKhkLc+mfZeCC8zkuBShG785SaVI=;
        b=Wm1QVQMzKm22Sq964RSSvOnBwDmCQe8L2zukA/HRQIKOeZQs+lZ5sIjWPlcOR7nOVN
         Ej8KVMyJ7mdwOu6pIqNfnhuoQ7q3tES8pc7JA8qW8//UatYVYWQZljGtdo/RGFlqsiG1
         N5HeLO4m0ZNOnP00pNGR2ZITtb+8KlcYvoL8DDQq9nH1dIVFQfwDLTFOwp1fvFU5gObv
         fRXBYUH5tL6FoXlqyH3eQbFuybb5BJDFnnDLHA7X4rlNhlOU1tcU64Z8Jw3+kkXmyZ22
         iGzPm0ILAujmR0whFvqTwWOdUPRw3Zhqx7K3O39eoa4PW/OgfGB5fnYITWIKeiLdR7C7
         /WXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OD4Qr3p8EgipnLEiKhkLc+mfZeCC8zkuBShG785SaVI=;
        b=EuChA7e4/vbsQA7Gx1zG+8GViRGoD3HFUFYsEHM6P2bdxAfcGU6rwyDARDnxBGQ8gl
         fqzVErA8/ridyfya2WlqhLks37qtXOhADovh8VflTo1LClViln39Fw6QxGTkBgnhvEPK
         DmMTXGDyPP69xgG71N8i0D4HDpKUgilvog5b/tqVN1FTXJKBf3ypjci1reIvFaE+LTdD
         a2oAAZr0jTbHGwwBNtz6YkfBXQtYrXbAXhZ7sJ0iKJvaUF1LuSFpexv31/lvznA27riY
         PuqjDmPVgyPB1UCIAAOtBT+vrz/amc62jAjNOrR4DnnNx9UV4gY6nCa9gYzN1dWVNlQH
         V1tA==
X-Gm-Message-State: AOAM530o2UBYkpDVqQHLP02Cv8934aozIXhn01qmmgK183nbY+FldMw8
        9Int2SP9lCeDTzLu5dOqtI44Abvlg4TQZNYcwzU=
X-Google-Smtp-Source: ABdhPJyMgAmFoD0w/qykFL6jDkcXPcwGL6yYZdlqWqrIUs0z9T2Gz0+qrQW4FpT2NVh6uMhnX5hIcRnmSu69edNKm1A=
X-Received: by 2002:a05:6830:1d43:: with SMTP id p3mr21642322oth.184.1614756842473;
 Tue, 02 Mar 2021 23:34:02 -0800 (PST)
MIME-Version: 1.0
References: <20210301084512.27170-1-charvi077@gmail.com> <xmqq8s76r9v1.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqq8s76r9v1.fsf@gitster.c.googlers.com>
From:   Charvi Mendiratta <charvi077@gmail.com>
Date:   Wed, 3 Mar 2021 13:03:51 +0530
Message-ID: <CAPSFM5c3xHRYVxgwVSh888yBxp01PvsEnRsxOjsJtXzjgeJ7Ng@mail.gmail.com>
Subject: Re: [PATCH v3 0/6][Outreachy] commit: Implementation of "amend!" commit
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> I only had a few minor nits and I think with them fixed the series
> becomes as good as it would get in the shorter term to be ready for
> 'next'.  We're almost there.
>

Thanks for pointing out the mistakes, I will fix them and update in
the next version.

Thanks and Regards,
Charvi
