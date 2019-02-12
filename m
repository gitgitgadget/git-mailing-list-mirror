Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9A1A91F453
	for <e@80x24.org>; Tue, 12 Feb 2019 16:49:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731219AbfBLQtP (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Feb 2019 11:49:15 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52909 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729078AbfBLQtP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Feb 2019 11:49:15 -0500
Received: by mail-wm1-f68.google.com with SMTP id m1so3754588wml.2
        for <git@vger.kernel.org>; Tue, 12 Feb 2019 08:49:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=Y/wjR5Rm32gMAGW8iecvIVtncBbHo8aDxDXY5ef4FRE=;
        b=lYDT6da5FiiCTsW9Evg5+Kl/mns2mzhrg5I1wIESqZjXVytDJPqLHbqtvFN9W7QdiH
         OpIuHscbIz8FHXryRpltsF9j15NEVjT5htZnNb74kaKpVDdpH+OY3lH79gaAtMzzFCUd
         c7gWz+/ZxYpJfqt5KvRL9m9ZPeY3FUbSVDXLIsOLsF6GqZ5OaaPaLpmAOJ0EuYqEr2sx
         TQikiWM+2RnTnvB9TPqv+tnWFqgFM4WxAgTwrEuQ1gM3v6Ap1niINXrBw4zuJ3cUA5xD
         JRcCY7QvtFOaVk7K4noWaQu6b3S/H9hYEr9/KlxVnideXdiJWHCwq0b9x98vjZrU+b8r
         /nYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=Y/wjR5Rm32gMAGW8iecvIVtncBbHo8aDxDXY5ef4FRE=;
        b=ACCmKcxGBUY9DvQbhnihOtzD/muII0VTnLUy/tpbCyE1kXgancykbr1Nux6MFcmOcZ
         PUqkn6d2wRdsAVTA3rfwetBlkBvDiKMQbI4GuZwgXJh/cAGu4mCGSLk8qvloui1m5FyF
         XuzKn+e0CvOcDdEVAi0aFzhM1gMKZHjCKahQG5cVLP/M3/Ff2Bg0cyfRdBq4gK14k05k
         6PtK2rw7grkhW1ro6PfpXZI/b5nIMRx1CXKYRfBMFeNhXfSUSUrzEJNNhKziJFjWxQlI
         UP1BSvvC/vR7Nu6kOvRBhOzdNB5NsRTdpmnKx/rKUAnZleMWZzvicxFSPr2xatApLLg5
         PyBw==
X-Gm-Message-State: AHQUAuYIEcQGoNh0hbOe92dpV5cRJYLIiYiz5KNHjvZy3jSr7ClAkmU9
        9Zmfqv44CyoQME0Sd3asoI4=
X-Google-Smtp-Source: AHgI3IYokhbN5WfMrxpo0qqQBkakAoU/ULu61QEhoZ6fyaSMN92Nfdj6HYiWynrbu0HkFcSBIfAcAA==
X-Received: by 2002:a1c:cc19:: with SMTP id h25mr3609547wmb.80.1549990152719;
        Tue, 12 Feb 2019 08:49:12 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id a1sm3548580wrq.96.2019.02.12.08.49.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Feb 2019 08:49:11 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        luke@diamand.org, Christian Couder <christian.couder@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] unpack-trees.c: fix writing "link" index ext with null base oid
References: <CAE5ih79JYrcV9cxMBU88Hq=HHQOOyzpkq+kT2zAgDzs=ao+PMg@mail.gmail.com>
        <20190209112328.26317-1-pclouds@gmail.com>
        <CABPp-BF+q0QY1YAKOk4iSrCRuEc7xsG7iqCzeDD9v8+jmvQvzg@mail.gmail.com>
Date:   Tue, 12 Feb 2019 08:49:11 -0800
In-Reply-To: <CABPp-BF+q0QY1YAKOk4iSrCRuEc7xsG7iqCzeDD9v8+jmvQvzg@mail.gmail.com>
        (Elijah Newren's message of "Mon, 11 Feb 2019 21:43:35 -0800")
Message-ID: <xmqq1s4deyuw.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

>> There is also another side fix in remove_split_index() that causes a
>> crash when doing "git update-index --no-split-index" when base_oid in
>> the index file is null. In this case we will not load
>> istate->split_index->base but we dereference it anyway and are rewarded
>> with a segfault. This should not happen anymore, but it's still wrong to
>> dereference a potential NULL pointer, especially when we do check for
>> NULL pointer in the next code.
>>
>> Reported-by: Luke Diamand <luke@diamand.org>
>> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
>
> Thanks for digging this down and fixing it.  When I saw this split
> index bug bisect to me that my heart sank a little; there's so much of
> that code I don't understand.  Nice to see you've already come along
> and fixed it all up.  :-)

Thanks, all.
