Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3908738B14F
	for <git@vger.kernel.org>; Mon,  8 Jun 2026 06:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780901409; cv=none; b=KejLcdq/DtZJDVCytksW1da3QO76CnUMsU/NkX9f3lNyQmWCQkqmTGS0ods6Ka0VUO9T4l1a6aM5Xpz1E6QwbGosNI4wtAC5c1etc3O0KORztrpBQbVyySTnJh9h0+5oZnT0MAQT5enj9bxK7xl5FSfDXgMCfODgfnrxFsh0ObE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780901409; c=relaxed/simple;
	bh=SLokGvvwOUrlui6mwSkZVGIzHenvVoi9S6hdGxwijFU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=isDE13EQiovUnpxEm6RQXuQZbkfi4+HAs42ns8ncPm3gyRnlR64wxNnN0hM1nH1i4GO8lqgNa6KvR/J9reaboBMX2muXQcuaxliUUlQBlMQQd/+H+cOSUjtar1nD2hLpGE7uICvzX2Xoa8DylcjzF83tEUA6/eWVmiYckAx/+MU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=SaNzEQac; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Tz8CdtcC; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="SaNzEQac";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Tz8CdtcC"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 7700C7A00C1;
	Mon,  8 Jun 2026 02:50:07 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Mon, 08 Jun 2026 02:50:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1780901407;
	 x=1780987807; bh=5LvZQcCpATX0ZictFU+P86940XLMZoDD60bJo32maIQ=; b=
	SaNzEQacJCgUztsXzFMWOhS2MFel5fXdZ7001yYr6AiOWUAbKST3SQHiBSaf+7Rt
	cjbAyXVTEx1c4PQXmGYrRHgbRsUNjotSspYfg/8ssemaa7dAPLonEunmcfaAPu6a
	/DLNO+JA3XpUPQ3uonprpCT8Lm3MWKcZ7R6KfrxrP24Xu3bsmFyuQprb7bWla75F
	XmjwAsF+uE36QcIpej4n00Yqg9RRcBRtYmNnz+W+iteLZpyW34s50cZy0kOBlcb8
	6ugLii9U4fC823T1hrPkt69Y8eYLmmXdF2Xr14gMMkgy0zZ7sWiAhydpqNoQZ6Xy
	6l7iw2OPAWoeQ++zFOIExg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1780901407; x=
	1780987807; bh=5LvZQcCpATX0ZictFU+P86940XLMZoDD60bJo32maIQ=; b=T
	z8CdtcCO6+Of+hn5m4OXClnChs11M52v7R/hj4KWK4EUag3wMAFGQkChZegJ3zPp
	pt3R/9j325E1EHp3Qj4RSkJloytRHJxV0c+/Txp7RM2wEQSjXf28vBqZmg0H236B
	u3Fjjs3nEUMpnREi+ONi0TTYKEHqG9Ag6RWeywBAc34QFJoXFB72NwSfF7EdZXiN
	6MENB/6Pn2qK7O8KmG5UmK7dZ5p6ytLb6CSTahRssMmnqyzmAoQUiTKJwHT2r5gU
	3ffLpmHvE+BQEdMDtWdQdrY64aTftg6uvSA0zBk5MskSo6TxQpvjGqq5xXmIx2GN
	uBcDiIKG6jgltxF6SfYzw==
X-ME-Sender: <xms:H2YmausG1j-OeJsXt-VU0rVeQkobJR8ar0h4AoWM5uBwbzv3SEm8pA>
    <xme:H2Ymatcx5RcrMtusdsxeJCYWg6pLdEMId3GUvPaEdw-pCl0Cbqb4BHl5lHoICECCq
    RZtr6lEzyloh_ceyfXKDDh2rr6GQguwKzx9rMe7Q5agpH6wScUwzA>
