Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D987C1D86C3
	for <git@vger.kernel.org>; Mon,  3 Feb 2025 06:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738564189; cv=none; b=VBYlGSCR/oWgCCt7lUybT+ckLmYte+V7Wwu7N7hg0I1x2FQw0FEyFeX5p7JFbE+ch18hJnAztnfGeicSD0+wZhR7rS50Extu98l0ypJ6G5FDugTJDYxT4v1s/rY55zzpTnEwIGKTOlZP3X3WVB3uc0IdOEqMX2QTXHZ/kmEbaQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738564189; c=relaxed/simple;
	bh=pKLx5AbYFplEym75aQ36nZRYMN4gAJi9rTE1bVyXkxE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mNEGEPAWBw4SsE/W0BWtNPMW9EZbFRetSq5q980JENPB5vxtYdW6VdY30cYV9W61dzvfXHYS84V6I/bvQ/y4lVpTiKDgKl4IixCzLSga1muzCVv3+iDxJZfF7wXPXaw3qsS1HUG8PVCOnbhzqawyInjSrRxX2F/WbhxhUjkoyhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=YG4+DTvi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Vz2ZDk34; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="YG4+DTvi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Vz2ZDk34"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id E28401380601;
	Mon,  3 Feb 2025 01:29:46 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Mon, 03 Feb 2025 01:29:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1738564186;
	 x=1738650586; bh=8rOCIbgznNeydvWMf/Vh1x1sEOIcV6oLc7deQU33H0E=; b=
	YG4+DTviKTd0tIMt+2XKbkVwpHBqYEAFeLGqqfOZEzYfPtQaUAeadk5mFtQV4G41
	85bUH42aMS44WZZynIOFz7iUOUKlakbHWVWIASPCqnA8S36W2e9AalAJbdILXRzW
	Hjl9bU2EuEpFo3b5eUbyiMIxr05a3aVPS2qad0Ko5odVsVToaYetugFccnl7cwP7
	U5k1rg8uIbt0V+eDIzYsW/VkQxVeRK8FFu/7iO5aCjzhCR4ulEMeHwcfFbpTnUoM
	XDDbwo/fnkgVJqFDwwYnbaVPGPeaK2PeuLGNEDgfxVl9D8rLZ0MIn9Y4WiZUejRh
	Wu2dNz82lkC93f5SBakU5w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1738564186; x=
	1738650586; bh=8rOCIbgznNeydvWMf/Vh1x1sEOIcV6oLc7deQU33H0E=; b=V
	z2ZDk34yxp9nFWyMp4C0sLkziCWmj9qX9RpDdwbcqKMOgAJKYEESspEbbyMdol/5
	kzicgzamKqr6sysfeD8JyAmJWNeDTuubTkhIWMiStWnoR9f3hLqrjlehCBXZhGxC
	+ssjMfYpYAgNdjGbZjmpq5Um2QhTCmCNkJTeYvqBdnWkwd/gunSyz6fz2vZwDYfl
	AW3ViDkI5ihs4/DaEJI1XpJnEa6NPnawFBTyFYDfXr694ky0fVQg67i3cQWhxe0b
	BCX3TLeON+Qxm4eaKiObK2DR2x1a8ckY5CXetXXs3+CvwPqnnEsm39B/+kyn8ekK
	Js4wK7m+i5pgzQbGjwZZw==
X-ME-Sender: <xms:WmKgZ5gBQXXtCyQzNS5C6xQfiHEbi7jtVdjLPPjdHUtmRLLps2oxYA>
    <xme:WmKgZ-BZMuTVcc-rpb7YMP-E2wsU3GJoRYxhNf10wyajtyRFkDP8R-9n7XSMxyKOA
    DTDW91G4sSRkzp2Ew>
X-ME-Received: <xmr:WmKgZ5HcD3hMG8I2HlFpkD-apzJECtwCfP7Wv1SMnW5Fzou69R4sGnQ0mQMFii5n_V7nrrWojkfH5vC4TY1PrOJUw1uTFYHlMKyoa8XpZLlVbw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduieekhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredt
    jeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepvdejteetffehjeevledvffffffevhfffieejffel
    iefghfevieegffdvhedtkedunecuffhomhgrihhnpehhthhtphgurdhshhenucevlhhush
    htvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
    pdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopeiihh
    hihihouhdrjhigsegrlhhisggrsggrqdhinhgtrdgtohhmpdhrtghpthhtohepghhithhs
    thgvrhesphhosghogidrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtohepshhunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtgho
    mh
X-ME-Proxy: <xmx:WmKgZ-SbereDvY5t4AUftOAs7vlKOrCfEacctAmVVyP4Zu04mnL7JQ>
    <xmx:WmKgZ2z8tvFH10AxsSRkNMq4zxj0zO2-f3hr2nNUxbO9MVX157c3ng>
    <xmx:WmKgZ04eKS7ePjB3IYEgGMhLIKbjf2Zt2oIjL6iJT4vJPO9SVWbzuA>
    <xmx:WmKgZ7yMQZ_EtXfkPFQRTB8Zp_GwDTScpQsHqqubIeaDCqbirpJ6qg>
    <xmx:WmKgZwt3-a0XhevNgNXAE9pXV-J4Lho2UDX-W8a7jeLzSAKMpXbX8630>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Feb 2025 01:29:45 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 6c763354 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 3 Feb 2025 06:29:43 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 03 Feb 2025 07:29:32 +0100
