Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 15E2B201C8
	for <e@80x24.org>; Mon, 13 Nov 2017 05:25:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751305AbdKMFZn (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Nov 2017 00:25:43 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54149 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750949AbdKMFZn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Nov 2017 00:25:43 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B515498F7B;
        Mon, 13 Nov 2017 00:25:42 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=MGZ1Fu5vba4Nmq7BY0R2IGwgfDM=; b=klmT7j
        pnTjWRTWqux788aMjUxxx6kXcJ/iHGv24Ba9ghTqE5rvbGdIZqB3oQjIylQYSD8J
        BACGE6DSC8VjJlzePs3+c/NaH61494YDTnnpHth+SEY5D90w0Jf+Hri4tyTjfBVO
        MdOMZCGBioRktz4lwA724L2yhgPQxT0guzVyo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=GiF5dxd2X49FZtTjo4u9PBfi++iJMIby
        uLN6Bhr/Yaqhr89vboEY5OWZIYwN56YCsqmg8YSWsqCjk+MPlDGl5XN7/MH+GOhe
        vwQc//yeCBE8dOpQyh2Z/tWpX6DEVxKxgPr18qwYZf77r9J5pLVtRhZZJEC+jwOs
        +lZ8sKCuWY8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id AAA5298F7A;
        Mon, 13 Nov 2017 00:25:42 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 1A69D98F79;
        Mon, 13 Nov 2017 00:25:42 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 4/4] sequencer: Show rename progress during cherry picks
References: <20171110173956.25105-1-newren@gmail.com>
        <20171110173956.25105-5-newren@gmail.com>
Date:   Mon, 13 Nov 2017 14:25:41 +0900
In-Reply-To: <20171110173956.25105-5-newren@gmail.com> (Elijah Newren's
        message of "Fri, 10 Nov 2017 09:39:56 -0800")
Message-ID: <xmqqpo8m92cq.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 17800358-C833-11E7-A836-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> Subject: Re: [PATCH 4/4] sequencer: Show rename progress during cherry picks

Style: s/Show/show/

> When trying to cherry-pick a change that has lots of renames, it is
> somewhat unsettling to wait a really long time without any feedback.
>
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>  sequencer.c | 1 +
>  1 file changed, 1 insertion(+)

Makes sense.


> diff --git a/sequencer.c b/sequencer.c
> index 2b4cecb617..247d93f363 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -448,6 +448,7 @@ static int do_recursive_merge(struct commit *base, struct commit *next,
>  	o.branch2 = next ? next_label : "(empty tree)";
>  	if (is_rebase_i(opts))
>  		o.buffer_output = 2;
> +	o.show_rename_progress = 1;
>  
>  	head_tree = parse_tree_indirect(head);
>  	next_tree = next ? next->tree : empty_tree();
