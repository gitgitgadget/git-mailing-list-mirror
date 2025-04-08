Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8E8D22F145
	for <git@vger.kernel.org>; Tue,  8 Apr 2025 20:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744143373; cv=none; b=PJLRKUiQnHMG6f0Sp0yo/zpzvg/YeICrE+kIAaTONdWjk1YyVazTBRV8ppVPE1aKKoGP0AvpK1xJUa/ZAGfIOHkwQBchbF0//Nci3sj+x2MuUTjOF8f9RuUh1c/YzwrSVbZUjl5cPhAhrBsNg3Y52+6QvP03/L+sRJ17wtlW66Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744143373; c=relaxed/simple;
	bh=yb6mSUVcGO9VLShWNQty+9EDqfXiZBMSMSLSnOdhw00=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hFPdLseBkajysG/i70PAzJzfEG+35XnXE7kJ+s1r86kK5I5Yg3UE7r4c8wu49KPTZcFgUKj8qbrde4nSWTuriROh74YXbax7ahbbePA4lBF5Havq5nWsiUkpXquhnRezZhkyjdNvFN61mhyZgGqAY64KRNVrEzNoomIFcKAGA8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=dQ/XkF44; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LIaNFlEq; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="dQ/XkF44";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LIaNFlEq"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id E861325400D0;
	Tue,  8 Apr 2025 16:16:09 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Tue, 08 Apr 2025 16:16:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm1;
	 t=1744143369; x=1744229769; bh=PhaJtn6da+70K90ideRqwX39aSruZRM9
	lEJiOVujXzs=; b=dQ/XkF44oSicQQH0w+j517jX4ZihiP7KfrnirB3YFNmVjOli
	kNAtaekxwis/mkLgftUl84crXh4TD0iFFht1dakhj6O3K/xL5cEXfnsOeVQg6Cz2
	xvhZNipPXdvCW4s1BcgOSyk3eoWv3BNZb6CZmTE+WqKaU5tDYiCP1BB4Fho3t3sg
	4pTsDM4Z7NHTBnHOgHMljKkms2uzJkggFpHiSfMzI6KzbCpZDbfVOvnNELtJRlCi
	D2Q4OvTZxDk0VyhVx+5TsHChkfUKRT+mXzRQ24IhBjSojROs056hA905tdOCABUl
	l1Ax4TCbk2xNSCia40hHq41I7BEURNrANH4XhQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1744143369; x=
	1744229769; bh=PhaJtn6da+70K90ideRqwX39aSruZRM9lEJiOVujXzs=; b=L
	IaNFlEq2/eOl0IXiAWxTIJHWxhu0rXoaDfvbC66XKC2EBVgpwCcRWDG52cqyCvNr
	Bb+AwLYolEs7Sg1dZo6wMdEAB7XguUYy1+zN/k9GGuy+3f/aoj6p/EJMXZ6NIoEi
	RMZPNhgrYCGmO4iwtxpX4802t04DK2QHRqtN1j9Ipj7AvLzR6xRhyttUdc0OXmBx
	DyrNkqPEm3clPmJY02TpQZwX+g1lzcR5X6H3UquW84eL/zBvde+RU5hdOupyTg1Y
	8rtnGJR/VxsENkMZRsdJB6IeHc1xurvtN4gwgMdJfPlKsCH6ch+wD0y0lHt/cxPR
	s0Y9g/IoHAhQMHUIHHNMA==
X-ME-Sender: <xms:CYT1Z2Vcen5WzPBBnyd-JyCekFO7CGQ4uIol5-yQOGJ4i9qX1WP2MQ>
    <xme:CYT1ZykxLtTnsVkZYR7gHFn3tGZxex1V0H6o-Bzvtvmvy82_rBclzuAFXgUB-M1ES
    njm7IqSyjdn48zevQ>
