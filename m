Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41DF228B50F
	for <git@vger.kernel.org>; Tue, 15 Apr 2025 09:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744711041; cv=none; b=gosUhoKJrk1KP0b/4x58QGpzlq266WxWzmv0sKd14FHT9t5i+iWumc6PTymQ04i6dl/DYdhA/8N3pY9in6pFA4LtkMD6150I1PoOAdpBXlAoa3bvvWxqlruU0n35MElr3f80+FbmCkzjHKln5ron5YqoX5Qmc2Kqdr/xC3Q/o8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744711041; c=relaxed/simple;
	bh=JLNRgfeKVg5LSZ36ef/q0qJT+doE6AdoGGpc4oglxds=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lCnkFqPffrt+gc82glvnoNJ1fme0/qS83mpztgJ67HCWVzaEuYq8chFtShSfpVq0bJ3vfHIO0TM5iTPGNoZ7R3449Flg7BHm7bk84RXk6Dot2fJa9kEJ5b7ZI1BYa9tXDoYzLOHtpVrn3/0hL09fv+heSUhrdmOmsVA069CnRZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=p4PewwQB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=m52QoiLb; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="p4PewwQB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="m52QoiLb"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 2450F11402D9;
	Tue, 15 Apr 2025 05:57:18 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 15 Apr 2025 05:57:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1744711038;
	 x=1744797438; bh=TZBf0dw2NYkdq0RU6sGf28pG6gDj5KjVAnrDy1+B55E=; b=
	p4PewwQBO6e72fBotShdMleB4vBJ7XNF6TlYSYgEZJmN+iFUzfXMECrWQmWBG47T
	qvCgKl7DD99AuT7i4JG29BdB4FA/Tu0z+gt1rvEoCFSBmoVRRbeNgsGXhijttXqS
	sT1lMq+fQDbnlXfnIfKJ5PrTqxJ0Pp6ivZkz3/IkYycCzM+LtARvzSlkthFtKNLF
	y4qLOoMxKkqJhhUcD2G2CcyM5NjSS/FMbfOJiYe2LegSLhNS/kt/vlCYRYNps7w0
	rva3ie+xcOREw3HsqCNDQsBe4DwP8hwExfuZXXGBJsZTItETyMtwXBvLlbbk6m61
	bJhiqyo+jCenpMo60PZXvg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1744711038; x=
	1744797438; bh=TZBf0dw2NYkdq0RU6sGf28pG6gDj5KjVAnrDy1+B55E=; b=m
	52QoiLb23t5xIvS4yQNRYRNyHWae0thti6Lp4KAwU91vTJtOAdzLozfZKmgs1Vy2
	B1tLx7EwPiSGBfBF78GH17MfRotRbvG82snW67Rt37Vjq+c1l4akFyUa7kfcfBK7
	vO6GkkvatWgGFyVeTctPPZbQ4NH4d7cU/38vYja8fp39QDwIA4XOafrWkw8fJvoh
	rbscNHqZvZJ6RbXXwf4Eiy/+/QEOUVLZQK59f+8KQ85XrJhGrrI3pfp2pR9jBZPQ
	ixgtQ7JlDC7nK/xfXgngefbW4ny/kUisblf+Z0vUZEYpK6lgdq9MQcWjD9udXK3d
	E7U3iJz/U+UuxuHEeSdkQ==
X-ME-Sender: <xms:fS3-Z4SnW_d0sHo44bnb3Sw7MTtgT-YhQK8O7NjZmHZo5uDWPYw6tA>
    <xme:fS3-Z1wHLdiXNwSIJM07fOVXgyUDUx91nVEcPFxhB_XMGOCZbGyG5LK6n9arSkUAi
    wwAzZSa5VAfSWKBEA>
X-ME-Received: <xmr:fS3-Z10i-Qcuiogx_nfkW01FyEabiDRJlW_SB1Sg2ee39EQJgDuokXXDgKkENe3fny_KEZWWbAllW08d69RBe-wOAjooxWtpWhyyOfBNeLTpyQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvvdefudekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtohepjhhohhgrnhhnvghsrdhstghhihhnuggvlhhinhesghhmgidruggv
X-ME-Proxy: <xmx:fS3-Z8CbktIU0YO3t4-7wxJSyvKGx4cTYKc9mpC86KyAaX68WiJgKA>
    <xmx:fS3-ZxiVnrFNO15ibfN212sgtLhW5hJAYQL4KZlPWuzQB86qIeHK4Q>
    <xmx:fS3-Z4qnf91oVVLJA1NpsT4G9i2fqO6v2bFrTr1DRCa_9i5OWS4-Pw>
    <xmx:fS3-Z0jjtZElRkPVHxfmhSH801Z_8IwB7H8Do4cGH9VPrCt5CtBvJg>
    <xmx:fS3-Z81kNm0iABetIAJ2LddzuigoWUUXpk9HuNL4Ib-94UIxjVyyW6zs>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 15 Apr 2025 05:57:17 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 6475c703 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 15 Apr 2025 09:57:15 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 15 Apr 2025 11:57:09 +0200
