Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC0BC224234
	for <git@vger.kernel.org>; Thu,  4 Jun 2026 01:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780535376; cv=none; b=PoKZsEmCu39HNAiiFxAS1XckQRmcQakl/xZWU/LP+kAfTue4GPOKD5tToIM9QnKX035+T0OOBmA1iU1sJ1BQsbj5NtQhgza9kQ8urg9InxvzHPzuuZFzvpCYQ9ACuXNAnfJG9dlbUVw7aVbFdO9W7NroCxdQXbbN1f2Y9lcbBhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780535376; c=relaxed/simple;
	bh=mi8CLluvw0DaNP5ljcWL48K7o51uuXwCqadJNJLrPqo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YfEskIA9OsbphzoKexV7db3i9j9F4mso2UC0Jbb5Bg/M0valCxax1VE5qWDbtZYqfofWqDKCjY+mx3JstJcHnL4ovMurCzuZVM+hKqDywWuyrzZhR3viHha/bGXhrDBMHmJYcF8oYbkY+APnNFOsSj2w5bbegd/y4l86uWAC0ZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=fBntBEgB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IJQXV4iX; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="fBntBEgB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IJQXV4iX"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id ED9CD1400091;
	Wed,  3 Jun 2026 21:09:34 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Wed, 03 Jun 2026 21:09:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1780535374; x=1780621774; bh=XtxANHCLc2
	/VCHcqnN1QQ6dAv+RxELCVNVQVltx+MaQ=; b=fBntBEgBo9qpT02/J5pTFOanw7
	rZohBXUr0FB+gZ7h3ygPr/v8KxkVNNfKy3W382fbso16QBXR1MrkQMQW50uXf3PJ
	8CpFEsUFpjQ8PfAR0C7dzAE1RZ8/x7CC+1kjNgF1N+NjzrFapRXwH9G+1BPUWoyw
	X+uPSsLdkzz1I+zPAJscBausotcOA2ToDtXYsKtJO2GLrLAC8g97LiKGQW5w3FwA
	g1aafVC0Fr/7piE2el/zB7YpeC1f0eg38unt2bb58FaQxYCkTRmNZdd/4Q09mUhW
	uUZmhTtIXSYQGRloENQFjdUNJe7HLwVsDA1pIwVOzspGnzFlEajtUUX6baDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1780535374; x=1780621774; bh=XtxANHCLc2/VCHcqnN1QQ6dAv+RxELCVNVQ
	Vltx+MaQ=; b=IJQXV4iX+v4AcxjyZuavCBy1pzzlRsWRGKK/SUObVCtILX+2STt
	yuA9nNuJ5DFdSXCGJTgM+ougHS19mbU2d69ge4/EZnrwEgQmQF3OeejB1y/2kaTA
	n8BN6tzw25Hsi6RVyMDlvAK9/jHavjajSrI4ovQhr+dJdm5F8GlTEQfjb2TbonTn
	bcQfUU8WQAnVD2yvXEzVlexszPGlEcxAdIKrQk/2sUqG+FRkcpUPSr88Xco88VpH
	TPPyf3nm9uUdnlWz4WxA18UiTkJQ3QS1C3gpgM/VqOk790j5+3lIBmj1jgolXVoA
	MZ6VSTwI4QUNoBmF791JhgqIig46WHbW6Uw==
X-ME-Sender: <xms:TtAgakxzHLABBWLjIJ8Ph13-bn36CM_sP-jXt7dfYUgpSJklDZarzw>
    <xme:TtAgavJF8NiK_74Sav7__gmlMre7stKp9FOP_ea1UhLNTQe8l3K76GeJcokGctKla
    UpHB3ZWz7IacR8PIKu2PfkNj0gH0QRkpo7ip5vKgsaol8cLBznX>
