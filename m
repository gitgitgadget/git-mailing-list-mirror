Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C0203F1AD3
	for <git@vger.kernel.org>; Mon, 15 Jun 2026 12:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781528400; cv=none; b=UjuNjj+MYxlSPSzHrUyzHKZso/TCQyGQkQAOyq0oZ0xJNJJrIkt+IMyl6eBK/LdN0/auWYNkgp+bawhOJ2BrrOYNjmRf1m6Z2ZzkI7uMIWWoPQYwR5ec88geqsxyNfbPVf6RFsfkeNzj0ZhPa9C4OAsbX4esuJX5URjop593Ps8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781528400; c=relaxed/simple;
	bh=smMa38GgsCXNxsIKwgHTCSIAfoTgm0nB0RLDsOEVeY4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RBF9yegMRpqbqNJnFZERvrjzywEecw53pX47b7RaOM/gNrGMKfcY80qyP/f6r1wlTBnBMEDmiOA01FycN3x6V28hCZqeXnYgNX0PSr5upTqWaIqxwwh6isExr1EG7FNfDmut/BgBa7QSS5Gf98WFdh8dHpEmNc68rrqThmJcZ9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=MaasSUJ1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FWbdPD36; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="MaasSUJ1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FWbdPD36"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 9E49EEC0076;
	Mon, 15 Jun 2026 08:59:56 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Mon, 15 Jun 2026 08:59:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1781528396;
	 x=1781614796; bh=ULM22KK0LfllHtBMmH68YT6JWPqmJZa//Y8QxkBPj84=; b=
	MaasSUJ1tEGk7zGFCO2JJx6LMfgQl+ZpWF2usW4PlsmeCEaF2SnAZSXk1lAHT6Or
	8CEfU91vZj7W+77RKLuy65V5P7/X46RW6uzcrRNN2bxgIYzFvC+Le+HlRAb7iYTN
	5cfm0FIeDtLb9T36oT9NxNZ/4ur1+kgmVEC9XItxkZqqrelrWyCd1kbkuV4aDVU4
	Aa02WkTy8kK0zZLcEokrDFm5uhokbzo5+1gJgdUF0Uy8P9Az2/qBR1s3AKG8KC3x
	9f2x8JECEFjlO9roVzNhktda0v5O8MoeqfUoHVJT7yQkMzjvElOjmWDSxSMGGS02
	CWZiMOtl6vsIM5kZBk9Jxw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781528396; x=
	1781614796; bh=ULM22KK0LfllHtBMmH68YT6JWPqmJZa//Y8QxkBPj84=; b=F
	WbdPD36kKYhKYN+mKFnHxS9xY/cGyV70qlhFNF01yPyaT5zg9McG4tY3J76Pxia3
	k0YLNy+u1Q2Tj97l9bhx4ZffWNmz/DKW6URy4AdER2XOr3mac8zAgbdShMPXla67
	lgSJ2xbjybw2Ernlql06ps1YdLrvZfqp2f9K9CxpCX7u/KEy6413B8EuAhsTvlR/
	/eiXDpowkPe5l29wK40NZqXszuCss2Z+/OngjbwhhFNy53Ey61IViAlZ/Fd2wHOx
	c7qOApVbaQyhgXDOwhQX/qsqLwtyGZDkD06Wz7CFUoPkoOPhESkqy6UrEmwm1eTc
	B6HlFxzO0tAT3+LbVUEFg==
X-ME-Sender: <xms:TPcvakCUgxJLLc8KEI2EDLoLcXu-gSgt-oqsHbSJuEZqAlypyvZCJQ>
    <xme:TPcvardUxFF7FFsREQvWDNqUphm3C1MoQwOuPz_KoST_cRPCcfkM2krste7oBqpeF
    1W_O2RsZ-55uT3wlyZJkWc3BDtWRFFW2X_Dgua8TrYYE72xyo5yuA>
X-ME-Received: <xmr:TPcvar2r6IAEdiP3I7-SssV0bB6AoPbNdDuc4QQJjqJIblmHcozm8iu7xm2qEK3jQ6_8K27KKd_nFpiR8CCAh9FMZvPWEBWoPGVbAOzmPA>
X-ME-Proxy-Cause: dmFkZTE0R8yETLxJQEQu5qYlTTsCn/4aFpcCdk82zSwSdbj1KUrfOuidsUuLBW1EbGZp8s
    scEnVB34pR/8GeEMgUnkwyhFiK6dcsbzRjpOxJXJduony3MaT92A6ZLYKDWAnDPi0Q4FXg
    e1sZKp7HxeEEJfAy1aXtK3gBmwEzv0ecqr8HvLEfdGtjWVpRM4g5yXooiz4nkB4mO88aYg
    LYEjqIBt/37I5q4VEJ6KjbSI6d3k2z/cEV/L4qhmRI9wcB+O5CRtAYYUVV/gSZjjGgF5Tw
    TlKeos9wjiHBoT+NKo7HBfQNmdqicRh0K9o/UXt/wEJuvBhFsAg9eg97W8L4w1D2OI7ppU
    GQK4ZVbd/Z9ubhOuQQPit9hIzXtq3CHOjHlQ1NtfXrtiHR0s5ipAUj/A0UeRrHl5Hy18Rt
    U9cZnaVuSf2fHgrKHmG8J5ZEUqmC1lpKuC2OCMq4EEnqCT/2I3qTpHp1iJa0Y1ShwK9W8U
    DhLO/rGpmOVLFi7x5eSHUXDyeIzT1sGzndo/8JJsqtybeK0nzpHbPGJk4FlHS4Ylbjqln9
    H+5lK2IusAglsP4Sbz5njI91SrbkXthEoxGfDFL8AxMDSW/oEG5Xa/GL1iYLeKpe9j0rn+
    igPKo06RDqeK+P2wandyn+bK39H6bsNZivudVGNgQ87wJgz16Ct0Khn1odJA
X-ME-Proxy: <xmx:TPcvaqijOjcPnf7VNJQgPqJmK0eQ7XSA1bAjNamYShCOmtN-Ekefaw>
    <xmx:TPcvasma54p09I2qcGb40QqVV5JG5SbwuM_PMfPrIwAcv9YndUpVgA>
    <xmx:TPcvaoZkxbCJx4xSgK5tNzqDmnAP5rj71QBku1YJ7i13uen5op-39g>
    <xmx:TPcvavFpiu8asbvDFFNVe8wu4owRPjvwoxfNb4jN5ZvmNie0pw6T_A>
    <xmx:TPcvaiAApDlQ4z6DuxoE5xOg6zGuI2gF3ePUDNcsGOj1mJfH5xxUaCKE>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Jun 2026 08:59:54 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 160e922c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 15 Jun 2026 12:59:54 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 15 Jun 2026 14:59:42 +0200
Subject: [PATCH v4 2/3] MyFirstContribution: recommend the use of b4
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260615-pks-b4-v4-2-22cfca8f19c5@pks.im>
References: <20260615-pks-b4-v4-0-22cfca8f19c5@pks.im>
In-Reply-To: <20260615-pks-b4-v4-0-22cfca8f19c5@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Tuomas Ahola <taahol@utu.fi>, 
 Weijie Yuan <wy@wyuan.org>, Ramsay Jones <ramsay@ramsayjones.plus.com>, 
 =?utf-8?q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>, 
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
 Toon Claes <toon@iotcl.com>, Karthik Nayak <karthik.188@gmail.com>
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
2.55.0.rc0.738.g0c8ab3ebcc.dirty

