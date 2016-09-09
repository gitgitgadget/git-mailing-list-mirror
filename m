Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 22B8920705
	for <e@80x24.org>; Fri,  9 Sep 2016 19:42:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753324AbcIITmB (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Sep 2016 15:42:01 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56514 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753226AbcIITmA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Sep 2016 15:42:00 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0B9FD3CE9E;
        Fri,  9 Sep 2016 15:41:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=o3EtdsgAVXufxQsp80epbt4DMJ0=; b=LNJGqN
        4DvB53oQ2lp3CrG+jQPl3od86Nf+41OMPdvCKpme1BJrmbLya7g7aMU6W5t7DlF5
        tN9ydUce2DrRPl9rgyrmul7WGjKCf3RSbTL3wD5sCeIqRXT9Cs5M5MWhPCyW5Ufd
        8iYckXa9k6zJida9CUsfsnQ7zna69Yx1WPRuc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=cNDEPz3oXol7nXMVP7FKTh7Nn3/lydWy
        tebAN9CDmTw4muKZqQUXe6NndfIV3wApvtUuogTYgqrlE+dCdE8bnK1UAu/WZZst
        4X7jIOZcNPfv7c5nqiJP/Cy6oo1Mol4MZcVXRhHpwicg9sX8TyjZx/1w3ZDnVstD
        jzmMiuADinI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 03F153CE9D;
        Fri,  9 Sep 2016 15:41:59 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 6D8243CE9C;
        Fri,  9 Sep 2016 15:41:58 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Josh Triplett <josh@joshtriplett.org>, Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] Move format-patch base commit and prerequisites before email signature
References: <20160908011200.qzvbdt4wjwiji4h5@x>
        <xmqqshtags0o.fsf@gitster.mtv.corp.google.com>
        <20160908185408.5qtfnztjbastlrtw@x>
        <20160908200819.pkg7jqcvxjpdqr3a@sigill.intra.peff.net>
        <xmqqd1kef5k5.fsf@gitster.mtv.corp.google.com>
Date:   Fri, 09 Sep 2016 12:41:56 -0700
In-Reply-To: <xmqqd1kef5k5.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Thu, 08 Sep 2016 14:24:42 -0700")
Message-ID: <xmqq7fakc12z.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 788E9F12-76C5-11E6-8786-51057B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Jeff King <peff@peff.net> writes:
>
>> On Thu, Sep 08, 2016 at 11:54:08AM -0700, Josh Triplett wrote:
>>
>>> > your problem description
>>> > looks perfect.  I am still not sure if the code does a reasonable
>>> > thing in MIME case, though.
>>> 
>>> It *looks* correct to me.
>> 
>> Hmm. It looks correct to me, too; ...
>> ...
>> So this is actually fixing a bug,...
>
> Yes, I actually wanted to hear that from Josh and have that in the
> proposed log message ;-).

So here is a suggested replacement.  I notice that in the MIME case,
we do not leave any blank line between the last line of the patch
and the baseinfo, which makes it look a bit strange, e.g. output of
"format-patch --attach=mimemime -1" may end like this:

    +       test_write_lines 1 2 >expect &&
    +       test_cmp expect actual
    +'
    +
     test_expect_success 'format-patch --pretty=mboxrd' '
            sp=" " &&
            cat >msg <<-INPUT_END &&
    base-commit: 6ebdac1bab966b720d776aa43ca188fe378b1f4b

    --------------mimemime--

We may want to tweak it a bit further.

-- >8 --
From: Josh Triplett <josh@joshtriplett.org>
Date: Wed, 7 Sep 2016 18:12:01 -0700
Subject: [PATCH] format-patch: show base info before email signature

Any text below the "-- " for the email signature gets treated as part of
the signature, and many mail clients will trim it from the quoted text
for a reply.  Move it above the signature, so people can reply to it
more easily.

Similarly, when producing the patch as a MIME attachment, the
original code placed the base info after the attached part, which
would be discarded.  Move the base info to the end of the part,
still inside the part boundary.

Add tests for the exact format of the email signature, and add tests
to ensure that the base info appears before the email signature when
producing a plain-text output, and that it appears before the part
boundary when producing a MIME attachment.

