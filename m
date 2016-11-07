Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5E9442022A
	for <e@80x24.org>; Mon,  7 Nov 2016 18:48:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933587AbcKGSr4 (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Nov 2016 13:47:56 -0500
Received: from mail-pf0-f174.google.com ([209.85.192.174]:33172 "EHLO
        mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933081AbcKGSrz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Nov 2016 13:47:55 -0500
Received: by mail-pf0-f174.google.com with SMTP id d2so94635015pfd.0
        for <git@vger.kernel.org>; Mon, 07 Nov 2016 10:47:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=daWYzGH9JWCtfs5TTOm1d+jguhENVXJz3oQEQHmWP8w=;
        b=eppb9kd2seApLaIu5B41GS7XJU8FZc24SXspudlUSJpnj4091jgvFgAFG6L5oJ6scF
         lhEq+Evpnhv8nd0Oi39VcBlSv4VboPEx9hvf8FQrdhOZR2EDNgYEvG9ktODhb3f9O/my
         DDDdu08qm2ea1LPbvyzmtt/uUtKIgogA4IFowJQbANzCP3WvQmlvzyr6TrpbKGi9Go2+
         tYuiadffOGqah9JsuPm9hHK9G5FhEZyFiidwZ87QbvXRGaniMdvUUyvc4l8u9l90e4R3
         wnletBrrSkGxBc/ngVRT0kWm8yvwiv5kf5BCfGeEue4NTDaFzJbEUy94vGSsjiUbCbf2
         Dyyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=daWYzGH9JWCtfs5TTOm1d+jguhENVXJz3oQEQHmWP8w=;
        b=T5L/nI7ihInw5bVAueEglnNK8X8U3vvreo8m6u5SSaSqHcfdUjSfaT8Blfzh60MdTH
         PPxqKUukCLrN7RzPVUOU9F8jFSrmJB3Vq6x3kud90bbIlv9v+P+2iRVm+nU8lY7w9ZWR
         3A7VSBlqgnP6yYjn1a9B6opNLsmZmGSnY0oIORq39Ws4XaFxLnfcO7FuvNsPy+hyKrR2
         ATQ3U6wvnDB8z7WMUYD5Vph8xx+K36ERkxLO6Noi+JyTkdhkXXvhiwqW5aYwPu0Tu3Ri
         hI4AHvlJ4AvSRr9PGxnAnZZax9bkLnfotCWPgmMXRXKVd9fhqnwD5dwT7C+9p2FUziIV
         fU7w==
X-Gm-Message-State: ABUngveemeJENzCDv+BidUIXgcuLG3UIvSbNLI4RJcEtJs3SW2mQ05tHSo4F+BaFp650ES4y
X-Received: by 10.99.2.142 with SMTP id 136mr12594826pgc.25.1478542467295;
        Mon, 07 Nov 2016 10:14:27 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:bd82:3124:1b9:77b4])
        by smtp.gmail.com with ESMTPSA id c5sm42072966pfj.71.2016.11.07.10.14.26
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 07 Nov 2016 10:14:26 -0800 (PST)
Date:   Mon, 7 Nov 2016 10:14:25 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Blake Burkhart <bburky@bburky.com>, Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v3] transport: add protocol policy config option
Message-ID: <20161107181425.GA143723@google.com>
References: <1478125247-62372-1-git-send-email-bmwill@google.com>
 <1478292933-7873-1-git-send-email-bmwill@google.com>
 <CAGZ79ka18s3-nzkCog3+g70NCoAawoqO1t-qghKSZJxjK6jkmw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGZ79ka18s3-nzkCog3+g70NCoAawoqO1t-qghKSZJxjK6jkmw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/04, Stefan Beller wrote:
> By default, if unset, ... have a default policy ...
> sounds strange. How about just dropping the first 4 words here:
> 
>      Known-safe protocols (http, https, git, ssh, file) have a
>      default policy of `always`, known-dangerous protocols (ext) have a
>      default policy of `never`, and all other protocols have a default policy
>      of `user`.  Supported policies:
> 
> 
> What happens if protocol.allow is set to true?

That wouldn't be allowed, its an unknown value as the only permitted
values are always, never, and user.

> 
> 
> 
> > +       if unset, known-safe protocols (http, https, git, ssh, file) have a
> > +       default policy of `always`, known-dangerous protocols (ext) have a
> > +       default policy of `never`, and all other protocols have a default policy
> > +       of `user`.  Supported policies:
> > ++
> > +--
> > +
> > +* `always` - protocol is always able to be used.
> > +
> > +* `never` - protocol is never able to be used.
> > +
> > +* `user` - protocol is only able to be used when `GIT_PROTOCOL_FROM_USER` is
> > +  either unset or has a value of 1.  This policy should be used when you want a
> > +  protocol to be usable by the user but don't want it used by commands which
> > +  execute clone/fetch/pull commands without user input, e.g. recursive
> > +  submodule initialization.
> > +
> > +--
> > +
> > +protocol.<name>.allow::
> > +       Set a policy to be used by protocol <name> with clone/fetch/pull commands.
> 
> How does this interact with protocol.allow?
> 
>     When protocol.allow is set, this overrides the specific protocol.
>     If protocol is not set, it overrides the specific protocol as well(?)

protocol.allow is a default for protocols which don't have a specific
protocol.<name>.allow entry

> > +       test_expect_success "clone $desc (disabled)" '
> > +               rm -rf tmp.git &&
> > +               test_must_fail git clone --bare "$url" tmp.git
> > +       '
> 
> 
> I could not spot a test for GIT_ALLOW_PROTOCOL overriding
> any protocol*allow policy. Is that also worth testing? (for
> backwards compatibility of tools that make use of GIT_ALLOW_PROTOCOL
> but the user already setup a policy.

I can add in one quick test for that.

-- 
Brandon Williams
