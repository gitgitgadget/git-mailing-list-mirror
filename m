Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E41A6C433EF
	for <git@archiver.kernel.org>; Mon, 18 Jul 2022 19:35:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236141AbiGRTfn (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Jul 2022 15:35:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236113AbiGRTfh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Jul 2022 15:35:37 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 744EAE00D
        for <git@vger.kernel.org>; Mon, 18 Jul 2022 12:35:36 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 782041452E7;
        Mon, 18 Jul 2022 15:35:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=QMTpCMOCNcG7IbgKpKnQUea35Pe7TcNgw80yQf
        Pfypw=; b=KU94CnqLVtJ4Dhp5pBuerj/CyJF5xwW7ACAUQfxcipTviJ9yNA64WZ
        Ql6qktkANtXWUuzQyVggn0I8FqYEbka5B47+3wChoAKkLDy7tDW+C931jjVC49dP
        KwvqFh2cJ1cCKAMxCY8Yjw3wf5IVDswI2IWiRrcl/CR5ymYwxyliQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6D8FE1452E6;
        Mon, 18 Jul 2022 15:35:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C90A91452E5;
        Mon, 18 Jul 2022 15:35:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, johannes.schindelin@gmx.de, me@ttaylorr.com,
        Jeff Hostetler <git@jeffhostetler.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v4 07/12] rebase: add --update-refs option
References: <pull.1247.v3.git.1656422759.gitgitgadget@gmail.com>
        <pull.1247.v4.git.1657631225.gitgitgadget@gmail.com>
        <3ec2cc922f971af4e4a558188cf139cc0c0150d6.1657631226.git.gitgitgadget@gmail.com>
        <20220718090557.GA5616@szeder.dev>
        <11aa9b43-adea-4e90-9c70-ab3579aa445f@github.com>
Date:   Mon, 18 Jul 2022 12:35:33 -0700
In-Reply-To: <11aa9b43-adea-4e90-9c70-ab3579aa445f@github.com> (Derrick
        Stolee's message of "Mon, 18 Jul 2022 12:55:54 -0400")
Message-ID: <xmqq4jzefc3e.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CB1425A8-06D0-11ED-A345-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <derrickstolee@github.com> writes:

> ... I think I should use "branches" here, but
> keep the name "--update-refs". The biggest reason is that it provides
> a nice parallel with the "update-ref" sequencer command. This command
> allows updating _any_ ref, such as lightweight tags in refs/tags/*
> or even refs in refs/my/namespace/*.
>
> The --update-refs option doesn't create the commands to update tags
> or refs in places other than refs/heads/*.

I guess it would make the choice of "branch" the most appropriate.

I was hoping that we can repoint refs in private namespaces that are
not branches with the option.  But as long as the underlying
"update-ref" instruction can be used by advanced users, that is OK.
