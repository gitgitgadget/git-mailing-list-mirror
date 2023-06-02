Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA43CC77B7A
	for <git@archiver.kernel.org>; Fri,  2 Jun 2023 17:26:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235563AbjFBR0i (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Jun 2023 13:26:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234602AbjFBR0h (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Jun 2023 13:26:37 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7F601AB
        for <git@vger.kernel.org>; Fri,  2 Jun 2023 10:26:36 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-561eb6c66f6so31595877b3.0
        for <git@vger.kernel.org>; Fri, 02 Jun 2023 10:26:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685726796; x=1688318796;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZStPsKaIP5FVvBA6ciPbXDN/E0JGlhAajMyO3JAmIrU=;
        b=caI74KQreI7Y6+GBWTPA+74TED2Sm+LFWPlLu3dyHdWHOrnkegNSDBtE1+pmUdA9Y/
         p6m99lDhNNtUQHh8YUSfd14oCTKFS6Yv8bGJ+P8NIWxVbSzhv+X/X82xlnjzooYz3O8k
         pgnYAS2+frA/lm/rqQVTvy3hbSkZlw++9Gbi/Ef3UTcNrp3QgIk/NPP9vbzFkOvGPsfS
         1Bf6C/LYCSAQq++qy2SSMsu0et+IKJJwCbVQokgt6ywyNa7qbw8GEQCmLwd8YBZW9GYV
         H8eHybHgBJs7iv7AuUOdk+uCzgz/U8Wma+zf4+kiQyMgdBbDp6JZ3S/Fol2+EsRDQoUF
         3VIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685726796; x=1688318796;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZStPsKaIP5FVvBA6ciPbXDN/E0JGlhAajMyO3JAmIrU=;
        b=IWaqfg9rmZfWAV9lUelNGVvQ2p3jXm06TzTQ2o9vXUj7rqxmWebTTnznZWYYWubhmX
         7xGu9LmZ+NuP6bi2TmYk+L+HgbBsx92LXlzTNy6fBjKldV98IvdaSo9aIkH7cMuLWFzC
         b4ZrNC9eTsNxjyRR1hbWeymFNF/gvPKMDt2mTxoqjmR7SjydHo5DYpZhsUdZOCz3Gai6
         9wVN04QdDfExrE/OqsztRdhSF+dDjc53WDqzYVQqwdi7UZRhUKGoI/8l3S7I6JY8r8Cb
         I1KXF7OxkQsqaHG/nQdI2yBXrc7h9W8OLb5fzH5x5lwfPOSD+Q9pipo2mN/8jQnuqR+0
         6oWw==
X-Gm-Message-State: AC+VfDzYkqGqlrHZnWWA3XGI7unylRWzSsC1JLBBuFXwTmUQhfPPEx3h
        wsParOaTQegcoHT00cTZXzHx4PzsmZ4Hcg==
X-Google-Smtp-Source: ACHHUZ6MGyT69gzJ6D3bqyQKlNOhVry/stlJrEpi08sPCtT6bpaCSTlz8ItDTVdnaQ1XSR/bcQs4cF1yJNZSlA==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3a07])
 (user=chooglen job=sendgmr) by 2002:a81:a889:0:b0:552:b607:634b with SMTP id
 f131-20020a81a889000000b00552b607634bmr309660ywh.4.1685726796083; Fri, 02 Jun
 2023 10:26:36 -0700 (PDT)
Date:   Fri, 02 Jun 2023 10:26:34 -0700
In-Reply-To: <20230601233550.429921-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <20230601233550.429921-1-jonathantanmy@google.com>
Message-ID: <kl6lmt1hzsfp.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: [PATCH v2 09/14] config.c: provide kvi with CLI config
From:   Glen Choo <chooglen@google.com>
To:     Jonathan Tan <jonathantanmy@google.com>,
        Glen Choo via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>,
        Emily Shaffer <nasamuffin@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

>> +	memcpy(&matched->kvi, kvi, sizeof(struct key_value_info));
>
> Can this just be
>
>   matched->kvi = *kvi;
>
> ?

If I remember correctly (big if), we have to copy the memory because the
config machinery allocates kvi on the stack, and the relevant functions
have returned by then. Hm, does this suggest that kvi should be const?

> If not, for the sizeof, use *kvi as the argument instead of struct
> key_value_info.

Makes sense.
