From: Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH] revisions --stdin: accept CRLF line terminators
Date: Tue, 11 Aug 2015 22:21:33 +0200
Message-ID: <55CA594D.5020103@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git Mailing List <git@vger.kernel.org>, msysGit <msysgit@googlegroups.com>
X-From: msysgit+bncBCJYV6HBKQIM7MVJVYCRUBERS2AUI@googlegroups.com Tue Aug 11 22:21:39 2015
Return-path: <msysgit+bncBCJYV6HBKQIM7MVJVYCRUBERS2AUI@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-lb0-f189.google.com ([209.85.217.189])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCJYV6HBKQIM7MVJVYCRUBERS2AUI@googlegroups.com>)
	id 1ZPG3F-0005hE-4I
	for gcvm-msysgit@m.gmane.org; Tue, 11 Aug 2015 22:21:37 +0200
Received: by lbck9 with SMTP id k9sf16195429lbc.1
        for <gcvm-msysgit@m.gmane.org>; Tue, 11 Aug 2015 13:21:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-type:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:x-spam-checked-in-group:list-post
         :list-help:list-archive:sender:list-subscribe:list-unsubscribe;
        bh=tNzzshWsXITxK95f+2v8vDRLP00XgW/hLXebWoekc20=;
        b=nXWyxKG9IOXPf0oBoESB9ae8NuLiqVYeBn9leFsf/WMxBDd1MpUXp7fAJOAQ1KcvSM
         O1Au94GbI/lX9Aut/7RH4yANp2JGosF55jYv3WtJWkS/yT44sGVFIwQp/8L37gjnBhM3
         Q5ni9ohYOpkYaNYUkt+53GW9VxIps9Z4JssLZjhtexjs+VLeIV33iPWC3NIDvPQh4xy8
         xjKMIoBY+E7JKnWLt7cuOICzAptaHU8up5qwwL8SdrnxVT1pqZYGTCWlsKkkesxuh+y+
         wWD/PqrmeIv3Ch6eIwpBruP0lJh05+VIml1w9UcCCOUgJIyAttz6UOD4hdbeKtjd2M1s
         CwpQ==
X-Received: by 10.152.6.40 with SMTP id x8mr198145lax.40.1439324496776;
        Tue, 11 Aug 2015 13:21:36 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.152.234.108 with SMTP id ud12ls923217lac.43.gmail; Tue, 11 Aug
 2015 13:21:35 -0700 (PDT)
X-Received: by 10.152.115.196 with SMTP id jq4mr8491292lab.1.1439324495391;
        Tue, 11 Aug 2015 13:21:35 -0700 (PDT)
Received: from bsmtp8.bon.at (bsmtp8.bon.at. [213.33.87.20])
        by gmr-mx.google.com with ESMTPS id ec7si126924wib.3.2015.08.11.13.21.35
        for <msysgit@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Aug 2015 13:21:35 -0700 (PDT)
Received-SPF: neutral (google.com: 213.33.87.20 is neither permitted nor denied by best guess record for domain of j6t@kdbg.org) client-ip=213.33.87.20;
Received: from dx.site (unknown [93.83.142.38])
	by bsmtp8.bon.at (Postfix) with ESMTPSA id 3mrQYB51Fcz5tlF;
	Tue, 11 Aug 2015 22:21:34 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.site (Postfix) with ESMTP id 84A8C52D0;
	Tue, 11 Aug 2015 22:21:33 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.1.0
X-Original-Sender: j6t@kdbg.org
X-Original-Authentication-Results: gmr-mx.google.com;       spf=neutral
 (google.com: 213.33.87.20 is neither permitted nor denied by best guess
 record for domain of j6t@kdbg.org) smtp.mailfrom=j6t@kdbg.org
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275720>

On Windows, 'git rebase -i' with rebase.missingCommitsCheck set to
warn or error reports:

   Dropped commits (newer to older):
   'atal: bad revision '410dee56...

The error comes from the git rev-list --stdin invocation in
git-rebase--interactive.sh (function check_todo_list). It is caused by
CRs that end up in the file "$todo".miss, because many tools of the MSYS
toolset force LF to CRLF conversion when regular files are written via
stdout.

To fix the error, permit CRLF line terminators when revisions and
pathspec are read using the --stdin option.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 This fixes a new failure in the test suite (t3404.8[67]) on Windows, but
 I got around to debug it only now.

 revision.c                |  4 ++++
 t/t6017-rev-list-stdin.sh | 16 ++++++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/revision.c b/revision.c
index cf60c5d..4efedeb 100644
--- a/revision.c
+++ b/revision.c
@@ -1641,6 +1641,8 @@ static void read_pathspec_from_stdin(struct rev_info *revs, struct strbuf *sb,
 		int len = sb->len;
 		if (len && sb->buf[len - 1] == '\n')
 			sb->buf[--len] = '\0';
+		if (len && sb->buf[len - 1] == '\r')
+			sb->buf[--len] = '\0';
 		ALLOC_GROW(prune->path, prune->nr + 1, prune->alloc);
 		prune->path[prune->nr++] = xstrdup(sb->buf);
 	}
@@ -1661,6 +1663,8 @@ static void read_revisions_from_stdin(struct rev_info *revs,
 		int len = sb.len;
 		if (len && sb.buf[len - 1] == '\n')
 			sb.buf[--len] = '\0';
+		if (len && sb.buf[len - 1] == '\r')
+			sb.buf[--len] = '\0';
 		if (!len)
 			break;
 		if (sb.buf[0] == '-') {
diff --git a/t/t6017-rev-list-stdin.sh b/t/t6017-rev-list-stdin.sh
index 667b375..34c43cf 100755
--- a/t/t6017-rev-list-stdin.sh
+++ b/t/t6017-rev-list-stdin.sh
@@ -75,4 +75,20 @@ test_expect_success 'not only --stdin' '
 	test_cmp expect actual
 '
 
+test_expect_success 'accept CRLF line terminators' '
+	cat >expect <<-\EOF &&
+	7
+
+	file-2
+	EOF
+	q_to_cr >input <<-\EOF &&
+	masterQ
+	^master^Q
+	--Q
+	file-2Q
+	EOF
+	git log --pretty=tformat:%s --name-only --stdin <input >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.3.2.245.gb5bf9d3

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
