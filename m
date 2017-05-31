Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5731A20D0A
	for <e@80x24.org>; Wed, 31 May 2017 07:59:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751086AbdEaH7S (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 May 2017 03:59:18 -0400
Received: from mail-qt0-f172.google.com ([209.85.216.172]:36699 "EHLO
        mail-qt0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750974AbdEaH7R (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 May 2017 03:59:17 -0400
Received: by mail-qt0-f172.google.com with SMTP id f55so6128016qta.3
        for <git@vger.kernel.org>; Wed, 31 May 2017 00:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=lzIZhCymvb5JXw+dR8hbXLwCvNpRE7Se3J7HWS4PewM=;
        b=C/Nd120H2rJUsJ3JTSg7q+SeSv+VmAYeEbh9UqhZ1Aljmrr+7JhXCnY/9XRgFF8wsR
         czHr7WxHdlgTuCMQv4q0GCQ1SNwkQzqMS7AyXC5anXvjSgCivBYPSnpKl1pWIF+GtJy6
         kycWyreKS2zfonKFIzhF0R+Vl7jv5BchFo5cqHUpeFCj1NcDWQ81kCyAJysUb4SK0HbC
         ajRyivMz41Bvrmy+FTh8AyrJQ1Sbj1qi+NDFTHAEGB7kf4/yfhvAbjFPlTOYGhkqfpj5
         HFc3qqMLN7y9e3JzyCMWtKbepllAXuAHtUUh3YTNNHjZF4f+QLgjqhO9CnBBeJENKQAm
         FVSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=lzIZhCymvb5JXw+dR8hbXLwCvNpRE7Se3J7HWS4PewM=;
        b=Hq3x3SFkdoEw6aYj7p3KZIT/ZOB0278hj9L1dD8CerzdEwvrSBNZJMDaYdHCMvvpdE
         ypT/5SkzD7A8whTrMKXyXGj7IGLovD+HWbUUfN5u0KV5aGFrRzPFihCcVvusQRnZ3nh+
         LQOhzP1nfgDQKGsAv0adaPuC+gWSBSWEDkTht/O2NOZruN4RyxbHZ29xfRFKPfx5O/3Z
         oJZJe5gYt6CVQq7BTT4bcP5XKvMhMrpw2MRpKkynW+qVPtQR2SckFJ8upgNAdYxkvoTs
         R98fgTksJ0Zn4BD4a22xkMkC7Ut0AQjBH45USWwbsjcPyNw0lO4uWtkuqpd+vgGSb0Vd
         StNQ==
X-Gm-Message-State: AODbwcDybIeDaEwdHP4oWDisOqFS9sDyqawsZGtvNLwhOpgkHj9ZCASk
        GmvpAwQqFyqe1Izgg3ZTYwBkH5R2/A==
X-Received: by 10.200.54.199 with SMTP id b7mr29896222qtc.145.1496217556440;
 Wed, 31 May 2017 00:59:16 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.55.78.212 with HTTP; Wed, 31 May 2017 00:59:15 -0700 (PDT)
In-Reply-To: <ab37d437-2a4e-b6ed-621f-5978083cd15b@gmail.com>
References: <20170518201333.13088-1-benpeart@microsoft.com>
 <CAP8UFD20gvTZqCOcpd1iozNDHOZR1sUKRwi062wL52FNHWNC3w@mail.gmail.com> <ab37d437-2a4e-b6ed-621f-5978083cd15b@gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Wed, 31 May 2017 09:59:15 +0200
Message-ID: <CAP8UFD3R0dEsX7BtzYoSmvaKTZYsm9=bpQsu0jEk2aKm83z-2A@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] Fast git status via a file system watcher
To:     Ben Peart <peartben@gmail.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Ben Peart <benpeart@microsoft.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        David Turner <David.Turner@twosigma.com>,
        Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 25, 2017 at 3:55 PM, Ben Peart <peartben@gmail.com> wrote:
>
> On 5/24/2017 6:54 AM, Christian Couder wrote:
>>>
>>> A new git hook (query-fsmonitor) must exist and be enabled
>>> (core.fsmonitor=true) that takes a time_t formatted as a string and
>>> outputs to stdout all files that have been modified since the requested
>>> time.
>>
>> Is there a reason why there is a new hook, instead of a
>> "core.fsmonitorquery" config option to which you could pass whatever
>> command line with options?
>
> A hook is a simple and well defined way to integrate git with another
> process.  If there is some fixed set of arguments that need to be passed to
> a file system monitor (beyond the timestamp stored in the index extension),
> they can be encoded in the integration script like I've done in the Watchman
> integration sample hook.

Yeah, but a hook must also be called everytime git wants to
communicate with the file system monitor. And we could perhaps get a
speed up if we could have only one long running process to communicate
with the file system monitor.
