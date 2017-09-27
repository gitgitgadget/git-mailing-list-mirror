Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7EC1C2047F
	for <e@80x24.org>; Wed, 27 Sep 2017 21:29:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752030AbdI0V35 (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Sep 2017 17:29:57 -0400
Received: from mail-pg0-f43.google.com ([74.125.83.43]:43734 "EHLO
        mail-pg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751801AbdI0V34 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Sep 2017 17:29:56 -0400
Received: by mail-pg0-f43.google.com with SMTP id u18so8478352pgo.0
        for <git@vger.kernel.org>; Wed, 27 Sep 2017 14:29:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5oGf/bjbTeNtlb5fEmfRRHzLFIuuxU1222kfPmM+u1M=;
        b=AlNnALQH0V2oD5ytEgbSUApDjy2ihZAWdl2Ee0RMFUNFfBSkcExep/OH22rFjNHBF+
         wQ97ErRT25gnxtciE2jUWmf5ovjXiJLFDtwa1I9HNQry2kN2i9PPheUmkY9YYzTapOIV
         S4YmLD1YlhuQVbwY3YNZG3cb/bc0juIfSxg444ZZICGQ+qmbWlAunGNJXAXzBX54Yi6a
         iiBgxCJxfm/ZcDVUV5vZtiH3YaWRwZy9h1pjT8FEIAM1tj793+vnanMT8cDcgGjS0B4H
         lj9W1DXYMdL/oYD0QcQpWZlWk2lKwO9wnzMEyXuRStxs5yFCE/QuiGX+4OFB3TnFfMiX
         /RyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5oGf/bjbTeNtlb5fEmfRRHzLFIuuxU1222kfPmM+u1M=;
        b=kgKV6VvKiUi7bRyvB6E+SlEvmcU3WIjdX1v+IA9CYh6FpihBR4N7R19XJGSPmD0uI+
         njNrwFeZLAraE4zOhunUqKYdkrwoVPDvTbkgRu+tvRVAq0NB3YcEjF474VV6BUh2tazr
         2BY1cK3ekvz/RynZEbJwoeR3CmWj0HR08uCeo3+Ek4vyQDr0BfXfNjwSYDtoiDFXwBin
         gfJvOS6p9NcFvijLarlf+XTff6fzXQc5Geu6Fkpw1LZeU0qvGjP+lmjPrc5UgIQiVU7J
         myheLJKw3L34ss8fu8FYsyzAM0tCLXQh3MuFg4e8HoXF9GrZzKrjgvGzlY5zSD8ooEfH
         TB5A==
X-Gm-Message-State: AHPjjUi5NWyQog6rg16lhW/bUKGbjeux/65S4xVNHqYojUWlBxao+ckc
        ILr6/z3aKwBxonErOv0PKOmE+g==
X-Google-Smtp-Source: AOwi7QDvUP9o9RXmT4ZFw6rrudoWz/r5ffMzmnrtjgSa1Prtjp7GyKszbGrREsEd+sN7aGza1W8BNA==
X-Received: by 10.101.85.204 with SMTP id k12mr2326111pgs.439.1506547795925;
        Wed, 27 Sep 2017 14:29:55 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:880:967f:fa0a:fc13])
        by smtp.gmail.com with ESMTPSA id u31sm21480550pgn.70.2017.09.27.14.29.54
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 27 Sep 2017 14:29:55 -0700 (PDT)
Date:   Wed, 27 Sep 2017 14:29:48 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, bturner@atlassian.com, git@jeffhostetler.com,
        jonathantanmy@google.com, jrnieder@gmail.com, peff@peff.net,
        sbeller@google.com
Subject: Re: [PATCH v2 5/9] upload-pack, receive-pack: introduce protocol
 version 1
Message-ID: <20170927212948.GB68699@google.com>
References: <20170913215448.84674-1-bmwill@google.com>
 <20170926235627.79606-1-bmwill@google.com>
 <20170926235627.79606-6-bmwill@google.com>
 <xmqqvak467fy.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqvak467fy.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 09/27, Junio C Hamano wrote:
> Brandon Williams <bmwill@google.com> writes:
> 
> > @@ -1963,6 +1964,19 @@ int cmd_receive_pack(int argc, const char **argv, const char *prefix)
> >  	else if (0 <= receive_unpack_limit)
> >  		unpack_limit = receive_unpack_limit;
> >  
> > +	switch (determine_protocol_version_server()) {
> > +	case protocol_v1:
> > +		if (advertise_refs || !stateless_rpc)
> > +			packet_write_fmt(1, "version 1\n");
> > +		/*
> > +		 * v1 is just the original protocol with a version string,
> > +		 * so just fall through after writing the version string.
> > +		 */
> > +	case protocol_v0:
> > +	default:
> > +		break;
> 
> When protocol_v2 is introduced in the other part of the codebase
> (i.e. in protocol.[ch]), until these lines are updated accordingly
> to take care of the new protocol, we'd pretend that client asked
> (and the server accepted) v0, even though the client and the daemon
> agreed to talk v2.
> 
> Shouldn't the "default:" die instead?  The same for upload-pack.c

Good catch.  Yeah you're right, the default should probably die saying
that receive pack or upload pack doesn't support the protocol version.

-- 
Brandon Williams
