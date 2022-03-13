Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFEF4C433EF
	for <git@archiver.kernel.org>; Sun, 13 Mar 2022 17:02:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235083AbiCMRDu (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 13 Mar 2022 13:03:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231150AbiCMRDt (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 Mar 2022 13:03:49 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3212B107D96
        for <git@vger.kernel.org>; Sun, 13 Mar 2022 10:02:42 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id gj15-20020a17090b108f00b001bef86c67c1so12406623pjb.3
        for <git@vger.kernel.org>; Sun, 13 Mar 2022 10:02:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:from:to:subject:references
         :in-reply-to:content-transfer-encoding;
        bh=rldX+PY4Tgph5gd9LKDnephVIfUHpUMme206/qWArdw=;
        b=hnvDq3Vh3RnHObvmheTCchWOTVxMnWwEEgdOjwug0Y3lFJV76U5/YS0RGNmT4dSjEb
         WuRDxRz2YbDvy/42Y5j0QSsEBQizL74LCbUdvxpoORTwUDD9rZn85MpjlRbi3A2zQ0lW
         +SJHvb5Z7YA//HWLS9hGXP/AYdhPjK1bDWxYORyp5A6lHx/JV9wq7YkxbXTAyJ5bBjrq
         mOZsFKlHkfNUMWaTw3JUEB44itK6VzKPFT0vxhdlH3BBOxMwe/JRi8qt6ZaFCaUTLOG6
         WoIYreLN3e+UL8QOkAZJAXB13B29UB1tZ0KMg/zJS20bVOoHg9k1Tljf6OnRqVJ0izB/
         csqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from:to
         :subject:references:in-reply-to:content-transfer-encoding;
        bh=rldX+PY4Tgph5gd9LKDnephVIfUHpUMme206/qWArdw=;
        b=lByE46X+O5SaGY0oU5GyuoxY77f665u722EW1Wht8k6uGubOvxuDkoWS68HGw+TXbT
         +NYrbe8/nQWgmES18cguKgEA668YiuQaOoX6+eIhyfOSKl29PFGY29uGJA/Hk0Pj8Dco
         Qr7g4fz1ekTXyK1r/Pw2l+wSJD9QPRBsdOXyYN7lclJcDpxWO9agdHoo0WoEzW/jay79
         lgaj0gayQpDKzgkDLL4mgt/hANt2nmclUFH9ua5f3AE6AEIv0tTPkq7pCFKZ+kNsCGib
         q8lWyNwNGf+tF1AMtQq7Gj5hbYwQLdjxU1jCKnFkwbhtrNs0X7yu9o+O8O3axYyD+ZuM
         mLvw==
X-Gm-Message-State: AOAM533GmdQ70ZjDEBScc1FRLKU+bnCmwbGNrlc1WwfsH5NsWGtH/ziq
        b1rv1jzGXVC3VbkniW3tJBHVqjHDmUM6C8Zk
X-Google-Smtp-Source: ABdhPJy+Z3D5W1rATnLKykjA/PYLLg3rCMy/T5krJSKxvX5rYvFWWGeRLmurBKHnFDV6iCGeVgYeSA==
X-Received: by 2002:a17:90b:1652:b0:1bf:32e9:6db3 with SMTP id il18-20020a17090b165200b001bf32e96db3mr21238133pjb.179.1647190961705;
        Sun, 13 Mar 2022 10:02:41 -0700 (PDT)
Received: from ?IPV6:2405:201:a800:4df9:6560:dadc:f905:6d19? ([2405:201:a800:4df9:6560:dadc:f905:6d19])
        by smtp.gmail.com with ESMTPSA id j8-20020a056a00174800b004f6f3bfd054sm18243737pfc.94.2022.03.13.10.02.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 13 Mar 2022 10:02:41 -0700 (PDT)
Message-ID: <634b6049-7b06-876d-499f-7aa5880a47f4@gmail.com>
Date:   Sun, 13 Mar 2022 22:32:36 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
From:   jaydeepjd.8914@gmail.com
To:     Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v7] userdiff: add builtin diff driver for kotlin language.
References: <20220301070226.2477769-1-jaydeepjd.8914@gmail.com>
 <20220312044832.718356-1-jaydeepjd.8914@gmail.com>
 <1f10cfa1-83b8-49b1-f4df-829cada788bd@kdbg.org>
In-Reply-To: <1f10cfa1-83b8-49b1-f4df-829cada788bd@kdbg.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 3/12/22 2:29 PM, Johannes Sixt <j6t@kdbg.org> wrote:
> Am 12.03.22 um 05:48 schrieb Jaydeep P Das:
> > The xfuncname pattern finds func/class declarations
> > in diffs to display as a hunk header. The word_regex
> > pattern finds individual tokens in Kotlin code to generate
> > appropriate diffs.
> >
> > This patch adds xfuncname regex and word_regex for Kotlin
> > language.
> >
> > Signed-off-by: Jaydeep P Das <jaydeepjd.8914@gmail.com>
> 
> This round looks good. Thank you for your perseverance.
> 
> Acked-by: Johannes Sixt <j6t@kdbg.org>


Thanks. Should I CC Junio or will it be here for some more reviews?
