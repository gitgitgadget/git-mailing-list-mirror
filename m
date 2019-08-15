Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9A90A1F45A
	for <e@80x24.org>; Thu, 15 Aug 2019 18:10:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731603AbfHOSKS (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Aug 2019 14:10:18 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62201 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729366AbfHOSKQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Aug 2019 14:10:16 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7A2B916DFD7;
        Thu, 15 Aug 2019 14:10:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=g0adfEyVSDHu2iVxS5XYhNDLY/A=; b=K0wroJ
        LXq7I7qakhU5I+WVpYmXnll0yZHjUjtHLQc0hZURisg4my2SunMtWnXcvcLltYyb
        NASDBBeB62io6V0TltnAkwA8XGJyrDQMRcNR/zVYfo/LYejlXFwW8Ha6cX/WON3b
        ONGRC/Y0IYaAwRxfwDss+4g1EmzswJCtOGERE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=JDrcbltLNUx3QpsADEOd8OpCB7cNHDKn
        gYPieTAjhoEo8RW2ynmJnnbRLIfI2HzTLCyoynDPKJA9L+Jn9Q7nD0pEQlZ48NHs
        RGgc1UNbae+nol/xkvQXl3ATjrv4DP+eH/K5Gvx+4o2mslYtsWmC2VZqvmzhn+FD
        KXaw3Sqvy+Q=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 71BA316DFD4;
        Thu, 15 Aug 2019 14:10:14 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D307916DFD3;
        Thu, 15 Aug 2019 14:10:13 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] bugreport: add tool to generate debugging info
References: <20190815023418.33407-1-emilyshaffer@google.com>
Date:   Thu, 15 Aug 2019 11:10:12 -0700
In-Reply-To: <20190815023418.33407-1-emilyshaffer@google.com> (Emily Shaffer's
        message of "Wed, 14 Aug 2019 19:34:18 -0700")
Message-ID: <xmqqzhka2tbv.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: ED92ADD6-BF87-11E9-8AE4-46F8B7964D18-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer <emilyshaffer@google.com> writes:

> diff --git a/Documentation/git-bugreport.txt b/Documentation/git-bugreport.txt
> new file mode 100644
> index 0000000000..c5f45bbee8
> --- /dev/null
> +++ b/Documentation/git-bugreport.txt
> @@ -0,0 +1,48 @@
> +git-bugreport(1)
> +================
> +
> +NAME
> +----
> +git-bugreport - Collect information for user to file a bug report
> +
> +SYNOPSIS
> +--------
> +[verse]
> +'git bugreport' [-o | --output <path>]
> +
> +DESCRIPTION
> +-----------
> +Captures information about the user's machine, Git client, and repository state,
> +as well as a form requesting information about the behavior the user observed,
> +into a single text file which the user can then share, for example to the Git
> +mailing list, in order to report an observed bug.
> +
> +The following information is requested from the user:
> +
> + - Reproduction steps
> + - Expected behavior
> + - Actual behavior

+ - How the above two are different

It is often helpful to have users explain how the expected and
actual are different in their own words.

> +NOTE
> +----
> +Bug reports can be sent to git@vger.kernel.org.

I am not sure if this belongs here.

> diff --git a/git-bugreport.sh b/git-bugreport.sh
> new file mode 100755
> index 0000000000..2200703a51
> --- /dev/null
> +++ b/git-bugreport.sh
> @@ -0,0 +1,86 @@
> +#!/bin/sh
> +
> +print_filenames_and_content() {
> +while read -r line; do
> +	echo "$line";
> +	echo "========";
> +	cat "$line";
> +	echo;
> +done
> +}

Style.

 - have SP on both sides of ()
 - one more HT indent for the function body
 - "do" on its own line
 - no unnecessary semicolons when LF would do

You probably are better off asking xargs to do this instead of
relying on "read -r".

	find ... | xargs -n 1 sh -c 'echo "$1" && cat "$1"' -

or something like that, perhaps.

