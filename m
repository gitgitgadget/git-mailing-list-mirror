Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8418A2232B
	for <git@vger.kernel.org>; Sun,  2 Jun 2024 23:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717369615; cv=none; b=a5lPrzTFHLqreGrP1TPqB+ADK8OXlknUQ2Ek0mDwA39dHBl7Bj3A6vtTD/vO6FSUpYYB+YDYGVvZbRnJ3dLVh8FtFdWCTrIREq3adFEQ+VHoxYDWHpkR9qVFN2DUX27GJDvERqHdosS0D8gY2AwCqQYpQZuAXETL7scbhybCApM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717369615; c=relaxed/simple;
	bh=oncwimCwLCIwO2gI5+4GwYhDqFOhgPCjq3VeQRZbaMc=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=DDJKNkzBxpYsPXGkPgAox+v7Pd3JYo0exJRqx6ljnxFCDoLNUMowSfZ0JkymD5GutP7WIsmGmimM3u9qeRA0TD4Uo5y6fKv5pXSqf12lhPAjzFE9NgPTwdDm/U0LNvdlrwymWJIpgsfHImYQD2OXh8/IUFZ+KAfZ3pB2NQYlvgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PtqkCRfa; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PtqkCRfa"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-52b962c4bb6so1197799e87.3
        for <git@vger.kernel.org>; Sun, 02 Jun 2024 16:06:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717369611; x=1717974411; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oMWhVK7b3xr0hvXDEYvpnTX8Y4Dja0oEL2UcN6NDgZg=;
        b=PtqkCRfaq9xqniexAcM0+ivXswW9ZiYCvbxWiuMg4Xbb3ViFGgoKj7pKY9BY2dh7wo
         2G4NBZtXLARKCKNCrIFXzobpkLu8AhOk7iFykfUDzKcAFfp/UZTmCXHACVJbxN6X+YvZ
         j3q4PCxqEgGr3OgSDOyxmCN6jbdFNhcUUzhOIrdolzKDRWM5Z7SK+4PbYG9pt4rw3wH3
         FZ4Ez+nNi1Hwuox6abCulP/qnLzR4RuH9B1zGAGcmOpOX9gVHREBrCkqc+Lxa95C06X8
         xccodc6cYUKDMVu5R12uP7YAqjySDIOCnclkwzYk248c8Nema3qx5/tIfCv5rwi8blfb
         tY/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717369611; x=1717974411;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oMWhVK7b3xr0hvXDEYvpnTX8Y4Dja0oEL2UcN6NDgZg=;
        b=kMu6J5XfRacjo2wMjFB0v9EW+2XQQ0y+2jhy8E0glzX7Q/+nakkUQlSO5Si1DVMjTb
         1Y5FIlPyFSi8Nenbh0NUQRFY1KvdLy/t7PQhSrAS+w2JDkUcc4+B/igGztmt2oCzLoXg
         /hmJPzoFSQdGId50TlWZmCoWAIRmM2TRBZ0kDwFPbTWZCmyCbb50teopsrar7eXGdV/L
         KdVkj43Y8k3yEbYyEqShWK9Gf0GiGuo+cU/E5Iy5VK6gGcj8eiJpmnF5t+YsiEKfaJuW
         jZJbve/3+K3v6/Dw3vMEds6q94BAwS63je6tWfKdODYajvBS4VNltZspRijorpMdJYnE
         t7Fg==
X-Gm-Message-State: AOJu0YwzOK4fj+DjsnR1GSAT/vBD6zlnZrVuzROy5zTVoV3LM2CEOrL9
	wvd+WJ3YbL4UNlWHHgIhkbrohIWG/NpZhdyc7h1UAGnDjLQKoAPm6H6uuw==
X-Google-Smtp-Source: AGHT+IEJqoSqLhxCyNj0qESWA6bQt61vKbiY3N4FrWfq6pnKh2sd9AJJnc1zyG0tCVV6mizetcU9+g==
X-Received: by 2002:a05:6512:3e24:b0:52b:798f:cd7e with SMTP id 2adb3069b0e04-52b89521852mr8138053e87.12.1717369610707;
        Sun, 02 Jun 2024 16:06:50 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a682ea1e5c4sm378414066b.115.2024.06.02.16.06.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Jun 2024 16:06:50 -0700 (PDT)
