Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28A5936212E
	for <git@vger.kernel.org>; Mon,  2 Mar 2026 11:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772452510; cv=none; b=qlprTAzhUQRt+iyPGoyCyhYySKGq1ouUb4GDd39WmCO4K9K5xnyxrKGGuvRL52oWPQPSLGbkQC7O2Nnr8yHgYEIyzQ5ravuToHpetGY3Uq4bWDSKJkfAdw4pZasBOC1vGrlwaWlcpFrWjaHHQpP0Ds66LIqvT7chRuziBpcs4sY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772452510; c=relaxed/simple;
	bh=cEklN6FUX/xH79qFcQSxjyNkdJ1Tje8668UDLBX68gM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=UU4GF70WjN3MUj5YXTojWO5GoKKfl/tP8SUL8uRT7+RkEfU0waMhxBgnC4HjZ7EKCvN7hw4hdATf51NEXMu1rrJjP/pyv53qdPAGB3S2Q6wP8NShn/LhxSAtDdWn6VZkH7RDehhABgfxFIbwdyn5zV0I4+TkmVs+8GDqQX3air4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=HCG2f5QL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AMdRuCfT; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="HCG2f5QL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AMdRuCfT"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 6618C140012D
	for <git@vger.kernel.org>; Mon,  2 Mar 2026 06:55:08 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Mon, 02 Mar 2026 06:55:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm1; t=1772452508; x=1772538908; bh=1Kjfpka6Zo
	eOFn+yI4tBUJB/3eTZlEiiUpruDSTU5e8=; b=HCG2f5QLkMdl1Tjo+kXqqZjPgC
	pkDj4u0MsNOt8A+J9Gd5tROhNlANuilUM4vuwZFWGLy8L1+apwk/Z4yIrWrWgV90
	9KdIOIHbcoQ4IuQfixUamelN8ACICLbvE7YMGyRr066mZ4NLm/+lz15Y2jWYomON
	fYgYlIoEYWwH9OdVeRDhvzJfBJ5nM4tt3fas8ugBr/jkOq4nnCUH43j5f4EKfXGx
	qA4b1lmwk31I141ci7HbjElksBopIN+pJ6N11yJHhI5ov+EOOoCoaBoBJ8snJiAq
	SYbIU4wKHow/gV/PKLagJja6ZjXwn5pyYzlu5hmyKszFE0y7qnoQWJvR+5gg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1772452508; x=1772538908; bh=1Kjfpka6ZoeOFn+yI4tBUJB/3eTZ
	lEiiUpruDSTU5e8=; b=AMdRuCfTVG/T9SWsOwTFpiJa+Y5t+wa+Q13gK0wg77lN
	3qjIhX0fYvqZcJERe1m41H/5bZ7XsPgjsiUNP2Hl+GXBNFKuARPcuVszX3+nUVqH
	v1V7ZBqm2slUdqddMcosn/A7F2WoGzVJe1b8+XCAH9CEF9bs2ZKu9qFv3KLRc6gF
	EHx+cc/sRQjyvEDYiv/Lklwjl/tftDMSYrRrCvSTGAIrJxKk6R00PiKvuUrK8ljC
	6cofHoEtV7N4YIrdYRvEaeu3lvJt/49J8rP3oxUgC1ttFgQJ0DH5GAmHw2+urG2l
	NjnVocnUx7Ylntt7FfUnrDVVG7i77l5mylxKSqJxQA==
X-ME-Sender: <xms:nHqlaVsDQW6C3ajZ1GDi_vCWCpo7qQsI_YyVnimRagCaRFt_hvhILg>
    <xme:nHqlaVZENgPdy6Q4xFy7WA7zhYd4Jo8RfAXWsij0wIR8z2b05uNlNmn_ZvGMvGAuC
    og17g9ZdOqhY1M6h_N25yXNs69L6PE3sfsWnOqX18f49TPTzIsMlA>
