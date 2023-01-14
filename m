Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF88DC3DA78
	for <git@archiver.kernel.org>; Sat, 14 Jan 2023 16:35:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229807AbjANQfz (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 14 Jan 2023 11:35:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbjANQfy (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 14 Jan 2023 11:35:54 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 907148A53
        for <git@vger.kernel.org>; Sat, 14 Jan 2023 08:35:53 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id w4-20020a17090ac98400b002186f5d7a4cso29996398pjt.0
        for <git@vger.kernel.org>; Sat, 14 Jan 2023 08:35:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MiwynIsquPh9fsMPYVyV6Wg8Di/FQCRj2x09aAJ1LK8=;
        b=LXvUnYkN8JxtKn6SrHqgzpGJC0iRyyLV7dhDhodL2KVEavivyIxYbMR98zszDg1v7f
         +CtCz4C7zqz6jYkxqNCzwVOQsnF+UjqwoQMtJjsnsiD4cJp1cmP25gO55oz3sTKsvlbM
         AUJ2ryTu7Ebh0PAE9ee3fmhDVI2CDY/QIehEdxFNXD5CNTJQamFMI3JfNZfn/hChi7FL
         4QFtwtRBuImaDN+ZhsRjsVh4qiRsJXHVKnNPR/0g3foKVYcxRxna87V82xmeRAew6OqQ
         7veQl75MN1X7TgAUNLkCRng5hPl31RA6zWvXrFOoIboI5P7wR4t8QpwE2TKXdo5BYkaF
         bQ8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MiwynIsquPh9fsMPYVyV6Wg8Di/FQCRj2x09aAJ1LK8=;
        b=TC/Gmj98x9R9D6zqjUrOnrxTxbdD0G9gzd+/7NEJhzmXT/f0PBe6AwUXk5djZufSno
         TEFsuk43uSPOb+IlhizVPY4GkOV1kcSQxNzZEzVq8sqcLgTCgLa+bfvR/ILleU+lrzep
         R1chx7XLuStaAIjq1OhIBO6R5q0t2z2wPNwmYXp93UQPa2GOOwKMdnr97g2UB+ynlgBZ
         rpUMqWzjrpqHC66jtFSsAzEI2l1imnT1DND5RZ+2POZFNSsSgZr+klsu5Bpy0gYZK2jz
         mjOEERSMT+jTLIezXP9/fzrLOQ8qOeELvSgsh3VA5SnIBfooo5kh8kQVlcwWl6LgNO6F
         qwJA==
X-Gm-Message-State: AFqh2koOJRbdmkbPllu7QunbDzaYZ2pSFbwB2c52D2SpTQrsASa/lby8
        2FVLiyCOYjdppE8BOt3hiJ4=
X-Google-Smtp-Source: AMrXdXuDTGlGHf1jf/kpReWJWC8+qs0nyc1JJuvXxp36Vo9+PYfaWqurAW2k88B10Q6buT8b9yp2sA==
X-Received: by 2002:a17:902:8d87:b0:192:d58f:e5ff with SMTP id v7-20020a1709028d8700b00192d58fe5ffmr39791274plo.16.1673714152970;
        Sat, 14 Jan 2023 08:35:52 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id e5-20020a17090301c500b00188fadb71ecsm16219430plh.16.2023.01.14.08.35.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Jan 2023 08:35:52 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jan 2023, #04; Sat, 14)
References: <xmqqilh9ms1p.fsf@gitster.g>
        <Y8Kkjswoy3ELmAxR@coredump.intra.peff.net>
Date:   Sat, 14 Jan 2023 08:35:52 -0800
In-Reply-To: <Y8Kkjswoy3ELmAxR@coredump.intra.peff.net> (Jeff King's message
        of "Sat, 14 Jan 2023 07:48:14 -0500")
Message-ID: <xmqqr0vxkr9z.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Sat, Jan 14, 2023 at 12:36:18AM -0800, Junio C Hamano wrote:
>
>> * ab/test-env-helper (2023-01-13) 1 commit
>>  - env-helper: move this built-in to to "test-tool env-helper"
>> 
>>  Remove "git env--helper" and demote it to a test-tool subcommand.
>> 
>>  Will merge to 'next'.
>>  source: <patch-1.1-e662c570f1d-20230112T155226Z-avarab@gmail.com>
>
> There's a typo in the subject: s/to to/to/. Not a big deal, but since it
> hasn't quite hit next yet, maybe worth fixing.

Indeed.  Thanks for reminding me.
