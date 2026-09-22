Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63024369D7D
	for <git@vger.kernel.org>; Tue, 22 Sep 2026 04:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790053068; cv=none; b=kFA/M0ckBrnXAXrJKuNuE7n5lZXfdJwPhoVA1OXzi6emSKr38DhY1+17p3ILdOGRyUVibiPhkHmYLUNo1OjdVgaQ4SJywU/pOTRreRTGH9Wez1tA8/GHxgNRBCj3a3Oh7jR6Lbqxyanf+RHBYAQ5QSDDx3g8fFhi50WNKR5Uad0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790053068; c=relaxed/simple;
	bh=67QOIa9TS3OqAwPWvy5Gj63l6sJiGG0rzxwS+bLHFM8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KFjnjDDnUIVae2hTvUwntdlS2xOQHEv0SKkKhlyRbVvHnEKIDu3aC0SiOSPZj6miTYbh2L+UkEPM8hJYn9qdNoggccXGNql6HxFlPPqohbZet+8yt7ybNgwEzrcKAa5KRvezHwYoB96ychyFfJ+F0DLZnjxXUkcceJ10M3/cck0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=GZ52FwVR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=s9qSNCaC; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="GZ52FwVR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="s9qSNCaC"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 7781D1400167;
	Tue, 22 Sep 2026 00:57:45 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Tue, 22 Sep 2026 00:57:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1790053065;
	 x=1790139465; bh=n/QgxlfjbTu8bPTYVclCCn1iZXEReqFtOUH2PQKG9sU=; b=
	GZ52FwVREuPlaVVFqN/uRRigjJCx8jRX6LW/IEYWfrCXl3yvMdDgYkLXxEmEoRBM
	mmR922GLGlmgj9pZTm4FTWxpZh9cnBsWaBF2gy8Pwcvy1QDMT/GRBBHBD/6M+x8+
	6q9gODroM7bNf6pq9vV/xe3QCbNBB+2PsJK9S9qCexuvoBUBLqn6xPWh3CM1pxBv
	dmeDBcoIyw11hyZMEj8WG6ptSZjRedu23ssocUJblQZ0ssh2h84Ej1vRFOFP8iZk
	CLeJ95N2ajs88ig0DC4qVLRHqfV0JoMIwY91m8YLo+3wLnOWjGcF3mQGBElxYQ9Z
	0wWhUOcebxzceEVWgn3m/A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1790053065; x=
	1790139465; bh=n/QgxlfjbTu8bPTYVclCCn1iZXEReqFtOUH2PQKG9sU=; b=s
	9qSNCaCH9I9t1ImQxwydPJeKUe6AguEcS+AsonV9d3rZ138IyrQYMrk/WgA13pW6
	CRFoKy1ulIDUcw9bNPLFkehzAIogMftMYrEu3qXfwKYoLVw5tzVDx3tGKaP8nBZy
	UidKbxjx88YLnk1Hce7pKhC0h8LUeCefw1cq1kznc05G3MdOQ4AoIWGAbWn3saqc
	tLpItKaIhgwI4ASvPPwpgmp8EMQLuUt4HIiwoLdIAUurV32rNS+64JT50sIxzZVy
	+sLPN4CKtqlaIiYWs9vswRiq2CAadg7/51/Ift/sKJjdWSLre1k6Kc0pKOJv3iBB
	qQUKqckEWQWfC4tfOL+GQ==
X-ME-Sender: <xms:yQqyalGscck2REOy4cLpnoOH00JwKstfkFMPeKoMwyAMdUank84YUQ>
    <xme:yQqyaviyISdgHwLCOnnO-i0cLJNaEOG26nDOf7B5VNfaDUJXz6yhW3210_H0zuIhQ
    HmHV18y99hElz7EVsER4beZoyXfHYCdXDjhhwjIslJmOqTj7uvw8A>
