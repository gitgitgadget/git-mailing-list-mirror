Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B91ABC433ED
	for <git@archiver.kernel.org>; Wed, 14 Apr 2021 23:51:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90F9C61179
	for <git@archiver.kernel.org>; Wed, 14 Apr 2021 23:51:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230115AbhDNXvl (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Apr 2021 19:51:41 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58196 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229950AbhDNXvl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Apr 2021 19:51:41 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 22B3BB91A0;
        Wed, 14 Apr 2021 19:51:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:mime-version:content-type; s=sasl; bh=I
        d7uh6vsz3lcFDmufxQtK44ikXc=; b=LHhwnDloQFslCky+vh40VL75OIQOMf5L6
        4ro4A0pMtyrUwdjGOed3mNoAqdM1W7flZVlWsC84Ulskv7i9ZKVxwpPWeXb2Ye4X
        qUDTIuqK9g+czggRSEqP4ZVFJuEoye3c5A7xTAY+NTw+9pJKD32uk1yPphLkaAO3
        Uhp8pHXqTY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
        :date:message-id:mime-version:content-type; q=dns; s=sasl; b=p2P
        5WF5JuNdRjqMiSJHXP81NxPsLRHHG4zQKfyglJtryEsxjTKN7sK/8+l7rTvwSIBg
        QeKGCfQRTaEeeoAcIxkxtynFpPlSmZc01aLaVFQpwNRI35Xlgpxx40O4XJf376hu
        eNn5ll+lK5vB3NfqljXyTrn1hl7E3kNOK6rZmIYM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0B502B919F;
        Wed, 14 Apr 2021 19:51:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 1AE26B919E;
        Wed, 14 Apr 2021 19:51:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [PATCH] doc: clarify "do not capitalize the first word" rule
Date:   Wed, 14 Apr 2021 16:51:17 -0700
Message-ID: <xmqq7dl4whl6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4E5EFA1A-9D7C-11EB-B9A3-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The same "do not capitalize the first word" rule is applied to both
our patch titles and error messages, but the existing description
was fuzzy in two aspects.

 * For error messages, it was not said that this was only about the
   first word that begins the sentence.

 * For both, it was not clear when a capital letter there was not an
   error.  We avoid capitalizing the first word when the only reason
   you would capitalize it is because it happens to be the first
   word in the sentence.  If a proper noun that is usually spelled
   in caps happens to come at the beginning of the sentence, that is
   not a reason to downcase it.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * I saw in the GGG inbox a well-intended patch that took the "do
   not capitalize" rule too far, but with documentation unclear, it
   was understandable, so here is to remedy the situation.

 Documentation/CodingGuidelines  |  7 ++++++-
 Documentation/SubmittingPatches | 11 +++++++----
 2 files changed, 13 insertions(+), 5 deletions(-)

diff --git c/Documentation/CodingGuidelines w/Documentation/CodingGuidelines
index 45465bc0c9..86d2afd6d2 100644
--- c/Documentation/CodingGuidelines
+++ w/Documentation/CodingGuidelines
@@ -498,7 +498,12 @@ Error Messages
 
  - Do not end error messages with a full stop.
 
- - Do not capitalize ("unable to open %s", not "Unable to open %s")
+ - Do not capitalize the first word, only because the word is the
+   first word in the message ("unable to open %s", not "Unable to open
+   %s", but "SHA-3 not supported" is fine, as the reason the first
+   word is capitalized is not because it is at the beginning of the
+   sentence, but because the word would be spelled with caps even when
+   it appeared in the middle of the sentence).
 
  - Say what the error is first ("cannot open %s", not "%s: cannot open")
 
diff --git c/Documentation/SubmittingPatches w/Documentation/SubmittingPatches
index 0452db2e67..aee56cf127 100644
--- c/Documentation/SubmittingPatches
+++ w/Documentation/SubmittingPatches
@@ -117,10 +117,13 @@ If in doubt which identifier to use, run `git log --no-merges` on the
 files you are modifying to see the current conventions.
 
 [[summary-section]]
-It's customary to start the remainder of the first line after "area: "
-with a lower-case letter. E.g. "doc: clarify...", not "doc:
-Clarify...", or "githooks.txt: improve...", not "githooks.txt:
-Improve...".
+The title sentence after the "area:" prefix omits the full stop at the
+end, and its first word is not capitalized unless there is a reason to
+capitalize it other than that it is the first word in the sentence.
+E.g. "doc: clarify...", not "doc: Clarify...", or "githooks.txt:
+improve...", not "githooks.txt: Improve...".  But "refs: HEAD is also
+treated as a ref" is correct, as we spell `HEAD` in all caps even when
+it appears in the middle of a sentence.
 
 [[meaningful-message]]
 The body should provide a meaningful commit message, which:
