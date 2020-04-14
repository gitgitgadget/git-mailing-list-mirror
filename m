Return-Path: <SRS0=cd4n=56=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E91CC2BB85
	for <git@archiver.kernel.org>; Tue, 14 Apr 2020 07:42:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 45AEB214AF
	for <git@archiver.kernel.org>; Tue, 14 Apr 2020 07:42:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp-br.20150623.gappssmtp.com header.i=@usp-br.20150623.gappssmtp.com header.b="hgCd0OjL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406796AbgDNHmW (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Apr 2020 03:42:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406788AbgDNHmQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Apr 2020 03:42:16 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C170C0A3BDC
        for <git@vger.kernel.org>; Tue, 14 Apr 2020 00:42:13 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id 71so9319934qtc.12
        for <git@vger.kernel.org>; Tue, 14 Apr 2020 00:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qK2MFIh2CG0sd5zsWfPdkq2q18knRNcClH1oJY/1Tdo=;
        b=hgCd0OjLeCnyQYHSgKKZF+leH0hNOkMx/Uc+yeAvG/Eloupf4za8GZH8EAagky3q79
         rwS8+3s4Tq4FpdoWnJ3w8fIoWCBiOXIogJ0aC3QWxq+Gy6i2E1VmsocfUh9kMi9JNPWq
         UBSk+7IFpFsHn1JRFMqSJ/0i8A/hlDQnW+C005geNSWb5msidwxHj+9DKkWnsq5OQqvN
         /2Uc/kgHkaivfmx8jDOMGSE9hT1w4Lvep9UCjcnh7m+ibvwY+ald8E6ZY3rrTDFVrC9X
         vxaUCNgnV5TYV6HCN8Rq/Fn577IWfj8IgmHexZGsw4S8Qp+hYlbm+pxxqKWvSWwBfKXC
         JMkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qK2MFIh2CG0sd5zsWfPdkq2q18knRNcClH1oJY/1Tdo=;
        b=LfA3/6m9l1SPOIfFcKGeUmRQ5Ybr9icFmPnJ/49Hc/q5f2YM1TixUoKU+0gYYUZBc2
         Mc/Ujco8W2yKW6ku7c8+rDG+oqhcGHFm89x5NUfowtfNbmlU99XCQUUV6FgYurmVN0Lp
         80Wnvb68sTHgHMwkSfM4LJta84l+DyPCgKaFv4pwTsN2DHWmus+qZL0YlnRE95suLaGj
         WjORU5WMPq5jLbNKjxBNCzSSNN4600VXwQa3OdjepjRV+qB6WEMt7hSLB/it022VeDbw
         uRmSK4R2EbTz5ae+pLKhK+iExffpNND+QM9s1cc0B80nC93hw261l9YtKPZ+IlOrumBc
         pEbQ==
X-Gm-Message-State: AGi0PubfzxIrFhjrxfLU++T5mUYWWDYkxA5JnewABpyjYdzhYyY69aNA
        nRhd9/0gik4SnBcuedxmGKrBqQ==
X-Google-Smtp-Source: APiQypKsuLCpkJN3r3ZnppKxsMp2QYesxR5XYLccL2xe4ESDgMsXP/WnsLgqyb7aRGo6KRo7YZ9l1g==
X-Received: by 2002:aed:2046:: with SMTP id 64mr14930947qta.187.1586850132452;
        Tue, 14 Apr 2020 00:42:12 -0700 (PDT)
Received: from mango.spo.virtua.com.br ([2804:14c:81:9a16::1])
        by smtp.gmail.com with ESMTPSA id u27sm10457778qtc.73.2020.04.14.00.42.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2020 00:42:11 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     greg@hurrell.net
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: 
Date:   Tue, 14 Apr 2020 04:42:04 -0300
Message-Id: <20200414074204.677139-1-matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <CAOyLvt9=wRfpvGGJqLMi7=wLWu881pOur8c9qNEg+Xqhf8W2ww@mail.gmail.com>
References: <CAOyLvt9=wRfpvGGJqLMi7=wLWu881pOur8c9qNEg+Xqhf8W2ww@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 13, 2020 at 6:57 PM Greg Hurrell <greg@hurrell.net> wrote:
>
> It seems that `git-grep -lz` behaves differently depending on whether
> it is inside a subdirectory:
[...]
> $ git grep -lz content
> an "example".txt^@nested/other "example".txt^@
>
> Note that, as expected, the files are NUL-terminated and not wrapped
> in quotes. ("^@" represents NUL byte.)
>
> $ cd nested
> $ git grep -lz content
> "other \"example\".txt"^@
>
> As soon as we move into a subdirectory, files are wrapped in quotes
> and contain escapes, despite the "-z" switch.

I think this is a bug in "plain" git-grep, not in -z specifically. In some git
commands, -z has the effect of unquoting the output paths. For example, the
docs for git-ls-files says: "-z: \0 line termination on output and do not quote
filenames." In git-grep, however, the -z doc entry only says: "Output \0
instead of the character that normally follows a file name."

So -z does not seem to affect quoting in git-grep. But should we change this, to
quote unusual pathnames (relative or not) by default, and let -z fall back to
the old behavior? This would be more consistent with other commands such as
git-ls-files and to the core.quotePath setting.

However, perhaps output paths are never intended to be displayed quoted in
git-grep (with or without -z) in order to be consistent with GNU grep. I don't
know which of these options is correct (if any), so I would love to hear what
others have to say about it.

But if the second is correct, I think we can use the following patch to solve
the reported bug:

(I'm just wondering: should we also add the information at core.quotePath that
git-grep does not comply with this setting, to be consistent with GNU grep {or
for any other reason}?)

-- >8 --
Subject: [RFC PATCH] grep: fix inconsistent output of unusual pathnames

