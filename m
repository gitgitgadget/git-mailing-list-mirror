Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB235C4321E
	for <git@archiver.kernel.org>; Thu,  1 Dec 2022 21:26:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230422AbiLAV0t (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Dec 2022 16:26:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230215AbiLAV0r (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Dec 2022 16:26:47 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F47EC7D04
        for <git@vger.kernel.org>; Thu,  1 Dec 2022 13:26:46 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id c15so3071422pfb.13
        for <git@vger.kernel.org>; Thu, 01 Dec 2022 13:26:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SPAGI+Y1AJeozLbaBSDAtNwmox5vgSOLQ2c5PI5cPy0=;
        b=RGrzArZ4LKsMAyQSLq250ZMVN7paWvOQTpLT4a5LO0M1H9Mao+/quelIfULA/omyHp
         i3T+8BlHB1UuK4eRWw1uzG7lNHYQMw2az6rFMQ2krgLCyHKHfER6Hl4JNYXNqulKMuHA
         DnpB5w5Yf0HDR9nxMH0OzO8DIk0WTSzwtYek76B5n0NCyoR6rZIisX7t7LPqocSc0Peg
         MiGPxog8Uo+z7zpNse32EFM7bvF38+JlOigdoRqYGF3at6ZWZ7Och1mCV27zMQeqMU+Q
         qRMpK+YXwrcgTT6gMjJbcIUp2ZNtpoD3NS29HuYAyc9FkL/1EDalK+b2dN4OHcv/zedX
         kSiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=SPAGI+Y1AJeozLbaBSDAtNwmox5vgSOLQ2c5PI5cPy0=;
        b=OPzRsUIpPSZC6FCmDwvL2BGd0khFizAEIZHUAqJMM8KjStSEbjPvRvOGg0LOXQWY4r
         l75kRaXctd9eftcvF54A1eAUnsyCCPpeMN7dM17RtmrKr1IOJ9gzdj+uMOoJ7EntPNvf
         1XFJ9DT7rVlREiiICZxvp1lhtUsBRl4YxpA3EAeZkDEKwmpXFIu1Ee4cEN/Ov3+PpvRg
         WUoi5nUHeohS3PjB/B9BgBDsJvPcx0rk02dzilq2QR0b7P4n3+WBCCDVVJ6zSk18mg0T
         Ycd/jhX1WUSi/uWxun4di+64coPitWQ+flrfJaEoEMkOA/OZKu2F/PTUrrsp+CCNvm+K
         vJ6w==
X-Gm-Message-State: ANoB5pnfE79QsBZPi50TDli0P6n/uQFYxLE+c+6ycfhJy5AppLtzo/Mv
        v5DTmupGLm12J6yCYjEaewA=
X-Google-Smtp-Source: AA0mqf4ArnJcil5pr1534R28SSvLsf0Z/K6+7h9trdE1wk1SUhgvyYHyuaNCubSJWNZu3eAeWeL8cA==
X-Received: by 2002:a63:1e23:0:b0:477:6fe2:29ec with SMTP id e35-20020a631e23000000b004776fe229ecmr41864085pge.522.1669930005767;
        Thu, 01 Dec 2022 13:26:45 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id g5-20020a17090a300500b002193f87fb4asm5348317pjb.4.2022.12.01.13.26.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 13:26:45 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Glen Choo <chooglen@google.com>
Cc:     =?utf-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, git@vger.kernel.org
Subject: Re: ab/remove--super-prefix and -rc0 (was What's cooking in git.git
 (Nov 2022, #07; Tue, 29))
References: <xmqqsfi22j67.fsf@gitster.g>
        <kl6lsfi1d1tf.fsf@chooglen-macbookpro.roam.corp.google.com>
        <xmqqilix150o.fsf@gitster.g>
        <kl6lh6ygqphu.fsf@chooglen-macbookpro.roam.corp.google.com>
        <221130.864jugi59l.gmgdl@evledraar.gmail.com>
        <kl6la647ow7e.fsf@chooglen-macbookpro.roam.corp.google.com>
Date:   Fri, 02 Dec 2022 06:26:44 +0900
In-Reply-To: <kl6la647ow7e.fsf@chooglen-macbookpro.roam.corp.google.com> (Glen
        Choo's message of "Thu, 01 Dec 2022 09:44:21 -0800")
Message-ID: <xmqqmt86stm3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Glen Choo <chooglen@google.com> writes:

> Frankly, I find it odd in the non-recursive case too e.g. in one of the
> non-recursive tests, we have:
>
>   Migrating git directory of '\''sub1'\'' from '\''sub1/.git'\'' to '\''../../.git/modules/sub1'\''
>
> where all 3 paths are relative, the first two share the same base but
> not the last one. I don't think a casual reader can easily tell that the
> last one should be relative to the second one.

That's a good example, although I can understand why a developer
(not a user) might choose to show the last one relative to the one
that comes before it.

Thanks, both.
