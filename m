Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B44D01FD99
	for <e@80x24.org>; Mon, 29 Aug 2016 13:50:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933677AbcH2Nt7 (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Aug 2016 09:49:59 -0400
Received: from mail-wm0-f48.google.com ([74.125.82.48]:37247 "EHLO
        mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933345AbcH2Nt5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Aug 2016 09:49:57 -0400
Received: by mail-wm0-f48.google.com with SMTP id i5so93123186wmg.0
        for <git@vger.kernel.org>; Mon, 29 Aug 2016 06:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=xPkEohFt/nK1FYu1cIj3GSo8tzD+2n6YHe8ApH0fDTM=;
        b=bc6JZaGjny75SfdXQxzvhlvcdUQX3PzJ3ZUrwNpuVV7Xeb3vIv9r4wdrQMUz11TL7d
         KyFoe3ETmORUcTpVH1+R4cjG01zunWYOaiTZ9SFm3M7Gn+cF1z2XzqWyU38Qud8RFKJX
         EJ02fjyvYnLEMOpbrXqimpVwwwFtuBNblkcGVBEcGOqn7M66yXHH0UZZlSvQsXi7c9P9
         FlCjkCUxT3HvaoMrOuD4T+NnxNCXcyjd59NowuKNK9EH0bbcrKldG8NS+IazyeIYemr6
         h7iIRLrMxWjh1zexMVsP7EfJynJbGmVHaqI8g76Jf5l5tGZjIHgqEptb6InKTHlw/bef
         tUzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=xPkEohFt/nK1FYu1cIj3GSo8tzD+2n6YHe8ApH0fDTM=;
        b=MAycqsR6y1C/+qoPIj1wGKfB22Cc/0bKkO9hlO3WklcYwRNwSnuBEpiw1xgaI1SY4f
         ciAcllaxazio2WaJxxR2+duFWq0oGqPLWEg8XtwB2mI/BTgp3RPhAwT8d6RUh6WuTSdp
         aX0fzHydM7AQGx4Nls8hM7Iq4N0g/v/B69r5p6IQRm4dY/6IMY76u80vDKzLVOF959Un
         nL5NM0+IGDI7Aj2wSrTIB9s/RN/wK38QOGbvIBy7CoVNEaud8sZ/fnK96EAp9I5NefBf
         Cssa2PO7wiiLXpj7zVBNTgeckO5cXEItTGWAcgYi5YhhIXRrfCWUtBgOILb4VabYk7Ea
         27IQ==
X-Gm-Message-State: AE9vXwMftDXtEN9nx5YVplyBRC/SGBFOObJKVhbJGA12OkpZp1GMT4r+ge55xco6lgLyBA==
X-Received: by 10.194.187.134 with SMTP id fs6mr15573822wjc.3.1472478501110;
        Mon, 29 Aug 2016 06:48:21 -0700 (PDT)
Received: from [192.168.1.26] (abpp123.neoplus.adsl.tpnet.pl. [83.8.57.123])
        by smtp.googlemail.com with ESMTPSA id z18sm13637038wmz.6.2016.08.29.06.48.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Aug 2016 06:48:20 -0700 (PDT)
Subject: Re: [PATCH 01/20] cache: convert struct cache_entry to use struct
 object_id
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
References: <20160828232757.373278-1-sandals@crustytoothpaste.net>
 <20160828232757.373278-2-sandals@crustytoothpaste.net>
Cc:     Paul Tan <pyokagan@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Jeff King <peff@peff.net>
From:   =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <577f6266-42ec-6c7b-8b21-1e4997f2b816@gmail.com>
Date:   Mon, 29 Aug 2016 15:48:10 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <20160828232757.373278-2-sandals@crustytoothpaste.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

W dniu 29.08.2016 o 01:27, brian m. carlson pisze:

> Convert struct cache_entry to use struct object_id by applying the
> following semantic patch and the object_id transforms from contrib:
> 
> @@
> struct cache_entry E1;
> @@
> - E1.sha1
> + E1.oid.hash
> 
> @@
> struct cache_entry *E1;
> @@
> - E1->sha1
> + E1->oid.hash

I wonder if writing this patch series (or rather the following one)
would be helped by using one of semantic patch tools, such as
Coccinelle[1], spdiff[2], or Undebt[3]...

[1]: http://coccinelle.lip6.fr/
[2]: http://www.diku.dk/~jespera/doc.html
[3]: http://engineeringblog.yelp.com/2016/08/undebt-how-we-refactored-3-million-lines-of-code.html

Best,
-- 
Jakub Narębski

