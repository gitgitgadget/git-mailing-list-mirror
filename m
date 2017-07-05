Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A79DA202A7
	for <e@80x24.org>; Wed,  5 Jul 2017 18:38:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752030AbdGESiy (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Jul 2017 14:38:54 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:33867 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751680AbdGESix (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Jul 2017 14:38:53 -0400
Received: by mail-pf0-f194.google.com with SMTP id c24so22506161pfe.1
        for <git@vger.kernel.org>; Wed, 05 Jul 2017 11:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=VnFzvK8q0F0krN6uKiGzOOMZocmkx3qWVx9BDFlqf30=;
        b=B+4r++bY6d8MaVmrFEvkQSwCw0vjbOy8W1LrAOwWs0q6h93coEnTysNkAnITrzKdBr
         MTY9YNBpW0b0vU/9YOqvj25MRntGtdquXJEv8MynMcYyXoQJLdX/z+CTZcrUPrisPhui
         SPyj0RsKFPi8RgZ1Kb0kBkn1JagQ/Tft6TxMbJvnLX/3fJ5MvfSYpdkZwnqGyNLVqsh9
         cBXAAEnP+gHLjxle2fS7ShAzwh5eqtyEyqV8mNP9/PtgFi0n1sNyzG+TIyqABTSqfAxB
         xBO6vUAtB76Vp+P0BB2mdkiV2PWFGrPmrxWxLyKisZYLxge/8AvB0UsynMCA5knmMXIh
         Vbbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=VnFzvK8q0F0krN6uKiGzOOMZocmkx3qWVx9BDFlqf30=;
        b=tpy8lMd4rzeRPP3YRiS9s+Zb6YQ6k/uQbs0H+CT0l52+ntQA9ywL6UB8SgTE9qNeBE
         usLSa+82LKgNyQNvGA15p40B+C72Lnux3QnK6NRpWZC7YIXa24gxYgtk+M86Ey6e7l3m
         iSnHNF1K4PSmOt7Qwtt3rmbuKcYvPMbDiFN44CiVgWt1ST5LaNf8hwhj/VBlM2b8T9/D
         tetRkrtB1zHlxRbutqZBC7Z3KfsktAvDNKl3aB55t3qdTUIIjgY9MZJ1HRYbUILHyqV9
         BM0eo2mDbbXzopGwSIYQqIBH6pDA2L2MpfOn9l/D1RljPKIcB06wA79LBwvfQMR0JPBu
         1ujA==
X-Gm-Message-State: AIVw113vxCsZcPWm0vfu6wf9/PepjWpEJRptC6PJFNUC585gAqAc2FaI
        iro/6t7fxaOV/A==
X-Received: by 10.99.121.75 with SMTP id u72mr22242135pgc.53.1499279932705;
        Wed, 05 Jul 2017 11:38:52 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:ad13:9505:c2bc:e887])
        by smtp.gmail.com with ESMTPSA id w85sm65147197pfj.115.2017.07.05.11.38.51
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 05 Jul 2017 11:38:52 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        "git\@vger.kernel.org" <git@vger.kernel.org>,
        Brandon Williams <bmwill@google.com>,
        Stefan Beller <stefanbeller@gmail.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH 11/12] sha1_name: convert get_sha1* to get_oid*
References: <20170703185533.51530-1-sandals@crustytoothpaste.net>
        <20170703185533.51530-12-sandals@crustytoothpaste.net>
        <CAGZ79kYWKUPhfMvg2N+1h6b49d3Bqw_3Moes9XscjkmXAumz8Q@mail.gmail.com>
Date:   Wed, 05 Jul 2017 11:38:51 -0700
In-Reply-To: <CAGZ79kYWKUPhfMvg2N+1h6b49d3Bqw_3Moes9XscjkmXAumz8Q@mail.gmail.com>
        (Stefan Beller's message of "Wed, 5 Jul 2017 11:01:07 -0700")
Message-ID: <xmqq4luqiv9g.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

>> @@ -636,7 +636,7 @@ static int get_sha1_basic(const char *str, int len, unsigned char *sha1,
>>                 int detached;
>>
>>                 if (interpret_nth_prior_checkout(str, len, &buf) > 0) {
>> -                       detached = (buf.len == 40 && !get_sha1_hex(buf.buf, sha1));
>> +                       detached = (!get_oid_hex(buf.buf, oid));
>
> omitting the length check here?

Good eyes.  It probably should check with the possible oid lengths.
