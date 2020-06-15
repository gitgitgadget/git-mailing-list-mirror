Return-Path: <SRS0=FGj8=74=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 709C3C433E0
	for <git@archiver.kernel.org>; Mon, 15 Jun 2020 10:01:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C7752068E
	for <git@archiver.kernel.org>; Mon, 15 Jun 2020 10:01:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rAksuk4y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729065AbgFOKBI (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Jun 2020 06:01:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726111AbgFOKBA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Jun 2020 06:01:00 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D44A4C061A0E
        for <git@vger.kernel.org>; Mon, 15 Jun 2020 03:00:58 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id o8so4557981wmh.4
        for <git@vger.kernel.org>; Mon, 15 Jun 2020 03:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=qqgNXyK+9u5Dqx+Y1ipmBRXDsYkk+V1FlXTEWDTo/wQ=;
        b=rAksuk4y0+aCAnrc286zoS/A/7kJ+tHRjS646CgnIzVFNqzIc3t58cbhi2fq2B0TQa
         U/IHwg5SFd08cf9yXEmHuFFPr5vulQJxl9I1+LJQuFfthMsJzSG76bJDINNABS/GayFQ
         OkbnaEp7bwNoTQ+ZKeRUMGxnIRcPFfNUbxoy5WVK3F+VAjKVqjQXcxQfL+K7TB3X4epI
         5X67VuVK0T5QOvwPU5Ll/IG8EjTp8x7Dkc7AQ2Ez+nohWBhX1EMfJzKNMFXQZ2byVjDJ
         7XXE1meuVHvve3kEgDAmiFHGmdyAMsM/U01ycLKmUwbikGgURmZra27caDFkrYZRWeT/
         ssjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qqgNXyK+9u5Dqx+Y1ipmBRXDsYkk+V1FlXTEWDTo/wQ=;
        b=DVeXEzBtze6R4ucHbMkb+4n/GLzGbmHxFTbSaAqwI8yLBns617LPi1cLNB4hmM5G3O
         ZdlKZBAVEkTU2fLPyIFyudRE4E+/fhtQlZjYbKFKG0mR36UZ5RBiaXUTrPy/yctJdjNm
         XQAAsH+a5anMY3Tw0vZ9hVCHqZbDurpWTP767iArhUftnPuYhNCIuveeR3XwZXLZrVuT
         M306w1gLjUhHwnaIolb0AFRoMQZjngN1EAi2MkjID68v4uLgH19hxU16c+REwM6AQ2W+
         Zde1Z2ZrFOG+Fu+1jOCF9U5K9zUSBROVWvgBYZCkK2CsAcJigFgknjTaOISelxAeB/WM
         CS/g==
X-Gm-Message-State: AOAM533xyuIV4bNBGMgTy7XqtWycTIiQuaEC4AuPZqJCaXay4TPRh/QF
        1B+PNrQdK8lRXAc/MRKwSq6+fCC+
X-Google-Smtp-Source: ABdhPJzcgVZDWw5RWeapi2ANi1lRfifOrybP6RjyToDPUAa/JkdsvistsN9QeFJbiQCKi0lyqvha1Q==
X-Received: by 2002:a1c:38c2:: with SMTP id f185mr12755806wma.79.1592215257628;
        Mon, 15 Jun 2020 03:00:57 -0700 (PDT)
Received: from [192.168.1.201] (226.20.198.146.dyn.plus.net. [146.198.20.226])
        by smtp.googlemail.com with ESMTPSA id k17sm23989530wrl.54.2020.06.15.03.00.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jun 2020 03:00:56 -0700 (PDT)
Subject: Re: [PATCH 1/9] init: allow overriding the default branch name for
 new repositories
To:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Don Goodman-Wilson via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, don@goodman-wilson.com, stolee@gmail.com,
        peff@peff.net, sandals@crustytoothpaste.net
References: <pull.656.git.1591823971.gitgitgadget@gmail.com>
 <90912e32da1192cfc3b39a18cb606caa46e85b1c.1591823971.git.gitgitgadget@gmail.com>
 <be09ffbb-4e38-5b67-54da-0b60d5e2d8c3@gmail.com>
 <nycvar.QRO.7.76.6.2006121308030.56@tvgsbejvaqbjf.bet>
 <xmqqlfks2pod.fsf@gitster.c.googlers.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <27936112-a29b-92d5-b506-3f88688cc5d3@gmail.com>
Date:   Mon, 15 Jun 2020 11:00:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <xmqqlfks2pod.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/06/2020 17:51, Junio C Hamano wrote:
> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
>> I added a _brief_ extension to the context to the first commit's commit
>> message. However, I do not want to go into details here because _this_
>> patch series is only about empowering users to change their default main
>> branch name.
> 
> [...]
> 
> Sufficiently large part of the user population are unhappy with the
> use of the word 'master' as the default name of the primary branch
> in a newly created repository, and the mere fact that we are aware
> of that is good enough justification to move _away_ from 'master'.
> In other words, we do not have to explain why 'master' was bad, as
> it does not have to be bad for everybody to be replaced.

This expresses what I was trying to get at with my comments much more
clearly than I managed - Thank you

> 
> But you need to defend that the new word you picked is something
> everybody is happy with.  That is much harder ;-).

Indeed, though I am more optimistic about that having seen a couple of
people have indicated that they don't mind too much what we choose so
long as it unlikely to cause future problems.

Best Wishes

Phillip


