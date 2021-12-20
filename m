Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F1E8C433EF
	for <git@archiver.kernel.org>; Mon, 20 Dec 2021 15:36:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236254AbhLTPge (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Dec 2021 10:36:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231320AbhLTPgd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Dec 2021 10:36:33 -0500
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com [IPv6:2607:f8b0:4864:20::c31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02282C061574
        for <git@vger.kernel.org>; Mon, 20 Dec 2021 07:36:33 -0800 (PST)
Received: by mail-oo1-xc31.google.com with SMTP id a11-20020a4ad1cb000000b002c2657270a0so3166205oos.8
        for <git@vger.kernel.org>; Mon, 20 Dec 2021 07:36:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=83xygkj4ZeITW0wtfDuVk22thF+Y1RSzB+4OmXWpd94=;
        b=YRZvq7l6UIbSVtBb2aWIzMQkbo+lhi/KHH4/JS7czFKSS2ixvuGAH0xSyMO/7MIbaY
         0Sv8o12m0n09ELLuq0MKZUx0++JlsK492uOpXYL3m6ohGqj0Rd1r8uqWDedP5BcUVv2F
         MOs6RhDwi20ja87EE3ZCZDCd5SvGPtD7I3TegltotXMOHKJ5hqfyyJ5p1mws6hb/Pdqu
         MsRzgglSs8mmeDoxRrdgAUCEySpG41Uw42mAios7YsR/V1htAGbchPlhgw0tCr3D/efy
         mh7NGudMmpAr7w41qCavf0PvDEz0BFhn80QWgHgpXVJ+ZiJyuMGy8aKEfUXlG0EHvEzV
         tKIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=83xygkj4ZeITW0wtfDuVk22thF+Y1RSzB+4OmXWpd94=;
        b=xxkTHr9uAQda/xW16tXLn74lKQ5XMWwRUgspLCZlvWiytbxJKUEEIQ0/PGCVgdA8uN
         my65Xglmzpb/O+ZHhYL0+rP0VRtadpp4m79uyuL/ySL9wMlW08vKbVBXXugLcXNdNl/R
         qo6RBwvf0Rl5c3YagZL6tZPuHQOZK+aoj0bMhIIDX4pEwB0pOT6YQ+2ith8eDoiLKGGe
         /53+sfmkjIM49Bm4KonhVkHIOMAfRm7Hl9vO+x1lWqeSI17trngHCyvre7TjftnF3HgV
         etvlEFkjK+/Ur0fBykgCoKznQIpFX2FG8qnG9UWZdItcUpbQnlXICgOPhzb/IVji59+m
         aS7g==
X-Gm-Message-State: AOAM531CNcBVF+znTra6ct/sR3en4NKyiIpqWFlezTN0ZBFNa9t3yfsy
        GFqF+NRSxIGr7VM7gUYljeakY9oVURE=
X-Google-Smtp-Source: ABdhPJwMuW1kjjeXL5A4U3UdMojehvTxF/xaCYhyevv/6Idkul+m+jJ/G2MgD4iZZOsTRgvuo+BT0A==
X-Received: by 2002:a4a:8746:: with SMTP id a6mr10295353ooi.93.1640014592252;
        Mon, 20 Dec 2021 07:36:32 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:1dd9:8fb3:37da:4055? ([2600:1700:e72:80a0:1dd9:8fb3:37da:4055])
        by smtp.gmail.com with ESMTPSA id u6sm3678023oiu.34.2021.12.20.07.36.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Dec 2021 07:36:31 -0800 (PST)
Message-ID: <b52be977-f03c-7915-68c8-f1842e920184@gmail.com>
Date:   Mon, 20 Dec 2021 10:36:28 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH] merge: allow to pretend a merge into detached HEAD is
 made into a branch
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
References: <xmqqbl1ezq5j.fsf@gitster.g>
 <211218.86sfuqw6ii.gmgdl@evledraar.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
In-Reply-To: <211218.86sfuqw6ii.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/18/2021 5:27 AM, Ævar Arnfjörð Bjarmason wrote:
> 
> On Fri, Dec 17 2021, Junio C Hamano wrote:
> 
>> +		OPT_STRING(0, "detached", &detached_head_name, N_("name"),
>> +			   N_("use <name> instead of detached HEAD")),
>> [...]
>> +	OPT_STRING(0, "detached", &detached_head_name, N_("name"),
>> +		   N_("use <name> instead of detached HEAD")),
> 
> Maybe OPT_STRING_F and PARSE_OPT_NONEG, or does --no-detached make
> sense?

While sometimes undocumented, these "--no-" options allows calling an
alias that might have the positive version included while disabling the
option.

	git alias merge-main merge <lots-of-custom-things> --detached-head-name=main
	git merge-main --no-detached-head-name

So, I think using the standard OPT_STRING here is fine.

Thanks,
-Stolee