X-ME-Received: <xmr:yQqyaoABfN2_oZkedI5WCCZ8VYlVaT_5aHMdj-7kh4Lg_zb-lmSQd1DWDVRMo5w8VC6J2hjtKO2Co779U4yJQ5cUAuUbDfsx3Vqi>
X-ME-Proxy-Cause: dmFkZTGe5fSUPM59nSidvQ26g4YqOd8aoihJD2BibIbJLBs85e8pRWEaM5ij8NI2CkVSya
    kgsImjw+mIJmCpEHU5X/7BkFX6cQ3LJ2e/6OBtfxuciq76/WJ/txSXhFAPq1/4dh/6hPK0
    rzvrKj+abG/8ydwoqeYTjObJQBjJuzko/C0gMo+2iX/vty5WZku3dpXZNB8O6Yh3AIIB/O
    pwm+BmqmfkoV3UNQZIRc4T6s89GbRS4HWRn99AYZG+1Z65rWr/I2FAjbHoXEWU+IW28r0/
    kK1zhnuUqldZbZZv3ufJt9uto5UtrO2Po9bVpveGj7tNk+qJMNRFHF/Z85fIz69Byz8YJ9
    FtL3CR8IFPXtjpSwiiku3Uda9TtXHMcpKwIAiiv0PmqiPdhJWbcgkIBInQovGxuTc1w5V4
    ux4dxesG2qfZtUQOJX+054IJFhXYdIlI+la1UzK46QNGeDL8ZdSwZnMqG0LAGjwdJ1iiyP
    lz5QPZVKrFM0mN2wqYIjsz08/F74+65fmJrcHeKVtNBowxeABMT5wIwhDIJeUTYSyYHNwQ
    pAMMq+E2uB8JsiYBnTmW67OmEulcuAatCN1QCyiaglsEeg26AR/r1knRBgbE8M6fCsDtst
    jz3kAYfrWT2YGmTvsLIWjWmtDYkdRg/4+6Lupbi1pkK5bZ5TrqT3XXK5ykAA
X-ME-Proxy: <xmx:yQqyahT06Js2I5oP3QDcfRfLUVQV5aaJ7bHox2XCtaxijN7LnkWOZw>
    <xmx:yQqyatXEnTqPVETLDz4uAfD6_6kTfbZjfh2ocMBBGHg6DNGV25JD8Q>
    <xmx:yQqyaqcBfmWIkMQMZ_DEpH0zYk9kNwCGIlccG0u_4A3rlMLEC3TITg>
    <xmx:yQqyapJzo9GdQig-_NTKwu4_8WGeTeuJimXhLVJoefKQX0Z3AmRu-A>
    <xmx:yQqyat0WoufIOMniMHJCfV6Vgpfmha8rkOQzTltNUa2X_x_UsclU9cEs>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 22 Sep 2026 00:57:44 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc: git@vger.kernel.org,  81625@debbugs.gnu.org,  Lester Longley
 <lester@ieee.org>,  Sean Whitton <spwhitton@spwhitton.name>,  Elijah
 Newren <newren@gmail.com>,  Martin =?utf-8?Q?=C3=85gren?=
 <martin.agren@gmail.com>
Subject: Re: [PATCH] dir: skip excluded directory with nested repo on prefix
 match
In-Reply-To: <be53c379-b0e1-4242-8504-e96c2c49d294@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
	message of "Fri, 18 Sep 2026 13:04:06 +0200")
References: <87ld94klhf.fsf@athena.silentflame.com>
	<be53c379-b0e1-4242-8504-e96c2c49d294@web.de>
Date: Mon, 21 Sep 2026 21:57:43 -0700
Message-ID: <xmqqjyodj320.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

René Scharfe <l.s.r@web.de> writes:

> +static int dir_match(struct index_state *istate,
> +		     const struct pathspec *pathspec,
> +		     const char *dirname, int len)
> +{
> +	return match_pathspec_with_flags(istate, pathspec, dirname, len,
> +					 0 /* prefix */,
> +					 NULL /* seen */,
> +					 DO_MATCH_LEADING_PATHSPEC);
> +}

OK, this is a good helper to extract and reuse.

