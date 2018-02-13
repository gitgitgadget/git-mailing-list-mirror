Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A3F1C1F404
	for <e@80x24.org>; Tue, 13 Feb 2018 18:52:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965589AbeBMSwn (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Feb 2018 13:52:43 -0500
Received: from mail-qk0-f178.google.com ([209.85.220.178]:35521 "EHLO
        mail-qk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965479AbeBMSwk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Feb 2018 13:52:40 -0500
Received: by mail-qk0-f178.google.com with SMTP id c4so21372309qkm.2
        for <git@vger.kernel.org>; Tue, 13 Feb 2018 10:52:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=ejRauAaM/hAfwxrS9wqB+YEFgY06Kvzik0H4/8zmgh4=;
        b=UEO8g8xBpB/s48jfXPUG6ehddDKiVsWmVKuKfaDGc4RR7VzTgGDsDVmM4GwkyPGM2Z
         ro4yXCWc8tKcb2V/+HOaYgesbLtuIgGAzxvujj3QGMQPC64pSvwNNT2C5JAEpawVa8ww
         PK1oADZHJSMF5wxF+DhiVRTQrdnM4zSAs0v9iF/xhlwrqwy+Vh2oQPtMDbJmvUu9itdI
         7vDz8+V81AHgcsPoYB5UYHlBm63UfI6PCWof9j34Eam//tXo++SLIiycsmaHBZwwgXQr
         92hb2ctK7oOkxrS8JJIx20kQ54empxod9KTPD+70NlJQ1hvdbFhXwgrr8d5kChAWdBxD
         pDiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=ejRauAaM/hAfwxrS9wqB+YEFgY06Kvzik0H4/8zmgh4=;
        b=eieSoc3PkULPyrDuXw+RLBxfQvP0mLvpEjVcdZrvPVo2aTEPekgC1OWGk3cfhUr+MC
         x0NYOA7oARPsMYEou/Te8EiFhst3xQFz0wYwLMNrIjna15HhWzIrLX7EG4B+jI05KvVF
         9QGSK2jf8tA+MbQQCws85a4f64RsTfBbayMUVfkcEtBKlNU/T7gCWG7t50LGyCmFJCN8
         4WatSuUKKz/w6cTo3BAgoPYS4yPNOw2WSXIxloVHoAMB/p+JugnT2MdzyohRcJQCZKXD
         deTrRGDOvfQw54kRVI2gHy/5fx2u4gHwVT8GVc3zIHOoxlMiW+33mm6W0lJGsZKyB0JI
         oPJQ==
X-Gm-Message-State: APf1xPB74zDYoFXLLf+ljov5v7VMS1pALCKOVGbB9p56qSfk6waLRwPT
        zQ+uLf1qnHDzjhEQvm08MGI=
X-Google-Smtp-Source: AH8x22623j2BH158lJINSosHcJgDtfzyw8Wmj6oam9PYsKjybtv66Ur5tHgzqZ5PLFmzHnTyTfoDCw==
X-Received: by 10.55.16.196 with SMTP id 65mr3540046qkq.110.1518547959441;
        Tue, 13 Feb 2018 10:52:39 -0800 (PST)
Received: from ?IPv6:2001:4898:6808:13e:c4e6:7a22:56f1:df04? ([2001:4898:8010:0:ae1c:7a22:56f1:df04])
        by smtp.gmail.com with ESMTPSA id 23sm8365181qtx.33.2018.02.13.10.52.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Feb 2018 10:52:38 -0800 (PST)
Subject: Re: [PATCH v2 0/2] Refactor hash search with fanout table
To:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
Cc:     l.s.r@web.de
References: <cover.1517609773.git.jonathantanmy@google.com>
 <cover.1518546891.git.jonathantanmy@google.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <4750f163-541b-81bb-aed1-4ddfe7657ade@gmail.com>
Date:   Tue, 13 Feb 2018 13:52:37 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <cover.1518546891.git.jonathantanmy@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2/13/2018 1:39 PM, Jonathan Tan wrote:
> Updates from v1:
>   - use uint32_t so that we can operate on packfiles of up to 4G objects
>     (this also means that I had to change the signature of the function)

I take it "4G objects" means "4 billion objects". The distinction is 
only important that the limit is not a 4GB IDX file, but in fact a large 
enough object count that the IDX file can be 100+ GB.

>   - don't hide types
>
> Derrick: you'll need to slightly change your patch to use the new API.
> As for find_abbrev_len_for_pack(), that's a good idea - I didn't do it
> in this set but it definitely should be done.

Thanks. I'll try to remember to do that change when this lands in 
master. I'll bring the new prototype into my commit-graph patch.

Reviewed-By: Derrick Stolee <dstolee@microsoft.com>
