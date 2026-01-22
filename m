Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D07F36C5AB
	for <git@vger.kernel.org>; Thu, 22 Jan 2026 17:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769102265; cv=none; b=YTTxDBvbYAzajOvgnBCgGmpvsq8A826IThaOVJJtrgFmuFK/YpMqHz47wcROYbAABGkZ7uHTncF8k6uWHPlINhipz7VrM3uQINdiRgb31gTnUL99WY4I3UPvLBUuMGOlSF/egkuAXTuthACB3f+fNNPRQc3PCudRwgxtK6LxN9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769102265; c=relaxed/simple;
	bh=y1qPhEos0fp6hcb3jAO2r8XlvjhqXBOR6uwNM8Z1vvg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tUJehzxpw6jeTb5y5M/gNSuBVFY+EUqpR8xJq7JJfvViB9PJpSZCWwk/r0tHAe6vVzVmdv/2i2smOw+v6O4zR0zldDksbWKH718mWbsatBv/TzuyJRTTQGHx5R6p1EG/fsjYq1HOHdraEqKmWSfOyzK+V5ZtXXrYAGHFgINxaqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=oyfFG3A5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=B7Xoh2WM; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="oyfFG3A5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="B7Xoh2WM"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 0674EEC00B4;
	Thu, 22 Jan 2026 12:17:33 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Thu, 22 Jan 2026 12:17:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1769102253; x=1769188653; bh=LGdFfAAGKh
	FgXQF36EBpA3u+n2L+ONzKLn4p+HYDoyo=; b=oyfFG3A5WJVnj8KtV6t6zpLcPH
	3dxMri4TcUKizRI8UUM5TXPAx07wACmNfg0bF0g32rzkdVkiGIpjIglN2mYmVaa/
	OEt4r3ofAmnBFaWyTjRwSdW2ESOMmb9ycPQ5W+2VhnBEKKdhtrkjsCpvIMtWtIRo
	cWst9QKCb5sFZjTT15mm39zvF6VfJYMfm9tdcjgnvzTePRTYz+tdfcMxjd++nTO/
	Xs3LaMpPq2X+7TCu1Bi0btSrELSzmX3giKRCxwI4VeHqlujfpOk0BVKEWQzP0Fa6
	Lye+T0QBL0Zp6tuO43QRj7F0j+5cHWH9nbIeHzl6s9rV+4wGcQBoenC9P9bA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1769102253; x=1769188653; bh=LGdFfAAGKhFgXQF36EBpA3u+n2L+ONzKLn4
	p+HYDoyo=; b=B7Xoh2WMWLKb6ptOWgB3RubiYJL/Wj7B2N8qRtF3Vd3f6QGcVuD
	0zJkTuXW7a/iDsMqodQf4+lZXKPhNf6D+mthPGIpkSXjyEr6VvY3US/MnApzO/BQ
	QbMcX/Q6PjJF3dDxRdL7n7swMzIKJaiWXhpQudH+IRpuK2FZ1fTv+TnJHguyq/qP
	CbHSy5SbIi3CqscIVyZEURYQ6wQZohj3r7JtbrduZ3XEbbzqaKH5KXEfXrMbsVew
	/DYVK+gmYzL5K5cdXC+hDcCrsNOqogUPs0VnuWwGw++3dwdB9iTLhPSEsK6RZzYX
	xztenSw0FE1ieZsmt6PgAlS4OhAxoS+H81w==
X-ME-Sender: <xms:rFtyafmL803Eq6Q5LQnLoHiuT7j-eBETq_BAU7LIVjRGLyU0N4lA3A>
    <xme:rFtyaaRG0qmVHLcR_e1BsN2r_lNJB_KGX0HfRwYaOYJh-24UzuUpzUw9RXCAdU-JK
    _baFtWX66sKXk9z-5Wcpu4qoa1LYtnyuEUG7tsHC01755-TPC3ztw>
X-ME-Received: <xmr:rFtyaTB0rcVOZXJlHyR6MHarlQTrvt0WEjvjoUkFjG121bzQitAu8SNsk8JN7m7bhHNS9AePQpeiryCx05fgXBRymDcRz8YVRtiRe2c>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddugeeijeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeive
    ffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehhrghrrhhi
    segrfhgrihgtshdruggvpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdroh
    hrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:rFtyaRQcSKYEjFDblwyCoKMhgTKKooW64JkXXBQZTOlMIKF_O1L19w>
    <xmx:rFtyaRpovzqdPH303pdbZjr2-QRrpkl44-GPrvsppzqiGT6Qgh3rvg>
    <xmx:rFtyaTwwkIkyCTKOgLcKBrWGKGoVDAJ-hKS4FnGPYBkn0cX4TDEH6Q>
    <xmx:rFtyaWJ73QpeL1ht5KFvYUveDIZmRQ7YW2femff0O0mV8UUUSJPVRA>
    <xmx:rVtyaT8T_2L3QIZaIFn0kxxDCkj3ryhVarcxxApCS4mRT0GW5B9tbDOH>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 22 Jan 2026 12:17:32 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Harald Dunkel <harri@afaics.de>
Cc: git@vger.kernel.org
Subject: Re: make "git --pager/--nopager" work as intended
In-Reply-To: <87o6mm2djm.fsf@tweety.afaics.de> (Harald Dunkel's message of
	"Thu, 22 Jan 2026 10:37:49 +0100")
References: <87o6mm2djm.fsf@tweety.afaics.de>
Date: Thu, 22 Jan 2026 09:17:31 -0800
Message-ID: <xmqqzf65o9ck.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Harald Dunkel <harri@afaics.de> writes:

> Hi folks,
>
> maybe its neurological, but the current behavior of "git -p" vs "git -P"
> makes me feel uneasy. Some commands (like git diff) use a pager by default,
> some ues it even without need (git branch), others don't. For every other
> git command I run I have the feeling git output is not working as intended.
>
> Setting core.pager to "cat" is not a solution. It breaks git -p.
>
> Regards
> Harri

I am not sure what is being asked here on the subject.  As far as I
understand, "git -p cmd" and "git -P cmd" do work as intended in
that they override the default choice of use (or non-use) of pager,
built into each individual command.

If you are saying that you disagree with the built-in choice made by
some of the commands, perhaps the following snippet from "git help
config" may help?

    pager.<cmd>::
            If the value is boolean, turns on or off pagination of the
            output of a particular Git subcommand when writing to a tty.
            Otherwise, turns on pagination for the subcommand using the
            pager specified by the value of `pager.<cmd>`.  If `--paginate`
            or `--no-pager` is specified on the command line, it takes
            precedence over this option.  To disable pagination for all
            commands, set `core.pager` or `GIT_PAGER` to `cat`.

So, if you have too many local branches like I do (I seem to have
411 of them as of this writing), 

	[pager]
		branch = false

would probably what you want?  With it "git -p branch" would still
let me paginate through all 411 local branches, and "git branch" and
"git -P branch" would make them scroll away.


	
