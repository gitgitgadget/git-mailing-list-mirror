Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 891F2376A0C
	for <git@vger.kernel.org>; Tue,  1 Sep 2026 15:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788275973; cv=none; b=P0FuCaODiPX1z8zQa0tcOkuOqZS1+LHhIb9qAYGI6qV2NxIYryFHxYitjFlV2zwk43/0gaeYylhkQkwNeXKMLMPcIaHPPWZjZ2DwTi6vBeEiMfOMGlX/Ddp/pYK842aVjuxg0hSqEOQzSBjV3WIcg4Xjz+twVO4+MdfvZE6yHyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788275973; c=relaxed/simple;
	bh=9kxFWb9BWVlMFhlJR0zidlHiwDEJ5DG2o+rIYm3R19c=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=g8r8vpfsXD9hHNhhGKHWNidYx1cQKqrI34m8tuzxyjqrC923zGw0mLuNccRfdTHM+lT8/yUwsqvCeQ6bwvpARXzKoFD6Ob+uhbTk7mmYIjseh5f2NJn5uF4mhdvrf78wq6WKpUo4/ydskoZecLPynd/zdjLfC/NrLDo78Puc62g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qGSBW2p4; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qGSBW2p4"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-499ae1c6471so35528325e9.3
        for <git@vger.kernel.org>; Tue, 01 Sep 2026 08:19:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788275970; x=1788880770; darn=vger.kernel.org;
        h=cc:to:references:in-reply-to:content-transfer-encoding:content-type
         :mime-version:message-id:date:subject:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=s/mpQpnl6TeyoduxHoLEwZwcx1qZJzGSvLer9BwDvBE=;
        b=qGSBW2p4hIxX5UUjQdEciMwPy3D4I8rvCuqdAr0hzWjzRj1iO1O297UFTtyTNRNujQ
         7H/LMR9F7Eyi+v/ZumXDtHxVoAzIL8DSH3CC0ivWthgSAikZUHUzx1SbLI0/3piPb8GX
         RGWNRFqnaTmUqCGvyccaHpO4OrkKv32E2aYx4hjd0cnSUfsGukrmznQQNBInKee9HQyN
         C+Juo1XBm9mQzIeNxR9LrBQdZ7UmWD21pL0gzQ5RErjiXMBiXXgWhz/AYiTDtvJgmogl
         /8C4d5zNT01pimW+++TjFzpe0nAtl/EwIBuwuPZ1fZ7VjxJrXNdFa880BRbLDxhgJF1t
         goQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788275970; x=1788880770;
        h=cc:to:references:in-reply-to:content-transfer-encoding:content-type
         :mime-version:message-id:date:subject:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=s/mpQpnl6TeyoduxHoLEwZwcx1qZJzGSvLer9BwDvBE=;
        b=cSDSNf+LZwclbW8tpLcUbqCvPlxfvVLY1YgJekTJhErYFxKmMqOmd/hDx7MoCXEFkB
         nrbGcQhYxc6EcW0TDz0KXUH4H2FWylD+3NQQ9Qo/B8SImuZAFdurR7nkKLfxawLmzI+r
         X5Nr/tZ+8DL/V22fDZyOEbw3Wv/HCSFZtCykjIBwCLVB1Wbxae+u1MumYKzRun0cmc2r
         RK+CguM60PgqBrBtDYDIobuFmxeurt8fFKNpUWJKd+KdRdqoPIlrb90cUCEpg8jbz2Ic
         GlgfcXqZOO4qOZSlOkupzKUfHkdMS/ZHhnLo6w8OQw/O/dlIbBmSOtp9BeL45z2+igwU
         OWxA==
X-Gm-Message-State: AFuF++nDBJDrxccdT8cgs2sCKtlztkT4Ch3kACatqcrtyW5ycW3xYP1g
	pru2eX6iue4UzVRNEyUZegRBRCvz+LmDLeXrfcI4ns5iyJOPOP9KLk94
