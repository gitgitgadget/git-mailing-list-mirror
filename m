Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40177C433EF
	for <git@archiver.kernel.org>; Wed, 10 Nov 2021 23:51:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1691461215
	for <git@archiver.kernel.org>; Wed, 10 Nov 2021 23:51:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234261AbhKJXyV (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Nov 2021 18:54:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234172AbhKJXyU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Nov 2021 18:54:20 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33931C061766
        for <git@vger.kernel.org>; Wed, 10 Nov 2021 15:51:32 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id c71-20020a1c9a4a000000b0032cdcc8cbafso3155621wme.3
        for <git@vger.kernel.org>; Wed, 10 Nov 2021 15:51:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=+5DFOemYkcczo+Eqz4btwop4LNVvCVBridc6aaGMpGQ=;
        b=WmLphNFdW5ssqQBT029+8VWYPqr95i3n8v2fMG4Fqx8QXg4xApdAQtSf370J7opvGu
         UYIOXeCR6G6OUZRTvLOcAbi305imfLQ/XxHo9s0FPKIQdRtPIcN36T58RTY+GaeNW1z3
         lo3XNHxfO7in+ukxPGUzBp/ZQn7r6SJVHuGGRV+wvbFkiNgr8pdirb/swJKvUn06wQe2
         cWRWNZGxy0B7RVK4szmuC+fgI7y2GTy+ZqFmoRyfj9aulXsHyyihxc7ijNNrL1gOPTeN
         bUaF2bDhJqE1Jlz+cOR0frfWSmmZZX+vZnejPF94tRgcQeI7XQXLu+MHjtLBY+Qzb9r2
         bU8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=+5DFOemYkcczo+Eqz4btwop4LNVvCVBridc6aaGMpGQ=;
        b=dg8Ca9E0x3xuN671KLV4bwC31ycbffACn72k00mH5psc1pq7CJuAQ6r/knlQ1dJczS
         A+v731YuiTnht55Y9pPm7BpYv3ZRJw5Fc39hcElW/61sdctOjqPNnnqv+fXR5EcXFs/1
         oVr1F+qY9Ee1+2mWVz5XVxBBTYYRayN3HQdVQtpvJuqOHjeMiglUM6YXgIv03dBUXFSI
         MaYSFyXHZG1SBKbKbFDv3d3FzQi0Bk9fFo7ZpwrVknqJYBkgQciIhqScfFgX4z2LMIDw
         ibjWhlnm6smLjLhamTk6ZGxsad/hMm99yq+iVhzn2yBltKVcs9QDW7j1/Hx4P8m0rYSE
         bf2g==
X-Gm-Message-State: AOAM533nSfDwaF6KKVBjg24ncSeIsZS6fSeMG4A+b7XRk/8wHc6BUJfW
        7EWA3nNnfY7gRTVq0/M6E9gxx0yd9lE=
X-Google-Smtp-Source: ABdhPJyw5YaU0LNyE5Vw78KBK80+jWcqSkdiLU0gLYRfGs4InjBCvXrNf31d3GV94VICnYSGF3o7Vg==
X-Received: by 2002:a7b:c770:: with SMTP id x16mr21582804wmk.66.1636588290684;
        Wed, 10 Nov 2021 15:51:30 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f15sm1198737wrt.26.2021.11.10.15.51.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Nov 2021 15:51:30 -0800 (PST)
Message-Id: <pull.1052.v7.git.1636588289.gitgitgadget@gmail.com>
In-Reply-To: <pull.1052.v6.git.1635532975.gitgitgadget@gmail.com>
References: <pull.1052.v6.git.1635532975.gitgitgadget@gmail.com>
From:   "Ivan Frade via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 10 Nov 2021 23:51:27 +0000
Subject: [PATCH v7 0/2] fetch-pack: redact packfile urls in traces
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Ivan Frade <ifrade@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Changes since v6:

 * Use specific hash sizes instead of hexsz
 * Remove unnecessary env vars in tests
 * Added comment on bit toggle

Changes since v5:

 * Use hexsz instead of hardcoded hash sizes

Changes since v4:

 * Use "uri" instead of "url"
 * Look specifically for a line with packfile-uri format (instead of for a
   URL in general)
 * Limit the redacting to the packfile-uri section in do_fetch_pack_v2
 * Use "%.*s" instead of duplicating parts of the string to print

Changes since v3:

 * Enable redacting URLs for all sections
 * Redact only URL path (it was until the end of line)
 * Redact URL in die() with more friendly message
 * Update doc to mention that packfile URIs are also redacted.

Changes since v2:

 * Redact only the path of the URL
 * Test are now strict, validating the exact line expected in the log

Changes since v1:

 * Removed non-POSIX flags in tests
 * More accurate regex for the non-encrypted packfile line
 * Dropped documentation change
 * Dropped redacting the die message in http-fetch

Ivan Frade (2):
  fetch-pack: redact packfile urls in traces
  http-fetch: redact url on die() message

 Documentation/git.txt  |  5 +++--
 fetch-pack.c           |  5 +++++
 http-fetch.c           | 14 ++++++++++--
 pkt-line.c             | 40 ++++++++++++++++++++++++++++++++-
 pkt-line.h             |  1 +
 t/t5702-protocol-v2.sh | 51 ++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 111 insertions(+), 5 deletions(-)


base-commit: 88d915a634b449147855041d44875322de2b286d
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1052%2Fifradeo%2Fredact-packfile-uri-v7
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1052/ifradeo/redact-packfile-uri-v7
Pull-Request: https://github.com/gitgitgadget/git/pull/1052

Range-diff vs v6:

 1:  a6098f98946 ! 1:  bbfdc346ede fetch-pack: redact packfile urls in traces
     @@ fetch-pack.c: static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
      +				reader.options |= PACKET_READ_REDACT_URI_PATH;
       			if (process_section_header(&reader, "packfile-uris", 1))
       				receive_packfile_uris(&reader, &packfile_uris);
     ++			/* We don't expect more URIs. Reset to avoid expensive URI check. */
      +			reader.options &= ~PACKET_READ_REDACT_URI_PATH;
      +
       			process_section_header(&reader, "packfile", 0);
     @@ pkt-line.c: int packet_length(const char lenbuf_hex[4])
      +	buffer += 1;
      +
      +	len = strspn(buffer, "0123456789abcdefABCDEF");
     -+	if (len != (int)the_hash_algo->hexsz || buffer[len] != ' ')
     ++	/* size of SHA1 and SHA256 hash */
     ++	if (!(len == 40 || len == 64) || buffer[len] != ' ')
      +		return NULL; /* required "<hash>SP" not seen */
      +
      +	path = strstr(buffer + len + 1, URI_MARK);
     @@ t/t5702-protocol-v2.sh: test_expect_success 'packfile-uri with transfer.fsckobje
      +		"uploadpack.blobpackfileuri" \
      +		"$(cat objh) $(cat packh) $HTTPD_URL/dumb/mypack-$(cat packh).pack" &&
      +
     -+	GIT_TRACE=1 GIT_TRACE_PACKET="$(pwd)/log" GIT_TEST_SIDEBAND_ALL=1 \
     ++	GIT_TRACE_PACKET="$(pwd)/log" \
      +	git -c protocol.version=2 \
      +		-c fetch.uriprotocols=http,https \
      +		clone "$HTTPD_URL/smart/http_parent" http_child &&
     @@ t/t5702-protocol-v2.sh: test_expect_success 'packfile-uri with transfer.fsckobje
      +		"uploadpack.blobpackfileuri" \
      +		"$(cat objh) $(cat packh) $HTTPD_URL/dumb/mypack-$(cat packh).pack" &&
      +
     -+	GIT_TRACE=1 GIT_TRACE_PACKET="$(pwd)/log" GIT_TEST_SIDEBAND_ALL=1 \
     ++	GIT_TRACE_PACKET="$(pwd)/log" \
      +	GIT_TRACE_REDACT=0 \
      +	git -c protocol.version=2 \
      +		-c fetch.uriprotocols=http,https \
 2:  38859ae7b7d = 2:  3b210735bc8 http-fetch: redact url on die() message

-- 
gitgitgadget
