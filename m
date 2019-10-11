Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 590EC1F4C0
	for <e@80x24.org>; Fri, 11 Oct 2019 16:38:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728489AbfJKQiq (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 Oct 2019 12:38:46 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:46883 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727149AbfJKQiq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Oct 2019 12:38:46 -0400
Received: by mail-pl1-f195.google.com with SMTP id q24so4694039plr.13
        for <git@vger.kernel.org>; Fri, 11 Oct 2019 09:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=P6VM0dklpsQvAaBFm5IpdhGT4TSLt+4Vu9u4Cztiu1I=;
        b=MZES5+O8FAcVhs2/k4zzlrQXZ14VNgHaF0xDxBfrPcDpBojRND2DkM38z9PGPM7MXZ
         u2az6G/u0y1zsLq2uKN34e1bWQrC6BcEAN9AB6yAj53ZQ2dptGX5kxXTeRsShH52n+xC
         ffRy4QsudRRthgkE5zb/k1IrLq+jlPt7DoYCw7fGmXW6NKNVg1UrvfS9ipfP8KWAbxOu
         jOqNW7SAWEI0rc9jWTT9DRniX+vO9m4OA3z5lVAPdxa7E17Okp5KEJwawEzporHyJ2AR
         5SnNyNYiECUsrnW8qZUfq/4+8NbgJyN6tGPgryY2o/aiqX5I6RG2SquDLeA79V1FQ+3j
         yIjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=P6VM0dklpsQvAaBFm5IpdhGT4TSLt+4Vu9u4Cztiu1I=;
        b=Sa+6tz7s4qrnS06QTcQBN+LuR/g3n8mqXisPveLOMUnN6LAoX6Iu2Auj8f0n/JcFg2
         yd6b/xl7zoHt2smkCOOP8s9hU1+0cacl5UprlrljdDxXSCOqeFhfEsLYM6AA8kA4wUbC
         7QAoUje2kTxUMwdY2D9PUKtLdlMqmxIhZYbMPuD3JhptJkevMe9O1m+sR19ZcE4jdJxd
         BtqGb2qr85/9mpKQeihQxrq2hMzSKcPrMfllxWHezjmDlUIu9PbBYhORtwbG9yFBiSnC
         AuOWdRpERs61KyTSwxMRsYJMTZdFBwf3Hp9Ry8hIXYLl9STzLPD6bG4YtJMqsLSWf1Fu
         +VIg==
X-Gm-Message-State: APjAAAXcMXVc/PjkCLebMrl1dN4gubzLhpbYxL/gRvuagVDgT2Dn8BtU
        sk0R/0qnOtWlESnMReUDB+U=
X-Google-Smtp-Source: APXvYqzuISN70gaCv0G14zehfd78+RIHGf3QCnUzXZeeTHKLfwRjBcs89PX763U+/lp1IDPDzZPCYw==
X-Received: by 2002:a17:902:b58f:: with SMTP id a15mr15785130pls.149.1570811923689;
        Fri, 11 Oct 2019 09:38:43 -0700 (PDT)
Received: from BE-SB2-MIFELIX.europe.corp.microsoft.com (50-47-110-187.evrt.wa.frontiernet.net. [50.47.110.187])
        by smtp.gmail.com with ESMTPSA id 4sm7952868pja.29.2019.10.11.09.38.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Oct 2019 09:38:42 -0700 (PDT)
Subject: Re: [PATCH v2 1/1] fsmonitor: don't fill bitmap with entries to be
 removed
To:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        William Baker via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, stolee@gmail.com, Johannes.Schindelin@gmx.de,
        jeffhost@microsoft.com, Junio C Hamano <gitster@pobox.com>,
        William Baker <William.Baker@microsoft.com>
References: <pull.372.git.gitgitgadget@gmail.com>
 <pull.372.v2.git.gitgitgadget@gmail.com>
 <08741d986c2b51828f115ab50f178d62e9982978.1570654810.git.gitgitgadget@gmail.com>
 <20191010110732.GJ29845@szeder.dev> <20191010112204.GK29845@szeder.dev>
From:   William Baker <williamtbakeremail@gmail.com>
Message-ID: <9c012ff1-182b-d71b-cd50-9c476f26748c@gmail.com>
Date:   Fri, 11 Oct 2019 09:38:41 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20191010112204.GK29845@szeder.dev>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/10/19 4:22 AM, SZEDER Gábor wrote:
>>> +# This test covers staging/unstaging files that appear at the end of the index.
>>> +# Test files with names beginning with 'z' are used under the assumption that
>>> +# earlier tests do not add/leave index entries that sort below them. 
> 
> I just read through Junio's comments on the first version of this
> patch, in particular his remarks about this comment.
> 
> If this new test case below were run in a dedicated repository, then
> this comment wouldn't be necessary, and all my comments below about
> that not-really-initial commit would be moot, too.
> 

Thanks for this suggestion!  I will submit a v3 version of the patch
with an update to the test script.

- William

