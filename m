Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2849C47DFBF
	for <git@vger.kernel.org>; Tue,  1 Sep 2026 15:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788277991; cv=none; b=kh+Doa18UDlAq5WhMLaJlmphXxvj5dTYa2hViXddl5r+e4UnXFlxqbsxhV+KEm2CGvFembgZXMAN7OLs/D1DBgg4a2iwmQTga0xViZlaHhtftjAPOULpQMQcn09Cho71WbndubMTITD0Aw87XtGBpmG3+NW+2reqqbypF7o82o4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788277991; c=relaxed/simple;
	bh=L3JdVzODKTGM1H+8HQhxzLKEx8EJE95uk8LZasb6a/8=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=lC9bcDbTLFuFZBD1GLU986GUipxOfiOo+S0QDC/TvYiL94wdr22KXJyJCww8PUoF7X8as9dwETIPLN9L4KJa/dCXGr1oCUl4wxiEI6/K1ZBOefY9dpdReCJNQpPvFtaT9LyzSQS+VY4AEUMW55/cStYNVoBZPjQZS2eFSCH5b8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X5WG1lYU; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X5WG1lYU"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-cc1cc97b84bso14191a12.1
        for <git@vger.kernel.org>; Tue, 01 Sep 2026 08:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788277989; x=1788882789; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=6dllLVuZeVpPrjdecSBEixYqoC6MYFsswZEtVXEe9ns=;
        b=X5WG1lYUied7wtwdfUQB5heqTKW3NwDj7N5e7axM7q9Cx+cAl8gEHaL2fZzlMrCFVP
         gwPRCNcDBZSu8ycsyPaNlwacvY/XHcqKytntDHKfSofiCwNzRGIu9W0i72nrlSlf4LuS
         2oE5hHyGGaa5i+ZjbF0ZFGdfx4U3rA8taFAEAu8liVaNN8wuQ6G5qMehwQE/+TRH2TO1
         +PdPEpsHD4sIO/W0FRB9Zjrz/iruJ3VrxeA9xCuo/WUMiERRpU4SoyrPuGu7T/6Y69oT
         XfEv6H9hVBnr4IPyS+hSdgNbuYfOV1g+yEujnNOsR65EA/vCFUXE4B4Oi8m9rMsT/odD
         U7pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788277989; x=1788882789;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6dllLVuZeVpPrjdecSBEixYqoC6MYFsswZEtVXEe9ns=;
        b=n4dfb6TDGo0Mljr8oQPuKM/zHpxqaR1XPxtuCWr3vPw7cCnRK7fNo1PyvZ8ljUav9q
         QwFty6oBuC9K/AB/mrcP5BmHJUO/298rGLPTDqVFkFz3gTSSlgca/AYaJO9ETbiGyECt
         9sjkZL0cUt3HoXWyaFeusRiQIjsJZ3/4nAfh1vPtWdXn+u1Te0z1lZ7l+gbPN/8I3Aof
         G+UWrdHS+nhuppfALz74EUKb8H/GJ0AAUW8oVchkRLlY32flgpA9+hvoxboitoF5qfoX
         j5aUxeNz3ii7YFIwW1Gwz/do4SCBOa9YX2gLbG/JF1AzKVzQrJhL5n8wXJWam7CFZsav
         0TDA==
X-Gm-Message-State: AFuF++k5kmc+c7v9mYzI/B9YGAZYdLbNF5F9d+aXGKuH2NclBRtOnyDT
	MQxpW8hr04ynUWuWZLKZVthErgLkh4m/L5ACxnn3Wz5lbg7zQjQj7ojKMT0zhw==
X-Gm-Gg: AYBFou3BUdqBgQZOg0zaWUTMIFtwTKaz85Yh9t3mDlFETPY8/Q7fhoQ7sqZZldSMIsg
	PhWtuvJ2FTHfHfuj1I6Ge2n1hrUUxn0EWR/GWsiGW6BMrpfWOC2DnbDVv58Moa0NMpS1p5ya2Uz
	LKX8hs1MO9K5a//BLsw0B/2RD5nBMEReIC7Eow7bUa9Au5s9O4GY9vLmDq8zce/PiklspW63onC
	bC7tk7eOnH+2Z1FlLiCI9kciUUDKgher2ph54qR9AU+JikUZydxba0WVuyOCEuImmr5Z5cvSmwd
	8N6Ja/Br1vvITeDEh1TAAcY4xhXghAn/UpV1n7gRQHJwh0zaMxz+4NjgqoqhDBLwZZpGbMZk1uR
	86B6+IfD1UEbVQNcA7M7Ehr7+X2sdkC3D1FMMkkN8RFX1Bqh76sI++pL27wf+k4uZnVy9R4ylzW
	Gca/pxGmg9ZnHx9ydaFn09wmZn7fOo97vZAgImozTG1d/AY03wdTEe5SMD1VV2rsxDCJa5b6E=
