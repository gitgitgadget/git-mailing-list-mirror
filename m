Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C83B286881
	for <git@vger.kernel.org>; Fri, 28 Aug 2026 16:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787933902; cv=none; b=gPOh/R9uKMcnDdnaXCrSnVjbCXeYHuco6KG2oQBr7oCE19Vl4/kw14oib4EhP0/lR3sPaxVSm/SJyK2HxLCXAfRl9Swep2L9TuafGi1dNuRg3ImcmIMhwLchAKid5djfYJ4KnLVHkMxf6LPvcyi2ujvryASYwAxp5X2vV3Pv2aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787933902; c=relaxed/simple;
	bh=jFbhDRh+PM4I+moYtRtqNJEtN+0HchKR1ta+6fKZspY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DDO2RlibzfTVkqipYO91Iu7XWzohkc/XU1XUa+CGBlFlI4HLeojbILjkjepFuY8tk8SQljBBbSeCsbxjhFN7FzL3JTNZ6DFMQioqMIXXePpgbht+awS64xckpkzMKdgbqaOid7oI2GTgnwWX8FPK+VEwLoKJMRabrLuJSqH8bXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=lzqPdY8b; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SiXAqUuV; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="lzqPdY8b";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SiXAqUuV"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id B85A51D000B1;
	Fri, 28 Aug 2026 12:18:19 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Fri, 28 Aug 2026 12:18:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1787933899; x=1788020299; bh=Nc86UopPhx
	qy43CVBYjNMInJNMkloBsz5Qg8pmZN/go=; b=lzqPdY8bUXbVBO0m8EDZ6TJu6y
	lIb7v9WQ7tndCIZL6a6wyFLxxvndRAdq1iId6QMThDFHA9lHwiWyTNFEoTG7ClcP
	K9Y58nmnh1fZ4LvrY/8+8avQOTVjJcMtHCV5yQkUj86zOz4xFytDxn6BeDTYjDMm
	129Ba/g3oNimT4Z0aM8bW5Odm2veYiEU+3txKHeM3E+n0XD7zXzpuNie94LBorHA
	0RYhjtXX6z/R5Y0H1Zc51SwPhluAS4lbDpQ1KyDXWLQyuUoUbOA7mKqdIG/CGsU/
	LIxSWbAf38AN3DyC/MUuY4OVkmvB7lvfo9EcrJyeCVDWNW3REzSorupkUAxg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1787933899; x=1788020299; bh=Nc86UopPhxqy43CVBYjNMInJNMkloBsz5Qg
	8pmZN/go=; b=SiXAqUuVkzKNxma8WjSJPIBsaNCBOXmkpLaTL2yufcId09LtYn1
	KeAKige8EpvCBBrAczweTirmDalUygwypq7AI8STUfiBVyqHqF0OOjMhNbVDxkAT
	ST6bhu++qxqSnHU2ywq5w73mqD/CeyfOMKyoSwcABbNLxEz4CNieI7Gg8n9Cv4OL
	H9Nnz7xRqiM16Kqoz0vnC9lrMrjbTabKKfvIVzqqbzhDT76/eN1HlYsapUP2SZwe
	TjF/DPl8K4lNfma8I2I5Ytuj9bvrmIkVuKb/haNGZyJya24jFrLzzjboBfO0jhCf
	2caFeOl0yu4OI7Hr8q3NIYWFmv1V9oUDJ2A==
X-ME-Sender: <xms:y7SRalO2a6Bo4T-y68vn3As6d-_PXOucjKS_bcwB_9gu45bypBK-NQ>
    <xme:y7SRau0ZXD2OICTABXidQlZWgebI8bulGYfns3EgjW2FxSshtLEY-UzoLKugWwVeV
    Nmq11L0X0kG214-o9KbgwJmivUHXol-ZunWT9-xaqqGhQojxU_R7Xs>
