Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 125A2C433F5
	for <git@archiver.kernel.org>; Tue,  1 Feb 2022 19:27:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242422AbiBAT15 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Feb 2022 14:27:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242278AbiBAT14 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Feb 2022 14:27:56 -0500
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7688C061714
        for <git@vger.kernel.org>; Tue,  1 Feb 2022 11:27:55 -0800 (PST)
Received: by mail-qt1-x82e.google.com with SMTP id h8so9314861qtk.13
        for <git@vger.kernel.org>; Tue, 01 Feb 2022 11:27:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version;
        bh=kL2+d8/I80Mn3sAnVEthWScBIob1LWtuwyR/UQ6IzwM=;
        b=KMLn1RF8XKfTAC5Dt+dxY0B+J6ZRHCYGny4wHUYUvOWH2j4WJbb1Tkm4Ghrcb/ZD9F
         GMkFKC06fdm/0k5J+J2QOyKr6eQ4/3VudNkQHS5/HPZUfaZPYmK5+AaLCJdFc0fQ58aR
         6mP2SzgqKl8QKevoDhqIJMca7dhKMPHtfe115pETTisDB/5S9q8h3YNWWkyLIjFEp7lv
         NAZkXfHzfxjstTXPbl/EoQ7Jwe/YLAly4uz9Q8YnmMa5+Ix+1ahDjrI/OHOGOyHBJZDm
         j+vOPhs/aE3HZGNCrHzs1i+H0QJ1eqgtfHhzLfJlmlKLaLpeGGL8pNtPY8HH8qR/SSlx
         YtSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version;
        bh=kL2+d8/I80Mn3sAnVEthWScBIob1LWtuwyR/UQ6IzwM=;
        b=t9Oiit1NOIaQGCQNDeeHXR0MJgtaEHTQd4BN7FuKVXR6pUWOhM56vdADUzOaxJVg3K
         sSalNfr8DKTbot7wTfU8AeFdbGqEE18o9rjKMycEW9rC1u+HHNL8iQUlWk3Iqpnbd5er
         977NaGjtvQl66umYQwKAZQUlon5MOTtGDcnZ4g4mWMdfV0TrB6eC+6GOVbl2sEfL47pm
         plfz+OmI5CJk+85qcyLJQ6pCzhNCU5FZFLnXomGaiS0uX1WlVwqMTPT6mZoCl9/LGn6K
         w4rYF5CYgtvRIEJdtLc3QV0mRXfBaqP7aih0wLJvBY9cs8Q9VWrvhSTk8vmvn6FnCUYm
         8TIw==
X-Gm-Message-State: AOAM532MvUvNLADRaWkRK46cOSJfqL7bTVlFH0aJIxex4vq23lC5+94O
        BKnKuVxSOxmJ7cDQheKsFoA=
X-Google-Smtp-Source: ABdhPJyQ22XqaquBX7SkFD4fci4lP2Aj2mu7tN6mEIjtlLgUNQzMv8z2XN8Pz0ue5mXdw2tfOcEIew==
X-Received: by 2002:a05:622a:489:: with SMTP id p9mr11849434qtx.11.1643743674974;
        Tue, 01 Feb 2022 11:27:54 -0800 (PST)
Received: from [192.168.1.211] (pool-108-35-55-112.nwrknj.fios.verizon.net. [108.35.55.112])
        by smtp.gmail.com with ESMTPSA id d6sm10831464qtb.55.2022.02.01.11.27.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 Feb 2022 11:27:54 -0800 (PST)
From:   John Cai <johncai86@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Christian Couder <christian.couder@gmail.com>,
        git <git@vger.kernel.org>,
        =?utf-8?b?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Eric Wong <e@80x24.org>
Subject: Re: [RFC v3] cat-file: add a --stdin-cmd mode
Date:   Tue, 01 Feb 2022 14:27:54 -0500
X-Mailer: MailMate Trial (1.14r5852)
Message-ID: <674CD40F-7060-4892-97CD-1940AEF7C3D7@gmail.com>
In-Reply-To: <YflzZsb/txsopusP@nand.local>
References: <20220128183319.43496-1-johncai86@gmail.com>
 <CAP8UFD3sHvA3Gx9+d=VjQ11sEqWF47AEeo-m4bGsVO3OUJ4dLw@mail.gmail.com>
 <YflzZsb/txsopusP@nand.local>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Taylor,

On 1 Feb 2022, at 12:52, Taylor Blau wrote:

> On Tue, Feb 01, 2022 at 10:39:30AM +0100, Christian Couder wrote:
>> Also I think at this point this should probably not be an RFC patch
>> anymore but a regular one.
>
> I think that this is due to my first "review" in [1], where I tried to
> get an understanding of what John's concrete usage plans were, since I
> couldn't figure out what they were on my own.
>
> I'm not sure that I've seen a response along the lines of "we need to
> control when the output stream is flushed in order to do ..." yet, but I
> would be interested to see one before moving too much further ahead of
> where we already are.

This would be useful when there is another process A interacting with a long
running git cat-file process B that is retrieving object information from the odb
interactively but also wants to use --buffer mode.

In this scenario, if A is asked to retrieve a large list of object metadata, it wants to
use --buffer mode to be more efficient but it would need a way to ensure that all of the
contents have been flushed to the output. If we want to keep B running to save startup time
(since otherwise we might need to spawn many git cat-file processes), then having
a flush command where we can guarantee a flush would be very handy.

>
> (Apologies if such a response was written, and I missed it).

Nope, don't think I explained the need for a flush command very clearly.

thanks
>
> Thanks,
> Taylor
>
> [1]: https://lore.kernel.org/git/YehomwNiIs0l83W7@nand.local/
