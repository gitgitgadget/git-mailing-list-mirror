Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BE07C433E0
	for <git@archiver.kernel.org>; Tue,  2 Feb 2021 15:32:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 120BA64E92
	for <git@archiver.kernel.org>; Tue,  2 Feb 2021 15:32:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235414AbhBBPbS (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Feb 2021 10:31:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235593AbhBBP24 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Feb 2021 10:28:56 -0500
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5292C061573
        for <git@vger.kernel.org>; Tue,  2 Feb 2021 07:28:15 -0800 (PST)
Received: by mail-ot1-x331.google.com with SMTP id 63so20198349oty.0
        for <git@vger.kernel.org>; Tue, 02 Feb 2021 07:28:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cRa4U9cvrVJyY4JGuD7/9ODgJMRxmGLiQFdlEJrucp0=;
        b=XiSkn/a5DUAWeXxjTDQAcqUeVwGvBm4vL+9Fvgt+/HILh3WX3ZIjfSjZaEV1dHVPJ6
         LKNU3NYOUQ2gXpsezgak8plbwYToaLvIVfWVHynV3CAuCql0H4F2DuXUSWiOmVPE3Kk0
         rHXjCw06tRCmWupzKdxv2oc3QIR2JXre5OFjpp8ySx3eR6HZdf2q7FvQXMV+ygaYEXxd
         EwGrO0fHlnuhVyo1iD2TR/keK4VsbtzocDht2ZNfHowtax9kS0oNTICw4wxFVNeBkXrZ
         SaxBLwI+lbNdlVbV6mW2VJFZCI1mhWwliGew1g7US4QkYviUaEZjzFYxFBHDTkcE8CP6
         DDug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cRa4U9cvrVJyY4JGuD7/9ODgJMRxmGLiQFdlEJrucp0=;
        b=PGY8smVIFXExPp3+TR735vDn0xoxhZRLCopERdUfm0ur7tF0yR3TZW5lbtBYYMiEAd
         9VeIK1UPmXG6nnBEByZovm0coqT5GV+DW7tpV+gXXzREyzQePknQZ8bVAZ8KdWI7bCF5
         oYFhpOfXGRIrHeDlMAOhQLkQd901ODGPBYby86opcXPmHA8DXLGvRDwxmCNAdoNKdVZ+
         MW/Cv9IyUQ7g8dLjxTBEXOD+bvaXDOPvCpUvlUXaPFh0f203oebRL7YRI80aXs+K+hSu
         rW8mxTRz16LlM4QrrtVSyqZHpTRBC7j5HOI4gNzKbEDBRB4SodoMeGRDghXHlUEJmnr8
         BqXw==
X-Gm-Message-State: AOAM531UusASUVlKBiyUxk+6XLS/yFeWPg5FcVSXUwCplOn0V9OoS92+
        WUOuPSbnw2tuxFXRAG3f5F8/zr4Bmvoob4t3iYo=
X-Google-Smtp-Source: ABdhPJxOqYXVKC3SJ0GcCT3H8dhff/hTWVTmheR60eNyFDU+vFr2OIzGBJsn1bI14lHmE3KllYKRhtyMDZcV+z8pavM=
X-Received: by 2002:a9d:741a:: with SMTP id n26mr15537583otk.210.1612279695165;
 Tue, 02 Feb 2021 07:28:15 -0800 (PST)
MIME-Version: 1.0
References: <xmqqsg6infev.fsf@gitster.c.googlers.com> <CAPSFM5fLcSBmcGTLaPuoKKHO0qv3fKB5q-XvXv5emWfLYpFv=w@mail.gmail.com>
 <xmqqr1lzlgc7.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqr1lzlgc7.fsf@gitster.c.googlers.com>
From:   Charvi Mendiratta <charvi077@gmail.com>
Date:   Tue, 2 Feb 2021 20:58:03 +0530
Message-ID: <CAPSFM5fegCDcLkKbhzT6wBubVWn=_KC45m55jUZX409Eqa3Ueg@mail.gmail.com>
Subject: Re: What's cooking in git.git (Jan 2021, #06; Sat, 30)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 2 Feb 2021 at 01:18, Junio C Hamano <gitster@pobox.com> wrote:
>
> Charvi Mendiratta <charvi077@gmail.com> writes:
>
> > It seems that a lot of tests are failing in macOS.
>
> That is caused by a separate topic, I think.
>
> The mention of 3415 is a leftover from an older round, I think.  It
> seems we have an all-green build of 'seen' with this topic in it.
>

Yes, I admit t3415 failed in the older round. Thanks for confirming !
