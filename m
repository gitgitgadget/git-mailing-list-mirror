Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75B92C433E9
	for <git@archiver.kernel.org>; Tue, 22 Dec 2020 22:25:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4EE49207B6
	for <git@archiver.kernel.org>; Tue, 22 Dec 2020 22:25:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728151AbgLVWZ0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Dec 2020 17:25:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728144AbgLVWZ0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Dec 2020 17:25:26 -0500
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9909C0613D3
        for <git@vger.kernel.org>; Tue, 22 Dec 2020 14:24:45 -0800 (PST)
Received: by mail-qv1-xf33.google.com with SMTP id 4so6757780qvh.1
        for <git@vger.kernel.org>; Tue, 22 Dec 2020 14:24:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dinwoodie.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5XvchChnQh8pq3T9HvuYMTVBLQsksDb84hyLD8Ob53Q=;
        b=AdAFqm7yO6PoyysFDOIdtg62l3r/DEH92qslqwdrWg5NuH9cFc9TPcaYw+dg/iwLfD
         uC4OUh5EG8mdu80GSWMURFyJTmd8saHzozOHJe5ukub+PBumZm4HayxjxZcprDPcLyzx
         fcu0PpAYR2K/V5/wF92X+gc9i5gFEA32hyB9E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5XvchChnQh8pq3T9HvuYMTVBLQsksDb84hyLD8Ob53Q=;
        b=fruX7nIQUKtnmpZQfVeG8mRVeXppaZLcoL+/eBHL3oq8lkSLNLGnbuEH+H+/0n4Hx2
         6HlAqgqEupDQAHHW8ZuSsVfoXQpxPg1lDVGQXzAWF54xHYaFxngN+WI3+xfSj1X2a5tu
         +Sy9hhlRI2MuKnHAn2y4SxH+nGv36Nk149+iyN31bwbKjwxYEnZ316n342+6O36D0Hm5
         9zyQnA/KdBTzn3uXQmrQAg4B75fb2GFBafACXhKTZx0DYajrqkoW8E+JjpOvi4Go9H3p
         3WXb+P2pcBQPLQyyA9MKnYpoGjGYBgSmG9rUq1yCrWCUaauVfvqGZZtsEf5rX8VyXgro
         3ssQ==
X-Gm-Message-State: AOAM532i78qDIIp7Jl+zc27XYZ/n608xrABWQLGuNUZn5Pprml+E5m81
        JTzPhCHscUlUXSkm8fs65A+Up56f5wx/Q6VCGur8cg==
X-Google-Smtp-Source: ABdhPJzhpb9ShPg7f9GQhAkQbFQV6WRieKS+PMQZSsVwAtoxKtfDMWFIwPaqd3/gNeLUJdJ0hBKjfpOTmIpZ2bcqrwA=
X-Received: by 2002:ad4:45a9:: with SMTP id y9mr24131106qvu.15.1608675884586;
 Tue, 22 Dec 2020 14:24:44 -0800 (PST)
MIME-Version: 1.0
References: <xmqqpn3tqugm.fsf@gitster.c.googlers.com> <3f0403b84ab06b9deb7c5c189792bebe1db586a7.1606866276.git.matheus.bernardino@usp.br>
 <CA+kUOamDD_SDNLk3sPSwNAojrAAP+g38MjkfG4JMPRTGOVAKAQ@mail.gmail.com>
 <87y2ht4pfr.fsf@Rainer.invalid> <CA+kUOam3h859kK76QuS9OFojeavXO15JNpinUQ0vPrAXrcsCoA@mail.gmail.com>
 <87pn354ijn.fsf@Rainer.invalid>
In-Reply-To: <87pn354ijn.fsf@Rainer.invalid>
From:   Adam Dinwoodie <adam@dinwoodie.org>
Date:   Tue, 22 Dec 2020 22:24:08 +0000
Message-ID: <CA+kUOamSd_3z8LbYt8QRx==HauYXoCe95B5hAW1W-LdnwGP-xw@mail.gmail.com>
Subject: Re: [PATCH] apply: don't use core.sharedRepository to create working
 tree files
To:     Matheus Tavares <matheus.bernardino@usp.br>,
        Git Mailing List <git@vger.kernel.org>
Cc:     Achim Gratz <Stromeko@nexgo.de>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Cracked it, and it's a simple error in the test script. It wasn't
readily obvious because the error gets silently swallowed, and
presumably because the command isn't necessary on most *nix systems
that have different behaviour for inheriting permissions, but the
entire problem is fixed with the following diff:

--- a/t/t4129-apply-samemode.sh
+++ b/t/t4129-apply-samemode.sh
@@ -78,7 +78,7 @@
        test_config core.sharedRepository 0666 &&
        (
                # Remove a default ACL if possible.
-               (setfacl -k newdir 2>/dev/null || true) &&
+               (setfacl -k . 2>/dev/null || true) &&
                umask 0077 &&

                # Test both files (f1) and leading dirs (d)

It looks like the erroneous line was copied from t0001-init.sh, but
that's a test where "newdir" is actually an existent directory, where
we never use a directory of that name in this test script. A more
likely candidate in the circumstances would have been
t1301-shared-repo.sh, which does call `setfacl -k .` as part of its
setup.

I'm assuming this is a simple and obvious enough fix that it can just
get squashed into the original commit, but I don't know if that breaks
things given the original commit is now included in rc tags. Let me
know if I need to format and submit this as a full patch?

Adam
