Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8B11415F02
	for <git@vger.kernel.org>; Tue, 21 Jul 2026 18:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784657090; cv=none; b=C96hfXE9bD9oZHBX2z/TaW7LNpGV+JJ/vQxtIu86W2VQb4Kj9+paLAFvtKeJ2L2vUIcznnlYwFioKHJBjQkW/lwrs4tLIsssqrxBeg4AaSMw9/QUjNePSEw2aWQtRtmc5c8WK+zAAfR8vzP3mfyyq6axO2+1tT19dAaChGlhT/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784657090; c=relaxed/simple;
	bh=2iV9zUCUss90br2apmKgcefh4RHQA/8t/PPo4Lvd8GI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=vGiq3WMdjWlXIcwOsTBwVd+4rBIGs4wnNE/fO+Bpsj3itOgT/0NgaaMHvZ/KKeMn7xGqBqUOpjFnK2wOC33FqmkM4k59A8vnBqbcysbXNIPEOYlJg3fZdsY2xZA5eqthMaNX+1AK/6hXEOlQSYfMlwiNtiuSIY/1tYFj0ctSNF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=pB2qjT50; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KDYDscrj; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="pB2qjT50";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KDYDscrj"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id 981AB1D000B3;
	Tue, 21 Jul 2026 14:04:47 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-09.internal (MEProxy); Tue, 21 Jul 2026 14:04:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1784657087; x=1784743487; bh=YfCNK/jwNQ
	qWwiT5zgD8yq9KEdoU6MO6pOm4WY8tnmE=; b=pB2qjT50CblH0NvxjEfs6MGq/c
	f7zBxXGWG7YGwNakn0Kv+XCrzGNCYAKm3AWONCmoNF+aDFGuNW3RzSq2ZScVngdP
	W91pKqczuHx4dmV86+dGXC7tDObk7vbr2jGM8VM0u/PRWqlcDsbFuqsddxzCMlbs
	gNwGliEQ5Q17jPZxuaH2Fr7JOl2Ct8hRjT8PdkUu4++KASglpT3kBhDTppSrQ20U
	IDcRl3RfUnk4uBndozVkLS/L5Ti0tV1AK2lyWARt+z4NQSvS4Wdyj3J7wUsm4ScP
	fWyYh7a36O1JJXvMUngRMMH8H0lKgKvVGOOYIb8HtOmTIY7dZEC/snEtiI+A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1784657087; x=1784743487; bh=YfCNK/jwNQqWwiT5zgD8yq9KEdoU6MO6pOm
	4WY8tnmE=; b=KDYDscrjPnvhKzNyBzU14OZCKJaFP+a32u7j6TWNEhgzBbYD09t
	6oukXKcXqVkkmawojOGeB9cPPJJkZV1fD8Wf4geySrMbHErbi/jJh74sHs3LdQmS
	Uw4+EUtRQaC//JQ/ugzZuxWiNdWJ2dEX8VqCBcQp8GhAlB7YWg5UgYBFm2GgVlBv
	WS+oDqS3dFu8l5ksK+aertcRVJoTJrLkKgg+buNa32Ku+FasMCLnfEUKYEVrRvxT
	p0BtR9x2+bdit9XmkJaUzREtYrHClMou8x5FUaMdQEDldf1o8wM6dYvDHsR7DoxD
	WPTr9h17PYGnVlsoKFYKyVX/uZPF2FniIbg==
X-ME-Sender: <xms:v7Rfak5fdIA8YObSEUABn10DP3bAEbmaqwjFxMz0tYHhXWHzdvq64w>
    <xme:v7RfatWf5nBNK7QNrqN8e4tds2JP8Qh510saEfLlOpHOPMrmZDeiFAW73rIFlAhSG
    uqKYkh6KCcrSDsH73YmL66BnJElKe4GL0DFasTuAAMRQR0izyqAMQ>
