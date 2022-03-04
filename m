Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D49DC433EF
	for <git@archiver.kernel.org>; Fri,  4 Mar 2022 22:42:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229908AbiCDWmv (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Mar 2022 17:42:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbiCDWmu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Mar 2022 17:42:50 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3969F1E14B7
        for <git@vger.kernel.org>; Fri,  4 Mar 2022 14:42:02 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id 11-20020a25030b000000b00628660166e7so8664544ybd.13
        for <git@vger.kernel.org>; Fri, 04 Mar 2022 14:42:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:subject:from:to:cc;
        bh=I9JqpolJ9TEfpiIYyEbUo3g6bGFCNVoR3Y64BJxoOg8=;
        b=daP1/LQm5Mg8ZKkfVdYnorRQllAQWq9ZSfQKeh564w/6U9J34tIr2t7E3+b+bt4VJa
         Wrwv/7OvALyaGRfxpEKhN3DUDPqDdsluhKHiIu7pBCosbI9uGulHSpFGchZwZ+Zh26Ld
         0rQ6g2RehPI+eTOi2t9dlBnQSFU5P+vTcv/vP7uBFa6xt+jh/a/KXKQkvuDt0m8BmbZv
         WSrE4ppNx2YBsKG8KTpMEM2I/rCc8+GZz9SnjmilYyWOsthnzqxTOp0g4ryT/dVFwQxn
         qBgH8Pk4FVxMkd+W1g7BhIyJq02QOrHGe9CBYmlt/UKKPMgl9SuRCkdGcbOHkSyhWvp2
         YOqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version:subject
         :from:to:cc;
        bh=I9JqpolJ9TEfpiIYyEbUo3g6bGFCNVoR3Y64BJxoOg8=;
        b=yX5iStouR5LspHoGx+hSyvolcutOPyR1oJoOkiasOEgYDwg06VVONFxRA/vZ5pLszs
         2Fg4XJrK5zbpvH5bB/SWeQ51LWhuaF/ZzNh5AJg/zR5gevuj6ifV1Pou+aZPoVvYduUb
         OClpmh+Qan665HOji8ETW98UPzcDVtQl6W/qfk6mQnxdF669ZD+uyUh5vvxwUKHTpW9L
         aegYKc5RE6/E/lGKY3/oMbr9i82g3yB/Tf9ozLEacSVqPJsPvU/jGmAHGqP1duG+DeIo
         Y4inHoQZJN882jugTjTo4lW9XKTwDiOHhOrHxvMPB0hDcUz5oIYYy7sK4Y2SxgpIQv2R
         Ugzw==
X-Gm-Message-State: AOAM532sPYF73CQq0Ho+kttTW1ygUaye4qgffYUrA/vud8iuVAN76Beg
        B5i9jyFnP9m1So78zeUePBMnpW01iWwQwLWK8A5r
X-Google-Smtp-Source: ABdhPJwMpeLjItbHunQ8QMYoFTpoBBh6MY9qj4Gtu0YfhVdCB0iJdyMOXazw2cTBdcfVve/jYIX4hmQdVnX5xhYNrFIe
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a25:dd86:0:b0:627:f54b:7b00 with
 SMTP id u128-20020a25dd86000000b00627f54b7b00mr687765ybg.35.1646433721397;
 Fri, 04 Mar 2022 14:42:01 -0800 (PST)
Date:   Fri,  4 Mar 2022 14:41:55 -0800
In-Reply-To: <20220304005757.70107-3-chooglen@google.com>
Message-Id: <20220304224156.637697-1-jonathantanmy@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.1.616.g0bdcbb4464-goog
Subject: Re: [PATCH v4 02/10] t5526: stop asserting on stderr literally
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Glen Choo <chooglen@google.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        "=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?=" 
        <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Glen Choo <chooglen@google.com> writes:
> +check_sub () {
> +	NEW_HEAD=$1 &&
> +	cat >$pwd/expect.err.sub <<-EOF
> +	Fetching submodule submodule
> +	From $pwd/submodule
> +	   OLD_HEAD..$NEW_HEAD  sub        -> origin/sub
> +	EOF
> +}
> +
> +check_deep () {
> +	NEW_HEAD=$1 &&
> +	cat >$pwd/expect.err.deep <<-EOF
> +	Fetching submodule submodule/subdir/deepsubmodule
> +	From $pwd/deepsubmodule
> +	   OLD_HEAD..$NEW_HEAD  deep       -> origin/deep
> +	EOF
> +}
> +
> +check_super () {
> +	NEW_HEAD=$1 &&
> +	cat >$pwd/expect.err.super <<-EOF
> +	From $pwd/.
> +	   OLD_HEAD..$NEW_HEAD  super      -> origin/super
> +	EOF
> +}

The check_ names still aren't changed (as I suggested in [1]) but
perhaps it's fine to leave it. It doesn't seem to bother the other
reviewers, and changing it would slightly disrupt the review in that
there will be extra changes in the range-diff.

[1] https://lore.kernel.org/git/20220224230523.2877129-1-jonathantanmy@google.com/
