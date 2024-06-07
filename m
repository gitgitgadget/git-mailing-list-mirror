Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3D1B23DE
	for <git@vger.kernel.org>; Fri,  7 Jun 2024 00:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717719435; cv=none; b=KXDk/W8YD7BjKGURZBTOoah1nDC/mkvQ2pQzhDvK0HmWjKyoZISrjZ5IiVbBO84fpWxXMX8u+iIZeI14yzE4j/RcQsypBwODzx9/uJVireeNRDO+ZN282jcvYgG03SACMmTFn1es8B5vGZNbmxhu0DuoVsDGdrhKF2zFSP2nAaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717719435; c=relaxed/simple;
	bh=rnFRIsTPSRcRxp/J0TFnZD/gDY+ET2pkf7KYRZUMaWA=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=LfLQSGwe4tOWmCSf09R/MNcd6KkLV5ZjJLh5DFy4IHqrFU0UiS8XFXl2J+PWocO0C2qIc6ZIDL1Wgt1bGr1ZEjnfnrfd7DpUfzlOLzG4iRHerEqf72iWXZ2aSZs0SpFRpPcNcGT79uF70XmYm6OMyo3tGoDNLQEr6dVp0yttyrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WBslRQ61; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WBslRQ61"
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5295e488248so1872240e87.2
        for <git@vger.kernel.org>; Thu, 06 Jun 2024 17:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717719430; x=1718324230; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XVjiizLYAvqhfvb7wKitt/Kgzb0bI8tThhHxpu/tyec=;
        b=WBslRQ61dRFztUWHnXVAG2zhDLXl4Nja/waTgTpOXahnvfboCsYMvoasMWn7adcI9R
         +oR3h07fErQmhVezzZ1BcPQ8ucpIHUZKvqRn/ENzYyhVSDAlUNfqoXJYho50KjeqBok7
         yBA3Xfgkt+LJNrexTddzx4omPpm3MenRi7QFXtYkZi3BH26XHLYVmGQnJEud/6LiluF9
         qqOyZVPPzKhKG/phKyjBKvItWc3W2fwniO5IGGyBOv4hdXJ7HhzCd+beS26HcrWd/1Ua
         Rh3eSCZ+1P9duXL8ChZUXoJnnhwpcFfte50vl7gZoKfgr67To5FACRBNjyg8k41mTNJx
         7CZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717719430; x=1718324230;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XVjiizLYAvqhfvb7wKitt/Kgzb0bI8tThhHxpu/tyec=;
        b=VLDrFD4YgxzAziRY7G+W4DhzDZMD8SPrRhXb4WBFmGFjJlMd5UcDOKK/1QMOxxN0W3
         nyBb4euzK5uxcflUzq/2tFpTZkoHIOFEP+2d60IzZeViLq6oLcxNpR4X6q5XeolkcrT+
         0xQZFPk8+AQ/1kxbhb+Zyih8ofe81QWoCLCWq3/QtmUMsxOGOhqxUqKHPg3VhqqP1SZ7
         s41EPF2zlSJlIGPmlgVFos5lig+LIdHh54HHUC/uvw4YtbEV4yfk0XoH8/fIWI1LE86Q
         YeKr80xi2ZYwlTTy4I62qNmYOMQt8/W3rYpKJK3b2xVbSuc9vhEVIJCrxnBdyy+ZsKWm
         Irlw==
X-Gm-Message-State: AOJu0YxBINo+0tycDQlpWcPKwMiGwdd84nwWV4Xkg8mo7s9EE3Hj6zbH
	wzU0IQanMvm/qfr2cIQWTsSOyuFu8kTb5UTudHW3xpePV9Z7FaHl/fpMMQ==
X-Google-Smtp-Source: AGHT+IE+q/Ptqn18UN5ba1c9TB8kFzzsP6R+1DpEe+B+FeVluarR/LpLseZMx4Od9RZE8sNO3dVYtg==
X-Received: by 2002:a05:6512:78d:b0:52b:9037:996d with SMTP id 2adb3069b0e04-52bb9fccd7bmr541336e87.46.1717719429958;
        Thu, 06 Jun 2024 17:17:09 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4215c1aa2f7sm36289385e9.14.2024.06.06.17.17.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 17:17:09 -0700 (PDT)
Message-Id: <pull.1726.v3.git.git.1717719428510.gitgitgadget@gmail.com>
In-Reply-To: <pull.1726.v2.git.git.1717369608923.gitgitgadget@gmail.com>
References: <pull.1726.v2.git.git.1717369608923.gitgitgadget@gmail.com>
From: "darcy via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 07 Jun 2024 00:17:08 +0000
Subject: [PATCH v3] date: detect underflow/overflow when parsing dates with
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
with a large enough positive timezone for the equivelant GMT time to be
before the epoch is considered valid by `parse_date_basic`. Similar
behaviour occurs when using a date close to "2099-12-31 23:59:59" (the
maximum date allowed by `tm_to_time_t`) with a large enough negative
timezone offset.

