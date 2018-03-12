Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-0.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B50141F404
	for <e@80x24.org>; Mon, 12 Mar 2018 22:24:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751397AbeCLWYr (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Mar 2018 18:24:47 -0400
Received: from mail-pg0-f50.google.com ([74.125.83.50]:45175 "EHLO
        mail-pg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751282AbeCLWYq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Mar 2018 18:24:46 -0400
Received: by mail-pg0-f50.google.com with SMTP id s13so4210773pgn.12
        for <git@vger.kernel.org>; Mon, 12 Mar 2018 15:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lKPth98DdC93Mxj81BJFfExeXyM6Y3pjxYd82FLarBY=;
        b=nou4fZCYqS2GsC2qFGjxsESoCeBaPADPiMnYWCOORJyz5r99VGx4A3oIBK5sJv+HtP
         ffpmkgyq6c3KfqH/lhcN/0jJMRqOqxIbo4xybF03uejv4r3oJEnpxSXFM9dVGwYicJP5
         IBK1z2ZgRlSMTUgLbrW9C4Swt0vVbZzl2jEepUAe+795lzk+E2cRinlX2G0eiRaDwx7o
         GPkYhIWdbRmORN52Hd/JKnOhp3y2+tNe7SQG2T6eoE9+qDtUxuLQ9BVjH868CTL7aL5p
         hdpyW0O7jKPylbp3gs50SABc332Yx5WjcdYrYJICtFiBbB6x08+gNrWrEJi5s/UImYcn
         RPOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lKPth98DdC93Mxj81BJFfExeXyM6Y3pjxYd82FLarBY=;
        b=dYSHMaZd5vCvETytnpiZNH5ySmLqqW8BbFqpHQrpKRqkobWZ1+375axUnA9GsRIIO5
         QYnUkSpD7sjVehFYmo79zdprG5HnLmIb1K3BDKWx6hP9mhdB0w2Ib8z0i3L88zBt8n+R
         096l05TcWmV9MqI+HcTmCBP4XNsEzT+c5LeTHz5D5M23ZvcLHIk9ut3Al7p16pgi0BV0
         Zps/M8jQqAp/w2np0uDkO7vxyp48q0Kys2q2I0l3eIcaaUMXVqckkRlXOAzJnHQjOB8R
         +0X6OaZeOq4DFNs6SGwJ3/9eANFuU+X/TOwLVYenJiqjcomcmZwkUQmsrHmyhlPXbJNL
         8G3A==
X-Gm-Message-State: AElRT7Hp+kjDq1ks9z3BWpZdJ9Ysam8SiDlmtrzHHbqcOV4u3I4hr2oA
        Iyv1RwvpSsoTJZlgrMRo+P6aYQ==
X-Google-Smtp-Source: AG47ELt+wr0pQPfFq1qD8soEo7tS7TbZfaDlhyjdEBPtVgUhU1F3jxAgY8DIKI5aidN82nTsSQE+6Q==
X-Received: by 10.99.115.84 with SMTP id d20mr7855940pgn.362.1520893485420;
        Mon, 12 Mar 2018 15:24:45 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:ff43:9291:7eda:b712])
        by smtp.gmail.com with ESMTPSA id y84sm18297268pff.81.2018.03.12.15.24.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 12 Mar 2018 15:24:44 -0700 (PDT)
Date:   Mon, 12 Mar 2018 15:24:43 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, git@jeffhostetler.com, jrnieder@gmail.com,
        pclouds@gmail.com, peff@peff.net, sbeller@google.com,
        stolee@gmail.com
Subject: Re: [PATCH v4 05/35] upload-pack: factor out processing lines
Message-ID: <20180312222443.GE61720@google.com>
References: <20180207011312.189834-1-bmwill@google.com>
 <20180228232252.102167-1-bmwill@google.com>
 <20180228232252.102167-6-bmwill@google.com>
 <xmqq371jfpzj.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq371jfpzj.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/01, Junio C Hamano wrote:
> Brandon Williams <bmwill@google.com> writes:
> 
> > Factor out the logic for processing shallow, deepen, deepen_since, and
> > deepen_not lines into their own functions to simplify the
> > 'receive_needs()' function in addition to making it easier to reuse some
> > of this logic when implementing protocol_v2.
> 
> These little functions that still require their incoming data to
> begin with fixed prefixes feels a bit strange way to refactor the
> logic for later reuse (when I imagine "reuse", the first use case
> that comes to my mind is "this data source our new code reads from
> gives the same data as the old 'shallow' packet used to give, but in
> a different syntax"---so I'd restructure the code in such a way that
> the caller figures out the syntax part and the called helper just
> groks the "information contents" unwrapped from the surface syntax;
> the syntax may be different in the new codepath but once unwrapped,
> the "information contents" to be processed would not be different
> hence we can reuse the helper).
> 
> IOW, I would have expected the caller to be not like this:
> 
> > -		if (skip_prefix(line, "shallow ", &arg)) {
> > -			struct object_id oid;
> > -			struct object *object;
> > -			if (get_oid_hex(arg, &oid))
> > -				die("invalid shallow line: %s", line);
> > -			object = parse_object(&oid);
> > -			if (!object)
> > -				continue;
> > -			if (object->type != OBJ_COMMIT)
> > -				die("invalid shallow object %s", oid_to_hex(&oid));
> > -			if (!(object->flags & CLIENT_SHALLOW)) {
> > -				object->flags |= CLIENT_SHALLOW;
> > -				add_object_array(object, NULL, &shallows);
> > -			}
> > +		if (process_shallow(line, &shallows))
> >  			continue;
> > +		if (process_deepen(line, &depth))
> >  			continue;
> 		...
> 
> but more like
> 
> 		if (skip_prefix(line, "shallow ", &arg) {
> 			process_shallow(arg, &shallows);
> 			continue;
> 		}
> 		if (skip_prefix(line, "deepen ", &arg) {
> 			process_deepen(arg, &depth);
> 			continue;
> 		}
> 		...
> 
> I need to defer the final judgment until I see how they are used,
> though.  It's not too big a deal either way---it just felt "not
> quite right" to me.

This is actually a really good point (and maybe the same point stefan
was trying to make on an old revision of this series).  I think it makes
much more sense to refactor the code to have a structure like you've
outlined.  I'll fix this for the next version.

-- 
Brandon Williams
