Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6C5E020281
	for <e@80x24.org>; Fri, 29 Sep 2017 20:21:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752123AbdI2UVc (ORCPT <rfc822;e@80x24.org>);
        Fri, 29 Sep 2017 16:21:32 -0400
Received: from mail-pf0-f169.google.com ([209.85.192.169]:48432 "EHLO
        mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752003AbdI2UVb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Sep 2017 16:21:31 -0400
Received: by mail-pf0-f169.google.com with SMTP id n24so346923pfk.5
        for <git@vger.kernel.org>; Fri, 29 Sep 2017 13:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OUUssSIbDRalTViulA9aj8bmegGbil3UXyYv+T8UBX4=;
        b=IQoEsWEyC8gdWRfos2Ub1fuLo+02NHOeHS5w4kVKDSVpeVHk8oy9XVvPIjO4A8YNgT
         byoMWjFHnKz1Pk2CXiOflmBbkY21EhWkXddin8sxwRePLyoT1E1FCTpZPj+OfXMq+HoW
         Y8fIr3LFIMaIE4T3bqSewmfNIQ606fQaT2OW+4ePm7loGKz7xw+M5U3jOyCDrZMCND1G
         xkTF82EgmedUQBSVOTTGftaf60Ga0v++SrasuteoAL7bSAO8dhVMtIGZxv9uCxiYhoLI
         W2GtYjSGJenYIp9CanLMS+3bIqKE6VsrelLIqhksZpUlo70pLXBoYV0gD6NwHqjQuBPZ
         7QMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OUUssSIbDRalTViulA9aj8bmegGbil3UXyYv+T8UBX4=;
        b=PTZkmEOz013udhX3VxLJd1kdqcpCeYovlis63oJt90ndkbiTvkDbwe0ZuLXcrrKmjE
         kq8HJMM+48Mn9bI4ta9ecCJC4RqknkQnaqYXIfVRfokVyUb8JLpqrUUMttgHN8Ko9731
         GT24y0uFc4UjMqHv1GLbPatlK/QUhS2T5AS/Tli3g/ozE+dBPBmob2J4mccXR43qfhnR
         mLHvu2B0SkIsDbs95n+TVkLzg+PvA9bUSd96N64Gfj9L+Ps5jqzsiAzRCTal3xbu5Cp7
         Vb0XgBsTH0GJxjXFqpbjCJuXOVBHN0NZZncnCOzs8THYwiaJJPzk6fr1pSuYL9JFC8/9
         7G9Q==
X-Gm-Message-State: AHPjjUjrOAEMQcqOkvq0oFldB49xg7tMMDgxNzp16WufGvOkPDjse13F
        rC0Nyo6tbnm3rH0Hlvp5RvvSsA==
X-Google-Smtp-Source: AOwi7QAcOUFGGbMpqWezH0F/axApfQRra9ETrjZM5RUcoszmLnKIq3JKiN6XfIDz+xu22+N3IvSTqA==
X-Received: by 10.98.198.78 with SMTP id m75mr8890864pfg.76.1506716490188;
        Fri, 29 Sep 2017 13:21:30 -0700 (PDT)
Received: from twelve3.mtv.corp.google.com ([2620:0:100e:422:95f1:13e:dc22:c4e5])
        by smtp.gmail.com with ESMTPSA id k25sm6967483pgf.13.2017.09.29.13.21.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Sep 2017 13:21:29 -0700 (PDT)
Date:   Fri, 29 Sep 2017 13:21:28 -0700
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     Jeff Hostetler <git@jeffhostetler.com>, git@vger.kernel.org,
        peartben@gmail.com, Christian Couder <christian.couder@gmail.com>
Subject: Re: RFC: Design and code of partial clones (now, missing commits
 and trees OK)
Message-Id: <20170929132128.3071d469cd8f80a86ce6b680@google.com>
In-Reply-To: <c3245fd2-cff4-0266-37e9-35b307e0357b@alum.mit.edu>
References: <20170915134343.3814dc38@twelve2.svl.corp.google.com>
        <e6259d03-e904-8c57-73b0-2434939fba71@jeffhostetler.com>
        <20170921154214.0d2ac45f@twelve2.svl.corp.google.com>
        <c3245fd2-cff4-0266-37e9-35b307e0357b@alum.mit.edu>
X-Mailer: Sylpheed 3.4.1 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 26 Sep 2017 17:26:33 +0200
Michael Haggerty <mhagger@alum.mit.edu> wrote:

> Maybe naming has been discussed at length before, and I am jumping into
> a long-settled topic. And admittedly this is bikeshedding.
> 
> But I find these names obscure, even as a developer. And terms like this
> will undoubtedly bleed into the UI and documentation, so it would be
> good to put some effort into choosing the best names possible.

Names are definitely not a long-settled topic. :-)

I agree that naming is important, and thanks for your efforts.

> I suppose that the term "promisor" comes from the computer science term
> "promise" [1]. In that sense it is apt, because, say, a promisor object
> is something that is known to be obtainable, but we don't have it yet.
> 
> But from the user's point of view, I think this isn't a very
> illuminating term. I think the user's mental model will be that there is
> a distinguished remote repository that holds the project's entire
> published history, and she has to remain connected to it for certain Git
> operations to work [2]. Another interesting aspect of this remote is
> that it has to be trusted never (well, almost never) to discard any
> objects [3].

Yes, that is the mental model I have too. I think the ordinary meaning
of the word "promise" works, though - you're not working completely on
things you have, but you're working partly based on the guarantees (or
promises) that this distinguished remote repository gives.

> Personally I think "lazy remote" and "backing remote" are not too bad.

I think these terms are imprecise. "Lazy remote" seems to me to imply
that it is the remote that is lazy, not us.

"Backing remote" does evoke the concept of a "backing store". For me,
the ability to transfer objects to the backing store to be stored
permanently (so that you don't have to store it yourself) is an
essential part of a backing store, and that is definitely something we
don't do here (although, admittedly, such a feature might be useful), so
I don't agree with that term. But if transferring objects is not
essential to a backing store, or if adding such a feature is a natural
fit to the partial clone feature, maybe we could use that.

> [2] I haven't checked whether the current proposal allows for
>     multiple "promisor remotes". It's certainly thinkable, if not
>     now then in the future. But I suppose that even then, 99% of
>     users will configure a single "promisor remote" for each
>     repository.

It does not allow for multiple "promisor remotes". Support for that
would require upgrades in the design (including knowing which remote to
fetch a missing object from), but otherwise I agree with your
statements.
