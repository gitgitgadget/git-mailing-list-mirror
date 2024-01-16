Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A4181BC4E
	for <git@vger.kernel.org>; Tue, 16 Jan 2024 13:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LFjo5pvk"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1d3ec3db764so35962175ad.2
        for <git@vger.kernel.org>; Tue, 16 Jan 2024 05:39:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705412373; x=1706017173; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Iiqx6TqESCyo+GQy/8dzXRf9neOwXTC5P0LQDss7moE=;
        b=LFjo5pvkz8pl6MDz8qzO0FH1mEQJdsyUmCqRrCwlVuoflt2PcVpTK5kSvAkzi/1f/O
         yN8cezMOTTn4oqZ5k45PIp65EG3b2kswGbEXPE1d2gFWEBw6+xY2gqLevwRSOjmJSTth
         g/U6boGIF7fjhP84nGULaUbT9Djbgi70+y0F1pzvMsI0CjMP8EoW0sxUUfva5vKXYl2O
         Klk2rCoqVedMjEVgP5gDOOzCsYznbVV3GsEPlrEVQuEMpOOXI6ALW4o5xrAqcTJnq8YN
         wFDJQWgMjv/CnGnhbL1ALvGoDfo8X3HwM3NtmlEudJ/FOmgjV2OOy/+ajoPiB5LujcVm
         8N3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705412373; x=1706017173;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Iiqx6TqESCyo+GQy/8dzXRf9neOwXTC5P0LQDss7moE=;
        b=Lso25AdODr1y9xkha4Qzr/tyN/MvmOrjPii4LqUxp6lAPfPsYiHqQPhGQO/xxlGIMw
         FrNV5uyep+uDnH5RpOLfPrCVeolusX4G78IoTM09uPAsu4+e7mVNpnSQIviALP+rJ/NJ
         WEQz1w6l2mVqMSSrljREYkRNCIKwXALawy3DBLyZjxSBGXw6pcN8+MNgcZoL8PLNuK/+
         KPKeH3WdxoO085L+BmHmxfJUdDz19xqWzH8Y6Md8t0dh5LKn3jl373ukz22mLwP4mk6K
         3jY2e2yinhkqd/7LWn0116SBjNqFZxsEx9OA8Qn/bNW2tN0Kfo5ZLcxuTfgeSOm6kMPj
         Pnmw==
X-Gm-Message-State: AOJu0YzQDkouuxBk0Yf5VcocLH3+Qr5XxAnYxMyBG60SLWOsaTRl276x
	meDnsPPFfSEebRNrHoD52FlA7sIjho7chw==
X-Google-Smtp-Source: AGHT+IF+X6FPZTq3Cos+2CA0pj22U7jSG+q7SzOBiU5fbaU+zX4aE5ktrPSVm62Rs5U8OcOP79iZ9w==
X-Received: by 2002:a17:902:7c01:b0:1d4:faae:885d with SMTP id x1-20020a1709027c0100b001d4faae885dmr3308796pll.123.1705412373530;
        Tue, 16 Jan 2024 05:39:33 -0800 (PST)
Received: from tigtog-proxy.localdomain.localdomain (144.34.163.219.16clouds.com. [144.34.163.219])
        by smtp.gmail.com with ESMTPSA id l8-20020a170902f68800b001d5c38bfa33sm4303351plg.307.2024.01.16.05.39.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Jan 2024 05:39:33 -0800 (PST)
From: Jiang Xin <worldhello.net@gmail.com>
To: Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Linus Arver <linusa@google.com>
Cc: Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: [PATCH v5 0/6] support remote archive via stateless transport
Date: Tue, 16 Jan 2024 21:39:24 +0800
Message-Id: <cover.1705411391.git.zhiyou.jx@alibaba-inc.com>
X-Mailer: git-send-email 2.32.0.rc3
In-Reply-To: <cover.1702562879.git.zhiyou.jx@alibaba-inc.com>
References: <cover.1702562879.git.zhiyou.jx@alibaba-inc.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiang Xin <zhiyou.jx@alibaba-inc.com>

"git archive --remote=<remote>" learned to talk over the smart
http (aka stateless) transport.

# Changes since v4

1. Change commit messages and order of commits.
2. Split the last commit of v4 into three seperate commits.


# range-diff v4...v5

