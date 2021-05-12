Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A141C433B4
	for <git@archiver.kernel.org>; Wed, 12 May 2021 04:46:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D5FE6617C9
	for <git@archiver.kernel.org>; Wed, 12 May 2021 04:46:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229803AbhELErH (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 May 2021 00:47:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbhELErG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 May 2021 00:47:06 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A175AC061574
        for <git@vger.kernel.org>; Tue, 11 May 2021 21:45:58 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id q7-20020a9d57870000b02902a5c2bd8c17so19523557oth.5
        for <git@vger.kernel.org>; Tue, 11 May 2021 21:45:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=71ZJRsma//+TZb7xtFgK+nd7exSjJmvBye3FsRJlsYM=;
        b=Z72yzX39q8aA8xs1Ort0DOQT9d81d6oqImT8IuCXbothMD+s8OnnCZrtmLEuLubtRI
         bM8S1Y2I1wtK5TUSPjq8mZGod4sikbt9ccm4GsiEiD9EKmAMnaje/sHeqnGIR2RP7/87
         djPKdsk+8anMoXPbD7qQHyTfVVnDECxexIrkyeXVcgniUq/qiwTnKODLefuq+rnMxtjS
         4WAmI8eZ1AkZAlPyLCz8yLXYh9o+lB3MfMgTblAxdNqZkWFoBSM25I1EhysSRotu24xD
         7nNe4j251+krdoso3ZH7icsRL52LUvanSyOge52tQLKDvCzhZ5FCjnF1GRRy3hXyTM+R
         1y9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=71ZJRsma//+TZb7xtFgK+nd7exSjJmvBye3FsRJlsYM=;
        b=sU4HW4Dt+Vqt0DqLapfHgitHHxXa7Z3CYL7x9m4UP7o9uRKMK3OnDwgYjhQ4m4v7kx
         mihewGXilFbmIcSM9xxLR9r9jmyjYwJzq8MrI4WUxTN9cVh+hCdsSxCGBc9X5fuKoDeB
         g+bNZdxYiX3Vd8UVPlv0ELY2VoPImF2MwaJGMBoq55HZuf+wiw4jRoSDfMP37oidJE74
         DiPt48cjKXnrQAj0rQ06/nVs7LPFm7vyRt7ZfhhGki/tpSsVQY6W91jYCv8JtrOL9sms
         1/oYYAS6yyvbtQr2+iKt5hIseZ6/HuZq9zflkyTOMBjpxGvBAWgWvr04sHEzkqksNL65
         57gw==
X-Gm-Message-State: AOAM53019ogfMK2Trwq4UXB8poaZ6gV6tOivY+YSCRacx6HJuNbkQGJ+
        tdXBxGy+c3fiZb7NYUShhuQ=
X-Google-Smtp-Source: ABdhPJxkxpnX0N+7N5AudHLsauJwtom5k6CrvEkOB3305zvmvi/ferHL3GM3nmH6ZHxO0oQ0+faJ7A==
X-Received: by 2002:a05:6830:1ac7:: with SMTP id r7mr23382329otc.167.1620794758073;
        Tue, 11 May 2021 21:45:58 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id 35sm1466796oth.49.2021.05.11.21.45.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 May 2021 21:45:57 -0700 (PDT)
Date:   Tue, 11 May 2021 23:45:53 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Cc:     Felipe Contreras <felipe.contreras@gmail.com>,
        =?UTF-8?B?TWFydGluIMOFZ3Jlbg==?= <martin.agren@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>, Jeff King <peff@peff.net>
Message-ID: <609b5d814b95c_678ff208d6@natae.notmuch>
In-Reply-To: <20210512021138.63598-2-sandals@crustytoothpaste.net>
References: <609b2828309fc_678ff2082@natae.notmuch>
 <20210512021138.63598-1-sandals@crustytoothpaste.net>
 <20210512021138.63598-2-sandals@crustytoothpaste.net>
Subject: RE: [PATCH 2/2] doc: remove GNU_ROFF option
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

brian m. carlson wrote:
> By default, groff converts apostrophes in troff source to Unicode
> apostrophes.  This is helpful and desirable when being used as a
> typesetter, since it makes the output much cleaner and more readable,
> but it is a problem in manual pages, since apostrophes are often used
> around shell commands and these should remain in their ASCII form for
> compatibility with the shell.
> 
> Fortunately, the DocBook stylesheets contain a workaround for this case:
> they detect the special .g number register, which is set only when using
> groff, and they define a special macro for apostrophes based on whether
> or not it is set and use that macro to write out the proper character.
> As a result, the DocBook stylesheets handle all cases correctly
> automatically, whether the user is using groff or not, unlike our
> GNU_ROFF code.
> 
> Additionally, this functionality was implemented in 2010.  Since nobody
> is shipping security support for an operating system that old anymore,
> we can just safely assume that the user has upgraded their system in the
> past decade and remove the GNU_ROFF option and its corresponding
> stylesheet altogether.

I'm not sure of all that, but my machine uses Arch Linux, it ships with
groff, I've never used GNU_ROFF=1, and I can copy text with apostrophes
from the genrated man pages just fine.

So this is probably fine.

-- 
Felipe Contreras
