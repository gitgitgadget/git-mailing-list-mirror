Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE3B03B2FCD
	for <git@vger.kernel.org>; Mon, 15 Jun 2026 08:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781511129; cv=none; b=JiFGDqOx+usPB4nM5hffICJplM37AE0rkPTol4Sb64rvrHCAPKOlXtvB13msVRJGYp9F7glKeBmmEKk1PIrc3c0C7bmuPJzVifChNuk1naEkqoBWskcli8kC832cAXtc+HiyihL+piGUdQZejFw/mrvTmcfj8Ig2i+T5glOZBfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781511129; c=relaxed/simple;
	bh=IezdxnwAEJ6E0enOqZwDDrTLGIGXO3prJndQjAC4yGY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BjFWRtaHFjHV9QudHBif2mmwleLl+GDVf1Nhg6yymenjyy034DJnEnJ0T1p2M5eSJhdahc82LXgoHfQ4vRfoJBNo5mRjv6mfRLrmbErvhbzoArn0jJA0zyC5GDLRrvThePOWL4JQAvD2d/h45eLwo8ZXDBJhI0NVp+nXdbL7WwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=NcYIItDV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Bv0KFsHb; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="NcYIItDV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Bv0KFsHb"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 2CB001D00059;
	Mon, 15 Jun 2026 04:12:07 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Mon, 15 Jun 2026 04:12:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1781511126; x=1781597526; bh=fgsMyRnauR
	TJhyXid83Mti+JvmA+9/iDC1in/xTq4hI=; b=NcYIItDVeioUlrJ7YrjibhzX+J
	enX8s89PxZDwwYBh69cc/FxYJiax5gsaTdhPohvjm+0JIAJJRziq4UtowC7bZmQa
	TclS4qcZcXkQsmodjWFJvWTvLs0gAxOjma2N3/77V/WCr+DbDthJZnKMI/hPDs+S
	2OQ1mQ8XT2Ni3dfZaqXdQdv1INh2Ej3OZMuWSUiC1VTrIIjFEz/72VhvUHosdFkd
	EwGm4JeCdY4PK+/lcBN2wQISyMgK4AXMlJiSYTkZ+IsgX10CZX8XGPUVaHLjtXio
	Shs0P7R7Jzn/spZw30D0nSuVytE0rtvgQYCw2f8TRe8fJTc6qN3WlpplKx+w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1781511126; x=1781597526; bh=fgsMyRnauRTJhyXid83Mti+JvmA+9/iDC1i
	n/xTq4hI=; b=Bv0KFsHbcWjj48zpxpSB/ppn4ThxPE0c198KnLcBjouFXxBcXGt
	1/ht9O6IV4AkslwecR3vGY+Q9zhq497UYr9dVaBdueElvV1EHL295fNiGVvBqqlL
	t2vgGlBaRH1jDJgfsxmrsZp7eBy2dKjkEvajdCrV2CLCiH5xNV9n6L4Jd+VPjSiW
	CI8xySvWt4KHcvAfRq8pCrIqX77KOORE4BeYRcXWOyC6uOXgVe2yJ6HN/TTiJcmZ
	7s2uzGS8xGZLiNeObgElELkUj51/FIN941fZI98jxVW6TsC4zJ3dlRxVBCRremtv
	Fx6cCKvL6cava7GuTm4E/sT67tjfz+MwEFA==
X-ME-Sender: <xms:1rMvaksMz8N3nvzFUEbIQsIOoPDBY6bhZX2Iihvi64TpC6hnuwI7pQ>
    <xme:1rMvakum1ffBlSw7RyMDcOcu40AUPVVYrVeabqIpeiNiPNciX63V_9YP854FeMJ8O
    GkxjgRwFjEEiqeKy3Kl5r_bu1eoGW1oa2f54hNcfjESzNZJ0Tk2lio>