X-ME-Received: <xmr:nHqlaebH6i6sHWHQxfF3FMRBeExkxkO3KKl4jBAemiqnnbBbi9_ppDBInkHvOeaxd3e5dBcYpCIYpCFFSJn4QpckUnAtZlhetmMyIv3AHQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvheejieduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucgovfgvgihtqfhnlhihqddqteefjeefqddtgeculdehtd
    dmnecujfgurhephfffufggtgfgkffvvefosehtjeertdertdejnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpedvgedvleejvdefkeetieejheelledtvefgteffffeuvddtvddtffeikefhvedv
    gfenucffohhmrghinhepghhithhlrggsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthht
    ohepuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvg
    hrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:nHqlaRVCDQ63iSQzjlL7DKp7yeVhJyMH8yIOG3Gm_fF6uIlBcgdtRg>
    <xmx:nHqlaV32hKdKOwnXKj30dQk0LSSYCTodlePCgWae0L-augykuQFYpA>
    <xmx:nHqlaYZgW06jUuNlDSEi7VsZZqZrGX75rsWgsepiDl_WNOYSW1a8pA>
    <xmx:nHqlaYqGJ7QNLyWs4fa2mHAmisw5WjtH8nhLZCb4XOxKG-SBdRjs2Q>
    <xmx:nHqlacdAWt-2prs1AX5Hs4Tw_SZ25HmGuoFNZM350tXowjYDG3Xh3RlI>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 2 Mar 2026 06:55:07 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 12aabbf7 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 2 Mar 2026 11:55:06 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 02 Mar 2026 12:55:02 +0100
Subject: [PATCH] ci: unset GITLAB_FEATURES envvar to not bust xargs(1)
 limits
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260302-pks-msvc-meson-xargs-v1-1-8e42abd879ce@pks.im>
X-B4-Tracking: v=1; b=H4sIAJV6pWkC/x3MSwqAMAwA0atI1gZqW79XERdaowaxSgNSEO9uc
 fkWMw8IBSaBLnsg0M3Cp08o8gzcNvqVkOdk0EpXyiiN1y54yO3wIDk9xjGsgs5OzpS2rVTdQEq
 vQAvHf9sP7/sBML2S8GYAAAA=
X-Change-ID: 20260302-pks-msvc-meson-xargs-c4bc35496078
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.3

We have started to see the following assert happen in our GitLab CI
pipelines for jobs that use Windows with Meson:

  assertion "bc_ctl.arg_max >= LINE_MAX" failed: file "xargs.c", line 512, function: main

The assert in question verifies that we have enough room available to
pass at least `LINE_MAX` many bytes via the command line. The xargs(1)
binary in those jobs comes from Git for Windows, which in turn sources
the binaries from MSYS2, and has the following limits in place:

  $ & "C:/Program Files/Git/usr/bin/bash.exe" -l -c 'xargs --show-limits </dev/null'
  Your environment variables take up 17373 bytes
  POSIX upper limit on argument length (this system): 12579
  POSIX smallest allowable upper limit on argument length (all systems): 4096
  Maximum length of command we could actually use: 18446744073709546822
  Size of command buffer we are actually using: 12579
  Maximum parallelism (--max-procs must be no greater): 2147483647

What's interesting to see is the limit of 16 exabits for the maximum
command line length. This value might seem a bit high, and it is indeed
the result of an underflow: our environment is larger than the POSIX
upper limit on argument length, and the value is computed by subtracting
the former from the latter. So what we get is the result of `2^64 -
(17373 - 12579)`.

This makes it clear that the problem here is the size of our environment
variables. A listing sorted by length yields the following result:

  $ Get-ChildItem "Env:" |
      Sort-Object { $_.Value.Length } -Descending |
      Select-Object Name, @{Name="Length"; Expression={$_.Value.Length}}
  Name                                          Length
  ----                                          ------
  GITLAB_FEATURES                                 6386
  Path                                             706
  PSModulePath                                     229

The GITLAB_FEATURES environment variable makes up for roughly a third of
the complete environment. This variable is a comma-separated list of
features available for the GitLab instance, and seemingly it has been
growing over time as GitLab added more and more features.

Fix the issue by unsetting the environment variable in "ci/lib.sh". This
ensures that the environment variables are now smaller than the upper
limit on argument length again, and that in turn fixes the assert in
xargs(1).

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
Hi,

this patch series fixes another issue that we saw creeping into GitLab
CI jobs for MSVC+Windows. The root cause is that our environment
variables have grown too large, and thus xargs(1) was hitting an assert.

A test run of this can be found at [1].

Thanks!

Patrick

[1]: https://gitlab.com/gitlab-org/git/-/merge_requests/514
---
 ci/lib.sh | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/ci/lib.sh b/ci/lib.sh
index 3ecbf147db..42a2b6a318 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -231,6 +231,10 @@ then
 	distro=$(echo "$CI_JOB_IMAGE" | tr : -)
 elif test true = "$GITLAB_CI"
 then
+	# This environment is multiple kB in size and may cause us to exceed
+	# xargs(1) limits on Windows.
+	unset GITLAB_FEATURES
+
 	CI_TYPE=gitlab-ci
 	CI_BRANCH="$CI_COMMIT_REF_NAME"
 	CI_COMMIT="$CI_COMMIT_SHA"

---
base-commit: 2cc71917514657b93014134350864f4849edfc83
change-id: 20260302-pks-msvc-meson-xargs-c4bc35496078

