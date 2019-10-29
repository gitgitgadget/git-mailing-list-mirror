Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D5ABE1F4C0
	for <e@80x24.org>; Tue, 29 Oct 2019 03:03:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730780AbfJ2DDM (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 Oct 2019 23:03:12 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:55915 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729145AbfJ2DDL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Oct 2019 23:03:11 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id CEEA8A988B;
        Mon, 28 Oct 2019 23:03:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=JoJNPa2paOBcbVtPjpUvqn0Xncc=; b=VskA2+
        7x459wt6rCLHyDWZFmBifx2XcqIsSaJsk8EfbG7quvOGP1YiJfN/xmT/PEd2yMLb
        RR10B76zsYt46MMJHbqdpJ29Aa/3By6JbQyt9nOhPWMKbvuygmvSlyVinYFbcrTJ
        65Ia3ZuiloNcSFMF+lUxP2Q+7zVl6SxgQFjaM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=H6gUE7oYSI0qVV9JqpEYgXLPgTEFAC+E
        oMr6LXK/yT3vFBgxNF4xPkuV/cETtavngyFSPdZrNAHDw5WIUO6Zb1mVJu9N6tiy
        i7JUW/sOYT64NC1rF+dA/NZ1RGnfLIDuybUVKfGb+hbCiTww1tPm3BcPhj+O4ioI
        FW7q/b0TfLM=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C7DE9A988A;
        Mon, 28 Oct 2019 23:03:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 01113A9889;
        Mon, 28 Oct 2019 23:03:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Miriam Rubio <mirucam@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [Outreachy] [PATCH] clone: rename static function `dir_exists()`.
References: <20191028165523.84333-1-mirucam@gmail.com>
Date:   Tue, 29 Oct 2019 12:03:04 +0900
In-Reply-To: <20191028165523.84333-1-mirucam@gmail.com> (Miriam Rubio's
        message of "Mon, 28 Oct 2019 17:55:23 +0100")
Message-ID: <xmqqimo86yon.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A19DFFE2-F9F8-11E9-A0AC-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Miriam Rubio <mirucam@gmail.com> writes:

> builtin/clone.c has a static function dir_exists() that
> checks if a given path exists on the filesystem.  It returns
> true (and it is correct for it to return true) when the
> given path exists as a non-directory (e.g. a regular file).
>
> This is confusing.  What the caller wants to check, and what
> this function wants to return, is if the path exists, so
> rename it to path_exists().
>
> Signed-off-by: Miriam Rubio <mirucam@gmail.com>
> ---
>  builtin/clone.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

With a narrowed scope, the patch and its explanation are both
perfect ;-)

Now, with this localized change behind us, we may want to consider
what to do with file_exists(path) that does not ensure the path is a
file.  It would be a separate topic, and it is OK for the result
after such consideration to be "let's not go further for now".  It
also is OK for it to be "I am interested in digging further", too.

Thanks.  Will queue.
