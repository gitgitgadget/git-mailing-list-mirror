Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A1C9C433E0
	for <git@archiver.kernel.org>; Tue, 16 Feb 2021 18:33:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F8E764E2B
	for <git@archiver.kernel.org>; Tue, 16 Feb 2021 18:33:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229912AbhBPSdV (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Feb 2021 13:33:21 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55008 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbhBPSdU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Feb 2021 13:33:20 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 41B6EA6178;
        Tue, 16 Feb 2021 13:32:35 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=5nVNvujXe9bJLaAB4sV9x5Za66k=; b=Dwnp9l
        4s7tCEdbY/LEg/5IzpKcgbU+eNK5jKDOcS3ZL/Z/Pm/YtGXTn8AoNO2UwQ+LX24+
        v7qib85xVPlueIMmTw4uafAq+CwrNCGDPUvTf2QkDruHl/1qC+1RdvR8KYInFdRe
        SecfTm0w3KyOsxCH1Z58VUsvQ4ZFfgGZq6SyI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=oxlEt3bx3GZEdh3bV77nwVJVy6vx7DmG
        4kVixoVIw118P1WDeSwaiMs1E4hO88+NOPjeMa3r5c+syThRDxN1OCcD5igbuIVZ
        +Mkr+qKNxwuTnxaK4U8fpBQLwJqOwZmauPj22WYdV/RbVfqlzJwQtyerpoUcWUng
        T6Qc5m5HzKQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 37383A6176;
        Tue, 16 Feb 2021 13:32:35 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.243.138.161])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A1233A6171;
        Tue, 16 Feb 2021 13:32:34 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org,
        Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Adam Spiers <git@adamspiers.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Chris Torek <chris.torek@gmail.com>
Subject: Re: [PATCH v2 09/27] userdiff tests: match full hunk headers
References: <20210215005236.11313-1-avarab@gmail.com>
        <20210215154427.32693-10-avarab@gmail.com>
        <4bd7bb84-3b75-258e-b488-f66dff6ba6b5@kdbg.org>
Date:   Tue, 16 Feb 2021 10:32:33 -0800
In-Reply-To: <4bd7bb84-3b75-258e-b488-f66dff6ba6b5@kdbg.org> (Johannes Sixt's
        message of "Mon, 15 Feb 2021 18:13:18 +0100")
Message-ID: <xmqqsg5vrhha.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 565C926E-7085-11EB-A5E8-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Sixt <j6t@kdbg.org> writes:

>>   t/t4018-diff-funcname.sh                      |  7 +++---
>>   t/t4018/README                                | 22 +++++++++----------
>>   t/t4018/README.ctx                            |  1 +
>>   t/t4018/bash-arithmetic-function.ctx          |  1 +
>>   t/t4018/bash-bashism-style-compact.ctx        |  1 +
>>   [...and so on...]
>
> This is what I meant by "without burdening test writers with lots of
> subtleties".
>
> I'm not a friend of this change :-(
>
> I think you are going overboard with required test precision. To have
> useful tests for userdiff patterns that demonstrate its features, 
> authors should write *many* tests. The right balance should be on the
> coverage of userdiff pattern features, not on the subtle details of
> each and everyone of it. Requiring that many additional context files
> makes it *really hard* to comply.

Yeah, the first time I saw the t4018 test framework appeared in my
tree, I truly appreciated its simplicity, how the test input file is
self-documenting and self-contained, with the clever use of "RIGHT",
"broken" and "ChangeMe" magic tokens, admired the cleverness of the
approach, and wished I was clever enough to invent that pattern to
apply to other tests myself.

A little new for each and every test for the miniscule gain of
checking which part of the function header line is extracted feels a
bit too much noise and rubs my sense of aesthetics, spoiled by the
existing t4018 tests, the wrong way.

This is a rough sketch of a different approach aiming for the same.
I converted only a few files, but I hope that this is enough to
illustrate the idea.

 t/t4018-diff-funcname.sh         | 17 ++++++++++++++---
 t/t4018/README                   |  9 ++++++---
 t/t4018/bash-arithmetic-function |  3 +++
 3 files changed, 23 insertions(+), 6 deletions(-)

diff --git c/t/t4018-diff-funcname.sh w/t/t4018-diff-funcname.sh
index 9675bc17db..dd79c99fc5 100755
--- c/t/t4018-diff-funcname.sh
+++ w/t/t4018-diff-funcname.sh
@@ -107,10 +107,21 @@ do
 	else
 		result=success
 	fi
-	test_expect_$result "hunk header: $i" "
+
+	test_expect_$result "hunk header: $i" '
+		HEAD=$(sed -n \
+			-e "s/^.*HEADER.*|\(.*\)right\(.*\)|.*/ \1RIGHT\2/p" "$i") &&
+
 		git diff -U1 $i >actual &&
-		grep '@@ .* @@.*RIGHT' actual
-	"
+
+		sed -ne "s/^@@[^@]*@@//p" actual |
+		if test -n "$HEAD"
+		then
+			grep -F "$HEAD"
+		else
+			grep "^.*RIGHT"
+		fi
+	'
 done
 
 test_done
diff --git c/t/t4018/README w/t/t4018/README
index 283e01cca1..bc3c11e083 100644
--- c/t/t4018/README
+++ w/t/t4018/README
@@ -10,9 +10,12 @@ The text that must appear in the hunk header must contain the word
 To mark a test case that highlights a malfunction, insert the word
 BROKEN in all lower-case somewhere in the file.
 
-This text is a bit twisted and out of order, but it is itself a
-test case for the default hunk header pattern. Know what you are doing
-if you change it.
+This text is a bit twisted and out of order, but it is itself a test
+case for the default hunk header pattern. Know what you are doing if
+you change it.  You can optionally force exactly what should be on
+the hunk header line by enclosing the expect text by vertical bars
+(but downcasing the word right in it) and place it on a line with
+HEADER on it, like |How to write right test cases|.
 
 BTW, this tests that the head line goes to the hunk header, not the line
 of equal signs.
diff --git c/t/t4018/bash-arithmetic-function w/t/t4018/bash-arithmetic-function
index c0b276cb50..935f18d96d 100644
--- c/t/t4018/bash-arithmetic-function
+++ w/t/t4018/bash-arithmetic-function
@@ -2,3 +2,6 @@ RIGHT() ((
 
     ChangeMe = "$x" + "$y"
 ))
+
+
+# HEADER |right()|
