Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A17A2C433F5
	for <git@archiver.kernel.org>; Wed,  5 Oct 2022 19:22:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230489AbiJETWe (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Oct 2022 15:22:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230462AbiJETWX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Oct 2022 15:22:23 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 850DE38A16
        for <git@vger.kernel.org>; Wed,  5 Oct 2022 12:22:22 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id b5so16079071pgb.6
        for <git@vger.kernel.org>; Wed, 05 Oct 2022 12:22:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x6n+DgqI/RRCCg0jjW+RxracjeFKqcB2JvMzhiVFVzw=;
        b=jmus6ThaB7mjKSARNchGE19NcSQtqq9v3IVRae2lWym0OzmtXU4PaUMIksOHvgTm0i
         NTBpTuFA7qLUYICQKVOzIcMTHi4hdHqba1No2X2H/huuNrGAju99tLAhCUUkqCY6BRIA
         VD1S9APII0afSpB6b9SwiYoMP20l+k02R8aJjQj5YMg7fHlObIQfG8CPUcs3OpTEB66x
         vQdBOATGFv1nkJDxDKPJBUSqvbH9p+zbkiHzm5XE+WoryzzZIla97pYNdrN7RqfHN8S4
         OL/3GskvCDKG+7qYg20LkukzA9j8c33ES01dsWEGqnNLU71Dui6Ejtm5iBo4BE1CaLHb
         5nnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x6n+DgqI/RRCCg0jjW+RxracjeFKqcB2JvMzhiVFVzw=;
        b=xjIgRX+f7MTZ2bZ+bGX58WenZ9UgPh/imziAjoGa90k6zfroNsW8JDpI+kVKjVPbUc
         KFyeY5VuWf77DT5dZGa6hGMCWLfbIYMVhBZIkTW1qLvUt3UQdBOzauj/eTVtkHsC/yvZ
         B99am1su3lA9/WyKDxmhPVSNFD+YEd/QcTivMQ1avD2S6P6qz6DiizTYIo3MDrDjizI+
         a7pJlQwXtiByEWJqr2hA4Vhb1FQW6Z5KXyXkYogCZB06ZcP2i2hoPDhgp9iYJRZWSPQC
         pe23VVaHhaUr+720CUVBgziQD4AffRp6jl2C/AqDln4HtPz1dnY5MDaq0Mk7ukh68U3u
         cP7Q==
X-Gm-Message-State: ACrzQf29MigR4WDp6mgSYu9DdZ5z0puiKUwgXb3IigC+HgCXSuvz6qV/
        iG5okqqIIn69sWP5CKlWW3Q=
X-Google-Smtp-Source: AMsMyM7VAQv3376BJ2VW71SxpCET9pxOjclveJjd8A+i6ssmqF46WCUhh3dMwuiCMmvmV5JHI410gQ==
X-Received: by 2002:a63:ed01:0:b0:445:4345:4a21 with SMTP id d1-20020a63ed01000000b0044543454a21mr1160995pgi.404.1664997741889;
        Wed, 05 Oct 2022 12:22:21 -0700 (PDT)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id x1-20020a623101000000b0056164b52bd8sm6301754pfx.32.2022.10.05.12.22.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Oct 2022 12:22:21 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Thomas Braun <thomas.braun@virtuell-zuhause.de>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [ANNOUNCE] Git v2.38.0
References: <xmqqmtacu8bw.fsf@gitster.g>
        <c8d43514-6f78-387c-b5aa-0657c75d5b4e@virtuell-zuhause.de>
Date:   Wed, 05 Oct 2022 12:22:20 -0700
In-Reply-To: <c8d43514-6f78-387c-b5aa-0657c75d5b4e@virtuell-zuhause.de>
        (Thomas Braun's message of "Wed, 5 Oct 2022 11:39:11 +0200")
Message-ID: <xmqqlepuoz2r.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thomas Braun <thomas.braun@virtuell-zuhause.de> writes:

> On 03.10.2022 19:26, Junio C Hamano wrote:
>
> Hi Junio and Ævar,
>
> the last git release has
>
>> submodule--helper: remove unused "list" helper
>
> in the shortlog which is 31955475 (submodule--helper: remove unused
> "list" helper, 2022-09-01).

X-<.

> Now the inevitable "I'm using this in production since 5 years and now
> it's broken" has happened.

X-< again.  Next time when you are using unsupported implementation
detail, please report when the potential breakage is still in 'next'
and not down in 'master'.

> Just for the record "git submodule status" is a good replacement for
> my case. I happen to need it on Windows using a CMD shell.
>
> Is there a general rule that commands which have "--helper" in them
> should not be relied on?

A good rule of thumb is to consider anything with double-dash as an
implementation detail that are not end-user facing, I would say.

Thanks, and sorry for the breakage.
