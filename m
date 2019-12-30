Return-Path: <SRS0=o5qA=2U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8186C2D0C2
	for <git@archiver.kernel.org>; Mon, 30 Dec 2019 16:13:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89C33206CB
	for <git@archiver.kernel.org>; Mon, 30 Dec 2019 16:13:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tVvP2pvH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727178AbfL3QNc (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Dec 2019 11:13:32 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44708 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726677AbfL3QNc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Dec 2019 11:13:32 -0500
Received: by mail-wr1-f66.google.com with SMTP id q10so33089161wrm.11
        for <git@vger.kernel.org>; Mon, 30 Dec 2019 08:13:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=vKXyD42CVkMA+EIy+kAhmU7xuf3KUCt535ON3mMEyUw=;
        b=tVvP2pvHYbk8WMaihea23VJ0EBf2h0VAEMQ29SxXjf/G6VRxMpO31VvzTYgbsBQRhl
         IXMW0TNeIdmAb11dUh9lny/Yq0lDvYXtXk4pJf2kVJgTu3ggWH/DMBOY4jom5RsXmdyt
         GQMgAAxVjfZ03cj/EX2yYUIPoSJLR9UENw1VpZJpRjOKGCFLZxgX4ft9eWxrXy0eKxco
         bSPeaSraYY4uZFp1BZOnSA/gTMJLHu9kFmCjj+YCW1iiZ/BSj8Y3grI1w6ymp8SPXjzW
         Ht5as8KPITin7opZiMakx+qy8aiKYNIXhJgva1vY3y/B1xZRQkjOj5YdvbGvc73DhrL9
         KK7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vKXyD42CVkMA+EIy+kAhmU7xuf3KUCt535ON3mMEyUw=;
        b=H4+pqASyD5fI33WTsM2aaExVW7p6UaArhM//GX0zcDq7ytp97ocwaW88BfFL3pkIi5
         MR+83pQnPkutBKfvXVoRenA+qx0Qv37SbM7eSW4wBGwCHdk3TxhNOOZJSTpCXBV5U5+c
         N0ioqP8jAn38+GZ3cMa3Y5HpNCQKrfsYQsDoLDmvRdoPFLQQc5kW7/ZPxzxexvRSzh4E
         Vs6HidBza3Uv/xp4m+QLXTXaSesInmL4TeiVa4GyNINM1f3TEke07OKXjM/213+8Cfgx
         fQX06CboiSuhT2NyPPKfFKAd1HpmOlN9JHQHsyXJwOIotY89LomntWA8+Xj6GveLWvjz
         3AhA==
X-Gm-Message-State: APjAAAUbJK6WtZp1JvdsPPt4zsQp8N3/FGAsz9CE1zflylhfLeruzlgV
        7QEprVPqeiMVzH7iI/4lkbT7GQhB
X-Google-Smtp-Source: APXvYqy+B2Tu9Pl34gyNbA9qzBmNBTsBbOLlPcxSLXBmNXftDLjvn6MORqcI1hEBsJGm3hAknSjQPQ==
X-Received: by 2002:adf:f789:: with SMTP id q9mr69546531wrp.103.1577722409837;
        Mon, 30 Dec 2019 08:13:29 -0800 (PST)
Received: from [192.168.0.108] ([188.173.146.22])
        by smtp.gmail.com with ESMTPSA id v3sm46895338wru.32.2019.12.30.08.13.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Dec 2019 08:13:29 -0800 (PST)
Subject: Re: Re: [PATCH 1/1] git-gui: add possibility to open currently
 selected file
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Pratyush Yadav <me@yadavpratyush.com>, git@vger.kernel.org
References: <pull.499.git.1577386915.gitgitgadget@gmail.com>
 <fce80f1b95f83915076640ca0be01aa473744777.1577386915.git.gitgitgadget@gmail.com>
 <20191227193418.36uzeizs37nv7ywb@yadavpratyush.com>
 <xmqqy2uxiemt.fsf@gitster-ct.c.googlers.com>
 <ee041086-3579-190d-e607-1973bcc94c23@gmail.com>
 <xmqqh81iiv18.fsf@gitster-ct.c.googlers.com>
From:   =?UTF-8?Q?Zoli_Szab=c3=b3?= <zoli.szabo@gmail.com>
Message-ID: <090d6c63-ccc0-e83b-3673-1bbe29c5991c@gmail.com>
Date:   Mon, 30 Dec 2019 18:13:33 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <xmqqh81iiv18.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Adapted the commit message once again (PATCH v3).

On 2019.12.30 01:14, Junio C Hamano wrote:
> Zoli Szabó <zoli.szabo@gmail.com> writes:
> 
>> On 2019.12.28 00:32, Junio C Hamano wrote:
>>
>>> The phrasing on the title is a bit awkward.  "add possibility to do
>>> X" is better spelled "allow doing X", no?
>>
>> Thank you, Junio, for the hint. Updated the commit message accordingly
>> (PATCH v2).
> 
> Also, do not start the body of the proposed log message with half
> sentence.  The title is supposed to be a full sentence.
> 
> 
> 
