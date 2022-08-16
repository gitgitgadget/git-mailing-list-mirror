Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07EE5C25B0E
	for <git@archiver.kernel.org>; Tue, 16 Aug 2022 16:04:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235772AbiHPQEj (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Aug 2022 12:04:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235441AbiHPQEH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Aug 2022 12:04:07 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D1ADDE8F
        for <git@vger.kernel.org>; Tue, 16 Aug 2022 09:01:02 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id ch17-20020a17090af41100b001fa74771f61so1763808pjb.0
        for <git@vger.kernel.org>; Tue, 16 Aug 2022 09:01:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=FlC4kBNsWvtngam8k8XZmD41svU7azmGm+GEnLy4jMo=;
        b=NantPgGxDLIGX8zvvr3ItSqY7DmDx/yka0xhVD/pvaZiVM++Dsgp3EQjOK9Zxo7QsT
         hkdrXbHsfFIKwgL0NSBxm0AUqe+KdmDcRzdQAtzdsJ/fP38cxf7BTzl+NotBipyxM+fK
         GWisjLDDtUA64Lr1v56+J3SiIb9BSVVnQ44xjSjfvta13Tdc055yIzU34caho6jYgWoq
         7paAGbzjrPVVraWmFPKonNiQNpAOO6O8WbOo3aYBOoNAYQfJFX33yEzxFVrq4knb1wMi
         61EZhVSik4kb8UvdzJDoIWZKwinyuWW+vzLod6Qevq7IQ8MEDy+3b9Ez21cJqI1RQ/Lz
         g/mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=FlC4kBNsWvtngam8k8XZmD41svU7azmGm+GEnLy4jMo=;
        b=fS4QTmUAIl01lqHFQyzzBDnvEXoIq8fkWoKUql1m0+bg1fcuZ/1YMMt78PWpcGv1jY
         9bN6v9dA4epNWh9AKgQtDyWrYnOadIWpkMDsiXd7CrVfdmpRroursQCdIGhthuXOvgvH
         HdixIRArdjyzBYGyxc5f0sidbxa0HZtydllrylHNhpXIV/OJJZ/Vgp/F3GPO4Vu/oi6o
         TvFmugzLSIR+sEzb23ef0ovQOxuQvPkvrICOff7bRRTAve3pwxgfmsc7jZLmsPWyGn/S
         Gt+NEkxT397ErI9LxZdUDRi5+P9aMFCUJhZjNQQw9edDzdFAAxhDaozUU0g4u40SivdH
         2HHQ==
X-Gm-Message-State: ACgBeo3X/Hnn1dQh/o01Xa2Nuf3Q0fhWrwd7YDJL24nnDSgqx5Zy2n3Y
        uqOCslcFB9Kt9rfZV64BiJTpa4sy5itq
X-Google-Smtp-Source: AA6agR494vCLFyPLwuZjjHc+ssgGoIoRQbqJjV8tmNQt4fW7tk0F+Zk+F4EVhhOcjCD0oJqjY0Pwbw==
X-Received: by 2002:a17:902:cccc:b0:172:72e0:faeb with SMTP id z12-20020a170902cccc00b0017272e0faebmr8346112ple.123.1660665661541;
        Tue, 16 Aug 2022 09:01:01 -0700 (PDT)
Received: from [192.168.0.104] (cpe-172-249-73-112.socal.res.rr.com. [172.249.73.112])
        by smtp.gmail.com with ESMTPSA id x125-20020a626383000000b0052f2bc783basm8649839pfb.117.2022.08.16.09.01.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Aug 2022 09:01:00 -0700 (PDT)
Message-ID: <2b19b57b-b6b1-8214-d1fd-3ffe9eac2d9d@github.com>
Date:   Tue, 16 Aug 2022 09:00:59 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.12.0
Subject: sy/mv-out-of-cone (was Re: What's cooking in git.git (Aug 2022, #05;
 Mon, 15))
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqq5yityzcu.fsf@gitster.g>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <xmqq5yityzcu.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> * sy/mv-out-of-cone (2022-08-10) 9 commits
>  - mv: check overwrite for in-to-out move
>  - advice.h: add advise_on_moving_dirty_path()
>  - mv: cleanup empty WORKING_DIRECTORY
>  - mv: from in-cone to out-of-cone
>  - mv: remove BOTH from enum update_mode
>  - mv: check if <destination> is a SKIP_WORKTREE_DIR
>  - mv: free the with_slash in check_dir_in_index()
>  - mv: rename check_dir_in_index() to empty_dir_has_sparse_contents()
>  - t7002: add tests for moving from in-cone to out-of-cone
> 
>  "git mv A B" in a sparsely populated working tree can be asked to
>  move a path from a directory that is "in cone" to another directory
>  that is "out of cone".  Handling of such a case has been improved.
> 
>  Will merge to 'next'?
>  source: <20220809120910.2021413-1-shaoxuan.yuan02@gmail.com>
> 

After reviewing the latest version [1], I think this is ready for 'next'.

[1] https://lore.kernel.org/git/52b67242-5d91-5406-9c95-9d8ddc49c079@github.com/
