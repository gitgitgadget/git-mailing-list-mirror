Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66DBF420479
	for <git@vger.kernel.org>; Fri,  4 Sep 2026 21:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788557343; cv=none; b=ewhoFRHMb3i0oE7ULrGOmRpQzHBlHaMsLgHzEml5zeb5bwXBisIbmgzVepSBwKC5mPdLceI1DHz/J70FyJ1Ean5Fz3r23QE7468qkZOsGnICYQeHxRM9MC++pdnOqCCW232QKDnuYfhQjoItW74abZJOE5mOiy97VxfwUYZ8gto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788557343; c=relaxed/simple;
	bh=moCDuI7fu8D8Qh63XIh63/TYj4b2E6qh8pYvRYlQqB8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=CkhEfNgauQU+cIT7rhCbDoau2yzsEZp/VVCD+i4xHso7bRCCaHbqzOETye7C9V2/IUFztmJC6dfXr6njEvkRMc7xKvCgL0kCWBzLvSmGjWziCOYlbzmK5ChjCX0brbasP9j9IQV3qETCA2eOJEkUIcy+lU9uIDPCj7DSvNKodP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XrCPx/HN; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XrCPx/HN"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-49a97714f5dso12838105e9.0
        for <git@vger.kernel.org>; Fri, 04 Sep 2026 14:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788557336; x=1789162136; darn=vger.kernel.org;
        h=cc:to:references:in-reply-to:content-transfer-encoding:content-type
         :mime-version:message-id:date:subject:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LUdMEoXTzdg7L1MdvKA957YG5WRgHJ5DsrLZS6R9QXs=;
        b=XrCPx/HNDguO6UKxuXtih5BbdiZoNyXE5dhebUSk7+DIxazn2UwD1vU/mw5/xlZPvY
         aItvfhX3UX2XU3Gl5WpHGAKDPbRBuR6Wos4jcnM6ib0jWolyMjjdQmnF+Ry/QqlOMNi3
         qwDp3duc9NSr+hu2kSCu5o/WtlCkUu40UMCQK1obe2nCoeaY3H07ObAha/UvQYZd2H0d
         WvF+vWiqFw4p9/4OFwGZl3okIj4/SMHQQ79LI8IFt7Ely3HG1GwyhxFAvHeXP6qCoETU
         3eDsDA/z1yP/GKZBnzzHlSCPKrpxrZbOKAT/czB0ZSbD+hc/XELJ7JNRTPtT7uqA3SnP
         pIjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788557336; x=1789162136;
        h=cc:to:references:in-reply-to:content-transfer-encoding:content-type
         :mime-version:message-id:date:subject:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LUdMEoXTzdg7L1MdvKA957YG5WRgHJ5DsrLZS6R9QXs=;
        b=biiVjmFWYbKSMnhsYwmJXMscwORpLDvNfBUYKn+GHUElu6MWEtiN949PhEQZR6MK09
         4HdFrO3K3n3ZZ/iMmhixC+CnjBcP/8+5EnGKmb6PFY4zt3UphSQDUw/0cZ3MP4Z6UHm7
         ZYp8N1K/k+cpb+O5E1/ZNjkaC6QS3mQ7zgDKPvcBNf9ZwtzF8FrOdThgo7ZT2n0gc+1M
         OvzlA2gUeURUS//COSgW+GHuBh/6vgCeM3Oxio9aQdBOrLPT4ijpNApUeWqGpTw+0S97
         pT2LnkW5g7MTNNvL+mpsoVtZ3v54oZp4HT2LdUv7kq3FZ3+HCb+K74b/BcrhEaUrdfZb
         3Exw==
X-Gm-Message-State: AFuF++mD2C02zDbu7jXIASeDMlCbSLVCX4/0szoa3T55BsunyKjQi/d8
	NFLnRkVno/Iak2bjRluk/Mmy5nTBq9ireMRGRuQTiyhZkGVEtHtKMyIc
