Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.8 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DD5A41F462
	for <e@80x24.org>; Mon, 20 May 2019 20:34:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726715AbfETUe0 (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 May 2019 16:34:26 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:34984 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726207AbfETUeZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 May 2019 16:34:25 -0400
Received: by mail-pf1-f194.google.com with SMTP id t87so7796516pfa.2
        for <git@vger.kernel.org>; Mon, 20 May 2019 13:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=WOMwmlTR4ixSWf0JH5+Qzg7pjQ3/bGSnz8PgT+bO6mQ=;
        b=i2OiMm6WKXsmjC4N13oL07oAzXF/r/0i21dQvEJh27i68rWjXC9qZ0keGBj/7yPLEy
         SpnsXQYwp9npouNCRHoswj5gLLBVWwJ2xHf1a8hbAMhFKv+CcReNDEl5Z6+83IU6bbt/
         WVWXS5Edgvw5lQhcKMUxYee6FGLVHQITfar5I38CHB7bSeFEVl0q6ldY7rGGyFfms9f0
         7sWjGrKUYPUnhiNHEag/57plomFgTJdEMYF+6nc6kJsOMb+ChMWpZ/KF/GAvwiOduvtH
         m6xqkl1bQDT9wNJ5OFqCeQeo1XD8IWTF7yFv8/TkMeK5AsSLK3ugE/6+goL4KpltB8aC
         gOfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WOMwmlTR4ixSWf0JH5+Qzg7pjQ3/bGSnz8PgT+bO6mQ=;
        b=ABnE1Ye1WrtoaM+YFp0UKtdrtqkknw1DJJtTVI7BhdFArhbGRSruyqrmCQRGv8IEQx
         Gp/Ia11vDa5p0GAp3eVqT76ESoCmzVciOHFrh0HkB1yz9qEnKTouuHgD+RWj4hxnCL6j
         Njw8B+3/Jwfy0Tej8JVzut2j4fXdblmfPN3yiEMudB7fia5TYVlSe0JiAWVFnXpRvWfL
         f5Mtg3HHmrUDhN18HVSBLKoUyFieRTCvWGYUx27tNIMe0jAuraM/BleDst7kfpLNVlRL
         F/bFev7LfINvNXZ6L8zBpjBwZSWEwkEq/p6urMkZkZlUQJApWbHXmnuUHMRt1Atb4dJN
         guTg==
X-Gm-Message-State: APjAAAU6g5npqwVqC8I95KdqhiLNJYClYagwICZ59r8P7hnKD64Pkc6L
        XU/ghZag8XUHB192O8f0Fbcw4g==
X-Google-Smtp-Source: APXvYqy1B8lzK4P8SHVYYODNYAl41Sa3g5wncGHZipS4SX7gS/gLnXmbAzlPlDJ51rlKaWHZkhR/1A==
X-Received: by 2002:a63:d54f:: with SMTP id v15mr36018105pgi.107.1558384465070;
        Mon, 20 May 2019 13:34:25 -0700 (PDT)
Received: from gnomeregan.cam.corp.google.com ([2620:15c:6:14:ad22:1cbb:d8fa:7d55])
        by smtp.googlemail.com with ESMTPSA id f5sm12078794pgc.7.2019.05.20.13.34.23
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 May 2019 13:34:24 -0700 (PDT)
Subject: Re: [PATCH v7 7/8 (edit)] blame: add a fingerprint heuristic to match
 ignored lines
To:     Michael Platings <michael@platin.gs>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        David Kastrup <dak@gnu.org>, Jeff King <peff@peff.net>,
        Jeff Smith <whydoubt@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?Q?Ren=c3=a9_Schar?= =?UTF-8?Q?fe?= <l.s.r@web.de>,
        Stefan Beller <stefanbeller@gmail.com>
References: <20190515214503.77162-8-brho@google.com>
 <20190516215713.100523-1-brho@google.com>
 <xmqqftpd3br1.fsf@gitster-ct.c.googlers.com>
 <CAJDYR9Qm+oQ=Lv53v_zrYaG2pW_TggD4q2ENEa7bR4z900fXyw@mail.gmail.com>
From:   Barret Rhoden <brho@google.com>
Message-ID: <d182d854-24b6-bbc4-e567-27ecbc933d69@google.com>
Date:   Mon, 20 May 2019 16:34:22 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAJDYR9Qm+oQ=Lv53v_zrYaG2pW_TggD4q2ENEa7bR4z900fXyw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi -

On 5/20/19 4:32 PM, Michael Platings wrote:
> Hi Junio,
> The SQUASH??? patches look good to me. Please squash away!
> Thanks,
> -Michael

I can squash them into the next version of the patch set too, pending 
other comments / changes.

Thanks,

Barret


