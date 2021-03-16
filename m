Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCBA6C433E0
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 01:03:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7CD7164EB9
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 01:03:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234098AbhCPBDM (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Mar 2021 21:03:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231703AbhCPBCx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Mar 2021 21:02:53 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86689C06174A
        for <git@vger.kernel.org>; Mon, 15 Mar 2021 18:02:53 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id n9so20549419pgi.7
        for <git@vger.kernel.org>; Mon, 15 Mar 2021 18:02:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=UOsk5AZDDSlefhSwCNhIame9WamSw8IarNb160tKXo8=;
        b=fVmRLbuKmbfJ8eDjbzxbVMDbI1bylmBOnhAB2/PeIMnq/1CzrACN9EaIhGe5x8E7qK
         9ofij9FGf9Y5H4/rA/z2evZmR6NGMLc9EX+iRqEXMFPDISkLAOAUrLPLQpTanbpGH7wl
         Jdp3O5YWgtou7RvuS+rhL/KN3lp7VIsDPKgx83svIDrhvHG/X9BPBx0/iRRfDjQzKN9/
         MgKlJ7CgBYffo89gcdkPuaEXc8JecrmBko+MFxSss2TEO3HoFJ7Ij3FtWyiOVdxYYhb4
         q89h+D1nBykwtiDJkYjn+L4huksJC8WiGinaqG6ZmxQUeaXssypeE7TLg+AWSHnwEYLi
         l5zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UOsk5AZDDSlefhSwCNhIame9WamSw8IarNb160tKXo8=;
        b=YdeHO8NLwIWhoO1rsIFv9W7FOIpVXgZ8pdrdsmWPAaDaS954ispjHN0d0ytrrXFQhU
         d9DUGele6jX6UJEL9twD8r1E8fq3gu3VAAQaeDzQ9BUYfYGyrj8uINBhis47eOBv/AQL
         X1pe0HvI7EgMHXWAFjGtrw4BNmgZJyh/yi3nS0OUFmIUHa3EWtSd/xpX3iC8C9o3quoY
         kCZHE6hzLZQqKYJstRO/yrTPc1G5zO0M4fLYiJwaFvjKN9T44+YsErlJkEyCXwzWbayX
         DCTKm6HCOf6b/lvzehpQ012OJkv6wi8THqyjX0ixFT3T6O+rRruXwLcQVcpuh0ntHVKF
         9DFw==
X-Gm-Message-State: AOAM533Zz3jaqIkqZ7b8RFTBMQADmQojp0u393iqUVkv4v2ejbRx+rMK
        yk8fkwgb7IdFsGgvQWX86uWAONyEiUA=
X-Google-Smtp-Source: ABdhPJxnwE7zG+EPeyQ7i2i9dtdHh6QELqu0pHSQgcIrisuJTvEeoA8eiqAU7je7sdk1zg6302TkHg==
X-Received: by 2002:a63:7885:: with SMTP id t127mr1474438pgc.237.1615856573006;
        Mon, 15 Mar 2021 18:02:53 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:b1c9:41e8:dd7a:142b])
        by smtp.gmail.com with ESMTPSA id v27sm14452461pfi.89.2021.03.15.18.02.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 18:02:52 -0700 (PDT)
Date:   Mon, 15 Mar 2021 18:02:50 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Drew DeVault <sir@cmpwn.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Subject: Re: Regarding the depreciation of ssh+git/git+ssh protocols
Message-ID: <YFADuptwV7iR76g5@google.com>
References: <C9Y2DPYH4XO1.3KFD8LT770P2@taiga>
 <YE+ftT2WaKDzc+45@google.com>
 <C9Y4NXXX6HRI.1IROIK8ZXK4S2@taiga>
 <YE/ZSiuIsMs3ucVM@camp.crustytoothpaste.net>
 <C9YD4AEUH84L.29FP64NJJ1BPU@taiga>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <C9YD4AEUH84L.29FP64NJJ1BPU@taiga>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Drew DeVault wrote:
> On Mon Mar 15, 2021 at 6:01 PM EDT, brian m. carlson wrote:

>> So I don't think this is a thing we can do, simply because in general
>> URLs aren't suitable for sharing this kind of information.
>
> That's simply not true. They are quite capable at this task, and are
> fulfilling this duty for a wide varitety of applications today.
>
> I don't really understand the disconnect here. No, URLs are not magic,
> but they are perfectly sufficient for this use-case.

I'm not sure it's a disconnect; instead, it just looks like we
disagree.  That said, with more details about the use case it might be
possible to sway me in another direction.

To maintain the URI analogy: the URI does not tell me the content-type
of what I can access from there.  Until I know that content-type, I
may not know what the best tool is to access it.

The root of the disagreement, though, is "Git URLs" looking like a URI
in the first place.  They're not meant to be universal at all.  They
are specifically for Git.

Thanks,
Jonathan
