Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF6EDC77B7D
	for <git@archiver.kernel.org>; Fri,  5 May 2023 22:36:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231948AbjEEWgB (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 May 2023 18:36:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbjEEWgA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 May 2023 18:36:00 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C6452106
        for <git@vger.kernel.org>; Fri,  5 May 2023 15:35:59 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id 41be03b00d2f7-51b603bb360so2054977a12.2
        for <git@vger.kernel.org>; Fri, 05 May 2023 15:35:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683326158; x=1685918158;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=EK6YOf5TwuXVYLsT1ORHbnepOB7p7QEq9Ypv05Lc2IA=;
        b=ZuHhE4ecQZfe8ImWs52lf8f0Hi/ieM1pHmoTntGr43OER4kZBZHJLJnfZQDcJO5snD
         Y920mRIC0gwDagXT5qWgQCeZ+/01lDcjlHZJiw9IsXmtO4Rf9HK1cfcJp+T6GU+RI3m+
         buDv+XMt/Ai4U0c8tdEzirm1F2wf2ezvGxR7Tuzdwx1jL2/tVywEqMu6ny3sROXnK9ZR
         GGpuqOg0zv4ZrLVrBrQl1YkNWWVaHCQvP6xs7k618du8ytWdXyBArsHRFamYrnE2DIfa
         Ugoz3hG0DrRRtaWxVorzuund0kKr4yqpd0G3rd6WQuhdBU1Kr8QycHIea71ZWELg0uCa
         bkwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683326158; x=1685918158;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EK6YOf5TwuXVYLsT1ORHbnepOB7p7QEq9Ypv05Lc2IA=;
        b=XQ/ulDy2hkQOqJ3LE1Nu0S00rz/8aavz4FrM0l9x1k/WSzqcIrl6KA9NYNY1GSOOl6
         HbVHZa+udCwyFXjr0+wHkDzMyZwEybk7NgDnX1JdFQLSpu8pPbTB5lsg0fNSHAreROSa
         FS3RspsTJ4vPPA3UmEMc16QEUmDjZPNfQye5VJ8sZ2Zm1E1bh6M2ojrt6MQ9tQhfDILs
         oqHcUZitGsNm7c9UkWYCFFfrNv7jSntYhdvZ1aiDf4rsD6X+IU/y6cDDnqJN5QHv3KDe
         nSjsh6StF+99jgeHwulFX3tFP0Florc31skSbz9BMkKto3Y+pGXP/wYewrICgAcJzxTF
         yDGA==
X-Gm-Message-State: AC+VfDzzb5vErX5VJPisPKJsqieJDHs+XE6p4p/Nt1IL5ED31Hop8FN3
        UvRXEFoPs8iI8rC6Y81gF3zsVR4bOjQ=
X-Google-Smtp-Source: ACHHUZ55sPCb9MvHPD5mwcGOsvFy0/dUUbqvafUU1n06p8riyhhqR+c70q+jU5Aj7jiOCg9DK9jB0A==
X-Received: by 2002:a17:902:aa03:b0:1aa:f78d:97b7 with SMTP id be3-20020a170902aa0300b001aaf78d97b7mr2889553plb.46.1683326158286;
        Fri, 05 May 2023 15:35:58 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id bi3-20020a170902bf0300b001a04ff0e2eesm2256053plb.58.2023.05.05.15.35.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 May 2023 15:35:57 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "Adam Johnson via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
        Adam Johnson <me@adamj.eu>
Subject: Re: [PATCH] doc: merge: improve conflict presentation docs
References: <pull.1505.git.git.1683295133304.gitgitgadget@gmail.com>
Date:   Fri, 05 May 2023 15:35:57 -0700
Message-ID: <xmqqzg6ibe42.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Adam Johnson via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Adam Johnson <me@adamj.eu>
>
> Improvements:
>
> 1. Remove the sexist example ("Barbie... wants to go shopping")

"Barbie goes shopping" is a pretty common meme.  A random internet
search finds many of them, e.g.

  https://featuredanimation.com/barbie-memes/

If it is about only Barbie herself, not about any other random girls,
would it still be a "sexist" example?

> 2. Show real merge marker contents, rather than e.g. "yours:sample.txt".

I am a bit torn about this change.  While I can see why we may want
to show sample output that is bit-for-bit-faithful to reality, these
examples are written to teach what each part of the output means,
and comments like "yours:sample.txt" are used instead of the actual
conflict marker comments to be more helpful for illustrative
purposes, and this change goes directly against it.

> 3. Swap yours/theirs terms for source/target.

I am not sure if this change is as an improvement, especially in the
context of "git merge", which you merge their work into your history
[*].  Surely, it *is* possible to rephase what I just said to "you
merge source's work into target's history", but it makes the primary
point of doing a merge less clear.  But others may have different
opinions, so please do not take this as the final rejection on this
point.

Thanks.


[Footnote]
* Conflicts during "git rebase" is a different matter.  You
  tentatively put your feet in the shoes of your upstream people,
  whom you can call "them", and replay "your" changes on top of
  "their" work, and a conflict you will see during this process is
  what "they" will see, i.e. while you are resolving such a
  conflict, you are playing the role of your upstream people, and
  the conflict you see is shown from their point of view.  In that
  context, "your" vs "their" may be suboptimal.
