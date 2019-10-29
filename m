Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4C9421F4C0
	for <e@80x24.org>; Tue, 29 Oct 2019 02:29:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730657AbfJ2C3F (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 Oct 2019 22:29:05 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:52324 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728497AbfJ2C3F (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Oct 2019 22:29:05 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B34E78CA55;
        Mon, 28 Oct 2019 22:29:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=gaLAFd/OvLuOWI+HUz18vQW3YN8=; b=EcD6wb
        03n7YumGeNVnnMVWaUZav+JstPo5r8/+k7ArJcbqQn+qDxnN5g2f0yRXNfj5wWgv
        u1WnB/2VRk0jxJQ5/rM0s7nbQoDLlijTWZSebPa7vdRGMByCqI+ovt0r3EycKMR5
        6mJwUZr0n7k0Rl3mbBBrj24RnUfAElpdRvKa0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=pykMXaXnWJZ6yDXLW9zdL+mO8qeB61UL
        1nSTTjmsjQx5dpGPOL7WoTp06DRRM4BNBWLQhqp+nhE7MxTrX1QVaFXTxxewMf3s
        04u193wazn0roSUr978yxncOyvTcYcoofs8AJmjwAGQ/vghq8vIrXZ5NUKMagIkv
        ChxIXJT0JkM=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id AAC128CA54;
        Mon, 28 Oct 2019 22:29:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id DADC38CA4F;
        Mon, 28 Oct 2019 22:29:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Mihail Atanassov <m.atanassov92@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH v2] Documentation/git-bisect.txt: add --no-ff to merge command
References: <20191028220122.21449-1-m.atanassov92@gmail.com>
        <20191028235426.GF12487@google.com>
Date:   Tue, 29 Oct 2019 11:28:59 +0900
In-Reply-To: <20191028235426.GF12487@google.com> (Jonathan Nieder's message of
        "Mon, 28 Oct 2019 16:54:26 -0700")
Message-ID: <xmqqmudk709g.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DEA2EC4A-F9F3-11E9-811A-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

> Mihail Atanassov wrote:
>
>> The hotfix application example uses `git merge --no-commit` to apply
>> temporary changes to the working tree during a bisect operation. In some
>> situations this can be a fast-forward and `merge` will apply the hotfix
>> branch's commits regardless of `--no-commit` (as documented in the `git
>> merge` manual).
>>
>> In the pathological case this will make a `git bisect run` invocation
>> loop indefinitely between the first bisect step and the fast-forwarded
>> post-merge HEAD.
>>
>> Add `--no-ff` to the merge command to avoid this issue.
>
> Makes sense.
>
>> Changes since v1:
>>  - removed comment change
>
> This kind of note, that doesn't need to be recorded in the Git commit
> history, should go after the "---" marker.  See [1]:

Thanks for mentoring.  No need to resend as I can edit it out while
queuing.

Thanks both.

>
>   You often want to add additional explanation about the patch, other
>   than the commit message itself. Place such "cover letter" material
>   between the three-dash line and the diffstat. For patches requiring
>   multiple iterations of review and discussion, an explanation of
>   changes between each iteration can be kept in Git-notes and inserted
>   automatically following the three-dash line via `git format-patch
>   --notes`.
>
>> Signed-off-by: Mihail Atanassov <m.atanassov92@gmail.com>
>> ---
>>  Documentation/git-bisect.txt | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> Except for that one nit,
> Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
>
> Thanks.
>
> [1] https://www.kernel.org/pub/software/scm/git/docs/SubmittingPatches.html#send-patches
