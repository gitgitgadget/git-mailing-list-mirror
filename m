Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AA4E3D333D
	for <git@vger.kernel.org>; Tue,  2 Jun 2026 11:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780401576; cv=none; b=L6cVNeGG+30ZiVN/uiSwlnNPMt0tuHIXU7HqH1yctfxSR87GhngTXoF1Zv0lWR5JLlKWPIfbXw17q1/rG6bgGcFSkBeRC8rNCRBlpheUaLWyXIs6uYEPCcO1MIPi0I6WTvDXmwI3XC1v+k5vyoNdQOKQGyBY1NodBAEdHaCPjEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780401576; c=relaxed/simple;
	bh=RlBziFtq19Eg2pzgz/ZrP/IjM8IlelJKxXniCqyI8rI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BLTOD4xpk8ZM2VLz99w8a3xzlxilafRmr6mxUUpUwonxmz4PiMJSyj/SB1l1OvHfOoRtxbn5DWJbotE1xQ3ms6KwnlEUhYw7IOOiebNhyKuAILZOQ3+fxm/e/5+Rf6Iin8+CiVTN9WAoiB6ilqv7IUMbAzU+COuzirfb8EZhVvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=BNj7hrfQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aFrCFc+P; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="BNj7hrfQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aFrCFc+P"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 79C447A00E1;
	Tue,  2 Jun 2026 07:59:34 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Tue, 02 Jun 2026 07:59:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1780401574;
	 x=1780487974; bh=h+byuB6J7xn3IGq14ZfxLAwOqlzFl0o91AWj9OiaWxo=; b=
	BNj7hrfQ5yIe9uiOgaUBmtWIOgIz3fjTXSrOR/qmuLONIGyFg4zZ2t+JrRBFHiSb
	JcoE1h5p5H+a6GcELR2NHBg5D0AGCfksXkSdY9X0/4Jd8YHAqVy4jcjpfprkvLto
	TlwXbiXlBEtBeww5dOOt6DY+0ZMsME5ByY5sPSxiVjNn5ky5TZHc435V011VxzlJ
	3wb9U1asqyPP+JJuNKHBHndUB7ft2sOM+EF/dNvN94KFXApct+6cRlK7SK9lz3GR
	HKFRWsJuzUUCY0bCNILWtrqgX3k2n8clkNMcJUzJDXer2U3CBrvSc8ZpSdj6p0rc
	7xzGn2C27L6BXAZ8RQmpPQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1780401574; x=
	1780487974; bh=h+byuB6J7xn3IGq14ZfxLAwOqlzFl0o91AWj9OiaWxo=; b=a
	FrCFc+PZcIoyZcSCGZUEXhAH2hwy9pzdE869l9ABr6PkxQVYY1RVHbOnKimcaxRu
	ud1rW2HwkI4olriCm5P2Fl/6rfn4AmhZjNdJD+1PmfOgun8tx/u3nF1zMZth0LmZ
	cXWeO8+gblNCTSIU0OVlETcAX9/HCV/cpw1N4rk1Q1239ySoEuYV/1mOIARqkUWG
	+IX0mn8rAAwY4LHtop0cyjbxZSAY5ZUcpFUd44S0ozjNlqbnH46FvOyRRyKNSnxh
	XRC64wl4L2Vh7NlsCu06tVmHg7JYpegK50i3q5jdv+VN66uqhtJ6T31DClh+YZh/
	rpDBW5PGV/PXwbjBAW8uw==
X-ME-Sender: <xms:psUeaosIzT4LKxYfK2CoXwEqXvEo4-EVunxztVXO_wYNZQIDgQOgbA>
    <xme:psUearcksTXDOmb8_waLFlUF50fIkgJenRGp7QPNaVVndFTpGuDYkbRHDw19LOoVX
    kDjcN3mrO-m-oskKnBzfQX-4wku9NFZwrmFsPMUfSA3PtF200rl6v0>
X-ME-Received: <xmr:psUeahYCZsJ9DLMHOyPmAx53hE-YyWxiChtHRlOn04IwCiWTAfxQNC0tpjIPg_cOb9BIlC2ordqGZ45UhBrtZ8hlzT5SgzKSUbUPxT373w>
X-ME-Proxy-Cause: dmFkZTFdp5/i9ZZUx961/tGv+ZvwapM5JN427bxQC25xQc9eGQ20sN7DsvVcwbyxsGGOpN
    9BGlEoZVaTZjH5rHxP64mILQYDImIoGzH5d/itSlcPy/dZqTU3ResLAyD5/JaumdVB1QGV
    MeSCGUrqXLuxqIqJEtV7RWid1oRlKeBvTI+7V5tpLUoP/EPjlr+mBkEgqMI3b0Pz9GYs9K
    mWME/l7jl7aS0ozV1bhEukE3r7QNLRBCmwHobE6s92ZlSfscH28AbDnXxbJv57bk+bDWtu
    FKAQJx3gjdS7Qp6ErcVRXxXZWp/CQNUmsKwuie9afPoeatxgi8f4i/3GqrNUDeXAZcuhsX
    3C2zHklVnR9bUwUM0ViD4TQEA5Tj3zOM9n3avh5RCRrh9udyknyq7nqM6MQV73kjT2lXvV
    1jJgR0XfPu1mSy86x5YREqLi4XaLTACpY/marfAIfhhqkeZXsE9OTpJ7vtlW+nkxuE9KfL
    jtXQ6g1XF4rsTNIsPif55i6a0tLMP30p5pnyZ27kPz8CFHJdtQfKRfFOX5ITGRhGjL6Pwo
    rFJIw1BywLSPPWGmLREf3shsMwXbVz3hLvTLefblsa6DDWqrpm4jusgL7tlpOm1S6Qnlru
    TgkLktKQ1DNLqddRPNiyew8NnV6ImS50TRPwPRpJEQt0t2t3OMl+Y9k0lc9w
X-ME-Proxy: <xmx:psUeamXwcJOuE59S2pXz9f20jR0hKyFbZpCfDlzBzehX4AKOqQzwRA>
    <xmx:psUeariW81umc_Pb16VL0jCgGpGQxWNuH4gllDFtK6U6N9Jhc1JY2w>
    <xmx:psUeasVnWB-49t6urukss8bdwniGCYweOT_y_1lsLoFqqV7y1D5nNw>
    <xmx:psUeaqPfDyHFGwWm_MCiXJxyefRkCDSGr0ciGFwpalRf-koblKIVkw>
    <xmx:psUeakE4AOeVv8WKJAhR-vh0_9tw5IA62HV6jBLi9_wYE4qeI0SoQH37>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 2 Jun 2026 07:59:33 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id fcb64e55 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 2 Jun 2026 11:59:32 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 02 Jun 2026 13:59:10 +0200
Subject: [PATCH 2/2] Documentation/MyFirstContribution: recommend the use
 of b4
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260602-pks-b4-v1-2-a7ae5a49e9cf@pks.im>
References: <20260602-pks-b4-v1-0-a7ae5a49e9cf@pks.im>
In-Reply-To: <20260602-pks-b4-v1-0-a7ae5a49e9cf@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
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
 Documentation/MyFirstContribution.adoc | 81 ++++++++++++++++++++++++++++++++--
 Documentation/SubmittingPatches        |  6 ++-
 2 files changed, 82 insertions(+), 5 deletions(-)

diff --git a/Documentation/MyFirstContribution.adoc b/Documentation/MyFirstContribution.adoc
index b9fdefce02..2e50111d89 100644
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
@@ -1296,6 +1301,76 @@ index 88f126184c..38da593a60 100644
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
2.54.0.1064.gd145956f57.dirty