1:  da80391037 ! 1:  f3fef46c05 transport-helper: no connection restriction in connect_helper
    @@ Commit message
         was for transport that supports the ".connect" method. The
         "connect_helper()" function protected itself from getting called for a
         transport without the method before calling process_connect_service(),
    -    which did not work with such a transport.
    +    which only worked with the ".connect" method.
     
         Later, commit edc9caf7 (transport-helper: introduce stateless-connect,
         2018-03-15) added a way for a transport without the ".connect" method
    -    to establish a "stateless" connection in protocol-v2, which
    -    process_connect_service() was taught to handle the "stateless"
    -    connection, making the old safety valve in its caller that insisted
    -    that ".connect" method must be defined too strict, and forgot to loosen
    -    it.
    +    to establish a "stateless" connection in protocol-v2, where
    +    process_connect_service() was taught to handle the ".stateless_connect"
    +    method, making the old protection too strict. But commit edc9caf7 forgot
    +    to adjust this protection accordingly.
     
         Remove the restriction in the "connect_helper()" function and give the
         function "process_connect_service()" the opportunity to establish a
    @@ Commit message
         protocol.
     
         Helped-by: Junio C Hamano <gitster@pobox.com>
    +    Helped-by: Linus Arver <linusa@google.com>
         Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
     
      ## transport-helper.c ##
-:  ---------- > 2:  6be331b22d remote-curl: supports git-upload-archive service
-:  ---------- > 3:  aabc8e1a2a transport-helper: protocol-v2 supports upload-archive
4:  a21a80dae9 ! 4:  fdab4abb43 archive: support remote archive from stateless transport
    @@ Metadata
     Author: Jiang Xin <zhiyou.jx@alibaba-inc.com>
     
      ## Commit message ##
    -    archive: support remote archive from stateless transport
    +    http-backend: new rpc-service for git-upload-archive
     
    -    Even though we can establish a stateless connection, we still cannot
    -    archive the remote repository using a stateless HTTP protocol. Try the
    -    following steps to make it work.
    +    Add new rpc-service "upload-archive" in http-backend to add server side
    +    support for remote archive over HTTP/HTTPS protocols.
     
    -     1. Add support for "git-upload-archive" service in "http-backend".
    -
    -     2. Use the URL ".../info/refs?service=git-upload-pack" to detect the
    -        protocol version, instead of use the "git-upload-archive" service.
    -
    -     3. "git-archive" does not expect to see protocol version and
    -        capabilities when connecting to remote-helper, so do not send them
    -        in "remote-curl.c" for the "git-upload-archive" service.
    +    Also add new test cases in t5003. In the test case "archive remote http
    +    repository", git-archive exits with a non-0 exit code even though we
    +    create the archive correctly. It will be fixed in a later commit.
     
         Helped-by: Eric Sunshine <sunshine@sunshineco.com>
         Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
 		if (ret)

    ... (omitted) ...

3:  870dc5fd21 ! 5:  6ac0c8e105 transport-helper: call do_take_over() in connect_helper
    @@ Commit message
         After successfully connecting to the smart transport by calling
         process_connect_service() in connect_helper(), run do_take_over() to
         replace the old vtable with a new one which has methods ready for the
    -    smart transport connection.
    +    smart transport connection. This will fix the exit code of git-archive
    +    in test case "archive remote http repository" of t5003.
     
         The connect_helper() function is used as the connect method of the
         vtable in "transport-helper.c", and it is called by transport_connect()
    @@ Commit message
         transport_connect() so far is in "builtin/archive.c". Without running
         do_take_over(), it may fail to call transport_disconnect() in
         run_remote_archiver() of "builtin/archive.c". This is because for a
    -    stateless connection or a service like "git-upload-pack-archive", the
    +    stateless connection and a service like "git-upload-archive", the
         remote helper may receive a SIGPIPE signal and exit early. To have a
         graceful disconnect method by calling do_take_over() will solve this
         issue.
     
    -    The subsequent commit will introduce remote archive over a stateless-rpc
    -    connection.
    -
    +    Helped-by: Linus Arver <linusa@google.com>
         Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
     
    + ## t/t5003-archive-zip.sh ##
    +@@ t/t5003-archive-zip.sh: test_expect_success 'remote archive does not work with protocol v1' '
    + '
    + 
    + test_expect_success 'archive remote http repository' '
    +-	test_must_fail git archive --remote="$HTTPD_URL/auth/smart/bare.git" \
    ++	git archive --remote="$HTTPD_URL/auth/smart/bare.git" \
    + 		--output=remote-http.zip HEAD &&
    + 	test_cmp_bin d.zip remote-http.zip
    + '
    +
      ## transport-helper.c ##
     @@ transport-helper.c: static int connect_helper(struct transport *transport, const char *name,
      
2:  2f7060f7c5 = 6:  423a89c593 transport-helper: call do_take_over() in process_connect

Jiang Xin (6):
  transport-helper: no connection restriction in connect_helper
  remote-curl: supports git-upload-archive service
  transport-helper: protocol-v2 supports upload-archive
  http-backend: new rpc-service for git-upload-archive
  transport-helper: call do_take_over() in connect_helper
  transport-helper: call do_take_over() in process_connect

 http-backend.c         | 13 ++++++++++---
 remote-curl.c          | 14 +++++++++++---
 t/t5003-archive-zip.sh | 34 ++++++++++++++++++++++++++++++++++
 transport-helper.c     | 29 +++++++++++++----------------
 4 files changed, 68 insertions(+), 22 deletions(-)

-- 
2.43.0

