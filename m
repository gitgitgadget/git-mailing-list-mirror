Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	DATE_IN_PAST_12_24,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7246E1F453
	for <e@80x24.org>; Thu, 20 Sep 2018 12:52:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387797AbeITSgM (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Sep 2018 14:36:12 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:39197 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387655AbeITSgM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Sep 2018 14:36:12 -0400
Received: by mail-qk1-f193.google.com with SMTP id b19-v6so4901961qkc.6
        for <git@vger.kernel.org>; Thu, 20 Sep 2018 05:52:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=49Gadvow9ujH+8qfkNyVjv7vnomM7OZa7oraXqKvbvA=;
        b=o7STvONt29d/R7Yt2qm62fkPLLuvBG3s89vnGSXQkJJ7HIUpquQEe1BE8RH7FZG5DZ
         G0bl2EfvF4pTekzm0RZzpT+ZvOCvpcitNlO8otc2GtCtFchgXGkDsVH8YzlqqsHAvu8P
         dwcLfz38e6mq0GMldrOTol8awkyPlmFm4latr8sWHy2A03xPWJBmEKZK/V7YuwO29DP1
         OfpAYSSYmlY+m7AFbuac9clsP7IBTOACMi1MM+TWVIzakv+h77qa5Q2Tz3aCDd8q6pv1
         lmxsobdAqTy3F2ZKU5VDDuOaef/ZQ1KnIM0jmJPeefYxttUcYy+KyJ89RbSU2Uubxqur
         H+7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=49Gadvow9ujH+8qfkNyVjv7vnomM7OZa7oraXqKvbvA=;
        b=L3pQuXNrQOrYU528lEGWbwhcqDpnCKzrhw7zOau5iO5yQbk+b0af2mRB3tmEqH5OdU
         JEQyKv4ST/VWKvetJBzPDDTHGUOYjWAGBY3iW+iC9buK56teMAvi89DZOl9oqbJOgVr7
         vDVDQlxDknsaagP4WnUC3dJvbYvxbMis+/PHaBRvOL4uV10Jak1f7JmD8lcJzB+w64UQ
         mALcq1DjEhqNC4UcS0v8oRy859BG0znaLiXfEj+1fzxb/fHON0pPe1n1OtEkzatujEuF
         N6mSV705JPVFJRU9fVPAVUu67Yb9rgMDktfVsVOAG25JsXttVgHQlOb9V8EWf9VthsUG
         v1PQ==
X-Gm-Message-State: APzg51CH69UQy1vhzjFf1lktkEXQCb+d3JLAMtxwOLcN8xxepBZpVnuT
        4TNl2YS7ICMprSWH5+s3FWk=
X-Google-Smtp-Source: ANB0VdaejISdtGz99lj4KAgP5CB72IZLgB47OVb5KfWCnubenmxG6U0JZ0wTNs85ROjBmbFXmCZfZw==
X-Received: by 2002:a37:b001:: with SMTP id z1-v6mr27579901qke.156.1537447969600;
        Thu, 20 Sep 2018 05:52:49 -0700 (PDT)
Received: from [10.0.1.17] ([98.122.163.216])
        by smtp.gmail.com with ESMTPSA id 1-v6sm4880736qkx.66.2018.09.20.05.52.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Sep 2018 05:52:48 -0700 (PDT)
Subject: Re: [PATCH] gc: fix regression in 7b0f229222 impacting --quiet
To:     =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
References: <20180919210138.31940-1-avarab@gmail.com>
 <CAN0heSr=upqAVzjm=gQoGVnOjBZcDWhmj3W8gFFa8bcfCgaHTg@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <0189570e-2b64-5933-8d60-f5186eb063b1@gmail.com>
Date:   Wed, 19 Sep 2018 19:22:24 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <CAN0heSr=upqAVzjm=gQoGVnOjBZcDWhmj3W8gFFa8bcfCgaHTg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/19/2018 5:21 PM, Martin Ågren wrote:
> On Wed, 19 Sep 2018 at 23:04, Ævar Arnfjörð Bjarmason <avarab@gmail.com> wrote:
>> Fix a regression in my recent 7b0f229222 ("commit-graph write: add
>> progress output", 2018-09-17), the newly added progress output for
>> "commit-graph write" didn't check the --quiet option.
Thanks for fixing this issue. Sorry I missed it in review.

I looked through the patch and didn't find anything more than Martin 
already did. I appreciate the tests.

Thanks,
-Stolee

