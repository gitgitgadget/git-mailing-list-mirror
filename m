Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38274C43381
	for <git@archiver.kernel.org>; Mon, 28 Dec 2020 15:20:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0419B223E8
	for <git@archiver.kernel.org>; Mon, 28 Dec 2020 15:20:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441090AbgL1PUn (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Dec 2020 10:20:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2441087AbgL1PUk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Dec 2020 10:20:40 -0500
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CEE9C061795
        for <git@vger.kernel.org>; Mon, 28 Dec 2020 07:20:00 -0800 (PST)
Received: by mail-qt1-x82b.google.com with SMTP id u21so7033580qtw.11
        for <git@vger.kernel.org>; Mon, 28 Dec 2020 07:20:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=/xYO5Rn0Kqh3ndkmjXMVK/BW75G8xxOnxh0CF6g2E3U=;
        b=DlQuC5ugaye2ZWJuTFghjZGu9Zq8nPlr28cQ37U1e+0PQcJrdys2YeokiAycycK7el
         o7mxJffyogC6e4aoCf1+PxhCjd/uFg+3PvzZQ++k+/Ji18PQ1SWizPm55uYzwYscSRF4
         GY0Vmg2X6CRvFbGZLwtjESsHl3sR1EVRaidl91+ZwHA1emwJywCBLEy2iDOY6G7wUBAs
         HWsw0OuxRi7zHBK2lHr+KURS9NQy1Hc2ILW2Jynky6TFga8AP3IBkUBhUpcsEfrYSAir
         UpOOM2CbGESzWBJnvsSfhhzGQZqp8iWQUiBDob7m6M24o60BnzbzP7i9a61EiEPItr5O
         pj1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/xYO5Rn0Kqh3ndkmjXMVK/BW75G8xxOnxh0CF6g2E3U=;
        b=aCR0KPniO0CimXArkMm/3+Z7Jqr7ZtOxGDWbIAMwmWlRXQmfMxHOWVhiQfDfo/ccvp
         sLPo8Zn57Y5lkgjkQ8JQyMfxfntFhev8zSh4YRf0l28yMyfHqPMrjwvltqH85XI8qZqg
         WqrHBt5UV/xuzjMguJ+gV6o0jf9MaCD+q7NFHT1wj0tGLCwTRBie0nP4dC1JoUC6H9BZ
         Bzp/nHY5RyTlGoP9IFQMch+Rli7J7zEkqtC+5y1JeF2zX4CzuTKOqSs1TElLdkx1qR/g
         xftrxz4H0Kd44Vj7CK7n9DXG6jPFqrbePuMjRtQT9cmkLobWQNtxrRenkfo4UkCkV/Xe
         gmFg==
X-Gm-Message-State: AOAM531gSDSoZ0z7fisqipGWXZsdobXylvtJhBfltCUqgJnDmznaF9Ll
        mtERUAjYozc+oBxePpxJt2gZsiUuIErAzA==
X-Google-Smtp-Source: ABdhPJzsYuGmBgkPd8NLNPMcTeutF3unwcafXkuSmAcBBLvD4kkBE+CwknjbrHd9twGJxpy+i7EnNA==
X-Received: by 2002:ac8:7b56:: with SMTP id m22mr45805953qtu.380.1609168799014;
        Mon, 28 Dec 2020 07:19:59 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:605d:243e:92dd:9289? ([2600:1700:e72:80a0:605d:243e:92dd:9289])
        by smtp.gmail.com with UTF8SMTPSA id j203sm23397726qke.134.2020.12.28.07.19.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Dec 2020 07:19:58 -0800 (PST)
Subject: Re: [PATCH] SubmittingPatches: tighten wording on "sign-off"
 procedure
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqqh7o6jjt1.fsf@gitster.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <e54cbb7d-eb80-519a-bedd-f4ab65e6ec24@gmail.com>
Date:   Mon, 28 Dec 2020 10:19:58 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:85.0) Gecko/20100101
 Thunderbird/85.0
MIME-Version: 1.0
In-Reply-To: <xmqqh7o6jjt1.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/28/2020 5:39 AM, Junio C Hamano wrote:
> The text says "if you can certify DCO then you add a Singed-off-by
> trailer".  But it does not say anything about people who cannot
> certify.  A natural reading may be that if you cannot certify, you
> do not add the trailer, but it shouldn't hurt to be overly explicit.

This is a good change.

Thanks,
-Stolee
