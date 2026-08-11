Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43B7B4248C5
	for <git@vger.kernel.org>; Tue, 11 Aug 2026 09:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786439109; cv=none; b=I5YRVBkNmYk2c+I6X1OcwD9NjDeF4PGqySoHRitjiFxM6n8muEB+UiHjKo4I6chjaZ9eGAwlFR4N2pI8WO2ko28pQ5iGX+12bfUG5B+X3sRp+6P+fF5CFZ0tWKyiUPLEtmAQ7arTO7ZRLmA+8ZmgjH27Xsia3th7wFaMrdgsV/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786439109; c=relaxed/simple;
	bh=sIx7Nsu2ZeMMyc8MahRIDqS7ErbUok1trhEimusygPM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=kNBN+VHYIGc0ZnQ1OIieV0GlWa5hJlZPRQOYC9hqkxsjp6poZ64sskp79Mij0JHYrTtqwWtFNWpQT4Xs/KviHC+WIpe+v/p+Ozbb0DUzcui2/5yCX9O5WGsG6BHoNdn2rkCBteB/DCqPn3NwH63X6aXIk9DWZbfVTchHgSzJB9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=RW/bpC2K; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BiD86i89; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="RW/bpC2K";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BiD86i89"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 2F9F9EC0118;
	Tue, 11 Aug 2026 05:05:06 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Tue, 11 Aug 2026 05:05:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm3; t=1786439106; x=1786525506; bh=XPVqlQO4QD
	xzx6VWnk46GLZ/JHep2lJVmYVFnd07Tfc=; b=RW/bpC2KcNgi+6teLP96/1EACg
	6yADhVHmjFoUdIMX0fT3VuP5fDgavVTCjvoPfAqtXlHehQszs7fszvX07YZYkdJ9
	JHPQjGlzSmCWABwR4HSTA0vYMY8r3ubpcqnM4kQyeHQqbAUIcOqLo9Uz8TI+bAv2
	IdbXT3KtYSDYe99/Cn0NHX8MQ5M80Hto6w07Sa3gMoA/tbmBxndEWKbrbZ2xtRKf
	NZ5YKU2pIpamdYhAaKQwGysZA2ySX8W64NexRKv4xy/eaBlSbR9WSMlQ5eIYpMRQ
	Qfbr5Hhr6AKH4wAUPr9O2VvamBCVTRTc84cBmclRrkEFS/Sx0hWoIGPSlnSQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1786439106; x=1786525506; bh=XPVqlQO4QDxzx6VWnk46GLZ/JHep
	2lJVmYVFnd07Tfc=; b=BiD86i894vY6cbWRCmrMkPjYtej6XxmGw4oT+CC7YCmh
	FtrVidl2GsJc2p3yOZMYxKza8kWKbgHOcvyzis+sjDYx0FVG+U+2RLzYI3+RdBjz
	eLLKRlA1NXUpV4w9eayALy9eWsnLnzL9R1NokXz3PiEZ8ns/jgNmPHxuLvBIqh5b
	XRpBLbZ8wVHBiUsJnZCQymNsM4PHpcVyfv/9aPgvAlQB+m94Ux8RWzJHcLpT1jTn
	RrSoreSxOUX6A4C0+CebFysc1+YEUYiOoRgVOfxTB7j29CZaNj+W20Qzxh7gukNe
	uoO1UvwYKDH55Jt3yKcdno5kfDDW7+/gIMxrwhuIAQ==
X-ME-Sender: <xms:weV6at0PBBGJmIk7PHCSlIBgN9Q78nevT-q0zjPa8kcRcixqiuBu3g>
    <xme:weV6aqHuSgOgbzrVE-CX46PNIHWglIL8mjeKwtzSpL5sswYgz5OBY2H_9hv3bLkZ0
    cThEQFKd7DoGAHNB0xIxU7XGyMvYIkvz1xPIt9vRVg3PHV3JIljvQ>
X-ME-Received: <xmr:weV6arg2AYgeey3ssuPJE3Ys3z0yq3MzwhrPLce1HTR8zDBFcPZfTx41dae1_QzctZtfve2sp5KfHzw4iRHJDDAkK4W5oI4MvL6D-MfxbA>
X-ME-Proxy-Cause: dmFkZTGfyUzunEJEWVdCITqnyQEjSEAto8PF0pI7RRCTdUmUBhad6cg52pZFUFOsClP1uu
    0O+b4Pqs4/Wj7F1ySsDNh8aRVcc6HXQgE1AFAJ+O+AAHJQfX0675VBeP6FGVHG4CpYiy4d
    FMLuDxMfeDrjxx5bLt09/1qPQyvstx1w//6wBUtE3rcrQWu07ib1J5Tg94k/fP0e9Z3rTE
    zwy93FPw1S5KQu9mdqUTP+XnQnF8xCFIksBWDHGA9/CyFSDx1y7VJmyBMi2CGtid3i7WVv
    TteokyfRr+7gI1NLGG+S0TyxFXDAJrSfmL02p3+VtlqR2cg0iZkCqMDCH+vsYY7mO5MAgT
    ZjdRnZtR98wfNdMOoyJdi4SolSfos1I6QblyGq+oRQOpwdKfWcy45UjbxhAOALGXYZtUdT
    EqXGAkG4F1BA5irh1LKDxVC7/lWZLBx5es4hKq5r3vEJV7RUY3bn6ysyzIJs7ctFiVh9OS
    CutiX5ib6zXb7kEgfz4g5WQkLnVYdB9F5YP9JWo/GgJ2Yo+GUtejqV8Gsz1Gj5JwRXTijJ
    gG4opYmoTg3b/qP5HEleJXyDf4rBv8xo5cuLUVmzHKB8cyogtfXu77lJDUpaGqQHDOteKH
    5M7gwYL99FgOe64iadmpTSghYFW0039pgTb5ciQaLP9hxokjDuLcrPoobYkw
