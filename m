Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19FC137A85D
	for <git@vger.kernel.org>; Thu,  3 Sep 2026 09:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788427694; cv=none; b=lM1ZnyQWdR+hbCWtZ+tA9kiUqmbPS4cxHjef59B17dJm175HAhzjahEYEaVadA8ALyfqSFeyUaC+pEY+5fy9nVNLGKYCrwatwh8rWHvDtn3zp7Onf8TJfTpkqKmAaS3GrImnx6DFWj4PiwXriMiNJqT3R2XvX6Qs+On/vYgF6X8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788427694; c=relaxed/simple;
	bh=Gy9QXw6HmT5RmqM3fecYA/BwZmi8DU7UnnTAizj8RBE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=FwWUgW0BhOHQkW1ZVHubg2fIDFz7URBKxrue5iBmdIXhMLXFzzFZ30Q/rsx/jvLpsbUW0YiPhR+ehf/eXOfc4QCFwA1kr4uDGWpy31PFm961OcmCpgQ7rJTrDWiBwPIloLNmdb2pX9YZb+FYqTuBrPPecL9vdbBfc8lF8TqPxM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rYrg5es7; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rYrg5es7"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-49a97714f5dso15619755e9.0
        for <git@vger.kernel.org>; Thu, 03 Sep 2026 02:28:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788427690; x=1789032490; darn=vger.kernel.org;
        h=cc:to:references:in-reply-to:content-transfer-encoding:content-type
         :mime-version:message-id:date:subject:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3qkVj9PJCzymaME3xFtIorRLU4OVuaLMfLygzdxcu58=;
        b=rYrg5es7nv/umYI2rRtVz71YIruDl9TtSWroONQEApsl1MX7xONi7pWLM2WH4IByiK
         49preuTaas+DIQ1TxRFvuJTLmbwbPvXfPUlHtLolvQP+BXdHKILrjL+hE9+FPNENq52Y
         Nlc2V1DkzbrbfpXm1TO2UtDezvLHLwhU/kf7gnSedQxGn4RO8laDFJcwN2PHVUDJsA8v
         wOBwl+6RaLOGhRPmwOQQ6URdo8QraxJiMFg/R5uWjtQaIGtUbGe2baE9ukvMjpIfT46v
         DuYc0m2joh+zUyKwOxMPlQ5hyuMckoLf+AFb5EHLU24SAdPmMs1GwQSnO0ty+/JXUsPT
         BBNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788427690; x=1789032490;
        h=cc:to:references:in-reply-to:content-transfer-encoding:content-type
         :mime-version:message-id:date:subject:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3qkVj9PJCzymaME3xFtIorRLU4OVuaLMfLygzdxcu58=;
        b=FojyPonEyGCAi1FCOqrWwQS9GCbyCfMgch3tqXG9UIcfX9RxTxd9qSvg1jHIvnljAQ
         FYCSc5dMhieWQhPQGsqKECT+mSAmlvMq+dP18TSe+hpPETS8WBwo2aViWEUqgwnzQyFo
         Td2x/kZew3KDt3XdJqULzeLOCxXN3Unamg7Do3eWWplylZF5QEJS7t7OonGjqQew3cud
         dL1efuNnk1mgqbmq6aghfW07HnbUIaZNyL7h++SBZ54U8w8rtA3eOOKHh80HGNiI6+yZ
         qGgBdRBiIwSgwQZNE3ZNBbtM4FFigJbzh9vGQx77D5YuIMdOSBYkhp5v3oAjXyUSnu6Y
         6nkg==
X-Gm-Message-State: AFuF++nqVFT7IN+3XhGPxmdcbqI2uU3pCtXj9mcu4F9pwwHT1w6swrdl
	p9wPWokACU4GCbhI9cZeG9C8TmaLDUHELNxWOmFCfFSngIEMCiXHOBRE
