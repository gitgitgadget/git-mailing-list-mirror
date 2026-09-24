Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D8C7382397
	for <git@vger.kernel.org>; Thu, 24 Sep 2026 14:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790258972; cv=none; b=FOYFz4BRuSrYjFazQL0L89YCfsFuixWU3IYFICtA1fDSceLsmAOiqhQw/1Fz+/7WlJV7rymoo4miz5ftZa+ZnBaaDtIX5enV3d+du37TiK0PFuPekVqB+9euBC3Z13VEDmrE35+KZN2jOiK4LWDV5uOQLft+fOBK4R1jZYWDOxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790258972; c=relaxed/simple;
	bh=2qal+usjc3IlDC1AWPDdSb6JRzEiNAtG71JUjCawAtM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VcnG6RpK4beW+2Nvgib25T6rvSQ4VAzgdbwekqwmtIpI7Kgt+BeqRy1Vs0NkpovFegerSlkk01GBer/Z0kJlcVkSshAqDvm8Ifq8b56lnZzb2kLf6KkpMaY838Aho/h0wyjUeJJr4OYp71dcl1BaiMuA3/USIb7g2Ke5nkCYR58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Ma2xKaea; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ryvsRmuW; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Ma2xKaea";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ryvsRmuW"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 6F4751D000C0;
	Thu, 24 Sep 2026 10:09:30 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Thu, 24 Sep 2026 10:09:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1790258970;
	 x=1790345370; bh=N36LViipDpFWqBYfTTaUGO4TmyxtVJGFs8fHknGhTso=; b=
	Ma2xKaeaKAM93Wi5td6rTsjLQ0vmaBba9+iqvLWudc9tD0MxCcDvoZ+TXAl0Kf1I
	x2AcGGpW3hWEygzcSe5Dx+OUU1Ku4/V4CLA7Ho9LU/w/uM8fhWSn2LDL2SbJP3g+
	vmmZWMbuZgKvxGFEiI24+4sjjv8txcH8/+WaYBTCZpWzvGMrfbRvXJ74FeyH/iOM
	KsGa0crFRDK/+DK213jnRWui+9YR4Yg2lBiLoMTnmLL6MH06lKFuY0Z2wU0txYUB
	kmcIDpkjV4/VeCIDdMBoh4UWra//xHjbjitm9DvQ6JdW8SwYYG2DOyQwjvqtW29K
	Gz+UwxAL9HZvwFIi/zWJuQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1790258970; x=
	1790345370; bh=N36LViipDpFWqBYfTTaUGO4TmyxtVJGFs8fHknGhTso=; b=r
	yvsRmuWIhBK3sH7BoYC8mN7s6J9yCVlsOeHb8Qn1C1ps/BDd7GCrLBirfuReMAOP
	Pc4eYMhTSp+kjSPf2gxxn1n6jNhVIeiY73apXjo5TozsLWyDFTB6MFwkx/YtVsye
	T3ysjUVpZJqlG1T40Ls21yPWgoJ+FHeKRNg6u3XQvoz4WVWl+OD6rH25y9A9PPjR
	sIky1qGpf/ksBdIf3Jx+yATLTxYSkfqyeUxwmWamXEnjP+boL/O3Ms7buHgBABoC
	FD4MvKolYG9nZcNInCYMpBEwILirF2IsXqXC49x2ChwYb9htVSU9bO9XTezQjTGH
	OLavc9AgvCMZIQffNQ1ew==
X-ME-Sender: <xms:Gi-1ar38blX4mVMFvl_O_sR2N13L-h58h9ZTqqZ9BcG9_Gctvy2UgQ>
    <xme:Gi-1agEKI9Sxdaxhbon5Ztf0_NXGl16pcr6P7TRy8u0o9hthi5lMB6akl01JD5cVt
    WfRJOms-7jllqE5LzgmrRH-Ls3K7d_PRHwtWsy0vsxX3c0xqrhFMwc>
X-ME-Received: <xmr:Gi-1apgeHRkRdZytqpnxbU26mMgeQTMeqq2hHfblUfXeVDOZf_VbOVjcHnoXrB_9gYNXXzM>
X-ME-Proxy-Cause: dmFkZTFLLH3pIGCnf1LseMaAoK7hqeaCcUz9yfaw6tj9ZUbVD/HAvnAFFfYhIvtOcpR+u3
    rtyfIj7XtaSJcKZOihrnuXD0ZE9p4RLrlU2t6CWK8Mvz/Fu2a0a4mCRwfO8B6+nm0sYB/Y
    +j5h8HLRixCZyPNfFRyOREzvm+GDEkGrfLr+N918WaMsHU5WyTYH4Z/8h3gXl6/vM4lM6I
    RwYKmkuKFMZcNvD1EIquP1k14oM4Dsr+KMPm+trpigbr9P++ukJN4r1RaNbgh1vTqK2utr
    b0zXK2+GgeNfaBPYI+1+imTc2vQdt4x34pI3prcTQUK7ECBsY5CTTuYjAuPMciA404nJKq
    hU+0pI6sW7z46eTQmjc9eCu0gv4IeREeuDvnjC58q7QxhYKz5+zkN3P8694J34x7sxN24P
    Z2J+yBRt52MidGkCT/XxoEzmjRg6O4x8EJe21z7phMHdkji14sbCTHR38QxtZAagvo5xvG
    Nl62vzkNeHF5KyaRxk2Jm8/7E5aLl0vpK3z5ISim/CLdW7M/FPdx9AbRTby8OpZ1EinFMX
    tPEHdnLrXVIjnFWMCkObY0FodwFGzsy5kx7LML882xRf32W96fVUkYcuC7MWDZTCx5V043
    hyGMvuN47d3K1Msut91q62ZXeo0a+ugbb6ckmTwD5XMZhgBYfSS6B+6z3vyw
