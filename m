Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0A7D71FE4E
	for <e@80x24.org>; Tue, 12 Jul 2016 20:41:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751084AbcGLUlF (ORCPT <rfc822;e@80x24.org>);
	Tue, 12 Jul 2016 16:41:05 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50331 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750874AbcGLUlE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 12 Jul 2016 16:41:04 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 52B6D2BC1D;
	Tue, 12 Jul 2016 16:40:52 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=/fll+COZNs+W
	lRe6U/l4GI/WwGc=; b=n9t9DXu1JgaLzvZKcMof+EyosAhyrQw+uHtL3eD4c2nI
	cW/mG0NLceJ7OhHQMEgEiGAlxKeIERJiy4hevmFNL12wl9a1/zgwrGtaRrW0UizN
	s/DRLtXvUWp8YTvfpXH8MPmoQUwc7MBie5PMGXQpi1cRev0shzo70EZmo46XzAA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=GIusjN
	uEiCK0mq+b7NRAXdBXWX6BhJtZfMG4Km75jNgOCkwdPkPWqm5VfhOwLlDyAGqsoa
	0QC8S4G4+DvHVFPRojBV379/BxM6ejAG0BBEgJIoeK/hfUNthTnOPtp53ZG+74KM
	Oq05DgE/uL4kM325JV4KRITWZrJo0AZBuFGZI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 4B5F52BC1B;
	Tue, 12 Jul 2016 16:40:52 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B79422BC19;
	Tue, 12 Jul 2016 16:40:51 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:	git@vger.kernel.org, yuri.kanivetsky@gmail.com
Subject: Re: [PATCH v3 1/4] test-lib.sh: introduce and use $_EMPTY_TREE
References: <20160706184829.31825-1-pclouds@gmail.com>
	<20160709052356.30570-1-pclouds@gmail.com>
	<20160709052356.30570-2-pclouds@gmail.com>
Date:	Tue, 12 Jul 2016 13:40:49 -0700
In-Reply-To: <20160709052356.30570-2-pclouds@gmail.com> (=?utf-8?B?Ik5n?=
 =?utf-8?B?dXnhu4VuIFRow6FpIE5n4buNYw==?=
	Duy"'s message of "Sat, 9 Jul 2016 07:23:53 +0200")
Message-ID: <xmqq1t2y4mjy.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: EC320A68-4870-11E6-BD5B-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: 8BIT
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Nguyễn Thái Ngọc Duy  <pclouds@gmail.com> writes:

> This is a special SHA1. Let's keep it at one place, easier to replace
> later when the hash change comes, easier to recognize. Start with an
> underscore to reduce the chances somebody may override it without
> realizing it's predefined.
>
> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
> ---
>  t/t0000-basic.sh                |  2 +-
>  t/t1100-commit-tree-options.sh  |  2 +-
>  t/t4010-diff-pathspec.sh        |  6 ++----
>  t/t4054-diff-bogus-tree.sh      | 10 ++++------
>  t/t5504-fetch-receive-strict.sh |  4 ++--
>  t/test-lib.sh                   |  4 +++-
>  6 files changed, 13 insertions(+), 15 deletions(-)
>
> diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
> index 60811a3..48214e9 100755
> --- a/t/t0000-basic.sh
> +++ b/t/t0000-basic.sh
> @@ -834,7 +834,7 @@ test_expect_success 'git write-tree should be able to write an empty tree' '
>  '
>  
>  test_expect_success 'validate object ID of a known tree' '
> -	test "$tree" = 4b825dc642cb6eb9a060e54bf8d69288fbee4904
> +	test "$tree" = $_EMPTY_TREE
>  '

I doubt the point of, and I'd rather not to see, the leading
underscore.  Are there existing uses of the name that want it to
mean something different?
