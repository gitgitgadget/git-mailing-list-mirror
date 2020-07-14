Return-Path: <SRS0=b2TE=AZ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88241C433E1
	for <git@archiver.kernel.org>; Tue, 14 Jul 2020 15:40:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D2912064C
	for <git@archiver.kernel.org>; Tue, 14 Jul 2020 15:40:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vB0qx1rx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbgGNPkV (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Jul 2020 11:40:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725890AbgGNPkT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Jul 2020 11:40:19 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 116B7C061755
        for <git@vger.kernel.org>; Tue, 14 Jul 2020 08:40:19 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id p7so7685572qvl.4
        for <git@vger.kernel.org>; Tue, 14 Jul 2020 08:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=zkLLOSZ7SeWAbVzGLBHr4gE3q+2jRK7y6+qeylw0nZc=;
        b=vB0qx1rxsPczNPW4LQmWc0RL/+YbFrI/Reiqy3egGYypQ4V7l6BfUOYIljSJese7eB
         8eRt1y9lBnLb5Pjk6hgI9YanRTFifCFpp324/Zwqwf7l/SsFfyJY30OB/m5NegdhQqlw
         Ydyt9ZLuXcqiT/gWuoU4Di5rJacZIPiRt/cZyZN4nVhraZmxWF5g0K3PvJdnxN+apkGd
         4rpHem96Pj9roV4R8hwcgjIIh0Ser8RryCcBxgRrydzsNUnPxGOXsDhk4nuUqbxd7LK4
         1HrFQIl1tYEarhIDGu5GnJZjOoLtWUs9y/Zrk8zp1h+t+4TBIhvFNBmoGWt3Ck30i6xw
         gOQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zkLLOSZ7SeWAbVzGLBHr4gE3q+2jRK7y6+qeylw0nZc=;
        b=ZSendYsvzrQNMhyLZD/IqSW9bWbQQ+JV4l9zxv8+lJXuI4+TI8rEfN9/vS23YxGePE
         syX/cPYr3qzmR5NQw0mmyQ80VZEahNS42EDEYjDTIAg6c4s02U8QzZvwLNNdIRE3rJ2h
         iFulyPbZBM/+XiLBs9BkaKJxxL/Cy7mHil51yvo7zCvNm3xnntM4Ueby5/W56QPEj5I8
         0jVn+8Nxj6mq9myiQPVShzHHspAJivmE6VE4vRtNOZZ6MVKzE9qBl0eo0YtxUQVtl0Qn
         +tofKIwOA8uN8jg/YErIaq4A2/6eSeneZXya3iay8ayMGEqEQt7OwKycTkzHvg8FsG4E
         4lfg==
X-Gm-Message-State: AOAM53390bmahS5belzN3jIQDjYQkLUP4BWql+dHaAOdbC+Ulf08T2RI
        7FS9WNdximZh4m/tOLdOzjTbzispj1Q=
X-Google-Smtp-Source: ABdhPJzvugX1VkACZNfx/OMGsH2k8nmYfYwyIFePIJ+lqOC3aVZr9qls1mcUsjefHW91QJHZ/FOUmA==
X-Received: by 2002:a0c:a306:: with SMTP id u6mr5287589qvu.88.1594741218101;
        Tue, 14 Jul 2020 08:40:18 -0700 (PDT)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id r18sm4355216qtf.62.2020.07.14.08.40.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jul 2020 08:40:17 -0700 (PDT)
Subject: Re: [PATCH] setup: warn about un-enabled extensions
To:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Edward Thomson <ethomson@edwardthomson.com>
References: <pull.675.git.1594677321039.gitgitgadget@gmail.com>
 <0bede821-139a-d805-934a-142004abaa4c@gmail.com>
 <nycvar.QRO.7.76.6.2007141420300.52@tvgsbejvaqbjf.bet>
 <xmqqzh82ktgm.fsf@gitster.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <18c65b85-2f2a-ff96-1ea7-e16befa6928f@gmail.com>
Date:   Tue, 14 Jul 2020 11:40:16 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.0
MIME-Version: 1.0
In-Reply-To: <xmqqzh82ktgm.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7/14/2020 11:27 AM, Junio C Hamano wrote:
> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
>>> If you don't mind, I was already going to squash Junio's commit into
>>> mine (almost completely replacing mine) but I could add a small
>>> commit on top that provides the following improvement to the error
>>> message:
>>
>> I don't mind at all. I'd just like to know that v2.28.0 avoids confusing
>> users in the same was as v2.28.0-rc0 confused me.
> 
> In a nearby thread, Jonathan Nieder raised an interesting approach
> to avoid confusing users, which I think (if I am reading him
> correctly) makes sense (cf. <20200714040616.GA2208896@google.com>)
> 
> What if we accept the extensions the code before the topic in
> question that was merged in -rc0 introduced the "confusion" accepts
> even in v0?  If we see extensions other than those handpicked and
> grandfathered ones (which are presumably the ones we add later and
> support in v1 and later repository versions) in a v0 repository, we
> keep ignoring.  Also we'd loosen the overly strict code that
> prevents upgrading from v0 to v1 in the presence of any extensions
> in -rc0, so that the grandfathered ones will not prevent the
> upgrading.
> 
> The original reasoning behind the strict check was because the users
> could have used extensions.frotz for their own use with their own
> meaning, trusting that Git would simply ignore it, and an upgrade to
> later version in which Git uses extensions.frotz for a purpose that
> is unrelated to the reason why these users used would just break the
> repository.  
> 
> But the ones that were (accidentally) honored in v0 couldn't have
> been used by the users for the purposes other than how Git would use
> them anyway, so there is no point to make them prevent the upgrade
> of the repository version from v0 to v1.
> 
> At least, that is how I understood the world would look like in
> Jonathan's "different endgame".
> 
> What do you three (Dscho, Derrick and Jonathan) think?  

If "v0" includes "core.repositoryFormatVersion is unset" then I
would consider this to be a way to avoid all user pain, which is
positive.

I'd be happy to test and review a patch that accomplishes this
goal.

CC'ing Ed Thomson because this extension stuff affects other tools,
like libgit2.

Thanks,
-Stolee

