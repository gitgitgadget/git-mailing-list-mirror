Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E32D42047F
	for <e@80x24.org>; Mon, 25 Sep 2017 01:03:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932867AbdIYBDx (ORCPT <rfc822;e@80x24.org>);
        Sun, 24 Sep 2017 21:03:53 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58012 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753475AbdIYBDv (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Sep 2017 21:03:51 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D5BD09ACA3;
        Sun, 24 Sep 2017 21:03:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=c+7WFdGzSXv7obeEuV1v35sFFe4=; b=tk0Srp
        6MokNuQwjYvAwmRXvWwL9QU0gefs1ByGxQMRrx3wLcnWkGVR4aLgbdaFthFneadD
        Hr2K1su4AEsn3ccgPy0ajdy+TNDrat+a+IWEGtdoH9/MgtaNt23zDFtN8dOC9u9A
        7FAPfLasrLnYI8S4A4+IBhvpzvdBeR5zfd/Bg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=huul0HsIpfX/t86TUx1h0Zuxhth6HlY+
        N7LsnyB6JtV9DickrhKYQ4udpfX3bL7xwFu2LEEzSL2oElKDoFOLPC7LDknJ+iin
        0GmQOaQPJ/BkHHx4xi3EPJvpRr8kWhVuKl82bw3co+vWJjf46ZuQBMxpTNAPNFRm
        ULyjQ0Sw3ns=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C26A89ACA2;
        Sun, 24 Sep 2017 21:03:51 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 14CF49ACA1;
        Sun, 24 Sep 2017 21:03:51 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Manav Rathi <mnvrth@gmail.com>
Cc:     git@vger.kernel.org, pclouds@gmail.com
Subject: Re: [PATCH] docs: improve discoverability of exclude pathspec
References: <CAEuZsW8vR0LesL=+ZoiFa=BBwhhm=KON+U3H2H9sNdTT+jgBkQ@mail.gmail.com>
Date:   Mon, 25 Sep 2017 10:03:49 +0900
In-Reply-To: <CAEuZsW8vR0LesL=+ZoiFa=BBwhhm=KON+U3H2H9sNdTT+jgBkQ@mail.gmail.com>
        (Manav Rathi's message of "Sun, 24 Sep 2017 21:47:16 +0530")
Message-ID: <xmqq1smvh9my.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 64C21556-A18D-11E7-B8B1-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Manav Rathi <mnvrth@gmail.com> writes:

> The ability to exclude paths in pathspecs is not mentioned in the man
> pages of git grep and other commands where it might be useful.

My reading stutters around "exclude paths in pathspecs" in the
above.  Perhaps "exclude paths with a negative pathspec" instead?

> diff --git a/Documentation/git-add.txt b/Documentation/git-add.txt
> index f4169fb..6f76f39 100644
> --- a/Documentation/git-add.txt
> +++ b/Documentation/git-add.txt
> @@ -50,17 +50,22 @@ commit.
>  OPTIONS
>  -------
>  <pathspec>...::
> - Files to add content from.  Fileglobs (e.g. `*.c`) can
> - be given to add all matching files.  Also a
> - leading directory name (e.g. `dir` to add `dir/file1`
> - and `dir/file2`) can be given to update the index to
> - match the current state of the directory as a whole (e.g.
> - specifying `dir` will record not just a file `dir/file1`
> - modified in the working tree, a file `dir/file2` added to
> - the working tree, but also a file `dir/file3` removed from
> - the working tree.  Note that older versions of Git used
> - to ignore removed files; use `--no-all` option if you want
> - to add modified or new files but ignore removed ones.
> + Files to add content from.
> ++
> +File globs (e.g. `*.c`) can be given to add all matching files.  A
> +leading directory name (e.g. `dir` to add `dir/file1` and `dir/file2`)
> +can be given to update the index to match the current state of the
> +directory as a whole.
> ++
> +Note that specifying `dir` will record not just a file `dir/file1`
> +modified in the working tree, a file `dir/file2` added to the working
> +tree, but also a file `dir/file3` removed from the working tree.
> +Older versions of Git used to ignore removed files; use the `--no-all`
> +option if you want to add new and modified files but ignore removed
> +ones.
> ++
> +For more details about the <pathspec> syntax, see the 'pathspec' entry
> +in linkgit:gitglossary[7].

This does a lot more than what the log message claims to do, unlike
the changes to other documentation pages.  Splitting the existing
paragraph in "git add" into multiple pagagraphs and changing a few
words here and there wasn't part of the bargain.

It would be easier to judge the merit of the patch if you split it
into two steps, if you want all the changes in it.  One would do
only what the log message claimed it did, i.e. "refer to glossary,
give an example where appropriate and add test".  That part I think
everybody can agree that it is a good change.  The change to the
introduction part I am not so sure about.

> -test_expect_success 'exclude only no longer errors out' '
> +test_expect_success 'exclude only pathspec uses default implicit pathspec' '

This is a very good change.

Back when the test was written, it was fresh in collective memory
that giving only negative pathspec elements without any positive
pathspec element resulted in an error, and that the behaviour was
updated so that it would not error out (and it was obvious that
implicit positive pattern to be used was to match all), but when
reading this with fresh eyes, "no longer errors out" is much much
less important than "start from include all and then subtract paths
that match".

>   git log --oneline --format=%s -- . ":(exclude)sub" >expect &&
>   git log --oneline --format=%s -- ":(exclude)sub" >actual &&
>   test_cmp expect actual
> @@ -183,4 +183,15 @@ EOF
>   test_cmp expect actual
>  '
>
> +test_expect_success 'multiple exclusions' '
> + git ls-files -- :^*/file2 :^sub2 >actual &&

Please quote these patterns inside "pair of dqs".

> + cat <<EOF >expect &&
> +file
> +sub/file
> +sub/sub/file
> +sub/sub/sub/file
> +EOF

By using <<-\EOF, you can indent (with tab) the contents of the here
document, like so:

	cat >expect <<-EOF &&
	file
	...
        EOF

By the way, please check your e-mail settings.  Your MUA seems to
have lost all tabs, and this patch does not apply.

Thanks.

> + test_cmp expect actual
> +'
> +
>  test_done
