Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 683FE1FA7B
	for <e@80x24.org>; Tue, 13 Jun 2017 19:45:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753311AbdFMTpH (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Jun 2017 15:45:07 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:34291 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752168AbdFMTpG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Jun 2017 15:45:06 -0400
Received: by mail-pg0-f65.google.com with SMTP id v14so20483036pgn.1
        for <git@vger.kernel.org>; Tue, 13 Jun 2017 12:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=2YYJ1ykbjx5Z1TR2CqDYquecKasMGp4StviAq1t8Lso=;
        b=E6CZIfcEGfVt6GuXbC1xfCNU6sHFDa3R2SrQeYlm9GqNXhK2SxP2g7oaux1uuZy9K9
         ishL4KM1WSHzrKYPHFesL6jD5biuRyGL8ajNPoTS34Hp0YUoAxKZ1pmKP2hm4wvNlmgZ
         JUhLgZxeijusSMZegTVUobQPsXjnUAW7KyzAB2LNg5FlbLSUqsO7Y3xL6+MZW0vI+uMq
         iT5FWyyf4eO/vWW2ohiRoN6mT++Gp+36HMCf2VSbrM+PE5WAUG4JWCPb1kT5p4kGXEbv
         B5ng5k8IOEu/Aou7YgSwLdp6BskoXTO8gAby9KyicIfsXu9AnArGYkiE5uLYh6CPRASU
         r8Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=2YYJ1ykbjx5Z1TR2CqDYquecKasMGp4StviAq1t8Lso=;
        b=J3kd/cyF68dB6oWvWSrcLjmYzs4pGkZ/eo1Nn5pRctrm08agHdbf10j7s8Uf2fJ3CP
         w/MxZ7RzxNGmcYL2JE/2TBNisSbdP8vQmScIaIAMSI6zXRAZs9Ivxf8FMTp2qm4J5W7P
         rQ+1ZehU4GKo+viScW8cS1jsURTlygXYUVmWNBoPw8UR3m1OkVbv3kvr4mH3nqYfRZa4
         6gql7rm9GNN2uhM1QQhXWojLxS4+KIeDs6yip7nx7zu0nEODv9AEwIMe8lOKLdLMdK04
         raevKaI8STn6GApw7J21fZmsMHO/APYo5Inaehh/5B1hr0ri1or2zFbg9tcScRNVBiei
         VTPg==
X-Gm-Message-State: AKS2vOxEp4qa9eqkYQQ8g6Lm8zI3QjCU3GWFm+Cz8Hc4dcEe9rPYwz56
        eyKW3dDjPDMb+aNoIqw=
X-Received: by 10.98.39.2 with SMTP id n2mr1109253pfn.182.1497383105584;
        Tue, 13 Jun 2017 12:45:05 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:b4c1:e9f6:bf2b:dcec])
        by smtp.gmail.com with ESMTPSA id o13sm19930970pfa.120.2017.06.13.12.45.04
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 13 Jun 2017 12:45:04 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Joel Teichroeb <joel@teichroeb.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmo=?= =?utf-8?B?w7Zyw7A=?= Bjarmason 
        <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH v4 3/5] stash: add test for stashing in a detached state
References: <20170608005535.13080-1-joel@teichroeb.net>
        <20170608005535.13080-4-joel@teichroeb.net>
Date:   Tue, 13 Jun 2017 12:45:03 -0700
In-Reply-To: <20170608005535.13080-4-joel@teichroeb.net> (Joel Teichroeb's
        message of "Wed, 7 Jun 2017 17:55:33 -0700")
Message-ID: <xmqqa85b65a8.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Joel Teichroeb <joel@teichroeb.net> writes:

> Signed-off-by: Joel Teichroeb <joel@teichroeb.net>
> ---
>  t/t3903-stash.sh | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
> index 5399fb05ca..ce4c8fe3d6 100755
> --- a/t/t3903-stash.sh
> +++ b/t/t3903-stash.sh
> @@ -822,6 +822,18 @@ test_expect_success 'create with multiple arguments for the message' '
>  	test_cmp expect actual
>  '
>  
> +test_expect_success 'create in a detached state' '
> +	test_when_finished "git checkout master" &&
> +	git checkout HEAD~1 &&
> +	>foo &&
> +	git add foo &&
> +	STASH_ID=$(git stash create) &&
> +	HEAD_ID=$(git rev-parse --short HEAD) &&
> +	echo "WIP on (no branch): ${HEAD_ID} initial" >expect &&
> +	git show --pretty=%s -s ${STASH_ID} >actual &&
> +	test_cmp expect actual
> +'

Hmph.  Is the title automatically given to the stash the
only/primary thing that is of interest to us in this test?  I think
we care more about that we record the right thing in the resulting
stash and also after creating the stash the working tree and the
index becomes clean.  Shouldn't we be testing that?

If "git stash create" fails to make the working tree and the index
clean, then "git checkout master" run by when-finished will carry
the local modifications with us, which probably is not what you
meant.  You'd need "reset --hard" there, too, perhaps?

>  test_expect_success 'stash -- <pathspec> stashes and restores the file' '
>  	>foo &&
>  	>bar &&
