Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6EF0C433EF
	for <git@archiver.kernel.org>; Thu, 23 Sep 2021 13:59:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 879CB6109E
	for <git@archiver.kernel.org>; Thu, 23 Sep 2021 13:59:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241280AbhIWOAy (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Sep 2021 10:00:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241308AbhIWOAx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Sep 2021 10:00:53 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A594C061574
        for <git@vger.kernel.org>; Thu, 23 Sep 2021 06:59:21 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id c21so23723321edj.0
        for <git@vger.kernel.org>; Thu, 23 Sep 2021 06:59:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=B6eH7hkX4k1y805SsvAIhLOsu/yvKuQnP/lXst8OoDo=;
        b=iqg9xUzIUoPyx8y0vOWHGmoVeNSMui7GVEKYTU+u8+26rIstXf7+2LcLDIm+GIAd2r
         SgvJ9rI1LC1P9Y5ni5/UGcIYrJYl5jDXHM7c9C3e5k68rzQmrDGauDbezs/mNE9XG6DB
         HNOAH0lfpK55kj1/Boy+yNd537VQRw16yEv+9Cg57qjjbvkGLJX4gv8/YXFbGaOvVo7R
         u8OoqtvloCYxcn/fziWgiX2qUJfiL4ylQnzWGe6MVEoSjNtEi8u9aX63B+9nABgbi9rl
         b7KWsnV82AJ+ml4iEa2jLNlbBadGdZDkVUjQ6vtGn2RJf2t27HdmQklunbsMknOLJGQO
         myrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=B6eH7hkX4k1y805SsvAIhLOsu/yvKuQnP/lXst8OoDo=;
        b=kUGcBxWf6ie/um+6s8z2hBbsokpCfcYA0wRnsqQTdHi1XOUHPqKSRN5eVmYAqRuSkz
         iEJbeHRlCZaDAPYRUnRERlbPoe5I3HgT9NZ6ngIItYXlRkFNAyLebp6NJBlj5qG+lIr/
         nSn/qFennQ40tHJqkQ7RrRCPtB2jhO6BJsnqOwp6dizXRaw47BZrVQAnZeUUHmB/9Kb/
         yl2dNMoIZn+7NMueGonmxSs/MRoFRuIIvW9sP793zLh0DPB3QYmlFrx8BENfcFxV7fo3
         /ZoAqserSiSLHmerCikSlpFulJEqJBF5c4yBxT05gDrL/9caCs78mWBbAFTz1dUw2F3u
         IFjA==
X-Gm-Message-State: AOAM531285W+zOczZSK4ag+L3WsL30PcVtaUxGr44Lf80yths4fJGYZ+
        oYXYYyQkDM1Uk1kdT1pykKY=
X-Google-Smtp-Source: ABdhPJw/KlTlSJDqhnX8tP165ZVzLVVffyUhHYjr4HeQCz0RC7wJ8pXBnn50qhsOJ1uJqVLKOOv38g==
X-Received: by 2002:a17:906:5045:: with SMTP id e5mr5325283ejk.239.1632405558378;
        Thu, 23 Sep 2021 06:59:18 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id t14sm3094977ejf.24.2021.09.23.06.59.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Sep 2021 06:59:17 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Hamza Mahfooz <someguy@effective-light.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH 6/5] grep.c: mark eol/bol and derived as "const char *
 const"
Date:   Thu, 23 Sep 2021 15:56:21 +0200
References: <YUlVZk1xXulAqdef@coredump.intra.peff.net>
 <patch-1.1-c317e6e125e-20210921T124416Z-avarab@gmail.com>
 <YUnx7gt0KQNRlhuZ@coredump.intra.peff.net>
 <874kadapq1.fsf@evledraar.gmail.com>
 <YUowCkmWqKgIldNz@coredump.intra.peff.net>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <YUowCkmWqKgIldNz@coredump.intra.peff.net>
Message-ID: <874kab5r63.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Sep 21 2021, Jeff King wrote:

> On Tue, Sep 21, 2021 at 05:17:57PM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>
>>=20
>> On Tue, Sep 21 2021, Jeff King wrote:
>>=20
>> > On Tue, Sep 21, 2021 at 02:45:16PM +0200, =C3=86var Arnfj=C3=B6r=C3=B0=
 Bjarmason wrote:
>> >
>> >> I think that generally git's codebase could use going beyond just
>> >> "const char *" when a "const char * const" would suffice, for some
>> >> reason we seem to mostly use it for the static usage variables.
>> >
>> > I didn't dig up the references in the list archive, but I feel like
>> > we've had this discussion long ago. One of the reasons not to do so is
>> > that it pollutes the function's interface with internal details.[...]
>>=20
>> Are there cases in my conversion where the caller has to do anything
>> special that they didn't before? These are also all static functions, so
>> it's all internal details exported to nobody.
>
> No, they don't have to do anything differently. I just meant that it
> clutters the interface when a human is reading it.

Fair enough, to this human reading it (and I'm not new to the grep.c
code) I find myself trying and failing to mentally track what gets
modified where, but anyway, I think that point is understood and I won't
argue for it ad nauseum.

Just replied to say to Junio's <xmqqh7ec77s3.fsf@gitster.g> in the
side-thread:

> Yes.  "This pointer is not modified" is a good thing to have inside
> an implementation, but the callers should not have to care.

That I just don't understand, i.e. how the variable is defined in this
6/5 pertains to how it gets used /inside/ the function in this case, the
caller code doesn't have to care, but perhaps I'm missing something...
