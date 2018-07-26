Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D96F6208E9
	for <e@80x24.org>; Thu, 26 Jul 2018 16:49:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732293AbeGZSHN (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Jul 2018 14:07:13 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41495 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731732AbeGZSHN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Jul 2018 14:07:13 -0400
Received: by mail-wr1-f67.google.com with SMTP id j5-v6so2371570wrr.8
        for <git@vger.kernel.org>; Thu, 26 Jul 2018 09:49:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=PzylFF8UVZzGbGfL4syHp7WAQgn3yPMq0JQW7r7+TIA=;
        b=PvogO40ctOQQI3IkpPo33g/vmqxOgDetOAiszMJaYKGS6DI4XAH58I7MxVCqtGqatf
         R49Te8Dwi1nDYCyh/hVr+5IuUR77oNvAG6oII9/wdzJ4ZE1gnT6ac04+ziHRN6oqXZBH
         9fW6ATQGbFB7sm63qoJCxm00jPLtrSP3dGIDfa5U1fi/wgh0zUUv94TxPG8RXJeXw+/h
         7XBemwaGQOhu2EYhbVnS/qx51Y84oC/IplyL7GN2EYDetOEkFpA7jkIYNyjo3Xlq2Q70
         domPgt4O/R9QLSpO82fFRi5uRCtR0LtXnDyZ5iVIMwfrHoYvsuj1q1+rsSpVxCjDm9Id
         bwQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=PzylFF8UVZzGbGfL4syHp7WAQgn3yPMq0JQW7r7+TIA=;
        b=a4VGRDzW2doxx5zNWZ4VGIg/Ha+n149SsuU1qrM5klGT9j3YY5GoqUZfrDqwUzpJqe
         qBohWsPGtO0q5cxLg6cpme4mHmfAhKSCw1kwg7oaIUEWqHqaEgmSK/jW0Z2vfmufoh9I
         kr9MaH8+eoZfWlfkxoLuUOzFEHTg9gHT92tkRt3tvTQVp94Co9qhY5jBMvEeWf1fUw92
         fAt1BHlhxwSzlvCO3LqeBpDmpOMQprJugGX5IwfsBj8FOViyA85MuznU0OHtbJyPiztK
         h/mhO53u2mOjYuAIHGT3KhadzqUog23HM4aowUKkmHYK/6TzZ1yHWPVEv3JzPzJqaOER
         khAQ==
X-Gm-Message-State: AOUpUlG7Sd6Yjh5GLfDOTOHa9M28EqDLzie6mOuOHQS0UW5dvGDy8jcj
        JeFLPqcEN5S2fV7rMru9GwDjduRw
X-Google-Smtp-Source: AAOMgpeAWIslFqcG3iWQCvFum5yTTTe2KBSCzHGTQkHOrzHyhSDgMoQiGkNpZsKMTjFZZxG3Ni1Nzg==
X-Received: by 2002:adf:8f2e:: with SMTP id p43-v6mr2152562wrb.193.1532623772476;
        Thu, 26 Jul 2018 09:49:32 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id s24-v6sm1420697wmc.7.2018.07.26.09.49.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 26 Jul 2018 09:49:31 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH 2/2] travis-ci: fail if Coccinelle static analysis found something to transform
References: <20180723130230.22491-1-szeder.dev@gmail.com>
        <20180723130230.22491-3-szeder.dev@gmail.com>
        <CAM0VKjmqwByERhPZLqZfg6JNEEeMkKQU1XuD93aW+3yfc2gucA@mail.gmail.com>
Date:   Thu, 26 Jul 2018 09:49:31 -0700
In-Reply-To: <CAM0VKjmqwByERhPZLqZfg6JNEEeMkKQU1XuD93aW+3yfc2gucA@mail.gmail.com>
        ("SZEDER =?utf-8?Q?G=C3=A1bor=22's?= message of "Thu, 26 Jul 2018 11:08:28
 +0200")
Message-ID: <xmqqy3dyq6w4.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER Gábor <szeder.dev@gmail.com> writes:

> On Mon, Jul 23, 2018 at 3:02 PM SZEDER Gábor <szeder.dev@gmail.com> wrote:
>
>> The only way to draw attention in such an automated setting is to fail
>> the build job.  Therefore, modify the 'ci/run-static-analysis.sh'
>> build script to check all the resulting '*.cocci.patch' files, and
>> fail the build job if any of them turns out to be not empty.  Include
>> those files' contents, i.e. Coccinelle's suggested transformations, in
>> the build job's trace log, so we'll know why it failed.
>
> And this is how it looks like "in action":
>
>   https://travis-ci.org/git/git/jobs/408269979#L570

;-)
