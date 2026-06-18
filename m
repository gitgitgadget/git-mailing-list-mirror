Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CF382DFA25
	for <git@vger.kernel.org>; Thu, 18 Jun 2026 15:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781798069; cv=none; b=lDGA1uGIT5jLXeEd2x4m9ar9mvrqoOKFreaZXCn7J9MhUzHIh4HF4YyEcwFxLtbh0BunPF9MVPlSWjcj2nMOESwdDhMzqg+x/2Ii4ax/dlSB73cVyFfGMS3Qr7knCScswwRs03tg/KT+d1Lw3ooayBRsZ5seTTX9m1GsWBY1sp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781798069; c=relaxed/simple;
	bh=H+BZgjZ0DVvT8CA088lMl4DIOspjKIkquuSkbLtg37E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nMW7l93Iz+Zis3JPH9l8HW21yP6sMPuhTsjmkjq9ghySGw5f+cxtowwGfztgu3dW4Fuf55VWBQdJ30XaMoRG/ZbqlZS6G3ldCWLZUp7SC+UnRZ496ajDRVi9h6hVbjUypU/WkAnaj6ixM6YSgV9618rwFV1q38yMzEGNDn71iEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=MvFdn2M+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=c66RYr2N; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="MvFdn2M+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="c66RYr2N"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A6C8314000E6;
	Thu, 18 Jun 2026 11:54:27 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Thu, 18 Jun 2026 11:54:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1781798067; x=1781884467; bh=6d2Pn7PfBU
	KT1Jl/dADIw0MUJiakA5bk55zBgZweTis=; b=MvFdn2M+5xxIv7+ZKxbUwcSDxK
	ZVjGK/csHzmY1pxJZHhQ56KpsIJdWIWa74uBazXW1VkDqE/2Io2OFJZA+BFcrNjm
	nlFMDjeYf1rVytCsCeTxlhAnHhRzKmZGVT8KrUQ/FZotxfVxcyZX02mJ5q5EqLwd
	BeAIFt87SYeETyKTL3z9R1nHNrHN04+DXK960rPs5PEgSuv1KugHxZZMnVsO/vWa
	b//0/asCiWM0eCvUYrSRnaOOkp5i6VgxhxwstrgW+9U9gaXtYSGweH0B6Vh2Ly1R
	cmAowX65CymAFenaGHuYAyIkt2ZA0o3KTvR5dQOXPUveXR7Pkc3KfXDupK0w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1781798067; x=1781884467; bh=6d2Pn7PfBUKT1Jl/dADIw0MUJiakA5bk55z
	BgZweTis=; b=c66RYr2N9qoHSBXwpz25ysSS84fpIqAIA8wzrOanww9kcC1HoTP
	qcxgTJ4D/Zzo65HyvHzKycjYg2X7nZI5KatX02aeEjR7kJiqQ2twH7k5olZiA0VU
	WMhDzTFYDjENpt315Y6xSkZltjM+uRU1oc58nFD9DR4a98Ih5HY/0CUAJ8jRDnld
	7ECWzp3TTNFPRay2DkUOKJ2xf8bXOiqNHkv0Eqa58ZUr4vifVTkXAA9SwXrVFaqp
	C2fPPDp7YEYryt2XX/xRfOfqj35+Rx5PucSsdRm9/o2FSBflOcuhOjuBoTt/y4Em
	X2sQTPjhfLYHpe/fQ5kwJGldsEnTPZx7FdQ==
X-ME-Sender: <xms:sxQ0ateS_9FNFVQntbbT_Jn_XBpZo-VYgjsOtgdtCM2WTjJAcZ5Uig>
    <xme:sxQ0atezwNblmFV5HluW25HXlWV8B1os5hvoLLrYh521XN4TeqcTEZoAnmORyE5O3
    G09G53OIS5JO9mzBUje34q6hox7oj2E-OGBZ50qcsd9rr9GSkGYcw>
