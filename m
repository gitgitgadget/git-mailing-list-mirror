Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ECEE6207EC
	for <e@80x24.org>; Thu,  6 Oct 2016 18:06:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754164AbcJFSGk (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Oct 2016 14:06:40 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64956 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754014AbcJFSGi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Oct 2016 14:06:38 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9234042C0B;
        Thu,  6 Oct 2016 14:06:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Tm9gmvK6gQr8f2GtBze2kMkbNWM=; b=G7T068
        824hCjxggFV+hUhn/BvSrjuxAd6Af0Su13qvsDiDVPiG7aXwKdi+A0RYakSGzGXW
        0NiQy1vOK5U6BO6fvvpBwAIV6e2vYeC8VzOeG/KH+EsLi12Dm22TvxK876lGqDPd
        1wYH4GKN9ul1Xp67GILcSXNRpQNREXekPQ1Pk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=L9HS7l6yxXwZBBLQBWxqKcjmhjlIooKQ
        YKGzSJsEm3OdpKr7M90mm5jy2f9G+Xfj8r9cJFHLXTnW2NBxl9LC4uy+7ZO4lYef
        qNRcb/OFhHutGewqhzRA2TEjxJSLFjIJQSK2wq/Wi0KWJIAvalI9UnKmAghAHzuy
        TDAWvxa+uwE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8A06D42C0A;
        Thu,  6 Oct 2016 14:06:06 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0B97542C08;
        Thu,  6 Oct 2016 14:06:05 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Sergey Organov <sorganov@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 6/6] Documentation/git-merge.txt: get rid of irrelevant references to git-pull
References: <cover.1475678515.git.sorganov@gmail.com>
        <b91ef5e97c60a85cce1a13f88a19218fd0f05655.1475678515.git.sorganov@gmail.com>
        <xmqqzimioc7s.fsf@gitster.mtv.corp.google.com>
        <87shsapjiz.fsf@javad.com>
        <xmqq60p6o4js.fsf@gitster.mtv.corp.google.com>
        <87h98pps7a.fsf@javad.com>
Date:   Thu, 06 Oct 2016 11:06:04 -0700
In-Reply-To: <87h98pps7a.fsf@javad.com> (Sergey Organov's message of "Thu, 06
        Oct 2016 15:39:21 +0300")
Message-ID: <xmqqmvihl5df.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8D031A88-8BEF-11E6-8294-F99D12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sergey Organov <sorganov@gmail.com> writes:

> Ah, I now see. I tried to keep the text intact as much as possible, and
> only split it into description and a note. Well, how about this then:

Much better than your earlier patch, but I am not sure if the
updated one is that much better compared to the original.

The pre- and post- state of this "how about this" patch essentially
say the same thing, and I suspect that the primary reason why you
think the post- state is easier to read is because you wrote it,
while the reason why I do not see much difference is because I
didn't write the updated one ;-).

I do find "In this case, ... store the combined history" in the
original a bit awkward to read, but most of that awkardness is
inherited by the updated text.  It may benefit from hinting why a
new commit is not needed a bit stronger.  Here is my attempt:

    When the commit we are merging is a descendant of the current
    HEAD, the history leading to the named commit can be, and by
    default is, taken as the combined history of the two.  Our
    history is "fast forwarded" to their history by updating `HEAD`
    along with the index to point at the named commit.

    This often happens when you are following along somebody else's
    work via "git pull" without doing your own development.

I think the awkwardness I felt in the original and your version is
gone from the above attempt, but I doubt that it is better over
either of them in any other way.

> diff --git a/Documentation/git-merge.txt b/Documentation/git-merge.txt
> index b758d55..479400f 100644
> --- a/Documentation/git-merge.txt
> +++ b/Documentation/git-merge.txt
> @@ -135,15 +135,17 @@ will exit early with the message "Already up-to-date."
>  FAST-FORWARD MERGE
>  ------------------
>  
> -Often the current branch head is an ancestor of the named commit.
> -This is the most common case especially when invoked from 'git
> -pull': you are tracking an upstream repository, you have committed
> -no local changes, and now you want to update to a newer upstream
> -revision.  In this case, a new commit is not needed to store the
> +When current branch head is an ancestor of the named commit,
> +a new commit is not needed to store the
>  combined history; instead, the `HEAD` (along with the index) is
>  updated to point at the named commit, without creating an extra
>  merge commit.
>  
> +This is very common case when 'git merge' is invoked from 'git
> +pull': you are tracking an upstream repository, you have committed
> +no local changes, and now you want to update to a newer upstream
> +revision.  
> +
>  This behavior can be suppressed with the `--no-ff` option.
>  
>  TRUE MERGE
>
> -- Sergey
