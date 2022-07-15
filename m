Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EF7DC433EF
	for <git@archiver.kernel.org>; Fri, 15 Jul 2022 20:50:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231406AbiGOUuC (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Jul 2022 16:50:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231286AbiGOUuC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Jul 2022 16:50:02 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDB3D90
        for <git@vger.kernel.org>; Fri, 15 Jul 2022 13:50:00 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id f9-20020a636a09000000b00401b6bc63beso3250367pgc.23
        for <git@vger.kernel.org>; Fri, 15 Jul 2022 13:50:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:subject:from:to:cc;
        bh=d5O317H74Ty3Y5mc+gR/3Ph3dBEPPNTfG4SZWjgcr/E=;
        b=eGBXnHxBcFlEDZtozOGEbjPSlfidg1eC4nPU1yWU+3Ll7uSnlMXu40pXFb2FEFJD3b
         Do2b1RmR+MAW8pVTC8kDyHOhbUsQmnHHrB4YLpfzUQdvlYERckIJYjzeJPrO7jr6TGMB
         qOqKqBroclf+XvmTUn8KHtA9b4r1naq1QJzJBcJnBQNTbkijg0v5EZK99P/FSj1KeTcg
         kavTsjtDxzbh60H7cPDMjyBxWhkT9bD/z0dVZ/r4peOK1n/XKyEXRBw/ohZfzXr+RGMd
         d2Jxy5lGnW07cvR2yjlyWY9+1CSO4NSJnKp8JIYqHlC8BpoNenxK0eZsPbz/OGmmUR/a
         HpRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version:subject
         :from:to:cc;
        bh=d5O317H74Ty3Y5mc+gR/3Ph3dBEPPNTfG4SZWjgcr/E=;
        b=0jhDO9rA5GZRhVB3lfWYB5V1/6tDhC6Ty13f0GA156PhauMhv6va7t+iLOz/LMGzgS
         /nyaCg/m0HvpBhgpbt4951dr0bXr7rYN1GpbFsMd3/bzGm1hPOYjNMJlpDsynUDxhS23
         ZpiaJ5MsyD3QVhkW1Hzb6cDLVejMK1dF+qkcOOARXLZtmCdoaSnWi270Gt0UadIxFx2H
         YpvmeaMtKL1JopRCQ88RZvbdhAQpJe0AphewbWm4lvHbFuG/uytZ3xwqV5HmvyhmKgo1
         ptIfMZ59rsPaTs5Aq7BIFrdHcP0pHaAAq63kzdJOjomLE0b9qn0GpYgLzKjhjA+i1ABm
         zOdg==
X-Gm-Message-State: AJIora9ABgFw+gIwZe4KY7mUY/aCgoHwdMtT8SZvaO7/nvxVMUnJUOPL
        jpIiRx+FWN7NcWLx8+qtDuNiCqikAMxsadtCUzIr
X-Google-Smtp-Source: AGRyM1sYb0HOTo//KIhBFFRKiK5el0Gju2AYmx/5gbthQ+d7vQEt78sgRQQYrDy/kWSx2tcapLTjch7rj2BnjOMnJHyq
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a17:90b:3d04:b0:1f0:d4c4:761 with
 SMTP id pt4-20020a17090b3d0400b001f0d4c40761mr9800069pjb.202.1657918200182;
 Fri, 15 Jul 2022 13:50:00 -0700 (PDT)
Date:   Fri, 15 Jul 2022 13:49:56 -0700
In-Reply-To: <xmqqfsj2yw6b.fsf@gitster.g>
Message-Id: <20220715204956.2927778-1-jonathantanmy@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.0.170.g444d1eabd0-goog
Subject: Re: [PATCH] fetch-pack: write effective filter to trace2
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Jeff Hostetler <git@jeffhostetler.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:
> Jonathan Tan <jonathantanmy@google.com> writes:
> 
> >> >> This is implemented for protocol v0, v1, and v2.
> >> 
> >> Is that different to say "for all protocols"?  I am wondering if it
> >> is worth saying (unlike in a hypothetical case where we do not
> >> support v0 and v1 we may want to state why we only support v2).
> >
> > I wrote it that way to avoid confusion with things like HTTP (which is a
> > protocol, at least in its name). Maybe better would be "This is
> > implemented for all protocols (v0, v1, and v2)".
> 
> I still wonder if it is better left unsaid.  When adding a new
> thing, it would not be noteworthy if the new thing is available no
> matter what protocol is being used, no?

I was thinking that a reviewer would think "why is this done twice" and
wrote this comment to answer this issue in advance, but it makes sense
to just remove it. OK - I'll do that.

> > My intent is to report what is being sent to the server in the fetch
> > request.
> 
> Then I'd be OK with a design that reports "none", if we send "none"
> to the server in this case.  If not, then I do not think we should.
> 
> Perhaps report an empty string or not reporting at all?  After all,
> the reader knows the client version and capability in the log so it
> is easy to tell between 'no filter was used' and 'too old to report
> the filter', no?  I dunno.

We don't send "none" to the server. If an empty string is OK then I'll
use that, since it will make it slightly easier for analysis since we do
not have to check against the version (and also to know which version
has support for this feature). But I'm OK either way.
