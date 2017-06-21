Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C270620D0C
	for <e@80x24.org>; Wed, 21 Jun 2017 21:13:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751946AbdFUVNm (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Jun 2017 17:13:42 -0400
Received: from mail-pf0-f169.google.com ([209.85.192.169]:33663 "EHLO
        mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751108AbdFUVNl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Jun 2017 17:13:41 -0400
Received: by mail-pf0-f169.google.com with SMTP id e7so10756503pfk.0
        for <git@vger.kernel.org>; Wed, 21 Jun 2017 14:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=UVDWc1Agblkn9PuxMtTO76B9lf9Evw8gqHGTnERqsAM=;
        b=cJSuZDhVZnqIhnX29OLxtI4PyeU0CqNxcoJA+2adJAl05l1D0zcRzOzd9t9bReW9iE
         p82Ixk/r6v7UBthHf66LiypbeQ5TL6ovEsetiVYRwz0te3rzy7Vlt2WIFoWVXiDclUee
         yx3JMutuocYbEQsIupeT2u/GZ2j08bzWIJ6arryA5Tg+XzIRzm+5laezczioqNBeMZmA
         uGeIMcW1CpY2sr9kHOxp52sfj9OyKU3CHPNIr3M2DV1LzGpspbFyi9RgBf0kj+GxcTV5
         0y7zfDazDu7+a4TSdnpRrXKoQscUjiNrK89v9DNFQFgOvUde9QlBSeo0Q8oqg2XZcVCX
         67Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=UVDWc1Agblkn9PuxMtTO76B9lf9Evw8gqHGTnERqsAM=;
        b=Xj89M0qZf+3Yp/ROPb5U6NsqhVwYhL31D+/a9xdgSyVdxrFr0xi+lQOXIVSfzas5zx
         glc87Fi7D/9UGRWtqQRsKJp3uNhL5oaLdzsEsS4zPsxqDrWh61CkCTbOSdDnqzYMuyI+
         cNV03NL1/Au4cLikJDGtD7Brj+igsSWzWIc3NsjkUjmzjxn5PwnyRM1pM+XYahLSx/Of
         GNL1NKat9SpjBlv9arrkCm9Mg9Xyb2qkPctUwfhnlNowMSibEEU9fOokA32yizUC2zFD
         +fSqKDDNJLVpRJzdgjIQVMLE/Qmqq69+18CNuCfr87xsYWkxU6+w6kI2i92HX/uH9qYv
         9Uug==
X-Gm-Message-State: AKS2vOyg+7Ly/xBqYyslzGNTaO+cf7dOj99aamcX3m9aiMAoTZFMOCf7
        YoEg62DOVLE39w==
X-Received: by 10.84.224.134 with SMTP id s6mr11147283plj.263.1498079620391;
        Wed, 21 Jun 2017 14:13:40 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:b0bd:d7d3:4f2e:5016])
        by smtp.gmail.com with ESMTPSA id g27sm34409248pfd.80.2017.06.21.14.13.39
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 21 Jun 2017 14:13:39 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Brandon Williams <bmwill@google.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.org>
Subject: Re: [PATCH 04/26] diff.c: introduce emit_diff_symbol
References: <CAGZ79kaqjQYmkt77kk5m=fdBfbZAvwd0YhhT7=O5b-FkQmDfHg@mail.gmail.com>
        <20170620024816.20021-1-sbeller@google.com>
        <20170620024816.20021-5-sbeller@google.com>
        <xmqq7f05p1z7.fsf@gitster.mtv.corp.google.com>
        <CAGZ79kYUpJxX-wBU=ALPgJwVaA8h_iJRtAu3T7p4J7qmy=U4dg@mail.gmail.com>
Date:   Wed, 21 Jun 2017 14:13:38 -0700
In-Reply-To: <CAGZ79kYUpJxX-wBU=ALPgJwVaA8h_iJRtAu3T7p4J7qmy=U4dg@mail.gmail.com>
        (Stefan Beller's message of "Wed, 21 Jun 2017 12:46:09 -0700")
Message-ID: <xmqq7f05niwt.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

>>>
>>> +enum diff_symbol {
>>> +     DIFF_SYMBOL_SEPARATOR,
>>
>> Drop the last comma from enum?
>
> I looked through out code base and for enums this is
> actually strictly enforced, so I guess I have to play
> by the rules here as I do not want to be the first
> to deviate from an upheld standard.

You sound like you are trying to find an excuse "not to play by the
rules".  Don't.