X-Gm-Gg: AR+sD121NLjESGcn4z4fJgCbmYyMDA7Dlxw7lOpi+JN+5yZbc+V0TQ4thutLvYPgtRE
	6P59GntV5vdjukifLefstN/7m2bloDypeM4XzU0mv/x/cfuVHG6usp9EfxSTo71l7Qp3ZWvcPp+
	tZQxmXh8BKvlC9uhwfaZDklJ3LcgRbFtRd+X6zXx23dSsMq3MSkkJVQMOon4yvWQp2BmKshDYf1
	MizxlFVKZVLILQ7jhkyDKMI08O2NTezFv/RU+p5OIXK06MhcWrcb6ar7N1URimpsV42bd2N1qwI
	OOxjNWbPQvycZzqF8NaMvzkh3O6Vj4gIxdlThBTpDbBzsXNkdM+9Xc5ryT1+HEtKw7bJs/qIlo5
	MTaJ5+CCaIkNi84ADNJQ6PmTdN3yQBsA6NyBC2TGzEmUO6umtx51+TJCLSj1A5nij2fDhWZ7PJ7
	AoVprioN/R0QliyPOElzH5Xb1gEz8/XAFMboCbWDeXOcFL+iBAB2cBIaf26MzcJaNPYLKkK+44W
	7EacsMGQCFaQZDTVOpduRXd8cs=
X-Received: by 2002:a05:600c:c11c:b0:499:b65d:1250 with SMTP id 5b1f17b1804b1-49cdc422c5bmr168453325e9.2.1788275969170;
        Tue, 01 Sep 2026 08:19:29 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:8109:d906:4e00:645f:6387:edab:db53])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49ce309e418sm17270605e9.13.2026.09.01.08.19.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 08:19:28 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v5 0/3] hook: introduce the receive-report hook
Date: Tue, 01 Sep 2026 17:19:22 +0200
Message-Id: <20260901-758-introduce-hook-v5-0-35cdc6be3cc1@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/23NTW7CMBCG4asgr2tkT/zLinsgFo4zJm5LjOwQt
 UK5Ow5VpQhl+Ukzz/sgBXPEQg67B8k4xRLTUIf82BHfu+GCNHZ1E2CgmOFAtTQ0DmNO3d0j7VP
 6orJtXLCBO42G1MdbxhB/Xujp/LfLvf1EPy7SctHHMqb8+6pOfLn7D5itwMQpp8aZzlhU0jTme
 Lm6+L336UqWwAQrAvgmAZVAyxCCdh58eCeaNSE2iYYyKqyVoAJzTME7IdaE2iREJVTLhdXSdVb
 qNTHP8xPQ26LLjwEAAA==
X-Change-ID: 20260812-758-introduce-hook-5b3af9f1a7e8
In-Reply-To: <20260818-758-introduce-hook-v1-1-8a8d89e65838@gmail.com>
References: <20260818-758-introduce-hook-v1-1-8a8d89e65838@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im, gitster@pobox.com, jltobler@gmail.com, 
 kristofferhaugsbakk@fastmail.com, Karthik Nayak <karthik.188@gmail.com>, 
 Phillip Wood <phillip.wood@dunelm.org.uk>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=14052;
 i=karthik.188@gmail.com; h=from:subject:message-id;
 bh=9kxFWb9BWVlMFhlJR0zidlHiwDEJ5DG2o+rIYm3R19c=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGqW7P7DhRHuDGNZ9Mo1RGOs66JQFO1HapT0d
 GahA0Mgybgja4kBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJqluz+AAoJED7VnySO
 Rox/IZ8MAJGDpQdFAMu8Dnd3/YAb1taNfxEVPzpT0I3w22krCGARA6K1ThYK3jyQc1MT9cNn8+Y
 SeN4DnYluJK4kOFgTXAjo6Dt0iTaRLlwHrxjBGDam2sO81HmkUk8nI6oZQ6JD3BhNp5Bt0bXSNB
 kI7cX1Q7S/lBaXUGSSm0kSWFkyp5APchLWVaKAToUDcbm2Zzciv4zhIBDw/D01CluHhxCtXSQ2N
 CMlViUATGjcjDRqethGrivO0OMgMfeJIBdHJlxRemvvUkE3VsSpRTYPNdEYD0E7qBk7vnacQzr5
 BELZwxNqSJ62WGEGJxLmvi1eyKH9+o4omoT8lofUQH1iu9nZQi02chVs46CsfHbMaEXWNFkFnt7
 ilARagNg5uNtACncePcN2Lr0p7VYfFljOQ35Y61tgoA2OjOMxCRKn9spZNShqg7vojzuDi1cW09
 yhVAEeQQ1g6zSG8Kx1Ir12s3VNVjQcQGsoD8dJooEPco430U81X8RTt6KVqFRrXDnZDx/QtYh11
 D0=
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
Karthik Nayak (3):
      doc: add proc-receive hook info in 'git-receive-pack.adoc'
      receive-pack: move message generation to separate function
      hook: introduce the receive-report hook

 Documentation/git-receive-pack.adoc |  17 +++
 Documentation/githooks.adoc         |  47 ++++++++
 builtin/receive-pack.c              | 132 +++++++++++++++------
 t/meson.build                       |   1 +
 t/t5412-receive-report-hook.sh      | 224 ++++++++++++++++++++++++++++++++++++
 5 files changed, 384 insertions(+), 37 deletions(-)

