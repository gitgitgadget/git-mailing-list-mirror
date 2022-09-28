Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 317EDC32771
	for <git@archiver.kernel.org>; Wed, 28 Sep 2022 13:14:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234033AbiI1NOI (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Sep 2022 09:14:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233713AbiI1NOF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Sep 2022 09:14:05 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71AE96B66A
        for <git@vger.kernel.org>; Wed, 28 Sep 2022 06:14:04 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id nb11so27041200ejc.5
        for <git@vger.kernel.org>; Wed, 28 Sep 2022 06:14:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date;
        bh=StcfY5iaa5ff2IDUzWyhwKkfOTRTITPxKNjgVxN1ztw=;
        b=Fx72wO0jE/VHyMOA+Tu3mePOIwnpmTJ1I56np4UtC4jnRuKIgPw7aBkIz+cffwNFjZ
         AXkRgArnTswRKKiKWDBFzRR4mhdx1MtLECqhlfjwXsWTEJIa22oetx6zuI1ZK7Heb2dO
         IwVp2Huz7ByZAsQJ842UX4U9PQUGk1U7d+agcuAg9i9fuNqAbrDA2byvPpMF8Y7fE7cr
         tghYkWcaF2MxpWpUaKgfrfenTVJzybMWIUNyCJCfwbvJZ/gBzO3J46BtF6h3LhcvCont
         H/SBBXYCUJYXS/bp/dLjSVlmrqxHR9bGnZFo0ZVMAqzQNu0P7BUnyH9CkCjCwKhdohTH
         f+IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=StcfY5iaa5ff2IDUzWyhwKkfOTRTITPxKNjgVxN1ztw=;
        b=Md65IWnhvjDVsRPBUVfEZkwQHZH6yJc9SMoPclr4UyPtcDVlKzTnN+CY+D1TjRgXIY
         Lkk5M7rCv+hX58zCOCS1huPnTyhFeVExvQiRH6+fzhwSjGlXe6Am1APyCFrCV6NcXftL
         as4BWXGxcHCnCTP/cOpxDNL9mvKL1KHnA4o/7+qe9bulAgSTJesn4eEBkpmD6tXX0PgB
         bg00byx+Pg5C3tYrhbo1D7osZOVMKe/pXK9bqGVsHcwoGxRWQ3m5oeIxzSP1vj9H2yZK
         Bgf4u+QvMyxV2J8SscUfy/jMcEX5Rfe2CnUkxLq611hS0FczX8KZSwU7BfwAff8+GaCW
         2ADw==
X-Gm-Message-State: ACrzQf0BYiaLbIgFkQQJjzwmSDeBI5J26u+qThUzCTHjPP9ZYZWMebth
        2r+eT0SjoKuV6lNWubuvIPhQMMiwLyjmaw==
X-Google-Smtp-Source: AMsMyM5mCDEosONIRrm94eSyz+BNX2+DdvJorMS93vrcpJtGWNRwRnS32Eg73mwZjA5OJlqIn0uRbg==
X-Received: by 2002:a17:907:2d09:b0:781:d793:f51e with SMTP id gs9-20020a1709072d0900b00781d793f51emr9237212ejc.628.1664370842503;
        Wed, 28 Sep 2022 06:14:02 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id q3-20020a170906144300b0077d37a5d401sm2340619ejc.33.2022.09.28.06.14.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 06:14:01 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1odWsy-000xeY-2j;
        Wed, 28 Sep 2022 15:14:00 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Calvin Wan <calvinwan@google.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, jonathantanmy@google.com,
        philipoakley@iee.email, johncai86@gmail.com
Subject: Re: [PATCH v5 6/6] cat-file: add remote-object-info to batch-command
Date:   Wed, 28 Sep 2022 15:12:48 +0200
References: <20220502170904.2770649-1-calvinwan@google.com>
 <20220728230210.2952731-7-calvinwan@google.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <20220728230210.2952731-7-calvinwan@google.com>
Message-ID: <220928.8635cby73b.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Jul 28 2022, Calvin Wan wrote:

> +			gtransport->smart_options->object_info_data = &remote_object_info;
> +			retval = transport_fetch_refs(gtransport, NULL);

I see Phillip Wood noted that this fails SANITIZE=address in
https://lore.kernel.org/git/00a58dbb-32e8-98dd-6c72-235e9c33af3b@gmail.com/;
just a *bump* about this issue. I noticed "seen" failed, bisected down
to 6/6 here, then saw his >month old report...
