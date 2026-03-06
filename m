Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 209BC17C69
	for <git@vger.kernel.org>; Fri,  6 Mar 2026 05:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772775149; cv=none; b=ARW2c3FJvf0mi2oAtQ8CpD/hJx1KRimn8o3U7S72XCijWjWCca4XkR8VrCkoNgmtn+HVFxgDExPPxfvY4DRWBsCjM5c6POaiOcM22tJgz0Tk8/YGFHvhpw2HX4X4b262oDDh7kIGNn1BkumqN/svbhZFphjJbV8MuouwwZrbhKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772775149; c=relaxed/simple;
	bh=KefOUKeqrEAMZ55vCYpRfxG63F41xe0OyIGKWUK/Qx0=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=IdGv7ZDGCHKAS/RKWQ1HfcZuCPUeOsSE1arGi4B4cO2mIYL9+TjQYJcEkQTW4mt0cG1S2/18BuiQlGdXzFbgEgKRN4dezsdoXFLgBk6G2EYQvJug5TtiexBme3j4/qF903wdrufo8E/VELZq5VyVPDoU1vosvTqY7a0xVkQ8/zE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wolfgangfaust.com; spf=pass smtp.mailfrom=wolfgangfaust.com; dkim=pass (2048-bit key) header.d=wolfgangfaust.com header.i=@wolfgangfaust.com header.b=AcTm4UbI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nqwaSWHe; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wolfgangfaust.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wolfgangfaust.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wolfgangfaust.com header.i=@wolfgangfaust.com header.b="AcTm4UbI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nqwaSWHe"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 6E3B6EC0595;
	Fri,  6 Mar 2026 00:32:27 -0500 (EST)
Received: from phl-imap-08 ([10.202.2.84])
  by phl-compute-01.internal (MEProxy); Fri, 06 Mar 2026 00:32:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	wolfgangfaust.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1772775147; x=1772861547; bh=LrUOtOAFIM
	+TBHzDQ3cyFNj3ZKlgY0Z5FmWTMl6/Zio=; b=AcTm4UbI8Y7GsBjLTCSBBmxQSv
	dJOhv/HQ5NjumFZmxGXH2rM1KctBxzG0evnb6igh4ouBaEBZMD05zWexUFwCQnyv
	BLVOwNIrCtJxH4X9Y1GHUERuPFmGvCeHayuYY2eYfMpMg7We3GOrDyuIcpolnSLp
	CmNY3tCTEg5QLl4D9RMAC8ta30KpDkeWMNruszQ5VcwYG/tt8Ho4439CgJDly6lZ
	I+pWZQNhENo6pMXtaoq1ww/RTk2R6ZG1SIkAJYHXJJexd4FEAciFJACQgCU/j8Ut
	ql7qv94dhGgK6/BaS3zIpjSnopVu/G3vaxsIcaSPZy0JqutyDTg9vad6/UmQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1772775147; x=
	1772861547; bh=LrUOtOAFIM+TBHzDQ3cyFNj3ZKlgY0Z5FmWTMl6/Zio=; b=n
	qwaSWHe57TPbJFn3mI62HXvocPi/hncjQxVPNbTFEG9jbLMxUCHXjPgnujkcdnPJ
	ku+E9J/7qPzLfqTdT7JESlDD39cMpaewmPqsE6KoqfKwXXZoMLbH2FWGC1H/UKPj
	FTayI91n4t9gCEPdPez/q0AysX6VCqHVuZPv04w6uqiKY2njKC3+MLht2d+BPoqS
	1uJhb4H3TwLOsjrejSs57RySW9IagEzTlYN2Y/uY2medN6JdhHLVDph5uCyYkVbl
	4mn3qFSR18VuGsLvMTq4w7OngLemabz2RfI6YGuCHP022RpTTwnnxeYXHujqDaQk
	ytb4mmE1siKx+bLuNorvQ==
X-ME-Sender: <xms:62aqaavRkIVdFA1oPEbdxdNFq63dzJIKJJPFiSAZJu9OcJtecgK98g>
    <xme:62aqaaS7O2qb5fmGd4YzcZxcXpN4RavM1_2UMaurR2w6XaD6LAgSmnTeYBH9INrb2
    Vdn3-SNA7tH-Mu2KZtaq-U9JUaWyG5pDmHGns7UEnDA8Y4ol96Syg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvieekgeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefoggffhffvvefkjghfufgtgfesthhqre
    dtredtjeenucfhrhhomhepfdghohhlfhhgrghnghcuhfgruhhsthdfuceotghonhhtrhhi
    sgdqghhithesfiholhhfghgrnhhgfhgruhhsthdrtghomheqnecuggftrfgrthhtvghrnh
    epvdeifedthedvgfdtjeduteeuvddutddvvdffffegudduudetueffieeuffdtvdetnecu
    vehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomheptghonhhtrh
    hisgdqghhithesfiholhhfghgrnhhgfhgruhhsthdrtghomhdpnhgspghrtghpthhtohep
    vddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepjheitheskhgusghgrdhorhhgpd
    hrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:62aqaZb5LigULoL3AXFi4VNoR3QuupgJXk0ir4SZV3SKiMaxw17d8A>
    <xmx:62aqaeVRX6JiWLIf_3vj4ojZhyGVdhJ05Np4zgDEt-Xi5TzFM0HYRg>
    <xmx:62aqaTgaDMXcKbZIcVPkR9sIVhFLs2aKhFVAWzEYQeiJ-0sX35SrIg>
    <xmx:62aqaUVl7R4uX4hm4qBhueYFtXgQ57MmuGFAfbqZvlQgqz5vIRkJBw>
    <xmx:62aqaZMTKwcLeU2R3mUcZNDNL0F-mXFoCuh_SUXeHK1GoJR4oxtTet15>
