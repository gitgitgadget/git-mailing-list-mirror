Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CED9323D293
	for <git@vger.kernel.org>; Wed, 16 Apr 2025 12:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744805784; cv=none; b=hxIE+j/CLCu9Js4hSFOfh1UG6tkM4gFhyGLThtfkVcVPlKHFPhvxkFlPHRsrkuLnP/jaqKiJk8EveaCEVsTsn3E+04bPEnfC2UWkZp7YXg6/TJOmIVCN9gyrp34rAtNpK4qRwxW/xKe0sT6p4k5NT9sD5Xg6R4J3mcIyXytBs9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744805784; c=relaxed/simple;
	bh=5L5rYb4eIwH+w2nJp7AJ/GehpX5c2fyavarqpKE4Uxg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eSW1F4xDdAV9tlUHdp03yl3F78lMOIvYgEiXY5DcweX4z05yYBB/Ns8mNY2+i9scuQ/O7e9P4lnJ0pMp4W3PgsvVLZ3c1OAp2dnKVjxStQSRSBvxP055XVuyJFrftRY57rYRWUxyfEdRU+a5EJJkJCV6wRdC/kCtal+MD3bm7OY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=i7htPBeI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=J/6Oc2U2; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="i7htPBeI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="J/6Oc2U2"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id ADCC41140308;
	Wed, 16 Apr 2025 08:16:19 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Wed, 16 Apr 2025 08:16:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1744805779;
	 x=1744892179; bh=Rf2xTNj43DhhWNRi088Bsl2dtKjt1sNWrA4Lr2BSV94=; b=
	i7htPBeICu7kpqjsKuB46nP9njIKeu4bLl7C3F42tQRrZd/6Y+1IQvCB7kMKR5zI
	i+vRYp1VbYwZuX3rD/ts6pqf+uH6u/CRd4YBuUOp5uz298lx/l9ms77PUUCQmey1
	DKa7UZMkquLqTJiOX5S76YU3gDzLhkZivuewq+PWy1iLKK8w0KNtO4pclyLzgeum
	YRjGEBr7/AZ8xDbdHBzYFvDXevtPSZdsw/ttkwVqvwuJtx7L95v9DUdRbtQgN6od
	WcgV6oO06bdjBZkojGND5KpQT3hBnKgij6YpWh1EXJftgwRKm3bjnylQkW7DndB2
	AstBNQd1YcHviU6llviIdw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1744805779; x=
	1744892179; bh=Rf2xTNj43DhhWNRi088Bsl2dtKjt1sNWrA4Lr2BSV94=; b=J
	/6Oc2U2OEMXN+uwmdY4k8zWOVLS5DWU16BLPAK2fZtLx9fvF/TcjSw/c28S6MY1Y
	qcVZRJMZwgE13gtgO16p5LECdSx2UWaHP/IuEYuGYqqblmojubuYmh1ev6N2F6qi
	iQmwFM0P+9KUv4NrNqnhqSiedL2hmdFHzZIuyiYwAByThWHiLBzDz1JZ1oGLo4wX
	KyIq2d7b5RgUqWMA3+VA9PeXrAydFlMA/a+BD+VrpS+jBeXY5gLbNY9zVL8t0d7V
	md2SdkjelBNrCgtL6dOTKm0BbfmKpQRsJzgMDowlFTwWHzVttTn/HYSKAYWJ7wEL
	GQg9q+h+o94mf1N6TZWVA==
X-ME-Sender: <xms:k5__Z4d5L1Cw6f0bat4NQLIYAQvyUgqO1PYzsmiTkWzS_kzZrctCbg>
    <xme:k5__Z6Mk0C1RYI-BLIdw0VYOLfTqlnxN7lj7BgXe6vzafDpk8fiuQdOkBRT3Hki-6
    iXpqda9xn5HgW8a1w>
X-ME-Received: <xmr:k5__Z5hjLpq5X9zGeOvXwXBbxMAg6Ej9cihlerUvQkUQa4zFW1Dqyk1DSsVUNfbPoZ08s2stTFwk4MolIzzOdfGO1z4aUIPhhv5cRitl2QVb3A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvvdeifeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehj
    ohhhrghnnhgvshdrshgthhhinhguvghlihhnsehgmhigrdguvg
X-ME-Proxy: <xmx:k5__Z99jPjgDknCBO36cvbO1b5NsU368TFIJ6U8xHN46Hj8Vix65TA>
    <xmx:k5__Z0ukIrCqQ6G1mVgBde4aaon9wz7NgoNdqGaWggJg2sXIgQ0M6A>
    <xmx:k5__Z0HyZR7VgtLglLUam1WImFYEiKjbKc4Gf6Az-4RskNC6lqGPBw>
    <xmx:k5__ZzMdmK3emWn6DcNOMAVuyxdRbsQ_M44teEvLb924vFrRfbGMWQ>
    <xmx:k5__Z2uhEEiGcAGvGtWFZgGl6kT1jgz1voKwtzERDpHWAcdjqUmD9Qfb>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 16 Apr 2025 08:16:18 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 66fe70dd (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 16 Apr 2025 12:16:16 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 16 Apr 2025 14:16:08 +0200
Subject: [PATCH v2 2/4] request-pull: stop depending on Perl
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250416-b4-pks-drop-perl-v2-2-bdd0492e9498@pks.im>
References: <20250416-b4-pks-drop-perl-v2-0-bdd0492e9498@pks.im>
In-Reply-To: <20250416-b4-pks-drop-perl-v2-0-bdd0492e9498@pks.im>
To: git@vger.kernel.org
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
 Junio C Hamano <gitster@pobox.com>
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
index 775ba8ea11a..6a7b7936784 100755
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
+		*"^"?*)
+			ref="${ref%"^"*}"
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

