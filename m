Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BE1E1B4F2C
	for <git@vger.kernel.org>; Tue, 11 Nov 2025 00:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762820784; cv=none; b=J3XSmnDHf5TGQqIZSFflAy1b2LPkyTXztwnoQOHCs0V+8Oux5xhE00M2YX/VUOzQ+3hF4F3slMsprdq+G2+AqiYKBDB6mh0Mh30V/NXIwbqAlF/h5XJqooGfTSanpEi4srUTSlL18CvNQbQikJd+Ps3RoKZJDE4OWalN+ryEwrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762820784; c=relaxed/simple;
	bh=qQHW1xKLliT3Ofm96fBJX5kYsAhbXUCR9L4XQb0E0Jw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qZAm/kj75qdXVVpScSVnshl23n+tmrDW9KkGISFTKfuVnLKTDz34YkE/ysmplVfOuL1QaHrqmXP8dChSHUptsQ6XWqYecGimAGQ8qNPn9oC+SrFgcFD+N9V91sIlmIO0Pauct1NA0T0eHAu9yT7kF5G6owZyKI9W+xTJW9/oaY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TcTOs/V6; arc=none smtp.client-ip=74.125.224.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TcTOs/V6"
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-63e393c4a8aso2794782d50.2
        for <git@vger.kernel.org>; Mon, 10 Nov 2025 16:26:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762820781; x=1763425581; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nAhlsXRQa/bQ720vuifAS3tsgp1iM90FWrooH4TCz2w=;
        b=TcTOs/V6GzLZ9XiPMgIT+z4Rt/SKixx7nB4C2DuohqlYku/PKN9yRVRLH006iLK+hu
         K8fik+s29MFC7t0lDkEN2hgbqhnqR+Ev1TduR+tuOFUYCPJuUmHyvXTmzXMjTrtq97uu
         xJEZs1msDxdpRzxqm6tLpYzKMdhegqTWwcKnNreCi9lfWIFCzu1VR95YdXCtnjhnZJzJ
         i9G27h89pA+BEMIbGeI2ydQL0+vsI8x2Zw3vBvmF2oJR6mMc/1Awn4LFM+VHk0DSc2Mz
         hOdh/WJsl/jnDUWJdvVjMDEZ/pZNX0HSLkUUjAQdWDmCVsdVHPQdgwdqjr1X7pixChgZ
         MAVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762820781; x=1763425581;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nAhlsXRQa/bQ720vuifAS3tsgp1iM90FWrooH4TCz2w=;
        b=SgLHWhI4sm2iOPh4rxVotByTl2NIZ/oq7IZtQBsjuncs7o+GtQB+17vA1tB1gG0ADv
         i1KZdiB6HF+frrjW3RX+POIj77Zx6sfqDV+WV24SCYcSq6M8HS462ZOnTPROxYv0kPZ1
         SPbgFO9xSR0VLITt7HI3aZgiDs/Q+FloNHT6jn/pHWbAq3ps0RLNr/BGOvXyjcp/aMSQ
         WQctQ84x8Qg1sZ3pvYapadzwhs3ksJxGfoJR29U/eCvTWEYzGriUo4VAdTCNU4ymb/Tf
         rCkzxNhXrg2PwJXT5rOuJRbaZCNcfJqdS0+pYe5NBTtWtDu8xW8r6k3psrFW67poRCAt
         TWyA==
X-Gm-Message-State: AOJu0YxmMu1mpXD7/uKPLSUOUKNbiHl40gMHljN0BUX6v29haLPyN+32
	6waNzuGllHHqPP1kvEYV41Og7fZlLhr+sRCWLYNEX1C5jDamC37pJDWwx7AFhuUxk20=
X-Gm-Gg: ASbGncsdpIVWF04nHXGvz1XUSS1FKku4c6DyOmX99qXosfpwq0Q3MR9qCGLIMaR6V29
	veN/P2XVj5vOAMap8eqTwnYW5rjl7yi6dcHEFbAZXoPNVDKC0ZlYAzN5lay22QpS6DfPjHUzEXy
	7iNBgBuz3ZxZQ/R3DWZKH1UcCIDcmC811V5fOULdphT0KwsQ4rMz0BWstMS8cfY2OZp0CHoSm4j
	lfFK77KlnLHYNuqoZExypTUO2Q1WBdL5HLFdNl7qEtu/f3fabWeDfbvevclYYDScPKirO8l/sQj
	gbT/ChgkUfaLqzU2IoT3ipMspQAn92UXVuuuPQqbhDxzFP4ZphNjs8Y+AdX6dwMb/ozu/Zkkf6k
	Fz0jVWXuVFhd8o06D33SResiUq5jv00vyDbVOYsjVHqkbfMd+ggdi56xRkYD/ENkHsdtd8OWNQa
	GrOH6RemlLHeIEBYY=
