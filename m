Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69C09C432BE
	for <git@archiver.kernel.org>; Wed, 25 Aug 2021 23:56:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 45A8A604DB
	for <git@archiver.kernel.org>; Wed, 25 Aug 2021 23:56:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233978AbhHYX5J (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Aug 2021 19:57:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231535AbhHYX5J (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Aug 2021 19:57:09 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3395C061757
        for <git@vger.kernel.org>; Wed, 25 Aug 2021 16:56:22 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id h9so2088930ejs.4
        for <git@vger.kernel.org>; Wed, 25 Aug 2021 16:56:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=0Iz2LGMTya9+S7x6S6wHQlRD8w8vgfXS0aAwxjldBL0=;
        b=UWtCjri36Lcvw1wTYieykqUelwMObKYFi8tKjQseLBdUN0PFqV+ZdcjRFL7aCshkbQ
         7PnLcxMd3ieAeQ1UwfOnWMvIdT/c1lu5J5wDE4/afzEWBOrU/Rq4z4LBWmTWLwYZEyrp
         idNa+kMXYLpRo05OXzCSva2D5kt3HbAHaMGw9KV+VzNc3SzYZEOTWyWrw+L9+0tNsErG
         MSDLNtXZreBTTyi37+iZFLfibnRY8hPPQtGkyRt/k3rNafYktMdex+4SDoy16oOJWiVD
         U+OiUe1F4HmkKEZpUdbrBCx6Dg17rcTJ3+bCZ7Q0Fzos2S/E4qf3Ggb0jnWamjmwsFpI
         xJWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=0Iz2LGMTya9+S7x6S6wHQlRD8w8vgfXS0aAwxjldBL0=;
        b=jkxEFH11Qq5hx1vBD3ierdtwwYn3EL6GIaaZduL3rciFsaMjSsCo5xusl+QZPPDeUC
         xOErLVTelXM583u74b+52Y9tpDn27fbW71Q5SahkQuTIhB16DBDdl1NotN8ZeLWWRQ8h
         O69sl9uqL8lS9N4jyeZ5AEwSBGKM79tjWqbAM481q9R568byBSOSO0V69tS6zhdLg/hu
         8x6fOR4Fqtw6/ii3fLH7+ru/+8A1rrNL5Qwwp1pbG6f5EiJH+cN1XcS4uVwQOhfQOXrA
         nbRheVqbAURLAhYGrPFFBuGLW8J48cG6HgPrRzjP14U2N2oJ/oPvaT4AUkOwsRSTVL+z
         xp7Q==
X-Gm-Message-State: AOAM532zs3X4A/hL6e2aGWOSXuJzzGlDPNBkKcbtk/bHEWmqiL4yCDzJ
        BSTz3wRAcMr2R0n3ud3wPVc=
X-Google-Smtp-Source: ABdhPJyuxIfawEwLjcFrqpEDitm0PUdCBDp0RCE32h5SB7kLe3MMagOge0BLGo+ipUIGmsJq+Etg6g==
X-Received: by 2002:a17:906:199b:: with SMTP id g27mr1208381ejd.517.1629935781365;
        Wed, 25 Aug 2021 16:56:21 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id v8sm737184edc.2.2021.08.25.16.56.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Aug 2021 16:56:21 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Teng Long <dyroneteng@gmail.com>
Cc:     gitster@pobox.com, git@vger.kernel.org, jonathantanmy@google.com
Subject: Re: [PATCH v5 06/14] t5702: replace with "test_when_finished" for
 cleanup
Date:   Thu, 26 Aug 2021 01:55:36 +0200
References: <cover.1629805395.git.dyroneteng@gmail.com>
 <f3b1cba7e102b3132f04b27be48e532da7d448c9.1629805396.git.dyroneteng@gmail.com>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <f3b1cba7e102b3132f04b27be48e532da7d448c9.1629805396.git.dyroneteng@gmail.com>
Message-ID: <87zgt5axjv.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Aug 25 2021, Teng Long wrote:

Thanks, much needed cleanup. I have an unsubmitted patch to do pretty
much this, plus some: https://github.com/avar/git/commit/27b3543c6ed

You might find the difference between the two interesting..

> -test_done
> +test_done
> \ No newline at end of file

More newline churn.
