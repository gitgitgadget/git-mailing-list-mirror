Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E79E83A9605
	for <git@vger.kernel.org>; Fri,  9 Oct 2026 05:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791522452; cv=none; b=WATLPfX2IuPy96Ak7w4f48imXyy8TirYn+PsfzaGxVk+1Vs6rGcRqAp/sIyDcN2LmpIAMKZMtXZ0jd4emURlUHrENxx6p9Kp/gt8tw1E8NOEuFXNRYHd5aH61OB2DcZiYMx+5FLK0/Nv8g6fo29jpra6UubssqyyyAUUpH+TPBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791522452; c=relaxed/simple;
	bh=ebvu0D5Z0Luiy87IE8i+Brnz/caJNRNCHwoH5DSIaXY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PXd/N3XKZ5QTt25Q+alKBhffySWibWQZud0VY8/DzvRPjOqrw/QPHNHnk+FwqtlrRnatp/WhH77sgHuqrb/NJ9w5GkACWQgTC5aksgrpFqQKTw0fFeK+JWZnnT/SBSIoWC7DffvZW0zUrl+G8wOjOQiCaYm0iX93KDbL43L7b+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ihmUC8wL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=a4Zv5MwC; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ihmUC8wL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="a4Zv5MwC"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id 50FC31D00065
	for <git@vger.kernel.org>; Fri,  9 Oct 2026 01:07:30 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-11.internal (MEProxy); Fri, 09 Oct 2026 01:07:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1791522450; x=1791608850; bh=1YxlMOXd5Y
	9hNO132Tdc1KnW5Yd13PmAUsvw2NQOWVI=; b=ihmUC8wLsZRBgOsVjXUC/uVau2
	fZdZUzPkl4N+T2G9OT8eFBMkDMXepSpH+LOthX2MrKH4qg+5LvzDAYx5Zn7AhweR
	+nZqVEHTpHhqp0vIB/6lNOptkm7R53ewlGNVbj00xU9xsWa6dnIbFgs5lRPvanaE
	HT6FZdYhIdaZXQCCXi05N9mMDblDIRT4j5tPj/eett8+6BCmEDRzdWYjkh+hz5Nx
	chYBlhJeigANaCPnlO4Gj0v8nIfXcSWhUScWcXcqWlWZsW7zns2fl21p3kd1Bxi8
	3ANcMxwgYxb806+km4arYMz6MQtMnHjIaSJisw+Cl9hdoLbLgHzCHGC9rzUQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1791522450; x=1791608850; bh=1YxlMOXd5Y9hNO132Tdc1KnW5Yd13PmAUsv
	w2NQOWVI=; b=a4Zv5MwCpG4qrA4uQlXB5F+CaEzLG6kd5xLyRbHGeVdj7TUyJ4H
	B0VJQDE5zOJQl762wfxYmRW4/CV5vGgxFryhe0aaWut/9o1WKY+G29CUM9N3nSiZ
	CEp7+vsuKM9ls+n7gGtW8ReuJx8CJ4m/GgoH4i1m5iWeNc3uvf+TwXndSx8Nq/AR
	Z73BjdT2/z8NzwzkRmyDA3CI68nPrfN+4tik8hjw50vZghwRcy8YjJtJZSA4SsAW
	1XohjarbWAoKHCDjU7N0vT6fMajlNS1XLPaQZ75sDr9aDkFh+QRP/mcK2RDueW/k
	c/9K7eRQ98xFbUQR3dncTMmWICLgXxg6jkA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791522450; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:CexZoIZhiwT47eQSNXd6BhkkiKs4S5yscJEIDJEAbz5ZLsQ
	rOeMnncNOg4Kr9nGEw+8GGY+qVSasPCl9SUfMzhZ8MRUY4S2CHUPFkN45aXKpDSZ
	m++1O6fNR6veEitIqYICxG5GiGvI9xcnzX0WcNIrMeuoNwcx8q83j9DYtpNaE9Ze
	8yLbYdynkr0mTQCRq6WENMOxn33Msoo36MMEzHSpQXcekN5wP8HhQnsbp50XNa6C
	/x+j2ur9GRfbCIXyyakNqSw5xIIGgF5/C1YmT9dUVwasi+56yWltU/rP6P9mKw1U
	kPBmBmrMwIjr3idad6QbujLG8FDQaH3rNP1HpnA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:atlphYaq/2RWCGLXVjEcEP/t5Qll8Gw2Ss/Vp7DumVI=:ebvu0D5Z0Luiy87IE8i+Brnz/caJNRNCHwoH5DSIaXY=;
X-ME-Sender: <xms:kXbIalNh48bojfvDlYuzlDFhPzGlWVI5tK6b36c4uzI_4Jh5Ngs_mg>
    <xme:kXbIah8grh8YXdEo0hp_d0QM8Z2fKODPHTviRVE5RjUbCfIV99j-WrGgEvTkXFQYM
    QBCZZAdcVWsO6euI4WhBqW1HkteZDp7M1HPbbiIE4trXxnbAHoaCaU>