X-Google-Smtp-Source: AGHT+IGqEGUH/s99UttdihZmMeKgl9d8t8+iw5ZlX0zpdyy6eRkGkUcDmNU/vkYVz4vi+Q+hBSosrQ==
X-Received: by 2002:a05:690e:2404:b0:63f:a7dc:159e with SMTP id 956f58d0204a3-640d45528c8mr6131514d50.29.1762820780982;
        Mon, 10 Nov 2025 16:26:20 -0800 (PST)
Received: from localhost.localdomain ([2605:a601:90a8:8b00::a])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-640b5d9350dsm5166858d50.20.2025.11.10.16.26.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 16:26:20 -0800 (PST)
Sender: "D. Ben Knoble" <ben.knoble@gmail.com>
From: "D. Ben Knoble" <ben.knoble+github@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	"D. Ben Knoble" <ben.knoble+github@gmail.com>,
	Todd Zullinger <tmz@pobox.com>
Subject: [PATCH] meson: make GIT_HTML_PATH configurable
Date: Mon, 10 Nov 2025 19:25:04 -0500
Message-ID: <d6b86ed23e28c875b48fdc77095ace3f8ff4ee5d.1762820704.git.ben.knoble+github@gmail.com>
X-Mailer: git-send-email 2.52.0.rc0.71.g03eda12af0.dirty
In-Reply-To: <385992f6020703558f0ba75a1be6c4f9dae08b83.1762264709.git.ben.knoble+github@gmail.com>
References: <385992f6020703558f0ba75a1be6c4f9dae08b83.1762264709.git.ben.knoble+github@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Makefile-based builds can configure Git's internal HTML_PATH by defining
htmldir, which is useful for packagers that put documentation in
different locations. Gentoo, for example, uses version-suffixed
directories like ${prefix}/share/doc/git-2.51 and puts the HTML
documentation in an 'html' subdirectory of the same.

Propagate the same configuration knob to Meson-based builds so that
"git --html-path" on such systems can be configured to output the
correct directory.

Signed-off-by: D. Ben Knoble <ben.knoble+github@gmail.com>
---

Reorder options lexicographically for Patrick ;)

v1: https://lore.kernel.org/git/85992f6020703558f0ba75a1be6c4f9dae08b83.1762264709.git.ben.knoble+github@gmail.com

 Documentation/howto/meson.build     |  4 ++--
 Documentation/meson.build           | 12 ++++++------
 Documentation/technical/meson.build |  4 ++--
 contrib/contacts/meson.build        |  2 +-
 contrib/subtree/meson.build         |  2 +-
 meson.build                         |  7 ++++++-
 meson_options.txt                   |  2 ++
 7 files changed, 20 insertions(+), 13 deletions(-)

diff --git a/Documentation/howto/meson.build b/Documentation/howto/meson.build
index ece20244af..16b9056f24 100644
--- a/Documentation/howto/meson.build
+++ b/Documentation/howto/meson.build
@@ -35,7 +35,7 @@ doc_targets += custom_target(
   output: 'howto-index.html',
   depends: documentation_deps,
   install: true,
-  install_dir: get_option('datadir') / 'doc/git-doc',
+  install_dir: htmldir,
 )
 
 foreach howto : howto_sources
@@ -57,6 +57,6 @@ foreach howto : howto_sources
     output: fs.stem(howto_stripped.full_path()) + '.html',
     depends: documentation_deps,
     install: true,
-    install_dir: get_option('datadir') / 'doc/git-doc/howto',
+    install_dir: htmldir / 'howto',
   )
 endforeach
diff --git a/Documentation/meson.build b/Documentation/meson.build
index 9d24f2da54..c00c9fe7f4 100644
--- a/Documentation/meson.build
+++ b/Documentation/meson.build
@@ -412,7 +412,7 @@ foreach manpage, category : manpages
       input: manpage,
       output: fs.stem(manpage) + '.html',
       install: true,
-      install_dir: get_option('datadir') / 'doc/git-doc',
+      install_dir: htmldir,
     )
   endif
 endforeach
@@ -423,7 +423,7 @@ if get_option('docs').contains('html')
     output: 'docinfo.html',
     copy: true,
     install: true,
-    install_dir: get_option('datadir') / 'doc/git-doc',
+    install_dir: htmldir,
   )
 
   configure_file(
@@ -431,11 +431,11 @@ if get_option('docs').contains('html')
     output: 'docbook-xsl.css',
     copy: true,
     install: true,
-    install_dir: get_option('datadir') / 'doc/git-doc',
+    install_dir: htmldir,
   )
 
   install_symlink('index.html',
-    install_dir: get_option('datadir') / 'doc/git-doc',
+    install_dir: htmldir,
     pointing_to: 'git.html',
   )
 
@@ -466,7 +466,7 @@ if get_option('docs').contains('html')
     input: 'docbook.xsl',
     output: 'user-manual.html',
     install: true,
