Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE631C282E7
	for <git@archiver.kernel.org>; Mon, 15 Aug 2022 00:54:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbiHOAyh (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 14 Aug 2022 20:54:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbiHOAyd (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 Aug 2022 20:54:33 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4346E7658
        for <git@vger.kernel.org>; Sun, 14 Aug 2022 17:54:30 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id h1so3230013wmd.3
        for <git@vger.kernel.org>; Sun, 14 Aug 2022 17:54:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc;
        bh=gVDkOGslC45IPb46yq5wVP1JsoZE3A38gQLmZBs+c6c=;
        b=Zx6jKSgXvCcT3/uDbsF4jF8LYW2ekZvcBdj5fPZ58+bzM4AK8BV79ZHm0wBrMC6bhL
         1dI7pZ8RN1zXv/nKJDOZIlvNyqyJR5zk1O+rEMeViw3ARzfWY+rOKKam542Oa9mB5oe+
         n9WW5LUsKwi1fgasArifWv2p26n+VHewYCkNhEjwtf3LhPaMwmZMAk6Yr2bBEN3j9EmT
         B46yzDnoOXL+2H6eVGz61HyQVl/dNzz0wd33BM1fR8oRkVAekO2jEWZFv8ZkfvpsO1D+
         BwZGyXANS3Y8/Wp0SC5U8tBq2e/m7pagdq7G8H7xY2fg4q2FCAShDbCZfl9VpHKvUPp0
         isfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc;
        bh=gVDkOGslC45IPb46yq5wVP1JsoZE3A38gQLmZBs+c6c=;
        b=nLOidh2KZ7drRf1L99EtYjnFJSklEEJSn7NZPQtOg090IyowEq+fW99EdXLUPsc3vh
         ubZXfTPisEkHY4vESH7yGPToRRVQoDDk/f6u316Rpyz9Vt9Rxh30kCq1/pF8f1Vr7sE8
         8TJL3sCZNBQ2Y8fv8OOCLkmtIcB5r0C47jtEqjB4hiF1wrObTmeoUYT/G6afCEY2Fw8S
         EvtUiMuV+Sop9cH962JadpcKkqoUhWFjWg9PViMtDcykExfCulCyA5od8aRUDKRTsoLM
         aqI5qmP3InRGOs25yePDfppn7fJW/zXgwG3O07fWdtPlxLwUhojiDUuPcly8yNijDwJe
         ceaQ==
X-Gm-Message-State: ACgBeo06/rULdbvycC697myVVHBtdr0PekyTJRsaS5AyckN3R7dP3aXP
        IHPq7Q7/rDo6BjXOF9aLJIB/BXC7rE0=
X-Google-Smtp-Source: AA6agR5PV/PSqwmuZFZ+IQK6+Docxif+Pbyxt9hB87zACxZ9g4waKZcPAXv09wEV27jZ32PJnQE3XA==
X-Received: by 2002:a7b:c399:0:b0:3a5:f3fb:85e0 with SMTP id s25-20020a7bc399000000b003a5f3fb85e0mr1743616wmj.38.1660524867035;
        Sun, 14 Aug 2022 17:54:27 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l23-20020a05600c2cd700b003a502c23f2asm8220640wmc.16.2022.08.14.17.54.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Aug 2022 17:54:26 -0700 (PDT)
Message-Id: <pull.1301.v2.git.git.1660524865.gitgitgadget@gmail.com>
In-Reply-To: <pull.1301.git.git.1659543457.gitgitgadget@gmail.com>
References: <pull.1301.git.git.1659543457.gitgitgadget@gmail.com>
From:   "Sun Chao via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 15 Aug 2022 00:54:22 +0000
Subject: [PATCH v2 0/3] hide-refs: add hook to force hide refs
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Sun Chao <16657101987@163.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Gerrit is implemented by JGit and is known as a centralized workflow system
which supports reference-level access control for repository. If we choose
to work in centralized workflow like what Gerrit provided, reference-level
access control is needed and we might add a reference filter hook hide-refs
to hide the private data.

This hook would be invoked by 'git-receive-pack' and 'git-upload-pack'
during the reference discovery phase, each reference and will be filtered
with this hook. The hook executes once with no arguments for each
'git-upload-pack' and 'git-receive-pack' process. Once the hook is invoked,
a version number and server process name ('uploadpack' or 'receive') will
send to it in pkt-line format, followed by a flush-pkt. The hook should
response with its version number.

During reference discovery phase, each reference will be filtered by this
hook. In the following example, the letter 'G' stands for 'git-receive-pack'
or 'git-upload-pack' and the letter 'H' stands for this hook. The hook
decides if the reference will be hidden or not, it sends result back in
pkt-line format protocol, a response "hide" the references will hide to the
client and can not fetch its private data even in protocol V2.

    # Version negotiation
    G: PKT-LINE(version=1\0uploadpack)
    G: flush-pkt
    H: PKT-LINE(version=1)
    H: flush-pkt

    # Send reference filter request to hook
    G: PKT-LINE(ref <refname>:<refname_full>)
    G: flush-pkt

    # Receive result from the hook.
    # Case 1: this reference is hidden
    H: PKT-LINE(hide)
    H: flush-pkt

    # Case 2: this reference can be advertised
    H: flush-pkt


To enable the hide-refs hook, we should config hiderefs with force: option,
eg:

    git config --add transfer.hiderefs force:refs/prefix1/
    git config --add uploadpack.hiderefs force:!refs/prefix2/


the hide-refs will be called during reference discovery phase and check each
matched reference, a 'hide' response means the reference will be hidden for
its private data and even the allowTipSHA1InWant or allowReachableSHA1InWant
is set to true.

Sun Chao (3):
  hide-refs: add hook to force hide refs
  t1419: add test cases for hide-refs hook
  doc: add documentation for the hide-refs hook

 Documentation/githooks.txt                    |  48 ++++
 Makefile                                      |   1 +
 builtin/receive-pack.c                        |   5 +-
 ls-refs.c                                     |   2 +-
 refs.c                                        | 221 +++++++++++++++++-
 refs.h                                        |   6 +
 serve.c                                       |   2 +
 t/helper/test-hide-refs.c                     | 152 ++++++++++++
 t/helper/test-tool.c                          |   1 +
 t/helper/test-tool.h                          |   1 +
 t/t1419-hide-refs-hook.sh                     | 142 +++++++++++
 t/t1419/common-functions.sh                   |  80 +++++++
 t/t1419/once-0000-abnormal-hide-refs-hook.sh  | 161 +++++++++++++
 ...test-0001-ls-remote-with-hide-refs-hook.sh |  77 ++++++
 ...st-0002-upload-pack-with-hide-refs-hook.sh | 122 ++++++++++
 ...t-0003-receive-pack-with-hide-refs-hook.sh |  87 +++++++
 upload-pack.c                                 |  32 +--
 upload-pack.h                                 |   1 +
 18 files changed, 1111 insertions(+), 30 deletions(-)
 create mode 100644 t/helper/test-hide-refs.c
 create mode 100755 t/t1419-hide-refs-hook.sh
 create mode 100644 t/t1419/common-functions.sh
 create mode 100644 t/t1419/once-0000-abnormal-hide-refs-hook.sh
 create mode 100644 t/t1419/test-0001-ls-remote-with-hide-refs-hook.sh
 create mode 100644 t/t1419/test-0002-upload-pack-with-hide-refs-hook.sh
 create mode 100644 t/t1419/test-0003-receive-pack-with-hide-refs-hook.sh


base-commit: afa70145a25e81faa685dc0b465e52b45d2444bd
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1301%2Fsunchao9%2Frefs_advertise-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1301/sunchao9/refs_advertise-v2
Pull-Request: https://github.com/git/git/pull/1301

Range-diff vs v1:

 1:  b4b5ce5a361 ! 1:  3b8fb63cc78 refs-advertise: add hook to filter advertised refs
     @@ Metadata
      Author: Sun Chao <sunchao9@huawei.com>
      
       ## Commit message ##
     -    refs-advertise: add hook to filter advertised refs
     +    hide-refs: add hook to force hide refs
      
          Gerrit is implemented by JGit and is known as a centralized workflow system
          which supports reference-level access control for repository. If we choose
          to work in centralized workflow like what Gerrit provided, reference-level
     -    access control is needed and is possible if we add a reference advertise
     -    filter hook just like what Gerrit did.
     +    access control is needed and we might add a reference filter hook
     +    `hide-refs` to hide the private data.
      
          This hook would be invoked by 'git-receive-pack' and 'git-upload-pack'
     -    during the reference discovery phase and the commit fetching phase,
     -    each reference and will be filtered by this hook. The hook executes once
     -    with no arguments for each 'git-upload-pack' and 'git-receive-pack' process
     -    and if the exit status is non-zero, `git push` and `git fetch` will abort.
     -
     -    Once the hook is invoked, a version number and server process name
     -    ('git-upload-pack' or 'git-receive-pack' or 'ls-refs') should send to it in
     -    packet-line format, followed by a flush-pkt. The hook should response with
     -    its version number and process name list it support. If the list does not
     -    contains the server process name, the server will close the connection with
     -    the hook and keep going without the hook child process.
     +    during the reference discovery phase, each reference and will be filtered
     +    with this hook. The hook executes once with no arguments for each
     +    'git-upload-pack' and 'git-receive-pack' process. Once the hook is invoked,
     +    a version number and server process name ('uploadpack' or 'receive') will
     +    send to it in pkt-line format, followed by a flush-pkt. The hook should
     +    response with its version number.
      
          During reference discovery phase, each reference will be filtered by this
          hook. In the following example, the letter 'G' stands for 'git-receive-pack'
          or 'git-upload-pack' and the letter 'H' stands for this hook. The hook
     -    decides if the reference will be advertised or not, it sends result back in
     -    pkt-line format protocol, a response in "ok ref <ref>" format followed by a
     -    flush-pkt means the references "<ref>" can be advertised, and "ng ref <ref>"
     -    means not.
     -
     -        # Version negotiation
     -        G: PKT-LINE(version=1\0git-upload-pack)
     -        G: flush-pkt
     -        H: PKT-LINE(version=1\0git-upload-pack git-receive-pack ls-refs)
     -        H: flush-pkt
     +    decides if the reference will be hidden or not, it sends result back in
     +    pkt-line format protocol, a response "hide" the references will hide
     +    to the client and can not fetch its private data even in protocol V2.
      
     -        # Send reference filter request to hook
     -        G: PKT-LINE(ref <ref> <oid>)
     -        G: flush-pkt
     +            # Version negotiation
     +            G: PKT-LINE(version=1\0uploadpack)
     +            G: flush-pkt
     +            H: PKT-LINE(version=1)
     +            H: flush-pkt
      
     -        # Receive result from the hook.
     -        # Case 1: this reference is valid
     -        H: PKT-LINE(ok ref <ref>)
     -        H: flush-pkt
     -        # Case 2: this reference is filtered out
     -        H: PKT-LINE(ng ref <ref>)
     -        H: flush-pkt
     +            # Send reference filter request to hook
     +            G: PKT-LINE(ref <refname>:<refname_full>)
     +            G: flush-pkt
      
     -    During commit fetch phase of 'git-upload-pack' process, git client may send
     -    `want <oid>` requests and 'git-upload-pack' will send object filter requests
     -    to the hook to check if the object "<oid>" will be sent to the client or
     -    not. In the following example, the letter 'G' stands for 'git-upload-pack'
     -    and the letter 'H' stands for this hook.
     +            # Receive result from the hook.
     +            # Case 1: this reference is hidden
     +            H: PKT-LINE(hide)
     +            H: flush-pkt
      
     -    The hook will decides if a commit will be sent to the client or not, it
     -    sends result in pkt-line format protocol to `git-upload-pack`, a response
     -    with "ok obj <oid>" format followed by a flush-pkt means the object "<oid>"
     -    can be sent to client, and "ng obj <oid>" means not.
     +            # Case 2: this reference can be advertised
     +            H: flush-pkt
      
     -        # Version negotiation
     -        G: PKT-LINE(version=1\0ls-refs)
     -        G: flush-pkt
     -        H: PKT-LINE(version=1\0git-upload-pack git-receive-pack ls-refs)
     -        H: flush-pkt
     +    To enable the `hide-refs` hook, we should config hiderefs with `force:`
     +    option, eg:
      
     -        # Send commit filter request to hook
     -        G: PKT-LINE(obj <oid>)
     -        G: flush-pkt
     +            git config --add transfer.hiderefs force:refs/prefix1/
     +            git config --add uploadpack.hiderefs force:!refs/prefix2/
      
     -        # Receive result from the hook.
     -        # Case 1: this object is valid
     -        H: PKT-LINE(ok obj <oid>)
     -        H: flush-pkt
     -        # Case 2: this object is filtered out
     -        H: PKT-LINE(ng obj <oid>)
     -        H: flush-pkt
     +    the `hide-refs` will be called during reference discovery phase and
     +    check each matched reference, a 'hide' response means the reference will
     +    be hidden for its private data and even the `allowTipSHA1InWant` or
     +    `allowReachableSHA1InWant` is set to true.
      
          Signed-off-by: Sun Chao <sunchao9@huawei.com>
      
     @@ Makefile: TEST_BUILTINS_OBJS += test-wildmatch.o
       TEST_BUILTINS_OBJS += test-windows-named-pipe.o
       TEST_BUILTINS_OBJS += test-write-cache.o
       TEST_BUILTINS_OBJS += test-xml-encode.o
     -+TEST_BUILTINS_OBJS += test-refs-advertise.o
     ++TEST_BUILTINS_OBJS += test-hide-refs.o
       
       # Do not add more tests here unless they have extra dependencies. Add
       # them in TEST_BUILTINS_OBJS above.
     -@@ Makefile: LIB_OBJS += refs/files-backend.o
     - LIB_OBJS += refs/iterator.o
     - LIB_OBJS += refs/packed-backend.o
     - LIB_OBJS += refs/ref-cache.o
     -+LIB_OBJS += refs/refs-advertise.o
     - LIB_OBJS += refspec.o
     - LIB_OBJS += remote.o
     - LIB_OBJS += replace-object.o
      
       ## builtin/receive-pack.c ##
     -@@
     - #include "commit-reach.h"
     - #include "worktree.h"
     - #include "shallow.h"
     -+#include "refs/refs-advertise.h"
     - 
     - static const char * const receive_pack_usage[] = {
     - 	N_("git receive-pack <git-dir>"),
      @@ builtin/receive-pack.c: static int show_ref_cb(const char *path_full, const struct object_id *oid,
     - 	if (ref_is_hidden(path, path_full))
     + 	struct oidset *seen = data;
     + 	const char *path = strip_namespace(path_full);
     + 
     +-	if (ref_is_hidden(path, path_full))
     ++	if (ref_is_hidden(path, path_full) || ref_is_force_hidden(path, path_full))
       		return 0;
       
     -+	if (filter_advertise_ref(path, oid)) {
     -+		return 0;
     -+	}
     -+
       	/*
     - 	 * Advertise refs outside our current namespace as ".have"
     - 	 * refs, so that the client can use them to minimize data
     -@@ builtin/receive-pack.c: static int delete_only(struct command *commands)
     - 	return 1;
     - }
     - 
     -+static void clean_refs_advertise_filter(void) {
     -+	clean_advertise_refs_filter();
     -+}
     -+
     - int cmd_receive_pack(int argc, const char **argv, const char *prefix)
     - {
     - 	int advertise_refs = 0;
     -@@ builtin/receive-pack.c: int cmd_receive_pack(int argc, const char **argv, const char *prefix)
     - 	if (!enter_repo(service_dir, 0))
     - 		die("'%s' does not appear to be a git repository", service_dir);
     +@@ builtin/receive-pack.c: static void reject_updates_to_hidden(struct command *commands)
     + 		strbuf_setlen(&refname_full, prefix_len);
     + 		strbuf_addstr(&refname_full, cmd->ref_name);
       
     -+	create_advertise_refs_filter("git-receive-pack");
     -+	atexit(clean_refs_advertise_filter);
     -+
     - 	git_config(receive_pack_config, NULL);
     - 	if (cert_nonce_seed)
     - 		push_cert_nonce = prepare_push_cert_nonce(service_dir, time(NULL));
     +-		if (!ref_is_hidden(cmd->ref_name, refname_full.buf))
     ++		if (!ref_is_hidden(cmd->ref_name, refname_full.buf) &&
     ++			!ref_is_force_hidden(cmd->ref_name, refname_full.buf))
     + 			continue;
     + 		if (is_null_oid(&cmd->new_oid))
     + 			cmd->error_string = "deny deleting a hidden ref";
      
       ## ls-refs.c ##
     -@@
     - #include "ls-refs.h"
     - #include "pkt-line.h"
     - #include "config.h"
     -+#include "run-command.h"
     -+#include "refs/refs-advertise.h"
     - 
     - static int config_read;
     - static int advertise_unborn;
     - static int allow_unborn;
     -+static struct string_list symref = STRING_LIST_INIT_DUP;
     - 
     - static void ensure_config_read(void)
     - {
      @@ ls-refs.c: static int send_ref(const char *refname, const struct object_id *oid,
     - {
     - 	struct ls_refs_data *data = cb_data;
     - 	const char *refname_nons = strip_namespace(refname);
     -+	const char *refname_to_filter = refname_nons;
       
       	strbuf_reset(&data->buf);
       
     -@@ ls-refs.c: static int send_ref(const char *refname, const struct object_id *oid,
     - 	if (!ref_match(&data->prefixes, refname_nons))
     +-	if (ref_is_hidden(refname_nons, refname))
     ++	if (mark_our_ref(refname_nons, refname, oid))
       		return 0;
       
     -+	if (!strcmp(refname_nons, "HEAD")) {
     -+		struct string_list_item *item = string_list_lookup(&symref, "HEAD");
     -+		if (item) {
     -+			refname_to_filter = (const char *)item->util;
     -+		}
     -+	}
     -+
     -+	if (filter_advertise_ref(refname_to_filter, oid))
     -+		return 0;
     -+
     - 	if (oid)
     - 		strbuf_addf(&data->buf, "%s %s", oid_to_hex(oid), refname_nons);
     - 	else
     -@@ ls-refs.c: static int send_ref(const char *refname, const struct object_id *oid,
     - 
     - static void send_possibly_unborn_head(struct ls_refs_data *data)
     - {
     -+	const char *symref_target;
     -+	struct string_list_item *item;
     - 	struct strbuf namespaced = STRBUF_INIT;
     - 	struct object_id oid;
     - 	int flag;
     - 	int oid_is_null;
     - 
     - 	strbuf_addf(&namespaced, "%sHEAD", get_git_namespace());
     --	if (!resolve_ref_unsafe(namespaced.buf, 0, &oid, &flag))
     -+	symref_target = resolve_ref_unsafe(namespaced.buf, 0, &oid, &flag);
     -+	if (!symref_target)
     - 		return; /* bad ref */
     - 	oid_is_null = is_null_oid(&oid);
     - 	if (!oid_is_null ||
     --	    (data->unborn && data->symrefs && (flag & REF_ISSYMREF)))
     -+	    (data->unborn && data->symrefs && (flag & REF_ISSYMREF))) {
     -+		item = string_list_append(&symref, "HEAD");
     -+		item->util = xstrdup(strip_namespace(symref_target));
     - 		send_ref(namespaced.buf, oid_is_null ? NULL : &oid, flag, data);
     -+	}
     - 	strbuf_release(&namespaced);
     - }
     - 
     -@@ ls-refs.c: static int ls_refs_config(const char *var, const char *value, void *data)
     - 	return parse_hide_refs_config(var, value, "uploadpack");
     + 	if (!ref_match(&data->prefixes, refname_nons))
     +
     + ## refs.c ##
     +@@
     + #include "lockfile.h"
     + #include "iterator.h"
     + #include "refs.h"
     ++#include "pkt-line.h"
     + #include "refs/refs-internal.h"
     + #include "run-command.h"
     + #include "hook.h"
     +@@ refs.c: char *shorten_unambiguous_ref(const char *refname, int strict)
       }
       
     -+static void clean_refs_advertise_filter(void) {
     -+	clean_advertise_refs_filter();
     -+}
     -+
     - int ls_refs(struct repository *r, struct packet_reader *request)
     + static struct string_list *hide_refs;
     +-
     ++static struct string_list *force_hide_refs;
     ++static struct strbuf hide_refs_section = STRBUF_INIT;
     + int parse_hide_refs_config(const char *var, const char *value, const char *section)
       {
     - 	struct ls_refs_data data;
     -@@ ls-refs.c: int ls_refs(struct repository *r, struct packet_reader *request)
     + 	const char *key;
     ++	int force = 0;
     ++
     + 	if (!strcmp("transfer.hiderefs", var) ||
     + 	    (!parse_config_key(var, section, NULL, NULL, &key) &&
     + 	     !strcmp(key, "hiderefs"))) {
     + 		char *ref;
     + 		int len;
     ++		int forcelen;
       
     - 	ensure_config_read();
     - 	git_config(ls_refs_config, NULL);
     -+	create_advertise_refs_filter("ls-refs");
     -+	atexit(clean_refs_advertise_filter);
     - 
     - 	while (packet_reader_read(request) == PACKET_READ_NORMAL) {
     - 		const char *arg = request->line;
     -
     - ## refs/refs-advertise.c (new) ##
     -@@
     -+#include "../cache.h"
     -+#include "../config.h"
     -+#include "../strbuf.h"
     -+#include "../hook.h"
     -+#include "../sigchain.h"
     -+#include "../pkt-line.h"
     -+#include "../refs.h"
     -+#include "../run-command.h"
     -+#include "connect.h"
     -+#include "ref-cache.h"
     -+#include "refs-advertise.h"
     + 		if (!value)
     + 			return config_error_nonbool(var);
      +
     -+struct advertise_refs_filter {
     -+	struct child_process proc;
     -+	struct packet_reader reader;
     -+};
     ++		forcelen = strlen("force:");
     ++		len = strlen(value);
     ++		if ((len >= forcelen) && !strncmp(value, "force:", forcelen)) {
     ++			if (len == forcelen)
     ++				return error(_("missing value for '%s' with force option"), var);
     ++
     ++			force = 1;
     ++			value += forcelen;
     ++		}
     ++
     + 		ref = xstrdup(value);
     + 		len = strlen(ref);
     + 		while (len && ref[len - 1] == '/')
     + 			ref[--len] = '\0';
     +-		if (!hide_refs) {
     +-			CALLOC_ARRAY(hide_refs, 1);
     +-			hide_refs->strdup_strings = 1;
     ++
     ++		if (force) {
     ++			if (!force_hide_refs) {
     ++				CALLOC_ARRAY(force_hide_refs, 1);
     ++				force_hide_refs->strdup_strings = 1;
     ++			}
     ++			string_list_append(force_hide_refs, ref);
     ++		} else {
     ++			if (!hide_refs) {
     ++				CALLOC_ARRAY(hide_refs, 1);
     ++				hide_refs->strdup_strings = 1;
     ++			}
     ++			string_list_append(hide_refs, ref);
     + 		}
     +-		string_list_append(hide_refs, ref);
     + 	}
      +
     -+static struct advertise_refs_filter *hook_filter = NULL;
     ++	if (hide_refs_section.len == 0) {
     ++		strbuf_addstr(&hide_refs_section, section);
     ++	}
      +
     -+void create_advertise_refs_filter(const char *command) {
     -+	struct advertise_refs_filter *filter;
     + 	return 0;
     + }
     + 
     +-int ref_is_hidden(const char *refname, const char *refname_full)
     ++static struct child_process *hide_refs_proc;
     ++static struct packet_reader *hide_refs_reader;
     ++static void create_hide_refs_process(void) {
      +	struct child_process *proc;
      +	struct packet_reader *reader;
      +	const char *hook_path;
     -+	int command_support = 0;
      +	int version = 0;
      +	int code;
      +
     -+	if (hook_filter != NULL)
     -+		return;
     -+
     -+	hook_path = find_hook("refs-advertise");
     ++	hook_path = find_hook("hide-refs");
      +	if (!hook_path) {
     -+		return;
     ++		die("can not find hide-refs hook");
      +	}
      +
     -+	filter = (struct advertise_refs_filter *) xcalloc (1, sizeof (struct advertise_refs_filter));
     -+	proc = &filter->proc;
     -+	reader = &filter->reader;
     ++	proc = (struct child_process *) xcalloc (1, sizeof (struct child_process));
     ++	reader = (struct packet_reader *) xcalloc (1, sizeof(struct packet_reader));
      +
      +	child_process_init(proc);
      +	strvec_push(&proc->args, hook_path);
      +	proc->in = -1;
      +	proc->out = -1;
     -+	proc->trace2_hook_name = "refs-advertise";
     ++	proc->trace2_hook_name = "hide-refs";
      +	proc->err = 0;
      +
      +	code = start_command(proc);
      +	if (code)
     -+		die("can not run hook refs-advertise");
     ++		die("can not run hook hide-refs");
      +
      +	sigchain_push(SIGPIPE, SIG_IGN);
      +
     @@ refs/refs-advertise.c (new)
      +	packet_reader_init(reader, proc->out, NULL, 0,
      +			   PACKET_READ_CHOMP_NEWLINE |
      +			   PACKET_READ_GENTLE_ON_EOF);
     -+	code = packet_write_fmt_gently(proc->in, "version=1%c%s", '\0', command);
     ++	code = packet_write_fmt_gently(proc->in, "version=1%c%s", '\0', hide_refs_section.buf);
      +	if (!code)
      +		code = packet_flush_gently(proc->in);
      +
      +	if (!code)
      +		for (;;) {
     -+			int linelen;
      +			enum packet_read_status status;
      +
      +			status = packet_reader_read(reader);
      +			if (status != PACKET_READ_NORMAL) {
     -+				/* Check whether refs-advertise exited abnormally */
     ++				/* Check whether hide-refs exited abnormally */
      +				if (status == PACKET_READ_EOF)
     -+					die("can not read version message from hook refs-advertise");
     ++					die("can not read version message from hook hide-refs");
      +				break;
      +			}
      +
      +			if (reader->pktlen > 8 && starts_with(reader->line, "version=")) {
      +				version = atoi(reader->line + 8);
     -+				linelen = strlen(reader->line);
     -+				if (linelen < reader->pktlen) {
     -+					const char *command_list = reader->line + linelen + 1;
     -+					if (parse_feature_request(command_list, command)) {
     -+						command_support = 1;
     -+					}
     -+				}
      +			}
      +		}
      +
      +	if (code)
     -+		die("can not read version message from hook refs-advertise");
     ++		die("can not read version message from hook hide-refs");
      +
      +	switch (version) {
      +	case 0:
     @@ refs/refs-advertise.c (new)
      +	case 1:
      +		break;
      +	default:
     -+		die(_("hook refs-advertise version '%d' is not supported"), version);
     ++		die(_("hook hide-refs version '%d' is not supported"), version);
      +	}
      +
      +	sigchain_pop(SIGPIPE);
      +
     -+	if (!command_support) {
     -+		close(proc->in);
     -+		close(proc->out);
     -+		kill(proc->pid, SIGTERM);
     -+		finish_command_in_signal(proc);
     -+		free(filter);
     -+
     -+		return;
     -+	}
     -+
     -+	hook_filter = filter;
     ++	hide_refs_proc = proc;
     ++	hide_refs_reader = reader;
      +	return;
      +}
      +
     -+void clean_advertise_refs_filter(void) {
     -+	struct child_process *proc;
     -+
     -+	if (!hook_filter) {
     -+		return;
     -+	}
     -+
     -+	proc = &hook_filter->proc;
     -+
     -+	close(proc->in);
     -+	close(proc->out);
     -+	kill(proc->pid, SIGTERM);
     -+	finish_command_in_signal(proc);
     -+	FREE_AND_NULL(hook_filter);
     -+}
     -+
     -+static int do_filter_advertise_ref(const char *refname, const struct object_id *oid) {
     -+	struct child_process *proc;
     -+	struct packet_reader *reader;
     ++static int ref_force_hidden_check(const char *refname, const char *refname_full)
     ++{
      +	struct strbuf buf = STRBUF_INIT;
     -+	char *oid_hex;
      +	int code;
     ++	int ret = 0;
     ++
     ++	if (!force_hide_refs) {
     ++		return 0;
     ++	}
      +
     -+	proc = &hook_filter->proc;
     -+	reader = &hook_filter->reader;
     -+	if (oid)
     -+		oid_hex = oid_to_hex(oid);
     -+	else
     -+		oid_hex = oid_to_hex(null_oid());
     ++	if (!hide_refs_proc) {
     ++		create_hide_refs_process();
     ++	}
      +
     -+	code = packet_write_fmt_gently(proc->in, "ref %s %s", refname, oid_hex);
     ++	sigchain_push(SIGPIPE, SIG_IGN);
     ++	code = packet_write_fmt_gently(hide_refs_proc->in, "ref %s:%s", refname, refname_full);
      +	if (code)
     -+		die("hook refs-advertise died abnormally");
     ++		die("hook hide-refs died abnormally");
      +
     -+	code = packet_flush_gently(proc->in);
     ++	code = packet_flush_gently(hide_refs_proc->in);
      +	if (code)
     -+		die("hook refs-advertise died abnormally");
     ++		die("hook hide-refs died abnormally");
      +
      +	for (;;) {
      +		enum packet_read_status status;
      +
     -+		status = packet_reader_read(reader);
     ++		status = packet_reader_read(hide_refs_reader);
      +		if (status != PACKET_READ_NORMAL) {
     -+			/* Check whether refs-advertise exited abnormally */
     ++			/* Check whether hide-refs exited abnormally */
      +			if (status == PACKET_READ_EOF)
     -+				die("hook refs-advertise died abnormally");
     ++				die("hook hide-refs died abnormally");
      +			break;
      +		}
      +
      +		strbuf_reset(&buf);
     -+		strbuf_addstr(&buf, reader->line);
     ++		strbuf_addstr(&buf, hide_refs_reader->line);
      +	}
      +
     -+	if (strncmp("ok ref ", buf.buf, 7))
     -+		return -1;
     ++	if (!strncmp("hide", buf.buf, 4))
     ++		ret = 1;
      +
     -+	if (strcmp(refname, buf.buf + 7))
     -+		return -1;
     -+
     -+	return 0;
     -+}
     -+
     -+int filter_advertise_ref(const char *refname, const struct object_id *oid) {
     -+	int result;
     -+
     -+	if (!hook_filter) {
     -+		return 0;
     -+	}
     -+
     -+	sigchain_push(SIGPIPE, SIG_IGN);
     -+	result = do_filter_advertise_ref(refname, oid);
      +	sigchain_pop(SIGPIPE);
     -+
     -+	return result;
     ++	return ret;
      +}
      +
     -+static int do_filter_advertise_object(const struct object_id *oid) {
     -+	struct child_process *proc;
     -+	struct packet_reader *reader;
     -+	struct strbuf buf = STRBUF_INIT;
     -+	char *oid_hex;
     -+	int code;
     -+
     -+	proc = &hook_filter->proc;
     -+	reader = &hook_filter->reader;
     -+	oid_hex = oid_to_hex(oid);
     -+
     -+	code = packet_write_fmt_gently(proc->in, "obj %s", oid_hex);
     -+	if (code)
     -+		die("hook refs-advertise died abnormally");
     -+
     -+	code = packet_flush_gently(proc->in);
     -+	if (code)
     -+		die("hook refs-advertise died abnormally");
     -+
     -+	for (;;) {
     -+		enum packet_read_status status;
     ++static int ref_hidden_check(const char *refname, const char *refname_full, int force)
     + {
     ++	struct string_list *hide_refs_list = hide_refs;
     + 	int i;
     + 
     +-	if (!hide_refs)
     ++	if (force)
     ++		hide_refs_list = force_hide_refs;
      +
     -+		status = packet_reader_read(reader);
     -+		if (status != PACKET_READ_NORMAL) {
     -+			/* Check whether refs-advertise exited abnormally */
     -+			if (status == PACKET_READ_EOF)
     -+				die("hook refs-advertise died abnormally");
     -+			break;
     ++	if (!hide_refs_list)
     + 		return 0;
     +-	for (i = hide_refs->nr - 1; i >= 0; i--) {
     +-		const char *match = hide_refs->items[i].string;
     ++	for (i = hide_refs_list->nr - 1; i >= 0; i--) {
     ++		const char *match = hide_refs_list->items[i].string;
     + 		const char *subject;
     + 		int neg = 0;
     + 		const char *p;
     +@@ refs.c: int ref_is_hidden(const char *refname, const char *refname_full)
     + 		/* refname can be NULL when namespaces are used. */
     + 		if (subject &&
     + 		    skip_prefix(subject, match, &p) &&
     +-		    (!*p || *p == '/'))
     +-			return !neg;
     ++		    (!*p || *p == '/')) {
     ++			if (neg)
     ++				return 0;
     ++			if (!force)
     ++				return 1;
     ++			return ref_force_hidden_check(refname, refname_full);
      +		}
     + 	}
     + 	return 0;
     + }
     + 
     ++int ref_is_hidden(const char *refname, const char *refname_full)
     ++{
     ++	return ref_hidden_check(refname, refname_full, 0);
     ++}
      +
     -+		strbuf_reset(&buf);
     -+		strbuf_addstr(&buf, reader->line);
     -+	}
     -+
     -+	if (strncmp("ok obj ", buf.buf, 7))
     -+		return -1;
     -+
     -+	if (strcmp(oid_hex, buf.buf + 7))
     -+		return -1;
     -+
     -+	return 0;
     ++int ref_is_force_hidden(const char *refname, const char *refname_full)
     ++{
     ++	return ref_hidden_check(refname, refname_full, 1);
      +}
      +
     -+int filter_advertise_object(const struct object_id *oid) {
     -+	int result;
     ++#define OUR_REF		(1u << 12)
     ++#define HIDDEN_REF	(1u << 19)
     ++#define HIDDEN_REF_FORCE	(1u << 20)
     ++static int has_force_hidden;
     ++int mark_our_ref(const char *refname, const char *refname_full,
     ++			const struct object_id *oid)
     ++{
     ++	struct object *o;
      +
     -+	if (!hook_filter || !oid) {
     ++	if (!oid || is_null_oid(oid)) {
      +		return 0;
      +	}
      +
     -+	sigchain_push(SIGPIPE, SIG_IGN);
     -+	result = do_filter_advertise_object(oid);
     -+	sigchain_pop(SIGPIPE);
     ++	o = lookup_unknown_object(the_repository, oid);
     ++	if (ref_is_force_hidden(refname, refname_full)) {
     ++		o->flags |= HIDDEN_REF_FORCE;
     ++		has_force_hidden = 1;
     ++		return 1;
     ++	}
     ++	if (ref_is_hidden(refname, refname_full)) {
     ++		o->flags |= HIDDEN_REF;
     ++		return 1;
     ++	}
     ++	o->flags |= OUR_REF;
     ++	return 0;
     ++}
      +
     -+	return result;
     ++int has_force_hidden_refs(void) {
     ++	return has_force_hidden;
      +}
     ++
     + const char *find_descendant_ref(const char *dirname,
     + 				const struct string_list *extras,
     + 				const struct string_list *skip)
     +
     + ## refs.h ##
     +@@ refs.h: int parse_hide_refs_config(const char *var, const char *value, const char *);
     +  * parameter always points to the full ref name.
     +  */
     + int ref_is_hidden(const char *, const char *);
     ++int ref_is_force_hidden(const char *, const char *);
     ++/* return non-zero if the ref is hidden, otherwise 0 */
     ++int mark_our_ref(const char *refname, const char *refname_full,
     ++			const struct object_id *oid);
     ++int has_force_hidden_refs(void);
     ++void lazy_load_hidden_refs(void);
     + 
     + enum ref_type {
     + 	REF_TYPE_PER_WORKTREE,	  /* refs inside refs/ but not shared       */
      
     - ## refs/refs-advertise.h (new) ##
     + ## serve.c ##
      @@
     -+#ifndef REFS_REFS_ADVERTISE_H
     -+#define REFS_REFS_ADVERTISE_H
     -+
     -+#include "../hash.h"
     -+
     -+void create_advertise_refs_filter(const char *command);
     -+void clean_advertise_refs_filter(void);
     -+int filter_advertise_ref(const char *refname, const struct object_id *oid);
     -+int filter_advertise_object(const struct object_id *oid);
     -+
     -+#endif
     + #include "cache.h"
     + #include "repository.h"
     + #include "config.h"
     ++#include "refs.h"
     + #include "pkt-line.h"
     + #include "version.h"
     + #include "ls-refs.h"
     +@@ serve.c: void protocol_v2_serve_loop(int stateless_rpc)
     + 	 * a single request/response exchange
     + 	 */
     + 	if (stateless_rpc) {
     ++		lazy_load_hidden_refs();
     + 		process_request();
     + 	} else {
     + 		for (;;)
      
     - ## t/helper/test-refs-advertise.c (new) ##
     + ## t/helper/test-hide-refs.c (new) ##
      @@
      +#include "cache.h"
      +#include "hash.h"
     @@ t/helper/test-refs-advertise.c (new)
      +#include "sigchain.h"
      +#include "test-tool.h"
      +
     -+static const char *refs_advertise_usage[] = {
     -+	"test-tool refs-advertise [<options>...]",
     ++static const char *hide_refs_usage[] = {
     ++	"test-tool hide-refs [<options>...]",
      +	NULL
      +};
      +
     -+static int can_upload_pack;
     -+static int can_receive_pack;
     -+static int can_ls_refs;
      +static int die_read_version;
      +static int die_write_version;
      +static int die_read_first_ref;
      +static int die_read_second_ref;
     -+static int die_filter_refs;
     -+static int upload_pack;
     -+static int receive_pack;
     -+static int ls_refs;
     ++static int die_after_proc_ref;
      +static int verbose;
      +static int version = 1;
      +static int first_ref;
     @@ t/helper/test-refs-advertise.c (new)
      +	char ref_name[FLEX_ARRAY]; /* more */
      +};
      +
     -+static void refs_advertise_verison(struct packet_reader *reader) {
     ++static void hide_refs_verison(struct packet_reader *reader) {
      +	int server_version = 0;
      +
      +	if (die_read_version)
      +		die("die with the --die-read-version option");
      +
      +	for (;;) {
     -+		int linelen;
     -+
      +		if (packet_reader_read(reader) != PACKET_READ_NORMAL)
      +			break;
      +
     @@ t/helper/test-refs-advertise.c (new)
      +			server_version = atoi(reader->line+8);
      +			if (server_version != 1)
      +				die("bad protocol version: %d", server_version);
     -+			linelen = strlen(reader->line);
     -+			if (linelen < reader->pktlen) {
     -+				const char *feature_list = reader->line + linelen + 1;
     -+				if (parse_feature_request(feature_list, "git-upload-pack"))
     -+					upload_pack = 1;
     -+				if (parse_feature_request(feature_list, "git-receive-pack"))
     -+					receive_pack = 1;
     -+				if (parse_feature_request(feature_list, "ls-refs"))
     -+					ls_refs = 1;
     -+			}
      +		}
      +	}
      +
      +	if (die_write_version)
      +		die("die with the --die-write-version option");
      +
     -+	if (can_upload_pack || can_receive_pack || can_ls_refs)
     -+		packet_write_fmt(1, "version=%d%c%s%s%s\n",
     -+				version, '\0',
     -+				can_upload_pack ? "git-upload-pack ": "",
     -+				can_receive_pack? "git-receive-pack ": "",
     -+				can_ls_refs? "ls-refs ": "");
     -+	else
     -+		packet_write_fmt(1, "version=%d\n", version);
     -+
     ++	packet_write_fmt(1, "version=%d\n", version);
      +	packet_flush(1);
     -+
     -+	if ((upload_pack && !can_upload_pack) ||
     -+		(receive_pack && !can_receive_pack) ||
     -+		(ls_refs && !can_ls_refs)) {
     -+			exit(0);
     -+	}
      +}
      +
     -+static void refs_advertise_read_refs(struct packet_reader *reader)
     ++static void hide_refs_proc(struct packet_reader *reader)
      +{
      +	const char *p;
      +	struct strbuf buf = STRBUF_INIT;
      +	enum packet_read_status status;
     -+	int filter_ok = 0;
      +
      +	if (!first_ref) {
      +		if (die_read_first_ref)
     @@ t/helper/test-refs-advertise.c (new)
      +		strbuf_addstr(&buf, reader->line);
      +	}
      +
     -+	p = buf.buf;
     -+
     -+	if (unsorted_string_list_has_string(&returns, p)) {
     -+		filter_ok = 1;
     -+	}
     -+
     -+	// if it's a ref filter request, we response without the commit id
     -+	if ((buf.len > (hash_size + 1)) && (strncmp("obj ", buf.buf, 4)))
     -+		strbuf_setlen(&buf, buf.len - (hash_size + 1));
     -+
     -+	if (filter_ok) {
     -+		packet_write_fmt(1, "%s %s\n", "ok", p);
     -+	} else {
     -+		packet_write_fmt(1, "%s %s\n", "ng", p);
     ++	p = strchr(buf.buf, ':');
     ++	if (unsorted_string_list_has_string(&returns, p + 1)) {
     ++		packet_write_fmt(1, "hide");
      +	}
      +
     -+	if (die_filter_refs)
     -+		die("die with the --die-filter-refs option");
     ++	if (die_after_proc_ref)
     ++		die("die with the --die-after-proc-refs option");
      +
      +	packet_flush(1);
      +}
      +
     -+int cmd__refs_advertise(int argc, const char **argv) {
     ++int cmd__hide_refs(int argc, const char **argv) {
      +	int nongit_ok = 0;
      +	struct packet_reader reader;
      +	const char *value = NULL;
      +	struct option options[] = {
     -+		OPT_BOOL(0, "can-upload-pack", &can_upload_pack,
     -+			 "support upload-pack command"),
     -+		OPT_BOOL(0, "can-receive-pack", &can_receive_pack,
     -+			 "support upload-pack command"),
     -+		OPT_BOOL(0, "can-ls-refs", &can_ls_refs,
     -+			 "support ls-refs command"),
      +		OPT_BOOL(0, "die-read-version", &die_read_version,
      +			 "die when reading version"),
      +		OPT_BOOL(0, "die-write-version", &die_write_version,
     @@ t/helper/test-refs-advertise.c (new)
      +			 "die when reading first reference"),
      +		OPT_BOOL(0, "die-read-second-ref", &die_read_second_ref,
      +			 "die when reading second reference"),
     -+		OPT_BOOL(0, "die-filter-refs", &die_filter_refs,
     -+			 "die when filtering refs"),
     -+		OPT_STRING_LIST('r', "return", &returns, "ref<SP>$refname<SP>$oid|obj<SP>$oid",
     -+				"refs or objects that can advertise"),
     ++		OPT_BOOL(0, "die-after-proc-refs", &die_after_proc_ref,
     ++			 "die after proc ref"),
     ++		OPT_STRING_LIST('r', "reserved", &returns, "refs-to-force-hidden",
     ++				"refs that will force hide"),
      +		OPT__VERBOSE(&verbose, "be verbose"),
      +		OPT_INTEGER('V', "version", &version,
      +			    "use this protocol version number"),
     @@ t/helper/test-refs-advertise.c (new)
      +
      +	setup_git_directory_gently(&nongit_ok);
      +
     -+	argc = parse_options(argc, argv, "test-tools", options, refs_advertise_usage, 0);
     ++	argc = parse_options(argc, argv, "test-tools", options, hide_refs_usage, 0);
      +	if (argc > 0)
     -+		usage_msg_opt("Too many arguments.", refs_advertise_usage, options);
     ++		usage_msg_opt("Too many arguments.", hide_refs_usage, options);
      +
      +	packet_reader_init(&reader, 0, NULL, 0, PACKET_READ_CHOMP_NEWLINE | PACKET_READ_GENTLE_ON_EOF);
      +
     @@ t/helper/test-refs-advertise.c (new)
      +			hash_size = GIT_SHA256_HEXSZ;
      +	}
      +
     -+	refs_advertise_verison(&reader);
     ++	hide_refs_verison(&reader);
      +	for (;;) {
     -+		refs_advertise_read_refs(&reader);
     ++		hide_refs_proc(&reader);
      +	}
      +
      +	return 0;
     @@ t/helper/test-tool.c: static struct test_cmd cmds[] = {
       	{ "regex", cmd__regex },
       	{ "repository", cmd__repository },
       	{ "revision-walking", cmd__revision_walking },
     -+	{ "refs-advertise", cmd__refs_advertise },
     ++	{ "hide-refs", cmd__hide_refs },
       	{ "run-command", cmd__run_command },
       	{ "scrap-cache-tree", cmd__scrap_cache_tree },
       	{ "serve-v2", cmd__serve_v2 },
     @@ t/helper/test-tool.h: int cmd__reftable(int argc, const char **argv);
       int cmd__regex(int argc, const char **argv);
       int cmd__repository(int argc, const char **argv);
       int cmd__revision_walking(int argc, const char **argv);
     -+int cmd__refs_advertise(int argc, const char **argv);
     ++int cmd__hide_refs(int argc, const char **argv);
       int cmd__run_command(int argc, const char **argv);
       int cmd__scrap_cache_tree(int argc, const char **argv);
       int cmd__serve_v2(int argc, const char **argv);
      
       ## upload-pack.c ##
      @@
     - #include "commit-graph.h"
     - #include "commit-reach.h"
     - #include "shallow.h"
     -+#include "refs/refs-advertise.h"
     - 
     - /* Remember to update object flag allocation in object.h */
     - #define THEY_HAVE	(1u << 11)
     -@@ upload-pack.c: static void receive_needs(struct upload_pack_data *data,
     - 		}
     - 
     - 		o = parse_object(the_repository, &oid_buf);
     --		if (!o) {
     -+		if ((!o) || (filter_advertise_object(&oid_buf))) {
     - 			packet_writer_error(&data->writer,
     - 					    "upload-pack: not our ref %s",
     - 					    oid_to_hex(&oid_buf));
     -@@ upload-pack.c: static int mark_our_ref(const char *refname, const char *refname_full,
     - 		o->flags |= HIDDEN_REF;
     - 		return 1;
     - 	}
     -+
     -+	if (filter_advertise_ref(refname, oid)) {
     -+		o->flags |= HIDDEN_REF;
     -+		return 1;
     -+	}
     -+
     - 	o->flags |= OUR_REF;
     - 	return 0;
     - }
     -@@ upload-pack.c: static void format_symref_info(struct strbuf *buf, struct string_list *symref)
     + #define NOT_SHALLOW	(1u << 17)
     + #define CLIENT_SHALLOW	(1u << 18)
     + #define HIDDEN_REF	(1u << 19)
     ++#define HIDDEN_REF_FORCE	(1u << 20)
       
     - 	if (!symref->nr)
     - 		return;
     --	for_each_string_list_item(item, symref)
     --		strbuf_addf(buf, " symref=%s:%s", item->string, (char *)item->util);
     -+	for_each_string_list_item(item, symref) {
     -+		if (!filter_advertise_ref((char *)item->util, NULL))
     -+			strbuf_addf(buf, " symref=%s:%s", item->string, (char *)item->util);
     -+	}
     - }
     - 
     - static void format_session_id(struct strbuf *buf, struct upload_pack_data *d) {
     -@@ upload-pack.c: static int send_ref(const char *refname, const struct object_id *oid,
     - 	static const char *capabilities = "multi_ack thin-pack side-band"
     - 		" side-band-64k ofs-delta shallow deepen-since deepen-not"
     - 		" deepen-relative no-progress include-tag multi_ack_detailed";
     --	const char *refname_nons = strip_namespace(refname);
     - 	struct object_id peeled;
     - 	struct upload_pack_data *data = cb_data;
     -+	const char *refname_nons = strip_namespace(refname);
     -+	const char *refname_to_filter = refname_nons;
     - 
     --	if (mark_our_ref(refname_nons, refname, oid))
     -+	if (!strcmp(refname_nons, "HEAD")) {
     -+		struct string_list_item *item = string_list_lookup(&data->symref, "HEAD");
     -+		if (item) {
     -+			refname_to_filter = (const char *)item->util;
     -+		}
     -+	}
     -+
     -+	if (mark_our_ref(refname_to_filter, refname, oid))
     - 		return 0;
     +-#define ALL_FLAGS (THEY_HAVE | OUR_REF | WANTED | COMMON_KNOWN | SHALLOW | \
     +-		NOT_SHALLOW | CLIENT_SHALLOW | HIDDEN_REF)
     ++#define ALL_FLAGS (THEY_HAVE |WANTED | COMMON_KNOWN | SHALLOW | \
     ++		NOT_SHALLOW | CLIENT_SHALLOW)
       
     - 	if (capabilities) {
     -@@ upload-pack.c: static void get_upload_pack_config(struct upload_pack_data *data)
     - 	git_protected_config(upload_pack_protected_config, data);
     + /* Enum for allowed unadvertised object request (UOR) */
     + enum allow_uor {
     +@@ upload-pack.c: static void receive_needs(struct upload_pack_data *data,
     + 		packet_flush(1);
       }
       
     -+static void clean_refs_advertise_filter(void) {
     -+	clean_advertise_refs_filter();
     -+}
     -+
     - void upload_pack(const int advertise_refs, const int stateless_rpc,
     - 		 const int timeout)
     +-/* return non-zero if the ref is hidden, otherwise 0 */
     +-static int mark_our_ref(const char *refname, const char *refname_full,
     +-			const struct object_id *oid)
     +-{
     +-	struct object *o = lookup_unknown_object(the_repository, oid);
     +-
     +-	if (ref_is_hidden(refname, refname_full)) {
     +-		o->flags |= HIDDEN_REF;
     +-		return 1;
     +-	}
     +-	o->flags |= OUR_REF;
     +-	return 0;
     +-}
     +-
     + static int check_ref(const char *refname_full, const struct object_id *oid,
     + 		     int flag, void *cb_data)
       {
     - 	struct packet_reader reader;
     - 	struct upload_pack_data data;
     - 
     -+	create_advertise_refs_filter("git-upload-pack");
     -+	atexit(clean_refs_advertise_filter);
     -+
     - 	upload_pack_data_init(&data);
     - 	get_upload_pack_config(&data);
     - 
     -@@ upload-pack.c: static int parse_want(struct packet_writer *writer, const char *line,
     - 		else
     - 			o = parse_object(the_repository, &oid);
     - 
     --		if (!o) {
     -+		if ((!o) || (filter_advertise_object(&oid))) {
     - 			packet_writer_error(writer,
     - 					    "upload-pack: not our ref %s",
     - 					    oid_to_hex(&oid));
      @@ upload-pack.c: static int parse_want_ref(struct packet_writer *writer, const char *line,
       
       		strbuf_addf(&refname, "%s%s", get_git_namespace(), refname_nons);
       		if (ref_is_hidden(refname_nons, refname.buf) ||
     --		    read_ref(refname.buf, &oid)) {
     -+		    read_ref(refname.buf, &oid) ||
     -+			filter_advertise_ref(refname_nons, &oid)) {
     ++			ref_is_force_hidden(refname_nons, refname.buf) ||
     + 		    read_ref(refname.buf, &oid)) {
       			packet_writer_error(writer, "unknown ref %s", refname_nons);
       			die("unknown ref %s", refname_nons);
     - 		}
     +@@ upload-pack.c: enum fetch_state {
     + 	FETCH_DONE,
     + };
     + 
     ++static int lazy_load_hidden = 0;
     ++// lazy load hidden refs for protocol V2
     ++void lazy_load_hidden_refs(void) {
     ++	lazy_load_hidden = 1;
     ++}
     ++
     + int upload_pack_v2(struct repository *r, struct packet_reader *request)
     + {
     + 	enum fetch_state state = FETCH_PROCESS_ARGS;
      @@ upload-pack.c: int upload_pack_v2(struct repository *r, struct packet_reader *request)
     + 				state = FETCH_DONE;
     + 			break;
     + 		case FETCH_SEND_PACK:
     ++			if (lazy_load_hidden) {
     ++				head_ref_namespaced(check_ref, NULL);
     ++				for_each_namespaced_ref(check_ref, NULL);
     ++			}
     ++			if (has_force_hidden_refs())
     ++				check_non_tip(&data);
     + 			send_wanted_ref_info(&data);
     + 			send_shallow_info(&data);
       
     - 	clear_object_flags(ALL_FLAGS);
     +
     + ## upload-pack.h ##
     +@@ upload-pack.h: struct strbuf;
     + int upload_pack_advertise(struct repository *r,
     + 			  struct strbuf *value);
       
     -+	create_advertise_refs_filter("git-upload-pack");
     -+	atexit(clean_refs_advertise_filter);
     -+
     - 	upload_pack_data_init(&data);
     - 	data.use_sideband = LARGE_PACKET_MAX;
     - 	get_upload_pack_config(&data);
     ++void lazy_load_hidden_refs(void);
     + #endif /* UPLOAD_PACK_H */
 2:  88504b3a08a ! 2:  72333c12c3f t1419: add test cases for refs-advertise hook
     @@ Metadata
      Author: Sun Chao <sunchao9@huawei.com>
      
       ## Commit message ##
     -    t1419: add test cases for refs-advertise hook
     +    t1419: add test cases for hide-refs hook
      
     -    Add test cases for the new 'refs-advertise' hook which is used to
     -    filter the references during reference discovery phase and commit
     -    fetching phase.
     +    Add test cases for the new 'hide-refs' hook which is used to
     +    filter the references during reference discovery phase.
      
          Signed-off-by: Sun Chao <sunchao9@huawei.com>
      
     - ## t/t1419-refs-advertise-hooks.sh (new) ##
     + ## t/t1419-hide-refs-hook.sh (new) ##
      @@
      +#!/bin/sh
      +#
      +# Copyright (c) 2022 Sun Chao
      +#
      +
     -+test_description='Test refs-advertise hook'
     ++test_description='Test hide-refs hook'
      +
      +GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
      +export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     @@ t/t1419-refs-advertise-hooks.sh (new)
      +	'
      +}
      +
     -+run_refs_advertise_hook_tests() {
     ++run_hide_refs_hook_tests() {
      +	case $1 in
      +		http)
      +			PROTOCOL="HTTP protocol"
     @@ t/t1419-refs-advertise-hooks.sh (new)
      +
      +	GIT_TEST_PROTOCOL_VERSION=$2
      +
     -+	# Run test cases for 'refs-advertise' hook
     ++	# Run test cases for 'hide-refs' hook
      +	for t in  "$TEST_DIRECTORY"/t1419/test-*.sh
      +	do
      +		# Initialize the bare_repo repository and work_repo
     @@ t/t1419-refs-advertise-hooks.sh (new)
      +		cp -rf work_repo work_repo.dump
      +
      +		git -C bare_repo.git config --local http.receivepack true
     ++		git -C bare_repo.git config --add transfer.hiderefs force:HEAD
     ++		git -C bare_repo.git config --add transfer.hiderefs force:refs
      +		cp -rf bare_repo.git bare_repo.git.dump
      +
      +		if test "$1" = "http"; then
     @@ t/t1419-refs-advertise-hooks.sh (new)
      +# Load test cases that only need to be executed once.
      +for t in  "$TEST_DIRECTORY"/t1419/once-*.sh
      +do
     ++	git -C "$BAREREPO_GIT_DIR" config --add transfer.hiderefs force:HEAD
     ++	git -C "$BAREREPO_GIT_DIR" config --add transfer.hiderefs force:refs
      +	. "$t"
      +done
      +
      +for protocol in 1 2
      +do
     -+	# Run test cases for 'refs-advertise' hook on local file protocol.
     -+	run_refs_advertise_hook_tests local $protocol
     ++	# Run test cases for 'hide-refs' hook on local file protocol.
     ++	run_hide_refs_hook_tests local $protocol
      +done
      +
      +ROOT_PATH="$PWD"
     @@ t/t1419-refs-advertise-hooks.sh (new)
      +start_httpd
      +set_askpass user@host pass@host
      +
     -+# Run test cases for 'refs-advertise' hook on HTTP protocol.
     ++# Run test cases for 'hide-refs' hook on HTTP protocol.
      +for protocol in 1 2
      +do
     -+	run_refs_advertise_hook_tests http $protocol
     ++	run_hide_refs_hook_tests http $protocol
      +done
      +
      +test_done
     @@ t/t1419/common-functions.sh (new)
      +		-e "s#$BAREREPO_PREFIX/bare_repo.git#<URL/of/bare_repo.git>#"
      +}
      +
     -+filter_out_refs_advertise_output() {
     ++filter_out_hide_refs_output() {
      +	make_user_friendly_and_stable_output | sed 's/^[0-9a-f]\{4\}//g'
      +}
      +
     @@ t/t1419/common-functions.sh (new)
      +	test_cmp show-ref.expect show-ref.filtered
      +}
      
     - ## t/t1419/once-0000-abnormal-refs-advertise-hook.sh (new) ##
     + ## t/t1419/once-0000-abnormal-hide-refs-hook.sh (new) ##
      @@
     -+test_expect_success "builtin protocol (protocol: 1): setup refs-advertise hook which die when read version" '
     -+	write_script "$BAREREPO_GIT_DIR/hooks/refs-advertise" <<-EOF
     -+		test-tool refs-advertise \
     -+			--can-upload-pack \
     -+			--can-receive-pack \
     -+			--can-ls-refs \
     -+			--die-read-version
     ++test_expect_success "builtin protocol (protocol: 1): setup hide-refs hook which die when read version" '
     ++	write_script "$BAREREPO_GIT_DIR/hooks/hide-refs" <<-EOF
     ++		test-tool hide-refs \
     ++			--die-read-version \
     ++			-r refs/heads/main
      +	EOF
      +'
      +
     -+test_expect_success "builtin protocol (protocol: 1): upload-pack --advertise-refs while refs-advertise hook die when read version" '
     ++test_expect_success "builtin protocol (protocol: 1): upload-pack --advertise-refs while hide-refs hook die when read version" '
      +	test_must_fail git -c protocol.version=1 upload-pack --advertise-refs "$BAREREPO_URL" >out 2>&1 &&
      +	cat out | grep "fatal: " | make_user_friendly_and_stable_output >actual &&
      +	format_and_save_expect <<-EOF &&
      +		fatal: die with the --die-read-version option
     -+		fatal: can not read version message from hook refs-advertise
     ++		fatal: can not read version message from hook hide-refs
      +	EOF
      +	test_cmp expect actual
      +'
      +
     -+test_expect_success "builtin protocol (protocol: 1): setup refs-advertise hook which die when write version" '
     -+	write_script "$BAREREPO_GIT_DIR/hooks/refs-advertise" <<-EOF
     -+		test-tool refs-advertise \
     -+			--can-upload-pack \
     -+			--can-receive-pack \
     -+			--can-ls-refs \
     -+			--die-write-version
     ++test_expect_success "builtin protocol (protocol: 1): setup hide-refs hook which die when write version" '
     ++	write_script "$BAREREPO_GIT_DIR/hooks/hide-refs" <<-EOF
     ++		test-tool hide-refs --die-write-version
      +	EOF
      +'
      +
     -+test_expect_success "builtin protocol (protocol: 1): upload-pack --advertise-refs while refs-advertise hook die when write version" '
     ++test_expect_success "builtin protocol (protocol: 1): upload-pack --advertise-refs while hide-refs hook die when write version" '
      +	test_must_fail git -c protocol.version=1 upload-pack --advertise-refs "$BAREREPO_URL" >out 2>&1 &&
      +	cat out | grep "fatal: " | make_user_friendly_and_stable_output >actual &&
      +	format_and_save_expect <<-EOF &&
      +		fatal: die with the --die-write-version option
     -+		fatal: can not read version message from hook refs-advertise
     ++		fatal: can not read version message from hook hide-refs
      +	EOF
      +	test_cmp expect actual
      +'
      +
     -+test_expect_success "builtin protocol (protocol: 1): setup refs-advertise hook which die when read first filter request" '
     -+	write_script "$BAREREPO_GIT_DIR/hooks/refs-advertise" <<-EOF
     -+		test-tool refs-advertise \
     -+			--can-upload-pack \
     -+			--can-receive-pack \
     -+			--can-ls-refs \
     -+			--die-read-first-ref
     ++test_expect_success "builtin protocol (protocol: 1): setup hide-refs hook which die when read first filter request" '
     ++	write_script "$BAREREPO_GIT_DIR/hooks/hide-refs" <<-EOF
     ++		test-tool hide-refs --die-read-first-ref
      +	EOF
      +'
      +
     -+test_expect_success "builtin protocol (protocol: 1): upload-pack --advertise-refs while refs-advertise hook die when read first filter request" '
     ++test_expect_success "builtin protocol (protocol: 1): upload-pack --advertise-refs while hide-refs hook die when read first filter request" '
      +	test_must_fail git -c protocol.version=1 upload-pack --advertise-refs "$BAREREPO_URL" >out 2>&1 &&
      +	cat out | grep "fatal: " | make_user_friendly_and_stable_output >actual &&
      +	format_and_save_expect <<-EOF &&
      +		fatal: die with the --die-read-first-ref option
     -+		fatal: hook refs-advertise died abnormally
     ++		fatal: hook hide-refs died abnormally
      +	EOF
      +	test_cmp expect actual
      +'
      +
     -+test_expect_success "builtin protocol (protocol: 1): setup refs-advertise hook which die when read second filter request" '
     -+	write_script "$BAREREPO_GIT_DIR/hooks/refs-advertise" <<-EOF
     -+		test-tool refs-advertise \
     -+			--can-upload-pack \
     -+			--can-receive-pack \
     -+			--can-ls-refs \
     -+			--die-read-second-ref
     ++test_expect_success "builtin protocol (protocol: 1): setup hide-refs hook which die when read second filter request" '
     ++	write_script "$BAREREPO_GIT_DIR/hooks/hide-refs" <<-EOF
     ++		test-tool hide-refs --die-read-second-ref
      +	EOF
      +'
      +
     -+test_expect_success "builtin protocol (protocol: 1): upload-pack --advertise-refs while refs-advertise hook die when read second filter request" '
     ++test_expect_success "builtin protocol (protocol: 1): upload-pack --advertise-refs while hide-refs hook die when read second filter request" '
      +	test_must_fail git -c protocol.version=1 upload-pack --advertise-refs "$BAREREPO_URL"  >out 2>&1 &&
      +	cat out | grep "fatal: " | make_user_friendly_and_stable_output >actual &&
      +	format_and_save_expect <<-EOF &&
      +		fatal: die with the --die-read-second-ref option
     -+		fatal: hook refs-advertise died abnormally
     ++		fatal: hook hide-refs died abnormally
      +	EOF
      +	test_cmp expect actual
      +'
      +
     -+test_expect_success "builtin protocol (protocol: 1): setup refs-advertise hook which die while filtring refs" '
     -+	write_script "$BAREREPO_GIT_DIR/hooks/refs-advertise" <<-EOF
     -+		test-tool refs-advertise \
     -+			--can-upload-pack \
     -+			--can-receive-pack \
     -+			--can-ls-refs \
     -+			--die-filter-refs
     ++test_expect_success "builtin protocol (protocol: 1): setup hide-refs hook which die while filtring refs" '
     ++	write_script "$BAREREPO_GIT_DIR/hooks/hide-refs" <<-EOF
     ++		test-tool hide-refs --die-after-proc-refs
      +	EOF
      +'
      +
     -+test_expect_success "builtin protocol (protocol: 1): upload-pack --advertise-refs while refs-advertise hook die while filtring refs" '
     ++test_expect_success "builtin protocol (protocol: 1): upload-pack --advertise-refs while hide-refs hook die while filtring refs" '
      +	test_must_fail git -c protocol.version=1 upload-pack --advertise-refs "$BAREREPO_URL"  >out 2>&1 &&
      +	cat out | grep "fatal: " | make_user_friendly_and_stable_output >actual &&
      +	format_and_save_expect <<-EOF &&
     -+		fatal: die with the --die-filter-refs option
     -+		fatal: hook refs-advertise died abnormally
     ++		fatal: die with the --die-after-proc-refs option
     ++		fatal: hook hide-refs died abnormally
      +	EOF
      +	test_cmp expect actual
      +'
      +
     -+test_expect_success "builtin protocol (protocol: 2): setup refs-advertise hook which die when read version" '
     -+	write_script "$BAREREPO_GIT_DIR/hooks/refs-advertise" <<-EOF
     -+		test-tool refs-advertise \
     -+			--can-upload-pack \
     -+			--can-receive-pack \
     -+			--can-ls-refs \
     -+			--die-read-version
     ++test_expect_success "builtin protocol (protocol: 2): setup hide-refs hook which die when read version" '
     ++	write_script "$BAREREPO_GIT_DIR/hooks/hide-refs" <<-EOF
     ++		test-tool hide-refs --die-read-version
      +	EOF
      +'
      +
     -+test_expect_success "builtin protocol (protocol: 2): upload-pack --advertise-refs while refs-advertise hook die when read version" '
     ++test_expect_success "builtin protocol (protocol: 2): upload-pack --advertise-refs while hide-refs hook die when read version" '
      +	test_must_fail git -c protocol.version=2 upload-pack --advertise-refs "$BAREREPO_URL" >out 2>&1 &&
      +	cat out | grep "fatal: " | make_user_friendly_and_stable_output >actual &&
      +	format_and_save_expect <<-EOF &&
      +		fatal: die with the --die-read-version option
     -+		fatal: can not read version message from hook refs-advertise
     ++		fatal: can not read version message from hook hide-refs
      +	EOF
      +	test_cmp expect actual
      +'
      +
     -+test_expect_success "builtin protocol (protocol: 2): setup refs-advertise hook which die when write version" '
     -+	write_script "$BAREREPO_GIT_DIR/hooks/refs-advertise" <<-EOF
     -+		test-tool refs-advertise \
     -+			--can-upload-pack \
     -+			--can-receive-pack \
     -+			--can-ls-refs \
     -+			--die-write-version
     ++test_expect_success "builtin protocol (protocol: 2): setup hide-refs hook which die when write version" '
     ++	write_script "$BAREREPO_GIT_DIR/hooks/hide-refs" <<-EOF
     ++		test-tool hide-refs --die-write-version
      +	EOF
      +'
      +
     -+test_expect_success "builtin protocol (protocol: 2): upload-pack --advertise-refs while refs-advertise hook die when write version" '
     ++test_expect_success "builtin protocol (protocol: 2): upload-pack --advertise-refs while hide-refs hook die when write version" '
      +	test_must_fail git -c protocol.version=2 upload-pack --advertise-refs "$BAREREPO_URL" >out 2>&1 &&
      +	cat out | grep "fatal: " | make_user_friendly_and_stable_output >actual &&
      +	format_and_save_expect <<-EOF &&
      +		fatal: die with the --die-write-version option
     -+		fatal: can not read version message from hook refs-advertise
     ++		fatal: can not read version message from hook hide-refs
      +	EOF
      +	test_cmp expect actual
      +'
      +
     -+test_expect_success "builtin protocol (protocol: 2): setup refs-advertise hook which die when read first filter request" '
     -+	write_script "$BAREREPO_GIT_DIR/hooks/refs-advertise" <<-EOF
     -+		test-tool refs-advertise \
     -+			--can-upload-pack \
     -+			--can-receive-pack \
     -+			--can-ls-refs \
     -+			--die-read-first-ref
     ++test_expect_success "builtin protocol (protocol: 2): setup hide-refs hook which die when read first filter request" '
     ++	write_script "$BAREREPO_GIT_DIR/hooks/hide-refs" <<-EOF
     ++		test-tool hide-refs --die-read-first-ref
      +	EOF
      +'
      +
     -+test_expect_success "builtin protocol (protocol: 2): upload-pack --advertise-refs while refs-advertise hook die when read first filter request" '
     ++test_expect_success "builtin protocol (protocol: 2): upload-pack --advertise-refs while hide-refs hook die when read first filter request" '
      +	test_must_fail git -c protocol.version=2 upload-pack --advertise-refs "$BAREREPO_URL" >out 2>&1 &&
      +	cat out | grep "fatal: " | make_user_friendly_and_stable_output >actual &&
      +	format_and_save_expect <<-EOF &&
      +		fatal: die with the --die-read-first-ref option
     -+		fatal: hook refs-advertise died abnormally
     ++		fatal: hook hide-refs died abnormally
      +	EOF
      +	test_cmp expect actual
      +'
      +
     -+test_expect_success "builtin protocol (protocol: 2): setup refs-advertise hook which die when read second filter request" '
     -+	write_script "$BAREREPO_GIT_DIR/hooks/refs-advertise" <<-EOF
     -+		test-tool refs-advertise \
     -+			--can-upload-pack \
     -+			--can-receive-pack \
     -+			--can-ls-refs \
     -+			--die-read-second-ref
     ++test_expect_success "builtin protocol (protocol: 2): setup hide-refs hook which die when read second filter request" '
     ++	write_script "$BAREREPO_GIT_DIR/hooks/hide-refs" <<-EOF
     ++		test-tool hide-refs --die-read-second-ref
      +	EOF
      +'
      +
     -+test_expect_success "builtin protocol (protocol: 2): upload-pack --advertise-refs while refs-advertise hook die when read second filter request" '
     ++test_expect_success "builtin protocol (protocol: 2): upload-pack --advertise-refs while hide-refs hook die when read second filter request" '
      +	test_must_fail git -c protocol.version=2 upload-pack --advertise-refs "$BAREREPO_URL" >out 2>&1 &&
      +	cat out | grep "fatal: " | make_user_friendly_and_stable_output >actual &&
      +	format_and_save_expect <<-EOF &&
      +		fatal: die with the --die-read-second-ref option
     -+		fatal: hook refs-advertise died abnormally
     ++		fatal: hook hide-refs died abnormally
      +	EOF
      +	test_cmp expect actual
      +'
      +
     -+test_expect_success "builtin protocol (protocol: 2): setup refs-advertise hook which die while filtring refs" '
     -+	write_script "$BAREREPO_GIT_DIR/hooks/refs-advertise" <<-EOF
     -+		test-tool refs-advertise \
     -+			--can-upload-pack \
     -+			--can-receive-pack \
     -+			--can-ls-refs \
     -+			--die-filter-refs
     ++test_expect_success "builtin protocol (protocol: 2): setup hide-refs hook which die while filtring refs" '
     ++	write_script "$BAREREPO_GIT_DIR/hooks/hide-refs" <<-EOF
     ++		test-tool hide-refs --die-after-proc-refs
      +	EOF
      +'
      +
     -+test_expect_success "builtin protocol (protocol: 2): upload-pack --advertise-refs while refs-advertise hook die while filtring refs" '
     ++test_expect_success "builtin protocol (protocol: 2): upload-pack --advertise-refs while hide-refs hook die while filtring refs" '
      +	test_must_fail git -c protocol.version=2 upload-pack --advertise-refs "$BAREREPO_URL" >out 2>&1 &&
      +	cat out | grep "fatal: " | make_user_friendly_and_stable_output >actual &&
      +	format_and_save_expect <<-EOF &&
     -+		fatal: die with the --die-filter-refs option
     -+		fatal: hook refs-advertise died abnormally
     ++		fatal: die with the --die-after-proc-refs option
     ++		fatal: hook hide-refs died abnormally
      +	EOF
      +	test_cmp expect actual
      +'
      
     - ## t/t1419/test-0000-standard-git-clone.sh (new) ##
     + ## t/t1419/test-0001-ls-remote-with-hide-refs-hook.sh (new) ##
      @@
     -+test_expect_success "$PROTOCOL (protocol: $GIT_TEST_PROTOCOL_VERSION): mirror clone" '
     -+	rm -rf local.git &&
     -+	git -c protocol.version=$GIT_TEST_PROTOCOL_VERSION clone --mirror "$BAREREPO_URL" local.git &&
     -+	git -c protocol.version=$GIT_TEST_PROTOCOL_VERSION -C local.git show-ref -d >out 2>&1 &&
     -+	refs_num=$(cat out | wc -l) &&
     -+	make_user_friendly_and_stable_output <out >actual &&
     -+	format_and_save_expect <<-EOF &&
     -+		<COMMIT-A> refs/heads/dev
     -+		<COMMIT-B> refs/heads/main
     -+		<COMMIT-C> refs/pull-requests/1/head
     -+		<COMMIT-TAG-v123> refs/tags/v123
     -+		<COMMIT-D> refs/tags/v123^{}
     ++test_expect_success "$PROTOCOL (protocol: $GIT_TEST_PROTOCOL_VERSION): setup hide-refs hook which hide no refs" '
     ++	write_script "$BAREREPO_GIT_DIR/hooks/hide-refs" <<-EOF
     ++		test-tool hide-refs
      +	EOF
     -+	test_cmp expect actual
      +'
      +
     -+test_expect_success "$PROTOCOL (protocol: $GIT_TEST_PROTOCOL_VERSION): ls-remote" '
     ++test_expect_success "$PROTOCOL (protocol: $GIT_TEST_PROTOCOL_VERSION): ls-remote while hide-refs hook hide no refs" '
      +	git -c protocol.version=$GIT_TEST_PROTOCOL_VERSION ls-remote "$BAREREPO_URL" >out 2>&1 &&
     -+	refs_num=$(cat out | wc -l) &&
      +	make_user_friendly_and_stable_output <out >actual &&
      +	format_and_save_expect <<-EOF &&
      +		<COMMIT-B>	HEAD
     @@ t/t1419/test-0000-standard-git-clone.sh (new)
      +	test_cmp expect actual
      +'
      +
     -+test_expect_success "$PROTOCOL (protocol: $GIT_TEST_PROTOCOL_VERSION): upload-pack" '
     -+	git -c protocol.version=$GIT_TEST_PROTOCOL_VERSION upload-pack --advertise-refs "$BAREREPO_GIT_DIR" >out 2>&1 &&
     -+	filter_out_refs_advertise_output <out >actual &&
     -+	format_and_save_expect <<-EOF &&
     -+		<COMMIT-B> HEAD
     -+		<COMMIT-A> refs/heads/dev
     -+		<COMMIT-B> refs/heads/main
     -+		<COMMIT-C> refs/pull-requests/1/head
     -+		<COMMIT-TAG-v123> refs/tags/v123
     -+		<COMMIT-D> refs/tags/v123^{}
     -+	EOF
     -+	test_cmp expect actual
     -+'
     -+
     -+test_expect_success "$PROTOCOL (protocol: $GIT_TEST_PROTOCOL_VERSION): receive-pack" '
     -+	git -c protocol.version=$GIT_TEST_PROTOCOL_VERSION receive-pack --advertise-refs "$BAREREPO_GIT_DIR" >out 2>&1 &&
     -+	filter_out_refs_advertise_output <out >actual &&
     -+	format_and_save_expect <<-EOF &&
     -+		<COMMIT-A> refs/heads/dev
     -+		<COMMIT-B> refs/heads/main
     -+		<COMMIT-C> refs/pull-requests/1/head
     -+		<COMMIT-TAG-v123> refs/tags/v123
     -+	EOF
     -+	test_cmp expect actual
     -+'
     -
     - ## t/t1419/test-0001-standard-git-push.sh (new) ##
     -@@
     -+test_expect_success "$PROTOCOL (protocol: $GIT_TEST_PROTOCOL_VERSION): push to main" '
     -+	create_commits_in work_repo E &&
     -+	git -c protocol.version=$GIT_TEST_PROTOCOL_VERSION -C work_repo push origin HEAD:main >out 2>&1 &&
     -+	make_user_friendly_and_stable_output <out >out.tmp &&
     -+	sed "s/$(get_abbrev_oid $E)[0-9a-f]*/<COMMIT-E>/g" <out.tmp >actual &&
     -+	format_and_save_expect <<-EOF &&
     -+		remote: # pre-receive hook        Z
     -+		remote: pre-receive< <COMMIT-B> <COMMIT-E> refs/heads/main        Z
     -+		remote: # update hook        Z
     -+		remote: update< refs/heads/main <COMMIT-B> <COMMIT-E>        Z
     -+		remote: # post-receive hook        Z
     -+		remote: post-receive< <COMMIT-B> <COMMIT-E> refs/heads/main        Z
     -+		To <URL/of/bare_repo.git>
     -+		   <COMMIT-B>..<COMMIT-E>  HEAD -> main
     -+		EOF
     -+	test_cmp expect actual
     -+'
     -+
     -+test_expect_success "$PROTOCOL (protocol: $GIT_TEST_PROTOCOL_VERSION): push to delete ref" '
     -+	git -c protocol.version=$GIT_TEST_PROTOCOL_VERSION -C work_repo push origin :dev >out 2>&1 &&
     -+	make_user_friendly_and_stable_output <out >out.tmp &&
     -+	sed "s/$(get_abbrev_oid $E)[0-9a-f]*/<COMMIT-E>/g" <out.tmp >actual &&
     -+	format_and_save_expect <<-EOF &&
     -+		remote: # pre-receive hook        Z
     -+		remote: pre-receive< <COMMIT-A> <ZERO-OID> refs/heads/dev        Z
     -+		remote: # update hook        Z
     -+		remote: update< refs/heads/dev <COMMIT-A> <ZERO-OID>        Z
     -+		remote: # post-receive hook        Z
     -+		remote: post-receive< <COMMIT-A> <ZERO-OID> refs/heads/dev        Z
     -+		To <URL/of/bare_repo.git>
     -+		 - [deleted]         dev
     -+		EOF
     -+	test_cmp expect actual
     -+'
     -
     - ## t/t1419/test-0002-ls-remote-with-refs-advertise-hook.sh (new) ##
     -@@
     -+test_expect_success "$PROTOCOL (protocol: $GIT_TEST_PROTOCOL_VERSION): setup refs-advertise hook which handle no command" '
     -+	write_script "$BAREREPO_GIT_DIR/hooks/refs-advertise" <<-EOF
     -+		test-tool refs-advertise
     ++test_expect_success "$PROTOCOL (protocol: $GIT_TEST_PROTOCOL_VERSION): setup hide-refs hook which hide all refs" '
     ++	write_script "$BAREREPO_GIT_DIR/hooks/hide-refs" <<-EOF
     ++	test-tool hide-refs \
     ++		-r "HEAD" \
     ++		-r "refs/heads/dev" \
     ++		-r "refs/heads/main" \
     ++		-r "refs/pull-requests/1/head" \
     ++		-r "refs/tags/v123"
      +	EOF
      +'
      +
     -+test_expect_success "$PROTOCOL (protocol: $GIT_TEST_PROTOCOL_VERSION): ls-remote while refs-advertise hook handle no command" '
     ++test_expect_success "$PROTOCOL (protocol: $GIT_TEST_PROTOCOL_VERSION): ls-remote while hide-refs hook hide all refs" '
      +	git -c protocol.version=$GIT_TEST_PROTOCOL_VERSION ls-remote "$BAREREPO_URL" >out 2>&1 &&
      +	make_user_friendly_and_stable_output <out >actual &&
      +	format_and_save_expect <<-EOF &&
     -+		<COMMIT-B>	HEAD
     -+		<COMMIT-A>	refs/heads/dev
     -+		<COMMIT-B>	refs/heads/main
     -+		<COMMIT-C>	refs/pull-requests/1/head
     -+		<COMMIT-TAG-v123>	refs/tags/v123
     -+		<COMMIT-D>	refs/tags/v123^{}
      +	EOF
      +	test_cmp expect actual
      +'
      +
     -+test_expect_success "$PROTOCOL (protocol: $GIT_TEST_PROTOCOL_VERSION): setup refs-advertise hook which advertise all refs" '
     -+	write_script "$BAREREPO_GIT_DIR/hooks/refs-advertise" <<-EOF
     -+	test-tool refs-advertise \
     -+		--can-upload-pack \
     -+		--can-ls-refs \
     -+		-r "ref refs/heads/dev $A" \
     -+		-r "obj $A" \
     -+		-r "ref refs/heads/main $B" \
     -+		-r "obj $B" \
     -+		-r "ref refs/pull-requests/1/head $C" \
     -+		-r "obj $C" \
     -+		-r "ref refs/tags/v123 $TAG" \
     -+		-r "obj $D"
     ++test_expect_success "$PROTOCOL (protocol: $GIT_TEST_PROTOCOL_VERSION): setup hide-refs hook which hide branches" '
     ++	write_script "$BAREREPO_GIT_DIR/hooks/hide-refs" <<-EOF
     ++	test-tool hide-refs \
     ++		-r "HEAD" \
     ++		-r "refs/heads/dev" \
     ++		-r "refs/heads/main"
      +	EOF
      +'
      +
     -+test_expect_success "$PROTOCOL (protocol: $GIT_TEST_PROTOCOL_VERSION): ls-remote all refs" '
     ++test_expect_success "$PROTOCOL (protocol: $GIT_TEST_PROTOCOL_VERSION): ls-remote while hide-refs hook hide branches" '
      +	git -c protocol.version=$GIT_TEST_PROTOCOL_VERSION ls-remote "$BAREREPO_URL" >out 2>&1 &&
      +	make_user_friendly_and_stable_output <out >actual &&
      +	format_and_save_expect <<-EOF &&
     -+		<COMMIT-B>	HEAD
     -+		<COMMIT-A>	refs/heads/dev
     -+		<COMMIT-B>	refs/heads/main
      +		<COMMIT-C>	refs/pull-requests/1/head
      +		<COMMIT-TAG-v123>	refs/tags/v123
      +		<COMMIT-D>	refs/tags/v123^{}
     @@ t/t1419/test-0002-ls-remote-with-refs-advertise-hook.sh (new)
      +	test_cmp expect actual
      +'
      +
     -+test_expect_success "$PROTOCOL (protocol: $GIT_TEST_PROTOCOL_VERSION): setup refs-advertise hook which advertise branches" '
     -+	write_script "$BAREREPO_GIT_DIR/hooks/refs-advertise" <<-EOF
     -+	test-tool refs-advertise \
     -+		--can-upload-pack \
     -+		--can-ls-refs \
     -+		-r "ref refs/heads/dev $A" \
     -+		-r "obj $A" \
     -+		-r "ref refs/heads/main $B" \
     -+		-r "obj $B"
     ++test_expect_success "$PROTOCOL (protocol: $GIT_TEST_PROTOCOL_VERSION): setup hide-refs hook which hide pull refs and tags" '
     ++	write_script "$BAREREPO_GIT_DIR/hooks/hide-refs" <<-EOF
     ++	test-tool hide-refs \
     ++		-r "refs/pull-requests/1/head" \
     ++		-r "refs/tags/v123"
      +	EOF
      +'
      +
     -+test_expect_success "$PROTOCOL (protocol: $GIT_TEST_PROTOCOL_VERSION): ls-remote branches" '
     ++test_expect_success "$PROTOCOL (protocol: $GIT_TEST_PROTOCOL_VERSION): ls-remote while hide-refs hook hide pull refs and tags" '
      +	git -c protocol.version=$GIT_TEST_PROTOCOL_VERSION ls-remote "$BAREREPO_URL" >out 2>&1 &&
      +	make_user_friendly_and_stable_output <out >actual &&
      +	format_and_save_expect <<-EOF &&
     @@ t/t1419/test-0002-ls-remote-with-refs-advertise-hook.sh (new)
      +		<COMMIT-B>	refs/heads/main
      +	EOF
      +	test_cmp expect actual
     -+'
     -+
     -+test_expect_success "$PROTOCOL (protocol: $GIT_TEST_PROTOCOL_VERSION): setup refs-advertise hook which advertise pull refs and tags" '
     -+	write_script "$BAREREPO_GIT_DIR/hooks/refs-advertise" <<-EOF
     -+	test-tool refs-advertise \
     -+		--can-upload-pack \
     -+		--can-ls-refs  \
     -+		-r "ref refs/pull-requests/1/head $C" \
     -+		-r "obj $C" \
     -+		-r "ref refs/tags/v123 $TAG" \
     -+		-r "obj $D"
     -+	EOF
     -+'
     -+
     -+test_expect_success "$PROTOCOL (protocol: $GIT_TEST_PROTOCOL_VERSION): ls-remote pull refs and tags" '
     -+	git -c protocol.version=$GIT_TEST_PROTOCOL_VERSION ls-remote "$BAREREPO_URL" >out 2>&1 &&
     -+	make_user_friendly_and_stable_output <out >actual &&
     -+	format_and_save_expect <<-EOF &&
     -+		<COMMIT-C>	refs/pull-requests/1/head
     -+		<COMMIT-TAG-v123>	refs/tags/v123
     -+		<COMMIT-D>	refs/tags/v123^{}
     -+	EOF
     -+	test_cmp expect actual
      +'
      
     - ## t/t1419/test-0003-upload-pack-with-refs-advertise-hook.sh (new) ##
     + ## t/t1419/test-0002-upload-pack-with-hide-refs-hook.sh (new) ##
      @@
     -+test_expect_success "$PROTOCOL (protocol: $GIT_TEST_PROTOCOL_VERSION): setup refs-advertise hook which handle no command" '
     -+	write_script "$BAREREPO_GIT_DIR/hooks/refs-advertise" <<-EOF
     -+		test-tool refs-advertise
     ++test_expect_success "$PROTOCOL (protocol: $GIT_TEST_PROTOCOL_VERSION): setup hide-refs hook which hide no refs" '
     ++	write_script "$BAREREPO_GIT_DIR/hooks/hide-refs" <<-EOF
     ++		test-tool hide-refs
      +	EOF
      +'
      +
     -+test_expect_success "$PROTOCOL (protocol: $GIT_TEST_PROTOCOL_VERSION): mirror clone while refs-advertise hook handle no command" '
     ++test_expect_success "$PROTOCOL (protocol: $GIT_TEST_PROTOCOL_VERSION): mirror clone while hide-refs hook hide no refs" '
      +	rm -rf local.git &&
      +	git -c protocol.version=$GIT_TEST_PROTOCOL_VERSION clone --mirror "$BAREREPO_URL" local.git &&
     -+	git -c protocol.version=$GIT_TEST_PROTOCOL_VERSION -C local.git show-ref -d >out 2>&1 &&
     ++	git -C local.git show-ref -d >out 2>&1 &&
      +	make_user_friendly_and_stable_output <out >actual &&
      +	format_and_save_expect <<-EOF &&
      +		<COMMIT-A> refs/heads/dev
     @@ t/t1419/test-0003-upload-pack-with-refs-advertise-hook.sh (new)
      +	test_cmp expect actual
      +'
      +
     -+test_expect_success "$PROTOCOL (protocol: $GIT_TEST_PROTOCOL_VERSION): setup refs-advertise hook which advertise all refs" '
     -+	write_script "$BAREREPO_GIT_DIR/hooks/refs-advertise" <<-EOF
     -+	test-tool refs-advertise \
     -+		--can-upload-pack \
     -+		--can-ls-refs \
     -+		-r "ref refs/heads/dev $A" \
     -+		-r "obj $A" \
     -+		-r "ref refs/heads/main $B" \
     -+		-r "obj $B" \
     -+		-r "ref refs/pull-requests/1/head $C" \
     -+		-r "obj $C" \
     -+		-r "ref refs/tags/v123 $TAG" \
     -+		-r "obj $TAG" \
     -+		-r "obj $D"
     ++test_expect_success "$PROTOCOL (protocol: $GIT_TEST_PROTOCOL_VERSION): setup hide-refs hook which hide all refs" '
     ++	write_script "$BAREREPO_GIT_DIR/hooks/hide-refs" <<-EOF
     ++	test-tool hide-refs \
     ++		-r "HEAD" \
     ++		-r "refs/heads/dev" \
     ++		-r "refs/heads/main" \
     ++		-r "refs/pull-requests/1/head" \
     ++		-r "refs/tags/v123"
      +	EOF
      +'
      +
     -+test_expect_success "$PROTOCOL (protocol: $GIT_TEST_PROTOCOL_VERSION): mirror clone all refs" '
     ++test_expect_success "$PROTOCOL (protocol: $GIT_TEST_PROTOCOL_VERSION): mirror clone while hide-refs hide all refs" '
      +	rm -rf local.git &&
      +	git -c protocol.version=$GIT_TEST_PROTOCOL_VERSION clone --mirror "$BAREREPO_URL" local.git &&
     -+	git -c protocol.version=$GIT_TEST_PROTOCOL_VERSION -C local.git show-ref -d >out 2>&1 &&
     ++	test_must_fail git -C local.git show-ref -d >out 2>&1 &&
      +	make_user_friendly_and_stable_output <out >actual &&
      +	format_and_save_expect <<-EOF &&
     -+		<COMMIT-A> refs/heads/dev
     -+		<COMMIT-B> refs/heads/main
     -+		<COMMIT-C> refs/pull-requests/1/head
     -+		<COMMIT-TAG-v123> refs/tags/v123
     -+		<COMMIT-D> refs/tags/v123^{}
      +	EOF
      +	test_cmp expect actual
      +'
      +
     -+test_expect_success "$PROTOCOL (protocol: $GIT_TEST_PROTOCOL_VERSION): setup refs-advertise hook which advertise branches" '
     -+	write_script "$BAREREPO_GIT_DIR/hooks/refs-advertise" <<-EOF
     -+	test-tool refs-advertise \
     -+		--can-upload-pack \
     -+		--can-ls-refs \
     -+		-r "ref refs/heads/dev $A" \
     -+		-r "obj $A" \
     -+		-r "ref refs/heads/main $B" \
     -+		-r "obj $B"
     ++test_expect_success "$PROTOCOL (protocol: $GIT_TEST_PROTOCOL_VERSION): setup hide-refs hook which hide branches" '
     ++	write_script "$BAREREPO_GIT_DIR/hooks/hide-refs" <<-EOF
     ++	test-tool hide-refs \
     ++		-r "HEAD" \
     ++		-r "refs/heads/dev" \
     ++		-r "refs/heads/main"
      +	EOF
      +'
      +
      +test_expect_success "$PROTOCOL (protocol: $GIT_TEST_PROTOCOL_VERSION): mirror clone branches" '
      +	rm -rf local.git &&
      +	git -c protocol.version=$GIT_TEST_PROTOCOL_VERSION clone --mirror "$BAREREPO_URL" local.git &&
     -+	git -c protocol.version=$GIT_TEST_PROTOCOL_VERSION -C local.git show-ref -d >out 2>&1 &&
     ++	git -C local.git show-ref -d >out 2>&1 &&
      +	make_user_friendly_and_stable_output <out >actual &&
      +	format_and_save_expect <<-EOF &&
     -+		<COMMIT-A> refs/heads/dev
     -+		<COMMIT-B> refs/heads/main
     ++		<COMMIT-C> refs/pull-requests/1/head
     ++		<COMMIT-TAG-v123> refs/tags/v123
     ++		<COMMIT-D> refs/tags/v123^{}
      +	EOF
      +	test_cmp expect actual
      +'
      +
     -+test_expect_success "$PROTOCOL (protocol: $GIT_TEST_PROTOCOL_VERSION): setup refs-advertise hook which advertise branches" '
     -+	write_script "$BAREREPO_GIT_DIR/hooks/refs-advertise" <<-EOF
     -+	test-tool refs-advertise \
     -+		--can-upload-pack \
     -+		--can-ls-refs \
     -+		-r "ref refs/heads/dev $A" \
     -+		-r "obj $A" \
     -+		-r "ref refs/heads/main $B" \
     -+		-r "obj $B"
     ++test_expect_success "$PROTOCOL (protocol: $GIT_TEST_PROTOCOL_VERSION): setup hide-refs hook which some branches" '
     ++	write_script "$BAREREPO_GIT_DIR/hooks/hide-refs" <<-EOF
     ++	test-tool hide-refs \
     ++		-r "HEAD" \
     ++		-r "refs/heads/dev"
      +	EOF
      +'
      +
     -+test_expect_success "$PROTOCOL (protocol: $GIT_TEST_PROTOCOL_VERSION): fetch a not advertised commit" '
     ++test_expect_success "$PROTOCOL (protocol: $GIT_TEST_PROTOCOL_VERSION): fetch a tip commit which is not hidden" '
      +	rm -rf local.git &&
     -+	git -c protocol.version=$GIT_TEST_PROTOCOL_VERSION init local.git &&
     -+	git -c protocol.version=$GIT_TEST_PROTOCOL_VERSION -C local.git remote add origin "$BAREREPO_URL" &&
     -+	test_must_fail git -C local.git fetch "$BAREREPO_URL" $D
     ++	git init local.git &&
     ++	git -C local.git remote add origin "$BAREREPO_URL" &&
     ++	git -C local.git -c protocol.version=$GIT_TEST_PROTOCOL_VERSION fetch "$BAREREPO_URL" $B
     ++'
     ++
     ++test_expect_success "$PROTOCOL (protocol: $GIT_TEST_PROTOCOL_VERSION): config allowAnySHA1InWant to true" '
     ++	git -C "$BAREREPO_GIT_DIR" config uploadpack.allowTipSHA1InWant true &&
     ++	git -C "$BAREREPO_GIT_DIR" config uploadpack.allowReachableSHA1InWant true
      +'
      +
     -+test_expect_success "$PROTOCOL (protocol: $GIT_TEST_PROTOCOL_VERSION): setup refs-advertise hook which advertise pull refs and tags" '
     -+	write_script "$BAREREPO_GIT_DIR/hooks/refs-advertise" <<-EOF
     -+	test-tool refs-advertise \
     -+		--can-upload-pack \
     -+		--can-ls-refs \
     -+		-r "ref refs/pull-requests/1/head $C" \
     -+		-r "obj $C" \
     -+		-r "ref refs/tags/v123 $TAG" \
     -+		-r "obj $TAG" \
     -+		-r "obj $D"
     ++test_expect_success "$PROTOCOL (protocol: $GIT_TEST_PROTOCOL_VERSION): fetch a non-tip commit which is not hidden" '
     ++	rm -rf local.git &&
     ++	git init local.git &&
     ++	git -C local.git remote add origin "$BAREREPO_URL" &&
     ++	git -C local.git -c protocol.version=$GIT_TEST_PROTOCOL_VERSION fetch "$BAREREPO_URL" $A
     ++'
     ++
     ++test_expect_success "$PROTOCOL (protocol: $GIT_TEST_PROTOCOL_VERSION): setup hide-refs hook which hide pull refs and tags" '
     ++	write_script "$BAREREPO_GIT_DIR/hooks/hide-refs" <<-EOF
     ++	test-tool hide-refs \
     ++		-r "refs/pull-requests/1/head" \
     ++		-r "refs/tags/v123"
      +	EOF
      +'
      +
     -+test_expect_success "$PROTOCOL (protocol: $GIT_TEST_PROTOCOL_VERSION): mirror clone pull refs and tags" '
     ++test_expect_success "$PROTOCOL (protocol: $GIT_TEST_PROTOCOL_VERSION): mirror clone while hide-refs hook hide pull refs and tags" '
      +	rm -rf local.git &&
      +	git -c protocol.version=$GIT_TEST_PROTOCOL_VERSION clone --mirror "$BAREREPO_URL" local.git &&
     -+	git -c protocol.version=$GIT_TEST_PROTOCOL_VERSION -C local.git show-ref -d >out 2>&1 &&
     ++	git -C local.git show-ref -d >out 2>&1 &&
      +	make_user_friendly_and_stable_output <out >actual &&
      +	format_and_save_expect <<-EOF &&
     -+		<COMMIT-C> refs/pull-requests/1/head
     -+		<COMMIT-TAG-v123> refs/tags/v123
     -+		<COMMIT-D> refs/tags/v123^{}
     ++		<COMMIT-A> refs/heads/dev
     ++		<COMMIT-B> refs/heads/main
      +	EOF
      +	test_cmp expect actual
      +'
      +
     -+test_expect_success "$PROTOCOL (protocol: $GIT_TEST_PROTOCOL_VERSION): clone a not advertised branch" '
     ++test_expect_success "$PROTOCOL (protocol: $GIT_TEST_PROTOCOL_VERSION): config allowAnySHA1InWant to true" '
     ++	git -C "$BAREREPO_GIT_DIR" config uploadpack.allowTipSHA1InWant true &&
     ++	git -C "$BAREREPO_GIT_DIR" config uploadpack.allowReachableSHA1InWant true
     ++'
     ++
     ++test_expect_success "$PROTOCOL (protocol: $GIT_TEST_PROTOCOL_VERSION): fetch a non-tip commit which is hidden" '
      +	rm -rf local.git &&
     -+	test_must_fail git -c protocol.version=$GIT_TEST_PROTOCOL_VERSION clone "$BAREREPO_URL" local.git -b main &&
     -+	test ! -d local.git
     ++	git init local.git &&
     ++	git -C local.git remote add origin "$BAREREPO_URL" &&
     ++	test_must_fail git -C local.git -c protocol.version=$GIT_TEST_PROTOCOL_VERSION fetch "$BAREREPO_URL" $C
      +'
      
     - ## t/t1419/test-0004-receive-pack-with-refs-advertise-hook.sh (new) ##
     + ## t/t1419/test-0003-receive-pack-with-hide-refs-hook.sh (new) ##
      @@
     -+test_expect_success "$PROTOCOL (protocol: $GIT_TEST_PROTOCOL_VERSION): setup refs-advertise hook which handle no command" '
     -+	write_script "$BAREREPO_GIT_DIR/hooks/refs-advertise" <<-EOF
     -+		test-tool refs-advertise
     ++test_expect_success "$PROTOCOL (protocol: $GIT_TEST_PROTOCOL_VERSION): setup hide-refs hook which hide no refs" '
     ++	write_script "$BAREREPO_GIT_DIR/hooks/hide-refs" <<-EOF
     ++		test-tool hide-refs
      +	EOF
      +'
      +
     -+test_expect_success "$PROTOCOL (protocol: $GIT_TEST_PROTOCOL_VERSION): push to main while refs-advertise hook handle no command" '
     ++test_expect_success "$PROTOCOL (protocol: $GIT_TEST_PROTOCOL_VERSION): push to main while hide-refs hook hide no refs" '
      +	create_commits_in work_repo E &&
      +	git -c protocol.version=$GIT_TEST_PROTOCOL_VERSION -C work_repo push origin HEAD:main >out 2>&1 &&
      +	make_user_friendly_and_stable_output <out >out.tmp &&
     @@ t/t1419/test-0004-receive-pack-with-refs-advertise-hook.sh (new)
      +	test_cmp expect actual
      +'
      +
     -+test_expect_success "$PROTOCOL (protocol: $GIT_TEST_PROTOCOL_VERSION): create ref while refs-advertise hook handle no command" '
     ++test_expect_success "$PROTOCOL (protocol: $GIT_TEST_PROTOCOL_VERSION): create ref while hide-refs hook hide no refs" '
      +	git -c protocol.version=$GIT_TEST_PROTOCOL_VERSION -C work_repo push origin HEAD:new >out 2>&1 &&
      +	make_user_friendly_and_stable_output <out >out.tmp &&
      +	sed "s/$(get_abbrev_oid $E)[0-9a-f]*/<COMMIT-E>/g" <out.tmp >actual &&
     @@ t/t1419/test-0004-receive-pack-with-refs-advertise-hook.sh (new)
      +	test_cmp expect actual
      +'
      +
     -+test_expect_success "$PROTOCOL (protocol: $GIT_TEST_PROTOCOL_VERSION): push to delete ref while refs-advertise hook handle no command" '
     ++test_expect_success "$PROTOCOL (protocol: $GIT_TEST_PROTOCOL_VERSION): push to delete ref while hide-refs hook hide no refs" '
      +	git -c protocol.version=$GIT_TEST_PROTOCOL_VERSION -C work_repo push origin :dev >out 2>&1 &&
      +	make_user_friendly_and_stable_output <out >out.tmp &&
      +	sed "s/$(get_abbrev_oid $E)[0-9a-f]*/<COMMIT-E>/g" <out.tmp >actual &&
     @@ t/t1419/test-0004-receive-pack-with-refs-advertise-hook.sh (new)
      +	test_cmp expect actual
      +'
      +
     -+test_expect_success "$PROTOCOL (protocol: $GIT_TEST_PROTOCOL_VERSION): setup refs-advertise hook which advertise nothing" '
     ++test_expect_success "$PROTOCOL (protocol: $GIT_TEST_PROTOCOL_VERSION): setup hide-refs hook which hide all refs" '
      +	rm -rf work_repo &&
      +	cp -rf work_repo.dump work_repo &&
      +	rm -rf "$BAREREPO_GIT_DIR" &&
      +	cp -rf bare_repo.git.dump "$BAREREPO_GIT_DIR" &&
     -+	write_script "$BAREREPO_GIT_DIR/hooks/refs-advertise" <<-EOF
     -+	test-tool refs-advertise \
     -+		--can-receive-pack \
     -+		--can-ls-refs
     ++	write_script "$BAREREPO_GIT_DIR/hooks/hide-refs" <<-EOF
     ++	test-tool hide-refs \
     ++		-r "HEAD" \
     ++		-r "refs/heads/dev" \
     ++		-r "refs/heads/main" \
     ++		-r "refs/pull-requests/1/head" \
     ++		-r "refs/tags/v123"
      +	EOF
      +'
      +
     -+test_expect_success "$PROTOCOL (protocol: $GIT_TEST_PROTOCOL_VERSION): push to main while refs-advertise hook advertise nothing" '
     ++test_expect_success "$PROTOCOL (protocol: $GIT_TEST_PROTOCOL_VERSION): push to main while hide-refs hook hide all refs" '
      +	create_commits_in work_repo E &&
      +	test_must_fail git -c protocol.version=$GIT_TEST_PROTOCOL_VERSION -C work_repo push origin HEAD:main >out 2>&1 &&
      +	make_user_friendly_and_stable_output <out >out.tmp &&
     @@ t/t1419/test-0004-receive-pack-with-refs-advertise-hook.sh (new)
      +	format_and_save_expect <<-EOF &&
      +		remote: # pre-receive hook        Z
      +		remote: pre-receive< <ZERO-OID> <COMMIT-E> refs/heads/main        Z
     -+		remote: # update hook        Z
     -+		remote: update< refs/heads/main <ZERO-OID> <COMMIT-E>        Z
     -+		remote: error: cannot lock ref "refs/heads/main": reference already exists        Z
      +		To <URL/of/bare_repo.git>
     -+		 ! [remote rejected] HEAD -> main (failed to update ref)
     -+		error: failed to push some refs to "<URL/of/bare_repo.git>"
     -+	EOF
     -+	test_cmp expect actual
     -+'
     -+
     -+test_expect_success "$PROTOCOL (protocol: $GIT_TEST_PROTOCOL_VERSION): create ref while while refs-advertise hook advertise nothing" '
     -+	git -c protocol.version=$GIT_TEST_PROTOCOL_VERSION -C work_repo push origin HEAD:new >out 2>&1 &&
     -+	make_user_friendly_and_stable_output <out >out.tmp &&
     -+	sed "s/$(get_abbrev_oid $E)[0-9a-f]*/<COMMIT-E>/g" <out.tmp >actual &&
     -+	format_and_save_expect <<-EOF &&
     -+		remote: # pre-receive hook        Z
     -+		remote: pre-receive< <ZERO-OID> <COMMIT-E> refs/heads/new        Z
     -+		remote: # update hook        Z
     -+		remote: update< refs/heads/new <ZERO-OID> <COMMIT-E>        Z
     -+		remote: # post-receive hook        Z
     -+		remote: post-receive< <ZERO-OID> <COMMIT-E> refs/heads/new        Z
     -+		To <URL/of/bare_repo.git>
     -+		 * [new branch]      HEAD -> new
     -+	EOF
     -+	test_cmp expect actual
     -+'
     -+
     -+test_expect_success "$PROTOCOL (protocol: $GIT_TEST_PROTOCOL_VERSION): push to delete ref while while refs-advertise hook advertise nothing" '
     -+	test_must_fail git -c protocol.version=$GIT_TEST_PROTOCOL_VERSION -C work_repo push origin :dev >out 2>&1 &&
     -+	make_user_friendly_and_stable_output <out >out.tmp &&
     -+	sed "s/$(get_abbrev_oid $E)[0-9a-f]*/<COMMIT-E>/g" <out.tmp >actual &&
     -+	format_and_save_expect <<-EOF &&
     -+		error: unable to delete "dev": remote ref does not exist
     -+		error: failed to push some refs to "<URL/of/bare_repo.git>"
     -+	EOF
     -+	test_cmp expect actual
     -+'
     -+
     -+test_expect_success "$PROTOCOL (protocol: $GIT_TEST_PROTOCOL_VERSION): setup refs-advertise hook which advertise all refs" '
     -+	rm -rf work_repo &&
     -+	cp -rf work_repo.dump work_repo &&
     -+	rm -rf "$BAREREPO_GIT_DIR" &&
     -+	cp -rf bare_repo.git.dump "$BAREREPO_GIT_DIR" &&
     -+	write_script "$BAREREPO_GIT_DIR/hooks/refs-advertise" <<-EOF
     -+	test-tool refs-advertise \
     -+		--can-receive-pack \
     -+		--can-ls-refs \
     -+		-r "ref refs/heads/dev $A" \
     -+		-r "obj $A" \
     -+		-r "ref refs/heads/main $B" \
     -+		-r "obj $B" \
     -+		-r "ref refs/pull-requests/1/head $C" \
     -+		-r "obj $C" \
     -+		-r "ref refs/tags/v123 $TAG" \
     -+		-r "obj $TAG" \
     -+		-r "obj $D"
     -+	EOF
     -+'
     -+
     -+test_expect_success "$PROTOCOL (protocol: $GIT_TEST_PROTOCOL_VERSION): push to main while refs-advertise hook advertise all refs" '
     -+	create_commits_in work_repo E &&
     -+	git -c protocol.version=$GIT_TEST_PROTOCOL_VERSION -C work_repo push origin HEAD:main >out 2>&1 &&
     -+	make_user_friendly_and_stable_output <out >out.tmp &&
     -+	sed "s/$(get_abbrev_oid $E)[0-9a-f]*/<COMMIT-E>/g" <out.tmp >actual &&
     -+	format_and_save_expect <<-EOF &&
     -+		remote: # pre-receive hook        Z
     -+		remote: pre-receive< <COMMIT-B> <COMMIT-E> refs/heads/main        Z
     -+		remote: # update hook        Z
     -+		remote: update< refs/heads/main <COMMIT-B> <COMMIT-E>        Z
     -+		remote: # post-receive hook        Z
     -+		remote: post-receive< <COMMIT-B> <COMMIT-E> refs/heads/main        Z
     -+		To <URL/of/bare_repo.git>
     -+		   <COMMIT-B>..<COMMIT-E>  HEAD -> main
     -+		EOF
     -+	test_cmp expect actual
     -+'
     -+
     -+test_expect_success "$PROTOCOL (protocol: $GIT_TEST_PROTOCOL_VERSION): create ref while while refs-advertise hook advertise all refs" '
     -+	git -c protocol.version=$GIT_TEST_PROTOCOL_VERSION -C work_repo push origin HEAD:new >out 2>&1 &&
     -+	make_user_friendly_and_stable_output <out >out.tmp &&
     -+	sed "s/$(get_abbrev_oid $E)[0-9a-f]*/<COMMIT-E>/g" <out.tmp >actual &&
     -+	format_and_save_expect <<-EOF &&
     -+		remote: # pre-receive hook        Z
     -+		remote: pre-receive< <ZERO-OID> <COMMIT-E> refs/heads/new        Z
     -+		remote: # update hook        Z
     -+		remote: update< refs/heads/new <ZERO-OID> <COMMIT-E>        Z
     -+		remote: # post-receive hook        Z
     -+		remote: post-receive< <ZERO-OID> <COMMIT-E> refs/heads/new        Z
     -+		To <URL/of/bare_repo.git>
     -+		 * [new branch]      HEAD -> new
     -+		EOF
     -+	test_cmp expect actual
     -+'
     -+
     -+test_expect_success "$PROTOCOL (protocol: $GIT_TEST_PROTOCOL_VERSION): push to delete ref while while refs-advertise hook advertise all refs" '
     -+	git -c protocol.version=$GIT_TEST_PROTOCOL_VERSION -C work_repo push origin :dev >out 2>&1 &&
     -+	make_user_friendly_and_stable_output <out >out.tmp &&
     -+	sed "s/$(get_abbrev_oid $E)[0-9a-f]*/<COMMIT-E>/g" <out.tmp >actual &&
     -+	format_and_save_expect <<-EOF &&
     -+		remote: # pre-receive hook        Z
     -+		remote: pre-receive< <COMMIT-A> <ZERO-OID> refs/heads/dev        Z
     -+		remote: # update hook        Z
     -+		remote: update< refs/heads/dev <COMMIT-A> <ZERO-OID>        Z
     -+		remote: # post-receive hook        Z
     -+		remote: post-receive< <COMMIT-A> <ZERO-OID> refs/heads/dev        Z
     -+		To <URL/of/bare_repo.git>
     -+		 - [deleted]         dev
     -+		EOF
     -+	test_cmp expect actual
     -+'
     -+
     -+test_expect_success "$PROTOCOL (protocol: $GIT_TEST_PROTOCOL_VERSION): setup refs-advertise hook which advertise pull refs and tags" '
     -+	rm -rf work_repo &&
     -+	cp -rf work_repo.dump work_repo &&
     -+	rm -rf "$BAREREPO_GIT_DIR" &&
     -+	cp -rf bare_repo.git.dump "$BAREREPO_GIT_DIR" &&
     -+	write_script "$BAREREPO_GIT_DIR/hooks/refs-advertise" <<-EOF
     -+	test-tool refs-advertise \
     -+		--can-receive-pack \
     -+		--can-ls-refs \
     -+		-r "ref refs/pull-requests/1/head $C" \
     -+		-r "obj $C" \
     -+		-r "ref refs/tags/v123 $TAG" \
     -+		-r "obj $TAG" \
     -+		-r "obj $D"
     -+	EOF
     -+'
     -+
     -+test_expect_success "$PROTOCOL (protocol: $GIT_TEST_PROTOCOL_VERSION): push to main while refs-advertise hook advertise pull refs and tags" '
     -+	create_commits_in work_repo E &&
     -+	test_must_fail git -c protocol.version=$GIT_TEST_PROTOCOL_VERSION -C work_repo push origin HEAD:main >out 2>&1 &&
     -+	make_user_friendly_and_stable_output <out >out.tmp &&
     -+	sed "s/$(get_abbrev_oid $E)[0-9a-f]*/<COMMIT-E>/g" <out.tmp >actual &&
     -+	format_and_save_expect <<-EOF &&
     -+		remote: # pre-receive hook        Z
     -+		remote: pre-receive< <ZERO-OID> <COMMIT-E> refs/heads/main        Z
     -+		remote: # update hook        Z
     -+		remote: update< refs/heads/main <ZERO-OID> <COMMIT-E>        Z
     -+		remote: error: cannot lock ref "refs/heads/main": reference already exists        Z
     -+		To <URL/of/bare_repo.git>
     -+		 ! [remote rejected] HEAD -> main (failed to update ref)
     -+		error: failed to push some refs to "<URL/of/bare_repo.git>"
     -+	EOF
     -+	test_cmp expect actual
     -+'
     -+
     -+test_expect_success "$PROTOCOL (protocol: $GIT_TEST_PROTOCOL_VERSION): create ref while while refs-advertise hook advertise pull refs and tags" '
     -+	git -c protocol.version=$GIT_TEST_PROTOCOL_VERSION -C work_repo push origin HEAD:new >out 2>&1 &&
     -+	make_user_friendly_and_stable_output <out >out.tmp &&
     -+	sed "s/$(get_abbrev_oid $E)[0-9a-f]*/<COMMIT-E>/g" <out.tmp >actual &&
     -+	format_and_save_expect <<-EOF &&
     -+		remote: # pre-receive hook        Z
     -+		remote: pre-receive< <ZERO-OID> <COMMIT-E> refs/heads/new        Z
     -+		remote: # update hook        Z
     -+		remote: update< refs/heads/new <ZERO-OID> <COMMIT-E>        Z
     -+		remote: # post-receive hook        Z
     -+		remote: post-receive< <ZERO-OID> <COMMIT-E> refs/heads/new        Z
     -+		To <URL/of/bare_repo.git>
     -+		 * [new branch]      HEAD -> new
     -+	EOF
     -+	test_cmp expect actual
     -+'
     -+
     -+test_expect_success "$PROTOCOL (protocol: $GIT_TEST_PROTOCOL_VERSION): push to delete ref while while refs-advertise hook advertise pull refs and tags" '
     -+	test_must_fail git -c protocol.version=$GIT_TEST_PROTOCOL_VERSION -C work_repo push origin :dev >out 2>&1 &&
     -+	make_user_friendly_and_stable_output <out >out.tmp &&
     -+	sed "s/$(get_abbrev_oid $E)[0-9a-f]*/<COMMIT-E>/g" <out.tmp >actual &&
     -+	format_and_save_expect <<-EOF &&
     -+		error: unable to delete "dev": remote ref does not exist
     ++		 ! [remote rejected] HEAD -> main (deny updating a hidden ref)
      +		error: failed to push some refs to "<URL/of/bare_repo.git>"
      +	EOF
      +	test_cmp expect actual
 3:  d98357d5f64 ! 3:  e737997eb31 doc: add documentation for the refs-advertise hook
     @@ Metadata
      Author: Sun Chao <16657101987@163.com>
      
       ## Commit message ##
     -    doc: add documentation for the refs-advertise hook
     +    doc: add documentation for the hide-refs hook
      
     -    "git upload-pack" or "git recevie-pack" can use "refs-advertise"
     -    hook to filter the references and commits during reference discovery
     -    phase and commit fetching phase.
     +    "git upload-pack" or "git recevie-pack" can use "hide-refs"
     +    hook to filter the references during reference discovery phase.
      
          Signed-off-by: Sun Chao <sunchao9@huawei.com>
      
     @@ Documentation/githooks.txt: If this hook exits with a non-zero status, `git push
       pushing anything.  Information about why the push is rejected may be sent
       to the user by writing to standard error.
       
     -+[[refs-advertise]]
     -+refs-advertise
     -+~~~~~~~~~~~~
     ++[[hide-refs]]
     ++hide-refs
     ++~~~~~~~~~
      +
     -+This hook is invoked by 'git-receive-pack' and 'git-upload-pack' during the
     -+reference discovery phase and the commit fetching phase, each reference and
     -+commit to fetch will be filtered by this hook. The hook executes once with
     -+no arguments for each 'git-upload-pack' and 'git-receive-pack' process and
     -+if the exit status is non-zero, `git push` and `git fetch` will abort.
     ++This hook would be invoked by 'git-receive-pack' and 'git-upload-pack'
     ++during the reference discovery phase, each reference and will be filtered
     ++by this hook. The hook executes once with no arguments for each
     ++'git-upload-pack' and 'git-receive-pack' process. Once the hook is invoked,
     ++a version number and server process name ('uploadpack' or 'receive') will
     ++send to it in pkt-line format, followed by a flush-pkt. The hook should
     ++response with its version number.
      +
     -+Once the hook is invoked, a version number and server process name
     -+('git-upload-pack' or 'git-receive-pack' or 'ls-refs') should send to it in
     -+packet-line format, followed by a flush-pkt. The hook should response with
     -+its version number and process name list it support. If the list does not
     -+contains the server process name, the server will close the connection with
     -+the hook and keep going without the hook child process.
     ++During reference discovery phase, each reference will be filtered by this
     ++hook. In the following example, the letter 'G' stands for 'git-receive-pack'
     ++or 'git-upload-pack' and the letter 'H' stands for this hook. The hook
     ++decides if the reference will be hidden or not, it sends result back in
     ++pkt-line format protocol, a response "hide" the references will hide
     ++to the client and can not fetch it even in protocol V2.
      +
     -+During reference discovery phase, each reference will be filtered by this hook,
     -+In the following example, the letter 'G' stands for 'git-receive-pack' or
     -+'git-upload-pack' and the letter 'H' stands for this hook. The hook decides if
     -+the reference will be advertised or not, it sends result back with pkt-line format
     -+protocol, a response in "ok ref <ref>" format followed by a flush-pkt means
     -+the references "<ref>" can be advertised, and "ng ref <ref>" means not.
     ++	# Version negotiation
     ++	G: PKT-LINE(version=1\0uploadpack)
     ++	G: flush-pkt
     ++	H: PKT-LINE(version=1)
     ++	H: flush-pkt
      +
     -+    # Version negotiation
     -+    G: PKT-LINE(version=1\0git-upload-pack)
     -+    G: flush-pkt
     -+    H: PKT-LINE(version=1\0git-upload-pack git-receive-pack ls-refs)
     -+    H: flush-pkt
     ++	# Send reference filter request to hook
     ++	G: PKT-LINE(ref <refname>:<refnamefull>)
     ++	G: flush-pkt
      +
     -+    # Send reference filter request to hook
     -+    G: PKT-LINE(ref <ref> <oid>)
     -+    G: flush-pkt
     ++	# Receive result from the hook.
     ++	# Case 1: this reference is hidden
     ++	H: PKT-LINE(hide)
     ++	H: flush-pkt
      +
     -+    # Receive result from the hook.
     -+    # Case 1: this reference is valid
     -+    H: PKT-LINE(ok ref <ref>)
     -+    H: flush-pkt
     -+    # Case 2: this reference is filtered out
     -+    H: PKT-LINE(ng ref <ref>)
     -+    H: flush-pkt
     ++	# Case 2: this reference can be advertised
     ++	H: flush-pkt
      +
     -+During commit fetch phase of 'git-upload-pack' process, git client may send `want <oid>`
     -+requests and 'git-upload-pack' will send object filter requests to the hook to check if
     -+the object "<oid>" will be sent to the client or not. In the following example, the letter
     -+'G' stands for 'git-upload-pack' and the letter 'H' stands for this hook.
     ++To enable the `hide-refs` hook, we should config hiderefs with `force:`
     ++option, eg:
      +
     -+The hook will decides if a commit will be sent to the client or not, it sends result with
     -+pkt-line format protocol to `git-upload-pack`, a response in "ok obj <oid>" format
     -+followed by a flush-pkt means the object "<oid>" can be sent to client, and "ng obj <oid>"
     -+means not.
     ++	git config --add transfer.hiderefs force:refs/prefix1/
     ++	git config --add uploadpack.hiderefs force:!refs/prefix2/
      +
     -+    # Version negotiation
     -+    G: PKT-LINE(version=1\0ls-refs)
     -+    G: flush-pkt
     -+    H: PKT-LINE(version=1\0git-upload-pack git-receive-pack ls-refs)
     -+    H: flush-pkt
     -+
     -+    # Send commit filter request to hook
     -+    G: PKT-LINE(obj <oid>)
     -+    G: flush-pkt
     -+
     -+    # Receive result from the hook.
     -+    # Case 1: this object is valid
     -+    H: PKT-LINE(ok obj <oid>)
     -+    H: flush-pkt
     -+    # Case 2: this object is filtered out
     -+    H: PKT-LINE(ng obj <oid>)
     -+    H: flush-pkt
     ++the `hide-refs` will be called during reference discovery phase and
     ++check each matched reference, a 'hide' reponse means the reference will
     ++be hidden for its private data and even the `allowTipSHA1InWant` and
     ++`allowReachableSHA1InWant` is set to true.
      +
       [[pre-receive]]
       pre-receive

-- 
gitgitgadget
