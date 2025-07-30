Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 804122110E
	for <git@vger.kernel.org>; Wed, 30 Jul 2025 15:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753888151; cv=none; b=U92Kp1+Wh39F27CR5xG5RCQ3fqP0/eyMIS6YgX5RrX//f8hKieMFBnPc7YJKHi4kKVBgbRdSf12bT+i0yCJPdNeNK91j09HZOkk//RkVGhTTPZaikXRiEr4vihZxVq0wauSplaWIkI0/rzfyxWjA8yKcYkYdwZwDvdVxXf7baLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753888151; c=relaxed/simple;
	bh=UoNVad8KCs42egu3q2B2B9T/a3qeGXKk1eRIwUppvRI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gU6fcQMpxJoIaZWzSe2BamTBAZUVAsX8HnR5bqMiO7rQWXvCtAhiYf3NmSsFzeKG5c2SeroMdx1nm86eSEolsbPDoo0LkHzCenoUHTSPwUnRl6Nd5yE7K8hxG17TIGSrhaLjb/fBW5pahEcWk/v4cSIpsZ6qdZ83eg0TQx+CmiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=PPbowePd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=V5W2vlY0; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="PPbowePd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="V5W2vlY0"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 87F2714001E2;
	Wed, 30 Jul 2025 11:09:08 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Wed, 30 Jul 2025 11:09:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1753888148;
	 x=1753974548; bh=aBcZq3gBlkJ2ijO9BByb+UDrPNCoAwyinzOYp3mLdKg=; b=
	PPbowePdyJ3mNWlC+O73SXb/OR3tVc2KcSgGSTw0GOhaN1HZETfypa20YWYY/LT/
	OY/tx2zNB810vNzDUQqz7lOXdW0gwISMrqzGQBOL2xGF7TMpSQN/BupCH0pj6CNN
	I8NHw836amu5JIxOsZfGxBRawV3YRfdpDONe66AkGQoRKUJ1yNzs/JPiw0UqZX4N
	kYmXPLaZqlKPpNCUjsTYUncIXaZDzLspWeS541jRdEpz0TWDqKug7W2ouDVIn7iZ
	6s4XB/U7HGxVASAkqHTythGPrTTAXyc5cGk++qe52P5HQTR57SGyUdsTaa+7b8er
	9f9SSAKriyGHAIX108boYA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1753888148; x=
	1753974548; bh=aBcZq3gBlkJ2ijO9BByb+UDrPNCoAwyinzOYp3mLdKg=; b=V
	5W2vlY0J1ij9aD+TTjgDSiSjyWqXJE3stVADofsgZByzQmouv1g0Ej332X+6U73E
	rHbGDogP8urrGjgWNXr4VbuiBYBkMP28IpSnwC3zSIQOMugZmANjop+n1Q5+YByW
	X1bI0H24jmwWy5PS0QeEyWOJfJiKmrI58MLEqlw7Wx6E0O+UCcLZNptwul/NZJ2N
	TeEmprKJStK6gw5GSzlleqWcuQXYvM4AlNwwbii0uE6rL5972RlkZbzKCmB2DGAN
	JDg5YD1naEI74512KJppbzY6FILSb0W1MOpSP3pbL9Cw5IbGL52KWkoHV+x/ucwt
	VXCsXgyelNgJOEYA0XPcA==
X-ME-Sender: <xms:kzWKaJplhtH-v3_R0DUAE1ioGk8dyljJWrdNpFwRdBc3VHIE9lryyg>
    <xme:kzWKaEH5PHSGvnhl5WmEaYk3Wb5qEHpmErMdt40Wavuw1ov2bQqriCE5xfcQJqLNO
    8N-NVK_u0oBQMENqw>
X-ME-Received: <xmr:kzWKaGr2v088GzmwkxwUYEjhcGPt66h9MHJzCCUFyOsD7nZtXktHbjVX3MlJcrH9RiWs_cYdnV5fKmbpVh83I2b7GVUSbQbog2p0o-I>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdelkedvgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtgfesthekredttderjeenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnheptdffvdetgedvtdekteefveeuveelgfekfeehiefgheevhedvkeehleevveef
    tdehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfh
    grshhtmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgr
    ihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopedukedvfedtvddvvdefjeelseduieefrdgtohhmpdhrtghpthhtoheptghh
    vghnjhhirghnhhhusehkhihlihhnohhsrdgtnhdprhgtphhtthhopehgihhtshhtvghrse
    hpohgsohigrdgtohhm
X-ME-Proxy: <xmx:kzWKaFb2TOilGc5YcUQnaq3gwvU74Fe-4DAnexG0nYYhz_NTd1uemw>
    <xmx:kzWKaHVFjki214rwx9UUkV09ccb_TH3qp-Gpv85bg85n91LOrorElw>
    <xmx:kzWKaG8n30KMxLm3cjxzJZanvR1Vnnu0mr4kDYADU3XYbKR_QWMg0Q>
    <xmx:kzWKaI-Ik5H7CrLDmclkPJ4bihC8cU4nWGCv5EhxmscV3sMucMBlpg>
    <xmx:lDWKaE1bFjFGE3-b6zx-HXH2UCSdh2gDfL76R_ArOHa28I8CUzPc2YUZ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 30 Jul 2025 11:09:07 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
Cc: "Josh Soref" <gitgitgadget@gmail.com>,  git@vger.kernel.org,
  =?utf-8?B?6ZmI5bu66JmO?=
 <18230222379@163.com>,  =?utf-8?B?6ZmI5bu66JmO?= <chenjianhu@kylinos.cn>
Subject: Re: [PATCH] modify the =?utf-8?Q?=E2=80=9Cfoo=22?= file path to
 "$PWD/bad-clone/sub/foo".
In-Reply-To: <096f8beb-8156-49da-b905-3615bb6116c8@app.fastmail.com>
	(Kristoffer Haugsbakk's message of "Wed, 30 Jul 2025 09:38:33 +0200")
References: <pull.2022.git.git.1753860300588.gitgitgadget@gmail.com>
	<096f8beb-8156-49da-b905-3615bb6116c8@app.fastmail.com>
Date: Wed, 30 Jul 2025 08:09:05 -0700
Message-ID: <xmqqfredn2b2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

"Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com> writes:

> On Wed, Jul 30, 2025, at 09:25, On Wed, Jul 30, 2025, at 09:25, 陈建虎 via GitGitGadget wrote:
>> From: =?UTF-8?q?=E9=99=88=E5=BB=BA=E8=99=8E?= <chenjianhu@kylinos.cn>
>> ...
>> Signed-off-by: chenjianhu <chenjianhu@kylinos.cn>
>
> The author name and signoff name should match.  Either “陈建虎” or the
> (I’m guessing) romanization “chenjianhu” for both.

Yup, either is fine but it would be nicer to non-east-asian friends
to use the Anglicized form.

The title is what needs more polish than the name though.  
