Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A4D0C2B9F4
	for <git@archiver.kernel.org>; Sat, 19 Jun 2021 11:21:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E36DA6054E
	for <git@archiver.kernel.org>; Sat, 19 Jun 2021 11:21:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233697AbhFSLXN (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 19 Jun 2021 07:23:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233146AbhFSLXM (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Jun 2021 07:23:12 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D39CC061574
        for <git@vger.kernel.org>; Sat, 19 Jun 2021 04:20:57 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id x21-20020a17090aa395b029016e25313bfcso7424033pjp.2
        for <git@vger.kernel.org>; Sat, 19 Jun 2021 04:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=HfQL+jxOCm3MHGLhfG3PCxJiFncw+wuQzTWAsPVg/Jc=;
        b=rUkSX8xH3LqTHA901XcmX2V8tgtlwb2ySQYS/W7LJQZ68VFFTG63S/6igYx2itF8/L
         LAaEVgNJ7X8cXwMznqbkepfYCD4wR5dTMmcolrEkCLgKhxM3jpPdUHXx1YYlox+Oz/kQ
         kRI65OcBKmdk/M8Nc/7irJqCsuKHpxZJ8eWz0HOCjYRNtCVcZaDUV6Ws16TyyfPWzhVN
         5vQtVowfDZ+z4mp6bfbMBBEU03KvlrixeDc3yxvf3nU+Lj2wcekzGBEXZpc9/xd9Icxh
         Z6ypmL9ncg34FJIocbYgSc8hAQ3fkMPAHy8NJw03MMIENJBi/Iq4HA+WkfoCI0qSgkES
         k3fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HfQL+jxOCm3MHGLhfG3PCxJiFncw+wuQzTWAsPVg/Jc=;
        b=QNCqv0+3BdX1nkcaovpZlXK21SBPmeMAN/OtyjCcNuxTpub4kcjQSQJPwuRrl1renG
         //ZlYT13Bv2OIxgIfyN3QvnKgjKe6/5Fl3NbSwIXJYt4wenXUpVSkiyt0aV+mi2GQBZ8
         ZvoSKhVePXGS4EmB1oqnk7n0gLZLCOumwjQkxBAUhA+Su6x7xvbntAMFcXvcu5gm14kf
         Dh+UZbQCPGIj3ACk90oWPcdd6ysnudpoYaMblof7JYWj7beXrw1WaxJn7cN3lnXBSTNv
         816BzK1DGdnzK+gZn27clWF9y6m2oeU7UMIk7eMrgpmhU/rfghYdolUNCR/5wXU+eAmt
         giRg==
X-Gm-Message-State: AOAM533+tiF1TeM/L6mnZmW9vrOUWsKH0Slc+JxKqv+01iH9cE8fG3sM
        MEuAwY6Qf8VSPQuetqnH5XwwuYOMze8UXQ==
X-Google-Smtp-Source: ABdhPJzbkfYojMssYJSyhcU1xaRoH6Xw3gk/eQPlw/QmSvjgToo71jHPAxggdSsMKc9ZbnGEBIdjLQ==
X-Received: by 2002:a17:902:6acb:b029:fc:4d8c:cfba with SMTP id i11-20020a1709026acbb02900fc4d8ccfbamr9057745plt.29.1624101655722;
        Sat, 19 Jun 2021 04:20:55 -0700 (PDT)
Received: from [192.168.43.80] (subs32-116-206-28-57.three.co.id. [116.206.28.57])
        by smtp.gmail.com with ESMTPSA id 29sm1765120pja.45.2021.06.19.04.20.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 19 Jun 2021 04:20:55 -0700 (PDT)
Subject: Re: [PATCH] blame: fix typo in documentation
To:     Andrei Rybak <rybak.a.v@gmail.com>
Cc:     Barret Rhoden <brho@google.com>, git@vger.kernel.org
References: <20210618221104.42260-1-rybak.a.v@gmail.com>
 <8921ac50-e628-9a60-2a8d-1b8cc2a5a056@gmail.com>
 <7cbbd59b-d5e3-4b96-a1ee-a242a7839028@gmail.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Message-ID: <e0199bd4-1585-061b-5dba-7da1232d9b43@gmail.com>
Date:   Sat, 19 Jun 2021 18:20:50 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <7cbbd59b-d5e3-4b96-a1ee-a242a7839028@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 19/06/21 18.12, Andrei Rybak wrote:
> If we shouldn't refer to this patch as typofix, how about
> 
>      blame: fix name of blame.markUnblamableLines in docs
> 
> or
> 
>      blame: correct name of config option in docs
> 
> or
> 
>      config/blame.txt: correct name of blame.markUnblamableLines
> 
> ?
> 

I prefer the second, because I prefer not to reveal actual config name 
so that readers must see the whole patch to see the name.

-- 
An old man doll... just what I always wanted! - Clara
