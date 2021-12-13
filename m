Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EFC7C433F5
	for <git@archiver.kernel.org>; Mon, 13 Dec 2021 23:37:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244233AbhLMXhQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Dec 2021 18:37:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241127AbhLMXhP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Dec 2021 18:37:15 -0500
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9975BC061574
        for <git@vger.kernel.org>; Mon, 13 Dec 2021 15:37:15 -0800 (PST)
Received: by mail-pg1-x549.google.com with SMTP id j3-20020a634a43000000b00325af3ab5f0so9745147pgl.11
        for <git@vger.kernel.org>; Mon, 13 Dec 2021 15:37:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=tmPuHSeJtyL7wVrkKuAX3unlns+NKCfAkaq6ZKRtA7o=;
        b=OEV5PjZJrXydTU7h/owHgxrdB4dctkm56bQRUz0KG2jNuC7N5l96ttVOR/pSar0X/m
         jrChTbAyOiIugbX6prRBm7826RAYY01KAZz0gHOLNqxWUCH5p9/DLIzte+SVivh0AVC+
         aAel9teeJKS0y34GMNRcbY8jKbh2NAXnKumAtArr2OnUPb03G4jUNbvqgd4TqZNhEJ+w
         lNI3SGtDno6Rc/gQNNPxV6yMmFcG9rMItLlRGi4jC4xKK/dPfeWR4wAWmQGUWiyHCk9N
         U2kDICF7RAojGWXC4H+SOG2AjNoxNl2oy4JCe5w6SRIcR6749Jb/6PGh5YmV6Lsm7+bL
         74Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=tmPuHSeJtyL7wVrkKuAX3unlns+NKCfAkaq6ZKRtA7o=;
        b=dPop6EYTVaf0rd1SKjCJla7kOIv2VbB3Y1o1RTHdV8i7kpjyURkzaXCBOegZjAqNTl
         G6klBDzSx2cx3tPafVE4dgnyUlGORa5AdnzyFWexHcXbl5vfzPZqLnucBHS/TGzo+z/S
         ZOrYCGdAYmCoYyZ+8F1sHXowiuQpKkEq5cEotpydmw211y0NGdYB3HRHikjtkra62qIF
         VvCbxOt42DDKsmxPXCBHldREWfx9R2f/7v43UROxCGDxCpJS8214C4kTvniNAlBMsvbA
         5zQuhLEvjyVN3hT28ObaVN9F72pMbNIEx7TJFKtckRuLLUilePy5rk1sn7Okz4Ka5qbo
         1HFw==
X-Gm-Message-State: AOAM533b+0KAW1GcHM0S7WZwNw8iFzra2bCR02z/ah8sfsY4CXPU+PQC
        S+AVSoxoxbge2NvcOYdO3iCqkt+Xp7DSwl8PK7Ap
X-Google-Smtp-Source: ABdhPJyt5FFOszgMzpk5lVTq5uNq+pxbItXyQyv6dXw7lsfa2XHEbhQnSgM0wHsvBycWL5WjM7zf2P88L/EXM/QdZVdw
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a05:6a00:cc9:b0:49f:b439:8930 with
 SMTP id b9-20020a056a000cc900b0049fb4398930mr1202794pfv.86.1639438635074;
 Mon, 13 Dec 2021 15:37:15 -0800 (PST)
Date:   Mon, 13 Dec 2021 15:37:12 -0800
In-Reply-To: <xmqqmtl8m8wj.fsf@gitster.g>
Message-Id: <20211213233712.774546-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <xmqqmtl8m8wj.fsf@gitster.g>
X-Mailer: git-send-email 2.34.1.173.g76aa8bc2d0-goog
Subject: Re: [PATCH v6 2/2] config: include file if remote URL matches a glob
From:   Jonathan Tan <jonathantanmy@google.com>
To:     gitster@pobox.com
Cc:     jonathantanmy@google.com, chooglen@google.com, git@vger.kernel.org,
        avarab@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:
> Perhaps it is easier to approach it from the viewpoint of a new
> user who is unfamiliar with what you designed.
> 
> I would imagine that most users would find it natural if a single
> pass precedure read and processed lines as it sees them.
> 
> That is, when the first includeif is evaluated, we have seen only
> 'remote.a.url' whose value is 'bar', so the condition does not hold.
> and then when the second includeif is evaluated, it gets included,
> and we read 'bar'.  But that is wher configuration reading ends;
> remote.b.url is not asked for after we process the second includeif
> til the end.
> 
> If you explain
> 
>  (1) why such a simplest design would not work well; and
> 
>  (2) how the actual design is different from that simplest design to
>      overcome it.
> 
> it would be easier to grok?
> 
> Thanks.

Thanks - this sounds like a good approach. I'll try this.
