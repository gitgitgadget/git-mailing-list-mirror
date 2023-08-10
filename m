Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 174D8C001E0
	for <git@archiver.kernel.org>; Thu, 10 Aug 2023 01:13:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231196AbjHJBNn (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Aug 2023 21:13:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbjHJBNm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Aug 2023 21:13:42 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AD001BD
        for <git@vger.kernel.org>; Wed,  9 Aug 2023 18:13:33 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id EB33924CB5;
        Wed,  9 Aug 2023 21:13:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=svN50j/adzIq94DUqowUZ+SZP5+5ovZHgD0Vu2
        faAPs=; b=d6c/VaT8V151KyE9dDwlSh+nI6AhVVNahI1IJ1uW6xfdABWVIVp5Qp
        X+THIqYE1+BPba6v2Ljziyr0/ivyVXe4YAVO3Cn7F0Ry3kDCuooZ1OSY3V63t733
        2ppPL4X9l49ARJfDEmbxPUVwZo0Spnd7r/HbkH3/RfdOQ4zXKURyk=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id CFA6524CB4;
        Wed,  9 Aug 2023 21:13:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.168.215.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 70F5024CB3;
        Wed,  9 Aug 2023 21:13:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Wesley Schwengle <wesleys@opperschaap.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] Fix grammar in git push man page
References: <20230810004044.1420385-1-wesleys@opperschaap.net>
Date:   Wed, 09 Aug 2023 18:13:28 -0700
In-Reply-To: <20230810004044.1420385-1-wesleys@opperschaap.net> (Wesley
        Schwengle's message of "Wed, 9 Aug 2023 20:40:25 -0400")
Message-ID: <xmqqcyzvk8cn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1D917DA0-371B-11EE-BCE6-C2DA088D43B2-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Wesley Schwengle <wesleys@opperschaap.net> writes:

> Subject: Re: [PATCH] Fix grammar in git push man page

We would probably phrase it more like

	Subject: git-push.txt: fix grammar

> While working on a blog post and using grammarly it suggested these two
> changes.
>
> Signed-off-by: Wesley Schwengle <wesleys@opperschaap.net>
> ---
>  Documentation/git-push.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
> index 297927d866..6926e79719 100644
> --- a/Documentation/git-push.txt
> +++ b/Documentation/git-push.txt
> @@ -37,7 +37,7 @@ the default `<refspec>` by consulting `remote.*.push` configuration,
>  and if it is not found, honors `push.default` configuration to decide
>  what to push (See linkgit:git-config[1] for the meaning of `push.default`).
>  
> -When neither the command-line nor the configuration specify what to
> +When neither the command line nor the configuration specifies what to

The fix for the verb is very much correct and appreciated.

The first part is debatable for two reasons.

Locally, what is "fixed" is only one of the two instances of
"command-line" in this file.  If we were to clean it up, you would
at least want to do the other one for consistency.

Globally, git grep -i "command.line" in Documentation (excluding
Documentation/RelNotes, as that part is almost exclusively written
by me and shows my bias) gives ~200 hits for "command line" and ~100
hits for "command-line".  We pretty much use them inter-changeably,
in other words.

But for the grammar fix, it probably makes sense to just fix the
verb without touching "command-line"; you have ~100 other instances
that want to be touched for consistency, and they shouldn't take the
verb fix hostage.

Thanks.

>  push, the default behavior is used, which corresponds to the `simple`
>  value for `push.default`: the current branch is pushed to the
>  corresponding upstream branch, but as a safety measure, the push is