> @@ -1996,11 +2006,7 @@ static enum path_treatment treat_directory(struct dir_struct *dir,
>  	 * for matching patterns.
>  	 */
>  	if (pathspec && !excluded) {
> -		matches_how = match_pathspec_with_flags(istate, pathspec,
> -							dirname, len,
> -							0 /* prefix */,
> -							NULL /* seen */,
> -							DO_MATCH_LEADING_PATHSPEC);
> +		matches_how = dir_match(istate, pathspec, dirname, len);
>  		if (!matches_how)
>  			return path_none;
>  	}

So, this hunk shows that the treat_directory() function is prepared
to be passed a NULL in pathspec.  We make sure we do not trigger
match_pathspec_with_flags() when pathspec is NULL, and this should
extends to dir_match() now.  This is a very sensible conditional, as
match_pathspec_with_flags() calls do_match_pathspec() as the first
thing, which begins with GUARD_PATHSPEC() macro that unconditionally
dereferences the pathspec.

> @@ -2034,8 +2040,13 @@ static enum path_treatment treat_directory(struct dir_struct *dir,
>  		strbuf_release(&sb);
>  
>  		if (nested_repo) {
> -			if ((dir->flags & DIR_SKIP_NESTED_GIT) ||
> -				(matches_how == MATCHED_RECURSIVELY_LEADING_PATHSPEC))
> +			if (dir->flags & DIR_SKIP_NESTED_GIT)
> +				return path_none;
> +			if (!matches_how)
> +				matches_how = dir_match(istate, pathspec,
> +							dirname, len);
> +			if (!matches_how ||
> +			    matches_how == MATCHED_RECURSIVELY_LEADING_PATHSPEC)
>  				return path_none;

Here, we do not know if we have pathspec==NULL.  Shouldn't "make
sure we have a result from dir_match() and return path_none as
appropriate" be done only when pathspec != NULL or something like
that, since dir_match() will crash if pathspec is NULL?

Taking all together, something along the following line squashed
into your patch, perhaps?  The newly added test is not essential; it
merely is to demonstrate why an extra conditional I added below
would help avoid segfaulting.

 dir.c                      | 15 +++++++++------
 t/t7061-wtstatus-ignore.sh | 25 +++++++++++++++++++++++++
 2 files changed, 34 insertions(+), 6 deletions(-)

diff --git c/dir.c w/dir.c
index 6bda650891..8e858c26d1 100644
--- c/dir.c
+++ w/dir.c
@@ -2042,12 +2042,15 @@ static enum path_treatment treat_directory(struct dir_struct *dir,
 		if (nested_repo) {
 			if (dir->flags & DIR_SKIP_NESTED_GIT)
 				return path_none;
-			if (!matches_how)
-				matches_how = dir_match(istate, pathspec,
-							dirname, len);
-			if (!matches_how ||
-			    matches_how == MATCHED_RECURSIVELY_LEADING_PATHSPEC)
-				return path_none;
+
+			if (pathspec) {
+				if (!matches_how)
+					matches_how = dir_match(istate, pathspec,
+								dirname, len);
+				if (!matches_how ||
+				    matches_how == MATCHED_RECURSIVELY_LEADING_PATHSPEC)
+					return path_none;
+			}
 			return excluded ? path_excluded : path_untracked;
 		}
 	}
diff --git c/t/t7061-wtstatus-ignore.sh w/t/t7061-wtstatus-ignore.sh
index 182933471f..6bc680312e 100755
--- c/t/t7061-wtstatus-ignore.sh
+++ w/t/t7061-wtstatus-ignore.sh
@@ -340,6 +340,31 @@ test_expect_success 'status ignores submodule in excluded directory' '
 	test_cmp expected actual
 '
 
+test_expect_success 'replace directory with untracked nested repo' '
+	test_create_repo checkout-nested &&
+	(
+		cd checkout-nested &&
+		test_commit base &&
+
+		# Branch with tracked file "dir"
+		git checkout -b branch-file &&
+		echo "tracked file" >dir &&
+		git add dir &&
+		git commit -m "add file dir" &&
+
+		# Switch back to base
+		git checkout -b branch-nested base &&
+
+		# Create an untracked directory containing a nested git repo
+		mkdir -p dir/nested &&
+		git init dir/nested &&
+
+		# Attempting checkout invokes verify_clean_subdirectory()
+		# with pathspec=NULL
+		test_must_fail git checkout branch-file
+	)
+'
+
 test_expect_success 'status omits excluded directory with submodule on prefix match' '
 	git status --porcelain --ignored -u tracke >actual &&
 	test_must_be_empty actual
