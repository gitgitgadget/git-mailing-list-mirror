Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4C361202AE
	for <e@80x24.org>; Thu,  6 Jul 2017 22:34:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752836AbdGFWel (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Jul 2017 18:34:41 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:36118 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752068AbdGFWek (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Jul 2017 18:34:40 -0400
Received: by mail-pg0-f67.google.com with SMTP id u36so1743071pgn.3
        for <git@vger.kernel.org>; Thu, 06 Jul 2017 15:34:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=PJkuGDfw+UWFhmx1umA8z4HZQbEry6MH+hgWiiQwIJU=;
        b=VPyD4ng0UYCDw4wFUJgj3+D18APbxbed5We/JK8JGHuJPlt+XFO0ygM2m1PEfK815/
         ePCm5cr8m0lOjxpevda0+Ud6SI9qi0uo2yT4UOGKiqe7XDA7yv4r0kvYNDDjk0maduKZ
         0sKthAAr6bmKCk/4q0U15fgwSjJUm6R9mKJnJqDL5omXhACyouMFUOjE7QuO8bmxO3i2
         AV33FTo2yKu4g2zo8VGE0iXLFRwvpbeWE4yf2K/uqpR337sV/QCVnnltohs0+/5Dk+b/
         XB/kchDtjK6r0H0063K4P2Qq9Gc8ArJEzLgW/0To3FljA663d1r1hwqTUDxaB0HVeO78
         4TAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=PJkuGDfw+UWFhmx1umA8z4HZQbEry6MH+hgWiiQwIJU=;
        b=aS7n+0LAXkWy+guQmUbg+ieC/gn3Wj99AWYHkg3CzGGlBVb1qjbtZZAaOL8ijBmXv9
         p678XCer0PKqBz3IiOVj7Sm8E3uTzDuIyl9Vh5H3c5LT6T37qw6trMyGAtAkEgUBksbl
         kpx8/Yz2zG8sZONHThazohha6DHGRcZTU+LxkzJl0ACTODM9jW4c8hvFq8Gn400FCozS
         l8t3j2BxEN4nj9naPx1mfwGBztCF0lFK3VbnZWCxO4Q2CEXFuTjRqSFP0jv5iY9tLdPT
         9+ptnp9OYhIdVcIdhRRv09pQ0/BkmG2wqDFFqXnyf9Q8k8kCmlTufm3TURMlnd3ASY2o
         ptiA==
X-Gm-Message-State: AIVw110nlyIxPut4vBnnGYxGTftgD6ryLKR9ktAvfoLKPpJpfvqI6O5M
        3in/AfqLk5lMg5ZLOuA=
X-Received: by 10.98.68.76 with SMTP id r73mr28625839pfa.152.1499380479434;
        Thu, 06 Jul 2017 15:34:39 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:f878:6796:f790:dc38])
        by smtp.gmail.com with ESMTPSA id z6sm2307969pff.46.2017.07.06.15.34.35
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 06 Jul 2017 15:34:35 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Konstantin Khomoutov <kostix+git@007spb.ru>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Jeff King <peff@peff.net>
Subject: Re: Should "head" also work for "HEAD" on case-insensitive FS?
References: <87ziclb2pa.fsf@gmail.com> <20170704071909.phs4bf5ybdord2lv@tigra>
        <87van8boe9.fsf@gmail.com>
        <20170705083611.jgxbp4sqogicfwdb@sigill.intra.peff.net>
        <xmqqshiaizhz.fsf@gitster.mtv.corp.google.com>
Date:   Thu, 06 Jul 2017 15:34:34 -0700
In-Reply-To: <xmqqshiaizhz.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Wed, 05 Jul 2017 10:07:20 -0700")
Message-ID: <xmqqo9sxdwjp.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Once Michael's packed-refs backend stabilizes, we may have a nice
> calm period in the refs subsystem and I expect that this will become
> a good medium-sized project for a contributor who does not have to 
> be so experienced (but not a complete newbie).
>
> It needs to:
>
>  - add icase-files-backend, preferrably sharing as much code as the
>    existing files-backend, in refs/.
>
>  - design a mechanism to configure which refs backend to use at
>    runtime; as this has to be done fairly early in the control flow,
>    this will likely to use early configuration mechanism and will
>    probably need to be done in the set-up code, but doing it lazy
>    may even be nicer, as not all subcommands need access to refs.
>
> Thanks for a pointer to the archive.

So here is an early WIP/illustration I did to see how involved such
a change would be, which should apply cleanly on top of 'pu'.

I was pleasantly surprised how cleanly refs/files-backend.c
separates the notion of "path" and "refname".  Only two functions,
files_reflog_path() and files_ref_path(), are responsible for taking
the refname and turning it to the pathname of an filesystem entity.
One one function, loose_fill_ref_dir(), is responsible for running
readdir() to find pathname, and turning the result into a refname.
So in theory, these three are the only things that need to know
about the "encoding".

The exact detail of the encoding used here is immaterial, but I just
used "encode uppercase letters and % as % followed by two hex",
which was simple enough.  Usual refs/heads/master and friends will
not have to be touched when encoded this way.  Perhaps the decoding
side should be tweaked so that uppercase letters it sees needs to be
downcased to avoid "refs/heads/Foo" getting returned as "Foo" branch,
as a "Foo" branch should have been encoded as "refs/heads/%46oo".

