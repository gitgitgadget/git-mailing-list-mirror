Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F207FC47088
	for <git@archiver.kernel.org>; Fri,  2 Dec 2022 19:04:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234618AbiLBTE1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Dec 2022 14:04:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234508AbiLBTEZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Dec 2022 14:04:25 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5919FC725D
        for <git@vger.kernel.org>; Fri,  2 Dec 2022 11:04:24 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id d14so2724144edj.11
        for <git@vger.kernel.org>; Fri, 02 Dec 2022 11:04:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=reFn8fPK9M0MYdyo9ZTytoay1aL5ldYD11N5UeNLSyw=;
        b=MZqHPnTsXdJOaXtboJSFS0m+85MtvMjRvcN0RnD8mPbYU6q7+WxSrW/pqk/YA7+0Qk
         WMvenDulBKCgx9nykADowuH7hsEpVzPCCYbewnPT6xOESmmz1XJxCgCyywj+aSs6KEr+
         tLrlgOBGmLdbt/5JTNEItuyHFx2fStv6vVF4++MUH7lnnZg1ejkISEhlteC4FGEdKY4a
         AEa1cGxPmknrYbMf5+PH3bSmJ+aCvs7saioooPsS2aam78pMblWUCPpX/73I4nU4XOEb
         +QL7nNASgGGQqltXJNBmNE0dX2uR9ZCSIY8+snFrOrrE8kxNbgR9W4uxwFT7kVDMm6uL
         3/YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=reFn8fPK9M0MYdyo9ZTytoay1aL5ldYD11N5UeNLSyw=;
        b=iHPwgDfSAzHe6sjjRaVNRkBNGf+FtLxRyx02BLyFhFR6Jmn3pZBdoJ55uZ5kKop/mj
         xAcdh0EHCNhsSPI0GQ5W4snf7rxswd91Je8Hvs6ibEQJnt2FbqwrXsuyPFhrg2YMMoIf
         M6XXD4z1MaJ6BZJVA6RqjiQjXFeUFs6tBF2lLnyYM2doYudR6pn3FcEoSqbqMv5ow6qn
         sKgbFQB+O0Bb4ECy7L0WAsdtx+WQMVQoAv6BANaFc0LOrcrvCbIrll93+mI6OD21ou6Y
         pU/xi4QuynicrmU/FdQE8IscRFV6brNYf8v8VTWlF3rLtNFpRy4G3nrHVvz/1mmZHAqz
         36Ig==
X-Gm-Message-State: ANoB5pm3GJFAQiEt617CKkv4MnUfSE5qdpG0T2EHLo2yqU3XL71dMFR3
        HUcQf3JsMF+0SVtiT8RuRLTrQWL1wszexQ==
X-Google-Smtp-Source: AA0mqf6g8pJx6tfL3J3TVxIR83MkxhLox60tVFTmQ+z2XYWKIxJ8nROEDb4Kz1gbRiPhkHNBp3HQhw==
X-Received: by 2002:a05:6402:2948:b0:463:bc31:2604 with SMTP id ed8-20020a056402294800b00463bc312604mr64667461edb.32.1670007862458;
        Fri, 02 Dec 2022 11:04:22 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id bm14-20020a0564020b0e00b0046bf4935323sm833642edb.30.2022.12.02.11.04.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Dec 2022 11:04:21 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1p1BKe-002pRi-1j;
        Fri, 02 Dec 2022 20:04:20 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, me@ttaylorr.com,
        newren@gmail.com, mjcheetham@outlook.com, steadmon@google.com,
        chooglen@google.com, jonathantanmy@google.com,
        dyroneteng@gmail.com, Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v2 6/9] strbuf: introduce strbuf_strip_file_from_path()
Date:   Fri, 02 Dec 2022 19:32:24 +0100
References: <pull.1400.git.1667264854.gitgitgadget@gmail.com>
 <pull.1400.v2.git.1668628302.gitgitgadget@gmail.com>
 <7d86852c01513ee131bf993302416f4c881a0bc6.1668628303.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <7d86852c01513ee131bf993302416f4c881a0bc6.1668628303.git.gitgitgadget@gmail.com>
Message-ID: <221202.86bkolfwzv.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Nov 16 2022, Derrick Stolee via GitGitGadget wrote:

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
> makes the name change valuable. The return value is the number of bytes
> removed.
>
> Signed-off-by: Derrick Stolee <derrickstolee@github.com>
> ---
>  strbuf.c |  9 +++++++++
>  strbuf.h | 12 ++++++++++++
>  2 files changed, 21 insertions(+)
>
> diff --git a/strbuf.c b/strbuf.c
> index 0890b1405c5..8d1e2e8bb61 100644
> --- a/strbuf.c
> +++ b/strbuf.c
> @@ -1200,3 +1200,12 @@ int strbuf_edit_interactively(struct strbuf *buffer, const char *path,
>  	free(path2);
>  	return res;
>  }
> +
> +size_t strbuf_strip_file_from_path(struct strbuf *buf)

Nit: Almost every function in this API calls its argument "sb", let's do
that for new functions.

