Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A6C3F20248
	for <e@80x24.org>; Thu, 18 Apr 2019 00:23:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387821AbfDRAXU (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 Apr 2019 20:23:20 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:36640 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729446AbfDRAXU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Apr 2019 20:23:20 -0400
Received: by mail-wm1-f65.google.com with SMTP id h18so695599wml.1
        for <git@vger.kernel.org>; Wed, 17 Apr 2019 17:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=mnY0Uan+sWvnmI7bK8Qu8rZqHnPqrbxFKpmFw1QWUn4=;
        b=cyIz2matq/rIwQsdCV3w969mglXtMbpUKjdY6pbpc2MVldZgyQS5GVXCElQNp738eY
         PJyhdgC6ueWtKodeDG8e4Msz7X2LhXLbQK11jaZz4EXYDgJRQAdNz4umcM0MQbipsFBg
         d2U24f2OwvJELT37jKCH/np88K5yZWnZRiiODhDMfChn0UB1Sg/HrlTPe2C0R5cxWzOi
         jhqejcsOVdUBthqbJ759W8TfjfX0qzGBgZOAKjGkTV8IVH/LEgaasGDEHubi/ZXOsBS/
         oZ/apki2MyEiGqDA3+7liaeNyG4tw8Yo8wCn7PCFbFAa8g5o6CI40NaWDWQ5P8Cf+w7s
         PtNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=mnY0Uan+sWvnmI7bK8Qu8rZqHnPqrbxFKpmFw1QWUn4=;
        b=TIqs7j01sL9Yyy6JC1i17AKe18qKT1Qg/ehicQOM6OE+q7ruSa+1Bf27Rm984eErfY
         cUqc4unWzWbpPUMP935xvskenS+Pq7lNDVroIEhbw/ZzadFJfag6EAsv4/P08N33uMz3
         D/5BVz04gcsCTo/K9JXi+UP8Cl1NA4zpXuCwBd1EK7en1Akvt7g+pTasNTFNKIy30Od0
         OyFlUlJxAG+lfU/o2CRPKoqKdcK8qfT1dbQcqBIYFQVzICWvdaWIlvVy0RheUp2gZhBK
         FNB0ZhWuZ0sBmh9ZCyrfVEnYuXhKPBGCKMe173k/v8NsdlCqVbno/hovJHsJhVU5XnuK
         xwdA==
X-Gm-Message-State: APjAAAU81qgvtTJTeCVkEtZASGuMOqml64gxGYf4haeHbzSW1EUhnNet
        NlADyBQqZH3HhieJM4LxBbs=
X-Google-Smtp-Source: APXvYqwvs9mCkxsfPF1LRXEbohwcexm9XA6gVjC+2aT5JeMNITWX54oC06JAkuRKG/6jRScxEVp94w==
X-Received: by 2002:a7b:c5ce:: with SMTP id n14mr920420wmk.18.1555546998477;
        Wed, 17 Apr 2019 17:23:18 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id g19sm333494wmh.17.2019.04.17.17.23.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 17 Apr 2019 17:23:17 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Damien Robert <damien.olivier.robert@gmail.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        Karthik Nayak <karthik.188@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH 1/1] Fix %(push:track) in ref-filter
References: <20190415210416.7525-1-damien.olivier.robert+git@gmail.com>
        <20190415210416.7525-2-damien.olivier.robert+git@gmail.com>
        <20190415220108.GD28128@sigill.intra.peff.net>
        <20190416123944.vtoremaitywtmkhj@mithrim>
        <20190416214842.GA21429@sigill.intra.peff.net>
        <20190417081754.bd27mjxjx7qdxhty@doriath>
Date:   Thu, 18 Apr 2019 09:23:17 +0900
In-Reply-To: <20190417081754.bd27mjxjx7qdxhty@doriath> (Damien Robert's
        message of "Wed, 17 Apr 2019 10:17:54 +0200")
Message-ID: <xmqqef60jh56.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Damien Robert <damien.olivier.robert@gmail.com> writes:

> From: Damien Robert <damien.olivier.robert+git@gmail.com>
> Date: Tue, 16 Apr 2019 14:16:46 +0200
> Subject: [PATCHv3 1/1] ref-filter: use correct branch for %(push:track)
>
> In ref-filter.c, when processing the atom %(push:track), the
> ahead/behind values are computed using `stat_tracking_info` which refers
> to the upstream branch.
> ...

Thanks, both.  Will queue.
