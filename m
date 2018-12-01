Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6F353211B4
	for <e@80x24.org>; Sat,  1 Dec 2018 12:24:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726578AbeLAXPY (ORCPT <rfc822;e@80x24.org>);
        Sat, 1 Dec 2018 18:15:24 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:60004 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726492AbeLAXPX (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Dec 2018 18:15:23 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E91233FF33;
        Sat,  1 Dec 2018 07:02:57 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=tQStUwjsyC2p
        3liFYDBxK6tG3XU=; b=fe11mMFQkp4Df5yOS7kVeKYNKXqvnqbwuEPemWG4fxZk
        JRNZV17CiJwEueMmhOKZtTTqucrvElRhf0xFkrMkhTmRwXx/C4QG2SLgOiCHXLtj
        LWkYsnffmFOXLkfcy6yFJ0vW2I8XetpLScxZ6bpKnBFLeP1aJgdoWbW7Bro31CE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=oHEPaf
        EkCuWNf0OeEmA+masUAi+CIKjywgnVstYC1T7INqxs9Rv5s2cXSvx6Y5JdqY42dm
        gPui19pKGSqqGb480qh8TiZORXa4RNvamlVxcOXJZjEegkuV991Yqqy050hChwrR
        VmWxfBT0BasgCuOGQ+xIa7wiSXLlV7b8BXyaE=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E1E4E3FF31;
        Sat,  1 Dec 2018 07:02:57 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.187.50.168])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 030E43FF2F;
        Sat,  1 Dec 2018 07:02:54 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     carenas@gmail.com, Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] t6036: avoid "cp -a"
References: <20181201025212.54244-1-carenas@gmail.com>
        <CABPp-BG0=bGW54eMHCiVMbU3dwccZM06qy2gzqm1CE-TUFZ2zg@mail.gmail.com>
Date:   Sat, 01 Dec 2018 21:02:52 +0900
In-Reply-To: <CABPp-BG0=bGW54eMHCiVMbU3dwccZM06qy2gzqm1CE-TUFZ2zg@mail.gmail.com>
        (Elijah Newren's message of "Fri, 30 Nov 2018 20:21:56 -0800")
Message-ID: <xmqqk1ktjvyr.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 093AE7D4-F561-11E8-A79B-CC883AD79A78-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> Thanks for the patch!
>
> On Fri, Nov 30, 2018 at 6:52 PM Carlo Marcelo Arenas Bel=C3=B3n
> ...
> Oops.  Thanks for catching.  To be honest, we don't even need -a, -R,
> etc. -- it was just a habit for me to add -a after cp.  A simple cp
> would do, though what you have here is fine too.

Thanks, both.  I think the topic won't escape 'next' until 2.20
final, and after that we can rewind 'next', so it may be better
to squash it in, but anyway...

-- >8 --
From: Carlo Marcelo Arenas Bel=C3=B3n <carenas@gmail.com>
Date: Fri, 30 Nov 2018 18:52:12 -0800
Subject: [PATCH] t6036: avoid non-portable "cp -a"

b8cd1bb713 ("t6036, t6043: increase code coverage for file collision
handling", 2018-11-07) uses this GNU extension that is not available
in a POSIX complaint cp.  In this particular case, there is no need to
use the option, as it is just copying a single file to create another
file.

Signed-off-by: Carlo Marcelo Arenas Bel=C3=B3n <carenas@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t6036-recursive-corner-cases.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t6036-recursive-corner-cases.sh b/t/t6036-recursive-corner=
-cases.sh
index b7488b00c0..d23b948f27 100755
--- a/t/t6036-recursive-corner-cases.sh
+++ b/t/t6036-recursive-corner-cases.sh
@@ -1631,7 +1631,7 @@ test_expect_success 'check nested conflicts' '
=20
 		# Compare m to expected contents
 		>empty &&
-		cp -a m_stage_2 expected_final_m &&
+		cp m_stage_2 expected_final_m &&
 		test_must_fail git merge-file --diff3 \
 			-L "HEAD"                     \
 			-L "merged common ancestors"  \
--=20
2.20.0-rc1-10-g7068cbc4ab

