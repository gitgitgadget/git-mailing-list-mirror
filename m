From: Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH 2/3] Windows: a test_cmp that is agnostic to random
 LF <> CRLF conversions
Date: Sat, 26 Oct 2013 21:17:15 +0200
Message-ID: <e64878fec3f026802e8d3958a1e6213428cab778.1382814437.git.j6t@kdbg.org>
References: <cover.1382814437.git.j6t@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: msysgit@googlegroups.com,
	Johannes Sixt <j6t@kdbg.org>
To: git@vger.kernel.org
X-From: msysgit+bncBCJYV6HBKQIM3KVQSMCRUBBWPOZ7Q@googlegroups.com Sat Oct 26 21:17:34 2013
Return-path: <msysgit+bncBCJYV6HBKQIM3KVQSMCRUBBWPOZ7Q@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-bk0-f56.google.com ([209.85.214.56])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCJYV6HBKQIM3KVQSMCRUBBWPOZ7Q@googlegroups.com>)
	id 1Va9Mb-0004in-Ss
	for gcvm-msysgit@m.gmane.org; Sat, 26 Oct 2013 21:17:33 +0200
Received: by mail-bk0-f56.google.com with SMTP id d7sf402800bkh.1
        for <gcvm-msysgit@m.gmane.org>; Sat, 26 Oct 2013 12:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:from:to:cc:subject:date:message-id:in-reply-to
         :references:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:list-post:list-help:list-archive
         :sender:list-subscribe:list-unsubscribe:content-type;
        bh=kioUkZal6tz19L/s3qfZ29X+0KsNJHl/B4Z8VXmxlzg=;
        b=e8wIB3op5akzdLxJcgdR91YVCY6dji2WD0g1FxYN6qSduq60S0cvgMJ+570wRd25jh
         taUfqGcxYEI/oYmjhmG6Nbwq7IhwmxwT+XoZwfMQBhWhY0bJjAl1Bo/yZBGd3/zCI6rt
         e36/KmThetbQbuHCOZESFVWqhgwYFprTkPF18sRpZzrAjNGKLeHg9b4dt+Lfz0CREihR
         2yslSmQi1KYiPjmdsxMmu1tPqAX2qs0RM72A6aCr2ETSuNLNOmhsJ7kzjw81eJ1CAF5l
         gTg0J9csg6yBvjumhEzILRN3k5xwO3MhMZfu1VMlMNHUUbf+qocbJ9s0vSZpqrZygG++
         oLCA==
X-Received: by 10.152.20.106 with SMTP id m10mr281866lae.5.1382815053494;
        Sat, 26 Oct 2013 12:17:33 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.152.1.164 with SMTP id 4ls380935lan.21.gmail; Sat, 26 Oct 2013
 12:17:32 -0700 (PDT)
X-Received: by 10.152.116.67 with SMTP id ju3mr5268885lab.0.1382815052911;
        Sat, 26 Oct 2013 12:17:32 -0700 (PDT)
Received: from bsmtp.bon.at (bsmtp5.bon.at. [195.3.86.187])
        by gmr-mx.google.com with ESMTPS id j45si1968717eep.0.2013.10.26.12.17.32
        for <msysgit@googlegroups.com>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sat, 26 Oct 2013 12:17:32 -0700 (PDT)
Received-SPF: neutral (google.com: 195.3.86.187 is neither permitted nor denied by best guess record for domain of j6t@kdbg.org) client-ip=195.3.86.187;
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 7A8C8CDF84;
	Sat, 26 Oct 2013 21:17:32 +0200 (CEST)
Received: from dx.sixt.local (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id 0420F19F666;
	Sat, 26 Oct 2013 21:17:32 +0200 (CEST)
X-Mailer: git-send-email 1.8.4.33.gd68f7e8
In-Reply-To: <cover.1382814437.git.j6t@kdbg.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236763>

In a number of tests, output that was produced by a shell script is
compared to expected output using test_cmp. Unfortunately, the MSYS bash--
when invoked via git, such as in hooks--converts LF to CRLF on output
(as produced by echo and printf), which leads to many false positives.

Implements a diff tool that undoes the converted CRLF. To avoid that
sub-processes are spawned (which is very slow on Windows), the tool is
implemented as a shell function. Diff is invoked as usual only when a
difference is detected by the shell code.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 t/test-lib-functions.sh | 66 +++++++++++++++++++++++++++++++++++++++++++++++++
 t/test-lib.sh           |  1 +
 2 files changed, 67 insertions(+)

diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index a7e9aac..f987694 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -710,3 +710,69 @@ test_ln_s_add () {
 		git update-index --add --cacheinfo 120000 $ln_s_obj "$2"
 	fi
 }
+
+# The following mingw_* functions obey POSIX shell syntax, but are actually
+# bash scripts, and are meant to be used only with bash on Windows.
+
+# A test_cmp function that treats LF and CRLF equal and avoids to fork
+# diff when possible.
+mingw_test_cmp () {
+	# Read text into shell variables and compare them. If the results
+	# are different, use regular diff to report the difference.
+	local test_cmp_a= test_cmp_b=
+
+	# When text came from stdin (one argument is '-') we must feed it
+	# to diff.
+	local stdin_for_diff=
+
+	# Since it is difficult to detect the difference between an
+	# empty input file and a failure to read the files, we go straight
+	# to diff if one of the inputs is empty.
+	if test -s "$1" && test -s "$2"
+	then
+		# regular case: both files non-empty
+		mingw_read_file_strip_cr_ test_cmp_a <"$1"
+		mingw_read_file_strip_cr_ test_cmp_b <"$2"
+	elif test -s "$1" && test "$2" = -
+	then
+		# read 2nd file from stdin
+		mingw_read_file_strip_cr_ test_cmp_a <"$1"
+		mingw_read_file_strip_cr_ test_cmp_b
+		stdin_for_diff='<<<"$test_cmp_b"'
+	elif test "$1" = - && test -s "$2"
+	then
+		# read 1st file from stdin
+		mingw_read_file_strip_cr_ test_cmp_a
+		mingw_read_file_strip_cr_ test_cmp_b <"$2"
+		stdin_for_diff='<<<"$test_cmp_a"'
+	fi
+	test -n "$test_cmp_a" &&
+	test -n "$test_cmp_b" &&
+	test "$test_cmp_a" = "$test_cmp_b" ||
+	eval "diff -u \"\$@\" $stdin_for_diff"
+}
+
+# $1 is the name of the shell variable to fill in
+mingw_read_file_strip_cr_ () {
+	# Read line-wise using LF as the line separator
+	# and use IFS to strip CR.
+	local line
+	while :
+	do
+		if IFS=$'\r' read -r -d $'\n' line
+		then
+			# good
+			line=$line$'\n'
+		else
+			# we get here at EOF, but also if the last line
+			# was not terminated by LF; in the latter case,
+			# some text was read
+			if test -z "$line"
+			then
+				# EOF, really
+				break
+			fi
+		fi
+		eval "$1=\$$1\$line"
+	done
+}
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 0fa7dfd..77e487b 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -817,6 +817,7 @@ case $(uname -s) in
 	test_set_prereq NOT_CYGWIN
 	test_set_prereq SED_STRIPS_CR
 	test_set_prereq GREP_STRIPS_CR
+	GIT_TEST_CMP=mingw_test_cmp
 	;;
 *CYGWIN*)
 	test_set_prereq POSIXPERM
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
