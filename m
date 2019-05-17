Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DB1CD1F461
	for <e@80x24.org>; Fri, 17 May 2019 05:12:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727777AbfEQFMi (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 May 2019 01:12:38 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50202 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727089AbfEQFMi (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 May 2019 01:12:38 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 16D7B157AB1;
        Fri, 17 May 2019 01:12:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=2joDsks3hQnse4n3DKKRCllu124=; b=P0Rb0H
        DPiEzfWGxUO4Iiu9lt5AyZA7x22g+m5v4TGj50mPwRhPf0G17d2ECskMSUk1uq9b
        YdmTS8s0/W+SQFJ+9Twzy3eEmYWbpSUqbaG6kDmtT0GcmgDBJU5BAKzWuRVkHDjt
        VhG31UFunlznHdo3ncWL3HDCwkMkxwdhVuvis=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=x14VsHLp0XiTbtWy+/HQxo1ZF2Pf3J0r
        x7NELHK/eOlRpSL70PV8M6/zhzdOZioO5Fi3ziXUZ11ec1aHNL9RmJE1I9dqAOxK
        YHE6XAQaFyG9QZE85TJBTsPhBGyY7Q8D6KZzabAJmugaW7XYGJKyQsDjzG+dvetG
        NsoAgYvQCpQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0E3C7157AB0;
        Fri, 17 May 2019 01:12:36 -0400 (EDT)
Received: from pobox.com (unknown [34.76.255.141])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6E15D157AAF;
        Fri, 17 May 2019 01:12:35 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Barret Rhoden <brho@google.com>
Cc:     git@vger.kernel.org, Michael Platings <michael@platin.gs>,
        =?utf-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, David Kastrup <dak@gnu.org>,
        Jeff King <peff@peff.net>, Jeff Smith <whydoubt@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?utf-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        Stefan Beller <stefanbeller@gmail.com>
Subject: Re: [PATCH v7 7/8 (edit)] blame: add a fingerprint heuristic to match ignored lines
References: <20190515214503.77162-8-brho@google.com>
        <20190516215713.100523-1-brho@google.com>
Date:   Fri, 17 May 2019 14:12:34 +0900
In-Reply-To: <20190516215713.100523-1-brho@google.com> (Barret Rhoden's
        message of "Thu, 16 May 2019 17:57:13 -0400")
Message-ID: <xmqqftpd3br1.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 61D02E98-7862-11E9-B7DA-46F8B7964D18-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Barret Rhoden <brho@google.com> writes:

> From: Michael Platings <michael@platin.gs>
>
> ...
> Michael removed the bashisms from the tests.

Will replace what's queued.

Note that I have two extra SQUASH??? patches on top of the branch to
make 'pu' build and test, which you may want to take a look at.

Thanks.




From 82e68b47261ae57e7b368b9eed3450dbbf76e3c1 Mon Sep 17 00:00:00 2001
From: Junio C Hamano <gitster@pobox.com>
Date: Thu, 16 May 2019 12:43:27 +0900
Subject: [PATCH 1/2] SQUASH??? error: decl-after-stmt

---
 blame.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/blame.c b/blame.c
index d55e458770..287841364b 100644
--- a/blame.c
+++ b/blame.c
@@ -925,9 +925,6 @@ static int *fuzzy_find_matching_lines(struct blame_origin *parent,
 	struct fingerprint *fingerprints_a = parent->fingerprints;
 	struct fingerprint *fingerprints_b = target->fingerprints;
 
-	if (length_a <= 0)
-		return NULL;
-
 	int i, *result, *second_best_result,
 		*certainties, *similarities, similarity_count;
 
@@ -943,6 +940,9 @@ static int *fuzzy_find_matching_lines(struct blame_origin *parent,
 	 */
 	int max_search_distance_a = 10, max_search_distance_b;
 
+	if (length_a <= 0)
+		return NULL;
+
 	if (max_search_distance_a >= length_a)
 		max_search_distance_a = length_a ? length_a - 1 : 0;
 
-- 
2.22.0-rc0


From 634f3cecaaba9174e81629f8df5942c261e8310b Mon Sep 17 00:00:00 2001
From: Junio C Hamano <gitster@pobox.com>
Date: Fri, 17 May 2019 13:45:42 +0900
Subject: [PATCH 2/2] SQUASH??? test-lint -- seq not portable

---
 t/t8014-blame-ignore-fuzzy.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/t/t8014-blame-ignore-fuzzy.sh b/t/t8014-blame-ignore-fuzzy.sh
index bbf70b0f56..1ff59624e9 100755
--- a/t/t8014-blame-ignore-fuzzy.sh
+++ b/t/t8014-blame-ignore-fuzzy.sh
@@ -298,7 +298,7 @@ EOF
 last_test=13
 
 test_expect_success setup '
-	{ for i in $(seq 2 $last_test)
+	{ for i in $(test_seq 2 $last_test)
 	do
 		# Append each line in a separate commit to make it easy to
 		# check which original line the blame output relates to.
@@ -314,7 +314,7 @@ test_expect_success setup '
 		done } <"a$i"
 	done } &&
 
-	{ for i in $(seq 2 $last_test)
+	{ for i in $(test_seq 2 $last_test)
 	do
 		# Overwrite the files with the final content.
 		cp b$i $i &&
@@ -329,7 +329,7 @@ test_expect_success setup '
 	IGNOREME=$(git rev-parse HEAD)
 '
 
-for i in $(seq 2 $last_test); do
+for i in $(test_seq 2 $last_test); do
 	eval title="\$title$i"
 	test_expect_success "$title" \
 	"git blame -M9 --ignore-rev $IGNOREME $i | sed -e \"$pick_author\" >actual && test_cmp expected$i actual"
-- 
2.22.0-rc0

