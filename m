Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0FEDC433F5
	for <git@archiver.kernel.org>; Sat, 25 Sep 2021 03:03:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B014E610F7
	for <git@archiver.kernel.org>; Sat, 25 Sep 2021 03:03:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347738AbhIYDEk (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Sep 2021 23:04:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347703AbhIYDEk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Sep 2021 23:04:40 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F606C061571
        for <git@vger.kernel.org>; Fri, 24 Sep 2021 20:03:06 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id r2so11729606pgl.10
        for <git@vger.kernel.org>; Fri, 24 Sep 2021 20:03:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7dyL2lAWtfJdXFOjZ8yQ16g1ck3SaYAJqJf+N/GJ3NU=;
        b=nOYtK2s9VFDmIZ8K17yRWqBFRQo3tLmqrBhVMcHMtzIo7f//fL/id/VRoXj7PrRz66
         TZcZIYUPuaJj6oMzLRY8GHwwI/eMuTmsUMXAYwJ2NDwfLYb/CmmtAgnrMPxfwjXeGRYA
         SeK8fRfnFh0h89dcMHhE3awZ5O7T8FQP4hX0r3/lPur5oaQoBVDFjmc/W06CFSTz746Q
         9mCMnW33wOuDS3MuW+KZkDOG+g0BPpBFmEWL/nv6nrL/VnuaEWMRl3DmL1+aCU3VjMrE
         sDJqk8upXDJljnvQznZ4XhtTqKDcxtVfgsl1RoROiddQ8GtXp3lxQVQIUfNstgNljlCX
         9OdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7dyL2lAWtfJdXFOjZ8yQ16g1ck3SaYAJqJf+N/GJ3NU=;
        b=7KOPFVYz4Osgut22yS7FCco2e+WNWN1lSwwC5G9iUA2NFvgmKUXAqMJ7StR7rYi2ud
         oMBy9HEALVXpO2Tunnuo/wjM24n8eshjOAoL5/Bv6iMjbdIltdVXEpk+g0M4+/esODSP
         jP4hOX6/y/ssC0KUnSKUiD5z++ZZn5BsWW//0ZrW2deNScQXU0zVh3mKARDsDzPW0p7S
         +6CMm4xCxefUzqv3fgEncYHYsn+0xg80dlSPdW3eHGcMkvfg4mDlIVE7fvBUY3d4N9PO
         ajQfCmW75ngXUcRC6VfS9qcoCEkcZGa6HBAVxW29JBs58L9bjGzLc0W8G/MDMkbOfdE5
         GaIA==
X-Gm-Message-State: AOAM531sIxjJexr1Ob5GBvfNQmfbspfm2fI/n8MDZ5vS7aA/ZMT3yLB1
        6MO0fXQI0lW83M5ucH3XRGxofnw5rm/k7d9Q
X-Google-Smtp-Source: ABdhPJyn2gRAIHOB6VFbX9nxb3LB4RF7Xfs572RmbThMjfdKUZoO6IN3c8nEB5TNiwSOmPmEUmfE8A==
X-Received: by 2002:a63:131f:: with SMTP id i31mr6504379pgl.207.1632538985513;
        Fri, 24 Sep 2021 20:03:05 -0700 (PDT)
Received: from [192.168.43.80] (subs02-180-214-232-88.three.co.id. [180.214.232.88])
        by smtp.gmail.com with ESMTPSA id b142sm10434422pfb.17.2021.09.24.20.03.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Sep 2021 20:03:04 -0700 (PDT)
Subject: Re: [PATCH v5 3/3] send-email docs: add format-patch options
To:     Junio C Hamano <gitster@pobox.com>,
        Carlo Arenas <carenas@gmail.com>
Cc:     Thiago Perrotta <tbperrotta@gmail.com>, avarab@gmail.com,
        git@vger.kernel.org
References: <87zgs34ccx.fsf@evledraar.gmail.com>
 <20210924024606.20542-4-tbperrotta@gmail.com>
 <9a60226c-7a35-0486-a687-31f7691e7551@gmail.com>
 <CAPUEspjxYy4GOABXkzRza-wmKnZAdq-v=OP-9+-wfV2PCnDGwQ@mail.gmail.com>
 <xmqqzgs2vvim.fsf@gitster.g>
 <CAPUEspiSh91a8MvhqhKm=DAn5_u-HoRBuL6-gBRMUtSshqpf=g@mail.gmail.com>
 <xmqqo88hspvv.fsf@gitster.g>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Message-ID: <d9114e0a-cb6e-1791-51f8-6e57f313e8d5@gmail.com>
Date:   Sat, 25 Sep 2021 10:03:01 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <xmqqo88hspvv.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 25/09/21 03.03, Junio C Hamano wrote:
> Ah, thanks for explanation.
> 
>      git format-patch -2
> 
> would be options-only way to "indicate some sort of revision", so
> perhaps
> 
>      . git send-email <send-email options> files|directory
>      . git send-email <send-email options> <format-patch options>
> 
> (where "options" is used to refer to both --options and arguments)
> would illustrate the differences better?
> 

But we can also directly specify revision range (commonly <common 
ancestor>..HEAD or HEAD ^<common ancestor>).

So for the second form, the syntax will be:

   git send-email <send-email options> <format-patch options> <revision 
range>

-- 
An old man doll... just what I always wanted! - Clara