-    install_dir: get_option('datadir') / 'doc/git-doc',
+    install_dir: htmldir,
   )
 
   articles = [
@@ -492,7 +492,7 @@ if get_option('docs').contains('html')
       output: fs.stem(article) + '.html',
       depends: documentation_deps,
       install: true,
-      install_dir: get_option('datadir') / 'doc/git-doc',
+      install_dir: htmldir,
     )
   endforeach
 
diff --git a/Documentation/technical/meson.build b/Documentation/technical/meson.build
index be698ef22a..faff3964a9 100644
--- a/Documentation/technical/meson.build
+++ b/Documentation/technical/meson.build
@@ -53,7 +53,7 @@ doc_targets += custom_target(
   output: 'api-index.html',
   depends: documentation_deps,
   install: true,
-  install_dir: get_option('datadir') / 'doc/git-doc/technical',
+  install_dir: htmldir / 'technical',
 )
 
 foreach article : api_docs + articles
@@ -63,6 +63,6 @@ foreach article : api_docs + articles
     output: fs.stem(article) + '.html',
     depends: documentation_deps,
     install: true,
-    install_dir: get_option('datadir') / 'doc/git-doc/technical',
+    install_dir: htmldir / 'technical',
   )
 endforeach
diff --git a/contrib/contacts/meson.build b/contrib/contacts/meson.build
index c8fdb35ed9..4ae6b32a03 100644
--- a/contrib/contacts/meson.build
+++ b/contrib/contacts/meson.build
@@ -50,6 +50,6 @@ if get_option('docs').contains('html')
     input: 'git-contacts.adoc',
     output: 'git-contacts.html',
     install: true,
-    install_dir: get_option('datadir') / 'doc/git-doc',
+    install_dir: htmldir,
   )
 endif
diff --git a/contrib/subtree/meson.build b/contrib/subtree/meson.build
index 46cdbcc30c..161435abeb 100644
--- a/contrib/subtree/meson.build
+++ b/contrib/subtree/meson.build
@@ -68,6 +68,6 @@ if get_option('docs').contains('html')
     input: 'git-subtree.adoc',
     output: 'git-subtree.html',
     install: true,
-    install_dir: get_option('datadir') / 'doc/git-doc',
+    install_dir: htmldir,
   )
 endif
diff --git a/meson.build b/meson.build
index 2b763f7c53..1f95a06edb 100644
--- a/meson.build
+++ b/meson.build
@@ -768,13 +768,18 @@ if test_output_directory == ''
   test_output_directory = meson.project_build_root() / 'test-output'
 endif
 
+htmldir = get_option('htmldir')
+if htmldir == ''
+  htmldir = get_option('datadir') / 'doc/git-doc'
+endif
+
 # These variables are used for building libgit.a.
 libgit_c_args = [
   '-DBINDIR="' + get_option('bindir') + '"',
   '-DDEFAULT_GIT_TEMPLATE_DIR="' + get_option('datadir') / 'git-core/templates' + '"',
   '-DFALLBACK_RUNTIME_PREFIX="' + get_option('prefix') + '"',
   '-DGIT_HOST_CPU="' + host_machine.cpu_family() + '"',
-  '-DGIT_HTML_PATH="' + get_option('datadir') / 'doc/git-doc"',
+  '-DGIT_HTML_PATH="' + htmldir + '"',
   '-DGIT_INFO_PATH="' + get_option('infodir') + '"',
   '-DGIT_LOCALE_PATH="' + get_option('localedir') + '"',
   '-DGIT_MAN_PATH="' + get_option('mandir') + '"',
diff --git a/meson_options.txt b/meson_options.txt
index 143dee9237..e0be260ae1 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -1,4 +1,6 @@
 # Configuration for Git installation
+option('htmldir', type: 'string', value: '',
+  description: 'Directory to install HTML docs to. Defaults to <datadir>/doc/git-doc')
 option('perllibdir', type: 'string', value: '',
   description: 'Directory to install perl lib to. Defaults to <datadir>/perl5')
 

Diff-intervalle :
1:  385992f602 ! 1:  d6b86ed23e meson: make GIT_HTML_PATH configurable
    @@ meson.build: if test_output_directory == ''
      ## meson_options.txt ##
     @@
      # Configuration for Git installation
    - option('perllibdir', type: 'string', value: '',
    -   description: 'Directory to install perl lib to. Defaults to <datadir>/perl5')
     +option('htmldir', type: 'string', value: '',
     +  description: 'Directory to install HTML docs to. Defaults to <datadir>/doc/git-doc')
    + option('perllibdir', type: 'string', value: '',
    +   description: 'Directory to install perl lib to. Defaults to <datadir>/perl5')
      
    - # Configuration for how Git behaves at runtime.
    - option('default_pager', type: 'string', value: 'less',

base-commit: 7f278e958afbf9b7e0727631b4c26dcfa1c63d6e
-- 
2.52.0.rc0.71.g03eda12af0.dirty

