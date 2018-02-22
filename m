Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 747E61F404
	for <e@80x24.org>; Thu, 22 Feb 2018 18:58:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751340AbeBVS65 (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Feb 2018 13:58:57 -0500
Received: from mail-pf0-f182.google.com ([209.85.192.182]:33560 "EHLO
        mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751158AbeBVS6z (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Feb 2018 13:58:55 -0500
Received: by mail-pf0-f182.google.com with SMTP id q13so2452715pff.0
        for <git@vger.kernel.org>; Thu, 22 Feb 2018 10:58:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FhhS+MBF8loeuPMc2P51g/FXR1Gv8ozlSO2j3lUEjzw=;
        b=IYjMimfgbPMWSVYYf1QxQdb2lVITMwoSHi+JkDmkHg/jfl6q4tGJHJcTdXswv5T3q4
         Y3eyxhZu7hnRJboteQE7zxuSYpnwyPaGz/urYWBEjAeBdR9P+b43yyQQwqQDRdZTW/PK
         3oir4L3mcuQ2atIvoPkxhXHd2GgnfhcZh74E4Fr0yio3mzJcJTUaoan56Sl6zBFuGqqz
         H7snDTLhiHAtB8jP1ROg+fZNpMi6Jhcyg5JXH7bN4QtJYNK3XPcgg0s5Y2lL08yJ6cdL
         oEgsHTjobMBiQOAM9Q0fNTFAlNC+pM9CrG0xY94ZTg0Pll12jnw/WcPGyqaeR2EIizOK
         CsfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FhhS+MBF8loeuPMc2P51g/FXR1Gv8ozlSO2j3lUEjzw=;
        b=p4q35gprryE1cXvU7duBzGsA18TNsHxfWNI2q+8Kq9fpcGOc74wDg34k0MO2Lge7+t
         LtyPhv6+y3Knpwr9X9CbuGn2DDhNXfFZKBeMkWvwdi/VxMkmnKtkqTr1KMu48TPdfJQg
         yp5oOCwrn0+4dK4eaW4VEzAMKoUrqWv2z26YxygYm8Nc9Qm/EAUc9nLELoGiAvBhZtQh
         ol7CF94LPnK6vtSBiXVpT22mOGkpkKKI4gv401wrVhJwwd9NlcZqTqIk+Bq6Jz2rqe2G
         IpRgoDFxe9jOs7ujHTt3Af1v0ODOl9+pIJTHrj8AAMWzs9mQ6mHeflyzymbGzULNRMQ3
         hOxQ==
X-Gm-Message-State: APf1xPBcBhKrgAURM9edAldC/g82DI49lmZVbj+5OCk/YrHkPcFGPt8H
        i+PcPiy1FeqH9/Lnb7xNF371mK2biu0=
X-Google-Smtp-Source: AH8x226D75Ry28YM3mQMEFrHIeRcX5QxNsa4qUozgeneNZcd0mIXTpzUFWfi8U1Vs7TD4yEmWpU2pw==
X-Received: by 10.98.15.15 with SMTP id x15mr7956478pfi.116.1519325935089;
        Thu, 22 Feb 2018 10:58:55 -0800 (PST)
Received: from google.com ([2620:0:100e:422:ff43:9291:7eda:b712])
        by smtp.gmail.com with ESMTPSA id a3sm1183435pfh.120.2018.02.22.10.58.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 22 Feb 2018 10:58:54 -0800 (PST)
Date:   Thu, 22 Feb 2018 10:58:53 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, sbeller@google.com, peff@peff.net,
        gitster@pobox.com, jrnieder@gmail.com, stolee@gmail.com,
        git@jeffhostetler.com, pclouds@gmail.com
Subject: Re: [PATCH v3 32/35] http: allow providing extra headers for http
 requests
Message-ID: <20180222185853.GJ185096@google.com>
References: <20180125235838.138135-1-bmwill@google.com>
 <20180207011312.189834-1-bmwill@google.com>
 <20180207011312.189834-33-bmwill@google.com>
 <20180221160905.5772106219ded5f16919de46@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180221160905.5772106219ded5f16919de46@google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 02/21, Jonathan Tan wrote:
> On Tue,  6 Feb 2018 17:13:09 -0800
> Brandon Williams <bmwill@google.com> wrote:
> 
> > @@ -172,6 +172,8 @@ struct http_get_options {
> >  	 * for details.
> >  	 */
> >  	struct strbuf *base_url;
> > +
> > +	struct string_list *extra_headers;
> 
> Document this? For example:
> 
>   If not NULL, additional HTTP headers to be sent with the request. The
>   strings in the list must not be freed until after the request.

I'll add that.

-- 
Brandon Williams
