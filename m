Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0B4C44C65
	for <git@vger.kernel.org>; Sun, 17 Dec 2023 14:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UL/3vc5c"
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-7b701b75f36so126929539f.0
        for <git@vger.kernel.org>; Sun, 17 Dec 2023 06:11:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702822297; x=1703427097; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bRk/3iwbdz9dliWGbAXYYd4NVeSMdA5HPgwe/d80his=;
        b=UL/3vc5c7p6mBY/V4/GEBT9wYu96U/UgUoflNS4ECsvKTdP9r4+l7uRDGkhxETXAuU
         pZMEC200Rywu3GFEBf5VF+fgQXqiYLCjeticFdOsB49vqfyyn1FQ9WLzNNlH7hdAQU7F
         dLOH0w9+KScaHTFTFFVVeKkpVuRnXOZDr5FDj2PwVS4jL+4ZeiDoa5U4Uma1e5PcrSC8
         KnhdziuL5twjpSRi5jMUt9w2Aj1CRPtsJsUbW+j6NhHB9VPSSEW3C7taOd/KJ+YXo4Xa
         uTgPsdJxcMaa7cus7b3vYpuN0C89456bWWzHNA/EDyeTjuQj6fLYG+4CPKkwUwO+P2GK
         yG+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702822297; x=1703427097;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bRk/3iwbdz9dliWGbAXYYd4NVeSMdA5HPgwe/d80his=;
        b=Nld+BNxMIvom7wpmGENCSqonx2dt+qJ1IL/FeN8a0Omf+eQNtHLKtgEABSUGdd4Etl
         9cDwVdpMvzpwqdWv/8lEkPPIJBZ+u5S/T+WxPq95jzufonxUHau4vYSUOyH20Us7N7u4
         zujxPx9dQSfZhg2Y1GoITfgjoUKqNjyBHoBgBCWBz+hnTTTOpCMnHCVPf/vrdx9DrfJ6
         j2sW1kyP4A84gB+viM/QInHEBf6vYu2VbbAcsg0qGOVT3xZ3oMIh3MjqfhiQ+IueA50T
         +PpWZiyD+bcDoPjciuuKRmS7VT+KcLathE1gsigYI/omnm24bQ6PZ5gukKEN1QWk0cbP
         ygfA==
X-Gm-Message-State: AOJu0YzcrqgdSK8GMaAHb/y/Rwa6eb2ThvZS4rWjML5PeLNEBBztw14Z
	khpgUEumLyNnjhsb8YqbTyEXKBeixJU=
X-Google-Smtp-Source: AGHT+IEvOf4vpSpwl4rNoEVNwUVy2mhmoceyFwWQbKMfx40ftbzjq3pvJ53GPJqb9mug56Egki6ooQ==
X-Received: by 2002:a05:6e02:20c1:b0:35d:6227:4f03 with SMTP id 1-20020a056e0220c100b0035d62274f03mr21900789ilq.7.1702822296848;
        Sun, 17 Dec 2023 06:11:36 -0800 (PST)
Received: from tigtog-proxy.localdomain.localdomain (144.34.163.219.16clouds.com. [144.34.163.219])
        by smtp.gmail.com with ESMTPSA id d1-20020a17090a114100b0028b005dadb3sm7672045pje.26.2023.12.17.06.11.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Dec 2023 06:11:36 -0800 (PST)
From: Jiang Xin <worldhello.net@gmail.com>
To: Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>
Cc: Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: [PATCH v3 0/2] fix fetch atomic error message
Date: Sun, 17 Dec 2023 22:11:32 +0800
Message-Id: <cover.1702821462.git.zhiyou.jx@alibaba-inc.com>
X-Mailer: git-send-email 2.32.0.rc3
In-Reply-To: <cover.1702556642.git.zhiyou.jx@alibaba-inc.com>
References: <cover.1702556642.git.zhiyou.jx@alibaba-inc.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiang Xin <zhiyou.jx@alibaba-inc.com>

# Changes since v2:

Changed the patches with help from Patrick.


# range-diff v2...v3

