From: Philip Oakley <philipoakley@iee.org>
Subject: [PATCH v2 06/16] engine.pl: Properly accept quoted spaces
 in filenames
Date: Sun, 19 Jul 2015 21:08:06 +0100
Message-ID: <1437336497-4072-7-git-send-email-philipoakley@iee.org>
References: <1437336497-4072-1-git-send-email-philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	MsysGit List <msysgit@googlegroups.com>,
	Yue Lin Ho <b8732003@student.nsysu.edu.tw>,
	Philip Oakley <philipoakley@iee.org>
To: Git List <git@vger.kernel.org>
X-From: msysgit+bncBDSOTWHYX4PBB2MGWCWQKGQEE7QVS4A@googlegroups.com Sun Jul 19 22:07:06 2015
Return-path: <msysgit+bncBDSOTWHYX4PBB2MGWCWQKGQEE7QVS4A@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-wg0-f58.google.com ([74.125.82.58])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBDSOTWHYX4PBB2MGWCWQKGQEE7QVS4A@googlegroups.com>)
	id 1ZGura-0002IB-B4
	for gcvm-msysgit@m.gmane.org; Sun, 19 Jul 2015 22:07:06 +0200
Received: by wgjf7 with SMTP id f7sf441312wgj.0
        for <gcvm-msysgit@m.gmane.org>; Sun, 19 Jul 2015 13:07:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:from:to:cc:subject:date:message-id:in-reply-to
         :references:x-original-sender:x-original-authentication-results
         :content-type:precedence:mailing-list:list-id
         :x-spam-checked-in-group:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe;
        bh=Ba9yOMtW1kTFDda6lufa+i0fI6QGnpGukNdkE4MoYiI=;
        b=M12ThSJAGmipT4xdA7/1r3mtNeteBJykFahWDnOPKU0ekLblGtMov/4Q7e8Wj8Iw4c
         ZJnOoHlzj7PjsivOSTIMAAS4X2XMWhKucFhQ6bjamcvIU+cDGB7Wd1udBHbddailNsMl
         sZBSjMuKy6V2gBxv2DVoewXqWG4Y/0glETqqB4dVgMe1anvnG7eZRLf1UlbcNeuH62A3
         mCvZ6R8Lleub/1XV1pGUBS7NGs6ougfdMoRJtBONrCFDUFm1/CLbPzuRtjHDdrgoYC4d
         HUvmfjfndemIIVm2VP6R8UZw5anj5lz+qZ19RxgSeqyNV7Lw9/QEMus1GoTGtRQsdupj
         +YNw==
X-Received: by 10.152.234.228 with SMTP id uh4mr371166lac.25.1437336426003;
        Sun, 19 Jul 2015 13:07:06 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.152.6.101 with SMTP id z5ls657678laz.65.gmail; Sun, 19 Jul
 2015 13:07:04 -0700 (PDT)
X-Received: by 10.152.88.111 with SMTP id bf15mr9939095lab.9.1437336424695;
        Sun, 19 Jul 2015 13:07:04 -0700 (PDT)
Received: from out1.ip02ir2.opaltelecom.net (out1.ip02ir2.opaltelecom.net. [62.24.128.238])
        by gmr-mx.google.com with ESMTP id gt9si270946wib.2.2015.07.19.13.07.04
        for <msysgit@googlegroups.com>;
        Sun, 19 Jul 2015 13:07:04 -0700 (PDT)
Received-SPF: softfail (google.com: domain of transitioning philipoakley@iee.org does not designate 62.24.128.238 as permitted sender) client-ip=62.24.128.238;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: A2A2EgCSAqxVPN4GFlxcgkFSVGmGUbcKhXkEAgKBGjwRAQEBAQEBAQYBAQEBQAE/hCQBAQRWIxAISTkKFAYTiDLEaAEBAQcikFIHhCsFlFKEb4k7ln6BCYMaPTGCSwEBAQ
X-IPAS-Result: A2A2EgCSAqxVPN4GFlxcgkFSVGmGUbcKhXkEAgKBGjwRAQEBAQEBAQYBAQEBQAE/hCQBAQRWIxAISTkKFAYTiDLEaAEBAQcikFIHhCsFlFKEb4k7ln6BCYMaPTGCSwEBAQ
X-IronPort-AV: E=Sophos;i="5.15,504,1432594800"; 
   d="scan'208";a="39118931"
