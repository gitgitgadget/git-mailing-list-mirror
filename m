Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D3D0C4332F
	for <git@archiver.kernel.org>; Fri, 16 Dec 2022 22:38:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229775AbiLPWiN (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Dec 2022 17:38:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbiLPWiL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Dec 2022 17:38:11 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA0B75F40C
        for <git@vger.kernel.org>; Fri, 16 Dec 2022 14:38:09 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id l10so3678731plb.8
        for <git@vger.kernel.org>; Fri, 16 Dec 2022 14:38:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DnmhZF5yFd2vxmsh6w3eZQeHG+xb52a/8gpmA5rtR+4=;
        b=lpjnpNrSssbwboyQNxm56kRjWAHLP2MEyirYQKdqBL8JZeJ0Agd1MdinQiZLxzHHdj
         i7gi2qj5R9hq2M2s3OlArZCk7EoRQAa5moOibN4ciK7+UUcagsECP3NxNRy6JbDGeJry
         wDVlyvR4V6MXC3ThI1NOv7P0Ee4gvsPsskhDffUndsZRNR4AQBYHjl8rPROowiO0mphJ
         KRxTPmfY3sKymyeYXOot04Z+v5/9FVf3hA2s32G9iKOnweTNBQiI7Yu8bJKF7DRVUhFJ
         tc/agER5ePamNhqQlIcUr0h3TTUlZZAXvxPtD0zAB52VZE6Bs71xFZyMOTHGte/O9nio
         DDRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DnmhZF5yFd2vxmsh6w3eZQeHG+xb52a/8gpmA5rtR+4=;
        b=FzpWJVibjol/b2qTihjbdWcFADWKzS3SeAJafJ+XCLFTTuCjkIxlQZDxWKZOS7efCQ
         +fQVxV8LGBmjBKCLqncf8Ivy5oHaAOxnl4536h2rRWUSoEn5nmLdEzlFujYFeWQUM71D
         t8OG73250kaCSHCdimcrUY+LVyRrIjMZEbRQJBjyK5x0ASnXvXgXTRs61HgwbXVvRCA6
         CrlyAEIv6Sb/oW08REx/W13wdw1eRWNYfJb3U78qSsl9WCXLbIitZ2WJUU8YW1My2Cu3
         tIOaLKUteYPBmKVfsLgX+TfTgV3gn9tqfvoiu2CgmnMxmPoirRMN2joVVl+9Tttv1aAu
         +bKQ==
X-Gm-Message-State: ANoB5pmD+WYdu/aEKmqt6Fwqq9xG6aNqgVBOoIcOGnkkL8h/PNG2j0YA
        x46F/BOnjoySMd1HX+U7HHg=
X-Google-Smtp-Source: AA0mqf7i6yY6O2Eqy/vMp3ADIVTnkhCBrvpaHZnRqxvyH5cFZ2nNOXm62IqPdbcDpaStgUSdZpZ1rg==
X-Received: by 2002:a17:902:6b02:b0:187:1fc6:6a13 with SMTP id o2-20020a1709026b0200b001871fc66a13mr35186609plk.49.1671230288951;
        Fri, 16 Dec 2022 14:38:08 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id u17-20020a170902e81100b00186b04776b0sm2122877plg.118.2022.12.16.14.38.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Dec 2022 14:38:08 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Karthik Nayak <karthik.188@gmail.com>, git@vger.kernel.org,
        toon@iotcl.com
Subject: Re: [PATCH v3 0/2] check-attr: add support to work with revisions
References: <20221216093552.3171319-1-karthik.188@gmail.com>
        <221216.86k02r1fcl.gmgdl@evledraar.gmail.com>
Date:   Sat, 17 Dec 2022 07:38:08 +0900
In-Reply-To: <221216.86k02r1fcl.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Fri, 16 Dec 2022 17:17:48 +0100")
Message-ID: <xmqq7cyrm0tr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

> So we could invent that as this series currently does with:
>
> 	git check-attrs --revision <rev> <attr>... <path>...
>
> Or, as I suggested:
>
>         git check-attr [<rev>:]<attr>... -- <path>...

What does <rev>:<attr> really mean?  As the syntax for the proposed
feature, I do not think it makes much sense.  For example:

  $ git check-attr HEAD:text HEAD^:text -- README.txt

 - With which README.txt are we checking the attribute?  The one
   taken from HEAD or HEAD^ or the index or the working tree?

 - When we say "README.txt has the text attribute", how does the
   user tell which "text" applies to the path?  From HEAD?  From
   HEAD^?

 - Does the same attribute 'text' have different meaning when coming
   from two different tree-ish?

Compared to that at least the proposed one makes it fairly clear
that we are talking about things in a single tree-ish consistently.
