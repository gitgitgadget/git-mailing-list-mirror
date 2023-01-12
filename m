Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F41F2C54EBE
	for <git@archiver.kernel.org>; Thu, 12 Jan 2023 21:10:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240842AbjALVKh (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Jan 2023 16:10:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234697AbjALVKQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jan 2023 16:10:16 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 358B26C7CA
        for <git@vger.kernel.org>; Thu, 12 Jan 2023 12:54:34 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id m7-20020a17090a730700b00225ebb9cd01so24878084pjk.3
        for <git@vger.kernel.org>; Thu, 12 Jan 2023 12:54:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NwIwaTdZzt9uUy2DsI6/hZjMoR0szfy2mtWzdLIa9/U=;
        b=AEFyI+EvNhXGgmLOs4yxELSmRBBV/Eqiwm46LPkFEu1W6X2XNM8H6UdmjDCyiJanRD
         liIIBJaigJBXo/uHi7vmxwmMBHk07wgpkFAcnf/dkNF1+kEA5eex0Hkj0BbLlm7rukiw
         4RccSQxuQhPLYh/LtfT28M6MmU5VsvDRSNWqO53rP5OzwkF9MFqMEOg1trzQLBs1DbB4
         4L44ek6u/dS5I9c+XqS3DZ2xKlL+LJ1ro32lDT05zTYagPewt9y3dBh4+vRKrCayn9Aj
         Ee2T8hC1UDiU4Px+05nBb8R2eCsDChJNKvZ8rwZhCzQl5BI2cRwgZzE8I8fENxo2u12x
         205A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NwIwaTdZzt9uUy2DsI6/hZjMoR0szfy2mtWzdLIa9/U=;
        b=UnoVjwmHdBGPeJBDUUUl7lWp5lNdnoqgjIMs5vP+LE2S+RLtd2rPNkxlCxlgn04xCD
         vEX+XHmJH8FRKFozKxZAekGrkj2Yq3/OqgR29mz29Gi43cqm9TSHv6ultDP4HVmJg3Gk
         Kl1PN9WXg6IzESWk6ftGPwOXVGzprm717ZiVpBmEZwlw/uVkkg183mHAXuPkjno4oqTS
         kJKLGs5gv5qcwsyTv3VzfI/LJ+DV0YpoTTeKSliQrS6ZRhCu7q3MRITy7IQXIyPNebsr
         fvkcBrzXmuEON3q80JJs3mFFOS/WHcuzxXTpy4duQOxllsfncaRhjyZNc8RekR7Me4Bw
         maRA==
X-Gm-Message-State: AFqh2ko3L2qXGN2C97WDQW9O3wmhmwIDe8wySoyp8OWcZqcCgGwkJKc/
        SaoiykjsBlLRGdj7gjTyPQ0+
X-Google-Smtp-Source: AMrXdXuVl/F/FmWNNHPdBNAv7kAVanjxc1EMvcAEpyTD6xY3RHgE511vF39f+/qysrFgCsxgNmlLWw==
X-Received: by 2002:a17:902:ba93:b0:191:282:5d72 with SMTP id k19-20020a170902ba9300b0019102825d72mr6609131pls.51.1673556872835;
        Thu, 12 Jan 2023 12:54:32 -0800 (PST)
Received: from [192.168.50.41] (cpe-172-91-184-234.socal.res.rr.com. [172.91.184.234])
        by smtp.gmail.com with ESMTPSA id bg7-20020a056a02010700b004785c24ffb4sm1504392pgb.26.2023.01.12.12.54.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Jan 2023 12:54:32 -0800 (PST)
Message-ID: <3858d972-6659-76c5-8d13-b9c803bc32c8@github.com>
Date:   Thu, 12 Jan 2023 12:54:30 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH v4 6/8] test-http-server: pass Git requests to
 http-backend
To:     Matthew John Cheetham <mjcheetham@outlook.com>,
        Matthew John Cheetham via GitGitGadget 
        <gitgitgadget@gmail.com>, git@vger.kernel.org
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Lessley Dennington <lessleydennington@gmail.com>,
        M Hickford <mirth.hickford@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Glen Choo <chooglen@google.com>,
        Matthew John Cheetham <mjcheetham@github.com>
References: <pull.1352.v3.git.1667426969.gitgitgadget@gmail.com>
 <pull.1352.v4.git.1670880984.gitgitgadget@gmail.com>
 <0a0f4fd10c8b29f327c35dadc7b17881f22b253a.1670880984.git.gitgitgadget@gmail.com>
 <f99c381c-1d30-7c95-6158-cecd5321dafd@github.com>
 <AS2PR03MB9815D6B888AD0E0E12C1C679C0FC9@AS2PR03MB9815.eurprd03.prod.outlook.com>
Content-Language: en-US
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <AS2PR03MB9815D6B888AD0E0E12C1C679C0FC9@AS2PR03MB9815.eurprd03.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Matthew John Cheetham wrote:
> 
> On 2022-12-14 15:20, Victoria Dye wrote:
>> nit: '$TEST_OUTPUT_DIRECTORY' instead of '$(pwd)' is more consistent with
>> what I see in other tests. 
> 
> I don't see this? In fact I see more usages of `$(pwd)` than your suggestion.

To be honest, I'm not sure how I missed this. '$(pwd)' *is* quite common in
the tests, although it does seem to be used mostly in individual tests
rather than file-level variables (although that's not universally true, e.g.
using it to set 'CURR_DIR' in 't9400-diff-highlight.sh'). 

So, contrary to my earlier comment, this seems best left up to (your)
personal preference than any concrete rule.

> 
>> Also, if you're creating a repo in its own subdirectory ('repo'), you can
>> set 'TEST_NO_CREATE_REPO=1' before importing './test-lib' to avoid creating
>> a repo at the root level of the test output dir - it can help avoid
>> potential weird/unexpected behavior as a result of being in a repo inside of
>> another repo.
> 
> However.. after setting `TEST_NO_CREATE_REPO=1` I was getting CI failures
> around a missing PWD, so my next iteration uses the `$TRASH_DIRECTORY` variable
> explicitly in paths instead :-)

You're right, I was completely misreading the purpose of
'TEST_OUTPUT_DIRECTORY' in 'test-lib.sh':

> if test -z "$TEST_OUTPUT_DIRECTORY"
> then
> 	# Similarly, override this to store the test-results subdir
> 	# elsewhere
> 	TEST_OUTPUT_DIRECTORY=$TEST_DIRECTORY
> fi

"the test-results subdir" != "the test working directory". As you pointed
out, '$TRASH_DIRECTORY' would be the variable to use here.

