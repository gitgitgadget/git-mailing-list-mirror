Return-Path: <SRS0=i2G4=DF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47EBEC2D0A8
	for <git@archiver.kernel.org>; Mon, 28 Sep 2020 18:43:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D25A920809
	for <git@archiver.kernel.org>; Mon, 28 Sep 2020 18:43:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="TsoqTV4K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726547AbgI1SnR (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Sep 2020 14:43:17 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:58658 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726500AbgI1SnR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Sep 2020 14:43:17 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C79F2EF2D0;
        Mon, 28 Sep 2020 14:43:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=j407QL985Pyo4mCe5S+QXiheV3o=; b=TsoqTV
        4Kv9IcU9YorWMtfMlkhfKSyrJneAYlTzoNJsegoWA1gm0UVe+KDZT0XaaxzUarB2
        T1ufvnGsoyQH8nXt/kaMYn4M8i2+6w2fYWEaIHyd7XbN9XxGCIhOnoJkBHHpvJi8
        BNu4m/esFJlR4U/LPr7/1UAep7WK9J1OOGWek=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=jXpaB7P1xVw9adfMQWdHIl9bZHKGeLEz
        qPnWjFM5CjyNy8zB0N4DmdpTQ/eZgC+AGjwKEpdXAzM3LFFzTZq4oDV6oGdT53Ur
        xR++72y9u0Oy/dnKYRqN7+BWlvHB4WQpngS18j53Dbcxr1lCma/am4BLIf5Ik/UB
        Xkem2l2oFwg=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C1069EF2CF;
        Mon, 28 Sep 2020 14:43:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 113EAEF2C9;
        Mon, 28 Sep 2020 14:43:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Robert Karszniewicz <avoidr@posteo.de>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] git-completion.bash: stash-show: add --patch-with-stat
References: <20200928110517.24915-1-avoidr@posteo.de>
Date:   Mon, 28 Sep 2020 11:43:11 -0700
In-Reply-To: <20200928110517.24915-1-avoidr@posteo.de> (Robert Karszniewicz's
        message of "Mon, 28 Sep 2020 13:05:17 +0200")
Message-ID: <xmqqh7rhn3nk.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 76A2611E-01BA-11EB-B759-F0EA2EB3C613-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Robert Karszniewicz <avoidr@posteo.de> writes:

> Signed-off-by: Robert Karszniewicz <avoidr@posteo.de>
> ---
>  contrib/completion/git-completion.bash | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index 8be4a0316e..d98c731667 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -3016,7 +3016,10 @@ _git_stash ()
>  		list,--*)
>  			__gitcomp "--name-status --oneline --patch-with-stat"
>  			;;
> -		show,--*|branch,--*)
> +		show,--*)
> +			__gitcomp "--patch-with-stat"
> +			;;

Why is --patch-with-stat so special?  

Without completion support for "--patch" and "--stat", typing
"--<TAB>" after "git stash show" and seeing only "--patch-with-stat"
(which has been made obsolete-but-still-kept synonym immediately
after the other two were invented in 2005) would make a rather
surprising experience to the end users.  For "show" alone, it may
make a lot of sense to complete "git stash show -<TAB>" and offer
"-p".

In any case, it might make more sense to do this instead, and then
rethink what options make sense to these subcommands of "git stash".
I do not think patch-with-stat should be among them.

-  		list,--*)
+  		list,--* | show,--*)
  			__gitcomp "--name-status --oneline --patch-with-stat"

Thanks.
