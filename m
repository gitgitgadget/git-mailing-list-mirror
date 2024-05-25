Received: from gosford.compton.nu (gosford.compton.nu [217.169.17.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6598F2BCF8
	for <git@vger.kernel.org>; Sat, 25 May 2024 10:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.169.17.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716631787; cv=none; b=Sfrk5VQ+ujGSdwKXC1bgKqABbfpsTUzxPksdzxqkS2V16aOK2/IgTqKQJJ9Xtp6y4hyE3sbgTtF3cjaPghqdzAQe74O+IbJo+Lp+cXs+F9ykr+3do8ElN5JtJ9RHodC4h23UUyZGYAxaG3ltK0kdLIp69D7cRbK/nMytpQ09Xsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716631787; c=relaxed/simple;
	bh=H+fd5qusVr1YhIusuHJ3OxE3IFeEXszmiNJQjptbXTc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tQ3Dtf7rxUFpb8CPaWNs6noGVWkcuvzLXA9sb7M6J9ncU7rJCaPL2EDzWG1hMlGkFmlsH5sT1tN7HBPbjgHS5iiGoEpZqoDpJDhBXuBOPD6V2ErQcX1Uu9aHnEWIc59KYUUDmWt5l0ftaNMQW1aN4iK5oWPEkfFe0UrgD0hPj04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=compton.nu; spf=pass smtp.mailfrom=compton.nu; dkim=pass (2048-bit key) header.d=compton.nu header.i=tom@compton.nu header.b=Dfp8zB4R; arc=none smtp.client-ip=217.169.17.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=compton.nu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=compton.nu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=compton.nu header.i=tom@compton.nu header.b="Dfp8zB4R"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=compton.nu;
	s=20200130; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=1TcCv6WJuHxZtFfsErlkU9fXmVFPBk8Ki+DK1903AoI=; i=tom@compton.nu;
	t=1716631785; x=1717841385; b=Dfp8zB4Rz5azpuhI79jIuEDzE3mB/7bb82wXpMg7NgAvZok
	MqyCs8yf1zT0m00d9gTnDD3dGBNtNhhhmy181VhlH5VHi9JadiOE6ChbG+Iyn+xbQv4AY1YLDoKFi
	JAhMlYDdOQaPSr+AaFJ6UwFjtobhVjOl2McAqk7Oh3r+IfaGbW2wYAeu54Vxyo452XUhUn2vGL4gK
	mzHKAL8s+iFRn0ZLnHjq3TqNnFLWuWepOTV8nP97MNWtM8MBo7s5u6RtGE2I+zvDuID4zrM2RY6R5
	y/BSMaSM+X4dbmB/HHjP7z7+h9LTApbiMWvdoOjiwW4L1XFf+Y5mRgO0vQTI1AFg==;
Authentication-Results: gosford.compton.nu;
	iprev=pass (bericote.compton.nu) smtp.remote-ip=2001:8b0:bd:1:1881:14ff:fe46:3cc7
Received: from bericote.compton.nu ([2001:8b0:bd:1:1881:14ff:fe46:3cc7]:43626)
	by gosford.compton.nu with esmtps  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <tom@compton.nu>)
	id 1sAoLB-00000009qui-2CLZ;
	Sat, 25 May 2024 11:09:33 +0100
Received: from tom by bericote.compton.nu with local (Exim 4.97.1)
	(envelope-from <tom@compton.nu>)
	id 1sAoLB-0000000CNNt-1YXb;
	Sat, 25 May 2024 11:09:29 +0100
From: Tom Hughes <tom@compton.nu>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	chriscool@tuxfamily.org,
	jonathantanmy@google.com,
	Tom Hughes <tom@compton.nu>
Subject: [PATCH v3] promisor-remote: add promisor.quiet configuration option
Date: Sat, 25 May 2024 11:09:27 +0100
Message-ID: <20240525100927.2949808-1-tom@compton.nu>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240524090937.2448229-1-tom@compton.nu>
References: <20240524090937.2448229-1-tom@compton.nu>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a configuration option to allow output from the promisor
fetching objects to be suppressed.

This allows us to stop commands like 'git blame' being swamped
with progress messages and gc notifications from the promisor
when used in a partial clone.

Signed-off-by: Tom Hughes <tom@compton.nu>
---
 Documentation/config.txt          |  2 ++
 Documentation/config/promisor.txt |  3 +++
 promisor-remote.c                 |  3 +++
 t/t0410-partial-clone.sh          | 43 +++++++++++++++++++++++++++++++
 4 files changed, 51 insertions(+)
 create mode 100644 Documentation/config/promisor.txt

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 70b448b132..6cae835db9 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -487,6 +487,8 @@ include::config/pager.txt[]
 
 include::config/pretty.txt[]
 
+include::config/promisor.txt[]
+
 include::config/protocol.txt[]
 
 include::config/pull.txt[]
diff --git a/Documentation/config/promisor.txt b/Documentation/config/promisor.txt
new file mode 100644
index 0000000000..98c5cb2ec2
--- /dev/null
+++ b/Documentation/config/promisor.txt
@@ -0,0 +1,3 @@
+promisor.quiet::
+	If set to "true" assume `--quiet` when fetching additional
+	objects for a partial clone.
diff --git a/promisor-remote.c b/promisor-remote.c
index b414922c44..2ca7c2ae48 100644
--- a/promisor-remote.c
+++ b/promisor-remote.c
@@ -23,6 +23,7 @@ static int fetch_objects(struct repository *repo,
 	struct child_process child = CHILD_PROCESS_INIT;
 	int i;
 	FILE *child_in;
+	int quiet;
 
 	if (git_env_bool(NO_LAZY_FETCH_ENVIRONMENT, 0)) {
 		static int warning_shown;
@@ -41,6 +42,8 @@ static int fetch_objects(struct repository *repo,
 		     "fetch", remote_name, "--no-tags",
 		     "--no-write-fetch-head", "--recurse-submodules=no",
 		     "--filter=blob:none", "--stdin", NULL);
+	if (!git_config_get_bool("promisor.quiet", &quiet) && quiet)
+		strvec_push(&child.args, "--quiet");
 	if (start_command(&child))
 		die(_("promisor-remote: unable to fork off fetch subprocess"));
 	child_in = xfdopen(child.in, "w");
diff --git a/t/t0410-partial-clone.sh b/t/t0410-partial-clone.sh
index 88a66f0904..8d468eb170 100755
--- a/t/t0410-partial-clone.sh
+++ b/t/t0410-partial-clone.sh
@@ -3,6 +3,7 @@
 test_description='partial clone'
 
 . ./test-lib.sh
+. "$TEST_DIRECTORY"/lib-terminal.sh
 
 # missing promisor objects cause repacks which write bitmaps to fail
 GIT_TEST_MULTI_PACK_INDEX_WRITE_BITMAP=0
@@ -689,6 +690,48 @@ test_expect_success 'lazy-fetch when accessing object not in the_repository' '
 	! grep "[?]$FILE_HASH" out
 '
 
+test_expect_success 'setup for promisor.quiet tests' '
+	rm -rf server &&
+	test_create_repo server &&
+	test_commit -C server foo &&
+	git -C server rm foo.t &&
+	git -C server commit -m remove &&
+	git -C server config uploadpack.allowanysha1inwant 1 &&
+	git -C server config uploadpack.allowfilter 1
+'
+
+test_expect_success TTY 'promisor.quiet=false shows progress messages' '
+	rm -rf repo &&
+	git clone --filter=blob:none "file://$(pwd)/server" repo &&
+	git -C repo config promisor.quiet "false" &&
+
+	test_terminal git -C repo cat-file -p foo:foo.t 2>err &&
+
+	# Ensure that progress messages are written
+	grep "Receiving objects" err
+'
+
+test_expect_success TTY 'promisor.quiet=true does not show progress messages' '
+	rm -rf repo &&
+	git clone --filter=blob:none "file://$(pwd)/server" repo &&
+	git -C repo config promisor.quiet "true" &&
+
+	test_terminal git -C repo cat-file -p foo:foo.t 2>err &&
+
+	# Ensure that no progress messages are written
+	! grep "Receiving objects" err
+'
+
+test_expect_success TTY 'promisor.quiet=unconfigured shows progress messages' '
+	rm -rf repo &&
+	git clone --filter=blob:none "file://$(pwd)/server" repo &&
+
+	test_terminal git -C repo cat-file -p foo:foo.t 2>err &&
+
+	# Ensure that progress messages are written
+	grep "Receiving objects" err
+'
+
 . "$TEST_DIRECTORY"/lib-httpd.sh
 start_httpd
 
-- 
2.45.1

