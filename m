Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B12CF221272
	for <git@vger.kernel.org>; Wed, 16 Apr 2025 12:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744805783; cv=none; b=tKREDclDYKj5ud06L7ss+axuWJQ0WQkIKHEMEzA6hX+DM3/t97G7Qa+dLVWsfq7fMG4+pFco2oQGnbpvx698hJv3j7f5bv6Q6W4KojluiyFv23wHoeaPJk9/841AkYeDzD8KcRZi/7lrouCrgIRdgkz9hhZ5qumZQhgU61oJijE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744805783; c=relaxed/simple;
	bh=V9vrXurmkYJgWyoH7kbXoDrJfgsQYcJrgToGhRR5GRA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=p0Z0f3g47l/ynCPvie4bn+DUpSl4itQ13EFXxDSkbjY0twlvDZ3tgPYIOQ6ErHouYdcZY3LUf+Ox9ViE4Anlwrmz5ij7eJmdp1TdbRUuBOy/bLYqR+x+grIA/W8g2II74YP1wyb4KkdCARnlrue1Bon4IWBBPGz4n1wE1vGSNPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=DB7267pp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=o3GFL9Ry; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="DB7267pp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="o3GFL9Ry"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 6B6E31140307;
	Wed, 16 Apr 2025 08:16:19 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Wed, 16 Apr 2025 08:16:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1744805779;
	 x=1744892179; bh=ab2Rr84K4wwwrfQSRN099LAqhrSMofyZLz66wj7KGu0=; b=
	DB7267pp/HA/JyYWStDlUMlsPA2F8DWLvMFl9FrD3MNbgZ33gMb1fpoefIIcAydi
	0E6BpdzoBLk5Z5OJr7FHCGFmZcssNWb8klPiIS6B83oxuO9usXeRg0RW4Os0JaSX
	vLZ5SNRFUzSMR1+euGkbl8IcW6+1o8fRT5eoJD0bK+mL4c0HG5JneIve7QfneVg3
	zcDLaWTseL9R9Y2UxkqJX3Bcj4NnH2Lk7X6ZI7Q3ZvYmSh3rscpNlZdf/cJc1NKa
	UZ5aLdk1ZVmGRA0CEWuS6TPq8ngJGmaUb+x7gOEAakbCP6zL2p5sPpB19z0tAbIq
	Stz/CipEGulhGjhUwCo/oQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1744805779; x=
	1744892179; bh=ab2Rr84K4wwwrfQSRN099LAqhrSMofyZLz66wj7KGu0=; b=o
	3GFL9Ry8ymVIwjYn0KlMOj0uifU8muMSpSFfhxBTcFkDmI8TO4gQgfYOnzjbU0Iw
	a6oHnWWr+vUdGsE2r96p8YZ1yK/tLCcfa6rtCMA94HHqKZX1dzTIzFXEa4rndNkI
	OemSev24TiqqVVjF7UpBD9brynr9nvqzVZ8dwRR5GbOtVytKPRlFVlKhwHiS2qmT
	YTSHHigoQSjLST4eZ1IF3qND0YCIzwRMB8XxIy+fFlHsTuw91DJRN2wCsWxkvaEv
	pWEvFrvhzHV4nqzPTExW99L2+nCEo/0VDOqzPkTgglCSDb5lMuSmxwppBH2CdMuQ
	d+AtwJLMfl7CU7RVL7zpg==
X-ME-Sender: <xms:k5__Z_SvJT32g4IitZx6UxlTuKAgjC0epHTmNdvNiGbEY0W5fTnZBA>
    <xme:k5__Zww_B_oknoPUi4LiFJWV7otj2gnYFcizuUoZvTojhEAKUbdnJA_CNMxMHoMdD
    BFDS4Tsj9Qv3_DYeg>
