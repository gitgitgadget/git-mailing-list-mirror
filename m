Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E744F1F453
	for <e@80x24.org>; Sat, 27 Apr 2019 00:01:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727226AbfD0ABt (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Apr 2019 20:01:49 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57370 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727086AbfD0ABt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Apr 2019 20:01:49 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 39587157449;
        Fri, 26 Apr 2019 20:01:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ALXszegLo/kN4G+M5hZeKTaUdQQ=; b=Z/0NfG
        y/nqeOqydTbThGzWWpgOOF0opmtjjftJKnDnlLJhfa8QMjdE2+PsH9KQTzMiGe6q
        meLylAs5Nn5TdvzHveC8vnZx4i4KvWUzRY8HQMM8XsZfrb2Dv5+TqXq92HWXtFBp
        Wua0+0Z4JXDUalzc2v53RypUJxQoLDUbE74do=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=pkrpwfoukK0jEzeeNd50V7Q1wmZLvF+j
        5AU1J9mj8jl7zvrGT7NCE+3b+xfK5N8hkEqttig4lzqdZkknBg3QZEJR3C+bBtNP
        FbhDytKU5dCrpitGBkCNvOcC6mEh4udI0kDleswkc4zbycyapzsqaMjAmVss28u0
        XAR8O63DCMw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 30CAF157448;
        Fri, 26 Apr 2019 20:01:47 -0400 (EDT)
Received: from pobox.com (unknown [34.76.255.141])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 87CCB157447;
        Fri, 26 Apr 2019 20:01:46 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 0/3] allow checkout and branch to create branches on a merge base
References: <cover.1556226502.git.liu.denton@gmail.com>
        <cover.1556305561.git.liu.denton@gmail.com>
        <xmqqlfzwtlft.fsf@gitster-ct.c.googlers.com>
        <20190426234024.GA28055@dev-l> <20190426235220.GB28055@dev-l>
Date:   Sat, 27 Apr 2019 09:01:45 +0900
In-Reply-To: <20190426235220.GB28055@dev-l> (Denton Liu's message of "Fri, 26
        Apr 2019 16:52:20 -0700")
Message-ID: <xmqq8svwtixi.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A5F1EDF2-687F-11E9-B49B-DF19F34BB12D-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

> Out of respect for your time as the maintainer (since you have a lot of
> topics to deal with), how do you prefer small fixups be submitted?
>
> * A complete reroll of the whole series
> * A replacement for one patch in the series
> * A follow-up email with an "oops, please change x to y"

Depends on how small your "small" is, but in general, the above is a
good approximation of the preference order.

Wholesale replacement without having to think is the easiest.  When
the latest round is not from a distant past (i.e. less than two
weeks old), replacement patches for only selected steps is also
fine, as I can pretend it is a wholesale replacement by completing
the missing patches by picking them from the mailbox while using the
updated ones.

"Please change x to y" is the least welcome, with a big exception
that it is the easiest when it is a change to a few words in a
single place, either in the log message or a file contents, of a
single patch topic---in other words, something I can deal with
"commit --amend" and needs less than 2 minutes to handle.  Anything
larger than that size and requires me to fire up "rebase -i" starts
to make me wonder why _I_ am doing that, not the topic owner.

Thanks.