X-ME-Received: <xmr:sxQ0aoyYF7nmo_V1H4Sb9nZ00S0hrml05HtqkI4YpSD8sQ5Vu7VK7Wgx5M7asezgT4r9wFPZEs9LSUV4IEt1TyrhOaB62uUz8m2I>
X-ME-Proxy-Cause: dmFkZTFLNSLtbYLNBareWTsQ4UmoIs1xQVG855ppgOB0X8bt49w9HFsZHKtH5dWK+zRUZH
    Km+Hkb23JCZJRI5KXiH1hYEtdPDSneDh1QS/MnfMw9UkI5y4glixM1eg2BuK+6wfXQ2oSQ
    vUHWLqxp3sFhiA3yAdAZEiSBLl+ST1qBeKjgrnINCQXd/HCqPey9XG9J/hkFEuopwtq/HG
    rOHzvlhPasO0L5F5eQxvV/mvXOu0Z3qnLuTZKVrHydlyEJn/087jTe9b5CT9tQ8hZlxbkC
    4gXdPlGCUik3fcJokXdodLAT12S0l3PuBpBdUa1TU4yaltYs1Qs6wSu0zuQCTGHdmdQIIR
    S1aNkRx74eEycBRSqxU5eou4hdM6eoUiJvIw97wG0aqEB9W5S5ehGmCDUcilqMO9qmpsFi
    CEUItROaseu3DO1AorsOm2VJzqdfsfW3hOWsiXF4K+f5bPm+yZbaeKSLvavTV5mIcHVdl/
    xkuS07KOsUee/1q3ulM7pepTH2zjb71tqWGPzXc3msG1jZdqYAhnqAWX3hEv3QxDYTvXs4
    kmGQ+RMCxKjU+a9vKMnBQDEd+DNgNelzTTVPlOr87TBAIMm9W50R4Mub6d2ji2l/R7yIN1
    od6fmzxbebkhgkVO5gsVyfu1fwwfIuN2vQzTiZ7WfkAJ+wCHaQvl4Xq/qjww
X-ME-Proxy: <xmx:sxQ0as8p2Zk9pSJs3nY1Wiku5ofR10N1Ui6QX1WdmtyIPCuRZ3zBQA>
    <xmx:sxQ0aoibj_F4JjJRuylgngQ8ix_6jg3WLpSMg0eqrRjNqnciXVIgLA>
    <xmx:sxQ0arHIjoNwDNopi9iOXzstS16CJAQXc70kK2hoT3aEVsIuZ4jCKA>
    <xmx:sxQ0av_UIEGMlYlh3pAVVG34ePj9agw1zAt4cVeyRnWP5TeL4zw0ZA>
    <xmx:sxQ0alqRjpy04oibqwKcbojNHqOfO2YmweK71hjBMIymUbElROpcds5E>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 18 Jun 2026 11:54:26 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Tamir Duberstein <tamird@gmail.com>
Cc: git@vger.kernel.org,  Karthik Nayak <karthik.188@gmail.com>,  Patrick
 Steinhardt <ps@pks.im>,  Victoria Dye <vdye@github.com>,  ZheNing Hu
 <adlternative@gmail.com>
Subject: Re: [PATCH v4] ref-filter: restore prefix-scoped iteration
In-Reply-To: <20260612-fix-git-branch-regression-v4-1-f150038c02f4@gmail.com>
	(Tamir Duberstein's message of "Fri, 12 Jun 2026 17:27:44 -0400")
References: <20260610-fix-git-branch-regression-v3-1-6fd48fad7a53@gmail.com>
	<20260612-fix-git-branch-regression-v4-1-f150038c02f4@gmail.com>
Date: Thu, 18 Jun 2026 08:54:25 -0700
Message-ID: <xmqqik7fsv2m.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Tamir Duberstein <tamird@gmail.com> writes:

> Changes in v4:
> - Explain the historical references in the commit message.
> - Run the new performance cases with both ref backends.
> - Drop the Assisted-by trailer.
> - Link to v3: https://patch.msgid.link/20260610-fix-git-branch-regression-v3-1-6fd48fad7a53@gmail.com

This seems to fully address comments by Patrick in
https://lore.kernel.org/git/aivx-7VOKE_TC50R@pks.im/

Let me mark the topic for 'next'.  Thanks all who discussed this patch.
