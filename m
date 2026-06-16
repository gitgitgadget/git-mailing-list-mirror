Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FDD645BD4B
	for <git@vger.kernel.org>; Tue, 16 Jun 2026 16:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781626159; cv=none; b=S6iZ2bPl8K9SqHDf1sgg20iestlhySkooi+NwvQmty2EIERFqZvQ6nJzIfhJdSsrON5oafkapeQ/aOgg4OTj/Uxgf1pHKH4ebpFad9btW2lagVQRimmqTCbyNhjR5Dh5bEmi7Dm0S27/7PpcYbaRAlGd62priXZl7cRX/UH0ZZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781626159; c=relaxed/simple;
	bh=cUt1Z8fC4ABPkEWx0L36ykH5LtwD00OJSztFs8aUQX4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hnrUmz86agnJlwL764Wk8G+GCIVnqRpWXG7d5at0VNuBacgQHkbeB2Y5J9oEXHKh0l8csVK8eXMPy2TFumva6QZGbKNA+MmVsT0zcZ/w2f7MR85j7tqo8zUKc0TW4z+NdshIeqLyVRwXNaam1EgE1Hz28p9f36EczpfN4OwGUgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=JS1soQPb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BWl2qO7N; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="JS1soQPb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BWl2qO7N"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 76F381D000D7;
	Tue, 16 Jun 2026 12:09:17 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Tue, 16 Jun 2026 12:09:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1781626157; x=1781712557; bh=h1jaBBoa+u
	zS6mQeqMQqt4r/TaT+HcP6nScriTW+WKM=; b=JS1soQPbMyU79dTZafC9m4m/ia
	sa3JbET0n7lmfsPgep6kh4maVH8FAp21++oIonU/R+9fbJLPuDjm/6sKKVri8OO0
	Ks/hdcJJLZOA/1YBwHaMYgLlX3JEnouCyqfblgvDoPi+3nEzGVjSocEMttO/YtgB
	QIbRkhXRYL6BEqA+Iapg2Lw0jiyZWiqmCm2sI9SgxN/pw5V4NRc9780A68ATDbZ3
	AJC42+BWfUee2ftiLTD3+rsJmCyWGl/WFTfzjrV8zdkxp1ZqIpGFvwNAhuGH9YNJ
	Y0EpxDpZlVCSkRkXrF3CrmexWObijs8kILew1omn0yQVfflJ0ZK9OVfmkizQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1781626157; x=1781712557; bh=h1jaBBoa+uzS6mQeqMQqt4r/TaT+HcP6nSc
	riTW+WKM=; b=BWl2qO7N4Tqslcg9M86L0OWNTBXzXqSCpWetXcymhBpKeoqYNiq
	oDUSWo4OWAjIY8E2t3BOlH9wTwQmiC/GiX5fawwvVLkLvaS5lqSRaNJBgejkem0r
	67E9BmxHpwdrV59rJQIEkRHhBjN3zbgPLcvuFblUJYcErYVufQ9xuO/9n7cf3+cY
	DOS77Lu4kiOuyV+3sM82hKkb5RBFK8GPzCe5W19v4rmoB8ixAOgkyfXwVw3czfgW
	pDUxcU8twMtc5E0XEVObcav/jNu7iR6w7CWIXUjNH4kw9aYosId8tvu6Ci8M7iYp
	Yxp1oCpiL7TTnOr7oEYW4yXps48eMSwjVXA==
X-ME-Sender: <xms:LHUxaszrKtafoTbkz_2_opgGSUWyGlzvzNMqnT1F2XERUQbuNOu3kQ>
    <xme:LHUxaj_voP9oRl2kjacRuDR3oiNQfS4RTRibW34uM1vKk3G2yfKPu4rBGeaVm_7TS
    05iEK1Ls_YptxiFVwfpvk974Gm_a_qLSEkRUpmw22cJ7BMdwrAS>
