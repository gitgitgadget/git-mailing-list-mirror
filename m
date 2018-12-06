Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E511C211B3
	for <e@80x24.org>; Thu,  6 Dec 2018 13:11:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729638AbeLFNLc (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Dec 2018 08:11:32 -0500
Received: from mail-qt1-f180.google.com ([209.85.160.180]:45282 "EHLO
        mail-qt1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729467AbeLFNLc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Dec 2018 08:11:32 -0500
Received: by mail-qt1-f180.google.com with SMTP id e5so376346qtr.12
        for <git@vger.kernel.org>; Thu, 06 Dec 2018 05:11:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding:content-language;
        bh=ofUnOmbtJk8kb0/8JrydXhIrdT+t6d0v6OCity946WY=;
        b=a3KnUbqrFI0PuoaXi424o1y7diTjFPP8OfRD5v1gk/73H2bIYdpi/36HT0YhKmXxg+
         COZxLGzvFqazkG5ZjMtaM0tWLN513j1OA/c7bNV+7a1yLYtCTqtmb0txXHSF+IIdorMl
         QeZmmUqBIFpKQ7SCU3QCm8JUYEpbxQPBXY2QHkaeJzAs9TBO1OavaamaWylatH9BbnT2
         jafZ1FfPseBba79h+z5Vdgtp+Y3lli+EMC5ZJLFoaIyAWIXEevR40uIvZDJPER2GLszy
         7xXfiEVAY/6f2ETzAIKK1wmFH5AJhhf0LS65LRhA9O1/wxycj5XNjroPNnTJ8Bk8jRMv
         BNuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=ofUnOmbtJk8kb0/8JrydXhIrdT+t6d0v6OCity946WY=;
        b=CaU10ueJvJZ4rJVtHlE2v1rhIEo+qyAqs/XF+9seckqX13ToTcpgBdo2tUVS8SzLyN
         KobFYibe5M4u+k4GKGhTwX9Le1GUN0riqft30kJbkkhzyK4vEdOog6INoVWJwK6/S6jn
         eHWsubyoWL7xOFKOop5nBNmwfERmoQyP1cnFuONiT6DtE6n32hwSEnycSQGVh80gx4C3
         z5lXoBZ9m+yDnyVXgk3CBGPuq8MjGNEfdaCGf6UCOXa44lj9XabBtRFeneyxXfV+G+07
         s/25HTohkBAYSVpXhCD4eUayw+5niqZmt8sKP5U2VB/ucST72KJ0Pix7EOdEY7Eddw1O
         JpcQ==
X-Gm-Message-State: AA+aEWZhchynufZi6wdARwLRfExjKxmRKbvgCz5zAl8CQ46Zet+72FUM
        wzOu+RQUgy2irR+ZgV3l8RxSLkYy
X-Google-Smtp-Source: AFSGD/WtndDiF8B5zAM4gwSrHpRQf/OmOZMSKsEvjzMhwHtgNVAVCvheaXRlk1GqMOUG3jkDZdT6Kw==
X-Received: by 2002:ac8:2487:: with SMTP id s7mr26776306qts.116.1544101891009;
        Thu, 06 Dec 2018 05:11:31 -0800 (PST)
Received: from ?IPv6:2001:4898:6808:13e:c80a:7b9f:f8e3:ff4d? ([2001:4898:8010:0:b140:7b9f:f8e3:ff4d])
        by smtp.gmail.com with ESMTPSA id x127sm361187qkx.43.2018.12.06.05.11.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Dec 2018 05:11:30 -0800 (PST)
Subject: Re: [PATCH 2/2] commit-graph: fix buffer read-overflow
To:     Josh Steadmon <steadmon@google.com>, git@vger.kernel.org
References: <cover.1544048946.git.steadmon@google.com>
 <ad2e761f4438ac80e947be0f6831fb6467eb4396.1544048946.git.steadmon@google.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <077fed80-8d8c-1ed9-b2b6-18b86887482f@gmail.com>
Date:   Thu, 6 Dec 2018 08:11:28 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:64.0) Gecko/20100101
 Thunderbird/64.0
MIME-Version: 1.0
In-Reply-To: <ad2e761f4438ac80e947be0f6831fb6467eb4396.1544048946.git.steadmon@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/5/2018 5:32 PM, Josh Steadmon wrote:
>   
> +		if (chunk_lookup + GRAPH_CHUNKLOOKUP_WIDTH > data + graph_size) {
> +			error(_("chunk lookup table entry missing; graph file may be incomplete"));
> +			free(graph);
> +			return NULL;
> +		}

Something I forgot earlier: there are several tests in 
t5318-commit-graph.sh that use 'git commit-graph verify' to ensure we 
hit these error conditions on a corrupted commit-graph file. Could you 
try adding a test there that looks for this error message?

Thanks,
-Stolee
