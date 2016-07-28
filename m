Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E118D1F858
	for <e@80x24.org>; Thu, 28 Jul 2016 21:23:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757357AbcG1VX3 (ORCPT <rfc822;e@80x24.org>);
	Thu, 28 Jul 2016 17:23:29 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57971 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751375AbcG1VX2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jul 2016 17:23:28 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id D93C42FD7B;
	Thu, 28 Jul 2016 17:23:26 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=KBF4fb4yY5OdM+9LVMTI/d5NWS4=; b=Uiwfhq
	CuaCVpJ/3AS+mTme65eD1+liwTVr1lCC90YDrKVjpT/LtSDl6HdRrc7qxfu7+os4
	aCzp1XdHg5RrRzG+XuiFXq3V++NVLSSna68Vb1OgX8PClw2G2CkjqzUS82W5He9x
	pzApfdLVGfEr0z7AMZKkGvGZ3f4bW6k5FGrBo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=khGUZ7CS8zSBFcGYKUrUnM7mXfDghojs
	SaU1Iyr8Y4/sKpv0cNiCzur5g2uZfEqJ3TVVPzivAZANKyCLIc9Wv2BL6hqx0BCn
	mPWZr2xtM8Cb7Ope+lD2kEPhJibx8UzgSmcwqVk5I1FNJildq9pmGu0S/ZKucHig
	VTyzjw/rjAc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id D1F0C2FD7A;
	Thu, 28 Jul 2016 17:23:26 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 58F522FD79;
	Thu, 28 Jul 2016 17:23:26 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Eric Wong <e@80x24.org>
Cc:	git@vger.kernel.org
Subject: Re: [PATCH] git-svn: allow --version to work anywhere
References: <20160720004734.GA19635@whir>
	<xmqqeg6lbnow.fsf@gitster.mtv.corp.google.com>
	<20160722204610.GA20896@whir>
	<xmqqtwf9r013.fsf@gitster.mtv.corp.google.com>
Date:	Thu, 28 Jul 2016 14:23:24 -0700
In-Reply-To: <xmqqtwf9r013.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Thu, 28 Jul 2016 13:16:24 -0700")
Message-ID: <xmqqd1lxqwxf.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 85791DAC-5509-11E6-BBEC-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Eric Wong <e@80x24.org> writes:
>
>> Repushed my master in case it's a convenient time to pull.
>>
>> The following changes since commit 29493589e97a2de0c4c1c314f61ccafaee3b5caf:
>>
>>   archive-tar: huge offset and future timestamps would not work on 32-bit (2016-07-15 10:51:55 -0700)
>>
>> are available in the git repository at:
>>
>>   git://bogomips.org/git-svn.git master
>>
>> for you to fetch changes up to c0071ae5dc1c610ab3791ece7ccf7d4772fde151:
>>
>>   git-svn: allow --version to work anywhere (2016-07-22 20:38:11 +0000)
>
> Thanks, pulled.

I was too deep in today's integration cycle to waste half-day's
work, so I added this hotfix after the merge, directly on 'master'.

-- >8 --
Subject: [PATCH] t9100: portability fix

Do not say "export VAR=VAL"; "VAR=VAL && export VAR" is always more
portable.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t9100-git-svn-basic.sh | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/t/t9100-git-svn-basic.sh b/t/t9100-git-svn-basic.sh
index ab6593b..d29f601 100755
--- a/t/t9100-git-svn-basic.sh
+++ b/t/t9100-git-svn-basic.sh
@@ -24,7 +24,8 @@ ceiling=$PWD
 
 test_expect_success 'git svn --version works anywhere' '
 	mkdir -p "$deepdir" && (
-		export GIT_CEILING_DIRECTORIES="$ceiling" &&
+		GIT_CEILING_DIRECTORIES="$ceiling" &&
+		export GIT_CEILING_DIRECTORIES &&
 		cd "$deepdir" &&
 		git svn --version
 	)
@@ -32,7 +33,8 @@ test_expect_success 'git svn --version works anywhere' '
 
 test_expect_success 'git svn help works anywhere' '
 	mkdir -p "$deepdir" && (
-		export GIT_CEILING_DIRECTORIES="$ceiling" &&
+		GIT_CEILING_DIRECTORIES="$ceiling" &&
+		export GIT_CEILING_DIRECTORIES &&
 		cd "$deepdir" &&
 		git svn help
 	)
-- 
2.9.2-662-gbb82c05