X-ME-Received: <xmr:kXbIaq4V0pT8dMRO_eFypJ7FuTRYQjla-NWPbNw_3qTrxPKz45kLeNsKuKaUo9DMfvprazHNZkg493hKvJSjQER7X5YB7nCAq89y>
X-ME-Proxy-Cause: dmFkZTEbRWdU+KtKTMFenJNma6zFcIKXCRFXtnB8PsJgfgm7wm4W+FN2ZvOjAKCs+rX1qk
    nNJzKduy/DgOCcSpS9m3t1rGxOE30FLUNlO22WojYKkNKP4qd+2D8CF8m0eo5XcEdlDupd
    JWXkCb9bIxg5Q00jGLXc6Y/3h8m2+EhqwREnQ6Guo7WF4l6hqOMgketb47zQQemFaKUaAx
    2DqlUEt5/U2AWnua0Jnq8UMARDMZGJZAknx7i4i8rpd0I2e6e8zqb/Zof1cSHSoVwRXyxj
    FQOXnlbzxunJDOxhijgKK2oRC6QGAI6j1E0Daz/RPKjtUPqM2WOV3IhUoPzowdZZM0nUKg
    05EDoUM0ZPEmTs8snQm6MBa6EZwmzlU1E2RFXnUxbMUlHpM8/d1I0+RdB1ciSsxDotHcfy
    NsAQjImv+XhHE+IM4AT36j4vUxUj2wT1MR686Fsrr9z61m6nmdMuo79piY5rgo8Kkr8T8G
    sxxnhIkM4ryiTiQ7LnC2p+whtYynVgo+o01wTSTYHYfq29xX7XvmyS8gveuXRoTSBA05tU
    Z7lsIRCdsjrCb2hXW2pmcdzqE9jjdCi/XbOL34FUXNEsEPchY9OjvIfwPZsO68k7RKWNWP
    khHrt++OS4CiznvWao3tOfKPZJh06PBGxZeUAbTavvwGLnihQks+Hq7BEHZA
X-ME-Proxy: <xmx:kXbIav6MDd7oicbQZJ_menHN6rZ1J3UAdqC3hgLR1W6Q4s97wAH7Bg>
    <xmx:kXbIarqMXHmfgHJm7NuYdV55cVmoe8VlAPawm05eDoPg8Vj-3wC8OA>
    <xmx:kXbIaoPnAg1YdhDLcwqEImchy4F_qMARoC73Swl9-EVOYNOPNHxWRQ>
    <xmx:kXbIar0ZHrTknsxJZJYWEfW1EJPtjkqZVaKarl-ZqFNc-7axg5XWDA>
    <xmx:knbIaoKPA2HZX9DwcM5NABdyF5cu1dgPfICs2wCVhjRG_CHndjVx2dV3>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 9 Oct 2026 01:07:29 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Ravi Mistry via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Abhijeetsingh Meena <abhijeet040403@gmail.com>,
  Kristoffer Haugsbakk <code@khaugsbakk.name>,  Phillip Wood
 <phillip.wood@dunelm.org.uk>,  Eric Sunshine <sunshine@sunshineco.com>,
  Ravi Mistry <rmistry@google.com>
