Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3D08920372
	for <e@80x24.org>; Mon,  9 Oct 2017 22:38:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755005AbdJIWia (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Oct 2017 18:38:30 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:33315 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754246AbdJIWi3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Oct 2017 18:38:29 -0400
Received: by mail-pf0-f195.google.com with SMTP id m28so30758923pfi.0
        for <git@vger.kernel.org>; Mon, 09 Oct 2017 15:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VMXT01cApnCEJMILVcn6bwFozwEunnqLfr2PzPJgLC0=;
        b=BiOiAqt6EF42ryMCtTQu0LyFuqNwM7O/pVeFKzg2Wn95275ocVdDCgkH20+auvQZSY
         Yr9tzvdBOhtKbeaNvf6XMGMEeVsRSFaPTTBW5OYiEqMDTluc1Kr2l7iFGQol2wzAvFdD
         SF52ubXT1H/F4VKcQ+O33Bgk+Yd90SAh3Es2bwvqhUet4wjmmkwk88if9a6xusQ2l6YV
         nWWSm+Oa//j/bfvd2MMGus1wzjTH9kxoQuwO7d7S4xMswsfOpaCcXUcdFtpa+BB43iIU
         qsHAkzMhf2nS2QUB2uEpjsgEaEBnmUwaFJR2bbt4wBXac3GRopkrMeD97CbltkHRj2ls
         Snkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VMXT01cApnCEJMILVcn6bwFozwEunnqLfr2PzPJgLC0=;
        b=p3R0Jty66T9964XjOr0MEauRN9AP4CdQxdWCORfebBmClsrdvHynQXofHTLz8C1vUN
         x59F5cuppmjec/KC4xeFn77msKSsnFF0XCcvNDBZghEihvLlIUiOjrRMRPK5Zkuqh/5R
         kAs91VoKjkUWh6548fE89l4p0au649ZtZQr57Vbmf0oGIPeR2pqCLXWyadaxba3JXQuh
         1Oawpg28sc5kY6mS8lUpxh9TbU+9yCyanMkchj7y8VKCyEn+hlBgZSccnCs/fhfbWWPs
         8R8PV04pzJZ7e69it+4d0r3aAS7KiekaelAXHHdAFvcgiy+cgifnYf1T66FXsaU0eXZe
         VbeQ==
X-Gm-Message-State: AMCzsaWv7Xts3hSF5M1L8duu7/5Mxg+PoF0q+pMg8YxYnEXKNXCEK7hJ
        yeBQQ9MdcFnOCM0a3gGu5Gov8B8J
X-Google-Smtp-Source: AOwi7QDwriY1gSGFigSnL6jBJDIzVUhd3KWaqWzRK7IYMZ7LtqLYuqC46Hg2nkoUWrAO4PwZM7bwDg==
X-Received: by 10.101.78.7 with SMTP id r7mr10585681pgt.64.1507588708604;
        Mon, 09 Oct 2017 15:38:28 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:14f3:fccd:46cc:9e97])
        by smtp.gmail.com with ESMTPSA id r64sm14539220pfg.25.2017.10.09.15.38.27
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 09 Oct 2017 15:38:28 -0700 (PDT)
Date:   Mon, 9 Oct 2017 15:38:26 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Brandon Williams <bmwill@google.com>,
        Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH v2 02/24] refs/files-backend: convert struct ref_to_prune
 to object_id
Message-ID: <20171009223826.GF19555@aiede.mtv.corp.google.com>
References: <20171009011132.675341-1-sandals@crustytoothpaste.net>
 <20171009011132.675341-3-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171009011132.675341-3-sandals@crustytoothpaste.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

brian m. carlson wrote:

> Change the member of this struct to be a struct object_id.
>
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---
>  refs/files-backend.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Yes, this is an obvious improvement to the clarity of the code.
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
