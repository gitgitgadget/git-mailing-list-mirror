Return-Path: <SRS0=UYkv=ZZ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A18DC432C0
	for <git@archiver.kernel.org>; Tue,  3 Dec 2019 16:03:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F2822068E
	for <git@archiver.kernel.org>; Tue,  3 Dec 2019 16:03:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SBwuBa1T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726888AbfLCQDe (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Dec 2019 11:03:34 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:36488 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726131AbfLCQDd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Dec 2019 11:03:33 -0500
Received: by mail-qk1-f194.google.com with SMTP id v19so3940867qkv.3
        for <git@vger.kernel.org>; Tue, 03 Dec 2019 08:03:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=xckf2TVioxAny6cZ9eZqjhBS+2ArrIY5K/zFk17kHQQ=;
        b=SBwuBa1Tce/rvIkgZsfcvfKdmxXPwYxxItDPAb4MbwbecVFXwpc1i3Ikmx/z5k2PEK
         velK2cPZu9kf+sOznU4vjQ1XABmESkwxGSb/JAp/al+BSx5qjItDDPCYWJPFkgD4gT0e
         mArx/1UEK89pTfZepmbgyaA78rMzVbf3QXNuW05Pqky8+ztfmHqlkfC8vmn3jkJnYXJj
         5E3DjKu9+JIfHmKsUddD+dtdUuFgyN5hXitbnCRnuFpTu/Y50UEHJn9daGZtjDBWDX0H
         uP0SXMiP8gFQj0e9AEPapnBmHFTBK0WUdDeGKD7NmaOAADeuR2TdTOsyrYWlFz+NioyT
         7pHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=xckf2TVioxAny6cZ9eZqjhBS+2ArrIY5K/zFk17kHQQ=;
        b=JAVV4sOL0Zs1O0/DZ9k7jaSaTUB7l/HWr+ZHHrld4UoMzCvawooCLfVmOzR2B/o+Fg
         oYIIET90PzEmS/GCnSq0/v1sBxAXpbg9yICUhTQ86HGZndgY/X4wLHTkXKoU2hPhmdWM
         vCqbIUeX55hxcIY0eaX2lApQGH8vFnF9fmR5E4NhcpWbD7p4nAr4wmGM8M3Is3qljiDo
         kStz1gHtfunAJubppPLnSW06ZwXTBMpLhAkxM4TLBq4r11yfm+3XRgQdmhRb3q0h5Zw2
         gDqwIWuejoGLR8DjdbTiIpij1V7bIcFBNb8Ktaz0iiiiZaLXoj/6F73LTmi6Y89l/xrR
         O52A==
X-Gm-Message-State: APjAAAU0Lcotc194YmblSS2ZJjyvUSG1My0/LdOM0o2YJ8tz3Vxm1DnT
        HeLJQmRAnKuroJd6QULZ6rI=
X-Google-Smtp-Source: APXvYqxI063WDDPZ0aDbIPKFFJXZjqTCZRVIAiJK/eiNPpSTHIe84LXxtoxu8ePN4KlqlJLLOr08bw==
X-Received: by 2002:a37:76c5:: with SMTP id r188mr2371659qkc.256.1575389012863;
        Tue, 03 Dec 2019 08:03:32 -0800 (PST)
Received: from [10.10.31.126] ([24.229.121.34])
        by smtp.gmail.com with ESMTPSA id m16sm1929482qke.26.2019.12.03.08.03.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Dec 2019 08:03:32 -0800 (PST)
Subject: Re: [PATCH v3 1/1] Python3 support for t9800 tests. Basic P4/Python3
 support
To:     Denton Liu <liu.denton@gmail.com>,
        Ben Keene via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
References: <pull.463.v2.git.1573828756.gitgitgadget@gmail.com>
 <pull.463.v3.git.1575313336.gitgitgadget@gmail.com>
 <02b3843e9f21105a945335d0b1d78251ddcc8cee.1575313336.git.gitgitgadget@gmail.com>
 <20191203001854.GA59841@generichostname>
From:   Ben Keene <seraphire@gmail.com>
Message-ID: <5c299c98-dda4-768d-7307-666bde85715d@gmail.com>
Date:   Tue, 3 Dec 2019 11:03:31 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191203001854.GA59841@generichostname>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On 12/2/2019 7:18 PM, Denton Liu wrote:
> Hi Ben,
>
> Thanks for the contribution!
>
>> Subject: Python3 support for t9800 tests. Basic P4/Python3 support
> In git.git, the convention for commit subjects is to use
> "<area>: <summary>". Perhaps something like, "git-p4: support Python 3"?
> Although I doubt this patch should remain as is... More below.
I didn't realize the email message from gitgitgadget was going to be the 
commit message, I thought it was the PR message.  I'll work on changing 
that!
>
> On Mon, Dec 02, 2019 at 07:02:16PM +0000, Ben Keene via GitGitGadget wrote:
>> From: Ben Keene <seraphire@gmail.com>
> It would be nice to have a bit more information about what this patch
> does. Could you please fill this in with some more details about the
> whats and, more importantly, the _whys_ of your change?
Sure, I'll add more detail.
>> Signed-off-by: Ben Keene <seraphire@gmail.com>
>> ---
>>   git-p4.py | 825 +++++++++++++++++++++++++++++++++++++++++-------------
>>   1 file changed, 628 insertions(+), 197 deletions(-)
> This is a very big change to be done in one patch. Could you please
> split this into multiple smaller patches that each do one logical
> change? For example, you could have the following series of changes:
>
> 	1. git-p4: use p4.exe if on Windows
> 	2. git-p4: introduce encoding helper functions # this is to
> 	        introduce the as_string(), as_bytes(), etc. functions
> 	3. git-p4: start using the encoding helper functions
> 	...
>
> This was just an example and you don't have to follow those literally. I
> just wanted to give you an idea of what I meant.
>
> You can see Documentation/SubmittingPatches#separate-commits for more
> information.
>
> Thanks,
>
> Denton
So my last question would be, should I open a different PR on 
gitgitgadget? I can cherry-pick my changes into another branch and 
restart my submission?
