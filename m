Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D6EA61F453
	for <e@80x24.org>; Tue, 12 Feb 2019 02:43:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726530AbfBLCnc (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Feb 2019 21:43:32 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53883 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726207AbfBLCnc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Feb 2019 21:43:32 -0500
Received: by mail-wm1-f66.google.com with SMTP id d15so1281540wmb.3
        for <git@vger.kernel.org>; Mon, 11 Feb 2019 18:43:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=5tRMsfx54z+DX/OwCAY/KGlknvQwil7xsYT4YPa7B8A=;
        b=HEw989eVxS31mrxEpmf1FZiUXeOSR2MCAtzc17GmemmG5K+xvU3r11gv1nrl+s+W36
         HMypo+ElLNIDR7XT483Ap7Rzko1wIxlLhavfcmIWyxmnMCFyLD7AlMN2QzNz3XAdTdHr
         SuMrvwnxRtZR+VMZAszNiX+PDJKBElRZDLbo5ODPTXq8KYM/+bdgfuhTBYqT+yJP9R3d
         rm32H2gWq0gePVKzoOnnslljwPE1Qg5SlNcjBy3xZhprcbmqR6FQEgHmdfjR/nj9CgmI
         bDqOgSjQn6CuDqFiPV28QxRp5JN3KIMvAC7zMwllalb5/yw0av6W9MnTeZhlzPE2oB0p
         u1PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=5tRMsfx54z+DX/OwCAY/KGlknvQwil7xsYT4YPa7B8A=;
        b=R+k3b6IyPBwtjLfr7t+FWmBoy9VgzQiE+C4YESuz3Lz1syXOYsv24tKPpzibh6JEGq
         1dwalu6FAeBf739FYj7saHeuaFVHJoPbN9ZSfNGjsqCxOe5u3MHfYzipHuuyWUl7NN1V
         PjymfWymwRrOcOAUsLBpKFgZ8Q7tyDHkVoU7rDUQHFQoPslCRDc8LsdtERWFaRdEAcyN
         wrj8qvtCud6rye+/0OOrav0cJqI8TTEy6ZlbG9yX9AZctHqQiaxk1NZu+pRmPMWyi2/l
         PNubsJTuqby7X42OtOsfkKnAgYN2/wjlQSPg7PVgotLC+YPhp3QCDVO/6ajNm1dbCkVf
         WCbg==
X-Gm-Message-State: AHQUAuZVNpqa1T71c7K+RoqFuk0VQNn9aCMI2VOr72VhFJ471zgCDl5r
        WU2Oxe/V/5xWX+7272ODMtc=
X-Google-Smtp-Source: AHgI3IbulX14//J2ruvXqQJmP0gAJUK/WZbdnCzy5K/9v76KAnCPfmYcpC/SacxMcNWxr8Uov6UKVA==
X-Received: by 2002:a7b:cb4a:: with SMTP id v10mr953786wmj.1.1549939410043;
        Mon, 11 Feb 2019 18:43:30 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id o12sm6308545wre.0.2019.02.11.18.43.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Feb 2019 18:43:29 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Kevin Daudt <me@ikke.info>, git@vger.kernel.org,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
        Rich Felker <dalias@libc.org>
Subject: Re: [PATCH v3] utf8: handle systems that don't write BOM for UTF-16
References: <20190209200802.277139-1-sandals@crustytoothpaste.net>
        <20190211012639.579489-1-sandals@crustytoothpaste.net>
        <20190211214306.GB14229@alpha>
        <20190211235835.GB684736@genre.crustytoothpaste.net>
        <xmqqtvh9g857.fsf@gitster-ct.c.googlers.com>
        <20190212005329.GD684736@genre.crustytoothpaste.net>
Date:   Mon, 11 Feb 2019 18:43:29 -0800
In-Reply-To: <20190212005329.GD684736@genre.crustytoothpaste.net> (brian
        m. carlson's message of "Tue, 12 Feb 2019 00:53:29 +0000")
Message-ID: <xmqqh8d9g20e.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> I've just sent a v4 with this squashed in. Whether you want to pick that
> up or squash this into v3 is up to you.

Let's take yours, as there is no point doing an eval for these two;
for that matter, braces around ${i} are also pointless, but I'll let
them pass.

Thanks.
