Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A61AF1F45A
	for <e@80x24.org>; Fri, 16 Aug 2019 21:05:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727708AbfHPVFI (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Aug 2019 17:05:08 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53599 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727548AbfHPVFI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Aug 2019 17:05:08 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id F1E941690D4;
        Fri, 16 Aug 2019 17:05:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=xXRuksjwewwk7I/4LL+DtQRS0Pw=; b=ODuDtz
        losUajSlAQ7NiKIW4eHaXFIOoPUnoQjhWUP6P93Iv0ls2RlneXiiszOU2CbLK8mM
        VS5AyWjPxXDbjkJcbuC53se1IRWXSdLxkP2y2du+/fsqKPznWOg/D/HoEkbcJvzf
        NF4r468EmOt0N/z++DLNwvRRu4fqx/8u21SlE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=G0LgsERaYJXHzQdWi6CJ6QXBhQU/fGlj
        1DvFstGDb6kX2q3+EG2V5cLXdUfxUb0qQXjzKrgh3+/Bx74HFj3elLGz0S+wkzhr
        YzL3B+42hFEl9mHpArX6z0ZU/ubNbXbP1s932cgUMyR+60bBH3RoMVjo9WZgXvLQ
        rVuJLoQKME0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id EA1921690D3;
        Fri, 16 Aug 2019 17:05:05 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id ABE1B1690D0;
        Fri, 16 Aug 2019 17:05:04 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v3 03/24] merge-recursive: enforce opt->ancestor != NULL when calling merge_trees()
References: <20190726155258.28561-1-newren@gmail.com>
        <20190815214053.16594-1-newren@gmail.com>
        <20190815214053.16594-4-newren@gmail.com>
Date:   Fri, 16 Aug 2019 14:05:03 -0700
In-Reply-To: <20190815214053.16594-4-newren@gmail.com> (Elijah Newren's
        message of "Thu, 15 Aug 2019 14:40:32 -0700")
Message-ID: <xmqqtvagzurk.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 850471C2-C069-11E9-BD09-72EEE64BB12D-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> We always want our conflict hunks to be labelled so that users can know
> where each came from.  The previous commit fixed the one caller in the
> codebase which was not setting opt->ancestor (and thus not providing a
> label for the "merge base" conflict hunk in diff3-style conflict
> markers); add an assertion to prevent future codepaths from also
> overlooking this requirement.

Makes sense.
