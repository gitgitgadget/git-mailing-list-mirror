Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72419C4332F
	for <git@archiver.kernel.org>; Wed, 16 Nov 2022 19:51:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234100AbiKPTvv (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Nov 2022 14:51:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232527AbiKPTvs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Nov 2022 14:51:48 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B40043AF8
        for <git@vger.kernel.org>; Wed, 16 Nov 2022 11:51:46 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id ja4-20020a05600c556400b003cf6e77f89cso3603322wmb.0
        for <git@vger.kernel.org>; Wed, 16 Nov 2022 11:51:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xOEH/HDMK44PCzgn1kJOv1Qf5bp7pZL4JUYP8gVPZo8=;
        b=mi201wNX2ldXEY9E58qjwoa3RBREvwwrcU3brkqxCdMRi2sRz/5iTC4WD+Ww1LS9Or
         WEefawpRM/g0HvYri9277OXnto1E8Y704ltd6ByInvmu+19NrJxJ3Y7di5/yMsoS24Fv
         px6baZPHSfnN7QuzfCGLLK7SHnprMtk8RRpzP4SBz9xk/JbygT4hqjUoTUDW/NoFcpGI
         5nVSDzx4lxcm+SH7VBwtmJwtJKmId31FuCzSvolJb+I+W0gqQYgr6Uz3yizflor2a3NT
         uu4YYZwK4sFlK2eRskbJIAJTl1DRtuNb+rmQj+XqpXc9PjKwiKyM1KMyhAa0qcX0ouoJ
         Apcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xOEH/HDMK44PCzgn1kJOv1Qf5bp7pZL4JUYP8gVPZo8=;
        b=OtSw/jd/4Rw3J3Cd0n1inuRn9dTOkWj5yLGfI4GXwtO4II7SFnx5nPZSHcpl4lK1K2
         dM4tOFaxhMg3rt8G7azZH+qbUcuoJ2SFfoJFYDxKz1YG65by/bkAesIvYK5cT/Bj/RtG
         80KlbdHUGmlz5pkkAKL6PAZiKAgQHmZzh2kuRhwHHmTD4bOn0Rmv86WZ4bjUOCT686Xn
         ftf+V2XRjUXOa3n0e9upbc55W/h2Wzunaxw9Lr0KVnRgf/t7mqNUMbWqNpn1Y2BSAZeP
         oRGYsLtdXDg8UqHeMkxhdCUwB7uFiQUJKoS5jNZTg4dzQ0PCl7+oaDb/G/o+DN2k5dUr
         NCMg==
X-Gm-Message-State: ANoB5pmTEF7oGez/NJvdAIQdiN9Za9/mS5ZNnDvCluBmc1M1KBdhB7Ao
        43G5L1jO/FE1A6YgWyHKehF+F6Zy81s=
X-Google-Smtp-Source: AA0mqf7xSQRUuAi32F2lqlUBeHGcmKdwc82Y+kKtLdqFBU/C6vSqz+c2rG9eKUm92yrO02pLFgS/Bw==
X-Received: by 2002:a05:600c:5010:b0:3cf:b067:416c with SMTP id n16-20020a05600c501000b003cfb067416cmr3243947wmr.134.1668628304552;
        Wed, 16 Nov 2022 11:51:44 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w9-20020adfee49000000b00228cd9f6349sm15953336wro.106.2022.11.16.11.51.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 11:51:44 -0800 (PST)
Message-Id: <pull.1400.v2.git.1668628302.gitgitgadget@gmail.com>
In-Reply-To: <pull.1400.git.1667264854.gitgitgadget@gmail.com>
References: <pull.1400.git.1667264854.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 16 Nov 2022 19:51:33 +0000
Subject: [PATCH v2 0/9] Bundle URIs IV: advertise over protocol v2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, me@ttaylorr.com, newren@gmail.com,
        avarab@gmail.com, mjcheetham@outlook.com, steadmon@google.com,
        chooglen@google.com, jonathantanmy@google.com,
        dyroneteng@gmail.com, Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is based on the recent master batch that included ds/bundle-uri-....

Now that git clone --bundle-uri can download a bundle list from a plaintex
file in config format, we can use the same set of key-value pairs to
advertise a bundle list over protocol v2. At the end of this series:

 1. A server can advertise bundles when uploadPack.advertiseBundleURIs is
    enabled. The bundle list comes from the server's local config,
    specifically the bundle.* namespace.
 2. A client can notice a server's bundle-uri advertisement and request the
    bundle list if transfer.bundleURI is enabled. The bundles are downloaded
    as if the list was advertised from the --bundle-uri option.

Many patches in this series were adapted from Ævar's v2 RFC [1]. He is
retained as author and I added myself as co-author only if the modifications
were significant.

[1]
https://lore.kernel.org/git/RFC-patch-v2-01.13-2fc87ce092b-20220311T155841Z-avarab@gmail.com/

 * Patches 1-5 are mostly taken from [1], again with mostly minor updates.
   The one major difference is the packet line format being a single
   key=value format instead of a sequence of pairs. This also means that
   Patch 4 is entirely new since it feeds these pairs directly from the
   server's config.

 * Patches 6-9 finish off the ability for the client to notice the
   capability, request the values, and download bundles before continuing
   with the rest of the download.

One thing that is not handled here but could be handled in a future change
is to disconnect from the origin Git server while downloading the bundle
URIs, then reconnecting afterwards. This does not make any difference for
HTTPS, but SSH may benefit from the reduced connection time. The git clone
--bundle-uri option did not suffer from this because the bundles are
downloaded before the server connection begins.

After this series, there is one more before the original scope of the plan
is complete: using creation tokens as a heuristic. See [2] for the RFC
version of those patches.

[2] https://github.com/derrickstolee/git/pull/22


Updates in v2
=============

 * Commit messages now refer to protocol v2 "commands" not "verbs".
 * Several edits were made to gitprotocol-v2.txt thanks to Victoria's
   thorough review.
 * strbuf_parent_directory() is renamed strbuf_strip_file_from_path() to
   make it more clear how it behaves when ending with a slash.

Thanks,

 * Stolee

Derrick Stolee (5):
  bundle-uri: serve bundle.* keys from config
  strbuf: introduce strbuf_strip_file_from_path()
  bundle-uri: allow relative URLs in bundle lists
  bundle-uri: download bundles from an advertised list
  clone: unbundle the advertised bundles

Ævar Arnfjörð Bjarmason (4):
  protocol v2: add server-side "bundle-uri" skeleton
  bundle-uri client: add minimal NOOP client
  bundle-uri client: add helper for testing server
  bundle-uri client: add boolean transfer.bundleURI setting

 Documentation/config/transfer.txt      |   6 +
 Documentation/gitprotocol-v2.txt       | 201 ++++++++++++++++++++++
 builtin/clone.c                        |  23 +++
 bundle-uri.c                           |  91 +++++++++-
 bundle-uri.h                           |  27 +++
 connect.c                              |  47 +++++
 remote.h                               |   5 +
 serve.c                                |   6 +
 strbuf.c                               |   9 +
 strbuf.h                               |  12 ++
 t/helper/test-bundle-uri.c             |  48 ++++++
 t/lib-t5730-protocol-v2-bundle-uri.sh  | 229 +++++++++++++++++++++++++
 t/t5601-clone.sh                       |  59 +++++++
 t/t5701-git-serve.sh                   |  40 ++++-
 t/t5730-protocol-v2-bundle-uri-file.sh |  36 ++++
 t/t5731-protocol-v2-bundle-uri-git.sh  |  17 ++
 t/t5732-protocol-v2-bundle-uri-http.sh |  17 ++
 t/t5750-bundle-uri-parse.sh            |  54 ++++++
 transport-helper.c                     |  13 ++
 transport-internal.h                   |   7 +
 transport.c                            |  87 ++++++++++
 transport.h                            |  23 +++
 22 files changed, 1055 insertions(+), 2 deletions(-)
 create mode 100644 t/lib-t5730-protocol-v2-bundle-uri.sh
 create mode 100755 t/t5730-protocol-v2-bundle-uri-file.sh
 create mode 100755 t/t5731-protocol-v2-bundle-uri-git.sh
 create mode 100755 t/t5732-protocol-v2-bundle-uri-http.sh


base-commit: c03801e19cb8ab36e9c0d17ff3d5e0c3b0f24193
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1400%2Fderrickstolee%2Fbundle-redo%2Fadvertise-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1400/derrickstolee/bundle-redo/advertise-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1400

Range-diff vs v1:

  1:  a02eee98318 !  1:  beae335b855 protocol v2: add server-side "bundle-uri" skeleton
     @@ Commit message
      
          An earlier version of this patch [1] used a different transfer format
          than the "key=value" pairs in the current implementation. The change was
     -    made to unify the protocol v2 verb with the bundle lists provided by
     +    made to unify the protocol v2 command with the bundle lists provided by
          independent bundle servers. Further, the standard allows for the server
          to advertise a URI that contains a bundle list. This allows users
          automatically discovering bundle providers that are loosely associated
     @@ Documentation/gitprotocol-v2.txt: and associated requested information, each sep
      +currently advertise a capability value. Both may be added in the
      +future.
      +
     -+When the client issues a `command=bundle-uri` the response is a list of
     -+key-value pairs provided as packet lines with value `<key>=<value>`. The
     -+meaning of these key-value pairs are provided by the config keys in the
     -+`bundle.*` namespace (see linkgit:git-config[1]).
     ++When the client issues a `command=bundle-uri` request, the response is a
     ++list of key-value pairs provided as packet lines with value
     ++`<key>=<value>`. Each `<key>` should be interpreted as a config key from
     ++the `bundle.*` namespace to construct a list of bundles. These keys are
     ++grouped by a `bundle.<id>.` subsection, where each key corresponding to a
     ++given `<id>` contributes attributes to the bundle defined by that `<id>`.
     ++See linkgit:git-config[1] for the specific details of these keys and how
     ++the Git client will interpret their values.
      +
     -+Clients are still expected to fully parse the line according to the
     -+above format, lines that do not conform to the format SHOULD be
     -+discarded. The user MAY be warned in such a case.
     ++Clients MUST parse the line according to the above format, lines that do
     ++not conform to the format SHOULD be discarded. The user MAY be warned in
     ++such a case.
      +
      +bundle-uri CLIENT AND SERVER EXPECTATIONS
      +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
      +
      +URI CONTENTS::
     -+The advertised URIs MUST be in one of two possible formats.
     ++The content at the advertised URIs MUST be one of two types.
      ++
     -+The first possible format is a bundle file that `git bundle verify`
     ++The advertised URI may contain a bundle file that `git bundle verify`
      +would accept. I.e. they MUST contain one or more reference tips for
      +use by the client, MUST indicate prerequisites (in any) with standard
      +"-" prefixes, and MUST indicate their "object-format", if
     -+applicable. Create "*.bundle" files with `git bundle create`.
     ++applicable.
      ++
     -+The second possible format is a plaintext file that `git config --list`
     -+would accept (with the `--file` option). The key-value pairs in this list
     -+are in the `bundle.*` namespace (see linkgit:git-config[1]).
     ++The advertised URI may alternatively contain a plaintext file that `git
     ++config --list` would accept (with the `--file` option). The key-value
     ++pairs in this list are in the `bundle.*` namespace (see
     ++linkgit:git-config[1]).
      +
      +bundle-uri CLIENT ERROR RECOVERY::
      +A client MUST above all gracefully degrade on errors, whether that
     @@ Documentation/gitprotocol-v2.txt: and associated requested information, each sep
      +WHEN ADVERTISED BUNDLE(S) REQUIRE NO FURTHER NEGOTIATION::
      +If after issuing `bundle-uri` and `ls-refs`, and getting the header(s)
      +of the bundle(s) the client finds that the ref tips it wants can be
     -+retrieved entirety from advertised bundle(s), it MAY disconnect. The
     -+results of such a 'clone' or 'fetch' should be indistinguishable from
     -+the state attained without using bundle-uri.
     ++retrieved entirely from advertised bundle(s), the client MAY disconnect
     ++from the Git server. The results of such a 'clone' or 'fetch' should be
     ++indistinguishable from the state attained without using bundle-uri.
      +
      +EARLY CLIENT DISCONNECTIONS AND ERROR RECOVERY::
      +A client MAY perform an early disconnect while still downloading the
     @@ Documentation/gitprotocol-v2.txt: and associated requested information, each sep
      +bundle-uri PROTOCOL FEATURES
      +^^^^^^^^^^^^^^^^^^^^^^^^^^^^
      +
     -+As noted above the `<key>=<value>` definitions are documented by the
     -+`bundle.*` config namespace.
     ++The client constructs a bundle list from the `<key>=<value>` pairs
     ++provided by the server. These pairs are part of the `bundle.*` namespace
     ++as documented in linkgit:git-config[1]. In this section, we discuss some
     ++of these keys and describe the actions the client will do in response to
     ++this information.
      +
      +In particular, the `bundle.version` key specifies an integer value. The
      +only accepted value at the moment is `1`, but if the client sees an
  2:  64dd9bf41de =  2:  0d85aef965d bundle-uri client: add minimal NOOP client
  3:  ae0003bb39b =  3:  c3269a24b57 bundle-uri client: add helper for testing server
  4:  431cd585184 =  4:  cd906f6d981 bundle-uri: serve bundle.* keys from config
  5:  c877f7c033d =  5:  93397468931 bundle-uri client: add boolean transfer.bundleURI setting
  6:  2200a70d279 !  6:  7d86852c015 strbuf: reintroduce strbuf_parent_directory()
     @@ Metadata
      Author: Derrick Stolee <derrickstolee@github.com>
      
       ## Commit message ##
     -    strbuf: reintroduce strbuf_parent_directory()
     +    strbuf: introduce strbuf_strip_file_from_path()
      
          The strbuf_parent_directory() method was added as a static method in
          contrib/scalar by d0feac4e8c0 (scalar: 'register' sets recommended
     @@ Commit message
          65f6a9eb0b9 (scalar: constrain enlistment search, 2022-08-18), but now
          there is a need for a similar method in the bundle URI feature.
      
     -    Re-add the method, this time in strbuf.c. The method requirements are
     -    slightly modified to allow a trailing slash, in which case nothing is
     -    done. The return value is the number of byte removed.
     +    Re-add the method, this time in strbuf.c, but with a new name:
     +    strbuf_strip_file_from_path(). The method requirements are slightly
     +    modified to allow a trailing slash, in which case nothing is done, which
     +    makes the name change valuable. The return value is the number of bytes
     +    removed.
      
          Signed-off-by: Derrick Stolee <derrickstolee@github.com>
      
     @@ strbuf.c: int strbuf_edit_interactively(struct strbuf *buffer, const char *path,
       	return res;
       }
      +
     -+size_t strbuf_parent_directory(struct strbuf *buf)
     ++size_t strbuf_strip_file_from_path(struct strbuf *buf)
      +{
      +	size_t len = buf->len;
      +	size_t offset = offset_1st_component(buf->buf);
      +	char *path_sep = find_last_dir_sep(buf->buf + offset);
     -+	strbuf_setlen(buf, path_sep ? path_sep - buf->buf : offset);
     ++	strbuf_setlen(buf, path_sep ? path_sep - buf->buf + 1 : offset);
      +	return len - buf->len;
      +}
      
     @@ strbuf.h: int launch_sequence_editor(const char *path, struct strbuf *buffer,
       			      const char *const *env);
       
      +/*
     -+ * Remove the deepest subdirectory in the provided path string. If path
     ++ * Remove the filename from the provided path string. If the path
      + * contains a trailing separator, then the path is considered a directory
     -+ * and nothing is modified.
     ++ * and nothing is modified. Returns the number of characters removed from
     ++ * the path.
     ++ *
     ++ * Examples:
     ++ * - "/path/to/file" -> "/path/to/" (returns: 4)
     ++ * - "/path/to/dir/" -> "/path/to/dir/" (returns: 0)
      + */
     -+size_t strbuf_parent_directory(struct strbuf *buf);
     ++size_t strbuf_strip_file_from_path(struct strbuf *buf);
      +
       void strbuf_add_lines(struct strbuf *sb,
       		      const char *prefix,
  7:  3550f6fb91b !  7:  186e112d821 bundle-uri: allow relative URLs in bundle lists
     @@ bundle-uri.c: int bundle_uri_parse_config_format(const char *uri,
      +		 * remove the filename portion of the path. This is
      +		 * important for relative URIs.
      +		 */
     -+		strbuf_parent_directory(&baseURI);
     ++		strbuf_strip_file_from_path(&baseURI);
      +		list->baseURI = strbuf_detach(&baseURI, NULL);
      +	}
       	result = git_config_from_file_with_options(config_to_bundle_list,
  8:  e002affe4bf !  8:  f254da46a2c bundle-uri: download bundles from an advertised list
     @@ Commit message
      
          The logic in fetch_bundle_uri() is useful for the --bundle-uri option of
          'git clone', but is not helpful when the clone operation discovers a
     -    list of URIs from the bundle-uri protocol v2 verb. To actually download
     -    and unbundle the advertised bundles, we need a different mechanism.
     +    list of URIs from the bundle-uri protocol v2 command. To actually
     +    download and unbundle the advertised bundles, we need a different
     +    mechanism.
      
          Create the new fetch_bundle_list() method which is very similar to
          fetch_bundle_uri() except that it relies on download_bundle_list()
  9:  1c034bba744 !  9:  b62b4b17481 clone: unbundle the advertised bundles
     @@ Commit message
          clone: unbundle the advertised bundles
      
          A previous change introduced the transport methods to acquire a bundle
     -    list from the 'bundle-uri' protocol v2 verb, when advertised _and_ when
     -    the client has chosen to enable the feature.
     +    list from the 'bundle-uri' protocol v2 command, when advertised _and_
     +    when the client has chosen to enable the feature.
      
          Teach Git to download and unbundle the data advertised by those bundles
          during 'git clone'.

-- 
gitgitgadget
