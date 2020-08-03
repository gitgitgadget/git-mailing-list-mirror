Return-Path: <SRS0=/7R8=BN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75117C433DF
	for <git@archiver.kernel.org>; Mon,  3 Aug 2020 23:01:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A2832073E
	for <git@archiver.kernel.org>; Mon,  3 Aug 2020 23:01:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="guYBuhvz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729154AbgHCXBj (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Aug 2020 19:01:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729139AbgHCXBi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Aug 2020 19:01:38 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7414AC06174A
        for <git@vger.kernel.org>; Mon,  3 Aug 2020 16:01:38 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id d4so939128pjx.5
        for <git@vger.kernel.org>; Mon, 03 Aug 2020 16:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ei/ecVLhs2zFCl3aeLn9oH5mUDHSsy/FAuEMKM3lGlY=;
        b=guYBuhvz/AcEpe+WGTF5xNDtlX7OlJ/nJBmqJpaJTYT1/F0DUHkZ9bPmvSJ6d3uJpt
         KX/YgjDocSo4Yc7jpgQEzngSDVMWYhFmEm8Pc28Loyt7TVtGgtoKoDaT/+conMVyZAQl
         9PskOWQPU9uC6q/rAhgx7wZ7ex7FwP+Ky6aHCOzQavpi2I9hSEgjPDctf2q2ZIeQPZj/
         RyGe2wcbghXcpTZVNLx81zsHjzBGmd1KGVgX2iDVuMoqBkhP1LqD3eBJWLdVz+Xffxva
         yGfvlv03ufxkCMjY28f9MU6WLOgZjdVqwSkAnZnDYqHYg7IJXaf6B+9/AJNzp50Py2Jk
         EQIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ei/ecVLhs2zFCl3aeLn9oH5mUDHSsy/FAuEMKM3lGlY=;
        b=QwzPS9dSOLaHwVWd3rgY1Qevw6HwzOdvHnBQAR1aEsWm3luiIiBAUzrcpJO8ddDPQY
         /vZwA11wc5LDepCfnE+5HNZDAyH7LrSt9WcPoF2BMfjuMTJzSVV8NzojqzcqGTE7Ijx9
         y1W99D6N1NsgWLMbca8t2+8bDOIX1V5NMnAlaxcb1RcYOSNCBqXC2rw5c88F/p8hkfMz
         gfeG03vh4X9W3cWK2IH5XFKo7KpLJ8skxhKOUJZ11dReZm3FIIKx9OcHF8Jn8/xut/MY
         P+wHJVG57UZzqdjzBAHeu0127MsDZ6aoLwI+7Pb7Us4tUbVFEXZChPXQPV3vxBO2e2ms
         zbtA==
X-Gm-Message-State: AOAM531KX/qrDKuj+yiIyjooUxGn2ALlukx8cwfU89ky1uIlMD/ffUOi
        XmmY4w33URqFMn2OTQ5EpXE=
X-Google-Smtp-Source: ABdhPJy9j/zPW4aqS1qxccVEGo+ERS+WMIw5OSV7llsajtg/hCvsebcgx5zGX1Mff0R7359pCqfspg==
X-Received: by 2002:a17:90a:3ccc:: with SMTP id k12mr1393027pjd.184.1596495697818;
        Mon, 03 Aug 2020 16:01:37 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:a28c:fdff:fee1:cedb])
        by smtp.gmail.com with ESMTPSA id x66sm20151286pgb.12.2020.08.03.16.01.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2020 16:01:36 -0700 (PDT)
Date:   Mon, 3 Aug 2020 16:01:34 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Johannes.Schindelin@gmx.de,
        sandals@crustytoothpaste.net, steadmon@google.com, peff@peff.net,
        congdanhqx@gmail.com, phillip.wood123@gmail.com,
        emilyshaffer@google.com, sluongng@gmail.com,
        jonathantanmy@google.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v2 01/18] maintenance: create basic maintenance runner
Message-ID: <20200803230134.GA58587@google.com>
References: <pull.671.git.1594131695.gitgitgadget@gmail.com>
 <pull.671.v2.git.1595527000.gitgitgadget@gmail.com>
 <63ec602a07756a41f8ccddd745562c567a4b3ed7.1595527000.git.gitgitgadget@gmail.com>
 <20200729221905.GB519065@google.com>
 <5cbdb559-3897-961f-4dd3-0bab11848c5b@gmail.com>
 <20200731003022.GA1029866@google.com>
 <a176ddf5-b45b-fb25-8740-96efbd324edf@gmail.com>
 <20200803174654.GA2473576@google.com>
 <20200803224631.GA73022@syl.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200803224631.GA73022@syl.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau wrote:
> On Mon, Aug 03, 2020 at 10:46:54AM -0700, Jonathan Nieder wrote:
>> Derrick Stolee wrote:
>>> On 7/30/2020 8:30 PM, Jonathan Nieder wrote:
>>>> Derrick Stolee wrote:

>>>>> If there is a better way to ask "Did my command call 'git gc' (with
>>>>> no arguments|with these arguments)?" then I'm happy to consider it.
>>>>
>>>> My proposal was just to factor this out into a function in
>>>> test-lib-functions.sh so it's easy to evolve over time in one place.
>>>
>>> This is a valuable suggestion, but this series is already too large
>>> to make such a change in addition to the patches already here.
>>
>> Hm, it's not clear to me that this would make the series significantly
>> larger.
>
> I think what Stolee is trying to say is less about a change that would
> make the series larger, it's about changing an already-large series.
>
>> And on the contrary, it would make the code less fragile.  I think this
>> is important.
>
> I'm not sure that I see your argument. What we are really discussing is
> whether or not we should have a static struct outside of 'cmd_gc()', or
> a zero-initialized frame local struct within 'cmd_gc()'. I fully
> understand the arguments in favor of one or the other, but I struggle to
> grasp that this is worth our time to debate in this much detail.

Sorry for the lack of clarity.  The proposal Stolee is pushing back on
above is to have a helper in test-lib-functions.sh that tells a test
whether an event it cares about happened in traces (in this example,
invocation of "git gc").

I consider it important because if we are getting into the habit of
having our tests assume the current exact byte-for-byte trace JSON
output, then that is an assumption that is going to be painful to
unravel.  Factoring out a helper would also make the test easier to
read, but that is less important than "an ounce of prevention is worth
a pound of cure" to me in this example.

Jonathan
