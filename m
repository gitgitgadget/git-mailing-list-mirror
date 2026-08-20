Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C16302DA768
	for <git@vger.kernel.org>; Thu, 20 Aug 2026 21:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787261996; cv=none; b=iYbmRS1L9/w2lKFMgJgWGdmq2vwqM4iFifAPJRR5qDow3Y8W39PbzD/aoEALCYf9NSo72mXCDvr5cDOSjd629JdIi4m9JJ+KhS1P2YLeg6mBrXPM7gy7PJxnyxgYiLHgAnRLet85e7Hj6aOdXDMgdKGuGS3x62Ydr32FiAghBgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787261996; c=relaxed/simple;
	bh=be236kxCcU7dLPsK2uO1eFJA08Uc8PTvRHRJGxq8VI4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pL0rHIxyfUjFZQKBPEmqAJuDFVZ9BfJUD/mEJ7AR6dMD9pTRlsiGlh+fB3JmmoH8O9UgoW/Mi9l9eKeQ6l7uou3DXtUcu22lbWOrgK3hNUc5ExncEGx1lSQeebTS+viOCx+YvZomBaAyTnURmo9Wcp/2G7IXpkD8M59rU/kj+L0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=QXgelbAa; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aKqaqu8v; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="QXgelbAa";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aKqaqu8v"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id CE288EC03DF;
	Thu, 20 Aug 2026 17:39:53 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Thu, 20 Aug 2026 17:39:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1787261993; x=1787348393; bh=sDubTl02Of
	8uEOy868ogmayxonPyGXvxLheiBxFxk1c=; b=QXgelbAa9RhYnzTTbcrlvBCWzO
	7o/sMuUHH2zn45oRwsx0ZqIZawn23UE2v8JWZtBOJHpU9Cu5iwt2gBt152arjylV
	pb/sKXm4FUBZPhiv3srG/y1y9DxKil0WJY0e1xT8nUkBxq1HXwQUmUF8LqS1ukHt
	byz8lHxj0dCsSt1cAhkvlZlb9XJ3getZcTXeGHtuNfOXkx0N6vmmcGdsPKrVhvrL
	gVdH8z7tFFn1tyRcX3pXNRTMk2+zHOtTM4SBMWb54R5MUJuxO8fMyZoNNEVOQrLm
	Revv4XfKB9i6ARfhzBfS9EpUITA5gzjbawjaemAur16jiJaY70eK7lyX/wCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1787261993; x=1787348393; bh=sDubTl02Of8uEOy868ogmayxonPyGXvxLhe
	iBxFxk1c=; b=aKqaqu8vYLvZJR7+LMmf+8WH834e+MCP0YGltxKQIQpryNLd2qc
	UKWufsQtXmhxuBXVsjNBF7EyI2Cx/mtku3lN6/iz+Ufw/aKd2vnzD/B7ZaFqoKGw
	qIY0UEZxMK+LgC3LdZ2gXn7z4bBhPiXtoOeJQZqtKNIralmyObE4nacJkExLUjWM
	IutJukB6vCVBD1sukxWCtUquWISQ1H604ET32R/7xiqLG5s0MoMPescPNXe3533I
	OCgPZeoP0WYUT5LMw7JWNhW4aZfNOdTWM0pJz1hRosymFdXbHEW3pUobgXGcWqTi
	t1WnJMl5C7+R17r9tA1Od6KwfGLE5X93cyw==
X-ME-Sender: <xms:KXSHaoDGh1rwDefIRG4-uWNoxk9buh2CzMz9YlUI1xO6YxkM-5PZJg>
    <xme:KXSHahZrU6HwJzN0iiISnlkdyBPwzG-QDCmwb8gzWojtQEYpbhLPPvLPK9IDQ9Mnf
    0gMucZucrHxSw5r1mFsXtcBMND9eu9Z6ZrFaLTGsESRxbbXbDwI_Q>
