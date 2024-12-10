Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BABA923DEBA
	for <git@vger.kernel.org>; Tue, 10 Dec 2024 12:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733832128; cv=none; b=pSstiTIaZRcqaOwxeR2oBg+JLxKCDq1rWsXCzhQMzIa+QmO+m8q1lTyi3exJHsphm3fE91Z37CCmcj3FeZtCHBOi6cEB+O3jyAy6QJjs9IxTT0pOOcGnbg2AyA9NbL0t7WmeMQCCOpqJHKpIenRPHjZQWI0i04CRk0L9U4uZhX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733832128; c=relaxed/simple;
	bh=9OXPa5LllM6RVL36My+RsPILfAYF5uoKETpjllJfkzA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=uHMnzE82EqFr54f7dj5dviD8Ut2r0YGcXpzluzhxHWGs/4cwJwOxUIGcRjRWrNONDYQeaAGRQwktsFBBXfNzpOyAtqP3G58Hfw3PKNdza1eWAN6ihS33NUb7I5CY+BmAxm8K1pL7i58+tUn7Sw2pisXaxC7GiABn+Lk3H+NoLIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=TNAQmUZI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VmzyWLI2; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="TNAQmUZI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VmzyWLI2"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id 72DC6114018C;
	Tue, 10 Dec 2024 07:02:05 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Tue, 10 Dec 2024 07:02:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1733832125;
	 x=1733918525; bh=Bpkfm7zaxBKZg9H57cXvoxpyl/afqgvxqSD1prq7pjo=; b=
	TNAQmUZI6iYmDbzQp+syXMskt1s3Ld8OrYsZSoCfc1bW57qX8al4ykudLDEdAxQ0
	odvxfNhARRPzxQTMm/HEL7On+8lXkykb0RFP4N5ZKYXmrdoOPtZQiB10Bj3W9Pt7
	m3UmLzzxjx1sNzrugDFploA6XlhX2jtAXKV2hbmefKih2fHNvUz5QA2kAaAZQrwz
	67S7DtlYqw4BX/NgIA3QHorL2512tggsY9CUnapyd2/y7opYLauiNlXJJww/tOY3
	cmqxZsq+NPnX57Y35S3DOHZDWtzojtvag76c5OEetm+e2zaJcCO9r5/qXMRRmNki
	0HJkKTBNTJHrEgrlmfRweA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1733832125; x=
	1733918525; bh=Bpkfm7zaxBKZg9H57cXvoxpyl/afqgvxqSD1prq7pjo=; b=V
	mzyWLI2vEOMMsPVg13rCxlOsSqJCEj/Z38sV/6mu7HasZFSS8Ry9ACefc2U5SFmM
	Evegr80UwazI39mhMVuLtxundOxP6EB/5Bcfg7qQ/J6YG1yvCKU9NQRJqCZVbNlX
	rr3RffMaQ2uU/7pXm7bwulxaW4zbcZIxG8Qw8APjuG8qWZash+qXXilZUdrK7CHM
	pEM3G714nu3si413oR07IEmLHKURpfIgHBzFrdw0UaTAejSlHwLADcL4znXga6qT
	lFU4j7p37a6zPlwSx/5CH3zPe0AXzrBH9s4Hpu3OLPT5t5XQW1Srct309SHDWZGB
	XN8kyINpVdJ0r+w1FayMg==
X-ME-Sender: <xms:vS1YZ_CbjDk0Cwu3F2A0pR3swhSS-ROZSv_yfUexV_0hJYEr5mwuNg>
    <xme:vS1YZ1ghLv770hfFc0Mk2Fbpe0AMbkroMyImOnZ9pb7ysAOzvP5LX4pl8N0ROgoP1
    hwSp_oFn6wN_wtMcg>
X-ME-Received: <xmr:vS1YZ6maGbB_YlTVlL3xgnblm1Z0DtrqxbZcrj9LBZ-eDklHo3kFLXRWgo8vIa0Ct21LJfE1MvWlgh6Nf0VKKlRygP6ZKAbkYs3c7FMi16zx>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrjeekgdefgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhufffkfggtgfgjghfvfevofesthejredtredtjeen
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepteeuueehhffhiedtueehtddtieekfedtudehtdehfefh
    geffveeggedthfehuedvnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhush
    htvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
    pdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehkrg
    hrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghr
    rdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehoshifrghlugdrsghuugguvghnhhgrgh
    gvnhesghhmgidruggv
X-ME-Proxy: <xmx:vS1YZxwcimIEn3_fefPHG5Tt1NhYhIsIkzslX7775qRwk3Zrot3j2Q>
    <xmx:vS1YZ0TkInju0gkE-wd8aQ2pwvy93CZ3sUKiehXcLZLr5Pd-stMGnQ>
    <xmx:vS1YZ0blhmf8FY83RuQ4sUxRaq8EKtzMoRg95nda6dyier-7ODszzQ>
    <xmx:vS1YZ1QUksmK8jfkgvRA13M7e3dkZIkORw7JvTJc9kWi6RrtyO-57Q>
    <xmx:vS1YZ6dtkKNFiIGNvqdaxovgQ2c5dH8sDgOYx91wIopx6-C3twcRBSB9>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 10 Dec 2024 07:02:04 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 3b7ff472 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 10 Dec 2024 12:00:30 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 0/4] Random improvements to GitLab CI
