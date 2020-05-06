Return-Path: <SRS0=4z2X=6U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA578C28CBC
	for <git@archiver.kernel.org>; Wed,  6 May 2020 15:12:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 943E02076D
	for <git@archiver.kernel.org>; Wed,  6 May 2020 15:12:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GHCMQXUq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729368AbgEFPMt (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 May 2020 11:12:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728784AbgEFPMt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 May 2020 11:12:49 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A90FC061A0F
        for <git@vger.kernel.org>; Wed,  6 May 2020 08:12:48 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id j14so1646008lfg.9
        for <git@vger.kernel.org>; Wed, 06 May 2020 08:12:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=2Ikb4zmsMuomhdrpEosokQSQfGUJLkIOSBgCWo7BlDw=;
        b=GHCMQXUqXRnk1fwmemDvZNQ3lM2OKQnCyCroDYizG/OsNJarKh0ID70iLyQPzpZMg5
         ACxzayby4CjrOQsYhTUtj1PFgq8B52sUYck+JoqukdNhmPLFJ94ne5ZfJvyKS1KwBWxz
         A81IssBMSBhizbFMjr70uff6nZ2RoKJm6v0WE4hEf/UIlFUaSQLpji+/ZagPkLKqW5Kf
         nACypsKNvrW4PjC8ZaZQ9HpHPCCkqrMeQF7r0n8rSNWEz+DuElA42d7G0zAirQRAkeeX
         Bi2ova5UU1omDB2I7zVwTpoHdhy2fE74Swg42S6INvb/h8WphmwcKlvGb4nRpPzcS7AK
         gIMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=2Ikb4zmsMuomhdrpEosokQSQfGUJLkIOSBgCWo7BlDw=;
        b=lTirJ6mH04A9cVRRcrOtTYdNmJIvMdjmnJtW4smUdPlmw4xEfe7t+DSczsQWgNNEAG
         jO6dWpjK3j/7zv8dqm3yzhzv1yYFvoM1ds/LOKM9A2/1XK8gIK+XB31w5Y+msOHn71xZ
         ZteExv0YmwGq5WjY/Y9kRUvGA2EcA9iJe0o7VOMOkaAHJoQIHmRrCEmTaEL0CHBnts4G
         R3rLXwrY/++8szra57lQtVCivqz2jqWjFIR2XdMMXbvUXyqgHxlMailbaZ/2jxSRMUac
         fLWnUhTPpGPy/EUfrc/8AGvFUZcUNlxe5Yl+VBjJXAOYWBnb2xZ93Nh7WojJxHV7RccX
         3QUA==
X-Gm-Message-State: AGi0PuZfTZ4+XiZ1eIWDO6OxNDUVeYx5LIHMtjRpMli/fzkQ1A5AVpgt
        +RM1buiWa65cFy+Q73mMhAsQ9iDm9p8=
X-Google-Smtp-Source: APiQypJaXWMnrAZmkzk6cxS7UR4oKnG38W/TxB2TtR4ubuu1Z1OLhJoglpGsxmbnYoFI5XhBmthp2w==
X-Received: by 2002:ac2:4213:: with SMTP id y19mr5197816lfh.99.1588777967070;
        Wed, 06 May 2020 08:12:47 -0700 (PDT)
Received: from [192.168.178.23] (aftr-62-216-206-147.dynamic.mnet-online.de. [62.216.206.147])
        by smtp.gmail.com with ESMTPSA id l20sm1818109lfj.10.2020.05.06.08.12.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 May 2020 08:12:45 -0700 (PDT)
Subject: Re: [PATCH] rebase --autosquash: fix a potential segfault
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Paul Ganssle <paul@ganssle.io>, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
References: <pull.625.git.1588624804554.gitgitgadget@gmail.com>
From:   Andrei Rybak <rybak.a.v@gmail.com>
Message-ID: <2367cf9d-2e37-b8c2-6881-f3e6c951a460@gmail.com>
Date:   Wed, 6 May 2020 17:12:44 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <pull.625.git.1588624804554.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2020-05-04 22:40, Johannes Schindelin via GitGitGadget wrote:
> However, as reported by Paul Ganssle, that need not be true: the special
> form `fixup! <commit-hash>` is allowed to point to _another_ fixup
> commit in the middle of the fixup chain.
>
> Example:
>
> 	* 0192a To fixup
> 	* 02f12 fixup! To fixup
> 	* 03763 fixup! To fixup
> 	* 04ecb fixup! 02f12

Could you please clarify if I'm understanding this correctly: does this
affect the fixups-of-a-fixup which were created by

	git commit --fixup=<pointer to previous fixup! commit>

? For example:

	* 0192a To fixup	
	* 02f12 fixup! To fixup	
	* 03763 fixup! To fixup	
	* 04ecb fixup! fixup! To fixup

Where 04ecb was created by pointing option --fixup at 02f12.