Having said that, this patch alone does not quite work yet.

 * In the repository discovery code, we have some logic that
   hard-codes the path in the directory (which is a candidate for
   being a repository) to check, like "refs/" and "HEAD".  In the
   attached illustration patch, files_path_encode() special cases
   "HEAD" so that it is not munged, which is a bit of ugly
   workaround for this.

 * I haven't figured out why, but what refs.c calls "pseudo refs"
   bypasses the files backend layer for some but not all operations,
   which causes t1405-main-ref-store to fail.  The test creates a
   "pseudo ref" FOO and then tries to remove it.  Creation seems to
   follow the files-backend.c and thusly goes through the escaping;
   refs.::refs_delete_ref() however does not consult files-backend.c
   and fails to find and delete .git/FOO, because the creation side
   encoded it as ".git/%46%4F%4F".

Michael is CC'ed as I thought it would be simpler to just ask about
the latter bullet point than digging it further myself ;-)

Thanks.

 refs/files-backend.c | 62 +++++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 56 insertions(+), 6 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 923e481e06..5bde77cbf8 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -23,6 +23,7 @@ struct ref_lock {
 struct files_ref_store {
 	struct ref_store base;
 	unsigned int store_flags;
+	int encode_names;
 
 	char *gitdir;
 	char *gitcommondir;
@@ -54,6 +55,9 @@ static struct ref_store *files_ref_store_create(const char *gitdir,
 	base_ref_store_init(ref_store, &refs_be_files);
 	refs->store_flags = flags;
 
+	/* git_config_get_bool("core.escapeLooseRefNames", &refs->encode_names); */
+	refs->encode_names = 1;
+
 	refs->gitdir = xstrdup(gitdir);
 	get_common_dir_noenv(&sb, gitdir);
 	refs->gitcommondir = strbuf_detach(&sb, NULL);
@@ -102,6 +106,49 @@ static struct files_ref_store *files_downcast(struct ref_store *ref_store,
 	return refs;
 }
 
+static void files_path_encode(struct files_ref_store *refs,
+			      struct strbuf *sb, const char *refname)
+{
+	if (!refs->encode_names || !strcmp(refname, "HEAD")) {
+		strbuf_addstr(sb, refname);
+	} else {
+		const char *cp;
+
+		for (cp = refname; *cp; cp++) {
+			int ch = *cp;
+			if (('A' <= ch && ch <= 'Z') || (ch == '%'))
+				strbuf_addf(sb, "%%%02x", ch);
+			else
+				strbuf_addch(sb, ch);
+		}
+	}
+}
+
+static int files_path_decode(struct files_ref_store *refs,
+			     struct strbuf *sb, const char *name, int namelen)
+{
+	if (!refs->encode_names) {
+		strbuf_add(sb, name, namelen);
+	} else {
+		size_t origlen = sb->len;
+
+		while (namelen--) {
+			int ch = *name++;
+
+			if (ch == '%') {
+				if (namelen < 2 || (ch = hex2chr(name)) < 0) {
+					strbuf_setlen(sb, origlen);
+					return -1;
+				}
+				namelen -= 2;
+				name += 2;
+			}
+			strbuf_addch(sb, ch);
+		}
+	}
+	return 0;
+}
+
 static void files_reflog_path(struct files_ref_store *refs,
 			      struct strbuf *sb,
 			      const char *refname)
@@ -118,15 +165,16 @@ static void files_reflog_path(struct files_ref_store *refs,
 	switch (ref_type(refname)) {
 	case REF_TYPE_PER_WORKTREE:
 	case REF_TYPE_PSEUDOREF:
-		strbuf_addf(sb, "%s/logs/%s", refs->gitdir, refname);
+		strbuf_addf(sb, "%s/logs/", refs->gitdir);
 		break;
 	case REF_TYPE_NORMAL:
-		strbuf_addf(sb, "%s/logs/%s", refs->gitcommondir, refname);
+		strbuf_addf(sb, "%s/logs/", refs->gitcommondir);
 		break;
 	default:
 		die("BUG: unknown ref type %d of ref %s",
 		    ref_type(refname), refname);
 	}
+	files_path_encode(refs, sb, refname);
 }
 
 static void files_ref_path(struct files_ref_store *refs,
@@ -136,15 +184,16 @@ static void files_ref_path(struct files_ref_store *refs,
 	switch (ref_type(refname)) {
 	case REF_TYPE_PER_WORKTREE:
 	case REF_TYPE_PSEUDOREF:
-		strbuf_addf(sb, "%s/%s", refs->gitdir, refname);
+		strbuf_addf(sb, "%s/", refs->gitdir);
 		break;
 	case REF_TYPE_NORMAL:
-		strbuf_addf(sb, "%s/%s", refs->gitcommondir, refname);
+		strbuf_addf(sb, "%s/", refs->gitcommondir);
 		break;
 	default:
 		die("BUG: unknown ref type %d of ref %s",
 		    ref_type(refname), refname);
 	}
+	files_path_encode(refs, sb, refname);
 }
 
 /*
@@ -174,7 +223,7 @@ static void loose_fill_ref_dir(struct ref_store *ref_store,
 	}
 
 	strbuf_init(&refname, dirnamelen + 257);
-	strbuf_add(&refname, dirname, dirnamelen);
+	files_path_decode(refs, &refname, dirname, dirnamelen);
 
 	while ((de = readdir(d)) != NULL) {
 		struct object_id oid;
@@ -185,7 +234,8 @@ static void loose_fill_ref_dir(struct ref_store *ref_store,
 			continue;
 		if (ends_with(de->d_name, ".lock"))
 			continue;
-		strbuf_addstr(&refname, de->d_name);
+		if (files_path_decode(refs, &refname, de->d_name, strlen(de->d_name)))
+			continue;
 		strbuf_addstr(&path, de->d_name);
 		if (stat(path.buf, &st) < 0) {
 			; /* silently ignore */




