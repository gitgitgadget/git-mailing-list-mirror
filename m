Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F4CFC433FE
	for <git@archiver.kernel.org>; Fri, 29 Oct 2021 18:42:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3557160ED5
	for <git@archiver.kernel.org>; Fri, 29 Oct 2021 18:42:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230189AbhJ2Sp1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Oct 2021 14:45:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230174AbhJ2Sp0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Oct 2021 14:45:26 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0A2AC061767
        for <git@vger.kernel.org>; Fri, 29 Oct 2021 11:42:57 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id d13so17795418wrf.11
        for <git@vger.kernel.org>; Fri, 29 Oct 2021 11:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=oepyab7yHkWDH/1OzQNxj0rcMmZovhgkFH/svjAX3bY=;
        b=Ti7rYkMvOf40s1xChZaOIwI69LfGPvZaikpw0ekgtt9M/5Mif7qD6rQu+waJkSAFl+
         3TCz6YVOwo6NytambHb9yyRikF3MjA+H5MtZ6YG/EhKZvkKkzdACZu/jl43bgFX1AOQC
         Xm3qFXZK/QnO0i5RrVqW1ScxoaLMoid3S+IOl0Q80XhGip5g+R4mIMf/e47rPY5JUZJj
         /XOHLZqpHZWurWVEzcxNqnq0/qHz9KRhbjB3dH9qAbWjkYZs2qNqWpyBzLS818NNwg0Q
         Uer1C+BU3pEGQf7+eFl1Yw+FKfhRf29buVQsDe3h4/GGbsDOJ0w0+3nxl4SwQeSgP4vJ
         JyCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=oepyab7yHkWDH/1OzQNxj0rcMmZovhgkFH/svjAX3bY=;
        b=E9bwUwWAkcOpmzjZ9srtG8Hb8Q37pUSnPvVldn1x7KLY7qxOjcAWfThOy++UMdFdIP
         iUFxAICCi7Q8m2jaTRXEeNufYNmbBIGghPv2f7rGEQrGtgv0Vv4br1p/lMEXjirbyLiz
         oP3HF7bdVWTbnKSPJO/Bz9y+zt4hjMYtKkwKj7Fm/7GKnMGvQA3/e0NNMC33afU19rhQ
         AM04/ts8CR2CTvg+gl8T2TxAJSLtNwu+PuwBiTUtz0uS4lCoWLypzJqaYKBGbi+6rw4E
         qk5mNUW3nWCAww6mqIRs6d/KbkbjQZIUhV0sgU08sFRRF6IEJFJ5LsFNlSnbxqb4ysLm
         Ysqg==
X-Gm-Message-State: AOAM5332UAOC0BfHnlPZlvbzF9skqrzH7CU9RBX24Evisl2uZUg3pqV4
        PVcyhSKmJ/iEOUveTkLoUBV80YJVYZQ=
X-Google-Smtp-Source: ABdhPJwTQ5a6LkyXny6r2k5EM3dp1NGHbekl2Wwl6fUJBJMZup/EskkLnU1rupVYzcvR/La+pEZ4gw==
X-Received: by 2002:adf:b748:: with SMTP id n8mr16283064wre.133.1635532976300;
        Fri, 29 Oct 2021 11:42:56 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q26sm4033973wrc.39.2021.10.29.11.42.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Oct 2021 11:42:56 -0700 (PDT)
Message-Id: <pull.1052.v6.git.1635532975.gitgitgadget@gmail.com>
In-Reply-To: <pull.1052.v5.git.1635461500.gitgitgadget@gmail.com>
References: <pull.1052.v5.git.1635461500.gitgitgadget@gmail.com>
From:   "Ivan Frade via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 29 Oct 2021 18:42:53 +0000
Subject: [PATCH v6 0/2] fetch-pack: redact packfile urls in traces
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        Ivan Frade <ifrade@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

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
 fetch-pack.c           |  4 ++++
 http-fetch.c           | 14 ++++++++++--
 pkt-line.c             | 39 +++++++++++++++++++++++++++++++-
 pkt-line.h             |  1 +
 t/t5702-protocol-v2.sh | 51 ++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 109 insertions(+), 5 deletions(-)


base-commit: e9e5ba39a78c8f5057262d49e261b42a8660d5b9
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1052%2Fifradeo%2Fredact-packfile-uri-v6
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1052/ifradeo/redact-packfile-uri-v6
Pull-Request: https://github.com/gitgitgadget/git/pull/1052

Range-diff vs v5:

 1:  c95b3cafcd6 ! 1:  a6098f98946 fetch-pack: redact packfile urls in traces
     @@ pkt-line.c: int packet_length(const char lenbuf_hex[4])
      +	buffer += 1;
      +
      +	len = strspn(buffer, "0123456789abcdefABCDEF");
     -+	if (!(len == 40 || len == 64) || buffer[len] != ' ')
     ++	if (len != (int)the_hash_algo->hexsz || buffer[len] != ' ')
      +		return NULL; /* required "<hash>SP" not seen */
      +
      +	path = strstr(buffer + len + 1, URI_MARK);
 2:  6912a690197 = 2:  38859ae7b7d http-fetch: redact url on die() message

-- 
gitgitgadget
