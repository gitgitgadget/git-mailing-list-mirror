Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8113A1F403
	for <e@80x24.org>; Mon, 18 Jun 2018 17:04:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934922AbeFRREh (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Jun 2018 13:04:37 -0400
Received: from mail-wm0-f48.google.com ([74.125.82.48]:51509 "EHLO
        mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932762AbeFRREg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Jun 2018 13:04:36 -0400
Received: by mail-wm0-f48.google.com with SMTP id r15-v6so15292338wmc.1
        for <git@vger.kernel.org>; Mon, 18 Jun 2018 10:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=R7DioZiML4vA6u3XwJcyTCqyYA1VY7b1lVR37kviCnk=;
        b=JvZEsNhoyiSRxE2oPh+tON8BmSVHiMcwmtoVKRX7O9JuKUUz/QmZxxCPIEe4eEbqwG
         mKJw1pQlo+WZplEq6P7f0b3Yy6yjgmFl0BWr48Bm9vL4TL1DN8Ae+cw9HIylJ8BOQVnC
         8dl+nK08P/aJqjay/reN0O9t3maFWtzaNz0GiRP0ZJKD0mNqBW6rWY/tzB+Qj2k5QZFB
         aBmiuZqvdCD/1e/mjLHQJa1BixbKAW95ufiEEVdb7j7MVpW2pGgll0FLgoG8GGNxVHNU
         sZXQWqyNCJ8TpYmkGUl5T1uCHEUBmFNHJPrBDmybpexNW4VOEURigkvhMBWiER6QTR20
         XSQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=R7DioZiML4vA6u3XwJcyTCqyYA1VY7b1lVR37kviCnk=;
        b=INIjpQ7+WryessUBiQVnathA5cYH7YmWR8ZX+keeiQb4eUGZTcnDg8lHmxwaVdIfdW
         3VE9VNZ4Vi26/I0+e1SY/6vHo/O5BEQXE+hfB2JEq4PSPF31zA7rrRuzBW0zZ/DFdAtD
         SaKVCs4064Emd9NnbDuCczmLGigge0RFmhV5aKwxchTEEWr+Zc/Xuxr/B5CJr7UDBSef
         m1OwXDH1NjXSl4pheXaTxgkHhGzLGomsozsp1u+GO+bITnqW5aqOBrEmIPjRdHI5mIOs
         6J9ba9hzixTc7IhULdXVMekY+2mFEPhWZgR33wO+NcORCsx9euADZPhND3UCLkD7S0gt
         3pnw==
X-Gm-Message-State: APt69E0UsA2dzHE/zTh1tLEYRRVw8CO0a8YUCJOwifuguq8Pnt5j9QY1
        Hn/JH2i2GRsTdXe3k4cNDic=
X-Google-Smtp-Source: ADUXVKK95aMvYgchUQtkJTOVzNMvqa+2kJpZMK8QcRixfmfhRpHPcG1KIG90Z9ArKcl4fc0Ltqt1fw==
X-Received: by 2002:a1c:4252:: with SMTP id p79-v6mr8988698wma.119.1529341475413;
        Mon, 18 Jun 2018 10:04:35 -0700 (PDT)
Received: from [192.168.0.104] (AToulouse-658-1-40-196.w86-221.abo.wanadoo.fr. [86.221.119.196])
        by smtp.gmail.com with ESMTPSA id 12-v6sm11489328wmt.19.2018.06.18.10.04.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Jun 2018 10:04:34 -0700 (PDT)
Subject: Re: [GSoC][PATCH 3/3] rebase -i: rewrite checkout_onto() in C
To:     phillip.wood@dunelm.org.uk, git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        Pratik Karki <predatoramigo@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>
References: <20180618131844.13408-1-alban.gruin@gmail.com>
 <20180618131844.13408-4-alban.gruin@gmail.com>
 <290d8b7c-3d82-e914-0399-e8dd5a6e1513@talktalk.net>
From:   Alban Gruin <alban.gruin@gmail.com>
Openpgp: preference=signencrypt
Message-ID: <3de6062e-d3cf-c85b-3663-31930b26e6e0@gmail.com>
Date:   Mon, 18 Jun 2018 19:04:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <290d8b7c-3d82-e914-0399-e8dd5a6e1513@talktalk.net>
Content-Type: text/plain; charset=utf-8
Content-Language: fr-FR
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip,

Le 18/06/2018 à 18:09, Phillip Wood a écrit :
>> +    if (get_oid(orig_head, &oid))
>> +        die(_("%s: not a valid OID"), orig_head);
> 
> If this code is going to live long-term in sequencer.c then it would be
> better not to die, but return an error instead as it's part of libgit.
> 

Right, I will fix this.

Cheers,
Alban