X-ME-Received: <xmr:y7SRasmKEO_grO2Xv3FAN_XePgXMAd8hZ-Sr3788KfPJQUc0NIP9qLkB89XiRcnfyqjQCWSBAsYCa1sOUrKqKGK_y1Y19Vm1_A>
X-ME-Proxy-Cause: dmFkZTEJfLP8gCd75+0IS8wlvp2//mRaRSLsXfeWNZx0+kggdBG91x9kcw4JvTUBV3dzUL
    L7L5ZStHyVDHI7ENH2ITpVmvtjDsAq/yWhE+T91PdjISDbGsGt+K2MoLv40U0VbDB8evjd
    fTjtf1OLP3uA2/Jq4GDqiIGC2n/affftsG1YAXQdC91EpJLhVJyJ/frumzD18m4dvHPkGd
    KoHueoPWSvRGBb0xiZ+garmZeqf0EknhiUhGB44LC+C4sGLeZ6IBUhNdZNIWAXrh48KS+M
    iSscaqkMMDuUhgnGjNuqtZTBElWHzRLE6Q7acy/iEbYge0brlLFl+ciFic/aEy4HiwOqnY
    nyhv6shhpfF7mpJ9qyjZi1dCuMfqcUuPW0+TXU0O52ml5Vc7SPWjVMdu0TvEzNvwFwajJk
    pQ7M4VrEO3JDLz6/w1B4oKeHd6l4XrYueeM/bY0sSPFghxWrkuzdJbZg15RSoia2kZIYuI
    nGWTUl1+RLYPL6Xfa2Q64mKBUDuvrdgoJQ5WgTjBqYe94fbykPlfiKhc1F43dEIaEEf8Oa
    uhgWVhugwRS1TolDURqVca2GwQ7QtXL5ZIWoLSfKOWQiWcuu9ds6lrYdz29UBNBBIAC0QN
    e3vVlcekOquXwkINEvD28T8LdiZB8sYV/H+9wGY2ZTMBy9pjfGFzSvDVS3Zw
X-ME-Proxy: <xmx:y7SRatXXqGtriI9ZbCeFeHrHfN14SpV3EHKrZeJplYxMKKApSeHB6A>
    <xmx:y7SRaqsAP2wzpOCcFWdGpJdiVUzt30adGOpawpZa9SJi2nnJ5d3b7w>
    <xmx:y7SRaoZEDZ02PiDvFaHfJS6fP5iyJG0eJbGX8a7ucCtYdeY1zYoDQg>
    <xmx:y7SRahXZ93-Mw1osAwJMZUPr28yfSqVyWJld4q0O5c1cCyZ6WFtqhA>
    <xmx:y7SRakl2XrqLqfZQhX7tk9dwM0WT_j0h0b2E9_k1-oZ9r_cJDka_evsx>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 28 Aug 2026 12:18:19 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Phillip Wood <phillip.wood123@gmail.com>,  Elijah
 Newren <newren@gmail.com>
Subject: Re: [PATCH v3 5/5] commit: refuse partial commits during conflict
 resolution
In-Reply-To: <050b9e8a52e531bcb17f483d0d574aaca3875adf.1787903085.git.gitgitgadget@gmail.com>
	(Elijah Newren via GitGitGadget's message of "Fri, 28 Aug 2026
	07:44:45 +0000")
References: <pull.2389.git.git.1787721681893.gitgitgadget@gmail.com>
	<pull.2389.v3.git.git.1787903085.gitgitgadget@gmail.com>
	<050b9e8a52e531bcb17f483d0d574aaca3875adf.1787903085.git.gitgitgadget@gmail.com>
Date: Fri, 28 Aug 2026 09:18:17 -0700
Message-ID: <xmqqqzji5id2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> -	if (whence != FROM_COMMIT) {
> -		if (whence == FROM_MERGE)
> -			die(_("cannot do a partial commit during a merge."));
> -		else if (is_from_cherry_pick(whence))
> -			die(_("cannot do a partial commit during a cherry-pick."));
> +	switch (sequencer_ongoing_operation(the_repository, whence)) {
> +	case ONGOING_NONE:
> +		break;
> +	case ONGOING_MERGE:
> +		die(_("cannot do a partial commit during a merge."));
> +	case ONGOING_CHERRY_PICK:
> +		die(_("cannot do a partial commit during a cherry-pick."));
> +	case ONGOING_REBASE_EMPTY:
> +		/*
> +		 * A pick that became empty is not a conflict, and creating
> +		 * a new commit (partial or not) poses no problem.
> +		 */
> +		break;
> +	case ONGOING_REVERT:
> +		die(_("cannot do a partial commit during a revert."));
> +	case ONGOING_AM:
> +		die(_("cannot do a partial commit during an am session."));
> +	case ONGOING_REBASE_CONFLICT:
> +		die(_("cannot do a partial commit while resolving conflicts during a rebase."));
>  	}

Looks quite thorough.  
Deliberate ommission of "default:" is a plus ;-)

