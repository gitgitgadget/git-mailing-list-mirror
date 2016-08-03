Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BD7121F40E
	for <e@80x24.org>; Wed,  3 Aug 2016 19:20:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756777AbcHCTUU (ORCPT <rfc822;e@80x24.org>);
	Wed, 3 Aug 2016 15:20:20 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56212 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756369AbcHCTUR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Aug 2016 15:20:17 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 4424C30137;
	Wed,  3 Aug 2016 15:08:03 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=hrO0Bfpa6V95exu993HRQQ6EK6s=; b=K7E30f
	llCkwFhz27CTCJQ7TrrV0nAEp8Un2baCjCDHYWup7R2Ey7Mz6EsWi01AFHrDijo1
	eSHWe+hbQ3T3RqzYAVqyKTTN+P49+f0hzYnEDPJL6YqlruNKeVZgc6UEI20Mg9LV
	qRAG06hOJFDaDCsub5B1352wZSni+A4YYLf80=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=k6zVaIXnPc2l3PPwWAxQlOrD/t241T3g
	RzXq7IcCkMKeySGeO13RMFAzuLp3EcD1E/W/CStaIAhJB8L4GPL9JjhBMP0vJ/0M
	J3sf11HN648JqO42cGSXvbvlDwuv1Q4dpj5zqI5o5d4/gbPeunsU44Wdb8nAgLju
	B6VKqeBgP78=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 3CC6830136;
	Wed,  3 Aug 2016 15:08:03 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A5D7830134;
	Wed,  3 Aug 2016 15:08:02 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:	Git Mailing List <git@vger.kernel.org>, Eric Wong <e@80x24.org>,
	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH v3] t7063: work around FreeBSD's lazy mtime update feature
References: <20160803160536.15596-1-pclouds@gmail.com>
	<20160803174522.5571-1-pclouds@gmail.com>
	<CAPc5daU49iVYw14sYeshXDbHGE_nW4vWyM=2XSz-buACVLFwoA@mail.gmail.com>
Date:	Wed, 03 Aug 2016 12:07:58 -0700
In-Reply-To: <CAPc5daU49iVYw14sYeshXDbHGE_nW4vWyM=2XSz-buACVLFwoA@mail.gmail.com>
	(Junio C. Hamano's message of "Wed, 3 Aug 2016 10:52:04 -0700")
Message-ID: <xmqqpopp8ycx.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 99DC0AA4-59AD-11E6-AD5D-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> If you mean to tell the user "I won't describe it in detail, if you
> really want to know,
> go run blame yourself", spell it out like so. I was hoping that you
> can summarize
> in-line there to help the readers here.

Here is a proposed fixup.

 t/t7063-status-untracked-cache.sh | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/t/t7063-status-untracked-cache.sh b/t/t7063-status-untracked-cache.sh
index d31d080..e0a8228 100755
--- a/t/t7063-status-untracked-cache.sh
+++ b/t/t7063-status-untracked-cache.sh
@@ -4,12 +4,16 @@ test_description='test untracked cache'
 
 . ./test-lib.sh
 
-# On some filesystems (e.g. FreeBSD's ext2 and ufs) this and that
-# happens when we do blah, which forces the untracked cache code to
-# take the slow path.  A test that wants to make sure the fast path
-# works correctly should call this helper to make mtime of the
-# containing directory in sync with the reality after doing blah and
-# before checking the fast path behaviour
+# On some filesystems (e.g. FreeBSD's ext2 and ufs) directory mtime
+# is updated lazily after contents in the directory changes, which
+# forces the untracked cache code to take the slow path.  A test
+# that wants to make sure that the fast path works correctly should
+# call this helper to make mtime of the containing directory in sync
+# with the reality before checking the fast path behaviour.
+#
+# See <20160803174522.5571-1-pclouds@gmail.com> if you want to know
+# more.
+
 sync_mtime () {
 	find . -type d -ls >/dev/null
 }
