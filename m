Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FCB5C4708C
	for <git@archiver.kernel.org>; Tue,  6 Dec 2022 10:43:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233785AbiLFKmo (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Dec 2022 05:42:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231653AbiLFKmS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Dec 2022 05:42:18 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6ED51DA50
        for <git@vger.kernel.org>; Tue,  6 Dec 2022 02:42:15 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id z92so19723719ede.1
        for <git@vger.kernel.org>; Tue, 06 Dec 2022 02:42:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6s2pvLRitD0BxlKR6uYUes3SOFtwCRc/7q7rfHizYlM=;
        b=knVAI39FkB5/wFwV7HNbordL6df9ZSsJ1WWDgBV8N1oxnnLY4QRufXocIayU7hfS+P
         iJ76QrY90rnVE+Huk5cgimqx5Ojx49BfdF+F/8Au2ejOu0FFmtnBJMOnEMElpbpV0pH6
         SufT6SxPdH1TDMKQNlvYf1LNPCY4FQZCDxybWdy5xG4LJkR1Or9R7eiGEe8uCYA4+lbd
         qOGNfF4lFiIkGVpxCSMqRGl76p6gPF5Kmko82c8HU8vzXlEabXfyW2dmAAmMfXucDwFx
         85zFgsXzp286K/bhpJ9ReShqlXQuUZxM9pBZMftpjiuM1MtwBfnhgnRCjECtgPz6hYUn
         Kv0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6s2pvLRitD0BxlKR6uYUes3SOFtwCRc/7q7rfHizYlM=;
        b=P6XFy0lcC+ZBBnHD2vLONYvAB3P5lbdj45bUN3zdB8/H0piLTx+pb3JujyrCjz1P+u
         wK3onDZbyz0xVgpae2BZTZ0KUEQErLPkUMmU8ErMhcqhBY9H2qHtJKYD9/x5jTD0tUoc
         XzOgNKIwBy6PPGrryIPShungSHMnC90Z8u4q6dzWnEkZCsE8teCZR12sdzw7I4K8iOJA
         8Qo7Pn5mT49EFC7BXP/GUWtZoBtjkN3yyT1001wur0j8/dEyh8DvcFjdRcTndwt/U48n
         0WqU0btrGOxT40zLcGGNzLbUFNs+i8CG0Y86fHMEswuz9ne55xnkHcpl0NVa6dwI19At
         a36A==
X-Gm-Message-State: ANoB5pkk8AvLpsGnguWUzNPKKFv9VDdGoV1rtKVMc/OGGOgrltRq2Sta
        Gj5Sz2+6S+i/i9j6oNwh2k4WU44umzei/g==
X-Google-Smtp-Source: AA0mqf73rh6wXAPZCH4XeF+bUy1OGp4LBG3RaXPQBNWuRsqdrKgZRdM5Q1+H5itDmKlq0YLRC0+ooQ==
X-Received: by 2002:aa7:da10:0:b0:46c:43ff:6961 with SMTP id r16-20020aa7da10000000b0046c43ff6961mr14408704eds.14.1670323333803;
        Tue, 06 Dec 2022 02:42:13 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id w22-20020a1709060a1600b007c07dfb0816sm7185797ejf.215.2022.12.06.02.42.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Dec 2022 02:42:13 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1p2VOu-003oQZ-1n;
        Tue, 06 Dec 2022 11:42:12 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, me@ttaylorr.com,
        newren@gmail.com, mjcheetham@outlook.com, steadmon@google.com,
        chooglen@google.com, jonathantanmy@google.com,
        dyroneteng@gmail.com, Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v3 08/11] strbuf: introduce strbuf_strip_file_from_path()
Date:   Tue, 06 Dec 2022 11:06:53 +0100
References: <pull.1400.v2.git.1668628302.gitgitgadget@gmail.com>
 <pull.1400.v3.git.1670262639.gitgitgadget@gmail.com>
 <1eec3426aee12bbd674ebd646075f0d4c0b1f5af.1670262639.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <1eec3426aee12bbd674ebd646075f0d4c0b1f5af.1670262639.git.gitgitgadget@gmail.com>
Message-ID: <221206.86a640dda3.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Dec 05 2022, Derrick Stolee via GitGitGadget wrote:

