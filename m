Return-Path: <SRS0=FHek=5A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 321C9C10DCE
	for <git@archiver.kernel.org>; Sun, 15 Mar 2020 16:37:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C507C205ED
	for <git@archiver.kernel.org>; Sun, 15 Mar 2020 16:37:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="SjFVwLBH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728935AbgCOQf3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 15 Mar 2020 12:35:29 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64655 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728692AbgCOQf3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 15 Mar 2020 12:35:29 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5D68F40E49;
        Sun, 15 Mar 2020 12:35:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=vvB39hkM5V0S
        XNONzjJzuIJWe/k=; b=SjFVwLBHzwUhVm0zkdy04h69nB99Nw+boRMFUGfYKJmP
        xcZ2KdOhkZm5Bjbo1EEaN5S3Qj6WOT4gCOis6DvwiiTrqsMb4M+g7VJ6B0x0/tdF
        hkG3PaISoKO4khQHRdAuF+Xj0DqloDqxCS6ScLOakm9L+2XORXY1BcNnQ4esJ2s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=oxpcY5
        RF43ifNZZmRJSYCQ2kR8zGODgJbmqiyHeHaKM9NL09BzHLlEqjSO4qTa9zE8ncDv
        6rw3i9//0M8wEX8347TPv6qbzCiNchJqedjM/8a/BD9+8K77OSINr0L4kywr1cKN
        t6wh8LKoDnE/U1/rRqiKvqwOYcgJxA161PiQI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 515D340E48;
        Sun, 15 Mar 2020 12:35:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id CE1B940E46;
        Sun, 15 Mar 2020 12:35:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        =?utf-8?Q?Jean-No=C3=ABl?= AVILA <jn.avila@free.fr>,
        git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>
Subject: Re: Regression in v2.26.0-rc0 and Magit
References: <3091652.KAqcNXvZJ4@cayenne> <20200312233504.GH120942@google.com>
        <xmqqk13pdsw1.fsf@gitster.c.googlers.com>
        <xmqq36accdpt.fsf@gitster.c.googlers.com>
        <20200315105803.GJ3122@szeder.dev>
Date:   Sun, 15 Mar 2020 09:35:23 -0700
In-Reply-To: <20200315105803.GJ3122@szeder.dev> ("SZEDER =?utf-8?Q?G=C3=A1?=
 =?utf-8?Q?bor=22's?= message of
        "Sun, 15 Mar 2020 11:58:03 +0100")
Message-ID: <xmqq4kupbmpg.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: F80B2C2A-66DA-11EA-B92E-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER G=C3=A1bor <szeder.dev@gmail.com> writes:

>> +test_expect_success 'log and ls-files in a bare repository' '
>> +	(
>> +		cd bare &&
>> +		test_must_fail git log -- .. &&
>> +		test_must_fail git ls-files -- ..
>> +	) >out 2>err &&
>> +	test_i18ngrep "outside repository" err
>
> I think it would be better to write this test as:
>
>   (
>         cd bare &&
>         test_must_fail git log -- .. 2>err &&
> 	test_i18ngrep "outside repository" err &&
>         test_must_fail git ls-files -- .. 2>err &&
> 	test_i18ngrep "outside repository" err
>   )
>
> because this way we make sure that both commands fail with the error
> we expect.

True.  Otherwise one may fail expectedly, and the other one may fail
in an unexpected but still clean way.  Thanks for carefully reading.

We could also split it into two separate tests, but I think it would
be an overkill.  The primary point of using must-fail is to ensure
that the command does not segfault, so in a sense, checking what is
in err is somewhat, but not completely, a redundant thing to do.

About checking redundantly, as we grab the standard output, we can
also make sure that it contains nothing, because we expect that the
failure happens way before the command is set up to compute what
they are asked to produce.

Below, I follow your suggestion to keep the log/ls-files pair in a
single test, as I think splitting it into two is an overkill, but I
kept the "truly bare repository" case and the "non-bare repository,
but we stepped into $GIT_DIR ourselves" case separate, and that is
deliberate.  We might want to rethink the behaviour in the latter
case.

diff --git a/t/t6136-pathspec-in-bare.sh b/t/t6136-pathspec-in-bare.sh
new file mode 100755
index 0000000000..b117251366
--- /dev/null
+++ b/t/t6136-pathspec-in-bare.sh
@@ -0,0 +1,38 @@
+#!/bin/sh
+
+test_description=3D'diagnosing out-of-scope pathspec'
+
+. ./test-lib.sh
+
+test_expect_success 'setup a bare and non-bare repository' '
+	test_commit file1 &&
+	git clone --bare . bare
+'
+
+test_expect_success 'log and ls-files in a bare repository' '
+	(
+		cd bare &&
+		test_must_fail git log -- .. >out 2>err &&
+		test_must_be_empty out &&
+		test_i18ngrep "outside repository" err &&
+
+		test_must_fail git ls-files -- .. >out 2>err &&
+		test_must_be_empty out &&
+		test_i18ngrep "outside repository" err
+	)
+'
+
+test_expect_success 'log and ls-files in .git directory' '
+	(
+		cd .git &&
+		test_must_fail git log -- .. >out 2>err &&
+		test_must_be_empty out &&
+		test_i18ngrep "outside repository" err &&
+
+		test_must_fail git ls-files -- .. >out 2>err &&
+		test_must_be_empty out &&
+		test_i18ngrep "outside repository" err
+	)
+'
+
+test_done
