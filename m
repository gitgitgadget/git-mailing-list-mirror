Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95BAD9460
	for <git@vger.kernel.org>; Tue, 15 Jul 2025 23:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752622255; cv=none; b=sh8wmlM8wcgfhan886q6ipEN4l/ImGUM01gzY9ljdXLhfrJnwjVv4QFG83mFbkj8Oz3FhMl1VoMu4Cidc7LN1YqW3gvvGz5CsKxuUPTGwBl7LbYg3A6cKZ8UrQrJhoR+tj87jZVQIHl84uappWphsngBnhzLpPdnltNmQFtrlww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752622255; c=relaxed/simple;
	bh=1n9irucGwCs7b2jVdjt8SS1fEdqhiyINzZNAf+ZiWGg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Fs2QCASAJe+qpWkIFgzvGh5eiRqjikwPtqkKAzPZJuWXp5W6GMI/GiBr7xAbNdHtdkqNF4GereEwI5KxKCC98rzkYhMKNwvZmRwKKH6lS4nR00OuCQAwq48gCZZ5SIBc5U9GGZVO757AmitKrie1WGRY4V5DWbSYZiHmPLmjT40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=igMt9bGd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=I0x3T7Pa; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="igMt9bGd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="I0x3T7Pa"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 3CA907A0012;
	Tue, 15 Jul 2025 19:30:51 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Tue, 15 Jul 2025 19:30:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1752622251;
	 x=1752708651; bh=vgwav2tVQ1m2Ul/vZHiT4IEw+h7kqAXao63QQfCJbhQ=; b=
	igMt9bGdN2A1LdtQSwjMCwYyM7HXEubKWfQlUNTuYnLnvRBCm9KMlpHB0jK7dVhh
	Q0W8vEQdFgg0lOG+ePI/QNb82T1/e3XqL3NEctiwfCouzEpIoEC1JQm2vbyCRSH6
	hLJb/71UPORo3ZdPMzsji6tNgUiJuRwvws2EkH/mkpSmyiCkYH8tqEzkaiw99p9a
	zW35cds3Tz5dhEFM6XWYAPigc6eqY8XshGPcyz2IDg8NTAeZQYkOshYjuZbC+W4B
	eCfQK0tFQSdusjTEZ/b5giF8RudaYOhxkbTHPl7PpeH9yCu+Spg5zufCl+/0RfE4
	mf5WMZ31yms9BLEHMp/zKw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1752622251; x=
	1752708651; bh=vgwav2tVQ1m2Ul/vZHiT4IEw+h7kqAXao63QQfCJbhQ=; b=I
	0x3T7Paa1x6hwKR12+8ERy3wczKfr5TU+csDHf6+gsM9dIKbUcQsZG8ow8wRPLPo
	FLGxJAcFEORpKtoTj/n5Ibb1zCxvLS4ZqRA5gfnJv4WJH1VuAs0X0/5v4IIjN3IO
	WXmB4WLO8Y6cifsKOmZ7vVj23ZaKmtk7FPf3SWcgLHF1XhCRM5kt4hC1e1dsMUmk
	RoGdTQTY8hkvyxxjO29jqwnBGyU1X016PRGrzeDvSGJzQCYPZRZe6W7Ux7B/RLw5
	yppfSZ2xEitlvlRsjK9jtQzjOSzxAZihwbI3HI41idNBT9hPHKGo+aQMMVHr0ohX
	E9ALfnX3BchTXiLev9FWQ==
X-ME-Sender: <xms:quR2aBWhLTky1ZNCsJYWihUZNwPFYDgbeLbzPVpD4urgrz9aMGNwpA>
    <xme:quR2aPJPxvebi-J9pBWBUKe3ujE5oe8Xc-8HwvIXs6QK5TSwwSjIkH_Pnm7ddtcBK
    eSEy8T3BAYzRS4zkQ>
