Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8D58B1F461
	for <e@80x24.org>; Thu, 22 Aug 2019 16:16:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733304AbfHVQQD (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Aug 2019 12:16:03 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:53206 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729455AbfHVQQC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Aug 2019 12:16:02 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A321F6E868;
        Thu, 22 Aug 2019 12:16:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=outS8/je/GvzAua5GBjErsGoFE4=; b=TNkKtA
        yDrAZ4TbhDwtVOT56HrFJwFNtnnkfGRciDMcxh2m3n0+LQfu1BOJM4fh5M9J5Jc+
        1ZDJ/m8xN5BH68C3vUtCz2W2nQYOunzAuXZ7V0T8ok0gH8RutvHAqfaovoQSDGrz
        JYHM5s58E1F+1+2XVLInQd1hFBNtSOfoVe9VM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=seLp5dOQYtFpQm3/ty2reao347oh5K9X
        pVWm6EDl5Hfcybqx465rMap+CrJiupEc9k9Xygf6mTDnSU7+w+iTl63Y65JOHazA
        qBXlHbE/W5Ok0xjYj+PmPTinnjqkIMTQCnH7ASss4ScMQdaoOkUv5NR0qSwXSRqS
        2Tumo2BWBYA=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 9B16E6E865;
        Thu, 22 Aug 2019 12:16:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id C3E5B6E864;
        Thu, 22 Aug 2019 12:15:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Mischa POSLAWSKY <git@shiar.nl>
Cc:     git@vger.kernel.org,
        =?utf-8?B?0J7Qu9GPINCi0LXQu9C10LbQvdCw0Y8=?= 
        <olyatelezhnaya@gmail.com>
Subject: Re: [PATCH 2/1] t6300: format missing tagger
References: <20190817215107.13733-1-git@shiar.nl>
        <xmqqimqtxcou.fsf@gitster-ct.c.googlers.com>
        <xmqq1rxerxkk.fsf@gitster-ct.c.googlers.com>
        <20190822135528.GB28725@shiar.net>
Date:   Thu, 22 Aug 2019 09:15:55 -0700
In-Reply-To: <20190822135528.GB28725@shiar.net> (Mischa POSLAWSKY's message of
        "Thu, 22 Aug 2019 15:55:28 +0200")
Message-ID: <xmqq36htqipw.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1FEECF74-C4F8-11E9-90C7-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Mischa POSLAWSKY <git@shiar.nl> writes:

> Alright, thanks for the pointer.
> Here's a batch of tests on all pertaining atoms.

Good to see that you made it much more thorough than my q-n-d
illustration patch ;-)

> -- >8 --
>
> Strip an annotated tag of its tagger header and verify it's ignored
> correctly in all cases, as fixed in commit e2a81276e8 (ref-filter:
> initialize empty name or email fields, 2019-08-19).

I am inclined to squash this test part of the update into the said
commit; you'd lose one commit count, but hopefully you do not mind?

My motivation for doing so is that it would allow us to lose the "as
fixed in commit X" comment in a log message, which in turn would
mean that the code-fix patch can later be rebased safely without
having to remember that this one needs to be adjusted ("git rebase"
does not do such a rewrite for us, and I personally do not think
"git rebase" should do such a rewrite silently, as I cannot quantify
the risk of false positives).

>
> Signed-off-by: Mischa POSLAWSKY <git@shiar.nl>
> ---
>  t/t6300-for-each-ref.sh | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>
> diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
> index ab69aa176d..9c910ce746 100755
> --- a/t/t6300-for-each-ref.sh
> +++ b/t/t6300-for-each-ref.sh
> @@ -526,6 +526,25 @@ test_expect_success 'Check ambiguous head and tag refs II (loose)' '
>  	test_cmp expected actual
>  '
>  
> +test_expect_success 'create tag without tagger' '
> +	git tag -a -m "Broken tag" taggerless &&
> +	git tag -f taggerless $(git cat-file tag taggerless |
> +		sed -e "/^tagger /d" |
> +		git hash-object --stdin -w -t tag)
> +'
> +
> +test_atom refs/tags/taggerless type 'commit'
> +test_atom refs/tags/taggerless tag 'taggerless'
> +test_atom refs/tags/taggerless tagger ''
> +test_atom refs/tags/taggerless taggername ''
> +test_atom refs/tags/taggerless taggeremail ''
> +test_atom refs/tags/taggerless taggerdate ''
> +test_atom refs/tags/taggerless committer ''
> +test_atom refs/tags/taggerless committername ''
> +test_atom refs/tags/taggerless committeremail ''
> +test_atom refs/tags/taggerless committerdate ''
> +test_atom refs/tags/taggerless subject 'Broken tag'
> +
>  test_expect_success 'an unusual tag with an incomplete line' '
>  
>  	git tag -m "bogo" bogo &&
