Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25EAD224D7
	for <git@vger.kernel.org>; Tue,  8 Jul 2025 20:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752005045; cv=none; b=dtmvrV/fx6SOZGGu3RkL2wsrQAD3muAJcQAvKLL2vWEzdXfRHEhYjyeEvh+uRxMWYU/sgS5Zg7MUgLjzumHgbWcc/rmBb267a9cBVvH59dyprf+HOM3cXcIUNIfQufoIWjKV9nyiVgPvluGvgLgeQhMu5mm04P9mSEQ3Si3I9r4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752005045; c=relaxed/simple;
	bh=0xjPqeRIjvEV8oG0UKBpbYJaqbcHCp5wlNuiirP6Zq0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=a2+1P5IzCnIBxH2L+EczTLw0pQADSKSad+/tXOQGQ0M3GUG7HISgEmtlRONtopHQbFcT8EEdKRYl+grvle9VDzGlNYuAaJeqnykn6U4ORGG9IyhE/7IlrblAdDksqanZVstHIWmZpjFxHeFKtOo6CX80hEtmQ/1gKGOgFZEWm8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ZhiMQZ7I; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Fhf6MscX; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ZhiMQZ7I";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Fhf6MscX"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id 2EB89EC02BE;
	Tue,  8 Jul 2025 16:04:02 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-12.internal (MEProxy); Tue, 08 Jul 2025 16:04:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1752005042; x=1752091442; bh=S8QFo4fqPa
	bsbO4DKHCXMqb0doC/1PT+x1qoWLu5o3E=; b=ZhiMQZ7Ig3rwC/pxbonz4MY3x7
	HwmP7XkG/w3bl48ABCL9bA8b2xK8P1Bi0A95iicy3AcpN4uDZk89EMjGN2BkvZEZ
	0A+OM41TnmAs1aOjVu+YGBoEHWUd9UIJjEFZWvVfSswR2bzOHPl9NIeCSF8aMrGb
	sX/Dl97tqtOrjVdvof86ya2adJpY9TbwQCz6S0SQIOka6ddnhg8VAJ4ePkSYev9o
	g/WnJK4S+OdE6cmjVXfsn93Cz3OtKhk/ref7kvnFLUA1YBvqxFeyWFY46uff91I+
	eFdq4jLuXNq13CR3zo26p6wJDdpN5nM0AwNtXkADu2anyVdGuVP3jWChfE7g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1752005042; x=1752091442; bh=S8QFo4fqPabsbO4DKHCXMqb0doC/1PT+x1q
	oWLu5o3E=; b=Fhf6MscXcpBqd2RTqZtcGnIAh6fSo7s+y7mCIqnQdcdAMJmOyWz
	BQV74obXu93Z0E/BfNZhL9iwupeLrlOhkSxPqs1ohYbOTkr6Jk26ASbrXyc/K/mm
	qpbHbeggbejQmaTtkJDlq9CQm5aAyTS4+7P1gVgEIRd25cmYWBkAtK3zUGM9VNdb
	64h6x4fkynGv1Eh61k/5RwYgtKF1HBiRzn40IlNY1yJa/lslZJiue+M7NqaGtFF3
	kVuiujVAmFraMVRPhk32eymyVRAZvFkxUe3eSVtPz/nyCaurLOsWL2rhkp5khVfY
	WbIQbgsGGaFBdaC9COX7/U73w+5ZEh22QEw==
X-ME-Sender: <xms:sXltaPt9exkj4GHEbHc4Lll0decdwPT7xQWye9l3XIWw4zGrV4vmNQ>
    <xme:sXltaDsups4xEth1t0m3__nEJiHNR7YKiEYHbrZplJWUQT3R4I9hhX-UmnU6wtm7X
    r0vRtf6LNDDBCyY8A>
X-ME-Received: <xmr:sXltaMM0eftEJI_ST6zt7_7-GeLYozdJquaUd688uXDzIh_epMYINtjsTRIeaFVHInOeAJSlCdab4hzSy2omgW30uJTF89Z5UkBxqaI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdefheehlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephffvvefujghffffkfgggtgesthdtredttd
    ertdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphho
    sghogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevff
    eufeejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspg
    hrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepmhgvsehtthgr
    hihlohhrrhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:snltaJ0kKCCkLSSgKFtukvQ4kZlgnTrLwvFq6OQ_QCqGUXKpEyubIw>
    <xmx:snltaAMmSrP_BH4nOAGsKkF1rF5SZ3Zy6bo4wYw_jaOGu4jdCCetmg>
    <xmx:snltaB3rTwfhC8WVvNc-H-CCYLysk2Tafv8PdF3PBZfJe4G-aLW1fA>
    <xmx:snltaPHpLTK1QZ6vUHDFXpnXOLeMhMUMZ0GT_MQgOu0PWw9qcIxKuQ>
    <xmx:snltaOgiSX_izVwE79vgvVZb_-M50_o4Nn4rN141OIpmXBnu4MFPCgue>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 8 Jul 2025 16:04:01 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] Documentation/RelNotes: use .adoc extension for new
 security releases
In-Reply-To: <d45d881536585ebaaf21ad5089afcd45523df783.1752000456.git.me@ttaylorr.com>
	(Taylor Blau's message of "Tue, 8 Jul 2025 14:47:50 -0400")
References: <d45d881536585ebaaf21ad5089afcd45523df783.1752000456.git.me@ttaylorr.com>
Date: Tue, 08 Jul 2025 13:04:00 -0700
Message-ID: <xmqqfrf6v49b.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Taylor Blau <me@ttaylorr.com> writes:

> When preparing the latest round of security fixes, we wrote release
> notes in v2.43.7, and then successively merged those up through to the
> various 'maint' branches.
>
> However, the 2.49 release series is the first to have commit 1f010d6bdf
> (doc: use .adoc extension for AsciiDoc files, 2025-01-20). This means
> that we should have renamed the new-but-historical release notes from
> *.txt to *.adoc during the merge into the 'maint-2.49' branch, but
> neglected to do so.
>
> Rename them accordingly to match the convention introduced by
> 1f010d6bdf. Since the release materials in question here were prepared
> before v2.50.0 was tagged, the 'maint' track for that release series is
> OK as is.
>
> Signed-off-by: Taylor Blau <me@ttaylorr.com>
> ---

Thanks.  Will take it directly on top of maint-2.49 branch.
