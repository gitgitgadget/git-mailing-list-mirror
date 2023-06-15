Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 872DCEB64D9
	for <git@archiver.kernel.org>; Thu, 15 Jun 2023 19:19:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231215AbjFOTTk (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Jun 2023 15:19:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229767AbjFOTTi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Jun 2023 15:19:38 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E11C1FCC
        for <git@vger.kernel.org>; Thu, 15 Jun 2023 12:19:37 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-3f8cec6641bso23993005e9.1
        for <git@vger.kernel.org>; Thu, 15 Jun 2023 12:19:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686856775; x=1689448775;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jdSgQ3kIXFP4oTwi/5/aX8etkKyyf8SklE8j582x2jM=;
        b=gxNop3MvqMJ+AYSeawWpILl+fdBeKc9IVxHPEzbaSMsHwfzhA/E0IIpg66N8x31ugi
         hb+l39qz9jmLn4UnqEoqIqZ4sXF1+V8e/9yrZ4SfP+nYIFjO7hkgayy0hGVLyeH6a9qa
         vvaYuCT5Vpxyeeb3XskRhdQa8xF/wFQJdC7Xi98QaOKP7bfrFDMnRTdv0RQ4fFc0uacr
         IFElayg+MOYdngS2atFsxtCOOhfJUGLC12VwHvR/tUWf6/AesbPsZ46s4j1T0T/EnAH4
         LeE7aCh8sT9SsTt9EXiKc3QvDMPAc5yrQbzQdSWUCZofo0b80LDX0DqlkNX970izl7GF
         Eseg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686856775; x=1689448775;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jdSgQ3kIXFP4oTwi/5/aX8etkKyyf8SklE8j582x2jM=;
        b=J3pMlTzoteZtmyyMO+M27XTv3IQcLbHf1Vq5hfstmAWao4fMusfEPaRK49K90v2ecu
         P3GOm+ZVGDjGvh81UNMgoSJHdK7smCiJfbUlODAcdsSAbO4sEPcpatyJoJUUt0PdEJjl
         X9a6ZF3qO9yjvO1YNF6fNG4rOEEHpArSncsDivIX+CHgbI4jsV3Exbbx7z13IYYYExKU
         LoXIA9FDfVnvh/D6QFZ3UdkbxBHvFL3sY1BxNN6OWRqvOM+vz8nwaO7so9p7l+W8gffZ
         8cL9p87R7zHPricWPQBIUcEQEyJMk83VJjJacQGhiHEmiKNkANHRldEfv9e5iE2UY0Q2
         gP0A==
X-Gm-Message-State: AC+VfDzM1/Xuc+OpnOd/SrHZdKDJnNtcbBuX6LTfRJVWsRK4rdKFmPdH
        RWefZZQwxw6dE5R1K1MX7Pim9o2Vvmc=
X-Google-Smtp-Source: ACHHUZ5MS9uvgJl2S355e5o2fJVarr3CTDkeMqJJRqUObZX4k1WsFxPWwaxveTL15R4slA+08VQt3A==
X-Received: by 2002:a05:600c:2042:b0:3f6:6da:3ad1 with SMTP id p2-20020a05600c204200b003f606da3ad1mr127457wmg.34.1686856775038;
        Thu, 15 Jun 2023 12:19:35 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q12-20020a05600c040c00b003f8ec58995fsm42111wmb.6.2023.06.15.12.19.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jun 2023 12:19:34 -0700 (PDT)
Message-Id: <pull.1525.v4.git.git.1686856773.gitgitgadget@gmail.com>
In-Reply-To: <pull.1525.v3.git.git.1686809004.gitgitgadget@gmail.com>
References: <pull.1525.v3.git.git.1686809004.gitgitgadget@gmail.com>
From:   "M Hickford via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 15 Jun 2023 19:19:31 +0000
Subject: [PATCH v4 0/2] credential: improvements to erase in helpers
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        Matthew John Cheetham <mjcheetham@outlook.com>,
        M Hickford <mirth.hickford@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

M Hickford (2):
  credential: avoid erasing distinct password
  credential: erase all matching credentials

 Documentation/git-credential.txt   |   2 +-
 Documentation/gitcredentials.txt   |   2 +-
 builtin/credential-cache--daemon.c |  17 +++--
 builtin/credential-store.c         |  15 +++--
 credential.c                       |   7 +-
 credential.h                       |   2 +-
 t/lib-credential.sh                | 103 +++++++++++++++++++++++++++++
 7 files changed, 128 insertions(+), 20 deletions(-)


base-commit: d7d8841f67f29e6ecbad85a11805c907d0f00d5d
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1525%2Fhickford%2Ferase-test-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1525/hickford/erase-test-v4
Pull-Request: https://github.com/git/git/pull/1525

Range-diff vs v3:

 1:  df3c8a15bf8 ! 1:  91d4b04b5e1 credential: avoid erasing distinct password
     @@ builtin/credential-store.c: static struct lock_file credential_lock;
       	FILE *fh;
       	struct strbuf line = STRBUF_INIT;
      @@ builtin/credential-store.c: static int parse_credential_file(const char *fn,
     - 
       	while (strbuf_getline_lf(&line, fh) != EOF) {
       		if (!credential_from_url_gently(&entry, line.buf, 1) &&
     --		    entry.username && entry.password &&
     + 		    entry.username && entry.password &&
      -		    credential_match(c, &entry)) {
     -+			entry.username && entry.password &&
     -+			credential_match(c, &entry, match_password)) {
     ++		    credential_match(c, &entry, match_password)) {
       			found_credential = 1;
       			if (match_cb) {
       				match_cb(&entry);
     @@ credential.c: void credential_clear(struct credential *c)
       {
       #define CHECK(x) (!want->x || (have->x && !strcmp(want->x, have->x)))
       	return CHECK(protocol) &&
     --	       CHECK(host) &&
     --	       CHECK(path) &&
     + 	       CHECK(host) &&
     + 	       CHECK(path) &&
      -	       CHECK(username);
     -+		CHECK(host) &&
     -+		CHECK(path) &&
     -+		CHECK(username) &&
     -+		(!match_password || CHECK(password));
     ++	       CHECK(username) &&
     ++	       (!match_password || CHECK(password));
       #undef CHECK
       }
       
     @@ t/lib-credential.sh: helper_test_clean() {
       	reject $1 https example.com user1
       	reject $1 https example.com user2
       	reject $1 https example.com user4
     -+	reject $1 https example.com user5
     -+	reject $1 https example.com user8
     ++	reject $1 https example.com user-distinct-pass
     ++	reject $1 https example.com user-overwrite
       	reject $1 http path.tld user
       	reject $1 https timeout.tld user
       	reject $1 https sso.tld
     @@ t/lib-credential.sh: helper_test() {
      +		check approve $HELPER <<-\EOF &&
      +		protocol=https
      +		host=example.com
     -+		username=user8
     ++		username=user-overwrite
      +		password=pass1
      +		EOF
      +		check approve $HELPER <<-\EOF &&
      +		protocol=https
      +		host=example.com
     -+		username=user8
     ++		username=user-overwrite
      +		password=pass2
      +		EOF
      +		check fill $HELPER <<-\EOF &&
      +		protocol=https
      +		host=example.com
     -+		username=user8
     ++		username=user-overwrite
      +		--
      +		protocol=https
      +		host=example.com
     -+		username=user8
     ++		username=user-overwrite
      +		password=pass2
      +		EOF
      +		check reject $HELPER <<-\EOF &&
      +		protocol=https
      +		host=example.com
     -+		username=user8
     ++		username=user-overwrite
      +		password=pass2
      +		EOF
      +		check fill $HELPER <<-\EOF
      +		protocol=https
      +		host=example.com
     -+		username=user8
     ++		username=user-overwrite
      +		--
      +		protocol=https
      +		host=example.com
     -+		username=user8
     ++		username=user-overwrite
      +		password=askpass-password
      +		--
     -+		askpass: Password for '\''https://user8@example.com'\'':
     ++		askpass: Password for '\''https://user-overwrite@example.com'\'':
      +		EOF
      +	'
      +
     @@ t/lib-credential.sh: helper_test() {
      +		check approve $HELPER <<-\EOF &&
      +		protocol=https
      +		host=example.com
     -+		username=user5
     ++		username=user-distinct-pass
      +		password=pass1
      +		EOF
      +		check reject $HELPER <<-\EOF &&
      +		protocol=https
      +		host=example.com
     -+		username=user5
     ++		username=user-distinct-pass
      +		password=pass2
      +		EOF
      +		check fill $HELPER <<-\EOF
      +		protocol=https
      +		host=example.com
     -+		username=user5
     ++		username=user-distinct-pass
      +		--
      +		protocol=https
      +		host=example.com
     -+		username=user5
     ++		username=user-distinct-pass
      +		password=pass1
      +		EOF
      +	'
 2:  e06d80e99a0 ! 2:  42f41b28e6e credential: erase all matching credentials
     @@ Commit message
      
          `credential reject` sends the erase action to each helper, but the
          exact behaviour of erase isn't specified in documentation or tests.
     -    Some helpers (such as credential-libsecret) delete all matching
     -    credentials, others (such as credential-cache and credential-store)
     -    delete at most one matching credential.
     +    Some helpers (such as credential-store and credential-libsecret) delete
     +    all matching credentials, others (such as credential-cache) delete at
     +    most one matching credential.
      
          Test that helpers erase all matching credentials. This behaviour is
          easiest to reason about. Users expect that `echo
     @@ Commit message
          "url=https://example.com\nusername=tim" | git credential reject` erase
          all matching credentials.
      
     -    Fix credential-cache and credential-store.
     +    Fix credential-cache.
      
          Signed-off-by: M Hickford <mirth.hickford@gmail.com>
      
     @@ builtin/credential-cache--daemon.c: static void serve_one_client(FILE *in, FILE
       			fprintf(out, "username=%s\n", e->item.username);
       			fprintf(out, "password=%s\n", e->item.password);
      
     - ## builtin/credential-store.c ##
     -@@ builtin/credential-store.c: static int parse_credential_file(const char *fn,
     - 			found_credential = 1;
     - 			if (match_cb) {
     - 				match_cb(&entry);
     --				break;
     - 			}
     - 		}
     - 		else if (other_cb)
     -
       ## t/lib-credential.sh ##
      @@ t/lib-credential.sh: helper_test_clean() {
     - 	reject $1 https example.com user2
       	reject $1 https example.com user4
     - 	reject $1 https example.com user5
     -+	reject $1 https example.com user6
     -+	reject $1 https example.com user7
     - 	reject $1 https example.com user8
     + 	reject $1 https example.com user-distinct-pass
     + 	reject $1 https example.com user-overwrite
     ++	reject $1 https example.com user-erase1
     ++	reject $1 https example.com user-erase2
       	reject $1 http path.tld user
       	reject $1 https timeout.tld user
     + 	reject $1 https sso.tld
      @@ t/lib-credential.sh: helper_test() {
       		EOF
       	'
     @@ t/lib-credential.sh: helper_test() {
      +		check approve $HELPER <<-\EOF &&
      +		protocol=https
      +		host=example.com
     -+		username=user6
     ++		username=user-erase1
      +		password=pass1
      +		EOF
      +		check approve $HELPER <<-\EOF &&
      +		protocol=https
      +		host=example.com
     -+		username=user7
     ++		username=user-erase2
      +		password=pass1
      +		EOF
      +		check reject $HELPER <<-\EOF &&

-- 
gitgitgadget
