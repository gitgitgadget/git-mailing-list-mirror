Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61338C433E0
	for <git@archiver.kernel.org>; Mon,  8 Mar 2021 18:19:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D8296148E
	for <git@archiver.kernel.org>; Mon,  8 Mar 2021 18:19:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230144AbhCHSTP (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Mar 2021 13:19:15 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56020 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229893AbhCHSTK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Mar 2021 13:19:10 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E7625A073D;
        Mon,  8 Mar 2021 13:19:09 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=NjmF/93TGPK9
        ddFNBJj2fuhu7Y8=; b=HAVnnqeM7FNwj70kyvsQqxq7rR6wfGlrJ8CkyZDoPUDc
        cXj5Mk21UyVHUc2zLgGxT3aS9p+fch4EjQj6E4DQ3HVfpG0LtOzbR4y1PDjm6HbS
        o6dZc7krqj30U0uXJymObDwkh0Uy63X3QuprkSC0X2dzInjOqr2estvhlDZNWAw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=e7Iybi
        j2EW2In9WmugK4EJDrZ0tum9kQd6psP4RhmyGqFIaJoZj2cg5FiKsyZtByQRWqqW
        SUo5ImSXghuL89rqozx/8LwTztP6+a1J44Edox9EGvJXz7Jdhynwf3QsEBdQ+uma
        JodefRjF3XREcc+Mh87vhrYrb6W7qMKZ+mRu8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E03C8A073C;
        Mon,  8 Mar 2021 13:19:09 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 718B4A073B;
        Mon,  8 Mar 2021 13:19:09 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v2 4/6] ls-files: refactor away read_tree()
References: <20210306193458.20633-1-avarab@gmail.com>
        <20210308022138.28166-5-avarab@gmail.com>
Date:   Mon, 08 Mar 2021 10:19:08 -0800
In-Reply-To: <20210308022138.28166-5-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Mon, 8 Mar 2021 03:21:36 +0100")
Message-ID: <xmqqwnuh5x0j.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: C6B011C0-803A-11EB-898A-D152C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Refactor away the read_tree() function into its only user,
> overlay_tree_on_index().

Nice.
