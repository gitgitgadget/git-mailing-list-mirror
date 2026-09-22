Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E13B157269D
	for <git@vger.kernel.org>; Tue, 22 Sep 2026 17:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790098062; cv=none; b=EkWvkQC4FSIsrby1e8ppeUIGPwz0l/BxkpfdJShXtpqEAXpSJScLf3Nhj1UUIEhIiSLdPiko1ZnAf6xr/DF40S78ZwsAqnrI1FkVZ06e+JAN1GJU6aNrzst5XxAJiQ6URVeEmnPgFWyg+1johbBA1dDOPeWB7SgrldTHPWKIKBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790098062; c=relaxed/simple;
	bh=wmwmg53XUVecS7vvM7F27MVISU8wC2OqeuI6urNt8cM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DYRnwMOlZBD4iWuMx2K5yndqfnsdFYj2xMPeuCdfd0hjQPZi2D0/n2zSXyAo7v7NaPccsTZIWLs8Grto7dQLW6ScfR1y+5jm7CezCEpHBuy1OlpXN+gJduMAn8rUzUlmE6Fh9cKJUcCqFr+w8MP0c8DwGGaDYoLZMPWSASUUzrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=OwoS1tm/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pZtYvE68; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="OwoS1tm/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pZtYvE68"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id EBB6A140014E;
	Tue, 22 Sep 2026 13:27:39 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Tue, 22 Sep 2026 13:27:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1790098059; x=1790184459; bh=kREVdz50I1
	EjawnCmQIaiLpZk1KapyQspG/wEFpqE9A=; b=OwoS1tm/8d7mHHrUpFIyhXuXt9
	ChpY59qYrcfH67gdT+JbCDQ0fV4umz/vlQ8wr/G9/H8jcGdRuoAr/HzEu45phDDY
	MtTQJJLSrAxgCnr1yvbrZaVvJwRjUyBjmPXSWXbBtiOFJANM0EP8oY5EhDJlZvBv
	HXxp0bMG1v0FcAoYGwikQT8mez4fe1zqBac+VYxItRc9Cnwt6g7wt2TferM1ZYLE
	+jvdcTe/puHfEWwuWKQnm48Qx7aQjK1HH3h5QmI8OdafKjI3ZG6lei0NQ9Aozn5B
	BfTszGNOnMzyntWRJoapBm7LNpCPMnwwxD8fGyrhROvslsOwrOL0FaZk1IEg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790098059; x=1790184459; bh=kREVdz50I1EjawnCmQIaiLpZk1KapyQspG/
	wEFpqE9A=; b=pZtYvE68vGXB4c++uTgBaMMrbg9up71IFR8rd3xAvsY4mDml6pY
	7VGUc9Ein9As+FVlWXVWDz7EMVSpEc+4KSjL2LUKA4ZpYG0YwqgriNdk8KJAvG+T
	nfXNwHjvp1tZ+WQFzVMdbLvOBRVJqJdDxF8pFgRYej3faEpNxGgjggXExRmhJYhc
	zbVAb4ad3vAr/ByGdTcZT3EPuN/fKWx5ik4rFTMrtBg5rGOnuCu59CQhOQ+asPlC
	+GqcpP0OGjs2ogWPh32WQJpqs72Vf9PTG4CZjEO7DxEE6qzXN6XYtVpUEZrIV5wR
	E3b6afuCwgMB7r9wJVmvmNpvsp3Hw6Y7/BA==
X-ME-Sender: <xms:i7qyamaDOydLFuzHM4swV5qO9ySJFBOQKHsl7FvWpRPCzshS-U2Bfw>
    <xme:i7qyatHX3bnoXCbjpu8DwY5WBjo68VcW94QcANW4DNW2-UkVaseXu1XKe0Y-JbZWR
    5REDH-h7hbhUqbQHCSwh47HCGKRxmd3e33BHTa7iMhSbp0nPyPznMo>
X-ME-Received: <xmr:i7qyaqwEyu7Dru33hRq74FncihgAPdQ5nmlPpDA6vYKZ1vSveRH4dWQFW-rfH5CBUQ7R074sfg5jp32R6i_9fGlLeL-TqkxuQWKs>
X-ME-Proxy-Cause: dmFkZTFLcY+oHKyMcOB8sw9R2QQKPgRJjisgy3sbc9+mlh1ZVZwu+9+Re9aTEciMm9iUjq
    aEG9uYVj1x5YqUGtgML6BqB1CLjc9XEOcqG8FswFd60pM0cYCrKkBZt15imUYvuq1HJE1P
    SKA4RX+CvvXXNUhx8R9PZ2TqlP9WVhWP7cSvCIbzTvWNPy35FM6BMr2aqkMCCxHmDRE2Am
    P7gncfCFfvzka/phR2SU8KanzAjwf7/dimQlIDvikZd6jBbga2TOoJI+KCYjN8R/ZNbZLT
    7lU4wnvXe52iGVCciICgIMBp+hJInLXcHPFRsBNmDEV+cQgvzU+bwGtiOklatd2qGxmoOi
    jDQRaJ5DxE7TrgIx8y4vJpWOVgd64ZuUJUc3J9VaelpZrhSaZmTXG0LSLkoPL+0s9PTuHc
    pmKr2lNI9euhfCZK5EABxTyJeTycayhufzvRgEzJRBpJf4G0her0zdr4Wulci2qcT8tqqj
    +yadAkM+lTXysYfKiddedSnvzv2MmqKf8EXDNOCfcn9YyIOEnSkJYpyHKkdDF67yFyojKe
    sS4s6/HYzwUfAObl0SG794PHwm8lHvjxXeS0YfWIJhG4MPFIA8yw4YkwYIoiuJ1GAVm31S
    YhlSXo7e/PM3tJUN84Cqd+AIL8OsU8WslZaPLb/SgOCs2gxSrJ2/mp4NCHcQ
