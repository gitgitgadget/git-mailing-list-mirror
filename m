Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CECD1F8BA6
	for <git@vger.kernel.org>; Thu, 24 Apr 2025 23:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745536252; cv=none; b=egXVTgBypQAdAGfTuMhPcT75gHpqQytNWyRVTBsOMmJ/D7QV9M/eo81TeqAll1q4HDwX0tqpWmP0vWKaKUr40qqSn7/3HOuzs2BiWY9lZYYnyBVgXuvRpJwABpaexgcR1zDz9eLMVfpmbNrlhtwSOAJrNEyv5xSOBR1NjXPgw/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745536252; c=relaxed/simple;
	bh=OVFvA5Brdou1JdgDikqveKNj12jvce2GE07/3kXNJvc=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DUzInuIYp8g4EU/ZXvlj0VlTr3CDdE9p3o2jifLj4dDuTqpEKCp+Uh9s6zxVRw0ngY3CcD84pykD14nRYqvpp0VjPTOdYN2IJ+6guCf8D658XBmeg7M7xslCPbg2X57IDSY2XhwP3wbPylOFDp564qdQ+gpHBWaHv1y1hbUrk1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=B5bkWEDf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bIQyPX+W; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="B5bkWEDf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bIQyPX+W"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 8F3411380213;
	Thu, 24 Apr 2025 19:10:49 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Thu, 24 Apr 2025 19:10:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1745536249; x=1745622649; bh=vFLHFEZ2WT
	wsZiPwon84tnEJneZQwk306GOsR3NkNpc=; b=B5bkWEDfZowXJkaAPMbiApVRPf
	20AQBsoes4WmK62fGBAhgyeEB2nHwZhP9U40tY6xCdL0wr/nWZpHy2ceP4e+bg8k
	Dwj1yU/WwKbBFMsGYj6r3VnDzHMnAsPNA36D0Pns9Wq6vdkVSvt9on5dC/WD/qFi
	zQmUBfvPCQLQh+KzEvQVjSHM9std4G9zoLq5unRN23BPbdprXdXdwHB1PR1cU5tX
	Fc2paqLnvOLylugdgzXlVcQRmoF/AQYjI0VCwDnrT3Ke509BSBvNT+p9ngiityLH
	UEgBBq9NWiLNYhlMZPMxylTsYqtISouvDycgx8QJXDe8WbfQwevnP3XQotQA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1745536249; x=1745622649; bh=vFLHFEZ2WTwsZiPwon84tnEJneZQwk306GO
	sR3NkNpc=; b=bIQyPX+W3mJP9oLZtjQyTV1K3Juh1WEbvWjJouplKErNyMJzlZ1
	Ze99YNq0ZpWBicSrYMRPUb0hn1eqpWpQwYWXO/GZfG/Pa42+zz3KyQt4ROwKgkM8
	RZE04DS7Xjr5bVEzNgi0pm9syEfx5S5CRjULkwMFoHT2jZXFXIDEVx3SUXvM9NNM
	deZP5poqS/HBlkaqg7Kw0fVxZN6vrv5a3dEC0Ao6+4O/Z9UZDSw7iB0zsMZRhCx4
	Xbc0GexFdHCHvOaGCtUB1OGYVLNWW6G1FU1dUsXyaHyC1Zb5XJIeUSffhbJ0EWDz
	yew3dAVVzKhANKR8RyY/ycWWCrn8EKq5WCA==
X-ME-Sender: <xms:-cQKaFSj77cmjhMUS-cOp6Xuew3wqIw0cA1Hv1RufUrCC8ZhWuO_iQ>
    <xme:-cQKaOweLE_TzBHlUTgFbTA9RLYq2l5v2FLIazvrPQLZfZtdYf2RwQBn9TITzyLQV
    XhioZeObtQenhwq4g>
X-ME-Received: <xmr:-cQKaK2KgXrX5Zg3x4D0ElOCUfQ-7j-SMb6vNgdoSbo0lsAeZ_x8BqUbRVJKF5uVQbEnaF3L-F3IHPMgfekK-lEcTZM_FWQ0ufDj>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvhedtjeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvf
    fujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcuvecujfgrmhgr
    nhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvghrnhepke
    fhueduteekgfdtueegvdfgueeiuedvlefggfefkedvffduvddvkeeuhfeifeejnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrh
    esphhosghogidrtghomhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhope
    hgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:-cQKaNDlHq5-knB0NUdm05YM0qfZKOQw0zz0EW08gK4nEds_kvSNkw>
    <xmx:-cQKaOh9pF05EKmCHN4jK9TkmQ3O6lu3s-mBPbH4m32gmr1WveGunQ>
    <xmx:-cQKaBqo7mp61TcT7oxX1BHgcC4swisd1TV3uSwbX31UhIX4eebqAA>
    <xmx:-cQKaJiAOukNsN2UAIfmZZIc0QgzeGcvxWgAurLkIN7Tq6ne-4vAOw>
    <xmx:-cQKaJT3PHH9FHQBWCbLGRjuz-gAB1vrp33bcJupvfGVBZlR5Vd2Hmdn>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 24 Apr 2025 19:10:49 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH] ci: skip unavailable external software
