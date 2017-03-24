Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 42C531FC19
	for <e@80x24.org>; Fri, 24 Mar 2017 18:05:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754871AbdCXSEm (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Mar 2017 14:04:42 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61318 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S934972AbdCXSEg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Mar 2017 14:04:36 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7BB0175776;
        Fri, 24 Mar 2017 14:04:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=4sKgq49rZF1QVaAReVUackBjJcI=; b=E6iR2u
        d741LEt+dtS/l38rxjlS+6z4FGeqObTDL9FbRvhn4FN1LCIVtg6HlgaGVmmBqhSf
        KhL2C5m8fPFP6wGRXnJpHEDZOY3F5+wqcGnDzZKaCTTslbC+jo9KhNILFELf6gNx
        Gg70HOrqpbymhOEhxXevyO2407LpuG7szKBbA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=TPUU9HB7+uyb5sLbyTxQQmn/Rfn6EbzI
        O5GD9RwmfJFKYlg+2x5QVds+Pc1Z99GdorBIidIvwZ9jKby2VjIJOBaD+7sq5Pex
        CdCaGN/Vz3btY7WA/K+W3hdHQS/msmcMmvs5MSv41x3VT+/F4MlSG/DycEMpz7tG
        9zfyH1k1wE0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 73ECC75775;
        Fri, 24 Mar 2017 14:04:29 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C8E8075773;
        Fri, 24 Mar 2017 14:04:28 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Santiago Torres <santiago@nyu.edu>, git@vger.kernel.org,
        Jan Palus <jan.palus@gmail.com>
Subject: Re: [PATCH 3/3] t7004, t7030: fix here-doc syntax errors
References: <20170322211003.b52cql3iwig2xqcd@sigill.intra.peff.net>
        <xmqq8tnxhssv.fsf@gitster.mtv.corp.google.com>
        <20170322221556.j7uj4vvgbcubcr3b@LykOS.localdomain>
        <20170322222230.yqqv6x4gokvb4jbz@sigill.intra.peff.net>
        <20170322223441.w32y464jqbnxnzna@LykOS.localdomain>
        <20170322224124.u3eax4ui3y4saxks@sigill.intra.peff.net>
        <20170322225108.wub4bmr63hk2sp33@LykOS.localdomain>
        <xmqqfui3ac2f.fsf@gitster.mtv.corp.google.com>
        <20170323234922.ot2vqblcnljacdtn@sigill.intra.peff.net>
        <xmqqlgru8vyt.fsf@gitster.mtv.corp.google.com>
        <20170324164943.7vvtcj5sqadj625o@sigill.intra.peff.net>
Date:   Fri, 24 Mar 2017 11:04:27 -0700
In-Reply-To: <20170324164943.7vvtcj5sqadj625o@sigill.intra.peff.net> (Jeff
        King's message of "Fri, 24 Mar 2017 12:49:43 -0400")
Message-ID: <xmqqvaqy7dqs.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 52DF9BC2-10BC-11E7-B4BC-FC50AE2156B6-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> It seems like t7030 should just skip_all when the GPG prereq is not
> met (it's not wrong to mark each test that's added, but it would have
> made this particular mistake harder).

I'd leave that to be done by others after the dust settles ;-).  

Here is what I have right now (proposed log message has updates to
match rather obvious changes to the tests).

-- >8 --
From: Santiago Torres <santiago@nyu.edu>
Date: Thu, 23 Mar 2017 18:28:47 -0400
Subject: [PATCH] t7004, t7030: fix here-doc syntax errors

Jan Palus noticed that some here-doc are spelled incorrectly,
resulting the entire remainder of the test snippet being slurped
into the "expect" file as if it were data, e.g. in this sequence

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
pass verification are omitted from the output.  Another breakage that
is uncovered is that these tests must be restricted to environment
where gpg is available.

Arguably, that is a safer behaviour, and because the format
specifiers like %(tag) do not have a way to show if the signature
verifies correctly, the command with the --format option cannot be
used to get a list of tags annotated with their signature validity
anyway.

For now, let's fix the here-doc syntax, update the expectation to
match the reality, and update the test prerequisite.

Maybe later when we extend the --format language available to "git
tag -v" and "git verify-tag" to include things like "%(gpg:status)",
we may want to change the behaviour so that piping a list of tag
names into

    xargs git verify-tag --format='%(gpg:status) %(tag)'

becomes a good way to produce such a list, but that is a separate
topic.

Noticed-by: Jan Palus <jan.palus@gmail.com>
Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Santiago Torres <santiago@nyu.edu>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t7004-tag.sh        | 12 +++++-------
 t/t7030-verify-tag.sh | 12 +++++-------
 2 files changed, 10 insertions(+), 14 deletions(-)

diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
index b53a2e5e41..f67bbb8abc 100755
--- a/t/t7004-tag.sh
+++ b/t/t7004-tag.sh
@@ -847,18 +847,16 @@ test_expect_success GPG 'verifying a forged tag should fail' '
 	test_must_fail git tag -v forged-tag
 '
 
-test_expect_success 'verifying a proper tag with --format pass and format accordingly' '
-	cat >expect <<-\EOF
+test_expect_success GPG 'verifying a proper tag with --format pass and format accordingly' '
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
+test_expect_success GPG 'verifying a forged tag with --format should fail silently' '
+	>expect &&
 	test_must_fail git tag -v --format="tagname : %(tag)" "forged-tag" >actual &&
 	test_cmp expect actual
 '
diff --git a/t/t7030-verify-tag.sh b/t/t7030-verify-tag.sh
index d62ccbb98e..b4b49eeb08 100755
--- a/t/t7030-verify-tag.sh
+++ b/t/t7030-verify-tag.sh
@@ -125,18 +125,16 @@ test_expect_success GPG 'verify multiple tags' '
 	test_cmp expect.stderr actual.stderr
 '
 
-test_expect_success 'verifying tag with --format' '
-	cat >expect <<-\EOF
+test_expect_success GPG 'verifying tag with --format' '
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
+test_expect_success GPG 'verifying a forged tag with --format should fail silently' '
+	>expect &&
 	test_must_fail git verify-tag --format="tagname : %(tag)" $(cat forged1.tag) >actual-forged &&
 	test_cmp expect actual-forged
 '
-- 
2.12.1-432-gf364f02724

