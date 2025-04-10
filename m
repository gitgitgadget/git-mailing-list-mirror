Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FF571EEA2D
	for <git@vger.kernel.org>; Thu, 10 Apr 2025 19:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744312022; cv=none; b=uiyvcdpxaHYHxF1ot8Hl1ZgcUtrjVNrCU6o+Lvzz13tQ2bylL7EupLpy/1ELh+V8rciccFTeyr6WZt3cfg1sC4/Ptyl81yCfY/nVpGLzb8U3OUGI5TOuNLFhmkQldul5s3UC5N2WHwFXwEoWKynCsrNjNiUSF5Wm1UWfpWuxzdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744312022; c=relaxed/simple;
	bh=z31777MkaKA53t6Pob1LE+VUV4Zvfwo8Qn14iQMdehM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Am4c2W39HAsNP/8iywdbARDG/Jk29hzhJPWJlygsD3gUABjGoPUGS7vI2kstjYOfm5TqrO1BSu6oD9hVu64Iypd+1/3DZ2iaeJacO5G+7iiCOwYyPZ7cUvD4J89dBO/GZnW9HwajqDdtGrPieevOzu4EkWH4CPj18+78oIfvczw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=omGuBo4o; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cy7PCZBi; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="omGuBo4o";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cy7PCZBi"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id DFAF9114018C;
	Thu, 10 Apr 2025 15:06:58 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Thu, 10 Apr 2025 15:06:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1744312018; x=1744398418; bh=84VICVyTEn
	kJgnISLACA7h0sFrlJ7BFnp+7HdVTT7WQ=; b=omGuBo4oUOEV6RO1NEx03HLmrW
	+Qkr1KNdMItdZfpPm2q349IkukFMjHN4IfxtBEnt5/ktH+aRsNufkSOEp8iqQ5VT
	9GLItzL4OUydTVw12nWEZNrzVR06Da49dghHA9MiLaa2DBw7xdaseitpltmbYuCJ
	0DLigRirbC30JjLLOKocTU+fo4lQ7Hp8vVVGQ3vcNl9vGxox6xiJGcFfHiqMEOvZ
	MqG/9sIN2795FlTSiz+OTIPic5cPH2YrLNN+bVgJuOxOZbQscDxiZH94E2eYrs0w
	+/ZaR4xG1wtm/WhJfe3ECNROX+1aCLN7PvZYjKHDq2GJ5diZ2ckLf3jGbNYA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1744312018; x=1744398418; bh=84VICVyTEnkJgnISLACA7h0sFrlJ7BFnp+7
	HdVTT7WQ=; b=cy7PCZBigfg9/Z820B0UVVtov7HXUIGDlOaTH9xVcglucg/J8fZ
	PAcUpNtNt7r75lGxX2idpJP14Eu6EDkDWNEntNwjNtPDzc7fPMXytbaxMrPXbgI+
	mkWH3sGGJ0sGgpdgDAW23e9pNYZF1r297485FRN2FEa8Et/QQify7K/C7St73jZQ
	e4UHxhu/pLZV4lecaxgvPsQ3bk5BdIDvlbbuK7hvjlsZ0BXJ4jCojOwcTh2mFsbP
	U1jc+91+jp6Go5fba2Y8b/XYMtM3MujORkq/vA0XFW70JxijuQnQNdYZqSnlu2RV
	u7VT/+Lkim1e/vX5jK+MGiT/wO17flI5WAA==
X-ME-Sender: <xms:0hb4ZxTQQw2KUCeZkNV8TzlVS1D2qf313D5S4hFh5ScHFFD9yYvJDA>
    <xme:0hb4Z6ysNwXG4lTgdcJNv2afVAOk_DM_o-JrBVFY3V3StEaE7j22ig7GV6TfxkIQk
    AqTWK8sacPgsp3rrg>
X-ME-Received: <xmr:0hb4Z21lx4sx50-yQO1gTtqk7smfZJK3laXRT9AbN2bBRoJtJzYBG5Ku7umk_ciujqbSBtc_xAp_E1GhqnciD5rrFAbdD8nPsQFf>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvtdeljedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhhihhllhhiph
    drfihoohguuddvfeesghhmrghilhdrtghomhdprhgtphhtthhopehkrghrthhhihhkrddu
    keeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlh
    drohhrghdprhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtphht
    thhopehtohhonhesihhothgtlhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpoh
    gsohigrdgtohhm