X-ME-Received: <xmr:v7Rfag10pYi5BLUJDAZqCbGtuES-rFFywD_AuoQxTYnX65i7TPcMf5lYPEPv-C-G0kBPuEl_jTWCDLU_Q_FDSmmEdxol-7xxMw>
X-ME-Proxy-Cause: dmFkZTFDLxmB8O3Hok1J+zvfODaTUdYcZJeZOYaFSuHIKfJoDpcnLITO4OQhR7BOLNCfkb
    3qLGfafzvyhgHC+rqykrDeRO476I5D7dsyMZaqzdrKjlo/1Q+vOVndAxRVViVwHqU6pPvL
    CywAAZG+peUiorb/xL/XJ+GEH7dmbWF1/PB5jwgaQQvPDcF9mxFoUCa2vA95sLpz6M0+b2
    LFmT3eYI9pje8qsNQHO1OQ1n3iPqDckhdEifwIscJK2C1/ztgzbnZ3fWsv+jVimqQYCPt0
    qrrr5c7oq96SAoGw8o6Q6ivjOi6yeXzjywwH8p/2XE3a1Mv3eDTSX6uo3GDj0qVW1kwFTr
    W3f34wSkKjv2NQau4fAYWY56KzZNwmnufaICk23bJ6sOzsINarukz/VeFNBAtSMqNv0Epk
    N9StOmtWr+FPiZ5oMh6IXg3aBFYDQH0l2XBrZDWfwmyrvtN9QWVbRMeQM3enqgaB7XUhVj
    Wdqs+0fvcQb2P7IYSw0zpAlyAbocWn2C8Fv3U7uMEotsEyEHsZOj/cW96Ud/h4b8RnOu8y
    PNBP6vn33NJa1GG/mlmQG3GXFTBaweUdNmsL2WKa3acxEhFHID/16mcpiQzpUsVFtx+jCY
    PmHUy+CzsobNKAyKci4w+Zqevq2L+VGcnciBF51XoKjy+pey2tgX+QZ5fcqw
X-ME-Proxy: <xmx:v7Rfai2bfP-aCG0jQ4wwmswHHncVVIzJDyyP4XJagXoot_XeIly76Q>
    <xmx:v7Rfar_7VTmAB8FfLBrPi036jSpK7Sa-EWN4Pg1GDIPui7vrVX0lsg>
    <xmx:v7Rfan1Lb2rTiFIhx6Go5ggbs3Ks7MjMAoVdCagIgoiq6I3yb6qTaA>
    <xmx:v7Rfag98RLoPWJyeblFyAqFZ7bP_nhi5U76XIreX-usGLRG-sDLuag>
    <xmx:v7RfamFDq8NuAcHAI-er0pv8FydUquozPUv0TCmnP08eSNOGgjDrpaYV>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 21 Jul 2026 14:04:46 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Hugo Sales <hugo@hsal.es>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 0/1] rebase: add --[no-]edit to --continue
In-Reply-To: <20260721140443.1809379-1-hugo@hsal.es> (Hugo Sales's message of
	"Tue, 21 Jul 2026 15:04:41 +0100")
References: <20260721140443.1809379-1-hugo@hsal.es>
Date: Tue, 21 Jul 2026 11:04:45 -0700
Message-ID: <xmqqldb4xlqa.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hugo Sales <hugo@hsal.es> writes:

> When a rebase stops for conflicts and the user runs `git rebase --continue`, the
> merge backend opens $EDITOR so the commit message can be revised. That is often
> useful, but not always: sometimes the user only wants to keep the message that
> is already there.
>
> This series adds:
>
> - `git rebase --continue --no-edit` to commit without opening an editor

Meh. "GIT_SEQUENCE_EDITOR=: git rebase --continue" is your friend ;-)

> - `rebase.noEdit` to make that the default on continue
> - `git rebase --continue --edit` to override `rebase.noEdit`

The new 'rebase.noEdit' configuration is especially concerning.  It
encourages users to assume by default that their rebase sessions
will not produce notable changes worth recording in the commit logs.

A few immediate edge cases come to mind:

 - What if 'rebase -i' stops to give control back to the user for
   reasons other than a merge conflict?  If the user chose 'edit',
   their original intent was to modify both the commit message and
   the content.  With 'rebase.noEdit' enabled, would they now have
   to remember to pass '--edit' when continuing?  Does the answer
   depend on whether the 'edit' step resulted in a merge conflict?

 - What if the user chose 'reword', which is an explicit signal to
   update the commit message, but 'rebase.noEdit' is enabled?  If
   the rebase does not stop with a conflict, it might open the
   editor regardless of the configuration.  But if a conflict does
   occur and requires manual resolution, will the user still need to
   remember to pass '--edit' when continuing?

The proposed tests only cover the code path where control returns to
the user due to a conflict.  This is understandable since that
scenario was your primary motivation.  However, they do not verify
what happens when there are no conflicts but the user explicitly
intended to edit the message from the start.  You may want to expand
the test coverage to address these scenarios (and potentially
others, as this is not an exhaustive list).

Thanks.
