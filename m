Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A3E1F2098B
	for <e@80x24.org>; Wed, 23 Nov 2016 16:52:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755787AbcKWQwQ (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Nov 2016 11:52:16 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58041 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1755367AbcKWQwP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Nov 2016 11:52:15 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id EA7614B633;
        Wed, 23 Nov 2016 11:52:13 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=26401+ynP1QO
        hVOHM2p3tteidQw=; b=EcTJL6WyNWPRwGSESEP5UG3cw0L2bbJduNBJNBoVJT7B
        hEGuSSV95hr0qC1HDli/4uRBaMKATJ5+4c7kRS0JZvd2cwwiAkmhCLIU/ppfptM9
        mxew4zSHcDx1NHPXXnXQFdE8NY6bKTMqFxPFMdn1LieNWuqEiCNuR3ZD9S22TpQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=oyUlsX
        Xe44BZEd6nGSBSJAKNds7Hs+tKw9yUCdyHr+4+4lT0MG2Ea1uy4sC7BEt+P1FvaK
        SHpdJ/GJrx2risWIZ5Yiy0e2U11aTLxU1/4MZflIY62daxLefa5VyVz9LZ28lzAx
        zX1Bu9/0uxzmhkEamATIexS0yCGevnkfHkc1k=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E09B34B62F;
        Wed, 23 Nov 2016 11:52:13 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1713B4B62D;
        Wed, 23 Nov 2016 11:52:12 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org, rappazzo@gmail.com
Subject: Re: [PATCH 0/3] Minor fixes on 'git worktree'
References: <20161122100046.8341-1-pclouds@gmail.com>
Date:   Wed, 23 Nov 2016 08:52:11 -0800
In-Reply-To: <20161122100046.8341-1-pclouds@gmail.com> (=?utf-8?B?Ik5ndXk=?=
 =?utf-8?B?4buFbiBUaMOhaSBOZ+G7jWM=?=
        Duy"'s message of "Tue, 22 Nov 2016 17:00:43 +0700")
Message-ID: <xmqqbmx6nnpg.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 2E99093E-B19D-11E6-B99D-E98412518317-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> This fixes two things:
>
>  - make sure the first item is always the main worktree even if we
>    fail to retrieve some info
>
>  - keep 'worktree list' order stable (which in turn fixes the random
>    failure on my 'worktree-move' series
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (3):
>   worktree.c: zero new 'struct worktree' on allocation
>   get_worktrees() must return main worktree as first item even on error
>   worktree list: keep the list sorted
>
>  builtin/worktree.c | 26 ++++++++++++++++++++++----
>  worktree.c         | 20 ++++----------------
>  2 files changed, 26 insertions(+), 20 deletions(-)

Any tests?

