Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6453912B93
	for <git@vger.kernel.org>; Thu, 16 Jan 2025 02:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736995589; cv=none; b=IS3gbpJjReV9mW2qk3vs1N07ZOtyI2JWcyqMBXXrOnfUwNH7wKKweH+1DBod7XPtx6d0SHSyHgULPu+C+XvbbAZWZCOxe987gzXc47hfFPZl7RZ8zwDLJ8hpNG4FHXBRESMTT+d2ETrLLndZMDnAnPfjVF6W8UJ3TVAa8wg3Bxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736995589; c=relaxed/simple;
	bh=NKzVvKI5UJzbcU+Fpz5FP75A+vJwB9GQpP8lrLk2iCA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hhoRDRokRJvh0KSjDsvTMxbUSE2MuC6sRWjUTjDwCvELqvHJn5sctz61BqUVApdqd8GUeQ1PwKvCQ/7MKepCE6hueLrMw4HNrM2o/+O9rcrxQQ6XUxmNQ+SBeE/jitpn3WbfFdENBcoh5qeNuRzq8L5jeGusVrVuZZsYn45qwDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=v7kg7O1C; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eljdpNlS; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="v7kg7O1C";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eljdpNlS"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 5D172138028A;
	Wed, 15 Jan 2025 21:46:25 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Wed, 15 Jan 2025 21:46:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1736995585; x=1737081985; bh=9g/UClK95u
	LYD4yqfQSnskFl+EBwjPs2TZR8YL4UxCs=; b=v7kg7O1CRXwAiln163Dco+tSPn
	8uBytdyXCCjf6y9kWN64Ar/NRnWx+vOWKgiO6M6KBlqZi2juxK3NhxRd93ewnK1g
	ayNT5ePosE4iLuZ4JqfLlMJZkZzbuAWobqlNezQJa+CyW4AK1f5dZrRXNyRjz1I+
	iqKD6clGmuJ32gsL3xkg3IAJ0M/1FSyw922TXHQYMKczLVQ2wAUs3MfTvoK/tqFr
	ZB5a78POTTcp87XyPIsXULgbuoCgvOGPw99BY9mnTFWQiKcnn/WEsaJEhSvoSuCI
	2ZtHZc+nY8yQRZGfXY0+51V90peyuTDUlcJcVj3+U4ynMi68NVWFVuk8+73w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1736995585; x=1737081985; bh=9g/UClK95uLYD4yqfQSnskFl+EBwjPs2TZR
	8YL4UxCs=; b=eljdpNlSpLZXpb8gimdwINcPjsCKMRsFaSoBZX7u3d68pbLuWFZ
	I+cX9c2j0M0me8L4PbVA6Mm/EzKs5Skr/nNabbAPdA89wcA66Dlc52u/3D1bYzh0
	aHu9n+HAv11n9jAO+yMfyOK4RFaOA8OA0NdHYEW/9LRMe5lR5E8nbJ8mHMhYjAG4
	uW9vfJF94V2/FzgBQSrSYReT1+q36v6IBDuhGd/VAJmyInTSi2dxbkugBr1O3zbP
	HMI6KBZxj3MUdzA9CEQ6/+97mHcwE17RGGevnZi/pzUCKNqjty6p6jHPbxahfSmT
	UMkEyJzvfLG+/THe5n6+xYwiloNR1pCawbw==
X-ME-Sender: <xms:AHOIZ0U74v2S3PABBNEt_7YxL4-CwT3o9wm_pUTV_d9HUaDGzZV6QA>
    <xme:AHOIZ4lWJRy-9xCUt9rN7z8PieSjMv2X4fr_LKrf00DwnwW6B-MEx9LFUoJ08iHs2
    fxllEFqDcWYWFzJbw>
