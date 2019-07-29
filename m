Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4FC9F1F462
	for <e@80x24.org>; Mon, 29 Jul 2019 14:19:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387784AbfG2OTx (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Jul 2019 10:19:53 -0400
Received: from mail-wr1-f52.google.com ([209.85.221.52]:33811 "EHLO
        mail-wr1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387762AbfG2OTx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Jul 2019 10:19:53 -0400
Received: by mail-wr1-f52.google.com with SMTP id 31so62103030wrm.1
        for <git@vger.kernel.org>; Mon, 29 Jul 2019 07:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rtfm-co-hu.20150623.gappssmtp.com; s=20150623;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=W5L+AYTY8Ft6BGw/JqoxmLow9sKtmYPg+H4i4qL3Eew=;
        b=ToMYhLef6GLRGB593q/OfVgRUdnvThaTLBEd5Mz0ORVuXi+NNXGo7vBMFv+CJEGP35
         OZ9OO5l6D3XtN3E2Xqfrv5cYP7IOzURs7ipEH1XHczOXWqhpsgG7Q4tAXvIccrf7WeA3
         lcRoV8jbduH3VXbF0somSWgJaMknr/KUsgb0/kzjNpmhTAN+nlOabrrDsNBCDR0wTfFk
         7ltT26tsy6SU8tYJ1GSeLndZqXw2zO6HSxlSeS2UxHiGqf44288W8wdAZbCkecm+okbP
         5g0YyqJCfcr0qf+0hFQHgMJX2dL9FABi/AOQjXiWp+k+xYUS0/qEm6hgrx/nC6c+R8a2
         4Pdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=W5L+AYTY8Ft6BGw/JqoxmLow9sKtmYPg+H4i4qL3Eew=;
        b=cEWtCHRamiv6ZAJVATSOrmFcyVD8q/BFZBTM/m1bHR/yxHKvjYcyXA8vf+bWcca6PJ
         pyQ/tWaRFEblm9MdZ7AKn8eRkOEvCGCv5wRc9pQbBFzh0JEk13clgvrIaVV3wgoHzk+z
         oQfoLcYDhkH05ABAWh14ChL1m9pRqISqfwZo6bqMsLuQ1Nia/AuQ2M8teCWUFDG6TtIa
         SB7LlAfnokRLud9ykKEyt6QvZljAQndEsH/jF9bdpbS1ejYBBphk+HV8T3X0e2e+1ZUN
         vkNCcoeEtqfx31xmXAnvBzpwtNvrzt3xN3UEzRRDflMKearww2daQ96+nSWmsBk/i9vH
         qUEQ==
X-Gm-Message-State: APjAAAUr3uu0LAgXuQ+HRlWqc5qsvCRoqLvOa4pSME/S/9XuHNS2RMtC
        mkHbF86ZYkFYjimTRe3f9/x8BQcu
X-Google-Smtp-Source: APXvYqziRaczXhj/htlh/bRo1BntFCS0gWhqMQDFjenb9x4VMgDmbmHdpZwq9VOSbmWSe9jfWnkTCw==
X-Received: by 2002:adf:e705:: with SMTP id c5mr73128155wrm.270.1564409990690;
        Mon, 29 Jul 2019 07:19:50 -0700 (PDT)
Received: from [10.32.1.109] (atom.chemaxon.com. [194.39.44.24])
        by smtp.gmail.com with ESMTPSA id a8sm48295372wma.31.2019.07.29.07.19.49
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Jul 2019 07:19:50 -0700 (PDT)
To:     git@vger.kernel.org
From:   Tamas Papp <tamas.papp@rtfm.co.hu>
Subject: git name-rev segfault
Message-ID: <799a4ba4-a2ae-7ce3-a6e4-acd329d062da@rtfm.co.hu>
Date:   Mon, 29 Jul 2019 16:19:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

hi All,


We ran into a segfault with all version of command line git.

We are able to reproduce this issue by this way:


Generate 100k file into a repository:

#!/bin/bash

rm -rf .git test.file
git init
git config user.email a@b
git config user.name c

time for i in {1..100000}
do
   [ $((i % 2)) -eq 1 ] && echo $i>test.file || echo 0 >test.file
   git add test.file

   git commit -m "$i committed"

done


Run git on it:

$ git name-rev a20f6989b75fa63ec6259a988e38714e1f5328a0



Could you coment on it?


Thank you,

tamas

