Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1F29376A1D
	for <git@vger.kernel.org>; Mon,  1 Jun 2026 12:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780317195; cv=none; b=h/vdLHsVK8YVPxsDe6tR6algqVNUGGhe5s5QRArhU8KHVAD+a4nE59oGD9pezb+OsNRytPeXSgCMICoCu4ngnlCvddHVxAYYRUnZTy5iiiLH5fZHm0GQygmYU3NUFL1qUKAHorkGvgq20yPYFYQJFebSlZksgw4SMAXqZ0GZo7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780317195; c=relaxed/simple;
	bh=lf29jNzNPUDIeO4wZrlJrd82C1YHjYEjtSP4mgOxOcY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TraQ9WrX0oQOE4aPWPdYJPc+83ukN5TvZb1Q8s3ccSU62WkhhvVQ0d8rUW2kMcMIA2rjTNjZaCmAX4kanOBK8YWAjhNT97jkvww02FQkcGD6UBarv5TvhKv/bH/YIscJtTysUBpMEtFbOHXmwgOx/qmUmt6KXvjOhjyFigkepZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=TsfHhOoO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CYyRxD9Z; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="TsfHhOoO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CYyRxD9Z"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 108F71D003E6;
	Mon,  1 Jun 2026 08:33:14 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Mon, 01 Jun 2026 08:33:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1780317193; x=1780403593; bh=9iuyYP0NMA
	7aDPvFiwBn9/n24sn+TzAMj4z5tFfzTTE=; b=TsfHhOoO9rNYm5p/mDR+x/PnqD
	iweshoJXvbcxjSjSTPz+ioCrnHRSPTXtEcTtUK1G+MxHzhIC0SRfUnJgUChmlMr1
	C61vzJj+3h3yJ08yAwkOdRb1WWBIDdWRtQIbq3IESUaCG5iOPetat4H2HkGejjRP
	ixkH2ClwLD9VbsoT02z6C6N1Di7ubaC9lniG7uy+q+/q/RhiaKWdRZquQlP4hkk0
	/gBt0QIvtW3mQ/3PYxmR8xgQCiRl/T+wR2rzBvncdAurdpOUKI6vY9d0gQrGi54o
	LlIyRSoNfj8GlSxVEPbhsr+7w4BrTRTdeLmxEX96bKGTguw1GM6nQdwTLSMQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1780317193; x=1780403593; bh=9iuyYP0NMA7aDPvFiwBn9/n24sn+TzAMj4z
	5tFfzTTE=; b=CYyRxD9ZoGtmBo8IlfH3x/+Y3ZxQaKzTJd14YvmJgZWV6NYxhf6
	CXK9/HZ7JvMIjVQBlKu/NsR168qYtSl8SpMJeE7vW34KgnIPYMHb3n6pSZT63ahE
	rpI8o5XzZkitnQHuPBIWXPc1l8IkwMlwYr5U+rcBqZ56XdmrAw5XAaYipgC1XZ6F
	wpi/61pGYDM30BEGErZUX1v9ZEQTrckrIV5BgbvQE141MboPLyJJ3eEQXpvCIDRI
	8QwlAQOMXEHRkm5CdkCY5QcIOcNGsW29btoNLokZLUiSWfUlx1fWWOHyNm6NNU/X
	GNJlt7hZF6+j7Q+C2hvLHA7f5Gct0UO6YAw==
X-ME-Sender: <xms:CXwdapWB_j70XAgour9BS-NbPINzutNXKFsa4wxpS5mYcPKiOcnjuQ>
    <xme:CXwdagnLU4kcNv0jwzWOckOlrbcAhV3_2DmGfOTqZlithhUsIauVppNn0Yr2Yop2U
    zKn18wUSIlZKoAyt_cL55LSQvshJHYGabC62zURe-4yj4CHFkAc>
X-ME-Received: <xmr:CXwdaqaWTSkjs8f-7duwpq12jmOdM-rU5cII-EhJqV3qcwTC9mpIIEi_kyGgMZwF8SSu08dzMiudTQU6Wb2ulneRkGCLORKA5Oas>
X-ME-Proxy-Cause: dmFkZTFxwq+W0/+8S0jElCZDn7v1OZxXQhOjTIbqFL5CWiIFQ+lpNiCdug7dXyNdMg3+lB
    01TRCdGuiYmTruA722jt+/gnRTXlnmxnPDZvVLa1tJSh/gJX7+y63kCRjOa8vJ0o/WWPuZ
    7PxkKKA1H8PElcvXfdArPt8RDuDshBX6N1Q6g+Gu/dfqNmSzdFQ5nVsdMmtRC33UTWgsAL
    hMh1e0kkwNwounEMpHVMFJaDy5krtwjkwvwZfFwILJGBa8MNXZiBGkFDwjmyYywndsNgwU
    6spgQnXdaaaViCLzt/LB3zWoTn6sYyY+mL5znNkJQQXmM0Af1Dzadfa4S8F7g8LiPynGiq
    TYqC9M8BuZTiQrC2PX+NiXoCVGgMTzPVCL+HklDNqgf4B2mDa5HsqKzljsbcriU/fdv6Go
    xE6bah+tdGUK3XvtouIfcyxiOAl2LA0kiS8NMyjz3fU0JNpMzUx0+R5VEeh2I48ElyXd8H
    0xFC8weSnFMbbyD/FKJD0/AHqFfipmYuPy+s+J32SvchMSX9lWHAX8yyHNIiDn7yX0JLCr
    3Qh1KbIzfoJU5UtBPAPLrqjyGYkT2Wbmzxwj5e5B3bX5kccZDVHhhiOpKTMCw8cUDeXLio
    d3dp119bbQDURKeznvA9C/TnA2tjP9zN9umNgSm5VJZJxmm1qPmw8YZ32VRg
