Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DF9521F5CB
	for <e@80x24.org>; Tue, 23 Apr 2019 02:27:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730710AbfDWC1F (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Apr 2019 22:27:05 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37169 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729504AbfDWC1F (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Apr 2019 22:27:05 -0400
Received: by mail-wr1-f66.google.com with SMTP id t17so6288926wrr.4
        for <git@vger.kernel.org>; Mon, 22 Apr 2019 19:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=nZaeKsRxr98OUoi8IQLFiY+f29lvnBBeT+ousepskRc=;
        b=uFJjnzSZCB+VS7/N2QQkGXVuXT9lEZXCNm/roX2TdLRercUHYOPVLZlmvIm1DsXD1S
         pgb1PTurhsstfbbxv9Llfe07Ra7Rhpx5tWEhMQ2O28pw2V0NlWFOLyEiJwYEBYXRQ6x8
         auXcIRU+gYCBWF/t4CFqIWeF35xStrj8hfRHwH32Km9uRZJHffYc6VreXouvJi6V3woV
         idLPS/ckhl2s/7ZN+gDvH4hfYHMZ5S/hD5p2EuGiTsHz5X1f/cHiz9ZHHonlt2LbTqOD
         nEUj8eRazRszAgoPnZ1fCvnxTr73GiQXDUeUWz7KgpLsVQZdR4J+6VcI6+y8zZsx9n/k
         VvtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=nZaeKsRxr98OUoi8IQLFiY+f29lvnBBeT+ousepskRc=;
        b=ACB0rbWe9BUm3x5R7xzPpWBlWL7c0H2dGl/2S9xmiXBLstssbGU0HUpqH/8AcwS3MQ
         A4bCvhVUpEKaR57mTZZW3c2mucuqtDaPnjkNAnHgriTP+Cl0xpJnBL26DlQ70x9DsoSN
         jHAdjTuHR6c8Y3jVFh6EMQenMXrR+PvUvuD5a9fLFeC3jIQBVQN0fyLjTDm2fSwbEaQA
         GBpQBmzlfdSbDvUMH7yPLjBthHDvUR3a56jODztIMyJ9wXzaV6+1QKAHWOZQlUF17Nn4
         Y20enCOCTHrzN/Co/gZwiCBSjiOYmTnhkvu+V2ToAvsxDuiPpm0FZR6XKuxDlP0XUvc4
         RQfA==
X-Gm-Message-State: APjAAAXYG26zls8ePZFHrT5G88lVyUg0HcdtqPdxMyVhmrAkmanL8z2W
        FmhKCdrpdCqhVJyVAey01w2cZsgvyt8=
X-Google-Smtp-Source: APXvYqyyJMmeTTMh3u8Ay0ytrNK5xrqjwJ5L/TY6B3x6oKsnhfs5qX0ruG6MKs+F7TZs/KxrcYGkTQ==
X-Received: by 2002:adf:edc8:: with SMTP id v8mr5625680wro.206.1555986423376;
        Mon, 22 Apr 2019 19:27:03 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id d4sm14950604wrv.42.2019.04.22.19.27.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 22 Apr 2019 19:27:02 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Martin Fick <mfick@codeaurora.org>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] p5302: create the repo in each index-pack test
References: <259296914.jpyqiltySj@mfick-lnx>
        <20190420035825.GB3559@sigill.intra.peff.net>
        <16052712.dFCfNLlQnN@mfick-lnx>
        <20190422205653.GA30286@sigill.intra.peff.net>
        <20190422211952.GA4728@sigill.intra.peff.net>
        <xmqqef5t7cil.fsf@gitster-ct.c.googlers.com>
        <20190423020749.GB16369@sigill.intra.peff.net>
Date:   Tue, 23 Apr 2019 11:27:02 +0900
In-Reply-To: <20190423020749.GB16369@sigill.intra.peff.net> (Jeff King's
        message of "Mon, 22 Apr 2019 22:07:50 -0400")
Message-ID: <xmqqv9z55udl.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>> This is obviously inherited from the original, but do we get scolded
>> by some versions of bash for this line, without quoting the source path
>> of the redirection, i.e.
>> 
>> 	... --stdin <"$PACK"
>
> In general, yes, but I think we are OK in this instance because we
> generated $PACK ourselves in the setup step, and we know that it is just
> a relative .git/objects/pack/xyz.pack with no spaces.

I know we are OK, but the issue with some versions of bash AFAIU is
that bash is not OK regardless of the contents of $variable that is
not quoted and used as the target or the source of a redirection,
issuing an unnecessary warning.

