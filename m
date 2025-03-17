Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90BA814885D
	for <git@vger.kernel.org>; Mon, 17 Mar 2025 22:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742249836; cv=none; b=cW1s4vpjxwoXVsYrGoDLWjoWK3o18JwNWA9SdtOlHG+RNMvOHX1fset/bC658rYVcpajO33QYpd3QXokcKz0zAC7cyTxJAOJkt+egToc4gDw43yJRmVeGZmGzMSC31gaRjXfrNw0MA00ZqIsj6ZONmwMxLBSioMslgrOseuskUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742249836; c=relaxed/simple;
	bh=YTDndJwUsuf1/wrr2kbaey5176vJWfuaIJ9rhysR5n4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nTM9mfccsoledTeAfYpzuazTRqc8sfAwafU4v3cAAcLU8Yx4vtjskr3ANeg2EdeoaQxKxmlpVL0vo5oqGXfY9DJ3ShCSTbD1qXp4hEHqLs6G7/gfIyyQXnmM8Y+Y2h6/wA7XzUIP3oP6MbYYY1QSD7v9Q/y0z9Q6XbHQWpDBXmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=F84uM6PY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SRfKILXM; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="F84uM6PY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SRfKILXM"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 8B4101140158;
	Mon, 17 Mar 2025 18:17:13 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Mon, 17 Mar 2025 18:17:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1742249833; x=1742336233; bh=A32osJq1X7
	cLU6xiYWkbXkwMA4aKydD2sreevVNqixU=; b=F84uM6PYCTeiAfatc0aeeDwzd1
	ho3d+1g+Fywu4lvBjNy/kN+G17GtRktLskAo6Sj6iMLspWoL16EJA2LE8FewvYdg
	6vlKogmd1G7yyOym+QQqrxih3R0ngvvkZg3TRGEyDvmonJgWKJji6P/FdT5/h61Q
	zMmXnPjky/9AbUJFgs/pElPSgqWyyOfineVr5Z7V2JWz5rEMUj291aqWI/Gy39fE
	SXNgsf1baAnLG7NIbthxwV7CFOvhStcZvtyfWhEa65pUOTYpjBfT1xe5ObgQmGjS
	ElXcR0dJC0CMiBFiH/yf+8wJ4cB8mHqepREyVgGh3blfShCXCw+f0YTHDZug==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1742249833; x=1742336233; bh=A32osJq1X7cLU6xiYWkbXkwMA4aKydD2sre
	evVNqixU=; b=SRfKILXMd8fS9RK600uZnv4C6iw8TZ6ksnIUYPZO6W//54mXVYV
	Uybb6Ac6f8PO+pveswyc4+GvpmAw7kibLudZgF1t4jA13klRT3dUQinSO35cXVU4
	bdKETucWiSaHfXZrpCl+aAIvGYMZ/VqjnSsGGoFNjJ9OOPTSd+t7Rfx3nZgT+Ewk
	g9RFi85720wxsQl13ZEa3Bx8ixILBgqyF8vxaBIiGSgoNPyQ7cAM3X2X3vCZPmQ8
	ziB3kydTs4WjiX2pcvwp+ICOSq1yqGyfXXQDL78fmPSzEQ560O1ObE3XBAXJM3QX
	FlNUEJTAM0YNEK8FO+XHyKxPZhVCzbdYCpQ==
X-ME-Sender: <xms:aZ_YZ8PJURjr9Trmsrp8Gh5G503se9Rb8KcsWs--7ytg22cnKxquxA>
    <xme:aZ_YZy820jeyjxVxSREizyC-G7nL42Wk_CyOwoYlKOPItFAb80Rx8mxVXbiiGMAro
    qegljuTyR-HNpRYiQ>
