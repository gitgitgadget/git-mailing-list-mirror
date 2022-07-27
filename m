Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D318C04A68
	for <git@archiver.kernel.org>; Wed, 27 Jul 2022 22:15:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236865AbiG0WPK (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Jul 2022 18:15:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237458AbiG0WOw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Jul 2022 18:14:52 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8587B6583E
        for <git@vger.kernel.org>; Wed, 27 Jul 2022 15:11:55 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id bh13so30200pgb.4
        for <git@vger.kernel.org>; Wed, 27 Jul 2022 15:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=ERvXdjfMAdskJ8YlP7maTiBJKwbMCyArodBhckLjzjg=;
        b=iAwVliXLQ0wcP4XEQnmlK+BFB76IjSTbjH/q4qVgMrW15bU45WrhLcxUF+9R9XvPDQ
         h0NFxdC+wlNIX7Fn+j5yH3ZVJkGyqh2w+ed6B2yAoR2oWLoRHUvvnMqpVhZVq7jIaFte
         boaDwROGMC52ACMBvv6359wkls/CVJjWfLV4kShbcXc1O9vn8YIt+dsYI7eB1doKdbYT
         rY9BowUSdzpgMMAKEJ5bg9J3A6FA/7o3DmQDmRB3kff+mO2fGIC0fMzbU8pvOSObWoAB
         Hb/Wt8aa6nxd8ow9AcZ4IwQluu3ZddRyIr3q7mbA+hGz50MKEOWs64NiHOh29G7uFubx
         aC/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=ERvXdjfMAdskJ8YlP7maTiBJKwbMCyArodBhckLjzjg=;
        b=foeJVPuNZ5VXf+TLKnAvLt/lPEJbPctjtIT+vCYSNPguyn/X8pSrp88pmYJGVNtTt6
         9PhRnXpg4Aa6hQsTyJuAjlktVBL35qf/PMExiIpTEsrGpYtPerT0hdCBVL7SDYgBxrnO
         2zQsUwOb/iQS/NviypsHxKvF62PVerjJyBZUh1yO9Whg5KtOMi8UZ09Dhm4FRUMYeez4
         npmqnb/rxR1mdeh37x6j1L8rq0p6sHk9dq1ZP0FR5NdziGMJpfQbr40msgoDHbGqWVNc
         ov2ZCVHwPrciJd0aMULrwtnJCvjKNqw1qU2ZDHop4Wq3ifKYS5U0RY12FLU3DCVxrei/
         RSAQ==
X-Gm-Message-State: AJIora+8JkUreXUh6qXpWaf5xxkEkb55AIaQ8A+w65Knt/3thmKF+rpH
        hTgFwjGfaa20EWSSQvhQgpTEbA==
X-Google-Smtp-Source: AGRyM1v2XwnUxB0YndlcKVw63xLXMNQpCnd6sTj743rfhs3jGwcXy6F/O0cqMnsMREcdhhcIYBomOQ==
X-Received: by 2002:a05:6a00:22c7:b0:52b:af2:903f with SMTP id f7-20020a056a0022c700b0052b0af2903fmr24098115pfj.3.1658959911434;
        Wed, 27 Jul 2022 15:11:51 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:6dea:f5ba:2fa:f9c3])
        by smtp.gmail.com with ESMTPSA id a15-20020a170902710f00b0016d79be70d7sm7153958pll.92.2022.07.27.15.11.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jul 2022 15:11:50 -0700 (PDT)
Date:   Wed, 27 Jul 2022 15:11:44 -0700
From:   Josh Steadmon <steadmon@google.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, me@ttaylorr.com,
        newren@gmail.com, avarab@gmail.com, dyroneteng@gmail.com,
        Johannes.Schindelin@gmx.de, szeder.dev@gmail.com,
        mjcheetham@outlook.com, Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH 0/5] Bundle URIs II: git clone --bundle-uri
Message-ID: <YuG4ICBFNbLPR9Iv@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, gitster@pobox.com, me@ttaylorr.com,
        newren@gmail.com, avarab@gmail.com, dyroneteng@gmail.com,
        Johannes.Schindelin@gmx.de, szeder.dev@gmail.com,
        mjcheetham@outlook.com, Derrick Stolee <derrickstolee@github.com>
