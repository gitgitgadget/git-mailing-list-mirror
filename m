From: Pat Thoyts <patthoyts@users.sourceforge.net>
Subject: [PATCH 4/8] git-svn: On MSYS, escape and quote SVN_SSH also
 if set by the user
Date: Fri, 14 Oct 2011 23:53:31 +0100
Message-ID: <1318632815-29945-5-git-send-email-patthoyts@users.sourceforge.net>
References: <1318632815-29945-1-git-send-email-patthoyts@users.sourceforge.net>
Mime-Version: 1.0
Cc: Junio C Hamano <gitster@pobox.com>,
	msysGit <msysgit@googlegroups.com>,
	Sebastian Schuberth <sschuberth@gmail.com>
To: Git <git@vger.kernel.org>
X-From: msysgit+bncCM7pyrzTCBDa--L0BBoEuDg-SA@googlegroups.com Sat Oct 15 00:55:55 2011
Return-path: <msysgit+bncCM7pyrzTCBDa--L0BBoEuDg-SA@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-ww0-f58.google.com ([74.125.82.58])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncCM7pyrzTCBDa--L0BBoEuDg-SA@googlegroups.com>)
	id 1REqfQ-0001ER-DQ
	for gcvm-msysgit@m.gmane.org; Sat, 15 Oct 2011 00:55:52 +0200
Received: by wwf25 with SMTP id 25sf318149wwf.3
        for <gcvm-msysgit@m.gmane.org>; Fri, 14 Oct 2011 15:55:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=mime-version:x-beenthere:received-spf:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:x-cloudmark-analysis
         :x-original-sender:x-original-authentication-results:precedence
         :mailing-list:list-id:x-google-group-id:list-post:list-help
         :list-archive:sender:list-subscribe:list-unsubscribe;
        bh=9qE8WccwGuEFjuJiDQaiVuKYRG71a1FyjBrRr/a2l30=;
        b=QPPy0pdrP818OHOHd6LBJ6QVZB8bnTk9e7pBfLjobLF6RpYWkK9cUDrYqscP+Xy2++
         2zb+kqPpsV0dk4nUQlKsLs1D8+xYE6AtwNDObTu1JFKPUNDN4CVVxRMywxBZ3+PAeUZm
         0n47q2Y40YYPZBkDVyntj8c2aqxFppS9OAK14=
Received: by 10.216.138.27 with SMTP id z27mr290257wei.13.1318632922728;
        Fri, 14 Oct 2011 15:55:22 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.227.38.21 with SMTP id z21ls8934981wbd.2.gmail; Fri, 14 Oct
 2011 15:55:21 -0700 (PDT)
Received: by 10.216.229.207 with SMTP id h57mr268924weq.3.1318632921961;
        Fri, 14 Oct 2011 15:55:21 -0700 (PDT)
Received: by 10.216.223.82 with SMTP id u60mswep;
        Fri, 14 Oct 2011 15:54:05 -0700 (PDT)
Received: by 10.227.43.9 with SMTP id u9mr300615wbe.4.1318632845340;
        Fri, 14 Oct 2011 15:54:05 -0700 (PDT)
Received: by 10.227.43.9 with SMTP id u9mr300614wbe.4.1318632845317;
        Fri, 14 Oct 2011 15:54:05 -0700 (PDT)
Received: from mtaout01-winn.ispmail.ntl.com (mtaout01-winn.ispmail.ntl.com. [81.103.221.47])
        by gmr-mx.google.com with ESMTP id v20si3219577wbn.1.2011.10.14.15.54.05;
        Fri, 14 Oct 2011 15:54:05 -0700 (PDT)
Received-SPF: pass (google.com: domain of pat@patthoyts.tk designates 81.103.221.47 as permitted sender) client-ip=81.103.221.47;
Received: from know-smtpout-4.server.virginmedia.net ([62.254.123.3])
          by mtaout01-winn.ispmail.ntl.com
          (InterMail vM.7.08.04.00 201-2186-134-20080326) with ESMTP
          id <20111014225404.NDNI13501.mtaout01-winn.ispmail.ntl.com@know-smtpout-4.server.virginmedia.net>;
          Fri, 14 Oct 2011 23:54:04 +0100
Received: from [94.171.235.235] (helo=fox.patthoyts.tk)
	by know-smtpout-4.server.virginmedia.net with esmtpa (Exim 4.63)
	(envelope-from <pat@patthoyts.tk>)
	id 1REqdg-0000OL-PE; Fri, 14 Oct 2011 23:54:04 +0100
Received: by fox.patthoyts.tk (Postfix, from userid 1000)
	id 5313F20A65; Fri, 14 Oct 2011 23:54:04 +0100 (BST)
X-Mailer: git-send-email 1.7.5
In-Reply-To: <1318632815-29945-1-git-send-email-patthoyts@users.sourceforge.net>
X-Cloudmark-Analysis: v=1.1 cv=R50lirqlHffDPPkwUlkuVa99MrvKdVWo//yz83qex8g= c=1 sm=0 a=b1lZO8IsMBkA:10 a=pGLkceISAAAA:8 a=19I1k8K98J2gF8G2pksA:9 a=MSl-tDqOz04A:10 a=HpAAvcLHHh0Zw7uRqdWCyQ==:117
X-Original-Sender: patthoyts@users.sourceforge.net
X-Original-Authentication-Results: gmr-mx.google.com; spf=pass (google.com:
 domain of pat@patthoyts.tk designates 81.103.221.47 as permitted sender) smtp.mail=pat@patthoyts.tk
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post?hl=en_US>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/?hl=en_US>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit?hl=en_US>
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en_US>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en_US>, <mailto:msysgit+unsubscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183624>

From: Sebastian Schuberth <sschuberth@gmail.com>

While GIT_SSH does not require any escaping / quoting (e.g. for paths
containing spaces), SVN_SSH requires it due to its use in a Perl script.

Previously, SVN_SSH has only been escaped and quoted automatically if it
was unset and thus derived from GIT_SSH. For user convenience, do the
escaping and quoting also for a SVN_SSH set by the user. This way, the
user is able to use the same unescaped and unquoted syntax for GIT_SSH
and SVN_SSH.

Signed-off-by: Sebastian Schuberth <sschuberth@gmail.com>
---
 git-svn.perl |   15 +++++++--------
 1 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index a0410f0..3b33379 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -22,14 +22,13 @@ $Git::SVN::default_ref_id = $ENV{GIT_SVN_ID} || 'git-svn';
 $Git::SVN::Ra::_log_window_size = 100;
 $Git::SVN::_minimize_url = 'unset';
 
-if (! exists $ENV{SVN_SSH}) {
-	if (exists $ENV{GIT_SSH}) {
-		$ENV{SVN_SSH} = $ENV{GIT_SSH};
-		if ($^O eq 'msys') {
-			$ENV{SVN_SSH} =~ s/\\/\\\\/g;
-			$ENV{SVN_SSH} =~ s/(.*)/"$1"/;
-		}
-	}
+if (! exists $ENV{SVN_SSH} && exists $ENV{GIT_SSH}) {
+	$ENV{SVN_SSH} = $ENV{GIT_SSH};
+}
+
+if (exists $ENV{SVN_SSH} && $^O eq 'msys') {
+	$ENV{SVN_SSH} =~ s/\\/\\\\/g;
+	$ENV{SVN_SSH} =~ s/(.*)/"$1"/;
 }
 
 $Git::SVN::Log::TZ = $ENV{TZ};
-- 
1.7.7.1.gbba15
