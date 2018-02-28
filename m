Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B7C951F404
	for <e@80x24.org>; Wed, 28 Feb 2018 01:08:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751646AbeB1BIZ (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Feb 2018 20:08:25 -0500
Received: from mail-pg0-f51.google.com ([74.125.83.51]:43944 "EHLO
        mail-pg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751139AbeB1BIZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Feb 2018 20:08:25 -0500
Received: by mail-pg0-f51.google.com with SMTP id e9so312884pgs.10
        for <git@vger.kernel.org>; Tue, 27 Feb 2018 17:08:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dM070hPEEtxbIZT7CSkwr/k8XskxS5oXkmZBTXIPuKA=;
        b=nLmHguUPSdFUFwhUqjc7eO5B5lubm/pLKKRWbndHHqVaEFgqLhELH7w9wHbYh9HtfR
         Ccnbx/Ujmx1Yq41rpieTq0cn63ZdKQro1P2owWGGuwAFtMaAyP0iYRVlf9nbidVE/IFR
         ngqrcKzBOccOGI6TeyMgPKKv8CDb1Hb0PgpuK4a+rHHIk3J+4eLSicaqgXsgQVBczDD1
         5vRFtcJAI7FtVcQZNii8LpKAsoqu8AbRiAKrtHMiIOWVSPwT3L4/7G18zS9Q+HZiPKXl
         GLOE9o/s90iIBI+dzmizabt2lHBhEY/bixpRew7CEAVvRYPQczbDGRznOULlb9AgZfEo
         6QZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dM070hPEEtxbIZT7CSkwr/k8XskxS5oXkmZBTXIPuKA=;
        b=kUpoU6A5vomEqahAjXGkleW0CHbDt/PdP4gdIuIMln8oDuec4IIqWnyQTq3Gp/LZA5
         6YC6Ux4KD11J1FVzXw2Vu0gUz+uJuUFta0YEVR9iHASOvXZii3n8yn/oxgbIxL2JJZqF
         lG/6A5tHISo/jNQseuR1oUx3tvbGZFwgTm/eWLkI3AzleOlUH8lrX6qDTzcqigER3UIm
         EVpkeTlj9aw8LL/FMfmSVA5Dyxo0yuzKWrQElzgOt8djhVRJRUsHTwF/UKytxR4qUDof
         stDZLd/vowS16RP7YzLpXuuGhxRAg2GfhA3gt0PUj0hfH6c7/IOx4lha0047ArhCrEt1
         kJZw==
X-Gm-Message-State: APf1xPANXN5sJHfkaDkYe5ZkoIL+0fpY1oTa3tqZEBoad59GsCzznREQ
        Sua2f2iCf+cZvlVc8OmAnbGT7g==
X-Google-Smtp-Source: AH8x224K4fYv1DTjTLPZZ1uN+pmdRksGhvw9hPxPUCHta23aBqtzdrXCMzMGrbCpSRv8p19TebPRrg==
X-Received: by 10.99.66.65 with SMTP id p62mr12480098pga.378.1519780104238;
        Tue, 27 Feb 2018 17:08:24 -0800 (PST)
Received: from google.com ([2620:0:100e:422:ff43:9291:7eda:b712])
        by smtp.gmail.com with ESMTPSA id 12sm466907pfr.147.2018.02.27.17.08.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 27 Feb 2018 17:08:23 -0800 (PST)
Date:   Tue, 27 Feb 2018 17:08:21 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     git@vger.kernel.org, sbeller@google.com, peff@peff.net,
        gitster@pobox.com, stolee@gmail.com, git@jeffhostetler.com,
        pclouds@gmail.com
Subject: Re: [PATCH v3 29/35] pkt-line: add packet_buf_write_len function
Message-ID: <20180228010821.GB45342@google.com>
References: <20180125235838.138135-1-bmwill@google.com>
 <20180207011312.189834-1-bmwill@google.com>
 <20180207011312.189834-30-bmwill@google.com>
 <20180227231145.GF174036@aiede.svl.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180227231145.GF174036@aiede.svl.corp.google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 02/27, Jonathan Nieder wrote:
> Brandon Williams wrote:
> 
> > Add the 'packet_buf_write_len()' function which allows for writing an
> > arbitrary length buffer into a 'struct strbuf' and formatting it in
> > packet-line format.
> 
> Makes sense.
> 
> [...]
> > --- a/pkt-line.h
> > +++ b/pkt-line.h
> > @@ -26,6 +26,7 @@ void packet_buf_flush(struct strbuf *buf);
> >  void packet_buf_delim(struct strbuf *buf);
> >  void packet_write(int fd_out, const char *buf, size_t size);
> >  void packet_buf_write(struct strbuf *buf, const char *fmt, ...) __attribute__((format (printf, 2, 3)));
> > +void packet_buf_write_len(struct strbuf *buf, const char *data, size_t len);
> 
> I wonder if we should rename packet_buf_write to something like
> packet_buf_writef.  Right now there's a kind of confusing collection of
> functions without much symmetry.
> 
> Alternatively, the _buf_ ones could become strbuf_* functions:
> 
> 	strbuf_add_packet(&buf, data, len);
> 	strbuf_addf_packet(&buf, fmt, ...);
> 
> That would make it clearer that these append to buf.
> 
> I'm just thinking out loud.  For this series, the API you have here
> looks fine, even if it is a bit inconsistent.  (In other words, even
> if you agree with me, this would probably be best addressed as a patch
> on top.)

Yeah I agree that an api change is needed, but yeah it can be done on
top of this series.

> 
> [...]
> > --- a/pkt-line.c
> > +++ b/pkt-line.c
> > @@ -215,6 +215,22 @@ void packet_buf_write(struct strbuf *buf, const char *fmt, ...)
> >  	va_end(args);
> >  }
> >  
> > +void packet_buf_write_len(struct strbuf *buf, const char *data, size_t len)
> > +{
> > +	size_t orig_len, n;
> > +
> > +	orig_len = buf->len;
> > +	strbuf_addstr(buf, "0000");
> > +	strbuf_add(buf, data, len);
> > +	n = buf->len - orig_len;
> > +
> > +	if (n > LARGE_PACKET_MAX)
> > +		die("protocol error: impossibly long line");
> 
> Could the error message describe the long line (e.g.
> 
> 		...impossibly long line %.*s...", 256, data);
> 

I was reusing the error msg as it appears in another part of this file.

> )?
> 
> > +
> > +	set_packet_header(&buf->buf[orig_len], n);
> > +	packet_trace(buf->buf + orig_len + 4, n - 4, 1);
> 
> Could do, more simply:
> 
> 	packet_trace(data, len, 1);

I'll change this.

> 
> Thanks,
> Jonathan

-- 
Brandon Williams
