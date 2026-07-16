Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34EA53D648F
	for <git@vger.kernel.org>; Thu, 16 Jul 2026 08:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784191806; cv=none; b=eCGnX1vavSpDvJQ7haqgCMkC99p+hwLh+iHMj+i3+aTkcTOorbR4sUb0hXDQ8B6f/fNAD+22cSFojHxYp3KDvjnM5TO3f28CfCcrSnMAjSLNitJiyEdqiKbM6ZR7HQJpcRB/sRjhccoPX92KiuA51onjeGxPOyge3CwBWQQoDuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784191806; c=relaxed/simple;
	bh=Tx5a9uTp4ac/kZBXRghvhh8wX/Yo263WVhEq7ZBjQkI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jVRUC4vbkkr0s60IaBOqNuJCJf9jtie2KFZK0P4O606Bc7yY0yJVVUcVGI0EavfikYOUPHD/AMrf9kJ4mb6A9K0GA3IewskuPVyjO8utJpVAQocynvZpP7xcTClA7CyO2drWIVu2YyZQGOmUe2rqiheOG4DPSwKOUe4GENte6To=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev; spf=pass smtp.mailfrom=malon.dev; dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b=CfIz+T52; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=KDWK0mHz; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=malon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b="CfIz+T52";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="KDWK0mHz"
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=CfIz+T523BCTpykCSPbP4dJwT8rrJXQnxm3aiRTqQo88o2VGbJ2zB+Qi9o3R0uHPtDV80zd1c+aC9opcmkqL0IOE8htiIQ7FwMmhK3MZ4IcJswE1u1dfjbDGTqdkqHzHJ5o1OPTMmQeKlmfum1acMkigkm2qXnKWtWmtpGOdVZ+SBjttt6uD65WNZpSMerSrcPpuip611OAO9lap3Go5++OPc37Zy9n8567grkI0Sl0/8cGIWu2o4bx5iXk6G4jE/9y61vh8QnLbUz7kKwxnkAKar/ZDXubghsSNrgotgsZmWWWu4nvFafoYuA2WsD3PHYKxRw4ZE+n/h0bWD8n0bA==; s=purelymail2; d=malon.dev; v=1; bh=Tx5a9uTp4ac/kZBXRghvhh8wX/Yo263WVhEq7ZBjQkI=; h=Received:From:To:Subject:Date;
DKIM-Signature: a=rsa-sha256; b=KDWK0mHzsTJbjyPWhk04BeL2VuKN01rRgpEMfCph1sHjjm9jo0lo80m7X1VzLp62FWsdhe9EUCdTyPYG2ggoSonXQ/AaapoCJAAp8gxb0v3amGKMjHQhuvyKYQz2w+tncH5eROszn+hOCd3fF9riKIhfumYmGrARec188KbWUSayJk4Y9RJmzLm+TwRwPeHuUYIyHn5nXMCOuzTQvhI8snHkwf5dbvr1vGlf94AzVeiLGGzThxA6m6fHGR9KE1XyL39WyyorBAoTh71wETAuxOY+EhpPfYSMBw3VbmmEZof5x+8uUL6v2t4qcRrs8Ps4GElxO6fd6bwakFunpALyIQ==; s=purelymail2; d=purelymail.com; v=1; bh=Tx5a9uTp4ac/kZBXRghvhh8wX/Yo263WVhEq7ZBjQkI=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 599969:32685:null:purelymail
X-Pm-Original-To: git@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id -873613066;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Thu, 16 Jul 2026 08:49:55 +0000 (UTC)
From: Tian Yuchen <cat@malon.dev>
To: git@vger.kernel.org
Cc: ps@pks.im,
	Tian Yuchen <cat@malon.dev>,
	Christian Couder <christian.couder@gmail.com>,
	Ayush Chandekar <ayu.chandekar@gmail.com>,
	Olamide Caleb Bello <belkid98@gmail.com>
Subject: [PATCH v6 1/4] read-cache: remove redundant extern declarations
Date: Thu, 16 Jul 2026 16:49:38 +0800
Message-ID: <20260716084941.1101918-2-cat@malon.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260716084941.1101918-1-cat@malon.dev>
References: <20260715035501.48271-1-cat@malon.dev>
 <20260716084941.1101918-1-cat@malon.dev>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by Purelymail
Content-Type: text/plain; charset=UTF-8

The 'read-cache.c' file already includes 'environment.h', which provides
the extern declarations for variables like 'trust_executable_bit' and
'has_symlinks'.

Remove the redundant extern declarations inside 'st_mode_from_ce()' to
clean up the code.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Ayush Chandekar <ayu.chandekar@gmail.com>
Mentored-by: Olamide Caleb Bello <belkid98@gmail.com>
Signed-off-by: Tian Yuchen <cat@malon.dev>
---
 read-cache.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index 38a04b8de3..c44e4d128f 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -204,8 +204,6 @@ void fill_stat_cache_info(struct index_state *istate, s=
truct cache_entry *ce, st
=20
 static unsigned int st_mode_from_ce(const struct cache_entry *ce)
 {
-=09extern int trust_executable_bit, has_symlinks;
-
 =09switch (ce->ce_mode & S_IFMT) {
 =09case S_IFLNK:
 =09=09return has_symlinks ? S_IFLNK : (S_IFREG | 0644);
--=20
2.43.0

