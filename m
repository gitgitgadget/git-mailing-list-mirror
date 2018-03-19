Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F3D581F404
	for <e@80x24.org>; Mon, 19 Mar 2018 13:12:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755458AbeCSNMv (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Mar 2018 09:12:51 -0400
Received: from mail-qk0-f179.google.com ([209.85.220.179]:40077 "EHLO
        mail-qk0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754996AbeCSNMu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Mar 2018 09:12:50 -0400
Received: by mail-qk0-f179.google.com with SMTP id o64so2492614qkl.7
        for <git@vger.kernel.org>; Mon, 19 Mar 2018 06:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=bOlS6BHPzHwcItdFsVV5dSubM2gLU6DHE0At+GKZKso=;
        b=VcLSpsIfeJWk7m7s8tUSrwgbKiPMXfv3r0Z7MYlQ6CqtiYgDWugRiMQ46v6Zh4C57c
         buyVnWPAo7lxVQ2YxJfoTDG6U5tipcKyIHI1xfoB1WTEjN3P6czaZez9qyIRhJExVCne
         GUWlNK1/VzMrft4EHHP1REogJci6kyTaF6FdsGjZl4KD2uemUtLG8wvC3lux65mUk5WZ
         TB/6TipmQi6Y4lhWiBwIDWnl646nhftw0lSFmjMDQEgTWHqEwx/fx2p6pRxrmSuQC9rO
         WONMBKOPNbN5J2iXEWO9rXL4W7C5RbBUMfoAmbx66YBoNrMqi4BSKSaXTldJr8BNq4+9
         fsrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=bOlS6BHPzHwcItdFsVV5dSubM2gLU6DHE0At+GKZKso=;
        b=o864ID7S4H+T6eojnznRLSl5YUOy/yCIy0ZEV/YfbmnNC/unwWBmL3YtrmpDSNRBM6
         GOVB2Yimhv5yfdQmn47KKQ7pFCb8rywYyMZPoCEx8giYf7r9E+0WMFwE8lRpjHlFZGM4
         AZMUvvTwfaDNl07m9GPSzgxxaZPnfCCWbnAaPgrXh3VlxYCofv4QlcDf8kRJGR6L0M5p
         q54opCVNLbl2SUOENi9jFDzNPizNCW0zGws1bBoyT+z2W2VojnZR9Zhgot1ZHqWJa/hR
         goCQCmBBf5O9+C3mWD+ZKHcx2ZvOl11l1ve3kiYUcBA42rVZX4zvWQprT/D4AOpXNtZl
         aPfA==
X-Gm-Message-State: AElRT7EcEBFkfmV9iGZjgiQYzLg+ZKjSH+8jiIHn57sTEBXfNVfXRznx
        qRN5ZAxbAfCo1pGwCe9tMLEXNOwfgMo=
X-Google-Smtp-Source: AG47ELvyv2mtZ5+0tZr1SDI8PGvH4Uz3iw7N+0olcuDCC2SElnAVIW3KCEBuLXPx+LgavCgU3CvsDw==
X-Received: by 10.55.246.26 with SMTP id y26mr17589442qkj.127.1521465170054;
        Mon, 19 Mar 2018 06:12:50 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:c4e6:7a22:56f1:df04? ([2001:4898:8010:0:ae1c:7a22:56f1:df04])
        by smtp.gmail.com with ESMTPSA id n58sm2823qta.34.2018.03.19.06.12.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Mar 2018 06:12:49 -0700 (PDT)
Subject: Re: [PATCH v6 07/14] commit-graph: implement 'git-commit-graph write'
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
        sbeller@google.com, szeder.dev@gmail.com,
        ramsay@ramsayjones.plus.com, git@jeffhostetler.com,
        Derrick Stolee <dstolee@microsoft.com>
References: <1519698787-190494-1-git-send-email-dstolee@microsoft.com>
 <20180314192736.70602-1-dstolee@microsoft.com>
 <20180314192736.70602-8-dstolee@microsoft.com>
 <87bmflcy8a.fsf@evledraar.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <5e394b91-fa78-5b70-8c5e-b06cc332bb3a@gmail.com>
Date:   Mon, 19 Mar 2018 09:12:48 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <87bmflcy8a.fsf@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/18/2018 9:25 AM, Ævar Arnfjörð Bjarmason wrote:
> On Wed, Mar 14 2018, Derrick Stolee jotted:
>
>> +'git commit-graph write' <options> [--object-dir <dir>]
>> +
>> +
>> +DESCRIPTION
>> +-----------
>> +
>> +Manage the serialized commit graph file.
>> +
>> +
>> +OPTIONS
>> +-------
>> +--object-dir::
>> +	Use given directory for the location of packfiles and commit graph
>> +	file. The commit graph file is expected to be at <dir>/info/commit-graph
>> +	and the packfiles are expected to be in <dir>/pack.
> Maybe this was covered in a previous round, this series is a little hard
> to follow since each version isn't In-Reply-To the version before it,
> but why is this option needed, i.e. why would you do:
>
>      git commit-graph write --object-dir=/some/path/.git/objects
>
> As opposed to just pigging-backing on what we already have with both of:
>
>      git --git-dir=/some/path/.git commit-graph write
>      git -C /some/path commit-graph write
>
> Is there some use-case where you have *just* the objects dir and not the
> rest of the .git folder?

Yes, such as an alternate. If I remember correctly, alternates only need 
the objects directory.

In the GVFS case, we place prefetch packfiles in an alternate so there 
is only one copy of the "remote objects" per drive. The commit graph 
will be stored in that alternate.

Thanks,
-Stolee
