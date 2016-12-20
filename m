Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 69A401FF76
	for <e@80x24.org>; Tue, 20 Dec 2016 18:35:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753781AbcLTSfq (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Dec 2016 13:35:46 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56907 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752918AbcLTSfo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Dec 2016 13:35:44 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0442758CBA;
        Tue, 20 Dec 2016 13:35:38 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=O2c1ynaSzsVsn9699LDH31/lb8w=; b=AWfADZ
        K8b54clBzt/W0NOwPPWgY3L68wQXhznGPu7C5FVeeYcVYSEcQ0FpCTDocELQYrzK
        GqwgJ0s+RCBDE3i0PR3uxYu/n+5FRYE8tAOn3lJY8BdUEH6s4ajYmR7jCwfVbYOG
        vPYWKp8l5hhwpEMi64y0GiuCOwALLlUjD98ig=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=BEtEHWSrPAJIp5jZfINPbh7LrwsCVkUj
        CDDh7y9XzIMxAaGpdID4JMqj/ce698aXXmh/Wi8Q0OAEeEEsxQQUqEbsWauG5cZB
        cF1s4czmaQwMH+QqEsO+LQW/7ukyFeK6/5vGQDPv6H9cntSFlqLhRzyRC4HQ7hIj
        yieUFiugZYc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id EF70258CB9;
        Tue, 20 Dec 2016 13:35:37 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 724DC58CB8;
        Tue, 20 Dec 2016 13:35:37 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Jeff King <peff@peff.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: Allow "git shortlog" to group by committer information
References: <CA+55aFzWkE43rSm-TJNKkHq4F3eOiGR0-Bo9V1=a1s=vQ0KPqQ@mail.gmail.com>
        <CA+55aFxSQ2wxU3cA+8uqS-W8mbobF35dVCZow2BcixGOOvGVFQ@mail.gmail.com>
        <20161216133940.hu474phggdslh6ka@sigill.intra.peff.net>
        <20161216135141.yhas67pzfm7bxxum@sigill.intra.peff.net>
        <16b115e0-3a7e-a5c2-1526-44bbcfc97db8@kdbg.org>
        <xmqq60melazp.fsf@gitster.mtv.corp.google.com>
        <xmqq1sx2lara.fsf@gitster.mtv.corp.google.com>
Date:   Tue, 20 Dec 2016 10:35:36 -0800
In-Reply-To: <xmqq1sx2lara.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Tue, 20 Dec 2016 10:24:09 -0800")
Message-ID: <xmqqvauejvnr.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 19D7DFD8-C6E3-11E6-8D87-E98412518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>>> May I kindly ask you to make this work on Windows, too? Just
>>>
>>> sed -i -e s/MINGW/MINGW,HAVENOT/ t4201-shortlog.sh
>>
>> HAVENOT???
>>>
>>> on your Linux box and make it pass the tests.
>>>
>>> Thank you so much in advance.
>
> Ah, I think I am slower than my usual today.

-- >8 --
Subject: SQUASH???

Make sure the test does not depend on the result of the previous
tests; with MINGW prerequisite satisfied, a "reset to original and
rebuild" in an earlier test was skipped, resulting in different
history being tested with this and the next tests.

---
 t/t4201-shortlog.sh | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/t/t4201-shortlog.sh b/t/t4201-shortlog.sh
index 6c7c637481..9df054bf05 100755
--- a/t/t4201-shortlog.sh
+++ b/t/t4201-shortlog.sh
@@ -191,8 +191,14 @@ test_expect_success 'shortlog with --output=<file>' '
 '
 
 test_expect_success 'shortlog --committer (internal)' '
+	git checkout --orphan side &&
+	git commit --allow-empty -m one &&
+	git commit --allow-empty -m two &&
+	GIT_COMMITTER_NAME="Sin Nombre" git commit --allow-empty -m three &&
+
 	cat >expect <<-\EOF &&
-	     3	C O Mitter
+	     2	C O Mitter
+	     1	Sin Nombre
 	EOF
 	git shortlog -nsc HEAD >actual &&
 	test_cmp expect actual
