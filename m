Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5690720281
	for <e@80x24.org>; Mon,  2 Oct 2017 15:49:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751902AbdJBPtW (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Oct 2017 11:49:22 -0400
Received: from mail-pg0-f46.google.com ([74.125.83.46]:47948 "EHLO
        mail-pg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751868AbdJBPtU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Oct 2017 11:49:20 -0400
Received: by mail-pg0-f46.google.com with SMTP id r25so778993pgn.4
        for <git@vger.kernel.org>; Mon, 02 Oct 2017 08:49:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=C4XbnPjqf5C8N5J3Jg1fZiOyeSEA2TQVlpbGnO6LuTM=;
        b=cGvjtnfi9hoSpuBbDzXkfQ+HGZ9I867au/0gAPESjXI7PBgyizN+aGTrJgLbiOADMV
         fhifaBDl7SK8dpJcj2McKF5vuaZGL9wD83EhMCp9DzI/UjCgjffR6TtLHEAPa34cNdpi
         5L3tPv5LcjNMntaAQlPOtg/TjfzyyZoaqHeXnI2rIY0eLdG1sy+UNgVD2AiwjPJi0dDI
         p7B+QuWjL+H4lDGDJv8Nw6sbYOE1+raLF6mDzcNZhJbMeCEfkAr6bOVZRMaDW15vfCdQ
         81kCPDfPAESG6t7oooRZJnwARwwu7NraMWav5XkvwTYFHGpf5DKrObTonOk+FbUb80zb
         EgsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=C4XbnPjqf5C8N5J3Jg1fZiOyeSEA2TQVlpbGnO6LuTM=;
        b=b3StaD7bhZg5O+5cj1CxouRZNYQYXMAUN/HjB8x8XAgkETN6JhiqHkj1louf0kx+jW
         FEf9vUxBjnifQxPpPLGMlJN1SPyP9f78+ip6AFSoiI/7YylN/0kQsd9TN2vbAfcPa15j
         aQF+e3c3pkrn1VYQDiXMswM1jWERRr2mB5ZTLNGwrPVPPRe3A9zX4ILodoxim5ia0PiW
         RLejUxThw2Zsywt2vVpL1DWUSRrMJE8INgsWHG7I+6kd8Z4YTBJ9MwxIvsE++NZL7Qtc
         vhMXt8VnGFgDxbh59WXC4fxFHTvctkOIFwq+GA9b306Gd4PDEMgmmQOezHeByGR7lyaD
         orVg==
X-Gm-Message-State: AHPjjUhmZq4Z91VV49X0RYDYnBlhjj86OJejxfBX/O158V4X9bq0WIb8
        9jlSLFx3BYg79YT5Rso/TeMJaA==
X-Google-Smtp-Source: AOwi7QDtacOqsAoh4E58EU6Vr83BwQlT3z7HyEMxUc7VSaMzvRd00h+BZuGwglVUIcpMgW5BtCgY3w==
X-Received: by 10.98.212.26 with SMTP id a26mr14623256pfh.333.1506959359552;
        Mon, 02 Oct 2017 08:49:19 -0700 (PDT)
Received: from localhost ([205.175.97.239])
        by smtp.gmail.com with ESMTPSA id i188sm15759352pgc.63.2017.10.02.08.49.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Oct 2017 08:49:18 -0700 (PDT)
Date:   Mon, 2 Oct 2017 08:49:16 -0700
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH v6 7/7] ref-filter.c: parse trailers arguments with
 %(contents) atom
Message-ID: <20171002154916.GA39723@D-10-157-251-166.dhcp4.washington.edu>
References: <20171002052326.GA10729@D-10-157-251-166.dhcp4.washington.edu>
 <20171002052524.12627-1-me@ttaylorr.com>
 <20171002052524.12627-7-me@ttaylorr.com>
 <20171002065100.cjawz6pvxjj2w5nr@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171002065100.cjawz6pvxjj2w5nr@sigill.intra.peff.net>
User-Agent: Mutt/1.8.3 (2017-05-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 02, 2017 at 02:51:00AM -0400, Jeff King wrote:
> > diff --git a/ref-filter.c b/ref-filter.c
> > index 43ed10a5e..6c26b4733 100644
> > --- a/ref-filter.c
> > +++ b/ref-filter.c
> > @@ -212,9 +212,10 @@ static void contents_atom_parser(const struct ref_format *format, struct used_at
> >  		atom->u.contents.option = C_SIG;
> >  	else if (!strcmp(arg, "subject"))
> >  		atom->u.contents.option = C_SUB;
> > -	else if (!strcmp(arg, "trailers"))
> > -		atom->u.contents.option = C_TRAILERS;
> > -	else if (skip_prefix(arg, "lines=", &arg)) {
> > +	else if (skip_prefix(arg, "trailers", &arg)) {
> > +		skip_prefix(arg, ":", &arg);
> > +		trailers_atom_parser(format, atom, *arg ? NULL : arg);
>
> I think your logic is flipped. You want "*arg ? arg : NULL";

Thank you for pointing this out. I should have run "make test" on this
patch set (or, as you suggested, `git rebase -x "make test" HEAD~7`)
before sending it out. I appreciate you catching my mistake, and I'll
make sure to run "make test" more diligently in the future :-).

It sounds like Junio picked this up while queueing.

--
- Taylor
