Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1E48C433FE
	for <git@archiver.kernel.org>; Fri, 19 Nov 2021 14:28:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C530061AD0
	for <git@archiver.kernel.org>; Fri, 19 Nov 2021 14:28:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235893AbhKSObc (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Nov 2021 09:31:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235888AbhKSObc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Nov 2021 09:31:32 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52E61C061574
        for <git@vger.kernel.org>; Fri, 19 Nov 2021 06:28:30 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id y12so43434416eda.12
        for <git@vger.kernel.org>; Fri, 19 Nov 2021 06:28:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=1x5fTKt+iUbFyvmrLmIxONDieVXV/TdczoFe1iztsr4=;
        b=fUO+htMhHaG3pd7lEpgccstsGOvZQAa4HG124ypDWopkWV6UqEAOr6QAyGr+NnKJh2
         YKAqlcvKP634xZJ+Z6+2sIrtRiZsOH92LyYPBfNHneRkkj79Q3OdQdEaFYyyafpTo8jf
         CSjCRaMoEU8q7+RAtoMAwN4u2UU0NsqVuxXj81PWcGB/G70hWbkDXpvNRA9Lsu7OWMhd
         ToLg1VqQk0uyUuMrDzT7mm9at7bXedoq3u4wnT/OGdhhRIvGwhLF+Exh7xCHLAYhzUbb
         GOFRSRyA+gaYeJzG6plN5g+A3bD2NbUc/sO3AEcgqWJ0OPZx2Ro8MucqwN5Xmy9ZR5RO
         oo5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=1x5fTKt+iUbFyvmrLmIxONDieVXV/TdczoFe1iztsr4=;
        b=4MlUgZu0fYcQiWmj4AGTVsPlV8JBe2LxU2wlfu91jwCoC6PXKfnPp1seBgxnuH3K3a
         E3lAKq1kYy3b8QTAO0dmhZ4sHklbYuJMiAQfTwrWB+YtEtm5zCak9DQfs/tYvtO5jSGq
         LIrfLcmv+aYLof4iPdx9bpczKzwvC4FblD7o40JxSNHaJLybxoQplibVYxFPk9bIO68A
         aA9T5rPFhxkdy7y5PYueSgKpJq+XATu9C7XLfBrdf0dw9JbAWfZkRo6jcDFMiQ7uM7Yu
         W6Tpb2JAAukO+PIvymUAJN2d03qrocNd93y1LhseyTf8adcG1PQ4Dhf6i/EdeJ0GONVn
         wIkQ==
X-Gm-Message-State: AOAM5323qjKFlOL6AUSAZio4nP9a+RxnXWVOHSJ8aLcH9WTdRXRfFe3e
        nxZ3vjhicP+djr5aJB8SU4o=
X-Google-Smtp-Source: ABdhPJwkFWRydzwQgeSj5HWWwgU7fYONf5BrifirCZFpmSge+tCLKZ0ztZtFMEChWp5gjZjByJmJtg==
X-Received: by 2002:a05:6402:1d52:: with SMTP id dz18mr826432edb.285.1637332108807;
        Fri, 19 Nov 2021 06:28:28 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id y17sm1736568edd.31.2021.11.19.06.28.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Nov 2021 06:28:28 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mo4sN-000kZH-MP;
        Fri, 19 Nov 2021 15:28:27 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Fabian Stelzer <fs@gigacodes.de>
Cc:     git@vger.kernel.org, Adam Dinwoodie <adam@dinwoodie.org>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/2] test-lib: introduce required prereq for test runs
Date:   Fri, 19 Nov 2021 15:26:00 +0100
References: <20211117090410.8013-1-fs@gigacodes.de>
 <20211117090410.8013-3-fs@gigacodes.de>
 <211119.865yso4a9y.gmgdl@evledraar.gmail.com>
 <20211119140953.cgdppgv3f64hqbdx@fs>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.9
In-reply-to: <20211119140953.cgdppgv3f64hqbdx@fs>
Message-ID: <211119.86sfvs2p9w.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Nov 19 2021, Fabian Stelzer wrote:

> On 19.11.2021 12:13, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>>
>>On Wed, Nov 17 2021, Fabian Stelzer wrote:
>>
>>> In certain environments or for specific test scenarios we might expect a
>>> specific prerequisite check to succeed. Therefore we would like to
>>> trigger an error when running our tests if this is not the case.
>>
>>trigger an error but...
>>
>>> To remedy this we add the environment variable GIT_TEST_REQUIRE_PREREQ
>>> which can be set to a comma separated list of prereqs. If one of these
>>> prereq tests fail then the whole test run will abort.
>>
>>..here it's "abort the whole test run". If that's what you want use
>>BAIL_OUT, not error. See: 234383cd401 (test-lib.sh: use "Bail out!"
>>syntax on bad SANITIZE=3Dleak use, 2021-10-14)
>>
>
> Hm, while testing this change i noticed another problem that i really
> have no idea how to fix.
> When a test uses test_have_prereq then the error/BAIL_OUT message will on=
ly be printed
> when run with '-v'. This is not the case when the prereq is specified
> in the test header. The test run will abort, but no error will be
> printed which can be quite confusing :/
> I guess this has something to do with how tests are run in subshells and
> their outputs only printed with -v. Maybe there should be some kind of
> override for BAIL_OUT at least? Not sure if/how this could be done.

It has to do with how we juggle file descriptors around, see test_eval_
in test-lib.sh.

So the "real" stdout is fd 5, not 1 when you're in a prereq.

Just:

    BAIL_OUT "bad" >&5

Will work, maybe it's a good idea to have:

	BAIL_OUT_PREREQ () {
		BAIL_OUT $@ >&5
	}

Sorry, I forgot about that caveat when suggesting it.
