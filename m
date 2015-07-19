From: Philip Oakley <philipoakley@iee.org>
Subject: [PATCH v2 15/16] msvc-build: add complete Microsoft Visual
 C compilation script
Date: Sun, 19 Jul 2015 21:08:16 +0100
Message-ID: <1437336497-4072-17-git-send-email-philipoakley@iee.org>
References: <1437336497-4072-1-git-send-email-philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	MsysGit List <msysgit@googlegroups.com>,
	Yue Lin Ho <b8732003@student.nsysu.edu.tw>,
	Philip Oakley <philipoakley@iee.org>
To: Git List <git@vger.kernel.org>
X-From: msysgit+bncBDSOTWHYX4PBB4MGWCWQKGQEJHE3ZRQ@googlegroups.com Sun Jul 19 22:07:18 2015
Return-path: <msysgit+bncBDSOTWHYX4PBB4MGWCWQKGQEJHE3ZRQ@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-wg0-f60.google.com ([74.125.82.60])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBDSOTWHYX4PBB4MGWCWQKGQEJHE3ZRQ@googlegroups.com>)
	id 1ZGuri-0002NB-7i
	for gcvm-msysgit@m.gmane.org; Sun, 19 Jul 2015 22:07:14 +0200
Received: by wgik5 with SMTP id k5sf789388wgi.1
        for <gcvm-msysgit@m.gmane.org>; Sun, 19 Jul 2015 13:07:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:from:to:cc:subject:date:message-id:in-reply-to
         :references:x-original-sender:x-original-authentication-results
         :content-type:precedence:mailing-list:list-id
         :x-spam-checked-in-group:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe;
        bh=+t39LCV3RaxGe1juUk7V0bluJpkHQJ+UgKxHV0GQ+v4=;
        b=R/Ivbo5CaKoH3EXVRKLDGdjL6EWM6t51bcwz/5gK58WyInXWa5Kf53WkKVx44HboTD
         zmK+yTCIu0PDPUHed9I0/Qd3JWJy23gLj727YOGkwm7jlZyvII1qNI3R/FZ9KEl3nCeK
         pbfLG5dHDpwGhm0h6TS/W/MG9ORbPlPFulKO2hHQnHroZRPhDXFIGixKQ9OpsNEImYLa
         Dr2r68a0t21z4F2PdJSE9UKCPLfU564yHiQ3uIOWzF06Pgx8R1u4/+Rz72PqOF8WwolC
         11XTiETRBVUymtjtP363s1vq2NyCKBo9/s55aipmgWXiZqcF+Tx/J2RgotaupQMr8yCb
         MDiQ==
X-Received: by 10.180.90.235 with SMTP id bz11mr28474wib.6.1437336433962;
        Sun, 19 Jul 2015 13:07:13 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.180.84.42 with SMTP id v10ls681560wiy.36.gmail; Sun, 19 Jul
 2015 13:07:13 -0700 (PDT)
X-Received: by 10.180.35.162 with SMTP id i2mr4472702wij.6.1437336433351;
        Sun, 19 Jul 2015 13:07:13 -0700 (PDT)
Received: from out1.ip02ir2.opaltelecom.net (out1.ip02ir2.opaltelecom.net. [62.24.128.238])
        by gmr-mx.google.com with ESMTP id gt9si270946wib.2.2015.07.19.13.07.13
        for <msysgit@googlegroups.com>;
        Sun, 19 Jul 2015 13:07:13 -0700 (PDT)
Received-SPF: softfail (google.com: domain of transitioning philipoakley@iee.org does not designate 62.24.128.238 as permitted sender) client-ip=62.24.128.238;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: A2AVDACSAqxVPN4GFlxcgkFSIzFpu2UJgU4dCoUtRAQCAoEaORQBAQEBAQEBBgEBAQFAAT+EJAEBBFYjEAhJOQoGAQ0GExSIHgnEXwEBAQcCII9mbAeCLQxBgTEFhWCGWIgahG+JO5Z+gQmDGj0xgksBAQE
X-IPAS-Result: A2AVDACSAqxVPN4GFlxcgkFSIzFpu2UJgU4dCoUtRAQCAoEaORQBAQEBAQEBBgEBAQFAAT+EJAEBBFYjEAhJOQoGAQ0GExSIHgnEXwEBAQcCII9mbAeCLQxBgTEFhWCGWIgahG+JO5Z+gQmDGj0xgksBAQE
X-IronPort-AV: E=Sophos;i="5.15,504,1432594800"; 
   d="scan'208";a="39118947"
