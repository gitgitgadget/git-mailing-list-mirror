Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4DCEB1F453
	for <e@80x24.org>; Wed,  3 Oct 2018 21:34:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726808AbeJDEYL (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 Oct 2018 00:24:11 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:43453 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725871AbeJDEYK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Oct 2018 00:24:10 -0400
Received: by mail-pf1-f195.google.com with SMTP id p24-v6so2279065pff.10
        for <git@vger.kernel.org>; Wed, 03 Oct 2018 14:34:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=sacbA/g2Ls8+ABiTJzBNwNt/AHvenwa3x5pcnGyh5L8=;
        b=nyI+GERp0g6Zh8uUT7rajifkOstxsI+zQ9wA6LGe0DsgcAHYu51uHlOr2m6hH6Ga4e
         7sGEHUF9O+gZXu+PT5zzbuVFIc/33e/uZnmDpMSoJrgCJ330ov2fBp3Ng7uGQN5XXu+7
         J3XWwjgag7r1J+/T8TGetqP4jihoTtXZcDAJn0OZ/jsW6Lj0paPwu1rMrgOIREGc9f7k
         g6BuOSPaTvFI47e4v4RRteh7zKL8FEicyOPKq08Z7LoTW1RlpMpHts0z3FgxY+5Fn3Ab
         h1PVm/6GosDKi5u42Eag9P088IbBVlI7p73leQT15AVHOnAkDXYZEueTEp77MBQNVtTw
         OU0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=sacbA/g2Ls8+ABiTJzBNwNt/AHvenwa3x5pcnGyh5L8=;
        b=E7TWaNVyX1LIGcQRnF+Kk1+/HGMyFqDtEZJjFMPy/BMBElf9EBoCcpUkrL9Lo1KYQ1
         /JULV2xpcgLnXD/2v6gt8sPePp6MscDY4wWFa6iiAiSa1kR3uIq0v0M9G97Av8Dzhqvw
         xZhEYXBZSPqOflZNul4cX65X6l+HOZAr05KekZmvCiUSRE6U56JFWrxngkmV/+MXzkr1
         9ISwCqlEZwJnQJo5qSJA+PzapUqCp9QsD2cNLhCVJDexeDgkQ7WNor21ZCcFRlSL/czv
         Fia2kzuLl+zJwbx9r3b+NvHgNt63TuXP8MyQOSOd50d/91H2nrSDvo07W2owCHH8J15k
         FY7A==
X-Gm-Message-State: ABuFfogseWoVtHKUfoDB0i71savOD3wIMfGp/Tvdc3EX055ap/pnKng3
        wV4ixTYIhyO0Fyi1MxPA2uO+ANknUfA58g==
X-Google-Smtp-Source: ACcGV62E5q/3Gm9is+LrviKDWlweOdf03/61vn7RWfvunRbxOeFlHVKmQUtknjsBNHkSGgN3c3+Q2Q==
X-Received: by 2002:a63:2106:: with SMTP id h6-v6mr2956010pgh.161.1538602441240;
        Wed, 03 Oct 2018 14:34:01 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:79fb:7d7a:4d6b:acb7])
        by smtp.gmail.com with ESMTPSA id a79-v6sm3868508pfa.124.2018.10.03.14.33.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 03 Oct 2018 14:34:00 -0700 (PDT)
Date:   Wed, 3 Oct 2018 14:33:49 -0700
From:   Josh Steadmon <steadmon@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git <git@vger.kernel.org>, Jonathan Nieder <jrnieder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/1] protocol: limit max protocol version per service
Message-ID: <20181003213349.GA32105@google.com>
References: <cover.1538516853.git.steadmon@google.com>
 <59357266bd86e8e0ace9217a97717129a6f76188.1538516853.git.steadmon@google.com>
 <CAGZ79kbD=P__8GU9rV87wREF_MbQA9i2ij6C2qXyaJfqHD3Szg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGZ79kbD=P__8GU9rV87wREF_MbQA9i2ij6C2qXyaJfqHD3Szg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2018.10.02 15:28, Stefan Beller wrote:
