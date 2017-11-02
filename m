Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3D48E202A0
	for <e@80x24.org>; Thu,  2 Nov 2017 05:17:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751261AbdKBFRB (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Nov 2017 01:17:01 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53568 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750917AbdKBFRA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Nov 2017 01:17:00 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C407CAE322;
        Thu,  2 Nov 2017 01:16:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=7l97cwB3PE0Zz1LmyolT0SSiWp0=; b=OA+0VP
        EzIBkgvuucddb3IJFXRK7NPuDptO3Z+zN4PTy11gBnl94rQIy0iKouVlBwxPY+R9
        uOhgw1f2jQPAQI7EcgR+BHP7Tiovf/f1pjufR+cb4codDsXuRIf45sd3o80i0FYi
        7v9JEJse1H898DsFMIh5wEd7iLvi07T9eHZNw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=bUm+hgIVnKsvjVx6iJfHOAW9/HoVEb2p
        fwhZ2lu7nccKPjSd5mFjO6bYsupk9Oswn4BAG+9foNA6wxo5TBgZUvzo79jcDUIL
        orP7dX3XqIx/tWpFtx9OfwoYn3D90amVi4DsWxlQZHkaCrviTmZl5CYRQlxQOj4q
        nrfePCJaAAI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BBCDCAE320;
        Thu,  2 Nov 2017 01:16:54 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2CDC8AE31F;
        Thu,  2 Nov 2017 01:16:54 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Simon Ruderich <simon@ruderich.org>
Cc:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Git List <git@vger.kernel.org>,
        Ralf Thielow <ralf.thielow@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 1/2] wrapper.c: consistently quote filenames in error messages
References: <22afeefa-cdd5-cd32-0a7c-6bad4de79f05@web.de>
        <32c515d01d4257c1532004d0bf21b2c330f6b81b.1509547231.git.simon@ruderich.org>
        <xmqqvaitqon6.fsf@gitster.mtv.corp.google.com>
Date:   Thu, 02 Nov 2017 14:16:52 +0900
In-Reply-To: <xmqqvaitqon6.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Thu, 02 Nov 2017 13:40:29 +0900")
Message-ID: <xmqqlgjpqmyj.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0A542618-BF8D-11E7-8791-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Simon Ruderich <simon@ruderich.org> writes:
>
>> All other error messages in the file use quotes around the file name.
>>
>> This change removes two translations as "could not write to '%s'" and
>> "could not close '%s'" are already translated and these two are the only
>> occurrences without quotes.
>>
>> Signed-off-by: Simon Ruderich <simon@ruderich.org>
>> ---
>>  wrapper.c | 8 ++++----
>>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> This patch is incomplete without adjusting a handful of tests to
> expect the updated messages, no?

I'll squash these in while queuing, but there might be more that I
didn't notice.

Thansk.

 t/t3600-rm.sh | 2 +-
 t/t7001-mv.sh | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t3600-rm.sh b/t/t3600-rm.sh
index f8568f8841..ab5500db44 100755
--- a/t/t3600-rm.sh
+++ b/t/t3600-rm.sh
@@ -688,7 +688,7 @@ test_expect_success 'checking out a commit after submodule removal needs manual
 	git submodule update &&
 	git checkout -q HEAD^ &&
 	git checkout -q master 2>actual &&
-	test_i18ngrep "^warning: unable to rmdir submod:" actual &&
+	test_i18ngrep "^warning: unable to rmdir '\''submod'\'':" actual &&
 	git status -s submod >actual &&
 	echo "?? submod/" >expected &&
 	test_cmp expected actual &&
diff --git a/t/t7001-mv.sh b/t/t7001-mv.sh
index f5929c46f3..6e5031f56f 100755
--- a/t/t7001-mv.sh
+++ b/t/t7001-mv.sh
@@ -452,7 +452,7 @@ test_expect_success 'checking out a commit before submodule moved needs manual u
 	git mv sub sub2 &&
 	git commit -m "moved sub to sub2" &&
 	git checkout -q HEAD^ 2>actual &&
-	test_i18ngrep "^warning: unable to rmdir sub2:" actual &&
+	test_i18ngrep "^warning: unable to rmdir '\''sub2'\'':" actual &&
 	git status -s sub2 >actual &&
 	echo "?? sub2/" >expected &&
 	test_cmp expected actual &&
