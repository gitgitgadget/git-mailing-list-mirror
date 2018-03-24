Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E946D1FAE2
	for <e@80x24.org>; Sat, 24 Mar 2018 09:42:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751883AbeCXJmR (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Mar 2018 05:42:17 -0400
Received: from mail-wr0-f174.google.com ([209.85.128.174]:36542 "EHLO
        mail-wr0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751797AbeCXJmQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Mar 2018 05:42:16 -0400
Received: by mail-wr0-f174.google.com with SMTP id d10so14327426wrf.3
        for <git@vger.kernel.org>; Sat, 24 Mar 2018 02:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=vcuFJ5gJ535JxGHcIzI4BaKrFWx2PxrTkrfHgkrideI=;
        b=NN6cg8HmZtuQPGTLOjgdiPoMtw3UlYa8luVmvFNjJ/jkPzbLpKgwDG3vMR72xfKaIc
         dNL6GE+BGeZv9swxr8lDp3k/gOUzCdk+JLuOxbX6B4Q+cnLT0MGGk+Pa2i98elh5EC+t
         d/YUzmqsIlFI/2TzBOWjiRZD72iodX5B8sMD98Ys3BKv3zBPpNaGWbiDG/iKbGp8POas
         7lvlKrA4cRhfWmOuJay1GYAWUtG8ub/AABqVRc5IqTjZLAxTK/8ETyR2vO/SkQlYXdgz
         BD8Po1rXVF8sgXPW3FlXANXsW3fqhEk+m7woSnLQdbGB70F8/XUN04r1K4AXHOuGRYks
         4c5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=vcuFJ5gJ535JxGHcIzI4BaKrFWx2PxrTkrfHgkrideI=;
        b=CRYdPe3PEjoG8QjtRgkAJxuKpwkB6dS/OjNe/RlEf9CA90VDm/rFFLwRCOdyKo6bkB
         hcPvlun6YVjhxhV7xjEf27JKPb3+CVP0CtO+RviuueYr/e0BDSRgMYaV2q+/91WlQB0M
         D9p4vWper8hYosd/KhkFLT07P3nkuMME5/l/BUGOimmvzqEKOhgYE3+FPqGDk/OhRJgF
         KVYdQZ9vpQjmjGfGhBjtNQgb7GiaYb1wO6FsCzVAuVHEkAhmogCAB8BEQbv+8Vb7nxyE
         M59M2TE8Ek3drYYahH9sAiZcbCCmiAzgxKJ2ArCXQnNEdqMkxxG7heBwzC8Kp3+4bhFh
         L8wQ==
X-Gm-Message-State: AElRT7HukCZf07Q27nvAaZDZU2//OikN/hLVsae9WFPwHmt83V5y14kC
        33uebVJ4WJi6dC8/NGufqA748NkO
X-Google-Smtp-Source: AG47ELv7LyK4TCc2e9spUNoLhG295aIQDP6K349fToJY9O7FlR9UEBm5xBaBgPbxgnby3Q0L1QVOZw==
X-Received: by 10.223.141.162 with SMTP id o31mr26486092wrb.167.1521884535549;
        Sat, 24 Mar 2018 02:42:15 -0700 (PDT)
Received: from evledraar (dhcp-089-098-184-206.chello.nl. [89.98.184.206])
        by smtp.gmail.com with ESMTPSA id g186sm1938604wmd.41.2018.03.24.02.42.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 24 Mar 2018 02:42:14 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     e@80x24.org, git@vger.kernel.org, gitster@pobox.com, peff@peff.net
Subject: Re: [PATCH v7 06/13] pack-objects: move in_pack out of struct object_entry
References: <20180318142526.9378-1-pclouds@gmail.com> <20180324063353.24722-1-pclouds@gmail.com> <20180324063353.24722-7-pclouds@gmail.com>
User-agent: Debian GNU/Linux 9.4 (stretch); Emacs 25.1.1; mu4e 1.1.0
In-reply-to: <20180324063353.24722-7-pclouds@gmail.com>
Date:   Sat, 24 Mar 2018 10:42:13 +0100
Message-ID: <87efk9yfm2.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Mar 24 2018, Nguyễn Thái Ngọc Duy wrote:

> +	if (pack->in_pack_by_idx) {
> +		if (p->index <= 0)
> +			die("BUG: found_pack should be NULL "
> +					"instead of having non-positive index");
> +			e->in_pack_idx = p->index;
> +	} else

The indentation after the die() here is wrong. GCC complaining about it:
    
    ./pack-objects.h: In function ‘oe_set_in_pack’:
    ./pack-objects.h:203:3: warning: this ‘if’ clause does not guard... [-Wmisleading-indentation]
       if (p->index <= 0)
       ^~
    ./pack-objects.h:206:4: note: ...this statement, but the latter is misleadingly indented as if it were guarded by the ‘if’
        e->in_pack_idx = p->index;
        ^
