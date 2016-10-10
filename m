Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 02BD820989
	for <e@80x24.org>; Mon, 10 Oct 2016 16:43:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753259AbcJJQm4 (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Oct 2016 12:42:56 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58543 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752963AbcJJQmy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Oct 2016 12:42:54 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7C9C142C48;
        Mon, 10 Oct 2016 12:42:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Hh1XpXvogND6RI9WsjFVx5EBM8o=; b=Itf8U8
        tzkBEtiSTxr9b3JpBnq0uDzk2c9aGyHapIacmQgNMBfJRJ/DXCRtG/Bqs083zmo4
        UWgDeT7eak+CTIJkzhqKuaFCiy1VHeiNIAmNtJFIAqpW3Zztt0xgm5DnZPoFSdU8
        plEqnJm111W6dra/HN07w5CNzqMsdDERZPVqo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=NsvVaew22zyvPIbUU+fl6qjf1zB16Sec
        7m6FZvxp74nuJyoUYmYkGrJIwDXodLoEPGF7vf8NUsViuCuEiqcrJjjJIWvp1lTM
        8HTC0S8Z/wjhTKYbD9tTLkWM9J9TeaOWKGZ8mizKapC6m0RClgBHBbRw/6aKXIwu
        3iswiEQGz1E=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 75B9342C47;
        Mon, 10 Oct 2016 12:42:51 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id EA16842C46;
        Mon, 10 Oct 2016 12:42:50 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeremy Huddleston Sequoia <jeremyhu@apple.com>
Cc:     git@vger.kernel.org, Josh Triplett <josh@joshtriplett.org>
Subject: Re: [PATCH] t4014-format-patch: Adjust git_version regex to better handle distro changes to DEF_VER
References: <20161010025323.9415-1-jeremyhu@apple.com>
Date:   Mon, 10 Oct 2016 09:42:48 -0700
In-Reply-To: <20161010025323.9415-1-jeremyhu@apple.com> (Jeremy Huddleston
        Sequoia's message of "Sun, 9 Oct 2016 19:53:23 -0700")
Message-ID: <xmqqpon8gnp3.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 955C4468-8F08-11E6-8DBB-5F377B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeremy Huddleston Sequoia <jeremyhu@apple.com> writes:

> Regressed-in: 480871e09ed2e5275b4ba16b278681e5a8c122ae

Please be considerate to future readers of "git log" to help them
avoid mistakes earlier commits made that caused you troubles.

This line by itself without any explanation of what was broken is
quite useless as a commit message.  What can the readers do?  They'd
go back and say "git show 480871e09" and then what?  The test added
or modified by the commit has been working quite well for others
since it was made, so it is very likely the reader wouldn't be able
to tell if anything is wrong in it.

You would help if you said what is different in _your_ environment
from others who have happily been running and passing this test for
others to understand and learn from your fix.  What is it?

The "Adjust ... distro changes" in the title offers some hint but it
could be more explicit.  Please write something along this line
instead.

    Subject: t4014: git --version can have SP in it

    480871e09e ("format-patch: show base info before email
    signature", 2016-09-07) added a helper function to recreate the
    signature at the end of the e-mail, i.e. "-- " line followed by
    the version string of Git, using output from "git --version" and
    stripping everything before the last SP.

    Because the default Git version string looks like "git version
    2.10.0-1-g480871e09e", this was mostly OK, but people can change
    this version string to arbitrary thing while compiling, which
    can break the assumption if they had SP in it.  Notably, Apple
    ships modified Git with " (Apple Git-xx)" appended to its
    version number.

    Instead, come up with the version string by stripping the "git
    version " from the beginning.

> Signed-off-by: Jeremy Huddleston Sequoia <jeremyhu@apple.com>

Good.

> CC: Josh Triplett <josh@joshtriplett.org>
> CC: Junio C Hamano <gitster@pobox.com>

Please don't do this in your log message.  These belong to your
e-mail headers, not here.

> ---
>  t/t4014-format-patch.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
> index 8d90a6e..33f6940 100755
> --- a/t/t4014-format-patch.sh
> +++ b/t/t4014-format-patch.sh
> @@ -754,7 +754,7 @@ test_expect_success 'format-patch --ignore-if-in-upstream HEAD' '
>  	git format-patch --ignore-if-in-upstream HEAD
>  '
>  
> -git_version="$(git --version | sed "s/.* //")"
> +git_version="$(git --version | sed "s/git version //")"

Anchor the fixed prefix to the beginning, so that we can protect
ourselves from another distro that would add "git version" in the
middle of their arbitrary versioning scheme ;-).  I.e.

    sed "s/^git version //"

>  
>  signature() {
>  	printf "%s\n%s\n\n" "-- " "${1:-$git_version}"
