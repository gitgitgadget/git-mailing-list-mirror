Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4C343D333F
	for <git@vger.kernel.org>; Wed,  9 Sep 2026 19:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788982874; cv=none; b=eekUJdp7OMtCXUI3OU1v8WGszWZ1elyPNp0GCUV43omQ4jDalV3puz0vZuE0uM323POuj9S1lO4KD6qZGI6yr7c1AOpc1D37sldx0MjqqHlJoK0Xvn2baeu6T/hIZOJGtFniyKTFDir0CQ9GheLx3UEEAliQaUotaYl760U/hCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788982874; c=relaxed/simple;
	bh=zSBVBX/3H13Ye8MFdeLM6JQhiSwuKLbOFybETEy+fsk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CsMunru5IOjZDTlT7otZbRLx6hEZFFCoQjQAgE6Ij2saKDK3nbWoGFAXss2W7hIy1y5lEroNsnnEMi1e8WLE6TpRn2FYZNtqmD15096SSXCHJLoMsm2eouot75066umWZIlDy8TkfHzvi1Wk9othJ1wjEeLSjJJ5eDzWjz/grU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=bf/xT/uL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=i2uv+JEi; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="bf/xT/uL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="i2uv+JEi"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id B15CE14000AE;
	Wed,  9 Sep 2026 15:41:11 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Wed, 09 Sep 2026 15:41:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1788982871; x=1789069271; bh=HmdZIWkzrZ
	ns37dLwcczk/5Vpzi0DTHu8lXxqQduBQ4=; b=bf/xT/uLO4ifSdT4WkDCbSleQh
	mmInWOy4gxkI9SjZRYGEKzPEMnPU0R1uP/tTYfcSQSJzKtmM9bZQTb1c6XYItH8f
	fkyyzPhttgiGz9fNRtyUqz26iSlxdVvWn3rvm2QXecMbbpO83GyjX/65k+pSfXHl
	qyUhO0XDlQ1M2uEuFNQPvzkPzRGBJqkFyoBPUtFXZcxz63tpe3kKF/Da6a8dspgC
	lkellqPf/mFmSGcC1WVctcWhaqyyNesWFDI8YyN6eqhxg1daBcGCc0jRHBGEMKRO
	6lx3ulfSMrcc00PVvQeQmfsjaq7ZhVKgfe7Y2kUphhk4dDqrh1HgYLmWqUXQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1788982871; x=1789069271; bh=HmdZIWkzrZns37dLwcczk/5Vpzi0DTHu8lX
	xqQduBQ4=; b=i2uv+JEis745talr+Uw0q12c21M12YMMBySMRWOOpAiFYii0INc
	EFj7Usz1f/uySy7+fpQr3N0GBdEkzhi3V8SnKwNWLDW2V/HgwB4uKpXpQ2Pxi0h5
	tw9IhWRfqirmrmiQH0OZIMBIogibioFyYMrJMgvguNmxTVC6631NKYGcNLlXhm7A
	6HWnhiact+PCRDWKK7N/O3/SCrzFOfXQceBkh0EbdsMs5gEq8eGtvqrQ7eF5Oowt
	TAe41Hj4vRY7KiXEakpsWdsmw+4231/v0bVCLzCBh5HSKuKhZdQW/Th2M42RQ8ir
	MW38dnkpKNn+Ar+COgwNcSPDJKcZWdWKQiw==
X-ME-Sender: <xms:V7ahar-gkSZYfdmRO0uyPFgIa1rP21Rr5rIZvFsCPUJ8mFnk9y1i5g>
    <xme:V7ahaunxrS-5lCCJtUnayFtU_LzO13Q6q5vd_spnkSWoPHzM-3Gs-Wdk43hXk_Imz
    PjnGAs7oAsrfIeMxFjC7cCX8PXWuHw5K8IV2Tis22YesmCu3n7y5Q>
X-ME-Received: <xmr:V7ahahXpRUh3Eme_Dc7x_VcnQ9xPKcS0fHBQwhjfPTIUehE0jubIxXK4jzBSR6z8RDhzZcxlsSA0kHwsM0PQzH6ZeBCjvwzmfKeE>
X-ME-Proxy-Cause: dmFkZTEHLS3mRNabpp0S3l8mp5I7SSKIQ/L8UJto8nE53tkiBgEHqzRSWXCEDF7z05hk4+
    w75cS7qarNAwd8nQlYWvbC4MnLpGDlTP3f/M7cc2gGf3UYU9lZoAU/ptA2xR9iv/snulPk
    wuDSfNV9GQ0lNwj363WAMsI7P2h/WvOszT8ugFwDUQ++FdUwP1w4O9ReVk+uRFdK4wc6OR
    U8qXsEO2OP8TOmkDenbE4Y0N3TgyHTypxnrsf6d16VYz+0s+aeXX8rRMdaKTQzocgIxmSt
    9jH6oZ9VI9FEwwbGAa+fgTOcTzp4F0VDurdlDseleSqTl08NFNUPINRIQGOZ8giMmWgpF/
    CEY6rlekbMXwAymc6xm++Fti0HEchHtTi+fG3iYUDZOHpjx+4tiAiBM/njruLyEqFE7GtI
    dH3f5C88xzujnUT1apmWi/HBWHAR8P3WzHIbrKIx8kKYamPqmJP3J9PH0/+QpWH7vs49oz
    er+jSMp86Tbdb7QA9tMDCB465ilDVYrNkvr0TPGYiZC77Br55HxHsH4d2CqUnNY4g2jJzp
    kI4mMstbPKGgpVvY55YKNzXtlVoqx1398JZj3SVWMzJaEqflAdw/o9cWVM8zTr6VNO8+Hp
    UfhzuEtscB0vz2BRoy+3msAzZPzGs1RAdnmpdt3WLmlvbA7/tRCJbOn/HN+g