X-ME-Received: <xmr:1rMvapOzTblB-wF1uS5a2XMM_g_w3vIIJ_uYZLjP0vaKogNMQRWfxKV17LoWEF2XLJtd9d00j_nn7lAcrod5gw6T85NDheHcA9Rfg91gmg>
X-ME-Proxy-Cause: dmFkZTGIGgM4E5vOXhoI5hRgHr0FcA36WWVRl8GPXv92kHIRweqkGWvt10MrYdA6UDkMEk
    OjApaYRd0UtWbAlQzmBPh1i0ZonPhD6+gIo7gmozU9baOhcnEBbmwconnoDOqQnt+lGAH1
    PCofaFDQdNTIDdi0yxbe99YqnfkmfSThy/H0tzd6r5j7Q8vlDXVfhQJn8PYn6kfWoGXdOu
    HLDPXmXtEbg/fam2PUEvPGFu6ZwZNQ/2EFMt9Rk6dalcE/gGK5SmdHWUFGRJJfKOETZzsA
    7yP0N0HuS212nJxhS7cR7KxlxzgQar1sV9vApHxyR75Rkyeh1KiyDtTYj9VfyXBEl/PeMV
    TdwWVlEI4HQG8HREGDH1DBlmDJahNNXIdeyOcOUwfWLgKVtpwa8BRXAyqrdLADItCHBaIU
    e+R9QQ5XByBFJBJiwtMUdzSQpbRP4htllWv3qf/3SK11UPwF/M3T4syoMkB5CPd0JKNvOP
    A2FXmrHRlKB+Pp2SscC+UCJUVRPezWRXBjUtvqEGbHZowjCmJ6R8jmAfkrhDGM335QmSvK
    AjSdrsmGNq2zEJft2cp9DClKLksxsHckg8fHeyR9LCTojSQGxuuC/ZnJPeiW1j18Imd69p
    Pb7vt8HfEGOSp5zjQVFlz4cUdLOrGzWMznGKU/D+QO+dfMv0X7wDrXdJJgLg
X-ME-Proxy: <xmx:1rMvai0DUSUyxczkugBKkD_tcH3PCBABckrMbdWxj7VO_QOCSDiEOg>
    <xmx:1rMvalNJZqri1t7Ll_dq6vBR0f1tn8lcddNwTLEZr76r6Vrq6OjAMA>
    <xmx:1rMvai3UxHNOmrf1K-nU2vluIOkhhIUQYx1_Z9HYu_gh2JHqHn7A9w>
    <xmx:1rMvasGFGSS6RUqhQO8hEyjmygidfD4VdUNsTDcJqLGtVuJHbKx9ew>
    <xmx:1rMvagOWHGIoW0b-GJFpPPv0d0FozZ5wQxoyGMVdGld0ge3IAZm7lhgY>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Jun 2026 04:12:06 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 7b15f866 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 15 Jun 2026 08:12:04 +0000 (UTC)
Date: Mon, 15 Jun 2026 10:11:57 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH] commit-graph: use timestamp_t for max parent generation
 accumulator
Message-ID: <ai-zzWn9Ls6-j9h8@pks.im>
References: <pull.2148.git.1781420271100.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pull.2148.git.1781420271100.gitgitgadget@gmail.com>

On Sun, Jun 14, 2026 at 06:57:50AM +0000, Elijah Newren via GitGitGadget wrote:
>     commit-graph: use timestamp_t for max parent generation accumulator
>     
>     We found a few repositories in the wild with commits whose authors were
>     apparently on a computer in the year 2120 when they recorded their
>     commits. Apparently, in a century from now, some folks are going to have
>     a really weird timezone as well (-13068837), though the timezone doesn't
>     factor into this patch at all.

I'd really be curious which other parts of Git will start to break once
we cross that threshold. Would it make sense if we maybe expanded our
linux-TEST-VARS job to create commits with a date beyond UINT32_MAX?
Something like the patch at the end of this mail. And yes, many tests
break with the patch applied. From all I've seen though many of those
failures are benign, even though I'd bet that there might even be some
"proper" failures in there.

Anyway, this is of course outside the scope of this patch series.

