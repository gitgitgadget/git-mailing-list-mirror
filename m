Return-Path: <SRS0=XbPV=A4=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BD3FC433E6
	for <git@archiver.kernel.org>; Fri, 17 Jul 2020 19:17:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D44622070E
	for <git@archiver.kernel.org>; Fri, 17 Jul 2020 19:17:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="IItqB+Sq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728381AbgGQTRd (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Jul 2020 15:17:33 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:57886 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728188AbgGQTRc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Jul 2020 15:17:32 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B7BC7EFF0B;
        Fri, 17 Jul 2020 15:17:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=6djt+O6OqIqA
        +2r5MmGkp1lcZF0=; b=IItqB+SqMumdyCM8TjOJqiv14YLzapV8jmryEmOjryZe
        1H/YIDNqy7LqBTgtJDbdns7eYWx3jBGTSGmlxyMJJzN4HWmdNxv3kKZdXuPbur33
        6K9fTyx/YdeETOctkw3PIpvJFuzQ8t5/SFOB6sElpbnxjR0XYmZfjgn2o7p2gzQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=tUkjb9
        w9P5K0kIB0UXwhajjUrwScf1G29zFEQwm9GNVKz3USmO0646Gn8oBtIl3Jl39LZf
        IPpooukTO4cT0AdcNsRsbddk3chMne4/G/19EiJYCHDP9Vh8jhGEENReoOUVrwJs
        gBWBqKadbojxdFI1D3cIhttJ+Mhi4sO4m/8rw=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B0E0EEFF09;
        Fri, 17 Jul 2020 15:17:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 01CEBEFF06;
        Fri, 17 Jul 2020 15:17:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jean Abou Samra <jean@abou-samra.fr>
Cc:     git@vger.kernel.org
Subject: Re: Git bisect run should check for the existence of the script
References: <9cea8076-be96-19c5-c368-288193daedd8@abou-samra.fr>
        <xmqq1rlclte2.fsf@gitster.c.googlers.com>
        <8c683b56-d17a-78ce-67bb-477e5b307df9@abou-samra.fr>
Date:   Fri, 17 Jul 2020 12:17:25 -0700
In-Reply-To: <8c683b56-d17a-78ce-67bb-477e5b307df9@abou-samra.fr> (Jean Abou
        Samra's message of "Fri, 17 Jul 2020 17:09:12 +0200")
Message-ID: <xmqqeepadk8q.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 2751ABE2-C862-11EA-BABB-843F439F7C89-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jean Abou Samra <jean@abou-samra.fr> writes:

> Le 15/07/2020 =C3=A0 16:55, Junio C Hamano a =C3=A9crit=C2=A0:
>> Jean Abou Samra <jean@abou-samra.fr> writes:
>>
>>> $ git bisect run ./non-existent.sh
>>> running ./non-existent.sh
>>> /usr/lib/git-core/git-bisect: 247: ./non-existent.sh: not found
> ...
>> On the other hand, the "./non-existent.sh" script could be part of
>> the tracked contents (i.e. some revisions have it and the working
>> tree has it when they get checked out, some revisions don't and the
>> working tree does not have it), and the user is trying to find the
>> first revision that stopped having a working script in its tree.  In
>> such a case, the script that does not exist and the script that fails
>> need to be treated the same way by "git bisect run" as failures.
>>
>> So... I dunno.
>
> Perhapsa --not-found-as-failure option could help?

Do you mean a new option must be passed if the end-user expects the
script to always exist across revisions, or the script is not
tracked to begin with?  It feels somewhat backwards and the effort
by the end-user to always type the option is better spent to make
sure there is no typo on the command line.

Besides, we need to take into account that "bisect run" takes an
arbitrary shell snippet, e.g. the user may try to switch between two
scripts, test-1 and test-2, based on some condition, and wrote this:

  $ git bisect run "if some-condition; then ./test-1; else ./test-3; fi"

but made a typo in the name of test-2.  It would be noticed after
attempting to run the "if ... fi" as a scriptlet by the returned
status from it being 127 (command not found), which is not treated
any specially by "git bisect run".  So a typo in the script name in
the above example cannot be distinguished from this error where the
user wanted to run test-1 under some condition, but wanted to
declare that the revision is bad if that condition did not hold,
i.e.

  $ git bisect run "if some-condition; then ./test-1; else (exit 127); fi=
"

Even if we somehow could tell these two apart, we cannot pick the
first scriptlet apart and guess which substring in it were meant as
a filename with a typo.

It may be possible to forbid the general use of exit code 127 and
instead reserve it to signal "we know that the test script is so
broken (this includes the case where it does not even exist) that
using it with 'bisect run' is meaningless; please stop immediately."
and nothing else, just like exit code 125 is reserved for "this
revision is not testable and cannot say good or bad", but making
such a change retroactively is not to be done very lightly.

So, again, I dunno.

 git-bisect.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-bisect.sh b/git-bisect.sh
index 7a8f796251..5c03bf8533 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -122,7 +122,7 @@ bisect_run () {
 		res=3D$?
=20
 		# Check for really bad run error.
-		if [ $res -lt 0 -o $res -ge 128 ]
+		if [ $res -lt 0 -o $res -ge 128 -o $res -eq 127 ]
 		then
 			eval_gettextln "bisect run failed:
 exit code \$res from '\$command' is < 0 or >=3D 128" >&2