X-ME-Proxy: <xmx:weV6al_lJyn8j_kvAhu2NN_1m37EtS7F2jhtu7-JTWa1Uz0N3wsvPg>
    <xmx:weV6aiqBah0aQlf-zhjRVWYsa01OlOQSQTXavU74ao-R8ECX_wpilQ>
    <xmx:weV6ak-mtFJEooo4n2Md_2Hsqlj-IHQUh49jQYA_UPRDSZGe6WFgyw>
    <xmx:weV6amV8vjIPW0wdviS0cNx6o8EVDyiC1PFoK9foSIf5wHQPmrUweQ>
    <xmx:wuV6aihel2CpU4xgUdI4ohJ7PExoEN2es2aTTlqEPBf8bPgvbhNV7BAc>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Aug 2026 05:05:05 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 9e83364b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 11 Aug 2026 09:05:00 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 11 Aug 2026 11:04:48 +0200
Subject: [PATCH] odb/files: be less aggressive with geometric repacking
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260811-pks-geometric-maintenance-reduce-frequency-v1-1-7a54c42355ac@pks.im>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXNwQ6CMBCE4Vche7ZJC2rUVzEeyjLgaii4bY2G8
 O5WPU2+y/wLRagg0qlaSPGUKFMocJuK+OrDACNdMdW23tuDs2a+RzNgGpFU2IxeQkLwgWEUXS7
 TKx4Zgd9mx46P27phtA2Vw1nRy+sXO1/+jrm9gdO3QOv6AUBJ+VmOAAAA
X-Change-ID: 20260810-pks-geometric-maintenance-reduce-frequency-5c1c9423ceb3
To: git@vger.kernel.org
Cc: Stefan Haller <lists@haller-berlin.de>
X-Mailer: b4 0.15.2

When performing auto-maintenance with geometric repacking we have two
conditions that may trigger a repack:

  - Either the geometric sequence of packfiles is invalidated.

  - Or we have too many loose objects.

The first condition shouldn't trigger all that often: it may be hit when
we fetch a new packfile, but users tend to not do that all the time. The
second condition is what typically triggers more regularly though, as
every command that ends up writing new objects may cause us to cross the
threshold of loose objects. It is thus preferable to not be too
aggressive here, as otherwise we may end up repacking objects quite
often.

For the geometric-repacking strategy though we have a default of 100
objects, only. As we're approximating the count of objects by only
reading the "objects/17/" shared, we'd only need 2 objects in there
before we perform a repack by default, which is quite aggressive.
git-gc(1) on the other hand has a default of 6700, so it is quite a bit
more conservative here.

Being this aggressive is also causing problems as reported by our users.
When running lots of concurrent writers, those writes will constantly
end up spawning maintenance jobs that end up repacking objects. As we
also prune objects, a concurrently running process that tries to write
an object may see that the sharding directories get removed under their
feet. While we try re-creating such leading directories, we only do so a
single time, and it may happen that the directory vanishes again before
we had the chance to create the loose object. This is not a new problem,
but it is exacerbated by us running maintenance this aggressively.

Improve the status quo by reducing the frequency at which we pack loose
objects to the same frequency that git-gc(1) uses.

Reported-by: Stefan Haller <lists@haller-berlin.de>
Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
Hi,

as reported by Stefan at [1]. Thanks!

Patrick

[1]: <4f6a96ac-d993-4872-b3c4-30d899f61ca9@haller-berlin.de>
---
 Documentation/config/maintenance.adoc | 2 +-
 odb/source-files.c                    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/config/maintenance.adoc b/Documentation/config/maintenance.adoc
index b578856dde..da8be9f812 100644
--- a/Documentation/config/maintenance.adoc
+++ b/Documentation/config/maintenance.adoc
@@ -101,7 +101,7 @@ maintenance.geometric-repack.auto::
 	there are packfiles that need to be merged together to retain the
 	geometric progression, or when there are at least this many loose
 	objects that would be written into a new packfile. The default value is
-	100.
+	6700.
 
 maintenance.geometric-repack.splitFactor::
 	This integer config option controls the factor used for the geometric
diff --git a/odb/source-files.c b/odb/source-files.c
index 5a68af7d84..555e466145 100644
--- a/odb/source-files.c
+++ b/odb/source-files.c
@@ -521,7 +521,7 @@ bool odb_source_files_optimize_required(struct odb_source *source,
 		};
 		struct existing_packs existing_packs = EXISTING_PACKS_INIT;
 		struct string_list kept_packs = STRING_LIST_INIT_DUP;
-		int auto_value = 100;
+		int auto_value = 6700;
 		bool ret;
 
 		repo_config_get_int(repo, "maintenance.geometric-repack.auto",

---
base-commit: 010afd3166ddc64c9863b1506f12cbcdda0d4ea1
change-id: 20260810-pks-geometric-maintenance-reduce-frequency-5c1c9423ceb3

