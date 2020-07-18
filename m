Return-Path: <SRS0=BQqG=A5=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08CB9C433DF
	for <git@archiver.kernel.org>; Sat, 18 Jul 2020 03:52:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D19EE2073E
	for <git@archiver.kernel.org>; Sat, 18 Jul 2020 03:52:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp-br.20150623.gappssmtp.com header.i=@usp-br.20150623.gappssmtp.com header.b="orjazPLq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727086AbgGRDwL (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Jul 2020 23:52:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726923AbgGRDwL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Jul 2020 23:52:11 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13632C0619D2
        for <git@vger.kernel.org>; Fri, 17 Jul 2020 20:52:11 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id m9so5157761qvx.5
        for <git@vger.kernel.org>; Fri, 17 Jul 2020 20:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=61qiDV7Bqi6st5SNOAzz7859gtvNmUNnMXLs43hYLhg=;
        b=orjazPLq9CMHruqGFXvXnM37WF4PExRh5oSfs4yoltzHoMYkZSBYZBh8yJcIb77mXQ
         xt6NGwGoZuDZatPzFuKFe9cUBtBtq4NXp7ha6u9wg0g4fkTYBz1dy9zahewlRF/SaTAv
         5VqL9c0y0DCpoe21JW1xQa1b+toOLe6yYDdfx6EqeXOUB1TI5zyso9RqRZdOILRLUoGn
         RlApkDkoqzgUKjL8+17f8npAjWS/zG1uywTAic2VSAoIGDNpVuhn580wWT3+hL7ZhOz+
         qH5rJb7GQ5R4rc9pmzYdj18yyEX7YlTm9kH5T6Klb1NUiI1pak1g/GOME4hNvmBgfSuP
         XB9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=61qiDV7Bqi6st5SNOAzz7859gtvNmUNnMXLs43hYLhg=;
        b=kz08hmwADC2xorG5jhVz44NSWmwQ9TJzm0RzD5vAZm0LltXMmM+Vic7e7OLi+mcA0E
         4iqDnqWTyoVjrWtFr3Ojq1sCsA8HSQRjvIPX1ZVMIFPpBmU/4j5hBb1+7DsLIwbfcDi1
         JfJ6WhNiiM1NSFmfz9qHgn5pM0UxjnYQzTGhijd5KZU0LhTfg2bLkxxx+WmRTu7kG/4u
         HJaHyIi7bHZWvrxgjr8ZeyJXfTqybF06Mb1wRfQzoaPnHXq+iHSopOzdlqkdUzrvVckB
         Dz9qc8ZaqX9lmbw/24tzdbL5UhlPCXQlI61Wb0mZI/sKyQk30jQIBtXNY1tikYp7oAf/
         anyg==
X-Gm-Message-State: AOAM530IMkRTFjswVCYoiNlvczMY0ZqrqSqUTEgAbbPk5Zxvp4HOibNo
        mrTwfU46FWvXhZoYc5Bm1SU1gg==
X-Google-Smtp-Source: ABdhPJzYDom635v+gwNu2dKtks/cYK4znAHoflsWndd/x5gnjcUUzsiJTnUPu3LWuZf9ncQ2j+IQ+g==
X-Received: by 2002:ad4:42a5:: with SMTP id e5mr12038646qvr.67.1595044330018;
        Fri, 17 Jul 2020 20:52:10 -0700 (PDT)
Received: from mango.spo.virtua.com.br ([2804:14c:81:9a16::3])
        by smtp.gmail.com with ESMTPSA id c27sm11327061qkl.125.2020.07.17.20.52.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2020 20:52:08 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     johannes.schindelin@gmx.de
Cc:     christian.couder@gmail.com, frekui@gmail.com, git@vger.kernel.org,
        j6t@kdbg.org, jonathantanmy@google.com, matheus.bernardino@usp.br,
        peff@peff.net, sandals@crustytoothpaste.net
Subject: Re: [PATCH v2 2/2] hex: make hash_to_hex_algop() and friends thread-safe
Date:   Sat, 18 Jul 2020 00:52:01 -0300
Message-Id: <20200718035201.42233-1-matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <nycvar.QRO.7.76.6.2007161214270.54@tvgsbejvaqbjf.bet>
References: <nycvar.QRO.7.76.6.2007161214270.54@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 16, 2020 at 9:56 AM Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
>
> Now, I am _far_ from knowing what I'm doing with Coccinelle, but I think
> this here semantic patch should get you going:
>
> -- snipsnap --
> @@
> expression E;
> @@
>   {
> ++   char hex[GIT_MAX_HEXSZ + 1];
>      ...
> -    oid_to_hex(E)
> +    oid_to_hex_r(hex, E)
>      ...
>   }
>
> @@
> expression E1, E2;
> @@
>   {
> ++   char hex1[GIT_MAX_HEXSZ + 1], hex2[GIT_MAX_HEXSZ + 1];
>      ...
> -    oid_to_hex(E1)
> +    oid_to_hex_r(hex1, E1)
>      ...
> -    oid_to_hex(E2)
> +    oid_to_hex_r(hex2, E2)
>      ...
>   }

Thanks for this nice example! This already worked very well in some of
my tests :)

However, with my _very_ limited notion of Coccinelle, I didn't
understand why some code snippets didn't match the above rules. For
example, the structure below:

func(...)
{
	if (cond)
		func2("%s", oid_to_hex(a));
}

I thought it could be because the `if` statement is missing the curly
brackets (and it does work if I add the brackets), but to my surprise,
adding another oid_to_hex() call in an `else` case also made the code
match the rule:

func(...)
{
	if (cond)
		func2("%s", oid_to_hex(a));
	else
		func2("%s", oid_to_hex(a));
}

The following snippet also correctly matches, but spatch introduces only
one `hex` variable:

	if (cond)
		func2("%s, %s", oid_to_hex(a), oid_to_hex(b));
	else
		func2("%s", oid_to_hex(a));

We will probably want our semantic rules to handle an arbitrary number
of `oid_to_hex()` calls in each function, but in scenarios like the
above one, we only really need 2 hex buffers despite having 3 calls...
That might be a little tricky, I guess.

Another thing that might be tricky in this conversion is checking for
name conflicts with the added `hex` variable (but maybe Coccinelle
already has a facilitator mechanism for such cases? IDK).
