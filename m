Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5524F1F406
	for <e@80x24.org>; Tue,  9 Jan 2018 19:28:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935460AbeAIT2F (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Jan 2018 14:28:05 -0500
Received: from mail-pg0-f54.google.com ([74.125.83.54]:40266 "EHLO
        mail-pg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935440AbeAIT2E (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Jan 2018 14:28:04 -0500
Received: by mail-pg0-f54.google.com with SMTP id q12so8651939pgt.7
        for <git@vger.kernel.org>; Tue, 09 Jan 2018 11:28:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=onQtOx9txmP2tJkbnfmpz6BPAD6a4YL2e+J9JRYUZ24=;
        b=rqCoonvQiWDL048cPfOD/B5Uh0AP5Z8VkqPu3h6HaFGu1j8br800e3FF4XhmSyxX20
         T7Li9r7K2sQ+HgtRtcSd7Y1giKyxIjeYu/ASqihIoql0FToDt/syKOnRiyKk8/YA9Squ
         tyvD8ld5UV+n+fgKwQviRzDrYBUjUEBJP5SYQjbCwcjd9XMOb6cRefZVMsgNGpLOGZzj
         D1f+6F5uOgvxz99re/EC91AHOALcwX6sRAsAehTw78XUvi0bb1u0O+hgNhn1uwWsyByU
         oyGLPLkNmGlRNosTQp8gCAWr853omalj6dotoGoVRtjVTSvFxRPCK8YVxV7Ky6gxiiXf
         P49w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=onQtOx9txmP2tJkbnfmpz6BPAD6a4YL2e+J9JRYUZ24=;
        b=K+iqG9gY1maDUgsvMa8i/n/NrG1POXr7n+u4HLZveZAzzqP9t/oKezosFS44YzYtcZ
         f8ghzhteWeVcH5BM1+mqb9V0wniA8GgtdfjKRjsbvOAQiMc58ced9ejzaimC5tSqa18l
         ZCmTaJAh1InySVMCWC5NgM8h3MwCt/70MWCwpZnOqYYWdoI2smOX+YEPqH8f9GN9X85D
         GB/Rwm7aVsidDi6g+R8EWHFLxiXuHOmzQQfFv2u7+19zgJquH9tsbRxjQUonoZE351eh
         QwJGrp2P6mxv5Py+R8n5raVQv+w9cwZ+qop1fnQ0ODPISfbd7jaftxtV/Kua4xTeVrSb
         VcOw==
X-Gm-Message-State: AKGB3mJVZAzW8kO24hxgnwW6txqqWJ0KmX1sRwooueg2SQhMQHBGY4lD
        LR4Z3QtnWSKPBkXyC0g7cNhOhw==
X-Google-Smtp-Source: ACJfBosbS4I0sy7lPsmhU8Xew/zFNymmuSFf+9Q3ihcbwlDciRZInvpPwgUtr+t7qfwMZbG+tuVXng==
X-Received: by 10.101.67.1 with SMTP id j1mr13245880pgq.204.1515526083545;
        Tue, 09 Jan 2018 11:28:03 -0800 (PST)
Received: from google.com ([2620:0:100e:422:5de7:5b51:7854:d1a5])
        by smtp.gmail.com with ESMTPSA id j14sm35749002pfj.93.2018.01.09.11.28.02
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 09 Jan 2018 11:28:02 -0800 (PST)
Date:   Tue, 9 Jan 2018 11:28:01 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, sbeller@google.com, gitster@pobox.com,
        peff@peff.net, philipoakley@iee.org, stolee@gmail.com,
        jrnieder@gmail.com
Subject: Re: [PATCH 01/26] pkt-line: introduce packet_read_with_status
Message-ID: <20180109192801.GD151395@google.com>
References: <20180103001828.205012-1-bmwill@google.com>
 <20180103001828.205012-2-bmwill@google.com>
 <20180109100411.b63dd903e2037372e4a28a91@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180109100411.b63dd903e2037372e4a28a91@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 01/09, Jonathan Tan wrote:
> On Tue,  2 Jan 2018 16:18:03 -0800
> Brandon Williams <bmwill@google.com> wrote:
> 
> > -int packet_read(int fd, char **src_buf, size_t *src_len,
> > -		char *buffer, unsigned size, int options)
> > +enum packet_read_status packet_read_with_status(int fd, char **src_buffer, size_t *src_len,
> > +						char *buffer, unsigned size, int *pktlen,
> > +						int options)
> >  {
> > -	int len, ret;
> > +	int len;
> >  	char linelen[4];
> >  
> > -	ret = get_packet_data(fd, src_buf, src_len, linelen, 4, options);
> > -	if (ret < 0)
> > -		return ret;
> > +	if (get_packet_data(fd, src_buffer, src_len, linelen, 4, options) < 0)
> > +		return PACKET_READ_EOF;
> > +
> >  	len = packet_length(linelen);
> >  	if (len < 0)
> >  		die("protocol error: bad line length character: %.4s", linelen);
> > -	if (!len) {
> > +
> > +	if (len == 0) {
> 
> This change (replacing "!len" with "len == 0") is unnecessary, I think.
> 
> >  		packet_trace("0000", 4, 0);
> > -		return 0;
> > +		return PACKET_READ_FLUSH;
> > +	} else if (len >= 1 && len <= 3) {
> > +		die("protocol error: bad line length character: %.4s", linelen);
> >  	}
> 
> This seems to be more of a "bad line length" than a "bad line length
> character".

I'll make these changes, though I do think this needs to stay as a "bad
line length character" as the len could be neg which is an indication of
parsing the linelen character failed.

> 
> Also, some of the checks are redundant. Above, it is probably better to
> delete "len >= 1", and optionally write "len < 4" instead of "len <= 3"
> (to emphasize that the subtraction of 4 below does not result in a
> negative value).
> 
> > +
> >  	len -= 4;
> > -	if (len >= size)
> > +	if ((len < 0) || ((unsigned)len >= size))
> >  		die("protocol error: bad line length %d", len);
> 
> The "len < 0" check is redundant.
> 
> > -	ret = get_packet_data(fd, src_buf, src_len, buffer, len, options);
> > -	if (ret < 0)
> > -		return ret;
> > +
> > +	if (get_packet_data(fd, src_buffer, src_len, buffer, len, options) < 0)
> > +		return PACKET_READ_EOF;
> >  
> >  	if ((options & PACKET_READ_CHOMP_NEWLINE) &&
> >  	    len && buffer[len-1] == '\n')

-- 
Brandon Williams
