Return-Path: <SRS0=QY2u=4X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57967C10DCE
	for <git@archiver.kernel.org>; Fri,  6 Mar 2020 17:54:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 295AD206E2
	for <git@archiver.kernel.org>; Fri,  6 Mar 2020 17:54:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="P3iH0h3n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726162AbgCFRyO (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Mar 2020 12:54:14 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55232 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725835AbgCFRyO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Mar 2020 12:54:14 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C24533D1F8;
        Fri,  6 Mar 2020 12:54:08 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=IvQcwDhKZuBLLf61EZMdsCdfnHM=; b=P3iH0h
        3nW+2NRUspP6UO5qm+ylbnhWWyP2QrLIyGB8vSCjuYlOX0OD9eFywX61zPEokpZw
        tCwJYhPdyGvftxqt/jPiEBdir1chIso94G+OwsEwhw8/r7eUBFQnI8a2PErCK/Zo
        o4qsxk25DF/sQ0ZDGIhhkrpgVVuF8mL2vO8rA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=KNFZDu4sb3+/avyX+fNPTSGmqLWIgFHk
        94vQFpFhnakXNeK5Q0t3Fa/+jKZxQGyjJYNk5GmeBa+ZTwlyQhW+GH4/ze2NIgV5
        mG4nr65KHv23jMY2uwYiGKFkqz3rrerMXh+sSp+G9T/sTNONmRFzegBAomQQK4WS
        mCQNiPl0iC4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B7D973D1F7;
        Fri,  6 Mar 2020 12:54:08 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E76C23D1F6;
        Fri,  6 Mar 2020 12:54:07 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     git@vger.kernel.org, Jacob Keller <jacob.keller@gmail.com>
Subject: Re: What's cooking in git.git (Mar 2020, #02; Thu, 5)
References: <xmqq4kv24fzo.fsf@gitster-ct.c.googlers.com>
        <20200306172913.GF1571684@cat>
Date:   Fri, 06 Mar 2020 09:54:06 -0800
In-Reply-To: <20200306172913.GF1571684@cat> (Thomas Gummerer's message of
        "Fri, 6 Mar 2020 17:29:13 +0000")
Message-ID: <xmqqv9nh2wu9.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7A1CECB2-5FD3-11EA-9344-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thomas Gummerer <t.gummerer@gmail.com> writes:

> On 03/05, Junio C Hamano wrote:
>> * tg/retire-scripted-stash (2020-03-05) 2 commits
>>   (merged to 'next' on 2020-03-05 at 8e82eb9dec)
>>  + stash: remove the stash.useBuiltin setting
>>  + stash: get git_stash_config at the top level
>> 
>>  "git stash" has kept an escape hatch to use the scripted version
>>  for a few releases, which got stale.  It has been removed.
>> 
>>  Will merge to 'master'.
>
> I was thinking only getting this into a release after 2.26 dropped,
> and have written the docs with that in mind.  Not sure if this "Will
> merge to 'master'" means that you were planning to get this into 2.26?

Committed to merge to 'master' sometime in the future, but it still
is not known if it will be before or after the upcoming release.

> I have a slight preference for waiting until after the release to
> merge this down, but I'm okay with doing it now.

Being cautious is good.  I do not think this is ultra-urgent; as you
said in <20200303174613.3557960-2-t.gummerer@gmail.com>, the "bug"
has been with us for a couple of releases already.  I do not mind
keeping it in 'next' and merge as a part of the first batch after
the release.


> If we want to do so
> we need to tweak the description in 'Documentation/config/stash.txt'
> to refer to 2.25 instead of 2.26.
>
> Either way, we'll need the patch below on top, as I made an
> embarrassing copy-paste mistake.  Sorry for the trouble.

Heh, I think 8a2cd3f5 ("stash: remove the stash.useBuiltin setting",
2020-03-03) that is on 'next' already has it (and s/Variable/variable/
casefix).

Thanks.

>
> --- >8 ---
> Subject: [PATCH] Documentation/config/stash: make description refer to stash
>
> Correct the description to refer to stash instead of rebase.  It was
> copied from Documentation/config/rebase.txt, and this author was not
> careful enough to replace all occurrences of rebase properly.
>
> Reported-by: Jacob Keller <jacob.keller@gmail.com>
> Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
> ---
>  Documentation/config/stash.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/config/stash.txt b/Documentation/config/stash.txt
> index 0f3db821f6..be81bd1656 100644
> --- a/Documentation/config/stash.txt
> +++ b/Documentation/config/stash.txt
> @@ -1,7 +1,7 @@
>  stash.useBuiltin::
>  	Unused configuration Variable.  Used in Git versions 2.22 to
>  	2.26 as an escape hatch to enable the legacy shellscript
> -	implementation of rebase. Now the built-in rewrite of it in C
> +	implementation of stash. Now the built-in rewrite of it in C
>  	is always used. Setting this will emit a warning, to alert any
>  	remaining users that setting this now does nothing.
