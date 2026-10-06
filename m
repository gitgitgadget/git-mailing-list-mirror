Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66EF43EC68E
	for <git@vger.kernel.org>; Tue,  6 Oct 2026 12:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791289523; cv=none; b=eqH2onoa+bCPoab/bGH8G8m5SEMiPnIAxp/e6LLqaD4nJd0BVPRJx8HaxCiuxNmjkRRvd4EbiI7VNq6aWoQ2CUhAE8e5XtuGpuZTw1nG5ZQwtzxnmuLWdW+Bi/hfGPZek+dEWQrpbbVD4qpl82eWrGH//dAilK2Uwk4AOK8bkhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791289523; c=relaxed/simple;
	bh=DFOcIeeP237vu5sXjX0IxsNUu5RsRzriRtVxeUL/SDA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ITL64s5zQJpa5G9Bd2/ydH5GpUI1sCqxl9XPWI9uwiqmFpXTuZS7mQ372d9UFD3mYUbuvfSZ50XTGycqSKV7nOUJivTMqmVJ+kcgit/ESWZ2GlRZXywBm7wiMCDS/53DcxedtFxLaSF9EfiFPgFj7yTtfs6DVSUidKpVdzYPrCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=JuzDhFL5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=tYdPLBJv; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="JuzDhFL5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tYdPLBJv"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 1542CEC01A3
	for <git@vger.kernel.org>; Tue,  6 Oct 2026 08:25:20 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Tue, 06 Oct 2026 08:25:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1791289520; x=1791375920; bh=WISYLoXAZK
	HIYvxqpdOHv3aBNpyjq6oyUoxsfrFThGE=; b=JuzDhFL5+Y5mSKN+KZyG14xah7
	DbX/iovvealFBWq3XTG1Bae4HJ5nd5eR4PsK1wgBkassgJawrhlH3LKzYhucmXjq
	W+0WoF7feBEHAi2O2/5lmRT8WKoXbn4HTlZk17pj3ZI+O3q70VE3xqFJyq7CteCX
	SMsdJUu1H/XGZov7LCPwh6kMoy5/3nvUzqbn/b4+jMHy7+vA0aFNQFNOTfhpuJY1
	jf4pO0M6KLdY1Fmhuhv8EXNsGWsrLumIikbmGDzJZbRkpeA2BGAVNrkKrveE7bzL
	+p2k9oqPX2o4yxXa6+PVr+ibJqz+KWHlCobxzpPOF11C6mhj+YSRP5oXKauw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1791289520; x=1791375920; bh=WISYLoXAZKHIYvxqpdOHv3aBNpyjq6oyUox
	sfrFThGE=; b=tYdPLBJvWrDlgkMZijCsCRe2SowzAWnKwQskyTA4L+4LMpfVFKZ
	n5pItzCuL7GPtNSV+jvRZiAFwZUZGa90Rw1NgiYWOEL1WeMyAixOlzdf49/yhgQ0
	ex0k+7G7HUMhprKNckFuaQtMhklZk7IQIcv1IREz6mr5CVfzCCmKIL+Gfib/Ec0h
	s2xSzHF7vuFHUrsibiUZSnJK5fkcBvNoE0D57TRLF0OIcl3onvEapLipYjAvDvCx
	sGBGaXy7ta5erhHXJZ6iJpl36Sn+1uLLDq5GVMq4oyKufiSJIS5H2u/kWWjGvsvZ
	5VznlRnYqJxxZ4rIogeXRh6Xo5fsm2z0xZA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791289520; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:jqfbcqEyFnWjY9fGYHST4yEpngWwSXlEtNp5XYs5YrxhvN5
	xE+Y9m1pD2uexuTP01ALg932mS+6Y0afeflNcIUWZvvmmSzVjWU4Cq/Dc2jh0Uew
	Ai+E5P6jsIw/KsJSUABuWpW0xedUP+HXxbetvuaVPANqWO4DlTu/B4U1JFrNErPq
	eIU2+4UuP1UmAyGJi/p972qKxOpaWI8pozu63vtIb9Ndowore+9FIZDszschnxKt
	Bwodg1zZs2b7swOjMyMduRQlRf317CV45p/GEeABE66Yj3OvSTcotwHde0HyzbRw
	n7U050Kr8nk2zIzMOzwslG1vubu8v1pF59sAXSg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:lflZOX1CKpjCVesjoG6DKo1AZnw50FvSbrQsjqe6Yds=:DFOcIeeP237vu5sXjX0IxsNUu5RsRzriRtVxeUL/SDA=;
