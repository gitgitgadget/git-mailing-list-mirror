Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EADBBC47088
	for <git@archiver.kernel.org>; Wed, 26 May 2021 14:39:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE08A6108D
	for <git@archiver.kernel.org>; Wed, 26 May 2021 14:39:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234778AbhEZOl3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 May 2021 10:41:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234604AbhEZOl2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 May 2021 10:41:28 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBB03C061574
        for <git@vger.kernel.org>; Wed, 26 May 2021 07:39:55 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id q10so1183508qkc.5
        for <git@vger.kernel.org>; Wed, 26 May 2021 07:39:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=zyq51ZWjgAqe1DJ1UumeVnjcU2HtVRFay9d2EES6wpQ=;
        b=ZvsDUspqUV45P8jkmRgkYlHgUmFZtqfkFWVvd6rXe1a84wgF2M32GdQo9hw972oEKS
         OJyniakAH9ub1PjCht9f7RsDXxGf2UuMupXaGodouspw/lNdIgPYeGfGojMmqmFFBX7M
         COrPgddQ72ddjXWrneoBOlbnQg3kWaaUwSFHK9b4r4eCeDfKH8FrUkGZpJwfG6/og3JS
         ZXX9MxSPvKk4YyPQbctW38hvEpE7m98A7esNGdrGD/PDEkJ4Y6LNxcpmtqZkKxIfVyYh
         FQYPK688pL85ceiaYTvlg6Bv25vpkQPJBCMWLKm5Gt/tOXQC8Cu62hi4+a4sCEbAsPkg
         LFUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zyq51ZWjgAqe1DJ1UumeVnjcU2HtVRFay9d2EES6wpQ=;
        b=EDRIav3FUVFg0ECV/qGb7l0FZiqXmJgf5UuT0Kr4d4y4GxXxslrCKDygEh98azyhpZ
         G2OQXPt8scCziL9hoAKqrp3B+usQDOuhFDS3uA7svwQIMpRFsMY83tH6fcs2fWGom8Xa
         jzTJL7O9dkw0ldOb8nViPrRlYO65g9F5/ZhKR9X5WT8xgWUaQQCdmjrnvVgB0OPJZMLj
         XSYxMH4ln4bjXuFXZzdbr03hkoU8cIemqK+nqeyJE0JSxOeo9g07B5RKsssXuJS7VjoN
         fxMSEb5XA1eP1ZxZxlp+Uo8SmG5XUG3lCkWvzDF40a7C8qwixiXX1OEn+/wk6yA2Llna
         rRDA==
X-Gm-Message-State: AOAM533P3WZja+jL6SWE0h9Y3Bg96wtC54HRbx4W5dABICwS4sjHtVmB
        Gj3IY5by+M5lW1j0RBhBvjYMIQ==
X-Google-Smtp-Source: ABdhPJwhsLSCURozsXAIK0tvFU8ow+CiWW2O7vNfmKBntHE+q9b4hoFmiWhhsGR4FOHFHqZpblRV/g==
X-Received: by 2002:a05:620a:30d:: with SMTP id s13mr41364892qkm.58.1622039994857;
        Wed, 26 May 2021 07:39:54 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:fd7b:5b8e:7238:b804])
        by smtp.gmail.com with ESMTPSA id p14sm1687574qki.27.2021.05.26.07.39.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 May 2021 07:39:54 -0700 (PDT)
Date:   Wed, 26 May 2021 10:39:53 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Han-Wen Nienhuys <hanwen@google.com>,
        Avar =?utf-8?B?QXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: CI: 'seen' minus a few passes tests, eh, almost
Message-ID: <YK5dubBcSwm9c4Ta@nand.local>
References: <xmqqcztecuy7.fsf@gitster.g>
 <xmqqzgwiawm4.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqzgwiawm4.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 26, 2021 at 02:32:19PM +0900, Junio C Hamano wrote:
> Just with a hunch, I further excluded tb/multi-pack-bitmaps from
> 'seen', in addition to these four topics.  It seems to pass the
> whole test suite on both 32- and 64-bit build combinations.
>
>     https://github.com/git/git/actions/runs/877225207
>
> Except that vs-build sometimes fails to download the sdk, that is.

Thanks for letting me know. I have accumulated a few local changes that
I wanted to include in a reroll of that topic, but I was waiting on
other reviewer eyes before sending it.

I should be able to spend some more time pushing that topic forward
after the release. There are a few other patch series waiting on it from
GitHub, too.


Thanks,
Taylor