X-ME-Received: <xmr:H2Ymagbxz6Nha7YMh0_dNanGTg7sNyd4GKmndbqPcbgCK0V8knsFnoezd3Eq0mK8DIFmzpYk5XTssi-nv3ztWQC-LMdlA_R5VRcpzS3Alw>
X-ME-Proxy-Cause: dmFkZTEKEjXO/TeqFyjAWUAw67gxtHnRAvAVHYn5/55/pSvaSmNbXcZ1p/plrIVi+/VsjC
    +xxCr60emcKisYBT2W0OeTV204y+WrYLKkRGDdKcZxFhmeIWczeaghTfqKO28cr/+2Tzrm
    yyG+SaF/aU7ecfMGuEF2iq05xRpz2nInWBRp+DxLCTgLgVgeiA2BpaOooCoNUGP+STbCxh
    peNYZAQFlrfUAXbHZaX9OUJcFnKAbPtonp6KnQ0c45NEjdEne5oY74SREOuC5tExiV0iOH
    PjJUQVn5jau+b5wlmepwenwHbV7edTfFqFUlEsJR2O7rFlizQ4wAx3YpQQ+d9dP9bfvWbk
    ubhebp62m3IkhKKgaF660Y3KSTWpuemHsRuDB92diB18ADsKcMPpbD03T4dPyIVs5Q2eKf
    8EPhpEvk8fJpQJraIUNZWm1DzwB7DWia/jB1+7I/4cX2KIF2gJLF6QsQjVxZ2NWLvE7NHp
    xEwraEowGETi/xtB0rrnsYNYJIy3fDGdP9INUVO6gsMgP9Ud1dFAqAGbfIC74I227GTeo/
    TJd8CrFJgtmC3JB+lTxwEBUbpuWJXyj73RZr5iPBK1SFbopcG5H15fk0QWNxH8lgK4eRWB
    va25eJjCS7y2lC/6boZqjHxRA4wXG3Gtpxf1AFDXtqxPZ2ME2aOnwLUz4Mvg
X-ME-Proxy: <xmx:H2YmanYBVdiBWDOIJSmytN-UPqq4b5jVAF5zj5xTX7hp69y9SGI_wA>
    <xmx:H2YmatLzDKujFbs8QSjsOC8Oyacosiprqe1Tbv9P0PCwDBKH_u1m3g>
    <xmx:H2Ymartc3otc0yK6qZoMJ5zTvDFEW5EDUKLZNz0eq6HrZCWdjul6tw>
    <xmx:H2YmapVSf4LN3NUVOBIVbIfkVYDIJOH1tZ5E3heb03SEwhMBMr_-mQ>
    <xmx:H2YmatLgSfxz0mUQrb4DJt_NxFn00K2ww_gikXiCHQK1lmpOrDj0j6iM>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Jun 2026 02:50:05 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 2dedd30f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 8 Jun 2026 06:50:02 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 08 Jun 2026 08:49:54 +0200
Subject: [PATCH v3 2/3] MyFirstContribution: recommend the use of b4
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260608-pks-b4-v3-2-f5e497d10c56@pks.im>
References: <20260608-pks-b4-v3-0-f5e497d10c56@pks.im>
In-Reply-To: <20260608-pks-b4-v3-0-f5e497d10c56@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Tuomas Ahola <taahol@utu.fi>, 
 Weijie Yuan <wy@wyuan.org>, Ramsay Jones <ramsay@ramsayjones.plus.com>, 
 =?utf-8?q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>, 
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
 Toon Claes <toon@iotcl.com>
X-Mailer: b4 0.15.2

The b4 tool originates from the Linux kernel community and is intended
to help mailing-list based workflows. It automates a lot of the annoying
bookkeeping tasks that contributors typically need to do: tracking the
list of recipients, Message-IDs, range-diffs and the like. In addition
to that, b4 also has many other subcommands that help the maintainer and
reviewers.

The Git project uses the same infrastructure as the kernel, so this tool
is also a very good fit for us. Adapt "MyFirstContribution" to
explicitly recommend its use.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/MyFirstContribution.adoc | 92 ++++++++++++++++++++++++++++++++--
 Documentation/SubmittingPatches        |  6 ++-
 2 files changed, 93 insertions(+), 5 deletions(-)

diff --git a/Documentation/MyFirstContribution.adoc b/Documentation/MyFirstContribution.adoc
index 984b7f5aa8..607876f3d8 100644
--- a/Documentation/MyFirstContribution.adoc
+++ b/Documentation/MyFirstContribution.adoc
@@ -833,7 +833,7 @@ This patchset is part of the MyFirstContribution tutorial and should not
 be merged.
 ----
 
-At this point the tutorial diverges, in order to demonstrate two
+At this point the tutorial diverges, in order to demonstrate three
 different methods of formatting your patchset and getting it reviewed.
 
 The first method to be covered is GitGitGadget, which is useful for those
