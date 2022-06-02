Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B255C433EF
	for <git@archiver.kernel.org>; Thu,  2 Jun 2022 17:48:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237679AbiFBRsR (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Jun 2022 13:48:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236902AbiFBRsQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Jun 2022 13:48:16 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBD9ADF90
        for <git@vger.kernel.org>; Thu,  2 Jun 2022 10:48:14 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 3C49E18F7F5;
        Thu,  2 Jun 2022 13:48:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=AsRk13Hr2IbnlXAMdEQlklUiPBLOwtLYCGlIKY
        Afuek=; b=V6PFpSaDU0zGKoL8t0UJuiVrXTsgJQGU2SsxIXd0YElTKADYNbPrdo
        wXLXKJNPscK1NLeyZQnVbwY88XMeROWS5MbFkzhoU+K3D7qN7Ybwyaj+I2untvHd
        xoeoT25Yph9Vwm7tKiqM+lfouGh4nm9bWB71EB9CBEwFoVeKFqBzk=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 3434F18F7F2;
        Thu,  2 Jun 2022 13:48:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id B16D918F7F0;
        Thu,  2 Jun 2022 13:48:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Josh Steadmon <steadmon@google.com>,
        congdanhqx@gmail.com, dyroneteng@gmail.com, martin.agren@gmail.com,
        peff@peff.net, tenglong.tl@alibaba-inc.com
Subject: Re: [PATCH] ls-tree: test for the regression in 9c4d58ff2c3
References: <xmqqee28spni.fsf@gitster.g>
        <patch-1.1-0fdfec624eb-20220531T171908Z-avarab@gmail.com>
        <nycvar.QRO.7.76.6.2206021703110.349@tvgsbejvaqbjf.bet>
Date:   Thu, 02 Jun 2022 10:48:09 -0700
In-Reply-To: <nycvar.QRO.7.76.6.2206021703110.349@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Thu, 2 Jun 2022 17:18:13 +0200 (CEST)")
Message-ID: <xmqqo7zbnehy.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2B17C3E6-E29C-11EC-BE2A-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> +test_ls_tree_format_mode_output () {
>> +	local opts=$1 &&
>
> This line does not quote `$1`, but...
>
> ... this line passes a first argument that contains spaces. Hence the
> tests fail in CI:
> https://github.com/git/git/runs/6703333447?check_suite_focus=true

We had a portability discussion not so in distant past on "local".

  https://lore.kernel.org/git/xmqqsftc3nd6.fsf@gitster.g/

The conclusion from the thread IIRC is

 * Very safe

	local var; var=$1

 * Probably OK

	local var="$1"

 * Not portable

	local var=$1

Thanks.
