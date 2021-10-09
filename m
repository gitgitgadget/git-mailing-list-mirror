Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3CE1C433F5
	for <git@archiver.kernel.org>; Sat,  9 Oct 2021 02:20:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C396761040
	for <git@archiver.kernel.org>; Sat,  9 Oct 2021 02:20:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244170AbhJICWZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Oct 2021 22:22:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231947AbhJICWY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Oct 2021 22:22:24 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD8FEC061570
        for <git@vger.kernel.org>; Fri,  8 Oct 2021 19:20:26 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id e12so35008882wra.4
        for <git@vger.kernel.org>; Fri, 08 Oct 2021 19:20:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=CA0KcTk13ytKp3mnlURIKJ0eVfu04pbvPhiOZjpLhDU=;
        b=HEjbrKtIwjXztDXRPP0hb8wB9MyCh83Ef/dODU0NA75fjXyAlHszQmBf3wsxkerZb1
         78zACBG5VOi+mgN02zwd0uxD0sqHgokodoSoL4bDxoUxCOLV8fqumLEX3/fU+HoO4a50
         1XjairaeuEqDLxAAv1ApIPj/czZgAljP3tF4bAEl4L/3JCcT4eLSyCUTeW+szGyWeIip
         uET0qI6iLTsO6PnVPsGrl9Y6zQBe8wLdcOU9ePnLxH2jRA+ZmIKvDm7UyOBOFSRhQsrY
         qR2jMw2c505fXaYOMIrv18UCub74kqcqWqYVEK4vLbzbGx2Feu3AEUhnvNVCYen3Bwsp
         tZSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=CA0KcTk13ytKp3mnlURIKJ0eVfu04pbvPhiOZjpLhDU=;
        b=TJhYcisbl1/HQaujI6tyRPYaA5xsGVLkr/LxsZifD4/oDPwYFNuGrhMpk694+tUW5S
         0D5CJF2XzcVshQP1h4oSUoz2h/+q2VGWa+KiZjXs5br48qi1fLN/jH4hhKx/rnWZY2L3
         37OjmOMGkuh6o05ie/g7zOAvOWyGbg4sELBYTDtCJCr7UJVM1zBqCrmalNysFK/8NEeg
         EbCdYttD6JCPboNwQJpp7rJds97Vkyq2OsLy85M2cwwKokdqw8+Qxp8jPp+H12P0jQHh
         v5lpmIEI0l4lNmQkS3NwYvMpQNjnvCetrqkK5jg1iF9mgN99gYFyjoKWmVA6J/RwohCh
         Q+uQ==
X-Gm-Message-State: AOAM5332IS+EGPCmhih73K/aZ3pks20CIMk+NAI1dnSmpzfsYY844ipa
        IT78xdCHvET/kxo8Ra5NtWzGTOkWtlc=
X-Google-Smtp-Source: ABdhPJyzjcdI9c6eN4NWzhaD/sXZtak2IyCE5CD3XpmBGEpLbM4Jkk//YIIaWHrLXgcRLK7qKn9bbw==
X-Received: by 2002:a1c:4455:: with SMTP id r82mr7034439wma.100.1633746025290;
        Fri, 08 Oct 2021 19:20:25 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c204sm13745653wme.11.2021.10.08.19.20.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Oct 2021 19:20:25 -0700 (PDT)
Message-Id: <pull.1052.v2.git.1633746024175.gitgitgadget@gmail.com>
In-Reply-To: <pull.1052.git.1633708986.gitgitgadget@gmail.com>
References: <pull.1052.git.1633708986.gitgitgadget@gmail.com>
From:   "Ivan Frade via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 09 Oct 2021 02:20:24 +0000
Subject: [PATCH v2] fetch-pack: redact packfile urls in traces
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Ivan Frade <ifrade@google.com>,
        Ivan Frade <ifrade@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Ivan Frade <ifrade@google.com>

In some setups, packfile uris act as bearer token. It is not
recommended to expose them plainly in logs, although in special
circunstances (e.g. debug) it makes sense to write them.

Redact the packfile-uri lines by default, unless the GIT_TRACE_REDACT
variable is set to false. This mimics the redacting of the
Authorization header in HTTP.

Changes since v1:
- Removed non-POSIX flags in tests
- More accurate regex for the non-encrypted packfile line
- Dropped documentation change
- Dropped redacting the die message in http-fetch

