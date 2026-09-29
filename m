Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2948E53F6B0
	for <git@vger.kernel.org>; Tue, 29 Sep 2026 17:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790704069; cv=none; b=M4+Zt3Fb9DF5vkUcdId7UKxNnbn+9CvIesEjgAMSIVUk9dSy5CQBshonYCwzSz5Pu0zc8FFBLmul3pw9xNQcBmaNUG1+d2ziyztzScwPT39c49LRSAqQqYiaep0TynBZHN3YkSsk7KnNnwpAIpPJXtwnn0HldNMfh9T+NgNpzFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790704069; c=relaxed/simple;
	bh=BwUe/XfIyOKk9GsTuPa+qoX0wbit/gOdJWFmm+vvlm8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VSuCd80attahY9ZXKiVmzlsr1w5SvXWIi+b5WH1UPNPz9w/jVcKisDI9ONNI88zOXZ6o24DNrQkeQ5fSiPUUt5KB3xEZquxqWjlgrUKnkhFKDhal08Xxl1Ab5uWeX8UHctR71UsO1JI8k1FWofJ1Na79Dh4pnX68K8bisr/rD+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Eg3fo6Ri; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DmyAw2ts; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Eg3fo6Ri";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DmyAw2ts"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id EC3C57A0271;
	Tue, 29 Sep 2026 13:47:46 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Tue, 29 Sep 2026 13:47:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1790704066; x=1790790466; bh=zRRuCaW+A6
	Y9IES4iCYsFziJrzbLRABzgXC0myZwgKQ=; b=Eg3fo6RijicQpJ1qOqLa5YNBJF
	dThD46zV2POEJKyPU787EJS006KQEWTvN/fRfWJst0cmqFbI8Zy6jG0KOPbX6SnG
	l00hsQb5JcpReOd0zUHnAWDRTItgG3+i45O7D9NAsoTKI5GGGgje3RG5/u/Tzv1q
	VIEG2ZXUacizwD4OswvWTiNiedTCb5yQwfn21sGXq62UNm1fNicLirC5uRgHYWd4
	hu0IeZ2DN7r0EgHZNzaDGII57zxWxaWF3kGOLJzMb/HkwHGPutfIVQ0Vc/m91nU/
	FOIQQbd3Pc1KCKZ9yhT+9aiHtER81KwpufvRJX0Ats9SN5zwVbJm9x0hDtFQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790704066; x=1790790466; bh=zRRuCaW+A6Y9IES4iCYsFziJrzbLRABzgXC
	0myZwgKQ=; b=DmyAw2ts9d2HdOizbwoBTXJxOemx8gXefcSj+OA5cjltsT8x730
	vXd+7Jt3uS67Kh7sfJpKojPRfuQiRSfIHFO9FqGiyhFbPDmrH2F0OTCmpxyBdKlX
	nqnfQ3sKyRhkziaEK2uMtnply+eKU/I5yiwe2WOaoizJXfffVX1hhx8MVZ2Sm+NT
	X08WzkQxm/tPtyNswmiPamxPUPtMraTeKvWN4GABtZYGBZPnklYMdPK6JGaPbUMl
	T1bxNWi/VLwevBXL4bNsZedBRZcyNVfUqRIG8pTYORRjiC57/YRZz+BBnwaKROjg
	oc2heuC+3riRqFSDA4uyycI0hEVhuSRvKWQ==
X-ME-Sender: <xms:wvm7aqUxWYcn7r55pCDf4ohxdDHL7xaCzavHsNFkT13rSPrJhHcoYQ>
    <xme:wvm7alpcGSxTN8vyU1AVtx3rh50LtRZqUVIyZP-pf2WqUSmvFP0Y9J0fAXIqBVi0r
    SeuGsO_-dLGS5s06mhVmztFj17v-EFhVSXdM2pgdbKxLVUpfkFMRKM>
X-ME-Received: <xmr:wvm7aknsSVI_crHMIG8EAuxQeg0WweJHKLH1GSxozjgzcfhZKSGCU5WH5dtThtw8eSAR_bbLMsDAngtL9aHUX1inVbJ5MD9N1Srt>
X-ME-Proxy-Cause: dmFkZTF5LzTpqBo7e1SgYqJ/LxPJoRtujM7mrBzUfrRirR36lOb5ojA1RIrrdRSvYaB/2x
    pXLKi+gco+DtRb1qfPFBWiDQbIp+WrCSUgBeGChgdUEl+uPaXQIg5YKvQrA2JnIEjpEVDF
    aaJfHtpKy1AqBykrmf7R50eYQwzjMYUqK94sbbUJMt15ZxdLpMGvZTVOFS8JA9P5u/Hk4y
    n/RxYdkoEf1WjzE2rNppDqRJIbO0W/QsoQinR62X24fcMjP/k/aIeLsbsM5x3kvFzzdTKL
    0bU+znbWZwf3fMkU9TCmNAd4sIKCYCEZa84So2Rc9ApDGhOkUhEWSL/QP2n1JUozZUYUf5
    Bx1Q4BpjXAMXocJ87hEgVGYR8p8CWWpDPXBz+6PzSy6FcwcLyX5UM2FxOFpQb1LwZTfWC+
    gTr2tS7BBchxy9T3X03RzJ6IYtAxwbReqgIWezcJ3dIsA7jtdfVNMYavL9YDEb1u5sfoVI
    tvPaOY6dpDF4AqolpZv3QbVveUJNgw337xudS0vQUx+t+sxWUE7933cALFv2BnSr5x9+EF
    1KKIEDVgQBTyavenqNldniXjYe80SUXiwGUnyzAv684t6ePpmgAdmM8Ub6Q6PtgEMIHsR0
    Jiehi7GQVXn9iTfHKWZFemaV+56nc9h5EpyKAbjJnqBb2k/1/FKRa9ML6kIw
