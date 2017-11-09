Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A90691F43C
	for <e@80x24.org>; Thu,  9 Nov 2017 02:49:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752095AbdKICtt (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Nov 2017 21:49:49 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50002 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752023AbdKICts (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Nov 2017 21:49:48 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 70E199EBFD;
        Wed,  8 Nov 2017 21:49:47 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=H64xUfeSKDLOQxK9CApQOiqA+Xg=; b=B+er8Q
        BTtk5TEfbi07+EYjwkGJIrI3htZZADVAeqrRmg9TJRYKoSMtU+CHdRTuA0HU8r0v
        dN2VPgGFVwmFelXteIPAAcagdpT1gJR93IevtFAKJOwKj/NODdYw8IpnjicbSChz
        5PQa+fSUWshg+3J5P1d+5ZJvHvTuqydJev/ys=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=BL3OJTewgvkk8GPqwrmVOFxHn8EqUptY
        xXrF5VLVOmo6bEIzLH6fAgc90sItrcWfz8/oz25hJb7ot3t5OqHfblHDnIP/+a85
        YS+rvij6PDRGbXSnQaudyZndKwGq2g1bjBcsBt9lAVYOn3RQiuCm2frsjF+P76zr
        le/oWujPADc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 684369EBFC;
        Wed,  8 Nov 2017 21:49:47 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C847B9EBFB;
        Wed,  8 Nov 2017 21:49:46 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Michael J Gruber <git@grubix.eu>
Cc:     Ekelhart Jakob <jakob.ekelhart@fsw.at>,
        "git\@vger.kernel.org" <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Matthias Lischka <matthias.lischka@fsw.at>
Subject: Re: [PATCH 2/3] merge-base: return fork-point outside reflog
References: <68633b20-9e2b-ae23-2ede-8728283250f0@grubix.eu>
        <cover.1505394278.git.git@grubix.eu>
        <5513a1415d11517c28158d9b4212d383a233182f.1505394278.git.git@grubix.eu>
        <xmqq60ckzng7.fsf@gitster.mtv.corp.google.com>
        <cd97bb1b-13f3-0856-a250-8f4921b9f6d8@grubix.eu>
        <xmqqshfnx1kl.fsf@gitster.mtv.corp.google.com>
        <xmqqshfgk1mr.fsf@gitster.mtv.corp.google.com>
        <5a2fca1d-4edf-965f-4840-58c924c91051@grubix.eu>
        <xmqqzi9nlcyw.fsf@gitster.mtv.corp.google.com>
        <4a14c35c-88b0-7bc3-0a6e-c69ed9ec7ee7@grubix.eu>
        <xmqqa81njds0.fsf@gitster.mtv.corp.google.com>
        <xmqq7ewckbpk.fsf@gitster.mtv.corp.google.com>
        <b9c2c978a6d3407c8c26509fc82b3920@SFSWW2K12EX02.intern.fsw.at>
        <1a375938-a3dc-d670-dd41-de524ac0f93d@grubix.eu>
Date:   Thu, 09 Nov 2017 11:49:45 +0900
In-Reply-To: <1a375938-a3dc-d670-dd41-de524ac0f93d@grubix.eu> (Michael
        J. Gruber's message of "Wed, 8 Nov 2017 10:33:41 +0100")
Message-ID: <xmqq375okvxy.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A5B4723C-C4F8-11E7-982C-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Michael J Gruber <git@grubix.eu> writes:

> It seems the consensus was that current functionality is as designed but
> not necessarily as expected, and another mode "--fork-base" (that does
> what I suggested as "fix") would meet these expectations. I would reuse
> the documentation of the current mode as a description of the new mode
> and add documentation for the existing mode ;)

If we are going to have two modes, it would be absolutely necessary
to explain in the documentation what they compute exactly in terms
that the end users understand, so that the users can choose which
one to use.

The current documentation is not that great because it can get away
with "we automatically by magic find the commit on top of which you
forked your branch", but when we have two different kinds of magic,
that would no longer be a useful description to help users to
choose.  We probably need to enhance the description in "Discussion
on fork-point mode" as a preliminary clean-up.  The attached is my
attempt.

I'd expect `--fork-base` to be explained in a similar way and to the
level of detail to help users pick which one of the three options
(i.e. without any option, with fork-point and with the new one) is
appropriate for their situation.  I've been thinking about what your
patch does, and I cannot come up with a reasonable way to explain
what it computes in the terms the users can get their heads around,
with history illustrations.

--- >8 ---
Subject: merge-base --fork-point doc: clarify the example and failure modes

The illustrated history used to explain the `--fork-point` mode
named three keypoint commits B3, B2 and B1 from the oldest to the
newest, which was hard to read.  Relabel them to B0, B1, B2.  Also
illustrate the history after the rebase using the `--fork-point`
facility was made.

The text already mentions use of reflog, but the description is not
clear what benefit we are trying to gain by using reflog.  Clarify
that it is to find the commits that were known to be at the tip of
the remote-tracking branch.  This in turn necessitates users to know
the ramifications of the underlying assumptions, namely, expiry of
reflog entries will make it impossible to determine which commits
were at the tip of the remote-tracking branches and we fail when in
doubt (instead of giving a random and incorrect result without even
warning).  Another limitation is that it won't be useful if you did
not fork from the tip of a remote-tracking branch but from in the
middle.

Describe them.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git-merge-base.txt | 64 +++++++++++++++++++++++++++++++++++-----
 1 file changed, 56 insertions(+), 8 deletions(-)

diff --git a/Documentation/git-merge-base.txt b/Documentation/git-merge-base.txt
index b968b64c38..a4859c8597 100644
--- a/Documentation/git-merge-base.txt
+++ b/Documentation/git-merge-base.txt
@@ -154,23 +154,71 @@ topic origin/master`, the history of remote-tracking branch
 `origin/master` may have been rewound and rebuilt, leading to a
 history of this shape:
 
-	                 o---B1
+	                 o---B2
 	                /
-	---o---o---B2--o---o---o---B (origin/master)
+	---o---o---B1--o---o---o---B (origin/master)
 	        \
-	         B3
+	         B0
 	          \
-	           Derived (topic)
+	           D0---D1---D (topic)
 
-where `origin/master` used to point at commits B3, B2, B1 and now it
+where `origin/master` used to point at commits B0, B1, B2 and now it
 points at B, and your `topic` branch was started on top of it back
-when `origin/master` was at B3. This mode uses the reflog of
-`origin/master` to find B3 as the fork point, so that the `topic`
-can be rebased on top of the updated `origin/master` by:
+when `origin/master` was at B0, and you built three commits, D0, D1,
+and D, on top of it.  Imagine that you now want to rebase the work
+you did on the topic on top of the updated origin/master.
+
+In such a case, `git merge-base origin/master topic` would return the
+parent of B0 in the above picture, but B0^..D is *not* the range of
+commits you would want to replay on top of B (it includes B0, which
+is not what you wrote; it is a commit the other side discarded when
+it moved its tip from B0 to B1).  
+
+`git merge-base --fork-point origin/master topic` is designed to
+help in such a case.  It takes not only B but also B0, B1, and B2
+(i.e. old tips of the remote-tracking branches your repository's
+reflog knows about) into account to see on which commit your topic
+branch was built and finds B0, allowing you to replay only the
+commits on your topic, excluding the commits the other side later
+discarded.
+
+Hence
 
     $ fork_point=$(git merge-base --fork-point origin/master topic)
+
+will find B0, and
+
     $ git rebase --onto origin/master $fork_point topic
 
+will replay D0, D1 and D on top of B to create a new history of this
+shape:
+
+                         o---B2
+                        /
+        ---o---o---B1--o---o---o---B (origin/master)
+                \                   \
+                 B0                  D0'--D1'--D' (topic - updated)
+                  \
+                   D0---D1---D (topic - old)
+
+A caveat is that older reflog entries in your repository may be
+expired by `git gc`.  If B0 no longer appears in the reflog of the
+remote-tracking branch `origin/master`, the `--fork-point` mode
+obviously cannot find it and fails, avoiding to give a random and
+useless result (such as the parent of B0, like the same command
+without the `--fork-point` option gives).  
+
+Also, the remote-tracking branch you use the `--fork-point` mode
+with must be the one your topic forked from its tip.  If you forked
+from an older commit than the tip, this mode would not find the fork
+point (imagine in the above sample history B0 did not exist,
+origin/master started at B1, moved to B2 and then B, and you forked
+your topic at origin/master^ when origin/master was B1; the shape of
+the history would be the same as above, without B0, and the parent
+of B1 is what `git merge-base origin/master topic` correctly finds,
+but the `--fork-point` mode will not, because it is not one of the
+commits that used to be at the tip of origin/master).
+
 
 See also
 --------
