Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BB1101F6AC
	for <e@80x24.org>; Mon,  9 Jul 2018 22:27:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932845AbeGIW1K (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Jul 2018 18:27:10 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:50413 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754326AbeGIW1J (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Jul 2018 18:27:09 -0400
Received: by mail-wm0-f68.google.com with SMTP id v25-v6so22663726wmc.0
        for <git@vger.kernel.org>; Mon, 09 Jul 2018 15:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=kVzX3gL1h4ex731foFeKyLpstgJEndxh2Bwr1eB8wDE=;
        b=COQr1jPI/fJ/9GAUFAHBgKfW3/rk5KGEozBJzL1J91jDZQp+lBRICv93rFxqDFT87p
         iE9Fzi1Ntzp8prxfSYRKbldUXdEswLlrrpgPDQ1qhmHcu6yRQ9FiVsX+iDtEg9ysrDT8
         8vmlYsU1UVmIHyVRW5iDCQVg+u/sPtkkN0j5z0uMMGlSmVbUbMz2M31dcY2WLhlHNp/m
         xCnZJoOTdQzz7mpNfBpgBUIInm/KmAg77c9iNfddBnOpRFVu7QCFi3PDP7CQMC/rx5cu
         DBSIb1IajH8cSbGshRcwlzO1CETjAL5RY4t2mqXfjfqYGyDKCYsI3uIvsJHhQJA2ssn+
         GoKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=kVzX3gL1h4ex731foFeKyLpstgJEndxh2Bwr1eB8wDE=;
        b=sXN+/TQzGa8uEN62ESCx0O22ikglLiFIXoGobfDGfojYUzeXxNM7XYutMD4vaj4yED
         JuBI8zjJU4ncs/6nxt5i/ncQkm4jdeachB9mwZE2kj/cZqlEgVRf1NCw2FAfNDvh6nuv
         S/ChfnqaHGGHWGGn1/xVW8Q342yLGr7HlgqGxAw1Dwcb88ni+M9Q4IbiEdV9lBxFRNRx
         JBUG+rnoCbd1IdLkAD/jpF+9UhJ3wM/ndzCy3tGuqL5pFirTQv34XQcBfss7jRKXutUU
         H7CyCQeyuKuMNM0O3lyFOtKZy9v5pXM8NAgBlr27XwT3fAL/OrJ1DOPXKg25hJjpFi4D
         8bqw==
X-Gm-Message-State: APt69E0/Eod+caWRcuCyuXsnpUZ/cb5OvmOLDS+15xUO6tixfdIds0gT
        RY0CzYUJSleGKjEKEUtHaeY=
X-Google-Smtp-Source: AAOMgpcw7cqL4Q7bafjG102j67ePkSxwh2RlJGHWU8iY1O7W29hbIeGIb38nhtWHBy36G7YwA3kP0A==
X-Received: by 2002:a1c:8587:: with SMTP id h129-v6mr9734368wmd.105.1531175228464;
        Mon, 09 Jul 2018 15:27:08 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id w24-v6sm13831212wmc.15.2018.07.09.15.27.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 09 Jul 2018 15:27:07 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>,
        Derrick Stolee <stolee@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 on ds/commit-graph-fsck 0/6] Object store refactoring: commit graph
References: <cover.1529616356.git.jonathantanmy@google.com>
        <cover.1531168854.git.jonathantanmy@google.com>
Date:   Mon, 09 Jul 2018 15:27:07 -0700
In-Reply-To: <cover.1531168854.git.jonathantanmy@google.com> (Jonathan Tan's
        message of "Mon, 9 Jul 2018 13:44:34 -0700")
Message-ID: <xmqq4lh8avus.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> This is on ds/commit-graph-fsck.
>
> I saw that ds/commit-graph-fsck has been updated to the latest version
> (v7, including "gc.writeCommitGraph"), so I've rebased my changes on top
> of that branch. There were some mechanical changes needed during the
> rebase, so I'm sending the rebased patches out.
>
> I've also added a patch (patch 1) that removes some duplication of
> implementation that Junio talked about in [1].
>
> [1] https://public-inbox.org/git/xmqqefgtmrgi.fsf@gitster-ct.c.googlers.com/

While attempting to merge this topic to 'pu', I noticed that you and
Derrick are perhaps playing a game of whack-a-mole by you getting
rid of core_commit_graph global and making it a per in-core
repository instance, while Derrick adding core_multi_pack_index,
making it necessary for yet another round of similar clean-up?





