Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E88621F516
	for <e@80x24.org>; Fri, 29 Jun 2018 17:57:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753318AbeF2R5n (ORCPT <rfc822;e@80x24.org>);
        Fri, 29 Jun 2018 13:57:43 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:36960 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752547AbeF2R5n (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Jun 2018 13:57:43 -0400
Received: by mail-wr0-f193.google.com with SMTP id k6-v6so9619810wrp.4
        for <git@vger.kernel.org>; Fri, 29 Jun 2018 10:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=OuVR+f0M9LJJn6bqUwM0Qdb77jNPuORay/EHxElkGoM=;
        b=bUn6mmue5FnbkxEdEzIdL7cXnkGNdC4VHznKiBhssHCwm/i9mzYpojxn4kPPWZrcAX
         rQxPXSEP/HrunS9Bj6oSzKZAI7SkCD6rmke0BnTYaXc+jNHJbauLWXLwgNv4WoWWmNax
         GHQhqQ1YXzgGSEC1yzFt9zm14AP2mmn4Vb48m7TwBuwKjLGCiloPAB9xDe9pVFYnyvfq
         tfFTBT1dyXEPwzqmQeEVxVGYnfE4HtwfQzLnieKEAkbCVd/fVohUHBXDKJKPbgkMqslR
         D7A/szhz5AQ/+W1XZI/n3vHV0FW6AJWsqhlb8/o84Jcirks4SwDFOt+OCHSIy5SHq1G+
         wvEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=OuVR+f0M9LJJn6bqUwM0Qdb77jNPuORay/EHxElkGoM=;
        b=lOphF2gcLq4eU3sQ6/IiqRaAjE+AhEHwEbRsHsyjl56ZoWHJzaZwKUmOe1OdQX8osD
         7M/vPSgeUpjcaD/EqG2/2YSBFD2WJHiAMw3vvW24sECVnsz1ngGrAc/81IH7wNObLf6b
         NX8fpfgMvNwCejDuzlNkcKQRne4tkx9q3V0WluHWn+LEHNoZOkARYUMmAw5RfIhvsXuZ
         y+45U/KzATEoDs3XzFqiwd88YYYoFqnDQuGWHF/N7wJaQB8qsYhy7bvCCN0H/csPhQ0c
         JBtM2FytF+hfCtYhEV6JyyY5sOaIDdr941W6w+3lx92CI/RbEgMPk8i/1Gjs5ARStiAj
         Xdfg==
X-Gm-Message-State: APt69E3asoNCRxjbuTjnEtJZEAkktDLQ1HFx25hylhnA3yvBaVaNyIdJ
        a/mwcQflyKV0rZ2/IvYylqU=
X-Google-Smtp-Source: AAOMgpcuCvy1PZ4hDcCqlNYkAyoWXgan44hn1TAYzJqEGvAyEVgrKukHvZ+yYlWGa2Q08veYcaA8OQ==
X-Received: by 2002:adf:87f1:: with SMTP id c46-v6mr12747525wrc.246.1530295061486;
        Fri, 29 Jun 2018 10:57:41 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id q140-v6sm2814238wmb.35.2018.06.29.10.57.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 29 Jun 2018 10:57:40 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v3 00/32] object-store: lookup_commit
References: <20180629012222.167426-1-sbeller@google.com>
Date:   Fri, 29 Jun 2018 10:57:40 -0700
In-Reply-To: <20180629012222.167426-1-sbeller@google.com> (Stefan Beller's
        message of "Thu, 28 Jun 2018 18:21:50 -0700")
Message-ID: <xmqq8t6xv5kb.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> This continues the elimination of global variables in the object store and
> teaches lookup_commit[_reference] and alike to handle a_repository.
>
> This is also available as
> https://github.com/stefanbeller/git/tree/object-store-lookup-commit
> or applies on top of 02f70d63027 (Merge branch 'sb/object-store-grafts'
> into next, 2018-06-28).
>
> Picking a base for this one is really hard, as nearly all series currently
> cooking or in flight collide with it on one or two lines. (lookup_* is used
> heavily, who would have thought?)

One technique these (not just this) recent efforts seem to be
forgetting is to introduce "new" names that take a_repo and then
make the existing one a thin wrapper that calls the new one with
&the_repo as the argument.

IOW, a new call to lookup_commit_reference(oid) in a function that
is happy to access the default repo (and notice taht 99% of our code
is happy with using just the currrent repository the user started
the git process for) does not need to be updated to call the
function with the same name with a different function signature
lookup_commit_reference(the_repo, oid).  If we name the new one
lookup_commit_reference_in_repo(r, oid) and make the callers that
already take a repo pointer call it, while leaving the callers that
do not even know or care about multiple in-core repo instances alone
to keep calling lookup_commit_reference(oid), you do not have to
worry too much about colliding.  That way, you do not have to step
on each others' toes with avoidable semantic merge conflicts and
incrementally improve things over time, no?

Thanks.
