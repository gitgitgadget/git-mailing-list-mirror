Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F075229B18
	for <git@vger.kernel.org>; Tue, 11 Mar 2025 21:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741728311; cv=none; b=lpcuLBvGjT2V1xlJE2GAwukvrIWsnBl0pz3Ujn4GFKXChQnxj7uphVAuJEt1mh+Fpgc3FVkM9MR3rksfHagipHVsTBMiripALqc0oxrtSIkF7rw+0zNY2WRZJPsfQ2rhmT7D9JMVGSYjHQTkSW0XbRg1OsnD2rXC0vycMELyBwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741728311; c=relaxed/simple;
	bh=393jHk+kNDR+u6p3k4BenO9Idf8kD19+ysqWChQRYzM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BIT9cd4N3xPwCNZxMbGnNduQelLHkhLcdqTnqoWfAkuGiI/VSfLA2GRufXRzI+wKNlgagJVBAr6dW+kQoYkk7TQQ/Gy0ue4CBCh+LSXcxxTF0r94IDX4WaCt3I7hzsOaj/1LPRuWRPvWFlsTG48JslPUiCzumla13GNGvjPv00k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=PLn9Q8hV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hDwxSFwx; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="PLn9Q8hV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hDwxSFwx"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfout.phl.internal (Postfix) with ESMTP id 96BE11382DC2;
	Tue, 11 Mar 2025 17:25:08 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-08.internal (MEProxy); Tue, 11 Mar 2025 17:25:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1741728308; x=
	1741814708; bh=aJW9cciD/JoCSsobLfiHZ2RR2UqWM844+p9uWheE0cs=; b=P
	Ln9Q8hV5+DRVpL3LfHoTjVSu5gf/b37P2FOVfmyKKEN5/nAtywdbzgtEdCy+2VHd
	lq/Ax90wwCxCBWVT8OmXixFb6T5aI41dCTUIAMlBrtibC+c8Qad2mBaxSS6M5oxe
	OAS/KWNQPNWwWu8PBvJlb4HDwlPTrgP5AcaNI/18T0Z3ykQsx/5YM1hJ8dMjPHM7
	Fa7JayLnbaZtEhFHD31I5pIyj3SysE6BiTYMErGpK4QOUbaDvPSuSSYgPRmiPddr
	VEeqzb3PeLs8rrVpSBsZlYULEAJ4WNmvSClpxCcI3yGTYIH76C6ne5cTAjuGep9V
	2tW7ly+fPpsoNf+zRMDpQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1741728308; x=1741814708; bh=aJW9cciD/JoCSsobLfiHZ2RR2UqW
	M844+p9uWheE0cs=; b=hDwxSFwxrHygpW6Dsw9zpYxBSfG8/BZ49hHIgK+TVlIH
	H6ETBvzfD/t0gnIMXeArpqdGERHDgXVM/rQk4zjWuVJIA7xfEWIspDSTGaPhLUg5
	boyhPpUs1lmPVG9jVFU42ZLVznUTMXsHutjCklcNiCIP//C85rdxdmrCMs8gSUMW
	N/PCU97R9EKuFjrfImLPs5hft8YXgfxPCug1SfQJLH+Tc0UD2Op623EBk9ghMsUC
	LvoL21FOSItmyLoCT3pCdTSn1BlYwH3KFdtNsEo7CZ+3CjhIAFxVQGiFB4ds4x9G
	AoG8C4ixdtZIxDyAmEDtj5Hly/6/7qIcFIEkDPy51A==
X-ME-Sender: <xms:NKrQZ5GM0QH72jXLpV7KNn6iSSD9uKLltc41S4WTKVsZqXLvj8g-zg>
    <xme:NKrQZ-U7JaZX2bJi-jXYKwBanTnR176i-O2NUkgP0blELYWg-ZPSpGhMXT-Uzj8VG
    TTglrPv2KYoiBPIJg>
X-ME-Received: <xmr:NKrQZ7KWJvbGvcB3ealL8OqPi9v4XVHCmahyiiXX22L6NiL6s6-mm9liX66NexWdPZDY5LWxSOotT2Jnpm_h-_Xcc-uJXV8vLGc5>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduvdefvdejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvf
    fufffkofgjfhgggfestdekredtredttdenucfhrhhomheplfhunhhiohcuvecujfgrmhgr
    nhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvghrnheple
    evieefieeuffeugefhveeugefgfeevvdefleevuedvfedvudefkeehtdeftdegnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrh
    esphhosghogidrtghomhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhope
    hgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:NKrQZ_GBzQaHlGXoD-1HDTXhfb-5p7zHZby-WyDDjmLMmOSYpnzdBA>
    <xmx:NKrQZ_WdroxT8XjSLwOKlOqsdEPeoD0LZ8A2vpdrpuaVki2T1V3rpQ>
    <xmx:NKrQZ6P7BV0ObtwgsuONem3HOzPc5qrTOHD_m4dnFhXhx2g_BFCc8g>
    <xmx:NKrQZ-0ngsKz_KV_HCS9zI7ig9D9ItoMlqlIAXjFbpuFqgJLB2KW4w>
    <xmx:NKrQZ8iU0VJAxRDoELnEJACAz6B-Oia6FzWm1IfyWUuIA8mq4lp03LKB>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Mar 2025 17:25:08 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH v2 1/6] t: document test_lazy_prereq
Date: Tue, 11 Mar 2025 14:25:00 -0700
Message-ID: <20250311212505.2920181-2-gitster@pobox.com>
X-Mailer: git-send-email 2.49.0-rc2-181-g28e223d67e
In-Reply-To: <20250311212505.2920181-1-gitster@pobox.com>
References: <20250310231652.3742490-1-gitster@pobox.com>
 <20250311212505.2920181-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The t/README file talked about test_set_prereq but lacked
explanation on test_lazy_prereq, which is a more modern way to
define prerequisites.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/README | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/t/README b/t/README
index 53e5b4a710..3ce9f5a393 100644
--- a/t/README
+++ b/t/README
@@ -818,7 +818,7 @@ Skipping tests
 --------------
 
 If you need to skip tests you should do so by using the three-arg form
-of the test_* functions (see the "Test harness library" section
+of the test_expect_* functions (see the "Test harness library" section
 below), e.g.:
 
     test_expect_success PERL 'I need Perl' '
@@ -965,6 +965,27 @@ see test-lib-functions.sh for the full list and their options.
 	    test_done
 	fi
 
+ - test_lazy_prereq <prereq> <script>
+
+   Declare the way to determine if a test prerequisite <prereq> is
+   satisified or not, but delay the actual determination until the
+   prerequisite is actually used by "test_have_prereq" or the
+   three-arg form of the test_expect_* functions.  For example, this
+   is how the SYMLINKS prerequisite is declared to see if the platform
+   supports symbolic links:
+
+	test_lazy_prereq SYMLINKS '
+		ln -s x y && test -h y
+	'
+
+   The script is lazily invoked when SYMLINKS prerequisite is first
+   queried by either "test_have_prereq SYMLINKS" or "test_expect_*
+   SYMLINKS ...".  The script is run in a temporary directory inside
+   a subshell, so you do not have to worry about removing temporary
+   files you create there.  When the script exits with status 0, the
+   prerequisite is set.  Exiting with non-zero status makes the
+   prerequisite unsatisified.
+
  - test_expect_code <exit-code> <command>
 
    Run a command and ensure that it exits with the given exit code.
-- 
2.49.0-rc2-181-g28e223d67e