Subject: [PATCH v5 2/8] t5548: refactor to reuse setup_upstream() function
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250203-pks-push-atomic-respect-exit-code-v5-2-d66481e36622@pks.im>
References: <20250203-pks-push-atomic-respect-exit-code-v5-0-d66481e36622@pks.im>
In-Reply-To: <20250203-pks-push-atomic-respect-exit-code-v5-0-d66481e36622@pks.im>
To: git@vger.kernel.org
Cc: Jiang Xin <zhiyou.jx@alibaba-inc.com>, 
 Junio C Hamano <gitster@pobox.com>, Eric Sunshine <sunshine@sunshineco.com>
X-Mailer: b4 0.14.2

From: Jiang Xin <zhiyou.jx@alibaba-inc.com>

Refactor the function setup_upstream_and_workbench(), extracting
create_upstream_template() and setup_upstream() from it. The former is
used to create the upstream repository template, while the latter is
used to rebuild the upstream repository and will be reused in subsequent
commits.

To ensure that setup_upstream() works properly in both local and HTTP
protocols, the HTTP settings have been moved to the setup_upstream() and
setup_upstream_and_workbench() functions.

Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t5548-push-porcelain.sh | 83 ++++++++++++++++++++++++++++++-----------------
 1 file changed, 53 insertions(+), 30 deletions(-)

diff --git a/t/t5548-push-porcelain.sh b/t/t5548-push-porcelain.sh
index 6282728eaf..1bf4d48cd9 100755
--- a/t/t5548-push-porcelain.sh
+++ b/t/t5548-push-porcelain.sh
@@ -54,29 +54,65 @@ format_and_save_expect () {
 	sed -e 's/^> //' -e 's/Z$//' >expect
 }
 
+create_upstream_template () {
+	git init --bare upstream-template.git &&
+	git clone upstream-template.git tmp_work_dir &&
+	create_commits_in tmp_work_dir A B &&
+	(
+		cd tmp_work_dir &&
+		git push origin \
+			$B:refs/heads/main \
+			$A:refs/heads/foo \
+			$A:refs/heads/bar \
+			$A:refs/heads/baz
+	) &&
+	rm -rf tmp_work_dir
+}
+
+setup_upstream () {
+	if test $# -ne 1
+	then
+		BUG "location of upstream repository is not provided"
+	fi &&
+	rm -rf "$1" &&
+	if ! test -d upstream-template.git
+	then
+		create_upstream_template
+	fi &&
+	git clone --mirror upstream-template.git "$1" &&
+	# The upstream repository provides services using the HTTP protocol.
+	if ! test "$1" = "upstream.git"
+	then
+		git -C "$1" config http.receivepack true
+	fi
+}
+
 setup_upstream_and_workbench () {
+	if test $# -ne 1
+	then
+		BUG "location of upstream repository is not provided"
+	fi
+	upstream="$1"
+
 	# Upstream  after setup : main(B)  foo(A)  bar(A)  baz(A)
 	# Workbench after setup : main(A)
 	test_expect_success "setup upstream repository and workbench" '
-		rm -rf upstream.git workbench &&
-		git init --bare upstream.git &&
-		git init workbench &&
-		create_commits_in workbench A B &&
+		setup_upstream "$upstream" &&
+		rm -rf workbench &&
+		git clone "$upstream" workbench &&
 		(
 			cd workbench &&
+			git update-ref refs/heads/main $A &&
 			# Try to make a stable fixed width for abbreviated commit ID,
 			# this fixed-width oid will be replaced with "<OID>".
 			git config core.abbrev 7 &&
-			git remote add origin ../upstream.git &&
-			git update-ref refs/heads/main $A &&
-			git push origin \
-				$B:refs/heads/main \
-				$A:refs/heads/foo \
-				$A:refs/heads/bar \
-				$A:refs/heads/baz
+			git config advice.pushUpdateRejected false
 		) &&
-		git -C "workbench" config advice.pushUpdateRejected false &&
-		upstream=upstream.git
+		# The upstream repository provides services using the HTTP protocol.
+		if ! test "$upstream" = "upstream.git"
+		then
+			git -C workbench remote set-url origin "$HTTPD_URL/smart/upstream.git"
+		fi
 	'
 }
 
@@ -88,7 +124,7 @@ run_git_push_porcelain_output_test() {
 		;;
 	file)
 		PROTOCOL="builtin protocol"
-		URL_PREFIX="\.\."
+		URL_PREFIX=".*"
 		;;
 	esac
 
@@ -247,10 +283,8 @@ run_git_push_porcelain_output_test() {
 	'
 }
 
-# Initialize the upstream repository and local workbench.
-setup_upstream_and_workbench
+setup_upstream_and_workbench upstream.git
 
-# Run git-push porcelain test on builtin protocol
 run_git_push_porcelain_output_test file
 
 ROOT_PATH="$PWD"
@@ -258,21 +292,10 @@ ROOT_PATH="$PWD"
 . "$TEST_DIRECTORY"/lib-httpd.sh
 . "$TEST_DIRECTORY"/lib-terminal.sh
 start_httpd
-
-# Re-initialize the upstream repository and local workbench.
-setup_upstream_and_workbench
-
-test_expect_success "setup for http" '
-	git -C upstream.git config http.receivepack true &&
-	upstream="$HTTPD_DOCUMENT_ROOT_PATH/upstream.git" &&
-	mv upstream.git "$upstream" &&
-
-	git -C workbench remote set-url origin $HTTPD_URL/smart/upstream.git
-'
-
 setup_askpass_helper
 
-# Run git-push porcelain test on HTTP protocol
+setup_upstream_and_workbench "$HTTPD_DOCUMENT_ROOT_PATH/upstream.git"
+
 run_git_push_porcelain_output_test http
 
 test_done

-- 
2.48.1.502.g6dc24dfdaf.dirty