X-ME-Received: <xmr:AHOIZ4ZGURM-ChbkC2FO6BT0aA40MJ1c0AoNruo18AJ5AjGoWe3hVuBmBtRrDC7bDuknH5thvRNVHPnBfkqxwN48QCXbTpZEJJKY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeitddggeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepffeiteeujeevfeehuddvjeduffeijeegfefh
    tddvkeefjeejhedtgeefgfeijedtnecuffhomhgrihhnpehgihhthhhusgdrtghomhenuc
    evlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshht
    vghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeduvddpmhhouggvpehsmhhtph
    houhhtpdhrtghpthhtohepshhtvggrughmohhnsehgohhoghhlvgdrtghomhdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptggrlhhvih
    hnfigrnhesghhoohhglhgvrdgtohhmpdhrtghpthhtohepnhgrshgrmhhufhhfihhnsehg
    ohhoghhlvgdrtghomhdprhgtphhtthhopegvmhhrrghsshesghhoohhglhgvrdgtohhmpd
    hrtghpthhtohepshgrnhgurghlshestghruhhsthihthhoohhthhhprghsthgvrdhnvght
    pdhrtghpthhtohepmhhhsehglhgrnhguihhumhdrohhrghdprhgtphhtthhopehpshesph
    hkshdrihhmpdhrtghpthhtohepshhunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtgho
    mh
X-ME-Proxy: <xmx:AHOIZzXXYruJFznxIMQXqc2iUB9TflQgwLIf9kVrc482kC0r24fguA>
    <xmx:AHOIZ-kDjy157Gf908Ecw9hiawYXKwSkKkeW14jsNPFOpukgWIOF2Q>
    <xmx:AHOIZ4ecGg3sHHwaBl_OBGNbqFCUnbi_J9kHhWLAotcAUlmOB-4I7Q>
    <xmx:AHOIZwGBB07ZLvNINB2431CqhuQtSxAOZTZAzaly1UCTo0DH2EBPGQ>
    <xmx:AXOIZ5_DCVr8r65KGy4Ih17HABsX0FaToI4-LHWLqL3P5p4KBnEStbJg>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 Jan 2025 21:46:24 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Josh Steadmon <steadmon@google.com>
Cc: git@vger.kernel.org,  calvinwan@google.com,  nasamuffin@google.com,
  emrass@google.com,  sandals@crustytoothpaste.net,  mh@glandium.org,
  ps@pks.im,  sunshine@sunshineco.com,  phillip.wood123@gmail.com,
  allred.sean@gmail.com
Subject: Re: [PATCH v6 1/5] common-main: split init and exit code into new
 files
In-Reply-To: <xmqqr053wvip.fsf@gitster.g> (Junio C. Hamano's message of "Wed,
	15 Jan 2025 14:40:46 -0800")
References: <cover.1723054623.git.steadmon@google.com>
	<cover.1736971328.git.steadmon@google.com>
	<ff6cd62397ec2755d15e9d76f9af8a84b54a36c1.1736971328.git.steadmon@google.com>
	<xmqqr053wvip.fsf@gitster.g>
Date: Wed, 15 Jan 2025 18:46:23 -0800
Message-ID: <xmqq34hjv5kw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> Josh Steadmon <steadmon@google.com> writes:
>
>> This split has previously been proposed ([1], [2]) to support fuzz tests
>> and unit tests by avoiding conflicting definitions for main(). However,
>> both of those issues were resolved by other methods of avoiding symbol
>> conflicts. Now we are trying to make libgit.a more self-contained, so
>> hopefully we can revisit this approach.
>
> Yay!
>
>> Additionally, move the initialization code out of main() into a new
>> init_git() function in its own file. Include this in libgit.a as well,
>> so that external users can share our setup code without calling our
>> main().
>
> Sounds good.
>
>> diff --git a/common-main.c b/common-main.c
>> index 8e68ac9e42..6b7ab077b0 100644
>> --- a/common-main.c
>> +++ b/common-main.c
>> @@ -1,92 +1,13 @@
>> ...
>> +#include "common-init.h"
>>  
>>  int main(int argc, const char **argv)
>>  {
>>  	int result;
>>  
>> +	init_git(argv);
>>  	result = cmd_main(argc, argv);
>>  
>>  	/* Not exit(3), but a wrapper calling our common_exit() */
>>  	exit(result);
>>  }
>
> Nice.  Very nice.  I wasn't too carefully validating what we lost
> here is identical to what we added to init_git(), but hopefully
> others would spot and stop us if that is not the case.
>
> Thanks.

Unfortunately, build based on meson does not seem to like the
init_git() thing.  Perhaps we need to add some missing files to
relevant lists in meson.build file or something silly like that?

https://github.com/git/git/actions/runs/12800227601/job/35687658673#step:8:961


