Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C5B231F453
	for <e@80x24.org>; Mon,  5 Nov 2018 12:29:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729105AbeKEVtP (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Nov 2018 16:49:15 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52298 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727337AbeKEVtP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Nov 2018 16:49:15 -0500
Received: by mail-wm1-f65.google.com with SMTP id l66-v6so2000006wml.2
        for <git@vger.kernel.org>; Mon, 05 Nov 2018 04:29:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=wnLpTm/mjZD5nkpPiu5NRtXfnT6m4W4ENC2rOTxKRA4=;
        b=HFBztQY24m/rJwalNOgNTfv16dnlsHIjjgHXteMQGQeExYB1oTqEjxVJDUQbxuyRCO
         BhhbUsiYsq3OHyyLfFzvViyWfniV5K9sFooGjcxbQJiC0sIT2hrQzNlXD+YSjTYZSE8A
         4IwTst+jEh7WLz+SYEhqWgJ2nXv+TPBVVLaBGe68HJN/0ieIoxGdIvFEb+xVKL2J5VMk
         FcjSfCm8T/7kC587v6sVLhmTlhqZeO8kBSJj11TAUwg8K6FWKzJE3R4Bxn1d9npg+GFw
         GHs/PuF1vjak3+/oY7NVv3youzz6Q049sMPjeDkpiJdtktEZY7KSc9crP0GNsqvIQSdz
         hONA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=wnLpTm/mjZD5nkpPiu5NRtXfnT6m4W4ENC2rOTxKRA4=;
        b=EwRJqC1D1RTTcn7k5VFxjnsO+ZfbEwyIBDwR1byzPXVVW+iCNOZXQhZ9L7Kg2VgX5R
         IRWGfDlvhPHPunEc7pc8F83+l58+mnB5hnkQ3XPiqTUib/VOHh9WLsCOmIvXpV4F6Nyo
         s+a/ornnF7iX8qTwKYQkGjulllCKxm9QILE/jdFv8XidfqYTzTv6D6KGn2jzQ+Lyz2lW
         XZGz30BVFf9Pkb/ro75LIYUHp07ZYOVV0/fhr1jWDN5OkdC2bemYOKCMMcR03gH8e2as
         JsZ5EaAD2cgNe7+k+vv505tbMLril0D+j6qSI3B9jkpQ0VI3rpuhCyBkkla2YClsxOxq
         NMdA==
X-Gm-Message-State: AGRZ1gJuRxXImlR2trQzTvRr/sMb2E292EScD4Qk0K79cdGcmTcXC0fs
        4DqNYyRhQwmA4x66YypdUus=
X-Google-Smtp-Source: AJdET5f+jqgyubGRQdR4gQCXgxquYoPVwIuJCed7dVpv5aikqx41r4q+Ygw8tU7Ge7i9abmVh7aJ5Q==
X-Received: by 2002:a1c:b5ce:: with SMTP id e197-v6mr5890370wmf.30.1541420980952;
        Mon, 05 Nov 2018 04:29:40 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id x197-v6sm44199940wme.15.2018.11.05.04.29.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Nov 2018 04:29:39 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH v3 7/8] push: add DWYM support for "git push refs/remotes/...:<dst>"
References: <20181026192734.9609-1-avarab@gmail.com>
        <20181026230741.23321-8-avarab@gmail.com>
        <xmqqlg6h4964.fsf@gitster-ct.c.googlers.com>
        <87in1lkw54.fsf@evledraar.gmail.com>
        <xmqqy3adtopw.fsf@gitster-ct.c.googlers.com>
        <87k1lr7obd.fsf@evledraar.gmail.com>
Date:   Mon, 05 Nov 2018 21:29:38 +0900
In-Reply-To: <87k1lr7obd.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Mon, 05 Nov 2018 12:31:50 +0100")
Message-ID: <xmqq4lcviu6l.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

> After all sometimes "other" is just the repo on my laptop or server. I
> shouldn't need to jump through hoops to re-push stuff from my "other"
> repo anymore than from the local repo.
>
> Yes refs/remotes/* isn't guaranteed to be "other repo's branches" in the
> same way our local refs/heads/* is, and this series bends over backwards
> to check if someone's (ab)used it for that, but I think for the purposes
> of the default UI we should treat it as "branches from other remotes" if
> we find commit objects there.

I do not think there is *any* disagreement between us that
refs/remotes/* is where somebody else's branches are stored.

The fundamental difference between us is what this "push" is doing.

You are limiting yourself to a single use case where you push to
publish to the remote repository, as if the work on somebody else's
commit were exactly like your own, hence you believe the push should
go to refs/heads/* of the receiving repository.

I am also allowing an additional use case I often have to use, where
I emulate a fetch done at the receiving repository by pushing into it.
I have refs/remotes/* by fetching somebody else's branches locally,
and instead of doing the same fetch over there by logging into it
and doing "git fetch" interactively, I push refs/remotes/* I happen
to have locally into refs/remotes/* there.

And I happen to think both are equally valid workflows, and there is
no strong reason to think everybody would intuitively expect a push
of my local refs/remotes/* will go to refs/heads/* of the receiving
repository like you do.  I'd rather want to make sure we do not make
wrong guesses and force the user to "recover".

> So I think the *only* thing we should be checking for the purposes of
> this DWYM feature is what local type of object (branch or tag) we find
> on the LHS of the refspec. And if we're sure of its type push to
> refs/{heads,tags}/* as appropriate.

That is insufficient as long as you do not consider refs/remotes/*
as one of the equally valid possibilities that sits next to refs/heads
and res/tags/.

