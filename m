Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1ECEE1F42D
	for <e@80x24.org>; Mon, 14 May 2018 06:45:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751953AbeENGpf (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 May 2018 02:45:35 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:42363 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751533AbeENGpe (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 May 2018 02:45:34 -0400
Received: by mail-wr0-f193.google.com with SMTP id v5-v6so10985088wrf.9
        for <git@vger.kernel.org>; Sun, 13 May 2018 23:45:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=etmqoCzmeF6H3U3b4JfztltZ1HgGl6hL+mnyy/xLvCI=;
        b=Wd0Oi4NnkKCIyh9vfWZoQkQ+M+AQ22q2uQAvq8HqgfJRshy/Vh9hnGLfzwsjxfNw9e
         ndWmAGcmI0crpPlD3fEOvGtlsTlErg74QS3WiC5UVkmZz2lkF+gMG/mLRBItDIrh2O4+
         N63YC0fVfBOKt/qX3Wx7mKqCjcsqi4a0eu9u08522CDaCQ7cQKLmBQR2mkdNvmBeDgp0
         ljxuIrYx7mme9E69xFYzsIlFqmF4ua5jCWGUTusk0vl7ahJYMMlhxYXQthdcjNIw5JJK
         YBcGy/bPkFiDM7COszMR4q9jE9FtbFS/NfQhUhTJhYXViunGfi1kpKo33RpKnkMuKj6j
         YorQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=etmqoCzmeF6H3U3b4JfztltZ1HgGl6hL+mnyy/xLvCI=;
        b=BU978wOCzm3QjemVcGWkGvYEAyfcW58tuvcRJnXOBEvV4vNur8076gSyy3uV6WKLe5
         h9asGsr+fQV/L2XAC6yWQoEJfbP1CQfeyG4IVU1gZVfoHgthW61M6DgiuDH1M5bT1xOP
         RXoOGdbloJCv1x4iDBuHqkhwbAYCfA4sLSC991j3Y3mLZPKHsQwzYuTeFiK/1LU+q3J3
         MNaiuAFAX2QnRpYkHBpbNO+ySzLb9pJoI+Ft55JJxwhTJmbAdwRsm84sXg2cX1hGXV5n
         z4uN1Gl3idi5iB56cRczUwEmr0a6SKLbz6XgHI1fv0GtwkPPVgePN3WQthYdAB2j3rYk
         dQvw==
X-Gm-Message-State: ALKqPwelFPQP3xpE+qNIATqy1mbYm2R1yJ50kT+Pa5YUK82zJgSTOUU4
        B9xkuqz04IAGWNm1XvpCcSQ=
X-Google-Smtp-Source: AB8JxZqbNPqGk0ywfgN5eWm9e+33wXiKOA3fwsfyaNUQmysKXY/01l7FF8VI3bWQfeLhZNRuhmqI4g==
X-Received: by 2002:adf:b71a:: with SMTP id l26-v6mr6158656wre.115.1526280332759;
        Sun, 13 May 2018 23:45:32 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id a10-v6sm11979401wri.10.2018.05.13.23.45.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 13 May 2018 23:45:31 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 11/14] show-branch: use commit-slab for commit-name instead of commit->util
References: <20180512080028.29611-1-pclouds@gmail.com>
        <20180513055208.17952-1-pclouds@gmail.com>
        <20180513055208.17952-12-pclouds@gmail.com>
Date:   Mon, 14 May 2018 15:45:30 +0900
In-Reply-To: <20180513055208.17952-12-pclouds@gmail.com> (=?utf-8?B?Ik5n?=
 =?utf-8?B?dXnhu4VuIFRow6FpIE5n4buNYw==?=
        Duy"'s message of "Sun, 13 May 2018 07:52:05 +0200")
Message-ID: <xmqq36yud9bp.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nguyễn Thái Ngọc Duy  <pclouds@gmail.com> writes:

> It's done so that commit->util can be removed. See more explanation in
> the commit that removes commit->util.
>
> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
> ---
>  builtin/show-branch.c | 39 +++++++++++++++++++++++++++------------
>  1 file changed, 27 insertions(+), 12 deletions(-)

Looks obviously correct.  

Another place we could use commit-slab in this program, which I
think is a more interesting application, is to use it to store a
bitmask with runtime-computed width to replace those object->flags
bits, which will allow us to lift the MAX_REVS limitation.

Thanks.
