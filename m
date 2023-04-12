Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22AC5C7619A
	for <git@archiver.kernel.org>; Wed, 12 Apr 2023 22:05:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229762AbjDLWFO (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Apr 2023 18:05:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbjDLWFM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Apr 2023 18:05:12 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BC6E6A65
        for <git@vger.kernel.org>; Wed, 12 Apr 2023 15:05:00 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id n203so1652529ybg.6
        for <git@vger.kernel.org>; Wed, 12 Apr 2023 15:05:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1681337099; x=1683929099;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EaX2Oujcz7Q950bahtzbJWNxc0Yi8VzD0vTdG4nQmZI=;
        b=uVu5nnBLr4Y5eYTMViNaNCvtShdm7HerqXWuMD9XDlBIuNFTydcPnp5nCxVLXvzO2n
         e8CbYXpkbgqBXenTecBDddXZyDUi3bL8l9U4In6oq1ZNgrUW1vOjUrdC8ZDuVzbhGDoU
         loywPBIHuXZHY0W5jr2zwUt+Je6VhZxurvq3P7HJ8VVR+aXD+oZOZNHaiGRdbm90d94P
         8vhpeGXUKs8XCxfHPy5ZEy0307QoT3TFHJrFwIQPrJ7jQA7A659T5PrV7L6R8803TtdE
         OrJAVWWp6OluMm+OOCoNyJoR2/tbN4NePFTOVLwWMXhSuSmDn7aQRDFcw0qI7n+ziFta
         UkYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681337099; x=1683929099;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EaX2Oujcz7Q950bahtzbJWNxc0Yi8VzD0vTdG4nQmZI=;
        b=lEaCpqK6fO0K/Ar+npfDOE2FtCj+I8/nkwt6/cznOpyRbhzybDWmVgJ9FbDO+fFMQk
         4qad4sB3QhGtJt1Dqxe1k+BrqzITTU0ns9wlBzFeftnuab952nrLMc/KjsX2DQ5Gpf6N
         kge2sedTEaGKTnDp+Gr90/wRPvwPJeWJp19B2pWgULi8UlpAqiDbBq8F1RcHPAsESdId
         nJThSXI6/r3/0lLCE+BS4Hy3cAUbp/94JUQqlUbE6y8e//hsf5TK4Glu2DaoATFZPSQt
         73TSXxu31vsgzs1ZV3esV73QWYy4RyMLGo/OyKSdhF+Hs39fhLckDpJfBPNVOu5/qpsE
         aXbg==
X-Gm-Message-State: AAQBX9fDDrJXp+KJehQqL4XJho326YjXXBbA9KKadC0l8CUlf25PRfiG
        J9GvZXNMKgsboElNIVblLLT+qQ==
X-Google-Smtp-Source: AKy350aI/4ZKErLxey4EIgyzMeRTFOccOOWR4jm+Xi12TgutIV6JsORNzIwp/txhZh51kfdRokMnUg==
X-Received: by 2002:a05:6902:1503:b0:b8e:d933:677 with SMTP id q3-20020a056902150300b00b8ed9330677mr85697ybu.19.1681337099193;
        Wed, 12 Apr 2023 15:04:59 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id r125-20020a254483000000b00b7767ca749dsm4597044yba.58.2023.04.12.15.04.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Apr 2023 15:04:57 -0700 (PDT)
Date:   Wed, 12 Apr 2023 18:04:55 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Apr 2023, #03; Tue, 11)
Message-ID: <ZDcrB0nX4Rl4ABCU@nand.local>
References: <xmqqo7ns69sz.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqo7ns69sz.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 12, 2023 at 02:59:56PM -0700, Junio C Hamano wrote:
> * tb/pack-bitmap-index-seek (2023-03-20) 6 commits
>  - pack-bitmap.c: factor out `bitmap_index_seek_commit()`
>  - pack-bitmap.c: use `bitmap_index_seek()` where possible
>  - pack-bitmap.c: factor out manual `map_pos` manipulation
>  - pack-bitmap.c: drop unnecessary 'inline's
>  - pack-bitmap.c: hide bitmap internals in `read_be32()`
>  - pack-bitmap.c: hide bitmap internals in `read_u8()`
>
>  Clean-up the pack-bitmap codepath.
>
>  Kicked back to 'seen' out of 'next'.
>  There is a BUG() on data errors that needs to be fixed.
>  source: <cover.1679342296.git.me@ttaylorr.com>

Sorry for letting this linger for a bit, I've been stymied with other
topics that has limited my attention on this series.

AFAICT, it shouldn't be conflicting with any other in-flight topics
right now, so keeping it in 'seen' as-is shouldn't be an issue. But if
you want to kick it out of there, too, that's equally fine with me.

I do intend on getting back to it shortly, though, hopefully next week.

Thanks,
Taylor
