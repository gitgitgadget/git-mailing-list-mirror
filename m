Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B908B1F404
	for <e@80x24.org>; Sat, 25 Aug 2018 10:58:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbeHYOgz (ORCPT <rfc822;e@80x24.org>);
        Sat, 25 Aug 2018 10:36:55 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33511 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726286AbeHYOgz (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Aug 2018 10:36:55 -0400
Received: by mail-wr1-f67.google.com with SMTP id v90-v6so9492093wrc.0
        for <git@vger.kernel.org>; Sat, 25 Aug 2018 03:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=n1iLZXhQtWLVoUzMSVlhHMPSaiseqBUpKd25vWBW5rQ=;
        b=nNSRkPSALmQvEYBprKwX8Mw62tH9WtWCcWjPKXdixY2/IWTjDEPSPqUpTf8UKZAxRn
         dT4/QrHzHjlDTLh1DXmIhynQX4erR/JPKXYO1X3KCd7E9yiViUw/0c9ZEfqiorAci/Da
         sX+4/azSkPZK3aSYa/LUlNAmKvyQZommwqrQ1t5XXc8EztBUy8kZrMVQL7Zdh52AVexl
         czzayCQKN8yNfZyNSe56KakejcIQ05W+bgbtFryi8BF+odacXgCt8FDFByEklvYwiuwG
         FXuHH4yzFBd+BCVCFXnOH/2N4Rza2/mI9wfvK02AGeh490vpqOwQg59OSJSoCz4mSKeA
         jBVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=n1iLZXhQtWLVoUzMSVlhHMPSaiseqBUpKd25vWBW5rQ=;
        b=EmxISabexWlxZfKV4nChXm+/lRn3bQTkxsA630w9SLultC4HKP0A9MGJ/MEaAB/UHj
         eMKIU5whsoyvgP3cjPUFKNMIacYPTi8c13Yutwuiv0Usqm9aTjkTOTd5F3c4t9FtPsut
         i+nM1/BLFa+ZeIYsLlaByrDVJzsvaUGMqOyi4vwdJ7vKmt1V9R7YxdHodI+lW6IPgZ4j
         sfSoPQbykWiTlj++rzhcSyz2qmGVrWHMNi4JkTppbzo8AZ+jGrFi7XuQHvT5E5Cc+cCK
         2hwXeTSNlp7dE31LkdEEUgzzdJqQA7LS/ObhZpC+P+eSw22nZN6ZxQhubWnnWxJJ9rJw
         qPZA==
X-Gm-Message-State: APzg51CtY0BFuDM2iYxybBprgAUCUOq24+w9NpVJMe1z2BYts7p33jSl
        suHUHql7ru501srRet8nbKk=
X-Google-Smtp-Source: ANB0VdZ4ei/w7N668z3oTDDfa5ipxgx6iCTX7NncIodIpeXPZ5947qBQzZQXumlLOoxnx/loEpfm3Q==
X-Received: by 2002:adf:ad47:: with SMTP id p65-v6mr3684005wrc.222.1535194697147;
        Sat, 25 Aug 2018 03:58:17 -0700 (PDT)
Received: from [192.168.178.82] (ppp-93-104-98-64.dynamic.mnet-online.de. [93.104.98.64])
        by smtp.gmail.com with ESMTPSA id r13-v6sm3137945wmf.35.2018.08.25.03.58.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 25 Aug 2018 03:58:16 -0700 (PDT)
Subject: Re: [PATCH 2/9] introduce hasheq() and oideq()
To:     Jeff King <peff@peff.net>, git@vger.kernel.org
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Derrick Stolee <stolee@gmail.com>,
        Jacob Keller <jacob.keller@gmail.com>
References: <20180825080031.GA32139@sigill.intra.peff.net>
 <20180825080543.GB737@sigill.intra.peff.net>
From:   Andrei Rybak <rybak.a.v@gmail.com>
Message-ID: <d8cc6d0e-d713-2387-6bde-072f208a87c6@gmail.com>
Date:   Sat, 25 Aug 2018 12:58:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180825080543.GB737@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 25/08/18 10:05, Jeff King wrote:
> The main comparison functions we provide for comparing
> object ids are hashcmp() and oidcmp(). These are more
> flexible than a strict equality check, since they also
> express ordering. That makes them them useful for sorting

s/them them/them/

> We can solve that by introducing a hasheq() function (and
> matching oideq() wrapper), which callers can use to make

s/make/& it/

> clear that they only care about equality. For now, the
> implementation will literally be "!hashcmp()", but it frees
> us up later to introduce code optimized specifically for the
> equality check.
> 
> Signed-off-by: Jeff King <peff@peff.net>

