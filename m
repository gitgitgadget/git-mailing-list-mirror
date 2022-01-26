Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DDBDC433EF
	for <git@archiver.kernel.org>; Wed, 26 Jan 2022 23:42:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229491AbiAZXmS (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Jan 2022 18:42:18 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62295 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbiAZXmQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Jan 2022 18:42:16 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E9E7F11EE51;
        Wed, 26 Jan 2022 18:42:15 -0500 (EST)
        (envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; s=sasl; bh=io24vVoyOqLZuFV9ulHMwZtoW
        GMP+7V02GnXweli/MM=; b=Xr4PsRq4UCH9N+18jUI3kPf6p+lhcwbCr6jeRBM3m
        7u5k24bpCB6AKwGgv9ec0e/ElJ3f293f8QJYnj0yZ0I/3rgjySGdrvGyhxe60yTJ
        W/5yTsI9p99sMiXNdc+wfkkO1XcHb0ZjqWin3JkYhsjBJyi+OWbFNjafyYbesUA0
        N0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E294011EE50;
        Wed, 26 Jan 2022 18:42:15 -0500 (EST)
        (envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4939B11EE4F;
        Wed, 26 Jan 2022 18:42:15 -0500 (EST)
        (envelope-from gitster@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [PATCH v2 3/3] SubmittingPatches: explain why we care about log messages
Date:   Wed, 26 Jan 2022 15:42:05 -0800
Message-Id: <20220126234205.2923388-4-gitster@pobox.com>
X-Mailer: git-send-email 2.35.0-168-gb86c5231e1
In-Reply-To: <20220126234205.2923388-1-gitster@pobox.com>
References: <xmqqilua89z5.fsf@gitster.g>
 <20220126234205.2923388-1-gitster@pobox.com>
MIME-Version: 1.0
X-Pobox-Relay-ID: 97631D42-7F01-11EC-B442-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Extend the "describe your changes well" section to cover whom we are
trying to help by doing so in the first place.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/SubmittingPatches | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPa=
tches
index 7225a0fb52..9c5977fac3 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -110,6 +110,34 @@ run `git diff --check` on your changes before you co=
mmit.
 [[describe-changes]]
 =3D=3D=3D Describe your changes well.
=20
+The log message that explains your changes is as much important as the
+changes themselves.  Your code may be clearly written with in-code
+comment to sufficiently explain how it works with the surrounding
+code, but those who need to fix or enhance your code in the future
+will need to know _why_ your code does what it does, for a few reasons:
+
+. Your code may be doing something differently from what you wanted it
+  to do.  Writing down what you actually wanted to achieve will help
+  them fix your code and make it do what it should have been doing
+  (also, you often discover your own bug while writing your log
+  message yourself).
+
+. Your code may be doing things that were only necessary for your
+  immediate needs (e.g. "do X to directories" without implementing or
+  even designing what is to be done on files).  Writing down why you
+  excluded what the code does not do will help guide future developers
+  (e.g. writing down "we do X to directories, because directories have
+  characteristic Y" would help them infer "oh, files also have the
+  same characteristic Y, so perhaps doing X to them would also make
+  sense?".  Or "we don't do the same X to files, because ..." will
+  help them decide if the reasoning is sound (in which case they do
+  not waste time extending your code to cover files), or reason
+  differently (in which case they explain why they extend your code to
+  cover files, too).
+
+The goal of your log message is to convey the _why_ behind your
+change to help them.
+
 The first line of the commit message should be a short description (50
 characters is the soft limit, see DISCUSSION in linkgit:git-commit[1]),
 and should skip the full stop.  It is also conventional in most cases to
--=20
2.35.0-155-g0eb5153edc

