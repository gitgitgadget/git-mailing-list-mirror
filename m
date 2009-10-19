From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: [PATCH v4 8/8] MSVC: Enable OpenSSL, and translate -lcrypto
Date: Mon, 19 Oct 2009 17:42:09 +0200
Message-ID: <1255966929-1280-9-git-send-email-kusmabite@gmail.com>
References: <1255966929-1280-1-git-send-email-kusmabite@gmail.com> <1255966929-1280-2-git-send-email-kusmabite@gmail.com> <1255966929-1280-3-git-send-email-kusmabite@gmail.com> <1255966929-1280-4-git-send-email-kusmabite@gmail.com> <1255966929-1280-5-git-send-email-kusmabite@gmail.com> <1255966929-1280-6-git-send-email-kusmabite@gmail.com> <1255966929-1280-7-git-send-email-kusmabite@gmail.com> <1255966929-1280-8-git-send-email-kusmabite@gmail.com>
Cc: msysgit@googlegroups.com, Marius Storm-Olsen <mstormo@gmail.com>, Erik Faye-Lund <kusmabite@gmail.com>
To: git@vger.kernel.org
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com Mon Oct 19 17:43:59 2009
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-qy0-f162.google.com ([209.85.221.162])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MzuOt-0006N3-CF
	for gcvm-msysgit@m.gmane.org; Mon, 19 Oct 2009 17:43:59 +0200
Received: by mail-qy0-f162.google.com with SMTP id 34so3506781qyk.22
        for <gcvm-msysgit@m.gmane.org>; Mon, 19 Oct 2009 08:43:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to
         :received:received:received:received-spf:received:dkim-signature
         :domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:sender:precedence
         :x-google-loop:mailing-list:list-id:list-post:list-help
         :list-unsubscribe:x-beenthere-env:x-beenthere;
        bh=8LXmXZaotUDZjw4uZKQ5s4Q9GB9ty2z9rjlhpbVULjU=;
        b=ddx8R70+941S3JQ+5DOD9f+5NjCbUs+cjsupBWzd2RAk2wHEt8tgp0ReIR2OXn3q/a
         +1M3b7qwbAKkbuua54rwSEhVkI+He3reAuQ/nNfmLEMZ6u29Ius5P58x3uYnQ8fBe/oQ
         X9dJkcmkIek7WtBmerptQEhQuj6ysrP65nAJ0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results
         :dkim-signature:domainkey-signature:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:sender:precedence
         :x-google-loop:mailing-list:list-id:list-post:list-help
         :list-unsubscribe:x-beenthere-env:x-beenthere;
        b=bO6muqGorTfTTKBfh9G1hfBvOHpd27FGDAst1XQHLFxrtonE6jb4OLwXp5Gjizlc5B
         5y+7OQKYAZdxi4jMOnf2zBJaXDJbjKUoQ4kcAJQ8fu8kPRXQ6dKKnzwfpJ9EpSRZk4dz
         ceeY1Zt42DrfuLjKuOiXoEpXlwC3+uI43Elis=
Received: by 10.229.114.218 with SMTP id f26mr77934qcq.42.1255967032409;
        Mon, 19 Oct 2009 08:43:52 -0700 (PDT)
Received: by 10.176.233.14 with SMTP id f14gr7454yqh.0;
	Mon, 19 Oct 2009 08:43:41 -0700 (PDT)
