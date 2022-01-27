Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E418C433FE
	for <git@archiver.kernel.org>; Thu, 27 Jan 2022 19:03:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245386AbiA0TDN (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Jan 2022 14:03:13 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50820 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245331AbiA0TDL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Jan 2022 14:03:11 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5443910BD09;
        Thu, 27 Jan 2022 14:03:10 -0500 (EST)
        (envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; s=sasl; bh=81dVhbOgla9BESkChBjhh9Kyj
        dB3YGY/BnYVObaBUrE=; b=CgT7eE2qeQL6VHWQJiTWnfxU/0fMyE5IyT4B6VjLW
        cPEqmcYw9k1qJXuV8nQLdlPChvI4kTHUHVJpB9jrdNEep31/V+D5ENEznIx7aV4z
        wqLLtPCESt4qChamlPqvw5BlYJocGgmm3OdcsO4qFqBNq6wPBkdoKksM9CvA2dkS
        ew=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4BFF210BD08;
        Thu, 27 Jan 2022 14:03:10 -0500 (EST)
        (envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 8FD8110BD07;
        Thu, 27 Jan 2022 14:03:09 -0500 (EST)
        (envelope-from gitster@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [PATCH v3 3/3] SubmittingPatches: explain why we care about log messages
Date:   Thu, 27 Jan 2022 11:02:59 -0800
Message-Id: <20220127190259.2470753-4-gitster@pobox.com>
X-Mailer: git-send-email 2.35.0-177-g7d269f5170
In-Reply-To: <20220126234205.2923388-1-gitster@pobox.com>
References: <20220126234205.2923388-1-gitster@pobox.com>
MIME-Version: 1.0
X-Pobox-Relay-ID: C493F4A6-7FA3-11EC-84C8-CB998F0A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Extend the "describe your changes well" section to cover whom we are
trying to help by doing so in the first place.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/SubmittingPatches | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPa=
tches
index 7225a0fb52..a6121d1d42 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -110,6 +110,35 @@ run `git diff --check` on your changes before you co=
mmit.
 [[describe-changes]]
 =3D=3D=3D Describe your changes well.
=20
+The log message that explains your changes is just as important as the
+changes themselves.  Your code may be clearly written with in-code
+comment to sufficiently explain how it works with the surrounding
+code, but those who need to fix or enhance your code in the future
+will need to know _why_ your code does what it does, for a few
+reasons:
+
+. Your code may be doing something differently from what you wanted it
+  to do.  Writing down what you actually wanted to achieve will help
+  them fix your code and make it do what it should have been doing
+  (also, you often discover your own bugs yourself, while writing the
+  log message to summarize the thought behind it).
+
+. Your code may be doing things that were only necessary for your
+  immediate needs (e.g. "do X to directories" without implementing or
+  even designing what is to be done on files).  Writing down why you
+  excluded what the code does not do will help guide future developers.
+  Writing down "we do X to directories, because directories have
+  characteristic Y" would help them infer "oh, files also have the same
+  characteristic Y, so perhaps doing X to them would also make sense?".
+  Saying "we don't do the same X to files, because ..." will help them
+  decide if the reasoning is sound (in which case they do not waste
+  time extending your code to cover files), or reason differently (in
+  which case, they can explain why they extend your code to cover
+  files, too).
+
+The goal of your log message is to convey the _why_ behind your
+change to help future developers.
+
 The first line of the commit message should be a short description (50
 characters is the soft limit, see DISCUSSION in linkgit:git-commit[1]),
 and should skip the full stop.  It is also conventional in most cases to
--=20
2.35.0-177-g7d269f5170

