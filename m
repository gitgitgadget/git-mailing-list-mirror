Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 920891F855
	for <e@80x24.org>; Sun, 31 Jul 2016 09:26:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753573AbcGaJ0W (ORCPT <rfc822;e@80x24.org>);
	Sun, 31 Jul 2016 05:26:22 -0400
Received: from mail-wm0-f44.google.com ([74.125.82.44]:34245 "EHLO
	mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753187AbcGaJ0V (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Jul 2016 05:26:21 -0400
Received: by mail-wm0-f44.google.com with SMTP id q128so48310796wma.1
        for <git@vger.kernel.org>; Sun, 31 Jul 2016 02:26:20 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:newsgroups:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=Hpr7wFW0v891tiqC2/EwR+m/WvnkX+NVgQm1GsTADHE=;
        b=COd4rJWvNV0YxOgbDTEV2cEstBD0nJ3U1CSh7cYGzoiPLF07BUCirHaY/z54mp52jA
         iJw/Xm0Lj7Jj8wpuStKwu2Zss1cvXRenWbKsitFKVnmpGYmJobRbKvSTga0UgVxDhjJ8
         paq/RslFAiEFNuCV9V7BfbYX1ZrMCbmJVGsxjqnHowt69JcoiIvEA0zDofMDCX9dsok5
         sEWrVhb049hXkr6gK3YXw8TsQc5waFlVM/mfZiNLCCKakwoXD81tNdYjfWrRp8ZShgQ5
         8uDx5h36djSr0G2GcCtqp+YQZCwSSfHWxZY4qMOAZO7PVnVmVp1GYFvmhWhAupBoMNXK
         AQuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:newsgroups:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-transfer-encoding;
        bh=Hpr7wFW0v891tiqC2/EwR+m/WvnkX+NVgQm1GsTADHE=;
        b=cKospPU5deoF6yM4lcIxD+e0acfRnaR2mqa8I+QFRzNswC+HRYed68f5DDL+D7osqS
         QxGJ+ZmXxIVkaYGh0yznsEkqkgx1TLK2JliCFVo7cVb0l7TpKXW2wAc3HGm/Llcmgnci
         zNnS9V7WqHVkeGgWCZlcaeXn0RTJQyMtpNn+xgabxhvEy4+uDF+NY31cWP8/vtHvvppk
         5EhxxwkjaBiOpALIB2pH52O74RTXuU3I0B2+HuNrJZ7ecRpmFQVaYzDabk3tqzYAhA1p
         ujR6eJTq9/gQFAffljA0d4QopjZ9GtnWicIdd92uHCenfHcNEGW8uWRJmPstGmv4teAQ
         eQ/A==
X-Gm-Message-State: AEkoouuYyB7pBnZDepqy7qgx4t5FBSfTNX66L9WySzo5qHLO57IUbcndRgXFEw3hdZZ8cg==
X-Received: by 10.194.175.170 with SMTP id cb10mr16057184wjc.17.1469957179835;
        Sun, 31 Jul 2016 02:26:19 -0700 (PDT)
Received: from [192.168.1.26] (dad247.neoplus.adsl.tpnet.pl. [83.23.3.247])
        by smtp.googlemail.com with ESMTPSA id a2sm11372443wma.2.2016.07.31.02.26.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 31 Jul 2016 02:26:18 -0700 (PDT)
Subject: Re: git bisect for reachable commits only
To:	Oleg Taranenko <olegtaranenko@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
References: <CABEd3j8VLbpeWbA6BfHYp5aLPEy0PesqYoHM9u4OM=b7Qm=LDg@mail.gmail.com>
 <xmqqinvonwxc.fsf@gitster.mtv.corp.google.com>
 <CABEd3j-MW--YSC9=nwcgHzxd6cqmUY+ky3-wLxMiMmbBGsvS7Q@mail.gmail.com>
Cc:	git@vger.kernel.org
Newsgroups: gmane.comp.version-control.git
From:	=?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <2bfd9cf5-a9fa-7650-21e9-9ceb9cc34d8b@gmail.com>
Date:	Sun, 31 Jul 2016 11:26:00 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <CABEd3j-MW--YSC9=nwcgHzxd6cqmUY+ky3-wLxMiMmbBGsvS7Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

W dniu 31.07.2016 o 02:06, Oleg Taranenko pisze:

> Then, I suggest as well additional to defaulting via 'git config
> bisect.reachable true/false' use per bisect session switch
> 
>     git bisect start --[un-]reachable-commits # which will override
> default setting

Isn't `--reachable-commits` the same as existing `--ancestry-path`
option to `git log` and friends (I wonder if passing log options to
bisect, that is: `git bisect --ancestry-path ...` would work)?

-- 
Jakub Narębski

