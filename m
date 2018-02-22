Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 868B01F404
	for <e@80x24.org>; Thu, 22 Feb 2018 18:17:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933573AbeBVSRn (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Feb 2018 13:17:43 -0500
Received: from mail-pg0-f68.google.com ([74.125.83.68]:33845 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933441AbeBVSRm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Feb 2018 13:17:42 -0500
Received: by mail-pg0-f68.google.com with SMTP id m19so2319276pgn.1
        for <git@vger.kernel.org>; Thu, 22 Feb 2018 10:17:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=uMTLkOpzyKS/B2yEl3nNYgl6vkLhbUyj2XWbyd7ACu8=;
        b=XZ1PHtL2J+Ro/52Q8HCAhrYTimG0/pY76e4no4R/Gob96goJhWJXUl+jxxuYCQTQhL
         fXp7aMWpvE+Gh4uhvWIyuziraJ6gxVKtEjhWzIe+BLD7TgBKZBJg/xovf0LiFbIA6FZB
         6MppxoLqdK+s/uKbz85xf9vhJZYWDpwZSprttdIpo1KreFoJ/OMpGawimcwAuRfuJgIN
         Nu7GbVii8GB1KXb3R+DdFWTS1dK+Mo00wfFnV8R2ttLkiLHLHS57CsObK86+AdNYubzh
         X/NvLlVCmvLxjdSsdnq41SqzpdJMJWF9FEWrH1ci9vSRX0gqV0jJFInFOcP7pMOhuRJJ
         m7YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uMTLkOpzyKS/B2yEl3nNYgl6vkLhbUyj2XWbyd7ACu8=;
        b=N8QMLTP8LFXoE1Z4eEEJcj6m9mJpIK+fp4nR/EVsSGq1HJBsZT+GGMWcJTKFB44NNm
         P3zZfVGI3597v11Pc6mrgvEGqFrjwOMH4Ga29uj/Xhuimyjz8JX0EmICMW8ZqBGz4zio
         JRYuaH1LVc9aF6/t9Znh8hNXY8TRpA9JqOI/frWi9Qc6SQRlT/H456hyzFlFCBA8NhYw
         2Toy2JaEjKZz0K8WRxqCOMg/7bjMJ+SULz2AW87c12YNtLzCi29/C+aM4wXaps3//6nE
         Of83Pk/LAU9tDcJRvRT2hjVT8YsPK2yEQY4F+NSnOwgwNKCpxskPSzEza1Kdpe/j7o6H
         P3Iw==
X-Gm-Message-State: APf1xPCg3Lz0YGhjgdTXkU/jcwJjEeke/DeIqYhN0iNtLhAkXTSDmBIA
        x3DANbp1lSLcbVvoXj59UlBMyA==
X-Google-Smtp-Source: AH8x225qvo4OsP1oI2bE6nv7G8c8uDBDKHmIoZTs9xmkcz5G6lASqu2iZCmURXQFNqFDKjcA9F8YCA==
X-Received: by 10.101.64.194 with SMTP id u2mr4553743pgp.280.1519323461419;
        Thu, 22 Feb 2018 10:17:41 -0800 (PST)
Received: from google.com ([2620:0:100e:422:ff43:9291:7eda:b712])
        by smtp.gmail.com with ESMTPSA id l189sm1064725pfl.48.2018.02.22.10.17.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 22 Feb 2018 10:17:40 -0800 (PST)
Date:   Thu, 22 Feb 2018 10:17:39 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, sbeller@google.com, peff@peff.net,
        gitster@pobox.com, jrnieder@gmail.com, stolee@gmail.com,
        git@jeffhostetler.com, pclouds@gmail.com
Subject: Re: [PATCH v3 08/35] connect: discover protocol version outside of
 get_remote_heads
Message-ID: <20180222181739.GC185096@google.com>
References: <20180125235838.138135-1-bmwill@google.com>
 <20180207011312.189834-1-bmwill@google.com>
 <20180207011312.189834-9-bmwill@google.com>
 <20180221141135.c78d72b422f985aae5375bca@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180221141135.c78d72b422f985aae5375bca@google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 02/21, Jonathan Tan wrote:
> On Tue,  6 Feb 2018 17:12:45 -0800
> Brandon Williams <bmwill@google.com> wrote:
> 
> > -	get_remote_heads(fd[0], NULL, 0, &ref, 0, NULL, &shallow);
> > +
> > +	packet_reader_init(&reader, fd[0], NULL, 0,
> > +			   PACKET_READ_CHOMP_NEWLINE |
> > +			   PACKET_READ_GENTLE_ON_EOF);
> > +
> > +	switch (discover_version(&reader)) {
> > +	case protocol_v1:
> > +	case protocol_v0:
> > +		get_remote_heads(&reader, &ref, 0, NULL, &shallow);
> > +		break;
> > +	case protocol_unknown_version:
> > +		BUG("unknown protocol version");
> > +	}
> 
> This inlining is repeated a few times, which raises the question: if the
> intention is to keep the v0/1 logic separately from v2, why not have a
> single function that wraps them all? Looking at the end result (after
> all the patches in this patch set are applied), it seems that the v2
> version does not have extra_have or shallow parameters, which is a good
> enough reason for me (I don't think functions that take in many
> arguments and then selectively use them is a good idea). I think that
> other reviewers will have this question too, so maybe discuss this in
> the commit message.

Yes this sort of switch statement appears a few times but really there
isn't a good way to "have one function to wrap it all" with the current
state of the code. That sort of change would take tons of refactoring to
get into a state where we could do that, and is outside the scope of
this series.

> 
> > diff --git a/remote.h b/remote.h
> > index 1f6611be2..2016461df 100644
> > --- a/remote.h
> > +++ b/remote.h
> > @@ -150,10 +150,11 @@ int check_ref_type(const struct ref *ref, int flags);
> >  void free_refs(struct ref *ref);
> >  
> >  struct oid_array;
> > -extern struct ref **get_remote_heads(int in, char *src_buf, size_t src_len,
> > +struct packet_reader;
> > +extern struct ref **get_remote_heads(struct packet_reader *reader,
> >  				     struct ref **list, unsigned int flags,
> >  				     struct oid_array *extra_have,
> > -				     struct oid_array *shallow);
> > +				     struct oid_array *shallow_points);
> 
> This change probably does not belong in this patch, especially since
> remote.c is unchanged.

Yes this hunk is needed, the signature of get_remote_heads changes.  It
may be difficult to see that due to the fact that we don't really have a
clear story on how header files are divided up within the project.

-- 
Brandon Williams
