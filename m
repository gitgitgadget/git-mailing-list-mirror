Return-Path: <SRS0=/7R8=BN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71C9DC433E0
	for <git@archiver.kernel.org>; Mon,  3 Aug 2020 23:52:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C35320775
	for <git@archiver.kernel.org>; Mon,  3 Aug 2020 23:52:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UU9ROmqu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728541AbgHCXwP (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Aug 2020 19:52:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726757AbgHCXwO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Aug 2020 19:52:14 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA188C06174A
        for <git@vger.kernel.org>; Mon,  3 Aug 2020 16:52:14 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id l60so995448pjb.3
        for <git@vger.kernel.org>; Mon, 03 Aug 2020 16:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=CpDH3LxBInC02kwAoOoTPw8+6oP4P0XEZht5kPF1/Lw=;
        b=UU9ROmquz1HZqPCuCx3n6Qd4uBagFgW/1rTsbI06ns7g5Xu49VOR5DRGf7HIwMmswZ
         /BaX+WbKmYwK7EZDk4Dl7fi3s1wYQiXiUtE1SIv+RL3BxBGfo8B0bYlHwEb5794juNlG
         CVPM3ZFIUcywFJxSgdB9zPnxBSiBUe2hFkZb508ke89H7jM3cjwx/wQ6fCxejhwpjGg+
         bKszLM5VEo1mNCOXMWb50hwyvZv4576IuSCejfNUGB5jyArPfOkU4EQlxFV2oTuaV6bg
         lzcwps0pokh6WJq+tnksMXbUnR2HHk1L6CoP7e+i1mkyM4Pve0V0kZ5RK+ZBRuuCCE/X
         p/Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CpDH3LxBInC02kwAoOoTPw8+6oP4P0XEZht5kPF1/Lw=;
        b=WsHZThMnrIvmFXoWjx0UIylg3Phxy0RyA//AaDn1pTAaZ9nZqvbeaYdzUzJ/H2ZK6H
         zRGAFbVZyOvVJAQDNiUsoqjlVVbxGUlefd0gV+YrFw/rCucfPZ/0HC3oIOKo1frNeRKR
         LuVdQ/rMPBbMjmw19gtervksS17u4AxC5q7cPTrZr/lUKbx1XHbMhojI5rsH78NYqrC9
         6UbOa9XSyF4QDJXEr+QoYYOD6pBWWCmC4iCzr+iec+4DwobRXq21uOp0OtSugBBMpKiX
         /ROh6HdiPGINrndi+Q/l3LTodA8ZcBX0dKIkJhaxBhdwZYK5G15ecQrQ4DC9WyIP+dD8
         f/yg==
X-Gm-Message-State: AOAM532ERcMpQbcqyCtNxqd+j9eU4dTj5pEKRqwVd+k4RZfOFvSKGEhx
        nZ0D7M+04wKjR9ZbGDxRsmI=
X-Google-Smtp-Source: ABdhPJx+wkTYPDtKvac9NgpB9uh+rvU2JSuW41iuBz7WUt9F9Eg+kVG08FVPSzIgsXCWdKwOLTdhqg==
X-Received: by 2002:a17:90b:283:: with SMTP id az3mr1714920pjb.10.1596498734192;
        Mon, 03 Aug 2020 16:52:14 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:a28c:fdff:fee1:cedb])
        by smtp.gmail.com with ESMTPSA id n13sm544973pjb.20.2020.08.03.16.52.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2020 16:52:13 -0700 (PDT)
Date:   Mon, 3 Aug 2020 16:52:11 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Johannes.Schindelin@gmx.de,
        sandals@crustytoothpaste.net, steadmon@google.com, peff@peff.net,
        congdanhqx@gmail.com, phillip.wood123@gmail.com,
        emilyshaffer@google.com, sluongng@gmail.com,
        jonathantanmy@google.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v2 01/18] maintenance: create basic maintenance runner
Message-ID: <20200803235211.GC58587@google.com>
References: <pull.671.git.1594131695.gitgitgadget@gmail.com>
 <pull.671.v2.git.1595527000.gitgitgadget@gmail.com>
 <63ec602a07756a41f8ccddd745562c567a4b3ed7.1595527000.git.gitgitgadget@gmail.com>
 <20200729221905.GB519065@google.com>
 <5cbdb559-3897-961f-4dd3-0bab11848c5b@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5cbdb559-3897-961f-4dd3-0bab11848c5b@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee wrote:
> On 7/29/2020 6:19 PM, Jonathan Nieder wrote:

>> Perhaps this is suggesting that we need some central test helper for
>> parsing traces so we can do this reliably in one place.  What do you
>> think?
>
> I'm specifically using GIT_TRACE2_EVENT, which is intended for
> consumption by computer, not humans. Adding whitespace or otherwise
> changing the output format would be an unnecessary disruption that
> is more likely to have downstream effects with external tools.
>
> In some way, adding extra dependencies like this in our own test
> suite can help ensure the output format is more stable.

I've discussed this a bit more at [1]: I do think this is output that
we cannot promise to keep stable.  Can you say a little more about why
extracting a helper would be problematic?  For example, would doing
that in a separate patch at the end of the series be workable for you?

More generally, one theme I'm sensing in the responses to the code
review comments I sent is that the series may have gotten too long to
be able to easily amend the beginning of it.  To that end, I'm happy
to make a reroll or make this easier in any other way I can.  This
also suggests to me that it may make sense to split off an early part
of the series and get that into a shape you're comfortable with before
rebasing the rest of the series on top as a separate topic (a tried
and true method, used recently for the "git bugreport" command, for
example).

Thoughts?

Thanks,
Jonathan

[1] https://lore.kernel.org/git/20200803231745.GB58587@google.com/
