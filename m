Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64DE1C7EE30
	for <git@archiver.kernel.org>; Fri,  3 Mar 2023 21:25:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231548AbjCCVZj (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Mar 2023 16:25:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231615AbjCCVZi (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Mar 2023 16:25:38 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9B7A62328
        for <git@vger.kernel.org>; Fri,  3 Mar 2023 13:25:32 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id cw28so15599452edb.5
        for <git@vger.kernel.org>; Fri, 03 Mar 2023 13:25:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677878731;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6I6CJWdBvjv2o4bVkZn7yejwwgFh8dj0eLGITnvHdoM=;
        b=qnG8Tn7HdZUPGLobLcpBLgkkCpRwXtWJR8XtURbsSK1HjlzZrgih5dRPWYs6LkqcKs
         kQrtvi7saWUrgMK3actuMoRci/3CUtp2ilXiR/gYSnr3zerIeFawmgGYdEvuNbNN46Gn
         dICQgHEbLxYSrIW49Ueq1L8/FV+JcZ5xRMq8/OIYZO1HYyIpeV3N58Pj461LV1s6V9y1
         HYgBmsVNavyv2k371w0YzYVqGW8BwEwccLgQaXNFcbG2mxRb+XW2INmGA1bYUJOZXfgb
         e8/0r1kLNk7KB17IzESODRQvfRC8HQCX2mkDeLDXw/kUQ3Is2BSPkcAdcE+4wWVTbAfV
         s4QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677878731;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6I6CJWdBvjv2o4bVkZn7yejwwgFh8dj0eLGITnvHdoM=;
        b=5XeWB2wzbiBE/jg1JrOIpiGfBs4NcZWRmOPOgOIfBhVpnOD2ipfrNHuQrH+ECgIJmi
         1f91Vj6szDHLaJfzAjNmAycV2dQdaNq/5soAPa9YX3znveuGPnAHYCEnGYrn98k83tvu
         78Qk+AvdDLQQp4z+8a38YG08MDTXEWdKIrwNnJOINAGtuDFYTsNCHD9UOVFdOCvS5hpS
         1pzO4WvV9iKZj8HB6SQjSvS6BRjbbz08OFH6ARaf/RAQTSIoiUI2+RCji++2LLndS+8p
         lZ8GGbfCaxxIJutjnr1MdQ/zWXD9T+Ulcacpn8tEMVdK2ijMNNqi3E4JgOc1iaWwgWCe
         snPA==
X-Gm-Message-State: AO0yUKV4lcEc7/KbVv0N4GfHMm4x5v1B/gGfDGC/1SHro6r2HsxPwSvR
        XQmkJ8MUqNMNpp2NGqbs9wYhwv6aC9SK5M0deHM=
X-Google-Smtp-Source: AK7set9XKzqd+1fuyWxY0eaKlNBmXJYfHEcJPXhpJx1brjBNBCFDZTzn8xk013fu37l31wxt3vXTNfpeB80CpsylajQ=
X-Received: by 2002:a17:906:398a:b0:877:747e:f076 with SMTP id
 h10-20020a170906398a00b00877747ef076mr1496118eje.0.1677878731179; Fri, 03 Mar
 2023 13:25:31 -0800 (PST)
MIME-Version: 1.0
References: <961e68d7-5f43-c385-10fa-455b8e2f32d0@haller-berlin.de>
 <374f83c2-7bf0-38be-26ae-de28340c37d2@dunelm.org.uk> <f28bb5a7-ec68-dce2-9b63-7bfb5330c33e@haller-berlin.de>
 <c237c1e3-5cd0-503d-ff4b-96f645a659f3@haller-berlin.de>
In-Reply-To: <c237c1e3-5cd0-503d-ff4b-96f645a659f3@haller-berlin.de>
From:   Chris Torek <chris.torek@gmail.com>
Date:   Fri, 3 Mar 2023 13:25:19 -0800
Message-ID: <CAPx1Gvdik+QhTw8U1vd0cW1yZ9GbgDpmW7apxnXdY=E0okLpTQ@mail.gmail.com>
Subject: Re: When exactly should REBASE_HEAD exist?
To:     Stefan Haller <lists@haller-berlin.de>
Cc:     phillip.wood@dunelm.org.uk, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 3, 2023 at 3:04 AM Stefan Haller <lists@haller-berlin.de> wrote:
> It seems that I can get close by checking whether the file
> .git/rebase-merge/amend exists.

The location and existence of this file depends on Git version and
whether you're using added working trees, so that's not generally
the right directionA to go.  It would be best if `git status`
reported all of this information directly: perhaps --porcelain=v2
can be augmented to provide this, or there might even be a
--porcelain=v3 if necessary.

Of course, you'll still have to do some kind of guesswork for
versions of Git that don't produce the right status.

In any case someone would need to add the desired information
to `git status`.

Chris
