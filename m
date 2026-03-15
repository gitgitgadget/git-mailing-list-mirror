Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EC41334C1D
	for <git@vger.kernel.org>; Sun, 15 Mar 2026 16:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773591084; cv=none; b=hN8p/AhP3DGDL6Pcs6xT+VLQ+JKmeBfxl3rp6+1+xj6Q2BqPnx/+TQqfy/bCqIKO9izmt/T6xyc/oXHy7UKyOLyfcY58QH9+JUBSHcpHbFsQXxzRJTDkD6PTLiQj0jBlo2HH7vHTbBQuBMATK8JI8ep6xgU2bZx6rHTZvXoDzuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773591084; c=relaxed/simple;
	bh=kUT2xLCzIhEgEaVP6mRMdNM2ACY2CDQXL5Tv5MODtRI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fCD5axv6qjObsEaQh/1bpfnTrxKWoj1LJ/JRvZm4wm6QEZJQjwPemwOY/bJ3BtB5gNsh1FeMdnLx1G4Gy0S7jmxWArKItIxfVIzcHUDd50Ro32ca4x5/DcaOlA/fTcbk9tE0VvbM66C3ZHmOLfbYogVG7GgwqZXNiqC+lR4QMgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=TNf8Dv8T; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ho8+Q/vB; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="TNf8Dv8T";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ho8+Q/vB"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 6CB14EC0120;
	Sun, 15 Mar 2026 12:11:22 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Sun, 15 Mar 2026 12:11:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1773591082; x=1773677482; bh=YQn5MiLkFT
	qcIn7Ds41Fhzcq9FYikn+fv4O/6QvNX30=; b=TNf8Dv8TkWWxog0lSU8kd0q254
	H63fsejsFSrZ3C89jEoTNx5O2CiRV+drK8Z03KLdd1f10tX1iSdIWwBQEMzpfueO
	kvAOQE2TCrHnumgPX+WnadQ3CIvtj5GUQ/XiTcrj55Mi5eTA4+FVAVNV9ZqGDBnv
	eaOiEJ8D6a7x0E3f2KN1DZ/0Cyw02SWafAup6bq1bum8jblLsH+6d024MUc57KkD
	iRRPSkNW42fv7pkCIWNg7gIIzOeIM2WrNaEPaS27lGB7GsIzU4LHSzZ1XIozmP3k
	PHHKrFwyxOmR2HlZIOaLw9yVrcq2JPknRFRrjb+kVNGgIT0ipfgtbqm7Cinw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773591082; x=1773677482; bh=YQn5MiLkFTqcIn7Ds41Fhzcq9FYikn+fv4O
	/6QvNX30=; b=ho8+Q/vBEdTsz1WLlhQHmQEJEP6kZNCrn68JEyiSwZ7f6UEWpwO
	4l4nXVMtjwH2VZhz7Gby61zD14q1B7H9e2x7bmvm7Efmr20uTi2m1/KIaVdiEOW+
	RJ1wm2KcJG8gT67ufI+/TILrr7xBSxtysZr1J9fLUQPOCEFMppUGuq5GnNjueaGK
	MF2M8KIkdUl8iggO8MDcI+Z688ehU73YyiIqavcDvQcIFqi/R/QklPeOT9i3tPNk
	9x1zA1oJvWMK4rtXeNzuMTU/Uo043MSinai96/FTDuIWqX6xVz7/JXiBWGrx6khX
	wFrLRmYSqsmW0A3chR7vrisUYpmlO377YhA==
X-ME-Sender: <xms:Kdq2aX4ud2XKAIYjZwG26LSolQ8k3kbu-jO4_0EFpFvxlV61flsjGQ>
    <xme:Kdq2aUfPPb6TteCLlbaoK0neugoiSOX874sIseQo9kMF2JznII4nzEJwtPBCLbM4k
    eiOyhtO2-PmRRjSWZhQqQagwGnJK6Pi9PA7zUJ1R4iJL-P6Gvca>
X-ME-Received: <xmr:Kdq2aeEVqkrOJBL3xJXtTxh1nzIHWknZZc9Yu_cpf0onKdIr92t0dqB4Ul4YaMDrL4QIs8drIO7SwOD_N5Zuzz_vu4Ju99Bq_w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvleehleefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepudeipdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehjiehtsehkuggsghdrohhrghdprhgtphhtthhope
    ifohhrlhguhhgvlhhlohdrnhgvthesghhmrghilhdrtghomhdprhgtphhtthhopegrshhh
    sehkrghmsggrnhgrrhhirgdrohhrghdprhgtphhtthhopehmihhkvghlrdhfohhrtggrug
    grsehgmhgrihhlrdgtohhmpdhrtghpthhtoheprhgrlhhfrdhthhhivghlohifsehgmhgr
    ihhlrdgtohhmpdhrtghpthhtohepjhhnrdgrvhhilhgrsehfrhgvvgdrfhhrpdhrtghpth
    htohepsggrghgrshguohhtmhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepughjmhdt
    tdhnsehmrghilhdrrhhupdhrtghpthhtohepphgvthgvrhesshhofhhtfiholhhvvghsrd
    hpphdrshgv
