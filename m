Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6E82E20248
	for <e@80x24.org>; Fri, 22 Mar 2019 03:25:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727386AbfCVDZV (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Mar 2019 23:25:21 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55559 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725999AbfCVDZV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Mar 2019 23:25:21 -0400
Received: by mail-wm1-f66.google.com with SMTP id o25so702800wmf.5
        for <git@vger.kernel.org>; Thu, 21 Mar 2019 20:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=pP/pxL4kkPq+fHd2rEOZF+vbzXZsTiyn02y6xn6dY6A=;
        b=sYJJf0QURVJ1/Mg1cyy3u2fKPbrYQF/3/8XjXdRx3q3tvXwWyIlFH6cGF8u3eQ198P
         32LY+WDYVNxNfkPeaLjIX06C6HEAw+5C5cRia2u4/s+4S8fX/CGavWnbC8/xx6cfae+G
         f+8MJEUp214etXoJPdMWJtZtIrHFEjNkMyufW8wlixsNhUY9hY8w8I7AmRqyPHQSgkXJ
         Di8TeC1uC7M/QPkwYbA+QxOb/e1QirmuR8GqPiYaIS0JlYL+oxiLshzgZtmhhjJ6iKp8
         NRQdo9UqKM37oLRmggv3o52eD/0cIJ6WpjW7ANWD3cgmEeotwQTtj/KozDzJHq3t1mRM
         X3dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=pP/pxL4kkPq+fHd2rEOZF+vbzXZsTiyn02y6xn6dY6A=;
        b=DIoHNDZJMYqlZdpmvpQ/srO5mpJYfqV754Z4s7muet0f/m/FXGTHkEJQ92zDeF8uHg
         xxEogtjdraQ+JML+pIdhiUGxN3degYtdzFQ1Uiy2/h1cloX4za3d5m9fBhWjgDinfVv/
         H8IVIjWtu6o+4UK81WEj+yBEYOHU/4ZCrccJ037VI4tGH4RwMzaUS++frxBrIyFet9qv
         lC+fPztcMTkfz5+mOLsujnBuGMd6Q6rDP6B4MhCIYAiaAvJwNOBhLvng7d2rZyanuniB
         K2pznJWoBAxZPP6eXMSCPB+F6GTSDUOwIUKELD0gdYcWlFpeQ0O4DUpx0TNOhwb86pCb
         8KXQ==
X-Gm-Message-State: APjAAAUD4Xs5B4w6tApWevR3UkNRDrqBRxbBu390d49Yml8Q53wifSEV
        7YFtFvvGX4ERgiDVlXlJZwshCpx9ka0=
X-Google-Smtp-Source: APXvYqzbFPhKjSvoLx8HmxffPhSJmNdeGF+FO6SHQQ51R3GId9avCtxoFWS43CoqqKBFrirk/Scc0Q==
X-Received: by 2002:a1c:ef1a:: with SMTP id n26mr1450502wmh.67.1553225119309;
        Thu, 21 Mar 2019 20:25:19 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id a17sm3211728wmg.40.2019.03.21.20.25.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Mar 2019 20:25:18 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Thomas Gummerer <t.gummerer@gmail.com>,
        Denton Liu <liu.denton@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>,
        Joel Teichroeb <joel@teichroeb.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Matthew Kraai <mkraai@its.jnj.com>
Subject: Re: [PATCH v2] stash: setup default diff output format if necessary
References: <20190319190503.GA10066@dev-l>
        <20190319231826.GB32487@hank.intra.tgummerer.com>
        <20190320224955.GE32487@hank.intra.tgummerer.com>
        <20190321095103.GB2894@sigill.intra.peff.net>
Date:   Fri, 22 Mar 2019 12:25:17 +0900
In-Reply-To: <20190321095103.GB2894@sigill.intra.peff.net> (Jeff King's
        message of "Thu, 21 Mar 2019 05:51:03 -0400")
Message-ID: <xmqqtvfvr3oi.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>> I think this also deserves some explanation of what didn't change,
>> especially after what I said in [*1*].  We're still not using the
>> 'diff_opt_parse()' option parser, as it doesn't understand '-v' for
>> example.  'setup_revisions()' understands that, but 'diff_opt_parse()'
>> doesn't, so we'd still have a change in behaviour at least there.
>> After discovering that I gave up on that approach.
>
> Yeah, I think this would get into the "why are we even looking at
> revision options" thing, which really is a separate topic. Let's do the
> minimal fix here.

I tend to agree.  Limiting ourselves to diff options would be a good
direction going forward in the longer term, but let's fix the regression
so that we can push the base topic to 'master' before we need to
know the shape of the next release.

> There is a "set_default" callback that was added by 6c374008b1
> (diff_opt: track whether flags have been set explicitly, 2013-05-10),
> but it looks like it was never actually used. I think the theory is that
> cases like this could do their tweaking in such a callback. But I think
> it makes sense to follow the lead of builtin/diff.c for the immediate
> fix, and we can look at using set_default as a separate topic.

I agree with the conclusion.  I wouldn't be surprised if this is one
of the things that was once used but left behind when the last
caller disappeared, though.


