Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67A81351C3B
	for <git@vger.kernel.org>; Wed, 25 Mar 2026 06:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774419688; cv=none; b=mshm2axRQvqmHkbopJbbVXAUWu4lkecg01g0IZFCKheGDw+Qco1TH/rCr8mp21ijRGfXWtqqKK0U9rdfXUQKvFCMAAgStok5mqG7WHCvFpyBT50YQzABoq6t09Kl3BcXHJ+ic13W9eLLh6bnaj53m0kMTZzbjHkzLpFf0JF+lYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774419688; c=relaxed/simple;
	bh=R5TJCmqDrEs0u8GTDb/Mih++ob8IkrjxGVep5AjSGj4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ceP+Kj7O7x2h+u8r3RxHl3prsy2eto9eT0N/uExAQElfWjuPInCZlozPBnnsn4o9aDzWeUjcTUrZZpcKVj0VyUQdy6xo1x5yYt7YoKb5+FwDNyeQ/2LCwW7Ll7Ni1ULWzRKZBjLCM9pW7IeD57wFwDYGoPAJSlazVtZwUREuGhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=kJjBOgZ5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=j1iDsrnv; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="kJjBOgZ5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="j1iDsrnv"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id BD71A1D001BD;
	Wed, 25 Mar 2026 02:21:26 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Wed, 25 Mar 2026 02:21:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1774419686; x=
	1774506086; bh=bCKQ5BduNuTHtMUHNkHHBgAiHJJsr4wgXgm0CoUIrRI=; b=k
	JjBOgZ5zdh+zw0izYjFHST6OSosYBvMTDX1NECkOnjY8bAXPvLzLLuFFFnA861yT
	boBIh6/OihLUCcBpQedMBzunBlgluFR4+j8N2cbSLIrvr8Hkr+j8WkJFopkdUx13
	axbNoab1W46/j6F+B5UXgn2zdWVEKvBfdZ7d2fkyJ55l9Xl2SlgX6WvdiGLndJq4
	Ef8Sx/IeF+RJ77OKup5Ac0mg/F2jt5vVgB4DTSWKNf4CWwB8tdK7upz7kWzoYuNc
	sDvkpnA6axs3eM1kqT8fyDgEH/PgqOQROUNudCVoIjLDYJpAoQ0Ye+XUmDu7WfBK
	aSO+385Xq/HrKEl9T8yXw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1774419686; x=1774506086; bh=bCKQ5BduNuTHtMUHNkHHBgAiHJJs
	r4wgXgm0CoUIrRI=; b=j1iDsrnvvzKuc8OyG27w/2MI06Ysd1PmVEyckz7zPtiD
	YPHzkxfWp2RrlnHJOo6zn4pL8hol+Gh6TvuQbQ+3B3izRU8RG8++bVemS051q0nv
	TV/KvuKANWnbpwBLVtDK0zhBjcqZf9kjRJS3oaaPGXLTv3eudaOBWnA3V3JENa3k
	Pj7gftk2p0ekzWU3cL0r11oQgghjoDAaeIRt033L1Hin2K7E26KcirNrcqakmw4C
	gvysUB5Dicyy8uhwuqLgH50S+hNQO85npsWm/QiXfU9XbPtBq0nhl/eHqVeVYdLy
	nKM2yBPERsFzShTFq0zxVuYdrLwRrDdBR8DBk+Np3Q==
X-ME-Sender: <xms:5n7DaThIpPwS5zkXagQcPyRZD-sxW_-ShaR4eMIzrpLDqDJnj7X-UA>
    <xme:5n7DaWCvCCd2uPNXXm9wpGgovWpUX1QnImuOQANY8YinV0Pm3eGI7jQO03_mN_b-P
    lbHTvCTOeI_23vtz-Z0NBV9ri63aKGMt2L2jyReKx0Qtwj-1bpy6g>
X-ME-Received: <xmr:5n7DaQviC43ae8-O1X1FXS6GLRjBN55GsaqtX-FVIJhlYYw37Y5bfvnYsl41FlUiqBiYMK5gJVHbAxxTXxtk_s9l_eddJ5mNLw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefvdefjeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekredtre
    dttdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphho
    sghogidrtghomheqnecuggftrfgrthhtvghrnhepleevieefieeuffeugefhveeugefgfe
    evvdefleevuedvfedvudefkeehtdeftdegnecuvehluhhsthgvrhfuihiivgepudenucfr
    rghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspg
    hrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrd
    gtohhm
X-ME-Proxy: <xmx:5n7DabZpI88qM4sI85ZL2tza5bSsCX1QhEzS73bfZXvtk_ErqNskEQ>
    <xmx:5n7DaTUEnDTFba5HY-Do-lsGBKnQ1PWTAd-C8RNdQVGW5b_DcaMa0Q>
    <xmx:5n7Daf5TqQbLEjZuos5Vq3ZpRZaanxfdt1TBr5n5r2tzGSRJn29OnQ>
    <xmx:5n7DaeipS4ViJ0fBKGi9IFnS83uajQepuQuyW5LHO4j2HY0BfhGw8A>
    <xmx:5n7DaW7SmdbyT7QD5T9VSba69kVyckdf_zvvOxdyG7RC3vIGqE8aVE8v>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 25 Mar 2026 02:21:26 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH 06/11] tests: make svn test "set -e" clean
Date: Tue, 24 Mar 2026 23:21:09 -0700
Message-ID: <20260325062114.2067946-7-gitster@pobox.com>
X-Mailer: git-send-email 2.53.0-886-g529cbd14ff
In-Reply-To: <20260325062114.2067946-1-gitster@pobox.com>
References: <20260325062114.2067946-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In order to catch mistakes like misspelling "test_expect_success",
we would like to eventually be able to run our test suite with the
"-e" option on.

The git-svn helper scriptlet suffers from two instances of the
recurring pattern where a sequence

	cmd ...
	if test $? ...

expects cmd to be allowed to fail freely and we can act on its exit
status, which is not possible under "set -e".

As the second instance uses an extra variable $x to capture the
status of the failed command already, let's use that variable to
rewrite the above pattern to

	x=0; cmd ... || x=$?
	if test $x ...

which means the same thing but does not fail under "set -e".

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/lib-git-svn.sh | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/t/lib-git-svn.sh b/t/lib-git-svn.sh
index 2fde2353fd..a73b997f8f 100644
--- a/t/lib-git-svn.sh
+++ b/t/lib-git-svn.sh
@@ -15,8 +15,8 @@ GIT_SVN_DIR=$GIT_DIR/svn/refs/remotes/git-svn
 SVN_TREE=$GIT_SVN_DIR/svn-tree
 test_set_port SVNSERVE_PORT
 
-svn >/dev/null 2>&1
-if test $? -ne 1
+x=0; svn >/dev/null 2>&1 || x=$?
+if test $x -ne 1
 then
 	skip_all='skipping git svn tests, svn not found'
 	test_done
@@ -32,8 +32,7 @@ use SVN::Core;
 use SVN::Repos;
 \$SVN::Core::VERSION gt '1.1.0' or exit(42);
 system(qw/svnadmin create --fs-type fsfs/, \$ENV{svnrepo}) == 0 or exit(41);
-" >&3 2>&4
-x=$?
+" >&3 2>&4 || x=$?
 if test $x -ne 0
 then
 	if test $x -eq 42; then
-- 
2.53.0-886-g529cbd14ff

