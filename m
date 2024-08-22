Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDAFA168488
	for <git@vger.kernel.org>; Thu, 22 Aug 2024 20:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724358055; cv=none; b=QphEnMO15kEGvKQiIe27cdxfUh7qJ6gFiPEXewLKEaW+56Wf4np5SKcMCLJ9FQB04yfwAGbLxDxG6kgDQYK1aasIxALmvd3VIAFaG6FWAaGnxxFsk9S+5cMJhXr6ruscHd40ZqhRgGqhxcrMnMaOPqhHbIfYmwyJUXKrSpZG5Fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724358055; c=relaxed/simple;
	bh=x2HcrXxlUmnNc5fr5GZ4rGc8WpXxDRp6RI2qIzZorzI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D3CQwdBzEY/tQ6jbyNFLDYG/uJ33rf87wKlHH47IzHNzRQ4OTWRGa9wNBobymRjIoWpESsonnvBkHwVe2I86PTUyRDYaA5Dz92TU97BgwWfqE1a5682RsY4h72S4n4YaVYBUfzU9KUsZCtGhA11dXzWUxmxJxpyFj9Jq1Cg11ZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=T7NhlgAM; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="T7NhlgAM"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-20353e5de9cso41955ad.0
        for <git@vger.kernel.org>; Thu, 22 Aug 2024 13:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724358053; x=1724962853; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uUecBdnV6odJPW8gTkKPHA1f6cU3/O9SO68lqwttY0A=;
        b=T7NhlgAMpy5yxTLmYPGMToWfcoUE12yaiciVmZS6eqKvZexHK/cO00a/JNPTs453SB
         3aKcV6NWe4t7OoicBPe6nKjLhT88AbWHogBq+y3PSwvE6GzgrnnxVskjRxwOhxxb16Vg
         j8LpCaPLp7M9mCwYjswOUenlxbQLv26CrxEASr1fLZVxKa4RYv6ZR7kLnSb302v5wKd2
         I334y3TaGIqFDBgA3fbs8IiRHRDDi6FjfaXTxaHsDsSN6FLh5IiSlG4kbp3PHISFbh37
         kfBHV1WNy7EkPeWZU1NJ+jCuk3P70K9/n1ZC5dyfSrkxEyqaQpM+cL7CNSkQmzFv6kFl
         K51w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724358053; x=1724962853;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uUecBdnV6odJPW8gTkKPHA1f6cU3/O9SO68lqwttY0A=;
        b=MbcACbwbNiux5HsPrCKwp70VgAqkNdC3mEZG/gpTkLeHIMdMZXg7mm9GILPdry4wo5
         1a1staERmRG0zrW+X+tOkuc19bAw8EJY+qTeDhWMtImhY8brU2qaTOh31SoqLkXPP/LB
         D4OQ7kdArnunjJ9izj/atmqEdmMjAcxcb6CRMa8DbdVka4n4lrwtS1r5IYVP7rK93w5X
         tnDyGZ6f/aBWRFHe1X2Tn8pbpdjmrTKHM5Mpnr5uvYhZf/C6A6t3o/VcYj5qL1qKagUW
         Mwl5LUxPftYH9+E0txt+7/V02okq26B4Hj09WtM0rIKn9D8OdNT78D8KmsxR3RNvQ1LQ
         pJFg==
X-Gm-Message-State: AOJu0YzxHDyIMHywEr901F82gz3O+Veok5SEjm37+zKTiSgy7nGYrSZA
	3c6Qsql4pf3y30XYNK88JsXvS46jngHEIkQ22O9LHsVo/NvPfETAd7iuQ/5iCYauWmJm4mhf09T
	OqA==
X-Google-Smtp-Source: AGHT+IFDQszJC6t9KlU0KWPYjjrmjEgNbu73fx5Y1vMizG3Ara+nQp2+FXvV0TKRNHDPyGttq94kxQ==
X-Received: by 2002:a17:903:2348:b0:201:f5b9:82da with SMTP id d9443c01a7336-20399255ce6mr730315ad.6.1724358052606;
        Thu, 22 Aug 2024 13:20:52 -0700 (PDT)
Received: from google.com ([2620:15c:2d3:204:9ba9:7ac3:74ce:2b8f])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7cd9acc3977sm1775929a12.30.2024.08.22.13.20.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 13:20:52 -0700 (PDT)
Date: Thu, 22 Aug 2024 13:20:46 -0700
From: Josh Steadmon <steadmon@google.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/2] send-pack: add new tracing regions for push
Message-ID: <jjnfnxuozlsguonviswt23simi4gwqjaetcm7b7wn7kndk6o4t@7p4dedarn6xt>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>, 
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <cover.1723747832.git.steadmon@google.com>
 <d57f258026f941e7bc05de8dac359fc1e2e42bee.1723747832.git.steadmon@google.com>
 <xmqq8qwxsg8w.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq8qwxsg8w.fsf@gitster.g>

