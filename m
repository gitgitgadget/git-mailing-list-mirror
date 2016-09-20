Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C98D3209A9
	for <e@80x24.org>; Tue, 20 Sep 2016 19:03:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932981AbcITTDP (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Sep 2016 15:03:15 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33590 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932948AbcITTDH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Sep 2016 15:03:07 -0400
Received: by mail-wm0-f68.google.com with SMTP id w84so4916515wmg.0
        for <git@vger.kernel.org>; Tue, 20 Sep 2016 12:03:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Xe8o0n6wkwl2SLXWCLDefzaV3Ehqonr2syftWbj1+tk=;
        b=AfQppZyo5N79cQ+Gtm2O95CZrDUj9SMSiQCfzigRYyncc8KojbOET3PZwbf16/pNmP
         flm8/9MVwV0gie5XLWFDAK7xzhP1lBipLOnT77NXA02M5MIw8rFEwwDg6Jm3U01Ihl7x
         UZRp/EgSP+kjV8KSK8rY4h8pfCMoxoahi3HnU5e40BYCSPA5x0Ov82QgmfoNV1qCNElj
         Udfhzqdb4Qw4p1FgwKMgZ+WwcP024fgCeqGEb5GGHcFJ2P0uP7GR+RwTMz52/gk2z0NO
         ZcnSZ424qsd4/R7wx1blM967fL/1MPl9Zi44qiBD+Scrwb6nbCI/XO1pJr49aDSRrnPK
         FeqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Xe8o0n6wkwl2SLXWCLDefzaV3Ehqonr2syftWbj1+tk=;
        b=JNHYpREjerSv3hjBwqie0RyvNy0ickgGyR8nTtjAOW98z477Ex0wF2wfS/YpRHnaBe
         NEifuyfXlK/h7E9eNBGi2DSifiyXn335fWtSpQjyrQdnppbOa3RkSlp+BvAK0s002HC8
         IMu7vYFJpLfAs8RNRYdwt6j9GxUgsWfPpRFpqT1YMvQIXo8CMNGRY4JsIk6AQlzBUbDG
         tuQ+37BQwkSc7Cvw9wnsA/+2Rk2BR7/j4ZkD4hiyU+qKaU+Qz3Sm/WiV4fioC34wp+Ib
         4bfEcybcnc67qJ0vSq+z34rz/2YeqtKA7of3K/zDNHS7EnSjwp5MHaFzwMmO21fYYLNs
         uBqQ==
X-Gm-Message-State: AE9vXwN929PrO7TME3NgUKuWj3+wuiLDy9OVMw03bpb3WNx/lUtc8T3L/cTi+ZOeLNuYeA==
X-Received: by 10.28.203.142 with SMTP id b136mr4460779wmg.36.1474398184299;
        Tue, 20 Sep 2016 12:03:04 -0700 (PDT)
Received: from slxBook4.fritz.box (p508BA5EF.dip0.t-ipconnect.de. [80.139.165.239])
        by smtp.gmail.com with ESMTPSA id gg10sm29820728wjd.4.2016.09.20.12.03.02
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Tue, 20 Sep 2016 12:03:03 -0700 (PDT)
From:   larsxschneider@gmail.com
To:     git@vger.kernel.org
Cc:     peff@peff.net, gitster@pobox.com, sbeller@google.com,
        jnareb@gmail.com, mlbright@gmail.com, tboegi@web.de,
        ramsay@ramsayjones.plus.com,
        Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH v8 11/11] convert: add filter.<driver>.process option
Date:   Tue, 20 Sep 2016 21:02:47 +0200
Message-Id: <20160920190247.82189-12-larsxschneider@gmail.com>
X-Mailer: git-send-email 2.10.0
In-Reply-To: <20160920190247.82189-1-larsxschneider@gmail.com>
References: <20160920190247.82189-1-larsxschneider@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Lars Schneider <larsxschneider@gmail.com>

Git's clean/smudge mechanism invokes an external filter process for
every single blob that is affected by a filter. If Git filters a lot of
blobs then the startup time of the external filter processes can become
a significant part of the overall Git execution time.

In a preliminary performance test this developer used a clean/smudge
filter written in golang to filter 12,000 files. This process took 364s
with the existing filter mechanism and 5s with the new mechanism. See
details here: https://github.com/github/git-lfs/pull/1382

This patch adds the `filter.<driver>.process` string option which, if
used, keeps the external filter process running and processes all blobs
with the packet format (pkt-line) based protocol over standard input and
standard output. The full protocol is explained in detail in
`Documentation/gitattributes.txt`.

A few key decisions:

* The long running filter process is referred to as filter protocol
  version 2 because the existing single shot filter invocation is
  considered version 1.
* Git sends a welcome message and expects a response right after the
  external filter process has started. This ensures that Git will not
  hang if a version 1 filter is incorrectly used with the
  filter.<driver>.process option for version 2 filters. In addition,
  Git can detect this kind of error and warn the user.
