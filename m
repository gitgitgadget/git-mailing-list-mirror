Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B443C4332F
	for <git@archiver.kernel.org>; Fri,  4 Nov 2022 15:28:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232549AbiKDP2y (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Nov 2022 11:28:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232554AbiKDP2g (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Nov 2022 11:28:36 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD80C2DAB4
        for <git@vger.kernel.org>; Fri,  4 Nov 2022 08:28:34 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id v4-20020a17090a088400b00212cb0ed97eso4824894pjc.5
        for <git@vger.kernel.org>; Fri, 04 Nov 2022 08:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DP4WVjzsKEbP6TBpFhPEkBJdiqwZLRiiWHvxU4Apddk=;
        b=AFVQXZR2erLAlkig3CZo4hx/tgGLIPAcPQO9Kkh/ZZ3q/VMD/Djo7IPPnSWNZC5cgU
         +nuDLnL3mISyU2OI0GBfLbHeNf1AJOhUE9XLvHrTIvYJ5jUG01ThP6hzIQE8lLaIqOiH
         IwmKqM6EY1sQ20OhyyPd2CBRC/CoZ6MQpgX6VVFafpZoy4k7Dgt4CYYscPUSFtwkE7/p
         uIYGi0XGakp9nv8JUxGfGijdVFCQz49tWeCarS9ZEAIPt/vMyAM44lieAJc1qeR2eShM
         Jkb1DDCmmIzfCCzEniTCFanLSpEZ11KX4Jhucs956pRIDCOOeUCv2TZWRszFx1jydqKE
         jKUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DP4WVjzsKEbP6TBpFhPEkBJdiqwZLRiiWHvxU4Apddk=;
        b=DDHpHuCdgYh3Kdz8z3nXOhVTYVeNHefnskOG1QKejfqlFEgpGisKTWgbaJ/OraO6/L
         ISEImby7NNcdW8k38s2X8FXY6jafqsropS+aRsBSDVv8gQCEmSDCAJ3g6MKGMqbOpp2m
         VfvZziVYfqxYW6lF9mk7B3sBwjb90O47QOvLVprqrpdJIxs0rWs7Rj8li0ZP9roD7c58
         R26vGNGiw1vlZnAKqP2IaYZTESO6zxa6OSe0VpzhTaTIu0A02/Ppf2Lr+Mo3gK/d2rba
         dzvx/YxF4tTB4pMzcceU49dMftI9+hLNXHx2H1+deT9axfg4J7LLZpmt7qQxmrCBypjf
         OSjQ==
X-Gm-Message-State: ACrzQf3Mcs86OmDeoVUBB044hBnCP47X22w9XPqbFX80koJRAeynxkkQ
        yxjqCOMqSb6eNrvsTmCQSDQf
X-Google-Smtp-Source: AMsMyM638C9497hdaxIdbDLdwsLZUjGVW5kMZG/rIRgAwA+l+4cI+FsZBdMCalGcdm8ZVIS846hYew==
X-Received: by 2002:a17:902:edcd:b0:17a:6fa:228d with SMTP id q13-20020a170902edcd00b0017a06fa228dmr36241815plk.29.1667575714345;
        Fri, 04 Nov 2022 08:28:34 -0700 (PDT)
Received: from [192.168.50.41] (cpe-172-91-184-234.socal.res.rr.com. [172.91.184.234])
        by smtp.gmail.com with ESMTPSA id u6-20020a170902e5c600b00172973d3cd9sm2856084plf.55.2022.11.04.08.28.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Nov 2022 08:28:33 -0700 (PDT)
Message-ID: <bf5bc739-cb88-61ff-ed6b-09b1316f2f35@github.com>
Date:   Fri, 4 Nov 2022 08:28:32 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.1
Subject: Re: rebase -i --update-refs can lead to deletion of branches
Content-Language: en-US
To:     phillip.wood@dunelm.org.uk, "herr.kaste" <herr.kaste@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Derrick Stolee <derrickstolee@github.com>,
        Phillip Wood <phillip.wood123@gmail.com>, erik@cervined.in
References: <CAFzd1+5F4zqQ1CNeY2xaaf0r__JmE4ECiBt5h5OdiJHbaE78VA@mail.gmail.com>
 <123628cc-1410-aaa0-0151-2dff35bd1855@github.com>
 <c195b67c-4dbc-a8b8-8513-2664e1ca2404@dunelm.org.uk>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <c195b67c-4dbc-a8b8-8513-2664e1ca2404@dunelm.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood wrote:
> We should be removing the entry entirely if the user removes it from the
> todo-list see b3b1a21d1a (sequencer: rewrite update-refs as user edits
> todo list, 2022-07-19) where the commit message says
> 
> 1. If a '<ref>/<before>/<after>' triple in the update-refs file does not
>    have a matching 'update-ref <ref>' command in the todo-list _and_ the
>    <after> value is the null OID, then remove that triple. Here, the
>    user removed the 'update-ref <ref>' command before it was executed,
>    since if it was executed then the <after> value would store the
>    commit at that position.
> 
> I think that is the best approach but it seems the implementation isn't
> actually doing that.

Thanks for pointing this out. This approach seems to have only been applied
to 'git rebase --edit-todo', so ideally the fix will just be "do the same
thing in the initial rebase."

I got sidetracked yesterday and didn't get as much time to work on this as
I'd liked, but I should be able to send a patch today.