X-ME-Sender: <xms:r-jEahB81dZrXnse7jHDlLW_mS4UwLQAnWrp4KSPbKCLbubCF0WJLA>
    <xme:r-jEamYZSaBKA_ltOrGbaLJy3SRbRvEp4BuF70zPCtjBN2JZrlI-J2WSKkqLVK9WU
    GXu4g4nWLjesg9Tp1zVWkdnxue7JaWx0sDrVrfS7AmifqrFnyUf-sA>
X-ME-Received: <xmr:r-jEak4HDG37Jmr8L1QjI4Bz9DTpL5FtCpm0U6m_NGmbJJD757DaFClvfchDaxM5biOE1TMJBVhHWuxrG-IeBJrwThgKAHSuN5vy>
X-ME-Proxy-Cause: dmFkZTFIu9imQzCn7ZHgmaJDYA+43WgR5IzX3aMV2z+wWHSo2haY2v+zEIHohKtBMdTuYC
    TRcPiICAZx2F8jQfkMPA47zLLUB/HLBpCK2Y2JxKMXlVbWx/Ngrxhj9ifUjKGHbeRlrjH8
    SmNlRBOGUVHQFL8p8IDTmu0B4strV9i9voS3aP29dFBoeJMP2BLZcEA3QyhaiICz2kg6fI
    UwCOnyVteBgCFz9+To8ygb9pFF5u00cPLsvKVIof3KGayqPUl4s0b5p73w/UBnuuoy0kSA
    66+3sOs8nqvM42O0n6oFkyeWIoj8J4qcFSkLAz3XDhf+CkrkPAsLQQAUU0P7dTg7fBUtn+
    Qo0AcNwIT3kb37tvsHes8NtEpmH102ohZ5fuxELq2C6FTxOIUtR9+AOjbwYXeCLYpnqj9B
    s0aS6OzJf/apzwwwlX4BdRibS9wjMEqvg2I2HZf3Dcn8Mn3leH535wJ8nG1zjL7iAj4pfq
    H+8AZjH7ZNaiTCBesoHHStN/6vy/czjdfqJOeVZT2ec2qeIdXYbz0uFqhPniFMR/oUZM5C
    fYqVpxqZ1K3+xwrDl04atxxiJJ769njP5HHKUhBnOy40oAGyB8EdRbX6QLUobPIMFeTWV9
    PvPX+i5y566nEhiug/qeBbToXx+Y+Fo6REVh20bEtvd7h9IuV9FwQRW1Vx9A
X-ME-Proxy: <xmx:r-jEanZaOCJS-olrhoRnXAhsD-CQ1TBBQK20VDwok6aWs645ErQiHA>
    <xmx:r-jEajhFIiHGJM7zX5zwZBPEpRE7dVK3fBI4fsDTm-BNhbNHV4NADQ>
    <xmx:r-jEao8iZEmmcNPswBDI_hwKiuTJaKzIgqft2znVwfiQsIklKEr4UA>
    <xmx:r-jEaup4vGoHv68kjrR5MmYXFpBBWELw5dH0AgCmVtqjdU7JaW0IPA>
    <xmx:sOjEau1IdBhvhA6mZbespQh5UFb5cBBBQMblkHhxrF8ZF54sWHr9PCtf>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 6 Oct 2026 08:25:19 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] t5551: fix quoting in curl version bug prereq
In-Reply-To: <20261006034331.GA1325722@coredump.intra.peff.net> (Jeff King's
	message of "Mon, 5 Oct 2026 23:43:31 -0400")
References: <pull.2236.git.1790118373340.gitgitgadget@gmail.com>
	<pull.2236.v2.git.1790283229626.gitgitgadget@gmail.com>
	<20261006034331.GA1325722@coredump.intra.peff.net>
