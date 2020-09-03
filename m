Return-Path: <SRS0=Hc2o=CM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FD97C433E7
	for <git@archiver.kernel.org>; Thu,  3 Sep 2020 06:00:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 611152072A
	for <git@archiver.kernel.org>; Thu,  3 Sep 2020 06:00:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pa1j5mGT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726162AbgICGAs (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Sep 2020 02:00:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725919AbgICGAq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Sep 2020 02:00:46 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEAD9C061244
        for <git@vger.kernel.org>; Wed,  2 Sep 2020 23:00:44 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id v15so1229890pgh.6
        for <git@vger.kernel.org>; Wed, 02 Sep 2020 23:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=73UqsuAFXiNOmXHYVDOIWquNJXXFdmEm39RfmW0Jlyc=;
        b=pa1j5mGTUqF7jD3T7QgkAUguqudwdFzfN+9OPdEnP+FtTVNZqbv76Jqc3JKKwZEbw2
         dLgElQW3IE5/cc+QzLs1D/jxJYR5YSJiIiTUQYgzwWQtV6xl6lf14QYe5XiHAaYCgfJd
         1lTHL1pmr72kkqlngSPVpf6PdWrieIA40gThDQUNCloc2MK81gaTkEYD2uwjufukE8al
         lsKBLR3TjzfbOe0ufk+z/JP3cGhRv+fAyuSIwJn/uOnink/3LgJcNNkYBNqHVgWG8kCd
         A7u55cj0nTfix0KMHJ0g0rxvZzee9DmqfuZfu3yH5ZM1c1UdmjdG1Uxf1soCkpLSfnq5
         MOkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=73UqsuAFXiNOmXHYVDOIWquNJXXFdmEm39RfmW0Jlyc=;
        b=aLZrPf8iGG6pDekItyW09ixWQAul2Enx0btRcVt5FISX1G3jjEgN96+pU1AVPG1H8J
         hPmAnGmoyYvK1fXNXRCjzIJwNPzrdXLhgl4/aKGwEX6zPoziaHIc/IY8B2zNggN7nFn1
         qWb2Qx00WePJyYEemAAf5T6n4q9qdxMWhpbDH9TH5yuMq85MZ4typQtfYwwrFG7VnNbJ
         wAjyLxy3SuygTffEob9F3S2DCruB1How/Qw5SJqmzTY9A5CUCHtD4qWATH+78gLSjHY2
         v/L7d1brKXnR6qdWZaaVOhnbZDsskYEUkDROnukj/balj/T6fJ58y9frdVtOwGmoxPfy
         FdzA==
X-Gm-Message-State: AOAM533ek5heHi8PcENCfEQIqrxnv5xdqy0ny3sIoig+svPI7awLBSMh
        u54e9rB70bXeIPCgCK70CYA=
X-Google-Smtp-Source: ABdhPJyLMmVGprxi/avIAYYlxDh0VmBurk0Brdibyjt+gobugk/XpE9rCQqIL8/Dl3dCCWwbdWWE2g==
X-Received: by 2002:a17:902:104:: with SMTP id 4mr2168776plb.216.1599112844019;
        Wed, 02 Sep 2020 23:00:44 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:a28c:fdff:fee1:cedb])
        by smtp.gmail.com with ESMTPSA id k88sm1211387pjk.19.2020.09.02.23.00.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2020 23:00:43 -0700 (PDT)
Date:   Wed, 2 Sep 2020 23:00:41 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Jeff King <peff@peff.net>, git <git@vger.kernel.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Git in Outreachy?
Message-ID: <20200903060041.GH4035286@google.com>
References: <20200828065609.GA2105118@coredump.intra.peff.net>
 <CAP8UFD2rpNhDhyHdQNxS-KJZgcumsCpK_JQ5koCqXJd70s-+_w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP8UFD2rpNhDhyHdQNxS-KJZgcumsCpK_JQ5koCqXJd70s-+_w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Christian Couder wrote:

> I would appreciate help to find project ideas though. Are there still
> scripts that are worth converting to C (excluding git-bisect.sh and
> git-submodule.sh that are still worked on)? Are there worthy
> refactorings or improvements that we could propose as projects?

I think setting up something like snowpatch[*] to run CI on patches
that have hit the mailing list but not yet hit "seen" might be a good
project for an interested applicant (and I'd be interested in
co-mentoring if we find a taker).

Some other topics that could be interesting:
- better support for handling people's name changing
- making signing features such as signed push easier to use (for
  example by allowing signing with SSH keys to simplify PKI) and more
  useful (for example by standardizing a way to publish signed push
  logs in Git)
- protocol: sharing notes and branch descriptions
- formats: on-disk reverse idx
- obliterate
- cache server to take advantage of multiple promisors+packfile URIs

Jonathan

[*] https://github.com/ruscur/snowpatch
