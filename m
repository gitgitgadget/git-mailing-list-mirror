Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 582581FE471
	for <git@vger.kernel.org>; Thu, 20 Feb 2025 15:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740066994; cv=none; b=hVOarEmuyiRf/hoW2FW6mOhrQlDXWE4eC0Px9WWdGoudC3vpsBYs4iJB4t9V201EYMHtwnjbiLzc3hohpOV8VGOp/+LxdLJxeQeXIbsPO6wvvIabNlqBiSHKW3lKib9dENrTDxeNjrroUHVstzevJzRsthJ8ktmESc+O0w91fUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740066994; c=relaxed/simple;
	bh=meEHzRaRiw/iyxRkHZUqs0/r9xxmD/Rx+cfdjn7TgvQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Hsh8OIbfaLxuM2RZif8Nun1D29bry+X2TsN1haVcvnZUVc6MnjYFPjqKtWT9b6nIyCI7tLavH86B1l/3MK0AAgphSRCs473vaTmoEzu65uZnFq74v2sCn2WTUOKbAOouJHpHwxZSnOlla93URW1gaewmtBWCZnTDIT57cqlnCQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=c7sX2qZP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OHyht4zw; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="c7sX2qZP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OHyht4zw"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 4D51D138098D;
	Thu, 20 Feb 2025 10:56:31 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Thu, 20 Feb 2025 10:56:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1740066991; x=1740153391; bh=uiXTE5ZnYM
	e7/U/zeDh2B0G6gFL3QmsLrZsc9vd/5sQ=; b=c7sX2qZP0tzuyFkQZwXnWpMc/3
	+hdvXMCfDnTp3wiC5/AfYASHYkdiOYUYGdlH07aiIx6SGl8VcmtuRpSlvBbD/DDk
	KcOd/txNyrrzxPpn5TBuUivJ+A0oAF+2H8GqEpBPS3uP0EjQmVPH3AAYCCKV0e1a
	zkcTuqEhY3FaNp5cJrRj3FqyxcCTRTRm64DnieffewtcX/CZhgH8hnyaj1FfePhA
	HAqY5LV8O3iB5O/dF4HGwfstaeBkrJ7SrXqaDoydX7JKWE9NbJDf8ho2gupkiv6E
	d/0a8Y2qd4rJHUqM9YKCzEGMdN7f9rQeEdMt00BHlMEpiDHtMMLMMt9VdU+Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1740066991; x=1740153391; bh=uiXTE5ZnYMe7/U/zeDh2B0G6gFL3QmsLrZs
	c9vd/5sQ=; b=OHyht4zwXCde0WMfBg5et1C+4n1+ld7gdkEpYBvZV7ZTRwIiqWp
	agp1EfDRwc+1682EoHCvUQ7Nqn+dzHE8rzuYAuh6P8R4jdIV0no08kN6327FkCUe
	6vpXGW6MC4UK0QOPBDwDHaHN1+FXQ9jvw/6W14enjT1ZBNC/IG1jdm+JHxM+Y6Il
	roGItJDnIRCWQZgtYRfj4ESJGeCf2Lx2k3Gecu6qpI8lSqFhbSe1uA2KxgjnLu3C
	jlboO3eMyDxn/Bu8oLDgfi7LAf9lsUvXPaPgG1sUhIYyCjsk7PQptXAlVtn6u1mn
	GOuUW8d5sxURnBmLt40pSlN7hNMq8B8SMbg==
X-ME-Sender: <xms:r1C3Z08gx6blCnyh_BhNKTStZj630NU6McGeRcO_Y78LP8EYRvcZug>
    <xme:r1C3Z8vXmXzsE7PcU2lzKjEErL1b4wPqBez3N2OK4OxlhIJBiOsGAz-jaG9zfUu-k
    KQzYZBRtgR-qTgL9Q>