* The status of a filter operation (e.g. "success" or "error) is set
  before the actual response and (if necessary!) re-set after the
  response. The advantage of this two step status response is that if
  the filter detects an error early, then the filter can communicate
  this and Git does not even need to create structures to read the
  response.
* All status responses are pkt-line lists terminated with a flush
  packet. This allows us to send other status fields with the same
  protocol in the future.

Helped-by: Martin-Louis Bright <mlbright@gmail.com>
Reviewed-by: Jakub Narebski <jnareb@gmail.com>
Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
---
 Documentation/gitattributes.txt        | 156 +++++++++++++-
 contrib/long-running-filter/example.pl | 123 +++++++++++
 convert.c                              | 348 ++++++++++++++++++++++++++++---
 pkt-line.h                             |   1 +
 t/t0021-conversion.sh                  | 365 ++++++++++++++++++++++++++++++++-
 t/t0021/rot13-filter.pl                | 191 +++++++++++++++++
 6 files changed, 1153 insertions(+), 31 deletions(-)
 create mode 100755 contrib/long-running-filter/example.pl
 create mode 100755 t/t0021/rot13-filter.pl

diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
index 7aff940..946dcad 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -293,7 +293,13 @@ checkout, when the `smudge` command is specified, the command is
 fed the blob object from its standard input, and its standard
 output is used to update the worktree file.  Similarly, the
 `clean` command is used to convert the contents of worktree file
-upon checkin.
+upon checkin. By default these commands process only a single
+blob and terminate.  If a long running `process` filter is used
+in place of `clean` and/or `smudge` filters, then Git can process
+all blobs with a single filter command invocation for the entire
+life of a single Git command, for example `git add --all`.  See
+section below for the description of the protocol used to
+communicate with a `process` filter.
 
 One use of the content filtering is to massage the content into a shape
 that is more convenient for the platform, filesystem, and the user to use.
@@ -373,6 +379,154 @@ not exist, or may have different contents. So, smudge and clean commands
 should not try to access the file on disk, but only act as filters on the
 content provided to them on standard input.
 
+Long Running Filter Process
+^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+If the filter command (a string value) is defined via
+`filter.<driver>.process` then Git can process all blobs with a
+single filter invocation for the entire life of a single Git
+command. This is achieved by using a packet format (pkt-line,
+see technical/protocol-common.txt) based protocol over standard
+input and standard output as follows. All packets are considered
+text and therefore are terminated by an LF. Exceptions are the
+"*CONTENT" packets and the flush packet.
+
+Git starts the filter when it encounters the first file
+that needs to be cleaned or smudged. After the filter started
+Git sends a welcome message ("git-filter-client"), a list of
+supported protocol version numbers, and a flush packet. Git expects
+to read a welcome response message ("git-filter-server") and exactly
+one protocol version number from the previously sent list. All further
+communication will be based on the selected version. The remaining
+protocol description below documents "version=2". Please note that
+"version=42" in the example below does not exist and is only there
+to illustrate how the protocol would look like with more than one
+version.
+
+After the version negotiation Git sends a list of supported capabilities
+and a flush packet. Git expects to read a list of desired capabilities,
+which must be a subset of the supported capabilities list, and a flush
+packet as response:
+------------------------
+packet:          git> git-filter-client
+packet:          git> version=2
+packet:          git> version=42
+packet:          git> 0000
+packet:          git< git-filter-server
+packet:          git< version=2
+packet:          git> clean=true
+packet:          git> smudge=true
+packet:          git> not-yet-invented=true
+packet:          git> 0000
+packet:          git< clean=true
+packet:          git< smudge=true
+packet:          git< 0000
+------------------------
+Supported filter capabilities in version 2 are "clean" and
+"smudge".
+
+Afterwards Git sends a list of "key=value" pairs terminated with
+a flush packet. The list will contain at least the filter command
+(based on the supported capabilities) and the pathname of the file
+to filter relative to the repository root. Right after these packets
+Git sends the content split in zero or more pkt-line packets and a
+flush packet to terminate content.
+------------------------
+packet:          git> command=smudge
+packet:          git> pathname=path/testfile.dat
+packet:          git> 0000
+packet:          git> CONTENT
+packet:          git> 0000
+------------------------
+
+The filter is expected to respond with a list of "key=value" pairs
+terminated with a flush packet. If the filter does not experience
+problems then the list must contain a "success" status. Right after
+these packets the filter is expected to send the content in zero
+or more pkt-line packets and a flush packet at the end. Finally, a
+second list of "key=value" pairs terminated with a flush packet
+is expected. The filter can change the status in the second list.
+------------------------
+packet:          git< status=success
+packet:          git< 0000
+packet:          git< SMUDGED_CONTENT
+packet:          git< 0000
+packet:          git< 0000  # empty list!
+------------------------
+
+If the result content is empty then the filter is expected to respond
+with a success status and an empty list.
+------------------------
+packet:          git< status=success
+packet:          git< 0000
+packet:          git< 0000  # empty content!
+packet:          git< 0000  # empty list!
+------------------------
+
+In case the filter cannot or does not want to process the content,
+it is expected to respond with an "error" status. Depending on the
+`filter.<driver>.required` flag Git will interpret that as error
+but it will not stop or restart the filter process.
+------------------------
+packet:          git< status=error
+packet:          git< 0000
+------------------------
+
+If the filter experiences an error during processing, then it can
+send the status "error" after the content was (partially or
+completely) sent. Depending on the `filter.<driver>.required` flag
+Git will interpret that as error but it will not stop or restart the
+filter process.
+------------------------
+packet:          git< status=success
+packet:          git< 0000
+packet:          git< HALF_WRITTEN_ERRONEOUS_CONTENT
+packet:          git< 0000
+packet:          git< status=error
+packet:          git< 0000
+------------------------
+
+If the filter dies during the communication or does not adhere to
+the protocol then Git will stop the filter process and restart it
+with the next file that needs to be processed. Depending on the
+`filter.<driver>.required` flag Git will interpret that as error.
+
+The error handling for all cases above mimic the behavior of
+the `filter.<driver>.clean` / `filter.<driver>.smudge` error
+handling.
+
+In case the filter cannot or does not want to process the content
+as well as any future content for the lifetime of the Git process,
+it is expected to respond with an "abort" status. Depending on
+the `filter.<driver>.required` flag Git will interpret that as error
+for the content as well as any future content for the lifetime of the
+Git process but it will not stop or restart the filter process.
+------------------------
+packet:          git< status=abort
+packet:          git< 0000
+------------------------
+
+After the filter has processed a blob it is expected to wait for
+the next "key=value" list containing a command. Git will close
+the command pipe on exit. The filter is expected to detect EOF
+and exit gracefully on its own.
+
+A long running filter demo implementation can be found in
+`contrib/long-running-filter/example.pl` located in the Git
+core repository. If you develop your own long running filter
+process then the `GIT_TRACE_PACKET` environment variables can be
+very helpful for debugging (see linkgit:git[1]).
+
+If a `filter.<driver>.process` command is configured then it
+always takes precedence over a configured `filter.<driver>.clean`
+or `filter.<driver>.smudge` command.
+
+Please note that you cannot use an existing `filter.<driver>.clean`
+or `filter.<driver>.smudge` command with `filter.<driver>.process`
+because the former two use a different inter process communication
+protocol than the latter one.
+
+
 Interaction between checkin/checkout attributes
 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
 
diff --git a/contrib/long-running-filter/example.pl b/contrib/long-running-filter/example.pl
new file mode 100755
index 0000000..c13a631
--- /dev/null
+++ b/contrib/long-running-filter/example.pl
@@ -0,0 +1,123 @@
+#!/usr/bin/perl
+#
+# Example implementation for the Git filter protocol version 2
+# See Documentation/gitattributes.txt, section "Filter Protocol"
+#
+
+use strict;
+use warnings;
+
+my $MAX_PACKET_CONTENT_SIZE = 65516;
+
+sub packet_bin_read {
+    my $buffer;
+    my $bytes_read = read STDIN, $buffer, 4;
+    if ( $bytes_read == 0 ) {
+
+        # EOF - Git stopped talking to us!
+        exit();
+    }
+    elsif ( $bytes_read != 4 ) {
+        die "invalid packet size '$bytes_read' field";
+    }
+    my $pkt_size = hex($buffer);
+    if ( $pkt_size == 0 ) {
+        return ( 1, "" );
+    }
+    elsif ( $pkt_size > 4 ) {
+        my $content_size = $pkt_size - 4;
+        $bytes_read = read STDIN, $buffer, $content_size;
+        if ( $bytes_read != $content_size ) {
+            die "invalid packet ($content_size expected; $bytes_read read)";
+        }
+        return ( 0, $buffer );
+    }
+    else {
+        die "invalid packet size";
+    }
+}
+
+sub packet_txt_read {
+    my ( $res, $buf ) = packet_bin_read();
+    unless ( $buf =~ /\n$/ ) {
+        die "A non-binary line SHOULD BE terminated by an LF.";
+    }
+    return ( $res, substr( $buf, 0, -1 ) );
+}
+
+sub packet_bin_write {
+    my ($packet) = @_;
+    print STDOUT sprintf( "%04x", length($packet) + 4 );
+    print STDOUT $packet;
+    STDOUT->flush();
+}
+
+sub packet_txt_write {
+    packet_bin_write( $_[0] . "\n" );
+}
+
+sub packet_flush {
+    print STDOUT sprintf( "%04x", 0 );
+    STDOUT->flush();
+}
+
+( packet_txt_read() eq ( 0, "git-filter-client" ) ) || die "bad initialize";
+( packet_txt_read() eq ( 0, "version=2" ) )         || die "bad version";
+( packet_bin_read() eq ( 1, "" ) )                  || die "bad version end";
+
+packet_txt_write("git-filter-server");
+packet_txt_write("version=2");
+
+( packet_txt_read() eq ( 0, "clean=true" ) )  || die "bad capability";
+( packet_txt_read() eq ( 0, "smudge=true" ) ) || die "bad capability";
+( packet_bin_read() eq ( 1, "" ) )            || die "bad capability end";
+
+packet_txt_write("clean=true");
+packet_txt_write("smudge=true");
+packet_flush();
+
+while (1) {
+    my ($command)  = packet_txt_read() =~ /^command=([^=]+)$/;
+    my ($pathname) = packet_txt_read() =~ /^pathname=([^=]+)$/;
+
+    packet_bin_read();
+
+    my $input = "";
+    {
+        binmode(STDIN);
+        my $buffer;
+        my $done = 0;
+        while ( !$done ) {
+            ( $done, $buffer ) = packet_bin_read();
+            $input .= $buffer;
+        }
+    }
+
+    my $output;
+    if ( $command eq "clean" ) {
+        ### Perform clean here ###
+        $output = $input;
+    }
+    elsif ( $command eq "smudge" ) {
+        ### Perform smudge here ###
+        $output = $input;
+    }
+    else {
+        die "bad command '$command'";
+    }
+
+    packet_txt_write("status=success");
+    packet_flush();
+    while ( length($output) > 0 ) {
+        my $packet = substr( $output, 0, $MAX_PACKET_CONTENT_SIZE );
+        packet_bin_write($packet);
+        if ( length($output) > $MAX_PACKET_CONTENT_SIZE ) {
+            $output = substr( $output, $MAX_PACKET_CONTENT_SIZE );
+        }
+        else {
+            $output = "";
+        }
+    }
+    packet_flush();    # flush content!
+    packet_flush();    # empty list!
+}
diff --git a/convert.c b/convert.c
index 597f561..bd66257 100644
--- a/convert.c
+++ b/convert.c
@@ -3,6 +3,7 @@
 #include "run-command.h"
 #include "quote.h"
 #include "sigchain.h"
+#include "pkt-line.h"
 
 /*
  * convert.c - convert a file when checking it out and checking it in.
@@ -442,7 +443,7 @@ static int filter_buffer_or_fd(int in, int out, void *data)
 	return (write_err || status);
 }
 
-static int apply_filter(const char *path, const char *src, size_t len, int fd,
+static int apply_single_file_filter(const char *path, const char *src, size_t len, int fd,
                         struct strbuf *dst, const char *cmd)
 {
 	/*
@@ -456,12 +457,6 @@ static int apply_filter(const char *path, const char *src, size_t len, int fd,
 	struct async async;
 	struct filter_params params;
 
-	if (!cmd || !*cmd)
-		return 0;
-
-	if (!dst)
-		return 1;
-
 	memset(&async, 0, sizeof(async));
 	async.proc = filter_buffer_or_fd;
 	async.data = &params;
@@ -493,14 +488,317 @@ static int apply_filter(const char *path, const char *src, size_t len, int fd,
 	return !err;
 }
 
+#define CAP_CLEAN    (1u<<0)
+#define CAP_SMUDGE   (1u<<1)
+
+struct cmd2process {
+	struct hashmap_entry ent; /* must be the first member! */
+	unsigned int supported_capabilities;
+	const char *cmd;
+	struct child_process process;
+};
+
+static int cmd_process_map_initialized;
+static struct hashmap cmd_process_map;
+
+static int cmd2process_cmp(const struct cmd2process *e1,
+                           const struct cmd2process *e2,
+                           const void *unused)
+{
+	return strcmp(e1->cmd, e2->cmd);
+}
+
+static struct cmd2process *find_multi_file_filter_entry(struct hashmap *hashmap, const char *cmd)
+{
+	struct cmd2process key;
+	hashmap_entry_init(&key, strhash(cmd));
+	key.cmd = cmd;
+	return hashmap_get(hashmap, &key, NULL);
+}
+
+static void kill_multi_file_filter(struct hashmap *hashmap, struct cmd2process *entry)
+{
+	if (!entry)
+		return;
+	sigchain_push(SIGPIPE, SIG_IGN);
+	/*
+	 * We kill the filter most likely because an error happened already.
+	 * That's why we are not interested in any error code here.
+	 */
+	close(entry->process.in);
+	close(entry->process.out);
+	sigchain_pop(SIGPIPE);
+	finish_command(&entry->process);
+	hashmap_remove(hashmap, entry, NULL);
+	free(entry);
+}
+
+static int packet_write_list(int fd, const char *line, ...)
+{
+	va_list args;
+	int err;
+	va_start(args, line);
+	for (;;) {
+		if (!line)
+			break;
+		if (strlen(line) > PKTLINE_DATA_MAXLEN)
+			return -1;
+		err = packet_write_fmt_gently(fd, "%s\n", line);
+		if (err)
+			return err;
+		line = va_arg(args, const char*);
+	}
+	va_end(args);
+	return packet_flush_gently(fd);
+}
+
+static struct cmd2process *start_multi_file_filter(struct hashmap *hashmap, const char *cmd)
+{
+	int err;
+	struct cmd2process *entry;
+	struct child_process *process;
+	const char *argv[] = { cmd, NULL };
+	struct string_list cap_list = STRING_LIST_INIT_NODUP;
+	char *cap_buf;
+	const char *cap_name;
+
+	entry = xmalloc(sizeof(*entry));
+	hashmap_entry_init(entry, strhash(cmd));
+	entry->cmd = cmd;
+	entry->supported_capabilities = 0;
+	process = &entry->process;
+
+	child_process_init(process);
+	process->argv = argv;
+	process->use_shell = 1;
+	process->in = -1;
+	process->out = -1;
+
+	if (start_command(process)) {
+		error("cannot fork to run external filter '%s'", cmd);
+		kill_multi_file_filter(hashmap, entry);
+		return NULL;
+	}
+
+	sigchain_push(SIGPIPE, SIG_IGN);
+
+	err = packet_write_list(process->in, "git-filter-client", "version=2", NULL);
+	if (err)
+		goto done;
+
+	err = strcmp(packet_read_line(process->out, NULL), "git-filter-server");
+	if (err) {
+		error("external filter '%s' does not support long running filter protocol", cmd);
+		goto done;
+	}
+	err = strcmp(packet_read_line(process->out, NULL), "version=2");
+	if (err)
+		goto done;
+
+	err = packet_write_list(process->in, "clean=true", "smudge=true", NULL);
+
+	for (;;) {
+		cap_buf = packet_read_line(process->out, NULL);
+		if (!cap_buf)
+			break;
+		string_list_split_in_place(&cap_list, cap_buf, '=', 1);
+
+		if (cap_list.nr != 2 || strcmp(cap_list.items[1].string, "true"))
+			continue;
+
+		cap_name = cap_list.items[0].string;
+		if (!strcmp(cap_name, "clean")) {
+			entry->supported_capabilities |= CAP_CLEAN;
+		} else if (!strcmp(cap_name, "smudge")) {
+			entry->supported_capabilities |= CAP_SMUDGE;
+		} else {
+			warning(
+				"external filter '%s' requested unsupported filter capability '%s'",
+				cmd, cap_name
+			);
+		}
+
+		string_list_clear(&cap_list, 0);
+	}
+
+done:
+	sigchain_pop(SIGPIPE);
+
+	if (err || errno == EPIPE) {
+		error("initialization for external filter '%s' failed", cmd);
+		kill_multi_file_filter(hashmap, entry);
+		return NULL;
+	}
+
+	hashmap_add(hashmap, entry);
+	return entry;
+}
+
+static void read_multi_file_filter_values(int fd, struct strbuf *status) {
+	struct strbuf **pair;
+	char *line;
+	for (;;) {
+		line = packet_read_line(fd, NULL);
+		if (!line)
+			break;
+		pair = strbuf_split_str(line, '=', 2);
+		if (pair[0] && pair[0]->len && pair[1]) {
+			if (!strcmp(pair[0]->buf, "status=")) {
+				strbuf_reset(status);
+				strbuf_addbuf(status, pair[1]);
+			}
+		}
+	}
+}
+
+static int apply_multi_file_filter(const char *path, const char *src, size_t len,
+                                   int fd, struct strbuf *dst, const char *cmd,
+                                   const unsigned int wanted_capability)
+{
+	int err;
+	struct cmd2process *entry;
+	struct child_process *process;
+	struct stat file_stat;
+	struct strbuf nbuf = STRBUF_INIT;
+	struct strbuf filter_status = STRBUF_INIT;
+	char *filter_type;
+
+	if (!cmd_process_map_initialized) {
+		cmd_process_map_initialized = 1;
+		hashmap_init(&cmd_process_map, (hashmap_cmp_fn) cmd2process_cmp, 0);
+		entry = NULL;
+	} else {
+		entry = find_multi_file_filter_entry(&cmd_process_map, cmd);
+	}
+
+	fflush(NULL);
+
+	if (!entry) {
+		entry = start_multi_file_filter(&cmd_process_map, cmd);
+		if (!entry)
+			return 0;
+	}
+	process = &entry->process;
+
+	if (!(wanted_capability & entry->supported_capabilities))
+		return 0;
+
+	if (CAP_CLEAN & wanted_capability)
+		filter_type = "clean";
+	else if (CAP_SMUDGE & wanted_capability)
+		filter_type = "smudge";
+	else
+		die("unexpected filter type");
+
+	if (fd >= 0 && !src) {
+		if (fstat(fd, &file_stat) == -1)
+			return 0;
+		len = xsize_t(file_stat.st_size);
+	}
+
+	sigchain_push(SIGPIPE, SIG_IGN);
+
+	err = strlen(filter_type) > PKTLINE_DATA_MAXLEN;
+	if (err)
+		goto done;
+
+	err = packet_write_fmt_gently(process->in, "command=%s\n", filter_type);
+	if (err)
+		goto done;
+
+	err = strlen(path) > PKTLINE_DATA_MAXLEN;
+	if (err)
+		goto done;
+
+	err = packet_write_fmt_gently(process->in, "pathname=%s\n", path);
+	if (err)
+		goto done;
+
+	err = packet_flush_gently(process->in);
+	if (err)
+		goto done;
+
+	if (fd >= 0)
+		err = write_packetized_from_fd(fd, process->in);
+	else
+		err = write_packetized_from_buf(src, len, process->in);
+	if (err)
+		goto done;
+
+	read_multi_file_filter_values(process->out, &filter_status);
+	err = strcmp(filter_status.buf, "success");
+	if (err)
+		goto done;
+
+	err = read_packetized_to_buf(process->out, &nbuf) < 0;
+	if (err)
+		goto done;
+
+	read_multi_file_filter_values(process->out, &filter_status);
+	err = strcmp(filter_status.buf, "success");
+
+done:
+	sigchain_pop(SIGPIPE);
+
+	if (err || errno == EPIPE) {
+		if (!strcmp(filter_status.buf, "error")) {
+			/* The filter signaled a problem with the file. */
+		} else if (!strcmp(filter_status.buf, "abort")) {
+			/*
+			 * The filter signaled a permanent problem. Don't try to filter
+			 * files with the same command for the lifetime of the current
+			 * Git process.
+			 */
+			 entry->supported_capabilities &= ~wanted_capability;
+		} else {
+			/*
+			 * Something went wrong with the protocol filter.
+			 * Force shutdown and restart if another blob requires filtering!
+			 */
+			error("external filter '%s' failed", cmd);
+			kill_multi_file_filter(&cmd_process_map, entry);
+		}
+	} else {
+		strbuf_swap(dst, &nbuf);
+	}
+	strbuf_release(&nbuf);
+	return !err;
+}
+
 static struct convert_driver {
 	const char *name;
 	struct convert_driver *next;
 	const char *smudge;
 	const char *clean;
+	const char *process;
 	int required;
 } *user_convert, **user_convert_tail;
 
