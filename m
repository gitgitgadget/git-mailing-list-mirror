Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EA85C6FA99
	for <git@archiver.kernel.org>; Fri, 10 Mar 2023 16:32:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbjCJQcL (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Mar 2023 11:32:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230201AbjCJQbu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Mar 2023 11:31:50 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 567DE763F9
        for <git@vger.kernel.org>; Fri, 10 Mar 2023 08:29:03 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id me6-20020a17090b17c600b0023816b0c7ceso10409270pjb.2
        for <git@vger.kernel.org>; Fri, 10 Mar 2023 08:29:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678465736;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8JumEHAB/3WsoSUAkZ3IF8++qLl/qXNK4Q6aQ2aA2uE=;
        b=cxOjyCuRzGYNCSAhvNy62XwvDZJiKs24ms1spd8CE1v1XyHNELZ9Get5a8t92ASSrm
         OOsZg5dH+rWG9mNvrzb2b/rTDgjrW47h61vg0E4l2pt7A0qiF+WbHdIGVAmwBj4eceLC
         0cwvib+4/AD0jfWnmVYy+MkCDCoNZ/bDatPu3ixVJGGakD3ocIXcba47rm5ZPqJRfViu
         /Sdpb38/de0M5HT0I4k7+hKh2e63BsgJoWGQ6b9kJ3vpwnHv0e+X4pwSRxfRFQN+uptS
         PolQ9ihDW5XV3u5/mqjyVjwV7IMHhJPeZcZpSevTI3a4iA0NFelLBqVCMPernZE7lu3p
         Pt8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678465736;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8JumEHAB/3WsoSUAkZ3IF8++qLl/qXNK4Q6aQ2aA2uE=;
        b=RSD1KWQ9eZoVlv0rEa3iBY4cP4zbi+bQ6cSOuWQuL46/PAKjDc2OnKR9bqvVYWMTWK
         mTKbKbWfUebOritOEnMKns2iFi0dPg7nUTMVKBWPihbZoOFGvnj6uRVlfjUwUUdVqj2h
         6/CZhRcS7HX+KeQjZ7wxFgWGGEKh82QjJ3smEUhPux3p/E4UbJzH68pVNqI/WNtyUHnR
         yuJKjgV9ORibmP7L8dhqV4Zj4YTxJCfzdJjDqsb0tRPJAVCw+ADElLBOuUDZmab93s1m
         gMypFY50paOgApgE26bpJY7FwAa5ZiKNE8aevZemOIygM9kptGIzmXLJnY+UEQWmrCaP
         syQQ==
X-Gm-Message-State: AO0yUKWmt+Pg8FQHV/Pk9tjxkIhFl1FJwo07ZMjzRq4ltHnVOKaZWLrv
        15MuhvdBSqhUJU54+Q9xMwE=
X-Google-Smtp-Source: AK7set9TwwJdGwL744aX+wQVTZuDynQS++/vv7a/ILSLs2bAV3zPIMjzPczJjIDVnFTGWIOYXJgD6g==
X-Received: by 2002:a17:903:11c8:b0:19f:1bd9:505 with SMTP id q8-20020a17090311c800b0019f1bd90505mr382901plh.36.1678465735864;
        Fri, 10 Mar 2023 08:28:55 -0800 (PST)
Received: from localhost (83.92.168.34.bc.googleusercontent.com. [34.168.92.83])
        by smtp.gmail.com with ESMTPSA id kd3-20020a17090313c300b0019acd3151d0sm227595plb.114.2023.03.10.08.28.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 08:28:55 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Alejandro Colomar <alx.manpages@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: Better suggestions when git-am(1) fails
References: <897c200c-afb3-ceb4-bf44-9af651f5feb4@gmail.com>
        <ZAlPtxZ/0Z28r5tF@coredump.intra.peff.net>
        <xmqqedpxq4if.fsf@gitster.g>
        <ZAr6vIOe3WbTIohE@coredump.intra.peff.net>
Date:   Fri, 10 Mar 2023 08:28:55 -0800
In-Reply-To: <ZAr6vIOe3WbTIohE@coredump.intra.peff.net> (Jeff King's message
        of "Fri, 10 Mar 2023 04:39:08 -0500")
Message-ID: <xmqqh6us7epk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>   1. I feel like "-p1" was pretty standard even before Git. You'd
>      extract two copies of the tarball, one into "foo-1.2.3" and one
>      into "foo-1.2.3.orig", and then "diff -Nru" between them to send a
>      patch.

I would too, but then we wouldn't have accepted the request to add
.noprefix configuration; I do not recall where it came from.

>   2. It feels weird that a maintainer who isn't using Git would expect a
>      lot of contributions from folks who are. And even weirder, that
>      they would insist that all of the folks sending patches set
>      diff.noprefix.
>
> So I won't say it's not possible (especially in some closed community).
> But I'm skeptical.

The scenario I would find more likely is a project established long
before we were popular wants to keep using -p0 even after switching
to use Git.

> All that said, if "apply" and "am" could automatically figure out
> and handle "-p0" patches, that would be a useful way to help
> people.  I'm just hesitant because it probably involves some heuristics.

I am not all that interested in that direction, for exactly the same
reason as I are heditant. Such a tool that outsmarts users will
eventually bite them.

> Yeah, I am as always a little concerned that one person's fix is another
> one's regression. But it really just seems to that on balance people set
> diff.noprefix with no thought at all to how it would affect format-patch
> (in fact, I'd guess 99% of Git users do not use format-patch at all).
> And then they are surprised (or worse, the receiver is surprised) when
> it doesn't work.

For these 99% users, if format-patch paid attention to their
diff.noprefix and used -p0, the world would become even more
interesting place.  I am not sure this particular cure is an
overall win.  And as you mentioned elsewhere, a change that is
deliberately designed to be breaking like this does not become
much safer by cooking in 'next', which is another sad thing.



