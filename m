Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ECA5C433EF
	for <git@archiver.kernel.org>; Sat, 26 Mar 2022 00:15:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230327AbiCZARB (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Mar 2022 20:17:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230301AbiCZAQ7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Mar 2022 20:16:59 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC66F20596D
        for <git@vger.kernel.org>; Fri, 25 Mar 2022 17:15:20 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 78A3711AFDE;
        Fri, 25 Mar 2022 20:15:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=FKD9naw1wcbXhE9clDGKTvAHuXJ+IuXqsI00zx
        jZ+i0=; b=WH9ssFKpIcGzivI2ksl7hUo53kFkk3XTJK8rXo1H83z920SO/Pj/Hu
        D56Xp6+UZXSLW4XeOHEa8yfV95aN86JCyrQJpSVfAtf844tKXGeeeGr8ijAlwNIc
        bO/rSd31uc+WlQRnKa7k+XQTFtyUJkS3LF59pr4wnJfXsLMeSCmOs=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 706F511AFDD;
        Fri, 25 Mar 2022 20:15:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.227.145.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D58D611AFDC;
        Fri, 25 Mar 2022 20:15:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Danny Lin <danny0838@gmail.com>
Cc:     git develop <git@vger.kernel.org>
Subject: Re: [PATCH] git-prompt: fix sequencer/todo detection
References: <20220325145301.3370-1-danny0838@gmail.com>
Date:   Fri, 25 Mar 2022 17:15:15 -0700
In-Reply-To: <20220325145301.3370-1-danny0838@gmail.com> (Danny Lin's message
        of "Fri, 25 Mar 2022 22:53:01 +0800")
Message-ID: <xmqqtubl7eng.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D0741210-AC99-11EC-8E0C-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Danny Lin <danny0838@gmail.com> writes:

> Previous case does not correctly check the "p ..." pattern.
>
> Signed-off-by: Danny Lin <danny0838@gmail.com>
> ---
>  contrib/completion/git-prompt.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/contrib/completion/git-prompt.sh b/contrib/completion/git-prompt.sh
> index db7c0068fb..8ae341a306 100644
> --- a/contrib/completion/git-prompt.sh
> +++ b/contrib/completion/git-prompt.sh
> @@ -315,7 +315,7 @@ __git_sequencer_status ()
>  	elif __git_eread "$g/sequencer/todo" todo
>  	then
>  		case "$todo" in
> -		p[\ \	]|pick[\ \	]*)
> +		p[\ \	]*|pick[\ \	]*)
>  			r="|CHERRY-PICKING"
>  			return 0
>  		;;

The original obviously is broken ;-)  Will queue.  Thanks.