Date: Tue, 10 Dec 2024 13:01:45 +0100
Message-Id: <20241210-pks-ci-section-fixes-v2-0-e087cfd174f4@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKktWGcC/4WNSw6CMBCGr0Jm7Zi2YgVX3sOwoHWUiRFIhzQa0
 rs7cgGX3/9cQSgxCZyrFRJlFp5GBberIA79+CDkmzI442rrjMf5KRgZheKiUbzzmwRtCK2NFI4
 mNKDVOdFmaPPaKQ8sy5Q+20u2P/XPYLZo8NQHG3xLB183F43t+QVdKeUL/9dIgrUAAAA=
X-Change-ID: 20241206-pks-ci-section-fixes-1bb91ceb50b8
In-Reply-To: <20241206-pks-ci-section-fixes-v1-0-7ab1b69e3648@pks.im>
References: <20241206-pks-ci-section-fixes-v1-0-7ab1b69e3648@pks.im>
To: git@vger.kernel.org
Cc: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>, 
 karthik nayak <karthik.188@gmail.com>
X-Mailer: b4 0.14.2

Hi,

this small patch series includes a couple of more-or-less random
improvements to GitLab CI.

Changes in v2:
- Use "%s" to inject variable data into section headers instead of
  converting to echo.
- Link to v1: https://lore.kernel.org/r/20241206-pks-ci-section-fixes-v1-0-7ab1b69e3648@pks.im

Thanks!

Patrick

---
Patrick Steinhardt (4):
      gitlab-ci: update macOS images to Sonoma
      ci/lib: remove duplicate trap to end "CI setup" group
      ci/lib: do not interpret escape sequences in `group ()` arguments
      ci/lib: fix "CI setup" sections with GitLab CI

 .gitlab-ci.yml | 4 ++--
 ci/lib.sh      | 9 ++++-----
 2 files changed, 6 insertions(+), 7 deletions(-)

Range-diff versus v1:

1:  c52dfd96a6 = 1:  c98da734b2 gitlab-ci: update macOS images to Sonoma
2:  6214c8b6d5 = 2:  d36bafc387 ci/lib: remove duplicate trap to end "CI setup" group
3:  b56c6ec0a2 ! 3:  16882b0033 ci/lib: use echo instead of printf to set up sections
    @@ Metadata
     Author: Patrick Steinhardt <ps@pks.im>
     
      ## Commit message ##
    -    ci/lib: use echo instead of printf to set up sections
    +    ci/lib: do not interpret escape sequences in `group ()` arguments
     
    -    We use printf to set up sections with GitLab CI even though we could
    -    trivially use echo. This may cause problems in case the argument passed
    -    to `begin_group ()` or `end_group ()` contains formatting directives as
    -    we use them as part of the formatting string.
    +    We use printf to set up sections with GitLab CI, which requires us to
    +    print a bunch of escape sequences via printf. The group name is
    +    controlled by the user and is expanded directly into the formatting
    +    string, which may cause problems in case the argument controls escape
    +    sequences or formatting directives.
     
    -    Simplify the code to instead use echo.
    +    Fix this potential issue by using formatting directives to pass variable
    +    data.
     
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
     
    @@ ci/lib.sh: elif test true = "$GITLAB_CI"
      	begin_group () {
      		need_to_end_group=t
     -		printf "\e[0Ksection_start:$(date +%s):$(echo "$1" | tr ' ' _)[collapsed=true]\r\e[0K$1\n"
    -+		echo "\e[0Ksection_start:$(date +%s):$(echo "$1" | tr ' ' _)[collapsed=true]\r\e[0K$1"
    ++		printf '\e[0Ksection_start:%s:%s[collapsed=true]\r\e[0K%s\n' "$(date +%s)" "$(echo "$1" | tr ' ' _)" "$1"
      		trap "end_group '$1'" EXIT
      		set -x
      	}
    @@ ci/lib.sh: then
      		set +x
      		need_to_end_group=
     -		printf "\e[0Ksection_end:$(date +%s):$(echo "$1" | tr ' ' _)\r\e[0K\n"
    -+		echo "\e[0Ksection_end:$(date +%s):$(echo "$1" | tr ' ' _)\r\e[0K"
    ++		printf '\e[0Ksection_end:%s:%s\r\e[0K\n' "$(date +%s)" "$(echo "$1" | tr ' ' _)"
      		trap - EXIT
      	}
      else
4:  a2bf5ac44f = 4:  6b67c4c238 ci/lib: fix "CI setup" sections with GitLab CI

---
base-commit: e66fd72e972df760a53c3d6da023c17adfc426d6
change-id: 20241206-pks-ci-section-fixes-1bb91ceb50b8

