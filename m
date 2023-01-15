Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69163C46467
	for <git@archiver.kernel.org>; Sun, 15 Jan 2023 21:38:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231707AbjAOVit (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 15 Jan 2023 16:38:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231661AbjAOVim (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 15 Jan 2023 16:38:42 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0150C1B546
        for <git@vger.kernel.org>; Sun, 15 Jan 2023 13:38:42 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id v23so27325409pju.3
        for <git@vger.kernel.org>; Sun, 15 Jan 2023 13:38:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xLlKnLyuHwXDS1ZCMDfnDRbs63fgnNbk8t61AabjeU4=;
        b=odVSfkscHUtNQyTqALwi0mRa1jbseQOARqUNUW+N2j3qoSz62rU3Q3Xj/rtbDiEnta
         QpZT3W13sJX/0iz0WxUmGzEwp0CxVEtdpbczAdEoCLTZwfOEXNdPaLGyjBCCcdTWulI+
         kq2HYjv2+8I6b51c939dQY5D6lVGGx2bKa8up9LE2GZObw3ZxFMMdDNnIQn6murt9CQa
         Tvv0jR0EzoaKzDRMR594DrF8sge1QdC9BXTgJx9DAZ2yH4fOERn0VXHxb3ItHh+mYQx2
         kyF1tjOY20EgyauOp0K7gUW0MzQVoMsU1ON+P1MrZ3Yh7nXalSQMfS/wSxFXl/msW4Iy
         SPag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xLlKnLyuHwXDS1ZCMDfnDRbs63fgnNbk8t61AabjeU4=;
        b=hz0yc9CZM0AINoRk8V7vCI7p3VEh81R8JzSp8Db9YCxtBVQ2WwBOABrfUPK//y7Ley
         RcfV9pLGOLquwwvzlf1/K28ydOylcgZwTlFNEkkaLEXq+E6ZggEEmo1des8BnB9JtyYG
         zfWYpcm9e6p+608ETvY4AR8OobWNYhJ7AQYK6eOGT5rwo5LmxMMR1pKv5T3mdDg3dHQB
         jS+HFTmNeEsvbAjwYKf1mVG7JIvhUoGfN7KktfOthNEtQZq8s3fYnlVg4z6NtOb+Fhbv
         jRbxBfnvgDGr/oqal+YFc6OJ1JdaQLu1LnVQByGgumk//sArkhO7bV/W/44pVWED1C65
         1G8g==
X-Gm-Message-State: AFqh2krz71OBV9oyfoREi/lNLCtSXQEiL/cY3Kw20uUejkGD6TNW6o+7
        J0oBv8iG39zp0beoeo5PoT8=
X-Google-Smtp-Source: AMrXdXuryc4pfL45FlmejwvECl7InVvxUg7bGSSjLQwM/Nkx5zJ7J9QrZeiDwZQ0R8XKbdY325Werg==
X-Received: by 2002:a17:902:eb4b:b0:194:623e:f401 with SMTP id i11-20020a170902eb4b00b00194623ef401mr13122477pli.8.1673818721384;
        Sun, 15 Jan 2023 13:38:41 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id f7-20020a170902ce8700b0018685257c0dsm17862574plg.58.2023.01.15.13.38.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Jan 2023 13:38:40 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Ramsay Jones <ramsay@ramsayjones.plus.com>, git@vger.kernel.org
Subject: Re: [PATCH] ci: do not die on deprecated-declarations warning
References: <xmqqv8l9n5fj.fsf@gitster.g>
        <Y8LAim4D3g6qnZdq@coredump.intra.peff.net>
        <xmqqv8l9ks86.fsf@gitster.g>
        <Y8LjTYhTycp/tTBn@coredump.intra.peff.net>
        <xmqq4jssi8qh.fsf@gitster.g>
        <Y8RdOt02JTvDnLiX@coredump.intra.peff.net>
Date:   Sun, 15 Jan 2023 13:38:40 -0800
In-Reply-To: <Y8RdOt02JTvDnLiX@coredump.intra.peff.net> (Jeff King's message
        of "Sun, 15 Jan 2023 15:08:26 -0500")
Message-ID: <xmqqpmbffpgf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I do think the IOCTL/SEEK one is old enough that we can do, though. The
> deprecation is newer, but the SEEK interface was added in an old enough
> version.

Yes, that one is old enough (SEEKFUNCTION and frieds are from 7.18.0
and 7.19.5, IOCTL was deprecated at 7.18.0, released 15 years ago).

A problematic one is REDIR_PROTOCOLS that was deprecated in 7.85.0
(Aug 2022) whose replacement appeared in the same 7.85.0 version.

Thanks.
