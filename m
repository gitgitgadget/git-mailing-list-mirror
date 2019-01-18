Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C84101F454
	for <e@80x24.org>; Fri, 18 Jan 2019 17:59:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728678AbfARR7W (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Jan 2019 12:59:22 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39284 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728080AbfARR7W (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Jan 2019 12:59:22 -0500
Received: by mail-wr1-f67.google.com with SMTP id t27so16125558wra.6
        for <git@vger.kernel.org>; Fri, 18 Jan 2019 09:59:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=JFG93tcGXUVOBvU3rR8qlnJUR+CIpbQ6nPkYUNAJ64Q=;
        b=KSZu6jOFVms79I4RdCKjKtLxTNoux8xji5xMhk37YVNL0NehwjBFZikqwhULcKm9qU
         oAPljUzQTNfe2ZrrEBWVdHFl7B7Lky/2vCq9zu0q2jv2XiO28XGgKVv4LgJNqGBD3W/K
         RLe35/v5hkL6I8lHWX988xC5x8cWEPyojo5RzX28osXtDwF3VBFUvZlr5esZ3Z5XR/7+
         OBM3WeLojkBz8gyZwKsDrLPAMM0gx6eL8wXZhWcGkj6U1GUX+CkwfS8OX+sRwWCBt4mq
         xVDg9LJBKuM4swTnrcfUIoYtPVHgL1IM8is4oW7mEWNdKfWNw7/miPnFvQD1FgHKmWt4
         tuqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=JFG93tcGXUVOBvU3rR8qlnJUR+CIpbQ6nPkYUNAJ64Q=;
        b=YUFh4D3ggstC4lm7BOHrdt3HPR7ohck9aQxpp5iRnTij3eA0HugVm1glOfcRJFTmiy
         SkQTnPwkOV8MNjHsxe1AXFCpdLoYLrj/HT0e31a2+0FOAuHCkmkNzQKEal8+UGwiGpl2
         EaIsQKg8jYpKKB0RVkF+rQaYGikz45JkxU3lKNLhUdlD7Ep9xIg7qDigRh3atkzL88Zz
         b8p2bNgEHNheDVmTr68d2LfkPFPvPndG+72LuzhUnNmA9lE5mwCDohso0OLpB7XBXNW9
         UhU8W447zeXOF50czRVI9asQfo25CAP9KT9Ns0zzdZfAvrEUwbu/qhYKFGPEnllXeCV0
         tPVw==
X-Gm-Message-State: AJcUukeAqHSqyTRJmpsl1p+j0NWdDdHxCXvpaxVR2ujnYI96t5Mj3a4e
        9i850TUVLBA2AtKM/5si01Q=
X-Google-Smtp-Source: ALg8bN6IijmPG9ThLMuEuZTbQLWa/eHbx7OjvhDgWoCZSf/J/N/GRF/8CIGaHQb8GKMbuwOaXmAULg==
X-Received: by 2002:adf:fc51:: with SMTP id e17mr17253788wrs.268.1547834360457;
        Fri, 18 Jan 2019 09:59:20 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id s8sm98649008wrn.44.2019.01.18.09.59.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 18 Jan 2019 09:59:19 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
        Orgad Shaneh <orgads@gmail.com>
Subject: Re: [PATCH 4/4] built-in rebase: call `git am` directly
References: <pull.24.git.gitgitgadget@gmail.com>
        <2b5ece8263936f0a7dfad864c0de43d784fdaf1f.1545398254.git.gitgitgadget@gmail.com>
        <xmqqwonkclpx.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1901181443350.41@tvgsbejvaqbjf.bet>
Date:   Fri, 18 Jan 2019 09:59:19 -0800
In-Reply-To: <nycvar.QRO.7.76.6.1901181443350.41@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Fri, 18 Jan 2019 15:15:45 +0100 (STD)")
Message-ID: <xmqqimylludk.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> Overall, this was quite a pleasant read and a well constructed
>> series.  Other than two minor points (i.e. interaction with the
>> 'post-checkout hook' topic, and discard_cache() before calling
>> move_to_original_branch) I did not quite understand, looks good to
>> me.
>> 
>> When merged to 'pu', I seem to be getting failure from t3425.5, .8
>> and .11, by the way.  I haven't dug into the actual breakages any
>> further than that.
>
> Sorry for the trouble, and for my silence (I was heads-down into the Azure
> Pipelines support).
>
> I did not see any breakage in `pu` lately, hopefully things resolved
> themselves?

The (semantic) conflict resolution can be seen in

    $ git show 'origin/pu^{/^Merge branch .js/rebase-am. into}'

which is recorded in my rerere database ;-)
