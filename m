Return-Path: <SRS0=Ralj=CP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 338C5C433E2
	for <git@archiver.kernel.org>; Sun,  6 Sep 2020 21:52:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DBA3D207BB
	for <git@archiver.kernel.org>; Sun,  6 Sep 2020 21:52:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="bg+q+upH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726683AbgIFVwz (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 6 Sep 2020 17:52:55 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:57293 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726292AbgIFVwx (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 Sep 2020 17:52:53 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E806EDC89A;
        Sun,  6 Sep 2020 17:52:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=J0oGpwCcv34yK/KCTxcDDLUmdPQ=; b=bg+q+upHavXCaIHSSxyI
        qOEo5xl6gxmhPOmytow+MB+Ex9zN6y1wQdk8gNIWTv3nITFkpZCKHdfKlXNnjyNb
        j5fQgvZ+RUKUdlO1s6WkwUQydNyH3ySzbfk+9N4ks3VoRuQH7Fx3rxHjodqSWD2Y
        Smgj2BzZS9aqJw6Umf54H00=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         q=dns; s=sasl; b=cCVbb6n+CkJxT8KRMr3uoyI94DgGc1Qp8elMstpaeuByTi
        6UdhbxH4XBYcMDLowD2AUeYdITwn/KlW4jNrfz4hYpHf+atM78bzQsPLQbi3pr6E
        qs0kaK3XsuDruIaMAmNENcghe/L/R9Iznsj+bpNkuNcrR+JzkXLIBpAMSdmo0=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id D5423DC899;
        Sun,  6 Sep 2020 17:52:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 1C4A4DC898;
        Sun,  6 Sep 2020 17:52:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Sergey Organov <sorganov@gmail.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: [PATCH 0/2] log_tree_diff: simplify
References: <20200828110526.21145-1-sorganov@gmail.com>
Date:   Sun, 06 Sep 2020 14:52:44 -0700
Message-ID: <xmqq1rje4loz.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4C68D346-F08B-11EA-AC99-843F439F7C89-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sergey Organov <sorganov@gmail.com> writes:

> These patches are pure code quality improvements, -- they should introduce no
> changes in behavior.
>
> Sergey Organov (2):
>   log_tree_diff: get rid of code duplication for first_parent_only
>   log_tree_diff: get rid of extra check for NULL
>
>  log-tree.c | 21 +++++----------------
>  1 file changed, 5 insertions(+), 16 deletions(-)

It's been so long since I looked at the codepath that it wasn't
immediately clear to me if we are doing the right thing around
log->parent until I reread 91539833 (Log message printout cleanups,
2006-04-17) to rediscover what the field was for, but everything
looks good to me.