Signed-off-by: Josh Triplett <josh@joshtriplett.org>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/log.c           |  4 ++--
 t/t4014-format-patch.sh | 30 +++++++++++++++++++++++++-----
 2 files changed, 27 insertions(+), 7 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index 92dc34d..d69d5e6 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1042,7 +1042,6 @@ static void make_cover_letter(struct rev_info *rev, int use_stdout,
 	diff_flush(&opts);
 
 	fprintf(rev->diffopt.file, "\n");
-	print_signature(rev->diffopt.file);
 }
 
 static const char *clean_message_id(const char *msg_id)
@@ -1720,6 +1719,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 		make_cover_letter(&rev, use_stdout,
 				  origin, nr, list, branch_name, quiet);
 		print_bases(&bases, rev.diffopt.file);
+		print_signature(rev.diffopt.file);
 		total++;
 		start_number--;
 	}
@@ -1779,13 +1779,13 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 		if (!use_stdout)
 			rev.shown_one = 0;
 		if (shown) {
+			print_bases(&bases, rev.diffopt.file);
 			if (rev.mime_boundary)
 				fprintf(rev.diffopt.file, "\n--%s%s--\n\n\n",
 				       mime_boundary_leader,
 				       rev.mime_boundary);
 			else
 				print_signature(rev.diffopt.file);
-			print_bases(&bases, rev.diffopt.file);
 		}
 		if (!use_stdout)
 			fclose(rev.diffopt.file);
diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index b0579dd..535857e 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -754,9 +754,22 @@ test_expect_success 'format-patch --ignore-if-in-upstream HEAD' '
 	git format-patch --ignore-if-in-upstream HEAD
 '
 
+git_version="$(git --version | sed "s/.* //")"
+
+signature() {
+	printf "%s\n%s\n\n" "-- " "${1:-$git_version}"
+}
+
+test_expect_success 'format-patch default signature' '
+	git format-patch --stdout -1 | tail -n 3 >output &&
+	signature >expect &&
+	test_cmp expect output
+'
+
 test_expect_success 'format-patch --signature' '
-	git format-patch --stdout --signature="my sig" -1 >output &&
-	grep "my sig" output
+	git format-patch --stdout --signature="my sig" -1 | tail -n 3 >output &&
+	signature "my sig" >expect &&
+	test_cmp expect output
 '
 
 test_expect_success 'format-patch with format.signature config' '
@@ -1502,12 +1515,11 @@ test_expect_success 'format-patch -o overrides format.outputDirectory' '
 
 test_expect_success 'format-patch --base' '
 	git checkout side &&
-	git format-patch --stdout --base=HEAD~3 -1 >patch &&
-	grep "^base-commit:" patch >actual &&
-	grep "^prerequisite-patch-id:" patch >>actual &&
+	git format-patch --stdout --base=HEAD~3 -1 | tail -n 6 >actual &&
 	echo "base-commit: $(git rev-parse HEAD~3)" >expected &&
 	echo "prerequisite-patch-id: $(git show --patch HEAD~2 | git patch-id --stable | awk "{print \$1}")" >>expected &&
 	echo "prerequisite-patch-id: $(git show --patch HEAD~1 | git patch-id --stable | awk "{print \$1}")" >>expected &&
+	signature >> expected &&
 	test_cmp expected actual
 '
 
@@ -1605,6 +1617,14 @@ test_expect_success 'format-patch --base overrides format.useAutoBase' '
 	test_cmp expected actual
 '
 
+test_expect_success 'format-patch --base with --attach' '
+	git format-patch --attach=mimemime --stdout --base=HEAD~ -1 >patch &&
+	sed -n -e "/^base-commit:/s/.*/1/p" -e "/^---*mimemime--$/s/.*/2/p" \
+		patch >actual &&
+	test_write_lines 1 2 >expect &&
+	test_cmp expect actual
+'
+
 test_expect_success 'format-patch --pretty=mboxrd' '
 	sp=" " &&
 	cat >msg <<-INPUT_END &&
-- 
2.10.0-339-gc0c747f

