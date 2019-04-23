Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.8 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1E2931F5CB
	for <e@80x24.org>; Tue, 23 Apr 2019 14:23:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727745AbfDWOXt (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Apr 2019 10:23:49 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:37501 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727690AbfDWOXt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Apr 2019 10:23:49 -0400
Received: by mail-pf1-f194.google.com with SMTP id 8so7584165pfr.4
        for <git@vger.kernel.org>; Tue, 23 Apr 2019 07:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=81bwgG3B1KZYQXuS1xtvsQf0zWyWMBXK3EljHy5W800=;
        b=Luw8T606TYHsTHzsnIbqbCQhGaoSWs9nDpzVITltI5xkYXy7DjzisvTGraLmCmIki1
         KlFT1kE5W8Y0adv3sdb+ChnXA3YvA6Y9WpKa1lHLizPhoRRz+uVSlAcgVZ8YC0w16PPp
         sSsmJwCvd50S+xpsgEI7+z5lnjdQR4eHnCiw6on8QP7GEc7j39QFoE7iMdvnXK4aqYN2
         CVdEvHIEQNavSGvuz+AaKE3UnLsAza0Re4xR6Sb+r09ohbgwdYKct/7wxuVxawvB0bKr
         DsRxOKHv6UxNNkm1ONKZUPqCwv2sKN8HgsnghCkROfn5p5vI7Z9tudDE9xiQJRKU9FKk
         sPHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=81bwgG3B1KZYQXuS1xtvsQf0zWyWMBXK3EljHy5W800=;
        b=dlZzQ9Wn2w+wabwLcHGPBxy5V5k5bxrpq0sFaQ1+XF0FHPAB/IrE72LoJeLar4WInJ
         h9D2JY213XcNgzOoQJrbA7AjgXNeD//WtG2TH5KSulVR+rDm4ArkMVdWrdwb/ZNCQ9eW
         0VGwtuPQU1jnUXcRzrniQAvUsZTOx3WzpAZtqcf6e3f/EHKex7yy5K/x0YVLMnQUbjWG
         sHsF+vBQcS2bLPVmFl1yy5o6OvM5mFKOZJEVgcnuSGXA+8umbaySukUszYNts9PCZf75
         0HD00Mb3ezMWHcBK5KSnGPxajSrBnEuEk80NtqbFJyyYNdq9FiAC7A/k6baKoKqCQWJZ
         ENow==
X-Gm-Message-State: APjAAAWH+BkIpywWeyAOCJ7rhx5NS4qz8ZEW4OJsD+iolI72dRV9NnuD
        Wrlq4DjNV0l1wyqpRQWYq/S8lQ==
X-Google-Smtp-Source: APXvYqx8Er58QLdmVQ7//DPnTcmoA34Sm9YsY1nvk0WZ7a0IItq6OR5ys+79PpyXd/LrpQ4/Amjbbg==
X-Received: by 2002:a63:6983:: with SMTP id e125mr23330389pgc.370.1556029427958;
        Tue, 23 Apr 2019 07:23:47 -0700 (PDT)
Received: from gnomeregan.cam.corp.google.com ([2620:15c:6:14:ad22:1cbb:d8fa:7d55])
        by smtp.googlemail.com with ESMTPSA id c25sm24105059pfo.69.2019.04.23.07.23.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Apr 2019 07:23:46 -0700 (PDT)
Subject: Re: [PATCH v6 0/6] blame: add the ability to ignore commits
To:     michael@platin.gs, git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Stefan Beller <stefanbeller@gmail.com>,
        Jeff Smith <whydoubt@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        David Kastrup <dak@gnu.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <[PATCH v6 0/6] blame: add the ability to ignore commits>
 <20190422222647.48628-1-michael@platin.gs>
From:   Barret Rhoden <brho@google.com>
Message-ID: <cc1466bc-0610-784b-e57b-8612c2e8569f@google.com>
Date:   Tue, 23 Apr 2019 10:23:44 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190422222647.48628-1-michael@platin.gs>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/22/19 6:26 PM, michael@platin.gs wrote:
> From: Michael Platings <michael@platin.gs>
> 
> Hi Barret,
> 
> This patch is on top of your patch v6 4/6.

Thanks, I'll take a look.  I was working on taking your old version and 
integrating it with my v6 6/6.  That way it gets the 
origin-fingerprint-filling code and can be easily compared to my 6/6 style.

[snip]

> 
> To address reordered lines I suggest a combination of this algorithm and your
> algorithm - in the first path my algorithm tries to match lines within a
> single chunk, and in the second pass your algorithm tries to find matches for
> unblamed lines out of order and outside their chunk.

I was thinking something similar.  Yesterday I did this with your older 
patch set - applied on my 6/6.  Two passes, one with your fuzzy matcher, 
then if we didn't find anything, do a scan of the entire parent (as my 
6/6 does now).

This approached worked for the cases I had (e.g. "header reordering"). 
I ran into an issue last night where your scan was finding matches where 
it shouldn't - might have been an issue with how I hooked it up.  I'll 
try your latest code and see how it goes.

Thanks,

Barret

