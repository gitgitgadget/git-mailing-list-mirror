Return-Path: <SRS0=dTtN=5S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 663A0C2BA13
	for <git@archiver.kernel.org>; Thu,  2 Apr 2020 07:09:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2D7020784
	for <git@archiver.kernel.org>; Thu,  2 Apr 2020 07:09:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="KGfOrQc8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hp3U7OYH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732537AbgDBHJR (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Apr 2020 03:09:17 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:56537 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728628AbgDBHJQ (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 2 Apr 2020 03:09:16 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 9A5845C0296;
        Thu,  2 Apr 2020 03:09:14 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Thu, 02 Apr 2020 03:09:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=wRq7WVH7L9BK7g6wz4nsMvA7dVm
        k70Q+TrZDfb94A9Y=; b=KGfOrQc8eIYwVgn+gTgwhpJW/n6FNc9Mv1PMvtaKqNT
        iDyv14GwEJgygJpWQa0q5qjTAKxvwI/cv18XDu90LwltlMk0Ihz4O9EjPKM5QrAu
        LoozcdAIztbXrtadzI0wputA3kk3GMa7ADJtXEujPrPHlbOfTV3fkCoByEbHi0ex
        ha0JgGFAd3K7QaWK7XpKZCLsd3dO9k/i77lAsvbCpBlLwjXy1IAAmvkx/nLC5G8k
        enw4TxKXJB1ADd7sBA3hTUvVZkh6CkrCVIsn0sHb0raXJFQAleEg1Gsu3ACvSOoX
        1Z9LoTEr01Ro+Sce6r96NkknDlCujEgOriUWZj7Ku0g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=wRq7WV
        H7L9BK7g6wz4nsMvA7dVmk70Q+TrZDfb94A9Y=; b=hp3U7OYHeoSpJ1uSpg8g9H
        lhYYeV/EQkBeBhDrPeo6Vo9YeLazzjOOobZPH4QVeMeVnQm6656dm81pfFBH01Hs
        Elf0ibIZgl9gAmFhwBX3SFxsbk8gUDlkw902XuhRDoMy5DzURbKyhSlo8bdGcaNu
        5J5Ibj/w5LKTl950GhUCl7Um6q6t5UYmLoMsZQI9dI4ICxleg/3tS/mPCD7CPrY3
        aPpYS283TFVvjPRw7YxFU5UBcH3quwqe4PkEAGkCv1+9QyT5UaHNZUrkVCJAfRxg
        nNKTCjK4vqAfpdHAl861wHh/1FgedJ7kq2WA2+LnO1xXyK2silMX7Jcd8KQSDLCw
        ==
X-ME-Sender: <xms:mo-FXvqAzc0tBNufO8_eozkyHx_tE9gu1_RcgfttoVUCPq0-0C23cg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrtdefgdduudeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucfkphepkeelrdduvd
    drleegrddvkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhr
    ohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:mo-FXhzEAM8xE87dDGWZvFwzGGr4Zc0u2ZsnbVpgLNgTJAiY8MBY6g>
    <xmx:mo-FXkwL76kEXTp6E4LHiQyZXZxYnFPLJ9XNZdzH0vWZW8X0_XeQjw>
    <xmx:mo-FXuaP8r-iLBkt7UzWUAysr3VcPUZkpoG5vN_Xgcd9hnPRHuE6Dw>
    <xmx:mo-FXhh_pgL7odw0lpv3xz5tsgcruGY1CtmFqzg7TJF0LuukCJgvNQ>
Received: from vm-mail.pks.im (x590c5e1c.dyn.telefonica.de [89.12.94.28])
        by mail.messagingengine.com (Postfix) with ESMTPA id AC816306CDC1;
        Thu,  2 Apr 2020 03:09:13 -0400 (EDT)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 9a6f8cce (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Thu, 2 Apr 2020 07:09:08 +0000 (UTC)
Date:   Thu, 2 Apr 2020 09:09:15 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     git <git@vger.kernel.org>
Cc:     Christian Couder <christian.couder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 0/9] Support for transactions in `git-update-ref --stdin`
Message-ID: <cover.1585811013.git.ps@pks.im>
References: <cover.1585129842.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="CE+1k2dSO48ffgeK"
Content-Disposition: inline
In-Reply-To: <cover.1585129842.git.ps@pks.im>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--CE+1k2dSO48ffgeK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

this is the second version of this patch series to introduce transaction
support in `git update-ref --stdin`. The goal is to make commands
available to the user of that command so that he can explicitly control
the given transaction by starting, preparing, and finally committing or
aborting the transaction.