X-ME-Proxy: <xmx:0hb4Z5CJZfReq2uio0vh6xjO3EHks-fc3GYexaH6zS16PnLgB5Tv6w>
    <xmx:0hb4Z6i21jVy01Wccn5y0bmV5s0WbVZiEuWL8jKeRwV4zhxmljRdhA>
    <xmx:0hb4Z9pRTWi4LTtRQkRTCOTQF-8ftjbE7WsCX8lDT9KE_pRD_GF4qg>
    <xmx:0hb4Z1hHC9QHXA5VGHrNp3KJ_9329cgB-5FIqjCr3fj-irrWOxgWDg>
    <xmx:0hb4ZzEAGoB87EyI-k7wgu8BiEPZGO-UmX4a-Om7WDnwkTErjpI-_d_r>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 10 Apr 2025 15:06:58 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Karthik Nayak <karthik.188@gmail.com>,  git@vger.kernel.org,
  jltobler@gmail.com,  toon@iotcl.com
Subject: Re: [PATCH v2 3/4] meson: add support for 'hdr-check'
In-Reply-To: <dc0d6acb-bcf1-4a7e-bfc8-7c2e7793c72b@gmail.com> (Phillip Wood's
	message of "Thu, 10 Apr 2025 15:50:39 +0100")
References: <20250410-505-wire-up-sparse-via-meson-v2-0-acb45cc8a2e5@gmail.com>
	<20250410-505-wire-up-sparse-via-meson-v2-3-acb45cc8a2e5@gmail.com>
	<dc0d6acb-bcf1-4a7e-bfc8-7c2e7793c72b@gmail.com>
Date: Thu, 10 Apr 2025 12:06:57 -0700
Message-ID: <xmqqplhjomy6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

> Hi Karthik
>
> On 10/04/2025 12:30, Karthik Nayak wrote:
>> The Makefile supports a target called 'hdr-check', which checks if
>> individual header files can be independently compiled. Let's port this
>> functionality to meson, our new build system too. The implementation
>> resembles that of the Makefile and provides the same check.
>
> Thanks for adding this, I've left a few comments below
>
>> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
>> ---
>>   meson.build | 107 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 107 insertions(+)
>> diff --git a/meson.build b/meson.build
>> index 790d178007..6fce1aa618 100644
>> --- a/meson.build
>> +++ b/meson.build
>> @@ -655,6 +655,12 @@ if git.found()
>>     endforeach
>>   endif
>>   +headers_generated = [
>
> To me "generated_headers" would be a more natural name and would match
> the style of "coccinelle_headers" from patch 1 as well as the
> equivalent in the Makefile.

To me too.

>> ...
>> +  'xdiff/xtypes.h',
>> +  'xdiff/xutils.h',
>> +]
>
> Having to manually maintain this list is a bit of a shame as every
> time a new file is added to compat we need to add it to meson.build
> twice. The Makefile avoids this by filtering the list of headers used
> when building git based on their path - can we do the same here?

Yup.  It cuts both ways, but generally I would prefer that.  Your
creating a new file, and saying "git add" on it, should be a sign
enough that you intend to make it a part of the project, and the
file having a name that follows the project convention (e.g., "C
header files are in certain directories and ends with .h") should be
a sign enough that you want it to be part of the build.  Forcing
people to list them explicitly is a pain.

Yes, the approach to "glob" the list of files used would not help
you catch mistakes like forgetting to "git add" new files.  You test
locally and you commit (without the new file), and you'll be
notified by whoever cloned from you about a "missing file".  But
forcing to list the files in Makefile or meson.build would not help
you catch that kind of mistake.  While it may give you one more
chance to remind yourself that you need to "git add" by ignoring a
new file until you add it to meson.build, if you add it to the file
but not to the commit, the build procedure would not complain.

So, yes, I would pretty much agree with you and prefer to see this
kind of list go, if possible.

Thanks.
