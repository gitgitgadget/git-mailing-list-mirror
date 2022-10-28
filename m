Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EBB4C38A02
	for <git@archiver.kernel.org>; Fri, 28 Oct 2022 21:51:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230030AbiJ1Vvq (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Oct 2022 17:51:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229866AbiJ1Vvo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Oct 2022 17:51:44 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89BDE24C960
        for <git@vger.kernel.org>; Fri, 28 Oct 2022 14:51:43 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id r61-20020a17090a43c300b00212f4e9cccdso11018379pjg.5
        for <git@vger.kernel.org>; Fri, 28 Oct 2022 14:51:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bO5GXsj3yKGxh/h8Yba/YjI6xVkyWEjRHJqIkudyEyU=;
        b=WGSMLHAELSLpXhZXMrxB+v1T6KDejVxxdXdLp95pxqwlvbyiW9Qrrs797uybq9ExFu
         ULiVDwQbDOLykpvcV9ju5D5Jx30BMixUjniC99LzE66VFowiX4ONkU83vsO3Z3YJ3uaa
         TdLOa/LYlHqWXBuHRqEmeqGZiqbHRBsw7HJezTXOCKu8exiSA+JkUdD/+ytxkbMdZddn
         dFlpyVFvfrqC/jEFwBBGXnCvImwl//oyC4vxNTkBoLUbv/l7UXVpga5efWqr5Vr+mNE4
         yanAAO4ELpEIGKdszUqeUv/RvxGIn90wLg5Zu2W7WRf5qbgzS9uMoOIRres6LvYMHALd
         f+kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bO5GXsj3yKGxh/h8Yba/YjI6xVkyWEjRHJqIkudyEyU=;
        b=EYTIY/lFHCYARiEC5tM3SHI3YXaH+etDJCDJaMXYZx/3GeX96V0Gv2xFsSLMfkR6rb
         m/k5AAxrLfyxFVughYv+QWaGCaxQNbZLpi4hWtaS5q9FfDS5Q3PfBrGiT1x1FDTTpqvX
         LPXuMq+yjREpEUQg4m658cjqPEE2K+6U8SKm5rPgTT/X4q3PMXhBih/Kt/CgYNdrbuy2
         5mT7MAdwi1h/f0e0wNy3/WeLTeuRTT/+dU6D1wqjO9KVHZbtSkM8msOLMvZ4uUlUhZul
         ijFU7CW7Nokvt966PIXfN4F3dF43KrLAJ3k2QNx5RRWfu1GdHbYpL3NZDo06x62Htyyy
         R84Q==
X-Gm-Message-State: ACrzQf1ksiCzvkTwAYBSOK6jXvQyLvAakHyjp+8yi8X/+8T7OXdBnGJF
        IbXhV+Jpx+UnqEo1qC5jtA9YPoCou3k=
X-Google-Smtp-Source: AMsMyM6vv6f1ZAnvASYIYpb/7w1j+h1DgcOfL3XDN+fut6gUrkRofM+pFXix4bxvY97C7x6kqFCm3g==
X-Received: by 2002:a17:90b:4f86:b0:213:3918:f29e with SMTP id qe6-20020a17090b4f8600b002133918f29emr1415012pjb.178.1666993902710;
        Fri, 28 Oct 2022 14:51:42 -0700 (PDT)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id c19-20020a621c13000000b00562a237179esm3221963pfc.131.2022.10.28.14.51.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 14:51:42 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org, Julien Moutinho <julm+git@sourcephile.fr>
Subject: Re: [PATCH] adjust_shared_perm(): leave g+s alone when the group
 does not matter
References: <xmqqr0yrhco6.fsf@gitster.g>
        <Y1xNrDB10XEcAa0d@tapette.crustytoothpaste.net>
Date:   Fri, 28 Oct 2022 14:51:42 -0700
In-Reply-To: <Y1xNrDB10XEcAa0d@tapette.crustytoothpaste.net> (brian
        m. carlson's message of "Fri, 28 Oct 2022 21:46:20 +0000")
Message-ID: <xmqqbkpvhb0x.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> On 2022-10-28 at 21:16:09, Junio C Hamano wrote:
>> Julien Moutinho reports that in an environment where directory does
>> not have BSD group semantics and requires g+s (aka FORCE_DIR_SET_GID)
>> but the system cripples chmod() to forbid g+s, adjust_shared_perm()
>
> I would personally use a different verb here because I have the
> impression it's offensive, at least when used as a noun.  Perhaps
> "limit" or "restrict" might be more neutral, or we could pick another
> verb which expresses our displeasure at this design (maybe "impair"?)
> but maybe is less likely to be emotionally charged or offend.

castrates? butchers?

tweaks?  That's quite neutral.