When grepping from the repository root, paths that contain unusual
characters are not output quoted. However, they are quoted when grepping
from a subdir without --full-name. For example:

$ echo content >'an "unusual" name.txt'
$ mkdir subdir
$ echo content >'subdir/another "unusual" name.txt'
$ git add .
$ git commit -m content

Then:
$ git grep content
an "unusual" name.txt:1:content
subdir/another "unusual" name.txt:1:content

But:
$ cd subdir
$ git grep content
"another \"unusual\" name.txt":1:content

Fix this inconsistency by not quoting unusual pathnames (relative or
not), which is also the default behavior in GNU grep. Also add some
tests to prevent regressions.

Note: some non-related tests that compare git-grep output against
git-ls-files also had to be modified. This is because the testing repo
now contains some unusual pathnames. And git-ls-files will quote such
paths by default, whereas git-grep won't.

Reported-by: Greg Hurrell <greg@hurrell.net>
Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---
 builtin/grep.c  | 15 ++++++++++-----
 t/t7810-grep.sh | 33 ++++++++++++++++++++++++++++++---
 2 files changed, 40 insertions(+), 8 deletions(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index 99e2685090..ca21f98315 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -303,8 +303,12 @@ static int grep_oid(struct grep_opt *opt, const struct object_id *oid,
 	struct grep_source gs;

 	if (opt->relative && opt->prefix_length) {
-		quote_path_relative(filename + tree_name_len, opt->prefix, &pathbuf);
-		strbuf_insert(&pathbuf, 0, filename, tree_name_len);
+		struct strbuf rel_buf = STRBUF_INIT;
+		const char *rel_name = relative_path(filename + tree_name_len,
+						     opt->prefix, &rel_buf);
+		strbuf_add(&pathbuf, filename, tree_name_len);
+		strbuf_addstr(&pathbuf, rel_name);
+		strbuf_release(&rel_buf);
 	} else {
 		strbuf_addstr(&pathbuf, filename);
 	}
@@ -333,13 +337,14 @@ static int grep_file(struct grep_opt *opt, const char *filename)
 {
 	struct strbuf buf = STRBUF_INIT;
 	struct grep_source gs;
+	const char *gs_name;

 	if (opt->relative && opt->prefix_length)
-		quote_path_relative(filename, opt->prefix, &buf);
+		gs_name = relative_path(filename, opt->prefix, &buf);
 	else
-		strbuf_addstr(&buf, filename);
+		gs_name = filename;

-	grep_source_init(&gs, GREP_SOURCE_FILE, buf.buf, filename, filename);
+	grep_source_init(&gs, GREP_SOURCE_FILE, gs_name, filename, filename);
 	strbuf_release(&buf);

 	if (num_threads > 1) {
diff --git a/t/t7810-grep.sh b/t/t7810-grep.sh
index 7d7b396c23..23911a3574 100755
--- a/t/t7810-grep.sh
+++ b/t/t7810-grep.sh
@@ -72,6 +72,8 @@ test_expect_success setup '
 	# Still a no-op.
 	function dummy() {}
 	EOF
+	echo unusual >"\"unusual\" pathname" &&
+	echo unusual >"t/\"unusual\" pathname2" &&
 	git add . &&
 	test_tick &&
 	git commit -m initial
@@ -481,6 +483,26 @@ do
 		git grep --count -h -e b $H -- ab >actual &&
 		test_cmp expected actual
 	'
+
+	test_expect_success "grep $L should not quote unusual pathnames" '
+		cat >expected <<-EOF &&
+		${HC}"unusual" pathname:unusual
+		${HC}t/"unusual" pathname2:unusual
+		EOF
+		git grep unusual $H >actual &&
+		test_cmp expected actual
+	'
+
+	test_expect_success "grep $L should not quote unusual relative pathnames" '
+		cat >expected <<-EOF &&
+		${HC}"unusual" pathname2:unusual
+		EOF
+		(
+			cd t &&
+			git grep unusual $H
+		) >actual &&
+		test_cmp expected actual
+	'
 done

 cat >expected <<EOF
@@ -500,7 +522,8 @@ test_expect_success 'grep -c -C' '
 '

 test_expect_success 'grep -L -C' '
-	git ls-files >expected &&
+	git ls-files -z >ls-files-z &&
+	tr "\0" "\n" <ls-files-z >expected &&
 	git grep -L -C1 nonexistent_string >actual &&
 	test_cmp expected actual
 '
@@ -1686,7 +1709,9 @@ test_expect_success 'grep does not report i-t-a with -L --cached' '
 	echo "intend to add this" >intend-to-add &&
 	git add -N intend-to-add &&
 	test_when_finished "git rm -f intend-to-add" &&
-	git ls-files | grep -v "^intend-to-add\$" >expected &&
+	git ls-files -z >ls-files-z &&
+	tr "\0" "\n" <ls-files-z >files &&
+	grep -v "^intend-to-add\$" files >expected &&
 	git grep -L --cached "nonexistent_string" >actual &&
 	test_cmp expected actual
 '
@@ -1696,7 +1721,9 @@ test_expect_success 'grep does not report i-t-a and assume unchanged with -L' '
 	git add -N intend-to-add-assume-unchanged &&
 	test_when_finished "git rm -f intend-to-add-assume-unchanged" &&
 	git update-index --assume-unchanged intend-to-add-assume-unchanged &&
-	git ls-files | grep -v "^intend-to-add-assume-unchanged\$" >expected &&
+	git ls-files -z >ls-files-z &&
+	tr "\0" "\n" <ls-files-z >files &&
+	grep -v "^intend-to-add-assume-unchanged\$" files >expected &&
 	git grep -L "nonexistent_string" >actual &&
 	test_cmp expected actual
 '
--
2.26.0

