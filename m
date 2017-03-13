Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C3AA8202C1
	for <e@80x24.org>; Mon, 13 Mar 2017 03:10:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755849AbdCMDKZ (ORCPT <rfc822;e@80x24.org>);
        Sun, 12 Mar 2017 23:10:25 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60411 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1755792AbdCMDKX (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Mar 2017 23:10:23 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id AD9C571D7B;
        Sun, 12 Mar 2017 23:10:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=5DSDB+wqaVpEYbN4Ht70dAgeQA0=; b=QhKNp3
        mhC1vSPEe6D+8pEeTARfHLROao+ueSjfAjmvXgGUKwwwg+xRnojGexmskCqd26+Q
        qTNP8xftUwI/e2oTdoB7ZSWZKF0mWxkvY5FOD8fiG2JowFF4XBf1LUHL0Eth4AXS
        Zl0zFLTDfKT6OxbqDYvS659410YCgY3wiywis=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=SmAaGUxqCHAFh9AQfqQa+kr4o5XooNHZ
        o81ywGIWmaeiUunky0IpfRNiTeYvdq7XBBCH/nD8oaePlLusaiNxMge3Xy06GsIM
        BVpRNqHvW0HrNqCfIk25VbKN6o7LLq2vjYKgDgWjjY+VF4UNmr3UtXKt6xtXdCGw
        Wt2Xfs5slX0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A5FA671D7A;
        Sun, 12 Mar 2017 23:10:21 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 153F471D79;
        Sun, 12 Mar 2017 23:10:21 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Prathamesh Chavan <pc44800@gmail.com>
Cc:     christian.couder@gmail.com, git@vger.kernel.org, jdl@jdl.com
Subject: Re: [Patch v2] t2027: avoid using pipes
References: <CAP8UFD1xQnR8aWVRqu1_k2qhEcR2fOdyHT51aUyq9EdFg7f7Xw@mail.gmail.com>
        <20170310083611.7374-1-pc44800@gmail.com>
Date:   Sun, 12 Mar 2017 20:10:19 -0700
In-Reply-To: <20170310083611.7374-1-pc44800@gmail.com> (Prathamesh Chavan's
        message of "Fri, 10 Mar 2017 14:06:11 +0530")
Message-ID: <xmqqk27tub1g.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 97C8EAC0-079A-11E7-A445-97B1B46B9B0B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Prathamesh Chavan <pc44800@gmail.com> writes:

> From: Prathamesh <pc44800@gmail.com>

Your e-mail header says 

	From: Prathamesh Chavan <pc44800@gmail.com>

and you probably have "[user] name = Prathamesh" somewhere in your
config, and I think that is why we see the above line in format-patch
output and on your sign-off.  If you really prefer to be known as a
person with a single name (without Chavan) to the community, that is
fine, but if that is not the case, perhaps you'd want to review your
config and fix this.

> Whenever a git command is present in the upstream of a pipe, its failure
> gets masked by piping and hence it should be avoided for testing the
> upstream git command. By writing out the output of the git command to
> a file, we can test the exit codes of both the commands as a failure exit
> code in any command is able to stop the && chain.

OK.

> Signed-off-by: Prathamesh <pc44800@gmail.com>

> diff --git a/t/t2027-worktree-list.sh b/t/t2027-worktree-list.sh
> index 848da5f36..a3e77fee5 100755
> --- a/t/t2027-worktree-list.sh
> +++ b/t/t2027-worktree-list.sh
> @@ -31,7 +31,8 @@ test_expect_success '"list" all worktrees from main' '
>  	test_when_finished "rm -rf here && git worktree prune" &&
>  	git worktree add --detach here master &&
>  	echo "$(git -C here rev-parse --show-toplevel) $(git rev-parse --short HEAD) (detached HEAD)" >>expect &&
> -	git worktree list | sed "s/  */ /g" >actual &&
> +	git worktree list >out &&
> +	sed "s/  */ /g" <out >actual &&
>  	test_cmp expect actual
>  '

We'll have "out" as a new leftover file, but it probably would not
make too much of a difference.  We already leave 'expect' and 'actual'
in the working tree as known crufts.  

Just FYI, if you want to clean them, there is already when_finished
in this piece (and others) so you could do

    -test_when_finished "rm -rf here && git worktree prune" &&
    -test_when_finished "rm -rf here out actual expect && git worktree prune" &&

When a test fails, when_finished is not run, so this will not
interfere with necessary debugging effort when/if somebody breaks
"git worktree" and this test starts failing.