X-ME-Received: <xmr:LHUxaoLST-fciYbN6aa_WPOB6Oa7sFOn_haNCkLpwiS5KdgGLodvuEDkvXGgKn1U6S3YxWrvYvGgd0HVNeI5OeX8E_dHCCtdkfL5>
X-ME-Proxy-Cause: dmFkZTGI7FNjPnc+FT5rq1DB819KOOeGYWtQdP0URoCibSySIpldqI68VBUkLNO//37IYi
    3gCrY3WeLtzWA9t8L+43PizEKCoDy89i3Pg0mcBL6gigg3ds393V2TFmHfgCwTRGZ/4nsH
    g1xd94MQ4x7wT5XzGqkE/jhyXdU2F3D15UlHzF0LeGHrOzUl4Wv4+Vrjfkjl1LWuVB2kWh
    +C775joczaGOaAEWQpsgER8r0Hah/uQ9UrJa9e3KEAGy5p53SYLXcyk3pRdCseOx0Fk3Y5
    njcfYN7+Nbgsla0Py+OmmUTgpAmznvCqYXt+f/1/rW28XbD09WI3HTZCpvb81Rsm7nTat8
    a1B6efayVOE2jthYY2M80Xwn/GmGjLjn/R6qN5KMoFgXBoWNnLruEC/Ov9U6ONNl/FUfO2
    uWcuhM1rwNbaBFWH+d+92vi6+FxZxNp0JrLaNFdz3VHzuzD1WkkyF0VgaMYWXHRKpWcn66
    wMR9ViFoWUFPaJ0aQGGNIy/ZWW5h+lnSOq8Q+BY/j/a5cYAkcK7R4ZkHIE8Av3gocMoYsP
    bDYcXth90zwqMVJw5KJ8/cULCiFpimA5jNJMBKumVoNbK61Dx0sg6oM+HqQTJMSo5nWCz2
    fNTvetOP0UIqhCKu6KRULlKmZKxUgPSfWPKypGkiMzqsX07Vead+d+fCPwHA
X-ME-Proxy: <xmx:LHUxahfd4uOfYYuUsCXaQu0syRCGjKtEQSE9HBOtDopLqBmMVrYkLw>
    <xmx:LHUxav-b5APbdmScNgh1xpAg5rXuvcEskO5my5apcGf-aCV5mK_BhQ>
    <xmx:LHUxamqkwYz9xvYHXSj3Q1W0XyFiCnk7B0Fgxwjg-fdqYTgZjfIFig>
    <xmx:LHUxasCz6nNmgxWlC80o2sldQyWx3xwAnf9xFZzxDFSL_pG4i9TnOw>
    <xmx:LXUxatZQ1Pg4zZSznHNxPPHI2kkD-hjrVTGJ7CffIt91jfiCMlRLpUE7>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 16 Jun 2026 12:09:16 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Philip Oakley <philipoakley@iee.email>,  Patrick
 Steinhardt <ps@pks.im>,  Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 0/6] Support hashing objects larger than 4GB on Windows
In-Reply-To: <pull.2138.v2.git.1781621398.gitgitgadget@gmail.com> (Johannes
	Schindelin via GitGitGadget's message of "Tue, 16 Jun 2026 14:49:51
	+0000")
References: <pull.2138.git.1780593313.gitgitgadget@gmail.com>
	<pull.2138.v2.git.1781621398.gitgitgadget@gmail.com>
Date: Tue, 16 Jun 2026 09:09:14 -0700
Message-ID: <xmqqfr2m4gd1.fsf@gitster.g>
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

> Changes since v1:
>
>  * Rebased to current master to resolve the conflicts with
>    ps/odb-source-loose

Very much appreciated.

>  * Dropped the !LONG_IS_64BIT prereq from the added/touched tests, as it is
>    now no longer needed

Good thing to do and see that the code works as well as it could,
whether a long is 32-bit or 64-bit ;-).

> Philip Oakley (6):
>   hash-object: demonstrate a >4GB/LLP64 problem
>   object-file.c: use size_t for header lengths
>   hash algorithms: use size_t for section lengths
>   hash-object --stdin: verify that it works with >4GB/LLP64
>   hash-object: add another >4GB/LLP64 test case
>   hash-object: add a >4GB/LLP64 test case using filtered input
>
>  object-file.c          | 14 +++++++-------
>  object-file.h          |  6 +++---
>  odb/source-files.c     |  2 +-
>  odb/source-inmemory.c  |  2 +-
>  odb/source-loose.c     |  4 ++--
>  odb/source.h           |  2 +-
>  sha1dc_git.c           |  3 +--
>  sha1dc_git.h           |  2 +-
>  t/t1007-hash-object.sh | 39 +++++++++++++++++++++++++++++++++++++++
>  9 files changed, 56 insertions(+), 18 deletions(-)

Will queue.  Thanks.

>
>
> base-commit: 700432b2ba22603a0bcb71475c9c333d17c9b0d1
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2138%2Fdscho%2FPhilipOakley%2Fhashliteral_t-v2
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2138/dscho/PhilipOakley/hashliteral_t-v2
> Pull-Request: https://github.com/gitgitgadget/git/pull/2138
>
> Range-diff vs v1:
>
>  1:  84e1cd0aa0 = 1:  9c01bac407 hash-object: demonstrate a >4GB/LLP64 problem
>  2:  809d83e46f ! 2:  aa5859c14f object-file.c: use size_t for header lengths
>      @@ Commit message

By the way, how is range-diff driven via GGG?  After applying these
patches on the same base commit, my "git range-diff v1...v2" invocation
punts on matching step 2 and I do not get a comparison like this
unless I give --creation-factor=<large number> from the command line.


