Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DC893C10A7
	for <git@vger.kernel.org>; Wed,  1 Jul 2026 21:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782941099; cv=none; b=GOGpKnOZp/yhf2WiKdUphB0ddxp28VjTlLEHCCwmO1MJG0u5PVXq/N8jb8Hu3Rtz4Ua/s1NDRZGjT2BFGXItuJPDSsgimxF2aFfZaaCfiTkH9tikGuahOJh56t3hcFQMLqpa0JKI2XmW2cC2bEnlwQvA2EGdWGNW0SRLCtsXSXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782941099; c=relaxed/simple;
	bh=WsftWKAEJR5QfrFx/oN7AWK8Vij2ZXTwdHqHqxamjxg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OtYpQxGOaN5HnNExVfvVYZ6vn0vkFD8WkxnPSbrjxIqtx+Ipj45IVfHTvsVxJR33/KoZhcZ77QVd6crJIKzS2mEaUmH4V2Hdv+xiXvBnwvk3trbr2BMITTzauVZC+99YEHJODqbe8S4KI5xP12pgcNCdaqhVhxNFO5UuVHPEydA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=MVpyvmdk; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="MVpyvmdk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1782941093;
	bh=WsftWKAEJR5QfrFx/oN7AWK8Vij2ZXTwdHqHqxamjxg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
	 Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	 In-Reply-To:References:Content-Type:Content-Disposition;
	b=MVpyvmdkkVjQ1UtfHIMfCY0PZE2RgOedidgXsXElRZzEPaaWV8yZZAsD3s1OKVXo1
	 sNrt8hep9eyl8R8UUxL/5j4G9yY8VZgjqi3UatmgUdDJwYt5SxeRGjGCI9GwnZC12g
	 WOnnCowQATD5QumVBIdM47SXrHzHNZQjhqEOk1/lX9XtTk7T7keB09amG3hssi85uy
	 O9JoUsyOGqTMcWi7e9qgJrqztb00Sd8ThHjvnWDHI11hDF1yi5rme67SzDZAhBAkCA
	 JTSv0Pk19TR5rnfI23lL0efkeSiQcPz1DeQaIKYPKksGMNBg8Psbu61z8dVHIMHuW3
	 AyZwro/fgtR/IXOJ/qLVeaR4UJpVYfHT6wrQ6mYQDA5+ChK8S4awj4xK5xIYn2yo0l
	 Ca0P+I7rSHPiPNTHxWja8CpTpqRLV4dihjf591zvLjvNCZI61lTRoA9WjNbqTwp6n1
	 13XCJM0vTmBt4ZN0i0f116qX6V/f1I+ruRID6loUL5Ks5goloXu
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:cd97:af94:901e:255d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 0F61B200BE;
	Wed,  1 Jul 2026 21:24:53 +0000 (UTC)
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>
Subject: [PATCH v2 1/4] t1517: skip svn tests if svn is not installed
Date: Wed,  1 Jul 2026 21:24:39 +0000
Message-ID: <20260701212442.1430084-2-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.53.0.697.g625c4fb2daa
In-Reply-To: <20260701212442.1430084-1-sandals@crustytoothpaste.net>
References: <20260316220742.1286157-1-sandals@crustytoothpaste.net>
 <20260701212442.1430084-1-sandals@crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The svn tests currently assume that git-svn's option parsing will always
fail the tests because it exits 0 on --help, not 129.  However, in a
future commit, we'll expect it to exit 0 and the tests will then need to
be updated to succeed in some cases and fail in others.

We therefore need to have t1517 determine whether the Subversion Perl
modules are present, since if they are not, git-svn will die on start
and then it needs to continue to expect failure.  Add a stripped down
version of the tests in t/lib-git-svn.sh as a prerequisite we can use
here for our svn tests.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/t1517-outside-repo.sh | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/t/t1517-outside-repo.sh b/t/t1517-outside-repo.sh
index c557f2f55c..583784f21b 100755
--- a/t/t1517-outside-repo.sh
+++ b/t/t1517-outside-repo.sh
@@ -4,6 +4,14 @@ test_description='check random commands outside repo'
 
 . ./test-lib.sh
 
+test_lazy_prereq SVN '
+	test_have_prereq PERL && test -n "$NO_SVN_TESTS" && perl -w -e "
+		use SVN::Core;
+		use SVN::Repos;
+		\$SVN::Core::VERSION gt '1.1.0' or exit(42);
+	"
+'
+
 test_expect_success 'set up a non-repo directory and test file' '
 	GIT_CEILING_DIRECTORIES=$(pwd) &&
 	export GIT_CEILING_DIRECTORIES &&
@@ -138,6 +146,8 @@ do
 	case "$cmd" in
 	instaweb)
 		prereq=PERL ;;
+	svn)
+		prereq=SVN ;;
 	*)
 		prereq= ;;
 	esac
