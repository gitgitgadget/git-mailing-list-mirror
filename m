Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 65B6E1FAEB
	for <e@80x24.org>; Thu,  8 Jun 2017 22:13:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751655AbdFHWNt (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Jun 2017 18:13:49 -0400
Received: from mail-pf0-f176.google.com ([209.85.192.176]:36330 "EHLO
        mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751478AbdFHWNs (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Jun 2017 18:13:48 -0400
Received: by mail-pf0-f176.google.com with SMTP id x63so21551428pff.3
        for <git@vger.kernel.org>; Thu, 08 Jun 2017 15:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=teichroeb-net.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding:content-language;
        bh=9JE4k8VpOyUby3LC4+IOVHjJWQxi/NqaJAalDBLUVuA=;
        b=luMHDxsWonIyw/+K+cdjbEJeayKrmutQtIxAWTV2NdnjVKpKDZupVTusHg6GbSMFrx
         OFtVhItjsTSU4q3+62HhzBdu+uVyxhpFEkUSu8In0QcgFsn0KPLoQqz9RvCZmXOolShB
         ZQjlb4taP/c6IDad0Jtb8K0YWkiA1FIYE690a430wJwFDJjiGSIs+rxmilpA5gAVs/Kj
         qiY4OWrc5mmIfBn4JqJsADk3MiL2QNJ5fALuuOlNdfljOiB/a2KPE4kKkyQXCkNoKDQH
         fT5DAtPIa5yc8TVpuFSBfeqwPr3C83bJ3jfaMFBTZuqBtAzdoxCD29zGX3n/0R3rx/fe
         t6YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=9JE4k8VpOyUby3LC4+IOVHjJWQxi/NqaJAalDBLUVuA=;
        b=PRVa6J3y54ce4bPtGFBbpn7+vYz8iNCe88IL5lI1yy9QG9BQk+JTCdW28yjEIaU/YM
         vN0ApnE4bRWJ2Fj2RpTUcacVyivdXKlCRvpUM9B9wNTtINGJ4uOguE1mcSSbOOmYIMqY
         fOFqfG0DjHIdTHL1xt9XyLfHK0ueD1ZlwzSTgjzFAVnG9R7z5zURPCmcjofXLhjpQzbU
         b+iqd2eUbiTIB2sAa3tw0Y6R87kTs8RdCv5TVSsAvLEuHTDOoms3KruAHla7OZOx2IGX
         gdG3JxdywR8IQ8H2Q8c/pt3CG4urLygO7wmqr97n2dY7lJg1EOqIP2YB1Nf71c/Dg/kg
         oJSw==
X-Gm-Message-State: AODbwcAMDIvSIdehZ/OZ8MK6EH/Gsl12+uR/OhDNcNIdneslkee1G9CJ
        R+JoMbn86Bu0k8qraeDjhg==
X-Received: by 10.99.100.65 with SMTP id y62mr39303319pgb.217.1496960027448;
        Thu, 08 Jun 2017 15:13:47 -0700 (PDT)
Received: from [10.0.0.2] (S01066c3b6b1953d0.vc.shawcable.net. [24.80.205.243])
        by smtp.gmail.com with ESMTPSA id c66sm13833685pfl.81.2017.06.08.15.13.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Jun 2017 15:13:46 -0700 (PDT)
Subject: Re: git stash --include-untracked possible destructive behavior
To:     Marc Strapetz <marc.strapetz@syntevo.com>, git@vger.kernel.org
References: <2b695c73-9de2-5502-6d19-ba4ad0114978@syntevo.com>
From:   Joel Teichroeb <joel@teichroeb.net>
Message-ID: <197975d0-7ec3-0ff4-9201-48226fd3b60c@teichroeb.net>
Date:   Thu, 8 Jun 2017 15:13:47 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <2b695c73-9de2-5502-6d19-ba4ad0114978@syntevo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It looks like it's an issue with git clean, as that's what stash uses 
internally. You can try your same test, but replace git stash with "git 
clean -df" and it will delete Data. Maybe clean should check if there 
are any ignored files in an untracked directory and only remove it if -x 
is specified?

Joel
