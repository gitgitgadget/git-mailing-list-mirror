Return-Path: <SRS0=h2Q9=DZ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C857C433E7
	for <git@archiver.kernel.org>; Sun, 18 Oct 2020 19:49:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 00FFB22268
	for <git@archiver.kernel.org>; Sun, 18 Oct 2020 19:49:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="YyWxMunz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729976AbgJRTt1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 18 Oct 2020 15:49:27 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:58308 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387727AbgJRTtY (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 18 Oct 2020 15:49:24 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id D70C7E6764;
        Sun, 18 Oct 2020 15:49:21 -0400 (EDT)
        (envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; s=sasl; bh=5kLH8TxWMioB/NRRPh0FTtDxv
        Ik=; b=YyWxMunzdy+BKo+eoz7sziqTQL4olJ9BS1X20rE2sChsFmCRh9Lk3PNIf
        s+iYItAYDIAnmSAm6anVC8H4aYFhMP4IR1TxevQDyTT4a+xUbLtr2dOkoCKDCki1
        1UFAmGZtPy01WRgt+SokKJY5Q+MD3CChK7CvGAHjoe9Bp6rzM0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; q=dns; s=sasl; b=I984TB08O+S0JvCrsmN
        GHEaEXpy3KH4ExohL07XAtiJxjCXRuIajCVGiQHr+rwR+CKutCABoH2yOoTak15B
        4N/elREScyrkH1H6Vyb39g2a2Ps+lGULBHh5705yPS3/Xlu5Y6pe53nE/mrOFdGM
        ypfA0EMjUtmMTdD/GrCeXKMI=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id D0689E6761;
        Sun, 18 Oct 2020 15:49:21 -0400 (EDT)
        (envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 57D14E675F;
        Sun, 18 Oct 2020 15:49:18 -0400 (EDT)
        (envelope-from gitster@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     Philippe Blain <levraiphilippeblain@gmail.com>
Subject: [PATCH v2 1/3] doc: preparatory clean-up of description on the sign-off option
Date:   Sun, 18 Oct 2020 12:49:10 -0700
Message-Id: <20201018194912.2716372-2-gitster@pobox.com>
X-Mailer: git-send-email 2.29.0-rc2-130-g9dc1ca14f3
In-Reply-To: <20201018194912.2716372-1-gitster@pobox.com>
References: <20201018194912.2716372-1-gitster@pobox.com>
MIME-Version: 1.0
X-Pobox-Relay-ID: 0264B1E6-117B-11EB-8B01-D609E328BF65-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Almost identical text on the signed-off-by trailer appears in the
documentation for "git commit" and "git merge" and its friends.

Introduce a new signoff-options.txt file to be shared.  A couple
things of note are:

 - The short-form "-s" is available only in "git commit", but not in
   commands that are friends of "git merge", as it is used as a
   short-hand for "--strategy".

 - The original lacks description on the negated "--no-signoff" form
   on "git commit" side, but it equally is applicable.  It however
   was unclear in the original text that not adding a Signed-off-by
   trailer is the default, so rephrase to explain it as a way to
   countermand a --signoff option that appeared earlier on the same
   command line.

This is in preparation to apply a further clarification on what
exactly the Signed-off-by trailer means.

Suggested-by: Philippe Blain <levraiphilippeblain@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * It initially seemed that the update in [v2 2/3] didn't need too
   many iterations to complete, but it turned out that a preliminary
   clean-up would make it easier to iterate on the text after all.

 Documentation/git-commit.txt     | 10 ++--------
 Documentation/merge-options.txt  | 11 +----------
 Documentation/signoff-option.txt | 14 ++++++++++++++
 3 files changed, 17 insertions(+), 18 deletions(-)
 create mode 100644 Documentation/signoff-option.txt

diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index a3baea32ae..17150fa7ea 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -59,6 +59,7 @@ commit by giving the same set of parameters (options an=
d paths).
 If you make a commit and then find a mistake immediately after
 that, you can recover from it with 'git reset'.
=20
+:git-commit: 1
=20
 OPTIONS
 -------
@@ -163,14 +164,7 @@ The `-m` option is mutually exclusive with `-c`, `-C=
`, and `-F`.
 	message, the commit is aborted.  This has no effect when a message
 	is given by other means, e.g. with the `-m` or `-F` options.
=20
--s::
---signoff::
-	Add Signed-off-by line by the committer at the end of the commit
-	log message.  The meaning of a signoff depends on the project,
-	but it typically certifies that committer has
-	the rights to submit this work under the same license and
-	agrees to a Developer Certificate of Origin
-	(see http://developercertificate.org/ for more information).
+include::signoff-option.txt[]
=20
 -n::
 --no-verify::
diff --git a/Documentation/merge-options.txt b/Documentation/merge-option=
s.txt
index 80d4831662..eb0aabd396 100644
--- a/Documentation/merge-options.txt
+++ b/Documentation/merge-options.txt
@@ -77,16 +77,7 @@ When not possible, refuse to merge and exit with a non=
-zero status.
 With --no-log do not list one-line descriptions from the
 actual commits being merged.
=20
---signoff::
---no-signoff::
-	Add Signed-off-by line by the committer at the end of the commit
-	log message.  The meaning of a signoff depends on the project,
-	but it typically certifies that committer has
-	the rights to submit this work under the same license and
-	agrees to a Developer Certificate of Origin
-	(see http://developercertificate.org/ for more information).
-+
-With --no-signoff do not add a Signed-off-by line.
+include::signoff-option.txt[]
=20
 --stat::
 -n::
diff --git a/Documentation/signoff-option.txt b/Documentation/signoff-opt=
ion.txt
new file mode 100644
index 0000000000..d1c6713774
--- /dev/null
+++ b/Documentation/signoff-option.txt
@@ -0,0 +1,14 @@
+ifdef::git-commit[]
+-s::
+endif::git-commit[]
+--signoff::
+--no-signoff::
+	Add Signed-off-by line by the committer at the end of the commit
+	log message.  The meaning of a signoff depends on the project,
+	but it typically certifies that committer has
+	the rights to submit this work under the same license and
+	agrees to a Developer Certificate of Origin
+	(see http://developercertificate.org/ for more information).
++
+The --no-signoff option can be used to countermand an earlier --signoff
+option on the command line.
--=20
2.29.0-rc2-130-g9dc1ca14f3

