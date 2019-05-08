Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D9F4D1F45F
	for <e@80x24.org>; Wed,  8 May 2019 14:07:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727849AbfEHOHE (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 May 2019 10:07:04 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:37762 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727620AbfEHOHD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 May 2019 10:07:03 -0400
Received: by mail-qt1-f193.google.com with SMTP id o7so1220496qtp.4
        for <git@vger.kernel.org>; Wed, 08 May 2019 07:07:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=cNGD9pnjgdb+1bjohd5LSWRFCWVRCneFh5cLu/VKypM=;
        b=thbIMXEgYlbI5B2+Cx7oEHqDwje0qUcTpXMcaBZMXV4vRduwLkDpMxiH6jYet6jnu1
         uqVx+0SLGzmeX3NYV5nLi3U9/SrNFhpk5x3W2DYRQ7O08BHsIJXSTBlZmphNrDoeqeq2
         RjI8H4l7FUMHfZ0LJfblgq1R5caCJ/fTtrnTVCwU9g6mqxb9um4guRciGqf8Q9EtO4mb
         X13UFPcYKOdNeOPvJUhFcGPDm8HjypHzPyzCCDMja4aULP0Rw3x9jpjjN8PwWYQYqH5Q
         7SAwPh5EcmRf0WWbl9CZN2N0lX9S7P6FH2INFZ9i9+yWYx0+rLjQJNrLcd0cyxKLgYfh
         c5hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cNGD9pnjgdb+1bjohd5LSWRFCWVRCneFh5cLu/VKypM=;
        b=RW2hrLRGRhmbPFB2yR//MZQA0O3CAXVS7UIIcXb4Orkzfr3bT3TFOe0a/UcNDHu/sx
         rjnfOJokS7BN+6A+ekK3LkWLRCFfrz0Su1JeJPOu1G9jNIFThHMoAkk7xfxRHDJ3xt38
         RHG0bRCu/iAM0d7bby+gzWyQsqLUFBusnaq8BAAh7z7c7wiF3LMCE/O/I5acS/o7g7HP
         Aj4qX1tO02CZCK61Q2sFocr8W1lc0AYI1PbHS1zr69O2LdPeWzyqCm/+QFb3sRN6hW13
         piQoqtquDzkvAIgMoQ3gz02jrqmWdRLO/SvOMt4ffkRZNQn5EoZJwW2LeirzEdZXPotp
         KXAQ==
X-Gm-Message-State: APjAAAWAjgp5ifP7+POAVRZmp8A9IKjrenjs5Z29d7obra/yzTPkVfYR
        TBndNU84aSNBCoLyQEx097ghcQqtMtQ=
X-Google-Smtp-Source: APXvYqxyeCNWYYTxzfKG+yeqZaPSF/rlQkpgpA1ARFCwjlrx7v/1P93403K/dQGXC6l2kQm15zeFDw==
X-Received: by 2002:aed:21b8:: with SMTP id l53mr2953923qtc.36.1557324422573;
        Wed, 08 May 2019 07:07:02 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:243f:92bd:dfb0:fd97? ([2001:4898:8010:2:d73:92bd:dfb0:fd97])
        by smtp.gmail.com with ESMTPSA id v190sm7087266qkc.9.2019.05.08.07.07.01
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 May 2019 07:07:01 -0700 (PDT)
Subject: Re: [PATCH 01/19] revision.h: avoid bit fields in struct rev_info
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, git@vger.kernel.org
References: <20190508111249.15262-1-pclouds@gmail.com>
 <20190508111249.15262-2-pclouds@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <0509589b-7a92-6c05-e404-65a9b2bf5666@gmail.com>
Date:   Wed, 8 May 2019 10:07:01 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:67.0) Gecko/20100101
 Thunderbird/67.0
MIME-Version: 1.0
In-Reply-To: <20190508111249.15262-2-pclouds@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5/8/2019 7:12 AM, Nguyễn Thái Ngọc Duy wrote:
> Bitfield addresses cannot be passed around in a pointer. This makes it
> hard to use parse-options to set/unset them. Turn this struct to
> normal integers. This of course increases the size of this struct
> multiple times, but since we only have a handful of rev_info variables
> around, memory consumption is not at all a concern.

I think you are right that this memory trade-off shouldn't be a problem.

What worries me instead is that we are using an "internal" data structure
for option parsing. Would it make more sense to create a struct for use
in the parse_opts method and a method that translates those options into
the bitfield in struct rev_info?

Thanks,
-Stolee
