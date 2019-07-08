Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7F37B1F461
	for <e@80x24.org>; Mon,  8 Jul 2019 19:24:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731614AbfGHTYM (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 Jul 2019 15:24:12 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62876 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728615AbfGHTYM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Jul 2019 15:24:12 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1E37B14CC2A;
        Mon,  8 Jul 2019 15:24:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=TT9HWu9QkID8vJDw7HNmeVtZwmU=; b=kpoP0u
        OfQr6mT/AEe1O4qmQ/xBCRmgVFzf69Ug8BIwUo8KoZxGIgGOtGmy31IS4NS+AMMf
        Oz1EEXx7ERyHS2vDotgkaBQEtAmkrd73iQt5hhzA3ktCo2xkO/3hX+ytKlNx80ih
        UzPMGMgjQ4vVzvX38sK14od7cu/S+42ckcJSc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ojK8sELjJ/ujzg1edXaP2vMzdGs+8XWO
        MK6Zd4snx/g1qV3MVNSDc0RVfrcE3c6pmWxdIVF8R/oG2qRSZITC3e3gIMs4i/bT
        DmXBvqIkdIe4L6gWdZPdQ6Nc7QXcjVLW/SK6XB+9j3M6BcpJo3QSfBVVk+YsdZxb
        eoOTzDQsa3A=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 16F8714CC29;
        Mon,  8 Jul 2019 15:24:12 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 7F04714CC28;
        Mon,  8 Jul 2019 15:24:11 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/1] diff: release all handles before running external diff
References: <pull.213.git.gitgitgadget@gmail.com>
Date:   Mon, 08 Jul 2019 12:24:10 -0700
In-Reply-To: <pull.213.git.gitgitgadget@gmail.com> (Johannes Schindelin via
        GitGitGadget's message of "Thu, 04 Jul 2019 02:16:22 -0700 (PDT)")
Message-ID: <xmqqr270xrc5.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F6EC3EBE-A1B5-11E9-AC22-72EEE64BB12D-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> On Windows, it is not possible to overwrite a file as long as any process
> holds a read handle to it. Even keeping regions memory-mapped prevents that.

That second sentence was quite helpful, as I do recall us closing
after mmapping.  Without it, the justification becomes quite weak.


