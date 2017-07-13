Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 09DC4202AC
	for <e@80x24.org>; Thu, 13 Jul 2017 19:12:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752863AbdGMTMN (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Jul 2017 15:12:13 -0400
Received: from mail-pf0-f169.google.com ([209.85.192.169]:36776 "EHLO
        mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752435AbdGMTMM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jul 2017 15:12:12 -0400
Received: by mail-pf0-f169.google.com with SMTP id q86so33812865pfl.3
        for <git@vger.kernel.org>; Thu, 13 Jul 2017 12:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=LINfAxhuGygxz0UWQ5UhQb3sO9VktXp3wVx1HbpJUwE=;
        b=MfvnDl1pO08ZsQxSnxhRzuxaoprEixPEPgagPWtXbow06RwQwuHuIwsFzH8t1dyB/H
         2XYcBybpdxI1qC5nw0cQsOBN5PfU6esnRlCWvYl4U92e5xBQlZOsRBiS2KrVv87RLAVw
         Y+SFOQIhBTE938uovmCWMUl+rm3Y8lE76E9p+eaq1Cy6DgbSc8tcEDJGFR0TWG7wTl+j
         hvyu4jTi5JzC8X5UtiXWZN/MNvBR9RKRVzJCTSWyrejZQDDpQ+M4trK6+9svCZwHyukK
         nswF/jURp5qiCK6ClRqhUEdrCoEFz4VyQ/YBA5JpyIlew2zOqNEAzwIs12a5oXUUlRmk
         mVxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=LINfAxhuGygxz0UWQ5UhQb3sO9VktXp3wVx1HbpJUwE=;
        b=WeJ+ZTGDf9XJHZnGP3D03holrj5Jt8Gvek6RsV/pAE/UynUWcTW77b2ZBV10C0LSnW
         UM0B3dfEGB76J4hmyIhXAiHoltxcGn9zFXJfRLrJGi/NE3aPs7kCQtUKwV7LPSs1XI/1
         8LIKlIbC2ZNi4ztSNNV4rfinFzaipFvomciGHlHrpVbUvlcM56QbPTJnwKDHgy5e0w2S
         uRqSecIQS2aDBuWrGOX2WUZJnMiiWi9WOktLv2SZME6G1VDi+ldwZqaJZKbx3Ku/07Sq
         p9VZJ68gR7c/L6vw4+KKLp5SQ6OmBaDprpolBvdFEYxLKCIOZlzt244/C7jXXbeKHC/p
         YxVQ==
X-Gm-Message-State: AIVw112Rn3jjRFJNpkvmxL9lI07iJyw7j7G8rDp9JStyB2gm3j0UV9hL
        fhx/BhNatwlAIw==
X-Received: by 10.99.0.151 with SMTP id 145mr10852515pga.115.1499973131314;
        Thu, 13 Jul 2017 12:12:11 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:3079:9e61:8883:4f9c])
        by smtp.gmail.com with ESMTPSA id 68sm15313325pfi.69.2017.07.13.12.12.10
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 13 Jul 2017 12:12:10 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Jeff King <peff@peff.net>,
        "git\@vger.kernel.org" <git@vger.kernel.org>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH] RFC: Introduce '.gitorderfile'
References: <20170711233827.23486-1-sbeller@google.com>
        <xmqqinix1j29.fsf@gitster.mtv.corp.google.com>
        <20170712205734.h77fgbbkavwpkr4h@sigill.intra.peff.net>
        <CAGZ79kYYg6-UMrKRPeJTbHdGR0juZ2OwFZmkuYgeYe5X+cm_sQ@mail.gmail.com>
        <20170713155923.a2nissoyczvewoh3@sigill.intra.peff.net>
        <CAGZ79kbgypimtWE32SnDrG-QWT6gF3WGxR5mi785F_rwvRPOuA@mail.gmail.com>
Date:   Thu, 13 Jul 2017 12:12:10 -0700
In-Reply-To: <CAGZ79kbgypimtWE32SnDrG-QWT6gF3WGxR5mi785F_rwvRPOuA@mail.gmail.com>
        (Stefan Beller's message of "Thu, 13 Jul 2017 10:30:59 -0700")
Message-ID: <xmqqr2xkw3qt.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> On Thu, Jul 13, 2017 at 8:59 AM, Jeff King <peff@peff.net> wrote:
>>> This triggers two reactions for me:
>>>
>>> (a) We should totally do that.
>>
>>> (b) It's a rabbit hole to go down.
>>
>> And yes, I had both of those reactions, too. We've had the
>> "project-level .gitconfig" discussion many times over the years. And it
>> generally comes back to "you can ship a snippet of config and then give
>> people a script which adds it to their repo".
>
> I see this "project-level .gitconfig" via the .gitmodules file.
> See GITMODULES(5), anything except submodule.<name>.path is
> just project-level .gitconfig,...

They were from day one meant as a suggestion made by the project.
You do not have to follow them and you are free to update them,
i.e. after "submodule init" copied URL to point at a closer mirror,
for example.
