Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 91BBC1F97E
	for <e@80x24.org>; Wed, 10 Oct 2018 02:14:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727181AbeJJJen (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 Oct 2018 05:34:43 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43007 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726976AbeJJJem (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Oct 2018 05:34:42 -0400
Received: by mail-wr1-f66.google.com with SMTP id g15-v6so3835628wru.9
        for <git@vger.kernel.org>; Tue, 09 Oct 2018 19:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=NaLDYCMpJ1x8HAAEg7g5c7Q6aW3snskC8wUk9+xI5KA=;
        b=b7ADJzlKY1Fj3QcJFQrE07pNXjn9J6PHdssgGQy/EMuuqMlucfUZUN9OFzUrYHbIph
         PtjZ7U824Y8i5wKEP69R+IhwxT2pPWBzArRsxSwVLXPd/3NYvSoaeQaFwgfzRVD4r8bp
         4Y7ZsrW3jXODBAjvI3yeWU/nlxsV/XU2QaTt7d3eZYMiNgf+Nfh+3HB0gc4bre2We9UY
         7FA+02qR8tpwP6A3cNkPBTDD+ou5w1F9MGirhRsRR8CZa+VhmvB7MTumFfI6rbh6php1
         zkJelM2Aa61Fz8oLNOvN9wa/gr0F37EM3P3DlYbnc0YVVWnCjEPd6HxQiE4jxhSPBNUS
         CiLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=NaLDYCMpJ1x8HAAEg7g5c7Q6aW3snskC8wUk9+xI5KA=;
        b=SR0JUACxKKXc1LV1uKPYxV5REzubFz29r5Jl5qdv6q14xxwzC4HkjZtnFNK/i+7aar
         c7at4QQYngytAl2XUuEk5nahZYRFN3u4FZstwImq2ipSNosIdym6LJ/uTQGLb7CKvuow
         ROpmrgQXx4R4QM0oi9iwQch5Ip1MaozxFRkMSBQiGtyb2fBqd75AwoPcxPjH3aswZicN
         PKQGMZP6eCKysRj4wJHBjPQqjXG4X6byXVTOvlEYNtLSmJJEG6vv0FCsQVDVkc4qX7dr
         /NdNLohnhdTU1Npv3VWUwdCWeGROsaNNFqmYJt3Ya1uUb/wbIc+7VuSKQeG1wkGfgo7Z
         odIw==
X-Gm-Message-State: ABuFfohHuVbDbhThxxXQmX/oysmVOWUK335zFFw3L9mL0EYGRFvK9Jjc
        1pCUXQPO5MTpA1Men6m6LDw=
X-Google-Smtp-Source: ACcGV60b0F4HzJCqDAGdwMzJPOV9XKwr94f92yW2PCoYZJZ5sNPI+RGb06QSzyO/d6EUlOcjqhjw2Q==
X-Received: by 2002:adf:da43:: with SMTP id r3-v6mr22278918wrl.221.1539137689503;
        Tue, 09 Oct 2018 19:14:49 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id t77-v6sm14242665wme.18.2018.10.09.19.14.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 09 Oct 2018 19:14:46 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Josh Steadmon <steadmon@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC PATCH 1/2] fuzz: Add basic fuzz testing target.
References: <cover.1538693039.git.steadmon@google.com>
        <bfe4f2f965528ca2a45864857051b9835970ff07.1538693039.git.steadmon@google.com>
Date:   Wed, 10 Oct 2018 11:14:44 +0900
In-Reply-To: <bfe4f2f965528ca2a45864857051b9835970ff07.1538693039.git.steadmon@google.com>
        (Josh Steadmon's message of "Thu, 4 Oct 2018 16:01:28 -0700")
Message-ID: <xmqqva6amtt7.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Josh Steadmon <steadmon@google.com> writes:

> +FUZZ_OBJS += fuzz-pack-headers.o
> +
> +FUZZ_PROGRAMS += $(patsubst %.o,%,$(FUZZ_OBJS))
> +
> ...
> +### Fuzz testing
> +#
> +.PHONY: fuzz-clean fuzz-objs fuzz-compile

I take it that you anticipate the fuzz programs in the future all
be named fuzz-$(blah), whose source is fuzz-$(blah).o (even though
we may grow some common code that may be linked with them, which can
be done by tweaking the rule for the $(FUZZ_PROGRAMS) target).  Am I
reading you correctly?  Would fuzz-{clean,objs,compile} risk squatting
on nicer names we may want to use for $(blah) down the line?

> + ...
> +$(FUZZ_PROGRAMS): fuzz-compile
> +	clang++ $(FUZZ_LDFLAGS) $(LIB_OBJS) $(BUILTIN_OBJS) $(XDIFF_OBJS) \
> +		$(EXTLIBS) git.o $@.o /usr/lib/llvm-4.0/lib/libFuzzer.a -o $@

Is the expected usage pattern to know a single fuzz-* program the
builder wants to build, to run "make fuzz-pack-headers"?  If not, it
also would be a good idea to have something like

    fuzz-build-all:: $(FUZZ_PROGRAMS)
    .PHONY: fuzz-build-all

perhaps?

Also, in the final version we unleash to general developer audience,
we'd want to support "make V=1" (and "make" that is "$(QUIET)").
