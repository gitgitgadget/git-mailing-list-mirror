Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AA1F81F597
	for <e@80x24.org>; Mon, 23 Jul 2018 20:41:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388052AbeGWVoL (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Jul 2018 17:44:11 -0400
Received: from mail-yb0-f202.google.com ([209.85.213.202]:44634 "EHLO
        mail-yb0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388022AbeGWVoL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Jul 2018 17:44:11 -0400
Received: by mail-yb0-f202.google.com with SMTP id 189-v6so903078ybz.11
        for <git@vger.kernel.org>; Mon, 23 Jul 2018 13:41:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=FCc3X1ywJsCrOIb7fUl3L1S/PqJLipbWr94wtglLwvE=;
        b=vFQoUH1n/FK/Ci3QDryblQJ2dPrwrczYm+b7UEXDAIf6meCuyz9mDL/rTCKyh7ZYpp
         rhQlElpuEUm3wTCCyiQs/l99c/JST2CLEqrxCSqDv5EWwhEUdj1PJDPYRfndchw6sutB
         LYYzH9ck9nMS/31hgJCz/KVkRbELoNZQxfIZPg8JOl+ObI+vymLwOF5/1nd5BtcWZxtT
         uUewSXr8Iuj6S68c4ceaIO51Th7v8MvmeBBBHLmR6wMtgtpt27zp+D5FFtZxrPVfB9Fo
         nPGzCEIP1ZkxI6t6RbtCVHZClusiNzZAdSEDESKwPgzqB79lUfHBxHTl9MopAut5QTEP
         9O3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=FCc3X1ywJsCrOIb7fUl3L1S/PqJLipbWr94wtglLwvE=;
        b=nNkp2M8IRTmEiyWXQm3y5p8R2HwG6C5D/wry5wJtAdKC1Zw1s3DPZM9F+5WBc1bv9i
         2dsbUVPLF3nzDHVjlnl0a0wwfWAd/txkDEoQ5xGhdMx46JmvonnZ0V2T8NzUkTYl6Fby
         GhA5cbVubC/Wwq4OAWyYXez1H86mBJ5X50T4xUYutqS44+tLdI3JV8nEp6udJPS9jdUa
         4oB8Ip88ppDP1MPf6xS4G/BKS4bhk0SApJioqZ2m6dCUL49WJkkBV/iGL789rt2TPEJU
         G/Z9Mc7NbpWZMQXEmR8E0kJWWnoG3BqkX4z/RKt9r1NoPNw2JFeDEu2KRxbDAFTvBd6d
         wl6A==
X-Gm-Message-State: AOUpUlFR4sMSNBjDi28r3W5y25KXpkpXxcQSOo2HL2CNuobfqpTlK+tS
        fXaeJ7muZD5JSzuDSIy9N2TBQhc/fqXSGiHkmm9o
X-Google-Smtp-Source: AAOMgpfJRaSvvXoLfSxQzvv4byDeUKlhCxb7vKTdwAyYNefPSyobHKqMW9MSE+ZUVb5Kw8I8smOXKwU/4LyK0RRDfZJl
MIME-Version: 1.0
X-Received: by 2002:a25:1e87:: with SMTP id e129-v6mr3981017ybe.48.1532378475665;
 Mon, 23 Jul 2018 13:41:15 -0700 (PDT)
Date:   Mon, 23 Jul 2018 13:41:12 -0700
In-Reply-To: <20180720163227.105950-18-dstolee@microsoft.com>
Message-Id: <20180723204112.233274-1-jonathantanmy@google.com>
References: <20180720163227.105950-18-dstolee@microsoft.com>
X-Mailer: git-send-email 2.18.0.233.g985f88cf7e-goog
Subject: Re: [PATCH v2 17/18] commit-reach: make can_all_from_reach... linear
From:   Jonathan Tan <jonathantanmy@google.com>
To:     dstolee@microsoft.com
Cc:     git@vger.kernel.org, sbeller@google.com, stolee@gmail.com,
        jonathantanmy@google.com, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> +		if (parse_commit(list[i]) ||
> +		    list[i]->generation < min_generation)

Here...

> +					if (parse_commit(parent->item) ||
> +					    parent->item->date < min_commit_date ||
> +					    parent->item->generation < min_generation)

...and here, would parse_commit_or_die() be better? I think that a
function that returns a definitive answer (either the commits are
reachable or not) should die when the commits cannot be parsed.

Other than that, I've compared the commits in this version to v1, and
all my review comments have been addressed, thanks. (With the exception
of the skip_prefix() one, but that is a minor matter - I suggested that
to make it easier to implement my "Ancestor:" and "Descendant:"
suggestion which Stolee disagreed on with reason.)

[1] https://public-inbox.org/git/20180716230019.257742-1-jonathantanmy@google.com/