X-ME-Proxy: <xmx:Kdq2aU7WMpffsNRsn_2Mcwjt4iveCyJZOXoFpOtyPBd00js6e3lpEA>
    <xmx:Kdq2aRvbaFXRNZdMY_vnCVMRBYwrl02v4pcMLiELvrrB47TsnoT7jA>
    <xmx:Kdq2aY_K6diQIo5mPePQmuGfZQZv2u-_u-AkvjnXuMvinn5ymqgKXA>
    <xmx:Kdq2abnUV5uUIDkPqrwYPXrmSn2vNxkpeBqshbctHHJzEN1l28xeag>
    <xmx:Ktq2aWnJuvMAaRUupJlVnOwKwdW7q6Nl2-uuPhJmldKbr4BgB8NN0LnW>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 15 Mar 2026 12:11:20 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Johannes Sixt <j6t@kdbg.org>
Cc: Jiang Xin <worldhello.net@gmail.com>,  Alexander Shopov
 <ash@kambanaria.org>,  Mikel Forcada <mikel.forcada@gmail.com>,  Ralf
 Thielow <ralf.thielow@gmail.com>,  =?utf-8?Q?Jean-No=C3=ABl?= Avila
 <jn.avila@free.fr>,
  Bagas Sanjaya <bagasdotme@gmail.com>,  Dimitriy Ryazantcev
 <DJm00n@mail.ru>,  Peter Krefting <peter@softwolves.pp.se>,  Emir SARI
 <bitigchi@me.com>,  Arkadii Yakovets <ark@cho.red>,  =?utf-8?B?VsWpIFRp?=
 =?utf-8?B?4bq/biBIxrBuZw==?=
 <newcomerminecraft@gmail.com>,  Teng Long <dyroneteng@gmail.com>,  Yi-Jyun
 Pan <pan93412@gmail.com>,  Git List <git@vger.kernel.org>
Subject: Re: [PATCH v3 1/5] l10n: add .gitattributes to simplify location
 filtering
In-Reply-To: <87220e93-8159-4a92-9c3f-b3f9fa34ba4e@kdbg.org> (Johannes Sixt's
	message of "Sun, 15 Mar 2026 12:13:08 +0100")
References: <CANYiYbFM9+4xGmeBRNCC6VyW9EzjEFxEWHDNnOVhJNM73Ga_FA@mail.gmail.com>
	<cover.1773497547.git.worldhello.net@gmail.com>
	<0c00f09918d94995b4f990679d598adcab0d6f2d.1773497547.git.worldhello.net@gmail.com>
	<87220e93-8159-4a92-9c3f-b3f9fa34ba4e@kdbg.org>
Date: Sun, 15 Mar 2026 09:11:19 -0700
Message-ID: <xmqqzf49rs2g.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Johannes Sixt <j6t@kdbg.org> writes:

>> +# Languages that strip both filenames and line numbers
>> +bg.po	filter=gettext-no-file-no-location
>> +de.po	filter=gettext-no-file-no-location
>> +#es.po	filter=gettext-no-file-no-location
>> +fr.po	filter=gettext-no-file-no-location
>> +#ga.po	filter=gettext-no-file-no-location
>> +#ru.po	filter=gettext-no-file-no-location
>> +sv.po	filter=gettext-no-file-no-location
>> +tr.po	filter=gettext-no-file-no-location
>> +uk.po	filter=gettext-no-file-no-location
>> +vi.po	filter=gettext-no-file-no-location
>> +
>> +# Languages that preserve filenames but strip line numbers
>> +#ca.po	filter=gettext-no-location
>> +id.po	filter=gettext-no-location
>> +zh_CN.po	filter=gettext-no-location
>> +zh_TW.po	filter=gettext-no-location
>
> How settled is the use of these two different filters (and names) in the
> community of translators? I am asking because I'm about to align the
> translation workflow in the Gitk repository with that in the Git
> repository. I need to know which of the two variants of filter names I
> should ask translators to use.

I too am curious.

I would imagine that the translation target langugae has nothing to
do with the choice, and it would be mere personal preference---in
which case it would be better if people can converge on a single
convention fast and stick to it.  After all, even if the current
French translators happen to prefer no-file no-location, for
example, existing translators would graduate the project and new
ones would come in, and their preference would change over time.

At least comments like "Languages that strip" is misleading, if this
is just "personal preferences of l10n groups of various languages".

Thanks.