> On Tue, Oct 2, 2018 at 3:00 PM Josh Steadmon <steadmon@google.com> wrote:
> >
> > For services other than git-receive-pack, clients currently advertise
> > that they support the version set in the protocol.version config,
> > regardless of whether or not there is actually an implementation of that
> > service for the given protocol version. This causes backwards-
> > compatibility problems when a new implementation for the given
> > protocol version is added.
> >
> > This patch sets maximum allowed protocol versions for git-receive-pack,
> > git-upload-archive, and git-upload-pack.
> >
> > Previously, git-receive-pack would downgrade from v2 to v0, but would
> > allow v1 if set in protocol.version. Now, it will downgrade from v2 to
> > v1.
> 
> But does git-receive-pack understand v1?
> As to my understanding we have not even defined v1
> for push (receive-pack) and archive --remote (upload-archive).
> v1 is only known to fetch (upload-pack).
> 
> > +enum protocol_version determine_maximum_protocol_version(
> > +               const char *service, enum protocol_version default_version)
> > +{
> > +       if (!strcmp(service, "git-receive-pack"))
> > +               return protocol_v1;
> > +       else if (!strcmp(service, "git-upload-archive"))
> > +               return protocol_v1;
> 
> so I would think these two would be _v0.
> ... goes and checks ...
> aa9bab29b8 (upload-pack, receive-pack: introduce protocol version 1,
> 2017-10-16) seems to actually teach v1 to receive-pack as well,
> but upload-archive was completely off radar, so I think returning
> (v1, v0, v2 in the order as in the code) would make sense?

I believe that git-upload-archive can still speak version 1 without any
trouble, but it at least doesn't break anything in the test suite to
limit this to v0 either.


> Asides from this, I thought there was a deliberate decision
> that we'd want to avoid a strict order on the protocol versions,
> but I could not find prior discussion on list to back up this claim. :/
> 
> For example we'd go with e.g. enums instead of integers
> for version numbers, as then some internal setup could
> also have things like protocol_v2018-10-02 or protocol_vWhatever;
> some protocol version may be advantageous to the client, some to
> the server, and we'd need to negotiate the best version that both
> are happy with. (e.g. the server may like version 0, 2 and 3, and
> the client may like 0,2,4 as 3 is bad security wise for the client,
> so both would negotiate to 2 as their best case)

Is there a method or design for advertising multiple acceptable versions
from the client? From my understanding, we can only add a single
version=X field in the advertisement, but IIUC we can extend this fairly
easily? Perhaps we can have "version=X" to mean the preferred version,
and then a repeatable "acceptable_version=Y" field or similar?


> From a maintenance perspective, do we want to keep
> this part of the code central, as it ties protocol (as proxied
> by service name) to the max version number?
> I would think that we'd rather have the decision local to the
> code, i.e. builtin/fetch would need to tell protocol.c that it
> can do (0,1,2) and builtin/push can do (0,1), and then the
> networking layers of code would figure out by the input
> from the caller and the input from the user (configured
> protocol.version) what is the best to go forward from
> then on.

I like having it centralized, because enforcing this in git_connect()
and discover_refs() catches all the outgoing version advertisements, but
there's lots of code paths that lead to those two functions that would
all have to have the acceptable version numbers plumbed through.

I suppose we could also have a registry of services to version numbers,
but I tend to dislike non-local sources of data. But if the list likes
that approach better, I'll be happy to implement it.


> But I guess having the central place here is not to
> bad either. How will it cope with the desire of protocol v2
> to have only one end point (c.f. serve.{c,h} via builtin/serve
> as "git serve") ?

I'm not sure about this. In my series to add a v2 archive command, I
added support for a new endpoint for proto v2 and I don't recall seeing
any complaints, but that is still open for review.

I suppose if we are strict about serving from a single endpoint, the
version registry makes more sense, and individual operations can declare
acceptable version numbers before calling any network code?



Thanks for the review,
Josh
