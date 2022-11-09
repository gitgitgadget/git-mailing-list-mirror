Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93AD6C433FE
	for <git@archiver.kernel.org>; Wed,  9 Nov 2022 06:35:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229649AbiKIGfW (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Nov 2022 01:35:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbiKIGfV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Nov 2022 01:35:21 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 292531A20C
        for <git@vger.kernel.org>; Tue,  8 Nov 2022 22:35:21 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id c2so16204894plz.11
        for <git@vger.kernel.org>; Tue, 08 Nov 2022 22:35:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lnwdUf73xvXnnO3rxVjMkA5Z/DhCQS7tEtykUp9pXeA=;
        b=qb5gE4ijiAL2zuG53eDz8YWyZsg2mvXD9JFDMOPDnKTER56UfNDHDt7+RAt+5zOuvh
         6ZWGqWZz0zxSnpXwqInqnU45HvPmMNy1u0DTJI0ylnihuV2MQn4l2mc/zsC+zfE++Wns
         bpyWopVq6KfnSgq7V/sviCW53vy1Lp1xjLQVkJOqiWg/Dl3nnaQLb9ZlaKd1c3LXWB2g
         TQpV5pbSMUE1mjIlX2DsS8/AIzlzPTLLdk9nP28t25WMzCvLZIHHu1bdHb++lVMfJQ5k
         R0hdk20EGgw+kwYKq5B0z2lfVOLLfT5UZCw20uI8bm8f3oTAOXEIsrd6Yc91EcVqDbGa
         5JYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lnwdUf73xvXnnO3rxVjMkA5Z/DhCQS7tEtykUp9pXeA=;
        b=y8e2FHERh9uPz/UkRifYvhqbvwiAFMWWG7Gog1BQ95/YKeLSlaGDMDDAxZV/vogNlQ
         LrQDVyAZpLGI8aC3939zSaUA2ZxyqepU1DbfRLP6RX3WTJKKUMMhBqQcaDtuIegf/Ayp
         2rYyNqdWbJSF1gmo9eHT5PxP2ii2d9C8Hz0UzbYFB8/v7FYqHGDvM5YXJFioRGm/H8Ca
         BCDIuipJwfTVcDmjY1rFjLC996MaWFWvm7IfEPgGCVnpmd5JohodzmAo56FE8+ZvDro7
         vQN+aoKWW0Lads0nnVVYaa8HfZpgRawCo3K0f1fRGQFgI9eB/THI1k/A6DI5ymbkXMDr
         +Sww==
X-Gm-Message-State: ACrzQf2knwXIXyKdNMrKBmQwLR9rqoZpZCFNEk7pVBfP6FCHBi3hxxpr
        kTj6F+juBzuIhpyuF3GXgJ0=
X-Google-Smtp-Source: AMsMyM7gr0NzTI1lmj/4qK9ZS9zjvqj7OhgFK66m/UEHlRMAlLqVMIMXlo8ZfQPNHke39LnH9w1OWA==
X-Received: by 2002:a17:903:2c2:b0:182:df88:e6d3 with SMTP id s2-20020a17090302c200b00182df88e6d3mr59091478plk.81.1667975720556;
        Tue, 08 Nov 2022 22:35:20 -0800 (PST)
Received: from localhost.localdomain ([47.246.101.63])
        by smtp.gmail.com with ESMTPSA id u7-20020a170902e5c700b00174d9bbeda4sm8135318plf.197.2022.11.08.22.35.18
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Nov 2022 22:35:19 -0800 (PST)
From:   Teng Long <dyroneteng@gmail.com>
X-Google-Original-From: Teng Long <tenglong.tl@alibaba-inc.com>
To:     avarab@gmail.com
Cc:     dyroneteng@gmail.com, git@vger.kernel.org,
        tenglong.tl@alibaba-inc.com
Subject: Re: [PATCH v2 1/3] notes.c: introduce "--blank-line" option
Date:   Wed,  9 Nov 2022 14:35:14 +0800
Message-Id: <20221109063514.93202-1-tenglong.tl@alibaba-inc.com>
X-Mailer: git-send-email 2.38.1.386.g72e528ee3df.dirty
In-Reply-To: <221108.86pmdxshkt.gmgdl@evledraar.gmail.com>
References: <221108.86pmdxshkt.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Ævar Arnfjörð Bjarmason" <avarab@gmail.com> writes:

> Sorry, I meant that in both cases it will expose the same options to the
> user: --blank-line and --no-blank-line. I.e. if you create options
> named:
>
> 	"x" "x-y"
>
> Their negations are: --no-x and --no-x-y. But if their names are:
>
> 	"x" "no-x"
>
> The negations are:
>
> 	--no-x and --x
>
> But as your example shows that's unrelated to whether the *variable in
> the code* is negated.
>
> So however you structure the code, which would be:
>
> 	int blankline = 1:
>         [...]
> 	OPT_BOOL(0, "blankline", &blankline, [...]);
>
> Or:
>
> 	int no_blankline = 0:
>         [...]
> 	OPT_BOOL(0, "no-blankline", &no_blankline, [...]);
>
> The documentation could in both cases say:
>
> 	--no-blankline:
> 		describe the non-default[...]

Thank you for the detailed explanation, now it's clear for me.
