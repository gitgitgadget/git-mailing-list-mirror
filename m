Return-Path: <SRS0=ek70=5Y=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DDCBC2D0EA
	for <git@archiver.kernel.org>; Wed,  8 Apr 2020 15:51:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 544FB206F5
	for <git@archiver.kernel.org>; Wed,  8 Apr 2020 15:51:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t3wd3qeg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729675AbgDHPvT (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Apr 2020 11:51:19 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:41933 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729176AbgDHPvS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Apr 2020 11:51:18 -0400
Received: by mail-ot1-f68.google.com with SMTP id f52so7205964otf.8
        for <git@vger.kernel.org>; Wed, 08 Apr 2020 08:51:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=A0TEXTzISI5vVJanL9xsagwTQoB4PcKs1QvEo5po300=;
        b=t3wd3qegkcmAGWzKNo/+uoFR3UrdPgnC1iWZ9RHa1ylxhArtBQsXJ8X9J9SDyfdlqT
         ZYl/vQCa5F9rqSFUXRaI2VTtBpb7QaIb6hq/TIyi9VZ+26sgeQ1oHeZBTFv8mwgwUzs3
         jVjA9fu1rOdWIAg5AWkTacH6WFqSjenM8bKBYyIvbwYGtVBWX9k2g0vLG1ayeK7AOjls
         0XNGxtkIIbIjb/PVP4XrGf3gdGtm7iK8JpumfUMrLTnrr8LbddUGvqtR+DdqoqQrFQNZ
         BkIi3FewrtWJJI3tmJOCOtUn1RRFhXnKsfBlWvghSjvGjmeuvDj2loRIPic2rX75jh+g
         qh1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=A0TEXTzISI5vVJanL9xsagwTQoB4PcKs1QvEo5po300=;
        b=Jy3AlMx08ZeNMRbi1ikVozqiUXnEZR9CR+v1o4AmZaFyU9rVmJQeN8Ij/bojdi8qBd
         MJs4VWWHSyLZd8PLCbhatUP/6sHj2+rYkvqhqlnO/4EYL12k1XMA4hkbPphF1+GIF+DE
         gLNrcAJzQLRxLMERsZHFpuqFwn+0x1K1iahPu8URDRhCXSqFrB2sDLtXw0eRWfqk1auQ
         Sn7h2ae6e08EEtNsiLf1Pe1mhSDor8aFscE02TpJSlInmCZA02pLp3jppJkYwziE+UyF
         Gb/DQCUO4ewvvE+4Dfz4KrpaQrrqUrs2KFr6FdyMp0V5CexKBDSL3Oss6bwVll+GHZU0
         Trvw==
X-Gm-Message-State: AGi0PuYC82jtSttVURGYdmdTSotA3kuFXx/ftGApirB83JfxPUtYhhhA
        1oyVeGMFmmfjW1oa7NUNUTA=
X-Google-Smtp-Source: APiQypKEEWhdTHnSfHua044zOkYqTlHCnunleJxyEju5NuCyjC05Zn2yumi4d5H3iirtwNungU/aqw==
X-Received: by 2002:a05:6830:1aee:: with SMTP id c14mr5958872otd.141.1586361077830;
        Wed, 08 Apr 2020 08:51:17 -0700 (PDT)
Received: from [192.168.1.83] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id x125sm658800oia.50.2020.04.08.08.51.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Apr 2020 08:51:17 -0700 (PDT)
Subject: Re: [PATCH v4 00/15] Changed Paths Bloom Filters
To:     Garima Singh via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     szeder.dev@gmail.com, jonathantanmy@google.com,
        Garima Singh <garima.singh@microsoft.com>,
        "jnareb@gmail.com" <jnareb@gmail.com>,
        "gitster@pobox.com" <gitster@pobox.com>
References: <pull.497.v3.git.1585528298.gitgitgadget@gmail.com>
 <pull.497.v4.git.1586192395.gitgitgadget@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <ced7a793-47d9-8254-93fe-acdda8f12334@gmail.com>
Date:   Wed, 8 Apr 2020 11:51:14 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:75.0) Gecko/20100101
 Thunderbird/75.0
MIME-Version: 1.0
In-Reply-To: <pull.497.v4.git.1586192395.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/6/2020 12:59 PM, Garima Singh via GitGitGadget wrote:
> Hey! 
> 
> The commit graph feature brought in a lot of performance improvements across
> multiple commands. However, file based history continues to be a performance
> pain point, especially in large repositories. 
> 
> Adopting changed path Bloom filters has been discussed on the list before,
> and a prototype version was worked on by SZEDER Gábor, Jonathan Tan and Dr.
> Derrick Stolee [1]. This series is based on Dr. Stolee's proof of concept in
> [2]
> 
> With the changes in this series, git users will be able to choose to write
> Bloom filters to the commit-graph using the following command:
> 
> 'git commit-graph write --changed-paths'
> 
> Subsequent 'git log -- path' commands will use these computed Bloom filters
> to decided which commits are worth exploring further to produce the history
> of the provided path. 

I noticed Jakub was not CC'd on this email. Jakub: do you plan to re-review
the new version? Or are you satisfied with the resolutions to your comments?

Is anyone else planning to review this series?

I'm just wondering when we should take this series to cook in 'next' and
start building things on top of it, such as "git blame" or "git log -L"
improvements. While it cooks, any bugs or issues could be resolved with
patches on top of this version. That would be my preference, anyway.

What do you think, Junio?

Thanks,
-Stolee

