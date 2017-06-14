Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	RCVD_IN_DNSWL_HI,T_DKIM_INVALID,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8DB6720401
	for <e@80x24.org>; Wed, 14 Jun 2017 10:05:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751836AbdFNKFU (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Jun 2017 06:05:20 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:34222 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751726AbdFNKFT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jun 2017 06:05:19 -0400
Received: by mail-pf0-f195.google.com with SMTP id d5so13775313pfe.1
        for <git@vger.kernel.org>; Wed, 14 Jun 2017 03:05:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=+T3nZZbxcG2t8EHlZXYdWH3MwTM2ayAghI/vPt9yYic=;
        b=jt25U4ThreONAeypP6UtD+13TbGsL6HDG3lCssuVCGg8MZJbhXXyUXgMbN1XX9QFq6
         vp4CayTIEI4gsiusLw/44krK0G7GNrjW+0QbW+eGoQKhOrjq8ntP6c6iRzUS8ehs3jGg
         T0KwDuUGe2d3QRLoDX3wOErLlK3+uEb6/Is05wx2ZR2M4gE3nrxMQ+dXLq2V6WrKV8rj
         hrHw4IjmwNEO9bAqWhwKiGUfOLUiKQ5IIeivsFEuzzd/gjrgjzzzv9ba4/CeFkgD5HYR
         nQzozc4DI4ulS51ZyK2vv0eOIbfm5Coopq194d08BXQ1Mwz6C227x1CIpdUuyG8J4FKK
         XfYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=+T3nZZbxcG2t8EHlZXYdWH3MwTM2ayAghI/vPt9yYic=;
        b=txcqCCIsnQivFL1Tn6M6n9lt8HFvJPJ64Eb+GC32gGSAKOapkQ7ORrfBk50NpcB+Nd
         LTk7tqj08d8bMLoCet0WFYtKHHMVIME3GYTt/k5wQEN8bh7t/zCAoYA0tOY4tOCFu3js
         GscYFqqZdgOrU+5NHP/Y1khL3Kg8mKTBpFpkx/C6atjfnh1paekPu26nTS1LDTsELnFv
         uVkhc7dCNgMwZJOKhLyz3hl+98kVAtOSc+nYdLUxis1y6aVagVKTfjKp/VhClkdORjty
         Q8RMveRC0MFOCaSBOoDTvNfHUrGWYakSpMrCgL9Rg0jwCi+5KoXcPrMzynmIPvGOWVGq
         oByQ==
X-Gm-Message-State: AKS2vOy1Zoph9N7lCOHFWtuGvbaTsVbUX8LgLn5e/5xrTtOtr1wMnQEO
        DZ3QdUDuuq15Xg==
X-Received: by 10.98.219.5 with SMTP id f5mr3315875pfg.2.1497434719069;
        Wed, 14 Jun 2017 03:05:19 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:b4c1:e9f6:bf2b:dcec])
        by smtp.gmail.com with ESMTPSA id 67sm1468968pfn.84.2017.06.14.03.05.18
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 14 Jun 2017 03:05:18 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Michael Haggerty <mhagger@alum.mit.edu>,
        =?utf-8?B?Tmd1eeG7hW4gVGg=?= =?utf-8?B?w6FpIE5n4buNYw==?= Duy 
        <pclouds@gmail.com>, Stefan Beller <sbeller@google.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        David Turner <novalis@novalis.org>,
        Brandon Williams <bmwill@google.com>,
        Johannes Sixt <j6t@kdbg.org>,
        =?utf-8?Q?=C3=98yvin?= =?utf-8?Q?d?= Holm <sunny@sunbase.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        git@vger.kernel.org
Subject: Re: [PATCH 1/2] for_each_bisect_ref(): don't trim refnames
References: <cover.1497430232.git.mhagger@alum.mit.edu>
        <3615deefe90bebe746618b04c055a466a442f85b.1497430232.git.mhagger@alum.mit.edu>
        <20170614092256.c3fmfcokuwbbcvbz@sigill.intra.peff.net>
        <20170614093242.twipnjncaka2lhyg@sigill.intra.peff.net>
Date:   Wed, 14 Jun 2017 03:05:17 -0700
In-Reply-To: <20170614093242.twipnjncaka2lhyg@sigill.intra.peff.net> (Jeff
        King's message of "Wed, 14 Jun 2017 05:32:42 -0400")
Message-ID: <xmqqfuf251gi.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>> Since we obviously don't have even a single test for "--bisect", that
>> might be worth adding.
>
> It turns out we do, but none that actually check that we use the default
> refnames. So maybe squash this in?

Sounds sensible.  Thanks.

>
> diff --git a/t/t6002-rev-list-bisect.sh b/t/t6002-rev-list-bisect.sh
> index 3bf2759ea..534903bbd 100755
> --- a/t/t6002-rev-list-bisect.sh
> +++ b/t/t6002-rev-list-bisect.sh
> @@ -235,4 +235,18 @@ test_sequence "--bisect"
>  
>  #
>  #
> +
> +test_expect_success '--bisect can default to good/bad refs' '
> +	git update-ref refs/bisect/bad c3 &&
> +	good=$(git rev-parse b1) &&
> +	git update-ref refs/bisect/good-$good $good &&
> +	good=$(git rev-parse c1) &&
> +	git update-ref refs/bisect/good-$good $good &&
> +
> +	# the only thing between c3 and c1 is c2
> +	git rev-parse c2 >expect &&
> +	git rev-list --bisect >actual &&
> +	test_cmp expect actual
> +'
> +
>  test_done