This leads to an integer underflow or underflow respectively in the
commit timestamp, which is not caught by `git-commit`, but will cause
other services to fail, such as `git-fsck`, which, for the first case,
reports "badDateOverflow: invalid author/committer line - date causes
integer overflow".

Instead check the timezone offset and fail if the resulting time comes
before the epoch "1970-01-01T00:00:00Z" or after the maximum date
"2099-12-31T23:59:59Z".

Signed-off-by: Darcy Burke <acednes@gmail.com>
---
    fix: prevent date underflow when using positive timezone offset
    
    cc: Patrick Steinhardt ps@pks.im cc: Phillip Wood
    phillip.wood123@gmail.com cc: darcy acednes@gmail.com cc: Jeff King
    peff@peff.net

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1726%2Fdxrcy%2Fmaster-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1726/dxrcy/master-v3
Pull-Request: https://github.com/git/git/pull/1726

Range-diff vs v2:

 1:  db508b2f533 ! 1:  f0de3a2c543 date: detect underflow when parsing dates with positive timezone offset
     @@ Metadata
      Author: darcy <acednes@gmail.com>
      
       ## Commit message ##
     -    date: detect underflow when parsing dates with positive timezone offset
     +    date: detect underflow/overflow when parsing dates with timezone offset
      
          Overriding the date of a commit to be close to "1970-01-01 00:00:00"
     -    with a large enough timezone for the equivelant GMT time to be before
     -    the epoch is considered valid by `parse_date_basic`.
     +    with a large enough positive timezone for the equivelant GMT time to be
     +    before the epoch is considered valid by `parse_date_basic`. Similar
     +    behaviour occurs when using a date close to "2099-12-31 23:59:59" (the
     +    maximum date allowed by `tm_to_time_t`) with a large enough negative
     +    timezone offset.
      
     -    This leads to an integer underflow in the commit timestamp, which is not
     -    caught by `git-commit`, but will cause other services to fail, such as
     -    `git-fsck`, which reports "badDateOverflow: invalid author/committer
     -    line - date causes integer overflow".
     +    This leads to an integer underflow or underflow respectively in the
     +    commit timestamp, which is not caught by `git-commit`, but will cause
     +    other services to fail, such as `git-fsck`, which, for the first case,
     +    reports "badDateOverflow: invalid author/committer line - date causes
     +    integer overflow".
      
          Instead check the timezone offset and fail if the resulting time comes
     -    before the epoch, "1970-01-01T00:00:00Z", when parsing.
     +    before the epoch "1970-01-01T00:00:00Z" or after the maximum date
     +    "2099-12-31T23:59:59Z".
      
          Signed-off-by: Darcy Burke <acednes@gmail.com>
      
       ## date.c ##
     +@@ date.c: static int match_object_header_date(const char *date, timestamp_t *timestamp, in
     + 	return 0;
     + }
     + 
     ++
     ++/* timestamp of 2099-12-31T23:59:59Z, including 32 leap days */
     ++static const time_t timestamp_max = ((2100L - 1970) * 365 + 32) * 24 * 60 * 60 - 1;
     ++
     + /* Gr. strptime is crap for this; it doesn't have a way to require RFC2822
     +    (i.e. English) day/month names, and it doesn't work correctly with %z. */
     + int parse_date_basic(const char *date, timestamp_t *timestamp, int *offset)
      @@ date.c: int parse_date_basic(const char *date, timestamp_t *timestamp, int *offset)
       		}
       	}
     @@ date.c: int parse_date_basic(const char *date, timestamp_t *timestamp, int *offs
      -	if (!tm_gmt)
      +	if (!tm_gmt) {
      +		if (*offset > 0 && *offset * 60 > *timestamp)
     ++			return -1;
     ++		if (*offset < 0 && -*offset * 60 > timestamp_max - *timestamp)
      +			return -1;
       		*timestamp -= *offset * 60;
      +	}
     @@ date.c: int parse_date_basic(const char *date, timestamp_t *timestamp, int *offs
       
      
       ## t/t0006-date.sh ##
     -@@ t/t0006-date.sh: check_parse '2008-02-14 20:30:45 -:30' '2008-02-14 20:30:45 +0000'
     - check_parse '2008-02-14 20:30:45 -05:00' '2008-02-14 20:30:45 -0500'
     +@@ t/t0006-date.sh: check_parse '2008-02-14 20:30:45 -05:00' '2008-02-14 20:30:45 -0500'
       check_parse '2008-02-14 20:30:45' '2008-02-14 20:30:45 -0500' EST5
       check_parse 'Thu, 7 Apr 2005 15:14:13 -0700' '2005-04-07 15:14:13 -0700'
     + 
      +check_parse '1970-01-01 00:00:00' '1970-01-01 00:00:00 +0000'
      +check_parse '1970-01-01 00:00:00 +00' '1970-01-01 00:00:00 +0000'
      +check_parse '1970-01-01 00:00:00 Z' '1970-01-01 00:00:00 +0000'
     @@ t/t0006-date.sh: check_parse '2008-02-14 20:30:45 -:30' '2008-02-14 20:30:45 +00
      +check_parse '1969-12-31 23:59:59 Z' bad
      +check_parse '1969-12-31 23:59:59 +11' bad
      +check_parse '1969-12-31 23:59:59 -11' bad
     - 
     ++
     ++check_parse '2099-12-31 23:59:59' '2099-12-31 23:59:59 +0000'
     ++check_parse '2099-12-31 23:59:59 +00' '2099-12-31 23:59:59 +0000'
     ++check_parse '2099-12-31 23:59:59 Z' '2099-12-31 23:59:59 +0000'
     ++check_parse '2099-12-31 23:59:59 +01' '2099-12-31 23:59:59 +0100'
     ++check_parse '2099-12-31 23:59:59 -01' bad
     ++check_parse '2099-12-31 23:59:59 -11' bad
     ++check_parse '2099-12-31 23:00:00 -01' bad
     ++check_parse '2099-12-31 22:59:59 -01' '2099-12-31 22:59:59 -0100'
     ++check_parse '2100-00-00 00:00:00' bad
     ++check_parse '2099-12-30 00:00:00 -11' '2099-12-30 00:00:00 -1100'
     ++check_parse '2100-00-00 00:00:00 +00' bad
     ++check_parse '2100-00-00 00:00:00 Z' bad
     ++check_parse '2100-00-00 00:00:00 -11' bad
     ++check_parse '2100-00-00 00:00:00 +11' bad
     ++
       check_approxidate() {
       	echo "$1 -> $2 +0000" >expect
     + 	test_expect_${3:-success} "parse approxidate ($1)" "


 date.c          | 12 +++++++++++-
 t/t0006-date.sh | 31 +++++++++++++++++++++++++++++++
 2 files changed, 42 insertions(+), 1 deletion(-)

diff --git a/date.c b/date.c
index 7365a4ad24f..95776c8a92f 100644
--- a/date.c
+++ b/date.c
@@ -868,6 +868,10 @@ static int match_object_header_date(const char *date, timestamp_t *timestamp, in
 	return 0;
 }
 
+
+/* timestamp of 2099-12-31T23:59:59Z, including 32 leap days */
+static const time_t timestamp_max = ((2100L - 1970) * 365 + 32) * 24 * 60 * 60 - 1;
+
 /* Gr. strptime is crap for this; it doesn't have a way to require RFC2822
    (i.e. English) day/month names, and it doesn't work correctly with %z. */
 int parse_date_basic(const char *date, timestamp_t *timestamp, int *offset)
@@ -937,8 +941,14 @@ int parse_date_basic(const char *date, timestamp_t *timestamp, int *offset)
 		}
 	}
 
-	if (!tm_gmt)
+	if (!tm_gmt) {
+		if (*offset > 0 && *offset * 60 > *timestamp)
+			return -1;
+		if (*offset < 0 && -*offset * 60 > timestamp_max - *timestamp)
+			return -1;
 		*timestamp -= *offset * 60;
+	}
+
 	return 0; /* success */
 }
 
