Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74354C433DB
	for <git@archiver.kernel.org>; Mon,  1 Feb 2021 23:02:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 267F764EAA
	for <git@archiver.kernel.org>; Mon,  1 Feb 2021 23:02:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230055AbhBAXCt (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Feb 2021 18:02:49 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50010 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229999AbhBAXCr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Feb 2021 18:02:47 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id EA5B99431D;
        Mon,  1 Feb 2021 18:02:06 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=zaEMUn8MYNJEjWpTVYOTIu8CGPc=; b=dPOjgR
        6K62lNpsfD7sg8ROQtreZu2Hwv5zYHU4/8U25GtvPGjh8BfnH2+4mmKhU2MnqB/H
        KmvpAeyvCKcN8KNeNPnRZUzinpskwRf2ypW84E0NbcJW+gp8ki2tzcZCoZ9LahIZ
        s1A4cJ9xgN+WqNogKPC8OdHuqrZW+YKg4vkK0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=PMTXKTmevtnurRSq0EqnwySCqW0T/JFP
        zdKIofStLUkzzPbJcO8UPZnidGWZcPaMB/RhInL6sEb4gNhkum26XhaoBmLeJIOS
        YBkxN/3e7dFjJJAG27AGqvaNXNiEbbEs9j/sjteoA6QSyBgIIkugnNI3ENWAyjXQ
        ShBjvJVVxps=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C08819431C;
        Mon,  1 Feb 2021 18:02:06 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0C32294318;
        Mon,  1 Feb 2021 18:02:05 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v3 01/17] commit: use config-based hooks
References: <20201222000435.1529768-1-emilyshaffer@google.com>
        <20201222000435.1529768-2-emilyshaffer@google.com>
Date:   Mon, 01 Feb 2021 15:02:03 -0800
In-Reply-To: <20201222000435.1529768-2-emilyshaffer@google.com> (Emily
        Shaffer's message of "Mon, 21 Dec 2020 16:04:19 -0800")
Message-ID: <xmqqwnvrie8k.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8077A318-64E1-11EB-A163-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer <emilyshaffer@google.com> writes:

> @@ -175,6 +183,8 @@ invoked after a commit is made.
>  This hook is meant primarily for notification, and cannot affect
>  the outcome of `git commit`.
>  
> +Hooks executed during 'post-commit' will run in parallel by default.

The "by default" makes it sound as if there is a way to force
'post-commit' alone serially, but other than hook.jobs that can be
used to uniformly make everything run serially, I didn't find a way
to do so.

The comment applies to all the "by default" in this latter half of
the series.

Thanks.
