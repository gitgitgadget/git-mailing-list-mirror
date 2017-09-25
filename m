Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9D022202A5
	for <e@80x24.org>; Mon, 25 Sep 2017 23:55:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966486AbdIYXzN (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Sep 2017 19:55:13 -0400
Received: from mail-pg0-f50.google.com ([74.125.83.50]:54480 "EHLO
        mail-pg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965398AbdIYXzN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Sep 2017 19:55:13 -0400
Received: by mail-pg0-f50.google.com with SMTP id c137so4920551pga.11
        for <git@vger.kernel.org>; Mon, 25 Sep 2017 16:55:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=e1ZxtXUdw0U+ekblJlOQcmqRMJSG+fwaSWzZ1MauHHo=;
        b=tPjtA0Bpx+SH4JWHjm2Z42KoUHz27vdOg+m1+pklDlFMCLWVhlbPpAShgKC9KvO9PN
         rxQ4g9A3nFXfKCqFxUPHpsUxOW1Czvdy7N+MgHCkhLEXU1Y2Hf8fmj7Kz93aMdaMexs2
         /ogJ/HeVmBazEt/oMH+G9l11S2J9uMomJRHXzCm+FHiryKJyh03WO+sG0UogCy/oytkN
         U9Ac49jp4U1wWq+YNxmoMH+crNpxUZ4t0SOUMoURMnbxwoXhJtjQnfxNFHEVgREb+0kv
         qzLXSqPHyW/CW6CXY7OIe5FFzRCfLFBK4kpiXBScKAluwdI4/9AYJny1bI7eOuLdhDps
         6JMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=e1ZxtXUdw0U+ekblJlOQcmqRMJSG+fwaSWzZ1MauHHo=;
        b=tt4uG+y6MEwKdU3R/uLNu/GqqmHDn06y9KJODf53TK49NYO8GT1Iqh42iPV1/9IyPD
         gNfXwa7OLkD9ultyPTbhzjsdOSHxSVWKQRbqa+1h/3xiWAoCcebwKVNH/LupOG/MWjom
         ezWgXdB9NAirpNUqp8m482iSacX8KR7aXKE/X2McDIV6CnP4Et63yWiL1LPoQPmq4D9T
         dL7/M316IVna6B6zc0JI9dMXFToGU/vCwK89oGlIPmanU5ZelbgF82gHBCrQnuWBdTMT
         YHbJNPhDjycuhie4rDro2i5Trx4aibPmpFf1fvuCymi3kTPACaBqnapAj9wYVzvPzGl5
         nlCw==
X-Gm-Message-State: AHPjjUiiNDO4sAvGF2mzZ7EbkrhosJ5vLt7BOF7yyw2SFdyY6nCIRyTi
        QLEHd1jG+mt73LZOHqPQSW4=
X-Google-Smtp-Source: AOwi7QB+h3JN6H0cUfnjaoeuNNXoSptJi1wNF4zuCWqR9mvSRD4uCjt0kKAxCgflztCvdAFu5Ix+4Q==
X-Received: by 10.98.198.202 with SMTP id x71mr8969095pfk.349.1506383712433;
        Mon, 25 Sep 2017 16:55:12 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:b5cd:5017:828c:d0cb])
        by smtp.gmail.com with ESMTPSA id d18sm12147577pfk.11.2017.09.25.16.55.11
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 25 Sep 2017 16:55:11 -0700 (PDT)
Date:   Mon, 25 Sep 2017 16:55:10 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 3/7] read_in_full: reset errno before reading
Message-ID: <20170925235510.GL27425@aiede.mtv.corp.google.com>
References: <20170925202646.agsnpmar3dzocdcr@sigill.intra.peff.net>
 <20170925202916.4tqo4gttrsoy7kai@sigill.intra.peff.net>
 <20170925220914.GB27425@aiede.mtv.corp.google.com>
 <20170925232313.hhtqpxuzpzbnbdop@sigill.intra.peff.net>
 <20170925233316.GI27425@aiede.mtv.corp.google.com>
 <20170925233732.4lqavl56qwpfjuxy@sigill.intra.peff.net>
 <20170925234541.l6qcislhfwtnxf5m@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170925234541.l6qcislhfwtnxf5m@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King wrote:

>   [EOVERFLOW]
>     The file is a regular file, nbyte is greater than 0, the starting
>     position is before the end-of-file, and the starting position is
>     greater than or equal to the offset maximum established in the open
>     file description associated with fildes.
>
> That's not _exactly_ what's going on here, but it's pretty close. And is
> what you would get if you implemented read_exactly() in terms of
> something like pread().

All that really matters is the strerror() that the user would see.

For EOVERFLOW, that is

	Value too large to be stored in data type

For EILSEQ, it is

	Illegal byte sequence

Neither is perfect, but the latter seems like a better fit for the kind
of file format errors we're describing here.  Of course, it's even
better if we fix the callers and don't try to wedge this into errno.

If you are okay with the too-long/too-short confusion in EOVERFLOW, then
there is EMSGSIZE:

	Message too long

Hope that helps,
Jonathan