X-ME-Proxy: <xmx:Gi-1ar_f3AYKcJX-4WMmaRZRtLmt4hLjE9pmCZVCAEnxAOF536erMg>
    <xmx:Gi-1agpc6yzHUlXZEyAURb3y41KyGEXGMHeLgrE9W4PvOuUHepCLRA>
    <xmx:Gi-1aq8Xt7dd570U4TfC4xQi_lzvfZ25d7bPPxAbGrlAEdOPs5u4sw>
    <xmx:Gi-1akUCJSvYe8ErtGq46yj2TG28n6jI6fjzv_zZ1mWpQe7Hyhq-ig>
    <xmx:Gi-1alZxIkDlL9F0p7G6w7tv2TwbiK6fzBW1w2Mnf9jYbVW1i-7BZKZw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 24 Sep 2026 10:09:29 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 276bbde4 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 24 Sep 2026 14:09:29 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 24 Sep 2026 16:09:14 +0200
Subject: [PATCH 5/7] meson: fix outdated completion helpers
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260924-pks-meson-improvements-v1-5-90b7f79f1c4e@pks.im>
References: <20260924-pks-meson-improvements-v1-0-90b7f79f1c4e@pks.im>
In-Reply-To: <20260924-pks-meson-improvements-v1-0-90b7f79f1c4e@pks.im>
To: git@vger.kernel.org
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-Mailer: b4 0.15.2

When using Meson 1.3.0 or newer, we use `fs.copyfile()` to put our
completion helpers into the expected location so that our test suite can
find these scripts. Naturally, we thus also add these scripts to our
test dependencies so that we know to build them before executing tests.
But there's an issue here: we include the "contrib/completion" subdir
after we have already wired up our tests, so any dependencies we add
here are not being honored correctly. This has the consequence that we
don't know to copy around these completion helpers when we execute
tests, and one has to manually `meson compile` beforehand.

The interesting part here is that the code path we use with older
versions of Meson don't suffer from the same problem as they use
`configure_file()`, and that function will always run whenever the
source file changes. It's conceptually correct to use `fs.copyfile()`
instead, but given that it's mostly creating problems for us it does not
really seem sensible to continue using it.

Adapt the build instructions to unconditionally use `configure_file()`
to fix this issue.

A better fix would arguably be to promote our shell completion helpers
out of "contrib/" -- they are an important part of Git nowadays, and
these helpers get installed on lots of platforms. If so, we could also
fix the order of subdir includes so that test dependencies are properly
honored. But that feels like a bigger change, so that's left for a
future patch series.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 contrib/completion/meson.build | 38 +++++++++++++++-----------------------
 1 file changed, 15 insertions(+), 23 deletions(-)

diff --git a/contrib/completion/meson.build b/contrib/completion/meson.build
index 576125b083..4483c5be3e 100644
--- a/contrib/completion/meson.build
+++ b/contrib/completion/meson.build
@@ -4,31 +4,23 @@ foreach script : [
   'git-completion.zsh',
   'git-prompt.sh'
 ]
-  if meson.version().version_compare('>=1.3.0')
-    test_dependencies += fs.copyfile(script)
-  else
-    configure_file(
-      input: script,
-      output: script,
-      copy: true,
-    )
-  endif
+  # Note that we intentionally don't use `fs.copyfile()` here because we'd have
+  # to add it to our test dependencies in that case, but that creates a
+  # chicken-and-egg situation between including "t/" or "contrib/" first.
+  configure_file(
+    input: script,
+    output: script,
+    copy: true,
+  )
 endforeach
 
 # We have to discern between the test dependency and the installed file. Our
 # tests assume the completion scripts to have the same name as the in-tree
 # files, but the installed filenames need to match the executable's basename.
-if meson.version().version_compare('>=1.3.0')
-  fs.copyfile('git-completion.bash', 'git',
-    install: true,
-    install_dir: get_option('datadir') / 'bash-completion/completions',
-  )
-else
-  configure_file(
-    input: 'git-completion.bash',
-    output: 'git',
-    copy: true,
-    install: true,
-    install_dir: get_option('datadir') / 'bash-completion/completions',
-  )
-endif
+configure_file(
+  input: 'git-completion.bash',
+  output: 'git',
+  copy: true,
+  install: true,
+  install_dir: get_option('datadir') / 'bash-completion/completions',
+)

-- 
2.56.0.rc2.329.gd58861e689.dirty

