Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EA1F320958
	for <e@80x24.org>; Thu, 23 Mar 2017 22:00:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751444AbdCWWAN (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Mar 2017 18:00:13 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53501 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750761AbdCWWAM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Mar 2017 18:00:12 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8DD3A6992E;
        Thu, 23 Mar 2017 18:00:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=PS7bHIcF/J1A7CkBoFWmifca++4=; b=CEzw/9
        N5k5ScUkHB8RRKoFRzDnMsXGx08/GKnGqROCf5vMS+LajUIQrUq1UNqNU3mcDV6B
        Cfvjn2ClZi/zaP634Z7w8fpmZaYbEDvQ2YGg6kbD7xQ1zdhQ3MmJz5+m+kVtbs5s
        7ySsV5okHlU2btzP2BWu7O7ciDvmvPIPKkjt4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=eTMW5O5KFapntsbh1J8ojMqGVkStUEHk
        VnN6F5rYJjB4u7bN2rNYoNS+qOywsOK7JPXzmI5y+3Y6bt0+ycGoIT7akPrD2bf7
        NDv4EOjKh8n7wcvdfKEMZZjXL0QGu8tr5nACxAPaRyLl8Lg/tBQ6h4SHg6CYgTJe
        GQdiwgEFPB4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 83B0F6992C;
        Thu, 23 Mar 2017 18:00:10 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C91426992A;
        Thu, 23 Mar 2017 18:00:09 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Santiago Torres <santiago@nyu.edu>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        Jan Palus <jan.palus@gmail.com>
Subject: Re: [PATCH 3/3] t7004, t7030: fix here-doc syntax errors
References: <20170322173528.ho43ulndlozq35tu@kalarepa>
        <20170322200805.23837-1-gitster@pobox.com>
        <20170322200805.23837-4-gitster@pobox.com>
        <20170322211003.b52cql3iwig2xqcd@sigill.intra.peff.net>
        <xmqq8tnxhssv.fsf@gitster.mtv.corp.google.com>
        <20170322221556.j7uj4vvgbcubcr3b@LykOS.localdomain>
        <20170322222230.yqqv6x4gokvb4jbz@sigill.intra.peff.net>
        <20170322223441.w32y464jqbnxnzna@LykOS.localdomain>
        <20170322224124.u3eax4ui3y4saxks@sigill.intra.peff.net>
        <20170322225108.wub4bmr63hk2sp33@LykOS.localdomain>
Date:   Thu, 23 Mar 2017 15:00:08 -0700
In-Reply-To: <20170322225108.wub4bmr63hk2sp33@LykOS.localdomain> (Santiago
        Torres's message of "Wed, 22 Mar 2017 18:51:08 -0400")
Message-ID: <xmqqfui3ac2f.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1526ED56-1014-11E7-B936-97B1B46B9B0B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Santiago Torres <santiago@nyu.edu> writes:

> This sounds like a helpful addition to implement. We could update/add
> tests for compliance on this once the feature is addded and fix the
> ambiguous behavior in the tests now.

OK, so has everybody agreed what the next step would be?  Is the
patch below a good first step (I still need to get it signed off)?

-- >8 --
Subject: t7004, t7030: fix here-doc syntax errors
From: Santiago Torres <santiago@nyu.edu>

Jan Palus noticed that some here-doc are spelled incorrectly,
resulting the entire remainder of the test as if it were data
slurped into the "expect" file, e.g. in this sequence

	cat >expect <<EOF &&
	... expectation ...
	EOF
	git $cmd_being_tested >actual &&
	test_cmp expect actual

the last command of the test is "cat" that sends everything to
'expect' and succeeds.

Fixing these issues in t7004 and t7030 reveals that "git tag -v"
and "git verify-tag" with their --format option do not work as the
test was expecting originally.  Instead of showing both valid tags
and tags with incorrect signatures on their output, tags that do not
pass verification are omitted from the output.

Arguably, that is a safer behaviour, and because the format
specifiers like %(tag) do not have a way to show if the signature
verifies correctly, the command with the --format option cannot be
used to get a list of tags annotated with their signature validity
anyway.

For now, let's fix the here-doc syntax and update the expectation to
match the reality.  Maybe later when we extend the --format language
available to "git tag -v" and "git verify-tag" to include things
like "%(gpg:status)", we may want to change the behaviour so that
piping a list of tag names into

    xargs git verify-tag --format='%(gpg:status) %(tag)'

becomes a good way to produce such a list, but that is a separate
topic.

Noticed-by: Jan Palus <jan.palus@gmail.com>
Helped-by: Jeff King <peff@peff.net>
---
 t/t7004-tag.sh        | 10 ++++------
 t/t7030-verify-tag.sh | 10 ++++------
 2 files changed, 8 insertions(+), 12 deletions(-)

diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
index b4698ab5f5..0581053a06 100755
--- a/t/t7004-tag.sh
+++ b/t/t7004-tag.sh
@@ -896,17 +896,15 @@ test_expect_success GPG 'verifying a forged tag should fail' '
 '
 
 test_expect_success 'verifying a proper tag with --format pass and format accordingly' '
-	cat >expect <<-\EOF
+	cat >expect <<-\EOF &&
 	tagname : signed-tag
-	EOF &&
+	EOF
 	git tag -v --format="tagname : %(tag)" "signed-tag" >actual &&
 	test_cmp expect actual
 '
 
-test_expect_success 'verifying a forged tag with --format fail and format accordingly' '
-	cat >expect <<-\EOF
-	tagname : forged-tag
-	EOF &&
+test_expect_success 'verifying a forged tag with --format should fail silently' '
+	>expect &&
 	test_must_fail git tag -v --format="tagname : %(tag)" "forged-tag" >actual &&
 	test_cmp expect actual
 '
diff --git a/t/t7030-verify-tag.sh b/t/t7030-verify-tag.sh
index d62ccbb98e..79864a3411 100755
--- a/t/t7030-verify-tag.sh
+++ b/t/t7030-verify-tag.sh
@@ -126,17 +126,15 @@ test_expect_success GPG 'verify multiple tags' '
 '
 
 test_expect_success 'verifying tag with --format' '
-	cat >expect <<-\EOF
+	cat >expect <<-\EOF &&
 	tagname : fourth-signed
-	EOF &&
+	EOF
 	git verify-tag --format="tagname : %(tag)" "fourth-signed" >actual &&
 	test_cmp expect actual
 '
 
-test_expect_success 'verifying a forged tag with --format fail and format accordingly' '
-	cat >expect <<-\EOF
-	tagname : 7th forged-signed
-	EOF &&
+test_expect_success 'verifying a forged tag with --format should fail silently' '
+	>expect &&
 	test_must_fail git verify-tag --format="tagname : %(tag)" $(cat forged1.tag) >actual-forged &&
 	test_cmp expect actual-forged
 '