X-ME-Received: <xmr:aZ_YZzSk401JQ_XVQzdqeb39L7SeANwMFEz4n4cAVm2M8WBJAsY7Ei66NuawQdlarI43OxHKVORVLH1LbhGZq_oC8Qa_T7cdA40E2D4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddugedtjeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepffeuhfekffefkeefjeeftddtkeelheeh
    leejieegueduffeifeeuhfdtieegjeeunecuffhomhgrihhnpehjshhonhdrnhgvfienuc
    evlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshht
    vghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpoh
    huthdprhgtphhtthhopehjohhhrghnnhgvshdrshgthhhinhguvghlihhnsehgmhigrdgu
    vgdprhgtphhtthhopehjvghllhihrdiihhgrohdrgedvsehgmhgrihhlrdgtohhmpdhrtg
    hpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihht
    shhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:aZ_YZ0sOR2yLgC6Js4adiS329aJlcQ6VQSoQpvkiY-3zlSjf99uovw>
    <xmx:aZ_YZ0c8gGS2jOtldFDagg2eAtdKOH0SluvvMOrzaUg65_VC_B5OiQ>
    <xmx:aZ_YZ40QHKXVTrJxrPvcoYjYpIevYUTTVBc1bXx42FfyD2GIUV9ExQ>
    <xmx:aZ_YZ49La37ekBXEMLEM4dNJpnUYr_DP861LQe6fUQvWRc-rdCNSvw>
    <xmx:aZ_YZz4dXwFeYx-NzT2iN9dkSodLwOgySy-0yGziUKaGuYVmQuLGDXSv>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 17 Mar 2025 18:17:12 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc: Zejun Zhao <jelly.zhao.42@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH] contrib/vscode: respect configurable options of
 IntelliSense
In-Reply-To: <fdd8e2c6-9adc-4e53-d65c-ba75da0758f9@gmx.de> (Johannes
	Schindelin's message of "Sun, 16 Mar 2025 03:37:45 +0100 (CET)")
References: <20250204125721.11357-1-jelly.zhao.42@gmail.com>
	<fdd8e2c6-9adc-4e53-d65c-ba75da0758f9@gmx.de>
Date: Mon, 17 Mar 2025 15:17:11 -0700
Message-ID: <xmqqy0x3715k.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi Zejun,
>
> On Tue, 4 Feb 2025, Zejun Zhao wrote:
>
>> The initialization script of VSCode development environment uses removed configurable options of IntelliSense, e.g. C_Cpp.intelliSenseEngineFallback and therefore triggers some warnings.
>>
>> Fix this by strictly respecting the latest configuration manual of VSCode IntelliSense.

Overly long lines.  Please wrap lines in your proposed log message
at around 70 cols or so.

It explains why removing "fallback" is the right thing to do, but
it also wants to explain why we favor "default" over "Default" (and
if there is no good reason, that change should be reverted).

>> Signed-off-by: Zejun Zhao <jelly.zhao.42@gmail.com>
>> ---

Other than that, thanks for writing, and thanks for reviewing.

>>  contrib/vscode/init.sh | 7 +++----
>>  1 file changed, 3 insertions(+), 4 deletions(-)
>>
>> diff --git a/contrib/vscode/init.sh b/contrib/vscode/init.sh
>> index f2d61bb0e6..17f5b6161e 100755
>> --- a/contrib/vscode/init.sh
>> +++ b/contrib/vscode/init.sh
>> @@ -15,8 +15,7 @@ die "Could not create .vscode/"
>>
>>  cat >.vscode/settings.json.new <<\EOF ||
>>  {
>> -    "C_Cpp.intelliSenseEngine": "Default",
>> -    "C_Cpp.intelliSenseEngineFallback": "Disabled",
>> +    "C_Cpp.intelliSenseEngine": "default",
>
> This looks good to me!
>
> Thank you,
> Johannes

>
>>      "[git-commit]": {
>>          "editor.wordWrap": "wordWrapColumn",
>>          "editor.wordWrapColumn": 72
>> @@ -203,8 +202,8 @@ cat >.vscode/settings.json.new <<\EOF ||
>>          "\\Wchar *\\*\\W*utfs\\W",
>>          "cURL's",
>>          "nedmalloc'ed",
>> -        "ntifs\\.h",
>> -    ],
>> +        "ntifs\\.h"
>> +    ]
>>  }
>>  EOF
>>  die "Could not write settings.json"
>>
>> base-commit: f93ff170b93a1782659637824b25923245ac9dd1
>> --
>> 2.43.0
>>
>>
>>