On 2024.08.15 13:06, Junio C Hamano wrote:
> Josh Steadmon <steadmon@google.com> writes:
> 
> > From: Calvin Wan <calvinwan@google.com>
> >
> > At $DAYJOB we experienced some slow pushes and needed additional trace
> > data to diagnose them.
> >
> > Add trace2 regions for various sections of send_pack().
> >
> > Signed-off-by: Josh Steadmon <steadmon@google.com>
> > ---
> >  send-pack.c | 16 +++++++++++++---
> >  1 file changed, 13 insertions(+), 3 deletions(-)
> >
> > diff --git a/send-pack.c b/send-pack.c
> > index fa2f5eec17..de8ba46ad5 100644
> > --- a/send-pack.c
> > +++ b/send-pack.c
> > @@ -512,8 +512,11 @@ int send_pack(struct send_pack_args *args,
> >  	}
> >  
> >  	git_config_get_bool("push.negotiate", &push_negotiate);
> > -	if (push_negotiate)
> > +	if (push_negotiate) {
> > +		trace2_region_enter("send_pack", "push_negotiate", the_repository);
> >  		get_commons_through_negotiation(args->url, remote_refs, &commons);
> > +		trace2_region_leave("send_pack", "push_negotiate", the_repository);
> > +	}
> 
> > @@ -641,10 +644,12 @@ int send_pack(struct send_pack_args *args,
> >  	/*
> >  	 * Finally, tell the other end!
> >  	 */
> > -	if (!args->dry_run && push_cert_nonce)
> > +	if (!args->dry_run && push_cert_nonce) {
> > +		trace2_region_enter("send_pack", "push_cert", the_repository);
> >  		cmds_sent = generate_push_cert(&req_buf, remote_refs, args,
> >  					       cap_buf.buf, push_cert_nonce);
> > -	else if (!args->dry_run)
> > +		trace2_region_leave("send_pack", "push_cert", the_repository);
> > +	} else if (!args->dry_run) {
> 
> Misleading "diff" but this is correct.
> 
> But makes me wonder if we really want to express these (and other
> events we saw in [PATCH 1/2]) as regions we enter and leave.
> Presumably we would generate a certificate instantly, compared to
> all the other things happening in this process, like talking over
> the network, waiting for the other end, and packing the payload, and
> I suspect that the single bit the debuggers would want to learn from
> the trace is "did we get asked to give a certificate?".
> Sandwitching a rather expensive operation inside a pair of
> enter/leave would give us a way to measure how long that operation
> took in exchanges for one extra trace log entry, and "ah, we need to
> first fetch the bundle and process it" we saw in [PATCH 1/2] is
> something that is worth timing, but I am finding a bit hard to
> believe it is worth doing for push cert generation.  It is
> understandable if there weren't any suitable mechanism to simply log
> "the control passed at this spot at this time" kind of event in the
> trace2 subsystem, but I do not think it is the case.

Ack, changed this to a "trace2_printf()" instead. Annoyingly the JSON
Event trace2 target that we use at $DAYJOB doesn't log these events, but
I can add another patch to enable that.


> > @@ -686,6 +692,7 @@ int send_pack(struct send_pack_args *args,
> >  	strbuf_release(&cap_buf);
> >  
> >  	if (use_sideband && cmds_sent) {
> > +		trace2_region_enter("send_pack", "sideband_demux", the_repository);
> >  		memset(&demux, 0, sizeof(demux));
> >  		demux.proc = sideband_demux;
> >  		demux.data = fd;
> > @@ -719,6 +726,8 @@ int send_pack(struct send_pack_args *args,
> >  			if (use_sideband) {
> >  				close(demux.out);
> >  				finish_async(&demux);
> > +				if (cmds_sent)
> > +					trace2_region_leave("send_pack", "sideband_demux", the_repository);
> >  			}
> >  			fd[1] = -1;
> >  			return -1;
> > @@ -743,6 +752,7 @@ int send_pack(struct send_pack_args *args,
> >  			error("error in sideband demultiplexer");
> >  			ret = -1;
> >  		}
> > +		trace2_region_leave("send_pack", "sideband_demux", the_repository);
> >  	}
> 
> This is also dubious.  When sideband is in effect, this records the
> fact that we did ran pack-objects and allows as to measure how much
> time it was spent.  But on a connection without sideband enabled, it
> does not record anything.  But if we start the region a line sooner,
> and finish the region a line later, we should be able to record the
> same facts even for a connection without sideband enabled.  I also
> find the name given to this region ultra-iffy.  Is it so important
> that sideband_demux was used to communicate with the other end that
> received the data our pack_objects() produced that the word
> "sideband_demux" deserves to be in the name of the region, more than
> the fact that this is the crux of sending pack data from us to them
> (i.e. the main part of the "send-pack")?

Yeah, thanks, this did need to be reworked. I pushed the regions down
into pack_objects() and receive_status(), which look like the only two
places we might spend much time.