X-Gm-Gg: AYBFou2Fz0NMAny1ZFlA4jGfumvQoQZfOWaWHITnuJE6Y12Srm0mt+oyahJwxgBR8i/
	7KFd70sxZwZNjEmmspwhs7y8/VNOFAmXPXW1LPH/vKOI4CtcIpyk0v1Jcu2Zrxzr5/nh0FP7YoS
	FO+e6WuFEuURMM8x1f4n9YEU96CXmH+wvMD4sb4qNIyDjzYA+vYTngLrT/aNNjDKv7W1RDpWGGE
	Iqfp1LilwhalyDZKJR/HXR/XM3NoFilv5qcrfY/ZYVm6w08VWoRmj8BZrV2p26IW6SWEM56T007
	beJe8hHfZsZLLvB9YJGZ62fHptPBL+yO3xFJOdLC+GmvA+7/aMqQUgbk4D7VmW2Gr0cCciAF3xX
	ncWqE43jcc/kGQpx4MBNnguzaF+vIwkRmDiftYvJYOgk/oxDhehk9+StiES6HYPgGyFZJ81fdEU
	yPtaaw9cpqBlJRb214aftZGVCYamCVDn85l/lAHh08Ty/pPWJavbxR55D8xAs89jULdL7fpH0XB
	LLhZeIL5IB8oNkCMBpaRvjoBrxiK2lgFHkHpw==
X-Received: by 2002:a05:600c:3b0e:b0:49c:eb04:1c49 with SMTP id 5b1f17b1804b1-49cf8254d53mr80573755e9.13.1788557336036;
        Fri, 04 Sep 2026 14:28:56 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:8109:d906:4e00:1faf:874b:d20e:6b2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-485883c074asm8820051f8f.23.2026.09.04.14.28.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 14:28:55 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v7 0/4] hook: introduce the receive-report hook
Date: Fri, 04 Sep 2026 23:28:48 +0200
Message-Id: <20260904-758-introduce-hook-v7-0-6c66f0a3a572@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/23P3U7EIBAF4FfZcC0GhvLnle9hvAA6bFG3mNJtN
 Ju+u3SNsWm4PMnMd2ZupOCUsJCn041MuKSS8liDfjiRMLjxjDT1NRNgoJjhQLU0NI3zlPtrQDr
 k/E6lFy7ayJ1GQ+ri54Qxfd3Rl9ffXK7+DcO8SdvEkMqcp+9768K3ub8C0ypYOOXUONMbi0oaY
 Z7PF5c+HkO+kK1ggR0BvElAJdAyhKhdgBCPhNgTXZMQlNHOWgkqMscUHIluT6gm0VVCed5ZLV1
 vpT4S8p+wrP2IrISQoQ/KowiBHwm1J0STUNsVYITn0VvPw55Y1/UHgkaM6xUCAAA=
X-Change-ID: 20260812-758-introduce-hook-5b3af9f1a7e8
In-Reply-To: <20260818-758-introduce-hook-v1-1-8a8d89e65838@gmail.com>
References: <20260818-758-introduce-hook-v1-1-8a8d89e65838@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im, gitster@pobox.com, jltobler@gmail.com, 
 kristofferhaugsbakk@fastmail.com, Phillip Wood <phillip.wood@dunelm.org.uk>, 
 Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=11983;
 i=karthik.188@gmail.com; h=from:subject:message-id;
 bh=moCDuI7fu8D8Qh63XIh63/TYj4b2E6qh8pYvRYlQqB8=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGqbOBQeas3yVg7guVOr5HhqR72bSKRYyYsHx
 +gEMyfUxM8anokBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJqmzgUAAoJED7VnySO
 Rox/4bYL/iS68ilzfnbjDreeE6iaK5cS5UhcD/5JD13ZBBSf++IwTwUqBwAjZ2GKJ183JlUGCoq
 iGuO9YIgWDZTa/TkpZeg/cMa5PX6OC5WBB3ExhNk5w+4BOR9L5p+JqXI84Ywt17YU3x9ARrmBhz
 x0Isi4kJwtM1+P7LyBNjIeBe7a6E/SCI99uglrwduju65y1oZewWSm/EqPNdLPP7jlcymeN+DeJ
 TDfmDAMaNXwlZJUOPjceDYB1NzUtPHdLOybnAP0C/Ogicn7Qca5whthL9sokoyeMPnROIJmeEVq
 4IipSQx6zZb+X7uDotx6gu1QXgqizugVrDtkFsHZKevCXAeHVF3gmoplaWmcJPp4JWMgKkSCdt2
 H3b4Y1xh75w61ncMcHxfvajgF9tIGq7Kj7dScjKrKkmMsg4OewpM146D1gsFxOV5QTJcJcypEbT
 O8Wn5IcDdold75zZ5ZjsAWoAN0n+4XMunGoqSYgitLONrepz8lOpXxX8VUKxAizx0+A/cRbUPw5
 ZI=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