X-ME-Proxy: <xmx:CXwdarNWivkkL1C5oh1QG4rUOq1W7b6KRFjpkEsx_RK9jJHmBv05cg>
    <xmx:CXwdavbxEF50oRfrIVdQOg3Re0OkSPqDmwX_xTdzrOnPyFwRBv8MQg>
    <xmx:CXwdap1X-PfqE2gbNbRSscSS8LYAsRdtADvzABeyvgOoYHFrgQTFQw>
    <xmx:CXwdaldvGyZD1syRhsz2xMHPvxRZs7vDED8wPbrFYSYCte3wyyVrFA>
    <xmx:CXwdal5I68kes8P3_3gIn3VHon6Hd0rUCipgOfrs2TzJhFUnMETyGgEo>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 1 Jun 2026 08:33:13 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 5/5] cache-tree: fix verify_cache() to catch
 non-adjacent D/F conflicts
In-Reply-To: <a87bbaa84fd5dcb2a585f82c4a5dfa1572b54588.1776731171.git.gitgitgadget@gmail.com>
	(Elijah Newren via GitGitGadget's message of "Tue, 21 Apr 2026
	00:26:11 +0000")
References: <pull.2096.git.1776731171.gitgitgadget@gmail.com>
	<a87bbaa84fd5dcb2a585f82c4a5dfa1572b54588.1776731171.git.gitgitgadget@gmail.com>
Date: Mon, 01 Jun 2026 21:33:12 +0900
Message-ID: <xmqqldcy4f07.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> I could not find any caller in current git that both allows the index to
> get into this state and then tries to write it out without doing other
> checks beyond the verify_cache() call in cache_tree_update(), but
> verify_cache() is documented as a safety net for preventing corrupt
> trees and should actually provide that guarantee.

Oh, absolutely.  This kind of tightening is very much appreciated.

> diff --git a/cache-tree.c b/cache-tree.c
> index 7881b42aa2..f11844fe72 100644
> --- a/cache-tree.c
> +++ b/cache-tree.c
> @@ -192,22 +192,62 @@ static int verify_cache(struct index_state *istate, int flags)
>  	for (i = 0; i + 1 < istate->cache_nr; i++) {
>  		/* path/file always comes after path because of the way
>  		 * the cache is sorted.  Also path can appear only once,
> -		 * which means conflicting one would immediately follow.
> +		 * so path/file is likely the immediately following path
> +		 * but might be separated if there is e.g. a
> +		 * path-internal/... file.
>  		 */
>  		const struct cache_entry *this_ce = istate->cache[i];
>  		const struct cache_entry *next_ce = istate->cache[i + 1];
>  		const char *this_name = this_ce->name;
>  		const char *next_name = next_ce->name;
>  		int this_len = ce_namelen(this_ce);
> +		const char *conflict_name = NULL;
> +
>  		if (this_len < ce_namelen(next_ce) &&
> -		    next_name[this_len] == '/' &&
> +		    next_name[this_len] <= '/' &&
>  		    strncmp(this_name, next_name, this_len) == 0) {
> +			if (next_name[this_len] == '/') {
> +				conflict_name = next_name;
> +			} else if (next_name[this_len] < '/') {
> +				/*
> +				 * The immediately next entry shares our
> +				 * prefix but sorts before "path/" (e.g.,
> +				 * "path-internal" between "path" and
> +				 * "path/file", since '-' (0x2D) < '/'
> +				 * (0x2F)).  Binary search to find where
> +				 * "path/" would be and check for a D/F
> +				 * conflict there.
> +				 */
> +				struct cache_entry *other;
> +				struct strbuf probe = STRBUF_INIT;
> +				int pos;
> +
> +				strbuf_add(&probe, this_name, this_len);
> +				strbuf_addch(&probe, '/');
> +				pos = index_name_pos_sparse(istate,
> +							    probe.buf,
> +							    probe.len);
> +				strbuf_release(&probe);
> +
> +				if (pos < 0)
> +					pos = -pos - 1;
> +				if (pos >= (int)istate->cache_nr)
> +					continue;
> +				other = istate->cache[pos];
> +				if (ce_namelen(other) > this_len &&
> +				    other->name[this_len] == '/' &&
> +				    !strncmp(this_name, other->name, this_len))
> +					conflict_name = other->name;
> +			}
> +		}

The narrow and tall comment block is a sign that this loop is
getting too deeply nested.  I wonder if it makes it easier to follow
if we extract this new logic into a small helper function on its
own?

What the code checks and how it does so both make sense to me, though.

Thanks.
