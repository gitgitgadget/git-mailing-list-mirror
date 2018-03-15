Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-0.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 19A181F404
	for <e@80x24.org>; Thu, 15 Mar 2018 17:28:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751854AbeCOR2v (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Mar 2018 13:28:51 -0400
Received: from mail-pf0-f172.google.com ([209.85.192.172]:36854 "EHLO
        mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751748AbeCOR2u (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Mar 2018 13:28:50 -0400
Received: by mail-pf0-f172.google.com with SMTP id 68so3088837pfx.3
        for <git@vger.kernel.org>; Thu, 15 Mar 2018 10:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=C3pYhrtsEyVW4dfyog2fkBvBIxA9UMKOSePlnCxliok=;
        b=uxPE6vUSlSdMcoiZjkU9TqR9Hv3VB/Iff3tjmGXK2T6zAxWkZmub0BuJdy8xCzZbpr
         TzbGSlIvVjOatoDIKz70ahdxaDv84LSHKDDzMfxdK+zz2q9pDlsrIdJ/A4jsxJOaP2i/
         qN1PiII8WgTDTCe2OdCaOCMQCLHNg9rWot3FElksIOcwiyKRDJxpAVa+U5e8c/HVVBJK
         dG+y54WZYUAP+TkX53O0eGkc+KZj1pJR5JVxvnTChMtvCGFsxS75BTLmZkuRRG9kVxqp
         vHXqxPbUIzvh2qRNxx3KB+Vbc1rvH5MlD8GJJCqpWjGETC2Ax6/JiyVnpWV81VV2Itz9
         XPNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=C3pYhrtsEyVW4dfyog2fkBvBIxA9UMKOSePlnCxliok=;
        b=LcOp1PfRIl4ivCC65TFYt505ACeUQtWAnjuZi6NUZJ0TIet//+EdJFqdU/70IGqkm+
         WHOhhlK3joeEMvQLzd2Io8S/TwLCdM0t/cD2OqPbv02v91TZ30E0t5itu9jPPp9sfOde
         pUgthOSZVgXHzM8PkdTfGNn/S3RKT20SJNW8H0YLx/u0JGyVaHXoSz8oiAqCafe2sYVi
         Te6iHswNqIvb4Gxo9IhxrrK5ZcYz0/I6aRWiNTRs/fPahaIsW5IdNqMkjWpJjzi95uMS
         9+P1a/CbnUDU9Sf2/kZiRxJaEQFtUrJTOVQ6cQcvFKb3lgznM+ACYx9myKeqfHQPMwQO
         WLLw==
X-Gm-Message-State: AElRT7EZY+H8S28IuqehFnI59l+QZ5c1bPfnT/ioYV1LpbzUXPWYv2sV
        noM0Nd5CKw/GqObvyjIMfZp0NYnhOy8=
X-Google-Smtp-Source: AG47ELt8fFDQgb0BNXG1ybznxpx0ltOKstDJvAA8/IydTMmUi5khXnm2jHbRWXe32x3A7AYev2WNVw==
X-Received: by 10.98.157.199 with SMTP id a68mr5303509pfk.237.1521134929980;
        Thu, 15 Mar 2018 10:28:49 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:ff43:9291:7eda:b712])
        by smtp.gmail.com with ESMTPSA id z6sm11048139pfe.9.2018.03.15.10.28.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 15 Mar 2018 10:28:49 -0700 (PDT)
Date:   Thu, 15 Mar 2018 10:28:48 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, git@jeffhostetler.com, jrnieder@gmail.com,
        pclouds@gmail.com, peff@peff.net, sbeller@google.com,
        stolee@gmail.com, jonathantanmy@google.com
Subject: Re: [PATCH v5 01/35] pkt-line: introduce packet_read_with_status
Message-ID: <20180315172848.GB174336@google.com>
References: <20180314183213.223440-1-bmwill@google.com>
 <20180314183213.223440-2-bmwill@google.com>
 <xmqq1sgmz6j0.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq1sgmz6j0.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/14, Junio C Hamano wrote:
> Brandon Williams <bmwill@google.com> writes:
> 
> > +/*
> > + * Read a packetized line into a buffer like the 'packet_read()' function but
> > + * returns an 'enum packet_read_status' which indicates the status of the read.
> > + * The number of bytes read will be assigined to *pktlen if the status of the
> > + * read was 'PACKET_READ_NORMAL'.
> > + */
> > +enum packet_read_status {
> > +	PACKET_READ_EOF,
> > +	PACKET_READ_NORMAL,
> > +	PACKET_READ_FLUSH,
> > +};
> 
> EOF was -1 and NORMAL was 0 in the previous round; do we need to
> read through all the invocations of functions that return this type
> and make sure there is no "while (such_a_function())" that used to see
> if we read NORMAL that is left un-updated?
> 
> I just have gone thru all the hits from
> 
>  $ git grep -n -e packet_erad_with_status -e packet_reader_read -e packet_reader_peek
> 
> There are a few
> 
> 	switch (packet_reader_peek())
> 
> which by definition we do not have to worry about.  Then majority of
> what could be problematic are of the form:
> 
> 	while (packet_reader_read() == PACKET_READ_NORMAL)
> 
> and they were this way even in the previous version, so it seems
> quite alright.
> 
> Will replace.  Thanks.

A reviewer in the previous round found that it was unnecessary to have
EOF start at -1, so per their comments I got rid of that.

-- 
Brandon Williams