diff --git a/t/t0006-date.sh b/t/t0006-date.sh
index 3031256d143..e8fdf361ad4 100755
--- a/t/t0006-date.sh
+++ b/t/t0006-date.sh
@@ -117,6 +117,37 @@ check_parse '2008-02-14 20:30:45 -05:00' '2008-02-14 20:30:45 -0500'
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
+
+check_parse '2099-12-31 23:59:59' '2099-12-31 23:59:59 +0000'
+check_parse '2099-12-31 23:59:59 +00' '2099-12-31 23:59:59 +0000'
+check_parse '2099-12-31 23:59:59 Z' '2099-12-31 23:59:59 +0000'
+check_parse '2099-12-31 23:59:59 +01' '2099-12-31 23:59:59 +0100'
+check_parse '2099-12-31 23:59:59 -01' bad
+check_parse '2099-12-31 23:59:59 -11' bad
+check_parse '2099-12-31 23:00:00 -01' bad
+check_parse '2099-12-31 22:59:59 -01' '2099-12-31 22:59:59 -0100'
+check_parse '2100-00-00 00:00:00' bad
+check_parse '2099-12-30 00:00:00 -11' '2099-12-30 00:00:00 -1100'
+check_parse '2100-00-00 00:00:00 +00' bad
+check_parse '2100-00-00 00:00:00 Z' bad
+check_parse '2100-00-00 00:00:00 -11' bad
+check_parse '2100-00-00 00:00:00 +11' bad
+
 check_approxidate() {
 	echo "$1 -> $2 +0000" >expect
 	test_expect_${3:-success} "parse approxidate ($1)" "

base-commit: cd77e87115eab5e80e6b161e7b84a79ba1a12cdc
-- 
gitgitgadget