X-Received: by 2002:a17:90b:2888:b0:37f:e326:6557 with SMTP id 98e67ed59e1d1-39907ab0ea1mr13670048a91.4.1788277988486;
        Tue, 01 Sep 2026 08:53:08 -0700 (PDT)
Received: from [127.0.0.1] ([57.154.3.146])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-142e0d2e465sm60338986c88.4.2026.09.01.08.53.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 08:53:07 -0700 (PDT)
Message-Id: <79396d491fe15c94a4e4c079d1109b425dcf966a.1788277983.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2171.v5.git.1788277983.gitgitgadget@gmail.com>
References: <pull.2171.git.1783479584.gitgitgadget@gmail.com>
	<pull.2171.v5.git.1788277983.gitgitgadget@gmail.com>
From: "Michael Montalbo via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 01 Sep 2026 15:53:02 +0000
Subject: [PATCH v5 2/3] t/lib-httpd: make http-429 first-request check atomic
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
Cc: Patrick Steinhardt <ps@pks.im>,
    Michael Montalbo <mmontalbo@gmail.com>,
    Michael Montalbo <mmontalbo@gmail.com>

From: Michael Montalbo <mmontalbo@gmail.com>

http-429.sh is a helper for testing retry logic. It uses "test -f" to
check for the existence of a state file and later uses "touch" or
"rm -f" on that file to determine if it should return a 429. This method
of managing state can fail if the helper script is invoked concurrently.
However, this failure does not currently manifest itself since the
helper is invoked sequentially.

As a preventive measure, fix the state management logic so it relies on
an atomic mkdir operation to mark that a 429 was returned. When
$retry_after is "permanent", always return 429 now that we do not rely
on a state file that is "touch"ed and "rm"ed to indicate when to respond
with a 429.

Signed-off-by: Michael Montalbo <mmontalbo@gmail.com>
---
 t/lib-httpd/http-429.sh | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/t/lib-httpd/http-429.sh b/t/lib-httpd/http-429.sh
index c97b16145b..1a5d7987db 100644
--- a/t/lib-httpd/http-429.sh
+++ b/t/lib-httpd/http-429.sh
@@ -3,7 +3,7 @@
 # Script to return HTTP 429 Too Many Requests responses for testing retry logic.
 # Usage: /http_429/<test-context>/<retry-after-value>/<repo-path>
 #
-# The test-context is a unique identifier for each test to isolate state files.
+# The test-context is a unique identifier for each test to isolate state directories.
 # The retry-after-value can be:
 #   - A number (e.g., "1", "2", "100") - sets Retry-After header to that many seconds
 #   - "none" - no Retry-After header
@@ -26,14 +26,16 @@ repo_path="${remaining#*/}"  # Get rest (repo path)
 # The repo name is the first component before any "/"
 repo_name="${repo_path%%/*}"
 
-# Use current directory (HTTPD_ROOT_PATH) for state file
-# Create a safe filename from test_context, retry_after and repo_name
-# This ensures all requests for the same test context share the same state file
+# Use current directory (HTTPD_ROOT_PATH) to hold state directory
+# Create a safe directory name from test_context, retry_after and repo_name
+# This ensures all requests for the same test context share the same state directory
 safe_name=$(echo "${test_context}-${retry_after}-${repo_name}" | tr '/' '_' | tr -cd 'a-zA-Z0-9_-')
-state_file="http-429-state-${safe_name}"
+state="http-429-state-${safe_name}"
 
-# Check if this is the first call (no state file exists)
-if test -f "$state_file"
+# Check if this is the first call (no state directory exists), or if
+# the retry-after-value is "permanent", which indicates a 429 must be
+# returned for every request (even if the state directory exists).
+if test "$retry_after" != permanent && ! mkdir "$state" 2>/dev/null
 then
 	# Already returned 429 once, forward to git-http-backend
 	# Set PATH_INFO to just the repo path (without retry-after value)
@@ -52,9 +54,6 @@ then
 	exec "$GIT_EXEC_PATH/git-http-backend"
 fi
 
-# Mark that we've returned 429
-touch "$state_file"
-
 # Output HTTP 429 response
 printf "Status: 429 Too Many Requests\r\n"
 
@@ -67,8 +66,7 @@ case "$retry_after" in
 		printf "Retry-After: invalid-format-123abc\r\n"
 		;;
 	permanent)
-		# Always return 429, don't set state file for success
-		rm -f "$state_file"
+		# Always return 429
 		printf "Retry-After: 1\r\n"
 		printf "Content-Type: text/plain\r\n"
 		printf "\r\n"
-- 
gitgitgadget

