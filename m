Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BE2A720437
	for <e@80x24.org>; Fri, 13 Oct 2017 22:18:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751624AbdJMWSu (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Oct 2017 18:18:50 -0400
Received: from mail-pg0-f43.google.com ([74.125.83.43]:44449 "EHLO
        mail-pg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751339AbdJMWSt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Oct 2017 18:18:49 -0400
Received: by mail-pg0-f43.google.com with SMTP id j3so2229061pga.1
        for <git@vger.kernel.org>; Fri, 13 Oct 2017 15:18:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ncNsqcFfyAN/8BLuZmMV19+HKQF/RQ+XivJsGo9hAg0=;
        b=IFWtMQoxYvIZtOR9Dvde2E/W7qzRuaR+I/756ykq8aNI5EbWLjV2HPCMTQ+Wju0vSF
         xKoafB/EPXEHTn4HE1BQxYd2Ntco0IRcsA/zd0aIQZKcE3FobsJbx6z6UxpiEHAE6qfC
         Vg7rVrynx9X25tvLiBc4bANMYB5ELPXpqvYdF7fp06wUxYocRjceHt4g+F7zBlhewqNa
         wUO9S3oIRtPaQ7czLRxmfs4tMmzua6vfbgtNzLhsbzu9BixjV619mbOu1P2Ft+bznlg3
         w+2EO4KaJXDuRPhgHKByblJ+eBpxldXCYUDHo8e2a4FiyLRjgs5vizq3qdjOrbNcBxMc
         NEOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ncNsqcFfyAN/8BLuZmMV19+HKQF/RQ+XivJsGo9hAg0=;
        b=fZTbNuzZhMduyoU5jerlQNm4BW+128gCewy1Szn4PZeQbJ2Kg0RZvJryrzWWbz38UO
         a5P/9SxOEH3rds5RCB+thqQc1H2RLvuR3AzzCP3m7knX5++ASOT2R/+9UTtQaYyRCzu9
         ljv0ffFy7+sbQqC91S87axMhItvgoyzM71cMPGaLTIYpCtMfRPcaWzK+rvdw3Q1/8S2C
         wuBrjA1P15P4xH5jGaFmq0iaVMQR13MO2SCU4xyen4+KKLJLb50XlQdbZi9EDcW+7Z2a
         ZAC1kPBYXXClRCgBRNeoXdFEs1FbaCLkMaQM/7yBw8Fkh/LpWTIKnnk8Scj8CoJqvUIi
         6RbQ==
X-Gm-Message-State: AMCzsaVr3sgaUM1HayoTOM6SxFo39DmZeUJo76q26nxmMbx3YZizSvX7
        bXOGU3zv1Nr46cW4ymAy19gMhA==
X-Google-Smtp-Source: AOwi7QBoUH7DB8ciUqYI8DG2y8lBY6AeAYXtQ5f6yXlah9cHoVhPqgfNPtRXtx1Vr7x4u7UvuRfkUg==
X-Received: by 10.99.95.70 with SMTP id t67mr645431pgb.409.1507933128845;
        Fri, 13 Oct 2017 15:18:48 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:b031:5884:4d4f:f3a9])
        by smtp.gmail.com with ESMTPSA id f11sm3360345pgp.48.2017.10.13.15.18.47
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 13 Oct 2017 15:18:48 -0700 (PDT)
Date:   Fri, 13 Oct 2017 15:18:46 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, bturner@atlassian.com, git@jeffhostetler.com,
        gitster@pobox.com, jrnieder@gmail.com, peff@peff.net,
        sbeller@google.com
Subject: Re: [PATCH v3 05/10] upload-pack, receive-pack: introduce protocol
 version 1
Message-ID: <20171013221846.GB101395@google.com>
References: <20170926235627.79606-1-bmwill@google.com>
 <20171003201507.3589-1-bmwill@google.com>
 <20171003201507.3589-6-bmwill@google.com>
 <20171010112818.bd75e8dbe4ae39c90e6512da@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171010112818.bd75e8dbe4ae39c90e6512da@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/10, Jonathan Tan wrote:
> On Tue,  3 Oct 2017 13:15:02 -0700
> Brandon Williams <bmwill@google.com> wrote:
> 
> > +	switch (determine_protocol_version_server()) {
> > +	case protocol_v1:
> > +		if (advertise_refs || !stateless_rpc)
> > +			packet_write_fmt(1, "version 1\n");
> > +		/*
> > +		 * v1 is just the original protocol with a version string,
> > +		 * so just fall through after writing the version string.
> > +		 */
> 
> Peff sent out at least one patch [1] that reformats fallthrough comments
> to be understood by GCC. It's probably worth doing here too.
> 
> In this case, I would do the 2-comment system that Peff suggested:
> 
> 	/*
> 	 * v1 is just the original protocol with a version string,
> 	 * so just fall through after writing the version string.
> 	 */
> 	if (advertise_refs || !stateless_rpc)
> 		packet_write_fmt(1, "version 1\n");
> 	/* fallthrough */
> 
> (I put the first comment before the code, so it doesn't look so weird.)

Sounds good.

> 
> [1] https://public-inbox.org/git/20170921062541.ew67gyvrmb2ot4sf@sigill.intra.peff.net/
> 
> > +	case protocol_v0:
> > +		break;
> > +	default:

I'm also going to change this to from default to
'protocol_unknown_version' that way we get a compiler error instead of a
run-time BUG when introducing a new protocol version number.

> > +		BUG("unknown protocol version");
> > +	}

-- 
Brandon Williams