Date: Tue, 06 Oct 2026 05:25:18 -0700
Message-ID: <xmqqik3fhv81.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> On Thu, Sep 24, 2026 at 08:53:49PM +0000, Johannes Schindelin via GitGitGadget wrote:
>
>> +# The cURL version which Debian 12 ships (v7.88.1) can fail to retry
>> +# authentication after an early HTTP/2 response. This bug was introduced
>> +# in cURL v7.88.0 (8c762f5998 (http2: minor buffer and error path fixes,
>> +# 2023-02-08)) and fixed in v8.3.0 (https://github.com/curl/curl/pull/11756).
>> +test_lazy_prereq HAVE_CURL_HTTP2_BUG "
>> +	test_have_prereq HTTP2 &&
>> +	build_option libcurl |
>> +	awk -F. '
>> +		($1 == 7 && $2 >= 88) || ($1 == 8 && $2 < 3) { broken = 1 }
>> +		END { exit !broken }
>> +	'
>> +"
>
> Doh, this is totally broken. The prereq snippet is in double-quotes, so
> the $1, etc in the awk invocation are interpolated before we even eval
> it. Fix is below.

Ah, I missed that "double-quote outside, single-quote inside"
anti-pattern.

I also like your "HERE-doc solves many such issues" approach in the
other message.

Thanks.



> -- >8 --
> Subject: [PATCH] t5551: fix quoting in curl version bug prereq
>
> We have a prereq snippet that invokes awk. The awk script's $1, etc,
> variables need to be quoted to avoid shell interpolation. We correctly
> use a single-quote inside the prereq snippet, but the snippet itself is
> contained in double-quotes. So we interpolate "$1" into whatever value
> that happens to have in the outer shell, and eval nonsense like:
>
>   awk '(--some-garbage == 7 && --other-garbage >= 88) ...'
>
> As a result, we don't think we have a buggy curl version even when we
> do, and run the test anyway. But of course it's easy not to notice,
> since this prereq was protecting us from a racy bug. It only breaks
> sometimes.
>
> There are a few options for fixing the quoting:
>
>   1. Backslash-escaping the dollar signs. This is perhaps the least-ugly
>      version, but it's a minor hassle to remember if somebody touches
>      the code later.
>
>   2. Single-quote the snippet, then quote interior single-quotes as
>      '\''. Reasonably obvious, but ugly.
>
>   3. Use the '<<\EOT' here-doc trick to specify the snippet. This would
>      look nice, but we don't yet support it for prereqs. ;)
>
> This patch uses (2), and we can circle back to (3) to make it look nicer
> later.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> This should go on top of js/ci-debian-12-http2-workaround.
>
> Since I know we both used GPT to work on this, I was curious if this
> slipped past it. Doesn't look like it from what I sent (which used
> option 2 above). I wonder if your agent flipped it, or if you saw how
> ugly it was and flipped it yourself. Not blaming, but it's just a funny
> and interesting data point if a human second-guessing the AI output
> introduced a bug.
>
>  t/t5551-http-fetch-smart.sh | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/t/t5551-http-fetch-smart.sh b/t/t5551-http-fetch-smart.sh
> index f66d7ce7ac..cb681e644f 100755
> --- a/t/t5551-http-fetch-smart.sh
> +++ b/t/t5551-http-fetch-smart.sh
> @@ -21,14 +21,14 @@ start_httpd
>  # authentication after an early HTTP/2 response. This bug was introduced
>  # in cURL v7.88.0 (8c762f5998 (http2: minor buffer and error path fixes,
>  # 2023-02-08)) and fixed in v8.3.0 (https://github.com/curl/curl/pull/11756).
> -test_lazy_prereq HAVE_CURL_HTTP2_BUG "
> +test_lazy_prereq HAVE_CURL_HTTP2_BUG '
>  	test_have_prereq HTTP2 &&
>  	build_option libcurl |
> -	awk -F. '
> +	awk -F. '\''
>  		($1 == 7 && $2 >= 88) || ($1 == 8 && $2 < 3) { broken = 1 }
>  		END { exit !broken }
> -	'
> -"
> +	'\''
> +'
>  
>  test_expect_success HTTP2 'enable client-side http/2' '
>  	git config --global http.version HTTP/2
