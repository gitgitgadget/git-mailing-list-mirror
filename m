Return-Path: <SRS0=h4OP=2D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EF3BC4D2F4
	for <git@archiver.kernel.org>; Fri, 13 Dec 2019 20:41:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A205724700
	for <git@archiver.kernel.org>; Fri, 13 Dec 2019 20:41:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="gAasTFhC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729039AbfLMUYH (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Dec 2019 15:24:07 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:50945 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729035AbfLMUYG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Dec 2019 15:24:06 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id BB45BA8C2C;
        Fri, 13 Dec 2019 15:24:04 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=nNgNU2w56OcVVVUP8fcqDvv2tCI=; b=gAasTF
        hCGkh70GrlW4IjgXY4QdC/WWr0xYr5LIcChXUegoZ29zjOrWmzHX/82SyOvMyFW5
        syWuvKBEtpfA2xaj4FHh//rpRxFxI3FpArjZP5Yad3twNU+0Cc6bpCscsPJDMQp0
        h3qJ3OQqVvllBcHzZpQ/J6n2zRByPjpCy8z00=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=rvd2AeYmKLnOIL0aEFNz/ybbfk9t2byz
        35LS2QR2t5tMlGhW+ICv0O/SxxwEZzTxAAWkX/RkBrJ8+urbv/qLebdL8LAGtUAo
        vLPxRLhxIxlfL6jZrhxEefVm9LzOx+i2KyHfvUrsbV3pJxZxk6O1nL3rEPcRq4Ng
        wtw7zGXPRUA=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B4780A8C2B;
        Fri, 13 Dec 2019 15:24:04 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id D67FDA8C21;
        Fri, 13 Dec 2019 15:24:01 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ed Maste <emaste@freebsd.org>
Cc:     Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org,
        Jeff King <peff@peff.net>, lukasz@niemier.pl
Subject: Re: [PATCH v2] userdiff: remove empty subexpression from elixir regex
References: <20191213173902.71541-1-emaste@FreeBSD.org>
        <20191213175535.87725-1-emaste@FreeBSD.org>
        <0c9d891e-382f-03d1-bcbd-d652f1d58f4d@kdbg.org>
        <CAPyFy2B_P7qJ+ocg8rzNWEZWo2uKzaZsfYRvvhwUbAXv2AB6pg@mail.gmail.com>
Date:   Fri, 13 Dec 2019 12:23:59 -0800
In-Reply-To: <CAPyFy2B_P7qJ+ocg8rzNWEZWo2uKzaZsfYRvvhwUbAXv2AB6pg@mail.gmail.com>
        (Ed Maste's message of "Fri, 13 Dec 2019 10:58:40 -0500")
Message-ID: <xmqqzhfwht40.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8035D066-1DE6-11EA-A6D1-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ed Maste <emaste@freebsd.org> writes:

>> > Add /* -- */ to make things more clear and be consistent with other
>> > patterns.
>>
>> This text would be nice to have in the commit message.
>
> Ah, I didn't think it was remarkable (it's consistent with all of the
> existing entries) but the change is indeed broader than what the
> commit message implies. I'm happy to send a v3 with an amended commit
> message if that's desired.

Let's save one round-trip, then.  Here is what I will queue on the
'pu' branch.

Thanks, all.

-- >8 --
From: Ed Maste <emaste@FreeBSD.org>
Date: Fri, 13 Dec 2019 17:55:35 +0000
Subject: [PATCH] userdiff: remove empty subexpression from elixir regex

The regex failed to compile on FreeBSD.

Also add /* -- */ mark to separate the two regex entries given to
the PATTERNS() macro, to make it consistent with patterns for other
content types.

Signed-off-by: Ed Maste <emaste@FreeBSD.org>
Reviewed-by: Jeff King <peff@peff.net>
Helped-by: Johannes Sixt <j6t@kdbg.org>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 userdiff.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/userdiff.c b/userdiff.c
index 577053c10a..0eb34bcd76 100644
--- a/userdiff.c
+++ b/userdiff.c
@@ -34,8 +34,9 @@ PATTERNS("dts",
 	 "|[-+*/%&^|!~]|>>|<<|&&|\\|\\|"),
 PATTERNS("elixir",
 	 "^[ \t]*((def(macro|module|impl|protocol|p)?|test)[ \t].*)$",
+	 /* -- */
 	 /* Atoms, names, and module attributes */
-	 "|[@:]?[a-zA-Z0-9@_?!]+"
+	 "[@:]?[a-zA-Z0-9@_?!]+"
 	 /* Numbers with specific base */
 	 "|[-+]?0[xob][0-9a-fA-F]+"
 	 /* Numbers */
-- 
2.24.1-664-g198078bb5a