X-ME-Received: <xmr:quR2aD3kCsmPS9O-Ro8UfpaEL14mOAFhhx9k_Sr1P7DFxR_Xkvwxy8Jl8gkdqpUx1Aono2IWC8mNX3rEnuQzhEymJvr62tVDx06_65k>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdehieduiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtgfesthekredttderjeenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhephfetvdejheduheegleehfeeivedtgeelfedvffdtvedtudffieekieeijedv
    lefhnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhnsggprhgtphhtthhopeejpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegrhi
    hurdgthhgrnhguvghkrghrsehgmhgrihhlrdgtohhmpdhrtghpthhtoheptghhrhhishht
    ihgrnhdrtghouhguvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvg
    hrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdef
    sehgmhgrihhlrdgtohhmpdhrtghpthhtohepshhhhigrmhhthhgrkhhkrghrtddtudesgh
    hmrghilhdrtghomhdprhgtphhtthhopehkrhhishhtohhffhgvrhhhrghughhssggrkhhk
    sehfrghsthhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrd
    gtohhm
X-ME-Proxy: <xmx:quR2aF7QovhbYAF4OsEOcn-brHAfxJjmCuMADNpgGSq1MCgNGi6bPA>
    <xmx:quR2aM-LfBElpC5u7sWwNu0P9fi-kSwRsv3KCeiIxlUUZ1P_S0f96w>
    <xmx:quR2aMXcUTBVNujBPv6lC_mSiELyAuAGCqMAhJMms2xCRMAETtV2eg>
    <xmx:quR2aPr4OAkJB4_4i6zJqu_7vf-eDrwhqM2FTJirP_zp-6iJpkCJSA>
    <xmx:q-R2aG0EDwpdOYNNY7G5H5hxEIW7yi4LruBBD0akacCTfrZFqqFnRouQ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 15 Jul 2025 19:30:50 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Ayush Chandekar <ayu.chandekar@gmail.com>
Cc: christian.couder@gmail.com,  git@vger.kernel.org,
  phillip.wood123@gmail.com,  shyamthakkar001@gmail.com,
  kristofferhaugsbakk@fastmail.com
Subject: Re: [GSOC PATCH 2/2] config: set comment_line_str to "#" when
 core.commentChar=auto
In-Reply-To: <CAE7as+aN+j4CteHUrr+R+CbZ=qi=mehYW2xQEG4ZcQYvXqJsaQ@mail.gmail.com>
	(Ayush Chandekar's message of "Wed, 16 Jul 2025 03:45:52 +0530")
References: <cover.1752602474.git.ayu.chandekar@gmail.com>
	<2a3c2d323bdb520a37a099b361be9ec5f2d5d46f.1752602474.git.ayu.chandekar@gmail.com>
	<xmqq1pqhgnby.fsf@gitster.g>
	<CAE7as+aN+j4CteHUrr+R+CbZ=qi=mehYW2xQEG4ZcQYvXqJsaQ@mail.gmail.com>
Date: Tue, 15 Jul 2025 16:30:48 -0700
Message-ID: <xmqqcya1f2vr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Ayush Chandekar <ayu.chandekar@gmail.com> writes:

> On Wed, Jul 16, 2025 at 2:53 AM Junio C Hamano <gitster@pobox.com> wrote:
>>
> [snip]
>>
>> This patch is exactly what Phillip suggested in
>>
>> https://lore.kernel.org/git/9e96aaab-79a2-4632-94cd-d016d4a63b30@gmail.com/
>>
>> isn't it?  Makes sense to me.
>>
>
> Yes, you're right. I should add the suggested-by trailer for this patch.

I am not sure about that, though.  A verbatim copy is stronger than
implementing what was suggested by another person.  If I were in
your position, I'll probably say something like

	The patch text was taken from Phillip Wood's message [*URL*],
	with the commit log message written by me.

	Based-on-a-patch-by: Phillip Wood <...>
	Signed-off-by: Ayush Chandekar <...>

In any case, this overlaps both textually but also intent-wise with
Phillip's "let's mark core.commentchar=auto deprecated and remove
the support at 3.0 boundary", which is planned to be rerolled to
make it a failure when the user uses core.commentchar=auto.  It
would be a while before we tag Git 3.0, so the fix in this topic
will be necessary until then.

Thanks.

