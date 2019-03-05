Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5B84020248
	for <e@80x24.org>; Tue,  5 Mar 2019 22:26:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727948AbfCEW0I (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Mar 2019 17:26:08 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42131 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726221AbfCEW0H (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Mar 2019 17:26:07 -0500
Received: by mail-wr1-f68.google.com with SMTP id r5so11204738wrg.9
        for <git@vger.kernel.org>; Tue, 05 Mar 2019 14:26:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=2IKhUa+wzmPzD06z7fH+Lj6Q22ZwTCUG1OZfv02mV3A=;
        b=nW0m5HsKfpjlKzozjjh0FvvNs3O/m3nF4nJ5AUWfe9bjCFwWtYGkZ5osxwQAG/F6zV
         /jyw8Lzvf0geLq3DB6YMl1RgtnsgCe/GmeKcebRrjWdbxo2W8YsjAXwAm5AtnyX9wRU4
         kjLOOUvEJ71Plwye6UQCGUFNu/WjZ0Y9h6Z6NXNU6ocOtuWW8igzcqh/DB6YZnw+k4iu
         59fpXBGwzCmlm7bFUqpjvdjqjwb4ijfQciN3S6eHCFOzCh+wA/r49kBMm9adJp+X+D6G
         kM61ZUZK1J3fkKYu2NjnJlj6rLO8BuF+zUirFxTSoYnvPrpy9q8+rjcmFgCC3bA+gafH
         bISA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=2IKhUa+wzmPzD06z7fH+Lj6Q22ZwTCUG1OZfv02mV3A=;
        b=KlXyG5VEacV2I8a7aDRGki2mMX0QIKQbRN/yBZjZ+jExUkTZPqVrJhL/hp2EfQizfO
         psdds4jnoV5xHxp9M/NMdxMTMzik9cUkQNNmkH/nUXQDhIVHn+t5xOj6MoUCFoYl1teB
         6ZqMGJXpjLyzAfsX+5aNL905y0SrRusTDsl5F/PVdRHSDj7SWoNwCY8qvqj0pJtnnr5p
         nTwCnfG4jG42MLALPWk+XCtl7D2BDtFyk7TmFJYiRmdX+azSc6BTnhMcjr/X/deh+Ksj
         Kkg7xUp/sBOvvnemcSfZJVqmu1pzIXERGmw0EpUxhHK13sCutPE5kIbfPzvUNU0ZwT/A
         3/XQ==
X-Gm-Message-State: APjAAAXezH1/arJaaQFGg79g3DgFx8KAjb1/04rq4udTro3TspR5aDt2
        49n8QdaU8y7F8SBb73tzt4A=
X-Google-Smtp-Source: APXvYqwUaBKh1IhG/NbjH022aar+TQuocGk8XZhlXhklZS+GHVYfAtEuIoWC2NZb4g0lbwU4RFAHSA==
X-Received: by 2002:a05:6000:8b:: with SMTP id m11mr655670wrx.243.1551824765654;
        Tue, 05 Mar 2019 14:26:05 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id e7sm16444718wrw.35.2019.03.05.14.26.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 05 Mar 2019 14:26:02 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Jeff King <peff@peff.net>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 1/1] Makefile: use `git ls-files` to list header files, if possible
References: <pull.130.git.gitgitgadget@gmail.com>
        <0b5529406b9458d37f3f5cdf38baa2d6a0a70a65.1551470265.git.gitgitgadget@gmail.com>
        <20190301213619.GA1518@sigill.intra.peff.net>
        <nycvar.QRO.7.76.6.1903022058230.45@tvgsbejvaqbjf.bet>
        <20190303171951.GD23811@sigill.intra.peff.net>
        <nycvar.QRO.7.76.6.1903041206300.45@tvgsbejvaqbjf.bet>
        <20190304214155.GB3347@sigill.intra.peff.net>
        <xmqqzhq9vpik.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1903051627050.41@tvgsbejvaqbjf.bet>
Date:   Wed, 06 Mar 2019 07:26:00 +0900
In-Reply-To: <nycvar.QRO.7.76.6.1903051627050.41@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Tue, 5 Mar 2019 16:28:45 +0100 (STD)")
Message-ID: <xmqqlg1tt0uf.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> After a normal build, with dynamic dependency checking on, we would
>> have sufficient information to figure it out.  Would that help?
>
> Yes, *if* the dynamic dependency checking is in effect (read: if we are
> compiling with GCC).
>
> However, I think that one of the benefits of the current approach is that
> hdr-check finds issues also in headers that are *not* part of the current
> build. Read: once hdr-check is run as part of the CI build, it is harder
> for some random contributor to break hdr-check for somebody else with
> different compile time options.

Sure.  That is exactly why we have multiple configurations at the
CI, hopefully more than each individual contributor has at hand so
that CI can give more coverage than any single individual can test.

What I was assuming was that at least one of these multiple
configurations would cover the case where sha256/gcrypt.h truly is
used, because that particular build is configured to use the system
header and library.  And it would be a far better approach to make
that build check also for the header, if we can cover all the
problematic (in the same sense as the sha256/gcrypt.h) header files,
than unconditionally "checking" without knowing the prerequisite and
causing a false positive.

Having said that, the optional use of ls-files introduced by the
patch in question is a valid incremental improvement over the
current Makefile, so it is a pretty much independent/orthogonal
issue.
