Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0B26C4332F
	for <git@archiver.kernel.org>; Wed,  3 Nov 2021 14:40:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A0AAC610E8
	for <git@archiver.kernel.org>; Wed,  3 Nov 2021 14:40:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231922AbhKCOnb (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Nov 2021 10:43:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231572AbhKCOna (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Nov 2021 10:43:30 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0285FC061714
        for <git@vger.kernel.org>; Wed,  3 Nov 2021 07:40:54 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id bl27so1145407oib.0
        for <git@vger.kernel.org>; Wed, 03 Nov 2021 07:40:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=A5I8sW+Dzox+sx+v35A/KSYbJc02q75OESjnC10je8w=;
        b=qHJ2WoTa4gBgjCW3mEM4WDP63AzNWKe+/p6ZZpgr/SSa9V49RqaDUW3AtztcpNLXGQ
         UfopL7PSiNCsUZTOJN9LCGFNnFtls/u8R+2XKhfQabFxWU2+B/VQ8kjyIJUzEW9aUHhQ
         Kh1izNImgHGf7nUKDpsmP/ZlE8a6rC7jQirPNk4oD26xF76NzDRzXCkEcdkVwH89nQGu
         kYotMN5ZHCAfVXDXI1XZyWKMWW4s845RiZrIWJV8lxEeI581mNEJYx+8SB/jxP4lNnkC
         bW95uzMZTrNi8OCIei3YMQy+1C7bDjNIQ2OT4EhiPMh1rV82GX8nCY1HHXw2z47hRKqk
         9BLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=A5I8sW+Dzox+sx+v35A/KSYbJc02q75OESjnC10je8w=;
        b=HeS5jMEq/O6bb/rcRhls5eDHe9BCqQR2VbFah0yGhsHQCmOh63rDIr5u+CamDa1Inj
         Z7aafA1oPSA1Zx+eO9sUWUmyn7bHHupH7NVYNpnwnATbxr9n4aBHw2lImOMsthH9LgWL
         2tVyB6Y2FhJJlxo87UGikmQmasTYkx/oPyT0bPxAJR8vnZfY0IJFNFcF5u4vcGc6fte6
         HF33oKto7pwk9AyCN/HB+vvaA47D8WlF7KZZXybOdAZno4aMkJVmukXDP/fYk8VxkuTY
         7FJhkWIlya7Fs8LM1RtVrK+bz+mLWfSUsEKQnJEiGONv7+XyIfIIrkm9CeQib1Mw277y
         wW8w==
X-Gm-Message-State: AOAM5321I3t5X4WvKJfTl73Kjbgwt5fv44ivPahqPjIEz6tZkXXj3z1/
        ys+FTg+EeBdygj5QHhuFDEY=
X-Google-Smtp-Source: ABdhPJyZaFBbqUEgEwvDp19SXf/t/F0JWVSv+V/RzdoeODAU3+Ar6mi4uwO2WJzup+7VXx1unpiGew==
X-Received: by 2002:a05:6808:159b:: with SMTP id t27mr10993841oiw.108.1635950453234;
        Wed, 03 Nov 2021 07:40:53 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:90ad:dd5d:e6f0:46f0? ([2600:1700:e72:80a0:90ad:dd5d:e6f0:46f0])
        by smtp.gmail.com with ESMTPSA id 70sm563697otn.74.2021.11.03.07.40.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Nov 2021 07:40:52 -0700 (PDT)
Message-ID: <1b9e4d3b-faa6-c9fc-c734-4720f9f832df@gmail.com>
Date:   Wed, 3 Nov 2021 10:40:51 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH v4 04/13] dir: fix pattern matching on dirs
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Glen Choo <chooglen@google.com>, git@vger.kernel.org,
        newren@gmail.com, matheus.bernardino@usp.br, vdye@github.com,
        jrnieder@gmail.com
References: <kl6lzgqnv2dn.fsf@chooglen-macbookpro.roam.corp.google.com>
 <xmqq7ddr9z0i.fsf@gitster.g> <2f1d2e09-faf5-0caf-6be8-7bcede9fe8d1@gmail.com>
 <7a62be4e-aa69-8a79-4608-971b96ee4d7c@gmail.com>
 <211102.86pmri1rv7.gmgdl@evledraar.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
In-Reply-To: <211102.86pmri1rv7.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/2/2021 11:33 AM, Ævar Arnfjörð Bjarmason wrote:
> 
> We have t3070-wildmatch.sh testing various combinations of these, and
> indeed this code resolves back to wildmatch().
> 
> But I think in this case this is due to dir.c's particular behavior of
> splitting paths before feeding them to wildmatch, as it needs to match
> things relative to the subdirectory.
> 
> Still, we've got a matrix of these in t3070-wildmatch.sh, which already
> tests some (but apparently not all) cases where we need to create an
> actual file on disk. These sorts of test blindspots are why I added that
> in de8bada2bf6 (wildmatch test: create & test files on disk in addition
> to in-memory, 2018-01-30).
> 
> Wouldn't it be better & more exhaustive here to change its test lines
> like:
> 
> 
>     match 0 0 1 1 foo/bar/baz 'bar'
> 
> To say:
> 
>     match 0 0 1 1 ? ? foo/bar/baz 'bar'
> 
> And just add to its match() function so that if we have a subject with a
> slash, we mkdir up to that first slash (here: "mkdir foo"), and create a
> .gitignore file therein with the "foo" directory with the "bar" content,
> perhaps adding "/bar", "bar/" and "/bar/" variants implicitly.
> 
> Then create a "bar.txt" in the directory as well, and a
> bar-otherdir/somefile.txt or whatever.
> 
> And fill in the "? ?" depending on whether those variants matched or
> not...
> 
> Anyway, just an idea, but if you pursue that you should be able to get
> much more exhaustive testing in this area that we've apparently had a
> blindspot in.

Those tests are quite exhaustive, but the test script is pretty
inscrutable and the refactor you suggest is pretty major. I'd prefer
to keep to the focused test for the sake of fixing this in time for
the release.

Thanks,
-Stolee
