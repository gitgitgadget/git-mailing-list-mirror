Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 87CEA1F404
	for <e@80x24.org>; Tue, 18 Sep 2018 01:55:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727344AbeIRHZm (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Sep 2018 03:25:42 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46784 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726434AbeIRHZm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Sep 2018 03:25:42 -0400
Received: by mail-wr1-f68.google.com with SMTP id a108-v6so236301wrc.13
        for <git@vger.kernel.org>; Mon, 17 Sep 2018 18:55:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=dmhlkzFG3Vo0+l//1J0J4Igty0gNn0nMUoBI8PadIxo=;
        b=PIJ9RLxH0/jxUs9omDSt11A/G44vVLvIbpib6iJrN/da0NIw3UOO2uJCwRUdSGdeQS
         +fH0McucVAAGsVeM/z31E/nJjQk6IJfHI5mNBd2YjsrcpGrTLcUE3bG6MZz0qe9m6lzi
         K056hJJkmacc7P5eylZN1e39k9tudX/GjxdQDINPc6fia0/cvlRT+8Ob8cGP7/RmVNQB
         f2towyX1Ure/EQZQCuzhynuUU5m2WGFMujljastyqVshIy6+6WsYtQ3zXooxx+yFATnZ
         pUJ7PNKyUhLW1oRFV9hTTQDz0jbi8HA5lgKq3jsWxRc2aGQpQB5qne2+NPDA/oh1Sjjm
         Gohw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=dmhlkzFG3Vo0+l//1J0J4Igty0gNn0nMUoBI8PadIxo=;
        b=LiInW+8+n9P0DeJXrOKljNqjfuwyqe695xznk+z4tKPPmX453t0CC983XnNzDFhyda
         lWQdjx6ibOBKjv59Ax1uXp5AxmcsebfKQiU9wadWOs59tuyXIHfHVvqkQmQGx25FG8vy
         0os5EQQFJAjDXLe37eZY2zJyJm7PCuOvtYkSXbmMsM5AwNV9PTiR7hghDmL/cddNQzMq
         LRg6kwPFkIu4x7iyM7/9LuYbSPfvT0vweXaXMdS5m/nkPMick+MJ6Y6pBK89qi3POoEI
         z4AJc2wen7BEgEDwHCRfYtzyYL03SoIi7yoruGx7tltYCvA32gW8CDFwVsKot4P/17p3
         +1Zg==
X-Gm-Message-State: APzg51A0LGOJbtbduuzO5ilgqAEVsEAVhPHKe+1URwDyPKNmedaL7dHZ
        +ySnzg0DEbc/GRAXSprcG6Y=
X-Google-Smtp-Source: ANB0Vdaz4oi+LEYhXbHsqak0CcmwmgAe6gRX3MS3N1nfo9u198Crl+jCmctRHTGmi4R7nqU93V7evQ==
X-Received: by 2002:a05:6000:104a:: with SMTP id c10mr19653296wrx.271.1537235732793;
        Mon, 17 Sep 2018 18:55:32 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id l18-v6sm15248028wru.75.2018.09.17.18.55.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 17 Sep 2018 18:55:31 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Todd Zullinger <tmz@pobox.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org, Thomas Gummerer <t.gummerer@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] t5551-http-fetch-smart.sh: sort cookies before comparing
References: <20180907232205.31328-1-tmz@pobox.com>
        <20180907235508.GB32065@sigill.intra.peff.net>
        <20180908032841.GK7192@zaya.teonanacatl.net>
        <20180908161712.GA9016@sigill.intra.peff.net>
        <xmqqd0tb6bn0.fsf@gitster-ct.c.googlers.com>
        <20180917221603.GA3621@sigill.intra.peff.net>
Date:   Mon, 17 Sep 2018 18:55:31 -0700
In-Reply-To: <20180917221603.GA3621@sigill.intra.peff.net> (Jeff King's
        message of "Mon, 17 Sep 2018 18:25:39 -0400")
Message-ID: <xmqqy3bz4lik.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>> -cat >expect_cookies.txt <<EOF
>> +cat <<EOF | sort >expect_cookies.txt
>
> This can be spelled:
>
>   sort >expect_cookies.txt <<EOF
>
> can't it? Then we do not even incur the extra process. :)

Yeah, true.  Running cat only to feed a pipe with contents of a
single file or the here-doc is an anti-pattern.
