Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FCD3C0015E
	for <git@archiver.kernel.org>; Wed, 19 Jul 2023 17:04:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230453AbjGSREQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Jul 2023 13:04:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230164AbjGSREO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Jul 2023 13:04:14 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FF3EB7
        for <git@vger.kernel.org>; Wed, 19 Jul 2023 10:04:13 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 184A21A310D;
        Wed, 19 Jul 2023 13:04:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=ovvbI13BdR8x
        gk79pSwXmadpywtwB6Euxukh7qWQOus=; b=pFREZ5h2whxFBwkkeLFVNo3o6q5o
        C63v88EiDOew43mEh/SYVhZQq2A3eYnagaiu/nHLry2Jm9cQ6PJFR5GiggUrE5Sd
        4E2cOkhGN5JMZcWhUT4IfhTayZ6Eo2VudaoXjjtP1p3C6n/kaJf0s+U9mgIaPHSH
        U7LucACxgERZt38=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 12A0C1A310C;
        Wed, 19 Jul 2023 13:04:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.168.215.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7A3651A310B;
        Wed, 19 Jul 2023 13:04:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Subject: [PATCH v3] MyFirstContribution: refrain from self-iterating too much
References: <xmqq3583uyk0.fsf@gitster.g>
        <20230122071156.367jwwt3d5txvkl4@tb-raspi4>
        <xmqqcz76tv6d.fsf@gitster.g> <xmqqzga9opdu.fsf@gitster.g>
        <20230123175804.2bkcr7yawyz5fhkb@tb-raspi4>
Date:   Wed, 19 Jul 2023 10:04:09 -0700
In-Reply-To: <20230123175804.2bkcr7yawyz5fhkb@tb-raspi4> ("Torsten
        =?utf-8?Q?B=C3=B6gershausen=22's?= message of "Mon, 23 Jan 2023 18:58:04
 +0100")
Message-ID: <xmqq8rbbbzp2.fsf_-_@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 4795E742-2656-11EE-AB0D-C65BE52EC81B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Finding mistakes in and improving your own patches is a good idea,
but doing so too quickly is being inconsiderate to reviewers who
have just seen the initial iteration and taking their time to review
it.  Encourage new developers to perform such a self review before
they send out their patches, not after.  After sending a patch that
they immediately found mistakes in, they are welcome to comment on
them, mentioning what and how they plan to improve them in an
updated version, before sending out their updates.

Helped-by: Torsten B=C3=B6gershausen <tboegi@web.de>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 * Sorry for a slow update.  Even though the topic is about not
   updating too quickly, this update was long overdue.  Not a whole
   lot changed.  Primary change is the later part of the proposed
   log message, which was helped by Torsten's comments, to which
   this message is a response to.

 Documentation/MyFirstContribution.txt | 31 +++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/Documentation/MyFirstContribution.txt b/Documentation/MyFirs=
tContribution.txt
index ccfd0cb5f3..1ede3f8e37 100644
--- a/Documentation/MyFirstContribution.txt
+++ b/Documentation/MyFirstContribution.txt
@@ -1256,6 +1256,37 @@ index 88f126184c..38da593a60 100644
 [[now-what]]
 =3D=3D My Patch Got Emailed - Now What?
=20
+After you sent out your first patch, you may find mistakes in it, or
+a different and better way to achieve the goal of the patch.  But
+please resist the temptation to send a new version immediately.
+
+ - If the mistakes you found are minor, send a reply to your patch as
+   if you were a reviewer and mention that you will fix them in an
+   updated version.
+
+ - On the other hand, if you think you want to change the course so
+   drastically that reviews on the initial patch would become
+   useless, send a reply to your patch to say so immediately to
+   avoid wasting others' time (e.g. "I am working on a better
+   approach, so please ignore this patch, and wait for the updated
+   version.")
+
+Then give reviewers enough time to process your initial patch before
+sending an updated version (unless you retracted the initial patch,
+that is).
+
+Now, the above is a good practice if you sent your initial patch
+prematurely without polish.  But a better approach of course is to
+avoid sending your patch prematurely in the first place.
+
+Keep in mind that people in the development community do not have to
+see your patch immediately after you wrote it.  Instead of seeing
+the initial version right now, that will be followed by several
+updated "oops, I like this version better than the previous one"
+versions over 2 days, reviewers would more appreciate if a single
+polished version came 2 days late and that version with fewer
+mistakes were the only one they need to review.
+
 [[reviewing]]
 =3D=3D=3D Responding to Reviews
=20
--=20
2.41.0-376-gcba07a324d

