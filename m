Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1C56D20D11
	for <e@80x24.org>; Fri,  2 Jun 2017 01:32:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751142AbdFBBcQ (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Jun 2017 21:32:16 -0400
Received: from mail-pf0-f170.google.com ([209.85.192.170]:35440 "EHLO
        mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751128AbdFBBcP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jun 2017 21:32:15 -0400
Received: by mail-pf0-f170.google.com with SMTP id n23so42182186pfb.2
        for <git@vger.kernel.org>; Thu, 01 Jun 2017 18:32:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=t3jXPfU1KtwdH65Uhy0T0uwLWTv6LxoYgpzWT/Gmdh4=;
        b=SRErE4qR0KL1NA3dATO+RnDJu7LNRs3/egCEySy04KERD4OxiJUkppeyiw2NepPy2s
         JMiAw0R2tkC/kbypOVtusR4cryj5W8MfFyHy8zm/yp/SG47qiVHNaITBnDv9UuPyGW5g
         qr4IINM5zT4eiSaIA2m7orwzyGNCaQFx93CF5vnNiBKlgnZ7Wkd9zJY5pb9CGI8ajEw1
         5KeQpJHNe+V4wRNSlduil982wHl6dMl0YdIrwE4zZ7SUOfhk9qgm8lj3nYyMfTda/lRB
         oeDYx0fsXtWW2j+9TKG5DpQ3976xp3zUcC9goaxb+6GCBTrsB0m18Tgk5X+tn6M1SMdS
         TLNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=t3jXPfU1KtwdH65Uhy0T0uwLWTv6LxoYgpzWT/Gmdh4=;
        b=XYvsONoMmhAifoHfWDjFgGLVCgENJQrOfxGqYrYfH2l/d1IE1L7ELbpJShAFZGkimQ
         JzJggJW7hWTWspminnsHFnsMYO46ffUJ/5QHq94ENIz9TX7n6kTwvnlQBsqsMWpyq+A/
         p6HijfjdpDdeCSNbuxElyqhfQaFkZa2KdCeu8nmXr1lSDvJtGXeONcN0A5CB73CHN5cn
         W1KsQPPm8Pi4gLDDn5QUB8xRfa+ODP/SO8XM0IESal+JQvn2NLCzAwVCeQPxyrWPuqYd
         U4B7pS3XYe1W4SXOeh9W17zXkxkwSZ9IzQhOWqc0GAT+abEwXI5JnsR4Zv62rOOeu94X
         p5LA==
X-Gm-Message-State: AODbwcA+9v8w1zxZ39kCjYZ0b/TaQfryVBZIIUNwWFCsRdoFnnrqOaDo
        JTwrF9kkh9KzRQ==
X-Received: by 10.98.87.211 with SMTP id i80mr4130821pfj.231.1496367134806;
        Thu, 01 Jun 2017 18:32:14 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:ec2c:8ebb:3fc7:e0d4])
        by smtp.gmail.com with ESMTPSA id r126sm14296255pgr.65.2017.06.01.18.32.13
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 01 Jun 2017 18:32:14 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, peff@peff.net, sandals@crustytoothpaste.net
Subject: Re: [PATCH 31/33] tree-diff: convert path_appendnew to object_id
References: <20170530173109.54904-1-bmwill@google.com>
        <20170530173109.54904-32-bmwill@google.com>
Date:   Fri, 02 Jun 2017 10:32:13 +0900
In-Reply-To: <20170530173109.54904-32-bmwill@google.com> (Brandon Williams's
        message of "Tue, 30 May 2017 10:31:07 -0700")
Message-ID: <xmqq4lvz2mzm.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams <bmwill@google.com> writes:

> @@ -221,7 +221,7 @@ static struct combine_diff_path *emit_path(struct combine_diff_path *p,
>  	if (emitthis) {
>  		int keep;
>  		struct combine_diff_path *pprev = p;
> -		p = path_appendnew(p, nparent, base, path, pathlen, mode, oid ? oid->hash : NULL);
> +		p = path_appendnew(p, nparent, base, path, pathlen, mode, oid);
>  
>  		for (i = 0; i < nparent; ++i) {
>  			/*

Ahh, it happens here ;-)

And of course, the order of these two patches cannot be swapped, so
this is the best organization of the series.

