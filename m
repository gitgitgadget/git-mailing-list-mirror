From: Johannes Sixt <j6t@kdbg.org>
Subject: PATCH] t3200: do not open a HTML manual page when
 DEFAULT_MAN_FORMAT is html
Date: Sat, 26 Oct 2013 20:48:46 +0200
Message-ID: <526C0E8E.30605@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: msysGit <msysgit@googlegroups.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: msysgit+bncBCJYV6HBKQIJDHNQSMCRUBGWI4BTW@googlegroups.com Sat Oct 26 20:48:51 2013
Return-path: <msysgit+bncBCJYV6HBKQIJDHNQSMCRUBGWI4BTW@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-wi0-f191.google.com ([209.85.212.191])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCJYV6HBKQIJDHNQSMCRUBGWI4BTW@googlegroups.com>)
	id 1Va8uo-0006nR-2w
	for gcvm-msysgit@m.gmane.org; Sat, 26 Oct 2013 20:48:50 +0200
Received: by mail-wi0-f191.google.com with SMTP id hn9sf289743wib.28
        for <gcvm-msysgit@m.gmane.org>; Sat, 26 Oct 2013 11:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :x-original-sender:x-original-authentication-results:precedence
         :mailing-list:list-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type;
        bh=tQIRzdkijQWgjSEtiiQNTL+tUZTklNPK2hfMhp2QQYg=;
        b=C5kBRSBZfDadwfhron1iWtNRV4kT3B9Zo3rMwt4q2hqP0D0erf6ob5oT7FwWIABmEs
         AMrw5z3OErHjvxYwApJhPU/6LuNZhFgGz1d+jZ5bT24p89qIgcjwODjRvwUa9nN/GjnK
         Re5K3SiY+9vgnYCm3eNEcX6nRBfqGETDLmYC6oj3qGfqM8yxzic86JY6o0q/2TtYKRLS
         Y+LLNlR3w01m+gxqcLfi7JL++iHC/WqXYOJSEvxIm0IIsWTP+otY78R1nqM6bZm5dpnN
         qHMdGzZATtGSgkL/0G16t/HXzySs+ONi0V0ZJpSojiP6aPsLcFjCBJmlllomBMhWmINq
         pSng==
X-Received: by 10.152.44.162 with SMTP id f2mr266594lam.3.1382813329634;
        Sat, 26 Oct 2013 11:48:49 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.152.19.166 with SMTP id g6ls349117lae.66.gmail; Sat, 26 Oct
 2013 11:48:48 -0700 (PDT)
X-Received: by 10.152.228.167 with SMTP id sj7mr5251496lac.4.1382813328872;
        Sat, 26 Oct 2013 11:48:48 -0700 (PDT)
Received: from bsmtp.bon.at (bsmtp5.bon.at. [195.3.86.187])
        by gmr-mx.google.com with ESMTP id a1si2114678ees.1.2013.10.26.11.48.48
        for <msysgit@googlegroups.com>;
        Sat, 26 Oct 2013 11:48:48 -0700 (PDT)
Received-SPF: neutral (google.com: 195.3.86.187 is neither permitted nor denied by best guess record for domain of j6t@kdbg.org) client-ip=195.3.86.187;
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 36409130047;
	Sat, 26 Oct 2013 20:48:48 +0200 (CEST)
Received: from dx.sixt.local (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id BFE4D19F60F;
	Sat, 26 Oct 2013 20:48:46 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.0
X-Original-Sender: j6t@kdbg.org
X-Original-Authentication-Results: gmr-mx.google.com;       spf=neutral
 (google.com: 195.3.86.187 is neither permitted nor denied by best guess
 record for domain of j6t@kdbg.org) smtp.mail=j6t@kdbg.org
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit>
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236761>

We have the build configuration option DEFAULT_MAN_FORMAT to choose a
format different from man pages to be used by 'git help' when no format
is requested explicitly. Since 65db0443 (Set the default help format to
html for msys builds, 2013-06-04) we use html on Windows by default.

There is one test in t3200-branch.sh that invokes a help page. The
intent of the redirections applied to the command invocation is to avoid
that the man page viewer interferes with the automated test. But when
the default format is not "man", this does not have the intended effect,
and the HTML manual page is opened during the test run. Request "man"
format explicitly to keep the test silent.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 I've posted this patch to the msysgit list in July, and Dscho has picked
 it up for Git on Windows.

 t/t3200-branch.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index 44ec6a4..e9823a0 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -17,7 +17,7 @@ test_expect_success 'prepare a trivial repository' '
 	HEAD=$(git rev-parse --verify HEAD)'
 
 test_expect_success 'git branch --help should not have created a bogus branch' '
-	test_might_fail git branch --help </dev/null >/dev/null 2>/dev/null &&
+	test_might_fail git branch --man --help </dev/null >/dev/null 2>&1 &&
 	test_path_is_missing .git/refs/heads/--help
 '
 
-- 
1.8.4.33.gd68f7e8

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
You received this message because you are subscribed to the Google Groups "msysGit" group.
To unsubscribe from this group and stop receiving emails from it, send an email to msysgit+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/groups/opt_out.
