Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0043BC4332F
	for <git@archiver.kernel.org>; Mon, 15 Nov 2021 22:52:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DDD0963222
	for <git@archiver.kernel.org>; Mon, 15 Nov 2021 22:52:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347638AbhKOWzA (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Nov 2021 17:55:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351354AbhKOWoI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Nov 2021 17:44:08 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B1CEC110F17
        for <git@vger.kernel.org>; Mon, 15 Nov 2021 13:54:50 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id w1so12125610edc.6
        for <git@vger.kernel.org>; Mon, 15 Nov 2021 13:54:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=wJghsRK92xseK3IwUNGM2aukfSmOr+It95ZsBlzoZ2w=;
        b=Vn4pRJ5ChnMLhLaUSCqKgUx7Psfs+8D6aH+/i7lqq4VyXKYQiwOmwNxVDS82f4RCGF
         YTOiRA8yG8e6IivGGW/nJNjdNn/PAQ6dcamjL82LH+ox0IGcsg8sBMqGLHnl5o8/tlY+
         cvP/7uqJlQBLMEs2kjzHFU+nmXFkd/ebXWTIxd+WV6zJRzvaJjseMaNTFMdAGakFiILs
         Cm7I81swt1pqQcgeCVYxxZhRypJ2hAuaNK9KltYuNuHEEN6zHvjqurEEHhI/Rzp9mIjv
         NtSn1RZ1dxyS9lZh2rRqEr91k8wCgGWYt0AYtZX5gyLT9dXaGdfzgeBMzMgJFoR4Cx6k
         Udpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=wJghsRK92xseK3IwUNGM2aukfSmOr+It95ZsBlzoZ2w=;
        b=1sAWgIf8dxxlb3IDPCFPcZ+zqTsURVMQKcBwvLWc6LEYiiIqa+2zs3plDxw4zHMG3o
         2KBzniYpavZSZGEovtpJUzGkEVMp9Jdya30mrc8tsn5R7gNlKxHcTfsnOF8MsOnJIk2X
         sbvUmYrXkD+U9e/goyVZd7l4rllUIk9dYmXsCs2H+4MHcinvAn5J3lp+R6Qv5AblklfF
         7eTdaus3DuVcyya62gjhFWTeEbHXGDM7Jnge8ktReMJainWZBGaL99g0ItaKXqmaW6Rw
         FDKMJZbnLsKeT/UxS53ITwUQvqHrft9qLYtUOGjmWclxK5PBNfZeelubxR8JJiWlHbJD
         9rIg==
X-Gm-Message-State: AOAM530DPogStGwrTEf5aVEvjPDBaC/wRIWtpACL1lQPdvkmqrzBY17t
        bkdwJ8lCVVY7K1qtNT3sgxo=
X-Google-Smtp-Source: ABdhPJyCXYz2Mx4+Y9Br9jD1pPP5Mjxf6G8+OtPQHXiKJVL9/4v/UiKbRjETeESkdUk/FyoBMCbNdg==
X-Received: by 2002:a05:6402:51c6:: with SMTP id r6mr2859594edd.365.1637013288919;
        Mon, 15 Nov 2021 13:54:48 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id e12sm7139979ejs.86.2021.11.15.13.54.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Nov 2021 13:54:48 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mmjw7-001Ffr-Ki;
        Mon, 15 Nov 2021 22:54:47 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Teng Long <dyroneteng@gmail.com>, git@vger.kernel.org,
        gitster@pobox.com
Subject: Re: [PATCH 0/3] support `--oid-only` in `ls-tree`
Date:   Mon, 15 Nov 2021 22:50:18 +0100
References: <20211115115153.48307-1-dyroneteng@gmail.com>
 <211115.86mtm5saz7.gmgdl@evledraar.gmail.com>
 <YZKwduZgH4BEpFzd@coredump.intra.peff.net>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.9
In-reply-to: <YZKwduZgH4BEpFzd@coredump.intra.peff.net>
Message-ID: <211115.86o86lqe3c.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Nov 15 2021, Jeff King wrote:

> On Mon, Nov 15, 2021 at 04:13:24PM +0100, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>
>> But I'd much rather see this be done with adding strbuf_expand() to
>> ls-tree. I.e. its docs say that it can emit:
>
> I had a similar thought, but that's a much bigger task. I think it would
> be reasonable to add --oid-only to match the existing --name-only, etc.
> If we later add a custom --format option, then it can easily be folded
> in and explained as "this is an alias for --format=3D%(objectname)", just
> like --name-only would become "this is an alias for --format=3D%(path)".

A quick patch to do it below, seems to work, passes all tests, but I
don't know how much I'd trust it. It's also quite an add use of
strbuf_expa(). We print to stdout directly since
write_name_quoted_relative() really wants to write to stdout, and not
give you a buffer. But I guess it makes sense in a way.

The hardcoded %7s for %(objectsize) is a bit nasty, but I don't know if
we've got anything existing that handles format specifiers with
strbuf_expand() that we could steal.

I really wouldn't trust this code much, I found it when writing it that
our tests for ls-tree are really lacking, e.g. we may not have a single
test for "-l" anywhere (or maybe I didn't look enough, I was just
running t/*ls*tree* while hacking it.

I do thin that we should consider just going with --format in either
case if we agree that this is a good direction. I.e. could just support
3-4 hardcoded formats now and die if anything else is specified.

Then we'd be future-proof with the same interface expanding later, and
wouldn't need to support options that we're only carrying because we
didn't implement the more generic format support.

(Assume my Signed-off-by, if there's any interest...)

diff --git a/builtin/ls-tree.c b/builtin/ls-tree.c
index 3a442631c71..e89daad4229 100644
--- a/builtin/ls-tree.c
+++ b/builtin/ls-tree.c
@@ -31,6 +31,20 @@ static const  char * const ls_tree_usage[] =3D {
 	NULL
 };
=20
+static const char *ls_tree_format_d =3D "%(objectmode) %(objecttype) %(obj=
ectname)	%(path)";
+static const char *ls_tree_format_l =3D "%(objectmode) %(objecttype) %(obj=
ectname) %(objectsize)	%(path)";
+static const char *ls_tree_format_n =3D "%(path)";
+
+struct expand_ls_tree_data {
+	const char *format;
+	unsigned mode;
+	const char *type;
+	const struct object_id *oid;
+	int abbrev;
+	const char *pathname;
+	const char *basebuf;
+};
+
 static int show_recursive(const char *base, int baselen, const char *pathn=
ame)
 {
 	int i;
@@ -61,9 +75,69 @@ static int show_recursive(const char *base, int baselen,=
 const char *pathname)
 	return 0;
 }
=20
+static size_t expand_show_tree(struct strbuf *sb,
+			       const char *start,
+			       void *context)
+{
+	struct expand_ls_tree_data *data =3D context;
+	const char *end;
+	const char *p;
+	size_t len;
+	const char *type =3D blob_type;
+
+	if (sb->len) {
+		fputs(sb->buf, stdout);
+		strbuf_reset(sb);
+	}
+
+	if (*start !=3D '(')
+		die(_("bad format as of '%s'"), start);
+	end =3D strchr(start + 1, ')');
+	if (!end)
+		die(_("ls-tree format element '%s' does not end in ')'"),
+		    start);
+	len =3D end - start + 1;
+
+	if (skip_prefix(start, "(objectmode)", &p)) {
+		printf("%06o", data->mode);
+	} else if (skip_prefix(start, "(objecttype)", &p)) {
+		fputs(data->type, stdout);
+	} else if (skip_prefix(start, "(objectsize)", &p)) {
+		char size_text[24];
+		const struct object_id *oid =3D data->oid;
+
+		if (!strcmp(type, blob_type)) {
+			unsigned long size;
+			if (oid_object_info(the_repository, oid, &size) =3D=3D OBJ_BAD)
+				xsnprintf(size_text, sizeof(size_text),
+					  "BAD");
+			else
+				xsnprintf(size_text, sizeof(size_text),
+					  "%"PRIuMAX, (uintmax_t)size);
+		} else {
+			xsnprintf(size_text, sizeof(size_text), "-");
+		}
+		printf("%7s", size_text);
+	} else if (skip_prefix(start, "(objectname)", &p)) {
+		fputs(find_unique_abbrev(data->oid, data->abbrev), stdout);
+	} else if (skip_prefix(start, "(path)", &p)) {
+		write_name_quoted_relative(data->basebuf,
+					   chomp_prefix ? ls_tree_prefix : NULL,
+					   stdout, line_termination);
+
+	} else {
+		unsigned int errlen =3D (unsigned long)len;
+		die(_("bad ls-tree format specifiec %%%.*s"), errlen, start);=09
+	}
+
+	return len;
+}
+
 static int show_tree(const struct object_id *oid, struct strbuf *base,
 		const char *pathname, unsigned mode, void *context)
 {
+	struct expand_ls_tree_data *data =3D context;
+	struct strbuf sb =3D STRBUF_INIT;
 	int retval =3D 0;
 	int baselen;
 	const char *type =3D blob_type;
@@ -90,31 +164,18 @@ static int show_tree(const struct object_id *oid, stru=
ct strbuf *base,
 	else if (ls_options & LS_TREE_ONLY)
 		return 0;
=20
-	if (!(ls_options & LS_NAME_ONLY)) {
-		if (ls_options & LS_SHOW_SIZE) {
-			char size_text[24];
-			if (!strcmp(type, blob_type)) {
-				unsigned long size;
-				if (oid_object_info(the_repository, oid, &size) =3D=3D OBJ_BAD)
-					xsnprintf(size_text, sizeof(size_text),
-						  "BAD");
-				else
-					xsnprintf(size_text, sizeof(size_text),
-						  "%"PRIuMAX, (uintmax_t)size);
-			} else
-				xsnprintf(size_text, sizeof(size_text), "-");
-			printf("%06o %s %s %7s\t", mode, type,
-			       find_unique_abbrev(oid, abbrev),
-			       size_text);
-		} else
-			printf("%06o %s %s\t", mode, type,
-			       find_unique_abbrev(oid, abbrev));
-	}
 	baselen =3D base->len;
 	strbuf_addstr(base, pathname);
-	write_name_quoted_relative(base->buf,
-				   chomp_prefix ? ls_tree_prefix : NULL,
-				   stdout, line_termination);
+
+	strbuf_reset(&sb);
+	data->mode =3D mode;
+	data->type =3D type;
+	data->oid =3D oid;
+	data->abbrev =3D abbrev;
+	data->pathname =3D pathname;
+	data->basebuf =3D base->buf;
+	strbuf_expand(&sb, data->format, expand_show_tree, data);
+
 	strbuf_setlen(base, baselen);
 	return retval;
 }
@@ -147,6 +208,9 @@ int cmd_ls_tree(int argc, const char **argv, const char=
 *prefix)
 		OPT__ABBREV(&abbrev),
 		OPT_END()
 	};
+	struct expand_ls_tree_data ls_tree_cb_data =3D {
+		.format =3D ls_tree_format_d,
+	};
=20
 	git_config(git_default_config, NULL);
 	ls_tree_prefix =3D prefix;
@@ -161,8 +225,14 @@ int cmd_ls_tree(int argc, const char **argv, const cha=
r *prefix)
 	}
 	/* -d -r should imply -t, but -d by itself should not have to. */
 	if ( (LS_TREE_ONLY|LS_RECURSIVE) =3D=3D
-	    ((LS_TREE_ONLY|LS_RECURSIVE) & ls_options))
+	    ((LS_TREE_ONLY|LS_RECURSIVE) & ls_options)) {
 		ls_options |=3D LS_SHOW_TREES;
+	}
+	if (ls_options & LS_NAME_ONLY)
+		ls_tree_cb_data.format =3D ls_tree_format_n;
+
+	if (ls_options & LS_SHOW_SIZE)
+		ls_tree_cb_data.format =3D ls_tree_format_l;
=20
 	if (argc < 1)
 		usage_with_options(ls_tree_usage, ls_tree_options);
@@ -185,6 +255,7 @@ int cmd_ls_tree(int argc, const char **argv, const char=
 *prefix)
 	tree =3D parse_tree_indirect(&oid);
 	if (!tree)
 		die("not a tree object");
+
 	return !!read_tree(the_repository, tree,
-			   &pathspec, show_tree, NULL);
+			   &pathspec, show_tree, &ls_tree_cb_data);
 }
