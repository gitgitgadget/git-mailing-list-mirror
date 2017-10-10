Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1A2A120372
	for <e@80x24.org>; Tue, 10 Oct 2017 02:19:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755862AbdJJCTW (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Oct 2017 22:19:22 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:35029 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755458AbdJJCTV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Oct 2017 22:19:21 -0400
Received: by mail-pf0-f194.google.com with SMTP id i23so31839706pfi.2
        for <git@vger.kernel.org>; Mon, 09 Oct 2017 19:19:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xq0Oa2jqt1x+BHP30VLTWB/BST6Zn0Ge+poQyVl6as8=;
        b=mHbswg4N8Gumv5hcKZcMTW17ye7DchsbCJNgjraLSOT6RsJnmYCVcSXkoTxuIz3C1m
         VguuPIu7Krd1zZB9UXRrsG/K0+8twqYhcko0jXbl16LgojVxqbFs7xlKxo2Q1BW/f7AP
         VZCGOvzanaj7yo7k5fgkgnf0j8kftdMIoJ/oyXh63xaWTJIX0lvZKM0CXIPKhOh4uLVw
         +50iio7jmk7pMqDP5ApS2nQBv8mgS/74uzhnrZLzqVRqf2mTz5hZ5TsC+esnp1gjCi/U
         B9L8+FoofxmxU3LqmsDKnu4Aw2ACXZgALcyeP7DZwDVPtqPQ2t/APEw4mofzHCXprwU9
         C7zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xq0Oa2jqt1x+BHP30VLTWB/BST6Zn0Ge+poQyVl6as8=;
        b=JogokqefMiyAFnX79p763LApP85kahal5ZtCM5qmkzHRI3LNQUwNrXnnOkKk0H/7B0
         PV347G5MyP9ukqYeMe+ozYXVJHapyx7yWQ+G0XOVSKe62gtqqdETUmP3fHMnIhzKIaai
         +ZyEswd3SKQ90IjQRDJRk4LuPdYJLggH0WKxsmwRRSh4yX1GLL60jz+rH78Cuu/+SI0W
         jVlu7VHQ2YyGxwJs/JhugMwJNpDSlfDoZKTR0ppmnryA1C+SLiNsIPuylodFKqe794y4
         jVMN+EYFSRJAL07krXssj9ikGwrkIBr3pIr7P53mf8fEKKCSETm2NAErqYLCi7MidRpS
         WCDA==
X-Gm-Message-State: AMCzsaXOt0PtmJPVvrPn6pX/GbP2qRbWVpe0C8xGyUhT4/hQ22ZtjVuZ
        1Gfplte9aIOxdvAti5/PyGI=
X-Google-Smtp-Source: AOwi7QAXQhYq9v0lOl0cvlybZPX0OV8E9yzrxwI0bfHGKDONzUnXzQA0jOiWl8fjF6+MRBsdwsWgDA==
X-Received: by 10.101.76.139 with SMTP id m11mr10972537pgt.103.1507601960660;
        Mon, 09 Oct 2017 19:19:20 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:c9c7:66a0:181:dab2])
        by smtp.gmail.com with ESMTPSA id x4sm16333756pfb.101.2017.10.09.19.19.19
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 09 Oct 2017 19:19:20 -0700 (PDT)
Date:   Mon, 9 Oct 2017 19:19:18 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Brandon Williams <bmwill@google.com>,
        Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH v2 12/24] pack-bitmap: convert
 traverse_bitmap_commit_list to object_id
Message-ID: <20171010021918.GT19555@aiede.mtv.corp.google.com>
References: <20171009011132.675341-1-sandals@crustytoothpaste.net>
 <20171009011132.675341-13-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171009011132.675341-13-sandals@crustytoothpaste.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

brian m. carlson wrote:

> Convert traverse_bitmap_commit_list and the callbacks it takes to use a
> pointer to struct object_id.
>
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---
>  builtin/pack-objects.c | 8 ++++----
>  builtin/rev-list.c     | 4 ++--
>  pack-bitmap.c          | 8 ++++----
>  pack-bitmap.h          | 2 +-
>  4 files changed, 11 insertions(+), 11 deletions(-)

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
