Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B27A1C61DA4
	for <git@archiver.kernel.org>; Thu, 16 Feb 2023 22:21:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbjBPWVj (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Feb 2023 17:21:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbjBPWVi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Feb 2023 17:21:38 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95B0A4AFE8
        for <git@vger.kernel.org>; Thu, 16 Feb 2023 14:21:37 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id d8so3620074plr.10
        for <git@vger.kernel.org>; Thu, 16 Feb 2023 14:21:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iqvCvjPJxQziEzZrY8VZgDocVd0j22xuRwBTEym0aZE=;
        b=eoG0GKmjckiRplOTs3qQXa+fmt297/SJxjWulQ7gbBrRwA9ngWGoi8JCLxzBJDDUb/
         +xs3pVJAjumD9MgjH92Lkmb1Y0RnDHzGeUHovlLzOVIY6YXJ+GEDikdNxXafuQqt0jNn
         byPV4RIlUigGVFrOYDA03LWO5Tk5mkCYG6R1UXnIRfUOZ2H6PLSGvOGzpoYH7IK61zHe
         NWuznuaMShKvlQFPMVXrb880wMWTu17XNF46RCrYHtgaLDpz9nimDssKVuBsEM1G3bTZ
         88nctFA+lI+qqyh4Mep0CErWnJbQFRhVMe6FicwNsbsPmmyBOkpYI0a5mJUWhP7rOL+V
         v2LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=iqvCvjPJxQziEzZrY8VZgDocVd0j22xuRwBTEym0aZE=;
        b=DtQ2nLKhevBBIIGHZ0FXH0wNG4kkfd0P4FRB7CeU8Yv0ek3wcIIgSPGMP8cjo9aqK/
         YiTgNYaTiYKnwS9jJbfgQ2KUiOQ5Zv9qj6ycit+Yt07vxMGhaoRWe9NFbWNZqOh1m65j
         ttwoFDOSd2FPyAq/W9213FnU3WGD6a5I/8pCAxwyKtfLB99l3vkUU7Jw6sPhIfeC8wTc
         e5fbYnF2J0A/R9iueON6GP2p6QqXCthPkTsTqwrAI5BZJlWuF8nKMSZRf2kUr3TSEwHp
         PAlSv+9AZSbPmAnl64sIgRA2J79rGkL+5Y+5x85sHbC38x8Xafv5+rpikMyWreWrdyvd
         EoFQ==
X-Gm-Message-State: AO0yUKVAN03DxeuBmzhfJewJxtGuzJB1PAKvBr7V/7B5JHp/KX7tTboC
        WNQE3cEMqLE4UoM4QJx3MCU=
X-Google-Smtp-Source: AK7set8BQEKY9tBtG4fjYP460kq4MmjtsGQgWEbFJdFTy+nwF6RkPrncbsQXnzOZthCAo8K9aqextQ==
X-Received: by 2002:a17:903:2444:b0:19a:5958:15e7 with SMTP id l4-20020a170903244400b0019a595815e7mr3652688pls.15.1676586096913;
        Thu, 16 Feb 2023 14:21:36 -0800 (PST)
Received: from localhost (252.157.168.34.bc.googleusercontent.com. [34.168.157.252])
        by smtp.gmail.com with ESMTPSA id f3-20020a170902e98300b0019a81a8bb14sm1812222plb.32.2023.02.16.14.21.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Feb 2023 14:21:36 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Raul E Rangel <rrangel@chromium.org>, git@vger.kernel.org
Subject: Re: Feature request: Add --mtime option to git archive
References: <Y+6G9n6cWRT9EKyl@google.com>
        <Y+6akicTFG9n0eZy@coredump.intra.peff.net>
Date:   Thu, 16 Feb 2023 14:21:36 -0800
In-Reply-To: <Y+6akicTFG9n0eZy@coredump.intra.peff.net> (Jeff King's message
        of "Thu, 16 Feb 2023 16:05:22 -0500")
Message-ID: <xmqq5yc1p7yn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Thu, Feb 16, 2023 at 12:41:42PM -0700, Raul E Rangel wrote:
>
>> When generating a tarball with `git archive <tree>`, `git archive` will
>> use the current time as the mtime. This results in a non-hermetic
>> tarball. Could we should add a --mtime option that allows passing in
>> the time? 
>
> That seems like a very reasonable feature to have. Just to sketch out
> the implementation, in case anybody wants to work on it: ...

There has been a discussion on not just "fix mtime" but coming up
with a lot more stable tar archive format specification.

The first link is about documenting the status quo.  The second one
is about the proposed format that aims to be stable.

https://lore.kernel.org/git/20230203080629.31492-1-ray@ameretat.dev/
https://lore.kernel.org/git/20230205221728.4179674-2-sandals@crustytoothpaste.net/

