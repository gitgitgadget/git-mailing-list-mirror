Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9E69E1FAFB
	for <e@80x24.org>; Mon,  3 Apr 2017 17:42:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752263AbdDCRmu (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Apr 2017 13:42:50 -0400
Received: from mail-pg0-f43.google.com ([74.125.83.43]:35012 "EHLO
        mail-pg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751750AbdDCRmt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Apr 2017 13:42:49 -0400
Received: by mail-pg0-f43.google.com with SMTP id 81so127211174pgh.2
        for <git@vger.kernel.org>; Mon, 03 Apr 2017 10:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=Yg0tGuAd22FvNHU2XNxBLWkkWBlevFUBVphTuNnUi+0=;
        b=Z+ZIVGnuEvX+9rVckXFStIn8eRREz1RWMV6OCf0t8kKJZhIdJRew1ZNsitvn42D1Ym
         RhubYzwVjg/xFSTKZpsh5bLhK7pxupiCusWWkliLxa2Q/G/uwWAA0Euw+OSMSP8ojCAY
         odMGUz9Sie6GIfaj+b642zwPfNVh4w+78bE74lieBTmRFfe/4gUlp+y6MCONIhUINp3Q
         tBSaEwMbRl0VUlzUrvP6tMfrmlaU7jwICzYK4RnXz9BDPo6B76GsyDExvg49dK4JKhUh
         ej/nfyh/80Xaj4oPfgx3NzpbjfaW7FTzPTLq1/ygLImqxu1ciItPuJO3B92pLZVYZDME
         MGpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=Yg0tGuAd22FvNHU2XNxBLWkkWBlevFUBVphTuNnUi+0=;
        b=pDb76D/X+jO6iiEexE4q7koxUFu3EjxfLg4Khmns2femxY81XmNGq1WXXlUTeUmzQi
         LQTW5TuyHQLDhuFOxfA4uF162JLkaV3nK8MuXHSz/WiMSvxka0ifaiRm9l8L5+verA7L
         QMJHS9KckJeRg1YHSAZyd5uM9Mk7zUk4iqRAZXpMyAtfNdWFSHO9Aj6nbYM5i8O+ksZK
         jQH/HbpSX+xPHEZxWIHfnU6wy4vFx3MqB/BL/mujZIbT1BUVZrW4us7CQ5f/H1bPGJIn
         75qo0rVqPqgQ99g+LV8KVCfV5f/m10xIVq+88VmwO7ERzmc5uaGfedmPvxpPKVXOKDmH
         1aug==
X-Gm-Message-State: AFeK/H3wSFAmF3B7Q23R33xkGo78V6zGu3aODw+A5jLhzjFavUOWI9fUi5yzIISQz23Dwhdc
X-Received: by 10.98.28.215 with SMTP id c206mr18861518pfc.227.1491241368517;
        Mon, 03 Apr 2017 10:42:48 -0700 (PDT)
Received: from twelve2.mtv.corp.google.com ([2620:0:1000:5b10:c0e5:4562:356a:dc16])
        by smtp.gmail.com with ESMTPSA id d130sm27224569pga.17.2017.04.03.10.42.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Apr 2017 10:42:47 -0700 (PDT)
Subject: Re: Bug in "git am" when the body starts with spaces
To:     Jeff King <peff@peff.net>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <CA+55aFypmFkc4gOEea-AF1kKYb3K=6nosXvYS4AMGFOQHw0ZxA@mail.gmail.com>
 <CA+55aFwcQuxwhQ+LABmev2XRHgOqsbRm7YDYn3FDDXKMYcF-CA@mail.gmail.com>
 <CA+55aFwmNuvh_ABtnd_uxXv5HjEjN-+HMZGh_u1OjOCa4dbpmg@mail.gmail.com>
 <20170402041838.dzkmibc5lq37sm3h@sigill.intra.peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
From:   Jonathan Tan <jonathantanmy@google.com>
Message-ID: <f3f2b6f0-c6bb-f50a-5030-61afe941eb23@google.com>
Date:   Mon, 3 Apr 2017 10:42:46 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <20170402041838.dzkmibc5lq37sm3h@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks, everyone, for looking into this.

On 04/01/2017 09:18 PM, Jeff King wrote:
> On Sat, Apr 01, 2017 at 12:03:44PM -0700, Linus Torvalds wrote:
>> The logic is fairly simple: if we encounter an empty line, and we have
>> pending in-body headers, we flush the pending headers, and mark us as
>> no longer in header mode.
>
> Hmm. I think this may work. At first I thought it was too strict in
> always checking inbody_header_accum.len, because we want this to kick in
> always, whether there's whitespace continuation or not. But that
> accumulator has to collect preemptively, before it knows if there's
> continuation. So it will always be non-empty if we've seen _any_ header,
> and it will remain non-empty as long as we keep parsing (because any
> time we flush, we do so in order to handle another line).
>
> IOW, I think this implements the state-machine thing I wrote in my
> earlier email, because the state "are we inside in-body header parsing"
> is always reflected by having a non-empty accumulator. It is a bit
> non-obvious though.

About obviousness, I think of a non-empty accumulator merely 
representing that the next line could potentially be a continuation 
line. And it is coincidence that this implies "are we inside in-body 
header parsing"; if not all in-body header lines could be "continued", 
there would be no such implication.

mi->inbody_header_accum.len is already used in check_inbody_header to 
mean "could the next line potentially be a continuation line" and to 
trigger a check for a negative criterion (in this case, a scissors 
line). I think it's fine to do the same thing, the negative criterion 
here being a blank line.
