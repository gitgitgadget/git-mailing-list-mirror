Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0BBF11F404
	for <e@80x24.org>; Thu, 22 Feb 2018 00:38:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751626AbeBVAiD (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Feb 2018 19:38:03 -0500
Received: from mail-pf0-f182.google.com ([209.85.192.182]:41513 "EHLO
        mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751623AbeBVAiB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Feb 2018 19:38:01 -0500
Received: by mail-pf0-f182.google.com with SMTP id a17so1393392pff.8
        for <git@vger.kernel.org>; Wed, 21 Feb 2018 16:38:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=M0aYztenTEvBdTfV5vhypeQZRSI5aVHv5A21KBOyRFA=;
        b=TVL/qNL018kuBUaenUxb4QFIy3m7gagMkD0r7QFTeYVwsMHmswOQTmjAnhGk9K1gnd
         sXvfCKPEJxEZZMN7MpoCQJWvuLCBxnt/14KDGVopDe7DNWgrq7bpu7bitHnPV2KhPLSZ
         sntWZ0n60h6ATjrnDt8BURgMSx6+Bc/EeJsqQ5ia4DgEbyy+Yv9ClxXw0C5mREbgrkT5
         HZjbi1MwSPKSeOK5OXRzzOZDdtZy3N6CPE//k8hkaq4O2mxTPOh8mziQnrHczFbG3V3x
         2SZSTgCJsAS2QIwhPB0XkKS7kptNCLyeGOxF7mv7oZUkSqF7mlGpTi2hMabFZZyN/qta
         WxBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=M0aYztenTEvBdTfV5vhypeQZRSI5aVHv5A21KBOyRFA=;
        b=g+UpfOuY7i/r2FhRV0ybEMYBgf7/62+zJx9345KCkGBpkF9v/u0Pyk6Vr8jvYIszjl
         uLQ2hWAzSXOrsJAXVXr/r7vGJTYj7AGxUOGutyVoEGFfVOTUn8/lYWqOQPIGVCFkapI/
         MKFrQyJsE/CUz/CzYyeQDoLbkQXh1RkXYuLRE2f84pzNLgqKv8TT2+NZSnZRKqhhqc3e
         twG7MBVgXl3Zf1PfwZNsgNZAoFwynf6/upjcrosl6FVrhGMywT1kTFzlWWU9OFB/oXKA
         Le6RRUAYthXJGUxCvb9IM23wjxkfly1QTxCaLjap12g3mEYI3Ia/I8s67cOtt8FGico2
         IIQw==
X-Gm-Message-State: APf1xPD6c7ZgZAfd5Y9ttBMogbOeOo4uuS0gK8BiOw5WZdPAhhBdyLQx
        xqmq4jkbQbeB+XFxdJBVqzIQWQ==
X-Google-Smtp-Source: AH8x224qozmutsnN1r3na7luF/kTqCgbNNtHR5XIvBfYl9XjAaQo9S8SabgVUQaLnp81Tnl342NyMw==
X-Received: by 10.101.70.203 with SMTP id n11mr3979977pgr.377.1519259880372;
        Wed, 21 Feb 2018 16:38:00 -0800 (PST)
Received: from google.com ([2620:0:100e:422:ff43:9291:7eda:b712])
        by smtp.gmail.com with ESMTPSA id y124sm15675258pgb.29.2018.02.21.16.37.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 21 Feb 2018 16:37:59 -0800 (PST)
Date:   Wed, 21 Feb 2018 16:37:58 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, jonathantanmy@google.com,
        pclouds@gmail.com, sunshine@sunshineco.com
Subject: Re: [PATCH 02/27] object-store: migrate alternates struct and
 functions from cache.h
Message-ID: <20180222003758.GB127348@google.com>
References: <20180216174626.24677-1-sbeller@google.com>
 <20180221015430.96054-1-sbeller@google.com>
 <20180221015430.96054-3-sbeller@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180221015430.96054-3-sbeller@google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 02/20, Stefan Beller wrote:
> Migrate the struct alternate_object_database and all its related
> functions to the object store as these functions are easier found in
> that header. The migration is just a verbatim copy, no need to
> include the object store header at any C file, because cache.h includes
> repository.h which in turn includes the object-store.h

Nice.  Always love seeing cache.h get smaller


-- 
Brandon Williams
