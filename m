Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F0C33202AC
	for <e@80x24.org>; Wed,  5 Jul 2017 01:48:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752312AbdGEBsY (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Jul 2017 21:48:24 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:35413 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752286AbdGEBsY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Jul 2017 21:48:24 -0400
Received: by mail-pg0-f65.google.com with SMTP id d193so10856638pgc.2
        for <git@vger.kernel.org>; Tue, 04 Jul 2017 18:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=r1p21Ep6HqHDpF27vleU3Pyf60Hpi3Hc6rJpjghHsSQ=;
        b=mse5gSZsh8sA57r+HeWtZb/L2K+NPJbGNQ8uFbRSgyrvDrUwSy6I4yaW2mUZ+UV0YX
         EyjH3JhGJqVX+nqxxzqZFnqNDuPURqT4wMT22yN1nLGKZxgbDV1p8VZuT3Y7h17hPxnb
         4+5ZBPtZpOogRdFNFuiTFzHEOEnoH+Xbd6OuxnpSSTdnhIKXFs8DrxLVfNTQcriWZH5T
         U8rPdaADWG/4782iZvyX+XWYaE534FW+lUs08F2WFHalB9JZi01mrjzX2O/cNTE+cM5s
         yVq4s8qDqVnPwcSoY1SstnPQfGxwQKI1DCVYubZDNGtEr/AGuUH5H2u0Y7kd5UxK2c5r
         RfEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=r1p21Ep6HqHDpF27vleU3Pyf60Hpi3Hc6rJpjghHsSQ=;
        b=F1haiwb75bku/Eg9DlgmElsJgxjrTeJp6I4oz9a9luuGZrR12iMOdFIHi3i8bZW7sy
         CBZCBOB5RsNQJ3Py35Sk1ec/HJIocqa1HgXq8uvxNATV1reh0+6I3Dbz8mBQ0snjhNEy
         hJfXxLsbbuwx+yF1CsyN37ienlK/3nltQ++V2pJF1QtGWijwD3OlxblSBv30pI858Isx
         CocJJGt7v9LAC779Y4NpeTdvNuXBWdCxg5TOM8aBYGorNxRG0Ng6Mf/ZHlwa3ZN6uC8c
         rSY5VLBP9q38WuSSl6Lra1UqSScxSMseoMmvfsIaFRL/BD6wmkmVhe4o0Op6p82yrSZR
         kUaw==
X-Gm-Message-State: AIVw110sLK8X0koW7jdad8QcZnMQdoxKX2IBWAezQFXyFAkRsNZ0pbiA
        p6XLbMF95pXk8w==
X-Received: by 10.98.64.220 with SMTP id f89mr17802223pfd.225.1499219303229;
        Tue, 04 Jul 2017 18:48:23 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:58ac:d78a:789c:c809])
        by smtp.gmail.com with ESMTPSA id s88sm40825125pfk.16.2017.07.04.18.48.22
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 04 Jul 2017 18:48:22 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
Cc:     git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>
Subject: Re: "git intepret-trailers" vs. "sed script" to add the signature
References: <20170630154306.26993-1-kaarticsivaraam91196@gmail.com>
        <xmqq1sq1togq.fsf@gitster.mtv.corp.google.com>
        <1498918546.4321.1.camel@gmail.com>
        <1498925790.4321.7.camel@gmail.com>
        <xmqqh8ytmp7y.fsf@gitster.mtv.corp.google.com>
        <1499195804.6428.2.camel@gmail.com>
Date:   Tue, 04 Jul 2017 18:48:21 -0700
In-Reply-To: <1499195804.6428.2.camel@gmail.com> (Kaartic Sivaraam's message
        of "Wed, 05 Jul 2017 00:46:44 +0530")
Message-ID: <xmqqr2xvk61m.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kaartic Sivaraam <kaarticsivaraam91196@gmail.com> writes:

> On Mon, 2017-07-03 at 09:58 -0700, Junio C Hamano wrote:
>> Kaartic Sivaraam <kaarticsivaraam91196@gmail.com> writes:
>> 
>> > I'll send a typical patch that uses "git interpret-headers" as a
>> > follow-up.
>> 
>> When you say a "typical" patch, what do you exactly mean?  Does
>> anybody else send typical patches (or atypical ones for that matter)
>> to the list?
>> 
> I apologise for the inconsistent wordings. I try to mean a patch which
> I'm not sure is acceptable (or) not. I guess that's [PATCH/RFC] in the
> language of this list. I'm not acquainted to the wordings as I'm an
> "off-list" person trying to help and get help! I'll try to use
> consistent wordings as far as I could. Once again, please excuse my
> ignorance.

Oh no need to apologise for "ignorance"; that goes both ways. I
wasn't familiar with a phrase you used "a typical patch" (which I
suspected that is something you may be used to from your involvement
in other development community) and showing _my_ ignorance and
asking for help to clarify, so that both of us can understand each
other better.

My reading of your response is that it is a normal patch that
proposes a change, as opposed to the final version of a patch meant
for inclusion, after it has been discussed here and everybody
supports---let me know if I am still not reading you correctly.

Thanks.
