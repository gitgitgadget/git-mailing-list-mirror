Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A06231F855
	for <e@80x24.org>; Fri, 29 Jul 2016 23:38:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753538AbcG2Xif (ORCPT <rfc822;e@80x24.org>);
	Fri, 29 Jul 2016 19:38:35 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:32993 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753484AbcG2XiU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jul 2016 19:38:20 -0400
Received: by mail-wm0-f67.google.com with SMTP id o80so17701418wme.0
        for <git@vger.kernel.org>; Fri, 29 Jul 2016 16:38:19 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=IxPjNOI5r3tMb6yKysQIoULJboBo062fA0pyEAn2fdo=;
        b=jjgbZbUn78D1KuXAxMgvN4f+4tnwlTynhsTn1QLZRQRTeBIcWbTftgMmbVY2iHL0tr
         /p+SwLiAoNoSqqH26pAwgJzbCq/ZQOT5zIrWL0JolR5cG2M18J/nVLDKQYqqIjdTQXNY
         CICALtzxU9TA6jqG5M2IF+sfodkbAQIKi0+sYGkzxW0nDrd1SCn/CMPLz7/sMfpWo/Z8
         zj7icG2qeqtidvyZ+KQbq1sQGBXnSdNZwB9yESX9t9tdD2uzS6ElF6ct8wixi1ILqsip
         yyfOLEUtV5kvhr2awpfaLZIIQhrLtOG9wB3wHK1T8r0GPDyfNCQ7oabPc8gQcz7LXRNx
         GvMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=IxPjNOI5r3tMb6yKysQIoULJboBo062fA0pyEAn2fdo=;
        b=WRjd5hXE1euZVdStFZvMHTGogKHgeJ7BBp15q1f90scQEigH0p8yGbsIwbPOtqJi44
         +xuAR8X58QjWU0zld48xcsnnxVTT83+9RXq5GlBSBDA9DnqFxvRpvrCaThYEIEPAZYYE
         giF2KdVEcTxiJasE9oFZ8+OhjiZHvyF2lKItroTVDaQDMdx0iG33E+ER9azf5tiDFcSj
         Koyj4pXGF7JPmvC0Dpw0snRAxWrYNd+bMR1zcVo1OfSkqOeeDfUmfjn3ndq5qCZSbsC2
         UdR0+hp+FAgNwS5fWM9GrT5N3gr1qWMagiCVoV6Ik/2qZQWu12dRdiIbUtvNNX4R97uQ
         pOsg==
X-Gm-Message-State: AEkoouvu+4og0Uc0hr2rr6pVqC9OGzVII32rBTqVVfHO2UxMKLsDh/ePytS6IonOpkLffA==
X-Received: by 10.28.22.70 with SMTP id 67mr3514780wmw.52.1469835497660;
        Fri, 29 Jul 2016 16:38:17 -0700 (PDT)
Received: from slxBook4.fritz.box (p5DDB4145.dip0.t-ipconnect.de. [93.219.65.69])
        by smtp.gmail.com with ESMTPSA id i1sm18663212wjl.9.2016.07.29.16.38.16
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Fri, 29 Jul 2016 16:38:17 -0700 (PDT)
From:	larsxschneider@gmail.com
To:	git@vger.kernel.org
Cc:	gitster@pobox.com, jnareb@gmail.com, tboegi@web.de,
	mlbright@gmail.com, e@80x24.org, peff@peff.net,
	Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH v3 10/10] convert: add filter.<driver>.process option
Date:	Sat, 30 Jul 2016 01:38:01 +0200
Message-Id: <20160729233801.82844-11-larsxschneider@gmail.com>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20160729233801.82844-1-larsxschneider@gmail.com>
References: <20160727000605.49982-1-larsxschneider%40gmail.com/>
 <20160729233801.82844-1-larsxschneider@gmail.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

From: Lars Schneider <larsxschneider@gmail.com>

Git's clean/smudge mechanism invokes an external filter process for every
single blob that is affected by a filter. If Git filters a lot of blobs
then the startup time of the external filter processes can become a
significant part of the overall Git execution time.

This patch adds the filter.<driver>.process string option which, if used,
keeps the external filter process running and processes all blobs with
the following packet format (pkt-line) based protocol over standard input
and standard output.

Git starts the filter on first usage and expects a welcome
message, protocol version number, and filter capabilities
separated by spaces:
------------------------
packet:          git< git-filter-protocol\n
packet:          git< version 2\n
packet:          git< capabilities clean smudge\n
------------------------
Supported filter capabilities are "clean", "smudge", "stream",
and "shutdown".

Afterwards Git sends a command (based on the supported
capabilities), the filename including its path
relative to the repository root, the content size as ASCII number
in bytes, the content split in zero or many pkt-line packets,
and a flush packet at the end:
------------------------
packet:          git> smudge\n
packet:          git> filename=path/testfile.dat\n
packet:          git> size=7\n
packet:          git> CONTENT
packet:          git> 0000
------------------------

The filter is expected to respond with the result content size as
ASCII number in bytes. If the capability "stream" is defined then
the filter must not send the content size. Afterwards the result
content in send in zero or many pkt-line packets and a flush packet
at the end. Finally a "success" packet is send to indicate that
everything went well.
------------------------
packet:          git< size=57\n   (omitted with capability "stream")
packet:          git< SMUDGED_CONTENT
packet:          git< 0000
packet:          git< success\n
------------------------

In case the filter cannot process the content, it is expected
to respond with the result content size 0 (only if "stream" is
not defined) and a "reject" packet.
------------------------
packet:          git< size=0\n    (omitted with capability "stream")
packet:          git< reject\n
------------------------

After the filter has processed a blob it is expected to wait for
the next command. A demo implementation can be found in
`t/t0021/rot13-filter.pl` located in the Git core repository.

If the filter supports the "shutdown" capability then Git will
send the "shutdown" command and wait until the filter answers
with "done". This gives the filter the opportunity to perform
cleanup tasks. Afterwards the filter is expected to exit.
------------------------
packet:          git> shutdown\n
packet:          git< done\n
------------------------

If a filter.<driver>.clean or filter.<driver>.smudge command
is configured then these commands always take precedence over
a configured filter.<driver>.process command.

