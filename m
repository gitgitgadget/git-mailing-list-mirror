From: Marius Storm-Olsen <mstormo@gmail.com>
Subject: [PATCH] MSVC: Enable OpenSSL, and translate -lcrypto
Date: Sat, 3 Oct 2009 22:00:39 +0200
Message-ID: <18cd41840910031300i32c74b15t74eb9eee23ff8469@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: kusmabite@googlemail.com, msysgit@googlegroups.com
To: git@vger.kernel.org
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com Sat Oct 03 22:00:57 2009
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-yx0-f137.google.com ([209.85.210.137])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MuAmm-0006Ju-Mx
	for gcvm-msysgit@m.gmane.org; Sat, 03 Oct 2009 22:00:56 +0200
Received: by yxe1 with SMTP id 1so2405853yxe.3
        for <gcvm-msysgit@m.gmane.org>; Sat, 03 Oct 2009 13:00:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to
         :received:received:received:received-spf:received:dkim-signature
         :domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:cc:content-type:sender:precedence:x-google-loop
         :mailing-list:list-id:list-post:list-help:list-unsubscribe
         :x-beenthere-env:x-beenthere;
        bh=1GJyZiDoTa7AekdnTtSTzxMBcCRTR+zfZV1LJjTyqsw=;
        b=oSRTe9zuyWFRRfzXrQWpHiIoMQkg3Z6OHlgTgRGSLGkb3mgKB2mJBdCs+5Nc/fjZe/
         6AGdFnaKL08CVZiWN9UdEB4BVQ0YTKunXhUwoM2umkJH8pgNhJnx4FNy0mFgkU/k9rG3
         WwCrqh6/kzzdjkr+ckm2HQJ3yS+I5sfCiTAoA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results
         :dkim-signature:domainkey-signature:mime-version:date:message-id
         :subject:from:to:cc:content-type:sender:precedence:x-google-loop
         :mailing-list:list-id:list-post:list-help:list-unsubscribe
         :x-beenthere-env:x-beenthere;
        b=sBWpGqjL/GRZoCX/r8TQQj0dTH017ZQTQYbFW8ovbDNSRlmK5Lg/XmiDaDPXJVa2bU
         97xs5jA2GQdU1TwgTMlmmAIgU7WUmWI5KM3DxdtUBaDiuUbCDpZQbzgXubnrBKYLwru6
         gqohBZXNWeRe2UmKvrFhYlXR/jiQYK94RTmVY=
Received: by 10.90.142.5 with SMTP id p5mr242485agd.24.1254600049283;
        Sat, 03 Oct 2009 13:00:49 -0700 (PDT)
Received: by 10.176.58.28 with SMTP id g28gr7244yqa.0;
	Sat, 03 Oct 2009 13:00:44 -0700 (PDT)
X-Sender: mstormo@gmail.com
X-Apparently-To: msysgit@googlegroups.com
Received: by 10.210.32.6 with SMTP id f6mr415516ebf.11.1254600041739; Sat, 03 Oct 2009 13:00:41 -0700 (PDT)
Received: by 10.210.32.6 with SMTP id f6mr415515ebf.11.1254600041672; Sat, 03 Oct 2009 13:00:41 -0700 (PDT)
Received: from mail-ew0-f211.google.com (mail-ew0-f211.google.com [209.85.219.211]) by gmr-mx.google.com with ESMTP id 15si572159ewy.4.2009.10.03.13.00.40; Sat, 03 Oct 2009 13:00:40 -0700 (PDT)
Received-SPF: pass (google.com: domain of mstormo@gmail.com designates 209.85.219.211 as permitted sender) client-ip=209.85.219.211;
Authentication-Results: gmr-mx.google.com; spf=pass (google.com: domain of mstormo@gmail.com designates 209.85.219.211 as permitted sender) smtp.mail=mstormo@gmail.com; dkim=pass (test mode) header.i=@gmail.com
Received: by ewy7 with SMTP id 7so1824282ewy.41 for <msysgit@googlegroups.com>; Sat, 03 Oct 2009 13:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=gamma; h=domainkey-signature:mime-version:received:date:message-id:subject :from:to:cc:content-type; bh=dPm1DRmkYKAo/EqICZ2i5abAPqcSaLh07nP10Y6bbjM=; b=Z0jfwYgzZ2nuGjwgGkMkeEBrdR2IC1cMu62HNea9KV9ElEoKl4c1NWjyAWfzf8aYcn B0VSDjvqTGUuhbxGQ3QInJrGr+/7DLT31RXQxeDRfKGJLnc59sJEcEMcdOjdkuGllGTa 7Z4rLWiKtTTFTdxeBtl37j6I+K1ngFthIP2iM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=gmail.com; s=gamma; h=mime-version:date:message-id:subject:from:to:cc:content-type; b=rRLA5qQHg7zrMEHhAJ81RkFXhmgEYMWN90+jXqYnCm4M2ofB8QtGbbDZtmp+eLHYvG Kyil+Sd4sYIpAMVN31HtDtowm7NUQ72XBiwcdsHQox20ufN7Nbm5/T3TL30Ai44GDqat fPHPAXc8/3gq9qfEuQ7WYDwIXe7gSeIZOynyU=
Received: by 10.216.15.66 with SMTP id e44mr632709wee.35.1254600039925; Sat,  03 Oct 2009 13:00:39 -0700 (PDT)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129496>


We don't use crypto, but rather require libeay32 and
ssleay32. handle it in both the Makefile msvc linker
script, and the buildsystem generator.

Signed-off-by: Marius Storm-Olsen <mstormo@gmail.com>
---
 Requires Erik Faye-Lund's MinGW patches for imap-send
 ontop of git.git master.

 This patch was actually sent using the MSVC
 git-imap-send.exe to my GMail account.
   D:\msvc\git>cat
0001-MSVC-Enable-OpenSSL-and-translate-lcrypto.patch |
git-imap-send.exe
   Resolving imap.gmail.com... ok
   Connecting to 74.125.79.109:993... ok
   Logging in...
   sending 1 message
   100% (1/1) done
 :)

 Makefile                        |    1 -
 compat/vcbuild/scripts/clink.pl |    3 +++
 contrib/buildsystems/engine.pl  |    3 +++
 3 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/Makefile b/Makefile
index 8818f0f..c4b91d8 100644
--- a/Makefile
+++ b/Makefile
@@ -881,7 +881,6 @@ ifdef MSVC
 	GIT_VERSION := $(GIT_VERSION).MSVC
 	pathsep = ;
 	NO_PREAD = YesPlease
-	NO_OPENSSL = YesPlease
 	NO_LIBGEN_H = YesPlease
 	NO_SYMLINK_HEAD = YesPlease
 	NO_IPV6 = YesPlease
diff --git a/compat/vcbuild/scripts/clink.pl b/compat/vcbuild/scripts/clink.pl
index 0ffd59f..fce1e24 100644
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
1.6.3.msysgit.0.18.gef407
