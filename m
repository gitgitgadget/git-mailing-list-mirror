Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B0E351F597
	for <e@80x24.org>; Thu, 26 Jul 2018 19:01:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730439AbeGZUTr (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Jul 2018 16:19:47 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:51301 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730289AbeGZUTr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Jul 2018 16:19:47 -0400
Received: by mail-wm0-f67.google.com with SMTP id y2-v6so2981182wma.1
        for <git@vger.kernel.org>; Thu, 26 Jul 2018 12:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=MRHodhJ8oGKSoqRvlmCH6RBLzjJOugRwL83donmilf0=;
        b=n4EENeejUzEcngoJ4Lh4eRKLucYH7tGwhiqCursP5tXAkvE/CelrBcuc6hNZCYf2Ld
         ui6eLfiOWicHCck/cJ+ILt8VSwyPZSa0sRKoNsmIasiMPNZjo+9f7Qb4aYBJJL6kLrvp
         lR6KimI2vBMZEsx9hkDxqucXmwb/7/1aphODInNXyjHC+GpVLi7AGa3mbmZ6i+QjLhBd
         12wiF2EDB3mjGaRtzBFeVIid7E0iaVy5i3kIJ/lMNL9yZAFgJkG15iyOeQhFpPFt4NRO
         58eET3HrV1VXt9aGV1txO7Iw7jQDPM0V8ziBr41SKB4cROVdqNudNmi8cvMJpCHU5dSQ
         2+Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=MRHodhJ8oGKSoqRvlmCH6RBLzjJOugRwL83donmilf0=;
        b=jH//NoJ1SUZxjbYq6x2eQ+6m7jQ0K5sSf5z1PdeOVWnKwR3/k+CD1kLU2oM6w6M19a
         0z63W0tbNPn1c7iqEh4pC6hG9fTPgZ5vF9uC64u9GCZ2gPflE7unG1X25BhGfD7jhOru
         6+n0x4KRdJTJRYxvDzT4Qt+3+lcymTeMMAc3wsCnNroZeKT4Y7KGmGbr3Q256siMbWoC
         z4DM6sMQx3JQ/+ZE1uUFishHoxl/Td2+GPpm2+PmFHrCvvHV66j7M36a7byKIzEv4guz
         3I1zsWuoXFA43Z89AtrACoXygx0ceUm9sUCCZr7HmtLuJLuGwyJYYAGvkNxe54BTck01
         yy5g==
X-Gm-Message-State: AOUpUlEz/jRkDLRuBUHfDx1HHRyBTXwjswBMDMAWC/YnAEQI4Lma+pT5
        FcbtlSGTQND+mRiDDiYVLwRyDocd
X-Google-Smtp-Source: AAOMgpdIkFwf4BB9uR0CGXbnac/RfN2fC3YmkMxd1s2De0uZUr4chagEdlnixCr8BZ5MrVikIHYurg==
X-Received: by 2002:a1c:d942:: with SMTP id q63-v6mr2492197wmg.78.1532631697158;
        Thu, 26 Jul 2018 12:01:37 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id a12-v6sm1376277wru.61.2018.07.26.12.01.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 26 Jul 2018 12:01:34 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     git@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v2] name_rev: add support for --cherry-picks
References: <20180726121346.GT1934745@devbig577.frc2.facebook.com>
        <20180726143930.GW1934745@devbig577.frc2.facebook.com>
        <xmqqa7qerpxu.fsf@gitster-ct.c.googlers.com>
        <20180726153714.GX1934745@devbig577.frc2.facebook.com>
Date:   Thu, 26 Jul 2018 12:01:34 -0700
In-Reply-To: <20180726153714.GX1934745@devbig577.frc2.facebook.com> (Tejun
        Heo's message of "Thu, 26 Jul 2018 08:37:14 -0700")
Message-ID: <xmqqr2jpq0s1.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Tejun Heo <tj@kernel.org> writes:

> I should have explained the use case better.

No, you did not need to.  I was not saying the feature is not useful.
I was only saying that "explain where in the history X sits" command
(i.e. "name-rev X" and "describe X") did not look like a good place
to have that feature.

>   Upstream, it's v4.17-rc1
>     Backported and released through v4.16-prod-r2
>       Also backported to v4.16-prod-r1 (cuz the fix happened while r1 was going through rc's)
>
> So, it extends the description of how the original commit is released
> (or given name) so that releases through cherry-picks are also
> included.

Perhaps.  I am not yet 100% convinced, but having a less hard time
trying to convince myself now ;-)

Thanks.
