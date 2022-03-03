Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D0EFC433F5
	for <git@archiver.kernel.org>; Thu,  3 Mar 2022 16:41:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235103AbiCCQmn (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Mar 2022 11:42:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235094AbiCCQmm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Mar 2022 11:42:42 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5966819D747
        for <git@vger.kernel.org>; Thu,  3 Mar 2022 08:41:56 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id y11so6850970eda.12
        for <git@vger.kernel.org>; Thu, 03 Mar 2022 08:41:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=GmMYDqAB/U3IP7oiCQ5EsfSUCbjGtfXzSK6D9+hJxNk=;
        b=YKQQkLgZSUh5n9K7NP0yGs7jonTbWe3PA7KA+zCzr/wNgsIlaktbXOeeL42nEZSmjr
         /PRRfWW52wA4MJeVNlzO5nZT1n6ZMxE8q1a95dAKEAsRnB2tJXEgF/+bFUePGafqzuQS
         BI9X8dCp7ESGQgemMVrikTEb/pgnrfE4PAAaAZHwpNTNacgtEC6/3GzjhZIvtv4cmvFh
         v8FOk20UlmEiayHjFBJR1xFFhSinLPbn0891kQdXhkgax1Kl8fqPjOVqQ4Fq5Q4VJmRh
         z5mEn1D5WmzXrlZDZiovc4pHJEmbHFXnZ/Q6TTvSy2W5v3EFKdckSYOY7sAP7mOC/PY8
         iEmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=GmMYDqAB/U3IP7oiCQ5EsfSUCbjGtfXzSK6D9+hJxNk=;
        b=g37rtJiLqujtnWlThCkIyypxsdjFThkA5CBete0mRYMhQzH3t/jbcbclezz8gdCgYV
         Qsvl9qk7kzz+WJ4M/CecewghH7nXkyTnczPZB/FTWSAKYTQ+SXymBVIqJKJfJrWkLfMc
         hWZtQn1ntsLWnjjAPLFApcTefrZEq5m39hynAXb6Qa1uxO6vU1vTWFIiibcLkUZn+i2P
         UGUQ3i89X89ktIApE1oslx+mQA9IE6vbs+Hmy7uOT0QBQtykakVtYkXFQ5ynG1re7bzn
         FYrjOpcsgoQpFnB5X/cdrog9YJ4WdWgljBwpMhe+T70b1T9MfeLJo8AgTDe8mlYd28H1
         NkBQ==
X-Gm-Message-State: AOAM531WJuu/rtdT0QQbHx977HuzFb55s8BbuQvhT/aTjqT+/0h6M+VZ
        swZUVHvI4JCzaunRxJ78lTU=
X-Google-Smtp-Source: ABdhPJzaa9in88kjcewmFyxJY+uS8xJmwSj2md9gGfObxtfNZhhqVGIxFS8TtlG44W9uqNhpaOMM6g==
X-Received: by 2002:a50:a6da:0:b0:415:d7a5:3e02 with SMTP id f26-20020a50a6da000000b00415d7a53e02mr4396668edc.137.1646325714714;
        Thu, 03 Mar 2022 08:41:54 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id lb14-20020a170907784e00b006d5c0baa503sm845302ejc.110.2022.03.03.08.41.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Mar 2022 08:41:53 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nPoWX-000eJw-59;
        Thu, 03 Mar 2022 17:41:53 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, tytso@mit.edu, derrickstolee@github.com,
        gitster@pobox.com, larsxschneider@gmail.com
Subject: Re: [PATCH v3 04/17] chunk-format.h: extract oid_version()
Date:   Thu, 03 Mar 2022 17:30:44 +0100
References: <cover.1638224692.git.me@ttaylorr.com>
 <cover.1646266835.git.me@ttaylorr.com>
 <135a07276b0a40b04f2c28d4f48c26b1af76c12c.1646266835.git.me@ttaylorr.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <135a07276b0a40b04f2c28d4f48c26b1af76c12c.1646266835.git.me@ttaylorr.com>
Message-ID: <220303.86ilsv2dke.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Mar 02 2022, Taylor Blau wrote:

> Consolidate these into a single definition in chunk-format.h. It's not
> clear that this is the best header to define this function in, but it
> should do for now.
> [...]
> +
> +uint8_t oid_version(const struct git_hash_algo *algop)
> +{
> +	switch (hash_algo_by_ptr(algop)) {
> +	case GIT_HASH_SHA1:
> +		return 1;
> +	case GIT_HASH_SHA256:
> +		return 2;

Not a new issue, but I wonder why these don't return hash_algo_by_ptr
aka GIT_HASH_WHATEVER here. I.e. this is the same as this more
straightforward & obvious code that avoids re-hardcoding the magic
constants:

	const int algo = hash_algo_by_ptr(algop)

	switch (algo) {
	case GIT_HASH_SHA1:
	case GIT_HASH_SHA256:
		return algo;
	default:
        [...]
        }

Probably best left as a later cleanup. FWIW I came up with this on top
of my designated init series:

diff --git a/hash.h b/hash.h
index 5d40368f18a..fd710ec6ae8 100644
--- a/hash.h
+++ b/hash.h
@@ -86,14 +86,18 @@ static inline void git_SHA256_Clone(git_SHA256_CTX *dst, const git_SHA256_CTX *s
  * field for being non-zero.  Use the name field for user-visible situations and
  * the format_id field for fixed-length fields on disk.
  */
-/* An unknown hash function. */
-#define GIT_HASH_UNKNOWN 0
-/* SHA-1 */
-#define GIT_HASH_SHA1 1
-/* SHA-256  */
-#define GIT_HASH_SHA256 2
-/* Number of algorithms supported (including unknown). */
-#define GIT_HASH_NALGOS (GIT_HASH_SHA256 + 1)
+enum git_hash_algo_name {
+	/* An unknown hash function. */
+	GIT_HASH_UNKNOWN,
+	/* SHA-1 */
+	GIT_HASH_SHA1,
+	GIT_HASH_SHA256,
+	/*
+	 * Number of algorithms supported (including unknown). This
+	 * must be kept last!
+	 */
+	GIT_HASH_NALGOS,
+};
 
 /* "sha1", big-endian */
 #define GIT_SHA1_FORMAT_ID 0x73686131
diff --git a/object-file.c b/object-file.c
index 5074471b471..f2d54a86969 100644
--- a/object-file.c
+++ b/object-file.c
@@ -166,7 +166,7 @@ static void git_hash_unknown_final_oid(struct object_id *oid, git_hash_ctx *ctx)
 }
 
 const struct git_hash_algo hash_algos[GIT_HASH_NALGOS] = {
-	{
+	[GIT_HASH_UNKNOWN] = {
 		.name = NULL,
 		.format_id = 0x00000000,
 		.rawsz = 0,
@@ -181,7 +181,7 @@ const struct git_hash_algo hash_algos[GIT_HASH_NALGOS] = {
 		.empty_blob = NULL,
 		.null_oid = NULL,
 	},
-	{
+	[GIT_HASH_SHA1] = {
 		.name = "sha1",
 		.format_id = GIT_SHA1_FORMAT_ID,
 		.rawsz = GIT_SHA1_RAWSZ,
@@ -196,7 +196,7 @@ const struct git_hash_algo hash_algos[GIT_HASH_NALGOS] = {
 		.empty_blob = &empty_blob_oid,
 		.null_oid = &null_oid_sha1,
 	},
-	{
+	[GIT_HASH_SHA256] = {
 		.name = "sha256",
 		.format_id = GIT_SHA256_FORMAT_ID,
 		.rawsz = GIT_SHA256_RAWSZ,
