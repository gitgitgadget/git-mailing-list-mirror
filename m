Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2D85C1F597
	for <e@80x24.org>; Sat,  4 Aug 2018 16:48:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728695AbeHDSth (ORCPT <rfc822;e@80x24.org>);
        Sat, 4 Aug 2018 14:49:37 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43486 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728054AbeHDStg (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Aug 2018 14:49:36 -0400
Received: by mail-wr1-f68.google.com with SMTP id b15-v6so8262341wrv.10
        for <git@vger.kernel.org>; Sat, 04 Aug 2018 09:48:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=Pu4rso+5h1RHrivjhFPneFscBeyWx/ALKQjewNsnHXs=;
        b=mRIfwc1h4ZdiCFSkXJIKwE6ypLw+dUGmww4355ep5ImvIDeeqCEHQh4ZF3tKg2iM75
         h0m0FmCL8TsqAElb+MZTmMY/yZkV/0REHOdp+QoLySAHDz5uxoB9mpdM/mRxdwyaLv5K
         bkUX7azxbyBWW1RtxJzBRzjPFcVOuAP8Rf+ydd8nedN20xiQ3J3We3zyhL59J66K4nI4
         AzZd8/siHy/WIf8YlkzjJR3h9UtM5oIFeAjAnIKFT6FgtymixiBSbnOFkSP6toDfw6xB
         xECkjsDYObMVUAkNfZ7M2ik+ktylZseIvag6FmjTWLxhH80mzoqsFX451c5eqieM8+bI
         2Zrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=Pu4rso+5h1RHrivjhFPneFscBeyWx/ALKQjewNsnHXs=;
        b=mta1LdGgWtdGOZt2xLSJs1mRDb8kdxNooTuZUJpTwDxmLVGflidlrr0rk4WbxyBQAn
         QDhQKA8UIa/o+opPqCQbM3f9nUov8uDeyfadySTqsvcpVhAffofYu7cVnAuq5nsbF9Kz
         g3AOmS/p1xqQVVYD6uP0MWEvzkDXsOl0rnEvZkPdnckC44dwZJ4v66nXPr/Pn6E3Mnu+
         5XZ2iI2+0nPTv0J3HEiZQpu6Pr2bgBYa4gXReF66MtlGJqZYj1Yh7x2stJIH7kZ5HSO0
         FKcpa7LlXbQoQMYOMA+cwVFm4ChhaWi9D+i6UWg3RhXUlxxPypj3/+NJmBXtSx2Z8s1J
         nhgw==
X-Gm-Message-State: AOUpUlF/ILmZ6IA925os0O8AoEuOraX/w6i8TNaCUsy+6gPnXupLYvcm
        DhRostXakiB3OwVFp97d4Kezpt6J
X-Google-Smtp-Source: AAOMgpe5p6A1xsrZ6zruvSlODqZpUoCB0OyvBvUP0/5rOnMTn3s1R0QRs/RNS8fugrK0YKPaBnEKVQ==
X-Received: by 2002:adf:8103:: with SMTP id 3-v6mr5342175wrm.213.1533401299951;
        Sat, 04 Aug 2018 09:48:19 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id f18-v6sm5159935wrt.64.2018.08.04.09.48.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 04 Aug 2018 09:48:19 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Edward Thomson <ethomson@edwardthomson.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC PATCH 1/1] recover: restoration of deleted worktree files
References: <20180804142247.GA7@e3c0ce5ceb57>
        <20180804142416.GA6@5f28dc333bbd>
        <xmqqpnyyt9di.fsf@gitster-ct.c.googlers.com>
        <20180804161956.GA6@1032a7a09014>
Date:   Sat, 04 Aug 2018 09:48:18 -0700
In-Reply-To: <20180804161956.GA6@1032a7a09014> (Edward Thomson's message of
        "Sat, 4 Aug 2018 16:19:56 +0000")
Message-ID: <xmqqh8kat6wd.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Edward Thomson <ethomson@edwardthomson.com> writes:

> In any case, it sounds like you're not particularly interested in
> this, although I certainly appreciate you taking the time to suggest
> improvements despite that.  There's some good feedback there.

Not in its current shape.  But do not take this in a wrong way.  It
may be useful in a third-party script collection in its current
shape already.

More importantly, I am not opposed to have a "resurrect" utility in
the core distribution.  It just has to be a lot better than what
"grep -e 'I think I wrote this string' .git/lost-found/other/*"
gives us.

Filename discovery (perhaps from lost trees, which was the idea I
wrote in the message I am responding to, but others may come up with
better alternatibve approaches) is a must, but not primarily because
such a grep won't find the path to which the contents should go.
When a user says "I think I wrote this string in the file I am
looking for", s/he already knows what s/he wants to recover (i.e. it
was a README file at the top-level).  Filename discovery is a must
because grepping in the raw blob contents without smudge filter
chain applied may not find what we want in the first place, and for
that to happen, we need to have a filename.

	Side note.  That may mean that even working in the
	do-recover mode, the script may want to take a filename,
	letting the user to say "pretend all lost blobs are of this
	type, as that is the type of the blob I just lost and am
	interested in, and a filename will help you find an
	appropriate smudge and/or textconv filter to help me"

That makes me realize that I did not mention one more thing, other
than the "interactibve loop", I did like in the script over what
lost-found gives us: smudge filter support.  I do not very often
work with contents that needs clean/smudge other than in one project
(obviously not "git.git"), and I can see how it is essential in
helping the user to find the contents the user is looking for.

Thanks.
