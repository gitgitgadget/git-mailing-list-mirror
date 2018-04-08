Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6C16E1F404
	for <e@80x24.org>; Sun,  8 Apr 2018 01:06:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751735AbeDHBG3 (ORCPT <rfc822;e@80x24.org>);
        Sat, 7 Apr 2018 21:06:29 -0400
Received: from mail-qk0-f181.google.com ([209.85.220.181]:45574 "EHLO
        mail-qk0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751387AbeDHBG2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 Apr 2018 21:06:28 -0400
Received: by mail-qk0-f181.google.com with SMTP id s9so5432016qke.12
        for <git@vger.kernel.org>; Sat, 07 Apr 2018 18:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=JdNvQrk0ohQsd6mEu5k8ZN8g5pb7j+xegJkLh3GSdsk=;
        b=KhglpUEXHJu8XPMXiv7sXGblL3psCfr45ak5DTXO+dusKuMVVcHXJYjXPYjw2Qe+1L
         okMS8w30WC+ODVuysdXaUlfuBkeevszeInL0M+hNMg1rYoyXTPDp7CClXaS4XdHHSn/u
         2+so5fVb7eLg2LfDIcq+O/3QM1nTMxpr+jKGiNJRybT7569QsoJRrjFwsVrplu+E0ZsA
         G5Ypn8Z6cy17AP2VveFsrMZP7yxEORSw56wnYIHH3I7BSGNJkl5/J4eY4qkLdSEyRQSq
         ycUBsSdBEryFsWEDJ6ytOrVAylBOve5IJHpP8uGrVX3+tyDLtHiN5kDbog/0UBRTzRTn
         zXNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=JdNvQrk0ohQsd6mEu5k8ZN8g5pb7j+xegJkLh3GSdsk=;
        b=QelNmPbyIkis9TaM0TYjAYOCSifGyBUveIUG3/dndbaqVsxtvmpDRxEK+Yx7/Q4FXR
         CuvQ1VgL8TjoJkZfSx3RftNMlDIdw936Njvzuh9MzKOZRCbrFI0Zz1OBiUEitImxFo1n
         fEJoQpJKj/g5bejUJwf9eJIVpPkyfGsora5EiqwMUNEpUgmlVtk0EYUChoX8c35FYuBF
         /O2IQThJx1EQaCiyhh7FRCEHWH86mlUy8tibo1392+SEwTzZ7S7uPnzRRhRUthjdxTHD
         39Kuz3Uvd4jNv4wfU+ZRTNZEVRP4Nb4q0y7hGOYKA7QXjTKAzMidYjaIibYdiIyxIxUH
         Hmgw==
X-Gm-Message-State: ALQs6tC2eabMNGbSSOKtcjnYFF7oU75z/yRNhdg6UZQdRHhtVK39Dz0k
        t1EXsCjx++3j5Nm+TEHMTCw=
X-Google-Smtp-Source: AIpwx4++cjtcQdatQzOBW/rMAQERNg32aX/vJw821tc7cdW08WraX23mXKtX64gHDSkeLq+1WA33xQ==
X-Received: by 10.55.217.70 with SMTP id u67mr22820271qki.294.1523149587969;
        Sat, 07 Apr 2018 18:06:27 -0700 (PDT)
Received: from [172.22.150.178] ([98.122.163.216])
        by smtp.gmail.com with ESMTPSA id f2sm3831324qtp.81.2018.04.07.18.06.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 07 Apr 2018 18:06:27 -0700 (PDT)
Subject: Re: [PATCH 0/6] Compute and consume generation numbers
To:     Jakub Narebski <jnareb@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Jeff King <peff@peff.net>
References: <20180403165143.80661-1-dstolee@microsoft.com>
 <867epjez1n.fsf@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <07abd2ce-e042-fe3c-b2db-3d2f2aa44de8@gmail.com>
Date:   Sat, 7 Apr 2018 21:06:24 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <867epjez1n.fsf@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/7/2018 12:55 PM, Jakub Narebski wrote:
> Currently I am at the stage of reproducing results in FELINE paper:
> "Reachability Queries in Very Large Graphs: A Fast Refined Online Search
> Approach" by Renê R. Veloso, Loïc Cerf, Wagner Meira Jr and Mohammed
> J. Zaki (2014).  This paper is available in the PDF form at
> https://openproceedings.org/EDBT/2014/paper_166.pdf
>
> The Jupyter Notebook (which runs on Google cloud, but can be also run
> locally) uses Python kernel, NetworkX librabry for graph manipulation,
> and matplotlib (via NetworkX) for display.
>
> Available at:
> https://colab.research.google.com/drive/1V-U7_slu5Z3s5iEEMFKhLXtaxSu5xyzg
> https://drive.google.com/file/d/1V-U7_slu5Z3s5iEEMFKhLXtaxSu5xyzg/view?usp=sharing
>
> I hope that could be of help, or at least interesting

Let me know when you can give numbers (either raw performance or # of 
commits walked) for real-world Git commit graphs. The Linux repo is a 
good example to use for benchmarking, but I also use the Kotlin repo 
sometimes as it has over a million objects and over 250K commits.

Of course, the only important statistic at the end of the day is the 
end-to-end time of a 'git ...' command. Your investigations should 
inform whether it is worth prototyping the feature in the git codebase.

Thanks,

-Stolee

