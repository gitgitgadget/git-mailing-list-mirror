Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 028F3C433EF
	for <git@archiver.kernel.org>; Tue, 12 Jul 2022 20:48:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230222AbiGLUsQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Jul 2022 16:48:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233504AbiGLUsK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Jul 2022 16:48:10 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4429854667
        for <git@vger.kernel.org>; Tue, 12 Jul 2022 13:48:09 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-31c9d560435so79036627b3.21
        for <git@vger.kernel.org>; Tue, 12 Jul 2022 13:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=xfqFkAKDr50ukYcTwVb/k2yKE3zzvuWndi9ob2oDupM=;
        b=V/e71Ak4S03iqPNvOOfttNxItert+w1km/Kk6blIAGKBJ+JO/17aJCu/RIupBsx9Wb
         f0RtPdjDpractB578gAgC4dBVS+A8P1qdswcYb4cQQ1RJkfJaI+p1aQm6N9OWCwSVgza
         Mx1L5lBR/x+3kvTvXtKapNA+mU/mcWmXvjkbgF+BUb6b0/mCTbI+AwOEZnsSLfXBOEBf
         +w9W4bwsSMw3yIF3m10M6kSiMLMmQBj0FO1t+mp2lPGLcpMvZxjIRtHUG7t7yiH2kc1K
         IkNyAVUxSIuLSi3gjfAgI2mvysn2GC1AKASMo6JMGOyI+BZGHfdDP+bUxxvukzjqSiG+
         hEGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=xfqFkAKDr50ukYcTwVb/k2yKE3zzvuWndi9ob2oDupM=;
        b=t3+EMJBJekkHYTnHQ0b9943V3K1vUPeCkOcAClRgN5RExfUzhkpeXlh2dq6wjb9DN+
         VC2+VL9TK+on5xpoxuxt9wHyDi3fwlIrwdzzzcEeM2e3KBEur2K4GaPlyjP5dDO6Feo+
         c2sVLQMdtYVxmZe6wdM7ldhK1NaQTxz45F8/qA0K38OBfjYa3g5CerMcktNS9BykKLfG
         tqCHLDMqqr2UjreRJiQSM9OrGG3JuizW3cJk2/MBqxxHKWWCIAyehZZOyUGwBX0eBrt1
         051Dy6mbsoDy23ffcYJfTIqxh/1VR20OvyprIGPVcblobzmcIzjT6ktVAWtJ4gf5s5fS
         VptA==
X-Gm-Message-State: AJIora/PchfR8JJRHIeu/Wg83YPw1ZHOM701YriigZrHcL2eE1gqyHgO
        U/3D0MFLcFd2IRlj9igslvrK72Oe5spfMQ==
X-Google-Smtp-Source: AGRyM1vHxCbq+fTMpqjEbLVIfjesZ5wObpki2c2CVgtfWsWk/0dDwd8gVd0YRB6+5dP7PQAE39PTclVmOVGGpg==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a25:910f:0:b0:66e:ca44:9463 with SMTP id
 v15-20020a25910f000000b0066eca449463mr182974ybl.0.1657658888555; Tue, 12 Jul
 2022 13:48:08 -0700 (PDT)
Date:   Tue, 12 Jul 2022 13:47:59 -0700
In-Reply-To: <220709.86zghj8d6i.gmgdl@evledraar.gmail.com>
Message-Id: <kl6lv8s25a80.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <pull.1261.v5.git.git.1656354994.gitgitgadget@gmail.com>
 <pull.1261.v6.git.git.1656612839.gitgitgadget@gmail.com> <220701.861qv5d8v7.gmgdl@evledraar.gmail.com>
 <kl6lr134spi0.fsf@chooglen-macbookpro.roam.corp.google.com> <220709.86zghj8d6i.gmgdl@evledraar.gmail.com>
Subject: Re: [PATCH v6 0/5] config: introduce discovery.bare and protected config
From:   Glen Choo <chooglen@google.com>
To:     "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>
Cc:     Glen Choo via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Thanks for following up. I'm a concerned that this thread will be
unproductive if all we're doing is reiterating our own opinions. I'm ok
if the conclusion is "agree to disagree", but let's not spend too much
time talking circles around one another (myself included, of course:)).

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> On Fri, Jul 01 2022, Glen Choo wrote:
>>> The "more narrow" and "more secure" go hand-in-hand, since if you work
>>> on such servers you'd turn this to "always" because you want to read
>>> such config, but then be left vulnerable to the actual (and muche rarer=
)
>>> exploit we're trying to prevent.
>>
>> The point that we're not defending bare repo users is fair, but maybe
>> the group we're trying to protect isn't really dedicated Git-serving
>> servers. This exploit requires you to have a bare repo inside the
>> working tree of a non-bare repo. So I think this is less of an issue for
>> a server, and more for "mixed-use" environments with both regular and
>> bare clones.
>
> Yes, but this is only something that's even a question because of an
> artificial limitation your proposal here suffers from.
>
> I.e. in trying to detect nefarious repos where you've got "looks like
> bare" content *tracked* in another repo you're conflating it with *any
> bare repo*.
>
> And the only reason we're doing that seems to me to be a premature
> optimization.

Right, I hear you. Besides performance, let me offer the perspective
that I should have led with in the previous email. In this thread and
the original "embedded bare repo" one [1], there is a huge diversity of
opinion on what the default behavior should be, e.g.:

- How do we detect an embedded bare repo (fsck check? walk up [and check
  if it's tracked]?)
- What to do when we detect one (ignore the config? block the repo?)
- How to preserve workflows that rely on embedded bare repos (some kind
  of (global|per-repo) exception list? allow the repo but not the
  config?)

And rightfully so! There are a lot of options here, so we want to make
sure we get the defaults right. But at the same time that implies a
pretty slow, difficult process.

On the other hand, I haven't seen nearly as much disagreement on "just
refuse to work with bare repos" because it's so restrictive that it
probably won't be the default. So it'll have no effect on most users,
but still confers protection for the subset of users who can benefit
from it. For those who want the problem fixed _today_ (e.g. my
employer), this seems like simple, low-hanging fruit that buys time for
us to find good default.

FWIW, when time permits I'd be happy to work on that good default (which
will probably be some variant of "walk up"), and to pay off the tech
debt introduced by this implementation (I have some ideas about how we
could improve the config API to achieve this [2]). Hopefully that helps
allay some of your concerns?

[1] https://lore.kernel.org/git/kl6lsfqpygsj.fsf@chooglen-macbookpro.roam.c=
orp.google.com
[2] https://lore.kernel.org/git/kl6lr13fi9qn.fsf@chooglen-macbookpro.roam.c=
orp.google.com
