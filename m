Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11C19C433B4
	for <git@archiver.kernel.org>; Sun,  4 Apr 2021 20:25:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CCE8C61382
	for <git@archiver.kernel.org>; Sun,  4 Apr 2021 20:25:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231492AbhDDUZ5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 4 Apr 2021 16:25:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231453AbhDDUZz (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Apr 2021 16:25:55 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45E99C061756
        for <git@vger.kernel.org>; Sun,  4 Apr 2021 13:25:48 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id c3so9898246qkc.5
        for <git@vger.kernel.org>; Sun, 04 Apr 2021 13:25:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=DtWGOBxnmJRvFu/Z9jfV1NAYLzDarywzLa+KXkcam4w=;
        b=RJzQ5YuEDCxv/225bl78BWfohI2GswaGPTLfLF1Eljywmw9+gwihODDOeHQLrx922+
         pIcwQl/FkGpD1sghNP8Q1xYApQo8zMEM2abV1Ci0L1RET6d9dtc0NgoY8D+zg9IjPMMt
         Jj7OV1Ru+rDxOwKu8YVLnVOG0nevUnMFRUx1Atv6tytBxmy6A7TfD1uqibikGUaLtS07
         iPADdiEp3vCogATM3zlobz7mNLO3jS1x4MQHd1dDSnGFGG99BMIcDT65qQhqhEHg91C/
         o5x9HkHZSz6DO/eEu7ylfsNaI/m2ZWj068HuYzUroI2mKPUQKQQ4HRThlmnlK+xoX1gu
         i8AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DtWGOBxnmJRvFu/Z9jfV1NAYLzDarywzLa+KXkcam4w=;
        b=fsgJ+KWxg8TvKJ1f1DJq7BANKZTDx9JE27XFnnTCAj4dPsWY770ztBIGMukYiJdKZn
         /YPvhQrB3pk+HQx87VI+MUNtnyqcxXTe99/iAqZPqic/zbEsYVlsDMGi/Je6zNM/s633
         1nXIjn0tEOtJ+zRAWgIJiKtB5XOTiBuJ/Zs6jq10rghBEXij9nVqHGDUyNPvGb4LTKPM
         0OLnBm830FnkM8LO7Ly5IhF3qQqi/Z3MnpoEUQJJD3ZijR+pLjzZnwvIBVoGaxOkM1yh
         U2u7e+eoAKiTXSz5ddel5Mtzl4jzmbDxKLSMSkkzqwrfyKNcCZe4W38JRVoEdswP5834
         PGIw==
X-Gm-Message-State: AOAM531p8y9LGSL7pQSEozhec3U5vwL3xFWnmCUMACkK3blHsYY6y/ej
        oTmFuy/3WBmwZIc6fUQjMhLm59HkJ6jeVg==
X-Google-Smtp-Source: ABdhPJzSWWAUuRHoMA3Xil1VKqUVBMOtYls4nqXmPwVcG6lbW6X3HMk19TFecIII0j23vUX5dh+9Yw==
X-Received: by 2002:a05:620a:630:: with SMTP id 16mr23189698qkv.304.1617567947835;
        Sun, 04 Apr 2021 13:25:47 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:d0fe:c9f3:8efa:4666? ([2600:1700:e72:80a0:d0fe:c9f3:8efa:4666])
        by smtp.gmail.com with ESMTPSA id e3sm12685034qkn.99.2021.04.04.13.25.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 Apr 2021 13:25:47 -0700 (PDT)
Subject: Re: should git maintenance prefetch be taught to honor remote.fetch
 refspec?
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Tom Saeger <tom.saeger@oracle.com>, git@vger.kernel.org
References: <20210401184914.qmr7jhjbhp2mt3h6@dhcp-10-154-148-175.vpn.oracle.com>
 <d246df21-fdaa-a391-847a-e03e8e664af1@gmail.com> <xmqq8s613gqa.fsf@gitster.g>
 <3bfd9a88-10f9-df71-bf96-f9c5654e48eb@gmail.com>
 <20210402182716.trbaflsjcvouff2y@brm-x62-17.us.oracle.com>
 <41dc2961-7ba5-a882-3416-45631e2cbb33@gmail.com> <xmqq1rbs4c6t.fsf@gitster.g>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <f113284b-a7fe-ba7f-ce1c-d214efd5d0c6@gmail.com>
Date:   Sun, 4 Apr 2021 16:25:44 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <xmqq1rbs4c6t.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 4/2/2021 5:19 PM, Junio C Hamano wrote:
> Derrick Stolee <stolee@gmail.com> writes:
> 
>> The other issue is that exact matches (no "*") have an exact
>> string in the destination, too, so replacing the _entire_
>> destination with "refs/prefetch/<remote>/*" breaks the refspec.
>> I think the substring approach will still work here.
> 
> I wonder if that matters.  If the exact format says
> 
> 	[remote "origin"]
> 	        url = git://git.kernel.org/pub/scm/git/git.git/
> 		fetch = +refs/heads/todo:refs/x/y/z
> 
> you can just add refs/prefetch/<remote>/ to the entire RHS to ensure
> that (1) the prefetch would not affect anything outside the 'prefetch'
> to break @{upstream} and friends, and (2) the prefetch from this remote
> would not affect anything used for other remotes.
> 
> IOW, the RHS, as long as it is hidden from normal operations and
> does not conflict with interaction with other repositories, where
> exactly in the refs hierarchy these objects are "parked" does not
> matter, I would think.
> 
> I do not recommend unparsed refspec and textually munging, by the
> way.  Doesn't
> 
> 	git fetch master:remotes/origin/master
> 
> first parse to normalize the src/dst sides to turn it into
> 
> 	git fetch refs/heads/master:refs/remotes/origin/master

I do not see evidence of this being reflected in my testing. The
good news is that I'm creating a test scenario that will give us
a clear way to test what the refspec parsing (and new output
format logic) is doing.

Now, it might be that we are having an equivalent behavior to
what you are suggesting because of the way refs are interpreted
when those refs are created based on the refspec. This complicates
things slightly, and I can work to see if there is a good way to
modify the refspec parsing to make this an explicit assumption.

> which is what you want to further redirect to the prefetch hierarchy
> 
> 	git fetch +refs/heads/master:refs/prefetch/origin/refs/remotes/origin/master
> 
> or whatever munging scheme is used?

The replacement will use the existing refspec's patterns for
partitioning the refspace, except we add 'prefetch' and no longer
insert the remote name ourselves. This allows us to have shorter
refnames while respecting the given layout as much as possible.

> Also, I wonder if there should be a mechanism to prune the
> prefetched refs, but that is totally outside the scope of the
> problem we have been discussing in this thread.
 
Yes, this is a good idea. Prefetch refs are going to add the
"force" option (starts with '+') because these refs should be
updated automatically when the remote refs are force-pushed.
Having a mechanism for removing dropped refs is a good idea.

Thanks,
-Stolee
