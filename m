Return-Path: <SRS0=yIgW=23=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D23A5C33C8C
	for <git@archiver.kernel.org>; Mon,  6 Jan 2020 23:18:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C774207FD
	for <git@archiver.kernel.org>; Mon,  6 Jan 2020 23:18:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Pbak5WJZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726735AbgAFXSM (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Jan 2020 18:18:12 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63056 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726545AbgAFXSM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Jan 2020 18:18:12 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CDE3D2B2BD;
        Mon,  6 Jan 2020 18:18:09 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ryr18emr1jI/J+hLq5xTSuHBiIA=; b=Pbak5W
        JZBXw6nPAjE5pgi0wtsws/W3655ntYajSIu4DaE0yPxA6NIiscsKojzzPLe2eQ3m
        /EUPfJZHSndJwysAbZZIOKcL/2W+kxQ2VmkmZ+tAczKaBeYLIbX/u/Ol9nMI1KIJ
        vsQZuXbcy066TBT+yXN5Vv6u94WJs13o26AaM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=QU6vr5ltyyYcpjJnbaBE0CW0JZfou4yQ
        aIGW/rg/2eg5hHw7ZGgiPHb9KUbEox0U7blPR6WHs7xJ+i1R0G0D+EsidBYgNZH2
        bt05rUcHWKKwlihuj0vX2INy9226EQncJHSfVPfcMroIY3JanoLqFBHaSVrgi3W8
        CHyrYtQ03f4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C67252B2BC;
        Mon,  6 Jan 2020 18:18:09 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 26C6F2B2B9;
        Mon,  6 Jan 2020 18:18:09 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     Heba Waly via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Heba Waly <heba.waly@gmail.com>
Subject: Re: [PATCH 1/1] add: use advise function to display hints
References: <pull.508.git.1577934241.gitgitgadget@gmail.com>
        <90608636bf184de76f91e4e04d9e796a021775a0.1577934241.git.gitgitgadget@gmail.com>
        <xmqqpng1eisc.fsf@gitster-ct.c.googlers.com>
        <20200106231327.GB181522@google.com>
Date:   Mon, 06 Jan 2020 15:18:08 -0800
In-Reply-To: <20200106231327.GB181522@google.com> (Emily Shaffer's message of
        "Mon, 6 Jan 2020 15:13:27 -0800")
Message-ID: <xmqqy2uk6uof.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CD312E54-30DA-11EA-89E9-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer <emilyshaffer@google.com> writes:

> Hm, I guess this answers my question above about them being 1:1. But I
> suppose it doesn't necessarily preclude advise() from associating a
> single config with multiple advice messages.

... and probably the other message in the thread from me would
answer any remaining question you may have, I guess ;-)