Please note that you cannot use an existing filter.<driver>.clean
or filter.<driver>.smudge command as filter.<driver>.process
command. As soon as Git would detect a file that needs to be
processed by this filter, it would stop responding.

Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
Helped-by: Martin-Louis Bright <mlbright@gmail.com>
---
 Documentation/gitattributes.txt |  84 ++++++++-
 convert.c                       | 400 +++++++++++++++++++++++++++++++++++++--
 t/t0021-conversion.sh           | 405 ++++++++++++++++++++++++++++++++++++++++
 t/t0021/rot13-filter.pl         | 177 ++++++++++++++++++
 4 files changed, 1053 insertions(+), 13 deletions(-)
 create mode 100755 t/t0021/rot13-filter.pl

diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
index 8882a3e..e3fbcc2 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -300,7 +300,11 @@ checkout, when the `smudge` command is specified, the command is
 fed the blob object from its standard input, and its standard
 output is used to update the worktree file.  Similarly, the
 `clean` command is used to convert the contents of worktree file
-upon checkin.
+upon checkin. By default these commands process only a single
+blob and terminate. If a long running filter process (see section
+below) is used then Git can process all blobs with a single filter
+invocation for the entire life of a single Git command (e.g.
+`git add .`).
 
 One use of the content filtering is to massage the content into a shape
 that is more convenient for the platform, filesystem, and the user to use.
@@ -375,6 +379,84 @@ substitution.  For example:
 ------------------------
 
 
+Long Running Filter Process
+^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+If the filter command (string value) is defined via
+filter.<driver>.process then Git can process all blobs with a
+single filter invocation for the entire life of a single Git
+command. This is achieved by using the following packet
+format (pkt-line, see protocol-common.txt) based protocol over
+standard input and standard output.
+
+Git starts the filter on first usage and expects a welcome
+message, protocol version number, and filter capabilities
+separated by spaces:
+------------------------
+packet:          git< git-filter-protocol\n
+packet:          git< version 2\n
+packet:          git< capabilities clean smudge\n
+------------------------
+Supported filter capabilities are "clean", "smudge", "stream",
+and "shutdown".
+
+Afterwards Git sends a command (based on the supported
+capabilities), the filename including its path
+relative to the repository root, the content size as ASCII number
+in bytes, the content split in zero or many pkt-line packets,
+and a flush packet at the end:
+------------------------
+packet:          git> smudge\n
+packet:          git> filename=path/testfile.dat\n
+packet:          git> size=7\n
+packet:          git> CONTENT
+packet:          git> 0000
+------------------------
+
+The filter is expected to respond with the result content size as
+ASCII number in bytes. If the capability "stream" is defined then
+the filter must not send the content size. Afterwards the result
+content in send in zero or many pkt-line packets and a flush packet
+at the end. Finally a "success" packet is send to indicate that
+everything went well.
+------------------------
+packet:          git< size=57\n   (omitted with capability "stream")
+packet:          git< SMUDGED_CONTENT
+packet:          git< 0000
+packet:          git< success\n
+------------------------
+
+In case the filter cannot process the content, it is expected
+to respond with the result content size 0 (only if "stream" is
+not defined) and a "reject" packet.
+------------------------
+packet:          git< size=0\n    (omitted with capability "stream")
+packet:          git< reject\n
+------------------------
+
+After the filter has processed a blob it is expected to wait for
+the next command. A demo implementation can be found in
+`t/t0021/rot13-filter.pl` located in the Git core repository.
+
+If the filter supports the "shutdown" capability then Git will
+send the "shutdown" command and wait until the filter answers
+with "done". This gives the filter the opportunity to perform
+cleanup tasks. Afterwards the filter is expected to exit.
+------------------------
+packet:          git> shutdown\n
+packet:          git< done\n
+------------------------
+
+If a filter.<driver>.clean or filter.<driver>.smudge command
+is configured then these commands always take precedence over
+a configured filter.<driver>.process command.
+
+Please note that you cannot use an existing filter.<driver>.clean
+or filter.<driver>.smudge command as filter.<driver>.process
+command. As soon as Git would detect a file that needs to be
+processed by this filter, it would stop responding.
+
+
 Interaction between checkin/checkout attributes
 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
 
diff --git a/convert.c b/convert.c
index 522e2c5..be6405c 100644
--- a/convert.c
+++ b/convert.c
@@ -3,6 +3,7 @@
 #include "run-command.h"
 #include "quote.h"
 #include "sigchain.h"
