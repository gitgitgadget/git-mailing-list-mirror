Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E05FF203E2
	for <e@80x24.org>; Fri, 11 Nov 2016 20:48:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936629AbcKKUsg (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 Nov 2016 15:48:36 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64626 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S934727AbcKKUsg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Nov 2016 15:48:36 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8596A4D61C;
        Fri, 11 Nov 2016 15:48:29 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=FLJ9cRjeQhhr4vG2wQn//Dc3Y20=; b=pJaYBi
        BZME6MUaBdZt+ff3MxdrxSalquoknFlUljkajPnRAx3MSXGh0qtHSzNDSQrdvBzi
        eO288sogs9SOy/z4w+l2vghnBHBnczSWg9X2baKISk0hHdZ2bb2NXrFOPu7iieGK
        eock51DAnbihaP/12T2T9rJ/50tjBGlvtOZjw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=UfHRcnstBA/BJZ9k3VkvFjiZQWymygAX
        bh0H4bfiJ76AedfeLhxEIwQotxikext6jAFpaOHC+4grTA3UZCJ7US1FrMDLXL6k
        wZ+Yq14TWO4FNkfBfFoGGOXEV2Do8XtU1htWCNvPkMyLmUVSs4bRA3oJ9pAbq/4J
        kIocrV5bXmM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 785544D61B;
        Fri, 11 Nov 2016 15:48:29 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id DB0094D61A;
        Fri, 11 Nov 2016 15:48:28 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org, Andreas Schwab <schwab@suse.de>
Subject: Re: [PATCH v2] t6026: ensure that long-running script really is
References: <16dc9f159b214997f7501006a8d1d8be2ef858e8.1478699463.git.johannes.schindelin@gmx.de>
        <xmqqfumy51tk.fsf@gitster.mtv.corp.google.com>
        <fbf517ad-7341-eb6d-ab38-4fe91410e57c@kdbg.org>
        <20161111084148.tgtsijn74z2pdylq@sigill.intra.peff.net>
        <6a421222-a138-5647-4965-8ede24d904b2@kdbg.org>
Date:   Fri, 11 Nov 2016 12:48:27 -0800
In-Reply-To: <6a421222-a138-5647-4965-8ede24d904b2@kdbg.org> (Johannes Sixt's
        message of "Fri, 11 Nov 2016 21:24:44 +0100")
Message-ID: <xmqq60nt3fqc.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 331319A6-A850-11E6-98AB-987C12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Sixt <j6t@kdbg.org> writes:

> Good point. Here is an updated version.

Unfortunately, I already took the version before this one and
started my integration cycle today.  I'll wiggle this in; it
essentially is about adding a big comment to explain what is going
on and then moving the when-finished down below it, right?

Thanks.

> If the pid file is not created, the kill command receives no
> arguments. Here on Linux, it reports failure in this case.
> This is good. I could have said
>
>    test_when_finished "kill \"\$(cat sleep.pid)\""
>
> but that is a bit too much quoting for my taste when it is
> not strictly necessary.
>
>  t/t6026-merge-attr.sh | 18 +++++++++++++-----
>  1 file changed, 13 insertions(+), 5 deletions(-)
>
> diff --git a/t/t6026-merge-attr.sh b/t/t6026-merge-attr.sh
> index 7a6e33e673..8f9b48a493 100755
> --- a/t/t6026-merge-attr.sh
> +++ b/t/t6026-merge-attr.sh
> @@ -183,16 +183,24 @@ test_expect_success 'up-to-date merge without common ancestor' '
>  
>  test_expect_success 'custom merge does not lock index' '
>  	git reset --hard anchor &&
> -	write_script sleep-one-second.sh <<-\EOF &&
> -		sleep 1 &
> +	write_script sleep-an-hour.sh <<-\EOF &&
> +		sleep 3600 &
>  		echo $! >sleep.pid
>  	EOF
> -	test_when_finished "kill \$(cat sleep.pid)" &&
>  
>  	test_write_lines >.gitattributes \
> -		"* merge=ours" "text merge=sleep-one-second" &&
> +		"* merge=ours" "text merge=sleep-an-hour" &&
>  	test_config merge.ours.driver true &&
> -	test_config merge.sleep-one-second.driver ./sleep-one-second.sh &&
> +	test_config merge.sleep-an-hour.driver ./sleep-an-hour.sh &&
> +
> +	# We are testing that the custom merge driver does not block
> +	# index.lock on Windows due to an inherited file handle.
> +	# To ensure that the backgrounded process ran sufficiently
> +	# long (and has been started in the first place), we do not
> +	# ignore the result of the kill command.
> +	# By packaging the command in test_when_finished, we get both
> +	# the correctness check and the clean-up.
> +	test_when_finished "kill \$(cat sleep.pid)" &&
>  	git merge master
>  '