+static int apply_filter(const char *path, const char *src, size_t len,
+                        int fd, struct strbuf *dst, struct convert_driver *drv,
+                        const unsigned int wanted_capability)
+{
+	const char *cmd = NULL;
+
+	if (!drv)
+		return 0;
+
+	if (!dst)
+		return 1;
+
+	if (!drv->process && (CAP_CLEAN & wanted_capability) && drv->clean)
+		cmd = drv->clean;
+	else if (!drv->process && (CAP_SMUDGE & wanted_capability) && drv->smudge)
+		cmd = drv->smudge;
+
+	if (cmd && *cmd)
+		return apply_single_file_filter(path, src, len, fd, dst, cmd);
+	else if (drv->process && *drv->process)
+		return apply_multi_file_filter(path, src, len, fd, dst, drv->process, wanted_capability);
+
+	return 0;
+}
+
 static int read_convert_config(const char *var, const char *value, void *cb)
 {
 	const char *key, *name;
@@ -538,6 +836,9 @@ static int read_convert_config(const char *var, const char *value, void *cb)
 	if (!strcmp("clean", key))
 		return git_config_string(&drv->clean, var, value);
 
+	if (!strcmp("process", key))
+		return git_config_string(&drv->process, var, value);
+
 	if (!strcmp("required", key)) {
 		drv->required = git_config_bool(var, value);
 		return 0;
@@ -839,7 +1140,7 @@ int would_convert_to_git_filter_fd(const char *path)
 	if (!ca.drv->required)
 		return 0;
 
-	return apply_filter(path, NULL, 0, -1, NULL, ca.drv->clean);
+	return apply_filter(path, NULL, 0, -1, NULL, ca.drv, CAP_CLEAN);
 }
 
 const char *get_convert_attr_ascii(const char *path)
@@ -872,18 +1173,12 @@ int convert_to_git(const char *path, const char *src, size_t len,
                    struct strbuf *dst, enum safe_crlf checksafe)
 {
 	int ret = 0;
-	const char *filter = NULL;
-	int required = 0;
 	struct conv_attrs ca;
 
 	convert_attrs(&ca, path);
-	if (ca.drv) {
-		filter = ca.drv->clean;
-		required = ca.drv->required;
-	}
 
-	ret |= apply_filter(path, src, len, -1, dst, filter);
-	if (!ret && required)
+	ret |= apply_filter(path, src, len, -1, dst, ca.drv, CAP_CLEAN);
+	if (!ret && ca.drv && ca.drv->required)
 		die("%s: clean filter '%s' failed", path, ca.drv->name);
 
 	if (ret && dst) {
@@ -905,9 +1200,9 @@ void convert_to_git_filter_fd(const char *path, int fd, struct strbuf *dst,
 	convert_attrs(&ca, path);
 
 	assert(ca.drv);
-	assert(ca.drv->clean);
+	assert(ca.drv->clean || ca.drv->process);
 
-	if (!apply_filter(path, NULL, 0, fd, dst, ca.drv->clean))
+	if (!apply_filter(path, NULL, 0, fd, dst, ca.drv, CAP_CLEAN))
 		die("%s: clean filter '%s' failed", path, ca.drv->name);
 
 	crlf_to_git(path, dst->buf, dst->len, dst, ca.crlf_action, checksafe);
@@ -919,15 +1214,9 @@ static int convert_to_working_tree_internal(const char *path, const char *src,
 					    int normalizing)
 {
 	int ret = 0, ret_filter = 0;
-	const char *filter = NULL;
-	int required = 0;
 	struct conv_attrs ca;
 
 	convert_attrs(&ca, path);
-	if (ca.drv) {
-		filter = ca.drv->smudge;
-		required = ca.drv->required;
-	}
 
 	ret |= ident_to_worktree(path, src, len, dst, ca.ident);
 	if (ret) {
@@ -936,9 +1225,10 @@ static int convert_to_working_tree_internal(const char *path, const char *src,
 	}
 	/*
 	 * CRLF conversion can be skipped if normalizing, unless there
-	 * is a smudge filter.  The filter might expect CRLFs.
+	 * is a smudge or process filter (even if the process filter doesn't
+	 * support smudge).  The filters might expect CRLFs.
 	 */
-	if (filter || !normalizing) {
+	if ((ca.drv && (ca.drv->smudge || ca.drv->process)) || !normalizing) {
 		ret |= crlf_to_worktree(path, src, len, dst, ca.crlf_action);
 		if (ret) {
 			src = dst->buf;
@@ -946,8 +1236,8 @@ static int convert_to_working_tree_internal(const char *path, const char *src,
 		}
 	}
 
-	ret_filter = apply_filter(path, src, len, -1, dst, filter);
-	if (!ret_filter && required)
+	ret_filter = apply_filter(path, src, len, -1, dst, ca.drv, CAP_SMUDGE);
+	if (!ret_filter && ca.drv && ca.drv->required)
 		die("%s: smudge filter %s failed", path, ca.drv->name);
 
 	return ret | ret_filter;
@@ -1399,7 +1689,7 @@ struct stream_filter *get_stream_filter(const char *path, const unsigned char *s
 	struct stream_filter *filter = NULL;
 
 	convert_attrs(&ca, path);
-	if (ca.drv && (ca.drv->smudge || ca.drv->clean))
+	if (ca.drv && (ca.drv->process || ca.drv->smudge || ca.drv->clean))
 		return NULL;
 
 	if (ca.crlf_action == CRLF_AUTO || ca.crlf_action == CRLF_AUTO_CRLF)
diff --git a/pkt-line.h b/pkt-line.h
index 6df8449..3d873f3 100644
--- a/pkt-line.h
+++ b/pkt-line.h
@@ -86,6 +86,7 @@ ssize_t read_packetized_to_buf(int fd_in, struct strbuf *sb_out);
 
 #define DEFAULT_PACKET_MAX 1000
 #define LARGE_PACKET_MAX 65520
+#define PKTLINE_DATA_MAXLEN (LARGE_PACKET_MAX - 4)
 extern char packet_buffer[LARGE_PACKET_MAX];
 
 #endif
diff --git a/t/t0021-conversion.sh b/t/t0021-conversion.sh
index dc50938..210c4f6 100755
--- a/t/t0021-conversion.sh
+++ b/t/t0021-conversion.sh
@@ -31,7 +31,10 @@ test_expect_success setup '
 	cat test >test.i &&
 	git add test test.t test.i &&
 	rm -f test test.t test.i &&
-	git checkout -- test test.t test.i
+	git checkout -- test test.t test.i &&
+
+	echo "content-test2" >test2.o &&
+	echo "content-test3 - subdir" >"test3 - subdir.o"
 '
 
 script='s/^\$Id: \([0-9a-f]*\) \$/\1/p'
@@ -279,4 +282,364 @@ test_expect_success 'diff does not reuse worktree files that need cleaning' '
 	test_line_count = 0 count
 '
 
+check_filter () {
+	rm -f rot13-filter.log actual.log &&
+	"$@" 2> git_stderr.log &&
+	test_must_be_empty git_stderr.log &&
+	cat >expected.log &&
+	sort rot13-filter.log | uniq -c | sed "s/^[ ]*//" >actual.log &&
+	test_cmp expected.log actual.log
+}
+
+check_filter_count_clean () {
+	rm -f rot13-filter.log actual.log &&
+	"$@" 2> git_stderr.log &&
+	test_must_be_empty git_stderr.log &&
+	cat >expected.log &&
+	sort rot13-filter.log | uniq -c | sed "s/^[ ]*//" |
+		sed "s/^\([0-9]\) IN: clean/x IN: clean/" >actual.log &&
+	test_cmp expected.log actual.log
+}
+
+check_filter_ignore_clean () {
+	rm -f rot13-filter.log actual.log &&
+	"$@" &&
+	cat >expected.log &&
+	grep -v "IN: clean" rot13-filter.log >actual.log &&
+	test_cmp expected.log actual.log
+}
+
+check_filter_no_call () {
+	rm -f rot13-filter.log &&
+	"$@" 2> git_stderr.log &&
+	test_must_be_empty git_stderr.log &&
+	test_must_be_empty rot13-filter.log
+}
+
+check_rot13 () {
+	test_cmp "$1" "$2" &&
+	./../rot13.sh <"$1" >expected &&
+	git cat-file blob :"$2" >actual &&
+	test_cmp expected actual
+}
+
+test_expect_success PERL 'required process filter should filter data' '
+	test_config_global filter.protocol.process "$TEST_DIRECTORY/t0021/rot13-filter.pl clean smudge" &&
+	test_config_global filter.protocol.required true &&
+	rm -rf repo &&
+	mkdir repo &&
+	(
+		cd repo &&
+		git init &&
+
+		echo "*.r filter=protocol" >.gitattributes &&
+		git add . &&
+		git commit . -m "test commit" &&
+		git branch empty &&
+
+		cp ../test.o test.r &&
+		cp ../test2.o test2.r &&
+		mkdir testsubdir &&
+		cp "../test3 - subdir.o" "testsubdir/test3 - subdir.r" &&
+		>test4-empty.r &&
+
+		check_filter \
+			git add . \
+				<<-\EOF &&
+					1 IN: clean test.r 57 [OK] -- OUT: 57 . [OK]
+					1 IN: clean test2.r 14 [OK] -- OUT: 14 . [OK]
+					1 IN: clean test4-empty.r 0 [OK] -- OUT: 0  [OK]
+					1 IN: clean testsubdir/test3 - subdir.r 23 [OK] -- OUT: 23 . [OK]
+					1 START
+					1 STOP
+					1 wrote filter header
+				EOF
+
+		check_filter_count_clean \
+			git commit . -m "test commit" \
+				<<-\EOF &&
+					x IN: clean test.r 57 [OK] -- OUT: 57 . [OK]
+					x IN: clean test2.r 14 [OK] -- OUT: 14 . [OK]
+					x IN: clean test4-empty.r 0 [OK] -- OUT: 0  [OK]
+					x IN: clean testsubdir/test3 - subdir.r 23 [OK] -- OUT: 23 . [OK]
+					1 START
+					1 STOP
+					1 wrote filter header
+				EOF
+
+		rm -f test?.r "testsubdir/test3 - subdir.r" &&
+
+		check_filter_ignore_clean \
+			git checkout . \
+				<<-\EOF &&
+					START
+					wrote filter header
+					IN: smudge test2.r 14 [OK] -- OUT: 14 . [OK]
+					IN: smudge testsubdir/test3 - subdir.r 23 [OK] -- OUT: 23 . [OK]
+					STOP
+				EOF
+
+		check_filter_ignore_clean \
+			git checkout empty \
+				<<-\EOF &&
+					START
+					wrote filter header
+					STOP
+				EOF
+
+		check_filter_ignore_clean \
+			git checkout master \
+				<<-\EOF &&
+					START
+					wrote filter header
+					IN: smudge test.r 57 [OK] -- OUT: 57 . [OK]
+					IN: smudge test2.r 14 [OK] -- OUT: 14 . [OK]
+					IN: smudge test4-empty.r 0 [OK] -- OUT: 0  [OK]
+					IN: smudge testsubdir/test3 - subdir.r 23 [OK] -- OUT: 23 . [OK]
+					STOP
+				EOF
+
+		check_rot13 ../test.o test.r &&
+		check_rot13 ../test2.o test2.r &&
+		check_rot13 "../test3 - subdir.o" "testsubdir/test3 - subdir.r"
+	)
+'
+
+test_expect_success PERL 'required process filter should clean only and take precedence' '
+	test_config_global filter.protocol.clean ./../rot13.sh &&
+	test_config_global filter.protocol.process "$TEST_DIRECTORY/t0021/rot13-filter.pl clean" &&
+	test_config_global filter.protocol.required true &&
+	rm -rf repo &&
+	mkdir repo &&
+	(
+		cd repo &&
+		git init &&
+
+		echo "*.r filter=protocol" >.gitattributes &&
+		git add . &&
+		git commit . -m "test commit" &&
+		git branch empty &&
+
+		cp ../test.o test.r &&
+
+		check_filter \
+			git add . \
+				<<-\EOF &&
+					1 IN: clean test.r 57 [OK] -- OUT: 57 . [OK]
+					1 START
+					1 STOP
+					1 wrote filter header
+				EOF
+
+		check_filter_count_clean \
+			git commit . -m "test commit" \
+				<<-\EOF
+					x IN: clean test.r 57 [OK] -- OUT: 57 . [OK]
+					1 START
+					1 STOP
+					1 wrote filter header
+				EOF
+	)
+'
+
+generate_test_data () {
+	LEN=$1
+	NAME=$2
+	test-genrandom end $LEN |
+		perl -pe "s/./chr((ord($&) % 26) + 97)/sge" >../$NAME.file &&
+	cp ../$NAME.file . &&
+	./../rot13.sh <../$NAME.file >../$NAME.file.rot13
+}
+
+test_expect_success PERL 'required process filter should process multiple packets' '
+	test_config_global filter.protocol.process "$TEST_DIRECTORY/t0021/rot13-filter.pl clean smudge" &&
+	test_config_global filter.protocol.required true &&
+
+	rm -rf repo &&
+	mkdir repo &&
+	(
+		cd repo &&
+		git init &&
+
+		# Generate data that requires 3 packets
+		PKTLINE_DATA_MAXLEN=65516 &&
+
+		generate_test_data $(($PKTLINE_DATA_MAXLEN        )) 1pkt_1__ &&
+		generate_test_data $(($PKTLINE_DATA_MAXLEN     + 1)) 2pkt_1+1 &&
+		generate_test_data $(($PKTLINE_DATA_MAXLEN * 2 - 1)) 2pkt_2-1 &&
+		generate_test_data $(($PKTLINE_DATA_MAXLEN * 2    )) 2pkt_2__ &&
+		generate_test_data $(($PKTLINE_DATA_MAXLEN * 2 + 1)) 3pkt_2+1 &&
+
+		echo "*.file filter=protocol" >.gitattributes &&
+		check_filter \
+			git add *.file .gitattributes \
+				<<-\EOF &&
+					1 IN: clean 1pkt_1__.file 65516 [OK] -- OUT: 65516 . [OK]
+					1 IN: clean 2pkt_1+1.file 65517 [OK] -- OUT: 65517 .. [OK]
+					1 IN: clean 2pkt_2-1.file 131031 [OK] -- OUT: 131031 .. [OK]
+					1 IN: clean 2pkt_2__.file 131032 [OK] -- OUT: 131032 .. [OK]
+					1 IN: clean 3pkt_2+1.file 131033 [OK] -- OUT: 131033 ... [OK]
+					1 START
+					1 STOP
+					1 wrote filter header
+				EOF
+		git commit . -m "test commit" &&
+
+		rm -f *.file &&
+		git checkout -- *.file &&
+
+		for f in *.file
+		do
+			git cat-file blob :$f >actual &&
+			test_cmp ../$f.rot13 actual
+		done
+	)
+'
+
+test_expect_success PERL 'required process filter should with clean error should fail' '
+	test_config_global filter.protocol.process "$TEST_DIRECTORY/t0021/rot13-filter.pl clean smudge" &&
+	test_config_global filter.protocol.required true &&
+	rm -rf repo &&
+	mkdir repo &&
+	(
+		cd repo &&
+		git init &&
+
+		echo "*.r filter=protocol" >.gitattributes &&
+
+		cp ../test.o test.r &&
+		echo "this is going to fail" >clean-write-fail.r &&
+		echo "content-test3-subdir" >test3.r &&
+
+		# Note: There are three clean paths in convert.c we just test one here.
+		test_must_fail git add .
+	)
+'
+
+test_expect_success PERL 'process filter should restart after unexpected write failure' '
+	test_config_global filter.protocol.process "$TEST_DIRECTORY/t0021/rot13-filter.pl clean smudge" &&
+	rm -rf repo &&
+	mkdir repo &&
+	(
+		cd repo &&
+		git init &&
+
+		echo "*.r filter=protocol" >.gitattributes &&
+
+		cp ../test.o test.r &&
+		cp ../test2.o test2.r &&
+		echo "this is going to fail" >smudge-write-fail.o &&
+		cat smudge-write-fail.o >smudge-write-fail.r &&
+		git add . &&
+		git commit . -m "test commit" &&
+		rm -f *.r &&
+
+		check_filter_ignore_clean \
+			git checkout . \
+				<<-\EOF &&
+					START
+					wrote filter header
+					IN: smudge smudge-write-fail.r 22 [OK] -- OUT: 22 [WRITE FAIL]
+					START
+					wrote filter header
+					IN: smudge test.r 57 [OK] -- OUT: 57 . [OK]
+					IN: smudge test2.r 14 [OK] -- OUT: 14 . [OK]
+					STOP
+				EOF
+
+		check_rot13 ../test.o test.r &&
+		check_rot13 ../test2.o test2.r &&
+
+		! test_cmp smudge-write-fail.o smudge-write-fail.r && # Smudge failed!
+		./../rot13.sh <smudge-write-fail.o >expected &&
+		git cat-file blob :smudge-write-fail.r >actual &&
+		test_cmp expected actual							  # Clean worked!
+	)
+'
+
+test_expect_success PERL 'process filter should not restart in case of an error' '
+	test_config_global filter.protocol.process "$TEST_DIRECTORY/t0021/rot13-filter.pl clean smudge" &&
+	rm -rf repo &&
+	mkdir repo &&
+	(
+		cd repo &&
+		git init &&
+
+		echo "*.r filter=protocol" >.gitattributes &&
+
+		cp ../test.o test.r &&
+		cp ../test2.o test2.r &&
+		echo "this will cause an error" >error.o &&
+		cp error.o error.r &&
+		git add . &&
+		git commit . -m "test commit" &&
+		rm -f *.r &&
+
+		check_filter_ignore_clean \
+			git checkout . \
+				<<-\EOF &&
+					START
+					wrote filter header
+					IN: smudge error.r 25 [OK] -- OUT: 0 [ERROR]
+					IN: smudge test.r 57 [OK] -- OUT: 57 . [OK]
+					IN: smudge test2.r 14 [OK] -- OUT: 14 . [OK]
+					STOP
+				EOF
+
+		check_rot13 ../test.o test.r &&
+		check_rot13 ../test2.o test2.r &&
+		test_cmp error.o error.r
+	)
+'
+
+test_expect_success PERL 'process filter should be able to signal an error for all future files' '
+	test_config_global filter.protocol.process "$TEST_DIRECTORY/t0021/rot13-filter.pl clean smudge" &&
+	rm -rf repo &&
+	mkdir repo &&
+	(
+		cd repo &&
+		git init &&
+
+		echo "*.r filter=protocol" >.gitattributes &&
+
+		cp ../test.o test.r &&
+		cp ../test2.o test2.r &&
+		echo "error this blob and all future blobs" >abort.o &&
+		cp abort.o abort.r &&
+		git add . &&
+		git commit . -m "test commit" &&
+		rm -f *.r &&
+
+		check_filter_ignore_clean \
+			git checkout . \
+				<<-\EOF &&
+					START
+					wrote filter header
+					IN: smudge abort.r 37 [OK] -- OUT: 0 [ABORT]
+					STOP
+				EOF
+
+		test_cmp ../test.o test.r &&
+		test_cmp ../test2.o test2.r &&
+		test_cmp abort.o abort.r
+	)
+'
+
+test_expect_success PERL 'invalid process filter must fail (and not hang!)' '
+	test_config_global filter.protocol.process cat &&
+	test_config_global filter.protocol.required true &&
+	rm -rf repo &&
+	mkdir repo &&
+	(
+		cd repo &&
+		git init &&
+
+		echo "*.r filter=protocol" >.gitattributes &&
+
+		cp ../test.o test.r &&
+		test_must_fail git add . 2> git_stderr.log &&
+		grep "not support long running filter protocol" git_stderr.log
+	)
+'
+
 test_done
diff --git a/t/t0021/rot13-filter.pl b/t/t0021/rot13-filter.pl
new file mode 100755
index 0000000..8958f71
--- /dev/null
+++ b/t/t0021/rot13-filter.pl
@@ -0,0 +1,191 @@
+#!/usr/bin/perl
+#
+# Example implementation for the Git filter protocol version 2
+# See Documentation/gitattributes.txt, section "Filter Protocol"
+#
+# The script takes the list of supported protocol capabilities as
+# arguments ("clean", "smudge", etc).
+#
+# This implementation supports special test cases:
+# (1) If data with the pathname "clean-write-fail.r" is processed with
+#     a "clean" operation then the write operation will die.
+# (2) If data with the pathname "smudge-write-fail.r" is processed with
+#     a "smudge" operation then the write operation will die.
+# (3) If data with the pathname "error.r" is processed with any
+#     operation then the filter signals that it cannot or does not want
+#     to process the file.
+# (4) If data with the pathname "abort.r" is processed with any
+#     operation then the filter signals that it cannot or does not want
+#     to process the file and any file after that is processed with the
+#     same command.
+#
+
+use strict;
+use warnings;
+
+my $MAX_PACKET_CONTENT_SIZE = 65516;
+my @capabilities            = @ARGV;
+
+open my $debug, ">>", "rot13-filter.log";
+
+sub rot13 {
+    my ($str) = @_;
+    $str =~ y/A-Za-z/N-ZA-Mn-za-m/;
+    return $str;
+}
+
+sub packet_bin_read {
+    my $buffer;
+    my $bytes_read = read STDIN, $buffer, 4;
+    if ( $bytes_read == 0 ) {
+
+        # EOF - Git stopped talking to us!
+        print $debug "STOP\n";
+        exit();
+    }
+    elsif ( $bytes_read != 4 ) {
+        die "invalid packet size '$bytes_read' field";
+    }
+    my $pkt_size = hex($buffer);
+    if ( $pkt_size == 0 ) {
+        return ( 1, "" );
+    }
+    elsif ( $pkt_size > 4 ) {
+        my $content_size = $pkt_size - 4;
+        $bytes_read = read STDIN, $buffer, $content_size;
+        if ( $bytes_read != $content_size ) {
+            die "invalid packet ($content_size expected; $bytes_read read)";
+        }
+        return ( 0, $buffer );
+    }
+    else {
+        die "invalid packet size";
+    }
+}
+
+sub packet_txt_read {
+    my ( $res, $buf ) = packet_bin_read();
+    unless ( $buf =~ /\n$/ ) {
+        die "A non-binary line SHOULD BE terminated by an LF.";
+    }
+    return ( $res, substr( $buf, 0, -1 ) );
+}
+
+sub packet_bin_write {
+    my ($packet) = @_;
+    print STDOUT sprintf( "%04x", length($packet) + 4 );
+    print STDOUT $packet;
+    STDOUT->flush();
+}
+
+sub packet_txt_write {
+    packet_bin_write( $_[0] . "\n" );
+}
+
+sub packet_flush {
+    print STDOUT sprintf( "%04x", 0 );
+    STDOUT->flush();
+}
+
+print $debug "START\n";
+$debug->flush();
+
+( packet_txt_read() eq ( 0, "git-filter-client" ) ) || die "bad initialize";
+( packet_txt_read() eq ( 0, "version=2" ) )         || die "bad version";
+( packet_bin_read() eq ( 1, "" ) )                  || die "bad version end";
+
+packet_txt_write("git-filter-server");
+packet_txt_write("version=2");
+
+( packet_txt_read() eq ( 0, "clean=true" ) )  || die "bad capability";
+( packet_txt_read() eq ( 0, "smudge=true" ) ) || die "bad capability";
+( packet_bin_read() eq ( 1, "" ) )            || die "bad capability end";
+
+foreach (@capabilities) {
+    packet_txt_write( $_ . "=true" );
+}
+packet_flush();
+print $debug "wrote filter header\n";
+$debug->flush();
+
+while (1) {
+    my ($command) = packet_txt_read() =~ /^command=([^=]+)$/;
+    print $debug "IN: $command";
+    $debug->flush();
+
+    my ($pathname) = packet_txt_read() =~ /^pathname=([^=]+)$/;
+    print $debug " $pathname";
+    $debug->flush();
+
+    # Flush
+    packet_bin_read();
+
+    my $input = "";
+    {
+        binmode(STDIN);
+        my $buffer;
+        my $done = 0;
+        while ( !$done ) {
+            ( $done, $buffer ) = packet_bin_read();
+            $input .= $buffer;
+        }
+        print $debug " " . length($input) . " [OK] -- ";
+        $debug->flush();
+    }
+
+    my $output;
+    if ( $pathname eq "error.r" or $pathname eq "abort.r" ) {
+        $output = "";
+    }
+    elsif ( $command eq "clean" and grep( /^clean$/, @capabilities ) ) {
+        $output = rot13($input);
+    }
+    elsif ( $command eq "smudge" and grep( /^smudge$/, @capabilities ) ) {
+        $output = rot13($input);
+    }
+    else {
+        die "bad command '$command'";
+    }
+
+    print $debug "OUT: " . length($output) . " ";
+    $debug->flush();
+
+    if ( $pathname eq "error.r" ) {
+        print $debug "[ERROR]\n";
+        $debug->flush();
+        packet_txt_write("status=error");
+        packet_flush();
+    }
+    elsif ( $pathname eq "abort.r" ) {
+        print $debug "[ABORT]\n";
+        $debug->flush();
+        packet_txt_write("status=abort");
+        packet_flush();
+    }
+    else {
+        packet_txt_write("status=success");
+        packet_flush();
+
+        if ( $pathname eq "${command}-write-fail.r" ) {
+            print $debug "[WRITE FAIL]\n";
+            $debug->flush();
+            die "${command} write error";
+        }
+
+        while ( length($output) > 0 ) {
+            my $packet = substr( $output, 0, $MAX_PACKET_CONTENT_SIZE );
+            packet_bin_write($packet);
+            print $debug ".";
+            if ( length($output) > $MAX_PACKET_CONTENT_SIZE ) {
+                $output = substr( $output, $MAX_PACKET_CONTENT_SIZE );
+            }
+            else {
+                $output = "";
+            }
+        }
+        packet_flush();
+        print $debug " [OK]\n";
+        $debug->flush();
+        packet_flush();
+    }
+}
-- 
2.10.0

