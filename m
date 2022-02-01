Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EC89C433F5
	for <git@archiver.kernel.org>; Tue,  1 Feb 2022 19:52:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233442AbiBATwo (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Feb 2022 14:52:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233141AbiBATwo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Feb 2022 14:52:44 -0500
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B99C1C06173B
        for <git@vger.kernel.org>; Tue,  1 Feb 2022 11:52:43 -0800 (PST)
Received: by mail-io1-xd29.google.com with SMTP id p63so21782505iod.11
        for <git@vger.kernel.org>; Tue, 01 Feb 2022 11:52:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=7YGNHkFVbkaM+/71BND1JNwPJBaNmrKwjDxFUw/jpEc=;
        b=7yPMSYPRFBUsTTi15psHul55ICPUDh+0kh+Up8kN6MnSSGhoUFtJ7GULw37gsSxhx7
         vMBHSBWh87bwCXaQvexH3BF9gahi7OQUX7JK7ZzmYd+/XhBO83hj+mrXY/EvpT07hmQp
         ueftshG2ihKJOUad4KfDF9Iw+yz58mz8ZnGRa455SLKBAelZq5WyzSzX0KMu72NQPvB9
         Sci45n6HduUCHaL3W185L2hP1jiDT91CPB+8CI+1lp9vLMQW8TDYwfKLNLlDO+vW0owv
         fOf6nM3XEffYlHiv7PRW3E87Pgp00MIQOImb42lJ+J5SWsD3lwL/soC507LW3rBwJkOb
         DrxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=7YGNHkFVbkaM+/71BND1JNwPJBaNmrKwjDxFUw/jpEc=;
        b=vHScpoOjwgmiXgqlRCBGCu8z+IXQoFWZCZyXmodNn+a1EUZdXMsJ2P5o1/CaeKt+rM
         THwiRlP2kq7CbjYrPeVnXTChsrNF9Fs0zWm8VfkL/dzGK2Hsu386GgZDpe0cVnkzN7SF
         ukl2dznlIdT5/1uD+n+4M/NIPPF++v9n3vHuY13v0tXE+tWXLprqDCs1C0f43STOjsMP
         KtLBegv2ILiQhmJs9AcwgEANwXPugS7nTB7fRYqa3a3cv0PBYulummSiqTrHe3Y3tOOk
         FsAzGnvDBu/Ht+oZc3OIp7LXeT70R8VkrUYAzRcxbDPmoC2S+x1iZX4zSquYZdO1lLqq
         STJg==
X-Gm-Message-State: AOAM532nprCfXw7usLjJ9a8azUlcZy3HtjkCo9BnW4a9IbOj1CcSFSPx
        PUZlMoSdvIKj9Jr8WEvEvwx1iNjU4UYx/A==
X-Google-Smtp-Source: ABdhPJxBEvHRFxZtQyiwNoVb8RN/Irmu3sLqvG0oh/BLwNrpjSJFggIccx0FMN+2qIUNYkEd0U44cw==
X-Received: by 2002:a05:6602:1350:: with SMTP id i16mr15125935iov.153.1643745162988;
        Tue, 01 Feb 2022 11:52:42 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id ay35sm14749571iob.3.2022.02.01.11.52.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Feb 2022 11:52:42 -0800 (PST)
Date:   Tue, 1 Feb 2022 14:52:41 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Michal =?utf-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>
Cc:     git@vger.kernel.org
Subject: Re: Getting rid of "hint: Using 'master' as the name for the initial
 branch." when initializing a repository with pygit
Message-ID: <YfmPiZZ/1RGzzfWE@nand.local>
References: <20220201184128.GT3113@kunlun.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220201184128.GT3113@kunlun.suse.cz>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 01, 2022 at 07:41:28PM +0100, Michal Suchánek wrote:
> I noticed that in some environments the default branch warning is
> displayed and not others because the git version varies.
>
> The warning is just noise in the test log so I would like to avoid it,
> and I would like to find a solution that works for git that predates the
> introduction of this warning and the option to silence it as well as
> the future git versions in which the default is subject to change.
>
> AFAICT there is no clean way to do it. I can set up the global option to
> whatever but I don't want to do that just to run tests.

If you have set the init.defaultBranch configuration, we will suppress
the hint you're talking about.

Alternatively, you can make sure that `git init` is invoked with the
`-q` (quiet) flag, which suppresses that warning whether or not you have
set the init.defaultBranch config.

(Here, I'm assuming that the library you're talking about invokes the
git binary and respects its configuration. I'm not sure how much control
you have over the flags that get passed down to the git binary, though).

We could also make it possible to suppress just that advice (with
another advice.* configuration option), but it seems redundant with the
existence of the other two options I discussed above.

Thanks,
Taylor
