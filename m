Return-Path: <SRS0=NddV=BZ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85DC8C433DF
	for <git@archiver.kernel.org>; Sat, 15 Aug 2020 21:57:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6678B22BED
	for <git@archiver.kernel.org>; Sat, 15 Aug 2020 21:57:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qDvZqOQ6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729465AbgHOV5I (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 15 Aug 2020 17:57:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726545AbgHOVwJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Aug 2020 17:52:09 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78132C061360
        for <git@vger.kernel.org>; Fri, 14 Aug 2020 19:32:03 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id p18so6240081ilm.7
        for <git@vger.kernel.org>; Fri, 14 Aug 2020 19:32:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ncQEwzP0Z5L67Czjzdq7X91utuuWEomfB7OaW0VLbn4=;
        b=qDvZqOQ6UZ3z0adxO89iFPPmdtQu7CWC79M1JxmEFfd4XxjAn3vLBsjwdHGC+KIpMt
         2CPUYR5x01uMnQdC7hL4YBVTn3X+jPUUBUIVO9nm4Hut56rHK59j5BLwTgkKKmgUDalb
         hDjjLwKBjaLWCWlQ9XaLpMZUG/UiKlCKYyytihb34XaA1x4vMs48vGLze41/YYvDvL0C
         KhPpwxMJF7sU+QXS0AMHPMfgS6M86IBvX5bjFDrPw5ZLYH+Wlh60zO3syUkeZiKpL6/Z
         rpKTQEZ38/o6+frRXQhz/RYnw6MoT+7yB4+7rHNLnsMgcRyc7GcsIuxtnxzbA9WPRHcq
         NUfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ncQEwzP0Z5L67Czjzdq7X91utuuWEomfB7OaW0VLbn4=;
        b=mINbCQU02v6STgdu+cbpQPnxx57EQ995GWo4j96t+X/jIc0F/beBzk/xn/kROwMN07
         c1reUCldlnogYX6tQztU3TEVfb+lhpTtZdMzdZlB9zf4vk1gbd6dv2tRnJ9crKBwlKcY
         9tjDKe3uGJDngSqhAirJnJy8C9UnSDy6hLJkuwiVN15Vze1EO9ctoRQXPUcbJfaWu8B5
         xcCxK+i0rhHBfQgyNDuGRrHH5tanWZKs1v6IyFElco0vWjPNO9lwnZWstRrFkxfK5Ru1
         tnnUI+xpff3DFPRK5AVfJj/oS+1+Q7b7o3fyNjJ3ZPQoqH2gBZ/j8aAWkyhIWzEbB5DG
         v+rA==
X-Gm-Message-State: AOAM530Xw/fVgLeWQoDiIKV/j5pAIvn205hgxRjVLK56LiGYlcKih04H
        W40p0/tATkPuwHKqgiW/8cvGGZIpKLyowOxch060ehr//cgWDMRM
X-Google-Smtp-Source: ABdhPJzbz8LV//e8Y9Q6e4knDWjbVB1Rq/J6ewW7J4TnMn4VpHpVmu8049CMtyeFCDuArFIvLzr636dkbmY9Jb/TaWM=
X-Received: by 2002:a92:c74b:: with SMTP id y11mr5060251ilp.264.1597458722234;
 Fri, 14 Aug 2020 19:32:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200814145344.2413-1-danny0838@gmail.com> <xmqqbljdxgkh.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqbljdxgkh.fsf@gitster.c.googlers.com>
From:   Danny Lin <danny0838@gmail.com>
Date:   Sat, 15 Aug 2020 10:31:43 +0800
Message-ID: <CAMbsUu6WnHori2t1qG=6UVLWDNEw5FSXeTd-K6WKnpZi5h6q+w@mail.gmail.com>
Subject: Re: [PATCH] Remove "unsure" for --message in subtree doc.
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git develop <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sorry, I missed that.

Further investigation suggests that it works with 'split --rejoin' and
has nothing to do with 'push' (actually, push never generates a merged
commit at all).  We can rephrase for that.

Junio C Hamano <gitster@pobox.com> writes:
>
> Danny Lin <danny0838@gmail.com> writes:
>
> > It is definitely clear that --message is valid for add, merge and pull.
>
> If it is also definitely clear that it is _only_ valid for those
> three, then the change is good.  I do not know if that is true
> offhand, though.
>
