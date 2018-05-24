Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0418F1F42D
	for <e@80x24.org>; Thu, 24 May 2018 16:28:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031435AbeEXQ2S (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 May 2018 12:28:18 -0400
Received: from mail-qt0-f176.google.com ([209.85.216.176]:37266 "EHLO
        mail-qt0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031095AbeEXQ2R (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 May 2018 12:28:17 -0400
Received: by mail-qt0-f176.google.com with SMTP id q13-v6so2813222qtp.4
        for <git@vger.kernel.org>; Thu, 24 May 2018 09:28:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=5rH1QmbMrCfsVEzKPDfKfJ47t1I37vmA1u3gYyMNQc0=;
        b=J/HTW/AOhb0vm0MnQCzQ4bj4wdm4hcWe20cHIrggh5WpBS3kx2WHZ8OV7VliWQZE7m
         OHXkPC+gMCYEFWM0tjy3vx5UlRVBiF5iKAGytJa1d+ScyG9sv0bU7Ep6MTdvgMg1xH+v
         YDL6hPXTwTd9eYjPd7gQwGtoEszml8WQ614NoxRlT5Ni3uYS9ApRATPCPuWmzDYw+PiF
         VJjvLttxDn+Mp3A9fK+l8xYeNqCiI1JABSFNMXm0ys0KqOs+p+whin+4Ve51Aroxd179
         G/tw6Si85gsvpCONKzNFlXW7Tnw1enBtYtYLnF4bYGP/Ff27x2VgFSCLUiFUwndGcVXs
         lg5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=5rH1QmbMrCfsVEzKPDfKfJ47t1I37vmA1u3gYyMNQc0=;
        b=IAHMjhQrPq8lnw66nZuEG3MYAgOuCoxGOGnyqlb3D1SEnfqBXL2TWMqx9Iuc0BCv/W
         cuhjb/4Z/Dp+dzTez+ljX5mEMbTeypgoOaRL7O2cUDl7iwMlanAFisFQnQAX5+6Apdzs
         uW7iGMmk5FIifIrOmRd8tjr818tNDonjjmprRefFRgI0Vvy/kvPf/rMa0XF2wsc35BGN
         7AhsHAE4FS/EILi16WW8KLoA+ia7/WC/aucXTBGcenjVGc9gswEZqecqmEkUDhb+tyIW
         WlF8sAxVNmQGQVtLtVEBzJoilk3z4ICqE6CnqtsHqSwxINS0ZGWxEfZwdqcxeIMblGVp
         8oAA==
X-Gm-Message-State: ALKqPwc8DXRr1WQyMGsGHvo9WTlcIxbJj3Et+laieOqGrBBBruZFsx84
        /QacwfRtF4j8tG75Y2/2noc=
X-Google-Smtp-Source: AB8JxZqlVLdJBMsKXQVYj25ypKfJsoFLdXu4O5iTxi7XPQ3e0SteDZUvEDcxm9XaK9xvtH6M3Q642A==
X-Received: by 2002:a0c:afda:: with SMTP id t26-v6mr7645513qvc.144.1527179296306;
        Thu, 24 May 2018 09:28:16 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:3c00:b45e:59c7:bb19? ([2001:4898:8010:0:2536:b45e:59c7:bb19])
        by smtp.gmail.com with ESMTPSA id m4-v6sm11113305qkf.91.2018.05.24.09.28.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 May 2018 09:28:15 -0700 (PDT)
Subject: Re: [PATCH v2 03/12] commit-graph: test that 'verify' finds
 corruption
To:     Jakub Narebski <jnareb@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
References: <20180510173345.40577-1-dstolee@microsoft.com>
 <20180511211504.79877-1-dstolee@microsoft.com>
 <20180511211504.79877-4-dstolee@microsoft.com> <86wovwdemu.fsf@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <33480b33-1baf-e822-981e-c7d4b392aeac@gmail.com>
Date:   Thu, 24 May 2018 12:28:14 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <86wovwdemu.fsf@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5/21/2018 2:53 PM, Jakub Narebski wrote:
>> +corrupt_data() {
>> +	file=$1
>> +	pos=$2
>> +	data="${3:-\0}"
>> +	printf "$data" | dd of="$file" bs=1 seek="$pos" conv=notrunc
>> +}
> First, if we do this that way (and not by adding a test helper), the use
> of this function should be, I think, protected using appropriate test
> prerequisite.  Not everyone has 'dd' tool installed, for example on
> MS Windows.

Windows does not, but it is also missing many things this test suite 
needs. 'dd' is included in the Git for Windows SDK. I rebased this 
series onto Git for Windows and the tests passed when run in an SDK shell.

Thanks,
-Stolee