X-ME-Received: <xmr:k5__Z034KnbmOx0m6OD-rRUfwA2IRemKBgHCRgXAWxNbpULdu2SDzydVUXDiAask3Fo8eL5qj47tEwR3RAdNYw1rPC5YKfU11qeUj3sZgpxHAA>
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
X-ME-Proxy: <xmx:k5__Z_BSQN3yt0ZsHfGfICCMG0wUcQp3L9p0NW5_H-1Y_rpRQxjkug>
    <xmx:k5__Z4i0atACqFNd0ZCzgiwamj-N9Hqy7VSdVlzfbJRiPFTCyLaYng>
    <xmx:k5__Zzqq53lC5Pm542C5kKzyast6gqrZYqRPGawBl-XWiAtvxIWXow>
    <xmx:k5__ZzgoqbYOocW1qJSt8d-UEwsmC-JX39_yKDOy8oX49bSCxOAodQ>
    <xmx:k5__Z5SwFFIfHxHQ9xsYt0XvQ1oX9IsgD5wIR23AyHRHu3jKCj8Oxyu9>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 16 Apr 2025 08:16:18 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 6e3e710f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 16 Apr 2025 12:16:15 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 16 Apr 2025 14:16:07 +0200
Subject: [PATCH v2 1/4] filter-branch: stop depending on Perl
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250416-b4-pks-drop-perl-v2-1-bdd0492e9498@pks.im>
References: <20250416-b4-pks-drop-perl-v2-0-bdd0492e9498@pks.im>
In-Reply-To: <20250416-b4-pks-drop-perl-v2-0-bdd0492e9498@pks.im>
To: git@vger.kernel.org
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
 Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.2

While git-filter-branch(1) is written as a shell script, the
`--state-branch` feature depends on Perl to save and extract the object
ID mappings. This can lead to subtle breakage though:

  - We execute `perl` directly without respecting the `PERL_PATH`
    configured by the distribution. As such, it may happen that we use
    the wrong version of Perl.

  - We install the script unchanged even if Perl isn't available at all
    on the system, so using `--state-branch` would lead to failure
    altogether in that case.

Fix this by dropping Perl and instead implementing the feature with
shell scripting exclusively.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 git-filter-branch.sh | 37 +++++++++++++++++++------------------
 1 file changed, 19 insertions(+), 18 deletions(-)

diff --git a/git-filter-branch.sh b/git-filter-branch.sh
index 3a51d4507c7..24fa317aaaa 100755
--- a/git-filter-branch.sh
+++ b/git-filter-branch.sh
@@ -295,15 +295,18 @@ then
 	if test -n "$state_commit"
 	then
 		echo "Populating map from $state_branch ($state_commit)" 1>&2
-		perl -e'open(MAP, "-|", "git show $ARGV[0]:filter.map") or die;
-			while (<MAP>) {
-				m/(.*):(.*)/ or die;
-				open F, ">../map/$1" or die;
-				print F "$2" or die;
-				close(F) or die;
-			}
-			close(MAP) or die;' "$state_commit" \
-				|| die "Unable to load state from $state_branch:filter.map"
+
+		git show "$state_commit:filter.map" >"$tempdir"/filter-map ||
+			die "Unable to load state from $state_branch:filter.map"
+		while read line
+		do
+			case "$line" in
+			*:*)
+				echo "${line%:*}" >../map/"${line#*:}";;
+			*)
+				die "Unable to load state from $state_branch:filter.map";;
+			esac
+		done <"$tempdir"/filter-map
 	else
 		echo "Branch $state_branch does not exist. Will create" 1>&2
 	fi
@@ -633,15 +636,13 @@ if test -n "$state_branch"
 then
 	echo "Saving rewrite state to $state_branch" 1>&2
 	state_blob=$(
-		perl -e'opendir D, "../map" or die;
-			open H, "|-", "git hash-object -w --stdin" or die;
-			foreach (sort readdir(D)) {
-				next if m/^\.\.?$/;
-				open F, "<../map/$_" or die;
-				chomp($f = <F>);
-				print H "$_:$f\n" or die;
-			}
-			close(H) or die;' || die "Unable to save state")
+		for file in ../map/*
+		do
+			from_commit=$(basename "$file")
+			to_commit=$(cat "$file")
+			echo "$from_commit:$to_commit"
+		done | git hash-object -w --stdin || die "Unable to save state"
+	)
 	state_tree=$(printf '100644 blob %s\tfilter.map\n' "$state_blob" | git mktree)
 	if test -n "$state_commit"
 	then

-- 
2.49.0.805.g082f7c87e0.dirty

