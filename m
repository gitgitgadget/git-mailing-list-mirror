Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D08F120281
	for <e@80x24.org>; Wed, 20 Sep 2017 21:34:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751653AbdITVeV (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Sep 2017 17:34:21 -0400
Received: from mail-pf0-f171.google.com ([209.85.192.171]:50285 "EHLO
        mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751387AbdITVeU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Sep 2017 17:34:20 -0400
Received: by mail-pf0-f171.google.com with SMTP id m63so2167381pfk.7
        for <git@vger.kernel.org>; Wed, 20 Sep 2017 14:34:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=S6bBtMCsKRulmxpcjVBNJHXWiKSz4tm7EuPBQxV47a8=;
        b=mmXsJ6uApftKxheqnUEt4Rf/H6hy8CjYxEyYNY9e59TPE8V0i9yJ3zgm0NHvZ5U2KM
         JuWtkE0q/3hZh0oPpHbMIjue1FQ/Nu0MAyicumgqSqXGRq7c1TfpgV9NXTkb7OSIURBH
         fevitYDryjGGbYMIrGsaKWswHlx8D3IWBIYSW3rgKipJ2SeQewcfYBIGZaFBWhY+BNtd
         Q1adlrAc9eX9EV7jmyKS1duZw4yy+J3Nz2Yaya3IW76ZVKmyzorHNpZ1tN7h/UWsr+46
         UWnRCNQMAQeCMaFVbvIL1nHE50XjNCrc9/R/jA/dDNynGQFf4x9o4pe8QLrjPuoQ+55G
         LxHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=S6bBtMCsKRulmxpcjVBNJHXWiKSz4tm7EuPBQxV47a8=;
        b=I7o1F58o8COa7hxQ+H9NPq8j6lr+o9eI6umutAlitTw0lB2QaC9EdiF59d3O/OiY0I
         YqulkUeNKuIKVisaM9SOq2pN4Og8MIi/5a8VfKcoJKlhI1+GZz69DV5SzOf29GoKxO7Y
         blrCR1vdcMHu+RzQYMciz23RAxdfFwADMBlcd/TaU8yU0xObJ/ekx+HpkgU9opUKV2BT
         mO1a887r3P5qpTJ5T7/QoDiBh40lLDy4rGHsJwjMgIXHFu284HPKmu+tYKYtcXw2JMVV
         SkXUjUmrgMHOK8b8RpfGPK0bA29cgXl1Xp/5FhD+DBu8HHxX6pMFhzPH7zFg5/tu8e4L
         JHeQ==
X-Gm-Message-State: AHPjjUhAXkdUDCMI/hnMyoeOz6RCF+ld5hP8NlNYld7pD21X3kU9s110
        HWitT9VJKu01Oc5MHHY2pM0=
X-Google-Smtp-Source: AOwi7QD5QXMjmWakSTq9PHvC7QLm9L8bqbL9FqjGh05XfX4WkcU6LitErSuDx888kBIe9joGx462Vg==
X-Received: by 10.84.224.13 with SMTP id r13mr3404054plj.137.1505943260068;
        Wed, 20 Sep 2017 14:34:20 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:da9:ac38:cdcf:de91])
        by smtp.gmail.com with ESMTPSA id r66sm9766437pfl.15.2017.09.20.14.34.19
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 20 Sep 2017 14:34:19 -0700 (PDT)
Date:   Wed, 20 Sep 2017 14:34:17 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Martin =?iso-8859-1?Q?=C5gren?= <martin.agren@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] commit: fix memory leak in `reduce_heads()`
Message-ID: <20170920213417.GG27425@aiede.mtv.corp.google.com>
References: <1505936846-2195-3-git-send-email-martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1505936846-2195-3-git-send-email-martin.agren@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Martin Ågren wrote:

> We don't free the temporary scratch space we use with
> `remove_redundant()`. Free it similar to how we do it in
> `get_merge_bases_many_0()`.
>
> Signed-off-by: Martin Ågren <martin.agren@gmail.com>
> ---
>  commit.c | 1 +
>  1 file changed, 1 insertion(+)

Good catch.  Thanks.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
