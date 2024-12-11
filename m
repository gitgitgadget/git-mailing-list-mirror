Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6026C208984
	for <git@vger.kernel.org>; Wed, 11 Dec 2024 10:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733914620; cv=none; b=FgqnoxKUzFkYLy1oLGYcF1gjliutwNTDcH7QxGntol8bVaioLtGfmaUtlQIOTmD9aipobjbmHmO4IunbqzydynAlb3QK9Y4u0eUnyT0hEfVmuKywCNfccJELjfSf6SCEmURtwIMUcmPOO5VH7qF9diaaWBNsqWNQwVGfeAKr1NA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733914620; c=relaxed/simple;
	bh=4f69HuToOJlL9G9JHjhB5PBNqibdx5o7Luvuepza/RE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=T+8+Xyd1c4yFlmSWt0K7iUEXB9bah5RAWIS7bUBCBTW0vUbp63KNJ5sj4C2kGELE5kHkvHxOmofP8bqV/V1ahS+XddpKh+qnhlZMW4vEsDbYWfzHxGeg+TC4mgHElmXV8dI+3opuz9VVdYbpD/km9Axg1wXb3RC8PzhzyAwtzMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=opWeHwPt; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VMTFKxiG; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="opWeHwPt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VMTFKxiG"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 4A04C2540267
	for <git@vger.kernel.org>; Wed, 11 Dec 2024 05:56:57 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Wed, 11 Dec 2024 05:56:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1733914617;
	 x=1734001017; bh=yo9rPYSZk2gm83u5Ipt8nqXMKkyPAr7TXzfep/ZnSDM=; b=
	opWeHwPt6FpjO9IHwkh+f6RM9h5YKuHQkV8QJGB/MUd2aBmG4p2ZphuPnQhCTnI6
	nIjydPGW3rkIdj9FPfEQ29hzOPMJ4FLCkueSTSa/RJZTfFFoQaYP92xSoq+Z58i6
	I4pMy0bCGBo4bWSIA1/N7M+Zt636jAnUd7FOZ+TVSaynX73jCSVfuaCZIuzsAvLz
	+6r42CPg6q9fM/PRGqGpHYc20edRzahKcVT3uudjRRLMqhOB11QhQydqHqyGcQk0
	pM3t7Kof2uimUcUIhiO0g9oZgbPkFQyJD05HPdw3FOu73hcSeVyh6H0nIRDJfMpL
	Y90ezA3GJF724mnxT/4ewg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1733914617; x=
	1734001017; bh=yo9rPYSZk2gm83u5Ipt8nqXMKkyPAr7TXzfep/ZnSDM=; b=V
	MTFKxiG+2w8hqw6W8xFWFgnqLZR4pfUPqPT6+wTPh9g6F6Koc1/N6CwhZD/zv1tS
	wgDz5PBUTQDvtetGHOXDnlPv5ghKMI8LHKVXDY6McSanF/3QeNSYlWTsB7YwpZ9v
	9SPsaexk18nFO/mEpkH2oVlTsbBXgUOtCc6Cfwl7rXIU/Xk7WKvEx0FvKvWby3eP
	V8eFKxUhRudRk3nAXKbuFZwu5W++WxC40LmZQKPXAcHokewfZvWdCfqScvSB8rQC
	TYtqwBrTiN4qN10jCVWmOfS1QjIhPZDIcKWd8D4qQpr6F0/ZFXrlI+omjmG5ICl9
	BAEd11LUYZHMe+B9kXF7Q==
X-ME-Sender: <xms:-W9ZZzjV8wnnTMeeIb4fn87wC4eJgm-9MB7qj2FGk9yXYouws6AZCA>
    <xme:-W9ZZwA1-LWMkJfDKnuIInXjdbQzHjLhGX2DSiMmvDT-Vy9ruLAGWEi3x8DnMn_Gh
    HJGDjCwjZbpO9UrQw>
