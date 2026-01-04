Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E3EC23D7DE
	for <git@vger.kernel.org>; Sun,  4 Jan 2026 06:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767508115; cv=none; b=RtABi7ZNQ9zDP5shKPe7o1KbGckF55zDtgbZtPCw8d4s8o2v/i89fnOp02Urxj0VktixCxd3AglXe9gddB+KNCD37gq16yLULPyZh4+VFNVpKMlSKLJYlCGelmM+FSyUrl5Ayx5+bf3ZBkJHQY2rQY/pl8l/R8l9NUuMkqhn/yU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767508115; c=relaxed/simple;
	bh=HlHwftn37kAKTQ0MTVhzqiusAIwTTZe32/zT6tI/iTQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JBUeBEhTReCzOoOHAgYKlKMj2HVKZf7xGP8BpK69ODkKjq+LjB5xFiV7XqPwfeQPt7H+AQhcJKJ0DFoR7zZwuLskEWyTfscGVyxHekoNm0hs8RoNBO4Vz2j9ZnswHDoXYF+Aqf1iqE+tRpKiuc6y1PwgIxlyi75AnI4TEVdEeCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=oao8GjCe; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Jz1exXdB; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="oao8GjCe";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Jz1exXdB"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 419717A00EC;
	Sun,  4 Jan 2026 01:28:31 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Sun, 04 Jan 2026 01:28:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1767508111;
	 x=1767594511; bh=aMd4PMi8DoZWkAWzAz6wx6pZh3N8GWi3vXP5cfNlvTE=; b=
	oao8GjCeABJlqkHnuxpji/Ef2xBwVvV+jbw68C9pFZ9ouKUeeAXn1casB4L/DrG0
	CBnY5OClQyTOlvr9ZEZnpVRLLBIv8K4ipLRBivE2FsVoIKlF2h4MzGMo5RGa0YQ1
	WFZB5irKHItUnc++6bSHxMR2PSIfolbhSrK26x9zNEUn4A7aDltIMYXkLvcW3820
	ayheKzTQ1MdwIq5R5Bgx7sZaOZpO2OSAXqn4muLhAW+pWAePZjCtyCWqeliN5TtU
	YORYcWm1Mz/86NYAUtET6HW+DoC6/LrIi2brspU3QPwFD4rH5adfPgY08ibvABnN
	7KmrPyjWBoOc+0soHq9Hgw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1767508111; x=
	1767594511; bh=aMd4PMi8DoZWkAWzAz6wx6pZh3N8GWi3vXP5cfNlvTE=; b=J
	z1exXdBsE/mqpm+ueGendVMfuTFVuwpHr3nC2QAw9HQUQMYihMVup0noIyP7jNgL
	BhGj9Wjkh4oWIJOYpYSYa4DWS2IWqWWIKAOwvo+MI8nYk2U3nC9qftM2/ExpBF7t
	4P9tYENpXOw7+KqEjvnYjj3KISjHfRw7X08abEcOD7Z8KtMAkz9L7E2vsf2pNrTY
	3afTF4rJDh3JPUArRpW6QrELAHJwKKUtEpxrWwLP3Mx7eGvyuDH6iGkD3Ev94FBi
	1aQOU3pMJOGwQpmMGeLlhIYOKdXNpFr6GVWg6iHWmUQALq/MmPZldndG9EyhW8UN
	9/x4za9anJsho2X6gJhIg==
X-ME-Sender: <xms:jwhaaUEjElB0T-bIWRbkaLDZQRcqQ4eRHUCjyYDdnfPnFlmDk55_9Q>
    <xme:jwhaaUNPflyTDleajnhBud1y6KwxUYKgywQjIjNnHwb6RD5yr-josZWiaIpl3shhx
    3vhBThrBu5EsZakuhmrHXDHonBtx6ejAz19cOz3CLRreTIh9TNCEA>