> From: Derrick Stolee <derrickstolee@github.com>
>
> The strbuf_parent_directory() method was added as a static method in
> contrib/scalar by d0feac4e8c0 (scalar: 'register' sets recommended
> config and starts maintenance, 2021-12-03) and then removed in
> 65f6a9eb0b9 (scalar: constrain enlistment search, 2022-08-18), but now
> there is a need for a similar method in the bundle URI feature.
>
> Re-add the method, this time in strbuf.c, but with a new name:
> strbuf_strip_file_from_path(). The method requirements are slightly
> modified to allow a trailing slash, in which case nothing is done, which
> makes the name change valuable.
>
> Signed-off-by: Derrick Stolee <derrickstolee@github.com>
> ---
>  strbuf.c |  6 ++++++
>  strbuf.h | 11 +++++++++++
>  2 files changed, 17 insertions(+)
>
> diff --git a/strbuf.c b/strbuf.c
> index 0890b1405c5..c383f41a3c5 100644
> --- a/strbuf.c
> +++ b/strbuf.c
> @@ -1200,3 +1200,9 @@ int strbuf_edit_interactively(struct strbuf *buffer, const char *path,
>  	free(path2);
>  	return res;
>  }
> +
> +void strbuf_strip_file_from_path(struct strbuf *sb)
> +{
> +	char *path_sep = find_last_dir_sep(sb->buf);
> +	strbuf_setlen(sb, path_sep ? path_sep - sb->buf + 1 : 0);
> +}
> diff --git a/strbuf.h b/strbuf.h
> index 76965a17d44..f6dbb9681ee 100644
> --- a/strbuf.h
> +++ b/strbuf.h
> @@ -664,6 +664,17 @@ int launch_sequence_editor(const char *path, struct strbuf *buffer,
>  int strbuf_edit_interactively(struct strbuf *buffer, const char *path,
>  			      const char *const *env);
>  
> +/*
> + * Remove the filename from the provided path string. If the path
> + * contains a trailing separator, then the path is considered a directory
> + * and nothing is modified.
> + *
> + * Examples:
> + * - "/path/to/file" -> "/path/to/"
> + * - "/path/to/dir/" -> "/path/to/dir/"
> + */
> +void strbuf_strip_file_from_path(struct strbuf *sb);
> +
>  void strbuf_add_lines(struct strbuf *sb,
>  		      const char *prefix,
>  		      const char *buf,

Re your reply in
https://lore.kernel.org/git/0980dcd4-30eb-4ef4-9369-279abe5ca5a2@github.com/
I still don't get how this is different from a 1-byte change to
strbuf_trim_trailing_dir_sep(), and if it isn't I think it's confusing
API design to have two very different ways to return the same data.

There you said "The difference is all about whether or not we start with
a slash _and_ no other slash appears in the path.".

But I can't find a case where there's any difference between the two. I
tried this ad-hoc test on top:
	
	diff --git a/help.c b/help.c
	index f1e090a4428..b0866b01439 100644
	--- a/help.c
	+++ b/help.c
	@@ -765,6 +765,16 @@ int cmd_version(int argc, const char **argv, const char *prefix)
	 			 "also print build options"),
	 		OPT_END()
	 	};
	+	struct strbuf sb1 = STRBUF_INIT;
	+	struct strbuf sb2 = STRBUF_INIT;
	+
	+	if (getenv("STR")) {
	+		strbuf_addstr(&sb1, getenv("STR"));
	+		strbuf_addstr(&sb2, getenv("STR"));
	+		strbuf_strip_file_from_path(&sb1);
	+		strbuf_trim_trailing_not_dir_sep(&sb2);
	+		fprintf(stderr, "%s: %s | %s\n", strcmp(sb1.buf, sb2.buf) ? "NEQ" : "EQ", sb1.buf, sb2.buf);
	+	}
	 
	 	argc = parse_options(argc, argv, prefix, options, usage, 0);
	 
	diff --git a/strbuf.c b/strbuf.c
	index c383f41a3c5..f75d94556fc 100644
	--- a/strbuf.c
	+++ b/strbuf.c
	@@ -114,13 +114,23 @@ void strbuf_rtrim(struct strbuf *sb)
	 	sb->buf[sb->len] = '\0';
	 }
	 
	-void strbuf_trim_trailing_dir_sep(struct strbuf *sb)
	+static void strbuf_trim_trailing_dir_sep_1(struct strbuf *sb, int flip)
	 {
	-	while (sb->len > 0 && is_dir_sep((unsigned char)sb->buf[sb->len - 1]))
	+	while (sb->len > 0 && is_dir_sep((unsigned char)sb->buf[sb->len - 1]) - flip)
	 		sb->len--;
	 	sb->buf[sb->len] = '\0';
	 }
	 
	+void strbuf_trim_trailing_dir_sep(struct strbuf *sb)
	+{
	+	strbuf_trim_trailing_dir_sep_1(sb, 1);
	+}
	+
	+void strbuf_trim_trailing_not_dir_sep(struct strbuf *sb)
	+{
	+	strbuf_trim_trailing_dir_sep_1(sb, 1);
	+}
	+
	 void strbuf_trim_trailing_newline(struct strbuf *sb)
	 {
	 	if (sb->len > 0 && sb->buf[sb->len - 1] == '\n') {
	diff --git a/strbuf.h b/strbuf.h
	index f6dbb9681ee..b936f45ffad 100644
	--- a/strbuf.h
	+++ b/strbuf.h
	@@ -189,6 +189,8 @@ void strbuf_ltrim(struct strbuf *sb);
	 
	 /* Strip trailing directory separators */
	 void strbuf_trim_trailing_dir_sep(struct strbuf *sb);
	+/* Strip trailing not-directory separators */
	+void strbuf_trim_trailing_not_dir_sep(struct strbuf *sb);
	 
	 /* Strip trailing LF or CR/LF */
	 void strbuf_trim_trailing_newline(struct strbuf *sb);

Then:
	
	$ for str in a / b/ /c /d/ /e/ /f/g /h/i/ j/k l//m n/o/p //q/r/s/t; do STR=$str ./git version; done 2>&1 | grep :
	EQ:  | 
	EQ: / | /
	EQ: b/ | b/
	EQ: / | /
	EQ: /d/ | /d/
	EQ: /e/ | /e/
	EQ: /f/ | /f/
	EQ: /h/i/ | /h/i/
	EQ: j/ | j/
	EQ: l// | l//
	EQ: n/o/ | n/o/
	EQ: //q/r/s/ | //q/r/s/

I.e. for those inputs it's the same as the existing
strbuf_trim_trailing_dir_sep() with an inverted test. Is there some edge
case that I'm missing?