Message-Id: <pull.1726.v2.git.git.1717369608923.gitgitgadget@gmail.com>
In-Reply-To: <pull.1726.git.git.1716801427015.gitgitgadget@gmail.com>
References: <pull.1726.git.git.1716801427015.gitgitgadget@gmail.com>
From: "darcy via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 02 Jun 2024 23:06:48 +0000
Subject: [PATCH v2] date: detect underflow when parsing dates with positive
 timezone offset
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: darcy <acednes@gmail.com>,
    darcy <acednes@gmail.com>

From: darcy <acednes@gmail.com>

Overriding the date of a commit to be close to "1970-01-01 00:00:00"
with a large enough timezone for the equivelant GMT time to be before
the epoch is considered valid by `parse_date_basic`.

This leads to an integer underflow in the commit timestamp, which is not
caught by `git-commit`, but will cause other services to fail, such as
`git-fsck`, which reports "badDateOverflow: invalid author/committer
line - date causes integer overflow".

Instead check the timezone offset and fail if the resulting time comes
before the epoch, "1970-01-01T00:00:00Z", when parsing.

Signed-off-by: Darcy Burke <acednes@gmail.com>
---
    fix: prevent date underflow when using positive timezone offset
    
    cc: Patrick Steinhardt ps@pks.im cc: Phillip Wood
    phillip.wood123@gmail.com

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1726%2Fdxrcy%2Fmaster-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1726/dxrcy/master-v2
Pull-Request: https://github.com/git/git/pull/1726

Range-diff vs v1:

 1:  4542d984aab ! 1:  db508b2f533 fix: prevent date underflow when using positive timezone offset
     @@ Metadata
      Author: darcy <acednes@gmail.com>
      
       ## Commit message ##
     -    fix: prevent date underflow when using positive timezone offset
     +    date: detect underflow when parsing dates with positive timezone offset
      
     -    Overriding the date of a commit to be `1970-01-01` with a large enough
     -    timezone for the equivalent GMT time to before 1970 is no longer
     -    accepted.
     +    Overriding the date of a commit to be close to "1970-01-01 00:00:00"
     +    with a large enough timezone for the equivelant GMT time to be before
     +    the epoch is considered valid by `parse_date_basic`.
      
     -    Example: `GIT_COMMITTER_DATE='1970-01-01T00:00:00+10' git commit` would
     -    previously be accepted, only to unexpectedly fail in other parts of the
     -    code, such as `git push`. The timestamp is now checked against postitive
     -    timezone values.
     +    This leads to an integer underflow in the commit timestamp, which is not
     +    caught by `git-commit`, but will cause other services to fail, such as
     +    `git-fsck`, which reports "badDateOverflow: invalid author/committer
     +    line - date causes integer overflow".
      
     -    Signed-off-by: darcy <acednes@gmail.com>
     +    Instead check the timezone offset and fail if the resulting time comes
     +    before the epoch, "1970-01-01T00:00:00Z", when parsing.
     +
     +    Signed-off-by: Darcy Burke <acednes@gmail.com>
      
       ## date.c ##
     -@@ date.c: int parse_date_basic(const char *date, timestamp_t *timestamp, int *offset)
     - 			match = match_alpha(date, &tm, offset);
     - 		else if (isdigit(c))
     - 			match = match_digit(date, &tm, offset, &tm_gmt);
     --		else if ((c == '-' || c == '+') && isdigit(date[1]))
     -+		else if ((c == '-' || c == '+') && isdigit(date[1]) && tm.tm_hour != -1)
     - 			match = match_tz(date, offset);
     - 
     - 		if (!match) {
      @@ date.c: int parse_date_basic(const char *date, timestamp_t *timestamp, int *offset)
       		}
       	}
       
      -	if (!tm_gmt)
      +	if (!tm_gmt) {
     -+		if (*offset > 0 && *offset * 60 > *timestamp) {
     ++		if (*offset > 0 && *offset * 60 > *timestamp)
      +			return -1;
     -+		}
       		*timestamp -= *offset * 60;
      +	}
      +
       	return 0; /* success */
       }
       
     +
     + ## t/t0006-date.sh ##
     +@@ t/t0006-date.sh: check_parse '2008-02-14 20:30:45 -:30' '2008-02-14 20:30:45 +0000'
     + check_parse '2008-02-14 20:30:45 -05:00' '2008-02-14 20:30:45 -0500'
     + check_parse '2008-02-14 20:30:45' '2008-02-14 20:30:45 -0500' EST5
     + check_parse 'Thu, 7 Apr 2005 15:14:13 -0700' '2005-04-07 15:14:13 -0700'
     ++check_parse '1970-01-01 00:00:00' '1970-01-01 00:00:00 +0000'
     ++check_parse '1970-01-01 00:00:00 +00' '1970-01-01 00:00:00 +0000'
     ++check_parse '1970-01-01 00:00:00 Z' '1970-01-01 00:00:00 +0000'
     ++check_parse '1970-01-01 00:00:00 -01' '1970-01-01 00:00:00 -0100'
     ++check_parse '1970-01-01 00:00:00 +01' bad
     ++check_parse '1970-01-01 00:00:00 +11' bad
     ++check_parse '1970-01-01 00:59:59 +01' bad
     ++check_parse '1970-01-01 01:00:00 +01' '1970-01-01 01:00:00 +0100'
     ++check_parse '1970-01-01 01:00:00 +11' bad
     ++check_parse '1970-01-02 00:00:00 +11' '1970-01-02 00:00:00 +1100'
     ++check_parse '1969-12-31 23:59:59' bad
     ++check_parse '1969-12-31 23:59:59 +00' bad
     ++check_parse '1969-12-31 23:59:59 Z' bad
     ++check_parse '1969-12-31 23:59:59 +11' bad
     ++check_parse '1969-12-31 23:59:59 -11' bad
     + 
     + check_approxidate() {
     + 	echo "$1 -> $2 +0000" >expect


 date.c          |  6 +++++-
 t/t0006-date.sh | 15 +++++++++++++++
 2 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/date.c b/date.c
index 7365a4ad24f..8e3ec1bcb00 100644
--- a/date.c
+++ b/date.c
@@ -937,8 +937,12 @@ int parse_date_basic(const char *date, timestamp_t *timestamp, int *offset)
 		}
 	}
 