Subject: Re: [PATCH v2 1/2] blame: harden ignore-revs parser and tag peeling
In-Reply-To: <2e12486c0d5dd8b94393b08413a85a8d47f86edd.1791493644.git.gitgitgadget@gmail.com>
	(Ravi Mistry via GitGitGadget's message of "Thu, 08 Oct 2026 21:07:23
	+0000")
References: <pull.2224.git.1789169384240.gitgitgadget@gmail.com>
	<pull.2224.v2.git.1791493644.gitgitgadget@gmail.com>
	<2e12486c0d5dd8b94393b08413a85a8d47f86edd.1791493644.git.gitgitgadget@gmail.com>
Date: Thu, 08 Oct 2026 22:07:27 -0700
Message-ID: <xmqqjynrwjg0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Ravi Mistry via GitGitGadget" <gitgitgadget@gmail.com> writes:

> - In oidset_parse_file_carefully(), strbuf_getline() reads up to the
>   next newline and records the full line length in sb.len, including
>   any embedded NUL bytes. However, strchr(sb.buf, '#') and
>   parse_oid_hex_algop(sb.buf, &oid, &p, algop) treat sb.buf as a
>   NUL-terminated string. If a line contains an embedded NUL byte after
>   a valid object name (such as "<oid>\0garbage" or "<oid>\0# comment"),
>   *p is '\0' and trailing bytes on the line are silently ignored.
>   Reject any line containing an embedded NUL byte via memchr() before
>   stripping comments and whitespace.

Maybe I am slow, but I do not immediately see why ignoring
everything after the first NUL is a problem.  A call to
strbuf_trim() is ineffective at trimming whitespace that appears
immediately before such a NUL.  For example, while

    cf9bdb1...f6092d # comment LF

would feed the leading 'cf9bdb1...f6092d' part (after stripping
whitespace before '#') to parse_oid_hex_algop(), this

    cf9bdb1...f6092d NUL comment LF

would keep the whitespace after '92d' and cause the parsing to
fail.  I do not see any security implications here.

On the other hand ...

> - In peel_to_commit_oid(), odb_read_object_info() is called without
>   OBJECT_INFO_SKIP_FETCH_OBJECT or OBJECT_INFO_QUICK, and deref_tag()
>   calls parse_object() on tag targets without checking whether the
>   target object exists locally first. In a partial clone, any missing
>   commit OID or tag target listed in the ignore-revs file would trigger
>   lazy promisor fetches and pack directory rescans during git-blame(1).
>   Use odb_read_object_info_extended() with OBJECT_INFO_LOOKUP_REPLACE |
>   OBJECT_INFO_SKIP_FETCH_OBJECT | OBJECT_INFO_QUICK and peel OBJ_TAG
>   objects one layer per iteration, verifying that each target object
>   exists locally and matches the tag's declared type before parsing it.

... this may be a very reasonable thing to do, I would think.  In a
shallow clone, if we are not auto-deepening the shallow boundary
during a "git blame" session, we have no reason to lazy fetch
entries in the ignore file that are older than the shallow boundary.

> diff --git a/oidset.c b/oidset.c
> index c8ff0b385c..90d39204d3 100644
> --- a/oidset.c
> +++ b/oidset.c
> @@ -85,6 +85,9 @@ void oidset_parse_file_carefully(struct oidset *set, const char *path,
>  		const char *p;
>  		const char *name;
>  
> +		if (memchr(sb.buf, '\0', sb.len))
> +			die("invalid object name: %s", sb.buf);

A file with such an entry is rejected and the entire operation is
aborted as suspected attack attempt, which feels like striking the
balance between usability and security at a wrong place.

But a line with broken object name already is rejected with "die()"
with the existing code, so it may be OK.

> diff --git a/t/t8013-blame-ignore-revs.sh b/t/t8013-blame-ignore-revs.sh
> index cace00ae8d..70fe509a64 100755
> --- a/t/t8013-blame-ignore-revs.sh
> +++ b/t/t8013-blame-ignore-revs.sh
> @@ -327,4 +327,42 @@ test_expect_success ignore_merge '
>  	test_cmp expect actual
>  '
>  
> +test_expect_success 'ignore-revs-file rejects lines with embedded NUL bytes' '
> +	rev_b=$(git rev-parse B) &&
> +	printf "%sQgarbage\n" "$rev_b" | q_to_nul >ignore_nul &&
> +	test_must_fail git blame file --ignore-revs-file ignore_nul 2>err &&
> +	test_grep "invalid object name:" err &&
> +
> +	printf "%sQ# comment\n" "$rev_b" | q_to_nul >ignore_nul_comment &&
> +	test_must_fail git blame file --ignore-revs-file ignore_nul_comment 2>err &&
> +	test_grep "invalid object name:" err
> +'
> +
> +test_expect_success 'ignore-revs-file peels chained tags and skips missing tag targets' '
> +	test_write_lines BB L2-modified L3 L4 L5 L6 L7 L8 CC >file &&
> +	git add file &&
> +	test_tick &&
> +	git commit -m D &&
> +	git tag -a -m "tag 1" D_TAG1 HEAD &&
> +	git tag -a -m "tag 2" D_TAG2 D_TAG1 &&
> +	git rev-parse D_TAG2 >ignore_tag_chain &&
> +	git blame --line-porcelain file --ignore-revs-file ignore_tag_chain >blame_raw &&
> +	sed -ne "/^[0-9a-f][0-9a-f]* [0-9][0-9]* 2/s/ .*//p" blame_raw >actual &&
> +	git rev-parse A >expect &&
> +	test_cmp expect actual &&
> +
> +	test_config extensions.partialClone origin &&
> +	test_config remote.origin.promisor true &&
> +	test_config remote.origin.url /nonexistent &&
> +	missing_oid=$(test_oid deadbeef) &&
> +	bad_tag=$(printf "object %s\ntype commit\ntag bad-tag\ntagger T <t@example.com> 0 +0000\n\nmsg\n" "$missing_oid" |
> +		git hash-object -t tag -w --stdin) &&
> +	test_write_lines "$missing_oid" "$bad_tag" >ignore_bad_tag &&
> +	git blame --line-porcelain file --ignore-revs-file ignore_bad_tag >blame_raw 2>err &&
> +	test_must_be_empty err &&
> +	sed -ne "/^[0-9a-f][0-9a-f]* [0-9][0-9]* 2/s/ .*//p" blame_raw >actual &&
> +	git rev-parse HEAD >expect &&
> +	test_cmp expect actual
> +'
> +
>  test_done
