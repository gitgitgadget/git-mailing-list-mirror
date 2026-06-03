Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35FC7400DFB
	for <git@vger.kernel.org>; Wed,  3 Jun 2026 06:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780469955; cv=none; b=fLB9bQfTRDy5G/7EnIv9m9oNNi5k+ooTttusmKp58bvWjnuSTaj7KlarpTvYtcB7+i2MlekuQ6bblsh92Jv+Hph6vlSWhZdmLw2Tf7sXbuwY3G9iDKBNRl5sZ0RsDzw34ZPI64m0NUGJP3qzw/xXii0qGY5dkVYE62pbDiFPk04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780469955; c=relaxed/simple;
	bh=NTrYO/ysYobIMEQvP0VlF5sZRV1pm3vsjckjGgrTHeE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sJ4l5EA7xPsqxjQwTxqcQtO86qBVx3f3IwltOpuCJUFdpX7yMjOh0qpAhTFvYkkwoT7gxWhaNyrK5FT0ULqeGyYvokjmnfPhRcRYrJi4vcAvyBAHRWkMBG23FRccByVSgF6BVPZBQVOHWdnPH8cLGAOs9fIwRUfQvoPio8chB9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=QyXXWWNt; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=M7bOIbvv; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="QyXXWWNt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="M7bOIbvv"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfout.stl.internal (Postfix) with ESMTP id 767321D00060;
	Wed,  3 Jun 2026 02:59:13 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Wed, 03 Jun 2026 02:59:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1780469953;
	 x=1780556353; bh=Um19HsmjdFh2a6oEbaNVdN3TErOAPAO1UEu+wEj0AJg=; b=
	QyXXWWNtWRIpZrI7XHcYILO+ei6AhoX5Glrm7sLUn6jIZ2Liuhq/O/vEtgRnkSC8
	QAN9vL0xtGQPh2G3kSGPyynCpL6oY9tqW/kEffW8SzGJ7KsLQxcTgfXTuxizW0LX
	Yohhyv49kK/z9Yv4+2grsNUGIlDcBTblLKbAc+wq8wDWOkHLmGYM4Gc3mO5fEK8R
	yxKak544pyU9+2wPsTp9preO2Ea9TqWjaX3RZodPvO4ViRz59czWQny2n2DNc4QE
	50+FXmbR8mjsb1FICevMx+1unoqjCRYPpnw4SZ+kO/b6rqZHS6aQMFNPZtjTuiFs
	TqQNw5dZugcv4ceYtbnwjw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1780469953; x=
	1780556353; bh=Um19HsmjdFh2a6oEbaNVdN3TErOAPAO1UEu+wEj0AJg=; b=M
	7bOIbvv2US7HA4yJrVyvsGEjF2DWoOY0k7yZbNCzHTfNB2c/2CrB9Sgf23u9jAoT
	xJEaWCdWmHzCw0ryxG0DhQWC4b/ej7FgCRUtXkkZbUeUs7OSqXsNQf46MkT5ZDdx
	JYAeZljmCLiEBQTf95pqUqdDmz92GzMioKGAsHuHA3dkuV3ltJkkr9UrLzfVRj8b
	x24u2iVBpVqN+XblAiER6mYT1CcgA05PmOdh52YVIZ7mZ5Ui7Ri85W94Tty2Qvtq
	pg/upxC5H+GSyNzJcCv+BE6Gmn/5HRX+WL3vSaqrszQ1qcpxVtckrFVtKL31MwT5
	Bwfd2fuT8xgBvL1V/6B6Q==
X-ME-Sender: <xms:wdAfatraiyrZGyuUveAohOfvMfONksRnCdhRFyeIA8nQM_yFEFFyZA>
    <xme:wdAfahI1xRaBYj1ZvbFEvuVj76p7ilmiQsE5CvWb9NyteVKFEzI1jSc9g56Z91Zwu
    PxwQfSsTIppSp8Qotagv3RF6ZRFjQvg6ekGFkkYQfUpQRlRNmW8c0U>
X-ME-Received: <xmr:wdAfaqSBU51ooeFtEPql-GXwkKJftMK-C3QOWSpQo1axvVTeFsvCvpQUH-XwW_IWuwxfDvtRQ68FkcNcv5yt0pCIS2ELgK7Yvj-POviS9gXY>
X-ME-Proxy-Cause: dmFkZTFNOV29i7tCr8PkRdVCE3tIEuZadO29DyzkFdxJe8fFSm5aS+Sf4SqatoGiqDbt9V
    fzbOkBOxN5wnXqDuVq0rlQ6aMT8ylaTtxBS05tJxsch0svEpTE+H3OGxSmeBmMvJcDZhcn
    x0MaBlLdiIl2Ge8CXTIw5E0L3M5gatfMDYCkA+W3HXKv1/R8FWy1pSelfOc9gdIIZss6bn
    5qdFwgc7x4zsVzSZgcd6Z8nDqNIgtgRVqo13fMxWnOZUjJT3gRJYKXBQZ0vxE5suddH3Lo
    TUvuVSebmQ1PSgFljNDpr67Jc3cThOoTjcckYvcxzAtdaOergP864ddQcWrkhoMB+gSOBy
    wfuEZBcKMZApvPcRU21UIcWP/k7FyhBdm0zx//Bv5hSeEJrtG5QNWtWYsuayLnvSoV1uK7
    cgWAoTLKJHRXeC8qG6oZwPv+k4d9JkQj91sDNRVVZusCyQCmpLESsI+YzscQh/WMh0Rrsb
    MqJDgc/fEPNiFNqKKqinlHtX/+q9J7WTEGwr6QbED98f6mJLprHFdqWxgG+LQ9eBeYTFlG
    kojCsIdoANmY1P/TdMpjAc1E4JkqKPcV5oigHDQwwQfcb99/HyayZ1Y/6uhnLXwUw6dN5/
    B9rNe7Jnhz08digWpfMQt8gLpzrOXA7f9GAMZUXVLnyqrofktkdanMcrexqA
X-ME-Proxy: <xmx:wdAfaovkM8LsXeCfjU57VqOwhPTSCQARLliJdB6tQS5ZIPfSNRbb0g>
    <xmx:wdAfajZ5yt_qpUbcNiQ9FzNNL9knPG7U4QHjsyGld0dym4v_pNFPWg>
    <xmx:wdAfamFhVbsuIhnBrILznY-RhdC_zNEyxOvnS07EnZLsD8WNx-o8Dg>
    <xmx:wdAfavz2BqVslDrIAYqQN4p6rwBcv9Ci7eBbowrp6HjhbCtd6g9bqg>
    <xmx:wdAfar-KqyJoTKXuRKzsLLHz_cxRq_yXOSTKw8truhIowlG89FIcgef7>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 Jun 2026 02:59:12 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 425e1351 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 3 Jun 2026 06:59:11 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 03 Jun 2026 08:59:00 +0200
Subject: [PATCH v2 2/3] Documentation/MyFirstContribution: recommend the
 use of b4
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260603-pks-b4-v2-2-a8aea0aa2c23@pks.im>
References: <20260603-pks-b4-v2-0-a8aea0aa2c23@pks.im>
In-Reply-To: <20260603-pks-b4-v2-0-a8aea0aa2c23@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Tuomas Ahola <taahol@utu.fi>, 
 Weijie Yuan <wy@wyuan.org>, Ramsay Jones <ramsay@ramsayjones.plus.com>
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
index 069020196c..fc0b06ae67 100644
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
2.54.0.1064.gd145956f57.dirty