Feedback-ID: ifd814412:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 3DF6C2CE0072; Fri,  6 Mar 2026 00:32:27 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AX21AeLsmHX3
Date: Thu, 05 Mar 2026 21:32:04 -0800
From: "Wolfgang Faust" <contrib-git@wolfgangfaust.com>
To: git@vger.kernel.org
Cc: "Johannes Sixt" <j6t@kdbg.org>
Message-Id: <65650733-1597-469f-9a2a-7358abf10b4e@app.fastmail.com>
In-Reply-To: <091e68fa-428d-48b0-bf7d-42b01660d6eb@app.fastmail.com>
References: <091e68fa-428d-48b0-bf7d-42b01660d6eb@app.fastmail.com>
Subject: [PATCH 3/4] git-gui: remove "Compress Database" feature
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Now that git-gui runs auto maintenance on commit and we expect that user=
s no
longer need to manually compress the database on a regular basis, this f=
eature
is not necessary.

Signed-off-by: Wolfgang Faust <contrib-git@wolfgangfaust.com>
---
This patch is more to start discussion than something I think is necessa=
rily a
good idea: maybe there are other circumstances where this is still usefu=
l?

 git-gui/git-gui.sh       |  3 ---
 git-gui/lib/database.tcl | 14 --------------
 git-gui/po/bg.po         |  6 ------
 git-gui/po/de.po         | 10 ----------
 git-gui/po/el.po         | 10 ----------
 git-gui/po/fr.po         | 10 ----------
 git-gui/po/hu.po         | 10 ----------
 git-gui/po/it.po         | 10 ----------
 git-gui/po/ja.po         | 10 ----------
 git-gui/po/nb.po         | 10 ----------
 git-gui/po/pt_br.po      | 10 ----------
 git-gui/po/pt_pt.po      | 10 ----------
 git-gui/po/ru.po         | 10 ----------
 git-gui/po/sv.po         | 10 ----------
 git-gui/po/vi.po         | 10 ----------
 git-gui/po/zh_cn.po      | 10 ----------
 16 files changed, 153 deletions(-)

