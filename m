Return-Path: <SRS0=QgeI=7Y=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF6ABC433DF
	for <git@archiver.kernel.org>; Thu, 11 Jun 2020 12:52:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C2F0207C3
	for <git@archiver.kernel.org>; Thu, 11 Jun 2020 12:52:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SJfhO5+p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726915AbgFKMw3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Jun 2020 08:52:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726597AbgFKMw2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Jun 2020 08:52:28 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48D4BC08C5C1
        for <git@vger.kernel.org>; Thu, 11 Jun 2020 05:52:28 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id f18so5437048qkh.1
        for <git@vger.kernel.org>; Thu, 11 Jun 2020 05:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=R0JNsKbzbkSYPWdeOzR/JlhKJl5ghTZSao/7baz1hh8=;
        b=SJfhO5+pAe2ew8vn2uYpV5EVcFrGZPIEOsbu6DXq3MeSyBN6LJ6Edm57Xn0qtMUpZS
         mn79y4CP3re4UtvQU6rrdfkERka7Z8rDFyd+eaOPBm9Nwsg9UfGleiv8nDTmqjfFWFBd
         wCGnAcx0fGw+nZoLnM0+KN0yOvwZ5S4Y5fMBJQve7CdI3nz0kR0uk1gQHlpf6DOntC1a
         RqkcdYW2IqLsIOtKFGAFOzTRxGlTRBKoJGWxgE0opEQnK5/m5DLAYBsNLVP1/W3UmHdI
         nu55W0aWC1vKkbtpxC0M5S1LaROuOrS8hwvSYXEXXKmmmD+IXJXtTvQhb/UOdsa7TWVF
         pwvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=R0JNsKbzbkSYPWdeOzR/JlhKJl5ghTZSao/7baz1hh8=;
        b=OsBVBxJda391YdWiCYtAy3i6pOvZG0731s3i1DG1vyQ6UFPoez+NwX+a7VhUp/b4pn
         szcfB31f4Nd1MUsybjq4vG4QcdNu5rLqMAlO0+tW4YGq9GhTpFJzZhFi6QveZcFvI9ZO
         9FaTmmSNThK+ty2536rTwS1VEPQddKM43a1cUPaLxcWox3bL5XT50CIJ9vpRZ+c3VcOL
         JsBBuNs4H2LtCHmoDm8zKLwbXWy4JkkoJ212fee9Ou+JwX1fOTdLVHpWd9FYfaQpOfPj
         rmt25iGI8Uu+NPza7Xemz54bwM/R4ByUDLGR6AJcY4ujdgdZHhQun2JyFuBC0YYaD9Io
         yxMQ==
X-Gm-Message-State: AOAM532uvwWvZOSM1IRA0MArEAr+JM4g3GjO0N5Sq2nAO32VjzCT3twt
        jF2zpkIKCNkPjYQCEHeRyWCElWYpSxo=
X-Google-Smtp-Source: ABdhPJwBD797uzvSKQxaRpeaGOxgI4AMziD5JDhCViiJ76EaegQd7sSVqYKOLpuXnQWVCvv3TAHkLA==
X-Received: by 2002:a37:512:: with SMTP id 18mr8491514qkf.231.1591879947054;
        Thu, 11 Jun 2020 05:52:27 -0700 (PDT)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id h5sm2190192qkk.108.2020.06.11.05.52.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jun 2020 05:52:26 -0700 (PDT)
Subject: Re: Rename offensive terminology (master)
To:     Don Goodman-Wilson <don@goodman-wilson.com>,
        =?UTF-8?Q?Michal_Such=c3=a1nek?= <msuchanek@suse.de>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Simon Pieters <simon@bocoup.com>, git@vger.kernel.org
References: <CAOAHyQwyXC1Z3v7BZAC+Bq6JBaM7FvBenA-1fcqeDV==apdWDg@mail.gmail.com>
 <20200505231641.GH6530@camp.crustytoothpaste.net>
 <nycvar.QRO.7.76.6.2006091126540.482@ZVAVAG-DN14RQO.ybpnyqbznva>
 <20200611115215.GQ21462@kitsune.suse.cz>
 <CAGA3LAfpoXDQryOPGg3g-4brpUcSAhL_2VOw8oy6D2ffp64hag@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <f27450d8-59a1-dc0b-f741-c8c883b95fe0@gmail.com>
Date:   Thu, 11 Jun 2020 08:52:25 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:77.0) Gecko/20100101
 Thunderbird/77.0
MIME-Version: 1.0
In-Reply-To: <CAGA3LAfpoXDQryOPGg3g-4brpUcSAhL_2VOw8oy6D2ffp64hag@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/11/2020 7:59 AM, Don Goodman-Wilson wrote:
> On Thu, Jun 11, 2020 at 1:52 PM Michal Suchánek <msuchanek@suse.de> wrote:
>> Indeed, the flexibility to choose the name of the default branch can be
>> helpful for projects with specific naming, especially non-english
>> speaking projects.
>>
>> To that end I would suggest adding -b argument to git init to be able to
>> choose the default branch name per project. This should select the
>> initial branch name and also write the it as the default branch name in
>> the repo configuration (if git continues to treat the default branch
>> specially).
>>
>> This can be used in documentation to use the new name immediately
>> without breaking existing workflows that rely on the 'master' branch.
> 
> I _really_ like this idea (and your reasoning). Seconded.

Yes, adding a -b|--branch option would be an excellent addition to
the config option.

Thanks,
-Stolee
