Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98F57C433F5
	for <git@archiver.kernel.org>; Wed, 24 Nov 2021 19:35:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351317AbhKXTi1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Nov 2021 14:38:27 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64787 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351394AbhKXTiC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Nov 2021 14:38:02 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5C7A0105B61;
        Wed, 24 Nov 2021 14:34:51 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=iz/6vO3Dt5pFon9wQiUx0cUlxwa1DMi2cMzZcg
        dsaJM=; b=KD97p22YFLk9d+pan8zuk/ypdv2hdkQefI/J+xs3WRUBnJFAjJpKb5
        sYjtqfa9nvDI7D+HkBRo9J8dvmR6+yJs5LwTHuN3UqutarrBzNkTP2eu96bH7xl3
        ZGQoru9AF0teVs7P8Mifo006qbM5kP64ogr9j1AT6agmXiDTirMJ4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4FF9C105B60;
        Wed, 24 Nov 2021 14:34:51 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9C375105B5F;
        Wed, 24 Nov 2021 14:34:50 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Carlo Arenas <carenas@gmail.com>, git@vger.kernel.org,
        phillip.wood123@gmail.com, thomas.wolf@paranor.ch,
        Alexander Veit <alexander.veit@gmx.net>
Subject: Re: [PATCH] editor: only save (and restore) the terminal if using a
 tty
References: <04ab7301-ea34-476c-eae4-4044fef74b91@gmail.com>
        <20211122222850.674-1-carenas@gmail.com> <xmqqa6hvbxob.fsf@gitster.g>
        <CAPUEspgDafXHHPvzNijTsPsna76yE8W=JH-78LX3jyaieSmp0A@mail.gmail.com>
        <xmqqtug293ml.fsf@gitster.g>
        <nycvar.QRO.7.76.6.2111241428190.63@tvgsbejvaqbjf.bet>
Date:   Wed, 24 Nov 2021 11:34:49 -0800
In-Reply-To: <nycvar.QRO.7.76.6.2111241428190.63@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Wed, 24 Nov 2021 14:29:29 +0100 (CET)")
Message-ID: <xmqqwnkx1h5y.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 97426686-4D5D-11EC-A74A-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Maybe a better approach would be to hide the `save_term()` dance behind a
> new config option, and then have it turned on automatically if the
> `editor` _happens_ to be `vi` or `vim`.

Why 'vi' and 'vim' are so special?  Is this an attempt to paper over
a bug in 'vim' on the caller side?

>
> That would help the problem reported in the Windows Terminal project.
>
> Ciao,
> Dscho
