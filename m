Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.1 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 51DEB1F731
	for <e@80x24.org>; Wed,  7 Aug 2019 18:11:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388669AbfHGSLz (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Aug 2019 14:11:55 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:40907 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387953AbfHGSLz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Aug 2019 14:11:55 -0400
Received: by mail-pl1-f195.google.com with SMTP id a93so41914009pla.7
        for <git@vger.kernel.org>; Wed, 07 Aug 2019 11:11:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tm3hA4GHXjPs3BxsxkuMDr6hcGZqXHAW5RSJACUH4Zs=;
        b=X6WF4B7kDBTe9ik5FGE/5ESZX1EziJAAJobhstoB0+iAySahNbn7e13s+s+lGvIO1B
         Anw/7ZmveImDJHQFXAdCIEGtr6WWJKXNMmx3GIARXBVMLNpFnthFeFXeSmXIDWky+KGk
         AisYzCmCIrfYbfJVjB+1WgNG9jpVq7CAoi3vgkk+RP+fhevjIcatOY3xgTToO3r0Bdg0
         qGp3TgGQIZNbPQRFaQfN41d6e1rLEAXqFzYY4H1dDJSU+oSNCv2tbIw6XP10Qr2O3WnD
         kl3ZuN+QpqqQiY0o1qQcSmniq+AVolmXTaOw4v9zDRh1O5cCHL1/iHLvHd3G1S21hTxV
         N2DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=tm3hA4GHXjPs3BxsxkuMDr6hcGZqXHAW5RSJACUH4Zs=;
        b=AaN4cs3IvZxkDT+ZoXjWL19krn5TzHo9Le2aJZCGoTUehK4DH8HqvyJOs9AB+huuP1
         o22yIMtJD9yZWsfUewkB0DVnyHLk/RMCyNGeaNwEYDTJboaddmV2bCu9BuZYDU8fRT5y
         qp7ECB0aTEcycrO38B8HQbreWJfdtudc/y/zZZ7KqwjbA3IbLV2lwDeGbBxcRSkZT+N6
         5lzrkCtKo/y7idSgc6Vn6szLSIb29Oh6x+tuLBAiUdxpbqn9Lk1JBZdu8F1ryNuas+Xd
         EEJMZGDHvb1sWYWOTDnBCKWi3xa6njjv6JxfSpK3jgslVRqp+qwqwKm7DDWtwIBQmek6
         S4Xw==
X-Gm-Message-State: APjAAAW4MtVhgFoMTk7OLWDohSAmizEADsRii6qHNnP2l9hFceL9+zIz
        A3dAo2FwW3c3ORjd+sHEG/iROmd9nJthcg==
X-Google-Smtp-Source: APXvYqxtAQM4mPnVupd4ERNBO9vAXarZdtxm/lCjE19IaqgQqO5kLnGk0w0MOoGsppA6i/JjfPtObQ==
X-Received: by 2002:a63:2157:: with SMTP id s23mr5369303pgm.167.1565201513372;
        Wed, 07 Aug 2019 11:11:53 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:4264:e2f7:27a:8bb2])
        by smtp.gmail.com with ESMTPSA id b37sm719088pjc.15.2019.08.07.11.11.52
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 07 Aug 2019 11:11:52 -0700 (PDT)
Date:   Wed, 7 Aug 2019 11:11:44 -0700
From:   Josh Steadmon <steadmon@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, git@grubix.eu, martin.agren@gmail.com
Subject: Re: [PATCH v4 1/4] t7503: verify proper hook execution
Message-ID: <20190807181144.GV43313@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        git@grubix.eu, martin.agren@gmail.com
References: <cover.1564695892.git.steadmon@google.com>
 <cover.1565044345.git.steadmon@google.com>
 <50857290955c5467ef6f75083395c695340fa284.1565044345.git.steadmon@google.com>
 <xmqqk1bqjh4s.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqk1bqjh4s.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2019.08.06 11:14, Junio C Hamano wrote:
> Josh Steadmon <steadmon@google.com> writes:
> 
> > t7503 did not verify that the expected hooks actually ran during
> > testing. Fix that by making the hook scripts write their $0 into a file
> > so that we can compare actual execution vs. expected execution.
> >
> > While we're at it, do some test style cleanups, such as using
> > write_script() and doing setup inside a test_expect_success block.
> > ...
> 
> The result mostly looks more pleasant compared to the original,
> modulo a few nits.
> 
> >  test_expect_success 'with succeeding hook' '
> > -
> > -	echo "more" >> file &&
> > +	test_when_finished "rm -f \"$PRECOMMIT\" expected_hooks actual_hooks" &&
> > +	ln -s "success.sample" "$PRECOMMIT" &&
> 
> Not all systems that want to run Git are capable of symbolic links.
> We should be able to do a copy here, perhaps?  Just the most basic
> form of "cp" without even "-p" would be sufficient as the target is
> expected to be missing (i.e. "cp" or "ln -s" would be creating the
> "$PRECOMMIT"), right?

Yeah, "cp" works here. Fixed in V5.