X-Sender: kusmabite@googlemail.com
X-Apparently-To: msysgit@googlegroups.com
Received: by 10.211.131.9 with SMTP id i9mr366175ebn.12.1255967020340; Mon, 19 Oct 2009 08:43:40 -0700 (PDT)
Received: by 10.211.131.9 with SMTP id i9mr366174ebn.12.1255967020313; Mon, 19 Oct 2009 08:43:40 -0700 (PDT)
Received: from mail-ew0-f214.google.com (mail-ew0-f214.google.com [209.85.219.214]) by gmr-mx.google.com with ESMTP id 16si923574ewy.7.2009.10.19.08.43.39; Mon, 19 Oct 2009 08:43:39 -0700 (PDT)
Received-SPF: pass (google.com: domain of kusmabite@googlemail.com designates 209.85.219.214 as permitted sender) client-ip=209.85.219.214;
Authentication-Results: gmr-mx.google.com; spf=pass (google.com: domain of kusmabite@googlemail.com designates 209.85.219.214 as permitted sender) smtp.mail=kusmabite@googlemail.com; dkim=pass (test mode) header.i=@googlemail.com
Received: by mail-ew0-f214.google.com with SMTP id 10so4129845ewy.9 for <msysgit@googlegroups.com>; Mon, 19 Oct 2009 08:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=googlemail.com; s=gamma; h=domainkey-signature:received:received:from:to:cc:subject:date :message-id:x-mailer:in-reply-to:references; bh=JAk0O9alSSrqbU8heRWTN+lN53wjFnaqQ7ruafuIFfc=; b=UfmLy07nuJRlgsB8238crz3A6cOi0QIgL3R0AKvCJkRvQX9V6LGnSnNwCNEA3BkSbl twGT0rqkXhU4flGJCZ2SF82gBdGCQvYasTNUUjAT+W54rtqJOGjL2TuUP8f8MEApfXOl RFXn7sQ/RYFLVQj6bHgwYOskf29Keao82WuLY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=googlemail.com; s=gamma; h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references; b=L/sfFqBKocRoMvv5bmWo+D9qQTibi58yYen2bPUmFY5osvZ1DVVQx4YcsuR3GuxjCw wPPMqrA3nyuFkZrz13MKw3gccywGXhihvWC4uCMNMcayU4NNP859KgluqWjgTTEYFk5j ATDAdS7IAN09JmE1yk0zTL7YAmAvgCMzkGNfs=
Received: by 10.211.142.11 with SMTP id u11mr5808161ebn.8.1255967019161; Mon, 19 Oct 2009 08:43:39 -0700 (PDT)
Received: from localhost ([77.40.159.131]) by mx.google.com with ESMTPS id 5sm1526780eyh.41.2009.10.19.08.43.38 (version=TLSv1/SSLv3 cipher=RC4-MD5); Mon, 19 Oct 2009 08:43:38 -0700 (PDT)
X-Mailer: git-send-email 1.6.4.msysgit.0
In-Reply-To: <1255966929-1280-8-git-send-email-kusmabite@gmail.com>
Sender: msysgit@googlegroups.com
Precedence: bulk
X-Google-Loop: groups
Mailing-List: list msysgit@googlegroups.com;
	contact msysgit+owner@googlegroups.com
List-Id: <msysgit.googlegroups.com>
List-Post: <mailto:msysgit@googlegroups.com>
List-Help: <mailto:msysgit+help@googlegroups.com>
List-Unsubscribe: <http://googlegroups.com/group/msysgit/subscribe>,
	<mailto:msysgit+unsubscribe@googlegroups.com>
X-BeenThere-Env: msysgit@googlegroups.com
X-BeenThere: msysgit@googlegroups.com
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130708>


From: Marius Storm-Olsen <mstormo@gmail.com>

We don't use crypto, but rather require libeay32 and
ssleay32. handle it in both the Makefile msvc linker
script, and the buildsystem generator.

Signed-off-by: Marius Storm-Olsen <mstormo@gmail.com>
Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
---
 Makefile                        |    1 -
 compat/vcbuild/scripts/clink.pl |    3 +++
 contrib/buildsystems/engine.pl  |    3 +++
 3 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/Makefile b/Makefile
index dbeaf2f..9db6c08 100644
--- a/Makefile
+++ b/Makefile
@@ -900,7 +900,6 @@ ifdef MSVC
 	GIT_VERSION := $(GIT_VERSION).MSVC
 	pathsep = ;
 	NO_PREAD = YesPlease
-	NO_OPENSSL = YesPlease
 	NO_LIBGEN_H = YesPlease
 	NO_SYMLINK_HEAD = YesPlease
 	NO_IPV6 = YesPlease
diff --git a/compat/vcbuild/scripts/clink.pl b/compat/vcbuild/scripts/clink.pl
index f9528c0..8a2112f 100644
--- a/compat/vcbuild/scripts/clink.pl
+++ b/compat/vcbuild/scripts/clink.pl
@@ -29,6 +29,9 @@ while (@ARGV) {
 		push(@args, "zlib.lib");
 	} elsif ("$arg" eq "-liconv") {
 		push(@args, "iconv.lib");
+	} elsif ("$arg" eq "-lcrypto") {
+		push(@args, "libeay32.lib");
+		push(@args, "ssleay32.lib");
 	} elsif ("$arg" =~ /^-L/ && "$arg" ne "-LTCG") {
 		$arg =~ s/^-L/-LIBPATH:/;
 		push(@args, $arg);
diff --git a/contrib/buildsystems/engine.pl b/contrib/buildsystems/engine.pl
index 20bd061..d506717 100644
--- a/contrib/buildsystems/engine.pl
+++ b/contrib/buildsystems/engine.pl
@@ -315,6 +315,9 @@ sub handleLinkLine
             $appout = shift @parts;
         } elsif ("$part" eq "-lz") {
             push(@libs, "zlib.lib");
+	} elsif ("$part" eq "-lcrypto") {
+            push(@libs, "libeay32.lib");
+            push(@libs, "ssleay32.lib");
         } elsif ($part =~ /^-/) {
             push(@lflags, $part);
         } elsif ($part =~ /\.(a|lib)$/) {
-- 
1.6.5.15.g5f078
