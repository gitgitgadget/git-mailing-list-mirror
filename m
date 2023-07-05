Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8E8EEB64DA
	for <git@archiver.kernel.org>; Wed,  5 Jul 2023 18:23:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233404AbjGESXe (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Jul 2023 14:23:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233872AbjGESXP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Jul 2023 14:23:15 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0027C1FFD
        for <git@vger.kernel.org>; Wed,  5 Jul 2023 11:22:50 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1b852785a65so7736205ad.0
        for <git@vger.kernel.org>; Wed, 05 Jul 2023 11:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google; t=1688581365; x=1691173365;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UhG0qz5r6IyZ6c7UsW9obKciRkJf8EzbBLtM56g7EKs=;
        b=AoAAxGS1VMbTx5ddQf4j5eCzGy/i3Axd9Rqo2Il7+GvPUgwukPkuaXU94BOHpss+Oq
         0G4huyWOXz7J1G9em/QhQ7vcCrng5uxFrcjNSP17ghBZsxSj+Ky08bXhAW1amrP11tfy
         9ukoL1d5nxoOduu4/oSkARfpqwRn6hvsjHbWu4occKc2zfhEo6VqLeEqi6vlvEeauQCd
         RVcOBwo1uiWwBMy2hYUQYBFPIfEtFwveWzq+44z/GUHFqObAkuOGZ/aSwd75gvd/UiXu
         nDH47LtPEE81BnRB9sk2k3IcbqYtIVQw8STDimfk3keHcspZ4d9CaLS+zihMzTk2NTbg
         4bNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688581365; x=1691173365;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UhG0qz5r6IyZ6c7UsW9obKciRkJf8EzbBLtM56g7EKs=;
        b=FUHosp7wxDLfnqn4Em/g80emFutsW19hsapmJMkp2PHiE55uKg64EvV1+0fCCPEj+y
         z6gCDty6ngMZ16MRbwpxq5JjPWpj8XKcyFS+gxkvq9XKMA7q7rbUf7+XznnnyXUfH4pN
         IcUp0dq8eyuu2FoHjoZO1+eJBrMblokru+s/vL10nv9ZP5We2aNJDA5ZHUFlZAriWa3/
         f5R3h/qZKzcumkDewHXpHCZUXeQgw50t1FaR5O0IV/oTSK4gStt4oGNEFsavEJffu8F8
         4TGSAftPRkeMOCpiHfh0PNLjaIfBMnq8nFIOCYyTLnG0GDGeOioEKx31G6Hsq3fSeE+e
         HGeA==
X-Gm-Message-State: ABy/qLaOHp4Azm78LCjy2Mh+HbYZQ6HeUALRwdeYV1CUKOmPLOGdzq/P
        W/AQS1AReSyCI/oGbPlgpYgk
X-Google-Smtp-Source: APBJJlFytVPFmx/4qLEGeZkN7TJ667FcIv2fhZ4jTpo5taIb6MTC2KOFQaSgVXWjtwd+0PmreJtCiw==
X-Received: by 2002:a17:903:234e:b0:1b8:a894:407c with SMTP id c14-20020a170903234e00b001b8a894407cmr4592309plh.22.1688581365698;
        Wed, 05 Jul 2023 11:22:45 -0700 (PDT)
Received: from [192.168.50.41] (cpe-172-91-184-234.socal.res.rr.com. [172.91.184.234])
        by smtp.gmail.com with ESMTPSA id jh9-20020a170903328900b001b881a8251bsm8130900plb.106.2023.07.05.11.22.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Jul 2023 11:22:45 -0700 (PDT)
Message-ID: <151e7426-e5b2-b078-7b51-63a4bd99dfed@github.com>
Date:   Wed, 5 Jul 2023 11:22:42 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [RFC PATCH 1/8] trace2: log fsync stats in trace2 rather than
 wrapper
Content-Language: en-US
To:     Calvin Wan <calvinwan@google.com>
Cc:     git@vger.kernel.org, nasamuffin@google.com, chooglen@google.com,
        johnathantanmy@google.com
References: <20230627195251.1973421-1-calvinwan@google.com>
 <20230627195251.1973421-2-calvinwan@google.com>
 <05df2971-0f26-6da3-093b-7de5d7a5dbca@github.com>
 <CAFySSZCYpxNcK6Tfagk1ZBs6cOT9XvWm2b3DJhN0fSPsQCWR1g@mail.gmail.com>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <CAFySSZCYpxNcK6Tfagk1ZBs6cOT9XvWm2b3DJhN0fSPsQCWR1g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Calvin Wan wrote:
>> An added note re: the commit message - it's extremely important that
>> functions _anywhere in Git_ are able to use the Trace2 API directly. A
>> developer could reasonably want to measure performance, keep track of an
>> interesting metric, log when a region is entered in the larger trace,
>> capture error information, etc. for any function, regardless of where in
>> falls in the internal library organization.
> 
> I don't quite agree that functions _anywhere in Git_ are able to use
> the Trace2 API directly for the same reason that we don't have the
> ability to log functions in external libraries -- logging common,
> low-level functionality creates an unnecessary amount of log churn and
> those logs generally contain practically useless information. 

That may be true in your use cases, but it isn't in mine and may not be for
others'. In fact, I was just using these exact fsync metrics a couple weeks
ago to do some performance analysis; I could easily imagine doing something
similar for another "low level" function. It's unreasonable - and unfair to
future development - to make an absolute declaration about "what's useful
vs. useless" and use that decision to justify severely limiting our future
flexibility on the matter.

> However,
> that does not mean that all of the functions in git-std-lib fall into
> that category (usage has certain functions definitely worth logging).
> This means that files like usage.c could instead be separated into its
> own library and git-std-lib would only contain files that we deem
> "should never be logged".

How do you make that determination? What about if/when someone realizes,
somewhere down the line, that one of those "should never be logged" files
would actually benefit from some aggregate metric, e.g. a Trace2 timer? This
isn't a case of extracting an extraneous dependency (where a function really
doesn't _need_ something it has access to); tracing & logging is a core
functionality in Git, and should not be artificially constrained in the name
of organization. 

>> To that end, I think either the
>> commit message should be rephrased to remove that statement (if the issue is
>> really "we're using a static variable and we want to avoid that"), or the
>> libification effort should be updated to accommodate use of Trace2 anywhere
>> in Git.
> 
> Besides potentially redrawing the boundaries of git-std-lib to
> accommodate Trace2, we're also looking into the possibility of
> stubbing out tracing in git-std-lib so that it and other libraries can
> be built and tested, and then when Trace2 is turned into a library,
> it's full functionality can be linked to.

If that allows you to meet your libification goals without limiting Trace2's
accessibility throughout the codebase, that works for me.

