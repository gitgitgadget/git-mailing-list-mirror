Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 27AA020A29
	for <e@80x24.org>; Wed, 20 Sep 2017 20:06:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751307AbdITUGc (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Sep 2017 16:06:32 -0400
Received: from mail-pg0-f42.google.com ([74.125.83.42]:47823 "EHLO
        mail-pg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750872AbdITUGb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Sep 2017 16:06:31 -0400
Received: by mail-pg0-f42.google.com with SMTP id d8so2280784pgt.4
        for <git@vger.kernel.org>; Wed, 20 Sep 2017 13:06:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=91OhYBPvxO7BqkAUlvD/tUiU3VqzrIzMcDJGxH5tIJM=;
        b=To7hS9UOovCGTzji7OhQSIfohfA9OeZH2DXwWaUzCLkxzqvULjr0Od5ZC7Oan1WgKx
         h5Sk18XA1i/X3NgoOObx37H3g4qdySwOYlIx0SNDH9Erk2HWs5soU96YXlmwplNC4FRu
         yj4o/5UZU9paU6u/U3RjSy2xcXJQ9um321M4ovyR66SnAxZU7LZDI2i8ralWiS3hp7EG
         9XotBFxJ6RdeIbAZdWcBCXFhTfpMC1iAL22n5iWJZdigAVtwsQqaG/FUuZIvX/jzukMz
         iUyBo/wOUyukSJn+i2Zw9JngiwV+Jo+7c6SoWHQmZAlRqfbjBsSSrfjSFg238HeTSTfp
         y22g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=91OhYBPvxO7BqkAUlvD/tUiU3VqzrIzMcDJGxH5tIJM=;
        b=Lw5mMdXKpmc/PgjoNrnNxoA+zNwSFMLdM++8Uy+rQhJTrSz3X9F6R//gXaEsDym/eT
         8Lm30wprELT9IEjAwiPYlDrYtlwwZ9h2G4WBPRK//tv/AVwMAxLIP6p6aL5S9428KcDn
         OVagoNbuwENsSPYaW57el8WX5S/NWuU9FbOp8R0m+AEuLf2bs5lQZaPwU6tA3YHCgeHp
         h+W3jH1EyezzdTg3USvYcRZeBkgVk2u3QpY7cqLvNoZdHWwyvm3YElIkJWE2B/YaJO85
         9lrrv0HUByvwRPjIOmh6pFpj57D3F06V9R5y5+6dry2Sjd+gEPcx97f70Ji3LigmhjvE
         ESqA==
X-Gm-Message-State: AHPjjUi27+X41uBA34ytwOgtGdUkclH8GBXvVz9UgfBea03gSp30hSat
        H1HAYJpMO8YV4uokGfHyEAl++g==
X-Google-Smtp-Source: AOwi7QDbsytCKOFUhv+IWJyAD4AtSolFYl3gubnVWxFDXwbV/N7qv0k9GfOa6jSo+PsmaJJTqRUaYA==
X-Received: by 10.84.217.206 with SMTP id d14mr3286654plj.157.1505937990215;
        Wed, 20 Sep 2017 13:06:30 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:29ba:27e3:2f83:e045])
        by smtp.gmail.com with ESMTPSA id s62sm9189411pfe.91.2017.09.20.13.06.28
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 20 Sep 2017 13:06:29 -0700 (PDT)
Date:   Wed, 20 Sep 2017 13:06:27 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, sbeller@google.com, gitster@pobox.com,
        jrnieder@gmail.com, bturner@atlassian.com, git@jeffhostetler.com,
        jonathantanmy@google.com
Subject: Re: [PATCH 1.5/8] connect: die when a capability line comes after a
 ref
Message-ID: <20170920200627.GA82704@google.com>
References: <20170913215448.84674-1-bmwill@google.com>
 <20170920184832.146564-1-bmwill@google.com>
 <20170920191431.emornzhse6f7s5mg@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170920191431.emornzhse6f7s5mg@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 09/20, Jeff King wrote:
> On Wed, Sep 20, 2017 at 11:48:32AM -0700, Brandon Williams wrote:
> 
> > Commit eb398797c (connect: advertized capability is not a ref,
> > 2016-09-09) taught 'get_remote_heads()' to recognize that the
> > 'capabilities^{}' line isn't a ref but required that the
> > 'capabilities^{}' line came during the first response from the server.
> > A future patch will introduce a version string sent by the server during
> > its first response which can then cause a client to unnecessarily die if
> > a 'capabilities^{}' line sent as the first ref.
> > 
> > Teach 'get_remote_heads()' to instead die if a 'capabilities^{}' line is
> > sent after a ref.
> 
> Hmm. I think I understand why you'd want this loosening. But why are we
> sending a version line to a client that we don't know is speaking v2?
> IOW, shouldn't we be reporting the version to the client in the normal
> capabilities when we don't know for sure that they can handle the new
> field? Otherwise we're breaking existing clients.

The client requested the version, this is the servers response.  So
older clients shouldn't be broken because they wouldn't be requesting
the newer versions.

> 
> Or is this only for v2 clients, and we've changed the protocol but
> get_remote_heads() just needs to be updated, too?

A client which didn't request protocol v1 (I'm calling the current
protocol v0, and v1 is just v0 with the initial response from the server
containing a version string) should not receive a version string in the
initial response.  The problem is that when introducing the version
string to protocol version 1, I didn't want to have to do a huge
refactoring of ALL of the current transport code so I stuck the version
check in get_remote_heads() since v1 is exactly the same as v0, except
for the first line from the server.

When we introduce v2, I'm sure we'll have to do more refactoring to
separate out the logic for the different versions.
> 
> > diff --git a/connect.c b/connect.c
> > index df56c0cbf..af5096ec6 100644
> > --- a/connect.c
> > +++ b/connect.c
> > @@ -124,10 +124,11 @@ struct ref **get_remote_heads(int in, char *src_buf, size_t src_len,
> >  	 * response does not necessarily mean an ACL problem, though.
> >  	 */
> >  	int saw_response;
> > +	int seen_ref;
> >  	int got_dummy_ref_with_capabilities_declaration = 0;
> > 
> >  	*list = NULL;
> > -	for (saw_response = 0; ; saw_response = 1) {
> > +	for (saw_response = 0, seen_ref = 0; ; saw_response = 1) {
> 
> If we're not going to update it in the right-hand side of the for-loop,
> should we perhaps not be initializing it in the left-hand side? I.e.,
> can we just do:
> 
>   seen_ref = 0;
> 
> above the loop, like we initialize "list"?
> 
> (For that matter, could we just be checking whether *list is NULL?)

True, that would probably be the better way to do this.

> 
> > @@ -165,6 +166,8 @@ struct ref **get_remote_heads(int in, char *src_buf, size_t src_len,
> > 
> >  		name_len = strlen(name);
> >  		if (len != name_len + GIT_SHA1_HEXSZ + 1) {
> > +			if (seen_ref)
> > +				; /* NEEDSWORK: Error out for multiple capabilities lines? */
> >  			free(server_capabilities);
> >  			server_capabilities = xstrdup(name + name_len + 1);
> >  		}
> 
> Interesting question. Probably it would be fine to. Coincidentally I ran
> across a similar case. It seems that upload-pack will read multiple
> capabilities lines back from the client. I.e., if it gets:
> 
>   want 1234abcd... foo
>   want 5678abcd... bar
> 
> then it will turn on both the "foo" and "bar" capabilities. I'm pretty
> sure this is unintended, and is somewhat counter to the way that clients
> handle multiple lines (which is to forget the old line and respect only
> the new one, as shown in the quoted hunk).
> 
> I wonder if we should be outlawing extra capabilities in both
> directions. I don't _think_ we've ever relied on that working, and I
> don't have much sympathy for any 3rd-party implementation that does
> (though I doubt that any exists).
> 
> That tangent aside, I do this hunk is kind of orthogonal to the point of
> your patch. We're talking about potential _tightening_ here, whereas the
> point of your patch is loosening. And it's not clear to me what we want
> to tighten:
> 
>   - should capabilities come as part of the first response, even if we
>     have no refs? In which case we really want "if (saw_response)" here.
> 
>   - should they came as part of the first ref (or pseudo-ref), in which
>     case "if (seen_ref)" is the right thing.
> 
>   - should we loosen it to complaining when there are multiple
>     capabilities sent. In which case "if (server_capabilities)" is the
>     right thing.
> 
> I'm not sure which we'd want, but it really seems like a separate topic
> that should be explored on top.

I wasn't sure either, which is why I added the comment to prod
discussion.  I agree that is is orthogonal to this series so I'll most
likely drop it, as it doesn't help with the protocol transition
discussion.

-- 
Brandon Williams
