From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: [PATCH v3 8/8] MSVC: Enable OpenSSL, and translate -lcrypto
Date: Tue, 13 Oct 2009 19:25:25 +0000
Message-ID: <1255461925-2244-9-git-send-email-kusmabite@gmail.com>
References: <1255461925-2244-1-git-send-email-kusmabite@gmail.com> <1255461925-2244-2-git-send-email-kusmabite@gmail.com> <1255461925-2244-3-git-send-email-kusmabite@gmail.com> <1255461925-2244-4-git-send-email-kusmabite@gmail.com> <1255461925-2244-5-git-send-email-kusmabite@gmail.com> <1255461925-2244-6-git-send-email-kusmabite@gmail.com> <1255461925-2244-7-git-send-email-kusmabite@gmail.com> <1255461925-2244-8-git-send-email-kusmabite@gmail.com>
Cc: msysgit@googlegroups.com, Marius Storm-Olsen <mstormo@gmail.com>, Erik Faye-Lund <kusmabite@gmail.com>
To: git@vger.kernel.org
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com Tue Oct 13 21:27:07 2009
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-yw0-f161.google.com ([209.85.211.161])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mxn1U-00075C-3a
	for gcvm-msysgit@m.gmane.org; Tue, 13 Oct 2009 21:27:04 +0200
Received: by ywh33 with SMTP id 33so5083891ywh.24
        for <gcvm-msysgit@m.gmane.org>; Tue, 13 Oct 2009 12:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to
         :received:received:received:received-spf:received:dkim-signature
         :domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:sender:precedence
         :x-google-loop:mailing-list:list-id:list-post:list-help
         :list-unsubscribe:x-beenthere-env:x-beenthere;
        bh=J0PcADJ9+nHpeHzu++jyIIZgWzHdNcFq8zKIlLQ0YF8=;
        b=qwsHiTzTcBEawZCDIpYwM3ePs2cpUsy4T7MMMLFLHw4BmrJ96EuTGTJJiBSMCawSrA
         8/HUwWvJkAEEzaVtiq4EcBhJz0gIsjR0MNZaJtX82h8R8w/JaC9twfbn1VwI8mqWbqlr
         d9PV4yetNweOA8+qnpRvJWEzp+QV4/mQIlKaM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results
         :dkim-signature:domainkey-signature:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:sender:precedence
         :x-google-loop:mailing-list:list-id:list-post:list-help
         :list-unsubscribe:x-beenthere-env:x-beenthere;
        b=ao9nZXDap/gH3ehpgbf58MUmn+nE/+S6VWUK3RXsWS1rddg/jtmW3Hsh6idrrxfpvv
         0z3pqBhmWOeJl6LCTTuOkhG74Xf1KcKdAyXxO5tDah1YUo6G0grQV5uPUbmT3pOLRLeT
         3wgB7hjY88PMTeb4PpI5f76BaHqH5FCNEbryk=
Received: by 10.90.45.10 with SMTP id s10mr414105ags.37.1255462015813;
        Tue, 13 Oct 2009 12:26:55 -0700 (PDT)
Received: by 10.177.117.7 with SMTP id u7gr7402yqm.0;
	Tue, 13 Oct 2009 12:26:44 -0700 (PDT)
X-Sender: kusmabite@googlemail.com
X-Apparently-To: msysgit@googlegroups.com
Received: by 10.211.132.10 with SMTP id j10mr999459ebn.3.1255462002765; Tue, 13 Oct 2009 12:26:42 -0700 (PDT)
Received: by 10.211.132.10 with SMTP id j10mr999458ebn.3.1255462002729; Tue, 13 Oct 2009 12:26:42 -0700 (PDT)
Received: from ey-out-2122.google.com (ey-out-2122.google.com [74.125.78.26]) by gmr-mx.google.com with ESMTP id 15si322689ewy.0.2009.10.13.12.26.41; Tue, 13 Oct 2009 12:26:41 -0700 (PDT)
Received-SPF: pass (google.com: domain of kusmabite@googlemail.com designates 74.125.78.26 as permitted sender) client-ip=74.125.78.26;
Authentication-Results: gmr-mx.google.com; spf=pass (google.com: domain of kusmabite@googlemail.com designates 74.125.78.26 as permitted sender) smtp.mail=kusmabite@googlemail.com; dkim=pass (test mode) header.i=@googlemail.com
Received: by ey-out-2122.google.com with SMTP id 22so2187044eye.31 for <msysgit@googlegroups.com>; Tue, 13 Oct 2009 12:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=googlemail.com; s=gamma; h=domainkey-signature:received:received:from:to:cc:subject:date :message-id:x-mailer:in-reply-to:references; bh=djAO1VSljVzg7+Aw8imNmMH4hpFL9EFvaTSohlZoLIc=; b=u5JqefCkL4slf9ly7QU0GeVk6FoXUlDg05yKYzTCfAFief1UWT1n9bQOaFn9lPvOQT C9Pb4FTI6pHiDi9PPfNhomIh8QCQZzNfulWdSyXOXLXtVwNgcAV2AVVH+70WE4/Vtcho wf4XiucG/zJ9vIO5hfUfWHCfqxDzcX49yNNM8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=googlemail.com; s=gamma; h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references; b=aXZoQ+PTwJaqHjzdRdW1dcYhYwv+Kb14jdxQM2Th6imBKSKaTmvUWvtRa8ec669Kjq amtHzwCUhYASpDM5Ntc9PfqgMocaBNPbKV1eOOt3Q1CuqpvkXOMBLcIedW3r/gKuwYoC qI6DoNVnh2DGBz9S68RkNW43Iu1FBt7oU+fdw=
Received: by 10.211.131.23 with SMTP id i23mr5862950ebn.90.1255462001630; Tue, 13 Oct 2009 12:26:41 -0700 (PDT)
Received: from localhost (cm-84.215.142.12.getinternet.no [84.215.142.12]) by mx.google.com with ESMTPS id 10sm262633eyz.36.2009.10.13.12.26.40 (version=TLSv1/SSLv3 cipher=RC4-MD5); Tue, 13 Oct 2009 12:26:41 -0700 (PDT)
X-Mailer: git-send-email 1.6.4
In-Reply-To: <1255461925-2244-8-git-send-email-kusmabite@gmail.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130191>


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
index e416fdb..b39bed4 100644
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
1.6.4
