Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CD97C54EE9
	for <git@archiver.kernel.org>; Sun, 18 Sep 2022 15:06:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229498AbiIRPGK (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 18 Sep 2022 11:06:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiIRPGI (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 18 Sep 2022 11:06:08 -0400
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96A4820BC6
        for <git@vger.kernel.org>; Sun, 18 Sep 2022 08:06:07 -0700 (PDT)
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-333a4a5d495so313514287b3.10
        for <git@vger.kernel.org>; Sun, 18 Sep 2022 08:06:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=S16mUQ/PKgvlzmECdxTO+lktZAICU5YxKomfqQjgsps=;
        b=YT+srJdx+ewAF5igPYIsTMLFObGaXHGzhI/cZOdPcajcJN434pX18m8C6ACsHl3EUs
         uZUFxAj/pRgyQkhrbf7PoGZAZayhcnwy375tWhV1oWvc2p+U+kLVdpgzqwCaRCzzLQYF
         4lGWp8F5Q3XBNdfFRm2UvNZQek3upePFA5MA9RxfkmFeqE1FFFqxDP3SveAAL/4BXpga
         y/tVsnnDdP+j/8HHl6OpO/DpPqGqT9iXFgzZrHKTRS8HeRRT8G2XPp8pB6ygpJtgybfK
         Rawx9XEbrwphNqySJ3kmQ0zVX/5VCaGwMiGdALD7oODfCzfiqzRsIsyBoMMRJfb/rVhi
         G10g==
X-Gm-Message-State: ACrzQf1MybTs42Zl2NYClpmrwfa4YYVKh3jpFHrWjDAIB98M3pE0HW8H
        hdJk0VdzCD29LRCo7qaFuurh02d9PKWVXTWfBy2I4J59
X-Google-Smtp-Source: AMsMyM5COuX2hPzFMI8LpbESCcGttWC5Af9q+YcHdnlzJKySXwI31w6Uv8j4cqFQP2G+FVHeiV0aj1Zion+z4am7aQA=
X-Received: by 2002:a81:be0b:0:b0:33f:213a:572e with SMTP id
 i11-20020a81be0b000000b0033f213a572emr11552308ywn.444.1663513566720; Sun, 18
 Sep 2022 08:06:06 -0700 (PDT)
MIME-Version: 1.0
References: <YyZWDkZWAkS7q+Wf@gmail.com> <20220918121053.880225-1-aclopte@gmail.com>
In-Reply-To: <20220918121053.880225-1-aclopte@gmail.com>
From:   Erik Cervin Edin <erik@cervined.in>
Date:   Sun, 18 Sep 2022 17:05:29 +0200
Message-ID: <CA+JQ7M8JX64M2m=+-NTnbRo64jy7_G=TYafj6UXv=R7UJo0vdQ@mail.gmail.com>
Subject: Re: [PATCH] sequencer: avoid dropping fixup commit that targets self
 via commit-ish
To:     Johannes Altmanninger <aclopte@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thank you for the explanation!

On Sun, Sep 18, 2022 at 2:11 PM Johannes Altmanninger <aclopte@gmail.com> wrote:
>
> Commit 68d5d03bc4 (rebase: teach --autosquash to match on sha1 in
> addition to message, 2010-11-04) made --autosquash apply a commit
> with subject "fixup! 012345" to the first commit in the todo list
> whose OID starts with 012345. So far so good.

I wasn't aware such fixups were recognized. The only way to create
such fixups is manually, correct?
