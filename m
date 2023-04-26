Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B24D0C7618E
	for <git@archiver.kernel.org>; Wed, 26 Apr 2023 18:54:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235095AbjDZSyj (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Apr 2023 14:54:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbjDZSyi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Apr 2023 14:54:38 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B65417EC0
        for <git@vger.kernel.org>; Wed, 26 Apr 2023 11:54:37 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id 98e67ed59e1d1-246f13f35f1so4132545a91.3
        for <git@vger.kernel.org>; Wed, 26 Apr 2023 11:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682535277; x=1685127277;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ozeAEC4ya155VGNkYOpWPcpG/TNwZ3NrAUh2QEO88mk=;
        b=JHJ0c+aLz05HlG9c+qWd8vYveBO0UE2r+1P/MhTqUGTLNu82m0zixCFTid6ABsl30A
         5Ek8k1sXnfQ8XLEYlt8EfbWWvSlM5nscigYgqBGja4n9RJCpchFisxlLnjqH2eCYT390
         RHp5URiwNDmPYu+NbKIxZca6sQ5PVg35qlMkPlrGPpG1JI81eNKI4KP6D5XZjr26cbYm
         FYFhYKe2K0RvOYQ//BZWL8ykvvNVSK2GTCEZhItq38bpURIWlbM12HcHFCnmwSZo0biE
         tc4nwvT2xKSh8/ItHzRcpl+r4+uP80JoQekIsH46z46G1oNvXT0ij98qdfUEw0eHljV0
         3spg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682535277; x=1685127277;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ozeAEC4ya155VGNkYOpWPcpG/TNwZ3NrAUh2QEO88mk=;
        b=IfypsCddvpcm6BMSQ89PtVdhx+RHCCsMQpvISJNUyYegNSbbiFHFOcZaqU6wjBPhHe
         pHufNvoWAPRBlJ5HMAHj6h2aRjYBtdV5psr6XWZJvJXo5+dGdD6Z6uDXB0jQluKQ9Z5p
         KpkjZfXjabGgsmWV2C0qIVJQ6UBi8wF/K5QGqAYzol+zbsrlfW1+5cifHewCMuH3ADWq
         jwAH9x+x15YEzZ9sdhmTTZdHvo+AAY6yHJ4zGQSbaOB/hoM3cPd4zb/BmFoRoVygBw1S
         afW3chUQnykUqoF4BLwRwgqgw12y9Uy15QnBWjM6P8jTT/QfuIXaDlU5UErKWm299w7S
         givA==
X-Gm-Message-State: AAQBX9f7ODHs3xYpF9tiDkA6CA49LoB7yu29H0CAJUF6hsl4ukF/WYfL
        nuDTOpPHuhrpjor7pLBfjPMiG1iPsmGCSQ==
X-Google-Smtp-Source: AKy350b1GZfaLhXSph+dGjQmQtL7gCVy0JXtZyo2ojFxUuVKbch81ez0voDZHCg/dSLzi1BF+EQKwu4X4eJB+A==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3a07])
 (user=chooglen job=sendgmr) by 2002:a17:90a:3fcd:b0:247:11e6:f6ff with SMTP
 id u13-20020a17090a3fcd00b0024711e6f6ffmr5348937pjm.3.1682535277221; Wed, 26
 Apr 2023 11:54:37 -0700 (PDT)
Date:   Wed, 26 Apr 2023 11:54:35 -0700
In-Reply-To: <cover.1681906948.git.ps@pks.im>
Mime-Version: 1.0
References: <cover.1681906948.git.ps@pks.im>
Message-ID: <kl6l8reeo4no.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: [PATCH 0/8] fetch: introduce machine-parseable output
From:   Glen Choo <chooglen@google.com>
To:     Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Patrick!

Thanks for the pleasant read! I thought this was a great topic for
Review Club. It's too bad that we missed you, but we post all relevant
feedback here anyway.

Nevertheless, if you'd like to see the meeting notes, you can find them
at:

https://docs.google.com/document/d/14L8BAumGTpsXpjDY8VzZ4rRtpAjuGrFSRqn3stCuS_w/edit

Patrick Steinhardt <ps@pks.im> writes:

> Parsing the output of fetches is mostly impossible. It prettifies
> reference names that are about to be updated, doesn't print the old and
> new object IDs the refs are being updated from and to, and prints all of
> that information in nice columns. In short, it is designed to be read by
> humans rather than machines.
>
> This makes it hard to use in a script way though, e.g. to learn about
> which references actually have been updated or which have not been
> updated. This patch series intends to fix that by introducing a new
> machine-parseable interface:
>
> ```
> $ git fetch --output-format=porcelain --no-progress
>   fff5a5e7f528b2ed2c335991399a766c2cf01103 af67688dca57999fd848f051eeea1d375ba546b2 refs/remotes/origin/master
> * 0000000000000000000000000000000000000000 e046fe5a36a970bc14fbfbcb2074a48776f6b671 refs/remotes/origin/x86-rep-insns
> * 0000000000000000000000000000000000000000 bb81ed6862b864c9eb99447f04d49a84ecb647e5 refs/tags/v6.3-rc4
> * 0000000000000000000000000000000000000000 83af7b1468c0dca86b4dc9e43e73bfa4f38d9637 refs/tags/v6.3-rc5
> * 0000000000000000000000000000000000000000 ab3affb8ed84f68638162fe7e6fd4055e15bff5b refs/tags/v6.3-rc6
> * 0000000000000000000000000000000000000000 1c8c28415e8743368a2b800520a6dd0b22ee6ec2 refs/tags/v6.3-rc7
> ```

Having machine-parseable output seems like an obviously good goal to me.
The finer points of the interface and output format are worth
discussing. I'll do so in the patches themselves.

Overall, I found the series very well-structured and easy to follow
along. Thanks.