This version improves the argument handling for commands as proposed by
Junio. Instead of the hard-to-understand `extra_lines` field, commands
now have a `args` field that specifies how many arguments a given
command has, including the first one separated by a space. As a result,
the initial space for the first argument is now handled in the generic
part and not moved into each of the command functions anymore. I've also
added a comment that clarifies why we ignore EOF when fetching
additional command lines.

The range-diff against v2 is attached below.

Patrick

Patrick Steinhardt (9):
  refs: fix segfault when aborting empty transaction
  git-update-ref.txt: add missing word
  strbuf: provide function to append whole lines
  update-ref: organize commands in an array
  update-ref: drop unused argument for `parse_refname`
  update-ref: pass end pointer instead of strbuf
  update-ref: move transaction handling into `update_refs_stdin()`
  update-ref: read commands in a line-wise fashion
  update-ref: implement interactive transaction handling

 Documentation/git-update-ref.txt |  28 +++-
 builtin/update-ref.c             | 245 ++++++++++++++++++++++---------
 refs/files-backend.c             |  20 +--
 strbuf.c                         |  10 ++
 strbuf.h                         |   6 +
 t/t1400-update-ref.sh            | 131 +++++++++++++++++
 6 files changed, 364 insertions(+), 76 deletions(-)

Range-diff against v2:
 1:  7a297db4da =3D  1:  7a297db4da refs: fix segfault when aborting empty =
transaction
 2:  15857e1b8c =3D  2:  15857e1b8c git-update-ref.txt: add missing word
 3:  b6546ae44e =3D  3:  b6546ae44e strbuf: provide function to append whol=
