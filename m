Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C5E521F4F8
	for <e@80x24.org>; Fri, 14 Oct 2016 21:44:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755728AbcJNVoC (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Oct 2016 17:44:02 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54458 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753832AbcJNVoA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Oct 2016 17:44:00 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6461E45D72;
        Fri, 14 Oct 2016 17:43:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=zcgd8hTpl4aHTmSjtLRxzQRTJmU=; b=piZvwV
        GHFZUztzukUWeMAE2L1UxtTNrEYt634Em74uGmGroyBsVtCPMOTRaLvptGksTyfV
        g8AfQjtJIXfbyUATttoanaoy/ZFTAO2fx/IvSapNF/e0XVc26ytlLPg2XHjfR1a8
        Bmoc26DJFf50ZBXTLaDiu/rC8PJN2UkPbiZnY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=cOwZSoC8BjKDTNgBEast/vxmhjbdinNG
        KJZxDlftRqsy4fuKbo7Wm+KuX2WJxwkFiV6/1LwjiJeEdWeR2+rZaCA8WVpDvAZ0
        xN6ZsJo/ImKKoTOFn3Wd48gKMD0LVTBoCREYBCQzfKZNDFZVPUr+TK6JkRkIMSU5
        lT8WWNFcJFI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5CDD145D71;
        Fri, 14 Oct 2016 17:43:34 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D5D6D45D6F;
        Fri, 14 Oct 2016 17:43:33 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Pranit Bauva <pranit.bauva@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v15 14/27] t6030: no cleanup with bad merge base
References: <01020157c38b19e0-81123fa5-5d9d-4f64-8f1b-ff336e83ebe4-000000@eu-west-1.amazonses.com>
        <01020157c38b1adc-d5fa6b9a-ce13-4ee9-874e-e45fac99fba6-000000@eu-west-1.amazonses.com>
Date:   Fri, 14 Oct 2016 14:43:31 -0700
In-Reply-To: <01020157c38b1adc-d5fa6b9a-ce13-4ee9-874e-e45fac99fba6-000000@eu-west-1.amazonses.com>
        (Pranit Bauva's message of "Fri, 14 Oct 2016 14:14:16 +0000")
Message-ID: <xmqqr37iy5bw.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 416E80DA-9257-11E6-8713-987C12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Pranit Bauva <pranit.bauva@gmail.com> writes:

> +test_expect_success 'check whether bisection cleanup is not done with bad merges' '
> +	git bisect start $HASH7 $SIDE_HASH7 &&
> +	test_expect_failure git bisect bad >out 2>out &&

I think you meant "test_must_fail" here.

> +	test_i18ngrep "The merge base" out &&
> +	test -e .git/BISECT_START
> +'
> +
>  test_done
>
> --
> https://github.com/git/git/pull/287
