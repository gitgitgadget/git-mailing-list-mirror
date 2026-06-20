Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 253063939D0
	for <git@vger.kernel.org>; Sat, 20 Jun 2026 14:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781964620; cv=none; b=OSIV5R2/drD6yHDde66vjiAEyNHemkUyAi8NjvXMkiEd9TzGuHxzjFQ56uTEKE39uKLEVWyhfQRZ82DbjnQI3uFxwyQp72JdHOlWI3s45Kg+LogKpR0k7p763DgP17qnrzhfQA7s/dAzmJD3GpK5AXk0mod6kmH0AmFs+S3gtoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781964620; c=relaxed/simple;
	bh=V77bttG8EQoy1bfo52i2VRw0MTR42XVk1WXxcqX7DpE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l60OS8q82C7hFe4jshlqx91aYujwxf7jiRIRp2aD3l83PyZwvL0UFZ3Fgu8w2GZLJOv8zkbPFa4osLvBdmAoGFtvq8NB1Gohe2xrm9kapeF24QnlUjHp5F/KjVR+HTFX/b3XquXCt66Nv9aJmNuyUG1cvRfltERG1YCnNWXzFLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev; spf=pass smtp.mailfrom=malon.dev; dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b=VR+0VR8Q; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=kYCOLAue; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=malon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b="VR+0VR8Q";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="kYCOLAue"
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=VR+0VR8QnEdTFZCu8enj2g/cwCXexR60ovIfYEPmC9j251hRWb2ceLP4agZXXIGkMST3B85aY8mohEWWQoUNVbhFANwTcEuKvpJowex4G6s2DJxLFuo/Mqm8XvTaMcTe2xyIYm5AWNeHqviNK1PdlzxP6s9wNElW/DgBUQMFdTboKVFzn/+ddOuM6j+7Rbun8hHgrgiT08VQ2LoVmODa2dMUZ7hnqQXLJ/93q/RRg67o7OTQJEiF83ttsWQuo3VowWFj0orHIqw9O+8czo6GfFS2iDlV/wBi5h6acL1JhNqtoMflMeb85rX62SIYH5mAhkx/U7qDqpmz7zjcZnGTuA==; s=purelymail1; d=malon.dev; v=1; bh=V77bttG8EQoy1bfo52i2VRw0MTR42XVk1WXxcqX7DpE=; h=Received:From:To:Subject:Date;
DKIM-Signature: a=rsa-sha256; b=kYCOLAue6u6Dq/NyTUliOBq1xoOFvUVMXil1ZYhCKQvdxF/ZFruz+Nv7r91yblxupH7v4ED7EPVL3g2uzP6/dV99Fx2O3jM9+r3++wKg1YaqP5imbSWEHAP+0Mz4xOgL0ixUENyp6tHYXkpvImu+7MPd8xPxOJMbHOevkzH2Xtn4ipWIj/gsK4gF6oWRTQgwDwvQ9HuPy+xgbLy4yJzubMTdKDNyktwgBfJ/yaogRkpHXtZmVKVrHQhxhjW+CuRv9SF4FzzcpYmtSzLTkhxbC8ois4rJjwTVcJBIfQjJsDyDdkN53A9ISX0m9lPFl+U4f9Zi14mrfaddrQxHIRb5gg==; s=purelymail1; d=purelymail.com; v=1; bh=V77bttG8EQoy1bfo52i2VRw0MTR42XVk1WXxcqX7DpE=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 599969:32685:null:purelymail
X-Pm-Original-To: git@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 960865910;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Sat, 20 Jun 2026 14:10:17 +0000 (UTC)
From: Tian Yuchen <cat@malon.dev>
To: git@vger.kernel.org
Cc: Tian Yuchen <cat@malon.dev>,
	Christian Couder <christian.couder@gmail.com>,
	Ayush Chandekar <ayu.chandekar@gmail.com>,
	Olamide Caleb Bello <belkid98@gmail.com>
Subject: [PATCH] environment: use 'repo->initialized' for repo_protect_hfs() and repo_protect_ntfs()
Date: Sat, 20 Jun 2026 22:09:57 +0800
Message-ID: <20260620140957.667820-1-cat@malon.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <xmqqo6h6jvuk.fsf@gitster.g>
References: <xmqqo6h6jvuk.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by Purelymail
Content-Type: text/plain; charset=UTF-8

To match how we refrain from calling repo_config_values() on an
uninitialized instance of a repository object in other two topics
that deal with ignore_case and trust_executable_bit, check the
repo->initialized bit instead of the repo->gitdir member.

Base commit: 43192e7977f5f05138abcdb3212a3f87ab513bef

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Ayush Chandekar <ayu.chandekar@gmail.com>
Mentored-by: Olamide Caleb Bello <belkid98@gmail.com>
Signed-off-by: Tian Yuchen <cat@malon.dev>
---
 environment.c | 4 ++--
 environment.h | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/environment.c b/environment.c
index 6ee11e9fc8..8f0c1c4f25 100644
--- a/environment.c
+++ b/environment.c
@@ -130,14 +130,14 @@ int is_bare_repository(struct repository *repo)
=20
 int repo_protect_ntfs(struct repository *repo)
 {
-=09return repo->gitdir ?
+=09return (repo && repo->initialized) ?
 =09=09repo_config_values(repo)->protect_ntfs :
 =09=09PROTECT_NTFS_DEFAULT;
 }
=20
 int repo_protect_hfs(struct repository *repo)
 {
-=09return repo->gitdir ?
+=09return (repo && repo->initialized) ?
 =09=09repo_config_values(repo)->protect_hfs :
 =09=09PROTECT_HFS_DEFAULT;
 }
diff --git a/environment.h b/environment.h
index d188955f5b..8aaedcfea3 100644
--- a/environment.h
+++ b/environment.h
@@ -137,8 +137,8 @@ int git_default_core_config(const char *var, const char=
 *value,
=20
 /*
  * Getters for the `protect_hfs` and `protect_ntfs` fields of `struct repo=
_config_values`.
- * They check `repo->gitdir` to prevent calling repo_config_values()
- * before the configuration is loaded or in bare environments.
+ * They check `repo->initialized` to prevent calling `repo_config_values()=
`
+ * before the repository setup is fully complete or in non-git environment=
s.
  */
 int repo_protect_hfs(struct repository *repo);
 int repo_protect_ntfs(struct repository *repo);
--=20
2.43.0