e lines
 4:  bd8c059fbc !  4:  0f881d4936 update-ref: organize commands in an array
    @@ Commit message
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
    =20
      ## builtin/update-ref.c ##
    -@@ builtin/update-ref.c: static int parse_next_oid(struct strbuf *inpu=
t, const char **next,
    - /*
    -  * The following five parse_cmd_*() functions parse the corresponding
    -  * command.  In each case, next points at the character following the
    -- * command name and the following space.  They each return a pointer
    -- * to the character terminating the command, and die with an
    -- * explanatory message if there are any parsing problems.  All of
    -- * these functions handle either text or binary format input,
    -- * depending on how line_termination is set.
    -+ * command name.  They each return a pointer to the character
    -+ * terminating the command, and die with an explanatory message if
    -+ * there are any parsing problems.  All of these functions handle
    -+ * either text or binary format input, depending on how
    -+ * line_termination is set.
    -  */
    -=20
    - static const char *parse_cmd_update(struct ref_transaction *transacti=
on,
    -@@ builtin/update-ref.c: static const char *parse_cmd_update(struct re=
f_transaction *transaction,
    - 	struct object_id new_oid, old_oid;
    - 	int have_old;
    -=20
    -+	if (!skip_prefix(next, " ", &next))
    -+		die("update: missing space after command");
    -+
    - 	refname =3D parse_refname(input, &next);
    - 	if (!refname)
    - 		die("update: missing <ref>");
    -@@ builtin/update-ref.c: static const char *parse_cmd_create(struct re=
f_transaction *transaction,
    - 	char *refname;
    - 	struct object_id new_oid;
    -=20
    -+	if (!skip_prefix(next, " ", &next))
    -+		die("create: missing space after command");
    -+
    - 	refname =3D parse_refname(input, &next);
    - 	if (!refname)
    - 		die("create: missing <ref>");
    -@@ builtin/update-ref.c: static const char *parse_cmd_delete(struct re=
f_transaction *transaction,
    - 	struct object_id old_oid;
    - 	int have_old;
    -=20
    -+	if (!skip_prefix(next, " ", &next))
    -+		die("delete: missing space after command");
    -+
    - 	refname =3D parse_refname(input, &next);
    - 	if (!refname)
    - 		die("delete: missing <ref>");
    -@@ builtin/update-ref.c: static const char *parse_cmd_verify(struct re=
f_transaction *transaction,
    - 	char *refname;
    - 	struct object_id old_oid;
    -=20
    -+	if (!skip_prefix(next, " ", &next))
    -+		die("verify: missing space after command");
    -+
    - 	refname =3D parse_refname(input, &next);
    - 	if (!refname)
    - 		die("verify: missing <ref>");
     @@ builtin/update-ref.c: static const char *parse_cmd_verify(struct re=
f_transaction *transaction,
      	return next;
      }
    @@ builtin/update-ref.c: static const char *parse_cmd_verify(struct ref=
_transaction
     +				    struct strbuf *input, const char *next)
      {
      	const char *rest;
    -+	if (!skip_prefix(next, " ", &next))
    -+		die("option: missing space after command");
      	if (skip_prefix(next, "no-deref", &rest) && *rest =3D=3D line_termin=
ation)
    - 		update_flags |=3D REF_NO_DEREF;
    - 	else
     @@ builtin/update-ref.c: static const char *parse_cmd_option(struct st=
rbuf *input, const char *next)
      	return rest;
      }
    @@ builtin/update-ref.c: static const char *parse_cmd_option(struct str=
buf *input,
     +		for (i =3D 0; i < ARRAY_SIZE(command); i++) {
     +			const char *prefix =3D command[i].prefix;
     +
    -+			if (!skip_prefix(next, prefix, &next))
    -+				continue;
    -+
    -+			/*
    -+			 * Check that the command is terminated by an argument
    -+			 * or line terminator and not only a matching prefix.
    -+			 */
    -+			if (input.buf[strlen(prefix)] !=3D line_termination &&
    -+			    input.buf[strlen(prefix)] !=3D '\0' &&
    -+			    input.buf[strlen(prefix)] !=3D ' ')
    ++			if (!skip_prefix(next, prefix, &next) ||
    ++			    !skip_prefix(next, " ", &next))
     +				continue;
     +
     +			cmd =3D &command[i];
 5:  49a14d2046 !  5:  c96395a14d update-ref: drop unused argument for `par=
se_refname`
    @@ builtin/update-ref.c: static const char *parse_arg(const char *next,=
 struct strb
      	struct strbuf ref =3D STRBUF_INIT;
     =20
     @@ builtin/update-ref.c: static const char *parse_cmd_update(struct re=
f_transaction *transaction,
    - 	if (!skip_prefix(next, " ", &next))
    - 		die("update: missing space after command");
    + 	struct object_id new_oid, old_oid;
    + 	int have_old;
     =20
     -	refname =3D parse_refname(input, &next);
     +	refname =3D parse_refname(&next);
    @@ builtin/update-ref.c: static const char *parse_cmd_update(struct ref=
_transaction
      		die("update: missing <ref>");
     =20
     @@ builtin/update-ref.c: static const char *parse_cmd_create(struct re=
f_transaction *transaction,
    - 	if (!skip_prefix(next, " ", &next))
    - 		die("create: missing space after command");
    + 	char *refname;
    + 	struct object_id new_oid;
     =20
     -	refname =3D parse_refname(input, &next);
     +	refname =3D parse_refname(&next);
    @@ builtin/update-ref.c: static const char *parse_cmd_create(struct ref=
_transaction
      		die("create: missing <ref>");
     =20
     @@ builtin/update-ref.c: static const char *parse_cmd_delete(struct re=
f_transaction *transaction,
    - 	if (!skip_prefix(next, " ", &next))
    - 		die("delete: missing space after command");
    + 	struct object_id old_oid;
    + 	int have_old;
     =20
     -	refname =3D parse_refname(input, &next);
     +	refname =3D parse_refname(&next);
    @@ builtin/update-ref.c: static const char *parse_cmd_delete(struct ref=
_transaction
      		die("delete: missing <ref>");
     =20
     @@ builtin/update-ref.c: static const char *parse_cmd_verify(struct re=
f_transaction *transaction,
    - 	if (!skip_prefix(next, " ", &next))
    - 		die("verify: missing space after command");
    + 	char *refname;
    + 	struct object_id old_oid;
     =20
     -	refname =3D parse_refname(input, &next);
     +	refname =3D parse_refname(&next);
 6:  cbe430029d !  6:  192cbf5944 update-ref: pass end pointer instead of s=
trbuf
    @@ builtin/update-ref.c: static const char *parse_cmd_verify(struct ref=
_transaction
     +				    const char *next, const char *end)
      {
      	const char *rest;
    - 	if (!skip_prefix(next, " ", &next))
    + 	if (skip_prefix(next, "no-deref", &rest) && *rest =3D=3D line_termin=
ation)
     @@ builtin/update-ref.c: static const char *parse_cmd_option(struct re=
f_transaction *transaction,
     =20
      static const struct parse_cmd {
 7:  d2f68f59a7 =3D  7:  be7bcf3dbd update-ref: move transaction handling i=
nto `update_refs_stdin()`
 8:  f8786fdeb3 !  8:  02ff6b7337 update-ref: read commands in a line-wise =
fashion
    @@ Commit message
    =20
      ## builtin/update-ref.c ##
     @@ builtin/update-ref.c: static int parse_next_oid(const char **next, =
const char *end,
    -  * line_termination is set.
    +  * depending on how line_termination is set.
       */
     =20
     -static const char *parse_cmd_update(struct ref_transaction *transacti=
on,
    @@ builtin/update-ref.c: static const char *parse_cmd_verify(struct ref=
_transaction
     +			     const char *next, const char *end)
      {
      	const char *rest;
    - 	if (!skip_prefix(next, " ", &next))
    -@@ builtin/update-ref.c: static const char *parse_cmd_option(struct re=
f_transaction *transaction,
    + 	if (skip_prefix(next, "no-deref", &rest) && *rest =3D=3D line_termin=
ation)
      		update_flags |=3D REF_NO_DEREF;
      	else
      		die("option unknown: %s", next);
    @@ builtin/update-ref.c: static const char *parse_cmd_option(struct ref=
_transaction
      	const char *prefix;
     -	const char *(*fn)(struct ref_transaction *, const char *, const char=
 *);
     +	void (*fn)(struct ref_transaction *, const char *, const char *);
    -+	/*
    -+	 * If using NUL-terminated format, only the first argument will be
    -+	 * available in the first line. In case a command expects more than =
one
    -+	 * argument, we thus have to fetch an additional `extra_lines` number
    -+	 * of lines.
    -+	 */
    -+	unsigned extra_lines;
    ++	unsigned args;
      } command[] =3D {
     -	{ "update", parse_cmd_update },
     -	{ "create", parse_cmd_create },
     -	{ "delete", parse_cmd_delete },
     -	{ "verify", parse_cmd_verify },
     -	{ "option", parse_cmd_option },
    -+	{ "update", parse_cmd_update, 2 },
    -+	{ "create", parse_cmd_create, 1 },
    -+	{ "delete", parse_cmd_delete, 1 },
    -+	{ "verify", parse_cmd_verify, 1 },
    -+	{ "option", parse_cmd_option, 0 },
    ++	{ "update", parse_cmd_update, 3 },
    ++	{ "create", parse_cmd_create, 2 },
    ++	{ "delete", parse_cmd_delete, 2 },
    ++	{ "verify", parse_cmd_verify, 2 },
    ++	{ "option", parse_cmd_option, 1 },
      };
     =20
      static void update_refs_stdin(void)
    @@ builtin/update-ref.c: static const char *parse_cmd_option(struct ref=
_transaction
     =20
      		for (i =3D 0; i < ARRAY_SIZE(command); i++) {
      			const char *prefix =3D command[i].prefix;
    ++			char c;
     =20
    --			if (!skip_prefix(next, prefix, &next))
    +-			if (!skip_prefix(next, prefix, &next) ||
    +-			    !skip_prefix(next, " ", &next))
     +			if (!starts_with(input.buf, prefix))
    ++				continue;
    ++
    ++			/*
    ++			 * If the command has arguments, verify that it's
    ++			 * followed by a space. Otherwise, it shall be followed
    ++			 * by a line terminator.
    ++			 */
    ++			c =3D command[i].args ? ' ' : line_termination;
    ++			if (input.buf[strlen(prefix)] !=3D c)
      				continue;
     =20
    - 			/*
    -@@ builtin/update-ref.c: static void update_refs_stdin(void)
    + 			cmd =3D &command[i];
      			break;
      		}
      		if (!cmd)
    @@ builtin/update-ref.c: static void update_refs_stdin(void)
     -		next =3D cmd->fn(transaction, next, input.buf + input.len);
     -		next++;
     +		/*
    -+		 * Read extra lines if NUL-terminated. Do not raise an error in
    -+		 * case there is an early EOF to let the command handle missing
    -+		 * arguments with a proper error message.
    ++		 * Read additional arguments if NUL-terminated. Do not raise an
    ++		 * error in case there is an early EOF to let the command
    ++		 * handle missing arguments with a proper error message.
     +		 */
    -+		for (j =3D 0; line_termination =3D=3D '\0' && j < cmd->extra_lines;=
 j++)
    ++		for (j =3D 1; line_termination =3D=3D '\0' && j < cmd->args; j++)
     +			if (strbuf_appendwholeline(&input, stdin, line_termination))
     +				break;
     +
    -+		cmd->fn(transaction, input.buf + strlen(cmd->prefix),
    ++		cmd->fn(transaction, input.buf + strlen(cmd->prefix) + !!cmd->args,
     +			input.buf + input.len);
      	}
     =20
 9:  c3fffdf9fa !  9:  5670bea2b1 update-ref: implement interactive transac=
tion handling
    @@ builtin/update-ref.c: static void parse_cmd_option(struct ref_transa=
ction *trans
      static const struct parse_cmd {
      	const char *prefix;
      	void (*fn)(struct ref_transaction *, const char *, const char *);
    -@@ builtin/update-ref.c: static const struct parse_cmd {
    - 	 * of lines.
    - 	 */
    - 	unsigned extra_lines;
    + 	unsigned args;
     +	enum update_refs_state state;
      } command[] =3D {
    --	{ "update", parse_cmd_update, 2 },
    --	{ "create", parse_cmd_create, 1 },
    --	{ "delete", parse_cmd_delete, 1 },
    --	{ "verify", parse_cmd_verify, 1 },
    --	{ "option", parse_cmd_option, 0 },
    -+	{ "update",  parse_cmd_update,  2, UPDATE_REFS_OPEN },
    -+	{ "create",  parse_cmd_create,  1, UPDATE_REFS_OPEN },
    -+	{ "delete",  parse_cmd_delete,  1, UPDATE_REFS_OPEN },
    -+	{ "verify",  parse_cmd_verify,  1, UPDATE_REFS_OPEN },
    -+	{ "option",  parse_cmd_option,  0, UPDATE_REFS_OPEN },
    +-	{ "update", parse_cmd_update, 3 },
    +-	{ "create", parse_cmd_create, 2 },
    +-	{ "delete", parse_cmd_delete, 2 },
    +-	{ "verify", parse_cmd_verify, 2 },
    +-	{ "option", parse_cmd_option, 1 },
    ++	{ "update",  parse_cmd_update,  3, UPDATE_REFS_OPEN },
    ++	{ "create",  parse_cmd_create,  2, UPDATE_REFS_OPEN },
    ++	{ "delete",  parse_cmd_delete,  2, UPDATE_REFS_OPEN },
    ++	{ "verify",  parse_cmd_verify,  2, UPDATE_REFS_OPEN },
    ++	{ "option",  parse_cmd_option,  1, UPDATE_REFS_OPEN },
     +	{ "start",   parse_cmd_start,   0, UPDATE_REFS_STARTED },
     +	{ "prepare", parse_cmd_prepare, 0, UPDATE_REFS_PREPARED },
     +	{ "abort",   parse_cmd_abort,   0, UPDATE_REFS_CLOSED },
    @@ builtin/update-ref.c: static void update_refs_stdin(void)
     +			break;
     +		}
     +
    - 		cmd->fn(transaction, input.buf + strlen(cmd->prefix),
    + 		cmd->fn(transaction, input.buf + strlen(cmd->prefix) + !!cmd->args,
      			input.buf + input.len);
      	}
     =20
--=20
2.26.0


--CE+1k2dSO48ffgeK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAl6Fj5sACgkQVbJhu7ck
PpSeVRAApwtEWAIkge/KJcpXqX1sebq3THlZQfSvVjQGgTkWF0KaHtngqn8lSa57
+nmW0e+gcwkW0mZu9smAh/htaYDaZ82Nu0XgJpOvQzia0l+D8KN/qsc6gsT8UnMX
73JWtD4RoQ/2aT52hwDIesvVTCnHBbNaZ9Nffw+gA2mvsSC/hOJ6ciCROa0T0jNq
k0C9a/bA0ilcKa5lTVlC8jDggLlA4F7Abmx5crqekyZb+2dA4YL4MkMUQdDuDsnW
861BOLNhnqttXHyw2KBtlWPjglUfOT4wFrAXBTnt3KAXp9APpjSwZeewLQ7OIyoG
3W5ih2Jrki6g+DMotnW1PHjSHNnQ83SO8ueM1YfiXH3fxfB4AFrw1f4MkE6nlI3c
khvSbcpHy7uL1YEyKjInWLoOUZ3DDHMqhT2Ijj+k3tOikG7MLAfaOJJZ+9EWTRQZ
gIHCxnH1MxRliOxLZwpS7pOb4JsHTxi6UaviKX9uUZgi/EX1YSQiBvZj2KyX+Ibh
kCMfQYyGueSan8viaKQG6g5JBfSapVsOu4eIZkADDyCf0n8bwDc/a8b2tB8D8fSa
ruapDrdj4VJjb/Msb3mERDCStNpMs4FTUi8D64SS58EmIUiIjXZL0+ntBp+IKecI
nQknXUcQ7M4lgObWbKpuJCgkzsYz/3RRFvSo4FRGfeBMh2u4bqI=
=D5Fu
-----END PGP SIGNATURE-----

--CE+1k2dSO48ffgeK--
