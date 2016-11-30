Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BA6491FF40
	for <e@80x24.org>; Wed, 30 Nov 2016 22:36:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757845AbcK3Wgc (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Nov 2016 17:36:32 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55451 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1755322AbcK3Wgb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Nov 2016 17:36:31 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9A70555338;
        Wed, 30 Nov 2016 17:36:30 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ABcXtA+3kE4TcvfZ29CzICrZNCI=; b=EMd0D5
        mlbZElrAPHAvM9no1G/KoRNcE+xEdlpyUajMPyZHYQ7FNX2teplHE7pGBwFDxx+y
        DEX3Tbjk9WSMBSGlfO3J6OumyeqvFvDDj4Zi9/MqftAs+WmIqaKvn5yK2RIu7hzp
        1ALNL3sgbTEORYh0bze6ZhU0gcUvJU8b4xXC8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=gT5xHjGgMqiVeQKess7V36Bfr13r453H
        EAnUrQlBAD3bSkFkW1/Bn2eB9GBHOvJrlo7tpjyvpOLIsk8DBRPwrARz19pgNm7e
        eYN/FBgFOp3eUbwGknUGMT2yOK6yAZrtAsOQtLLrIoSBZXRrq0AyeYNdim1Jk/ts
        4nGpkcJveJ0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9225C55337;
        Wed, 30 Nov 2016 17:36:30 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0EC5055336;
        Wed, 30 Nov 2016 17:36:30 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [RFC/PATCH v3 00/16] Add initial experimental external ODB support
References: <20161130210420.15982-1-chriscool@tuxfamily.org>
Date:   Wed, 30 Nov 2016 14:36:28 -0800
In-Reply-To: <20161130210420.15982-1-chriscool@tuxfamily.org> (Christian
        Couder's message of "Wed, 30 Nov 2016 22:04:04 +0100")
Message-ID: <xmqqy400bno3.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 70092F6A-B74D-11E6-A605-E98412518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:

> For now there should be one odb ref per blob. Each ref name should be
> refs/odbs/<odbname>/<sha1> where <sha1> is the sha1 of the blob stored
> in the external odb named <odbname>.
>
> These odb refs should all point to a blob that should be stored in the
> Git repository and contain information about the blob stored in the
> external odb. This information can be specific to the external odb.
> The repos can then share this information using commands like:
>
> `git fetch origin "refs/odbs/<odbname>/*:refs/odbs/<odbname>/*"`

Unless this is designed to serve only a handful of blobs, I cannot
see how this design would scale successfully.  I notice you wrote
"For now" at the beginning, but what is the envisioned way this will
evolve in the future?

