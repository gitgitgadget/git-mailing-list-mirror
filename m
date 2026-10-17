Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2C0D35AC0C
	for <git@vger.kernel.org>; Sat, 17 Oct 2026 03:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792209586; cv=none; b=niq2fkc5O0+kH8kHJrx0Np3BVf3w93BIFSsUqhHx9QdPObftuZPcnpFW0LLesB0M6C3r4Ne3Qk5s6bYr2q0aO2YKOB2wnOB85+MRdGxen5Mm2FlK+cqdDR5pDFNNA+6yzaJtnv7DA0eEgE2DF4yMRSxWzUhU2JZ+XH9U0zOnIhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792209586; c=relaxed/simple;
	bh=U5LrEn7sx5UfNXczORYBEnwJDWq1DI/5vvWlnL7X6yI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Q9NpJ//JJzd2U0+Q8Tt7hDtWiX4KOOUJp2UXQLRklOPPLfLusWy/ZRkwNo//atm8RIidTCtiUn3lzmd/uhjvd2RyoWOM9QI6oHG1x9j8FolhKId3Njog6exMKpdbh5WdJtF7MjlIpeKAdbchUEab8tuwt0sGYal0RbMfbXQtyTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=P4A+Z+ts; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=sLR7Sd71; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="P4A+Z+ts";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="sLR7Sd71"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 292637A0058
	for <git@vger.kernel.org>; Fri, 16 Oct 2026 23:59:43 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Fri, 16 Oct 2026 23:59:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1792209582; x=1792295982; bh=AaTT8fzZBH
	0cJrBtvVdij0ZBT6p4kCw51OXPrvCXds0=; b=P4A+Z+tsYSoWQQzzudkWqdhmrv
	oqUqvG+C+kzWshvKP0LpjvEOtcewt0hAkYXAmsqQgjz2BtWDAIVumGkKjQeU6zqM
	ysk6r5VlXeNr7663odBEvl89y13+Flm7sODi9vfaojEE5RTigCshj9QsGbJgi+4h
	S0d7NFjboWzkak1RNGnYuy3+o+HVdkO1z/B3z9SKj3cPbHROShncrjE9FWjaQtGM
	YlO1e4JeVzGy36bW3EA9AYe2c0nIMr8xgJySPQHprdosDXnmN28DTg5BhFxWaqC7
	ZRrra+NYGFOR7B83NLUeU0Trd/YicCSq5SWX0LNlEdJHLpJTGtORTOpnkdiQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792209582; x=1792295982; bh=AaTT8fzZBH0cJrBtvVdij0ZBT6p4kCw51OX
	PrvCXds0=; b=sLR7Sd71xerhmQtQ4ZhySyjHSxTcWEkWJH6bQxtsWGlqbIjbxE+
	MH2nOpHKOYEiTtUf40WbnQaHaRCIK4QVE9ONGcSDpjVLVtEh5wBWrHPDXfPMDMVs
	gDckzT5cSWrk/99xWFP5gh9h492uUVoL2YgJGSFKqF6cd/93bV5scp+wQwK5cz4n
	ZGFHm3Gl1vlHZG+1Kv7M2IGWS8yV/Tuzl9zd/V1lkRQ/+Hjd8ZWrWqXpwbNX7Zuk
	/5ZOjqXV+cEhszlD/I5JQ4IO5OFkSJE+Gh8TH3BklPT5v2kk4Z48U9UAszCoFSPV
	LtuB3exebqcklsAbTmIV4Kx/KNV71+f5qkg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792209582; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:CVaN8bUbKmdVtYAfL+oIx6fU6eX0UK9VNe6lT8hNL1xawvj
	H8lYjDJjarxOOLwm0Se0SiKLPh9mAlmKPGSn6CbddS+avPBhcg3IJOW+UP8WYDCs
	BIw4b47vvkpzYbEXcI2Idect8bF7hU/ocyPeTepdm8qnQ9QDcNqgP+6c3b7UOfWo
	Qs/kkSa5GfM3E4twQ/AWOzaeNEsr72pYph9LIGwx6eQyEZ81x5GItPG033dWRy6U
	afCSKq2pRtruE0f4Wym1cXrTAx3T9Q+PEMlbuh5YQm4O6Fw9DtOm/W3k0ORFtbWn
	m7AOXeSXvpAO20EMbmRGAA1OQh2fbyWC487bbJQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:wTlHfzEJJfmJS7BOsed/10Wo+Fd4bCPmLFOIJDreAIM=:U5LrEn7sx5UfNXczORYBEnwJDWq1DI/5vvWlnL7X6yI=;
X-ME-Sender: <xms:rvLSagDDoZp275r3G2WwtTYEdchfJeUkHJJ_uVuFre_89C1O3MR_OQ>
    <xme:rvLSapbtPgvlh25ZRQ4qK9vSqo_XKYdrw6-c9fN6fTwLYbYGovMVzP-RYfU3Y9qhq
    JDL20nqGqY46NTqqi5uRdHKTsmFi1Kh0yoPSsqJDVN2WAs7OrGt6Z4>
