From: Thomas Braun <thomas.braun@byte-physics.de>
Subject: [PATCH/RFC] send-pack.c: Allow to disable side-band-64k
Date: Mon, 19 May 2014 21:07:14 +0200
Message-ID: <1400526434-3132-1-git-send-email-thomas.braun@byte-physics.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: msysgit@googlegroups.com
To: git@vger.kernel.org
X-From: msysgit+bncBD57FPGWUYHBBPFP5GNQKGQETZAWN5Y@googlegroups.com Mon May 19 21:13:07 2014
Return-path: <msysgit+bncBD57FPGWUYHBBPFP5GNQKGQETZAWN5Y@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-we0-f185.google.com ([74.125.82.185])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBD57FPGWUYHBBPFP5GNQKGQETZAWN5Y@googlegroups.com>)
	id 1WmSzd-00060d-2L
	for gcvm-msysgit@m.gmane.org; Mon, 19 May 2014 21:13:01 +0200
Received: by mail-we0-f185.google.com with SMTP id w61sf521553wes.12
        for <gcvm-msysgit@m.gmane.org>; Mon, 19 May 2014 12:13:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:from:to:cc:subject:date:message-id:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type;
        bh=vGAM4NLfBrwzbRG+jhHSNwwl+h7y0tnoT2xzIiLbWvE=;
        b=LijZNm6Ab9+WJD0hREP5fuFy5WYlcrUV1hcAjC+FM89+tu6qgzMcZmxYI7wzNlw508
         U+tsCdrNXl2zgQsh3+O6YKdFmQQCT4R4g4C4GrvIt0Rn3ikE7N8k8uTGy8ZBKF73oJX/
         inrg3IgL930vTrAG3NVpBFnh65u/gEHY2/CxFzt0GTCjOiPitJZdw7KADypc6788++OK
         Of1hcjNq79+ECbQKq79aNapHe6UiEhx3wixDRfKRdUJKwHMsr0fXnOkSm1eyP8wTYYzD
         tM7/tvdY5JyMjWkp+qLMJn8BzWoaXfC2k+/0sEQNKiQmeR4R6dOc3sJbP89dRP/EXSFf
         swyA==
X-Received: by 10.152.18.134 with SMTP id w6mr417168lad.1.1400526780810;
        Mon, 19 May 2014 12:13:00 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.152.197.1 with SMTP id iq1ls257972lac.18.gmail; Mon, 19 May
 2014 12:13:00 -0700 (PDT)
X-Received: by 10.112.168.198 with SMTP id zy6mr525216lbb.15.1400526780152;
        Mon, 19 May 2014 12:13:00 -0700 (PDT)
Received: by 10.194.100.38 with SMTP id ev6mswjb;
        Mon, 19 May 2014 12:08:16 -0700 (PDT)
X-Received: by 10.152.115.195 with SMTP id jq3mr1640677lab.4.1400526495937;
        Mon, 19 May 2014 12:08:15 -0700 (PDT)
Received: from wp380.webpack.hosteurope.de (wp380.webpack.hosteurope.de. [2a01:488:42::50ed:8595])
        by gmr-mx.google.com with ESMTPS id r49si201974eep.0.2014.05.19.12.08.15
        for <msysgit@googlegroups.com>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 19 May 2014 12:08:15 -0700 (PDT)
Received-SPF: none (google.com: thomas.braun@byte-physics.de does not designate permitted sender hosts) client-ip=2a01:488:42::50ed:8595;
Received: from p5ddc1dd3.dip0.t-ipconnect.de ([93.220.29.211] helo=localhost.localdomain); authenticated
	by wp380.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	id 1WmSv0-0005nF-Gj; Mon, 19 May 2014 21:08:14 +0200
X-Mailer: git-send-email 1.9.1
X-bounce-key: webpack.hosteurope.de;thomas.braun@byte-physics.de;1400526495;738fa282;
X-Original-Sender: thomas.braun@byte-physics.de
X-Original-Authentication-Results: gmr-mx.google.com;       spf=neutral
 (google.com: thomas.braun@byte-physics.de does not designate permitted sender
 hosts) smtp.mail=thomas.braun@byte-physics.de
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249613>

