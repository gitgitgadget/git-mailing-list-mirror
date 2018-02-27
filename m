Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8F8AD1FAE2
	for <e@80x24.org>; Tue, 27 Feb 2018 18:57:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751554AbeB0S5i (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Feb 2018 13:57:38 -0500
Received: from mail-io0-f178.google.com ([209.85.223.178]:39188 "EHLO
        mail-io0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751463AbeB0S5h (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Feb 2018 13:57:37 -0500
Received: by mail-io0-f178.google.com with SMTP id b34so386558ioj.6
        for <git@vger.kernel.org>; Tue, 27 Feb 2018 10:57:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=low81NFJqbV+bzLswtdU1vqVE9iOtVnXxAqzU8FlaeE=;
        b=oCaMeJrdRaw2K0YdkM2ylVC9Kwjq12wpI4aqepOyEeGPFshpMnWlLo3X32i8JFHqmF
         dvbSw0zYqvmNuR5yzY/BwvgmR9xgA7gFmiOM2ln6YDWEum9I9+dwPUzooCUT7oZcGBEx
         +lHMsbxqkCaXS2v9QEKntIXZTo6LIkAsIGl9IF/i2FaTQ1hkuGsYux5s9ib8h+DECnTy
         hbNXoB5sv+oQTAxc/8RLORPQaSc9QWbjNnavKcxoVb/FkUwQX0fv4LWZUMEfRJcDn4td
         BIX5Qkt6jCt7E9dlOJMTGQRwTD841b1S3gCTqIuFeHbFUkiF81uFBjny1xD7fRnTl9pe
         GzDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=low81NFJqbV+bzLswtdU1vqVE9iOtVnXxAqzU8FlaeE=;
        b=XjZjpuK6Q/U5un4wA7U4JvoO0RSHXeyPqufwFwCnX7EaCzn44Sp7kZIhZD8loWX3TA
         CLhYge+gSITuU2VbDc1nxBl/GH1GXdZOiS7TjEP+eRoluAB5mfc+i3EplSGAJd6vXhXy
         nk9A+SRP/P/27zEz9GT+Ww13MKtcTXT4c0aPZk/YD0r6iynLsWbWEd8JkW9gj2EbrSUw
         G4Ys/Q+ssnj4eKWKiM5rz4ZXcv876hhDNtHKzmTIyY0l8DyOBhU+i6aBDe1qYxIVNIrB
         sOoACadlRm79tTHiLbPYskpsrInNOGmB+1JwEPPCBG7BzOdGwORaL0lDbV2cYlhtaxrn
         5ntQ==
X-Gm-Message-State: APf1xPB8tSswPY1xqwMt0TYb7to8Hv9Ffd0Qhj/0nndk9A42LH87vnt6
        5UEiybmKLUuzXzdrVsrOLh6gCA==
X-Google-Smtp-Source: AG47ELswcCgNoop93YHE27ayPXeWNPEfjTt9gyAApeScgEub6bz2ojr4buCwlMH+YBbwtoSzjJA5Xw==
X-Received: by 10.107.48.3 with SMTP id w3mr16653346iow.84.1519757856008;
        Tue, 27 Feb 2018 10:57:36 -0800 (PST)
Received: from google.com ([2620:0:100e:422:ff43:9291:7eda:b712])
        by smtp.gmail.com with ESMTPSA id l42sm2958033ioi.53.2018.02.27.10.57.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 27 Feb 2018 10:57:35 -0800 (PST)
Date:   Tue, 27 Feb 2018 10:57:33 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     git@vger.kernel.org, sbeller@google.com, peff@peff.net,
        gitster@pobox.com, stolee@gmail.com, git@jeffhostetler.com,
        pclouds@gmail.com
Subject: Re: [PATCH v3 22/35] upload-pack: support shallow requests
Message-ID: <20180227185733.GF209668@google.com>
References: <20180125235838.138135-1-bmwill@google.com>
 <20180207011312.189834-1-bmwill@google.com>
 <20180207011312.189834-23-bmwill@google.com>
 <20180227182854.GA174036@aiede.svl.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180227182854.GA174036@aiede.svl.corp.google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 02/27, Jonathan Nieder wrote:

I'll make the documentation changes you suggested.

> > +    deepen <depth>
> > +	Request that the fetch/clone should be shallow having a commit depth of
> 
> nit: s/Request/Requests/, for consistency with the others?
> 
> > +	<depth> relative to the remote side.
> 
> What does the value of <depth> mean? E.g. does a depth of 1 mean to
> fetch only the commits named in "have", 2 to fetch those commits plus
> their parents, etc, or am I off by one?

Honestly I have no clue, what does the current protocol do?  There isn't
any documentation about it and this just reuses the logic from that.

> 
> Is <depth> always a positive number?
> 
> What happens if <depth> starts with a 0?  Is that a client error?
> 

> >      output = *section
> > -    section = (acknowledgments | packfile)
> > +    section = (acknowledgments | shallow-info | packfile)
> >  	      (flush-pkt | delim-pkt)
> 
> It looks like sections can go in an arbitrary order.  Are there
> tests to make sure the server can cope with reordering?  (I ask
> not because I mistrust the server but because I have some vague
> hope that other server implementations might be inspired by our
> tests.)

I'll fix this so that they don't come in arbitrary order

> 
> [...]
> > @@ -215,6 +245,11 @@ header.
> >      nak = PKT-LINE("NAK" LF)
> >      ack = PKT-LINE("ACK" SP obj-id LF)
> >  
> > +    shallow-info = PKT-LINE("shallow-info" LF)
> > +		   *PKT-LINE((shallow | unshallow) LF)
> > +    shallow = "shallow" SP obj-id
> > +    unshallow = "unshallow" SP obj-id
> 
> Likewise: it looks like shallows and unshallows can be intermixed; can
> this be either (a) tightened or (b) covered by tests to make sure a
> later refactoring doesn't accidentally tighten it?

This reuses the existing logic from v0 so its due to that spec.

> > --- a/upload-pack.c
> > +++ b/upload-pack.c
> > @@ -710,7 +710,6 @@ static void deepen(int depth, int deepen_relative,
> >  	}
> >  
> >  	send_unshallow(shallows);
> > -	packet_flush(1);
> 
> What does this part do?
> >  }
> >  
> >  static void deepen_by_rev_list(int ac, const char **av,
> > @@ -722,7 +721,52 @@ static void deepen_by_rev_list(int ac, const char **av,
> >  	send_shallow(result);
> >  	free_commit_list(result);
> >  	send_unshallow(shallows);
> > -	packet_flush(1);
> 
> Same question.

Pulling out the flush packet so that the logic can be reused for v2, the
flush is added back in for the v0 case but not for the v2 case.

> 
> > +}
> > +
> > +static int send_shallow_list(int depth, int deepen_rev_list,
> > +			     timestamp_t deepen_since,
> > +			     struct string_list *deepen_not,
> > +			     struct object_array *shallows)
> 
> What does the return value from this function represent?  It doesn't
> appear to be the usual "0 means success, -1 means failure" so a
> comment would help.

I'll add a comment.

> 
> > +{
> > +	int ret = 0;
> > +
> > +	if (depth > 0 && deepen_rev_list)
> > +		die("git upload-pack: deepen and deepen-since (or deepen-not) cannot be used together");
> 
> nit: long line (can/should "make style" find these?)
> 
> The error message is pretty long, longer than a typical 80-column
> terminal, so probably best to find a way to make the message shorter.
> E.g.
> 
> 		die("upload-pack: deepen cannot be combined with other deepen-* options");
> 
> That still would be >80 columns with the indent, so the usual style
> would be to break it into multiple strings and use C preprocessor
> concatenation (yuck):
> 
> 		die("upload-pack: "
> 		    "deepen cannot be combined with other deepen-* options");
> 

> [...]
> > +	if (depth > 0) {
> > +		deepen(depth, deepen_relative, shallows);
> > +		ret = 1;
> > +	} else if (deepen_rev_list) {
> > +		struct argv_array av = ARGV_ARRAY_INIT;
> > +		int i;
> > +
> > +		argv_array_push(&av, "rev-list");
> > +		if (deepen_since)
> > +			argv_array_pushf(&av, "--max-age=%"PRItime, deepen_since);
> > +		if (deepen_not->nr) {
> > +			argv_array_push(&av, "--not");
> > +			for (i = 0; i < deepen_not->nr; i++) {
> > +				struct string_list_item *s = deepen_not->items + i;
> > +				argv_array_push(&av, s->string);
> 
> This accepts arbitrary rev-list arguments, which feels dangerous
> (could end up doing an expensive operation or reading arbitrary files
> or finding a way to execute arbitrary code).
> 
> [...]
> > -		if (deepen_not.nr) {
> > -			argv_array_push(&av, "--not");
> > -			for (i = 0; i < deepen_not.nr; i++) {
> > -				struct string_list_item *s = deepen_not.items + i;
> > -				argv_array_push(&av, s->string);
> 
> Huh.  Looks like some of the above comments are better addressed to an
> earlier patch.

If someone wants to fix this after the fact they can, I just moved this
logic, I didn't add it.

> 
> [...]
> > @@ -1071,6 +1085,13 @@ struct upload_pack_data {
> >  	struct object_array wants;
> >  	struct oid_array haves;
> >  
> > +	struct object_array shallows;
> > +	struct string_list deepen_not;
> > +	int depth;
> > +	timestamp_t deepen_since;
> > +	int deepen_rev_list;
> > +	int deepen_relative;
> 
> Nice.
> 
> Comments describing deepen_Rev_list and deepen_relative would be nice.
> 
> Are those boolean?  Can they be unsigned:1 to make that
> self-explanatory?

They are boolean but are passed via reference at some points so they
can't be bit flags.

> 
> [...]
> > @@ -1080,12 +1101,14 @@ struct upload_pack_data {
> >  	unsigned done : 1;
> >  };
> >  
> > -#define UPLOAD_PACK_DATA_INIT { OBJECT_ARRAY_INIT, OID_ARRAY_INIT, 0, 0, 0, 0, 0, 0 }
> > +#define UPLOAD_PACK_DATA_INIT { OBJECT_ARRAY_INIT, OID_ARRAY_INIT, OBJECT_ARRAY_INIT, STRING_LIST_INIT_DUP, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 }
> 
> Long line, "make style" should be able to fix it.
> 

I'll fix this.

-- 
Brandon Williams
