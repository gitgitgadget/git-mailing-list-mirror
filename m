Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CBD221F424
	for <e@80x24.org>; Wed, 25 Apr 2018 14:11:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753674AbeDYOLq (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Apr 2018 10:11:46 -0400
Received: from mail-qt0-f173.google.com ([209.85.216.173]:38343 "EHLO
        mail-qt0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753283AbeDYOLp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Apr 2018 10:11:45 -0400
Received: by mail-qt0-f173.google.com with SMTP id z23-v6so26956575qti.5
        for <git@vger.kernel.org>; Wed, 25 Apr 2018 07:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=Y7EY0IlhVbim2MSdyBylchU8TZfzjuYmfoc1lyUtFmc=;
        b=O9/q/m6F5D2/201ssLw/Xggc4Q3pnVL5UWvD15AZQ8pquI3JDBMSu2caIeTQr99Ro8
         Aq0dUu9+a2JM52MriXa4GKKRFWRYN16MBWn0Hd8/LGQKHsYygELBVKJccj5eOh1RACxB
         JXqug2YBILH9huixdC00j4L2cY95iiYn0YHcY4CJqqt+ziBrviNUcrckm/eylXXrJ9Ym
         MWMr2Va1dLqpqBz7DSQDAZYL/cPMFYvneU5ogk1LiVLy/kp0iZ8q3zqqtqwCdi0Gho39
         2koI88U3J8Sx31yeUl+fI4YknNUyN6DA1Y5KCwppgyQ3XnGhFiYYPrk6BTFcqU7vp11g
         jjYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=Y7EY0IlhVbim2MSdyBylchU8TZfzjuYmfoc1lyUtFmc=;
        b=YkNrHx22MZAUPe6B+CNyyr6ND2GazNGgJXgSBWLUDD/oPAaJT0RRQq+Vzh8j4cwf/H
         fswlXOCXpCXCkAn2KKwWo4piGY4GEliYGhhtL+FAM7JKaO++x5MW2rb2fhGh2NL8mGZ5
         k6blL8NRqRGqSogIiYJ25/krzHYFduF7d7hkoLLqK/a0Kwqc0+fzqgzS+VHVYiI8RyrE
         +cAClC4IDwrVPSQmruDaJ/nkQMcJzWDjVuTPSCtngrZvYDiJQyOPUTAB8r+K3WuataqK
         WYMWRYzPFmBI0mciCMsPENE1AzJOmzK9hp6Bo6z+eoccybOt7bhMdseEu69MZdB+aUNU
         FqKA==
X-Gm-Message-State: ALQs6tD+uA3ASlxYP8Pl8kdOcTMJ+mg+8Mbz2kn4ILxn18GaReP7fPeH
        Jl4OocQ8G+TK8LBnD4KTzko=
X-Google-Smtp-Source: AB8JxZqcnCRBCMvHZY2m/+ntmJa7DVGVs6EWaWO3kCKq6y5Sd1vRbwYcN1G9DJ+3bhIrV5BTkzMIag==
X-Received: by 2002:aed:3e3a:: with SMTP id l55-v6mr5889152qtf.4.1524665504505;
        Wed, 25 Apr 2018 07:11:44 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:c4e6:7a22:56f1:df04? ([2001:4898:8010:0:ae1c:7a22:56f1:df04])
        by smtp.gmail.com with ESMTPSA id n29-v6sm15785608qta.94.2018.04.25.07.11.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Apr 2018 07:11:43 -0700 (PDT)
Subject: Re: [PATCH v3 5/9] ref-filter: use generation number for --contains
To:     Jakub Narebski <jnareb@gmail.com>
Cc:     Derrick Stolee <dstolee@microsoft.com>, git@vger.kernel.org,
        "peff@peff.net" <peff@peff.net>,
        "avarab@gmail.com" <avarab@gmail.com>,
        "sbeller@google.com" <sbeller@google.com>,
        "larsxschneider@gmail.com" <larsxschneider@gmail.com>,
        "bmwill@google.com" <bmwill@google.com>,
        "gitster@pobox.com" <gitster@pobox.com>,
        "sunshine@sunshineco.com" <sunshine@sunshineco.com>,
        "jonathantanmy@google.com" <jonathantanmy@google.com>
References: <20180409164131.37312-1-dstolee@microsoft.com>
 <20180417170001.138464-1-dstolee@microsoft.com>
 <20180417170001.138464-6-dstolee@microsoft.com> <86r2ncgrcs.fsf@gmail.com>
 <48f910b6-8762-f34b-b644-d6c7ff99499f@gmail.com> <868t9cfn6f.fsf@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <1c63c945-aea0-4d15-9d0c-35092a00c30d@gmail.com>
Date:   Wed, 25 Apr 2018 10:11:41 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <868t9cfn6f.fsf@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/24/2018 2:56 PM, Jakub Narebski wrote:
> Derrick Stolee <stolee@gmail.com> writes:
>> One way to fix this is to call 'prepare_commit_graph()' directly and
>> then test that 'commit_graph' is non-null before performing any
>> parses. I'm not thrilled with how that couples the commit-graph
>> implementation to this feature, but that may be necessary to avoid
>> regressions in the non-commit-graph case.
> Another possible solution (not sure if better or worse) would be to
> change the signature of contains_tag_algo() function to take parameter
> or flag that would decide whether to parse "wants".

If I reorder commits so "commit-graph:always load commit-graph 
information" is before this one, then we can call 
load_commit_graph_info() which just fills the generation and graph_pos 
information. This will keep the coupling very light, instead of needing 
to call prepare_commit_graph() or checking the config setting.

Thanks,
-Stolee