@@ -845,9 +845,14 @@ more fine-grained control over the emails to be sent. This method requires some
 setup which can change depending on your system and will not be covered in this
 tutorial.
 
+The third method to be covered is `b4`, which builds on top of `git
+format-patch` and `git send-email`. This method is the recommended way to
+submit patches via mail as it automates a lot of the bookkeeping required by
+`git send-email`.
+
 Regardless of which method you choose, your engagement with reviewers will be
-the same; the review process will be covered after the sections on GitGitGadget
-and `git send-email`.
+the same; the review process will be covered after the sections on GitGitGadget,
+`git send-email` and `b4`.
 
 [[howto-ggg]]
 == Sending Patches via GitGitGadget
@@ -1296,6 +1301,87 @@ index 88f126184c..38da593a60 100644
 2.21.0.392.gf8f6787159e-goog
 ----
 
+[[howto-b4]]
+== Sending Patches with `b4`
+
+`b4` is a tool that builds on top of `git format-patch` and `git send-email`.
+It automates much of the bookkeeping involved in sending a patch series to a
+mailing-list-based project.
+
+Refer to the https://b4.docs.kernel.org/[b4 documentation] for a full reference.
+
+[[prep-b4]]
+=== Preparing a Patch Series
+
+`b4` tracks your patch series as a branch. To start tracking the `psuh` branch
+you have been working on, run:
+
+----
+$ b4 prep --enroll master
+----
+
+This enrolls the current branch, using `master` as the base of the topic. `b4`
+manages the cover letter as part of the branch, so you can edit it at any time
+with:
+
+----
+$ b4 prep --edit-cover
+----
+
+The cover letter not only tracks the content of the top-level mail, but also
+the set of recipients. You can add recipients by adding `To:` and `Cc:`
+trailer lines.
+
+[[send-b4]]
+=== Sending the Patches
+
+Before sending the series out for real, you can inspect what `b4` would send by
+passing `--dry-run`:
+
+----
+$ b4 send --dry-run
+----
+
+Once you are happy with the result, send the series with:
+
+----
+$ b4 send
+----
+
+[[v2-b4]]
+=== Sending v2
+
+When you are ready to send a new iteration of your series, refine your
+patches as usual using linkgit:git-rebase[1]. Note that you typically want to
+rebase on top of the cover letter. You can configure an alias to enable easy
+rebases going forward:
+
+---
+$ git config set alias.b4-rebase 'rebase "HEAD^{/--- b4-submit-tracking ---}"'
+$ git b4-rebase -i
+---
+
+Before sending out the new version you should also update the cover letter with
+`b4 prep --edit-cover` to note the relevant changes compared to the previous
+version. You can inspect the changes between the two versions with `b4 prep
+--compare-to=v1`.
+
+Same as with the first version, you can use `b4 send` to send out the second
+version. `b4` automatically bumps the version to `v2`, generates the range-diff
+against the previous iteration, and threads the new series as a reply to the
+cover letter of the first version.
+
+[[configure-b4]]
+=== Configure b4
+
+`b4` can be configured via linkgit:git-config[1]. In addition to that, projects
+can have their own set of defaults in `.b4-config` in the root tree, which also
+uses Git's config format. The user's configuration always takes precedence over
+the per-project defaults.
+
+Refer to the https://b4.docs.kernel.org/en/latest/config.html[b4 config documentation]
+for more information on the available options.
+
 [[now-what]]
 == My Patch Got Emailed - Now What?
 
diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index d570184ec8..99427e1ee1 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -573,8 +573,10 @@ your existing e-mail client (often optimized for "multipart/*" MIME
 type e-mails) might render your patches unusable.
 
 NOTE: Here we outline the procedure using `format-patch` and
-`send-email`, but you can instead use GitGitGadget to send in your
-patches (see link:MyFirstContribution.html[MyFirstContribution]).
+`send-email`, but you can instead use GitGitGadget or `b4` to send in
+your patches (see link:MyFirstContribution.html[MyFirstContribution]).
+Contributors are encouraged to use `b4`, which automates much of the
+bookkeeping that is otherwise done by hand.
 
 People on the Git mailing list need to be able to read and
 comment on the changes you are submitting.  It is important for

-- 
2.54.0.1136.gdb2ca164c4.dirty

