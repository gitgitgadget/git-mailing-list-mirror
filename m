Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DDBB220467
	for <e@80x24.org>; Mon, 16 Oct 2017 17:55:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754203AbdJPRzp (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Oct 2017 13:55:45 -0400
Received: from mail-io0-f182.google.com ([209.85.223.182]:54316 "EHLO
        mail-io0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753676AbdJPRzn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Oct 2017 13:55:43 -0400
Received: by mail-io0-f182.google.com with SMTP id e89so9283910ioi.11
        for <git@vger.kernel.org>; Mon, 16 Oct 2017 10:55:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/v2w9tdYMqFr3p5+VAInFSjMXVwAr9jqUrgcoGnWO+A=;
        b=Uy1lvJjA/XoZQww881saH35jzM1Nx7cMMsn/JxWst0AqfFDee47k0dl0Fq17LBUnAO
         hNlea0mYtzl+WrsYoh2E+vEucpXZDy3EIt311295/vCwPkAHtwhNWgih63gnx3EW4MQI
         Iw/XrDy9QqF+w6/zhpalwRQRz6XZiIG+ZZRzZLM9LfUOLtBW+7PCtQr82RALTIhCFXHu
         L8gazpAwp1wdspX8jju4pmmG35jBnKstOaFFJfVtMxcsNPp950wvsxdpOA6eurKbyIi1
         dPcVPPBa8k9sANY0JnWD7EwxHrgiExEIzMwrNeDAIUqzmjr7lSmAjuaDnxSJNM7XSTnu
         Kt3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/v2w9tdYMqFr3p5+VAInFSjMXVwAr9jqUrgcoGnWO+A=;
        b=QBPcZPZ/es+/3ynyN6oNq1QrSre1qcYBDWP28Y9IvtUzmnZ2KVFNy7PtviFoOjn0r5
         rEjxDcIGh3JE1tZkNllWxzZe0G2ljR+imQJauiB5SHrH+ssBfwbvmBvgtBn6013DVKwa
         GaffZjd8nv48FEG2C0lpFDDclin3GuLfwpBFOHvw/V1jiWl3o53d7yYZGtQWp9TKLgk5
         A27Nopggdi7BP8JrOUttToItUufUj5Bhat2nXAyMdIGKhq+yv621U+ttpiIvpXdxpmWY
         mRueZsLPg2/bfewGQLoYfoGsYy6OfyJVj0CoLhjbP7CkACUPEaj4pmC9rOjt7Ff0zlDj
         xe4Q==
X-Gm-Message-State: AMCzsaWjYjJX5wS25myn/ddqJaAuJpIADttSyzZvOT+DcVXBoRFJutYn
        Ap3vnwZB7K9vGopxyAv7CIDN7Zs/5xs=
X-Google-Smtp-Source: AOwi7QDzmJ3Db607y/vImBDM785DzlI4U7c43QzcuPVl+H1KFfBWZA4/m2IFpK3uF6EK0eCLFjBfgw==
X-Received: by 10.107.3.82 with SMTP id 79mr14030861iod.297.1508176542020;
        Mon, 16 Oct 2017 10:55:42 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id s74sm3813071ita.21.2017.10.16.10.55.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 16 Oct 2017 10:55:40 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     martin.agren@gmail.com, simon@ruderich.org, bturner@atlassian.com,
        git@jeffhostetler.com, gitster@pobox.com, jonathantanmy@google.com,
        jrnieder@gmail.com, peff@peff.net, sbeller@google.com,
        Brandon Williams <bmwill@google.com>
Subject: [PATCH v4 00/11] protocol transition
Date:   Mon, 16 Oct 2017 10:55:21 -0700
Message-Id: <20171016175532.73459-1-bmwill@google.com>
X-Mailer: git-send-email 2.15.0.rc0.271.g36b669edcc-goog
In-Reply-To: <20171003201507.3589-1-bmwill@google.com>
References: <20171003201507.3589-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Changes in v4:
 * Added more tests for the new handeling of ssh variants.
 * Removed the 'default' case in upload_pack and receive_pack and instead
   ensured that all enum values were accounted for.  This way when a new
   protocol version is introduced the compiler will throw an error if the new
   protocol version isn't accounted for in these switch statements.
 * Added Jonathan's Documentation patch ontop of the series (with the small
   change I pointed out in reply to the patch itself)
 * A few other small changes due to reviewer comments.


Brandon Williams (9):
  pkt-line: add packet_write function
  protocol: introduce protocol extension mechanisms
  daemon: recognize hidden request arguments
  upload-pack, receive-pack: introduce protocol version 1
  connect: teach client to recognize v1 server response
  connect: tell server that the client understands v1
  http: tell server that the client understands v1
  i5700: add interop test for protocol transition
  ssh: introduce a 'simple' ssh variant

Jonathan Tan (2):
  connect: in ref advertisement, shallows are last
  Documentation: document Extra Parameters

 Documentation/config.txt                  |  44 +++-
 Documentation/git.txt                     |  15 +-
 Documentation/technical/http-protocol.txt |   8 +
 Documentation/technical/pack-protocol.txt |  43 +++-
 Makefile                                  |   1 +
 builtin/receive-pack.c                    |  17 ++
 cache.h                                   |  10 +
 connect.c                                 | 354 ++++++++++++++++++++----------
 daemon.c                                  |  71 +++++-
 http.c                                    |  18 ++
 pkt-line.c                                |   6 +
 pkt-line.h                                |   1 +
 protocol.c                                |  79 +++++++
 protocol.h                                |  33 +++
 t/interop/i5700-protocol-transition.sh    |  68 ++++++
 t/lib-httpd/apache.conf                   |   7 +
 t/t5601-clone.sh                          |  26 ++-
 t/t5700-protocol-v1.sh                    | 294 +++++++++++++++++++++++++
 upload-pack.c                             |  20 +-
 19 files changed, 967 insertions(+), 148 deletions(-)
 create mode 100644 protocol.c
 create mode 100644 protocol.h
 create mode 100755 t/interop/i5700-protocol-transition.sh
 create mode 100755 t/t5700-protocol-v1.sh

--- interdiff with 'origin/bw/protocol-v1'


diff --git a/Documentation/technical/http-protocol.txt b/Documentation/technical/http-protocol.txt
index 1c561bdd9..a0e45f288 100644
--- a/Documentation/technical/http-protocol.txt
+++ b/Documentation/technical/http-protocol.txt
@@ -219,6 +219,10 @@ smart server reply:
    S: 003c2cb58b79488a98d2721cea644875a8dd0026b115 refs/tags/v1.0\n
    S: 003fa3c2e2402b99163d1d59756e5f207ae21cccba4c refs/tags/v1.0^{}\n
 
+The client may send Extra Parameters (see
+Documentation/technical/pack-protocol.txt) as a colon-separated string
+in the Git-Protocol HTTP header.
+
 Dumb Server Response
 ^^^^^^^^^^^^^^^^^^^^
 Dumb servers MUST respond with the dumb server reply format.
@@ -269,7 +273,11 @@ the C locale ordering.  The stream SHOULD include the default ref
 named `HEAD` as the first ref.  The stream MUST include capability
 declarations behind a NUL on the first ref.
 
+The returned response contains "version 1" if "version=1" was sent as an
+Extra Parameter.
+
   smart_reply     =  PKT-LINE("# service=$servicename" LF)
+		     *1("version 1")
 		     ref_list
 		     "0000"
   ref_list        =  empty_list / non_empty_list
diff --git a/Documentation/technical/pack-protocol.txt b/Documentation/technical/pack-protocol.txt
index ed1eae8b8..cd31edc91 100644
--- a/Documentation/technical/pack-protocol.txt
+++ b/Documentation/technical/pack-protocol.txt
@@ -39,6 +39,19 @@ communicates with that invoked process over the SSH connection.
 The file:// transport runs the 'upload-pack' or 'receive-pack'
 process locally and communicates with it over a pipe.
 
+Extra Parameters
+----------------
+
+The protocol provides a mechanism in which clients can send additional
+information in its first message to the server. These are called "Extra
+Parameters", and are supported by the Git, SSH, and HTTP protocols.
+
+Each Extra Parameter takes the form of `<key>=<value>` or `<key>`.
+
+Servers that receive any such Extra Parameters MUST ignore all
+unrecognized keys. Currently, the only Extra Parameter recognized is
+"version=1".
+
 Git Transport
 -------------
 
@@ -46,18 +59,25 @@ The Git transport starts off by sending the command and repository
 on the wire using the pkt-line format, followed by a NUL byte and a
 hostname parameter, terminated by a NUL byte.
 
-   0032git-upload-pack /project.git\0host=myserver.com\0
+   0033git-upload-pack /project.git\0host=myserver.com\0
+
+The transport may send Extra Parameters by adding an additional NUL
+byte, and then adding one or more NUL-terminated strings:
+
+   003egit-upload-pack /project.git\0host=myserver.com\0\0version=1\0
 
 --
-   git-proto-request = request-command SP pathname NUL [ host-parameter NUL ]
+   git-proto-request = request-command SP pathname NUL
+		       [ host-parameter NUL ] [ NUL extra-parameters ]
    request-command   = "git-upload-pack" / "git-receive-pack" /
 		       "git-upload-archive"   ; case sensitive
    pathname          = *( %x01-ff ) ; exclude NUL
    host-parameter    = "host=" hostname [ ":" port ]
+   extra-parameters  = 1*extra-parameter
+   extra-parameter   = 1*( %x01-ff ) NUL
 --
 
-Only host-parameter is allowed in the git-proto-request. Clients
-MUST NOT attempt to send additional parameters. It is used for the
+host-parameter is used for the
 git-daemon name based virtual hosting.  See --interpolated-path
 option to git daemon, with the %H/%CH format characters.
 
@@ -117,6 +137,12 @@ we execute it without the leading '/'.
 		     v
    ssh user@example.com "git-upload-pack '~alice/project.git'"
 
+Depending on the value of the `protocol.version` configuration variable,
+Git may attempt to send Extra Parameters as a colon-separated string in
+the GIT_PROTOCOL environment variable. This is done only if
+the `ssh.variant` configuration variable indicates that the ssh command
+supports passing environment variables as an argument.
+
 A few things to remember here:
 
 - The "command name" is spelled with dash (e.g. git-upload-pack), but
@@ -137,11 +163,13 @@ Reference Discovery
 -------------------
 
 When the client initially connects the server will immediately respond
-with a listing of each reference it has (all branches and tags) along
+with a version number (if "version=1" is sent as an Extra Parameter),
+and a listing of each reference it has (all branches and tags) along
 with the object name that each reference currently points to.
 
-   $ echo -e -n "0039git-upload-pack /schacon/gitbook.git\0host=example.com\0" |
+   $ echo -e -n "0044git-upload-pack /schacon/gitbook.git\0host=example.com\0\0version=1\0" |
       nc -v example.com 9418
+   000aversion 1
    00887217a7c7e582c46cec22a130adf4b9d7d950fba0 HEAD\0multi_ack thin-pack
 		side-band side-band-64k ofs-delta shallow no-progress include-tag
    00441d3fcd5ced445d1abc402225c0b8a1299641f497 refs/heads/integration
@@ -165,7 +193,8 @@ immediately after the ref itself, if presented. A conforming server
 MUST peel the ref if it's an annotated tag.
 
 ----
-  advertised-refs  =  (no-refs / list-of-refs)
+  advertised-refs  =  *1("version 1")
+		      (no-refs / list-of-refs)
 		      *shallow
 		      flush-pkt
 
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 94b7d29ea..839c1462d 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -1966,15 +1966,17 @@ int cmd_receive_pack(int argc, const char **argv, const char *prefix)
 
 	switch (determine_protocol_version_server()) {
 	case protocol_v1:
-		if (advertise_refs || !stateless_rpc)
-			packet_write_fmt(1, "version 1\n");
 		/*
 		 * v1 is just the original protocol with a version string,
 		 * so just fall through after writing the version string.
 		 */
+		if (advertise_refs || !stateless_rpc)
+			packet_write_fmt(1, "version 1\n");
+
+		/* fallthrough */
 	case protocol_v0:
 		break;
-	default:
+	case protocol_unknown_version:
 		BUG("unknown protocol version");
 	}
 
diff --git a/connect.c b/connect.c
index 65cee49b6..7fbd396b3 100644
--- a/connect.c
+++ b/connect.c
@@ -836,7 +836,8 @@ static enum ssh_variant determine_ssh_variant(const char *ssh_command,
 		}
 	}
 
