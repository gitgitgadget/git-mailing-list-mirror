Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F343E1F406
	for <e@80x24.org>; Tue,  9 Jan 2018 19:09:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935259AbeAITJg (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Jan 2018 14:09:36 -0500
Received: from mail-pf0-f196.google.com ([209.85.192.196]:34288 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933326AbeAITJe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Jan 2018 14:09:34 -0500
Received: by mail-pf0-f196.google.com with SMTP id e76so4449705pfk.1
        for <git@vger.kernel.org>; Tue, 09 Jan 2018 11:09:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7X/UeVggwfn6quLHsHKKgt3rugIq3sXN+zeZZS+J9dI=;
        b=YPKnlZh2t7sx/4xFm1K3Ucw9v/JDRN1YxzC2nTFkNT1HqJvLaZzL79Xd/NeFyR8nAg
         ckz76PP06X1xVREGWCTsvJFBfuzUgI5sSy+ZVPAbdktGw2R1na1NB/ZIt34MFlGVhhgC
         uU+0pnh/FI92Rh62NpiI5nPuUvUM8zx6IYcUvZEQ65caqqseeZBLcjoGWGTgMMucUM2o
         cJjUEzDSdi7kYXEB3PeJA1HR1kvEslgxDrej2Ld1AH40Hy0H9CBvW60ktX/rs1r+KZNq
         93p5UsK1TGlqFIZergvZ+IEoIdOpH0Uwq2TD8TDYVfUHvlC3S1rawRLpNXoW0caOIEQg
         KI6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7X/UeVggwfn6quLHsHKKgt3rugIq3sXN+zeZZS+J9dI=;
        b=Kn6EZA4Bw6s8HaX1ZKvc6lYwXKrBjTtO95pThwGNr/Ag2LjJ7N474KygUadlrBA+7n
         NJH6+wTXB23EeIq5dJjiJQKbar34Y8eZTXyk1Jz1fbIW0DFrl0y9p8VXiC+Pw4OvGP15
         bP4Su4In6lo4IBFq6oZ2h/5wvbmGEzCSOuarxoc6C1fPtlSOsMzZ8pTrgnOY8MbZNgX2
         44EZzZLwn88yvFvXBAKHT0312SgL8cftTdC4dh4Q7282l2gIb3xbF6nKACOEwGlgCaBX
         XW3LjxMVXQlEB+vbHOjagPSMZObI/RHn8NgY+sqb4Y1IGalDO/P5rdO3SGR+AZ96EbnL
         1e8A==
X-Gm-Message-State: AKGB3mISE+DXCrZ1rkofEqM7t243igsGc7QdGf0DU76sXGAKyHA0uNGE
        dRSMB6GXzik3A09CC7DEdLeHCQ==
X-Google-Smtp-Source: ACJfBou3QzdDsxcfj4eDjMLtOsESuF2wsviCaEK0H0qiTpcxrEKEzq1ywDz8bvV9EDmGuRODwy3ozg==
X-Received: by 10.101.66.198 with SMTP id l6mr12930723pgp.148.1515524973826;
        Tue, 09 Jan 2018 11:09:33 -0800 (PST)
Received: from google.com ([2620:0:100e:422:5de7:5b51:7854:d1a5])
        by smtp.gmail.com with ESMTPSA id r1sm32897869pfg.98.2018.01.09.11.09.32
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 09 Jan 2018 11:09:32 -0800 (PST)
Date:   Tue, 9 Jan 2018 11:09:31 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, sbeller@google.com, gitster@pobox.com,
        peff@peff.net, philipoakley@iee.org, stolee@gmail.com,
        jrnieder@gmail.com
Subject: Re: [PATCH 07/26] connect: convert get_remote_heads to use struct
 packet_reader
Message-ID: <20180109190931.GA151395@google.com>
References: <20180103001828.205012-1-bmwill@google.com>
 <20180103001828.205012-8-bmwill@google.com>
 <20180109102735.a6d3330325aef428fde87700@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180109102735.a6d3330325aef428fde87700@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 01/09, Jonathan Tan wrote:
> On Tue,  2 Jan 2018 16:18:09 -0800
> Brandon Williams <bmwill@google.com> wrote:
> 
> > -	while ((len = read_remote_ref(in, &src_buf, &src_len, &responded))) {
> > +	while (state != EXPECTING_DONE) {
> > +		switch (packet_reader_read(&reader)) {
> > +		case PACKET_READ_EOF:
> > +			die_initial_contact(1);
> > +		case PACKET_READ_NORMAL:
> > +			len = reader.pktlen;
> > +			if (len > 4 && skip_prefix(packet_buffer, "ERR ", &arg))
> 
> This should be a field in reader, not the global packet_buffer, I think.

Thanks for catching that.

> 
> Also, I did a search of usages of packet_buffer, and there are just a
> few of them - it might be worthwhile to eliminate it, and have each
> component using it allocate its own buffer. But this can be done in a
> separate patch set.

I'll go through and eliminate the references to packet_buffer by passing
in the buffer explicitly.

> 
> > @@ -269,6 +284,8 @@ struct ref **get_remote_heads(int in, char *src_buf, size_t src_len,
> >  			if (process_shallow(len, shallow_points))
> >  				break;
> >  			die("protocol error: unexpected '%s'", packet_buffer);
> 
> Here too.

-- 
Brandon Williams