Received: from host-92-22-6-222.as13285.net (HELO localhost) ([92.22.6.222])
  by out1.ip02ir2.opaltelecom.net with ESMTP; 19 Jul 2015 21:07:13 +0100
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274289>

Implement the README to facilitate cross community development.
Include comments for those Windows folks not yet fully familiar
with bash commands.

This is identical to the msysgit script, except for the 'cd toplevel'
step, and comments for the edification of converts from Windows.

Original author: Johannes Schindelin (2011-11-01 3142da4 : Add a script
to make the MSVC build more convenient) on Msysgit
https://github.com/msysgit/msysgit/commit/3142da4038 and subsequent
development.

The --gui clean now also removes the VS2010 .sdf file, and the
vcs-svn_lib & xdiff_lib directories.

The script is made executable in line with $msysgit/cb9836b8a
(Mark scripts and binaries in /bin/ as executable, 2012-06-26)

Signed-off-by: Philip Oakley <philipoakley@iee.org>
---

TODO:
resolve any further cleaning of newer VS2010... build products.
---
 compat/vcbuild/README             |  2 +
 compat/vcbuild/scripts/msvc-build | 86 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 88 insertions(+)
 create mode 100755 compat/vcbuild/scripts/msvc-build

diff --git a/compat/vcbuild/README b/compat/vcbuild/README
index ad8633e..faaea69 100644
--- a/compat/vcbuild/README
+++ b/compat/vcbuild/README
@@ -57,3 +57,5 @@ The Steps of Build Git with VS2008
    Git, which you set up in step 1.
 
 Done!
+
+Or, use the msvc-build script; available from /compat/vcbuild/scripts/.
diff --git a/compat/vcbuild/scripts/msvc-build b/compat/vcbuild/scripts/msvc-build
new file mode 100755
index 0000000..d67203b
--- /dev/null
+++ b/compat/vcbuild/scripts/msvc-build
@@ -0,0 +1,86 @@
+#!/bin/sh
+
+# This msvc-build command should be executed from the msysgit directory level
+# This is so that the 'cd/git' step works and the subequent operations have the right msysgit super directory.
+set -e # Exit immediately if a command exits with a nonzero exit status.
+
+gui=
+clean=
+while test $# -gt 0
+do
+	case "$1" in
+	--gui|--dev|--devenv|--vs|--visual-studio)
+		gui=t
+		;;
+	clean)
+		clean=t
+		;;
+	*)
+		echo "Usage: $0 [--vs] [clean]" >&2
+		exit 1
+		;;
+	esac
+	shift
+done
+
+cd $(git rev-parse --show-toplevel)
+
+case "$clean" in
+t)
+	case "$gui" in
+	t)
+		rm -rf git.sln git.sdf libgit vcs-svn_lib xdiff_lib
+		# remove any other new VS2010... stuff as well: rm -rf  ?
+		;;
+	'')
+		make clean
+		;;
+	esac
+	exit
+	;;
+esac
+
+to_ignore="$(git ls-files --other --exclude-standard msvcgit msvc-build.cmd)"
+test -z "$to_ignore" || {
+	mkdir -p .git/info &&
+	echo "$to_ignore" |
+	sed 's/^/\//' >> .git/info/exclude
+} || exit
+
+test -d msvcgit || git clone git://repo.or.cz/msvcgit.git
+
+vsvars=
+# assume cl.exe will populate its relevant environment variables
+# if cl.exe does not exist, populate vsvars with the most recent Visual Studio path
+type cl.exe 2> /dev/null ||
+vsvars="$(ls -t \
+	"$PROGRAMFILES/Microsoft Visual Studio"*/Common7/Tools/vsvars32.bat |
+	head -n 1)"
+
+
+config_mak=
+# if a config.mak file (dot, not underscore) exists, back it up,
+# remember the backup file name in config_mak.
+test -f config.mak &&
+config_mak=config.mak.bup.$$ &&
+mv config.mak $config_mak
+
+cat > config.mak << EOF
+CFLAGS += -Imsvcgit/32bits/include
+LDFLAGS += -Lmsvcgit/32bits/lib
+EOF
+
+echo "call \"$vsvars\"" > msvc-build.cmd
+if test -z "$gui"
+then
+	echo 'make MSVC=1' >> msvc-build.cmd
+else
+	echo 'perl contrib/buildsystems/generate -g Vcproj' >> msvc-build.cmd
+	echo 'start git.sln' >> msvc-build.cmd
+fi
+
+cmd /c msvc-build.cmd
+
+# if we made a backup file (name in config_mak), then restore it.
+test -z "$config_mak" ||
+mv $config_mak config.mak
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
