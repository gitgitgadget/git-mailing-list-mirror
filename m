Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A3FF01F453
	for <e@80x24.org>; Mon, 29 Oct 2018 08:14:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729210AbeJ2RBu (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Oct 2018 13:01:50 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:35619 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725969AbeJ2RBu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Oct 2018 13:01:50 -0400
Received: by mail-ed1-f65.google.com with SMTP id e2-v6so6457417edn.2
        for <git@vger.kernel.org>; Mon, 29 Oct 2018 01:14:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=4wBmsi9iQNqjBsQdz9oxTwuV7Dgljc+RcbxG48oU4Q0=;
        b=WdkXUUiFqPVMIvoRhqCO5M17tGHqfMi8V064VDFoCRckVpfsW3DT5koTyFNdqwaHZ+
         FNUnTE+dv0FIEjgGIMRAJInWsYVcJ0NM7LB37bTqPhjU4irpWQwShZN1S+UReIYA3kbo
         GjW70gOvkev5V8sxdcaIf99sG8gq8Ca6SZ+8v9HSkgwgXSrufdqR32/yVEMEjkGcWMkA
         z46PWvbIbHsGYTZf1ul9Z8ojLvqe0/Gyffd/vsMQxP9ziIM/gBv5xxXPB5WZUDly0MYY
         jYGz9trGy+tvUYJRD9tz+7dxy4A6oN+R5whx/BEvuV+xJBXUtgD5wCQq4KeFj3EGnFqm
         52GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=4wBmsi9iQNqjBsQdz9oxTwuV7Dgljc+RcbxG48oU4Q0=;
        b=cxdYb/NUomGAC5rxWfYW3X3mFr6OpAmg67lZ0xhHLM3fGfQD0F1fxw+457EQQ8DXVn
         LyKAJZYp+jWyO6i4jV9Pty5TPElyUsxmcc8xtc7SH8aCgK0sOxa9TQssQepVH2TEe0YT
         Akn5sDdYaOoH+FYIymdOAs/C9gMq1WhDBrePzLxHv1jA7FP9eWBHXz6+PhBgzpOUVDu/
         Kkg04cHFoQq2UfUsDXQrRRr8WHR37vl9vAORb0xKX9XYe6HM+Q+DHfsiXdDfwYFA5X5N
         J66RTDF/6dYAtLPSBpiYDIfaYc3Qx7cLORXQdG7k6gFwEtx77jJwIpqS4mctPFiwWQ+D
         A6JA==
X-Gm-Message-State: AGRZ1gJh3WnePafSuYcOhlKHFBVlaPFpe4s3Csz7SMBlLPPIlXJjDo1R
        n8yfUEfbaES8vONWWfnx/sLObboSlaA=
X-Google-Smtp-Source: AJdET5f33srk+yJkWNBkbm6GJU40Y34UG8kOKn5m7DFbefQyJwsNBzNeDIGpxQ6zgrl7gV4i1yRRbQ==
X-Received: by 2002:aa7:d7ce:: with SMTP id e14-v6mr12260647eds.69.1540800854626;
        Mon, 29 Oct 2018 01:14:14 -0700 (PDT)
Received: from evledraar ([2a02:a450:3911:1:fd59:dbfe:7c38:41f0])
        by smtp.gmail.com with ESMTPSA id d18-v6sm2772250edq.53.2018.10.29.01.14.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 29 Oct 2018 01:14:14 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH v3 7/8] push: add DWYM support for "git push refs/remotes/...:<dst>"
References: <20181026192734.9609-1-avarab@gmail.com> <20181026230741.23321-8-avarab@gmail.com> <xmqqlg6h4964.fsf@gitster-ct.c.googlers.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <xmqqlg6h4964.fsf@gitster-ct.c.googlers.com>
Date:   Mon, 29 Oct 2018 09:13:59 +0100
Message-ID: <87in1lkw54.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Oct 29 2018, Junio C Hamano wrote:

> Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:
>
>> Add DWYM support for pushing a ref in refs/remotes/* when the <dst>
>
> I think most people call it do-what-*I*-mean, not do-what-you-mean.

FWIW I picked this up from the perl list where both are used depending
on context. I.e. DW[IY]M depending on if the sentence is one where you'd
describe things from a first or second-person perspective "I implemented
this to DWIM, and it'll DWYM if you invoke it as...". Also
"dwimerry"[1].

>> ref is unqualified. Now instead of erroring out we support e.g.:
>>
>>     $ ./git-push avar refs/remotes/origin/master:upstream-master -n
>>     To github.com:avar/git.git
>>      * [new branch]            origin/master -> upstream-master
>>
>> Before this we wouldn't know what do do with
>> refs/remotes/origin/master, now we'll look it up and discover that
>> it's a commit (or tag) and add a refs/{heads,tags}/ prefix to <dst> as
>> appropriate.
>
> I am not sure if this is a good change, as I already hinted earlier.
> If I were doing "git push" to any of my publishing places, I would
> be irritated if "refs/remotes/ko/master:something" created a local
> "something" branch at the desitnation, instead of erroring out.
>
> On the other hand, I do not think I mind all that much if a src that
> is a tag object to automatically go to refs/tags/ (having a tag
> object in refs/remotes/** is rare enough to matter in the first
> place).

Yeah maybe this is going too far. I don't think so, but happy to me
challenged on that point :)

I don't think so because the only reason I've ever needed this is
because I deleted some branch accidentally and am using a push from
"remotes/*" to bring it back. I.e. I'll always want branch-for-branch,
not to push that as a tag.

Of course it isn't actually a "branch", but just a commit object
(depending on the refspec configuration), so we can't quite make that
hard assumption.

But I figured screwing with how refs/remotes/* works by manually adding
new refspecs is such an advanced feature that the people doing it are
probably all here on-list, and would be the sort of users advanced
enough to either know the semantics or try this with -n.

Whereas the vast majority of users won't ever screw with it, and if they
ever push from remotes/* to another remote almost definitely want a new
branch under the new name.

1. https://www.urbandictionary.com/define.php?term=DWYM
