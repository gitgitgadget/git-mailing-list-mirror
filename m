Return-Path: <SRS0=prLJ=4M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10841C38BE0
	for <git@archiver.kernel.org>; Mon, 24 Feb 2020 19:33:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8B9320CC7
	for <git@archiver.kernel.org>; Mon, 24 Feb 2020 19:33:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="agSi0pk2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727202AbgBXTdE (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Feb 2020 14:33:04 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:60757 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725860AbgBXTdE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Feb 2020 14:33:04 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A9672C9819;
        Mon, 24 Feb 2020 14:33:02 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=kJ89ZJz9PrX1
        1oZqGi7E+O17194=; b=agSi0pk2D8O47oisBETh5EBxMTba+ISq0PKH54eeK0O9
        5Dj2Xjd25Wa82IRwmqNMlz1i4jXp+U3eIwx3I0oy4bGX60HXbt+QwEEK3vUfGL/P
        GWwuJuXgX1Q1xOCEVCYavor+qIQfokBaPdUOPQ3alJppmT2VzKxAjEJ+iZCT4Gw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=sT82E8
        xtjs8qJ4kc+F3WxHhvEDKcZrTzINUuEkGhP5w4CzWZ6IIXGCNgS6FUdkCzlshZbc
        3asJjGmB7VT+K0HJAO+K+9MJDrhAzrjNk5s0M4VK7fvX5nZ3UoETdAQCtunqYtGT
        yuQotcbLLz6E+t/E+mexYABhAGlJCH612qtuI=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A1065C9818;
        Mon, 24 Feb 2020 14:33:02 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id BE5C0C9815;
        Mon, 24 Feb 2020 14:32:59 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 3/3] t: drop debug `cat` calls
References: <dde0f85e5e3dd99a61b83df1b6eb572be8a3ff51.1582447606.git.martin.agren@gmail.com>
        <179c67caec0f8123d09455cb78532419166e1b9e.1582447606.git.martin.agren@gmail.com>
Date:   Mon, 24 Feb 2020 11:32:57 -0800
In-Reply-To: <179c67caec0f8123d09455cb78532419166e1b9e.1582447606.git.martin.agren@gmail.com>
        ("Martin =?utf-8?Q?=C3=85gren=22's?= message of "Sun, 23 Feb 2020 09:48:36
 +0100")
Message-ID: <xmqqlforpyqe.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 7736F078-573C-11EA-902B-B0405B776F7B-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Martin =C3=85gren <martin.agren@gmail.com> writes:

> We `cat` files, but don't inspect or grab the contents in any way.
> Unlike in an earlier commit, there is no reason to suspect that these
> files could be missing, so `cat`-ing them is just wasted effort.
> ...
>  	rm -rf repo-cloned &&
>  	test_must_fail git clone repo repo-cloned 2>git-stderr.log &&
> -	cat git-stderr.log &&
>  	grep "error: .missing-delay\.a. was not filtered properly" git-stderr=
.log

Loss of cat does not change if git-stderr.log file went missing for
whatever reason (e.g. typo while updating the test), just like 2/3,
so the debugging cruft can safely be removed.

> -	$RUN for-each-reflog-ent HEAD >actual && cat actual &&
> +	$RUN for-each-reflog-ent HEAD >actual &&
>  	head -n1 actual | grep first &&

Very similar, as lack of 'actual' for whatever reason will manifest
in a failure for "grep" from finding 'first' anyway.

I sort of sympathetic to your desire to have two classes and
separate/distribute them into 2/3 and 3/3, but to me the line
between two classes looks like it was drawn along a wrong axis.

The proposed log message for this step hints that the criteria for
tests to be thrown into this category is that the output of 'cat' is
not used in any useful way, and the input of 'cat' is known to exist
(i.e. so "cat fails if the file is missing" is not part of the test),
but that applies to the one instance singled out in 2/3 (i.e. the
file in question, kwdelfile.c, is created with shell redirection,
just like "actual" file above is).

> diff --git a/t/t1450-fsck.sh b/t/t1450-fsck.sh
> index 02478bc4ec..d09eff503c 100755
> --- a/t/t1450-fsck.sh
> +++ b/t/t1450-fsck.sh
> @@ -141,7 +141,6 @@ test_expect_success 'email without @ is okay' '
>  	git update-ref refs/heads/bogus "$new" &&
>  	test_when_finished "git update-ref -d refs/heads/bogus" &&
>  	git fsck 2>out &&
> -	cat out &&
>  	! grep "commit $new" out
>  '

This one on the other hand *DOES* rely on 'out' being created; we do
not want to take the failing 'grep' as a sign of success if it is
because 'out' is missing.

> diff --git a/t/t2107-update-index-basic.sh b/t/t2107-update-index-basic=
.sh
> index 2242cd098e..a30b7ca6bc 100755
> --- a/t/t2107-update-index-basic.sh
> +++ b/t/t2107-update-index-basic.sh
> @@ -9,7 +9,6 @@ Tests for command-line parsing and basic operation.
> =20
>  test_expect_success 'update-index --nonsense fails' '
>  	test_must_fail git update-index --nonsense 2>msg &&
> -	cat msg &&
>  	test -s msg
>  '

This one does not.  "test -s msg" on non-existent msg will fail, so
this is closer to category 2/3.

So, I am OK to have two patches that catch two classes, but the
division between 2/3 and 3/3 in this series does not look the right
one.

I am also OK to have a single patch with updated log message, saying
"removal of 'cat <file>' may miss a failure mode that <file> did not
get created, which would have been caught as a test failure in the
original, but the <file>s used by cats removed in this patch are
either impossible to be missing (because a preceding step in the
test created it, or the &&-cascade would have failed if it failed to
create the file), or followed by another step in the test that would
fail if the file is missing (e.g. running grep on the file), so it is
safe to drop these cats", or something like that.



