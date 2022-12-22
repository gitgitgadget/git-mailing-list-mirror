Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DD58C4332F
	for <git@archiver.kernel.org>; Thu, 22 Dec 2022 14:36:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235770AbiLVOgr (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Dec 2022 09:36:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235744AbiLVOgm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Dec 2022 09:36:42 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B4FE2937F
        for <git@vger.kernel.org>; Thu, 22 Dec 2022 06:36:41 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id w15so1830933wrl.9
        for <git@vger.kernel.org>; Thu, 22 Dec 2022 06:36:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:user-agent:mime-version:date:message-id:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LZ2UxWGxhIIQbasYyJT6Ok0+JwglAi2CZKH81d7gZF4=;
        b=Qx2iYTx2VoM9WcyP44ozz5D6MAogxHYwgekCiElG+t4kVPXTF3qKwysxUSEX3YEEN1
         onUH2RyvrlFS4TfWsGA3ZKvbIgt1mlapZuqfq8FzGxu5dFaMQ6KLNPXusiQZmQE2Iom9
         hgDQi7uQ6rCS3rayPPLjMMgzGLt6xaR3c2GWWNv7WjLBVY2gcOaGSR4u81g+3I7wVL/i
         +2Mstw4kzLJrjBGGa3JlHa+X6REPtzrkvTk8L3in5GDa5brA5L/X26eHJAL4EtR8KEPD
         pHX/szZUz7oCqzoNovcylHeEONLdZ1/JUeC644wxOChtPsug98t1bLFB5s2xmVJquiXN
         HrzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LZ2UxWGxhIIQbasYyJT6Ok0+JwglAi2CZKH81d7gZF4=;
        b=npfw3o9ylYvuUHBDuV9PLd87wGY76q8ORLT4/GZM5jqwkt/Lehc8/1jXl1kIc9c+jK
         eHg/5P5NZjnRhzESUOlvAwN0gGNBoDduxgJnL2ngNr7C5WyFFxYLxKjXxqELwrQ+utTQ
         CGQ9NfC7RAu8EG/g1JKOiXUfS6ZACbXt3/UgUQ1EcGSoYlASJR1ksONJKHPTRNJPSvLc
         nccGzFxBcCtG85EIq481Ul6Qjh1WplkWGDpictIdmsBtzwHTU3cv5G+plyERhiIQMVvj
         D2u119b1YRGiJflQyHmkFDkps7X3oGUWLvhXcjLd8Nr3th0MhzBROJyvl1H7VJJbGReg
         S8hA==
X-Gm-Message-State: AFqh2kpDkWVti9+ey6Ty0ca08ZZ1JW72HL5KDpCAYsymCaHPBkvT44vg
        aJK5xy73T6vLkkJOQhmebtdHoj2LKhk=
X-Google-Smtp-Source: AMrXdXuSk8SEbD4/uikEK5wAqi08Z5XVzsw2TDvCDMCqT0adIWB1saoXBZxKZ7bNFTdVO4nFocLmPw==
X-Received: by 2002:a5d:5485:0:b0:242:5e85:ac17 with SMTP id h5-20020a5d5485000000b002425e85ac17mr3671556wrv.40.1671719799572;
        Thu, 22 Dec 2022 06:36:39 -0800 (PST)
Received: from [192.168.1.14] (host-92-2-151-214.as13285.net. [92.2.151.214])
        by smtp.gmail.com with ESMTPSA id j1-20020adfff81000000b0024cb961b6aesm610781wrr.104.2022.12.22.06.36.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Dec 2022 06:36:39 -0800 (PST)
From:   Phillip Wood <phillip.wood123@gmail.com>
X-Google-Original-From: Phillip Wood <phillip.wood@dunelm.org.uk>
Message-ID: <1d40c799-e98a-2f44-9edd-795ade2b189f@dunelm.org.uk>
Date:   Thu, 22 Dec 2022 14:36:38 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v4 2/2] attr: add flag `--revision` to work with revisions
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Karthik Nayak <karthik.188@gmail.com>, git@vger.kernel.org,
        Toon Claes <toon@iotcl.com>, Junio C Hamano <gitster@pobox.com>
References: <cover.1671630304.git.karthik.188@gmail.com>
 <a161dbdf8b70354716d0bfeccc707c242c7f33a1.1671630304.git.karthik.188@gmail.com>
 <cc2e5f1e-8f53-ad83-1f5d-ae910ab60c53@dunelm.org.uk>
 <CAPig+cTHJzHsUum0RnyCcqxj1qhxJR9EcKRjoShCznQ_oXYHOA@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAPig+cTHJzHsUum0RnyCcqxj1qhxJR9EcKRjoShCznQ_oXYHOA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Eric

On 21/12/2022 21:13, Eric Sunshine wrote:
> On Wed, Dec 21, 2022 at 3:58 PM Phillip Wood <phillip.wood123@gmail.com> wrote:
>> On 21/12/2022 13:47, Karthik Nayak wrote:
>>> Since we use a tree-ish object, the user can pass "--revision
>>> HEAD:subdirectory" and all the attributes will be looked up as if
>>> subdirectory was the root directory of the repository.
>>
>> We should be clear in the documentation and option help that --revision
>> takes a tree-ish (i.e. --revision=<tree-ish>). Maybe calling the option
>> --tree would be clearer.
> 
> If that's the case, shouldn't this be called --source (or some
> variation thereof) for consistency[1] with git-restore?

Yes, that's a good suggestion, sorry I'd forgotten that you'd mentioned 
that before.

> [1]: https://lore.kernel.org/git/CAPig+cT_xz3m-3kkL_Scf0opNXkikU94kSF46VO8KHkNMWbGzg@mail.gmail.com/
> 
>>> +attr_check_revision () {
>>> +     path="$1" expect="$2" revision="$3" git_opts="$4" &&
>>
>> Is that line valid posix shell? I know it works with local (which is not
>> in posix) but is it allowed for global variables?
> 
> This is fine as-is; it's POSIX.

Thanks for clarifying that

Best Wishes

Phillip
