Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCD30C433E0
	for <git@archiver.kernel.org>; Mon,  8 Mar 2021 23:38:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C9DC64FA9
	for <git@archiver.kernel.org>; Mon,  8 Mar 2021 23:38:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230410AbhCHXiW (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Mar 2021 18:38:22 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52586 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231307AbhCHXiO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Mar 2021 18:38:14 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 01F10BB4B9;
        Mon,  8 Mar 2021 18:38:14 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=LrPvnpdut7NS0heBHd7/ALzfwhQ=; b=swOHT8
        ZM1xyqcWCtGLGoH2sJ3d6m+0y6yeydrowc+8DaFUkcH9xjkz5LaJ0gNII0MtKg0J
        hWwBhR0FekmkUbd2bK4k7ZskTxlLcaVhHIlMLsZ/DDABa7BmxtQBzpCP6tNqbzLM
        tftpQGgB3+kWxeXdFvsrBF8sWQQISxsCNKBkA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=V6GyuJDLMzKxHuMiM0Zj1leCSIjjZEqW
        cdeu/Or45+BDbVguywCPkz1sWJeWveYnzFnOLjLfKl3C4RZnqEuy8i8+BusXus8n
        QDHN+hO4QPr1Gv32QYeGWjuslN7YEGOD+eP/MtaScw0vK1dAMgvLpQ5VQSJVxk+1
        Noy+rtx7T4Q=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id EE5BFBB4B8;
        Mon,  8 Mar 2021 18:38:13 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 6A7B3BB4B7;
        Mon,  8 Mar 2021 18:38:13 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Mike Frysinger <vapier@gentoo.org>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] contrib/rebase-catchup: helper for updating old branches
References: <20210308230345.28498-1-vapier@gentoo.org>
Date:   Mon, 08 Mar 2021 15:38:12 -0800
In-Reply-To: <20210308230345.28498-1-vapier@gentoo.org> (Mike Frysinger's
        message of "Mon, 8 Mar 2021 18:03:45 -0500")
Message-ID: <xmqqk0qh43ob.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 596263CA-8067-11EB-A143-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Mike Frysinger <vapier@gentoo.org> writes:

> For people who want to rebase their work onto the latest branch
> (instead of merging), but there's many conflicting changes.  This
> allows you to address those conflicts one-by-one and work through
> each issue instead of trying to take them all on at once.

I wonder how well this compares or complements with Michael
Haggerty's "git imerge".

> If there's no interest in merging this into contrib, then this is more spam,
> and anyone interested can use https://github.com/vapier/git-rebase-catchup

The thinking during the past several years is that the Git ecosystem
and userbase have grown large enough, and unlike our earlier years,
individual add-on's like this (and "imerge" I mentioned earlier) can
thrive without being in-tree to gain an undue exposure boost over
its competitors, so I doubt that adding more stuff to contrib/ would
be a good direction to go in the longer term.

>  create mode 100755 contrib/rebase-catchup/git-rebase-catchup.py

And it does not help for this to be written in Python (which we've
been moving away from).

Having said all that, the end-user community may benefit from having
a well curated set of third-party tools advertised at a single
autoritative-sounding place, but it is dubious that contrib/
subdirectory of my tree should be such a place (I won't be its
curator anyway).

Perhaps there is an opening for non-code contribution for those
without much programming experience but with great organizational
skills.

Thanks.