diff --git a/git-gui/git-gui.sh b/git-gui/git-gui.sh
index 29b708f9c8..d2f3ff3e96 100755
--- a/git-gui/git-gui.sh
+++ b/git-gui/git-gui.sh
@@ -2652,9 +2652,6 @@ if {[is_enabled multicommit]} {
 	.mbar.repository add command -label [mc "Database Statistics"] \
 		-command do_stats
=20
-	.mbar.repository add command -label [mc "Compress Database"] \
-		-command do_gc
-
 	.mbar.repository add command -label [mc "Verify Database"] \
 		-command do_fsck_objects
=20
diff --git a/git-gui/lib/database.tcl b/git-gui/lib/database.tcl
index 9b4cc98df5..7edb45b5c8 100644
--- a/git-gui/lib/database.tcl
+++ b/git-gui/lib/database.tcl
@@ -29,11 +29,7 @@ proc do_stats {} {
 	ttk::button $w.buttons.close -text [mc Close] \
 		-default active \
 		-command [list destroy $w]
-	ttk::button $w.buttons.gc -text [mc "Compress Database"] \
-		-default normal \
-		-command "destroy $w;do_gc"
 	pack $w.buttons.close -side right
-	pack $w.buttons.gc -side left
 	pack $w.buttons -side bottom -fill x -pady 10 -padx 10
=20
 	ttk::labelframe $w.stat -text [mc "Database Statistics"]
@@ -67,16 +63,6 @@ proc do_stats {} {
 	tkwait window $w
 }
=20
-proc do_gc {} {
-	set w [console::new {gc} [mc "Compressing the object database"]]
-	console::chain $w {
-		{exec git pack-refs --prune}
-		{exec git reflog expire --all}
-		{exec git repack -a -d -l}
-		{exec git rerere gc}
-	}
-}
-
 proc do_fsck_objects {} {
 	set w [console::new {fsck-objects} \
 		[mc "Verifying the object database with fsck-objects"]]
diff --git a/git-gui/po/bg.po b/git-gui/po/bg.po
index 2670bbb4ef..c7f3e57a58 100644
--- a/git-gui/po/bg.po
+++ b/git-gui/po/bg.po
@@ -184,9 +184,6 @@ msgstr "=D0=92=D0=B8=D0=B7=D1=83=D0=B0=D0=BB=D0=B8=D0=
=B7=D0=B0=D1=86=D0=B8=D1=8F =D0=BD=D0=B0 =D0=B8=D1=81=D1=82=D0=BE=D1=80=D0=
=B8=D1=8F=D1=82=D0=B0 =D0=BD=D0=B0 =E2=80=9E%s=E2=80=9C"
 msgid "Database Statistics"
 msgstr "=D0=A1=D1=82=D0=B0=D1=82=D0=B8=D1=81=D1=82=D0=B8=D0=BA=D0=B0 =D0=
=BD=D0=B0 =D0=B1=D0=B0=D0=B7=D0=B0=D1=82=D0=B0 =D0=BE=D1=82 =D0=B4=D0=B0=
=D0=BD=D0=BD=D0=B8"
=20
-msgid "Compress Database"
-msgstr "=D0=9A=D0=BE=D0=BC=D0=BF=D1=80=D0=B5=D1=81=D0=B8=D1=80=D0=B0=D0=
=BD=D0=B5 =D0=BD=D0=B0 =D0=B1=D0=B0=D0=B7=D0=B0=D1=82=D0=B0 =D0=BE=D1=82=
 =D0=B4=D0=B0=D0=BD=D0=BD=D0=B8"
-
 msgid "Verify Database"
 msgstr "=D0=9F=D1=80=D0=BE=D0=B2=D0=B5=D1=80=D0=BA=D0=B0 =D0=BD=D0=B0 =D0=
=B1=D0=B0=D0=B7=D0=B0=D1=82=D0=B0 =D0=BE=D1=82 =D0=B4=D0=B0=D0=BD=D0=BD=D0=
=B8"
=20
@@ -1161,9 +1158,6 @@ msgstr "%s:"
 msgid "%s (%s): Database Statistics"
 msgstr "%s (%s): =D0=A1=D1=82=D0=B0=D1=82=D0=B8=D1=81=D1=82=D0=B8=D0=BA=
=D0=B0 =D0=BD=D0=B0 =D0=B1=D0=B0=D0=B7=D0=B0=D1=82=D0=B0 =D0=BE=D1=82 =D0=
=B4=D0=B0=D0=BD=D0=BD=D0=B8"
=20
-msgid "Compressing the object database"
-msgstr "=D0=9A=D0=BE=D0=BC=D0=BF=D1=80=D0=B5=D1=81=D0=B8=D1=80=D0=B0=D0=
=BD=D0=B5 =D0=BD=D0=B0 =D0=B1=D0=B0=D0=B7=D0=B0=D1=82=D0=B0 =D1=81 =D0=B4=
=D0=B0=D0=BD=D0=BD=D0=B8 =D0=B7=D0=B0 =D0=BE=D0=B1=D0=B5=D0=BA=D1=82=D0=B8=
=D1=82=D0=B5"
-
 msgid "Verifying the object database with fsck-objects"
 msgstr "=D0=9F=D1=80=D0=BE=D0=B2=D0=B5=D1=80=D0=BA=D0=B0 =D0=BD=D0=B0 =D0=
=B1=D0=B0=D0=B7=D0=B0=D1=82=D0=B0 =D1=81 =D0=B4=D0=B0=D0=BD=D0=BD=D0=B8 =
=D0=B7=D0=B0 =D0=BE=D0=B1=D0=B5=D0=BA=D1=82=D0=B8=D1=82=D0=B5 =D1=81 =D0=
=BF=D1=80=D0=BE=D0=B3=D1=80=D0=B0=D0=BC=D0=B0=D1=82=D0=B0 =E2=80=9Efsck-=
objects=E2=80=9C"
=20
diff --git a/git-gui/po/de.po b/git-gui/po/de.po
index 490ed25e0d..c9d197335e 100644
--- a/git-gui/po/de.po
+++ b/git-gui/po/de.po
@@ -246,11 +246,6 @@ msgstr "Historie von =C2=BB%s=C2=AB darstellen"
 #: git-gui.sh:2799 lib/database.tcl:40
 msgid "Database Statistics"
 msgstr "Datenbankstatistik"
-
-#: git-gui.sh:2802 lib/database.tcl:33
-msgid "Compress Database"
-msgstr "Datenbank komprimieren"
-
 #: git-gui.sh:2805
 msgid "Verify Database"
 msgstr "Datenbank =C3=BCberpr=C3=BCfen"
@@ -2673,11 +2668,6 @@ msgstr "Dateien im M=C3=BClleimer"
 #, tcl-format
 msgid "%s (%s): Database Statistics"
 msgstr "%s (%s): Datenbankstatistik"
-
-#: lib/database.tcl:72
-msgid "Compressing the object database"
-msgstr "Objektdatenbank komprimieren"
-
 #: lib/database.tcl:83
 msgid "Verifying the object database with fsck-objects"
 msgstr "Die Objektdatenbank durch =C2=BBfsck-objects=C2=AB =C3=BCberpr=C3=
=BCfen lassen"
diff --git a/git-gui/po/el.po b/git-gui/po/el.po
index 1c77b98b14..5f780f4c5b 100644
--- a/git-gui/po/el.po
+++ b/git-gui/po/el.po
@@ -197,11 +197,6 @@ msgstr "=CE=91=CF=80=CE=B5=CE=B9=CE=BA=CF=8C=CE=BD=CE=
=B9=CF=83=CE=B7 =CE=99=CF=83=CF=84=CE=BF=CF=81=CE=B9=CE=BA=CE=BF=CF=8D =CF=
=84=CE=BF=CF=85 %s"
 #: git-gui.sh:1906 lib/database.tcl:27 lib/database.tcl:67
 msgid "Database Statistics"
 msgstr "=CE=A3=CF=84=CE=B1=CF=84=CE=B9=CF=83=CF=84=CE=B9=CE=BA=CE=AC =CE=
=92=CE=AC=CF=83=CE=B7=CF=82 =CE=94=CE=B5=CE=B4=CE=BF=CE=BC=CE=AD=CE=BD=CF=
=89=CE=BD"
-
-#: git-gui.sh:1909 lib/database.tcl:34
-msgid "Compress Database"
-msgstr "=CE=A3=CF=85=CE=BC=CF=80=CE=AF=CE=B5=CF=83=CE=B7 =CE=92=CE=AC=CF=
=83=CE=B7=CF=82 =CE=94=CE=B5=CE=B4=CE=BF=CE=BC=CE=AD=CE=BD=CF=89=CE=BD"
-
 #: git-gui.sh:1912
 msgid "Verify Database"
 msgstr "=CE=95=CF=80=CE=B1=CE=BB=CE=AE=CE=B8=CE=B5=CF=85=CF=83=CE=B7 =CE=
=92=CE=AC=CF=83=CE=B7=CF=82 =CE=94=CE=B5=CE=B4=CE=BF=CE=BC=CE=AD=CE=BD=CF=
=89=CE=BD"
@@ -1400,11 +1395,6 @@ msgstr "=CE=A0=CE=B1=CE=BA=CE=B5=CF=84=CE=B1=CF=81=
=CE=B9=CF=83=CE=BC=CE=AD=CE=BD=CE=B1 =CE=B1=CE=BD=CF=84=CE=B9=CE=BA=CE=B5=
=CE=AF=CE=BC=CE=B5=CE=BD=CE=B1 =CE=AD=CF=84=CE=BF=CE=B9=CE=BC=CE=B1 =CE=B3=
=CE=B9=CE=B1 =CE=BA
 #: lib/database.tcl:49
 msgid "Garbage files"
 msgstr "=CE=86=CF=87=CF=81=CE=B7=CF=83=CF=84=CE=B1 =CE=B1=CF=81=CF=87=CE=
=B5=CE=AF=CE=B1"
-
-#: lib/database.tcl:72
-msgid "Compressing the object database"
-msgstr "=CE=93=CE=AF=CE=BD=CE=B5=CF=84=CE=B1=CE=B9 =CF=83=CF=85=CE=BC=CF=
=80=CE=AF=CE=B5=CF=83=CE=B7 =CF=84=CE=B7=CF=82 =CE=B2=CE=AC=CF=83=CE=B7=CF=
=82 =CE=B4=CE=B5=CE=B4=CE=BF=CE=BC=CE=AD=CE=BD=CF=89=CE=BD =CE=B1=CE=BD=CF=
=84=CE=B9=CE=BA=CE=B5=CE=B9=CE=BC=CE=AD=CE=BD=CF=89=CE=BD"
-
 #: lib/database.tcl:83
 msgid "Verifying the object database with fsck-objects"
 msgstr ""
diff --git a/git-gui/po/fr.po b/git-gui/po/fr.po
index 9da3e09ba2..d0354ed8ff 100644
--- a/git-gui/po/fr.po
+++ b/git-gui/po/fr.po
@@ -227,11 +227,6 @@ msgstr "Voir l'historique de la branche : %s"
 #: git-gui.sh:2510 lib/database.tcl:27 lib/database.tcl:67
 msgid "Database Statistics"
 msgstr "Statistiques du d=C3=A9p=C3=B4t"
-
-#: git-gui.sh:2513 lib/database.tcl:34
-msgid "Compress Database"
-msgstr "Comprimer le d=C3=A9p=C3=B4t"
-
 #: git-gui.sh:2516
 msgid "Verify Database"
 msgstr "V=C3=A9rifier le d=C3=A9p=C3=B4t"
@@ -1547,11 +1542,6 @@ msgstr "Objets empaquet=C3=A9s attendant d'=C3=AA=
tre supprim=C3=A9s"
 #: lib/database.tcl:49
 msgid "Garbage files"
 msgstr "Fichiers poubelle"
-
-#: lib/database.tcl:72
-msgid "Compressing the object database"
-msgstr "Compression de la base des objets"
-
 #: lib/database.tcl:83
 msgid "Verifying the object database with fsck-objects"
 msgstr "V=C3=A9rification de la base des objets avec fsck-objects"
diff --git a/git-gui/po/hu.po b/git-gui/po/hu.po
index 4404af74d6..8141ab13f3 100644
--- a/git-gui/po/hu.po
+++ b/git-gui/po/hu.po
@@ -215,11 +215,6 @@ msgstr "A(z) %s branch t=C3=B6rt=C3=A9net=C3=A9nek =
vizualiz=C3=A1l=C3=A1sa"
 #: git-gui.sh:2334 lib/database.tcl:27 lib/database.tcl:67
 msgid "Database Statistics"
 msgstr "Adatb=C3=A1zis statisztik=C3=A1k"
-
-#: git-gui.sh:2337 lib/database.tcl:34
-msgid "Compress Database"
-msgstr "Adatb=C3=A1zis t=C3=B6m=C3=B6r=C3=ADt=C3=A9se"
-
 #: git-gui.sh:2340
 msgid "Verify Database"
 msgstr "Adatb=C3=A1zis ellen=C5=91rz=C3=A9se"
@@ -1496,11 +1491,6 @@ msgstr "Elt=C3=A1vol=C3=ADt=C3=A1sra v=C3=A1r=C3=B3=
 csomagolt objektumok sz=C3=A1mra"
 #: lib/database.tcl:49
 msgid "Garbage files"
 msgstr "Hullad=C3=A9k f=C3=A1jlok"
-
-#: lib/database.tcl:72
-msgid "Compressing the object database"
-msgstr "Az objektum adatb=C3=A1zis t=C3=B6m=C3=B6r=C3=ADt=C3=A9se"
-
 #: lib/database.tcl:83
 msgid "Verifying the object database with fsck-objects"
 msgstr "Az objektum adatb=C3=A1zis ellen=C5=91rz=C3=A9se az fsck-object=
s haszn=C3=A1lat=C3=A1val"
diff --git a/git-gui/po/it.po b/git-gui/po/it.po
index b590dfbbd0..6e9b8d97b7 100644
--- a/git-gui/po/it.po
+++ b/git-gui/po/it.po
@@ -225,11 +225,6 @@ msgstr "Visualizza la cronologia di %s"
 #: git-gui.sh:2510 lib/database.tcl:27 lib/database.tcl:67
 msgid "Database Statistics"
 msgstr "Statistiche dell'archivio"
-
-#: git-gui.sh:2513 lib/database.tcl:34
-msgid "Compress Database"
-msgstr "Comprimi l'archivio"
-
 #: git-gui.sh:2516
 msgid "Verify Database"
 msgstr "Verifica l'archivio"
@@ -1543,11 +1538,6 @@ msgstr "Oggetti impacchettati che attendono la po=
tatura"
 #: lib/database.tcl:49
 msgid "Garbage files"
 msgstr "File inutili"
-
-#: lib/database.tcl:72
-msgid "Compressing the object database"
-msgstr "Compressione dell'archivio in corso"
-
 #: lib/database.tcl:83
 msgid "Verifying the object database with fsck-objects"
 msgstr "Verifica dell'archivio con fsck-objects in corso"
diff --git a/git-gui/po/ja.po b/git-gui/po/ja.po
index d52bcd7f8c..31b59c8e58 100644
--- a/git-gui/po/ja.po
+++ b/git-gui/po/ja.po
@@ -246,11 +246,6 @@ msgstr "=E3=83=96=E3=83=A9=E3=83=B3=E3=83=81 %s =E3=
=81=AE=E5=B1=A5=E6=AD=B4=E3=82=92=E8=A6=8B=E3=82=8B"
 #: git-gui.sh:2719 lib/database.tcl:40 lib/database.tcl:66
 msgid "Database Statistics"
 msgstr "=E3=83=87=E3=83=BC=E3=82=BF=E3=83=99=E3=83=BC=E3=82=B9=E7=B5=B1=
=E8=A8=88"
-
-#: git-gui.sh:2722 lib/database.tcl:33
-msgid "Compress Database"
-msgstr "=E3=83=87=E3=83=BC=E3=82=BF=E3=83=99=E3=83=BC=E3=82=B9=E5=9C=A7=
=E7=B8=AE"
-
 #: git-gui.sh:2725
 msgid "Verify Database"
 msgstr "=E3=83=87=E3=83=BC=E3=82=BF=E3=83=99=E3=83=BC=E3=82=B9=E6=A4=9C=
=E8=A8=BC"
@@ -1930,11 +1925,6 @@ msgstr "=E3=83=91=E3=83=83=E3=82=AF=E3=81=AB=E5=AD=
=98=E5=9C=A8=E3=81=99=E3=82=8B=E3=81=AE=E3=81=A7=E6=8D=A8=E3=81=A6=E3=81=
=A6=E8=89=AF=E3=81=84=E3=82=AA=E3=83=96=E3=82=B8=E3=82=A7=E3=82=AF=E3=83=
=88=E3=81=AE=E6=95=B0"
 #: lib/database.tcl:48
 msgid "Garbage files"
 msgstr "=E3=82=B4=E3=83=9F=E3=83=95=E3=82=A1=E3=82=A4=E3=83=AB"
-
-#: lib/database.tcl:72
-msgid "Compressing the object database"
-msgstr "=E3=83=87=E3=83=BC=E3=82=BF=E3=83=99=E3=83=BC=E3=82=B9=E5=9C=A7=
=E7=B8=AE"
-
 #: lib/database.tcl:83
 msgid "Verifying the object database with fsck-objects"
 msgstr "fsck-objects =E3=81=A7=E3=82=AA=E3=83=96=E3=82=B8=E3=82=A7=E3=82=
=AF=E3=83=88=E3=83=BB=E3=83=87=E3=83=BC=E3=82=BF=E3=83=99=E3=83=BC=E3=82=
=B9=E3=82=92=E6=A4=9C=E8=A8=BC=E3=81=97=E3=81=A6=E3=81=84=E3=81=BE=E3=81=
=99"
diff --git a/git-gui/po/nb.po b/git-gui/po/nb.po
index 4b6e5136b0..41b8eb9b51 100644
--- a/git-gui/po/nb.po
+++ b/git-gui/po/nb.po
@@ -215,11 +215,6 @@ msgstr "Visualiser historien til %s"
 #: git-gui.sh:2334 lib/database.tcl:27 lib/database.tcl:67
 msgid "Database Statistics"
 msgstr "Databasestatistikk"
-
-#: git-gui.sh:2337 lib/database.tcl:34
-msgid "Compress Database"
-msgstr "Kompress databasen"
-
 #: git-gui.sh:2340
 msgid "Verify Database"
 msgstr "Verifiser databasen"
@@ -1453,11 +1448,6 @@ msgstr "Pakkede objekter som avventer fjerning"
 #: lib/database.tcl:49
 msgid "Garbage files"
 msgstr "Avfallsfiler"
-
-#: lib/database.tcl:72
-msgid "Compressing the object database"
-msgstr "Komprimerer objektdatabasen"
-
 #: lib/database.tcl:83
 msgid "Verifying the object database with fsck-objects"
 msgstr "Verifiserer objektdatabasen med fsck-objects"
diff --git a/git-gui/po/pt_br.po b/git-gui/po/pt_br.po
index 8580aaaece..327708b511 100644
--- a/git-gui/po/pt_br.po
+++ b/git-gui/po/pt_br.po
@@ -223,11 +223,6 @@ msgstr "Visualizar hist=C3=B3rico de %s"
 #: git-gui.sh:2510 lib/database.tcl:27 lib/database.tcl:67
 msgid "Database Statistics"
 msgstr "Estat=C3=ADsticas do banco de dados"
-
-#: git-gui.sh:2513 lib/database.tcl:34
-msgid "Compress Database"
-msgstr "Compactar banco de dados"
-
 #: git-gui.sh:2516
 msgid "Verify Database"
 msgstr "Verificar banco de dados"
@@ -1532,11 +1527,6 @@ msgstr "Objetos compactados aguardando elimina=C3=
=A7=C3=A3o"
 #: lib/database.tcl:49
 msgid "Garbage files"
 msgstr "Arquivos de lixo"
-
-#: lib/database.tcl:72
-msgid "Compressing the object database"
-msgstr "Compactando banco de dados de objetos"
-
 #: lib/database.tcl:83
 msgid "Verifying the object database with fsck-objects"
 msgstr "Verificando banco de dados de objetos com fsck-objects"
diff --git a/git-gui/po/pt_pt.po b/git-gui/po/pt_pt.po
index e6354ce5c0..498700c91f 100644
--- a/git-gui/po/pt_pt.po
+++ b/git-gui/po/pt_pt.po
@@ -247,11 +247,6 @@ msgstr "Visualizar hist=C3=B3rico de %s"
 #: git-gui.sh:2719 lib/database.tcl:40 lib/database.tcl:66
 msgid "Database Statistics"
 msgstr "Estat=C3=ADsticas da base de dados"
-
-#: git-gui.sh:2722 lib/database.tcl:33
-msgid "Compress Database"
-msgstr "Comprimir base de dados"
-
 #: git-gui.sh:2725
 msgid "Verify Database"
 msgstr "Verificar base de dados"
@@ -2528,11 +2523,6 @@ msgstr "Objetos compactados =C3=A0 espera de poda"
 #: lib/database.tcl:48
 msgid "Garbage files"
 msgstr "Ficheiros de lixo"
-
-#: lib/database.tcl:72
-msgid "Compressing the object database"
-msgstr "A comprimir a base de dados de objetos"
-
 #: lib/database.tcl:83
 msgid "Verifying the object database with fsck-objects"
 msgstr "A verificar a base de dados de objetos com fsck-objects"
diff --git a/git-gui/po/ru.po b/git-gui/po/ru.po
index 4761cc1adb..8151f02d8a 100644
--- a/git-gui/po/ru.po
+++ b/git-gui/po/ru.po
@@ -238,11 +238,6 @@ msgstr "=D0=9F=D0=BE=D0=BA=D0=B0=D0=B7=D0=B0=D1=82=D1=
=8C =D0=B8=D1=81=D1=82=D0=BE=D1=80=D0=B8=D1=8E =D0=B2=D0=B5=D1=82=D0=BA=D0=
=B8 %s"
 #: git-gui.sh:2799 lib/database.tcl:40
 msgid "Database Statistics"
 msgstr "=D0=A1=D1=82=D0=B0=D1=82=D0=B8=D1=81=D1=82=D0=B8=D0=BA=D0=B0 =D0=
=B1=D0=B0=D0=B7=D1=8B =D0=B4=D0=B0=D0=BD=D0=BD=D1=8B=D1=85"
-
-#: git-gui.sh:2802 lib/database.tcl:33
-msgid "Compress Database"
-msgstr "=D0=A1=D0=B6=D0=B0=D1=82=D1=8C =D0=B1=D0=B0=D0=B7=D1=83 =D0=B4=D0=
=B0=D0=BD=D0=BD=D1=8B=D1=85"
-
 #: git-gui.sh:2805
 msgid "Verify Database"
 msgstr "=D0=9F=D1=80=D0=BE=D0=B2=D0=B5=D1=80=D0=B8=D1=82=D1=8C =D0=B1=D0=
=B0=D0=B7=D1=83 =D0=B4=D0=B0=D0=BD=D0=BD=D1=8B=D1=85"
@@ -2498,11 +2493,6 @@ msgstr "=D0=9C=D1=83=D1=81=D0=BE=D1=80"
 #, tcl-format
 msgid "%s (%s): Database Statistics"
 msgstr "%s (%s): =D0=A1=D1=82=D0=B0=D1=82=D0=B8=D1=81=D1=82=D0=B8=D0=BA=
=D0=B0 =D0=B1=D0=B0=D0=B7=D1=8B =D0=B4=D0=B0=D0=BD=D0=BD=D1=8B=D1=85"
-
-#: lib/database.tcl:72
-msgid "Compressing the object database"
-msgstr "=D0=A1=D0=B6=D0=B0=D1=82=D0=B8=D0=B5 =D0=B1=D0=B0=D0=B7=D1=8B =D0=
=BE=D0=B1=D1=8A=D0=B5=D0=BA=D1=82=D0=BE=D0=B2"
-
 #: lib/database.tcl:83
 msgid "Verifying the object database with fsck-objects"
 msgstr "=D0=9F=D1=80=D0=BE=D0=B2=D0=B5=D1=80=D0=BA=D0=B0 =D0=B1=D0=B0=D0=
=B7=D1=8B =D0=BE=D0=B1=D1=8A=D0=B5=D0=BA=D1=82=D0=BE=D0=B2 =D0=BF=D1=80=D0=
=B8 =D0=BF=D0=BE=D0=BC=D0=BE=D1=89=D0=B8 fsck"
diff --git a/git-gui/po/sv.po b/git-gui/po/sv.po
index 06835f133a..9509fcda0a 100644
--- a/git-gui/po/sv.po
+++ b/git-gui/po/sv.po
@@ -252,11 +252,6 @@ msgstr "Visualisera historik f=C3=B6r %s"
 #: git-gui.sh:2824 lib/database.tcl:40
 msgid "Database Statistics"
 msgstr "Databasstatistik"
-
-#: git-gui.sh:2827 lib/database.tcl:33
-msgid "Compress Database"
-msgstr "Komprimera databas"
-
 #: git-gui.sh:2830
 msgid "Verify Database"
 msgstr "Verifiera databas"
@@ -1603,11 +1598,6 @@ msgstr "%s:"
 #, tcl-format
 msgid "%s (%s): Database Statistics"
 msgstr "%s (%s): Databasstatistik"
-
-#: lib/database.tcl:72
-msgid "Compressing the object database"
-msgstr "Komprimerar objektdatabasen"
-
 #: lib/database.tcl:83
 msgid "Verifying the object database with fsck-objects"
 msgstr "Verifierar objektdatabasen med fsck-objects"
diff --git a/git-gui/po/vi.po b/git-gui/po/vi.po
index ad0ec7816c..67b9ee534f 100644
--- a/git-gui/po/vi.po
+++ b/git-gui/po/vi.po
@@ -248,11 +248,6 @@ msgstr "Duy=E1=BB=87t l=E1=BB=8Bch s=E1=BB=AD c=E1=BB=
=A7a %s tr=E1=BB=B1c quan"
 #: git-gui.sh:2713 lib/database.tcl:40 lib/database.tcl:66
 msgid "Database Statistics"
 msgstr "Th=E1=BB=91ng k=C3=AA c=C6=A1 s=E1=BB=9F d=E1=BB=AF li=E1=BB=87=
u"
-
-#: git-gui.sh:2716 lib/database.tcl:33
-msgid "Compress Database"
-msgstr "N=C3=A9n c=C6=A1 s=E1=BB=9F d=E1=BB=AF li=E1=BB=87u"
-
 #: git-gui.sh:2719
 msgid "Verify Database"
 msgstr "Th=E1=BA=A9m tra c=C6=A1 s=E1=BB=9F d=E1=BB=AF li=E1=BB=87u"
@@ -1589,11 +1584,6 @@ msgstr "C=C3=A1c =C4=91=E1=BB=91i t=C6=B0=E1=BB=A3=
ng g=C3=B3i ch=E1=BB=9D x=C3=A9n b=E1=BB=9Bt"
 #: lib/database.tcl:48
 msgid "Garbage files"
 msgstr "C=C3=A1c t=E1=BA=ADp tin r=C3=A1c"
-
-#: lib/database.tcl:72
-msgid "Compressing the object database"
-msgstr "N=C3=A9n c=C6=A1 s=E1=BB=9F d=E1=BB=AF li=E1=BB=87u =C4=91=E1=BB=
=91i t=C6=B0=E1=BB=A3ng"
-
 #: lib/database.tcl:83
 msgid "Verifying the object database with fsck-objects"
 msgstr "=C4=90ang ki=E1=BB=83m tra c=C6=A1 s=E1=BB=9F d=E1=BB=AF li=E1=BB=
=87u =C4=91=E1=BB=91i t=C6=B0=E1=BB=A3ng b=E1=BA=B1ng l=E1=BB=87nh fsck"
diff --git a/git-gui/po/zh_cn.po b/git-gui/po/zh_cn.po
index 4412d4ea44..f7d290af7d 100644
--- a/git-gui/po/zh_cn.po
+++ b/git-gui/po/zh_cn.po
@@ -214,11 +214,6 @@ msgstr "=E5=9B=BE=E7=A4=BA %s =E5=88=86=E6=94=AF=E7=
=9A=84=E5=8E=86=E5=8F=B2"
 #: git-gui.sh:1906 lib/database.tcl:27 lib/database.tcl:67
 msgid "Database Statistics"
 msgstr "=E6=95=B0=E6=8D=AE=E5=BA=93=E7=BB=9F=E8=AE=A1=E4=BF=A1=E6=81=AF"
-
-#: git-gui.sh:1909 lib/database.tcl:34
-msgid "Compress Database"
-msgstr "=E5=8E=8B=E7=BC=A9=E6=95=B0=E6=8D=AE=E5=BA=93"
-
 #: git-gui.sh:1912
 msgid "Verify Database"
 msgstr "=E9=AA=8C=E8=AF=81=E6=95=B0=E6=8D=AE=E5=BA=93"
@@ -1379,11 +1374,6 @@ msgstr "=E5=8E=8B=E7=BC=A9=E5=AF=B9=E8=B1=A1=E7=AD=
=89=E5=BE=85=E6=B8=85=E7=90=86"
 #: lib/database.tcl:49
 msgid "Garbage files"
 msgstr "=E5=9E=83=E5=9C=BE=E6=96=87=E4=BB=B6"
-
-#: lib/database.tcl:72
-msgid "Compressing the object database"
-msgstr "=E5=8E=8B=E7=BC=A9=E5=AF=B9=E8=B1=A1=E6=95=B0=E6=8D=AE=E5=BA=93"
-
 #: lib/database.tcl:83
 msgid "Verifying the object database with fsck-objects"
 msgstr "=E4=BD=BF=E7=94=A8 fsck-objects =E9=AA=8C=E8=AF=81=E5=AF=B9=E8=B1=
=A1=E6=95=B0=E6=8D=AE=E5=BA=93"
--=20
2.52.0
