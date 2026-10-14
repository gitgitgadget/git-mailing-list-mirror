Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BCC147D47A
	for <git@vger.kernel.org>; Wed, 14 Oct 2026 20:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792008093; cv=none; b=Ur5/qmMVqM7lNFFMc4cpS957CdukOcEKtSohc27HlnFovAg4qyyENXaWIUTVNiYr01C+aM+I6ijOJBrjxciEo/UbGZlsbGBF74N+UcBO/pD/og5tSzT+IRooBbXsSJ0mQGeBiACqqcyLSuo5zpb3VlDo+x/7lcT7SDG/ZrE9Qt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792008093; c=relaxed/simple;
	bh=simUUOMy7PgzVyors2UKZ+1PYj89MK4IAh1TO98y/sg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TrdAFBBNwR2TOlukydiWT6Uhje17xFx91V2WkCIFdjp4tgpXsRuitcb8tOnwK6RGVQ3dbezwOJzuQANi9fNJAie3unS1hE3UzL5ECUGDVm+tqwcXd2kwrY+BaI+zEQfxxnngOv22HXsjXIAmQIQHXw+DQrgQ53xI9Jwh6TO0nj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=PSHQ293z; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DUwXjvmR; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="PSHQ293z";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DUwXjvmR"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 2305214000F3
	for <git@vger.kernel.org>; Wed, 14 Oct 2026 16:01:31 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-10.internal (MEProxy); Wed, 14 Oct 2026 16:01:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1792008091; x=1792094491; bh=japGr97gnf
	CFJOWSvd0hMP1wh1WLBZk7GVxw5JAzvuk=; b=PSHQ293zdnrKdv93CS5DeSv0n4
	qGMEVePKzPXBrygukjJd53K2zcXufbOOoMcxpaWFS31eOQRjyEKDbB9Q6VNXWIL7
	E7UbkcQ3m+mPS3sDDoDxji9yDwsPnNX2vN6doNGNXm3K3g+qvywwGSMcMxSU3K3D
	SdrzvBon/M3jFlCHv6C8FGB2G8+qKp8pszlby49WXfJRfc1asP/rHOIujFsxrM8j
	bcWuECbx+CkpcB6XRQoDb7Rtrb1m29HZ9d06M+/4yckKrEbahPnMUF0m5bs3jthm
	df59dKv4mgScBNUDVXaZvpWdz3UUPoSz4P4v10kAsM8NZUoJKf4ptxIxqHvg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792008091; x=1792094491; bh=japGr97gnfCFJOWSvd0hMP1wh1WLBZk7GVx
	w5JAzvuk=; b=DUwXjvmR6C4/pvIRqwONNVPCBqUKWLeZb7RC+LfYsEi0at45z7W
	oaJ0MXnNX96PPmebY+Q/9mzL0Xxjqt02P3K5cn0MMIHPvuNQA/oN9HLDgeELgO0C
	ES0T+758sFQmj1pLDOyDQzUthhjqlfqLEZt9AuhWWcS1E4mjmQcerQQI/zGnbf7h
	UayWkQna4GsedlvPZpGg6XKH3T8ajPAk/LaWxsLidhJqvZsVRQTjNc94ZefHcLbA
	B4QYMPzbdnwGNsIqwgsigV0T20Q/rcqBIW1cVZ1+5I12SqXP5ddy+VPD39cUx4xT
	Mxuihfb3JXyLmBvHgkU5+kbuYLbjZhHpbMQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792008091; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:kFMUdudShrigWIP5hflET0y8im09KJxl8o/nbP/11rcr0xl
	reN/7ZWyd5mYe6QvXuOp94dXPTD4NTxWKLJLFJ0qSleGX4S/EVDB8o7j4vFYkLjn
	dJBRpKB8yGPNP4nXqanmLSCXNT1dOUl2U2hRrr+cLdQWIeDD+B4XrVNooYWgD/Wb
	KpLKQz0mtx+Zoreucdru7g09Aw2uHJ+qLeSP6xMXdB3E4b9BUWP0Y+cUcXPCbqaC
	vymcGGbM4k68UiuS7ge9qnhExmNkp8Kf2iRZdcjMFiZUKZW1/FZpIyTmvBU5L4NG
	n5p2x8PoP9IXXTQkatSxKze84PP/YMnaN3LZtPw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:xKQYmTIozFpqTSKZ2qIfs9hiBM87kR/OY2JC37W8U2A=:simUUOMy7PgzVyors2UKZ+1PYj89MK4IAh1TO98y/sg=;
X-ME-Sender: <xms:mt_PaqE_6FT7Y_dQJ38MZF3CToF-FIYMAoa_YpB_gK739lK_5KRc9g>
    <xme:mt_PatnBRxUk-HpShEQqtG1RNGdD6BwY8imhHJ78G8qJ1FvhQUR0x1lyBmtfeB6-o
    BoARr7cLVmHlvzugz671PKhFXNCPYl0pDLGuCi_oJP2yANlFr9GLA>
