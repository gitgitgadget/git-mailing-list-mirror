Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EU+wYA3S"
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF0E69C
	for <git@vger.kernel.org>; Thu, 14 Dec 2023 06:13:48 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-6ce94f62806so4660621b3a.1
        for <git@vger.kernel.org>; Thu, 14 Dec 2023 06:13:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702563228; x=1703168028; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qb8eMO+r2EX9wgE+XrVSIkJfXNeVFSb+ROeu76BH6Nw=;
        b=EU+wYA3SPrs/8yuvRFWrz6XWVp2U+DKgbLPXKDZAYRzPtlVaNbsHyJrktvcq1EXKY8
         lHz3mnIa3fkv7Vk7WfCv49q4O+gAXoAhqi5NH7H8v124FqVlwHR0+WQoYHnI3KmzLj+E
         KExcWmvZL+NDTfCZVCKRNHkNzlJtT6rRaZgpngrrHLKKRbzNU6r+OxcMirtlT1iCifmu
         jMZdSGYnyusiuQ/Kso6Aa+BiX59jaAIiVTLDheFyH9vtqRDm0EU2l4+sWckgGSM3zk8a
         XCG2wFo3WL+q8Lumn1QtmXz98LLyZH/DLTOV8TSKyFx96x0oxnwCCZs94ss3t6YnGMUB
         gi2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702563228; x=1703168028;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qb8eMO+r2EX9wgE+XrVSIkJfXNeVFSb+ROeu76BH6Nw=;
        b=fpqqq6e6hDMLR7SXlFH6wnVHfc9m+xjnw4s7tJBMCruP6QPo9iej2AqHHVao8QeB+d
         zUyze7eFvPxFzlz9pKdo9sUVPpUWF83cByPOu51gwUa0NP6v56hFhaD9raWCEelG7S75
         WLsvwp/CBaPsg4kjOHl7E706WVCwgItTExYKWGiAlg5Weila3GXaSuuGotIhMqy3Tyfq
         VHe7rd4IyZdPiirRKh47DGMDXYXoqNkDLK4O8SW/LC1b8nSKBuPULQU7stuoYQe/SgGO
         QmEzafauyvhQfyC7AIpFbBvXNgUkXLWfHB8ULoGWvjmEY1A8tyLPqFkdtPrt6CSDnzte
         kBbQ==
X-Gm-Message-State: AOJu0YwWbfsjSo2s22ynuNa12ibzi+7exHQfIqCaG6XBbGQkJRNzEtCx
	PQbwOISCvKz7XmVDSsRt8zPRNbczL9Y=
X-Google-Smtp-Source: AGHT+IHdtjy+oaA7aG8QFEFc8p8Ec1O0z8BOjctdbAcs+c4M1DLErEg0byw3sm0LNMs09vuVsEcS5Q==
X-Received: by 2002:a05:6a00:2401:b0:6ce:2731:c235 with SMTP id z1-20020a056a00240100b006ce2731c235mr6045920pfh.36.1702563228040;
        Thu, 14 Dec 2023 06:13:48 -0800 (PST)
Received: from tigtog-proxy.localdomain.localdomain (144.34.163.219.16clouds.com. [144.34.163.219])
        by smtp.gmail.com with ESMTPSA id 16-20020a056a00071000b006ce921da705sm11806232pfl.136.2023.12.14.06.13.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Dec 2023 06:13:47 -0800 (PST)
From: Jiang Xin <worldhello.net@gmail.com>
To: Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
Cc: Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: [PATCH v4 0/4] support remote archive via stateless transport
Date: Thu, 14 Dec 2023 22:13:41 +0800
Message-Id: <cover.1702562879.git.zhiyou.jx@alibaba-inc.com>
X-Mailer: git-send-email 2.32.0.rc3
In-Reply-To: <cover.1696432593.git.zhiyou.jx@alibaba-inc.com>
References: <cover.1696432593.git.zhiyou.jx@alibaba-inc.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiang Xin <zhiyou.jx@alibaba-inc.com>

# Change since v3:

1. Update commit message of patch 2/4.
2. Add comments in t5003.

# range-diff v3...v4

1:  1818d8e30e = 1:  d343585cb5 transport-helper: no connection restriction in connect_helper
2:  b57524bc91 ! 2:  65fb67523c transport-helper: call do_take_over() in process_connect
    @@ Commit message
         where the return value from process_connect() is the return value of the
         call it makes to process_connect_service().
     
    -    It is safe to make a refactor by moving the call of do_take_over()
    -    into the function process_connect().
    +    Move the call of do_take_over() inside process_connect(), so that
    +    calling the process_connect() function is more concise and will not
    +    miss do_take_over().
     
         Suggested-by: Junio C Hamano <gitster@pobox.com>
         Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
3:  7ce60e3b9a = 3:  109a1fffde transport-helper: call do_take_over() in connect_helper
4:  626f903508 ! 4:  eb905259fe archive: support remote archive from stateless transport
    @@ Commit message
     
         Helped-by: Eric Sunshine <sunshine@sunshineco.com>
         Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
    @@ t/t5003-archive-zip.sh: check_zip with_untracked2
      check_added with_untracked2 untracked one/untracked
      check_added with_untracked2 untracked two/untracked
      
    ++# Test remote archive over HTTP protocol.
    ++#
    ++# Note: this should be the last part of this test suite, because
    ++# by including lib-httpd.sh, the test may end early if httpd tests
    ++# should not be run.
    ++#
     +. "$TEST_DIRECTORY"/lib-httpd.sh
     +start_httpd
     +
    @@ t/t5003-archive-zip.sh: check_zip with_untracked2
     +setup_askpass_helper
     +
     +test_expect_success 'remote archive does not work with protocol v1' '
    -+	test_when_finished "rm -f d5.zip" &&
     +	test_must_fail git -c protocol.version=1 archive \
     +		--remote="$HTTPD_URL/auth/smart/bare.git" \
    -+		--output=d5.zip HEAD >actual 2>&1 &&
    ++		--output=remote-http.zip HEAD >actual 2>&1 &&
     +	cat >expect <<-EOF &&
     +	fatal: can${SQ}t connect to subservice git-upload-archive
     +	EOF
    @@ t/t5003-archive-zip.sh: check_zip with_untracked2
     +'
     +
     +test_expect_success 'archive remote http repository' '
    -+	test_when_finished "rm -f d5.zip" &&
     +	git archive --remote="$HTTPD_URL/auth/smart/bare.git" \
    -+		--output=d5.zip HEAD &&
    -+	test_cmp_bin d.zip d5.zip
    ++		--output=remote-http.zip HEAD &&
    ++	test_cmp_bin d.zip remote-http.zip
     +'
     +
      test_done

Jiang Xin (4):
  transport-helper: no connection restriction in connect_helper
  transport-helper: call do_take_over() in process_connect
  transport-helper: call do_take_over() in connect_helper
  archive: support remote archive from stateless transport

 http-backend.c         | 15 +++++++++++----
 remote-curl.c          | 14 +++++++++++---
 t/t5003-archive-zip.sh | 34 ++++++++++++++++++++++++++++++++++
 transport-helper.c     | 29 +++++++++++++----------------
 4 files changed, 69 insertions(+), 23 deletions(-)

-- 
2.41.0.232.g2f6f0bca4f.agit.8.0.4.dev