X-ME-Proxy: <xmx:i7qyavn0s4aoYDALp3nVJ44ldKyFtisiBr7_GFvE-I9Uy3DHxHR6zQ>
    <xmx:i7qyajnTuDLTtCSzhQqaTkrEf22nhshPdp_DvjhskHQw_02QKqtotw>
    <xmx:i7qyahxEM1xubixnoUO6kqYt38gDTyw5f8OtRM-5VM_LGFe81LdElA>
    <xmx:i7qyaoqe3XAdx3Vw9UbkzCCXdCmdUCStJ7YPM2ub-6zQToyaj6Wxkg>
    <xmx:i7qyalX-Tsvvvghs7WAE2W1Or1InPMfJMGzP89PrBi_5rQOQLl6vc2RA>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 22 Sep 2026 13:27:39 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Pushkar Singh <pushkarkumarsingh1970@gmail.com>
Cc: r.norouzi@proton.me,  git@vger.kernel.org,  ps@pks.im,  peff@peff.net
Subject: Re: [PATCH] reflog: fix default expiry periods
In-Reply-To: <20260922165433.591551-2-pushkarkumarsingh1970@gmail.com>
	(Pushkar Singh's message of "Tue, 22 Sep 2026 16:54:34 +0000")
References: <GZicFFe4cqB928v52ERTcEFaAFtAwL0rp8VaCKSMyYzJ48XbQ9XoduiDtsou0Qp4N2CGmCS49uRbxi9dUWwlFzgzlt0PkGzR7IkqysP9tVQ=@proton.me>
	<20260922165433.591551-2-pushkarkumarsingh1970@gmail.com>
Date: Tue, 22 Sep 2026 10:27:38 -0700
Message-ID: <xmqq5wzxfb79.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Pushkar Singh <pushkarkumarsingh1970@gmail.com> writes:

> The default expiry periods for reflog entries are reversed in
> REFLOG_EXPIRE_OPTIONS_INIT(). This causes reachable entries to
> expire after 30 days instead of the documented 90 days.
>
> Restore the intended 90-day expiry for reachable entries and
> 30-day expiry for unreachable entries.
>
> Add a regression test for a reachable reflog entry that is
> 60 days old.

Does this breakage date back to the beginning of the reflog expire
feature, or was it working perfectly fine but was broken sometime
ago?  Do we know where the breakge happened, and why?  Those are a
lot more relevant things to describe in the first paragraph.  Once
the problem is described clearly enough in a simple case like this,
the solution to the problem is so obvious that latter two paragraphs
do not need to be said.

> Reported-by: r.norouzi <r.norouzi@proton.me>
> Signed-off-by: Pushkar Singh <pushkarkumarsingh1970@gmail.com>
> ---
>  reflog.h          |  4 ++--
>  t/t1410-reflog.sh | 13 +++++++++++++
>  2 files changed, 15 insertions(+), 2 deletions(-)

> diff --git a/reflog.h b/reflog.h
> index b996712c00..3bdd1ca8a5 100644
> --- a/reflog.h
> +++ b/reflog.h
> @@ -23,8 +23,8 @@ struct reflog_expire_options {
>  	int recno;
>  };
>  #define REFLOG_EXPIRE_OPTIONS_INIT(now) { \
> -	.default_expire_total = now - 30 * 24 * 3600, \
> -	.default_expire_unreachable = now - 90 * 24 * 3600, \
> +	.default_expire_total = now - 90 * 24 * 3600, \
> +	.default_expire_unreachable = now - 30 * 24 * 3600, \
>  }
>  
>  /*
> diff --git a/t/t1410-reflog.sh b/t/t1410-reflog.sh
> index 8f78cf4b01..1239c078ef 100755
> --- a/t/t1410-reflog.sh
> +++ b/t/t1410-reflog.sh
> @@ -153,6 +153,19 @@ test_expect_success 'reflog expire should not barf on an annotated tag' '
>  	test_grep ! "error: [Oo]bject .* not a commit" err
>  '
>  
> +test_expect_success 'reflog expire keeps reachable entries for 90 days' '
> +	test_when_finished "rm -rf repo" &&
> +	git init repo &&
> +	(
> +		cd repo &&
> +		timestamp=$(test-tool date timestamp "60.days.ago") &&
> +		timestamp=${timestamp#* -> } &&
> +		test_commit --no-tag --date "$timestamp +0000" old &&
> +		git reflog expire --all &&
> +		test_stdout_line_count = 1 git reflog refs/heads/main
> +	)
> +'

Do you also want to see what happens to entries that point at
unreachable objects that is say 20 days and 40 days old,
respectively, plus an entry that points at a reachable object that
is 100 days old?  "Keeping" is "not expiring" and driven by the same
logic, so it is better to test both sides of the same coin, isn't it?

>  test_expect_success 'corrupt and check' '
>  
>  	corrupt $F &&

Thanks.
