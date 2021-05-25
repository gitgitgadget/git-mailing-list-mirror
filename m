Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2F96C2B9F8
	for <git@archiver.kernel.org>; Tue, 25 May 2021 12:12:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E8BA61284
	for <git@archiver.kernel.org>; Tue, 25 May 2021 12:12:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232183AbhEYMOH (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 May 2021 08:14:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231865AbhEYMOG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 May 2021 08:14:06 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E12AFC061574
        for <git@vger.kernel.org>; Tue, 25 May 2021 05:12:35 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id w12so28136508edx.1
        for <git@vger.kernel.org>; Tue, 25 May 2021 05:12:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=9PQYVLUJdvJLwYyuFywNmBEiitmF/rvT9fUpOuib9yM=;
        b=A+DcyGUsU4JOEqVon5vITJDx3UuQW5zkwM7wkm6fqwX9iVpwdW5X5l60KLHY30jOyD
         i+w1rVDgs/TN9ZkObNuA3Zhpki+eMGuc+IvvmUw+4lBHGX+Ic723WVye7k+DhJ3r+cb8
         +6b1N5POgdlLlPLGWZVpLzhGmSlZ/m6qn48Z5VtbNPMyqW+tlMDRwDLKaAwIWJI7qcEN
         rmxJd7+ZzNG+CsZ0MvAsbMfdV16jAYejWRBCPLSrKwtAWE925tqeQAKY6yECa6XcI9kA
         R/SOZaIHmaNUinqB2NgSdCiNbcySlLLiFA2KhkmX1oNCkfNFupbowiDbdmlQlRu6lFt+
         V21g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=9PQYVLUJdvJLwYyuFywNmBEiitmF/rvT9fUpOuib9yM=;
        b=avj2neG5gGvreTFU4ZP15H/QOb4TM01/ZG9XRc3mn1vADjVK4scVKGkqb9jWGRlLNo
         kSY+kOSb91jmoPj+myEtgwOcuOIoa/2172tq5vDjjRJ1L1KkaNJwM7pUmhFPrANCIrLH
         tjsigRC2SMEPSUbSN1qoBVEUC0zYHaUiH/mXPvWTh0B2XYW1myZH3w90oT7wh2hT8/Jk
         M5OotSUbpIiWVkHqQ4jr1ZYwI8yzxT0N1xBCB55s6WhrOVaOPZCvj60xO2TDdDljVep+
         rBrnu4dewpTYrVmLPE3d1CxCFP+vOU8oLK7+TymxwLa0JK8qLN5m7cBLK2eymirlQvWb
         k+ew==
X-Gm-Message-State: AOAM532QS0L44qz2fqY90H1eB4VWHlak7MR2c1u3qexYkVTlDqBDFuRo
        rOInmTJEclTMMqM/J1F8CeQ=
X-Google-Smtp-Source: ABdhPJx3hDTPEKHUhfnVZV2x1wms5RpCLduxi2uFYuyIAbXyA6EhtQWOLWvhFwDMMMi/k2EdkQICVA==
X-Received: by 2002:aa7:c441:: with SMTP id n1mr31326972edr.6.1621944754366;
        Tue, 25 May 2021 05:12:34 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id y27sm8999236ejf.104.2021.05.25.05.12.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 May 2021 05:12:33 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Robert Foss <robert.foss@linaro.org>
Subject: Re: [PATCH 2/2] send-email: don't needlessly abs_path() the
 core.hooksPath
Date:   Tue, 25 May 2021 14:09:35 +0200
References: <bb30fe2b-cd75-4782-24a6-08bb002a0367@kdbg.org>
 <cover-0.2-00000000000-20210524T231047Z-avarab@gmail.com>
 <patch-2.2-d097e7b0b81-20210524T231047Z-avarab@gmail.com>
 <xmqqh7iripzg.fsf@gitster.g> <874kerny0e.fsf@evledraar.gmail.com>
 <xmqq35ubgwpy.fsf@gitster.g>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.5.12
In-reply-to: <xmqq35ubgwpy.fsf@gitster.g>
Message-ID: <87v977m2q6.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, May 25 2021, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>> The repo_path() function was introduced in c8243933c74, so it's never
>> been in a release, thus I think it's fine to alter its behavior.
>>
>> The code here doesn't need to concern itself with what needs to be
>> relative to what, you run send-email in some working tree directory (or
>> top-level), and depending on core.hooksPath we'll either return a
>> relative path to the .git/hooks or an absolute one, the system()
>> invocation will accept either.
>
> All of that are convincing, but I'd rather not risk it.  I'll take
> your 1/2 with J6t's fix, both of which are obvious and no brainer,
> but I am willing to take this 2/2 as a post-release clean-up next
> monght, though ;-)

Fair enough. I get that we're in the rc phase, but FWIW I still
disagree.

I do think supporting whatever edge case we're exposing by
round-tripping through abs_path() and its subtly different behavior is
worse than a change to make us rely on the well-understood rev-parse
behavior directly.

Especially since the fix is to something that didn't work to begin with
before the v2.32.0 release is out (core.hooksPath + send-email), but
perhaps that's more of an argument for reverting the topic during RC +
try to have it land in v2.33.0?

And that + what seems to be the prevailing (IMO nonsensical) opinion on
Git.pm's stability promise, meaning that once this new function is out
in a release we'll be stuck supporting it makes me want to change this
pre-release.

But I'll leave it to you, if you are convinced and do want to take this
2/2 after all I'll submit another trivial patch on top to remove the new
(then unused) repo_path function, which we expect to go away anyway.
