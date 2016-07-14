Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3F37C20196
	for <e@80x24.org>; Thu, 14 Jul 2016 16:18:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751733AbcGNQS0 (ORCPT <rfc822;e@80x24.org>);
	Thu, 14 Jul 2016 12:18:26 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51841 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751452AbcGNQSX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jul 2016 12:18:23 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 76BD72A3EC;
	Thu, 14 Jul 2016 12:18:21 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=i0/y1QChRV/3kh9GsFuk+MTVQAQ=; b=VomIf6
	dvGsxqjMtM4uqwQHul+XvnPaI7r1IbL/ams53IVK+SKEAujOqdEHNd6hcRCiDO8p
	Qa61OX10pzz5Jn6UxK0FOYvTDQeE6YSv3cVYHFGRHpRdgrrFfbBxMWXazr9JTAER
	+u8oVcF1uQRQqKlskHeFA1VTnKi8rA4oEnlyY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=dgTgFv6tlOzVqyQAR4srAsP8N9qBZ9op
	oQfWEdz9RwparO+gDa8maKEmNaBevi9Grp8SwDWr0qPRpEaN835XHmUiw1R+lTry
	3mNfPNlIvY9f/rc6loqKPv3QJdufiBQ1LGEsLsSzYjESDG7FQYfmj4+xvhHPp9us
	FBdYAXDfi4M=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 6E01B2A3EB;
	Thu, 14 Jul 2016 12:18:21 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E6D482A3EA;
	Thu, 14 Jul 2016 12:18:20 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:	git@vger.kernel.org,
	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	Johannes Sixt <j6t@kdbg.org>, Jeff King <peff@peff.net>
Subject: Re: [PATCH] mingw: fix regression in t1308-config-set
References: <6f439a56703ca6fb5c269c75904796ae67e96960.1468504461.git.johannes.schindelin@gmx.de>
Date:	Thu, 14 Jul 2016 09:18:18 -0700
In-Reply-To: <6f439a56703ca6fb5c269c75904796ae67e96960.1468504461.git.johannes.schindelin@gmx.de>
	(Johannes Schindelin's message of "Thu, 14 Jul 2016 15:58:59 +0200
	(CEST)")
Message-ID: <xmqqr3awry5x.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 94CFA9FA-49DE-11E6-9EE1-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> When we tried to fix in 58461bd (t1308: do not get fooled by symbolic
> links to the source tree, 2016-06-02) an obscure case where the user
> cd's into Git's source code via a symbolic link, a regression was
> introduced that affects all test runs on Windows.

Thanks for producing a fix quickly after the topic hit 'master'.

The original came from

  http://thread.gmane.org/gmane.comp.version-control.git/296021/focus=296199

which was merged at e5e5bb67 (Merge branch 'jk/upload-pack-hook'
into next, 2016-06-28) to 'next'.  

I see J6t raised C:/foo vs /c/foo issue in the thread later, but
unfortunately I didn't notice it.

I added a few missing Cc: and quoted the whole patch here to those
who were involved; I think this update is correct, but just trying
to make sure people know.

Not limited to this particular topic, there probably are some things
we can and should add to the procedure to prevent further episodes
like this, but I am not seeing anything immediately obvious offhand.
There already is a way to prominently mark a topic to be not-ready
with an outstanding issue called "What's cooking" report, but it is
maintained manually and it can be leaky without extra set of eyes
constantly monitoring.

> The original patch introducing the test case in question was careful to
> use `$(pwd)` instead of `$PWD`.
>
> This was done to account for the fact that Git's test suite uses shell
> scripting even on Windows, where the shell's Unix-y paths are
> incompatible with the main Git executable's idea of paths: it only
> accepts Windows paths.
>
> It is an awkward but necessary thing, then, to use `$(pwd)` (which gives
> us a Windows path) when interacting with the Git executable and `$PWD`
> (which gives the shell's idea of the current working directory in Unix-y
> form) for shell scripts, including the test suite itself.
>
> Obviously this broke the use case of the Git maintainer when changing
> the working directory into Git's source code directory via a symlink,
> i.e. when `$(pwd)` does not agree with `$PWD`.
>
> However, we must not fix that use case at the expense of regressing
> another use case.
>
> Let's special-case Windows here, even if it is ugly, for lack of a more
> elegant solution.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
> Published-As: https://github.com/dscho/git/releases/tag/t1308-on-windows-v1
>
> 	Side note: it was not at all clear to me how 58461bd fixed the
> 	problem by replacing $(pwd) with $HOME, given that HOME is set to
> 	$TRASH_DIRECTORY which is set to $TEST_OUTPUT_DIRECTORY/... after
> 	TEST_OUTPUT_DIRECTORY was set to TEST_DIRECTORY which in turn was
> 	set to $(pwd).
>
> 	I guess the reason is that -P in `cd -P "$TRASH DIRECTORY"`, but
> 	then I *really* do not understand how $(pwd) and $PWD could
> 	disagree.
> 	Oh well. I have to move on to the next fire.
>
>  t/t1308-config-set.sh | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/t/t1308-config-set.sh b/t/t1308-config-set.sh
> index a06e71c..7655c94 100755
> --- a/t/t1308-config-set.sh
> +++ b/t/t1308-config-set.sh
> @@ -233,11 +233,19 @@ cmdline_config="'foo.bar=from-cmdline'"
>  test_expect_success 'iteration shows correct origins' '
>  	echo "[foo]bar = from-repo" >.git/config &&
>  	echo "[foo]bar = from-home" >.gitconfig &&
> +	if test_have_prereq MINGW
> +	then
> +		# Use Windows path (i.e. *not* $HOME)
> +		HOME_GITCONFIG=$(pwd)/.gitconfig
> +	else
> +		# Do not get fooled by symbolic links, i.e. $HOME != $(pwd)
> +		HOME_GITCONFIG=$HOME/.gitconfig
> +	fi &&
>  	cat >expect <<-EOF &&
>  	key=foo.bar
>  	value=from-home
>  	origin=file
> -	name=$HOME/.gitconfig
> +	name=$HOME_GITCONFIG
>  	scope=global
>  
>  	key=foo.bar
