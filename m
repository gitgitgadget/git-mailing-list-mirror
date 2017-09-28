Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DF7F620A10
	for <e@80x24.org>; Thu, 28 Sep 2017 22:08:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751088AbdI1WIS (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Sep 2017 18:08:18 -0400
Received: from mail-pf0-f182.google.com ([209.85.192.182]:55381 "EHLO
        mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750946AbdI1WIR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Sep 2017 18:08:17 -0400
Received: by mail-pf0-f182.google.com with SMTP id r71so1517060pfe.12
        for <git@vger.kernel.org>; Thu, 28 Sep 2017 15:08:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gPrO4rOCNLbQeszuAErYk80rSfOTZjzm+nYUpRUrDXU=;
        b=S4ozl9hoQ9IbGgvcVQzkCgAJwJ0ChZ/Hcmhzfabiu+zkWhKf3Up0vyvmM52UqYD7j4
         2/7uK6jAzMzOHVAyPXIJ190vZ8Dnbeotz3xk/cFXusR82g5T2NIbXvhaoP6wSUy9v+nb
         RxBNpyR7gaGfyUDlp7pkNmgWPUkWWGizK9jSiQ3d0PLDAVyfj3jEP8nUQBnyy5zA/hMq
         dKJV6jnJGK+zFnelTd3RiDukNd+wn2UIl+CXPmKXE+ZgrtEj9cDMd6v6lQHPi31XfrEc
         rRFDcEP92nEr4xg5L6Q1Q3JoZnQAO+t1XbVifU0Y02YyaG5gEu6ra+FWjDh5ovWAOVZP
         M3zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gPrO4rOCNLbQeszuAErYk80rSfOTZjzm+nYUpRUrDXU=;
        b=WQ0eJPSL+6aHqtkHgRYxhdmeJ+4/evDEobfgiW2QJ5RumvKVSyc5OMiycgDoSLqoP3
         wvGzIlFjyWnQnJ6JCLFRqn2oxhfVYkWja6UvvUXET3+LfvOAqIKs3lik/Zc5lSet2uXY
         q0deCqieaijN1yK1Zm4gLe12GQYBu27arVbtJ1lBuyIKMwswqr6U2zj1EAIy097k7mWL
         aqPAJKed1awXvoWVULW2sLxL9wk6yF4wTwFHQaJ9AG5zsThNBgBvjlrZ2srvYZYyrrl7
         gx9tMuQg8D1Q0FRGsokyPN6ExkP3tPhbMs/ZQf8hIvtgJRvG8GPcgbGlZ4x6SPEFmoi4
         Lzlw==
X-Gm-Message-State: AHPjjUgn8aC4KyFmL1ZkAoYzex3NebQwQxLuAsiBHZXdjM29IEIlTH/J
        nH8z2BE+YU8fNezzerJd0e/Sbg==
X-Google-Smtp-Source: AOwi7QBGOIMO5Ge2g09ZJuS8jsgDEFGb6agWAJS/FdjKBDZ/437r/KG1cy1QpWWd8LtY35H6pZ1KsQ==
X-Received: by 10.99.191.6 with SMTP id v6mr5562292pgf.284.1506636496929;
        Thu, 28 Sep 2017 15:08:16 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:c55b:7140:f55d:7eed])
        by smtp.gmail.com with ESMTPSA id c62sm4584027pfl.84.2017.09.28.15.08.15
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 28 Sep 2017 15:08:15 -0700 (PDT)
Date:   Thu, 28 Sep 2017 15:08:14 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, bturner@atlassian.com, git@jeffhostetler.com,
        jonathantanmy@google.com, jrnieder@gmail.com, peff@peff.net,
        sbeller@google.com
Subject: Re: [PATCH v2 6/9] connect: teach client to recognize v1 server
 response
Message-ID: <20170928220814.GC177031@google.com>
References: <20170913215448.84674-1-bmwill@google.com>
 <20170926235627.79606-1-bmwill@google.com>
 <20170926235627.79606-7-bmwill@google.com>
 <xmqqpoac676l.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqpoac676l.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 09/27, Junio C Hamano wrote:
> Brandon Williams <bmwill@google.com> writes:
> 
> > +/* Returns 1 if packet_buffer is a protocol version pkt-line, 0 otherwise. */
> > +static int process_protocol_version(void)
> > +{
> > +	switch (determine_protocol_version_client(packet_buffer)) {
> > +		case protocol_v1:
> > +			return 1;
> > +		case protocol_v0:
> > +			return 0;
> > +		default:
> > +			die("server is speaking an unknown protocol");
> > +	}
> > +}
> 
> For the purpose of "technology demonstration" v1 protocol, it is OK
> to discard the result of "determine_pvc()" like the above code, but
> in a real application, we would do a bit more than just ignoring an
> extra "version #" packet that appears at the beginning, no?
> 
> It would be sensible to design how the result of determien_pvc()
> call is propagated to the remainder of the program in this patch and
> implement it.  Perhaps add a new global (like server_capabilities
> already is) and store the value there, or something?  Or pass a
> pointer to enum protocol_version as a return-location parameter to
> this helper function so that the process_capabilities() can pass a
> pointer to its local variable?

Yes, once we actually implement a v2 we would need to not throw away the
result of 'determine_pvc()' and instead do control flow based on the
resultant version.  I was trying to implement 'v1' as simply as possible
so that I wouldn't have to do a large amount of refactoring when
proposing this transition, though it seems Jonathan ended up doing more
than I planned, as I figured we didn't really know what the code will
need to be refactored to, in order to handle another protocol version.
I would suspect that we maybe wouldn't want to determine which version a
server is speaking in 'get_remote_heads()' but rather at some point
before that so we can branch off to do v2 like things, for example,
capability discovery and not ref discovery.

If you do think we need to do more of that refactoring now, before a v2,
I can most certainly work on that.


> 
> >  static void process_capabilities(int *len)
> >  {
> > @@ -224,12 +239,19 @@ struct ref **get_remote_heads(int in, char *src_buf, size_t src_len,
> >  	 */
> >  	int responded = 0;
> >  	int len;
> > -	int state = EXPECTING_FIRST_REF;
> > +	int state = EXPECTING_PROTOCOL_VERSION;
> >  
> >  	*list = NULL;
> >  
> >  	while ((len = read_remote_ref(in, &src_buf, &src_len, &responded))) {
> >  		switch (state) {
> > +		case EXPECTING_PROTOCOL_VERSION:
> > +			if (process_protocol_version()) {
> > +				state = EXPECTING_FIRST_REF;
> > +				break;
> > +			}
> > +			state = EXPECTING_FIRST_REF;
> > +			/* fallthrough */
> >  		case EXPECTING_FIRST_REF:
> >  			process_capabilities(&len);
> >  			if (process_dummy_ref()) {

-- 
Brandon Williams