Signed-off-by: Ivan Frade <ifrade@google.com>
---
    fetch-pack: redact packfile urls in traces
    
    In some setups, packfile uris act as bearer token. It is not recommended
    to expose them plainly in logs, although in special circunstances (e.g.
    debug) it makes sense to write them.
    
    Redact the packfile-uri lines by default, unless the GIT_TRACE_REDACT
    variable is set to false. This mimics the redacting of the Authorization
    header in HTTP.
    
    Signed-off-by: Ivan Frade ifrade@google.com
    
    cc: Ævar Arnfjörð Bjarmason avarab@gmail.com

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1052%2Fifradeo%2Fredact-packfile-uri-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1052/ifradeo/redact-packfile-uri-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1052

Range-diff vs v1:

 1:  b473f145a87 ! 1:  701cb7a6ab9 fetch-pack: redact packfile urls in traces
     @@ Commit message
          variable is set to false. This mimics the redacting of the
          Authorization header in HTTP.
      
     +    Changes since v1:
     +    - Removed non-POSIX flags in tests
     +    - More accurate regex for the non-encrypted packfile line
     +    - Dropped documentation change
     +    - Dropped redacting the die message in http-fetch
     +
          Signed-off-by: Ivan Frade <ifrade@google.com>
      
       ## fetch-pack.c ##
     @@ fetch-pack.c: static void receive_packfile_uris(struct packet_reader *reader,
       		die("expected DELIM");
       }
      
     - ## http-fetch.c ##
     -@@ http-fetch.c: static void fetch_single_packfile(struct object_id *packfile_hash,
     - 	if (start_active_slot(preq->slot)) {
     - 		run_active_slot(preq->slot);
     - 		if (results.curl_result != CURLE_OK) {
     --			die("Unable to get pack file %s\n%s", preq->url,
     -+			int showUrl = git_env_bool("GIT_TRACE_REDACT", 1);
     -+			die("Unable to get offloaded pack file %s\n%s",
     -+			    showUrl ? preq->url : "<redacted>",
     - 			    curl_errorstr);
     - 		}
     - 	} else {
     -
       ## pkt-line.c ##
      @@ pkt-line.c: enum packet_read_status packet_read_with_status(int fd, char **src_buffer,
       		len--;
     @@ t/t5702-protocol-v2.sh: test_expect_success 'packfile-uri with transfer.fsckobje
      +		-c fetch.uriprotocols=http,https \
      +		clone "$HTTPD_URL/smart/http_parent" http_child &&
      +
     -+	grep -A1 "clone<\ ..packfile-uris" log | grep "clone<\ <redacted>"
     ++	grep "clone< <redacted>" log
      +'
      +
      +test_expect_success 'packfile-uri not redacted in trace when GIT_TRACE_REDACT=0' '
     @@ t/t5702-protocol-v2.sh: test_expect_success 'packfile-uri with transfer.fsckobje
      +		-c fetch.uriprotocols=http,https \
      +		clone "$HTTPD_URL/smart/http_parent" http_child &&
      +
     -+	grep -A1 "clone<\ ..packfile-uris" log  | grep -E "clone<\ ..[[:alnum:]]{40,64}\ http"
     ++	grep -E "clone< ..[0-9a-f]{40,64} http://" log
      +'
      +
       test_expect_success 'http:// --negotiate-only' '
 2:  497c5fd18d7 < -:  ----------- Documentation: packfile-uri hash can be longer than 40 hex chars


 fetch-pack.c           | 11 +++++++++++
 pkt-line.c             |  7 ++++++-
 pkt-line.h             |  1 +
 t/t5702-protocol-v2.sh | 43 ++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 61 insertions(+), 1 deletion(-)

diff --git a/fetch-pack.c b/fetch-pack.c
index a9604f35a3e..05c85eeafa1 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -1518,7 +1518,16 @@ static void receive_wanted_refs(struct packet_reader *reader,
 static void receive_packfile_uris(struct packet_reader *reader,
 				  struct string_list *uris)
 {
+	int original_options;
 	process_section_header(reader, "packfile-uris", 0);
+	/*
+	 * In some setups, packfile-uris act as bearer tokens,
+	 * redact them by default.
+	 */
+	original_options = reader->options;
+	if (git_env_bool("GIT_TRACE_REDACT", 1))
+		reader->options |= PACKET_READ_REDACT_ON_TRACE;
+
 	while (packet_reader_read(reader) == PACKET_READ_NORMAL) {
 		if (reader->pktlen < the_hash_algo->hexsz ||
 		    reader->line[the_hash_algo->hexsz] != ' ')
@@ -1526,6 +1535,8 @@ static void receive_packfile_uris(struct packet_reader *reader,
 
 		string_list_append(uris, reader->line);
 	}
+	reader->options = original_options;
+
 	if (reader->status != PACKET_READ_DELIM)
 		die("expected DELIM");
 }
diff --git a/pkt-line.c b/pkt-line.c
index de4a94b437e..8da8ed88ccf 100644
--- a/pkt-line.c
+++ b/pkt-line.c
@@ -443,7 +443,12 @@ enum packet_read_status packet_read_with_status(int fd, char **src_buffer,
 		len--;
 
 	buffer[len] = 0;
-	packet_trace(buffer, len, 0);
+	if (options & PACKET_READ_REDACT_ON_TRACE) {
+		const char *redacted = "<redacted>";
+		packet_trace(redacted, strlen(redacted), 0);
+	} else {
+		packet_trace(buffer, len, 0);
+	}
 
 	if ((options & PACKET_READ_DIE_ON_ERR_PACKET) &&
 	    starts_with(buffer, "ERR "))
diff --git a/pkt-line.h b/pkt-line.h
index 82b95e4bdd3..44c02f3bc6e 100644
--- a/pkt-line.h
+++ b/pkt-line.h
@@ -88,6 +88,7 @@ void packet_fflush(FILE *f);
 #define PACKET_READ_CHOMP_NEWLINE        (1u<<1)
 #define PACKET_READ_DIE_ON_ERR_PACKET    (1u<<2)
 #define PACKET_READ_GENTLE_ON_READ_ERROR (1u<<3)
+#define PACKET_READ_REDACT_ON_TRACE      (1u<<4)
 int packet_read(int fd, char **src_buffer, size_t *src_len, char
 		*buffer, unsigned size, int options);
 
diff --git a/t/t5702-protocol-v2.sh b/t/t5702-protocol-v2.sh
index d527cf6c49f..f0273317861 100755
--- a/t/t5702-protocol-v2.sh
+++ b/t/t5702-protocol-v2.sh
@@ -1107,6 +1107,49 @@ test_expect_success 'packfile-uri with transfer.fsckobjects fails when .gitmodul
 	test_i18ngrep "disallowed submodule name" err
 '
 
+test_expect_success 'packfile-uri redacted in trace' '
+	P="$HTTPD_DOCUMENT_ROOT_PATH/http_parent" &&
+	rm -rf "$P" http_child log &&
+
+	git init "$P" &&
+	git -C "$P" config "uploadpack.allowsidebandall" "true" &&
+
+	echo my-blob >"$P/my-blob" &&
+	git -C "$P" add my-blob &&
+	git -C "$P" commit -m x &&
+
+	configure_exclusion "$P" my-blob >h &&
+
+	GIT_TRACE=1 GIT_TRACE_PACKET="$(pwd)/log" GIT_TEST_SIDEBAND_ALL=1 \
+	git -c protocol.version=2 \
+		-c fetch.uriprotocols=http,https \
+		clone "$HTTPD_URL/smart/http_parent" http_child &&
+
+	grep "clone< <redacted>" log
+'
+
+test_expect_success 'packfile-uri not redacted in trace when GIT_TRACE_REDACT=0' '
+	P="$HTTPD_DOCUMENT_ROOT_PATH/http_parent" &&
+	rm -rf "$P" http_child log &&
+
+	git init "$P" &&
+	git -C "$P" config "uploadpack.allowsidebandall" "true" &&
+
+	echo my-blob >"$P/my-blob" &&
+	git -C "$P" add my-blob &&
+	git -C "$P" commit -m x &&
+
+	configure_exclusion "$P" my-blob >h &&
+
+	GIT_TRACE=1 GIT_TRACE_PACKET="$(pwd)/log" GIT_TEST_SIDEBAND_ALL=1 \
+	GIT_TRACE_REDACT=0 \
+	git -c protocol.version=2 \
+		-c fetch.uriprotocols=http,https \
+		clone "$HTTPD_URL/smart/http_parent" http_child &&
+
+	grep -E "clone< ..[0-9a-f]{40,64} http://" log
+'
+
 test_expect_success 'http:// --negotiate-only' '
 	SERVER="$HTTPD_DOCUMENT_ROOT_PATH/server" &&
 	URI="$HTTPD_URL/smart/server" &&

base-commit: 0785eb769886ae81e346df10e88bc49ffc0ac64e
-- 
gitgitgadget
