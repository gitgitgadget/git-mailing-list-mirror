Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 826C7C433F5
	for <git@archiver.kernel.org>; Mon, 20 Dec 2021 18:13:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233646AbhLTSNW (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Dec 2021 13:13:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232777AbhLTSNV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Dec 2021 13:13:21 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC365C061574
        for <git@vger.kernel.org>; Mon, 20 Dec 2021 10:13:20 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id z29so41798570edl.7
        for <git@vger.kernel.org>; Mon, 20 Dec 2021 10:13:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=DJ8r8ZILI25EteII+qvc5ka02qo18dv5sG0tM2R8oco=;
        b=J+tDHngNCUEjwP0cEEaTAf9lhDuhSY3aR52EYV0MhatFI08PcQ6au/4nF7fllUTYqL
         zgW41z4xsN5uae2VZJcvijNCEAsiZlHa9VBNFxfuwg3yAP+4QOi+lm87BmuRpZOVrzMg
         xkE7OJo1m6lqqlc1PIk9HvtB20t84BYxRIWTNvalj+6ZUZDVesOXJgcML00PZzsk9WFr
         fGZJKWdPfss3Ce0Ljbr0GRgZlk7BruP0Ej8oYb7h6qCrLqYAN8w2lZEwg+TG8aQ5P1Pd
         X/1L0bNjTbCDmtzGO6NryfyZRBgu+EDJBZOpf8RAQnz8hpycb0Om1cb18J7OavfgtajS
         JxRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=DJ8r8ZILI25EteII+qvc5ka02qo18dv5sG0tM2R8oco=;
        b=If51H/ah68pJUbyKNXQTCP1BNDQuO4IbH5nQdZFnH702gN95IIyfobvKz/uk+zAmU/
         2jD+KXfIEAgvx71EAWpoXYnKtb5dKMw47Lngnbdy2fuzsFKOeexQG5qxkxE0wqAANlyx
         Vrupu2xKunGml0e4V5PxhwZns6vrdBYQuFjiZU2RA8JwllEoQm5eap98TY3I6ElTzxh9
         Ed+3A6EMcnrnGCk2kULgkVCDQHb5Ru5bHJDfyPo+pGO3IBgSkOXy/Yh8kOmKpLSZ9kPF
         m4FK6JMNJgX1XtUma5O8h72jo2oa0jUiucMtbg4d8q+1H4nGweXIpCPkCG6kh/Kq/FcN
         kygA==
X-Gm-Message-State: AOAM530az8lYXdynrvqVuQ4yKYyMnd+0QLRO+huCM1Sqx1/E2h8POV7L
        VqSobHTYv3Mohn8asslQUjo/JbW9nMqFTw==
X-Google-Smtp-Source: ABdhPJyz8mPakLUymQzBeskqBy60TW28JPK/d/+B94KPN9zLmujzqqWN6J5efV2XNcSseksl+AK9dA==
X-Received: by 2002:a17:907:72c2:: with SMTP id du2mr14599281ejc.155.1640023999015;
        Mon, 20 Dec 2021 10:13:19 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id g22sm3868998edv.70.2021.12.20.10.13.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Dec 2021 10:13:18 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mzN9x-000VoX-Uf;
        Mon, 20 Dec 2021 19:13:17 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] CI: remove support for Azure CI
Date:   Mon, 20 Dec 2021 19:05:31 +0100
References: <patch-1.1-eec0a8c3164-20211217T000418Z-avarab@gmail.com>
 <nycvar.QRO.7.76.6.2112201834050.347@tvgsbejvaqbjf.bet>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <nycvar.QRO.7.76.6.2112201834050.347@tvgsbejvaqbjf.bet>
Message-ID: <211220.864k73uoua.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Dec 20 2021, Johannes Schindelin wrote:

> Hi =C3=86var,
>
> On Fri, 17 Dec 2021, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>
>> Remove various code required to support Azure CI. Recently in
>> 4a6e4b96026 (CI: remove Travis CI support, 2021-11-23) we removed the
>> Travis CI support, which was last used in June 2021.
>>
>> The supporting infrastructure for Azure CI was already partially
>> removed in 6081d3898fe (ci: retire the Azure Pipelines definition,
>> 2020-04-11). As that commit notes:
>>
>>     We have GitHub Actions now. Running the same builds and tests in Azu=
re
>>     Pipelines would be redundant, and a waste of energy.
>>
>> This follow-up removes the relevant Azure Pipelines-only supporting
>> code. Most of it was added in commits merged as part of
>> 57cbc53d3e0 (Merge branch 'js/vsts-ci', 2019-02-06).
>
> It feels premature to remove the remnants of Azure Pipelines support
> already now. It would be better to hold off a little, as much fun as
> deleting and refactoring code may be for some of us.
>
> The reason is that there are still some things that Azure Pipelines can do
> that GitHub workflows cannot, for example:
>
> - present the logs of failed tests in an intuitive manner,
>
> - re-run _only_ failed jobs.
>
> At this stage, I am not convinced yet that we should bet completely on
> GitHub workflows.

I think these concerns should be addressed by the rest of the commit
message that follows the paragraph you quoted.

I.e. I'm not deleting this for fun, but because certain improvements to
test-lib.sh require patching the JUnit emitter.

Since there is no current user of it or a way to test it against a
working CI mode such changes are harder to make and to review.

Those changes being things I've got locally that achieve some of the
same aims you note here. I.e. getting guaranteed machine-parsability of
the test-lib.sh TAP output, to e.g. present failing tests intuitively.

My 707d2f2fe86 (CI: use "$runs_on_pool", not "$jobname" to select
packages & config, 2021-11-23) also shows that by removing these dead or
unused modes it becomes easier to make the CI less GitHub-dependant.

I'd like to follow-up with that and e.g. make the "install *.deb
packages" step of CI be something you can trivially invoke via a
corresponding "make" target, and generally make the commands and checks
we run in CI a much thinner wrapper for targets you can easily run
locally without mocking up a bunch of fake values for ci/lib.sh
first. The changes in ci/* here are a small step towards that,
i.e. fewer (and in this case, not easily testable) special-cases we need
to worry about.
