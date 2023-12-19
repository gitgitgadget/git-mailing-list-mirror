Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 864D03D0DB
	for <git@vger.kernel.org>; Tue, 19 Dec 2023 22:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FhkMG9wu"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-5c699b44dddso1781023a12.1
        for <git@vger.kernel.org>; Tue, 19 Dec 2023 14:14:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703024076; x=1703628876; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9FUJpMvWFFyNnNH6+I+HlpA9SCHvqfQV5aEXHN9qjD0=;
        b=FhkMG9wuU73trqFvFwFQySlqwkyBtlQSdhtsxutk9Q7EPng4IDAHkLRatmnehgaeJB
         zGejVsXPXHpZOAHYl1Ti449J3RnwbyRe+EvS7M8ZcqhgsaeQPqj5HC0IizwTUcalAbXN
         w9kdsxpO93G4nBLOverXXvbpzTHSPCQThwtQ4aGOGaH3OioV3lgbVyG13GgP/Cay09zT
         AwD4HyqjA9WkQzP/PpPP0jEczZMUSCLyAX1wUmvx48mUTjSON032zqJs1cqydc2KhuW5
         AlqQbx0SxZFIC8Rri8dP933v11dXKTHlyVpMh7D4gQadTFFY0QWewCiMjVZb1lNMpc99
         k8jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703024076; x=1703628876;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9FUJpMvWFFyNnNH6+I+HlpA9SCHvqfQV5aEXHN9qjD0=;
        b=l37LO0ruLInDQT4/K8co+bg+f6XLoq4GeA0+9c+gyAQj5F2txi2S68zGByJi5q3wkc
         hOszcmwAXlISF9tKayOo4e5OBnMNfnC6TZ24A1IdZ6362/t9F4206gbqrTyHU/gFrDyv
         6J2koG7fMPRDL1Da41ONN5R7YYtyCjeYanbiATGL4vcFVM4/o8/MhbfTrjcxw1rgNnBf
         0hhP/Mwk6xqfnGSeqxZj8xjoVX104ZeUznf+eEqzPuK52DsDbqVdoRePmtYztPk6qvTZ
         69GF+vtAji20FqIACD+QoazMmFUUlQz0c6a6sdDei72N8ryRfDsiOCSt4HKdUhj+eNk+
         eWOQ==
X-Gm-Message-State: AOJu0YwJQOfAwqdsXFPORcaTKoz9iStFZuSba04QLX5izeU1TXIkCSkW
	YZX/g01NcRQwViiT+BPVI1jyreQUdBs=
X-Google-Smtp-Source: AGHT+IEQC3XiMTA0VYyJhO9mSMRfjjqNc9xQHhwmxrGV3xyc7ToZ9YF/nQu8D05ChreBQLOiYK08fQ==
X-Received: by 2002:a05:6a20:1444:b0:194:d1f0:b087 with SMTP id a4-20020a056a20144400b00194d1f0b087mr80128pzi.122.1703024076440;
        Tue, 19 Dec 2023 14:14:36 -0800 (PST)
Received: from localhost.localdomain (192-184-144-144.fiber.dynamic.sonic.net. [192.184.144.144])
        by smtp.gmail.com with ESMTPSA id 4-20020a17090a190400b00288622137dfsm2360255pjg.5.2023.12.19.14.14.35
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 19 Dec 2023 14:14:36 -0800 (PST)
From: Stan Hu <stanhu@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,
	Christian Couder <christian.couder@gmail.com>,
	Stan Hu <stanhu@gmail.com>
Subject: [PATCH v3 2/2] completion: support pseudoref existence checks for reftables
Date: Tue, 19 Dec 2023 14:14:18 -0800
Message-ID: <e25a0c5c84dfeca7067fe803388ea3bcee58860c.1703022850.git.stanhu@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1703022850.git.stanhu@gmail.com>
References: <cover.1703022850.git.stanhu@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In contrib/completion/git-completion.bash, there are a bunch of
instances where we read pseudorefs, such as HEAD, MERGE_HEAD,
REVERT_HEAD, and others via the filesystem. However, the upcoming
reftable refs backend won't use '.git/HEAD' at all but instead will
write an invalid refname as placeholder for backwards compatibility,
which will break the git-completion script.

Update the '__git_pseudoref_exists' function to:

1. Recognize the placeholder '.git/HEAD' written by the reftable
   backend (its content is specified in the reftable specs).
2. If reftable is in use, use 'git rev-parse' to determine whether the
    given ref exists.
3. Otherwise, continue to use 'test -f' to check for the ref's filename.

Signed-off-by: Stan Hu <stanhu@gmail.com>
---
 contrib/completion/git-completion.bash | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 8edd002eed..e21a39b406 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -122,12 +122,35 @@ __git ()
 		${__git_dir:+--git-dir="$__git_dir"} "$@" 2>/dev/null
 }
 
+# Helper function to read the first line of a file into a variable.
+# __git_eread requires 2 arguments, the file path and the name of the
+# variable, in that order.
+#
+# This is taken from git-prompt.sh.
+__git_eread ()
+{
+	test -r "$1" && IFS=$'\r\n' read -r "$2" <"$1"
+}
+
 # Runs git in $__git_repo_path to determine whether a pseudoref exists.
 # 1: The pseudo-ref to search
 __git_pseudoref_exists ()
 {
 	local ref=$1
 
+	# If the reftable is in use, we have to shell out to 'git rev-parse'
+	# to determine whether the ref exists instead of looking directly in
+	# the filesystem to determine whether the ref exists. Otherwise, use
+	# Bash builtins since executing Git commands are expensive on some
+	# platforms.
+	if __git_eread "$__git_repo_path/HEAD" head; then
+		b="${head#ref: }"
+		if [ "$b" == "refs/heads/.invalid" ]; then
+			__git -C "$__git_repo_path" rev-parse --verify --quiet "$ref" 2>/dev/null
+			return $?
+		fi
+	fi
+
 	[ -f "$__git_repo_path/$ref" ]
 }
 
-- 
2.42.0