X-ME-Received: <xmr:KXSHaj7vFBKLsnCTTWkz_5xurP_HuAnqnRpi0wfsE124MaUgtvxW8YUmAxRQM__oM3IPPss5xA6XQseo67NJJOtSvuQi61v3FQ>
X-ME-Proxy-Cause: dmFkZTFVOniXfVr2JxEY1wURGf4OEeCfqvtVPfsf8d7xY7siLXrFzeCP1iAq5r+9Jh7AsU
    X3wnYjtlDsWRL+082Zvvq3clOIfdIHUalc2L33FaA9eUc75XZ2OaJXGv9hoQYw2nUM2ijp
    JnPMbT4JhMuO/A2ZZ3G9JyWFC7UzgnQ85/29uCFOkY0QV2IYe45j4ozfLUBX6ccoNo0wwE
    E3va/xvTp6v2cjz1VHRxYcZe+qZ2X5jgx+mIpDm+i6EJnapPo0fJK5JbcisrUkrOku24PK
    EQBc4Pnse36jBANHCzgdMHz3semeHc73tf/YaKYYALWdgB6SWNf+ZIUs4CCmPOfy1+nLl6
    a0R7UX7T3lWOxqJtlkfpviMcjB7EE0ac3qlw9KVDfrWXTz6Ytzpx+CfUKrCAG5xgULXPgz
    FF7Am6Ic5i5IJ4BUaYgjQC6LXOcUt9CMCK3iGQmkyxRwIkzUHCEpAOT18efTWoXsracQXs
    pEe9wCMfVNirxnNCWJSwuADH3bNIxSNGoFRAiUOwxT9wk3m5pBkVcNoH8/8IBgbU30SVdR
    CtI2GMCr+zOaB8Vf8EZRUnOsgELlYsXBtpEoxw7P6KDG0yIRYRrg7i0LMfCmM94c0lKNk/
    1ueqWtzlHvd+zmmiz4bBDGqx+VvwkKMCau6OPt+peF810k8+AIuTRH0YEZhg
X-ME-Proxy: <xmx:KXSHaqa7pFho5slZWBF4_iXrlIAzVOusqM-HY0lNxLJlirlrFj_OJg>
    <xmx:KXSHaqjG2ORZpMDQGcuKOA2zx1ajdQpHsYuVhmRJQVSowgEcOIr8OQ>
    <xmx:KXSHaj_fowkmQHQpnr8mG759o8skgz7vf8I6QYOd6KvJbKZWAp-4-w>
    <xmx:KXSHatrvpRuXg4L3dcZP1kguR1jVpDPBr6vI_Vu-Z4bI375c6HbLDA>
    <xmx:KXSHalrpPftNjode8ioUFc6YLDIgcmQXzbBJCY0lXD0mMSUrMfRkX4N_>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 20 Aug 2026 17:39:53 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: Lutz Lengemann via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Lutz Lengemann <lutz@lengemann.net>
Subject: Re: [PATCH v2] completion: zsh: support completion after "git -C
 <path>"
In-Reply-To: <CALnO6CC35iuyJpKZtkEN7fGuGK7zKd_jbebyZdKSQ1pyfOBRZA@mail.gmail.com>
	(D. Ben Knoble's message of "Thu, 20 Aug 2026 08:28:33 -0400")
References: <pull.2155.git.1781710256081.gitgitgadget@gmail.com>
	<pull.2155.v2.git.1787144872870.gitgitgadget@gmail.com>
	<CALnO6CC35iuyJpKZtkEN7fGuGK7zKd_jbebyZdKSQ1pyfOBRZA@mail.gmail.com>
Date: Thu, 20 Aug 2026 14:39:51 -0700
Message-ID: <xmqqo6ewtqs8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"D. Ben Knoble" <ben.knoble@gmail.com> writes:

>>      ++                         ;;
>>      ++                 -c|--git-dir|--work-tree|--namespace)
>>      ++                         (( i++ ))
>>      ++                         ;;
>>      ++                 -*)
>>      ++                         ;;
>
> Yep, unlike Bash (which requires at least one command in the "list"
> part between a pattern and the terminator), Zsh accepts empty actions
> here.

This may be a common misconception.

It is true that a compound_list is not allowed to be empty, but
POSIX.1 sh grammar [*] explicitly allows ';;' to come after ')'
without a compound_list in between.

Specifically

        case_item        :     pattern ')' linebreak     DSEMI linebreak
                         |     pattern ')' compound_list DSEMI linebreak
                         | '(' pattern ')' linebreak     DSEMI linebreak
                         | '(' pattern ')' compound_list DSEMI linebreak
                         ;

where "linebreak" is a run of NEWLINE tokens or empty.  So

	case $foo in
	bar) ;;
	esac

is allowed.


[Footnote]

* Look for case_clause in
  https://pubs.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.html
  and read from there.
