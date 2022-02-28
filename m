Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD624C433EF
	for <git@archiver.kernel.org>; Mon, 28 Feb 2022 11:02:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232778AbiB1LCo (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Feb 2022 06:02:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230405AbiB1LCm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Feb 2022 06:02:42 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9F756271
        for <git@vger.kernel.org>; Mon, 28 Feb 2022 03:02:03 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id w3so16977167edu.8
        for <git@vger.kernel.org>; Mon, 28 Feb 2022 03:02:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=yvD76Ixl8CQ+jDSfOW7xGUfAM2H03CCRNqsfkAtN14w=;
        b=gLkKQImnyj6NkeIYG7IP1FzOrnvdn+9P+td4mpwp2q2r1FJpU8Fk/9W5shYTF+4PNJ
         9RILWJh4pQfdDs88ZtEff4+7RZQ5qfkHT87AOBS6V8mLSweZzN5HroXvkiwX2mj8IgOm
         6QgT+vkwMqfAaTROSL4DAjKcOOcf/6OAlLrazRPECCD520rC4ebfnddr8FVLv+GGrdBW
         L9S8Y6VNSPseJVfTezyM3sZXlGVn6ebEEFFQqS9iEvTRVwBcLVVmV7+2QXb/ZD7eDBq1
         uOxtl35wy6XYo+9hfKH8vuWbe7ylCR5+pn1HSrB8WWFVELH8v+m0VlIOAXLZU8tA6der
         D4fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=yvD76Ixl8CQ+jDSfOW7xGUfAM2H03CCRNqsfkAtN14w=;
        b=C5FP/JjZKvpCn1Wt3l+xsykrSS3kiZ8sVr9TlpYzXlLv/STFAECr3XdW2a92GO0lMh
         mqaAIy1gR7aU2GOiLwjvkgmjQwJ59ljYeIMPIVqAn5WfQgzUWLRYHvHSvw165qPFWILW
         2qutoNPofOCqfNrRqMCpp1xp2UzJ6IQ8leQFOods1pBoBI/9dTBTO8MI17t9USU5814h
         k7YwL+0j0XWsOitDfKn7WWJz0eoOqohBoH7n2erjxrA+aDmylO9EFt4d6Zt1OT4hIJ1j
         30z5VqroeuRK2MxLR5f2eUN74oJm45D/+uMNBthreIP9hIh8I02ci+hix0QA/FN0UEyT
         Hbvw==
X-Gm-Message-State: AOAM530W8hizKQVQhzIgWkIUpOd0+HN5yH+XTak6Bwy2jhrsarJ6imG0
        9X6MPpZgPfN6isCt2MpwsHd9tu/Qrpk=
X-Google-Smtp-Source: ABdhPJxOALMlpvWOweCgCSBXj+vPMEfI+550GHixF5sV5Qm6Cr1fNLXyntGOn7b9FXBSct4YvxWW3Q==
X-Received: by 2002:a05:6402:2386:b0:413:ba6f:217c with SMTP id j6-20020a056402238600b00413ba6f217cmr4471270eda.344.1646046119776;
        Mon, 28 Feb 2022 03:01:59 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id gb25-20020a170907961900b006ce423d43e1sm4278781ejc.13.2022.02.28.03.01.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 03:01:59 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nOdmw-001IuS-In;
        Mon, 28 Feb 2022 12:01:58 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Rolf Eike Beer <eb@emlix.com>
Cc:     git@vger.kernel.org
Subject: Re: Please add support for "git merge --continue -S"
Date:   Mon, 28 Feb 2022 11:58:11 +0100
References: <3769291.LUJhsIL6D6@mobilepool36.emlix.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <3769291.LUJhsIL6D6@mobilepool36.emlix.com>
Message-ID: <220228.86fso35k61.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Feb 28 2022, Rolf Eike Beer wrote:

> [[PGP Signed Part:Undecided]]
> Hi,
>
> I usually sign my commits and merges. But when a merge has collisions I can't 
> continue and sign in one step, because --continue and -S seem to be mutually 
> exclusive. My way out is:
>
> git merge --continue
> git commit --amend --no-edit -S
>
> ... but this could be a bit simpler. Or maybe --continue could remember if I 
> have passed "-S" to the original "git merge" command.
>
> Regards,

You can just drop the use of "merge --continue" entirely and use
"commit" instead.

Caveats related to this were recently discussed on-list:
https://lore.kernel.org/git/CALRdAfcyfesNqfLhhe2GW_5V9s2hf++i6mZS1Lw5hqQYTca85w@mail.gmail.com/

As noted there I think this makes for confusing UI, but you should able to just:

    git commit -S