+#include "pkt-line.h"
 
 /*
  * convert.c - convert a file when checking it out and checking it in.
@@ -481,11 +482,355 @@ static int apply_filter(const char *path, const char *src, size_t len, int fd,
 	return ret;
 }
 
+static int multi_packet_read(int fd_in, struct strbuf *sb, size_t expected_bytes, int is_stream)
+{
+	int bytes_read;
+	size_t total_bytes_read = 0;
+	if (expected_bytes == 0 && !is_stream)
+		return 0;
+
+	if (is_stream)
+		strbuf_grow(sb, LARGE_PACKET_MAX);           // allocate space for at least one packet
+	else
+		strbuf_grow(sb, st_add(expected_bytes, 1));  // add one extra byte for the packet flush
+
+	do {
+		bytes_read = packet_read(
+			fd_in, NULL, NULL,
+			sb->buf + total_bytes_read, sb->len - total_bytes_read - 1,
+			PACKET_READ_GENTLE_ON_EOF
+		);
+		if (bytes_read < 0)
+			return 1;  // unexpected EOF
+
+		if (is_stream &&
+			bytes_read > 0 &&
+			sb->len - total_bytes_read - 1 <= 0)
+			strbuf_grow(sb, st_add(sb->len, LARGE_PACKET_MAX));
+		total_bytes_read += bytes_read;
+	}
+	while (
+		bytes_read > 0 &&                   // the last packet was no flush
+		sb->len - total_bytes_read - 1 > 0  // we still have space left in the buffer
+	);
+	strbuf_setlen(sb, total_bytes_read);
+	return (is_stream ? 0 : expected_bytes != total_bytes_read);
+}
+
+static int multi_packet_write_from_fd(const int fd_in, const int fd_out)
+{
+	int did_fail = 0;
+	ssize_t bytes_to_write;
+	while (!did_fail) {
+		bytes_to_write = xread(fd_in, PKTLINE_DATA_START(packet_buffer), PKTLINE_DATA_LEN);
+		if (bytes_to_write < 0)
+			return 1;
+		if (bytes_to_write == 0)
+			break;
+		did_fail |= direct_packet_write(fd_out, packet_buffer, PKTLINE_HEADER_LEN + bytes_to_write, 1);
+	}
+	if (!did_fail)
+		did_fail = packet_flush_gentle(fd_out);
+	return did_fail;
+}
+
+static int multi_packet_write_from_buf(const char *src, size_t len, int fd_out)
+{
+	int did_fail = 0;
+	size_t bytes_written = 0;
+	size_t bytes_to_write;
+	while (!did_fail) {
+		if ((len - bytes_written) > PKTLINE_DATA_LEN)
+			bytes_to_write = PKTLINE_DATA_LEN;
+		else
+			bytes_to_write = len - bytes_written;
+		if (bytes_to_write == 0)
+			break;
+		did_fail |= direct_packet_write_data(fd_out, src + bytes_written, bytes_to_write, 1);
+		bytes_written += bytes_to_write;
+	}
+	if (!did_fail)
+		did_fail = packet_flush_gentle(fd_out);
+	return did_fail;
+}
+
+#define FILTER_CAPABILITIES_STREAM   0x1
+#define FILTER_CAPABILITIES_CLEAN    0x2
+#define FILTER_CAPABILITIES_SMUDGE   0x4
+#define FILTER_CAPABILITIES_SHUTDOWN 0x8
+#define FILTER_SUPPORTS_STREAM(type) ((type) & FILTER_CAPABILITIES_STREAM)
+#define FILTER_SUPPORTS_CLEAN(type)  ((type) & FILTER_CAPABILITIES_CLEAN)
+#define FILTER_SUPPORTS_SMUDGE(type) ((type) & FILTER_CAPABILITIES_SMUDGE)
+#define FILTER_SUPPORTS_SHUTDOWN(type) ((type) & FILTER_CAPABILITIES_SHUTDOWN)
+
+struct cmd2process {
+	struct hashmap_entry ent; /* must be the first member! */
+	const char *cmd;
+	int supported_capabilities;
+	struct child_process process;
+};
+
+static int cmd_process_map_initialized = 0;
+static struct hashmap cmd_process_map;
+
+static int cmd2process_cmp(const struct cmd2process *e1,
+							const struct cmd2process *e2,
+							const void *unused)
+{
+	return strcmp(e1->cmd, e2->cmd);
+}
+
+static struct cmd2process *find_protocol2_filter_entry(struct hashmap *hashmap, const char *cmd)
+{
+	struct cmd2process k;
+	hashmap_entry_init(&k, strhash(cmd));
+	k.cmd = cmd;
+	return hashmap_get(hashmap, &k, NULL);
+}
+
+static void kill_protocol2_filter(struct hashmap *hashmap, struct cmd2process *entry) {
+	if (!entry)
+		return;
+	sigchain_push(SIGPIPE, SIG_IGN);
+	close(entry->process.in);
+	close(entry->process.out);
+	sigchain_pop(SIGPIPE);
+	finish_command(&entry->process);
+	child_process_clear(&entry->process);
+	hashmap_remove(hashmap, entry, NULL);
+	free(entry);
+}
+
+void shutdown_protocol2_filter(pid_t pid)
+{
+	int did_fail;
+	struct cmd2process *entry;
+	struct hashmap_iter iter;
+	static const char shutdown[] = "shutdown\n";
+	char *result = NULL;
+
+	if (!cmd_process_map_initialized)
+		return;
+
+    hashmap_iter_init(&cmd_process_map, &iter);
+	while ((entry = hashmap_iter_next(&iter))) {
+		if (entry->process.pid == pid &&
+			FILTER_SUPPORTS_SHUTDOWN(entry->supported_capabilities)
+		) {
+			sigchain_push(SIGPIPE, SIG_IGN);
+			did_fail = direct_packet_write_data(
+				entry->process.in, shutdown, strlen(shutdown), 1);
+			if (!did_fail)
+				result = packet_read_line(entry->process.out, NULL);
+			close(entry->process.in);
+			close(entry->process.out);
+			sigchain_pop(SIGPIPE);
+
+			if (did_fail || !result || strcmp(result, "done"))
+				error("shutdown of external filter '%s' failed", entry->cmd);
+		}
+	}
+}
+
+static struct cmd2process *start_protocol2_filter(struct hashmap *hashmap, const char *cmd)
+{
+	int did_fail;
+	struct cmd2process *entry;
+	struct child_process *process;
+	const char *argv[] = { cmd, NULL };
+	struct string_list capabilities = STRING_LIST_INIT_NODUP;
+	char *capabilities_buffer;
+	int i;
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
+	process->clean_on_exit = 1;
+	process->clean_on_exit_handler = shutdown_protocol2_filter;
+
+	if (start_command(process)) {
+		error("cannot fork to run external filter '%s'", cmd);
+		kill_protocol2_filter(hashmap, entry);
+		return NULL;
+	}
+
+	sigchain_push(SIGPIPE, SIG_IGN);
+	did_fail = strcmp(packet_read_line(process->out, NULL), "git-filter-protocol");
+	if (!did_fail)
+		did_fail |= strcmp(packet_read_line(process->out, NULL), "version 2");
+	if (!did_fail)
+		capabilities_buffer = packet_read_line(process->out, NULL);
+	else
+		capabilities_buffer = NULL;
+	sigchain_pop(SIGPIPE);
+
+	if (!did_fail && capabilities_buffer) {
+		string_list_split_in_place(&capabilities, capabilities_buffer, ' ', -1);
+		if (capabilities.nr > 1 &&
+			!strcmp(capabilities.items[0].string, "capabilities")) {
+			for (i = 1; i < capabilities.nr; i++) {
+				const char *requested = capabilities.items[i].string;
+				if (!strcmp(requested, "stream")) {
+					entry->supported_capabilities |= FILTER_CAPABILITIES_STREAM;
+				} else if (!strcmp(requested, "clean")) {
+					entry->supported_capabilities |= FILTER_CAPABILITIES_CLEAN;
+				} else if (!strcmp(requested, "smudge")) {
+					entry->supported_capabilities |= FILTER_CAPABILITIES_SMUDGE;
+				} else if (!strcmp(requested, "shutdown")) {
+					entry->supported_capabilities |= FILTER_CAPABILITIES_SHUTDOWN;
+				} else {
+					warning(
+						"external filter '%s' requested unsupported filter capability '%s'",
+						cmd, requested
+					);
+				}
+			}
+		} else {
+			error("filter capabilities not found");
+			did_fail = 1;
+		}
+		string_list_clear(&capabilities, 0);
+	}
+
+	if (did_fail) {
+		error("initialization for external filter '%s' failed", cmd);
+		kill_protocol2_filter(hashmap, entry);
+		return NULL;
+	}
+
+	hashmap_add(hashmap, entry);
+	return entry;
+}
+
+static int apply_protocol2_filter(const char *path, const char *src, size_t len,
+						int fd, struct strbuf *dst, const char *cmd,
+						const int wanted_capability)
+{
+	int ret = 1;
+	struct cmd2process *entry;
+	struct child_process *process;
+	struct stat file_stat;
+	struct strbuf nbuf = STRBUF_INIT;
+	size_t expected_bytes = 0;
+	char *strtol_end;
+	char *strbuf;
+	char *filter_type;
+	char *filter_result = NULL;
+
+	if (!cmd || !*cmd)
+		return 0;
+
+	if (!dst)
+		return 1;
+
+	if (!cmd_process_map_initialized) {
+		cmd_process_map_initialized = 1;
+		hashmap_init(&cmd_process_map, (hashmap_cmp_fn) cmd2process_cmp, 0);
+		entry = NULL;
+	} else {
+		entry = find_protocol2_filter_entry(&cmd_process_map, cmd);
+	}
+
+	fflush(NULL);
+
+	if (!entry) {
+		entry = start_protocol2_filter(&cmd_process_map, cmd);
+		if (!entry) {
+			return 0;
+		}
+	}
+	process = &entry->process;
+
+	if (!(wanted_capability & entry->supported_capabilities))
+		return 1;  // it is OK if the wanted capability is not supported
+
+	if FILTER_SUPPORTS_CLEAN(wanted_capability)
+		filter_type = "clean";
+	else if FILTER_SUPPORTS_SMUDGE(wanted_capability)
+		filter_type = "smudge";
+	else
+		die("unexpected filter type");
+
+	if (fd >= 0 && !src) {
+		if (fstat(fd, &file_stat) == -1)
+			return 0;
+		len = file_stat.st_size;
+	}
+
+	sigchain_push(SIGPIPE, SIG_IGN);
+
+	packet_buf_write(&nbuf, "%s\n", filter_type);
+	ret &= !direct_packet_write(process->in, nbuf.buf, nbuf.len, 1);
+
+	if (ret) {
+		strbuf_reset(&nbuf);
+		packet_buf_write(&nbuf, "filename=%s\n", path);
+		ret = !direct_packet_write(process->in, nbuf.buf, nbuf.len, 1);
+	}
+
+	if (ret) {
+		strbuf_reset(&nbuf);
+		packet_buf_write(&nbuf, "size=%"PRIuMAX"\n", (uintmax_t)len);
+		ret = !direct_packet_write(process->in, nbuf.buf, nbuf.len, 1);
+	}
+
+	if (ret) {
+		if (fd >= 0)
+			ret = !multi_packet_write_from_fd(fd, process->in);
+		else
+			ret = !multi_packet_write_from_buf(src, len, process->in);
+	}
+
+	if (ret && !FILTER_SUPPORTS_STREAM(entry->supported_capabilities)) {
+		strbuf = packet_read_line(process->out, NULL);
+		if (strlen(strbuf) > 5 && !strncmp("size=", strbuf, 5)) {
+			expected_bytes = (off_t)strtol(strbuf + 5, &strtol_end, 10);
+			ret = (strtol_end != strbuf && errno != ERANGE);
+		} else {
+			ret = 0;
+		}
+	}
+
+	if (ret) {
+		strbuf_reset(&nbuf);
+		ret = !multi_packet_read(process->out, &nbuf, expected_bytes,
+			FILTER_SUPPORTS_STREAM(entry->supported_capabilities));
+	}
+
+	if (ret) {
+		filter_result = packet_read_line(process->out, NULL);
+		ret = !strcmp(filter_result, "success");
+	}
+
+	sigchain_pop(SIGPIPE);
+
+	if (ret) {
+		strbuf_swap(dst, &nbuf);
+	} else {
+		if (!filter_result || strcmp(filter_result, "reject")) {
+			// Something went wrong with the protocol filter. Force shutdown!
+			error("external filter '%s' failed", cmd);
+			kill_protocol2_filter(&cmd_process_map, entry);
+		}
+	}
+	strbuf_release(&nbuf);
+	return ret;
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
 
@@ -526,6 +871,10 @@ static int read_convert_config(const char *var, const char *value, void *cb)
 	if (!strcmp("clean", key))
 		return git_config_string(&drv->clean, var, value);
 
+	if (!strcmp("process", key)) {
+		return git_config_string(&drv->process, var, value);
+	}
+
 	if (!strcmp("required", key)) {
 		drv->required = git_config_bool(var, value);
 		return 0;
@@ -823,7 +1172,12 @@ int would_convert_to_git_filter_fd(const char *path)
 	if (!ca.drv->required)
 		return 0;
 
-	return apply_filter(path, NULL, 0, -1, NULL, ca.drv->clean);
+	if (!ca.drv->clean && ca.drv->process)
+		return apply_protocol2_filter(
+			path, NULL, 0, -1, NULL, ca.drv->process, FILTER_CAPABILITIES_CLEAN
+		);
+	else
+		return apply_filter(path, NULL, 0, -1, NULL, ca.drv->clean);
 }
 
 const char *get_convert_attr_ascii(const char *path)
@@ -856,17 +1210,24 @@ int convert_to_git(const char *path, const char *src, size_t len,
                    struct strbuf *dst, enum safe_crlf checksafe)
 {
 	int ret = 0;
-	const char *filter = NULL;
+	const char *clean_filter = NULL;
+	const char *process_filter = NULL;
 	int required = 0;
 	struct conv_attrs ca;
 
 	convert_attrs(&ca, path);
 	if (ca.drv) {
-		filter = ca.drv->clean;
+		clean_filter = ca.drv->clean;
+		process_filter = ca.drv->process;
 		required = ca.drv->required;
 	}
 
-	ret |= apply_filter(path, src, len, -1, dst, filter);
+	if (!clean_filter && process_filter)
+		ret |= apply_protocol2_filter(
+			path, src, len, -1, dst, process_filter, FILTER_CAPABILITIES_CLEAN
+		);
+	else
+		ret |= apply_filter(path, src, len, -1, dst, clean_filter);
 	if (!ret && required)
 		die("%s: clean filter '%s' failed", path, ca.drv->name);
 
@@ -885,13 +1246,21 @@ int convert_to_git(const char *path, const char *src, size_t len,
 void convert_to_git_filter_fd(const char *path, int fd, struct strbuf *dst,
 			      enum safe_crlf checksafe)
 {
+	int ret = 0;
 	struct conv_attrs ca;
 	convert_attrs(&ca, path);
 
 	assert(ca.drv);
-	assert(ca.drv->clean);
+	assert(ca.drv->clean || ca.drv->process);
+
+	if (!ca.drv->clean && ca.drv->process)
+		ret = apply_protocol2_filter(
+			path, NULL, 0, fd, dst, ca.drv->process, FILTER_CAPABILITIES_CLEAN
+		);
+	else
+		ret = apply_filter(path, NULL, 0, fd, dst, ca.drv->clean);
 
-	if (!apply_filter(path, NULL, 0, fd, dst, ca.drv->clean))
+	if (!ret)
 		die("%s: clean filter '%s' failed", path, ca.drv->name);
 
 	crlf_to_git(path, dst->buf, dst->len, dst, ca.crlf_action, checksafe);
@@ -902,14 +1271,16 @@ static int convert_to_working_tree_internal(const char *path, const char *src,
 					    size_t len, struct strbuf *dst,
 					    int normalizing)
 {
-	int ret = 0, ret_filter = 0;
-	const char *filter = NULL;
+	int ret = 0, ret_filter;
+	const char *smudge_filter = NULL;
+	const char *process_filter = NULL;
 	int required = 0;
 	struct conv_attrs ca;
 
 	convert_attrs(&ca, path);
 	if (ca.drv) {
-		filter = ca.drv->smudge;
+		process_filter = ca.drv->process;
+		smudge_filter = ca.drv->smudge;
 		required = ca.drv->required;
 	}
 
@@ -922,7 +1293,7 @@ static int convert_to_working_tree_internal(const char *path, const char *src,
 	 * CRLF conversion can be skipped if normalizing, unless there
 	 * is a smudge filter.  The filter might expect CRLFs.
 	 */
-	if (filter || !normalizing) {
+	if (smudge_filter || process_filter || !normalizing) {
 		ret |= crlf_to_worktree(path, src, len, dst, ca.crlf_action);
 		if (ret) {
 			src = dst->buf;
@@ -930,7 +1301,12 @@ static int convert_to_working_tree_internal(const char *path, const char *src,
 		}
 	}
 
-	ret_filter = apply_filter(path, src, len, -1, dst, filter);
+	if (!smudge_filter && process_filter)
+		ret_filter = apply_protocol2_filter(
+			path, src, len, -1, dst, process_filter, FILTER_CAPABILITIES_SMUDGE
+		);
+	else
+		ret_filter = apply_filter(path, src, len, -1, dst, smudge_filter);
 	if (!ret_filter && required)
 		die("%s: smudge filter %s failed", path, ca.drv->name);
 
@@ -1383,7 +1759,7 @@ struct stream_filter *get_stream_filter(const char *path, const unsigned char *s
 	struct stream_filter *filter = NULL;
 
 	convert_attrs(&ca, path);
-	if (ca.drv && (ca.drv->smudge || ca.drv->clean))
+	if (ca.drv && (ca.drv->process || ca.drv->smudge || ca.drv->clean))
 		return NULL;
 
 	if (ca.crlf_action == CRLF_AUTO || ca.crlf_action == CRLF_AUTO_CRLF)
diff --git a/t/t0021-conversion.sh b/t/t0021-conversion.sh
index 34c8eb9..e8a7703 100755
--- a/t/t0021-conversion.sh
+++ b/t/t0021-conversion.sh
@@ -296,4 +296,409 @@ test_expect_success 'disable filter with empty override' '
 	test_must_be_empty err
 '
 
+test_expect_success PERL 'required process filter should filter data' '
+	test_config_global filter.protocol.process "$TEST_DIRECTORY/t0021/rot13-filter.pl clean smudge shutdown" &&
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
+		cat ../test.o >test.r &&
+		echo "test22" >test2.r &&
+		mkdir testsubdir &&
+		echo "test333" >testsubdir/test3.r &&
+
+		rm -f rot13-filter.log &&
+		git add . &&
+		sort rot13-filter.log | uniq -c | sed "s/^[ ]*//" >uniq-rot13-filter.log &&
+		cat >expected_add.log <<-\EOF &&
+			1 IN: clean test.r 57 [OK] -- OUT: 57 [OK]
+			1 IN: clean test2.r 7 [OK] -- OUT: 7 [OK]
+			1 IN: clean testsubdir/test3.r 8 [OK] -- OUT: 8 [OK]
+			1 IN: shutdown -- [OK]
+			1 start
+			1 wrote filter header
+		EOF
+		test_cmp expected_add.log uniq-rot13-filter.log &&
+
+		>rot13-filter.log &&
+		git commit . -m "test commit" &&
+		sort rot13-filter.log | uniq -c | sed "s/^[ ]*//" |
+			sed "s/^\([0-9]\) IN: clean/x IN: clean/" >uniq-rot13-filter.log &&
+		cat >expected_commit.log <<-\EOF &&
+			x IN: clean test.r 57 [OK] -- OUT: 57 [OK]
+			x IN: clean test2.r 7 [OK] -- OUT: 7 [OK]
+			x IN: clean testsubdir/test3.r 8 [OK] -- OUT: 8 [OK]
+			1 IN: shutdown -- [OK]
+			1 start
+			1 wrote filter header
+		EOF
+		test_cmp expected_commit.log uniq-rot13-filter.log &&
+
+		>rot13-filter.log &&
+		rm -f test?.r testsubdir/test3.r &&
+		git checkout . &&
+		cat rot13-filter.log | grep -v "IN: clean" >smudge-rot13-filter.log &&
+		cat >expected_checkout.log <<-\EOF &&
+			start
+			wrote filter header
+			IN: smudge test2.r 7 [OK] -- OUT: 7 [OK]
+			IN: smudge testsubdir/test3.r 8 [OK] -- OUT: 8 [OK]
+			IN: shutdown -- [OK]
+		EOF
+		test_cmp expected_checkout.log smudge-rot13-filter.log &&
+
+		git checkout empty &&
+
+		>rot13-filter.log &&
+		git checkout master &&
+		cat rot13-filter.log | grep -v "IN: clean" >smudge-rot13-filter.log &&
+		cat >expected_checkout_master.log <<-\EOF &&
+			start
+			wrote filter header
+			IN: smudge test.r 57 [OK] -- OUT: 57 [OK]
+			IN: smudge test2.r 7 [OK] -- OUT: 7 [OK]
+			IN: smudge testsubdir/test3.r 8 [OK] -- OUT: 8 [OK]
+			IN: shutdown -- [OK]
+		EOF
+		test_cmp expected_checkout_master.log smudge-rot13-filter.log &&
+
+		./../rot13.sh <test.r >expected &&
+		git cat-file blob :test.r >actual &&
+		test_cmp expected actual &&
+
+		./../rot13.sh <test2.r >expected &&
+		git cat-file blob :test2.r >actual &&
+		test_cmp expected actual &&
+
+		./../rot13.sh <testsubdir/test3.r >expected &&
+		git cat-file blob :testsubdir/test3.r >actual &&
+		test_cmp expected actual
+	)
+'
+
+test_expect_success PERL 'required process filter should filter data stream' '
+	test_config_global filter.protocol.process "$TEST_DIRECTORY/t0021/rot13-filter.pl stream clean smudge" &&
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
+		cat ../test.o >test.r &&
+		echo "test22" >test2.r &&
+		mkdir testsubdir &&
+		echo "test333" >testsubdir/test3.r &&
+
+		rm -f rot13-filter.log &&
+		git add . &&
+		sort rot13-filter.log | uniq -c | sed "s/^[ ]*//" >uniq-rot13-filter.log &&
+		cat >expected_add.log <<-\EOF &&
+			1 IN: clean test.r 57 [OK] -- OUT: STREAM [OK]
+			1 IN: clean test2.r 7 [OK] -- OUT: STREAM [OK]
+			1 IN: clean testsubdir/test3.r 8 [OK] -- OUT: STREAM [OK]
+			1 start
+			1 wrote filter header
+		EOF
+		test_cmp expected_add.log uniq-rot13-filter.log &&
+
+		>rot13-filter.log &&
+		git commit . -m "test commit" &&
+		sort rot13-filter.log | uniq -c | sed "s/^[ ]*//" |
+			sed "s/^\([0-9]\) IN: clean/x IN: clean/" >uniq-rot13-filter.log &&
+		cat >expected_commit.log <<-\EOF &&
+			x IN: clean test.r 57 [OK] -- OUT: STREAM [OK]
+			x IN: clean test2.r 7 [OK] -- OUT: STREAM [OK]
+			x IN: clean testsubdir/test3.r 8 [OK] -- OUT: STREAM [OK]
+			1 start
+			1 wrote filter header
+		EOF
+		test_cmp expected_commit.log uniq-rot13-filter.log &&
+
+		>rot13-filter.log &&
+		rm -f test?.r testsubdir/test3.r &&
+		git checkout . &&
+		cat rot13-filter.log | grep -v "IN: clean" >smudge-rot13-filter.log &&
+		cat >expected_checkout.log <<-\EOF &&
+			start
+			wrote filter header
+			IN: smudge test2.r 7 [OK] -- OUT: STREAM [OK]
+			IN: smudge testsubdir/test3.r 8 [OK] -- OUT: STREAM [OK]
+		EOF
+		test_cmp expected_checkout.log smudge-rot13-filter.log &&
+
+		git checkout empty &&
+
+		>rot13-filter.log &&
+		git checkout master &&
+		cat rot13-filter.log | grep -v "IN: clean" >smudge-rot13-filter.log &&
+		cat >expected_checkout_master.log <<-\EOF &&
+			start
+			wrote filter header
+			IN: smudge test.r 57 [OK] -- OUT: STREAM [OK]
+			IN: smudge test2.r 7 [OK] -- OUT: STREAM [OK]
+			IN: smudge testsubdir/test3.r 8 [OK] -- OUT: STREAM [OK]
+		EOF
+		test_cmp expected_checkout_master.log smudge-rot13-filter.log &&
+
+		./../rot13.sh <test.r >expected &&
+		git cat-file blob :test.r >actual &&
+		test_cmp expected actual &&
+
+		./../rot13.sh <test2.r >expected &&
+		git cat-file blob :test2.r >actual &&
+		test_cmp expected actual &&
+
+		./../rot13.sh <testsubdir/test3.r >expected &&
+		git cat-file blob :testsubdir/test3.r >actual &&
+		test_cmp expected actual
+	)
+'
+
+test_expect_success PERL 'required process filter should filter smudge data and one-shot filter should clean' '
+	test_config_global filter.protocol.clean ./../rot13.sh &&
+	test_config_global filter.protocol.process "$TEST_DIRECTORY/t0021/rot13-filter.pl smudge" &&
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
+		cat ../test.o >test.r &&
+		echo "test22" >test2.r &&
+		mkdir testsubdir &&
+		echo "test333" >testsubdir/test3.r &&
+
+		rm -f rot13-filter.log &&
+		git add . &&
+		test_must_be_empty rot13-filter.log &&
+
+		>rot13-filter.log &&
+		git commit . -m "test commit" &&
+		test_must_be_empty rot13-filter.log &&
+
+		>rot13-filter.log &&
+		rm -f test?.r testsubdir/test3.r &&
+		git checkout . &&
+		cat rot13-filter.log | grep -v "IN: clean" >smudge-rot13-filter.log &&
+		cat >expected_checkout.log <<-\EOF &&
+			start
+			wrote filter header
+			IN: smudge test2.r 7 [OK] -- OUT: 7 [OK]
+			IN: smudge testsubdir/test3.r 8 [OK] -- OUT: 8 [OK]
+		EOF
+		test_cmp expected_checkout.log smudge-rot13-filter.log &&
+
+		git checkout empty &&
+
+		>rot13-filter.log &&
+		git checkout master &&
+		cat rot13-filter.log | grep -v "IN: clean" >smudge-rot13-filter.log &&
+		cat >expected_checkout_master.log <<-\EOF &&
+			start
+			wrote filter header
+			IN: smudge test.r 57 [OK] -- OUT: 57 [OK]
+			IN: smudge test2.r 7 [OK] -- OUT: 7 [OK]
+			IN: smudge testsubdir/test3.r 8 [OK] -- OUT: 8 [OK]
+		EOF
+		test_cmp expected_checkout_master.log smudge-rot13-filter.log &&
+
+		./../rot13.sh <test.r >expected &&
+		git cat-file blob :test.r >actual &&
+		test_cmp expected actual &&
+
+		./../rot13.sh <test2.r >expected &&
+		git cat-file blob :test2.r >actual &&
+		test_cmp expected actual &&
+
+		./../rot13.sh <testsubdir/test3.r >expected &&
+		git cat-file blob :testsubdir/test3.r >actual &&
+		test_cmp expected actual
+	)
+'
+
+test_expect_success PERL 'required process filter should clean only' '
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
+		cat ../test.o >test.r &&
+
+		rm -f rot13-filter.log &&
+		git add . &&
+		sort rot13-filter.log | uniq -c | sed "s/^[ ]*//" >uniq-rot13-filter.log &&
+		cat >expected_add.log <<-\EOF &&
+			1 IN: clean test.r 57 [OK] -- OUT: 57 [OK]
+			1 start
+			1 wrote filter header
+		EOF
+		test_cmp expected_add.log uniq-rot13-filter.log &&
+
+		>rot13-filter.log &&
+		git commit . -m "test commit" &&
+		sort rot13-filter.log | uniq -c | sed "s/^[ ]*//" |
+			sed "s/^\([0-9]\) IN: clean/x IN: clean/" >uniq-rot13-filter.log &&
+		cat >expected_commit.log <<-\EOF &&
+			x IN: clean test.r 57 [OK] -- OUT: 57 [OK]
+			1 start
+			1 wrote filter header
+		EOF
+		test_cmp expected_commit.log uniq-rot13-filter.log
+	)
+'
+
+test_expect_success PERL 'required process filter should process files larger LARGE_PACKET_MAX' '
+	test_config_global filter.protocol.process "$TEST_DIRECTORY/t0021/rot13-filter.pl clean smudge" &&
+	test_config_global filter.protocol.required true &&
+	rm -rf repo &&
+	mkdir repo &&
+	(
+		cd repo &&
+		git init &&
+
+		echo "*.file filter=protocol" >.gitattributes &&
+		cat ../generated-test-data/largish.file.rot13 >large.rot13 &&
+		cat ../generated-test-data/largish.file >large.file &&
+		cat large.file >large.original &&
+
+		git add large.file .gitattributes &&
+		git commit . -m "test commit" &&
+
+		rm -f large.file &&
+		git checkout -- large.file &&
+		git cat-file blob :large.file >actual &&
+		test_cmp large.rot13 actual
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
+		cat ../test.o >test.r &&
+		echo "this is going to fail" >clean-write-fail.r &&
+		echo "test333" >test3.r &&
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
+		cat ../test.o >test.r &&
+		echo "1234567" >test2.o &&
+		cat test2.o >test2.r &&
+		echo "this is going to fail" >smudge-write-fail.o &&
+		cat smudge-write-fail.o >smudge-write-fail.r &&
+		git add . &&
+		git commit . -m "test commit" &&
+		rm -f *.r &&
+
+		printf "" >rot13-filter.log &&
+		git checkout . &&
+		cat rot13-filter.log | grep -v "IN: clean" >smudge-rot13-filter.log &&
+		cat >expected_checkout_master.log <<-\EOF &&
+			start
+			wrote filter header
+			IN: smudge smudge-write-fail.r 22 [OK] -- OUT: 22 [WRITE FAIL]
+			start
+			wrote filter header
+			IN: smudge test.r 57 [OK] -- OUT: 57 [OK]
+			IN: smudge test2.r 8 [OK] -- OUT: 8 [OK]
+		EOF
+		test_cmp expected_checkout_master.log smudge-rot13-filter.log &&
+
+		test_cmp ../test.o test.r &&
+		./../rot13.sh <../test.o >expected &&
+		git cat-file blob :test.r >actual &&
+		test_cmp expected actual &&
+
+		test_cmp test2.o test2.r &&
+		./../rot13.sh <test2.o >expected &&
+		git cat-file blob :test2.r >actual &&
+		test_cmp expected actual &&
+
+		! test_cmp smudge-write-fail.o smudge-write-fail.r && # Smudge failed!
+		./../rot13.sh <smudge-write-fail.o >expected &&
+		git cat-file blob :smudge-write-fail.r >actual &&
+		test_cmp expected actual							  # Clean worked!
+	)
+'
+
+test_expect_success PERL 'process filter should not restart after intentionally rejected file' '
+	test_config_global filter.protocol.process "$TEST_DIRECTORY/t0021/rot13-filter.pl clean smudge" &&
+	rm -rf repo &&
+	mkdir repo &&
+	(
+		cd repo &&
+		git init &&
+
+		echo "*.r filter=protocol" >.gitattributes &&
+
+		cat ../test.o >test.r &&
+		echo "1234567" >test2.o &&
+		cat test2.o >test2.r &&
+		echo "this is going to fail" >reject.o &&
+		cat reject.o >reject.r &&
+		git add . &&
+		git commit . -m "test commit" &&
+		rm -f *.r &&
+
+		printf "" >rot13-filter.log &&
+		git checkout . &&
+		cat rot13-filter.log | grep -v "IN: clean" >smudge-rot13-filter.log &&
+		cat >expected_checkout_master.log <<-\EOF &&
+			start
+			wrote filter header
+			IN: smudge reject.r 22 [OK] -- OUT: 0 [REJECT]
+			IN: smudge test.r 57 [OK] -- OUT: 57 [OK]
+			IN: smudge test2.r 8 [OK] -- OUT: 8 [OK]
+		EOF
+		test_cmp expected_checkout_master.log smudge-rot13-filter.log
+	)
+'
 test_done
diff --git a/t/t0021/rot13-filter.pl b/t/t0021/rot13-filter.pl
new file mode 100755
index 0000000..cb0925d
--- /dev/null
+++ b/t/t0021/rot13-filter.pl
@@ -0,0 +1,177 @@
+#!/usr/bin/perl
+#
+# Example implementation for the Git filter protocol version 2
+# See Documentation/gitattributes.txt, section "Filter Protocol"
+#
+# The script takes the list of supported protocol capabilities as
+# arguments ("stream", "clean", and "smudge" are supported).
+#
+# This implementation supports three special test cases:
+# (1) If data with the filename "clean-write-fail.r" is processed with
+#     a "clean" operation then the write operation will die.
+# (2) If data with the filename "smudge-write-fail.r" is processed with
+#     a "smudge" operation then the write operation will die.
+# (3) If data with the filename "failure.r" is processed with any
+#     operation then the filter signals that the operation was not
+#     successful.
+#
+
+use strict;
+use warnings;
+
+my $MAX_PACKET_CONTENT_SIZE = 65516;
+my @capabilities            = @ARGV;
+
+sub rot13 {
+    my ($str) = @_;
+    $str =~ y/A-Za-z/N-ZA-Mn-za-m/;
+    return $str;
+}
+
+sub packet_read {
+    my $buffer;
+    my $bytes_read = read STDIN, $buffer, 4;
+    if ( $bytes_read == 0 ) {
+        return;
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
+            die "invalid packet";
+        }
+        return ( 0, $buffer );
+    }
+    else {
+        die "invalid packet size";
+    }
+}
+
+sub packet_write {
+    my ($packet) = @_;
+    print STDOUT sprintf( "%04x", length($packet) + 4 );
+    print STDOUT $packet;
+    STDOUT->flush();
+}
+
+sub packet_flush {
+    print STDOUT sprintf( "%04x", 0 );
+    STDOUT->flush();
+}
+
+open my $debug, ">>", "rot13-filter.log";
+print $debug "start\n";
+$debug->flush();
+
+packet_write("git-filter-protocol\n");
+packet_write("version 2\n");
+packet_write( "capabilities " . join( ' ', @capabilities ) . "\n" );
+print $debug "wrote filter header\n";
+$debug->flush();
+
+while (1) {
+    my $command = packet_read();
+    unless ( defined($command) ) {
+        exit();
+    }
+    chomp $command;
+    print $debug "IN: $command";
+    $debug->flush();
+
+    if ( $command eq "shutdown" ) {
+        print $debug " -- [OK]";
+        $debug->flush();
+        packet_write("done\n");
+        exit();
+    }
+
+    my ($filename) = packet_read() =~ /filename=([^=]+)\n/;
+    print $debug " $filename";
+    $debug->flush();
+    my ($filelen) = packet_read() =~ /size=([^=]+)\n/;
+    chomp $filelen;
+    print $debug " $filelen";
+    $debug->flush();
+
+    $filelen =~ /\A\d+\z/ or die "bad filelen: $filelen";
+    my $output;
+
+    if ( $filelen > 0 ) {
+        my $input = "";
+        {
+            binmode(STDIN);
+            my $buffer;
+            my $done = 0;
+            while ( !$done ) {
+                ( $done, $buffer ) = packet_read();
+                $input .= $buffer;
+            }
+            print $debug " [OK] -- ";
+            $debug->flush();
+        }
+
+        if ( $command eq "clean" and grep( /^clean$/, @capabilities ) ) {
+            $output = rot13($input);
+        }
+        elsif ( $command eq "smudge" and grep( /^smudge$/, @capabilities ) ) {
+            $output = rot13($input);
+        }
+        else {
+            die "bad command $command";
+        }
+    }
+
+    my $output_len = length($output);
+    if ( $filename eq "reject.r" ) {
+        $output_len = 0;
+    }
+
+    if ( grep( /^stream$/, @capabilities ) ) {
+        print $debug "OUT: STREAM ";
+    }
+    else {
+        packet_write("size=$output_len\n");
+        print $debug "OUT: $output_len ";
+    }
+    $debug->flush();
+
+    if ( $filename eq "reject.r" ) {
+        packet_write("reject\n");
+        print $debug "[REJECT]\n";    # Could also be an error
+        $debug->flush();
+    }
+
+    if ( $output_len > 0 ) {
+        if (( $command eq "clean" and $filename eq "clean-write-fail.r" )
+            or
+            ( $command eq "smudge" and $filename eq "smudge-write-fail.r" ))
+        {
+            print $debug "[WRITE FAIL]\n";
+            $debug->flush();
+            die "write error";
+        }
+        else {
+            while ( length($output) > 0 ) {
+                my $packet = substr( $output, 0, $MAX_PACKET_CONTENT_SIZE );
+                packet_write($packet);
+                if ( length($output) > $MAX_PACKET_CONTENT_SIZE ) {
+                    $output = substr( $output, $MAX_PACKET_CONTENT_SIZE );
+                }
+                else {
+                    $output = "";
+                }
+            }
+            packet_flush();
+            packet_write("success\n");
+            print $debug "[OK]\n";
+            $debug->flush();
+        }
+    }
+}
-- 
2.9.0

