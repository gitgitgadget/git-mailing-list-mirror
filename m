Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 24A501FF32
	for <e@80x24.org>; Thu, 12 Oct 2017 01:17:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752622AbdJLBRy (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Oct 2017 21:17:54 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56278 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751782AbdJLBRx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Oct 2017 21:17:53 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E98B497ECE;
        Wed, 11 Oct 2017 21:17:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=a256SpS1xn8aP+PrgcIm4tyRwzU=; b=TRT/qs
        Lz+s/1JyfwDEYcktyMas7YW+gwJYSqWkzoUBnRaTOgXWvNbhMZ1iWurfr85OlMoM
        dKwglCOBJFD0DXo2HvS9i+KSLbc+/6fVupLiZlBGH7W0uR3mi63Cv8CEx+9ogJmT
        1Z7ckTD0bpfDvBcR7YPNCal6VkmDnrLHJxL4g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=lF82NZq4kb49nyAsab6Nn3uOFgN1FeK4
        UNC/5r/S+vN299a2ooj0mEbb6YqlNwhyf668GxV4bQSCW602XlAb3nCcT9KjGq2Q
        3jQL6cYeOD/9aVlS84P4Wzfaai9RGoPxTPEr6mfhOu3fW1QHdCLDdn/o2E1S680f
        BiOgaVG9t+Q=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E09AB97ECD;
        Wed, 11 Oct 2017 21:17:52 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 5A64997ECC;
        Wed, 11 Oct 2017 21:17:52 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "W. Trevor King" <wking@tremily.us>
Cc:     Git <git@vger.kernel.org>,
        =?utf-8?Q?=C5=81ukasz?= Gryglicki <lukaszgryglicki@o2.pl>
Subject: Re: [PATCH] pull: pass --signoff/--no-signoff to "git merge"
References: <18953f46ffb5e3dbc4da8fbda7fe3ab4298d7cbd.1507752482.git.wking@tremily.us>
Date:   Thu, 12 Oct 2017 10:17:51 +0900
In-Reply-To: <18953f46ffb5e3dbc4da8fbda7fe3ab4298d7cbd.1507752482.git.wking@tremily.us>
        (W. Trevor King's message of "Wed, 11 Oct 2017 13:10:47 -0700")
Message-ID: <xmqqefq92mgw.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2B39CB1A-AEEB-11E7-A596-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"W. Trevor King" <wking@tremily.us> writes:

> Following 09c2cb87 (pull: pass --allow-unrelated-histories to "git
> merge", 2016-03-18) with the tests also drawing on 14d01b4f (merge:
> add a --signoff flag, 2017-07-04).

I cannot find a verb in the above.

> The order of options in merge-options.txt isn't clear to me, but I've
> put --signoff between --log and --stat as somewhat alphabetized and
> having an "add to the commit message" function like --log.
>
> The tests aren't as extensive as t7614-merge-signoff.sh, but they
> exercises both the --signoff and --no-signoff options.  There may be a
> more efficient way to set them up (like t7614-merge-signoff.sh's
> test_setup), but with all the pull options packed into a single test
> script it seemed easiest to just copy/paste the duplicate setup code.

The above two paragraphs read more like "requesting help for hints
to improve this patch" than commit log message.  Perhaps move them
below the three-dash line and instead describe what you actually did
here (if they were worth explaining, that is)?

> 09c2cb87 didn't motivate the addition of --allow-unrelated-histories
> to pull; only citing the reason from e379fdf3 (merge: refuse to create
> too cool a merge by default, 2016-03-18) gave for *not* including it.
> I like having both exposed in pull because while the fetch-and-merge
> approach might be a more popular way to judge "how well they fit
> together", you can also do that after an optimistic pull.  And in
> cases where an optimistic pull is likely to succeed, suggesting it is
> easier to explain to Git newbies than a FETCH_HEAD merge.

I find this paragraph totally unrelated to what the patch does.
Save it for the patch you add to pass --allow-unrelated-histories
given to pull down to underlying merge, perhaps?

>
> Signed-off-by: W. Trevor King <wking@tremily.us>
> ---
>  Documentation/git-merge.txt     |  8 --------
>  Documentation/merge-options.txt | 10 ++++++++++
>  builtin/pull.c                  |  8 ++++++++
>  t/t5521-pull-options.sh         | 43 +++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 61 insertions(+), 8 deletions(-)
> ...
> diff --git a/t/t5521-pull-options.sh b/t/t5521-pull-options.sh
> index ded8f98dbe..d95789ab8c 100755
> --- a/t/t5521-pull-options.sh
> +++ b/t/t5521-pull-options.sh
> @@ -165,4 +165,47 @@ test_expect_success 'git pull --allow-unrelated-histories' '
>  	)
>  '
>  
> +test_expect_success 'git pull --signoff add a sign-off line' '
> +	test_when_finished "rm -fr src dst actual expected" &&
> +	cat >expected <<-EOF &&
> +		Signed-off-by: $(git var GIT_COMMITTER_IDENT | sed -e "s/>.*/>/")
> +	EOF

	echo "Signed-off-by: $GIT_COMMITER_NAME <$GIT_COMMITTER_EMAIL>" >expect

or

	git var GIT_COMMITTER_IDENT |
	sed -e 's/^\([^>]*>\).*/Signed-off-by: \1/' >expect

> +	git init src &&
> +	(
> +		cd src &&
> +		test_commit one
> +	) &&

I suspect somebody will suggest "test_commit -C" ;-)

> +	git clone src dst &&
> +	(
> +		cd src &&
> +		test_commit two
> +	) &&
> +	(
> +		cd dst &&
> +		git pull --signoff --no-ff &&
> +		git cat-file commit HEAD | tail -n1 >../actual

I think it makes it more robust to replace "tail" with "collect all
the signed-off-by lines" like the other test (below) does.  Perhaps
have a helper function and use it in both?

	get_signoff () {
		git cat-file commit "$1" | sed -n -e '/^Signed-off-by: /p'
	}

Some may say "cat-file can fail, and having it on the LHS of a pipe
hides its failure", advocating for something like:

	get_signoff () {
		git cat-file commit "$1" >sign-off-temp &&
		sed -n -e '/^Signed-off-by: /p' sign-off-temp
	}

> +	) &&
> +	test_cmp expected actual
> +'

> +test_expect_success 'git pull --no-signoff flag cancels --signoff flag' '
> +	test_when_finished "rm -fr src dst actual" &&
> +	git init src &&
> +	(
> +		cd src &&
> +		test_commit one
> +	) &&
> +	git clone src dst &&
> +	(
> +		cd src &&
> +		test_commit two
> +	) &&
> +	(
> +		cd dst &&
> +		git pull --signoff --no-signoff --no-ff &&
> +		git cat-file commit HEAD | sed -n /Signed-off-by/p >../actual
> +	) &&
> +	test_must_be_empty actual
> +'
> +
>  test_done

I think "--signoff" and "--signoff --no-signoff" are reasonable
minimum things to test.  Two more cases, i.e. running it without
either and with "--no-signoff" alone, to ensure that the sign-off
mechanism does not kick in would make it even better.

Thanks.