-	if (!strcasecmp(variant, "ssh"))
+	if (!strcasecmp(variant, "ssh") ||
+	    !strcasecmp(variant, "ssh.exe"))
 		ssh_variant = VARIANT_SSH;
 	else if (!strcasecmp(variant, "plink") ||
 		 !strcasecmp(variant, "plink.exe"))
diff --git a/daemon.c b/daemon.c
index 36cc794c9..e37e343d0 100644
--- a/daemon.c
+++ b/daemon.c
@@ -582,6 +582,9 @@ static void canonicalize_client(struct strbuf *out, const char *in)
 
 /*
  * Read the host as supplied by the client connection.
+ *
+ * Returns a pointer to the character after the NUL byte terminating the host
+ * arguemnt, or 'extra_args' if there is no host arguemnt.
  */
 static char *parse_host_arg(struct hostinfo *hi, char *extra_args, int buflen)
 {
diff --git a/pkt-line.c b/pkt-line.c
index c025d0332..7006b3587 100644
--- a/pkt-line.c
+++ b/pkt-line.c
@@ -188,7 +188,7 @@ static int packet_write_gently(const int fd_out, const char *buf, size_t size)
 	return 0;
 }
 
-void packet_write(const int fd_out, const char *buf, size_t size)
+void packet_write(int fd_out, const char *buf, size_t size)
 {
 	if (packet_write_gently(fd_out, buf, size))
 		die_errno("packet write failed");
diff --git a/pkt-line.h b/pkt-line.h
index d9e9783b1..3dad583e2 100644
--- a/pkt-line.h
+++ b/pkt-line.h
@@ -22,7 +22,7 @@
 void packet_flush(int fd);
 void packet_write_fmt(int fd, const char *fmt, ...) __attribute__((format (printf, 2, 3)));
 void packet_buf_flush(struct strbuf *buf);
-void packet_write(const int fd_out, const char *buf, size_t size);
+void packet_write(int fd_out, const char *buf, size_t size);
 void packet_buf_write(struct strbuf *buf, const char *fmt, ...) __attribute__((format (printf, 2, 3)));
 int packet_flush_gently(int fd);
 int packet_write_fmt_gently(int fd, const char *fmt, ...) __attribute__((format (printf, 2, 3)));
diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
index ee1a24c5b..86811a0c3 100755
--- a/t/t5601-clone.sh
+++ b/t/t5601-clone.sh
@@ -309,21 +309,18 @@ test_expect_success 'clone checking out a tag' '
 setup_ssh_wrapper () {
 	test_expect_success 'setup ssh wrapper' '
 		cp "$GIT_BUILD_DIR/t/helper/test-fake-ssh$X" \
-			"$TRASH_DIRECTORY/ssh-wrapper$X" &&
-		GIT_SSH="$TRASH_DIRECTORY/ssh-wrapper$X" &&
+			"$TRASH_DIRECTORY/ssh$X" &&
+		GIT_SSH="$TRASH_DIRECTORY/ssh$X" &&
 		export GIT_SSH &&
-		GIT_SSH_VARIANT=ssh &&
-		export GIT_SSH_VARIANT &&
 		export TRASH_DIRECTORY &&
 		>"$TRASH_DIRECTORY"/ssh-output
 	'
 }
 
 copy_ssh_wrapper_as () {
-	cp "$TRASH_DIRECTORY/ssh-wrapper$X" "${1%$X}$X" &&
+	cp "$TRASH_DIRECTORY/ssh$X" "${1%$X}$X" &&
 	GIT_SSH="${1%$X}$X" &&
-	export GIT_SSH &&
-	unset GIT_SSH_VARIANT
+	export GIT_SSH
 }
 
 expect_ssh () {
@@ -365,6 +362,22 @@ test_expect_success 'bracketed hostnames are still ssh' '
 	expect_ssh "-p 123" myhost src
 '
 
+test_expect_success 'OpenSSH variant passes -4' '
+	git clone -4 "[myhost:123]:src" ssh-ipv4-clone &&
+	expect_ssh "-4 -p 123" myhost src
+'
+
+test_expect_success 'variant can be overriden' '
+	git -c ssh.variant=simple clone -4 "[myhost:123]:src" ssh-simple-clone &&
+	expect_ssh myhost src
+'
+
+test_expect_success 'simple is treated as simple' '
+	copy_ssh_wrapper_as "$TRASH_DIRECTORY/simple" &&
+	git clone -4 "[myhost:123]:src" ssh-bracket-clone-simple &&
+	expect_ssh myhost src
+'
+
 test_expect_success 'uplink is treated as simple' '
 	copy_ssh_wrapper_as "$TRASH_DIRECTORY/uplink" &&
 	git clone "[myhost:123]:src" ssh-bracket-clone-uplink &&
diff --git a/upload-pack.c b/upload-pack.c
index ef438e9c2..ef99a029c 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -1071,16 +1071,18 @@ int cmd_main(int argc, const char **argv)
 
 	switch (determine_protocol_version_server()) {
 	case protocol_v1:
-		if (advertise_refs || !stateless_rpc)
-			packet_write_fmt(1, "version 1\n");
 		/*
 		 * v1 is just the original protocol with a version string,
 		 * so just fall through after writing the version string.
 		 */
+		if (advertise_refs || !stateless_rpc)
+			packet_write_fmt(1, "version 1\n");
+
+		/* fallthrough */
 	case protocol_v0:
 		upload_pack();
 		break;
-	default:
+	case protocol_unknown_version:
 		BUG("unknown protocol version");
 	}
 

-- 
2.15.0.rc0.271.g36b669edcc-goog

