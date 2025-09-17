Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F62D1E3DF8
	for <git@vger.kernel.org>; Wed, 17 Sep 2025 06:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758090178; cv=none; b=ZYRsnlA9mHizmQXeA12Iql/+m5KNnJMsPhSjCCNmy7LC04lG6QrFQccQFbIKrwHwP4GesvqrUgaRlicGdTODOv4t4ebP1/wPKYBAhvfsT4mWkBzJQS8y5mYA0L6Cv2ZvPcmdAQQExHa9ViCJmQKOwaTw/PKErNuzeDnMMKWhh6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758090178; c=relaxed/simple;
	bh=1UiDLk3xzfxkdEUSdVKB3bEtIgvxNsTRdrYwMJy8fGk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Qx6JpK52sMSRHVjTR9Cl413BBN43KoFYRm0eEG5XmXP6vcXJCcKXjw/ZpkmXlFTqpizzN3tQQau+KpgOxGPr8XqotYEPr2RfeMg+3Awg3j50aYqNZRUodHKp4FRKHfnX2rLHU7nMW5tLEj3GbGnzWPSK1XwQxnOO6UBGzGwVfHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ofRU7n2m; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ezxeJm53; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ofRU7n2m";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ezxeJm53"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 1B13E1D001E2;
	Wed, 17 Sep 2025 02:22:55 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Wed, 17 Sep 2025 02:22:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1758090174;
	 x=1758176574; bh=JlSAZ/2Zrc0M+lM8JCms+IpREv5X4QsvO4JAbw5roH4=; b=
	ofRU7n2mWCOEJzDsyWqktnnh1KPoliYn1Y7AgpOSp59Da11fgRNoEPq5xWbDuf7Y
	PYtmS/oDb7BpRP/QZkX9hKuDUI5uXDa5i7E2qCHfA5Rwa04fy4WAxwzyLXONS6f9
	vFq+vkuRjGYEi7He74/iLYaGaW35RHIK9dAhxPWFrQYRn/hV4FPhkbO/73u3VNsl
	u0zgslN30IqYMrD+F1cXiGOKso9+6Li4tnoaUH7m19PSGODuRCu/I4vGORU61e6g
	Nec22LTmWHrht8+N1uDzlWtjzl8PA0p5uUU7bgHNOJv/F9yeOrItdrNMZiXyYWu5
	jzl5xF0iiTNN+GNTqxQJRg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1758090174; x=
	1758176574; bh=JlSAZ/2Zrc0M+lM8JCms+IpREv5X4QsvO4JAbw5roH4=; b=e
	zxeJm53RW+ysr6SQnOGt18YevaL8e/0bIDWk1x2kP3kbd7sUMmdWOrlNGmisyAgY
	QgaEpR6zkt+Iv0XYRrQWpS5io09WVkUD+b+1yQF7xoN4P6AdEd4qMt0a9gF/HROZ
	rS4vjn2xOyQsH2DVUf6LoS0m5MpVlpRM5GMnKQ8E17cwPfofrR01Eb03F/QhspEo
	JPkTOvdPwMIC7UvHpriFKkZDlQT+EcEXi3sB5oQUBIX4ZiCUFXjn6BmPd+8ozOXa
	QBqoOwOssRuyCTFpV/T6OJ75K20hEjh6A9fwMgRdv6nsQZrKca39a0hFaWiFgKSs
	JbcH/50diYSyJ7GctjeRA==
X-ME-Sender: <xms:vlPKaJ3uwu16N5dz_WChgrQyS0fWFgaBwuj7i15c0On3uJJmTkeEpw>
    <xme:vlPKaKq0Buvda9t4m0BAy1q38ZbYPEeH8agxcKBAsHng9kN3RY49kLVYnQqhFiZDc
    2l3SIVmWXyM6xqVXg>
X-ME-Received: <xmr:vlPKaGe2A-rqJbboJU0Hqxwfn7JVhUrRgxnQvx6NbqRcDvd631Irxqt1Zpqu1zPCpury6Z0jF4uUwVGsxBvl1KB62GJJuZgc4FJ52gc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdegvdejvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtgfesthekredttderjeenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnheptdffvdetgedvtdekteefveeuveelgfekfeehiefgheevhedvkeehleevveef
    tdehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepvgiivghkihgvlhhnvgifrhgvnhesghhmrghilhdrtg
    homhdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomhdprhgt
    phhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhith
    hsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:vlPKaJppqh-gi7041qbvb5yTEoz6B6sbbSs0dATVSlK_58EFx8FeMw>
    <xmx:vlPKaHGg_cqopYFqV92-po4rQ7PSKhG1bpDq5xhbq8AT359-yoYAvA>
    <xmx:vlPKaJvpObr7GqLt2bMGEE36cIJUsI1zT0WH_ck47iWxXOmPex_0Kg>
    <xmx:vlPKaJWfmjK9_a_DHGE_fDJ3sG5nA5ATb7G_azFDa4wQyJ6E4lp-fQ>
    <xmx:vlPKaPFK6XxqkhcG0asAr6o029aqoYzSPklr2zBi9ydPOc24cq6lu8ug>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 17 Sep 2025 02:22:54 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Ezekiel Newren <ezekielnewren@gmail.com>
Cc: Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org
Subject: Re: [PATCH 00/17] Use rust types in xdiff.
In-Reply-To: <CAH=ZcbCra35t7sxnwTvaw2oQeh6VL719v4Hx1fjDTGiU5Gmh-w@mail.gmail.com>
	(Ezekiel Newren's message of "Tue, 16 Sep 2025 16:01:03 -0600")
References: <pull.2048.git.git.1757274320.gitgitgadget@gmail.com>
	<xmqqcy7qm582.fsf@gitster.g>
	<CAH=ZcbCra35t7sxnwTvaw2oQeh6VL719v4Hx1fjDTGiU5Gmh-w@mail.gmail.com>
Date: Tue, 16 Sep 2025 23:22:53 -0700
Message-ID: <xmqqzfation6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Ezekiel Newren <ezekielnewren@gmail.com> writes:

> On Tue, Sep 16, 2025 at 3:56 PM Junio C Hamano <gitster@pobox.com> wrote:
>> I think we saw that the earlier part were read carefully by Elijah
>> (and others may have read without finding anything worth commenting
>> on), so should we split this into two parts and start merging the
>> early 9 down to 'next' and then to 'master'?
>
> I agree. 1-9 are ready to go. Do I need to create a new version of
> this patch series? let it stand as is until it's been merged into
> master, or something else?

I have

 - en/xdiff-cleanup topic that ends with cb1c89e5 (xdiff: treat
   xdfile_t.rchg like an enum, 2025-09-07);

 - en/xdiff-rust topic that
   - forks from v2.51.0
   - merges (with --no-ff) en/xdiff-cleanup
   - has the remaining patches rebased on the above merge

and 'seen' will have the first one and then the other one merged.
Later, let's merge the former to 'next' and 'master', with the
understanding that everybody is already happy with its contents and
we won't need to touch anything in that first-half of the topic
until we merge it down to 'master'.

The remainder hasn't been commented on very much (yet).  If you have
improvements, please do update these topmost 8 patches so that we
can replace the part of en/xdiff-rust above the merge.

Thanks.

