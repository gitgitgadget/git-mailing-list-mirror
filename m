Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9C01C6FD1C
	for <git@archiver.kernel.org>; Wed, 22 Mar 2023 19:16:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230026AbjCVTQZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Mar 2023 15:16:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbjCVTQY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Mar 2023 15:16:24 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 859DA5DC95
        for <git@vger.kernel.org>; Wed, 22 Mar 2023 12:16:22 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id n20so7160129pfa.3
        for <git@vger.kernel.org>; Wed, 22 Mar 2023 12:16:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679512582;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Loa2nV3VOgsSnV2EDIUjMnDw1wP05mm1lONGlulW2wc=;
        b=Gj+uwj3zOJAwRS+s5j5+GkRyFX6EUsO4uPOLeUomXR1QootjQ7LPNOs/vczlXaq+HC
         sAi6BLNZmPAiUtU1+gCNHzmOjD0AxAEs3so0SYNBfpQGhI/l6Lax/pPd786QLoQ0LUoD
         rhHnNzMx/Y7QYb6OyYMcXMRoIEIHwpBnN/mvZxcunSdea71kmPJqPM4E7556MxEdZOw5
         NRlvJDPnJru3KKtNJsxJIiNCoJLRHKAuXRZcQIDSguvAcYgCJGpXY6+Pw/iiitsHuAHO
         amj0zuYNOQTI8NRvPCUOQcIJo/QGYsVHnnboiNqkmcBA7nWUl8huCntwgwyDf/WY7pFh
         Xs+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679512582;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Loa2nV3VOgsSnV2EDIUjMnDw1wP05mm1lONGlulW2wc=;
        b=KmvVqZgZc0U+CDwq8LYoOWqTJQHAbYVW2pypm2i7ETaJjmJ1G99MyIYTLz6XZORjmT
         0eB9E+qhCFK65fomfUv9VjOpd79md7rDOrdJc3qDCJBZaSzyTdyNS6GF4blr84t5hj+z
         CYMf6MeVHqz1pn+P5YWGp8d2m/ewaiPmgWzljf6jiwjid6ytKXWY32wvDTkJvuT8PvdU
         Wx+81o8dAZTmSFn6npIfRj+khFOhRpRolWrpAz26H77k6kerxx8jgeZPb9FvJBmhBF6y
         2vND4+ma7Iys+1BzO2+5H/c4RSUj8tUQZo9fT6WQ5mLmB8H4aimaNlFUYChKTmlJx+SW
         tPNw==
X-Gm-Message-State: AO0yUKV0Cl3adn6WfS3nSquu0hjdM1CMtYiXBxugS+T8UCn7wRHGCnof
        g5T5jj3V2i/i5z5hqvq3YahwjGE2ic8=
X-Google-Smtp-Source: AK7set8EqK76GFbZMwEiDvB5l37YbnMrJQB1ecr4dUTFjnqpzDorJZJR5GOQPSmChiP4xBelp6bz+A==
X-Received: by 2002:a05:6a00:4f:b0:627:f1f1:a97d with SMTP id i15-20020a056a00004f00b00627f1f1a97dmr4077681pfk.24.1679512581973;
        Wed, 22 Mar 2023 12:16:21 -0700 (PDT)
Received: from localhost (83.92.168.34.bc.googleusercontent.com. [34.168.92.83])
        by smtp.gmail.com with ESMTPSA id u20-20020aa78394000000b00608dae58695sm10323508pfm.209.2023.03.22.12.16.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 12:16:21 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Victoria Dye <vdye@github.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: Git 2.41 release date
References: <f337e514-8d3b-927a-5fe3-34f67f199435@github.com>
Date:   Wed, 22 Mar 2023 12:16:21 -0700
In-Reply-To: <f337e514-8d3b-927a-5fe3-34f67f199435@github.com> (Victoria Dye's
        message of "Wed, 22 Mar 2023 10:59:50 -0700")
Message-ID: <xmqq7cv8egvu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Victoria Dye <vdye@github.com> writes:

> While perusing the Git Calendar [1], I noticed that the final 2.41 release
> date is on a major US holiday (Memorial Day, May 29). In the past, release
> dates have been shifted to avoid situations like this, and doing so has been
> noticeably helpful to downstream maintainers/integrators. Would it make
> sense to similarly shift 2.41?

Surely, I will be accomodating, of course.  Thanks for spotting.

How does Thu June 1st sound?
