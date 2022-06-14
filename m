Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 872E7C433EF
	for <git@archiver.kernel.org>; Tue, 14 Jun 2022 14:06:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237068AbiFNOGh (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Jun 2022 10:06:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230476AbiFNOGg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Jun 2022 10:06:36 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B365E3A72F
        for <git@vger.kernel.org>; Tue, 14 Jun 2022 07:06:35 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id e80so9471597iof.3
        for <git@vger.kernel.org>; Tue, 14 Jun 2022 07:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=FL2hiPeCbzRe7peppmK8gxxEGXjse/o9asubn0zmf28=;
        b=gvhFAuFQ877081De7+A/vPk9cNicyMt8nsXsOo09I4gd8Q/l160EXMJR9hImz1ofyX
         HxJ6L5mIAfZEN488XuDTT6T9pebN8s2795j6fgFoYWsviai/8jr+0gXqJ/277rzeS1bp
         wfg6q3jPLfIO6Db6tXbsIHkr1ywos9xdAYt7J1wexpb9a4Ecj0k47OcC8qnOynmCSBtr
         JnPFd0nrlXwoa0xWlRXasRvSoe1z3kguM1O22ZQn0jwwJplK3n8jO719GwgRPHKwCkBW
         rzkNj0DwVxjUIovmAzfrdP/HIFVuFZy7UKS5EGnFMcg857SJ4irS9xKeVLpI6W9MHnfT
         V1bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=FL2hiPeCbzRe7peppmK8gxxEGXjse/o9asubn0zmf28=;
        b=Yewz7NU38x+d+ZmmJ8jBJfCpK6ZqIKq+oKVYA3bCWyktSJq4PO4NX4OYQS6yvvqGRv
         rUWZ2xv3vUbr6eaenjGGmEuPFIHF16RdhHCxKSLuL7WLkVWO5pNyUE0zemM8XeQWKA5D
         50LBe3V5UrWUsDLEoWpTbjQyyjQn3rD9LC5uIrBKQ28FptOUaZfT8yOliFukADbQPEqP
         MCunZ5ywk+swuP1YNBENQeYMufTqs/QexBitVfaDFJAI7eMuFd1NHs6e6WvYOGDHeShI
         pWi0OaZr/FpcybrEqbeD7ZZbJjcUAeJlfw1aSSI4mZfkkNCtz5tF4xtzY7TWNzDXyoxY
         LSbQ==
X-Gm-Message-State: AOAM532MT1eKgWuGdNITp3uhOmIz3fldgOh9mNDUQNtQfLG0iuB/JlE/
        f0z7GRTOBfMJ/ZdRcWiETcAf
X-Google-Smtp-Source: ABdhPJziKEg+e9Chtqe8xbVyLfrSx7y9IbwydakNCy3W6mLpQruZGbGTsg8ApqAP+v6IaMJU8PZsOA==
X-Received: by 2002:a05:6638:1415:b0:331:d318:83ab with SMTP id k21-20020a056638141500b00331d31883abmr3083783jad.126.1655215595176;
        Tue, 14 Jun 2022 07:06:35 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:508:3b97:7c0b:efc0? ([2600:1700:e72:80a0:508:3b97:7c0b:efc0])
        by smtp.gmail.com with ESMTPSA id i16-20020a02ca50000000b00331b2dd285dsm4848830jal.177.2022.06.14.07.06.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jun 2022 07:06:34 -0700 (PDT)
Message-ID: <fa330b8c-e495-1ab8-2085-d1c2d7e06ff6@github.com>
Date:   Tue, 14 Jun 2022 10:06:33 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 3/4] fetch: use new branch_checked_out() and add tests
Content-Language: en-US
To:     phillip.wood@dunelm.org.uk,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     gitster@pobox.com, johannes.schindelin@gmx.de, me@ttaylorr.com,
        Jeff Hostetler <git@jeffhostetler.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
References: <pull.1254.git.1654718942.gitgitgadget@gmail.com>
 <4540dbeed385341f8c5b45134e1a65dc48c75b0c.1654718942.git.gitgitgadget@gmail.com>
 <5137243d-ff20-e184-493b-29af64c408d9@gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <5137243d-ff20-e184-493b-29af64c408d9@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/14/2022 6:10 AM, Phillip Wood wrote:
> Hi Stolee
> 
> On 08/06/2022 21:09, Derrick Stolee via GitGitGadget wrote:
>>           format_display(display, '!', _("[rejected]"),
>> -                   wt->is_current ?
>> -                       _("can't fetch in current branch") :
>> -                       _("checked out in another worktree"),
>> +                   path ? _("can't fetch in current branch") :
>> +                      _("checked out in another worktree"),
> 
> I'm confused by this, isn't path always non-null?

Yes, at this point it is. This message needs to change since we
no longer have access to the worktree. As noted in the commit
message, this case requires concurrent changes to the filesystem
to activate this logic, so having a simpler "branch is checked
out _somewhere_" message should work here.

Thanks,
-Stolee