Subject: [PATCH 2/4] request-pull: stop depending on Perl
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250415-b4-pks-drop-perl-v1-2-c6addf175858@pks.im>
References: <20250415-b4-pks-drop-perl-v1-0-c6addf175858@pks.im>
In-Reply-To: <20250415-b4-pks-drop-perl-v1-0-c6addf175858@pks.im>
To: git@vger.kernel.org
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-Mailer: b4 0.14.2

While git-request-pull(1) is written as a shell script, for it to
function we depend on Perl being available. The script gets installed
unconditionally though, regardless of whether or not Perl is even
available on the system. When it's not available, the `@PERL_PATH@`
variable may be substituted with a nonexistent executable path and thus
cause the script to fail.

Refactor the script so that it does not depend on Perl at all anymore.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 git-request-pull.sh     | 74 ++++++++++++++++++++++++++-----------------------
 t/t5150-request-pull.sh |  6 ----
 2 files changed, 40 insertions(+), 40 deletions(-)

diff --git a/git-request-pull.sh b/git-request-pull.sh
index 775ba8ea11a..59276fe265b 100755
--- a/git-request-pull.sh
+++ b/git-request-pull.sh
@@ -78,41 +78,47 @@ fi
 merge_base=$(git merge-base $baserev $headrev) ||
 die "fatal: No commits in common between $base and $head"
 
-# $head is the refname from the command line.
-# Find a ref with the same name as $head that exists at the remote
+find_matching_ref () {
+	while read sha1 ref
+	do
+		case "$ref" in
+		*"^{}")
+			ref="${ref%"^{}"}"
+			deref=true
+			;;
+		*)
+			deref=
+			;;
+		esac
+
+		if test "$sha1" = "${remote:-HEAD}"
+		then
+			echo "$sha1 $sha1"
+			break
+		fi
+
+		case "$ref" in
+		"${remote:-HEAD}"|*"/${remote:-HEAD}")
+			if test -z "$deref"
+			then
+				# Remember the matching unpeeled object on the
+				# remote side.
+				remote_sha1="$sha1"
+			fi
+
+			if test "$sha1" = "$headrev"
+			then
+				echo "${remote_sha1:-$headrev} $ref"
+				break
+			fi
+			;;
+		esac
+	done
+}
+
+# Find a ref with the same name as $remote that exists at the remote
 # and points to the same commit as the local object.
-find_matching_ref='
-	my ($head,$headrev) = (@ARGV);
-	my $pattern = qr{/\Q$head\E$};
-	my ($remote_sha1, $found);
-
-	while (<STDIN>) {
-		chomp;
-		my ($sha1, $ref, $deref) = /^(\S+)\s+([^^]+)(\S*)$/;
-
-		if ($sha1 eq $head) {
-			$found = $remote_sha1 = $sha1;
-			break;
-		}
-
-		if ($ref eq $head || $ref =~ $pattern) {
-			if ($deref eq "") {
-				# Remember the matching object on the remote side
-				$remote_sha1 = $sha1;
-			}
-			if ($sha1 eq $headrev) {
-				$found = $ref;
-				break;
-			}
-		}
-	}
-	if ($found) {
-		$remote_sha1 = $headrev if ! defined $remote_sha1;
-		print "$remote_sha1 $found\n";
-	}
-'
-
-set fnord $(git ls-remote "$url" | @PERL_PATH@ -e "$find_matching_ref" "${remote:-HEAD}" "$headrev")
+set fnord $(git ls-remote "$url" | find_matching_ref)
 remote_sha1=$2
 ref=$3
 
diff --git a/t/t5150-request-pull.sh b/t/t5150-request-pull.sh
index cb67bac1c47..270ce6ea487 100755
--- a/t/t5150-request-pull.sh
+++ b/t/t5150-request-pull.sh
@@ -7,12 +7,6 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./test-lib.sh
 
-if ! test_have_prereq PERL
-then
-	skip_all='skipping request-pull tests, perl not available'
-	test_done
-fi
-
 test_expect_success 'setup' '
 
 	git init --bare upstream.git &&

-- 
2.49.0.805.g082f7c87e0.dirty

