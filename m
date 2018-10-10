Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.4 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C28DB1F97E
	for <e@80x24.org>; Wed, 10 Oct 2018 23:53:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726223AbeJKHRk (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Oct 2018 03:17:40 -0400
Received: from mail-pg1-f169.google.com ([209.85.215.169]:45488 "EHLO
        mail-pg1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725968AbeJKHRk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Oct 2018 03:17:40 -0400
Received: by mail-pg1-f169.google.com with SMTP id t70-v6so3238083pgd.12
        for <git@vger.kernel.org>; Wed, 10 Oct 2018 16:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=glq2g0s47PW1p/vRRXkbfzkFyYer2wWzWd5XN7344/E=;
        b=Y1k1gSFlSvFa2jiWHkaFAPF0xUSetcI8h/H5ggcoBR6iseUHECqtSDCf68YqzJEW0f
         rRoaNLXNI1uEdQ7NE8WCeTBscgSBoUrEPXZNsAywPTqXqmAGflPvq2P3K1wqkZrvMvm+
         tBbvgumra3RXqE2fuHnS+G79a1Bldiqn/LI8hvw5p4p+jqxC9d2K8IGP9GTt7gpYlqsi
         HqUr1ig3+zXJvZh3R0LywmextoyA46+JTJrCrOojUFenHqJinWA1GhBI85DQ2+jMBnI7
         K2DoUukOaZJoh3tHSmJoJyEvXxNzxJw5g/ImFRA9rv2VZBAhUQoBJbl64yjPMPvajEWn
         EpQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=glq2g0s47PW1p/vRRXkbfzkFyYer2wWzWd5XN7344/E=;
        b=DXEgGgYbLvYbaM8t6FIVvVNEGGeIH9EjR+f18Wvp0vjDzsGhReKMx09EtOCEc1JxSs
         CaaO9/Aq74gq4ft09uJSASCsSZopBYJVf4jKf8f1ltmmmHrlqkv216eF+13xXC93LGUF
         FnOoIRqLfiGdH7+AI8CGYxqAAeI3LOYqNtQVcotUtIZ6VLXHe+no/4Gyd5ZCYdmtRT6G
         TfYil8y242uim8a4uG3pyYC83KJj+zvAi4sO8zO4ULxXp7sOuYH52Md5QGQ5uMrjyyuQ
         X8R6IMqv5cvGNrDWTx1lLdTSOfaPqmp918G8HUFImLLAaScLuWwgPnDi3bR63q057YCk
         vu2g==
X-Gm-Message-State: ABuFfoi+n5tq3xHP1Ijs0WrXth5XdMYEl7Um/uu5puw6uR8syyUfrwsW
        eEITkA1h9oZywfC8HJRZkB0oVA==
X-Google-Smtp-Source: ACcGV601YjiQI8f2oNYsiRTHl2HaNmMa8LHSUQdCMuTFkYtBFPgHlDkczWPe/INfWZmKCXj5rvu6/w==
X-Received: by 2002:a63:cf0e:: with SMTP id j14-v6mr31358313pgg.195.1539215589817;
        Wed, 10 Oct 2018 16:53:09 -0700 (PDT)
Received: from google.com ([2620:0:100e:913:5bb:3076:546:99b0])
        by smtp.gmail.com with ESMTPSA id j64-v6sm16265695pge.15.2018.10.10.16.53.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 10 Oct 2018 16:53:08 -0700 (PDT)
Date:   Wed, 10 Oct 2018 16:53:03 -0700
From:   Josh Steadmon <steadmon@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git <git@vger.kernel.org>, Jonathan Nieder <jrnieder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/1] protocol: limit max protocol version per service
Message-ID: <20181010235303.GB12177@google.com>
References: <cover.1538516853.git.steadmon@google.com>
 <59357266bd86e8e0ace9217a97717129a6f76188.1538516853.git.steadmon@google.com>
 <CAGZ79kbD=P__8GU9rV87wREF_MbQA9i2ij6C2qXyaJfqHD3Szg@mail.gmail.com>
 <20181003213349.GA32105@google.com>
 <CAGZ79kZP7y3v8hrhKKP_FT7+uyUSWO5s8w13-c67QWdzme1-Qw@mail.gmail.com>
 <20181005001817.GB32105@google.com>
 <CAGZ79kbSF5XM72SOQH7XNyjeCLqQ+AuxOqMPTspjOgk-jEgrzw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGZ79kbSF5XM72SOQH7XNyjeCLqQ+AuxOqMPTspjOgk-jEgrzw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2018.10.05 12:25, Stefan Beller wrote:
> > > > I suppose if we are strict about serving from a single endpoint, the
> > > > version registry makes more sense, and individual operations can declare
> > > > acceptable version numbers before calling any network code?
> > >
> > > Ah yeah, that makes sense!
> >
> > Thinking out loud here. Please let me know if I say something stupid :)
> >
> > So we'll have (up to) three pieces of version information we'll care
> > about for version negotiation:
> >
> > 1. (maybe) a client-side protocol.version config entry
> 
> (and in case we don't, we have it implicit ly hardcoded, as
> we have to choose the default for users that don't care themselves about
> this setting)
> 
> > 2. a list of acceptable proto versions for the currently running
> >    operation on the client
> > 3. a list of acceptable proto versions for the server endpoint that
> >    handles the request
> 
> Yes that matches my understanding. The issue is between (1) and (2)
> as (1) is in a generic config, whereas (2) is specific to the command,
> such that it may differ. And as a user you may want to express things
> like: "use the highest version", which is done by setting (1) to "version 2"
> despite (2) not having support of all commands for v2.
> 
> > According to the doc on protocol.version: "If set, clients will attempt
> > to communicate with a server using the specified protocol version. If
> > unset, no attempt will be made by the client to communicate using a
> > particular protocol version, this results in protocol version 0 being
> > used."
> >
> > So, if protocol.version is not set, or set to 0, the client should not
> > attempt any sort of version negotiation.
> 
> Yes, as version 0 is unaware of versions, i.e. there are old installations
> out there where all the versioning code is not there, so in case of an
> old client the new server *must* speak v0 to be able to communicate
> (and vice versa).
> 
> 
> > Otherwise, the client prefers a
> > particular version, but we don't guarantee that they will actually use
> > that version after the (unspecified) version negotiation procedure.
> >
> > If protocol.version is set to something other than 0, we construct a
> > list of acceptable versions for the given operation. If the
> > protocol.version entry is present in that list, we move it to the front
> > of the list to note that it is the preferred version. We send all of
> > these, in order, in the request.
> >
> > When the server endpoint begins to handle a request, it first constructs
> > a list of acceptable versions. If the client specifies a list of
> > versions, we check them one-by-one to see if they are acceptable. If we
> > find a match, we use that version. If we don't find any matches or if
> > the client did not send a version list, we default to v0.
> >
> > Seem reasonable?
> 
> This sounds super reasonable!

So this runs into problems with remote-curl (and possibly other remote
helpers):

builtin/push.c can declare whatever allowed versions it wants, but those
are not carried over when remote-curl is started to actually talk to the
remote. What's worse, remote-curl starts its HTTP connection before it
knows what command it's actually acting as a helper for.

For now, I'm going to try adding an --allowed_versions flag for the
remote helpers, but if anyone has a better idea, let me know.


Thanks,
Josh