> +
> +generate_report_text() {
> +
> +	# Generate a form for the user to fill out with their issue.
> +	gettextln "Thank you for filling out a Git bug report!"
> +	gettextln "Please answer the following questions to help us understand your issue."
> +	echo
> +	gettextln "What did you do before the bug happened? (Steps to reproduce your issue)"
> +	echo
> +	gettextln "What did you expect to happen? (Expected behavior)"
> +	echo
> +	gettextln "What happened instead? (Actual behavior)"
> +	echo
> +	gettextln "Anything else you want to add:"
> +	echo
> +	gettextln "Please review the rest of the bug report below."
> +	gettextln "You can delete any lines you don't wish to send."
> +	echo

Would we on the receiving end be able to tell these section headers
in translated to 47 different languages?  I am sure that i18n is
used here to encourage non-C-locale users to file bugs in their own
languages, but are we prepared to react to them?

> +	echo "[System Information]"
> +	git version --build-options
> +	uname -a
> +	curl-config --version
> +	ldd --version

"curl-config: command not found" may be clear enough, but would
there be a case where errors from two or more consecutive commands
in the above sequence would make the output confusing to the person
sitting on the receiving end?  Would it help, as a convention, to
always ahve "echo [what am I reporting]" before each of these
commands?

> +# Create bugreport file
> +BUGREPORT_FILE="$basedir/git-bugreport-$(whoami)-$(hostname)-$(date -Iminutes)"

How portable is -Iminutes?

> diff --git a/t/t0091-bugreport.sh b/t/t0091-bugreport.sh
> new file mode 100755
> index 0000000000..6eb2ee4f66
> --- /dev/null
> +++ b/t/t0091-bugreport.sh
> @@ -0,0 +1,41 @@
> +#!/bin/bash

Make sure /bin/sh suffices to run the test script.

> +test_description='git bugreport'
> +
> +. ./test-lib.sh
> +
> +# Headers "[System Info]" will be followed by a non-empty line if we put some
> +# information there; we can make sure all our headers were followed by some
> +# information to check if the command was successful.
> +HEADER_PATTERN="^\[.*\]$"
> +check_all_headers_populated() {
> +	while read -r line; do
> +		if [$(grep $HEADER_PATTERN $line)]; then

Documentation/CodingGuidelines

I am not sure if the traits this test script checks about the
contents of the output is all that interesting.  Whenever we add new
sections to the main command because we want other kinds of
information collected, we'd update this test script because
otherwise the test would fail, but would it result in quality
bugreport tool, or is it just additional busywork?

If we decide later that a header and its body needs to be separated
with a blank line for better readablity, the check done here would
also need to be updated, but again, that does not feel like anything
more than just busywork to me.

The tests for "-o" and unknown options do make sense, though.

Thanks.

> +# Headers "[System Info]" will be followed by a non-empty line if we put some
> +# information there; we can make sure all our headers were followed by some
> +# information to check if the command was successful.
> +HEADER_PATTERN="^\[.*\]$"
> +check_all_headers_populated() {
> +	while read -r line; do
> +		if [$(grep $HEADER_PATTERN $line)]; then
> +			read -r nextline
> +			if [-z $nextline]; then
> +				return 1;
> +			fi
> +		fi
> +	done
> +}
> +
> +test_expect_success 'creates a report with content in the right places' '
> +	git bugreport &&
> +	check_all_headers_populated <git-bugreport-* &&
> +	rm git-bugreport-*
> +'
> +
> +test_expect_success '--output puts the report in the provided dir' '
> +	mkdir foo/ &&
> +	git bugreport -o foo/ &&
> +	test -f foo/git-bugreport-* &&
> +	rm -fr foo/
> +'
> +
> +test_expect_success 'incorrect arguments abort with usage' '
> +	test_must_fail git bugreport --false 2>output &&
> +	grep usage output &&
> +	test ! -f git-bugreport-*
> +'
> +
> +test_done