> +{
> +	size_t len = buf->len;
> +	size_t offset = offset_1st_component(buf->buf);

Mm, isn't the return value of offset_1st_component() a boolean? it's
just an "is_dir_sep(buf->buf[0])".

So this works to....

> +	char *path_sep = find_last_dir_sep(buf->buf + offset);

...find the last dir separator starting at either 0 or 1.

But anyway, what sort of string is this expecting to handle where the
last dir separator isn't >=1 offset into the string anyway? Shouldn't we
just exclude the string "/" here? Maybe I'm missing something....


> +	strbuf_setlen(buf, path_sep ? path_sep - buf->buf + 1 : offset);
> +	return len - buf->len;
> +}

Urm, so isn't this literally one-byte away from being equivalent to a
function that's already in the API?:
strbuf_trim_trailing_dir_sep. I.e. this seems to me to do the same as
this new function.

Context manually adjusted so we can see the only difference is the
"is_dir_sep" v.s. "!is_dir_sep".

There's a few strbuf functions like that, and we should probably
generalize the ctype-like test they share into some callback mechanism,
but in the meantime keeping with the pattern & naming of existing
functions seems better.

But again, I may be missing something.

I removed the comment because if it's the same then the new function is
self-documenting. It doesn't matter if the URI ends in a "/" or not, all
we need to get across is that we're stripping non-dirsep characters from
the URL, whether it ends in one or not.

In terms of correctness: The use of is_dir_sep() seems incorrect to me
here. On Windows won't that end up using is_xplatform_dir_sep(), so
bundle-uri's behavior will differ there, and we'll support \\-paths as
well as /-paths, but elsewhere only /-paths.

Shouldn't this just test "/", not "is_dir_sep()"?

At which point (if the above is correct) we could also call this
strbuf_rtrim_notchr(), and just call strbuf_rtrim_notchr(sb, '/') (but
even better would be a ctype-like callback).

diff --git a/bundle-uri.c b/bundle-uri.c
index 5914d220c43..c3ed04eae0f 100644
--- a/bundle-uri.c
+++ b/bundle-uri.c
@@ -192,20 +192,15 @@ int bundle_uri_parse_config_format(const char *uri,
 		.error_action = CONFIG_ERROR_ERROR,
 	};
 
 	if (!list->baseURI) {
 		struct strbuf baseURI = STRBUF_INIT;
 		strbuf_addstr(&baseURI, uri);
 
-		/*
-		 * If the URI does not end with a trailing slash, then
-		 * remove the filename portion of the path. This is
-		 * important for relative URIs.
-		 */
-		strbuf_strip_file_from_path(&baseURI);
+		strbuf_trim_trailing_not_dir_sep(&baseURI);
 		list->baseURI = strbuf_detach(&baseURI, NULL);
 	}
 	result = git_config_from_file_with_options(config_to_bundle_list,
 						   filename, list,
 						   &opts);
 
 	if (!result && list->mode == BUNDLE_MODE_NONE) {
diff --git a/strbuf.c b/strbuf.c
index 8d1e2e8bb61..3466552b854 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -117,14 +117,21 @@ void strbuf_rtrim(struct strbuf *sb)
 void strbuf_trim_trailing_dir_sep(struct strbuf *sb)
 {
 	while (sb->len > 0 && is_dir_sep((unsigned char)sb->buf[sb->len - 1]))
 		sb->len--;
 	sb->buf[sb->len] = '\0';
 }
 
+void strbuf_trim_trailing_not_dir_sep(struct strbuf *sb)
+{
+	while (sb->len > 0 && !is_dir_sep((unsigned char)sb->buf[sb->len - 1]))
+		sb->len--;
+	sb->buf[sb->len] = '\0';
+}
+
 void strbuf_trim_trailing_newline(struct strbuf *sb)
 {
 	if (sb->len > 0 && sb->buf[sb->len - 1] == '\n') {
 		if (--sb->len > 0 && sb->buf[sb->len - 1] == '\r')
 			--sb->len;
 		sb->buf[sb->len] = '\0';
 	}
@@ -1196,16 +1203,7 @@ int strbuf_edit_interactively(struct strbuf *buffer, const char *path,
 			res = error_errno(_("could not edit '%s'"), path);
 		unlink(path);
 	}
 
 	free(path2);
 	return res;
 }
-
-size_t strbuf_strip_file_from_path(struct strbuf *buf)
-{
-	size_t len = buf->len;
-	size_t offset = offset_1st_component(buf->buf);
-	char *path_sep = find_last_dir_sep(buf->buf + offset);
-	strbuf_setlen(buf, path_sep ? path_sep - buf->buf + 1 : offset);
-	return len - buf->len;
-}
diff --git a/strbuf.h b/strbuf.h
index 4822b713786..b5929ecc8dd 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -185,14 +185,16 @@ static inline void strbuf_setlen(struct strbuf *sb, size_t len)
  */
 void strbuf_trim(struct strbuf *sb);
 void strbuf_rtrim(struct strbuf *sb);
 void strbuf_ltrim(struct strbuf *sb);
 
 /* Strip trailing directory separators */
 void strbuf_trim_trailing_dir_sep(struct strbuf *sb);
+/* Strip trailing non-directory separators */
+void strbuf_trim_trailing_not_dir_sep(struct strbuf *sb);
 
 /* Strip trailing LF or CR/LF */
 void strbuf_trim_trailing_newline(struct strbuf *sb);
 
 /**
  * Replace the contents of the strbuf with a reencoded form.  Returns -1
  * on error, 0 on success.