Introduce a new receive-report hook which kicks in after the reference
transaction is complete, but before the report is sent to the client.
The hook receives the pkt-line encoded report in its stdin and its
stdout replaces the report transferred to the user. If the hook exits
with a non-zero exit code, all references are marked as rejected.

The first patch, adds missing documentation to 'git-receive-pack.adoc'.
The second patch refactors code and the third patch contains the new
hook.

---
Changes in v7:
- Removed report_v2() since it is the same as report() with the new
  changes.
- Used a switch statement instead of an if/else for the enum.
- Removed an unnecessary curly brace.
- Also rebased on top of latest master (3cb9185f65 (The 22nd batch,
  2026-09-02) as there were conflicts.
- Link to v6: https://patch.msgid.link/20260903-758-introduce-hook-v6-0-6283b1fb9b1c@gmail.com

Changes in v6:
- Introduce a new commit which introduces `enum report_status_version`,
  use that and drop static variables in the codebase.
- Reword the commit message and documentation to:
  - State further why reference-transaction cannot be used.
  - State the responsibility of the hook owner to undo and reference
    changes if needed.
- Link to v5: https://patch.msgid.link/20260901-758-introduce-hook-v5-0-35cdc6be3cc1@gmail.com

Changes in v5:
- Rewrote some of the commit messages and documentation.
- Renamed the function `generate_response` to `generate_report` to avoid
  ambiguity.
- We now override the cmd's error_strings, this avoids the whole
  precedence issue with the earlier series.
- Also add information about how we can override the unpack status to
  fail the push and add a corresponding test.
- Thanks to Patrick for the review!
- Junio: This causes conflict with next ('jt/receive-pack-pluggable-writes')
  similar to before, please let me know if its better for me to add that
  dependency.
- Link to v4: https://patch.msgid.link/20260826-758-introduce-hook-v4-0-6b14975ad957@gmail.com

Changes in v4:
- Change the name of the hook to be 'receive-report' to avoid ambiguity.
- Link to v3: https://patch.msgid.link/20260824-758-introduce-hook-v3-0-499526f0a062@gmail.com

Changes in v3:
- Move out addition of proc-receive hook doc to 'git-receive-pack.adoc'
  into a new commit.
- Add a new commit to move out the response generation in receive-pack
  to a new function.
- Instead of die-ing on non-zero exit code, we modify each reference to
  indicate that the hook failed.
- Instead of correctly listing out the protocol, link to
  linkgit:gitprotocol-pack[5], as the protocol also differs between v1
  and v2.
- Link to v2: https://patch.msgid.link/20260821-758-introduce-hook-v2-1-e90e2f7ac2cf@gmail.com

Changes in v2:
- Modify the documentation and commit message to be more verbose.
- Add documentation to 'git-receive-pack.adoc'
- Use 'ret' as the variable name for the return code.
- Modify the test to also check for the 'remote:'.
- Link to v1: https://patch.msgid.link/20260818-758-introduce-hook-v1-1-8a8d89e65838@gmail.com

 To: git@vger.kernel.org
 CC: ps@pks.im
 CC: gitster@pobox.com
 CC: jltobler@gmail.com
 CC: kristofferhaugsbakk@fastmail.com
 CC: phillip.wood123@gmail.com

---
Karthik Nayak (4):
      doc: add proc-receive hook info in 'git-receive-pack.adoc'
      receive-pack: drop static variables to track report status version
      receive-pack: move message generation to separate function
      hook: introduce the receive-report hook

 Documentation/git-receive-pack.adoc |  17 +++
 Documentation/githooks.adoc         |  61 ++++++++++
 builtin/receive-pack.c              | 148 ++++++++++++++++--------
 t/meson.build                       |   1 +
 t/t5412-receive-report-hook.sh      | 224 ++++++++++++++++++++++++++++++++++++
 5 files changed, 403 insertions(+), 48 deletions(-)

Range-diff versus v6:

1:  97c946bad0 = 1:  efb66eb539 doc: add proc-receive hook info in 'git-receive-pack.adoc'
2:  0f7738eed0 ! 2:  d8e4830a6f receive-pack: drop static variables to track report status version
    @@ builtin/receive-pack.c: enum deny_action {
      static int deny_deletes;
      static int deny_non_fast_forwards;
      static enum deny_action deny_current_branch = DENY_UNCONFIGURED;
    -@@ builtin/receive-pack.c: static int advertise_push_options;
    +@@ builtin/receive-pack.c: static int advertise_atomic_push = 1;
    + static int advertise_push_options;
      static int advertise_sid;
    - static int unpack_limit = 100;
      static off_t max_input_size;
     -static int report_status;
     -static int report_status_v2;
    @@ builtin/receive-pack.c: int cmd_receive_pack(int argc,
      
     -	if ((commands = read_head_info(&reader, &shallow))) {
     +	if ((commands = read_head_info(&reader, &shallow, &version))) {
    - 		const char *unpack_status = NULL;
      		struct string_list push_options = STRING_LIST_INIT_DUP;
    + 		struct strbuf unpack_status = STRBUF_INIT;
      
     @@ builtin/receive-pack.c: int cmd_receive_pack(int argc,
      				 &push_options);
    - 		delete_tempfile(&pack_lockfile);
    + 		odb_transaction_finalize(transaction);
      		sigchain_push(SIGPIPE, SIG_IGN);
     -		if (report_status_v2)
    -+		if (version == REPORT_STATUS_V2)
    - 			report_v2(commands, unpack_status);
    ++
    ++		switch (version) {
    ++		case REPORT_STATUS_V2:
    + 			report_v2(commands, &unpack_status);
     -		else if (report_status)
    -+		else if (version == REPORT_STATUS_V0)
    - 			report(commands, unpack_status);
    -+		else
    ++			break;
    ++		case REPORT_STATUS_V0:
    + 			report(commands, &unpack_status);
    ++			break;
    ++		default:
     +			BUG("unknown report status version");
    ++		}
    ++
      		sigchain_pop(SIGPIPE);
      		run_receive_hook(commands, "post-receive", 1, NULL,
      				 &push_options);
3:  8b56349072 ! 3:  d9464d9739 receive-pack: move message generation to separate function
    @@ Commit message
         knows to provide a more detailed report about how exactly a given
         reference was updated.
     
    +    With this, also drop `report_v2()` as both report functions now are
    +    similar in structure with only the `report_status_version`
    +    differentiating them.
    +
         In the next commit we're about to add another site that wants to
         generate these reports. Refactor the logic into a shared function that
         can easily be reused.
    @@ builtin/receive-pack.c: static void update_shallow_info(struct command *commands
      	free(ref_status);
      }
      
    --static void report(struct command *commands, const char *unpack_status)
    +-static void report(struct command *commands, const struct strbuf *unpack_status)
     +/*
     + * Generate the response to be sent to the client invoking 'git-receive-pack(1)'.
     + * For v2 protocol, set `detailed_report` to true, which will also add detailed
     + * report per reference update.
     + */
     +static void generate_report(struct strbuf *buf, struct command *commands,
    -+			    const char *unpack_status,
    ++			    const struct strbuf *unpack_status,
     +			    enum report_status_version version)
      {
      	struct command *cmd;
    @@ builtin/receive-pack.c: static void update_shallow_info(struct command *commands
      
     -	packet_buf_write(&buf, "unpack %s\n",
     +	packet_buf_write(buf, "unpack %s\n",
    - 			 unpack_status ? unpack_status : "ok");
    + 			 unpack_status->len ? unpack_status->buf : "ok");
     -	for (cmd = commands; cmd; cmd = cmd->next) {
     -		if (!cmd->error_string)
     -			packet_buf_write(&buf, "ok %s\n",
    @@ builtin/receive-pack.c: static void update_shallow_info(struct command *commands
     -	strbuf_release(&buf);
     -}
     -
    --static void report_v2(struct command *commands, const char *unpack_status)
    +-static void report_v2(struct command *commands, const struct strbuf *unpack_status)
     -{
     -	struct command *cmd;
     -	struct strbuf buf = STRBUF_INIT;
     -	struct ref_push_report *report;
      
     -	packet_buf_write(&buf, "unpack %s\n",
    --			 unpack_status ? unpack_status : "ok");
    +-			 unpack_status->len ? unpack_status->buf : "ok");
      	for (cmd = commands; cmd; cmd = cmd->next) {
     +		struct ref_push_report *report;
      		int count = 0;
    @@ builtin/receive-pack.c: static void update_shallow_info(struct command *commands
     +	packet_buf_flush(buf);
     +}
     +
    -+static void report(struct command *commands, const char *unpack_status)
    -+{
    -+	struct strbuf buf = STRBUF_INIT;
    -+
    -+	generate_report(&buf, commands, unpack_status, REPORT_STATUS_V0);
    -+
    -+	if (use_sideband)
    -+		send_sideband(1, 1, buf.buf, buf.len, use_sideband);
    -+	else
    -+		write_or_die(1, buf.buf, buf.len);
    -+	strbuf_release(&buf);
    -+}
    -+
    -+static void report_v2(struct command *commands, const char *unpack_status)
    ++static void report(struct command *commands, const struct strbuf *unpack_status,
    ++		   enum report_status_version version)
     +{
     +	struct strbuf buf = STRBUF_INIT;
     +
    -+	generate_report(&buf, commands, unpack_status, REPORT_STATUS_V2);
    ++	generate_report(&buf, commands, unpack_status, version);
      
      	if (use_sideband)
      		send_sideband(1, 1, buf.buf, buf.len, use_sideband);
    +@@ builtin/receive-pack.c: int cmd_receive_pack(int argc,
    + 
    + 		switch (version) {
    + 		case REPORT_STATUS_V2:
    +-			report_v2(commands, &unpack_status);
    +-			break;
    + 		case REPORT_STATUS_V0:
    +-			report(commands, &unpack_status);
    ++			report(commands, &unpack_status, version);
    + 			break;
    + 		default:
    + 			BUG("unknown report status version");
4:  a3d7576e58 ! 4:  262c8f1708 hook: introduce the receive-report hook
    @@ builtin/receive-pack.c: static void update_shallow_info(struct command *commands
      
     +static void override_cmds_error(struct command *commands, const char *err)
     +{
    -+	for (struct command *cmd = commands; cmd; cmd = cmd->next) {
    ++	for (struct command *cmd = commands; cmd; cmd = cmd->next)
     +		cmd->error_string = err;
    -+	}
     +}
     +
      /*
       * Generate the response to be sent to the client invoking 'git-receive-pack(1)'.
       * For v2 protocol, set `detailed_report` to true, which will also add detailed
    -@@ builtin/receive-pack.c: static void report(struct command *commands, const char *unpack_status)
    +@@ builtin/receive-pack.c: static void report(struct command *commands, const struct strbuf *unpack_status,
      
    - 	generate_report(&buf, commands, unpack_status, REPORT_STATUS_V0);
    + 	generate_report(&buf, commands, unpack_status, version);
      
     +	if (run_receive_report_hook(&buf)) {
     +		strbuf_reset(&buf);
     +		override_cmds_error(commands, "receive-report hook failed");
     +		generate_report(&buf, commands, unpack_status, false);
     +	}
    -+
    - 	if (use_sideband)
    - 		send_sideband(1, 1, buf.buf, buf.len, use_sideband);
    - 	else
    -@@ builtin/receive-pack.c: static void report_v2(struct command *commands, const char *unpack_status)
    - 
    - 	generate_report(&buf, commands, unpack_status, REPORT_STATUS_V2);
    - 
    -+	if (run_receive_report_hook(&buf)) {
    -+		strbuf_reset(&buf);
    -+		override_cmds_error(commands, "receive-report hook failed");
    -+		generate_report(&buf, commands, unpack_status, true);
    -+	}
     +
      	if (use_sideband)
      		send_sideband(1, 1, buf.buf, buf.len, use_sideband);

---
base-commit: 3cb9185f65410273787f74333cc027d2ea5daada
change-id: 20260812-758-introduce-hook-5b3af9f1a7e8


Thanks
- Karthik

