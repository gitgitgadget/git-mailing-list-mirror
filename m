Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 283966F073
	for <git@vger.kernel.org>; Wed,  4 Jun 2025 14:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749048552; cv=none; b=J7nI9RNgX+E/DUkUIedhiv8OCnq2jHeWF4WCfRi6Jfd4itaW4c1223dv8P3IFkjs5j+X6bKYicVZUPqQ8cDa5N24qoUxfGspnY+cr65w9URbqKqJ4Th/5i7oq+ZNDxcSAuprIX4ivKpC1HK/dqUq25xXASpHjiK0Q8er1w9erRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749048552; c=relaxed/simple;
	bh=ZwxuWtA3/MBbmwvmFdmRX6RtG8D2YCifgQXTN72LAdE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=l1RF1k1eu9JN4ochUSrbAeFW3ftgCd638zI1ShQl2a0oQp9WtZcdif2DxY4Vt3+E4FzRCUOJojh8na9tZa5iSluXrh+gpOfkCnavF6y6EYpiHO7nXx2VyrDkALCbYKPojXQwUFs6Uv3QTZMWO44gNY9rTxEFnTk2s0rkvXbEX7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Mr2NWON8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qYNGEsNK; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Mr2NWON8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qYNGEsNK"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 231C91140291;
	Wed,  4 Jun 2025 10:49:09 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-09.internal (MEProxy); Wed, 04 Jun 2025 10:49:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1749048549;
	 x=1749134949; bh=OHsH5JjvObH+QJL11XHnz+bPlqam79SB/E5kH7rwXxQ=; b=
	Mr2NWON83h+bB2SmD0F8nb/ykxi454EsPQO9+9pgNXueGVVfXVY9WbvqE4zB2k/l
	0OpPsqmt9/lNhQO+I+9w7CHgQhooO57JWT3K5A1d55n2AJ5DVGdlNsChrZYvhtya
	mhWiRu2bkQ6VjVqvOKxh8KocHbt68blDzoDZyuIrW1tf6jnQ+FU/efw/4K4tnhPt
	Mrr6orovyR97euY64PrI0LUoXMinUvF/uzeOIIYHTy2mvrI2XBesMjKSjcxv0mhw
	FenlotVlJekPVi+I4WZO2fmnTRtbgaSr5NVdyOQH+Co5tmIPx9EqV31mkT2QBq2d
	RH8372XAiqpCNU0h3ywqZA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1749048549; x=
	1749134949; bh=OHsH5JjvObH+QJL11XHnz+bPlqam79SB/E5kH7rwXxQ=; b=q
	YNGEsNKDFKDmA1GCMXV93jv3riZ9qmQ2yKhCBHH+FR9yRU/iWCK+X9RCL2BleVRA
	cArtRAq5J76hH4Hek6/cN5Cc4WpJCv4gy/AODAUrC3XSowkzpLGq+5TrhDtJD4Pu
	rqmzPjjM7FB1qKanfMatwe6n7MJDF+IEoPhvMVp/z8Xj5bAxH6TOKU4Tn18z3RmV
	L5RiJ92LdIFcJDBTrtzDNFAk319AijCaTyKXNqbMMiqcWEMR3EBe5rK3DBv76e3X
	UhQoYuFQcvRgdVbU3ryl7mEggnfOEiHfE/wg9TDyAwEvltrsRUhlxP891n1TBOAi
	gswaiHQ+cgw7hCaLTJiLw==
X-ME-Sender: <xms:31xAaDp76m8vKTlXPwO0HWe2mRQK2v2F_jcmddlU2UoVbg2_a0aaYg>
    <xme:31xAaNqv-n4nu6irrPbdTosocTnipc4kjG9Ww-_L2zoYbm5plbhjTSZ2A6CkG8ez1
    JjUT0d7UYQ28XX46Q>
X-ME-Received: <xmr:31xAaAMUE2uJoB3LIrTfzXcdOLmXBw8af-wpzM7u3GtsF0s8Vn5Mw33yDw9bcnEAHchO7gtbW9tHg8AfyS3oApI4T1hM3Cc2rbNP>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugddvvdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgfgsehtkeertddtreej
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpedtffdvteegvddtkeetfeevueevlefgkeef
    heeigfehveehvdekheelveevfedtheenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopeehtddvtddvgeeffe
    dttdehieesshhmrghilhdrnhhjuhdrvgguuhdrtghnpdhrtghpthhtohepghhithhgihht
    ghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepshhu
    nhhshhhinhgvsehsuhhnshhhihhnvggtohdrtghomhdprhgtphhtthhopehgihhtshhtvg
    hrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:31xAaG6jwQwWrgtmRZPAI55TTileHsS6vRtEvODqvXjmySyAoxdlhw>
    <xmx:31xAaC4u87AflVqCFTWe5pN2wqW3jrNyEK9395xSGl_xokWgmu3Bsw>
    <xmx:31xAaOiZVsq9LnvJ2oPebZhKTqXpB7PJxOMyNocVwhVHsN9HnYgZJA>
    <xmx:31xAaE6Jo3klcf2_w3kCE5p53hmRsZBTWUAM5kfEULGiRoWDxo2QLA>
    <xmx:5VxAaMbdj1rie75BFHKSUX2aJjKopfFQuyZcdFrGytotwZJlLAxnn-_t>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 4 Jun 2025 10:49:03 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: lidongyan <502024330056@smail.nju.edu.cn>
Cc: Lidong Yan via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Eric Sunshine
 <sunshine@sunshineco.com>
Subject: Re: [PATCH v3] pack-bitmap: remove checks before bitmap_free
In-Reply-To: <60E19C19-2910-46E7-9409-58D26190722A@smail.nju.edu.cn>
	(lidongyan's message of "Wed, 4 Jun 2025 20:43:49 +0800")
References: <pull.1977.v2.git.git.1748628846.gitgitgadget@gmail.com>
	<pull.1977.v3.git.git.1748915181113.gitgitgadget@gmail.com>
	<xmqq1ps1s698.fsf@gitster.g>
	<0BFD6581-2BB9-439B-9837-767FA98900C5@smail.nju.edu.cn>
	<xmqqwm9sq2lq.fsf@gitster.g>
	<B7032488-F47A-46B9-AF9C-D059AFC31FE8@smail.nju.edu.cn>
	<xmqqcybjg00s.fsf@gitster.g>
	<60E19C19-2910-46E7-9409-58D26190722A@smail.nju.edu.cn>
Date: Wed, 04 Jun 2025 07:49:02 -0700
Message-ID: <xmqqtt4vd0kh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

lidongyan <502024330056@smail.nju.edu.cn> writes:

>> Which was where my question came from.
>> 
>> Or perhaps you didn't do that "is my test really tickling the bug I
>> fixed and makes the original code without my fix fail?" test?  Which
>> also explains why lack of "export" was not noticed.
>
> The test case in v0 with “export” would fail, but test-lint in CI shouts. To make
> CI happy, I delete “export” and submit immediately. So I am sure now in
> v3 this test truly test what we want. But I make two mistakes that I haven’t
> pass all CI test before submit. I apologize for the oversight. I'll double-check
> my tests more carefully in the future to avoid similar issues.

Ah, I understood what happened.  No need to apologize.  I just
wanted to know how it was missed, so that we all can learn from
this episode to make sure that our tests do verify what we want
them to.

Thanks.
