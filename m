Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD4FAC433FE
	for <git@archiver.kernel.org>; Fri,  4 Nov 2022 10:40:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231491AbiKDKk5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Nov 2022 06:40:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231475AbiKDKkr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Nov 2022 06:40:47 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54975CE
        for <git@vger.kernel.org>; Fri,  4 Nov 2022 03:40:42 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id v1so6437311wrt.11
        for <git@vger.kernel.org>; Fri, 04 Nov 2022 03:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:from:to:cc:subject:date:message-id:reply-to;
        bh=S8XnX6Oz+aVYvW6lPwCRQz11PdMGG257FzlDW7Arhu8=;
        b=hCuOGKKmaD6mupFoSeMZl8dv4NhuKtIGnDDMk9qxSJRy6MTU7yhdnXlkdBCNlkQ2qV
         FgQu39239HPUNLUePg7mDimMXl/9l4xREs9aJmI4irR3XoJXTS6n9l+dbhDKUCuGlD1/
         Sq3akfHzApvf+aqP8a5nagexsTVrfo0Fo4yx05vZv3yYACs6JpWq9YES6VXvbSTKKxIC
         erkmPJKmYOAcmqT/qxy/tWVfaP07hX8D5fl5i5ZOxfVBBt2GMta1aI1DXYkmZY2aRQep
         k5raav7b/OqKwVCWJKdR5BsUt7thHtokO2DTekDhik+9m5Df9HNNZ9Ic/Dk4ynB32kmY
         ytcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S8XnX6Oz+aVYvW6lPwCRQz11PdMGG257FzlDW7Arhu8=;
        b=uPYWnGtKmYMxAgTJyHwXN1eYK60gP0dQE2npoIurFq5lGbOfbnqYKnWL7CYKAzc2Th
         2Nak24+YKf+MR0GUxcFHBFMByj7Jau5nYYmY3J+I6shPneykVDDvqLpqRSV045rfm/cp
         ogjoH1BAKeGOnqUtnnc8ennLJeJwNz8elSQ2wS566rVWYXLeEqfsZ9rXYHhZIG/fYio/
         Nfg5DOCfNLShsmByUZwcG73r/3Y+HORImquPuyPJIY2RfTmzv6sy5tf7HOIW+LUJ+IE8
         A7zdZ/91YC+9PRhTiTGVX5p4usWQ65uNxs0DA4Ci0btyWcGTlkpWGqsUKxKlIvztrYeZ
         QCgA==
X-Gm-Message-State: ACrzQf24dPqHi7sfMSyNUceRB3j9nb8H6VotD9GmQD99sDpFanXy84xg
        hidXwOXnez91NiyLwhS/fVfwRb+nukU=
X-Google-Smtp-Source: AMsMyM4pTjBaRhJ3VsrAGg7xYmo4nc//kGVNIm2YIiMUeVvWW5EtgqLbkWPJ69o+XJrsWXh8bdJNQg==
X-Received: by 2002:a5d:5682:0:b0:236:6231:113b with SMTP id f2-20020a5d5682000000b002366231113bmr14637183wrv.42.1667558440748;
        Fri, 04 Nov 2022 03:40:40 -0700 (PDT)
Received: from [192.168.1.74] ([31.185.185.212])
        by smtp.gmail.com with ESMTPSA id az24-20020adfe198000000b0022cd0c8c696sm3228836wrb.103.2022.11.04.03.40.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Nov 2022 03:40:40 -0700 (PDT)
From:   Phillip Wood <phillip.wood123@gmail.com>
X-Google-Original-From: Phillip Wood <phillip.wood@dunelm.org.uk>
Message-ID: <c195b67c-4dbc-a8b8-8513-2664e1ca2404@dunelm.org.uk>
Date:   Fri, 4 Nov 2022 10:40:39 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: rebase -i --update-refs can lead to deletion of branches
Content-Language: en-US
To:     Victoria Dye <vdye@github.com>,
        "herr.kaste" <herr.kaste@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Derrick Stolee <derrickstolee@github.com>,
        Phillip Wood <phillip.wood123@gmail.com>, erik@cervined.in
References: <CAFzd1+5F4zqQ1CNeY2xaaf0r__JmE4ECiBt5h5OdiJHbaE78VA@mail.gmail.com>
 <123628cc-1410-aaa0-0151-2dff35bd1855@github.com>
In-Reply-To: <123628cc-1410-aaa0-0151-2dff35bd1855@github.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Victoria

On 04/11/2022 00:31, Victoria Dye wrote:
> herr.kaste wrote:
>> Now, I should just have not used `--update-refs` in the first place but anyway
>> I decide late that I rather don't want to update "master" etc. and it should
>> probably not delete the local refs.
>>
> 
> Agreed, this doesn't seem like desired behavior - the opposite of "update
> the ref" isn't "delete the ref". ;)
> 
> The reason it's happening is because, when '--update-refs' is used, the
> rebase starts by constructing a list of 'update_ref_record's for each of the
> refs that *could* be updated. Each item in that list contains the
> corresponding ref's "before" commit OID (i.e., what it currently points to)
> and initializes the "after" OID to null. When an 'update-ref' line is
> encountered in the 'rebase-todo', the "after" OID is updated with the
> newly-rebased value. However, if an 'update-ref' line is removed from the
> 'rebase-todo', the "after" value is never updated. Then, when the rebase
> finishes and the ref state data is applied, all of the entries with null
> "after" OIDs are deleted.
> 
> The three options for a fix I can think of are:
> 
>    1. initialize the "after" OID to the value of "before".
>    2. don't update refs with a null "after" OID.
>    3. initialize the "after" OID to the value of "before", don't update the
>       ref if "before" == "after".
> 
> I think #3 is the best option, since it avoids the unnecessary updates of #1
> and leaves a cleaner path to a 'delete-ref' option (like the one proposed
> elsewhere in the thread [1]) than #2. I'll send a patch shortly.

We should be removing the entry entirely if the user removes it from the 
todo-list see b3b1a21d1a (sequencer: rewrite update-refs as user edits 
todo list, 2022-07-19) where the commit message says

1. If a '<ref>/<before>/<after>' triple in the update-refs file does not
    have a matching 'update-ref <ref>' command in the todo-list _and_ the
    <after> value is the null OID, then remove that triple. Here, the
    user removed the 'update-ref <ref>' command before it was executed,
    since if it was executed then the <after> value would store the
    commit at that position.

I think that is the best approach but it seems the implementation isn't 
actually doing that.

Best Wishes

Phillip



> [1] https://lore.kernel.org/git/CA+JQ7M-GbBTHZZ9xOLR=FitWFpUnkfuep9kSfNPxuSbJbKteGw@mail.gmail.com/
> 
> Thanks for reporting!
> - Victoria
> 