X-ME-Received: <xmr:TtAgaurGTzdidfG7no5Zf6kLayv9CTBM5NhM-r09_JSLVt50DPnZXkLE6GXniKhP4-0cSHLvedWPQUI4taj-8b0cAkgjtSOd3WmD>
X-ME-Proxy-Cause: dmFkZTESxk8mliN16wclUPWN5DS5kgXmo9l938mFjTM1QnzEs2pDi+tzjhYfJlU8y2FgRT
    w2D6hO3Wrl4HPzVYJaa4vYi1Vr0TgioaaGT21aMaQ4O+jxVXHLTEF1QuoS0QMPipNbeftT
    lC7+xonQLWpE/Mqiqkn1T9EHlGFbHr/WkTClYDRcfrHnpwDXzAl8MJ3C33k1IDk3Yt6hP6
    iV8j5jplkNYCGQokUKYcvI/vXbf/ajBPh+YnkqQRq+wo4NcXDEAjwBQDmcUaHrQDA0PZ+I
    WnHZR0DQuDLiYrRZdyHTcSqXuX2eHKL/2jNNvOYE1fTWjUmkeUlSZBSY8S/ouN1cc1nrNJ
    TjHUAgsN3wh+o0TWchaUBvw62VbidwO+Igy63qDd/LJa4O8NKqXzGyub4qs6Zu60TrctkP
    KAQ+K4d0JHcNMPy1CyZvjK1tXh55HO8fxihaqbUfXqnWrx+guzU7R+hrns0YdFAn20pdwS
    3NO/pcvlltNL+cPAWYNJvcogZxbNJWpSCMslomgAXi5S0WKbvO1RCto3Tn80oeDsoYkLB6
    IWUdFj7qAH6WBGXOmIgN6ejuSyfppEVPZwTJ3BXJ9zqIIu9xwDQZHduVjoDjr6usCybZHu
    UOHBNrQ9zcuqDX5dhDZOUXoFOphGZ+TXzR8TAY9jAVlaDWmQ9YAS/QCgsPBg
X-ME-Proxy: <xmx:TtAgauIXBwtETOFtB7wgcXCrBlOnp1tS4kJagnKswWQNaOZA34ZSkQ>
    <xmx:TtAgajT050YByCGM133RHImLYCeM59RIM5qAp6NJrUpK7NqLoWQ6-w>
    <xmx:TtAgatsLFtJ1Cug-eA5fA8SugOjOLB17UcO1_GNRCSyrQms9x0-EIw>
    <xmx:TtAgakYWJ3Dj6AlGRSuCzdFhktfXOc6D9wg0YpYmr3bdrS4NITfFjg>
    <xmx:TtAgapZo26PdtjRdQl9_rKmxxG9B5OjCEbB0gwrbbzszVTzZyECjdEiI>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 Jun 2026 21:09:34 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  Harald Nordgren
 <haraldnordgren@gmail.com>
Subject: Re: [PATCH v6 0/2] config: suggest the correct form when key
 contains "="
In-Reply-To: <pull.2302.v6.git.git.1780425808.gitgitgadget@gmail.com> (Harald
	Nordgren via GitGitGadget's message of "Tue, 02 Jun 2026 18:43:26
	+0000")
References: <pull.2302.v5.git.git.1780407557.gitgitgadget@gmail.com>
	<pull.2302.v6.git.git.1780425808.gitgitgadget@gmail.com>
Date: Thu, 04 Jun 2026 10:09:33 +0900
Message-ID: <xmqq1penqfg2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com> writes:

>  * The quiet parameter now lives on a static do_parse_config_key() instead
>    of git_config_parse_key() itself. git_config_parse_key() is back to its
>    three-argument signature; existing callers don't change.
>  * New public git_config_key_is_valid() for callers that only need a yes/no
>    check.
>
> Harald Nordgren (2):
>   config: add git_config_key_is_valid() for quiet validation
>   config: improve diagnostic for "set" with missing value
>
>  builtin/config.c  | 32 ++++++++++++++++++++++++++-
>  config.c          | 38 ++++++++++++++++++++++++--------
>  config.h          |  2 ++
>  t/t1300-config.sh | 56 +++++++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 118 insertions(+), 10 deletions(-)

Looking good.  Thanks.  Will queue.