References: <pull.1300.git.1658781277.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pull.1300.git.1658781277.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2022.07.25 20:34, Derrick Stolee via GitGitGadget wrote:
> This is the second series building the bundle URI feature as discussed in
> the previous series that added the design document [1]. This series does not
> modify the design document, so the patches are independent and can be
> applied to the latest 'master'.
> 
> [1]
> https://lore.kernel.org/git/pull.1248.v3.git.1658757188.gitgitgadget@gmail.com
> 
> This series brings in just enough logic that we can bootstrap clones from a
> single bundle using git clone --bundle-uri=<X>.
> 
>  * Patch 1 adds a 'get' capability to 'git remote-https' which allows
>    downloading the contents of a URI to a local file.
>  * Patch 2 creates basic file-copy logic within a new bundle-uri.c file. It
>    is not used until patch 3.
>  * Patch 3 creates the git clone --bundle-uri=<X> option, allowing Git to
>    bootstrap a clone from a bundle, but get the remaining objects from the
>    origin URL. (As of this patch, it only accepts a filename.)
>  * Patch 4 extends the git clone --bundle-uri=<X> option to allow file://
>    and https:// URIs.
>  * Patch 5 is a CLI helper to avoid using --bundle-uri and --depth at the
>    same time in git clone.
> 
> As outlined in [1], the next steps after this are:
> 
>  1. Allow parsing a bundle list as a config file at the given URI. The
>     key-value format is unified with the protocol v2 verb (coming in (3)).
>     [2]
>  2. Implement the protocol v2 verb, re-using the bundle list logic from (2).
>     Use this to auto-discover bundle URIs during 'git clone' (behind a
>     config option). [3]
>  3. Implement the 'creationToken' heuristic, allowing incremental 'git
>     fetch' commands to download a bundle list from a configured URI, and
>     only download bundles that are new based on the creation token values.
>     [4]
> 
> I have prepared some of this work as pull requests on my personal fork so
> curious readers can look ahead to where we are going:
> 
> [2] https://github.com/derrickstolee/git/pull/20
> 
> [3] https://github.com/derrickstolee/git/pull/21
> 
> [4] https://github.com/derrickstolee/git/pull/22
> 
> Note: this series includes some code pulled out of the first series [1], and
> in particular the git fetch --bundle-uri=<X> option is removed. The
> intention was to replace that with git bundle fetch <X>, but that conflicts
> with the work to refactor how subcommands are parsed. The git bundle fetch
> subcommand could be added later for maximum flexibility on the client side,
> but we can also move forward without it.
> 
> Thanks, -Stolee
> 
> P.S. Here is the range-diff compared to v2 of the previous bundle URI
> series:
> 
> 1:  d444042dc4dcc < -:  ------------- docs: document bundle URI standard
> 2:  0a2cf60437f78 ! 1:  40808e92afb7b remote-curl: add 'get' capability
>     @@ remote-curl.c: static void parse_fetch(struct strbuf *buf)
>       
>      +static void parse_get(struct strbuf *buf)
>      +{
>     -+	struct http_get_options opts = { 0 };
>      +	struct strbuf url = STRBUF_INIT;
>      +	struct strbuf path = STRBUF_INIT;
>      +	const char *p, *space;
>     @@ remote-curl.c: static void parse_fetch(struct strbuf *buf)
>      +	strbuf_add(&url, p, space - p);
>      +	strbuf_addstr(&path, space + 1);
>      +
>     -+	if (http_get_file(url.buf, path.buf, &opts))
>     ++	if (http_get_file(url.buf, path.buf, NULL))
>      +		die(_("failed to download file at URL '%s'"), url.buf);
>      +
>      +	strbuf_release(&url);
>     @@ t/t5557-http-get.sh (new)
>      +	get $url file1
>      +	EOF
>      +
>     -+	test_must_fail git remote-http $url $url <input 2>err &&
>     ++	test_must_fail git remote-http $url <input 2>err &&
>      +	test_path_is_missing file1 &&
>      +	grep "failed to download file at URL" err &&
>      +	rm file1.temp
>     @@ t/t5557-http-get.sh (new)
>      +
>      +	EOF
>      +
>     -+	GIT_TRACE2_PERF=1 git remote-http $url $url <input &&
>     ++	GIT_TRACE2_PERF=1 git remote-http $url <input &&
>      +	test_cmp "$HTTPD_DOCUMENT_ROOT_PATH/exists.txt" file2
>      +'
>      +
>      +test_done
>     -
>     - ## transport-helper.c ##
>     -@@ transport-helper.c: struct helper_data {
>     - 		check_connectivity : 1,
>     - 		no_disconnect_req : 1,
>     - 		no_private_update : 1,
>     --		object_format : 1;
>     -+		object_format : 1,
>     -+		get : 1;
>     - 
>     - 	/*
>     - 	 * As an optimization, the transport code may invoke fetch before
>     -@@ transport-helper.c: static struct child_process *get_helper(struct transport *transport)
>     - 			data->no_private_update = 1;
>     - 		} else if (starts_with(capname, "object-format")) {
>     - 			data->object_format = 1;
>     -+		} else if (!strcmp(capname, "get")) {
>     -+			data->get = 1;
>     - 		} else if (mandatory) {
>     - 			die(_("unknown mandatory capability %s; this remote "
>     - 			      "helper probably needs newer version of Git"),
> 3:  abec47564fd9c ! 2:  7d3159f0d9a29 bundle-uri: create basic file-copy logic
>     @@ Commit message
>          file, not a bundle list. Bundle lists will be implemented in a future
>          change.
>      
>     +    Note that the discovery of a temporary filename is slightly racy because
>     +    the odb_mkstemp() relies on the temporary file not existing. With the
>     +    current implementation being limited to file copies, we could replace
>     +    the copy_file() with copy_fd(). The tricky part comes in future changes
>     +    that send the filename to 'git remote-https' and its 'get' capability.
>     +    At that point, we need the file descriptor closed _and_ the file
>     +    unlinked. If we were to keep the file descriptor open for the sake of
>     +    normal file copies, then we would pollute the rest of the code for
>     +    little benefit. This is especially the case because we expect that most
>     +    bundle URI use will be based on HTTPS instead of file copies.
>     +
>          Signed-off-by: Derrick Stolee <derrickstolee@github.com>
>      
>       ## Makefile ##
>     @@ bundle-uri.c (new)
>      +#include "refs.h"
>      +#include "run-command.h"
>      +
>     -+static void find_temp_filename(struct strbuf *name)
>     ++static int find_temp_filename(struct strbuf *name)
>      +{
>      +	int fd;
>      +	/*
>     @@ bundle-uri.c (new)
>      +	 * racy, but unlikely to collide.
>      +	 */
>      +	fd = odb_mkstemp(name, "bundles/tmp_uri_XXXXXX");
>     -+	if (fd < 0)
>     -+		die(_("failed to create temporary file"));
>     ++	if (fd < 0) {
>     ++		warning(_("failed to create temporary file"));
>     ++		return -1;
>     ++	}
>     ++
>      +	close(fd);
>      +	unlink(name->buf);
>     ++	return 0;
>      +}
>      +
>     -+static int copy_uri_to_file(const char *uri, const char *file)
>     ++static int copy_uri_to_file(const char *file, const char *uri)
>      +{
>     -+	/* Copy as a file */
>     -+	return copy_file(file, uri, 0444);
>     ++	/* File-based URIs only for now. */
>     ++	return copy_file(file, uri, 0);
>      +}
>      +
>      +static int unbundle_from_file(struct repository *r, const char *file)
>     @@ bundle-uri.c (new)
>      +	int result = 0;
>      +	int bundle_fd;
>      +	struct bundle_header header = BUNDLE_HEADER_INIT;
>     -+	struct strvec extra_index_pack_args = STRVEC_INIT;
>      +	struct string_list_item *refname;
>      +	struct strbuf bundle_ref = STRBUF_INIT;
>      +	size_t bundle_prefix_len;
>     @@ bundle-uri.c (new)
>      +	if ((bundle_fd = read_bundle_header(file, &header)) < 0)
>      +		return 1;
>      +
>     -+	if ((result = unbundle(r, &header, bundle_fd, &extra_index_pack_args)))
>     ++	if ((result = unbundle(r, &header, bundle_fd, NULL)))
>      +		return 1;
>      +
>      +	/*
>     @@ bundle-uri.c (new)
>      +	int result = 0;
>      +	struct strbuf filename = STRBUF_INIT;
>      +
>     -+	find_temp_filename(&filename);
>     -+	if ((result = copy_uri_to_file(uri, filename.buf)))
>     ++	if ((result = find_temp_filename(&filename)))
>     ++		goto cleanup;
>     ++
>     ++	if ((result = copy_uri_to_file(filename.buf, uri))) {
>     ++		warning(_("failed to download bundle from URI '%s'"), uri);
>      +		goto cleanup;
>     ++	}
>      +
>     -+	if ((result = !is_bundle(filename.buf, 0)))
>     ++	if ((result = !is_bundle(filename.buf, 0))) {
>     ++		warning(_("file at URI '%s' is not a bundle"), uri);
>      +		goto cleanup;
>     ++	}
>      +
>     -+	if ((result = unbundle_from_file(r, filename.buf)))
>     ++	if ((result = unbundle_from_file(r, filename.buf))) {
>     ++		warning(_("failed to unbundle bundle from URI '%s'"), uri);
>      +		goto cleanup;
>     ++	}
>      +
>      +cleanup:
>      +	unlink(filename.buf);
> 4:  f6255ec518857 < -:  ------------- fetch: add --bundle-uri option
> -:  ------------- > 3:  29e645a54ba7f clone: add --bundle-uri option
> 5:  bfbd11b48bf1b ! 4:  f6bc3177332e8 bundle-uri: add support for http(s):// and file://
>     @@ Metadata
>       ## Commit message ##
>          bundle-uri: add support for http(s):// and file://
>      
>     -    The previous change created the 'git fetch --bundle-uri=<uri>' option.
>     +    The previous change created the 'git clone --bundle-uri=<uri>' option.
>          Currently, <uri> must be a filename.
>      
>          Update copy_uri_to_file() to first inspect the URI for an HTTP(S) prefix
>     @@ Commit message
>          Signed-off-by: Derrick Stolee <derrickstolee@github.com>
>      
>       ## bundle-uri.c ##
>     -@@ bundle-uri.c: static void find_temp_filename(struct strbuf *name)
>     - 	unlink(name->buf);
>     +@@ bundle-uri.c: static int find_temp_filename(struct strbuf *name)
>     + 	return 0;
>       }
>       
>     -+static int download_https_uri_to_file(const char *uri, const char *file)
>     -+{
>     +-static int copy_uri_to_file(const char *file, const char *uri)
>     ++static int download_https_uri_to_file(const char *file, const char *uri)
>     + {
>     +-	/* File-based URIs only for now. */
>     +-	return copy_file(file, uri, 0);
>      +	int result = 0;
>      +	struct child_process cp = CHILD_PROCESS_INIT;
>      +	FILE *child_in = NULL, *child_out = NULL;
>     @@ bundle-uri.c: static void find_temp_filename(struct strbuf *name)
>      +	return result;
>      +}
>      +
>     - static int copy_uri_to_file(const char *uri, const char *file)
>     - {
>     ++static int copy_uri_to_file(const char *filename, const char *uri)
>     ++{
>      +	const char *out;
>     ++
>      +	if (skip_prefix(uri, "https:", &out) ||
>      +	    skip_prefix(uri, "http:", &out))
>     -+		return download_https_uri_to_file(uri, file);
>     ++		return download_https_uri_to_file(filename, uri);
>      +
>      +	if (!skip_prefix(uri, "file://", &out))
>      +		out = uri;
>      +
>     - 	/* Copy as a file */
>     --	return copy_file(file, uri, 0444);
>     -+	return !!copy_file(file, out, 0);
>     ++	/* Copy as a file */
>     ++	return copy_file(filename, out, 0);
>       }
>       
>       static int unbundle_from_file(struct repository *r, const char *file)
>      
>     - ## t/t5558-fetch-bundle-uri.sh ##
>     -@@ t/t5558-fetch-bundle-uri.sh: test_expect_success 'fetch file bundle' '
>     + ## t/t5558-clone-bundle-uri.sh ##
>     +@@ t/t5558-clone-bundle-uri.sh: test_expect_success 'clone with path bundle' '
>           test_cmp expect actual
>       '
>       
>     -+test_expect_success 'fetch file:// bundle' '
>     -+	git init fetch-file &&
>     -+	git -C fetch-file fetch --bundle-uri="file://$(pwd)/fetch-from/B.bundle" &&
>     -+	git -C fetch-file rev-parse refs/bundles/topic >actual &&
>     -+	git -C fetch-from rev-parse topic >expect &&
>     ++test_expect_success 'clone with file:// bundle' '
>     ++	git clone --bundle-uri="file://$(pwd)/clone-from/B.bundle" \
>     ++		clone-from clone-file &&
>     ++	git -C clone-file rev-parse refs/bundles/topic >actual &&
>     ++	git -C clone-from rev-parse topic >expect &&
>      +	test_cmp expect actual
>      +'
>      +
>     @@ t/t5558-fetch-bundle-uri.sh: test_expect_success 'fetch file bundle' '
>      +start_httpd
>      +
>      +test_expect_success 'fail to fetch from non-existent HTTP URL' '
>     -+	test_must_fail git fetch --bundle-uri="$HTTPD_URL/does-not-exist" 2>err &&
>     ++	test_when_finished rm -rf test &&
>     ++	git clone --bundle-uri="$HTTPD_URL/does-not-exist" . test 2>err &&
>      +	grep "failed to download bundle from URI" err
>      +'
>      +
>      +test_expect_success 'fail to fetch from non-bundle HTTP URL' '
>     ++	test_when_finished rm -rf test &&
>      +	echo bogus >"$HTTPD_DOCUMENT_ROOT_PATH/bogus" &&
>     -+	test_must_fail git fetch --bundle-uri="$HTTPD_URL/bogus" 2>err &&
>     ++	git clone --bundle-uri="$HTTPD_URL/bogus" . test 2>err &&
>      +	grep "is not a bundle" err
>      +'
>      +
>     -+test_expect_success 'fetch HTTP bundle' '
>     -+	cp fetch-from/B.bundle "$HTTPD_DOCUMENT_ROOT_PATH/B.bundle" &&
>     -+	git init fetch-http &&
>     -+	git -C fetch-http fetch --bundle-uri="$HTTPD_URL/B.bundle" &&
>     -+	git -C fetch-http rev-parse refs/bundles/topic >actual &&
>     -+	git -C fetch-from rev-parse topic >expect &&
>     -+	test_cmp expect actual
>     ++test_expect_success 'clone HTTP bundle' '
>     ++	cp clone-from/B.bundle "$HTTPD_DOCUMENT_ROOT_PATH/B.bundle" &&
>     ++
>     ++	git clone --no-local --mirror clone-from \
>     ++		"$HTTPD_DOCUMENT_ROOT_PATH/fetch.git" &&
>     ++
>     ++	git clone --bundle-uri="$HTTPD_URL/B.bundle" \
>     ++		"$HTTPD_URL/smart/fetch.git" clone-http &&
>     ++	git -C clone-http rev-parse refs/bundles/topic >actual &&
>     ++	git -C clone-from rev-parse topic >expect &&
>     ++	test_cmp expect actual &&
>     ++
>     ++	test_config -C clone-http log.excludedecoration refs/bundle/
>      +'
>      +
>      +# Do not add tests here unless they use the HTTP server, as they will
> 6:  a217e9a0640b4 < -:  ------------- fetch: add 'refs/bundle/' to log.excludeDecoration
> -:  ------------- > 5:  e823b168ab725 clone: --bundle-uri cannot be combined with --depth
> 
> 
> Derrick Stolee (5):
>   remote-curl: add 'get' capability
>   bundle-uri: create basic file-copy logic
>   clone: add --bundle-uri option
>   bundle-uri: add support for http(s):// and file://
>   clone: --bundle-uri cannot be combined with --depth
> 
>  Documentation/git-clone.txt         |   7 ++
>  Documentation/gitremote-helpers.txt |   9 ++
>  Makefile                            |   1 +
>  builtin/clone.c                     |  18 +++
>  bundle-uri.c                        | 168 ++++++++++++++++++++++++++++
>  bundle-uri.h                        |  14 +++
>  remote-curl.c                       |  32 ++++++
>  t/t5557-http-get.sh                 |  37 ++++++
>  t/t5558-clone-bundle-uri.sh         |  81 ++++++++++++++
>  t/t5606-clone-options.sh            |   8 ++
>  10 files changed, 375 insertions(+)
>  create mode 100644 bundle-uri.c
>  create mode 100644 bundle-uri.h
>  create mode 100755 t/t5557-http-get.sh
>  create mode 100755 t/t5558-clone-bundle-uri.sh
> 
> 
> base-commit: e72d93e88cb20b06e88e6e7d81bd1dc4effe453f
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1300%2Fderrickstolee%2Fbundle-redo%2Fclone-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1300/derrickstolee/bundle-redo/clone-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/1300
> -- 
> gitgitgadget

Looks good to me, with just one small fix and a couple of optional
nitpicks. Thaks for the series!

Reviewed-by: Josh Steadmon <steadmon@google.com>