X-ME-Received: <xmr:r1C3Z6Cb5TV0CsuJvCPM2lNhwnFFOFpTXvjFJZIODUhSL-uP5ZDsuLhRLoYE1CF9jj8NrLKftLwiaYC-fJ0CJtl690acXnW01FGakeQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeijeehfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpshesphhkshdrih
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:r1C3Z0dv-Lj7ZKhcDshbgNH2Z3sx7pc6luMd628YffZWJbr95cKLWA>
    <xmx:r1C3Z5PveFmiZS52JgbXWwYxFkE4Px_EBOVuCxTRCMp2lGB6xMCDrQ>
    <xmx:r1C3Z-mvJpYG3wLfeBpWXdCFb9Ewj_2XTX2g4Q54um0ozyQngK8r-g>
    <xmx:r1C3Z7vN7Vtp6T2gCoFCVyNyaomAdtKGIggKvtADOArgksGMTwxPOQ>
    <xmx:r1C3Z6rJk2tCGigB05FZW9FSHuzTkvATPRQDZ854WK3uPOaCczHeypfk>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 20 Feb 2025 10:56:30 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Feb 2025, #06; Tue, 18)
In-Reply-To: <Z7cPd79kZzJkLPi3@pks.im> (Patrick Steinhardt's message of "Thu,
	20 Feb 2025 12:18:15 +0100")
References: <xmqqy0y2hg8l.fsf@gitster.g> <Z7cPd79kZzJkLPi3@pks.im>
Date: Thu, 20 Feb 2025 07:56:29 -0800
Message-ID: <xmqqv7t4d2z6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> On Tue, Feb 18, 2025 at 05:31:54PM -0800, Junio C Hamano wrote:
>> * ps/path-sans-the-repository (2025-02-07) 16 commits
>>  - path: adjust last remaining users of `the_repository`
>>  - environment: move access to "core.sharedRepository" into repo settings
>>  - environment: move access to "core.hooksPath" into repo settings
>>  - repo-settings: introduce function to clear struct
>>  - path: drop `git_path()` in favor of `repo_git_path()`
>>  - rerere: let `rerere_path()` write paths into a caller-provided buffer
>>  - path: drop `git_common_path()` in favor of `repo_common_path()`
>>  - worktree: return allocated string from `get_worktree_git_dir()`
>>  - path: drop `git_path_buf()` in favor of `repo_git_path_replace()`
>>  - path: drop `git_pathdup()` in favor of `repo_git_path()`
>>  - path: drop unused `strbuf_git_path()` function
>>  - path: refactor `repo_submodule_path()` family of functions
>>  - submodule: refactor `submodule_to_gitdir()` to accept a repo
>>  - path: refactor `repo_worktree_path()` family of functions
>>  - path: refactor `repo_git_path()` family of functions
>>  - path: refactor `repo_common_path()` family of functions
>> 
>>  The path.[ch] API takes an explicit repository parameter passed
>>  throughout the callchain, instead of relying on the_repository
>>  singleton instance.
>>  source: <20250207-b4-pks-path-drop-the-repository-v2-0-13cad3c11b8a@pks.im>
>
> This series has been Ack'd by both Karthik and Jialuo -- do you want me
> to pull in additional reviewers to move it forward?

Nah, I've seen their comments on the first round.  Let me give it a
quick scan before marking it for 'next'.

>> * ps/build-meson-fixes-0130 (2025-01-30) 14 commits
>>  - gitlab-ci: restrict maximum number of link jobs on Windows
>>  - meson: consistently use custom program paths to resolve programs
>>  - meson: fix overwritten `git` variable
>>  - meson: prevent finding sed(1) in a loop
>>  - meson: improve handling of `sane_tool_path` option
>>  - meson: improve PATH handling
>>  - meson: drop separate version library
>>  - meson: stop linking libcurl into all executables
>>  - meson: introduce `libgit_curl` dependency
>>  - meson: simplify use of the common-main library
>>  - meson: inline the static 'git' library
>>  - meson: fix OpenSSL fallback when not explicitly required
>>  - meson: fix exec path with enabled runtime prefix
>>  - Merge branch 'ps/build-meson-fixes' into ps/build-meson-fixes-0130
>> 
>>  Assorted fixes and improvements to the build procedure based on
>>  meson.
>> 
>>  Needs review.
>>  source: <20250130-b4-pks-meson-improvements-v2-0-2f05581ffb44@pks.im>
>
> This one has also received two reviews by Toon and Justin and it has
> been cooking for quite a while, so the same question here.

Yup, this one looks good to me, too, from a cursory look.  Let me
mark it for 'next'.

Thanks.
