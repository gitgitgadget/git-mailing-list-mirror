From: Pat Thoyts <patthoyts@users.sourceforge.net>
Subject: [PATCH 4/4] t5526: avoid dependency on submodule order
Date: Thu,  3 Feb 2011 15:31:45 +0000
Message-ID: <1296747105-1663-5-git-send-email-patthoyts@users.sourceforge.net>
References: <1296747105-1663-1-git-send-email-patthoyts@users.sourceforge.net>
Mime-Version: 1.0
Cc: msysGit <msysgit@googlegroups.com>,
	Junio C Hamano <gitster@pobox.com>,
	Pat Thoyts <patthoyts@users.sourceforge.net>
To: Git Mailing List <git@vger.kernel.org>
X-From: msysgit+bncCM7pyrzTCBDQmKvqBBoEmwGudA@googlegroups.com Thu Feb 03 16:40:30 2011
Return-path: <msysgit+bncCM7pyrzTCBDQmKvqBBoEmwGudA@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-wy0-f186.google.com ([74.125.82.186])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncCM7pyrzTCBDQmKvqBBoEmwGudA@googlegroups.com>)
	id 1Pl1II-0002Ip-RJ
	for gcvm-msysgit@m.gmane.org; Thu, 03 Feb 2011 16:40:26 +0100
Received: by wyb36 with SMTP id 36sf1299928wyb.3
        for <gcvm-msysgit@m.gmane.org>; Thu, 03 Feb 2011 07:40:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:mime-version:x-beenthere:received-spf:from:to
         :cc:subject:date:message-id:x-mailer:in-reply-to:references
         :x-original-sender:x-original-authentication-results:precedence
         :mailing-list:list-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe;
        bh=/noABTujEHGanaHTdL1lCpy8UA+wz16RsLKQxOYZvEE=;
        b=fabPJBp8ac2xPqZeZZXvpSJdUiAgbNGFtLqqLt1LBTGi802dAjUiorDGGt69POX8G7
         uDGXwttqx87nZwIvjC8pEzVK8Nf0BJzaZAlMG6un3XX/u28UFsV+zjZbusQj0RSbW7Vf
         IGCtMiORMTk+9jnizGNLAx8e1khjdqKXSfno8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=mime-version:x-beenthere:received-spf:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe;
        b=kWEAI90kU2gtI/U+rjx6w3n7BTJ08M5wk8NVviZakUkuPky2eOwrGd0zkJQzAfmQRz
         hlwumP09PN2GSYsWYO7ZbVawWw2kRHK9HW4KrKCLe2tnMvajr/7fVRPfgLir4zGAjaN1
         3Wal6YYrr+p2JF6NfMqtZbiCGx2+2UkIXXFJY=
Received: by 10.216.186.138 with SMTP id w10mr2085854wem.15.1296747600377;
        Thu, 03 Feb 2011 07:40:00 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.216.162.73 with SMTP id x51ls807436wek.3.p; Thu, 03 Feb 2011
 07:39:59 -0800 (PST)
Received: by 10.216.70.145 with SMTP id p17mr686776wed.0.1296747599353;
        Thu, 03 Feb 2011 07:39:59 -0800 (PST)
Received: by 10.217.6.10 with SMTP id x10mr238085wes.2.1296747140266;
        Thu, 03 Feb 2011 07:32:20 -0800 (PST)
Received: by 10.217.6.10 with SMTP id x10mr238084wes.2.1296747140236;
        Thu, 03 Feb 2011 07:32:20 -0800 (PST)
Received: from smtp-out3.blueyonder.co.uk (smtp-out3.blueyonder.co.uk [195.188.213.6])
        by gmr-mx.google.com with ESMTP id f60si115190wes.2.2011.02.03.07.32.20;
        Thu, 03 Feb 2011 07:32:20 -0800 (PST)
Received-SPF: pass (google.com: domain of pat@patthoyts.tk designates 195.188.213.6 as permitted sender) client-ip=195.188.213.6;
Received: from [172.23.170.144] (helo=anti-virus03-07)
	by smtp-out3.blueyonder.co.uk with smtp (Exim 4.52)
	id 1Pl1AR-0006DJ-Ib; Thu, 03 Feb 2011 15:32:19 +0000
Received: from [77.100.97.230] (helo=fox.patthoyts.tk)
	by asmtp-out2.blueyonder.co.uk with esmtpa (Exim 4.72)
	(envelope-from <pat@patthoyts.tk>)
	id 1Pl1AC-0001Px-93; Thu, 03 Feb 2011 15:32:04 +0000
Received: by fox.patthoyts.tk (Postfix, from userid 1000)
	id E8AC324E9C; Thu,  3 Feb 2011 15:32:03 +0000 (GMT)
