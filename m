Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5D8FF20A17
	for <e@80x24.org>; Tue, 24 Jan 2017 01:33:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751969AbdAXBdp (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Jan 2017 20:33:45 -0500
Received: from mail-pf0-f176.google.com ([209.85.192.176]:34112 "EHLO
        mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751778AbdAXBdo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Jan 2017 20:33:44 -0500
Received: by mail-pf0-f176.google.com with SMTP id e4so45442108pfg.1
        for <git@vger.kernel.org>; Mon, 23 Jan 2017 17:33:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=IJYo/fqsy8mt54UJSznWXp9jiOFW38QOg7QKu9TD2EQ=;
        b=rxxdGVMxfddp4pzXRnQMAWgglXimm2+7fPGUdFr7QU1cPfs4w33egpY1btjTAa9vcQ
         Zzwfu20NWb4dIrQxGcvltogUrOrg4M/SB8Ophm8mKUve4PSQeGX+A/RgZh2+FqzFUDEt
         5tVtZAGKQ9VEnycL6Y2EMKvCraDnWXSe1G4n0QTF2qOJZGK71n1plvd2zvFAFkSnp5X7
         6g+wR3KE9LY8CXm+s4K9PiT2AMZPT/FRWaa7ffcYYVNFSApzJx6yJnyHtcVz939ee3r4
         46HXuFyddGnrwC38N8HUF7kx7Woxbc00HaTKu0kHRRvPnjnpOA993+/dPpyhvd6wbv9Y
         ixlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=IJYo/fqsy8mt54UJSznWXp9jiOFW38QOg7QKu9TD2EQ=;
        b=EJegH0FCbnHVKUnGnbzpRmX9G/wV6kufVlDAteq/pRpLbD8wIAL8/Oc62CTDW5OLT1
         B8dGq8eSE+8JaexOfPynjj6028G6CWQ1t2GUFmgE2vv2M8V4mg7uWfwOrHBziPd74j/r
         2pG1CApitUGkYP48Z8hhM+OJu6hm0ubma0XlxPBVkTnop7DGGadUYfyacY3W4YJx70Z/
         wFfYT+pUThhmBhWI5vFfx/+RmV4TNpf2l/p13pGUO/s6z+D4u22hWanbj77pdSiibQyu
         eeWG+Vq1eToLMcghzBDIWGyDeWWec3fC7RuQthfR+nr4bL7Cydc4fXwECb6D37COmIWf
         uzSQ==
X-Gm-Message-State: AIkVDXIAQOQCv6UH9fh9lVPc6uTnuKUoUYGrUcqZZEQZVxHttrRYZZTSvR9n6qMXwkV1Szcl
X-Received: by 10.98.194.153 with SMTP id w25mr35631970pfk.181.1485221623578;
        Mon, 23 Jan 2017 17:33:43 -0800 (PST)
Received: from google.com ([2620:0:1000:5b10:19da:d768:d0e6:f301])
        by smtp.gmail.com with ESMTPSA id v4sm902012pfb.36.2017.01.23.17.33.41
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 23 Jan 2017 17:33:42 -0800 (PST)
Date:   Mon, 23 Jan 2017 17:33:41 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/12] reducing resource usage of for_each_alternate_ref
Message-ID: <20170124013341.GA185930@google.com>
References: <20170124003729.j4ygjcgypdq7hceg@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170124003729.j4ygjcgypdq7hceg@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 01/23, Jeff King wrote:
> 
> A brief overview of the patches:
> 
>   [01/12]: for_each_alternate_ref: handle failure from real_pathdup()
>   [02/12]: for_each_alternate_ref: stop trimming trailing slashes
>   [03/12]: for_each_alternate_ref: use strbuf for path allocation
> 
>     Bugfixes and cleanups (the first one is actually a recent-ish
>     regression).

Which is most likely my fault, Sorry! :)

I think the old behavior was to die and not return NULL.

-- 
Brandon Williams