X-ME-Proxy: <xmx:V7ahajFGKjDYAV3TfX6iNV9CkgDqlVe2lzkUEBmdrVFic_cxlzzuHA>
    <xmx:V7ahatelUeVqgQ7Ij9_DDR4fv3bX2bi-hiLQjDQcrRVTEXF58s0Gyg>
    <xmx:V7ahakIg81ZnKsSmPT4j39lqI2P_v-o1Kxct9FxKoZ6nB4YHMX8vpA>
    <xmx:V7ahaiFQkcNh3VnEFvRqN7dFH6qpE7m62HnoXjIPP2OGyzWVjVh3vg>
    <xmx:V7ahaoZI_HqC2QGS2bUh_VYLYbBFNa7WPK8PBBfds24ZDUh1eyCv7rS->
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 9 Sep 2026 15:41:10 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Johannes Sixt <j6t@kdbg.org>,  Johannes Schindelin
 <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v3 12/12] mingw: allow `git.exe` to be used instead of
 the "Git wrapper"
In-Reply-To: <4a4f24a1ba0fce48dce8f77737a5153cf304aa2c.1788981436.git.gitgitgadget@gmail.com>
	(Johannes Schindelin via GitGitGadget's message of "Wed, 09 Sep 2026
	19:17:16 +0000")
References: <pull.2195.git.1785939999.gitgitgadget@gmail.com>
	<pull.2195.v3.git.1788981436.gitgitgadget@gmail.com>
	<4a4f24a1ba0fce48dce8f77737a5153cf304aa2c.1788981436.git.gitgitgadget@gmail.com>
Date: Wed, 09 Sep 2026 12:41:09 -0700
Message-ID: <xmqqik4eqkkq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

>  t/t0060-path-utils.sh               | 30 +++++++++++++

> diff --git a/t/t0060-path-utils.sh b/t/t0060-path-utils.sh
> index 8545cdfab5..02906055d3 100755
> --- a/t/t0060-path-utils.sh
> +++ b/t/t0060-path-utils.sh
> @@ -611,4 +611,34 @@ test_expect_success !VALGRIND,RUNTIME_PREFIX,CAN_EXEC_IN_PWD '%(prefix)/ works'
>  	test_cmp expect actual
>  '
>  
> +test_expect_success MINGW,RUNTIME_PREFIX 'MSYSTEM/PATH is adjusted if necessary' '
> +	if test -z "$MINGW_PREFIX"
> +	then
> +		MINGW_PREFIX="/$(echo "${MSYSTEM:-MINGW64}" | tr A-Z a-z)"
> +	fi &&
> +	mkdir -p "$HOME"/bin pretend"$MINGW_PREFIX"/bin \
> +		pretend"$MINGW_PREFIX"/libexec/git-core pretend/usr/bin &&
> +	cp "$GIT_EXEC_PATH"/git.exe pretend"$MINGW_PREFIX"/bin/ &&
> +	cp "$GIT_EXEC_PATH"/git.exe pretend"$MINGW_PREFIX"/libexec/git-core/ &&
> +	# copy the .dll files, if any (happens when building via CMake)
> +	if test -n "$(ls "$GIT_EXEC_PATH"/*.dll 2>/dev/null)"
> +	then
> +		cp "$GIT_EXEC_PATH"/*.dll pretend"$MINGW_PREFIX"/bin/ &&
> +		cp "$GIT_EXEC_PATH"/*.dll pretend"$MINGW_PREFIX"/libexec/git-core/
> +	fi &&
> +	echo "env | grep MSYSTEM=" | write_script "$HOME"/bin/git-test-home &&
> +	echo "echo ${MINGW_PREFIX#/}" | write_script pretend"$MINGW_PREFIX"/bin/git-test-bin &&
> +	echo "echo usr" | write_script pretend/usr/bin/git-test-bin2 &&
> +
> +	(
> +		MSYSTEM= &&
> +		GIT_EXEC_PATH= &&
> +		pretend"$MINGW_PREFIX"/libexec/git-core/git.exe test-home >actual &&
> +		pretend"$MINGW_PREFIX"/libexec/git-core/git.exe test-bin >>actual &&
> +		pretend"$MINGW_PREFIX"/bin/git.exe test-bin2 >>actual
> +	) &&
> +	test_write_lines MSYSTEM=$MSYSTEM "${MINGW_PREFIX#/}" usr >expect &&
> +	test_cmp expect actual
> +'
> +
>  test_done

The previous iteration had a "while at it" style fix to another test
a few lines back, which is the only difference the end state of this
iteration has relative to the older round.  The movement of part of
[8/12] to this step is logically correct (even though it does not
show in the end state, of course).

Shall we mark the topic ready for 'next' by now?

Thanks.


diff --git c/t/t0060-path-utils.sh w/t/t0060-path-utils.sh
index 56faf5fe73..02906055d3 100755
--- c/t/t0060-path-utils.sh
+++ w/t/t0060-path-utils.sh
@@ -602,8 +602,7 @@ test_expect_success !VALGRIND,RUNTIME_PREFIX,CAN_EXEC_IN_PWD 'RUNTIME_PREFIX wor
 	echo "echo HERE" | write_script pretend/libexec/git-core/git-here &&
 	GIT_EXEC_PATH= ./pretend/bin/git here >actual &&
 	echo HERE >expect &&
-	test_cmp expect actual
-'
+	test_cmp expect actual'
 
 test_expect_success !VALGRIND,RUNTIME_PREFIX,CAN_EXEC_IN_PWD '%(prefix)/ works' '
 	git config yes.path "%(prefix)/yes" &&
