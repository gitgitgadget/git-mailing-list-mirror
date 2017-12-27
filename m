Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 98AD41F404
	for <e@80x24.org>; Wed, 27 Dec 2017 18:27:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752004AbdL0S1w (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Dec 2017 13:27:52 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51208 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751184AbdL0S1v (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Dec 2017 13:27:51 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1EE01B6A09;
        Wed, 27 Dec 2017 13:27:51 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=SxOF0tFHR/GcDk6BjSKqZS/Kg0M=; b=kkGknb
        yoyjtgwx3VA1jmuPW/H0M17T4aFQzotn+TVX8ilpmLLCarF+yNu4pNp48PlKaUiz
        LKfWftmBgu+rHgMBrg95f7PM8uxC0fz9EBTTETlnOUeOOltka9ORkP975XgJ4wde
        GwlJglU3oNB9PDPUgPtgAJWpoTNZTo0fGmjfw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Cnreyk79mdP+916u4e2eG3xRdFdRAlCw
        UZRSSGsf4vBsbxSBTnnStDCHTZGufz1VMd45VtvsFV+iZWWVSgmhmOsIi3YbuMtJ
        5NYz092JJhzjYQu8Bins9CZ/Ljj/buYjoGikYvYPgscwJMxy34UwtEh3cgHeVdGy
        tQabMq5al3U=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 15FDCB6A08;
        Wed, 27 Dec 2017 13:27:51 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 8467FB6A07;
        Wed, 27 Dec 2017 13:27:50 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Daniel Knittl-Frank <knittl89@googlemail.com>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [RFC] Prepend "tags/" when describing tags with embedded name
References: <CACx-yZ3VAaPQ4dU40_JFm_=WGH5ZX-28bXKqGqVnj39-6_9duw@mail.gmail.com>
Date:   Wed, 27 Dec 2017 10:27:49 -0800
In-Reply-To: <CACx-yZ3VAaPQ4dU40_JFm_=WGH5ZX-28bXKqGqVnj39-6_9duw@mail.gmail.com>
        (Daniel Knittl-Frank's message of "Sat, 23 Dec 2017 15:17:30 +0100")
Message-ID: <xmqq8tdonhzu.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A5339AE8-EB33-11E7-BD22-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Daniel Knittl-Frank <knittl89@googlemail.com> writes:

> On Fri, Dec 15, 2017 at 8:25 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> I think the code makes sense, but it won't be understandable by
>> those who do not know what you discussed in the original thread.
>>
>> A proper commit log message, with a new test or two in t6120, would
>> be an appropriate way to fix that.
>>
>> Care to follow through, along the lines in
>> Documentation/SubmittingPatches?
>
> The updated branch including tests can be found at:
> http://repo.or.cz/git/dkf.git/shortlog/refs/heads/bugfix/describe-all
>
> One existing test in t6210 needed updating to match the new behavior,
> three new tests have been added: annotated tags, lightweight tags, and
> branches.
>
> Daniel

Thanks.  Looks excellent.  

The second paragraph, while it did not say anything incorrect, felt
a bit too indirect to point out that the commit it refers introduced
the regression this is fixing, so I updated the description a bit,
like below.

-- >8 --
From: Daniel Knittl-Frank <knittl89+git@googlemail.com>
Date: Mon, 11 Dec 2017 18:24:54 +0100
Subject: [PATCH] describe: prepend "tags/" when describing tags with embedded name

The man page of the "git describe" command explains the expected
output when using the --all option, i.e. the full reference path is
shown, including heads/ or tags/ prefix.

When 212945d4a85dfa172ea55ec73b1d830ef2d8582f ("Teach git-describe
to verify annotated tag names before output") made Git favor the
embedded name of annotated tags, it accidentally changed the output
format when the --all flag is given, only printing the tag's name
without the prefix.

Check if --all was specified and re-add the "tags/" prefix for this
special case to fix the regresssion.

Signed-off-by: Daniel Knittl-Frank <knittl89+git@googlemail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/describe.c  | 7 +++++--
 t/t6120-describe.sh | 6 +++++-
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/builtin/describe.c b/builtin/describe.c
index 29075dbd0f..2004a1a86e 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -271,10 +271,13 @@ static void display_name(struct commit_name *n)
 		n->name_checked = 1;
 	}
 
-	if (n->tag)
+	if (n->tag) {
+		if (all)
+			printf("tags/");
 		printf("%s", n->tag->tag);
-	else
+	} else {
 		printf("%s", n->path);
+	}
 }
 
 static void show_suffix(int depth, const struct object_id *oid)
diff --git a/t/t6120-describe.sh b/t/t6120-describe.sh
index 1c0e8659d9..15612b3bbe 100755
--- a/t/t6120-describe.sh
+++ b/t/t6120-describe.sh
@@ -122,7 +122,7 @@ test_expect_success 'describe --contains defaults to HEAD without commit-ish' '
 '
 
 : >err.expect
-check_describe A --all A^0
+check_describe tags/A --all A^0
 test_expect_success 'no warning was displayed for A' '
 	test_cmp err.expect err.actual
 '
@@ -340,4 +340,8 @@ test_expect_success ULIMIT_STACK_SIZE 'describe works in a deep repo' '
 	test_cmp expect actual
 '
 
+check_describe tags/A --all A
+check_describe tags/c --all c
+check_describe heads/branch_A --all --match='branch_*' branch_A
+
 test_done
-- 
2.15.1-597-g62d91a8972

