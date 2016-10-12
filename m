Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D28C51F4F8
	for <e@80x24.org>; Wed, 12 Oct 2016 06:00:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753565AbcJLGAc (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Oct 2016 02:00:32 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50912 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752236AbcJLF7p (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Oct 2016 01:59:45 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6CF7F3E4B1;
        Wed, 12 Oct 2016 01:59:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=7rpBKqT6vmkQPMIG1Qgm1eOAmXE=; b=IsLy5N
        yzAIdHP4fz4SYlbn7SN67mAHevsb77CgBfq2l4Ct1hbnzKJIrHEkMaSHiDE7trzD
        7XD9TNMK2RMNlS/OBJKi45nIjhE71ERZAtuk8F70ttKcByWywwzIVYm/t48l/Fc9
        YJsfYUtBGf4JB1yBYbNTi2h76mxpMLrZ0bHDA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=iX1TdFiP7BfIIPLCIZnOlz70u2wq7LaA
        db5/WxlGCJddkX5+bRpZ4PQytR0IUS62xlMDOmF4dPa0Q4cwU8R0IFu4bOqea5ZQ
        8N4Qm3r936jbvBlnBuSC2bOpaqKKAwQEWYUVsR4BulfnpxiEg/EIneTp85mN1byd
        IbQA8Tl4x78=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 644E03E4AF;
        Wed, 12 Oct 2016 01:59:18 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id DCAAC3E4AE;
        Wed, 12 Oct 2016 01:59:17 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeremy Huddleston Sequoia <jeremyhu@freedesktop.org>
Cc:     t.gummerer@gmail.com, git@vger.kernel.org
Subject: Re: git 2.10.1 test regression in t3700-add.sh
References: <A433322C-2B75-4B4B-A8CC-BAC3179EE7A7@freedesktop.org>
        <98EB348E-221D-488C-A466-1FACB1C768FF@freedesktop.org>
        <6CA5F44F-38C1-4C15-9B85-FE84FB93E616@freedesktop.org>
        <49BF26B2-8E6D-40B1-87A2-1FDDF9A76B8E@freedesktop.org>
        <xmqq8ttwgkyo.fsf@gitster.mtv.corp.google.com>
        <EF7F9B45-867A-433B-9623-EBBF33D34793@freedesktop.org>
Date:   Tue, 11 Oct 2016 22:59:15 -0700
In-Reply-To: <EF7F9B45-867A-433B-9623-EBBF33D34793@freedesktop.org> (Jeremy
        Huddleston Sequoia's message of "Tue, 11 Oct 2016 16:32:51 -0700")
Message-ID: <xmqq1szm6rbg.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0302ABD6-9041-11E6-948B-5F377B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeremy Huddleston Sequoia <jeremyhu@freedesktop.org> writes:

>> diff --git a/t/t3700-add.sh b/t/t3700-add.sh
>> index 924a266126..53c0cb6dea 100755
>> --- a/t/t3700-add.sh
>> +++ b/t/t3700-add.sh
>> @@ -350,6 +350,7 @@ test_expect_success POSIXPERM,SYMLINKS 'git add --chmod=+x with symlinks' '
>> '
>> 
>> test_expect_success 'git add --chmod=[+-]x changes index with already added file' '
>> +	rm -f foo3 xfoo3 &&
>> 	echo foo >foo3 &&
>> 	git add foo3 &&
>> 	git add --chmod=+x foo3 &&
>
>
> I actually tried that, but the problem is that xfoo3 was
> previously added as a symlink, so test_mode_in_index still reports
> it as a symlink.

Ah, of course.  That "rm -f" needs to remove from the index and also
from the working tree, so has to be "git rm -f --ignore-unmatch" or
something like that.

> It's fundamentally a question of who is responsible for cleanup.
> Is the individual test responsible for cleaning up after itself
> (such that later tests can rely on a clean state), or should
> individual tests assume that the initial state might be undefined
> and try to cleanup after earlier tests?

In modern tests, we strive to do the former with liberal use of
test_when_finished.  I think the one that creates xfoo[123] and
leaves them behind for a long time predates the modern practice.

A minimal fix with that approach may look like this:

 t/t3700-add.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/t/t3700-add.sh b/t/t3700-add.sh
index 924a266126..80c7ee3e3b 100755
--- a/t/t3700-add.sh
+++ b/t/t3700-add.sh
@@ -64,6 +64,7 @@ test_expect_success 'git add: filemode=0 should not get confused by symlink' '
 test_expect_success \
 	'git update-index --add: Test that executable bit is not used...' \
 	'git config core.filemode 0 &&
+	 test_when_finished "git rm -f xfoo3" &&
 	 test_ln_s_add xfoo2 xfoo3 &&	# runs git update-index --add
 	 test_mode_in_index 120000 xfoo3'
 