-	if (!tm_gmt)
+	if (!tm_gmt) {
+		if (*offset > 0 && *offset * 60 > *timestamp)
+			return -1;
 		*timestamp -= *offset * 60;
+	}
+
 	return 0; /* success */
 }
 
diff --git a/t/t0006-date.sh b/t/t0006-date.sh
index 3031256d143..cdbb40bec01 100755
--- a/t/t0006-date.sh
+++ b/t/t0006-date.sh
@@ -116,6 +116,21 @@ check_parse '2008-02-14 20:30:45 -:30' '2008-02-14 20:30:45 +0000'
 check_parse '2008-02-14 20:30:45 -05:00' '2008-02-14 20:30:45 -0500'
 check_parse '2008-02-14 20:30:45' '2008-02-14 20:30:45 -0500' EST5
 check_parse 'Thu, 7 Apr 2005 15:14:13 -0700' '2005-04-07 15:14:13 -0700'
+check_parse '1970-01-01 00:00:00' '1970-01-01 00:00:00 +0000'
+check_parse '1970-01-01 00:00:00 +00' '1970-01-01 00:00:00 +0000'
+check_parse '1970-01-01 00:00:00 Z' '1970-01-01 00:00:00 +0000'
+check_parse '1970-01-01 00:00:00 -01' '1970-01-01 00:00:00 -0100'
+check_parse '1970-01-01 00:00:00 +01' bad
+check_parse '1970-01-01 00:00:00 +11' bad
+check_parse '1970-01-01 00:59:59 +01' bad
+check_parse '1970-01-01 01:00:00 +01' '1970-01-01 01:00:00 +0100'
+check_parse '1970-01-01 01:00:00 +11' bad
+check_parse '1970-01-02 00:00:00 +11' '1970-01-02 00:00:00 +1100'
+check_parse '1969-12-31 23:59:59' bad
+check_parse '1969-12-31 23:59:59 +00' bad
+check_parse '1969-12-31 23:59:59 Z' bad
+check_parse '1969-12-31 23:59:59 +11' bad
+check_parse '1969-12-31 23:59:59 -11' bad
 
 check_approxidate() {
 	echo "$1 -> $2 +0000" >expect

base-commit: 9eaef5822cd76bbeb53b6479ce0ddaad34ee2b14
-- 
gitgitgadget