X-ME-Received: <xmr:CYT1Z6YcAq8QQW440uGzk6UGR7SQjTfnkfK-ZSmSIAyvH8meUeN-RWHhA-ptHkvkV4F2Ldn2mKMf-AjF5RTNvwv8QnLjpPfbee9Y>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvtdegtdefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefufffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhephffhtdegffeiieekleeitdekvdffieffgfdv
    vdffleetledtudehtddvtdeileefnecuffhomhgrihhnpehgihhthhhusgdrtghomhdprg
    iiuhhrvgdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhl
    fhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeehpd
    hmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghl
    rdhorhhgpdhrtghpthhtohepshgrnhgurghlshestghruhhsthihthhoohhthhhprghsth
    gvrdhnvghtpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthho
    pehjohhhrghnnhgvshdrshgthhhinhguvghlihhnsehgmhigrdguvgdprhgtphhtthhope
    hgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:CYT1Z9XCjgsLaVVA9a-2AfrB5LtbFYVmQTmB-7NDWcWoIg18pqSilQ>
    <xmx:CYT1ZwkXdL1UVCHOeOvhkZ8JxQgAyyE69kEGHT3CEI2bf4EnFtr-aA>
    <xmx:CYT1ZyeBUoIpDGfn0mAgFIEzENLrEieJVwY19wLtGzgHjc_B6W1SmQ>
    <xmx:CYT1ZyGZu_EctJUDZQddGvabsGp103mS0IoxJoeWTL6C3ViOjqrCQg>
    <xmx:CYT1Z_FrxMO2azd7Y4dPdExw07tAhTJ26AlwfyyZwHtGHQEl80GbRLf1>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 8 Apr 2025 16:16:09 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>, Taylor Blau
 <me@ttaylorr.com>,
    Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [RFH] GitHub deprecates Ubuntu 20.04 Actions runner image
Date: Tue, 08 Apr 2025 13:16:07 -0700
Message-ID: <xmqqo6x6wgs8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

It seems that we are hitting https://github.com/actions/runner-images/issues/11101
which deliberately breaks CI jobs running on Ubuntu 20.04 images, in preparation
for its removal targetted for Apr 15th, 2025.

The following is a random/blind attempt, but I need a lot of help ;-).

[jc: brian and Taylor CC'ed for their ac112fd4 (Add additional CI
jobs to avoid accidental breakage, 2024-10-31)]

 (1) I do not know if the deprecation schedule at GitHub is the same
     for native runner images and dockerized ones.  Do we want to
     leave the linux-TEST-vars that uses image ubuntu:20.04 alone
     for now?

 (2) If we were to update it to ubuntu:22.04, would gcc-8 still be
     the right "ancient-ish" version of the compiler, or should we
     update it as well?

 (3) Linux32 job running on image i386/ubuntu:focal has comments
     that says it is supported until 2025-04-02; should we simply
     drop that job, as 32-bit platforms are less and less relevant
     these days?  It is not so urgent but debian-11 job also should
     be replaced with something slightly newer next summer.

 (4) I have no idea how the "sparse" job, which seems to download
     pre-built sparse using magic incantation

      - name: Download a current `sparse` package
        uses: git-for-windows/get-azure-pipelines-artifact@v0
        with:
          repository: git/git
          definitionId: 10
          artifact: sparse-20.04
      - name: Install the current `sparse` package
        run: sudo dpkg -i sparse-20.04/sparse_*.deb

     is supposed to be updated.  Should that be coordinated with the
     git-for-windows project, where its .github/workflows/test.yml
     has a similar insn to build sparse-20.04?

     It appears that Dscho (CC'ed) is futzing with the generation of
     sparse package on Ubuntu 20.04 and 22.04 and getting affected
     by the same 20.04 brownout

     https://dev.azure.com/git/git/_build/results?buildId=2396&view=results

     so probably I do not have to worry about it and let Dscho take
     care of the whole thing?


 .github/workflows/main.yml | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git c/.github/workflows/main.yml w/.github/workflows/main.yml
index 9959b61ece..1d4422c898 100644
--- c/.github/workflows/main.yml
+++ w/.github/workflows/main.yml
@@ -372,7 +372,7 @@ jobs:
           image: ubuntu:rolling
           cc: clang
         - jobname: linux-TEST-vars
-          image: ubuntu:20.04
+          image: ubuntu:22.04
           cc: gcc
           cc_package: gcc-8
         - jobname: linux-breaking-changes
@@ -446,7 +446,7 @@ jobs:
     if: needs.ci-config.outputs.enabled == 'yes'
     env:
       jobname: sparse
-    runs-on: ubuntu-20.04
+    runs-on: ubuntu-22.04
     concurrency:
       group: sparse-${{ github.ref }}
       cancel-in-progress: ${{ needs.ci-config.outputs.skip_concurrent == 'yes' }}
@@ -457,9 +457,9 @@ jobs:
       with:
         repository: git/git
         definitionId: 10
-        artifact: sparse-20.04
+        artifact: sparse-22.04
     - name: Install the current `sparse` package
-      run: sudo dpkg -i sparse-20.04/sparse_*.deb
+      run: sudo dpkg -i sparse-22.04/sparse_*.deb
     - uses: actions/checkout@v4
     - name: Install other dependencies
       run: ci/install-dependencies.sh