Since commit 0c499ea60f the send-pack builtin uses the side-band-64k
capability if advertised by the server. Unfortunately this breaks
pushing over the dump git protocol with a windows git client.

The detailed reasons for this breakage are (by courtesy of Jeff
Preshing, quoted from
https://groups.google.com/d/msg/msysgit/at8D7J-h7mw/eaLujILGUWoJ):
----------------------------------------------------------------------------
MinGW wraps Windows sockets in CRT file descriptors in order to mimic
the functionality of POSIX sockets. This causes msvcrt.dll to treat
sockets as Installable File System (IFS) handles, calling ReadFile,
WriteFile, DuplicateHandle and CloseHandle on them. This approach works
well in simple cases on recent versions of Windows, but does not support
all usage patterns.  In particular, using this approach, any attempt to
read & write concurrently on the same socket (from one or more
processes) will deadlock in a scenario where the read waits for a
response from the server which is only invoked after the write. This is
what send_pack currently attempts to do in the use_sideband codepath.
----------------------------------------------------------------------------

The new config option "sendpack.sideband" allows to override the
side-band-64k capability of the server.

Other transportation methods like ssh and http/https still benefit from
the sideband channel, therefore the default value of "sendpack.sideband"
is still true.

Alternative approaches considered but deemed too invasive:
- Rewrite read/write wrappers in mingw.c in order to distinguish between
  a file descriptor which has a socket behind and a file descriptor
  which has a file behind.
- Turning the capability side-band-64k off completely. This would remove a useful
  feature for users of non-affected transport protocols.

Signed-off-by: Thomas Braun <thomas.braun@byte-physics.de>
---

This patch, with a slightly less polished commit message, is already part of
msysgit/git see b68e386. 

A lengthy discussion can be found here [1].

What do you think, is this also for you as upstream interesting?

[1]: https://github.com/msysgit/git/issues/101

 Documentation/config.txt |  6 ++++++
 send-pack.c              | 14 +++++++++++++-
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 1932e9b..13ff657 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -2435,3 +2435,9 @@ web.browser::
 	Specify a web browser that may be used by some commands.
 	Currently only linkgit:git-instaweb[1] and linkgit:git-help[1]
 	may use it.
+
+sendpack.sideband::
+  Allows to disable the side-band-64k capability for send-pack even
+  when it is advertised by the server. Makes it possible to work
+  around a limitation in the git for windows implementation together
+  with the dump git protocol. Defaults to true.
diff --git a/send-pack.c b/send-pack.c
index 6129b0f..aace1fc 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -12,6 +12,16 @@
 #include "version.h"
 #include "sha1-array.h"
 
+static int config_use_sideband = 1;
+
+static int send_pack_config(const char *var, const char *value, void *unused)
+{
+	if (!strcmp("sendpack.sideband", var))
+		config_use_sideband = git_config_bool(var, value);
+
+	return 0;
+}
+
 static int feed_object(const unsigned char *sha1, int fd, int negative)
 {
 	char buf[42];
@@ -209,6 +219,8 @@ int send_pack(struct send_pack_args *args,
 	int ret;
 	struct async demux;
 
+	git_config(send_pack_config, NULL);
+
 	/* Does the other end support the reporting? */
 	if (server_supports("report-status"))
 		status_report = 1;
@@ -216,7 +228,7 @@ int send_pack(struct send_pack_args *args,
 		allow_deleting_refs = 1;
 	if (server_supports("ofs-delta"))
 		args->use_ofs_delta = 1;
-	if (server_supports("side-band-64k"))
+	if (config_use_sideband && server_supports("side-band-64k"))
 		use_sideband = 1;
 	if (server_supports("quiet"))
 		quiet_supported = 1;
-- 
1.9.1

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
For more options, visit https://groups.google.com/d/optout.
