Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6F4B41F404
	for <e@80x24.org>; Sun, 25 Mar 2018 17:06:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753730AbeCYRGt (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Mar 2018 13:06:49 -0400
Received: from mail-wr0-f171.google.com ([209.85.128.171]:41630 "EHLO
        mail-wr0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753646AbeCYRGs (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Mar 2018 13:06:48 -0400
Received: by mail-wr0-f171.google.com with SMTP id f14so16587388wre.8
        for <git@vger.kernel.org>; Sun, 25 Mar 2018 10:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=HWHhZZqWRWkfXQkSlDMz1h4eH6CB4h5+Ku2ove0HDmw=;
        b=RtqQ37WqG7Wnz5vFvqF1GO7DMMxqJI38MC+RTKfJPKQj5hRINur8+9Y1Md2+5vQ5Po
         FVaMZ1Yxx/fWUyuOWljL6+O7rK+oh0/eUutT2MMqikFSd7o2SeFHOMhwgqAKmNDZeVLL
         cNeJXGCFNR8uEvQ7DmgkOHZB/57eKIrwDn9GKiXDnfQI4ivu2c/D4GCGKl8q5K+AuYSZ
         D9I3ypH5147y2GbZacstK/Re8W4gaY7NBd4jhXgGa1NohZWqaBeO52LTyM//efTZibW1
         byH+wssQOW8g8WvjrD8e+R8qQtgZLpE33c1FgWJEAxNMoIYC+KcxuwjiD0JxKqOXJ1/X
         Wp+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=HWHhZZqWRWkfXQkSlDMz1h4eH6CB4h5+Ku2ove0HDmw=;
        b=RMfShmr0QUiP8SwEp3Hfsxqg96mPCyrdExngrAbfEe6KINV2KB1F7A3TfXOQ0D5WkZ
         3ijaTbFNu9OtGsMQbrdA06iY0AJuAlzJjMvagkraAJwl1mVedbFv+JqpqAVlo3LZ8cCg
         gTCDRebpF1ULNBQKSfkEAXJEQlAY4ynX26+tGg/hK+Wrvs/kwDBaULNLBPQoE/KM55ie
         NTuXKfCrgsdUDiRhd6e5DUJmzmWXIckzFyHOFl5eGvM7Y58MwZnpYAqZByzQ9SKnVKI4
         +ObNxXoGeQYuRKwDg76buyu4oVRFwG3v1BhIzaDhDre+lt4QdiDSO/EFeHYjuiYYrjk6
         IZHg==
X-Gm-Message-State: AElRT7HIEHH1GlejtDf8Ilyy82KzPN1Oc7M3XFaoZzdA7/bdIjhQ5Jhk
        hX8Xie2bCEAmP7RbJyDN81U=
X-Google-Smtp-Source: AG47ELuTylbCAMk3MQmJI+4n8Eog/don5uuG+Pv3n/RAUfLdt0blOINqQYR6r78B78XBeG8HFrgPOw==
X-Received: by 10.223.189.14 with SMTP id j14mr18391476wrh.138.1521997606763;
        Sun, 25 Mar 2018 10:06:46 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id o11sm13769492wrg.91.2018.03.25.10.06.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 25 Mar 2018 10:06:46 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Git mailing list <git@vger.kernel.org>
Subject: Re: [PATCH] branch -l: print useful info whilst rebasing a non-local branch
References: <20180324183844.4565-1-kaartic.sivaraam@gmail.com>
        <CAPig+cQ8xw23SGhpx5qtDEyzJGR1v4L2Lm9tEWe56Rh3c8Q3cg@mail.gmail.com>
        <87ea8cac-c745-b7e6-7804-5116cd94ed48@gmail.com>
        <20180325041056.GA22321@sigill.intra.peff.net>
        <CAPig+cRe9AmFv=GCxPOo5vcLGFuT1qdM60M4KV5P6UN+Ai-QoQ@mail.gmail.com>
        <20180325043337.GA32465@sigill.intra.peff.net>
Date:   Sun, 25 Mar 2018 10:06:45 -0700
In-Reply-To: <20180325043337.GA32465@sigill.intra.peff.net> (Jeff King's
        message of "Sun, 25 Mar 2018 00:33:37 -0400")
Message-ID: <xmqq7eq0f5ju.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> IMHO we should do one of:
>
>   1. Nothing. ;)
>
>   2. Complain about "-l" in list mode to help educate users about the
>      current craziness.

Nah.  We've seen this, perhaps not often but enough times over long
period of time.  The above two would not fly as a longer term
solution.

>
>   3. Drop "-l" (probably with a deprecation period); it seems unlikely
>      to me that anybody uses it for branch creation, and this would at
>      least reduce the confusion (then it would just be "so why don't we
>      have -l" instead of "why is -l not what I expect").
>
>   4. Repurpose "-l" as a shortcut for --list (also after a deprecation
>      period). This is slightly more dangerous in that it may confuse
>      people using multiple versions of Git that cross the deprecation
>      line. But that's kind of what the deprecation period is for...

3. is prerequisite for 4.  If we haven't gone through both in 5
years we should be ashamed of ourselves ;-)  But at least we should
start 3. and aim to finish 3. in 2 years if not sooner.