> diff --git a/commit-graph.c b/commit-graph.c
> index 9abe62bd5a..4b7156fd76 100644
> --- a/commit-graph.c
> +++ b/commit-graph.c
> @@ -1669,7 +1669,7 @@ static void compute_reachable_generation_numbers(
>  			struct commit *current = list->item;
>  			struct commit_list *parent;
>  			int all_parents_computed = 1;
> -			uint32_t max_gen = 0;
> +			timestamp_t max_gen = 0;
>  
>  			for (parent = current->parents; parent; parent = parent->next) {
>  				repo_parse_commit(info->r, parent->item);

This looks obviously correct.

> diff --git a/t/t5328-commit-graph-64bit-time.sh b/t/t5328-commit-graph-64bit-time.sh
> index d8891e6a92..bc651b69de 100755
> --- a/t/t5328-commit-graph-64bit-time.sh
> +++ b/t/t5328-commit-graph-64bit-time.sh
> @@ -74,6 +74,15 @@ test_expect_success 'single commit with generation data exceeding UINT32_MAX' '
>  	git -C repo-uint32-max commit-graph verify
>  '
>  
> +test_expect_success 'descendant of commit with date exceeding UINT32_MAX' '
> +	git init repo-uint32-max-descendant &&
> +	test_commit -C repo-uint32-max-descendant \
> +		--date "@4294967300 +0000" future-parent &&
> +	test_commit -C repo-uint32-max-descendant present-day-child &&
> +	git -C repo-uint32-max-descendant commit-graph write --reachable &&
> +	git -C repo-uint32-max-descendant commit-graph verify
> +'

Makes sense. Thanks!

Patrick

diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 809c662124..e78902b671 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -136,12 +136,19 @@ sane_unset () {
 test_tick () {
 	if test -z "${test_tick+set}"
 	then
-		test_tick=1112911993
+		if test_bool_env GIT_TEST_FUTURE false
+		then
+			test_tick=4294697600
+			test_tick_prefix=@
+		else
+			test_tick=1112911993
+			test_tick_prefix=
+		fi
 	else
 		test_tick=$(($test_tick + 60))
 	fi
-	GIT_COMMITTER_DATE="$test_tick -0700"
-	GIT_AUTHOR_DATE="$test_tick -0700"
+	GIT_COMMITTER_DATE="$test_tick_prefix$test_tick -0700"
+	GIT_AUTHOR_DATE="$test_tick_prefix$test_tick -0700"
 	export GIT_COMMITTER_DATE GIT_AUTHOR_DATE
 }
 
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 4a7357b547..54798fb3f1 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -558,12 +558,26 @@ TEST_AUTHOR_LOCALNAME=author
 TEST_AUTHOR_DOMAIN=example.com
 GIT_AUTHOR_EMAIL=${TEST_AUTHOR_LOCALNAME}@${TEST_AUTHOR_DOMAIN}
 GIT_AUTHOR_NAME='A U Thor'
-GIT_AUTHOR_DATE='1112354055 +0200'
 TEST_COMMITTER_LOCALNAME=committer
 TEST_COMMITTER_DOMAIN=example.com
 GIT_COMMITTER_EMAIL=${TEST_COMMITTER_LOCALNAME}@${TEST_COMMITTER_DOMAIN}
 GIT_COMMITTER_NAME='C O Mitter'
-GIT_COMMITTER_DATE='1112354055 +0200'
+
+case "${GIT_TEST_FUTURE:-false}" in
+1|on|true|yes)
+	GIT_AUTHOR_DATE="${GIT_TEST_DATE:-@4294697300 +0200}"
+	GIT_COMMITTER_DATE="${GIT_TEST_DATE:-@4294697300 +0200}"
+	;;
+0|off|false|no)
+	GIT_AUTHOR_DATE="${GIT_TEST_DATE:-1112354055 +0200}"
+	GIT_COMMITTER_DATE="${GIT_TEST_DATE:-1112354055 +0200}"
+	;;
+*)
+	echo "GIT_TEST_FUTURE requires a boolean" >&2
+	exit 1
+	;;
+esac
+
 GIT_MERGE_VERBOSITY=5
 GIT_MERGE_AUTOEDIT=no
 export GIT_MERGE_VERBOSITY GIT_MERGE_AUTOEDIT
