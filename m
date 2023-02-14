Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB81BC6379F
	for <git@archiver.kernel.org>; Tue, 14 Feb 2023 22:36:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232034AbjBNWgn (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Feb 2023 17:36:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232031AbjBNWgi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Feb 2023 17:36:38 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEA9C305EB
        for <git@vger.kernel.org>; Tue, 14 Feb 2023 14:36:37 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id u75so11251087pgc.10
        for <git@vger.kernel.org>; Tue, 14 Feb 2023 14:36:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jOwzXFdgED1iiCAEF9yTJFihF9OhJw7KajDjHlOjwn0=;
        b=Q6cZuCbkDhYdvOnDFspzGhzicE5z8B331yATERBVoAMLY2usKI+ZrlxXB1lU+/mayD
         6m7NmIzb2L9TG4WSOXRPKb6vuIYqKFDNAYRWbeqFHdYHC1kEerh/VMAoya4lDRtn/OMD
         3yAHz42ihGB60nqOxejYkv7AGzC170IPtAlnifdnKi/sFROJmZmB+9rXwCCrr7bgo6nT
         1HDjlFwfZNq7rANSALWw1WP/VuwE/F+2QIIQRf5as6v+3BtuZCbn7MjEcsscLBan1Tfb
         EWvqkHssKbkqGQdifzqjPCvmMgBzPOxU8Lg4LZqqzgqb/l+vUTWbzuFPKRWtD/OHabyj
         bvXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jOwzXFdgED1iiCAEF9yTJFihF9OhJw7KajDjHlOjwn0=;
        b=zX3TvHh+TPnAVpUDc9kExRHVNZavQWyLxYSetb8lXRChUq582lGvutb2lniMOxrpLH
         vxnIcdiIXzfMUtkKcdlhDBygZ2K7IXutevNb9/ucqFO9EWem525WDfEpZ+/rWLtXRoFE
         GMRWTwPTP9Sm1hvkCIWQWPkgv542s1DuWnDK9vQlqqJeKhMyx3BsE9UeHkXPaKGkdPNP
         aL0jNcXLPuOZbuCcP7dkjkfins2MdQvm2CGEB/5ZSKxMy5nhF0SUt1ZYvN0grqs5z6HE
         kchJ/VP3RW6fFNC51KWMbOLYQFC2Vm3D2pQ35dD3h+TF+NQZ+qCjABj4MV5CELMOXTP/
         rlxQ==
X-Gm-Message-State: AO0yUKWM7eqOH2O4kwRC7YG3vB/rADGPEiMH0XOkRWQD4T5KPyXdurcZ
        2vCrPqGbI4bXgyDJANIhg3ng4YKHpCUX5HCm0QI=
X-Google-Smtp-Source: AK7set8nqp3SSWNNGgZIdsd4NDlt2JcKaIwogtmN4a1bL28M24ef/v8s/2hx/W95omQ607c6D6rMn/97wf2Hiev0zQk=
X-Received: by 2002:a62:1d57:0:b0:5a8:bf27:74c8 with SMTP id
 d84-20020a621d57000000b005a8bf2774c8mr748472pfd.28.1676414197146; Tue, 14 Feb
 2023 14:36:37 -0800 (PST)
MIME-Version: 1.0
References: <pull.1443.v2.git.git.1675244392025.gitgitgadget@gmail.com>
 <pull.1443.v3.git.git.1675545372271.gitgitgadget@gmail.com> <xmqqmt5h80s8.fsf@gitster.g>
In-Reply-To: <xmqqmt5h80s8.fsf@gitster.g>
From:   M Hickford <mirth.hickford@gmail.com>
Date:   Tue, 14 Feb 2023 22:36:01 +0000
Message-ID: <CAGJzqs=t7k2zRKKq9xN-Avbo2uXgqsg7i0Utfv-ee6yZ2CWNDA@mail.gmail.com>
Subject: Re: [PATCH v3] credential: new attribute password_expiry_utc
To:     Junio C Hamano <gitster@pobox.com>
Cc:     M Hickford via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Jeff King <peff@peff.net>, Cheetham <mjcheetham@outlook.com>,
        Dennington <lessleydennington@gmail.com>,
        M Hickford <mirth.hickford@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 14 Feb 2023 at 01:59, Junio C Hamano <gitster@pobox.com> wrote:
>
> "M Hickford via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > From: M Hickford <mirth.hickford@gmail.com>
> >
> > Some passwords have an expiry date known at generation. This may be
> > years away for a personal access token or hours for an OAuth access
> > token.
> > ...
> >  t/t0300-credentials.sh             | 94 ++++++++++++++++++++++++++++++
>
> https://github.com/git/git/actions/runs/4169057114/jobs/7217377625
>
> Other platforms seem to be OK, but Windows test seems to be unhappy
> with it when this topic gets merged to 'seen'.

Curious, let me take a look. I see that the tests failed on freebsd too.

I don't have a Windows machine to debug. If anyone reading has a
hypothesis, please share.

I shall try changing the default value for a password without expiry
from TIME_MAX to 0, see if that works any better [2].

[1] https://github.com/git/git/pull/1443/checks?check_run_id=11112315291
[2] https://github.com/git/git/pull/1443/checks?check_run_id=11343677685