X-ME-Received: <xmr:rvLSar5_mhASLKX_FwZw8O9ZNXfYG-ei_EBjqE8R1SEwJgmaQcjDSUrs1IBxwDGYelfZ7XnhWKz17N_fHV0F_JCguLIK8leZmLeK>
X-ME-Proxy-Cause: dmFkZTE/kZr6MmudMhxgCwT7+DnNVDQFPDppassGBcmsVhGsHKMhRmyCaxUu9CIdF7fMil
    I+8lABdTPnY2SKg5LugjAZ5YgbSwthRouQ4kw5CAzKAyng2b31JYjzchnVAreHMXK6SPrn
    DDT0qYeP1XSlXbhsilkM80a3vyamzLnE/Q70/rp0xB+z7XLvrET1tH9YOGDkl1pNtGWQEK
    hg/EUENeOZvurH1OqGEUfxQvUEN0MX42R8nqxkGShz75lO2hM3TbF2yXh5fEkMeF1HPM/g
    dg9d4qxzMNPIGOsZX6m4qbBXR40+UxZaiIZS/4Jmsn3sBbe3jlVlj/9vdAtxRPwky2CKtI
    B0UE+o+nNgoHkgOaZLOEjnTgOok7A1VSxW3dHUW/0/gOKC09HXY4E2KgGowQvhIHzVjanQ
    Cq2UzBNJLWDJtAvBeK8B7Ao/rNYdelLVlxWftEWZhOSYCiazNIk6YYSlZQC4Blq0o4MCWP
    lZmo+osaIHUVirl5+9dWtAMKQXsIGI7/sQsYvVwsazNtkCs37Z+Pniwwir6nhuf47szrQP
    LcjW5PBAEIP4J51Ujy/EN53eC+fsl/TMMwznqEvy3Ee95IY2pdM+HqS8SvyUewuGlOLFu0
    WHdoyMnheMUPEPcCvZHYe95eDdCpEqBRMrw4Jod66/ZOPG6Sj19AzOznmcHw
X-ME-Proxy: <xmx:rvLSaiZCVu17DBJ0NLd-ybMUpGMQwn-Q8vxLAqlm-YhUbwlczv6NsQ>
    <xmx:rvLSaigLRrGzx72vZCLhBLWkFsXy2pQsLU5KmcFncBFO5RXaZpK_UQ>
    <xmx:rvLSar8JtWVL67xrwXyp8VJLbMl7-dV_xkhfQ7_Zbf6sGCA6kY7tVg>
    <xmx:rvLSaloIJOkjuXUCUzn1TaapJ3jynIAVBLVqlswG9C7bYG7tTvNeAA>
    <xmx:rvLSatqPKDSEhmEMvEx1n0PRfLeNkps_Ut0BPxFiv5247oEMYr6Qr7jP>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 16 Oct 2026 23:59:42 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Mark C. Chu-Carroll" <markchucarroll@fastmail.com>
Cc: git@vger.kernel.org,  jltobler@gmail.com,  ps@pks.im
Subject: Re: [PATCH v7 1/1] repo: add filtering options to "repo structure"
In-Reply-To: <20261015170342.39967-2-markchucarroll@fastmail.com> (Mark
	C. Chu-Carroll's message of "Thu, 15 Oct 2026 13:03:42 -0400")
References: <20261015144559.3652143-3-markchucarroll@fastmail.com>
	<20261015170342.39967-1-markchucarroll@fastmail.com>
	<20261015170342.39967-2-markchucarroll@fastmail.com>
Date: Fri, 16 Oct 2026 20:59:41 -0700
Message-ID: <xmqq33u5c6z6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Mark C. Chu-Carroll" <markchucarroll@fastmail.com> writes:

>  t/t1901-repo-structure.sh   | 197 ++++++++++++++++++++++++++++++++++++

This test is broken with SHA-256 and in Git 3.0.

> +test_expect_success 'filter by object type' '

This hardcodes many 40 hexdigits constants, like ...

> +	test_when_finished "rm -rf repo" &&
> +	git init repo &&
> +	(
> ...
> +		objects.blobs.max_size=13
> +		objects.blobs.max_size_oid=97d808e45116bf02103490294d3d46dad7a2ac62

... this one, which is very specific to SHA-1.  Existing tests in
this file (like the one immediately after this one) protects such a
test with SHA1 prerequisite to avoid breaking in SHA-256
environment, which is far from ideal but better than leaving it
broken.  In the longer term, we should strive to get rid of use of
SHA1 prerequisites, as SHA-256 will be becoming the default in not
so distant future versions of Git.

>  test_expect_success SHA1 'lines and nul format' '
>  	test_when_finished "rm -rf repo" &&
>  	git init repo &&

If you choose to fix them, see recent effort by others for
inspiration to make sure you can share and reuse most of this test
between two supported hash functions, e.g. the discussion that lead
to

  https://lore.kernel.org/git/pull.2252.v4.git.1792012956734.gitgitgadget@gmail.com/

but you may choose to punt and just put your broken test under SHA1
prerequisite to sweep the breakage under the rug just like other
existing tests in this file.