X-Gm-Gg: AYBFou3H6MuFWn+IsZIOStp+d6O1HkdWxv6OWbnbY5TJSVyvxrdOlWMi87LDfaSqtCj
	PWVLStKwJo3aIKuwPQQHF8RT/+kuZvs3ZlQ0oVAK4qyqx4iWov8OJCIUFVSBMfUL1AN1dqcPdxq
	GEBhmFRyC3lzkYuFYJRiI6ltoN2Rm+n1nrq9UCrASgXzL3igWjFN5DeTiJlvvnPwNnYdgFPvdyv
	IINZc7m07JvcasrzQ4jBuZJMj8TbG5NBbbsyWxfZm7pz+aXCc/rTuDO/WZ6Ew1NQB2dEM52XJwz
	DEGidNHGQ2BxB7P/tavXneaIDCXSDU+xS5jnrRPID+Yh9gRvdfUOZ51Ry4Zr3r8DtMoInxYS6yh
	jeiQOYhiCUwFBwoREX3OhMieh5z0QretBSi40gVLetduwm7QS435o++IXFQIhBWMkWvYLjbbkX1
	DvnoRGH3sqpbTm5QHE4acYPbhdYvqe9RKdeosq/y+CeR+bbt0MltGOtH1cxr34Zv0/wPtTWAwBI
	ys9Dp21uBIEPU8VvLZIlhkZ2n8=
X-Received: by 2002:a05:600c:c48f:b0:499:8aff:59b6 with SMTP id 5b1f17b1804b1-49ce582276dmr165893825e9.14.1788427689989;
        Thu, 03 Sep 2026 02:28:09 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:8109:d906:4e00:56e2:6e6b:ebf7:2587])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cee60d8a6sm55553105e9.10.2026.09.03.02.28.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 02:28:09 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v6 0/4] hook: introduce the receive-report hook
Date: Thu, 03 Sep 2026 11:27:57 +0200
Message-Id: <20260903-758-introduce-hook-v6-0-6283b1fb9b1c@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/23PzUrEMBQF4FcZsjaS/x9Xvoe4SJObadRpJOkUZ
 ei7m46IpWR54NzvcG+oQklQ0dPphgosqaY8taAeTsiPbjoDTqFlxAhTxFCGtTQ4TXPJ4eoBjzm
 /YzlwF22kToNB7fCzQExfd/Tl9TfX6/AGft6krTGmOufyfV9d6Nb7GzC9gYViio0zwVhQ0nDzf
 L649PHo8wVtAwvbEYx2CdYIsARY1M4zH48E3xOiS3BMsLBWMhWJI4odCbEnVJcQjVADFVZLF6z
 UR0L+E5b0H5GN4NIHrwbg3tM9sa7rDwBeYqLSAQAA
X-Change-ID: 20260812-758-introduce-hook-5b3af9f1a7e8
In-Reply-To: <20260818-758-introduce-hook-v1-1-8a8d89e65838@gmail.com>
References: <20260818-758-introduce-hook-v1-1-8a8d89e65838@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im, gitster@pobox.com, jltobler@gmail.com, 
 kristofferhaugsbakk@fastmail.com, Phillip Wood <phillip.wood@dunelm.org.uk>, 
 Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=11283;
 i=karthik.188@gmail.com; h=from:subject:message-id;
 bh=Gy9QXw6HmT5RmqM3fecYA/BwZmi8DU7UnnTAizj8RBE=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGqZPad3mwIEjp0iA557epWCiqncj2dWT8Wlt
 QirMBV3jJzYIIkBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJqmT2nAAoJED7VnySO
 Rox/tTEL/A/so/i/iBBTRnTJC2MWC05MVRSDYrlnh6MfeleeeY0y3V+JfOQP2d7F1VrGjNg1NQc
 LwX/q6KRzHIW7bPo5qrWE6iC2jsf8UTP5b6FEckjmNFpdH2Y6g0o90XwbkZpQSx1mKWxbYLbEVM
 pRigrNJ6tYxEidAzi62Ewd91HM3L2VEXVe23jQiJ7IyKQx9YfIgLYVfVzBFoW7tGziTyjM7Jl62
 gGFx45TUT3jslGfN2sNsL9Bl3MPqKyiQPv6PtGx6lUMmROhiuQZn6Uua2rU5xCHBXroEoOvrcfO
 aMGsQndvsE8k1B8UBP0J1zpy/l8CdTbrVuhuiRkaLZCkTB/PAzqRtniq7gvGV77VgcvUDNvTvQZ
 6GfdrxKnvyOOBNvTzi4RElG4taVXQom9MVzZ7GRqD+Sb1UV73JaMvBG8fefoSHjxvqF/ljuUjW2
 6Mh3BHbdm8DDATqtfJm1EtLkbeQ3Y+8prri0D0zmVCuyjuNIKIph1nAPytu+ro4QSa8oh/XXuu5
 18=
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
 builtin/receive-pack.c              | 157 +++++++++++++++++--------
 t/meson.build                       |   1 +
 t/t5412-receive-report-hook.sh      | 224 ++++++++++++++++++++++++++++++++++++
 5 files changed, 415 insertions(+), 45 deletions(-)