X-Mailer: git-send-email 1.7.4
In-Reply-To: <1296747105-1663-1-git-send-email-patthoyts@users.sourceforge.net>
X-Original-Sender: patthoyts@users.sourceforge.net
X-Original-Authentication-Results: gmr-mx.google.com; spf=pass (google.com:
 domain of pat@patthoyts.tk designates 195.188.213.6 as permitted sender) smtp.mail=pat@patthoyts.tk
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
List-Post: <http://groups.google.com/group/msysgit/post?hl=en_US>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/?hl=en_US>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit?hl=en_US>
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en_US>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en_US>, <mailto:msysgit+unsubscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165979>

When running tests on msysGit the actual results appear in the reverse
order. Added a test_cmp_unordered to test that each expected line is
present in the output without depending upon the order of lines.

Signed-off-by: Pat Thoyts <patthoyts@users.sourceforge.net>
---
 t/t5526-fetch-submodules.sh |   32 ++++++++++++++++++--------------
 1 files changed, 18 insertions(+), 14 deletions(-)

diff --git a/t/t5526-fetch-submodules.sh b/t/t5526-fetch-submodules.sh
index 884a5e5..d218845 100755
--- a/t/t5526-fetch-submodules.sh
+++ b/t/t5526-fetch-submodules.sh
@@ -32,6 +32,10 @@ add_upstream_commit() {
 	)
 }
 
+test_cmp_unordered() {
+	grep --line-regexp -f "$@" >&3
+}
+
 test_expect_success setup '
 	mkdir deepsubmodule &&
 	(
@@ -67,8 +71,8 @@ test_expect_success "fetch --recurse-submodules recurses into submodules" '
 		cd downstream &&
 		git fetch --recurse-submodules >../actual.out 2>../actual.err
 	) &&
-	test_cmp expect.out actual.out &&
-	test_cmp expect.err actual.err
+	test_cmp_unordered expect.out actual.out &&
+	test_cmp_unordered expect.err actual.err
 '
 
 test_expect_success "fetch alone only fetches superproject" '
@@ -96,8 +100,8 @@ test_expect_success "using fetchRecurseSubmodules=true in .gitmodules recurses i
 		git config -f .gitmodules submodule.submodule.fetchRecurseSubmodules true &&
 		git fetch >../actual.out 2>../actual.err
 	) &&
-	test_cmp expect.out actual.out &&
-	test_cmp expect.err actual.err
+	test_cmp_unordered expect.out actual.out &&
+	test_cmp_unordered expect.err actual.err
 '
 
 test_expect_success "--no-recurse-submodules overrides .gitmodules config" '
@@ -127,8 +131,8 @@ test_expect_success "--recurse-submodules overrides fetchRecurseSubmodules setti
 		git config -f --unset .gitmodules submodule.submodule.fetchRecurseSubmodules true &&
 		git config --unset submodule.submodule.fetchRecurseSubmodules
 	) &&
-	test_cmp expect.out actual.out &&
-	test_cmp expect.err actual.err
+	test_cmp_unordered expect.out actual.out &&
+	test_cmp_unordered expect.err actual.err
 '
 
 test_expect_success "--quiet propagates to submodules" '
@@ -146,14 +150,14 @@ test_expect_success "--dry-run propagates to submodules" '
 		cd downstream &&
 		git fetch --recurse-submodules --dry-run >../actual.out 2>../actual.err
 	) &&
-	test_cmp expect.out actual.out &&
-	test_cmp expect.err actual.err &&
+	test_cmp_unordered expect.out actual.out &&
+	test_cmp_unordered expect.err actual.err &&
 	(
 		cd downstream &&
 		git fetch --recurse-submodules >../actual.out 2>../actual.err
 	) &&
-	test_cmp expect.out actual.out &&
-	test_cmp expect.err actual.err
+	test_cmp_unordered expect.out actual.out &&
+	test_cmp_unordered expect.err actual.err
 '
 
 test_expect_success "recurseSubmodules=true propagates into submodules" '
@@ -163,8 +167,8 @@ test_expect_success "recurseSubmodules=true propagates into submodules" '
 		git config fetch.recurseSubmodules true
 		git fetch >../actual.out 2>../actual.err
 	) &&
-	test_cmp expect.out actual.out &&
-	test_cmp expect.err actual.err
+	test_cmp_unordered expect.out actual.out &&
+	test_cmp_unordered expect.err actual.err
 '
 
 test_expect_success "--recurse-submodules overrides config in submodule" '
@@ -177,8 +181,8 @@ test_expect_success "--recurse-submodules overrides config in submodule" '
 		) &&
 		git fetch --recurse-submodules >../actual.out 2>../actual.err
 	) &&
-	test_cmp expect.out actual.out &&
-	test_cmp expect.err actual.err
+	test_cmp_unordered expect.out actual.out &&
+	test_cmp_unordered expect.err actual.err
 '
 
 test_expect_success "--no-recurse-submodules overrides config setting" '
-- 
1.7.4.msysgit.0
