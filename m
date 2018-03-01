Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BABF71F404
	for <e@80x24.org>; Thu,  1 Mar 2018 12:37:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030422AbeCAMhP (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Mar 2018 07:37:15 -0500
Received: from mail-wr0-f180.google.com ([209.85.128.180]:39960 "EHLO
        mail-wr0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030328AbeCAMhO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Mar 2018 07:37:14 -0500
Received: by mail-wr0-f180.google.com with SMTP id o76so5942880wrb.7
        for <git@vger.kernel.org>; Thu, 01 Mar 2018 04:37:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=KMIdbEabJcrmXGO3Lu1juO7q09geDThN6yQbaP9M0v0=;
        b=E0cbQF+WPxJ6w7Ffc14fL3Nw1Zfp0JpfmrpCZ5dlbDBb9gFo1JGC9gHn3+viAVCDM9
         /d8n82BURPjhurNTajFJC8MLo+ikSVRZeTkZqUeHTB6r3H/gFWspy4jLWXheseuc5XVh
         ul+f+1qt3Mmsimy6/ANhChW5mBw19MieLsLQjUXWwReGBSUbfpvHzruw+IRaDHhTirlt
         gOVpLqAC+MMItrxI78Zo5TUeXImQjrWnoTvVJnl9nvV06vrwkV4zKJx5XV83TnJRhdO0
         jJZR0176IjjynZ4HJymgJ4/REttSHaIze+6d92Je4s1TfOjeBhcbxWMUWNulWh8T0FIz
         eZDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=KMIdbEabJcrmXGO3Lu1juO7q09geDThN6yQbaP9M0v0=;
        b=UnZ1u29bj3B6nV8+2uVIRZ8QkouOtFNQG2qzcF0wG5NjKdHJdZK7QzShC5TYYwU8Xe
         f3DmUEOXOsBjqbAB3uR8XZeWke0vJN9Tmn4S9XRT2YJQBu+fg+oZOqSQbPPrNDvP+t6K
         QBSkKDZVz+ozVKT34HooDynRKda60CofzRiAeInfH/KyKVXOgnbZv3oOOEvPWTm/AHc7
         ylEm8DeE4Oa022XegXNoiFFCToOfS74O4Ku5KburoV+Pvse4e/XX8XLVqGPYQxwlPp4I
         4iHLASTMWpO/g7S5iSd3WollnG6Ielf8KSvjVAjqc/47xRR+Qywmu8HIdCAbvrtqXPip
         rpZQ==
X-Gm-Message-State: APf1xPCfBpngRoGNrrw9TJQ2nZUnwjNmWpxib7RIDv5dYPOPtuPWpAiS
        sDUp+zrWTaQPYBImJbVLeqD9HNgS
X-Google-Smtp-Source: AG47ELsvUNCSvF934Fa6q82CQ5mCFI7Lp26Jf3CBI4QLcncnV+aktNjJ+VARXeR9cFWX4hCz6q7i1w==
X-Received: by 10.223.181.152 with SMTP id c24mr1767269wre.233.1519907832773;
        Thu, 01 Mar 2018 04:37:12 -0800 (PST)
Received: from evledraar (178-84-79-100.dynamic.upc.nl. [178.84.79.100])
        by smtp.gmail.com with ESMTPSA id z18sm2956412wrh.2.2018.03.01.04.37.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 01 Mar 2018 04:37:11 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Eric Wong <e@80x24.org>
Subject: Re: [PATCH 07/11] pack-objects: move in_pack out of struct object_entry
References: <20180228092722.GA25627@ash> <20180301091052.32267-1-pclouds@gmail.com> <20180301091052.32267-8-pclouds@gmail.com>
User-agent: Debian GNU/Linux 9.3 (stretch); Emacs 25.1.1; mu4e 1.1.0
In-reply-to: <20180301091052.32267-8-pclouds@gmail.com>
Date:   Thu, 01 Mar 2018 13:37:10 +0100
Message-ID: <87zi3sc6q1.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Mar 01 2018, Nguyễn Thái Ngọc Duy jotted:

> pack. Use an index isntead since the number of packs should be

s/isntead/instead/

> This limits the number of packs we can handle to 256 (still
> unreasonably high for a repo to work well). If you have more than 256
> packs, you'll need an older version of Git to repack first.

So if you have gc.autoPackLimit=300 this will break, how does it break?

Should we also make (& document) setting that variable higher than 256
an error?