Range-diff versus v5:

1:  5b55286c7b = 1:  ac4272c0ed doc: add proc-receive hook info in 'git-receive-pack.adoc'
-:  ---------- > 2:  e635158b10 receive-pack: drop static variables to track report status version
2:  c4e0e8185a ! 3:  0d588b7e24 receive-pack: move message generation to separate function
    @@ builtin/receive-pack.c: static void update_shallow_info(struct command *commands
     + * report per reference update.
     + */
     +static void generate_report(struct strbuf *buf, struct command *commands,
    -+			    const char *unpack_status, bool detailed_report)
    ++			    const char *unpack_status,
    ++			    enum report_status_version version)
      {
      	struct command *cmd;
     -	struct strbuf buf = STRBUF_INIT;
    @@ builtin/receive-pack.c: static void update_shallow_info(struct command *commands
     +		else
     +			packet_buf_write(buf, "ok %s\n", cmd->ref_name);
     +
    -+		if (!detailed_report || cmd->error_string)
    ++		if (version != REPORT_STATUS_V2 || cmd->error_string)
      			continue;
     -		}
     -		packet_buf_write(&buf, "ok %s\n",
    @@ builtin/receive-pack.c: static void update_shallow_info(struct command *commands
     +{
     +	struct strbuf buf = STRBUF_INIT;
     +
    -+	generate_report(&buf, commands, unpack_status, false);
    ++	generate_report(&buf, commands, unpack_status, REPORT_STATUS_V0);
     +
     +	if (use_sideband)
     +		send_sideband(1, 1, buf.buf, buf.len, use_sideband);
    @@ builtin/receive-pack.c: static void update_shallow_info(struct command *commands
     +{
     +	struct strbuf buf = STRBUF_INIT;
     +
    -+	generate_report(&buf, commands, unpack_status, true);
    ++	generate_report(&buf, commands, unpack_status, REPORT_STATUS_V2);
      
      	if (use_sideband)
      		send_sideband(1, 1, buf.buf, buf.len, use_sideband);
3:  750a58166e ! 4:  ee4346b991 hook: introduce the receive-report hook
    @@ Commit message
         operations post reference transaction succeed. So reporting the correct
         message based on the outcome of these operations is important.
     
    +    The outcome of these operations is only known after `execute_commands()`
    +    has returned and before the report is written. There is no point in
    +    receive-pack where the server can act on that.
    +
         We cannot use any of the existing hooks as:
     
           - The pre-receive hook runs too early, as we haven't updated
    @@ Commit message
           - The update hook is too inefficient as it runs once per reference,
             and we cannot trivially determine the last update.
     
    -      - The reference-transaction hook cannot be used by us because we care
    -        about the phase where it was committed already. And while the hook
    -        fires in that phase, it does not allow the caller to modify the
    -        result in any capacity.
    +      - The reference-transaction hook is not suited for this. It fires from
    +        within `ref_transaction_commit()`, which is before the outcome we
    +        need to report is known, so there is no phase at which it could give
    +        us the answer. It also does not contain any knowledge regarding the
    +        push and cannot communicate with the clients.
    +
    +      - The proc-receive hook replaces execute_commands() for references
    +        matching 'receive.procReceiveRefs'. We need to gate the report for
    +        the push as a whole.
     
           - The post-receive and post-update hooks cannot be used as they run
             too late, at the point where we have already reported success to the
    @@ Commit message
         'remote:' lines on the client terminal. Writing to stderr alone does
         not affect the push outcome.
     
    -    Note that in either failure mode, ref updates already applied by
    -    execute_commands() are not rolled back. The hook can cause the client
    -    to perceive the push as failed, but cannot undo server-side changes.
    +    Reference updates applied by execute_commands() are not rolled back in
    +    either failure mode. The hook can cause the client to perceive the push
    +    as failed, but cannot undo server-side changes. This creates a
    +    divergence that the server cannot resolve: the client leaves its
    +    remote-tracking reference at the old value while the update is in fact
    +    applied, and a later fetch may reveal the update that the push reported
    +    as rejected.
    +
    +    The hook is therefore only appropriate for servers which can guarantee
    +    that a rejected update is not observable by any reader. In our case the
    +    transaction committed by execute_commands() produces a candidate version
    +    which is not visible to other readers and is only published once the
    +    subsequent operations succeed, so a report of 'ng' corresponds to a
    +    version that is discarded rather than published. On a repository where a
    +    committed reference update is immediately visible, rejecting a push from
    +    this hook would instead leave the pusher with a view that does not match
    +    the server.
     
         This hook does not use the config-based hook infrastructure, which
         supports running multiple scripts per hook event. This hook is a
    @@ Documentation/githooks.adoc: The exit status of the hook is ignored for any stat
     +to `ng` rolls back any ref changes that were already committed
     +server-side. The hook can cause the client to perceive the push as
     +failed, but cannot undo the server-side updates.
    ++
    ++This means that reporting a reference as `ng` makes the client believe
    ++the update did not happen while the server has in fact applied it. The
    ++client leaves its remote-tracking reference at its old value, and a
    ++later `git fetch` may reveal the very update that the push reported as
    ++rejected. Neither Git nor the server can reconcile this; only the user,
    ++by fetching again, will find out.
    ++
    ++This hook is therefore only appropriate for servers which can guarantee
    ++that a rejected update is not observable by any reader, for example
    ++because the committed transaction produces a candidate state that is
    ++discarded rather than published. On a repository where a committed
    ++reference update is immediately visible, using this hook to reject a
    ++push will leave the pusher with a view that does not match the server.
     +
      push-to-checkout
      ~~~~~~~~~~~~~~~~
    @@ builtin/receive-pack.c: static void update_shallow_info(struct command *commands
       * For v2 protocol, set `detailed_report` to true, which will also add detailed
     @@ builtin/receive-pack.c: static void report(struct command *commands, const char *unpack_status)
      
    - 	generate_report(&buf, commands, unpack_status, false);
    + 	generate_report(&buf, commands, unpack_status, REPORT_STATUS_V0);
      
     +	if (run_receive_report_hook(&buf)) {
     +		strbuf_reset(&buf);
    @@ builtin/receive-pack.c: static void report(struct command *commands, const char
      	else
     @@ builtin/receive-pack.c: static void report_v2(struct command *commands, const char *unpack_status)
      
    - 	generate_report(&buf, commands, unpack_status, true);
    + 	generate_report(&buf, commands, unpack_status, REPORT_STATUS_V2);
      
     +	if (run_receive_report_hook(&buf)) {
     +		strbuf_reset(&buf);

---
base-commit: 11c6700f10234578d10523faf35656ca491425c9
change-id: 20260812-758-introduce-hook-5b3af9f1a7e8


Thanks
- Karthik