In-Reply-To: <xmqqfrhxtdg9.fsf@gitster.g> (Junio C. Hamano's message of "Thu,
	24 Apr 2025 15:13:58 -0700")
References: <xmqqfrhxtdg9.fsf@gitster.g>
Date: Thu, 24 Apr 2025 16:10:47 -0700
Message-ID: <xmqqmsc5rw94.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

The ci/install-dependencies.sh script used in a very early phase of
our CI jobs downloads Perforce, Git-LFS, and JGit, used for running
the test scripts.  The test framework is prepared to properly skip
the tests that depend on these external software, but the CI script
is unnecessarily strict (due to its use of "set -e" in ci/lib.sh)
and fails the entire CI run before even starting to test the rest of
the system.

Notice a failure to download to any of these external software, but
keep going.  We need to be careful about cleaning after a failed
wget, as a later part of the script that does:

        if type jgit >/dev/null 2>&1
        then
                echo "$(tput setaf 6)JGit Version$(tput sgr0)"
                jgit version
        else
                echo >&2 "WARNING: JGit wasn't installed, see above for clues why"
        fi

will (surprise!) succeed running "type jgit", and then fail with
"jgit version", taking the whole thing down due to "set -e".

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 ci/install-dependencies.sh | 31 ++++++++++++++++++++++---------
 1 file changed, 22 insertions(+), 9 deletions(-)

diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
index 0df74610d0..e51304c3b0 100755
--- a/ci/install-dependencies.sh
+++ b/ci/install-dependencies.sh
@@ -66,16 +66,29 @@ ubuntu-*|i386/ubuntu-*|debian-*)
 		mkdir --parents "$CUSTOM_PATH"
 
 		wget --quiet --directory-prefix="$CUSTOM_PATH" \
-			"$P4WHENCE/bin.linux26x86_64/p4d" "$P4WHENCE/bin.linux26x86_64/p4"
-		chmod a+x "$CUSTOM_PATH/p4d" "$CUSTOM_PATH/p4"
-
-		wget --quiet "$LFSWHENCE/git-lfs-linux-amd64-$LINUX_GIT_LFS_VERSION.tar.gz"
+			"$P4WHENCE/bin.linux26x86_64/p4d" \
+			"$P4WHENCE/bin.linux26x86_64/p4" &&
+		chmod a+x "$CUSTOM_PATH/p4d" "$CUSTOM_PATH/p4" || {
+			rm -f "$CUSTOM_PATH/p4"
+			rm -f "$CUSTOM_PATH/p4d"
+			echo >&2 "P4 download (optional) failed"
+		}
+
+		wget --quiet \
+		     "$LFSWHENCE/git-lfs-linux-amd64-$LINUX_GIT_LFS_VERSION.tar.gz" &&
 		tar -xzf "git-lfs-linux-amd64-$LINUX_GIT_LFS_VERSION.tar.gz" \
-			-C "$CUSTOM_PATH" --strip-components=1 "git-lfs-$LINUX_GIT_LFS_VERSION/git-lfs"
-		rm "git-lfs-linux-amd64-$LINUX_GIT_LFS_VERSION.tar.gz"
-
-		wget --quiet "$JGITWHENCE" --output-document="$CUSTOM_PATH/jgit"
-		chmod a+x "$CUSTOM_PATH/jgit"
+			-C "$CUSTOM_PATH" --strip-components=1 \
+			"git-lfs-$LINUX_GIT_LFS_VERSION/git-lfs" &&
+		rm "git-lfs-linux-amd64-$LINUX_GIT_LFS_VERSION.tar.gz" || {
+			rm -f "$CUSTOM_PATH/git-lfs"
+			echo >&2 "LFS download (optional) failed"
+		}
+
+		wget --quiet "$JGITWHENCE" --output-document="$CUSTOM_PATH/jgit" &&
+		chmod a+x "$CUSTOM_PATH/jgit" || {
+			rm -f "$CUSTOM_PATH/jgit"
+			echo >&2 "JGit download (optional) failed"
+		}
 		;;
 	esac
 	;;
-- 
2.49.0-555-g089a0e42c4