1:  0b9865f1df ! 1:  0a6c53de7c t5574: test porcelain output of atomic fetch
    @@ Commit message
     
         In a later commit, we will fix this issue.
     
    +    Helped-by: Patrick Steinhardt <ps@pks.im>
         Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
     
      ## t/t5574-fetch-output.sh ##
     @@ t/t5574-fetch-output.sh: test_expect_success 'fetch compact output' '
    @@ t/t5574-fetch-output.sh: test_expect_success 'fetch porcelain output' '
     +	FORCE_UPDATED_NEW=$(git rev-parse HEAD)
      '
      
    -+for opt in off on
    ++for opt in "" "--atomic"
     +do
    -+	case $opt in
    -+	on)
    -+		opt=--atomic
    -+		;;
    -+	off)
    -+		opt=
    -+		;;
    -+	esac
     +	test_expect_failure "fetch porcelain output ${opt:+(atomic)}" '
     +		test_when_finished "rm -rf porcelain" &&
     +
2:  e10fa198dd ! 2:  a8a7658fb2 fetch: no redundant error message for atomic fetch
    @@ Commit message
         will appear at the end of do_fetch(). It was introduced in b3a804663c
         (fetch: make `--atomic` flag cover backfilling of tags, 2022-02-17).
     
    -    In function do_fetch(), a failure message is already shown before the
    -    retcode is set, so we should not call additional error() at the end of
    -    this function.
    +    Because a failure message is displayed before setting retcode in the
    +    function do_fetch(), calling error() on the err message at the end of
    +    this function may result in redundant or empty error message to be
    +    displayed.
     
         We can remove the redundant error() function, because we know that
         the function ref_transaction_abort() never fails. While we can find a
    @@ Commit message
             if (ref_transaction_abort(transaction, &error))
                 error("abort: %s", error.buf);
     
    -    We can fix this issue follow this pattern, and the test case "fetch
    -    porcelain output (atomic)" in t5574 will also be fixed. If in the future
    -    we decide that we don't need to check the return value of the function
    -    ref_transaction_abort(), this change can be fixed along with it.
    +    Following this pattern, we can tolerate the return value of the function
    +    ref_transaction_abort() being changed in the future. We also delay the
    +    output of the err message to the end of do_fetch() to reduce redundant
    +    code. With these changes, the test case "fetch porcelain output
    +    (atomic)" in t5574 will also be fixed.
     
    +    Helped-by: Patrick Steinhardt <ps@pks.im>
         Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
     
      ## builtin/fetch.c ##
    +@@ builtin/fetch.c: static int do_fetch(struct transport *transport,
    + 	if (atomic_fetch) {
    + 		transaction = ref_transaction_begin(&err);
    + 		if (!transaction) {
    +-			retcode = error("%s", err.buf);
    ++			retcode = -1;
    + 			goto cleanup;
    + 		}
    + 	}
    +@@ builtin/fetch.c: static int do_fetch(struct transport *transport,
    + 
    + 		retcode = ref_transaction_commit(transaction, &err);
    + 		if (retcode) {
    +-			error("%s", err.buf);
    + 			ref_transaction_free(transaction);
    + 			transaction = NULL;
    + 			goto cleanup;
     @@ builtin/fetch.c: static int do_fetch(struct transport *transport,
      	}
      
      cleanup:
     -	if (retcode && transaction) {
     -		ref_transaction_abort(transaction, &err);
    -+	if (retcode && transaction && ref_transaction_abort(transaction, &err))
    - 		error("%s", err.buf);
    --	}
    +-		error("%s", err.buf);
    ++	if (retcode) {
    ++		if (err.len) {
    ++			error("%s", err.buf);
    ++			strbuf_reset(&err);
    ++		}
    ++		if (transaction && ref_transaction_abort(transaction, &err) &&
    ++		    err.len)
    ++			error("%s", err.buf);
    + 	}
      
      	display_state_release(&display_state);


Jiang Xin (2):
  t5574: test porcelain output of atomic fetch
  fetch: no redundant error message for atomic fetch

 builtin/fetch.c         | 14 ++++---
 t/t5574-fetch-output.sh | 89 +++++++++++++++++++++++------------------
 2 files changed, 59 insertions(+), 44 deletions(-)

-- 
2.41.0.232.g2f6f0bca4f.agit.8.0.4.dev