X-ME-Received: <xmr:mt_PamZbBlWPq--9e78DZKOOHF8LLqiEFWUU-o1kMF65D0fac3cgMUVMDzbW_Tm3mxASn-vX6XZGoZ0jgHgo8ACfMNQzyxnOpe2b>
X-ME-Proxy-Cause: dmFkZTEA1vKr8RT+Vvy3OmXkSDY3mM63RZSxRdFBVKtmFszwQG1gHofWvQafQbY/9uCDh1
    THz7FKKNZXBDqfa/AVO7OZGqjLG7EddViFWSWfu2OJlg+4wD/lzRo1Lxs84yn48XkB2ATk
    22vcXQSv35ngv723VP7M7E64F7MZMSRp4YG1PcbBenUvvrOr/WxSWJogy/kic5PIWpZPX+
    oCMsHkjsnsudYj/mTg6Wlpidk57DdtV4G4U2MsTGL5bL90tqtrkgQxjOIn13ATLgcN0VMU
    rpKzjc3m7cKgCdQvuifym7NQBzZt1/+pFN+mknmpG4K1klMO9y9UXqG3mTxw73QI/mOgcA
    Z5S8G7IvkSXeMjYj5GXzbm/wJEIy8eEdl+VT+HLchyG5N7T1L3mYcLHuVFrgFKzSL5kDSp
    qh91HHPFGdZgGHiW4lOIK3LF1s7kkFJBzGFgsXLZ3k8uvnGA3inTAV87DLi5gKJ+wOXdws
    5HlWwq+R8fxY8nA7MDfDg+mIIyzxehjBB5oULsCsmFTPny0Xi592c/ehZ11szPuZ8imtek
    ktJpSLBd32bX1YOiMKxKF+wmzGiwzd5kXzvuNIlVHfeKiHL/OXsgY36RngBqMztU400Hqu
    y8Pjom0uu2v+ew9TUi4NDLbBmJcXEan9Npu/MAR/PdPtut8Vie8IlV8HhqWA
X-ME-Proxy: <xmx:mt_PaqH8iS5CSU19yqMNZrJIGjqmrymyWulJzpqKH_WZPnwRI3V7ww>
    <xmx:m9_PavIK2pPRJwypxTSfdYe-Gijn26A3vv4XJ5ABeWbbAmyYlKnaXg>
    <xmx:m9_PatN0ER_CPY-1bF0iDJIemtWm6lYcbjvn1jhiHbr2su8lUAuHug>
    <xmx:m9_PanmrwglMw3lor-5bosiq6RjxTlX1UiPsDeVOidQY4Bgee4LmRA>
    <xmx:m9_PatZOPPX8ZWd2xZmvstnCzkf3h-fGGKswtgYF5p5tgeJ9B2_MyzHD>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 14 Oct 2026 16:01:30 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Dorine Tipo <dorine.a.tipo@gmail.com>
Cc: git@vger.kernel.org,  kaartic.sivaraam@gmail.com,
  christian.couder@gmail.com,  siddharthasthana31@gmail.com,
  usmanakinyemi202@gmail.com
Subject: Re: [Outreachy PATCH 1/2] t0410: use rev-parse to get the subtree OID
In-Reply-To: <20261014134504.1152225-2-dorine.a.tipo@gmail.com> (Dorine Tipo's
	message of "Wed, 14 Oct 2026 16:45:03 +0300")
References: <20261014134504.1152225-1-dorine.a.tipo@gmail.com>
	<20261014134504.1152225-2-dorine.a.tipo@gmail.com>
Date: Wed, 14 Oct 2026 13:01:29 -0700
Message-ID: <xmqqcxtcqcfa.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Dorine Tipo <dorine.a.tipo@gmail.com> writes:

> The 'rev-list stops traversal at missing and promised tree' test gets
> the OID of a_dir by piping 'git ls-tree' through grep, head and cut.
>
> The pipeline goes against t/README which says not to pipe the output
> of a git command, since only the last command's exit code is kept.
> 'cut -b13-52' also assumes a 40-character SHA-1 name, so under SHA-256
> TREE2 holds an abbreviated OID.
>
> Use 'git rev-parse HEAD:a_dir' instead. It returns the full OID in a
> single command, the same way TREE is computed with
> 'git rev-parse foo^{tree}' just above.
>
> Signed-off-by: Dorine Tipo <dorine.a.tipo@gmail.com>
> ---
>  t/t0410-partial-clone.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/t/t0410-partial-clone.sh b/t/t0410-partial-clone.sh
> index 788e9a1631..a24b663f73 100755
> --- a/t/t0410-partial-clone.sh
> +++ b/t/t0410-partial-clone.sh
> @@ -405,7 +405,7 @@ test_expect_success 'rev-list stops traversal at missing and promised tree' '
>  	TREE=$(git -C repo rev-parse foo^{tree}) &&
>  
>  	# a tree referenced by HEAD^{tree} (tree referenced from tree)
> -	TREE2=$(git -C repo ls-tree HEAD^{tree} | grep " tree " | head -1 | cut -b13-52) &&
> +	TREE2=$(git -C repo rev-parse HEAD:a_dir) &&
>  
>  	promise_and_delete "$TREE" &&
>  	promise_and_delete "$TREE2" &&

[devil's advocate hat on]

That may avoid piping, but are they chekcing the same thing?  If
HEAD had a tree that sorts before a_dir due to a bug, the original
test would have used that tree instead of the tree of a_dir.  Later
tests may have noticed that the tree object is not what is expected
for a_dir and led to the discovery of such a bug.  The new test goes
directly to a_dir so it wouldn't catch such a bug.

[devil's advoicate hat off]

Arguably, the use of "head -1" in the original pipeline is
unnecessary as 'repo' prepared there only has a_dir/something and
nothing else, and if the extra tree that was added by a bug sorted
after a_dir, it would have hidden such a bug, instead of catching
it.  So in the sense, it would be better to assume that the tree
would be created in a shape that we expect and explicitly name the
directory we are interested in i.e., "HEAD:a_dir".

So, one thing we may want to add to the second paragraph of the
proposed log message is that the original assumed silently that the
first tree object in ls-tree output is the tree we are intrerested
in, without even validating what path the tree was stored at, and it
would be an improvement to name 'a_dir' explicitly in the test.