X-ME-Proxy: <xmx:wvm7at1O-AmS2ViXva-Zj3GdaNFhbHP2DrZ6ph7kbh2utuTe2473AQ>
    <xmx:wvm7apSwjteBV_i4fWgpun5lQObNuhIM0nUPR-LkeTfQB6ngc-atkw>
    <xmx:wvm7auwkjvuXaqQZCRRfCGq1uTCSwLo_q1ocPkowtxK0WtTdy3NoTw>
    <xmx:wvm7ahARBQV9ibWLesRMP789autSHE8CdiB2LbSoopRrCHdZH19ofw>
    <xmx:wvm7arY5I84nzO1UcwCg7G6e0ZkWyVBbCiMus0VvKD6s79DqoQpdHVRf>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 29 Sep 2026 13:47:46 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org,  "brian m . carlson"
 <sandals@crustytoothpaste.net>,  Patrick Steinhardt <ps@pks.im>,  Karthik
 Nayak <karthik.188@gmail.com>,  Jeff King <peff@peff.net>,  Elijah Newren
 <newren@gmail.com>
Subject: Re: [PATCH v4 5/5] builtin/upload-pack: don't disable lazy fetching
 on trusted repo
In-Reply-To: <20260928133846.2094261-6-christian.couder@gmail.com> (Christian
	Couder's message of "Mon, 28 Sep 2026 15:38:46 +0200")
References: <20260908164129.560396-1-christian.couder@gmail.com>
	<20260928133846.2094261-1-christian.couder@gmail.com>
	<20260928133846.2094261-6-christian.couder@gmail.com>
Date: Tue, 29 Sep 2026 10:47:45 -0700
Message-ID: <xmqqse2sgda6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Christian Couder <christian.couder@gmail.com> writes:

>  Documentation/config/uploadpack.adoc  |  49 +++++++++
>  Documentation/git-upload-pack.adoc    |   5 +
>  Documentation/git.adoc                |   4 +-
>  builtin/upload-pack.c                 |  19 +++-
>  t/t5710-promisor-remote-capability.sh | 142 ++++++++++++++++++++++++++
>  5 files changed, 217 insertions(+), 2 deletions(-)

The diffstat above is pleasing to see, with ample documentation to
help users, tests with (hopefully) reasonable coverage, and a
minimal amount of actual code changes to enable the feature, thanks
to the preparatory work done in earlier steps.

> +uploadpack.lazyFetchTrusted::
> +	A multi-valued configuration variable, each of which contains the
> +	absolute local path of a repository that `upload-pack` is allowed to
> +	lazily fetch missing objects for.

"each of which" lacks a plural noun to modify.  Perhaps

	each value of which specifies the absolute local path of a
	repository from which upload-pack is allowed to lazily fetch
	missing objects.

> ++
> +A repository is identified by its git directory, i.e. the `.git`

"i.e." -> "i.e.," (similarly "e.g." -> "e.g.," below).

> diff --git a/builtin/upload-pack.c b/builtin/upload-pack.c
> index 32831fb879..53e76deb23 100644
> --- a/builtin/upload-pack.c
> +++ b/builtin/upload-pack.c
> @@ -46,7 +46,6 @@ int cmd_upload_pack(int argc,
>  	packet_trace_identity("upload-pack");
>  	disable_replace_refs();
>  	save_commit_buffer = 0;
> -	xsetenv(NO_LAZY_FETCH_ENVIRONMENT, "1", 0);
>  
>  	argc = parse_options(argc, argv, prefix, options, upload_pack_usage, 0);
>  
> @@ -62,6 +61,24 @@ int cmd_upload_pack(int argc,
>  	if (!enter_repo(the_repository, dir, enter_repo_flags))
>  		die("'%s' does not appear to be a git repository", dir);
>  
> +	/*
> +	 * Lazily fetching while serving a client would run `git fetch`,
> +	 * which may execute arbitrary commands from the configuration
> +	 * and hooks of the served repo, so we disable it by default as
> +	 * we trust nobody. There are two ways for a server operator to
> +	 * allow it though:
> +	 *
> +	 *   - if GIT_NO_LAZY_FETCH is already set, we leave it alone and
> +	 *     honor whatever the operator put there,
> +	 *
> +	 *   - otherwise, if the served repo is in the
> +	 *     "uploadpack.lazyFetchTrusted" protected allowlist, we
> +	 *     don't disable lazy fetching.
> +	 */
> +	if (!getenv(NO_LAZY_FETCH_ENVIRONMENT) &&
> +	    !upload_pack_lazy_fetch_trusted(the_repository))
> +		xsetenv(NO_LAZY_FETCH_ENVIRONMENT, "1", 1);
> +

OK, the logic is so trivially obvious and clear that it wouldn't
even need the above comment.  Very nice.

