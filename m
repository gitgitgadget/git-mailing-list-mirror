Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0B17C04FEE
	for <git@archiver.kernel.org>; Wed, 20 Sep 2023 19:17:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229947AbjITTRu (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Sep 2023 15:17:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229909AbjITTRf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Sep 2023 15:17:35 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81144C9
        for <git@vger.kernel.org>; Wed, 20 Sep 2023 12:17:27 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1c44c7dbaf9so1167865ad.1
        for <git@vger.kernel.org>; Wed, 20 Sep 2023 12:17:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695237446; x=1695842246; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+jPS6BZe6RLahQCTZmydG1BSuWRManQQlj1c5w8gGs8=;
        b=fCq1t9JWuxsiKj2g8aVrrGg4iOrU9mDn1awYurCkGmJhRbuSCg//a3oMam1ebARUvG
         DBgzDPP8VODk7qdWgpv0QIgfOlw9151WvMa+YwTG7W/bUtxTj+cNNCDp0duVO5/3BwNB
         7HqCh5CXXvJauKRC57qxazTK2e1tLVLk2epEoMmjx75KRINO8wAKPxW0m5K/hlOhiKXZ
         aV91CH1u1JNwpvKer9yJ4b94z6PGR869Aa9cc8ynNJ5+gi9esXr2DcQfsitJIhYZ9AJc
         SBpNwBvIIKDb9cUO6TXmiWsEhwmMhK2kI9MIr8hl0FzMr4XD78RzfhF/W2xoNJodGcbn
         dmuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695237447; x=1695842247;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+jPS6BZe6RLahQCTZmydG1BSuWRManQQlj1c5w8gGs8=;
        b=GxlBrEE2hFNW8IfuXsTSJM9NsZxaK2SYLMT7BdWe9yvuD62+vrtp8Hu1tlqFNdc1Z6
         AR3IzK/Zq0Iu7O3+xo8q33u+nuJtDRf1CsrpBJA0DfW6w7fFnM6me1njuYLH67Iom5iB
         OOQYnOfBTxGljJjyDIHjvzUOIb9tQP2jvv39JTSrLwnrNhItTwuNY49+DxCLdamDIdM0
         WEaiyFaquG6574gEpLfw5HbIX0k4pw/Rc84oR7/SZjakJ9hDwaa0KO7tzDyHBl0LtnXh
         fOwqKYs+XbySIJ9mtJXogoTeTzlFfZLqf4axEtR7DVc5nQ0LGmtna2zwDMfwxfmtCj6L
         g8bw==
X-Gm-Message-State: AOJu0YyaBYB678lUO+KWTSdh2KHavIGiYS6lCtiV/JBaNG2gEJ5RpaOy
        +AyHvffDEvTfAI6RIewFwwj3pxl/wmffXg==
X-Google-Smtp-Source: AGHT+IEKphpqgdeIribJCyCiCXIKwWZ7aAHBmFKVRLtKKQ1pKYHEwfxa93pfVNHabgd3pYWYe90e6Q==
X-Received: by 2002:a17:903:2291:b0:1b8:83a3:7db6 with SMTP id b17-20020a170903229100b001b883a37db6mr3771506plh.44.1695237446403;
        Wed, 20 Sep 2023 12:17:26 -0700 (PDT)
Received: from fivlite-virtual-machine.localdomain ([49.37.159.110])
        by smtp.gmail.com with ESMTPSA id l20-20020a170903005400b001c420afa03bsm11146847pla.109.2023.09.20.12.17.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 12:17:26 -0700 (PDT)
From:   Kousik Sanagavarapu <five231003@gmail.com>
To:     git@vger.kernel.org
Cc:     Kousik Sanagavarapu <five231003@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>
Subject: [PATCH 2/2] ref-filter: add mailmap support
Date:   Thu, 21 Sep 2023 00:35:42 +0530
Message-ID: <20230920191654.6133-3-five231003@gmail.com>
X-Mailer: git-send-email 2.42.0.160.g6905eb16ce.dirty
In-Reply-To: <20230920191654.6133-1-five231003@gmail.com>
References: <20230920191654.6133-1-five231003@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add mailmap support to ref-filter formats which are similar in
pretty. This support is such that the following pretty placeholders are
equivalent to the new ref-filter atoms:

	%aN = authorname:mailmap
	%cN = committername:mailmap

	%aE = authoremail:mailmap
	%aL = authoremail:mailmap,localpart
	%cE = committeremail:mailmap
	%cL = committeremail:mailmap,localpart

Additionally, mailmap can also be used with ":trim" option for email by
doing something like "authoremail:mailmap,trim".

The above also applies for the "tagger" atom, that is,
"taggername:mailmap", "taggeremail:mailmap", "taggeremail:mailmap,trim"
and "taggername:mailmap,localpart".

The functionality of ":trim" and ":localpart" remains the same. That is,
":trim" gives the email, but without the angle brackets and ":localpart"
gives the part of the email before the '@' character (if such a
character is not found then we directly grab everything between the
angle brackets).

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Hariom Verma <hariom18599@gmail.com>
Signed-off-by: Kousik Sanagavarapu <five231003@gmail.com>
---
 Documentation/git-for-each-ref.txt |   6 +-
 ref-filter.c                       | 152 ++++++++++++++++++++++-------
 t/t6300-for-each-ref.sh            |  83 ++++++++++++++++
 3 files changed, 205 insertions(+), 36 deletions(-)

diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
index 11b2bc3121..e86d5700dd 100644
--- a/Documentation/git-for-each-ref.txt
+++ b/Documentation/git-for-each-ref.txt
@@ -303,7 +303,11 @@ Fields that have name-email-date tuple as its value (`author`,
 and `date` to extract the named component.  For email fields (`authoremail`,
 `committeremail` and `taggeremail`), `:trim` can be appended to get the email
 without angle brackets, and `:localpart` to get the part before the `@` symbol
-out of the trimmed email.
+out of the trimmed email. In addition to these, the `:mailmap` option and the
+corresponding `:mailmap,trim` and `:mailmap,localpart` can be used (order does
+not matter) to get values of the name and email according to the .mailmap file
+or according to the file set in the mailmap.file or mailmap.blob configuration
+variable (see linkgit:gitmailmap[5]).
 
 The raw data in an object is `raw`.
 
diff --git a/ref-filter.c b/ref-filter.c
index fae9f4b8ed..e4d3510e28 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -13,6 +13,8 @@
 #include "oid-array.h"
 #include "repository.h"
 #include "commit.h"
+#include "mailmap.h"
+#include "ident.h"
 #include "remote.h"
 #include "color.h"
 #include "tag.h"
@@ -215,8 +217,16 @@ static struct used_atom {
 		struct {
 			enum { O_SIZE, O_SIZE_DISK } option;
 		} objectsize;
-		struct email_option {
-			enum { EO_RAW, EO_TRIM, EO_LOCALPART } option;
+		struct {
+			enum { N_RAW, N_MAILMAP } option;
+		} name_option;
+		struct {
+			enum {
+				EO_RAW = 0,
+				EO_TRIM = 1<<0,
+				EO_LOCALPART = 1<<1,
+				EO_MAILMAP = 1<<2,
+			} option;
 		} email_option;
 		struct {
 			enum { S_BARE, S_GRADE, S_SIGNER, S_KEY,
@@ -720,21 +730,55 @@ static int oid_atom_parser(struct ref_format *format UNUSED,
 	return 0;
 }
 
-static int person_email_atom_parser(struct ref_format *format UNUSED,
-				    struct used_atom *atom,
-				    const char *arg, struct strbuf *err)
+static int person_name_atom_parser(struct ref_format *format UNUSED,
+				   struct used_atom *atom,
+				   const char *arg, struct strbuf *err)
 {
 	if (!arg)
-		atom->u.email_option.option = EO_RAW;
-	else if (!strcmp(arg, "trim"))
-		atom->u.email_option.option = EO_TRIM;
-	else if (!strcmp(arg, "localpart"))
-		atom->u.email_option.option = EO_LOCALPART;
+		atom->u.name_option.option = N_RAW;
+	else if (!strcmp(arg, "mailmap"))
+		atom->u.name_option.option = N_MAILMAP;
 	else
 		return err_bad_arg(err, atom->name, arg);
 	return 0;
 }
 
+static int email_atom_option_parser(struct used_atom *atom,
+				    const char **arg, struct strbuf *err)
+{
+	if (!*arg)
+		return EO_RAW;
+	if (skip_prefix(*arg, "trim", arg))
+		return EO_TRIM;
+	if (skip_prefix(*arg, "localpart", arg))
+		return EO_LOCALPART;
+	if (skip_prefix(*arg, "mailmap", arg))
+		return EO_MAILMAP;
+	return -1;
+}
+
+static int person_email_atom_parser(struct ref_format *format UNUSED,
+				    struct used_atom *atom,
+				    const char *arg, struct strbuf *err)
+{
+	for (;;) {
+		int opt = email_atom_option_parser(atom, &arg, err);
+		const char *bad_arg = arg;
+
+		if (opt < 0)
+			return err_bad_arg(err, atom->name, bad_arg);
+		atom->u.email_option.option |= opt;
+
+		if (!arg || !*arg)
+			break;
+		if (*arg == ',')
+			arg++;
+		else
+			return err_bad_arg(err, atom->name, bad_arg);
+	}
+	return 0;
+}
+
 static int refname_atom_parser(struct ref_format *format UNUSED,
 			       struct used_atom *atom,
 			       const char *arg, struct strbuf *err)
@@ -877,15 +921,15 @@ static struct {
 	[ATOM_TYPE] = { "type", SOURCE_OBJ },
 	[ATOM_TAG] = { "tag", SOURCE_OBJ },
 	[ATOM_AUTHOR] = { "author", SOURCE_OBJ },
-	[ATOM_AUTHORNAME] = { "authorname", SOURCE_OBJ },
+	[ATOM_AUTHORNAME] = { "authorname", SOURCE_OBJ, FIELD_STR, person_name_atom_parser },
 	[ATOM_AUTHOREMAIL] = { "authoremail", SOURCE_OBJ, FIELD_STR, person_email_atom_parser },
 	[ATOM_AUTHORDATE] = { "authordate", SOURCE_OBJ, FIELD_TIME },
 	[ATOM_COMMITTER] = { "committer", SOURCE_OBJ },
-	[ATOM_COMMITTERNAME] = { "committername", SOURCE_OBJ },
+	[ATOM_COMMITTERNAME] = { "committername", SOURCE_OBJ, FIELD_STR, person_name_atom_parser },
 	[ATOM_COMMITTEREMAIL] = { "committeremail", SOURCE_OBJ, FIELD_STR, person_email_atom_parser },
 	[ATOM_COMMITTERDATE] = { "committerdate", SOURCE_OBJ, FIELD_TIME },
 	[ATOM_TAGGER] = { "tagger", SOURCE_OBJ },
-	[ATOM_TAGGERNAME] = { "taggername", SOURCE_OBJ },
+	[ATOM_TAGGERNAME] = { "taggername", SOURCE_OBJ, FIELD_STR, person_name_atom_parser },
 	[ATOM_TAGGEREMAIL] = { "taggeremail", SOURCE_OBJ, FIELD_STR, person_email_atom_parser },
 	[ATOM_TAGGERDATE] = { "taggerdate", SOURCE_OBJ, FIELD_TIME },
 	[ATOM_CREATOR] = { "creator", SOURCE_OBJ },
@@ -1486,32 +1530,49 @@ static const char *copy_name(const char *buf)
 	return xstrdup("");
 }
 
+static const char *find_end_of_email(const char *email, int opt)
+{
+	const char *eoemail;
+
+	if (opt & EO_LOCALPART) {
+		eoemail = strchr(email, '@');
+		if (eoemail)
+			return eoemail;
+		return strchr(email, '>');
+	}
+
+	if (opt & EO_TRIM)
+		return strchr(email, '>');
+
+	/*
+	 * The option here is either the raw email option or the raw
+	 * mailmap option (that is EO_RAW or EO_MAILMAP). In such cases,
+	 * we directly grab the whole email including the closing
+	 * angle brackets.
+	 *
+	 * If EO_MAILMAP was set with any other option (that is either
+	 * EO_TRIM or EO_LOCALPART), we already grab the end of email
+	 * above.
+	 */
+	eoemail = strchr(email, '>');
+	if (eoemail)
+		eoemail++;
+	return eoemail;
+}
+
 static const char *copy_email(const char *buf, struct used_atom *atom)
 {
 	const char *email = strchr(buf, '<');
 	const char *eoemail;
+	int opt = atom->u.email_option.option;
+
 	if (!email)
 		return xstrdup("");
-	switch (atom->u.email_option.option) {
-	case EO_RAW:
-		eoemail = strchr(email, '>');
-		if (eoemail)
-			eoemail++;
-		break;
-	case EO_TRIM:
-		email++;
-		eoemail = strchr(email, '>');
-		break;
-	case EO_LOCALPART:
+
+	if (opt & (EO_LOCALPART | EO_TRIM))
 		email++;
-		eoemail = strchr(email, '@');
-		if (!eoemail)
-			eoemail = strchr(email, '>');
-		break;
-	default:
-		BUG("unknown email option");
-	}
 
+	eoemail = find_end_of_email(email, opt);
 	if (!eoemail)
 		return xstrdup("");
 	return xmemdupz(email, eoemail - email);
@@ -1572,16 +1633,23 @@ static void grab_date(const char *buf, struct atom_value *v, const char *atomnam
 	v->value = 0;
 }
 
+static struct string_list mailmap = STRING_LIST_INIT_NODUP;
+
 /* See grab_values */
 static void grab_person(const char *who, struct atom_value *val, int deref, void *buf)
 {
 	int i;
 	int wholen = strlen(who);
 	const char *wholine = NULL;
+	const char *headers[] = { "author ", "committer ",
+				  "tagger ", NULL };
 
 	for (i = 0; i < used_atom_cnt; i++) {
-		const char *name = used_atom[i].name;
+		struct used_atom *atom = &used_atom[i];
+		const char *name = atom->name;
 		struct atom_value *v = &val[i];
+		struct strbuf mailmap_buf = STRBUF_INIT;
+
 		if (!!deref != (*name == '*'))
 			continue;
 		if (deref)
@@ -1589,22 +1657,36 @@ static void grab_person(const char *who, struct atom_value *val, int deref, void
 		if (strncmp(who, name, wholen))
 			continue;
 		if (name[wholen] != 0 &&
-		    strcmp(name + wholen, "name") &&
+		    !starts_with(name + wholen, "name") &&
 		    !starts_with(name + wholen, "email") &&
 		    !starts_with(name + wholen, "date"))
 			continue;
-		if (!wholine)
+
+		if ((starts_with(name + wholen, "name") &&
+		    (atom->u.name_option.option == N_MAILMAP)) ||
+		    (starts_with(name + wholen, "email") &&
+		    (atom->u.email_option.option & EO_MAILMAP))) {
+			if (!mailmap.items)
+				read_mailmap(&mailmap);
+			strbuf_addstr(&mailmap_buf, buf);
+			apply_mailmap_to_header(&mailmap_buf, headers, &mailmap);
+			wholine = find_wholine(who, wholen, mailmap_buf.buf);
+		} else {
 			wholine = find_wholine(who, wholen, buf);
+		}
+
 		if (!wholine)
 			return; /* no point looking for it */
 		if (name[wholen] == 0)
 			v->s = copy_line(wholine);
-		else if (!strcmp(name + wholen, "name"))
+		else if (starts_with(name + wholen, "name"))
 			v->s = copy_name(wholine);
 		else if (starts_with(name + wholen, "email"))
 			v->s = copy_email(wholine, &used_atom[i]);
 		else if (starts_with(name + wholen, "date"))
 			grab_date(wholine, v, name);
+
+		strbuf_release(&mailmap_buf);
 	}
 
 	/*
diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
index 15b4622f57..1fb464ca50 100755
--- a/t/t6300-for-each-ref.sh
+++ b/t/t6300-for-each-ref.sh
@@ -25,6 +25,13 @@ test_expect_success setup '
 	disklen sha1:138
 	disklen sha256:154
 	EOF
+
+	# setup .mailmap
+	cat >.mailmap <<-EOF &&
+	A Thor <athor@example.com> A U Thor <author@example.com>
+	C Mitter <cmitter@example.com> C O Mitter <committer@example.com>
+	EOF
+
 	setdate_and_increment &&
 	echo "Using $datestamp" > one &&
 	git add one &&
@@ -141,15 +148,31 @@ test_atom head '*objectname' ''
 test_atom head '*objecttype' ''
 test_atom head author 'A U Thor <author@example.com> 1151968724 +0200'
 test_atom head authorname 'A U Thor'
+test_atom head authorname:mailmap 'A Thor'
 test_atom head authoremail '<author@example.com>'
 test_atom head authoremail:trim 'author@example.com'
 test_atom head authoremail:localpart 'author'
+test_atom head authoremail:trim,localpart 'author'
+test_atom head authoremail:mailmap '<athor@example.com>'
+test_atom head authoremail:mailmap,trim 'athor@example.com'
+test_atom head authoremail:trim,mailmap 'athor@example.com'
+test_atom head authoremail:mailmap,localpart 'athor'
+test_atom head authoremail:localpart,mailmap 'athor'
+test_atom head authoremail:mailmap,trim,localpart,mailmap,trim 'athor'
 test_atom head authordate 'Tue Jul 4 01:18:44 2006 +0200'
 test_atom head committer 'C O Mitter <committer@example.com> 1151968723 +0200'
 test_atom head committername 'C O Mitter'
+test_atom head committername:mailmap 'C Mitter'
 test_atom head committeremail '<committer@example.com>'
 test_atom head committeremail:trim 'committer@example.com'
 test_atom head committeremail:localpart 'committer'
+test_atom head committeremail:localpart,trim 'committer'
+test_atom head committeremail:mailmap '<cmitter@example.com>'
+test_atom head committeremail:mailmap,trim 'cmitter@example.com'
+test_atom head committeremail:trim,mailmap 'cmitter@example.com'
+test_atom head committeremail:mailmap,localpart 'cmitter'
+test_atom head committeremail:localpart,mailmap 'cmitter'
+test_atom head committeremail:trim,mailmap,trim,trim,localpart 'cmitter'
 test_atom head committerdate 'Tue Jul 4 01:18:43 2006 +0200'
 test_atom head tag ''
 test_atom head tagger ''
@@ -199,22 +222,46 @@ test_atom tag '*objectname' $(git rev-parse refs/tags/testtag^{})
 test_atom tag '*objecttype' 'commit'
 test_atom tag author ''
 test_atom tag authorname ''
+test_atom tag authorname:mailmap ''
 test_atom tag authoremail ''
 test_atom tag authoremail:trim ''
 test_atom tag authoremail:localpart ''
+test_atom tag authoremail:trim,localpart ''
+test_atom tag authoremail:mailmap ''
+test_atom tag authoremail:mailmap,trim ''
+test_atom tag authoremail:trim,mailmap ''
+test_atom tag authoremail:mailmap,localpart ''
+test_atom tag authoremail:localpart,mailmap ''
+test_atom tag authoremail:mailmap,trim,localpart,mailmap,trim ''
 test_atom tag authordate ''
 test_atom tag committer ''
 test_atom tag committername ''
+test_atom tag committername:mailmap ''
 test_atom tag committeremail ''
 test_atom tag committeremail:trim ''
 test_atom tag committeremail:localpart ''
+test_atom tag committeremail:localpart,trim ''
+test_atom tag committeremail:mailmap ''
+test_atom tag committeremail:mailmap,trim ''
+test_atom tag committeremail:trim,mailmap ''
+test_atom tag committeremail:mailmap,localpart ''
+test_atom tag committeremail:localpart,mailmap ''
+test_atom tag committeremail:trim,mailmap,trim,trim,localpart ''
 test_atom tag committerdate ''
 test_atom tag tag 'testtag'
 test_atom tag tagger 'C O Mitter <committer@example.com> 1151968725 +0200'
 test_atom tag taggername 'C O Mitter'
+test_atom tag taggername:mailmap 'C Mitter'
 test_atom tag taggeremail '<committer@example.com>'
 test_atom tag taggeremail:trim 'committer@example.com'
 test_atom tag taggeremail:localpart 'committer'
+test_atom tag taggeremail:trim,localpart 'committer'
+test_atom tag taggeremail:mailmap '<cmitter@example.com>'
+test_atom tag taggeremail:mailmap,trim 'cmitter@example.com'
+test_atom tag taggeremail:trim,mailmap 'cmitter@example.com'
+test_atom tag taggeremail:mailmap,localpart 'cmitter'
+test_atom tag taggeremail:localpart,mailmap 'cmitter'
+test_atom tag taggeremail:trim,mailmap,trim,localpart,localpart 'cmitter'
 test_atom tag taggerdate 'Tue Jul 4 01:18:45 2006 +0200'
 test_atom tag creator 'C O Mitter <committer@example.com> 1151968725 +0200'
 test_atom tag creatordate 'Tue Jul 4 01:18:45 2006 +0200'
@@ -284,9 +331,45 @@ test_bad_atom() {
 test_bad_atom head 'authoremail:foo' \
 	'fatal: unrecognized %(authoremail) argument: foo'
 
+test_bad_atom head 'authoremail:mailmap,trim,bar' \
+	'fatal: unrecognized %(authoremail) argument: bar'
+
+test_bad_atom head 'authoremail:trim,' \
+	'fatal: unrecognized %(authoremail) argument: '
+
+test_bad_atom head 'authoremail:mailmaptrim' \
+	'fatal: unrecognized %(authoremail) argument: trim'
+
+test_bad_atom head 'committeremail: ' \
+	'fatal: unrecognized %(committeremail) argument:  '
+
+test_bad_atom head 'committeremail: trim,foo' \
+	'fatal: unrecognized %(committeremail) argument:  trim,foo'
+
+test_bad_atom head 'committeremail:mailmap,localpart ' \
+	'fatal: unrecognized %(committeremail) argument:  '
+
+test_bad_atom head 'committeremail:trim_localpart' \
+	'fatal: unrecognized %(committeremail) argument: _localpart'
+
+test_bad_atom head 'committeremail:localpart,,,trim' \
+	'fatal: unrecognized %(committeremail) argument: ,,trim'
+
+test_bad_atom tag 'taggeremail:mailmap,trim, foo ' \
+	'fatal: unrecognized %(taggeremail) argument:  foo '
+
+test_bad_atom tag 'taggeremail:trim,localpart,' \
+	'fatal: unrecognized %(taggeremail) argument: '
+
+test_bad_atom tag 'taggeremail:mailmap;localpart trim' \
+	'fatal: unrecognized %(taggeremail) argument: ;localpart trim'
+
 test_bad_atom tag 'taggeremail:localpart trim' \
 	'fatal: unrecognized %(taggeremail) argument:  trim'
 
+test_bad_atom tag 'taggeremail:mailmap,mailmap,trim,qux,localpart,trim' \
+	'fatal: unrecognized %(taggeremail) argument: qux,localpart,trim'
+
 test_date () {
 	f=$1 &&
 	committer_date=$2 &&
-- 
2.42.0.160.g6905eb16ce.dirty

