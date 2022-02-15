Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CE16C433F5
	for <git@archiver.kernel.org>; Tue, 15 Feb 2022 22:05:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243640AbiBOWFa (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Feb 2022 17:05:30 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235480AbiBOWF3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Feb 2022 17:05:29 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3A181EEC0
        for <git@vger.kernel.org>; Tue, 15 Feb 2022 14:05:18 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id d10so160777eje.10
        for <git@vger.kernel.org>; Tue, 15 Feb 2022 14:05:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=Yb2vwda6QTd+iGZsSiE8tEpsva5su6gsTdLuJfg0e/M=;
        b=BfdP2IsLdluclX7yjBhw43KVtNu0s8Js4F6nQjn6E6S0w5JwPLaFFEI6+vTVeDRYDR
         K7HOd0xhDZ0PFlvYq/KiyGMUODxoc+Ee2JTW22ae1XS0JfG56Uby3wjsnvnKCd8oe36b
         nTHn1iYD/ubFrFg3L4AgJM3nRTbGZmnF5ywCPenQNay3uwxUqApo093YyP9FLStJ1XrD
         g7lRSOsnd9Y/upjzovDEMJywbctR4Fw81p+I+tIGIKrYM4O66gPKtCTk0JoOuWgZ4Kcp
         UNIr7FxnXh++UGlEG6k1BogafFRCNgAJlrZLu4/9oKR2WljNPO5xpc2yt6a2KXcQBSlw
         Ifmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=Yb2vwda6QTd+iGZsSiE8tEpsva5su6gsTdLuJfg0e/M=;
        b=lE9dJRhiZUoxY0FzIxfyTDAKRccqfZGvdN5+SmSbi9LPPRnOwSW0DBmPYaQtZSznMC
         oWiPii1oRtLvcE6VBa8tJoFr6dU6iKroly1pxHppn6PET8TxPaK6g2L1vQGBW7sgrnBo
         YQr2S1ifCQE2Yncnvw/5mYO4SCQdRwEWTb7jd18K6LCDUbzbzYKDkPWhj9PPA0+Ct+51
         5BcymESBPOyhr3mAIXEr3zz3sTrwnxZgFeemf/roMtLR/FLIgEkcDD172Y7ey+TXKIb0
         BF70YHVWmieZrwJvLIaSfNkmULBPWwtlkSUX36WroAAIAA3NCbJYDVdeaUxyuxdP3RHs
         HLfw==
X-Gm-Message-State: AOAM530ned9oEZa17ahxo+6iifx/q2SdHX3bX8v97QDc5VFep6N5Ca3K
        KKSHB1NV3afc6U+kL1QTV+aGXV1O9GU=
X-Google-Smtp-Source: ABdhPJxSBBaNDGROqsOyQrb+Z4DaD7BSXHvw0zuDRykjRHz7R1qHIzeYvewimDJ7vhSZneyVe85wyw==
X-Received: by 2002:a17:906:4c46:b0:6cf:5489:da5b with SMTP id d6-20020a1709064c4600b006cf5489da5bmr31715ejw.203.1644962717070;
        Tue, 15 Feb 2022 14:05:17 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id p19sm12185964ejc.42.2022.02.15.14.05.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Feb 2022 14:05:16 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nK5wi-002tV8-47;
        Tue, 15 Feb 2022 23:05:16 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Glen Choo <chooglen@google.com>
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 4/9] submodule: inline submodule_commits() into caller
Date:   Tue, 15 Feb 2022 23:02:47 +0100
References: <20220210044152.78352-1-chooglen@google.com>
 <20220215172318.73533-1-chooglen@google.com>
 <20220215172318.73533-5-chooglen@google.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <20220215172318.73533-5-chooglen@google.com>
Message-ID: <220215.86iltfwztv.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Feb 16 2022, Glen Choo wrote:

> -		commits = submodule_commits(changed, name);
> -		oid_array_append(commits, &p->two->oid);
> +		item = string_list_insert(changed, name);
> +		if (!item->util)
> +			/* NEEDSWORK: should we have oid_array_init()? */
> +			item->util = xcalloc(1, sizeof(struct oid_array));
> +		oid_array_append(item->util, &p->two->oid);
>  	}
>  }

Yes, just adding it while we're at it seems worthwhile, and if not
defining this in terms of the macro would be better, as the two are
guaranteed not to drift apart. I.e. the pattern seen in:

    git grep -W 'memcpy.*&blank'