Received: from host-92-22-6-222.as13285.net (HELO localhost) ([92.22.6.222])
  by out1.ip02ir2.opaltelecom.net with ESMTP; 19 Jul 2015 21:07:05 +0100
X-Mailer: git-send-email 2.3.1
In-Reply-To: <1437336497-4072-1-git-send-email-philipoakley@iee.org>
X-Original-Sender: philipoakley@iee.org
X-Original-Authentication-Results: gmr-mx.google.com;       spf=softfail
 (google.com: domain of transitioning philipoakley@iee.org does not designate
 62.24.128.238 as permitted sender) smtp.mail=philipoakley@iee.org
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Spam-Checked-In-Group: msysgit@googlegroups.com
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/msysgit/subscribe>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274282>

The engine.pl script barfs on the properly quoted spaces in
filename options prevalent on Windows. Use shellwords() rather
than split() to separate such options.

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Philip Oakley <philipoakley@iee.org>
---
Junio's help at gmane.comp.version-control.msysgit/21145 (2014-11-21)
& gmane.comp.version-control.msysgit/21147 (2014-11-21)
---
 contrib/buildsystems/engine.pl | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/contrib/buildsystems/engine.pl b/contrib/buildsystems/engine.pl
index c8a5258..24b8992 100755
--- a/contrib/buildsystems/engine.pl
+++ b/contrib/buildsystems/engine.pl
@@ -12,6 +12,7 @@ use File::Basename;
 use File::Spec;
 use Cwd;
 use Generators;
+use Text::ParseWords;
 
 my (%build_structure, %compile_options, @makedry);
 my $out_dir = getcwd();
@@ -231,7 +232,7 @@ sub removeDuplicates
 sub handleCompileLine
 {
     my ($line, $lineno) = @_;
-    my @parts = split(' ', $line);
+    my @parts = shellwords($line);
     my $sourcefile;
     shift(@parts); # ignore cmd
     while (my $part = shift @parts) {
@@ -265,7 +266,7 @@ sub handleLibLine
     my (@objfiles, @lflags, $libout, $part);
     # kill cmd and rm 'prefix'
     $line =~ s/^rm -f .* && .* rcs //;
-    my @parts = split(' ', $line);
+    my @parts = shellwords($line);
     while ($part = shift @parts) {
         if ($part =~ /^-/) {
             push(@lflags, $part);
@@ -306,7 +307,7 @@ sub handleLinkLine
 {
     my ($line, $lineno) = @_;
     my (@objfiles, @lflags, @libs, $appout, $part);
-    my @parts = split(' ', $line);
+    my @parts = shellwords($line);
     shift(@parts); # ignore cmd
     while ($part = shift @parts) {
         if ($part =~ /^-IGNORE/) {
-- 
2.4.2.windows.1.5.gd32afb6

-- 
-- 
*** Please reply-to-all at all times ***
*** (do not pretend to know who is subscribed and who is not) ***
*** Please avoid top-posting. ***
The msysGit Wiki is here: https://github.com/msysgit/msysgit/wiki - Github accounts are free.

You received this message because you are subscribed to the Google
Groups "msysGit" group.
To post to this group, send email to msysgit@googlegroups.com
To unsubscribe from this group, send email to
msysgit+unsubscribe@googlegroups.com
For more options, and view previous threads, visit this group at
http://groups.google.com/group/msysgit?hl=en_US?hl=en

--- 
You received this message because you are subscribed to the Google Groups "Git for Windows" group.
To unsubscribe from this group and stop receiving emails from it, send an email to msysgit+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