X-ME-Received: <xmr:jwhaaWeE1KsO-ECR0lImgKK-JJOaIUTFwDxRK-7WBfaSQ0goGFj7_yxnaawN0kIlcguwy6jPFhcnguVxlU8qy7GbWRYp7eXxl95zVxA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdelfeejtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtgfesthekredttderjeenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepgeeghfdufeekgeeuiefgjefhjedvjeevtdehgeeuudekgfeileefueetjeei
    ueelnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgih
    htghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgv
    rhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhrnhhivgguvghrsehgmhgrihhlrd
    gtohhmpdhrtghpthhtohephhgvrghthhguuhhtthhonhesghhmrghilhdrtghomhdprhgt
    phhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:jwhaaRsUBv8ub2OyrM1x96dJlxIFS9klnRoFbNhQLC0lWtFpV2aMaQ>
    <xmx:jwhaaXmOoDOVX4Oju8V3ps2yYzBNqY8zjbTX2HCq7lJgC1B6lhv_SQ>
    <xmx:jwhaaTy55YQ2hX2LAwrwS4gmQ7JJ25Hh2FRW2Sef8S_du_H0ygFjWA>
    <xmx:jwhaaZMOxRtpdUd1XAK7sQ5oHnm5GPBTBi7fKuzsyEgEggmwfAx_yA>
    <xmx:jwhaaQ-GAXzePFiM-vnQdf4rUp0pEfpoPnqoW_pi56rKX05oUEKfcJPF>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 4 Jan 2026 01:28:30 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Heath_Dutton=F0=9F=95=B4=EF=B8=8F_via_GitGitGadget?=
 <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  jrnieder@gmail.com,  Heath =?utf-8?B?RHV0dG9u?=
 =?utf-8?B?8J+VtO+4jw==?=
 <heathdutton@gmail.com>
Subject: Re: [PATCH] doc: define timestamp in pack protocol grammar
In-Reply-To: <pull.2154.git.git.1767496120852.gitgitgadget@gmail.com> (Heath
	Dutton's message of "Sun, 04 Jan 2026 03:08:40 +0000")
References: <pull.2154.git.git.1767496120852.gitgitgadget@gmail.com>
Date: Sun, 04 Jan 2026 15:28:29 +0900
Message-ID: <xmqqv7hhnb76.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

"Heath Dutton🕴️ via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: =?UTF-8?q?Heath=20Dutton=F0=9F=95=B4=EF=B8=8F?=
>  <heathdutton@gmail.com>

This name is expected to be identical to ...

> The grammar for depth-request uses 'timestamp' but never defines it,
> unlike 'depth' which is properly defined as '1*DIGIT'. Add the missing
> definition.
>
> Signed-off-by: Heath Dutton <heathdutton@gmail.com>

... what we have here.  There is something weird going on after the
name before the e-mail on the in-body From: line, though?

> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2154%2Fheathdutton%2Fhd%2Fdoc-protocol-timestamp-40000018-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2154/heathdutton/hd/doc-protocol-timestamp-40000018-v1
> Pull-Request: https://github.com/git/git/pull/2154
>
>  Documentation/gitprotocol-pack.adoc | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/gitprotocol-pack.adoc b/Documentation/gitprotocol-pack.adoc
> index 837b691c89..7ad63322c2 100644
> --- a/Documentation/gitprotocol-pack.adoc
> +++ b/Documentation/gitprotocol-pack.adoc
> @@ -273,6 +273,7 @@ out of what the server said it could do with the first 'want' line.
>    additional-want   =  PKT-LINE("want" SP obj-id)
>  
>    depth             =  1*DIGIT
> +  timestamp         =  1*DIGIT

OK.

It was added at 569e554b (upload-pack: add deepen-since to cut
shallow repos based on time, 2016-06-12) by Duy for deepen-since
which is parsed using parse_timestamp() that is a fancier name for
strtoumax(), so 1*DIGIT sounds fine.

Thanks.