X-ME-Received: <xmr:-W9ZZzHprE2gYn8VBO7dyO6CDn4-7XnWNjCrHBgco_XzljRVdeVvOfk9ZONNf9twQTcCNt9F93cHtH7hMM_9V9RbuWCkfgNqHB7i13I-IdFDhQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrkedtgddvvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephfffufggtg
    fgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvd
    ekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsg
    gprhgtphhtthhopedupdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:-W9ZZwS8MCiDhwXZgJn_Zi0ovLXCdz1zsGUBvopmNXn1k9V59J2a1w>
    <xmx:-W9ZZwxqn-3nCIppzmxKEe12QViFlKPXB-v8jBSfR-f-_h1gM5cjSA>
    <xmx:-W9ZZ26LHRKfDpMFOSLEJ98cTtfuvxyA62ekZ5dtUq9ca8-g4o2u8w>
    <xmx:-W9ZZ1zD3qEF91OW4gRs7knUky0JHKQdmBfPnytll075QOROng4fQg>
    <xmx:-W9ZZ9rD-TYXCb176BGPsoGqmHZQeJtArziYDGQrRkGvTBDdYOUqMAUo>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 11 Dec 2024 05:56:56 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id ca0b630e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Wed, 11 Dec 2024 10:55:20 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 11 Dec 2024 11:56:39 +0100
Subject: [PATCH 3/5] ci: repurpose "linux-gcc" job for deprecations
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241211-pks-remote-branches-deprecation-v1-3-1431e2369135@pks.im>
References: <20241211-pks-remote-branches-deprecation-v1-0-1431e2369135@pks.im>
In-Reply-To: <20241211-pks-remote-branches-deprecation-v1-0-1431e2369135@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.2

The "linux-gcc" job isn't all that interesting by itself and can be
considered more or less the "standard" job: it is running with a
reasonably up-to-date image and uses GCC as a compiler, both of which we
already cover in other jobs.

There is one exception though: we change the default branch to be "main"
instead of "master", so it is forging ahead a bit into the future to
make sure that this change does not cause havoc. So let's expand on this
a bit and also add the new "WITH_BREAKING_CHANGES" flag to the mix.

Rename the job to "linux-breaking-changes" accordingly.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 .github/workflows/main.yml | 2 +-
 .gitlab-ci.yml             | 2 +-
 ci/run-build-and-tests.sh  | 3 ++-
 3 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index 32d35d2257812f02121b20c3cae342d626481553..46b96fb96cc6e2659fe0b4b640f7e671587d059a 100644
--- a/.github/workflows/main.yml
+++ b/.github/workflows/main.yml
@@ -269,7 +269,7 @@ jobs:
           - jobname: linux-reftable
             cc: clang
             pool: ubuntu-latest
-          - jobname: linux-gcc
+          - jobname: linux-breaking-changes
             cc: gcc
             pool: ubuntu-20.04
           - jobname: linux-TEST-vars
diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index b86bb0bdb3363e06e6fe4195c34babd67cf7e8cc..492e5d9082dbdb3389c173f2b5a45fe43f4bea41 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -43,7 +43,7 @@ test:linux:
       - jobname: linux-reftable
         image: ubuntu:latest
         CC: clang
-      - jobname: linux-gcc
+      - jobname: linux-breaking-changes
         image: ubuntu:20.04
         CC: gcc
       - jobname: linux-TEST-vars
diff --git a/ci/run-build-and-tests.sh b/ci/run-build-and-tests.sh
index 2e28d02b20f2469afddc4e04fdbd18465babb1ef..2ccd812fb4e025be3b8e9ab2ec6ae44e92944ab0 100755
--- a/ci/run-build-and-tests.sh
+++ b/ci/run-build-and-tests.sh
@@ -13,8 +13,9 @@ esac
 run_tests=t
 
 case "$jobname" in
-linux-gcc)
+linux-breaking-changes)
 	export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
+	export WITH_BREAKING_CHANGES=YesPlease
 	;;
 linux-TEST-vars)
 	export GIT_TEST_SPLIT_INDEX=yes

-- 
2.47.1.447.ga7e8429e30.dirty

