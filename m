Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0251C433EF
	for <git@archiver.kernel.org>; Mon, 25 Jul 2022 20:34:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237095AbiGYUen (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Jul 2022 16:34:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbiGYUem (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Jul 2022 16:34:42 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C29B2251F
        for <git@vger.kernel.org>; Mon, 25 Jul 2022 13:34:40 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id b21-20020a05600c4e1500b003a32bc8612fso7040625wmq.3
        for <git@vger.kernel.org>; Mon, 25 Jul 2022 13:34:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=WCkA+WNGHEW5m93DmnOjy3874TIDhCvz3gt2EgP4Phk=;
        b=b00PtZ/qzaVZ00AGKoH/idoOopuus8joNkEoFZU+el8bFZNztxBE07Y+lVxhLN5Wrj
         MzL8aKYk8VOfr/UerPFfN6MtYo2KCBC3KxE6ODB0eayQ3IxFgZw78yQRe0g9cQL3nGSE
         f7SMUT8TTCsUZNsiJKERJ9tMvkYsdYDYgu8vQQ/EDIR+w7Hr+XIw87Hz8RYT90LN9RCB
         91PuApCr/nR8RmRQ/nGl92bG3jLe5WPHR/h9stfo93SEQmjjvl79e81CeV5LDYXp7Rsa
         JuE7QfiEKBmRYX3Rl7FGGNE7j/lZu0EGwGbQ0P37OdqluLLFthTF0pJKixvESvDOaBlR
         ekbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=WCkA+WNGHEW5m93DmnOjy3874TIDhCvz3gt2EgP4Phk=;
        b=aeRsQkb6JCBhpvwh6N6EpuCZ3FRC0RZTOX1V7XS0nMIrg7f8Rm4X1cC05LaD01Q824
         HR/Ws2tv2fOzSlh+g1rnuvG8YnxhayJuVsby8hh9m45z7L6VR5Xq8QLVbn5AFeQSwXQV
         bbShJZStMubipLIuoQHSs7sMiF+83I8lfCV0yJfuDaBcYRjkLt17qHxAsXKPj8mMbHSg
         pxxJM07fmubXCwQ+U76XqLrv1FVfJ7bU+b14bWzxvN0j6LVFRrZdG4i3VSwicAbOV9p+
         /hDqAbzlOUcbBeC9FcDps5epsGbv0+T6GSMKUFhLOLS4iouNsmivRRJYrK1xcqzwCVLW
         fSfw==
X-Gm-Message-State: AJIora/cmpZmF8ws8GGCztTgEPpch5KkS3uUUpRi25LXhxE32jAXnAFj
        nMD0Mpa0LFX0JOPweTEt7eyT6N/gLAE=
X-Google-Smtp-Source: AGRyM1sar/UMxrbR3vOV5ARpSAxgJk+J0NH49zIHBo96eMdM6GJgTKduh3rZvyDxaNXdxl2jC8ZZWg==
X-Received: by 2002:a1c:2542:0:b0:3a3:2dcd:8736 with SMTP id l63-20020a1c2542000000b003a32dcd8736mr19246053wml.57.1658781278592;
        Mon, 25 Jul 2022 13:34:38 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f7-20020a1c3807000000b003a3080eacb9sm15707887wma.24.2022.07.25.13.34.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 13:34:38 -0700 (PDT)
Message-Id: <pull.1300.git.1658781277.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 25 Jul 2022 20:34:32 +0000
Subject: [PATCH 0/5] Bundle URIs II: git clone --bundle-uri
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, me@ttaylorr.com, newren@gmail.com,
        avarab@gmail.com, dyroneteng@gmail.com, Johannes.Schindelin@gmx.de,
        szeder.dev@gmail.com, mjcheetham@outlook.com, steadmon@google.com,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is the second series building the bundle URI feature as discussed in
the previous series that added the design document [1]. This series does not
modify the design document, so the patches are independent and can be
applied to the latest 'master'.

[1]
https://lore.kernel.org/git/pull.1248.v3.git.1658757188.gitgitgadget@gmail.com

This series brings in just enough logic that we can bootstrap clones from a
single bundle using git clone --bundle-uri=<X>.

 * Patch 1 adds a 'get' capability to 'git remote-https' which allows
   downloading the contents of a URI to a local file.
 * Patch 2 creates basic file-copy logic within a new bundle-uri.c file. It
   is not used until patch 3.
 * Patch 3 creates the git clone --bundle-uri=<X> option, allowing Git to
   bootstrap a clone from a bundle, but get the remaining objects from the
   origin URL. (As of this patch, it only accepts a filename.)
 * Patch 4 extends the git clone --bundle-uri=<X> option to allow file://
   and https:// URIs.
 * Patch 5 is a CLI helper to avoid using --bundle-uri and --depth at the
   same time in git clone.

As outlined in [1], the next steps after this are:

 1. Allow parsing a bundle list as a config file at the given URI. The
    key-value format is unified with the protocol v2 verb (coming in (3)).
    [2]
 2. Implement the protocol v2 verb, re-using the bundle list logic from (2).
    Use this to auto-discover bundle URIs during 'git clone' (behind a
    config option). [3]
 3. Implement the 'creationToken' heuristic, allowing incremental 'git
    fetch' commands to download a bundle list from a configured URI, and
    only download bundles that are new based on the creation token values.
    [4]

I have prepared some of this work as pull requests on my personal fork so
curious readers can look ahead to where we are going:

[2] https://github.com/derrickstolee/git/pull/20

[3] https://github.com/derrickstolee/git/pull/21

[4] https://github.com/derrickstolee/git/pull/22

Note: this series includes some code pulled out of the first series [1], and
in particular the git fetch --bundle-uri=<X> option is removed. The
intention was to replace that with git bundle fetch <X>, but that conflicts
with the work to refactor how subcommands are parsed. The git bundle fetch
subcommand could be added later for maximum flexibility on the client side,
but we can also move forward without it.

Thanks, -Stolee

P.S. Here is the range-diff compared to v2 of the previous bundle URI
series:

1:  d444042dc4dcc < -:  ------------- docs: document bundle URI standard
2:  0a2cf60437f78 ! 1:  40808e92afb7b remote-curl: add 'get' capability
    @@ remote-curl.c: static void parse_fetch(struct strbuf *buf)
      
     +static void parse_get(struct strbuf *buf)
     +{
    -+	struct http_get_options opts = { 0 };
     +	struct strbuf url = STRBUF_INIT;
     +	struct strbuf path = STRBUF_INIT;
     +	const char *p, *space;
    @@ remote-curl.c: static void parse_fetch(struct strbuf *buf)
     +	strbuf_add(&url, p, space - p);
     +	strbuf_addstr(&path, space + 1);
     +
    -+	if (http_get_file(url.buf, path.buf, &opts))
    ++	if (http_get_file(url.buf, path.buf, NULL))
     +		die(_("failed to download file at URL '%s'"), url.buf);
     +
     +	strbuf_release(&url);
    @@ t/t5557-http-get.sh (new)
     +	get $url file1
     +	EOF
     +
    -+	test_must_fail git remote-http $url $url <input 2>err &&
    ++	test_must_fail git remote-http $url <input 2>err &&
     +	test_path_is_missing file1 &&
     +	grep "failed to download file at URL" err &&
     +	rm file1.temp
    @@ t/t5557-http-get.sh (new)
     +
     +	EOF
     +
    -+	GIT_TRACE2_PERF=1 git remote-http $url $url <input &&
    ++	GIT_TRACE2_PERF=1 git remote-http $url <input &&
     +	test_cmp "$HTTPD_DOCUMENT_ROOT_PATH/exists.txt" file2
     +'
     +
     +test_done
    -
    - ## transport-helper.c ##
    -@@ transport-helper.c: struct helper_data {
    - 		check_connectivity : 1,
    - 		no_disconnect_req : 1,
    - 		no_private_update : 1,
    --		object_format : 1;
    -+		object_format : 1,
    -+		get : 1;
    - 
    - 	/*
    - 	 * As an optimization, the transport code may invoke fetch before
    -@@ transport-helper.c: static struct child_process *get_helper(struct transport *transport)
    - 			data->no_private_update = 1;
    - 		} else if (starts_with(capname, "object-format")) {
    - 			data->object_format = 1;
    -+		} else if (!strcmp(capname, "get")) {
    -+			data->get = 1;
    - 		} else if (mandatory) {
    - 			die(_("unknown mandatory capability %s; this remote "
    - 			      "helper probably needs newer version of Git"),
3:  abec47564fd9c ! 2:  7d3159f0d9a29 bundle-uri: create basic file-copy logic
    @@ Commit message
         file, not a bundle list. Bundle lists will be implemented in a future
         change.
     
    +    Note that the discovery of a temporary filename is slightly racy because
    +    the odb_mkstemp() relies on the temporary file not existing. With the
    +    current implementation being limited to file copies, we could replace
    +    the copy_file() with copy_fd(). The tricky part comes in future changes
    +    that send the filename to 'git remote-https' and its 'get' capability.
    +    At that point, we need the file descriptor closed _and_ the file
    +    unlinked. If we were to keep the file descriptor open for the sake of
    +    normal file copies, then we would pollute the rest of the code for
    +    little benefit. This is especially the case because we expect that most
    +    bundle URI use will be based on HTTPS instead of file copies.
    +
         Signed-off-by: Derrick Stolee <derrickstolee@github.com>
     
      ## Makefile ##
    @@ bundle-uri.c (new)
     +#include "refs.h"
     +#include "run-command.h"
     +
    -+static void find_temp_filename(struct strbuf *name)
    ++static int find_temp_filename(struct strbuf *name)
     +{
     +	int fd;
     +	/*
    @@ bundle-uri.c (new)
     +	 * racy, but unlikely to collide.
     +	 */
     +	fd = odb_mkstemp(name, "bundles/tmp_uri_XXXXXX");
    -+	if (fd < 0)
    -+		die(_("failed to create temporary file"));
    ++	if (fd < 0) {
    ++		warning(_("failed to create temporary file"));
    ++		return -1;
    ++	}
    ++
     +	close(fd);
     +	unlink(name->buf);
    ++	return 0;
     +}
     +
    -+static int copy_uri_to_file(const char *uri, const char *file)
    ++static int copy_uri_to_file(const char *file, const char *uri)
     +{
    -+	/* Copy as a file */
    -+	return copy_file(file, uri, 0444);
    ++	/* File-based URIs only for now. */
    ++	return copy_file(file, uri, 0);
     +}
     +
     +static int unbundle_from_file(struct repository *r, const char *file)
    @@ bundle-uri.c (new)
     +	int result = 0;
     +	int bundle_fd;
     +	struct bundle_header header = BUNDLE_HEADER_INIT;
    -+	struct strvec extra_index_pack_args = STRVEC_INIT;
     +	struct string_list_item *refname;
     +	struct strbuf bundle_ref = STRBUF_INIT;
     +	size_t bundle_prefix_len;
    @@ bundle-uri.c (new)
     +	if ((bundle_fd = read_bundle_header(file, &header)) < 0)
     +		return 1;
     +
    -+	if ((result = unbundle(r, &header, bundle_fd, &extra_index_pack_args)))
    ++	if ((result = unbundle(r, &header, bundle_fd, NULL)))
     +		return 1;
     +
     +	/*
    @@ bundle-uri.c (new)
     +	int result = 0;
     +	struct strbuf filename = STRBUF_INIT;
     +
    -+	find_temp_filename(&filename);
    -+	if ((result = copy_uri_to_file(uri, filename.buf)))
    ++	if ((result = find_temp_filename(&filename)))
    ++		goto cleanup;
    ++
    ++	if ((result = copy_uri_to_file(filename.buf, uri))) {
    ++		warning(_("failed to download bundle from URI '%s'"), uri);
     +		goto cleanup;
    ++	}
     +
    -+	if ((result = !is_bundle(filename.buf, 0)))
    ++	if ((result = !is_bundle(filename.buf, 0))) {
    ++		warning(_("file at URI '%s' is not a bundle"), uri);
     +		goto cleanup;
    ++	}
     +
    -+	if ((result = unbundle_from_file(r, filename.buf)))
    ++	if ((result = unbundle_from_file(r, filename.buf))) {
    ++		warning(_("failed to unbundle bundle from URI '%s'"), uri);
     +		goto cleanup;
    ++	}
     +
     +cleanup:
     +	unlink(filename.buf);
4:  f6255ec518857 < -:  ------------- fetch: add --bundle-uri option
-:  ------------- > 3:  29e645a54ba7f clone: add --bundle-uri option
5:  bfbd11b48bf1b ! 4:  f6bc3177332e8 bundle-uri: add support for http(s):// and file://
    @@ Metadata
      ## Commit message ##
         bundle-uri: add support for http(s):// and file://
     
    -    The previous change created the 'git fetch --bundle-uri=<uri>' option.
    +    The previous change created the 'git clone --bundle-uri=<uri>' option.
         Currently, <uri> must be a filename.
     
         Update copy_uri_to_file() to first inspect the URI for an HTTP(S) prefix
    @@ Commit message
         Signed-off-by: Derrick Stolee <derrickstolee@github.com>
     
      ## bundle-uri.c ##
    -@@ bundle-uri.c: static void find_temp_filename(struct strbuf *name)
    - 	unlink(name->buf);
    +@@ bundle-uri.c: static int find_temp_filename(struct strbuf *name)
    + 	return 0;
      }
      
    -+static int download_https_uri_to_file(const char *uri, const char *file)
    -+{
    +-static int copy_uri_to_file(const char *file, const char *uri)
    ++static int download_https_uri_to_file(const char *file, const char *uri)
    + {
    +-	/* File-based URIs only for now. */
    +-	return copy_file(file, uri, 0);
     +	int result = 0;
     +	struct child_process cp = CHILD_PROCESS_INIT;
     +	FILE *child_in = NULL, *child_out = NULL;
    @@ bundle-uri.c: static void find_temp_filename(struct strbuf *name)
     +	return result;
     +}
     +
    - static int copy_uri_to_file(const char *uri, const char *file)
    - {
    ++static int copy_uri_to_file(const char *filename, const char *uri)
    ++{
     +	const char *out;
    ++
     +	if (skip_prefix(uri, "https:", &out) ||
     +	    skip_prefix(uri, "http:", &out))
    -+		return download_https_uri_to_file(uri, file);
    ++		return download_https_uri_to_file(filename, uri);
     +
     +	if (!skip_prefix(uri, "file://", &out))
     +		out = uri;
     +
    - 	/* Copy as a file */
    --	return copy_file(file, uri, 0444);
    -+	return !!copy_file(file, out, 0);
    ++	/* Copy as a file */
    ++	return copy_file(filename, out, 0);
      }
      
      static int unbundle_from_file(struct repository *r, const char *file)
     
    - ## t/t5558-fetch-bundle-uri.sh ##
    -@@ t/t5558-fetch-bundle-uri.sh: test_expect_success 'fetch file bundle' '
    + ## t/t5558-clone-bundle-uri.sh ##
    +@@ t/t5558-clone-bundle-uri.sh: test_expect_success 'clone with path bundle' '
          test_cmp expect actual
      '
      
    -+test_expect_success 'fetch file:// bundle' '
    -+	git init fetch-file &&
    -+	git -C fetch-file fetch --bundle-uri="file://$(pwd)/fetch-from/B.bundle" &&
    -+	git -C fetch-file rev-parse refs/bundles/topic >actual &&
    -+	git -C fetch-from rev-parse topic >expect &&
    ++test_expect_success 'clone with file:// bundle' '
    ++	git clone --bundle-uri="file://$(pwd)/clone-from/B.bundle" \
    ++		clone-from clone-file &&
    ++	git -C clone-file rev-parse refs/bundles/topic >actual &&
    ++	git -C clone-from rev-parse topic >expect &&
     +	test_cmp expect actual
     +'
     +
    @@ t/t5558-fetch-bundle-uri.sh: test_expect_success 'fetch file bundle' '
     +start_httpd
     +
     +test_expect_success 'fail to fetch from non-existent HTTP URL' '
    -+	test_must_fail git fetch --bundle-uri="$HTTPD_URL/does-not-exist" 2>err &&
    ++	test_when_finished rm -rf test &&
    ++	git clone --bundle-uri="$HTTPD_URL/does-not-exist" . test 2>err &&
     +	grep "failed to download bundle from URI" err
     +'
     +
     +test_expect_success 'fail to fetch from non-bundle HTTP URL' '
    ++	test_when_finished rm -rf test &&
     +	echo bogus >"$HTTPD_DOCUMENT_ROOT_PATH/bogus" &&
    -+	test_must_fail git fetch --bundle-uri="$HTTPD_URL/bogus" 2>err &&
    ++	git clone --bundle-uri="$HTTPD_URL/bogus" . test 2>err &&
     +	grep "is not a bundle" err
     +'
     +
    -+test_expect_success 'fetch HTTP bundle' '
    -+	cp fetch-from/B.bundle "$HTTPD_DOCUMENT_ROOT_PATH/B.bundle" &&
    -+	git init fetch-http &&
    -+	git -C fetch-http fetch --bundle-uri="$HTTPD_URL/B.bundle" &&
    -+	git -C fetch-http rev-parse refs/bundles/topic >actual &&
    -+	git -C fetch-from rev-parse topic >expect &&
    -+	test_cmp expect actual
    ++test_expect_success 'clone HTTP bundle' '
    ++	cp clone-from/B.bundle "$HTTPD_DOCUMENT_ROOT_PATH/B.bundle" &&
    ++
    ++	git clone --no-local --mirror clone-from \
    ++		"$HTTPD_DOCUMENT_ROOT_PATH/fetch.git" &&
    ++
    ++	git clone --bundle-uri="$HTTPD_URL/B.bundle" \
    ++		"$HTTPD_URL/smart/fetch.git" clone-http &&
    ++	git -C clone-http rev-parse refs/bundles/topic >actual &&
    ++	git -C clone-from rev-parse topic >expect &&
    ++	test_cmp expect actual &&
    ++
    ++	test_config -C clone-http log.excludedecoration refs/bundle/
     +'
     +
     +# Do not add tests here unless they use the HTTP server, as they will
6:  a217e9a0640b4 < -:  ------------- fetch: add 'refs/bundle/' to log.excludeDecoration
-:  ------------- > 5:  e823b168ab725 clone: --bundle-uri cannot be combined with --depth


Derrick Stolee (5):
  remote-curl: add 'get' capability
  bundle-uri: create basic file-copy logic
  clone: add --bundle-uri option
  bundle-uri: add support for http(s):// and file://
  clone: --bundle-uri cannot be combined with --depth

 Documentation/git-clone.txt         |   7 ++
 Documentation/gitremote-helpers.txt |   9 ++
 Makefile                            |   1 +
 builtin/clone.c                     |  18 +++
 bundle-uri.c                        | 168 ++++++++++++++++++++++++++++
 bundle-uri.h                        |  14 +++
 remote-curl.c                       |  32 ++++++
 t/t5557-http-get.sh                 |  37 ++++++
 t/t5558-clone-bundle-uri.sh         |  81 ++++++++++++++
 t/t5606-clone-options.sh            |   8 ++
 10 files changed, 375 insertions(+)
 create mode 100644 bundle-uri.c
 create mode 100644 bundle-uri.h
 create mode 100755 t/t5557-http-get.sh
 create mode 100755 t/t5558-clone-bundle-uri.sh


base-commit: e72d93e88cb20b06e88e6e7d81bd1dc4effe453f
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1300%2Fderrickstolee%2Fbundle-redo%2Fclone-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1300/derrickstolee/bundle-redo/clone-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1300
-- 
gitgitgadget