Range-diff versus v4:

1:  6b173f391d < -:  ---------- doc: add proc-receive hook info in 'git-receive-pack.adoc'
-:  ---------- > 1:  cb32302829 doc: add proc-receive hook info in 'git-receive-pack.adoc'
2:  24e3e651ff ! 2:  ad3394490e receive-pack: move message generation to separate function
    @@ Metadata
      ## Commit message ##
         receive-pack: move message generation to separate function
     
    -    Post the reference transaction, both `report()` and `report_v2()`
    -    generate the message to be sent to the client. In v2, we also add
    -    reports for each reference if available. Since they share common code,
    -    move them to a common function. This will also help the following
    -    commit, where we will need to regenerate the message during hook
    -    failure.
    +    After git-receive-pack(1) has committed the reference updates, we call
    +    either `report()` or `report_v2()` to report to the client which of the
    +    references we have updated successfully and which updates have failed.
    +    The only difference between those two functions is that the latter also
    +    knows to provide a more detailed report about how exactly a given
    +    reference was updated.
     
    +    In the next commit we're about to add another site that wants to
    +    generate these reports. Refactor the logic into a shared function that
    +    can easily be reused.
    +
    +    Helped-by: Patrick Steinhardt <ps@pks.im>
         Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
     
      ## builtin/receive-pack.c ##
    @@ builtin/receive-pack.c: static void update_shallow_info(struct command *commands
     -static void report(struct command *commands, const char *unpack_status)
     +/*
     + * Generate the response to be sent to the client invoking 'git-receive-pack(1)'.
    -+ * For v2 protocol, set `add_reports` to true, which will also add additional
    ++ * For v2 protocol, set `detailed_report` to true, which will also add detailed
     + * report per reference update.
     + */
    -+static void generate_response(struct strbuf *buf, struct command *commands,
    -+			      const char *unpack_status, bool add_reports)
    ++static void generate_report(struct strbuf *buf, struct command *commands,
    ++			    const char *unpack_status, bool detailed_report)
      {
      	struct command *cmd;
     -	struct strbuf buf = STRBUF_INIT;
    @@ builtin/receive-pack.c: static void update_shallow_info(struct command *commands
     +		else
     +			packet_buf_write(buf, "ok %s\n", cmd->ref_name);
     +
    -+		if (!add_reports || cmd->error_string)
    ++		if (!detailed_report || cmd->error_string)
      			continue;
     -		}
     -		packet_buf_write(&buf, "ok %s\n",
    @@ builtin/receive-pack.c: static void update_shallow_info(struct command *commands
     +{
     +	struct strbuf buf = STRBUF_INIT;
     +
    -+	generate_response(&buf, commands, unpack_status, false);
    ++	generate_report(&buf, commands, unpack_status, false);
     +
     +	if (use_sideband)
     +		send_sideband(1, 1, buf.buf, buf.len, use_sideband);
    @@ builtin/receive-pack.c: static void update_shallow_info(struct command *commands
     +{
     +	struct strbuf buf = STRBUF_INIT;
     +
    -+	generate_response(&buf, commands, unpack_status, true);
    ++	generate_report(&buf, commands, unpack_status, true);
      
      	if (use_sideband)
      		send_sideband(1, 1, buf.buf, buf.len, use_sideband);
3:  d6c98d2693 ! 3:  a24ca1141d hook: introduce the receive-report hook
    @@ Commit message
         Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
     
      ## Documentation/git-receive-pack.adoc ##
    -@@ Documentation/git-receive-pack.adoc: requests. It handles refs whose names match the patterns defined by
    - `receive.procReceiveRefs` and executes the actual ref updates. See
    - linkgit:githooks[5] for the full protocol description.
    +@@ Documentation/git-receive-pack.adoc: commands will be executed by this hook, instead of by the internal
    + `execute_commands()` function.  This hook is responsible for updating
    + the relevant references and reporting the results back to 'receive-pack'.
      
     +RECEIVE-REPORT HOOK
     +-------------------
     +This hook is invoked by 'git-receive-pack' after all the ref updates
     +have been applied but before the report is sent to the client. The hook
     +receives the complete report in pkt-line format on stdin and its stdout
    -+replaces the report sent to the client. Allowing the hook to rewrite
    ++replaces the report sent to the client, which allows the hook to rewrite
     +the outcomes or abort the push completely. See linkgit:githooks[5] for
     +the full protocol description.
     +
    @@ Documentation/githooks.adoc: The exit status of the hook is ignored for any stat
     +fully buffered by `receive-pack` before any data is sent to the client,
     +so the hook's exit status is known before the client receives anything.
     +
    -+There are two distinct ways the hook can affect the push outcome:
    ++There are three distinct ways the hook can affect the push outcome:
    ++
    ++* To reject the push, modify the unpack status from `ok` to the required
    ++  error message. While `git-push` will fail, individual references may
    ++  still show success messages unless modified.
     +
     +* To reject individual ref updates while keeping `receive-pack` alive,
     +  rewrite the corresponding `ok <refname>` lines to
    -+  `ng <refname> <reason>` lines in the output and exit with status 0.
    ++  `ng <refname>[ <reason>]` lines in the output and exit with status 0.
     +  The client will then mark those specific refs as rejected while
     +  treating any `ok` refs as successful. The push as a whole is
     +  considered failed if any ref is `ng`, and `git push` will exit with
    @@ builtin/receive-pack.c: static int run_update_hook(struct command *cmd)
      					       const char *refname)
      {
     @@ builtin/receive-pack.c: static void update_shallow_info(struct command *commands,
    -  * Generate the response to be sent to the client invoking 'git-receive-pack(1)'.
    -  * For v2 protocol, set `add_reports` to true, which will also add additional
    -  * report per reference update.
    -+ * If `ref_error` is set, then all references will be rejected with the given
    -+ * error message.
    -  */
    - static void generate_response(struct strbuf *buf, struct command *commands,
    --			      const char *unpack_status, bool add_reports)
    -+			      const char *unpack_status, bool add_reports,
    -+			      const char *ref_error)
    - {
    - 	struct command *cmd;
    - 
    -@@ builtin/receive-pack.c: static void generate_response(struct strbuf *buf, struct command *commands,
    - 		if (cmd->error_string)
    - 			packet_buf_write(buf, "ng %s %s\n",
    - 					 cmd->ref_name, cmd->error_string);
    -+		else if (ref_error)
    -+			packet_buf_write(buf, "ng %s %s\n",
    -+					 cmd->ref_name, ref_error);
    - 		else
    - 			packet_buf_write(buf, "ok %s\n", cmd->ref_name);
    - 
    --		if (!add_reports || cmd->error_string)
    -+		if (!add_reports || cmd->error_string || ref_error)
    - 			continue;
    + 	free(ref_status);
    + }
      
    - 		for (report = cmd->report; report; report = report->next) {
    ++static void override_cmds_error(struct command *commands, const char *err)
    ++{
    ++	for (struct command *cmd = commands; cmd; cmd = cmd->next) {
    ++		cmd->error_string = err;
    ++	}
    ++}
    ++
    + /*
    +  * Generate the response to be sent to the client invoking 'git-receive-pack(1)'.
    +  * For v2 protocol, set `detailed_report` to true, which will also add detailed
     @@ builtin/receive-pack.c: static void report(struct command *commands, const char *unpack_status)
    - {
    - 	struct strbuf buf = STRBUF_INIT;
      
    --	generate_response(&buf, commands, unpack_status, false);
    -+	generate_response(&buf, commands, unpack_status, false, NULL);
    -+
    + 	generate_report(&buf, commands, unpack_status, false);
    + 
     +	if (run_receive_report_hook(&buf)) {
     +		strbuf_reset(&buf);
    -+		generate_response(&buf, commands, unpack_status, false,
    -+				  "receive-report hook failed");
    ++		override_cmds_error(commands, "receive-report hook failed");
    ++		generate_report(&buf, commands, unpack_status, false);
     +	}
    - 
    ++
      	if (use_sideband)
      		send_sideband(1, 1, buf.buf, buf.len, use_sideband);
    + 	else
     @@ builtin/receive-pack.c: static void report_v2(struct command *commands, const char *unpack_status)
    - {
    - 	struct strbuf buf = STRBUF_INIT;
      
    --	generate_response(&buf, commands, unpack_status, true);
    -+	generate_response(&buf, commands, unpack_status, true, NULL);
    -+
    + 	generate_report(&buf, commands, unpack_status, true);
    + 
     +	if (run_receive_report_hook(&buf)) {
     +		strbuf_reset(&buf);
    -+		generate_response(&buf, commands, unpack_status, true,
    -+			  "receive-report hook failed");
    ++		override_cmds_error(commands, "receive-report hook failed");
    ++		generate_report(&buf, commands, unpack_status, true);
     +	}
    - 
    ++
      	if (use_sideband)
      		send_sideband(1, 1, buf.buf, buf.len, use_sideband);
    + 	else
     
      ## t/meson.build ##
     @@ t/meson.build: integration_tests = [
    @@ t/t5412-receive-report-hook.sh (new)
     +	test_cmp expect actual
     +'
     +
    ++test_expect_success "hook can modify the unpack status" '
    ++	test_when_finished "rm -rf upstream" &&
    ++	test_when_finished "git -C workbench remote remove origin" &&
    ++
    ++	git init --bare upstream &&
    ++	git -C workbench remote add origin ../upstream &&
    ++	git -C workbench push origin $A:refs/heads/main &&
    ++
    ++	test_hook -C upstream --setup receive-report <<-\EOF &&
    ++	test-tool pkt-line unpack |
    ++	sed "s/^unpack ok$/unpack push failed due to server error/" |
    ++	test-tool pkt-line pack
    ++	EOF
    ++
    ++	test_must_fail git -C workbench push origin $B:refs/heads/main >out 2>&1 &&
    ++	test_grep "error: remote unpack failed: push failed due to server error" out &&
    ++	make_user_friendly_and_stable_output <out >actual &&
    ++	cat >expect <<-\EOF &&
    ++	To ../upstream
    ++	   <COMMIT-A>..<COMMIT-B>  <COMMIT-B> -> main
    ++	EOF
    ++	test_cmp expect actual
    ++'
    ++
     +test_expect_success "hook can report a custom failure message" '
     +	test_when_finished "rm -rf upstream" &&
     +	test_when_finished "git -C workbench remote remove origin" &&

---
base-commit: 11c6700f10234578d10523faf35656ca491425c9
change-id: 20260812-758-introduce-hook-5b3af9f1a7e8


Thanks
- Karthik

