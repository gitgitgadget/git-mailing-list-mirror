Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F039F1F516
	for <e@80x24.org>; Thu, 28 Jun 2018 17:15:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753751AbeF1RP4 (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Jun 2018 13:15:56 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:55384 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753172AbeF1RPz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jun 2018 13:15:55 -0400
Received: by mail-wm0-f65.google.com with SMTP id v16-v6so10586037wmv.5
        for <git@vger.kernel.org>; Thu, 28 Jun 2018 10:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=jK5XZYHf2IISO7d897uKlEIz7gDYx7tBWO/BXQncmV8=;
        b=rLHpwSKl5QmRroMIc+fvn/e3TxzZ3rz3/wMCdZz4sKUpupNqkvtmMsLsYWooHiLKnY
         Nq5cjf0N+JEnKz+OaXiMGLaZjbI06OPbDu0d0+u12LwD1r406lhunLg4A0s07cdpn54U
         aMO+qdoJ80WlrfBKMSmHJ1Z5U0KUseRT9DfQaIQJL/w3bTVXAQweBTCUiEyjo9qQ1RhG
         IzrfEB4TKR4edyeAiNZq0gcdR2FANHFUUtt9yNSh9S2o7Rg8AqFBr0RDfENOFhZFe7am
         krSylU5UyqiB0RBnIdptSvcbnWBzUMWC92X8lIblXwGirNoVEJzeSPiOgD4+leMLgzT/
         qFVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=jK5XZYHf2IISO7d897uKlEIz7gDYx7tBWO/BXQncmV8=;
        b=n/eYJqWqSHAtCW6sQ13bNo74kEIwuj6NyQjk4IBIKHBSE6BG4mWxtbkVaezu/H/Y5I
         vxxYJdkTSOX0qkjNjKiMAM4rYN1sZV1UA2tL3iQ8UgHW+tuCkkbky17yK0BeSN93btLc
         XwUoa46sBiQEibMUYQAH9gNZ4qVFCwcmEVC/8hERIgVWxWs2ZsWS1fe869Ip9ifUlIXj
         BSiwu1zAhwojhaUzKxLc47DkWCT62AC33nuhaPT3Sk75SCKg254DU4Z+2YDn/xoR3P91
         IE6U8omzWwx/TuGxeO8NGUhvxxJZXXBGaGPnDAifEJffLvRkQD7eDemtZSfaGDHa+ekg
         Siuw==
X-Gm-Message-State: APt69E0ybUWVYBSeOlBE08KpBSR9HrktUel2G7v8yUwKd8vOilWnd/5C
        emMO/zR9Kjg4I20/kMuYsI0=
X-Google-Smtp-Source: AAOMgpdnkHvWBbD5k4OeJvdQRYKi80QfRPiczuktB6hg4N3r9igEgR9eN43zODLGrc1aK8/fHjJU1Q==
X-Received: by 2002:a1c:b801:: with SMTP id i1-v6mr8676228wmf.30.1530206153671;
        Thu, 28 Jun 2018 10:15:53 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id d4-v6sm11111085wrp.51.2018.06.28.10.15.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Jun 2018 10:15:52 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jameson Miller <jamill@microsoft.com>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>,
        "jonathantanmy\@google.com" <jonathantanmy@google.com>,
        "pclouds\@gmail.com" <pclouds@gmail.com>,
        "peartben\@gmail.com" <peartben@gmail.com>,
        "peff\@peff.net" <peff@peff.net>,
        "sbeller\@google.com" <sbeller@google.com>
Subject: Re: [PATCH v5 5/8] mem-pool: add life cycle management functions
References: <20180620201557.77155-1-jamill@microsoft.com>
        <20180628135932.225288-1-jamill@microsoft.com>
        <20180628135932.225288-6-jamill@microsoft.com>
Date:   Thu, 28 Jun 2018 10:15:52 -0700
In-Reply-To: <20180628135932.225288-6-jamill@microsoft.com> (Jameson Miller's
        message of "Thu, 28 Jun 2018 14:00:12 +0000")
Message-ID: <xmqqefgqygqf.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jameson Miller <jamill@microsoft.com> writes:

> Add initialization and discard functions to mem_pool type. As the
> memory allocated by mem_pool can now be freed, we also track the large
> allocations.
>
> If the there are existing mp_blocks in the mem_poo's linked list of

mem_poo?

> mp_blocksl, then the mp_block for a large allocation is inserted

mp_blocksl?

