Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 20F031F62E
	for <e@80x24.org>; Tue, 15 Jan 2019 18:29:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730976AbfAOS3F (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Jan 2019 13:29:05 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:51188 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728336AbfAOS3E (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Jan 2019 13:29:04 -0500
Received: by mail-wm1-f66.google.com with SMTP id n190so4377839wmd.0
        for <git@vger.kernel.org>; Tue, 15 Jan 2019 10:29:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=Ui3s3khKki0iCuOx8U7nqVoXzMGCHFdF/zF5RV1APFw=;
        b=HAO1zWN5tErth55KMILd+S8bj675/YTT+x5nxJ62JrSIiCHlko2zO1y/1xLt6Hu9Z0
         Bk4f0rh4fdfZpvEG+HqnolrwJDnCB8raEMJcahmmqmEWvJHEsNkvJek1+t9sJloTJWMl
         P4WxhGsxFb6wzrbRVpENkvPU05kgYhGhOqSjrgTf2pPzk22Help6MpKsypMCH4VeiRq9
         uBUrXxpP143eHOgH1lqttaicd8xqM28qhpaIwwZ4iJmCi5+BUE1+RUPrBq5wcOtxBvav
         7c+sPhkuoCqu/S4f9uWO/aGyh6+ksot56rusjWYmUFFuYDIN1o6XasIYFTCpNEpVmS2J
         H1zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=Ui3s3khKki0iCuOx8U7nqVoXzMGCHFdF/zF5RV1APFw=;
        b=H+na7SMjg3gvMbRLdVnrMwdScCs6Spj3SArBT8LzKG/mFzOhScwR3NTMojyK3iHEVw
         Lcw4xWkiom5gC6cvPsgdLlVZ2wnQfiv5Xj4gOrTJg8dmkAau243HRp6+WEZLxjvSzhzd
         YHRW/ViCtVLgIU9+m1gTTndz+vwr0/VPYyb/umhO+Ma15hH6BE/4WWV3r00IcblqZ/A9
         IerhUopzWz3X0zayE4TFGMRNYhYB3jPhu+AERRTxkkyT8AmGi1iBo8okG0b4E910bvZV
         MvNO2hA7nIQ4kWlAaqa7IWRm3B7VelWKDNFj7OuzwUVPNYVpF2CNPMJ3Ilc1oCTsyHUy
         W69g==
X-Gm-Message-State: AJcUukdolinySEeJiO1YqxjM1CJRNUTPb0hmj4LM28Yn2Nd4EHxxybZt
        ft6VToaDZp5/UAD20qtS3EmKbEkN
X-Google-Smtp-Source: ALg8bN7gJXwKwKPuG8qUl7BhAkhKgPYufcAhUFh1061MKVwNOwh/Y5TRgNXq5xwwk0xyqRtrz9M6wg==
X-Received: by 2002:a1c:4e08:: with SMTP id g8mr4339605wmh.46.1547576942745;
        Tue, 15 Jan 2019 10:29:02 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id f130sm31016273wme.41.2019.01.15.10.29.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 15 Jan 2019 10:29:01 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        GIT Mailing-list <git@vger.kernel.org>
Subject: Re: [PATCH] revision.c: fix sparse warnings (sparse algorithm)
References: <0f69cce6-a0a0-8972-93dd-5c1aa428f508@ramsayjones.plus.com>
        <a0ace9a0-65f9-ad2e-26f8-b46e3ef0153e@gmail.com>
Date:   Tue, 15 Jan 2019 10:29:01 -0800
In-Reply-To: <a0ace9a0-65f9-ad2e-26f8-b46e3ef0153e@gmail.com> (Derrick
        Stolee's message of "Tue, 15 Jan 2019 09:42:36 -0500")
Message-ID: <xmqqzhs1srki.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

> On 1/13/2019 3:55 PM, Ramsay Jones wrote:
>> Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
>> ---
>>
>> Hi Derrick,
>>
>> If you need to re-roll your 'ds/push-sparse-tree-walk' branch, could
>> you please squash this into the relevant patch [commit 9949aaeef4
>> ("revision: implement sparse algorithm", 2018-12-14)].
>>
>> This commit caused both 'sparse' and my 'static-check.pl' script to
>> complain about the visibility of the 'map_flags' variable (it is a
>> file local variable), so one solution would be to mark it 'static'.
>> However, it is simply not being used, so ...
>>
>> Thanks!
>>
>> ATB,
>> Ramsay Jones
>
> Thanks, Ramsay! I'm rerolling the series today, so I will make this change.
>
> -Stolee

Thanks, both.
