Return-Path: <SRS0=ZiOn=25=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CB4CC282DD
	for <git@archiver.kernel.org>; Wed,  8 Jan 2020 19:15:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD38B2070E
	for <git@archiver.kernel.org>; Wed,  8 Jan 2020 19:15:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="KKwLxowJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728666AbgAHTPi (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Jan 2020 14:15:38 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:54499 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726411AbgAHTPh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Jan 2020 14:15:37 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 9D353A1ADD;
        Wed,  8 Jan 2020 14:15:35 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=hVMlNA2Asg9fdbXOtQOuHoShBeE=; b=KKwLxo
        wJE6owLeKVjFTS5PUyh2zaXGJREDczQ7mWXTThrQm9lJvIHS0HaBqlYfOBDhMw8x
        M+KdXp+7Zkq/GDXXP6tNZM+dPz7Hd2OEm1eYrR6+Axg/ShF2PRVH7/mT9xh8zOMX
        DSpKJFxaffdDBGfrgBJSZaOqF0O8r8wDGRAkc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=qWs8dMu4gEts+OZh5TCvj1c68szTL2Vz
        7K/aPq3wUnraPszpHxeePVpqvfFzhWLWSBeDN95u7/46XVHZ92P52eqpSFbNnLZD
        YMXN8O4SOcz0aFoa1KnNUBDZbVV/VH4oqqlYuSHdClcC7LRpxENlHR7V8hM59g5a
        ZbWbC/1mQo0=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 948C5A1ADB;
        Wed,  8 Jan 2020 14:15:35 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id BA5F9A1AD7;
        Wed,  8 Jan 2020 14:15:32 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Heba Waly <heba.waly@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Heba Waly via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Emily Shaffer <emilyshaffer@google.com>
Subject: Re: [PATCH v2 1/1] branch: advise the user to checkout a different branch before deleting
References: <pull.507.git.1577933387.gitgitgadget@gmail.com>
        <pull.507.v2.git.1578370226.gitgitgadget@gmail.com>
        <19a7cc1889d6094e4f8a94c19c43ad554662e8d8.1578370226.git.gitgitgadget@gmail.com>
        <CAPig+cQ0qY8KDZrQ8khuz34DqPimorN7JHHn0Ms=KpvJYtxJoA@mail.gmail.com>
        <CACg5j26jyWnAtM+mZ-FuN7OQWHpKk5nADG+7J-=metJMdO6+2Q@mail.gmail.com>
        <CAPig+cTDayF0hHn7wSPGNS8h2qPUYhhg9Z8fY_rLQnWmAg-NKQ@mail.gmail.com>
        <CACg5j260h88bd=W_4EzAn7B0TiU02Y8BzKDQ7w3UJiHkhL60NQ@mail.gmail.com>
        <nycvar.QRO.7.76.6.2001081945490.46@tvgsbejvaqbjf.bet>
Date:   Wed, 08 Jan 2020 11:15:30 -0800
In-Reply-To: <nycvar.QRO.7.76.6.2001081945490.46@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Wed, 8 Jan 2020 20:01:12 +0100 (CET)")
Message-ID: <xmqqsgkp220d.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3DBA685E-324B-11EA-B94E-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> This is the first time I hear about anybody wanting to disable any advice
> ...
> I don't really think that this is desired, though.

Me neither.  We seem to have come up with more-or-less the same
illustration, but such a global "turn all off" needs to be explained
very well before we let users blindly use it, I think.
