Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7894EC433F5
	for <git@archiver.kernel.org>; Wed, 26 Jan 2022 22:11:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232925AbiAZWLW (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Jan 2022 17:11:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232997AbiAZWLV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Jan 2022 17:11:21 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EB46C061748
        for <git@vger.kernel.org>; Wed, 26 Jan 2022 14:11:21 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id g2so555822pgo.9
        for <git@vger.kernel.org>; Wed, 26 Jan 2022 14:11:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=vcMic8TP4u70N4vhyFHNMoYQ8IrLtxrMM3uesZu5qtQ=;
        b=FHU8lOGEYkiJ02yKkRWHvDebcP1uguTqp4WU3PUtFfDPnN4J6pI3b0cQI7mzPG0qRN
         Tw49EvT0dLV1qqUdvYjWHJYAcPZeSedb2zYuVLqDFxbszgvv9kaphta25+1s7p6oU7pv
         d5yUpzZ+fAmlFFOGyItEY+lONZWys/r04qU9xYktzmwHnYBVx+wD8pyhM4GbiVjPB/AE
         Ajx1ed/O1NnL6BvvTkiJRC6b2Mk6MKxcqGRMhZcwJJfSKVvuYx37hibt2gFxOAtnPIVV
         T/IxL0EXR/6Sgz0J6A25RBAc8I7W0ddeaUdxl3lPSiWwBmTOZsqhMxEEjjK+7Rp+Z4No
         WvPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=vcMic8TP4u70N4vhyFHNMoYQ8IrLtxrMM3uesZu5qtQ=;
        b=Y0NAvyDCTz8DhiA3fQCaX2u0AyNq4RMbjwsQk7uBQ2ocu5pP+ECCGHOJHyyhDyIbWP
         sUD58pAlR6ERBUw2Ke2moMlxjes0KpRa7zhAwq6CM3Xe4VMylzMkJEyKjS9K8pp8/q2D
         fvK1izI+8Mf814PDszAEZFMAbQU9O4q5ZT08kapGi3p6RdRmopELpFtJIl088cXH1CU9
         hqSGGeRaW2FnCQZroelbHN9QLTvxeIZDn75A0U+WPsmfMt3Mn1+aqR08rmO2hZqnQlQB
         tY7waGCwOpukpbudtCasaYXYyc0Efdy5vc4oN9ChKedpQt71G79FsaLekVxwgq/vwXYi
         tLog==
X-Gm-Message-State: AOAM532KkM+wK6mvye91rl1cLCaKbRJJ/hu7AOdQNG3d9Fn+VvkOsHJh
        7kltM1/GAMbODot4PQGmqsHzxFu9uQnzsg==
X-Google-Smtp-Source: ABdhPJzJIaJTnPl+xFRbKLbePlkDWJne3u7JXUhCeHamArkHS+I2p7Epg6ybcwoWr29Cx0QlFumunQ==
X-Received: by 2002:a63:f30e:: with SMTP id l14mr664804pgh.410.1643235080411;
        Wed, 26 Jan 2022 14:11:20 -0800 (PST)
Received: from google.com ([2620:15c:2ce:200:ab6e:3315:a6a2:f99f])
        by smtp.gmail.com with ESMTPSA id q19sm2986807pfn.159.2022.01.26.14.11.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 14:11:19 -0800 (PST)
Date:   Wed, 26 Jan 2022 14:11:13 -0800
From:   Josh Steadmon <steadmon@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff Hostetler <jeffhost@microsoft.com>, git@vger.kernel.org
Subject: Re: [PATCH] test-lib: unset trace2 parent envvars
Message-ID: <YfHHAXjReQoMhjdl@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <jeffhost@microsoft.com>, git@vger.kernel.org
References: <82e51a52e20fbe13a5a898a0a2f6dbe1188e3fa3.1642116539.git.steadmon@google.com>
 <xmqq35lqetzw.fsf@gitster.g>
 <Yecv7H5rrdMnRJBs@google.com>
 <xmqq4k60sogk.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq4k60sogk.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2022.01.18 13:50, Junio C Hamano wrote:
> Josh Steadmon <steadmon@google.com> writes:
> 
> > Yes, due to the number of different TRACE2 modes, I figured it was
> > cleaner to allow them by default and then explicitly unset the ones that
> > cause trouble for trace parsing tests.
> 
> I think I would agree that it is a better solution, and the design
> behind it (which makes me say it is better) should be recorded in
> the log message (and possibly in-code comment near the place we
> reset them) to help future developers who may add more TRACE2
> variables.
> 
> Thanks.

Fixed in V2. Thanks!
