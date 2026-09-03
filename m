Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C716393DC8
	for <git@vger.kernel.org>; Thu,  3 Sep 2026 18:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788461515; cv=none; b=CotHx2K6k4t1fkCqNS7bEQB47ZjRO9lHSwFlsc6Y+lIeuFiHGw8cFjtiRTmEei+YfL7lP+cfPDQBQS8Mlzq+7uhe71yfI+2RX+20Yaj4fCMytMjzPGz5Jq8ZwhCy1aoW3WnKrUOt8Ks7QPNb+sp77IA4kHYOHJ7nOOKpAPzhTRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788461515; c=relaxed/simple;
	bh=zjcuUcQzJY6+9cNjS2hCloA2/tw0i7C5Ydj4pMddKWQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BiPW2l/BM50GOSInKxj3Hk1BFHQt3qgQYjV/er5ZvoWqfzUX8iT2XL1j56vFA+j8dc+Ovj7ZKrZbNVDXGeA9TuDnwDIsj9l0rEQbK3pu4fgn+wx+xFZb0Uev5+CFa1ohLcefdhPVKZzj2tsUd6bOXIbBXWSs9vH3ysynsGW0VUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=c8G3iqad; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gJ7lYQq4; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="c8G3iqad";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gJ7lYQq4"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id E30AD7A0167;
	Thu,  3 Sep 2026 14:51:43 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Thu, 03 Sep 2026 14:51:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1788461503;
	 x=1788547903; bh=ZaKDqYQJAKxXtU1sHYq8z9L4qmyiGedIFFhKgRV8zDM=; b=
	c8G3iqadji0lWOFx0u2RoVuMitizcKiA+SbVZxZmjz08L1kHJUtMlg1WhUf5N7jm
	8hw33Jo0hz77whymM7oSj/yAScRMiBU1HweZyIZdSeknQ54q3Jqyk+8QjOLCRdyg
	9cqcBbKLMrwrfMmFMzCac6FE4H7jqUWdC5qFWXQ87lr5q/gERpGr4UumnP5QOebg
	+9+g59HIfV2uRssWC8LsvAAi06/PCGgKiPkL08jE3XubnwBI+P51F9T2DST0VcSt
	jIY6OG5IvHU7cXy4md28qFySEq9FFu/JKLv/6mVjQCkYq9vt9LMm6uOYLZ7vjssb
	RwZe2sQWFT0r5Sgyaq+uWQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1788461503; x=
	1788547903; bh=ZaKDqYQJAKxXtU1sHYq8z9L4qmyiGedIFFhKgRV8zDM=; b=g
	J7lYQq4hKSPmGcSRM9aqmxwmKbYIEhhSSuKfPQYwiLuknQcWgjeRSrDXkftgi/Oi
	YMUDdOXajBGkqoGLOMYPZABzNT4I+Pb0nUrUCqlfPo7yu3pBUaHNNOeCIU1aADs0
	Xteb9RxZU5gUoUwLjUx7tPAVlTHrnIpvgmfCzULohP4mZQYNJMX4hohGvGy+6kFD
	sS7OduDlNg15bad8C8CzWlQAed+3TsMK3BtiPPbsswRDXKixKQNTd2tqdPQRBqzT
	WtxJxaCC/TK2BV06vo/UEWB+P3Z97rst90cJDpa89uUURaL/r6zyXypbuXVpeRTy
	ruK/d0bYeK7REEixSgIfQ==
X-ME-Sender: <xms:v8GZavc0kKqX0xHUhdm8YKLTS_vyHv2tvfsfqWorffRDepCneUnOUA>
    <xme:v8GZasM335cbcaDrduyye3o0IgfhzeNCfj26x-_PqQsAtt6ub_asc5eaIUqqeo0SG
    8cBt01uMcnrek6tc1_JMBCcCMNifAzDvSy06_2oxwq3xtnZC_qzHw>
X-ME-Received: <xmr:v8GZatj90SWv9BX3SfnCTcaQUMAFOogaIxNqIP5CHEEhDbc-7bvvDFLxXpF-npg91xTM_TaAW0XI5JlqMvmUcfwZtjhwDjc-oQ>
X-ME-Proxy-Cause: dmFkZTEwFbcyyYPReaFK0pSdK6EtHUMhMwwRPkZIB5AGh5FYyzIfY4XSKEx4d5uSeY3U6V
    B3RmvH0bm0VManc+fBUSin10iKKyIidl8Sxgs2XtEgbjRVR04ceHFTamZJmGpfbGfqSY2L
    Gguq29875cccmc2PBOVhyL3UqYTT2AWxw/w1Cuvxc/p7nlUXMiCnWg8Pv1DfHpT4DTnp2z
    /yLk/d/NYkSbF9N+8/gwJj/zirE6pMAVlBsdqw80toib8GTanWfGa2LJ/x8XlFGPlhyHKx
    VwmzpJH0xB8RYMFKBKu5J7SiKc7mZHdH2DkWeAYuQ3HxbjwoWCT3fsBczcvVlV7o9zWPBv
    OzUvedsIwQBNaSIP45kCmJY3vaw010juZ+YiS0BXO1qKbf8Y7fJ6IRHUjTeg4lTiDkbS9y
    sDYLQj64pufWR9QwkmstD3B/jhLYg6Nwtmhx9Qzji8Xzxow/So5jjj5dtpi+R2/H2LaHEu
    +nIOIh7b+XrAinY1vCh4kgwwf0axjZ428I6hEUKvoT3nqzZwvhS/pmC6Iff+DIdefuUb5S
    GyRsri98/pYVnIP1v0h5JXVFsunAzRLO1pofseH3QErh2d3Wb07WUnM4cQH7DIzkPb3rUO
    xkdWq9FXnvNuZbH4c0oyXNxC4FIi14nCI7EkXmLH29g7qXA2DrqDZWnJaqrg
X-ME-Proxy: <xmx:v8GZav0yufBoVpjRyZdLDAbJPP9Org0UXKLvkqEFR7XxmWoLxFgxwA>
    <xmx:v8GZang5J_cn4iaB8ywE2PKq-LU-4gJ34mRxhQ9prP6Rd4KOy-jbOQ>
    <xmx:v8GZaveVi9LPDDlbAS-Ym8_LISqwoCQa1xrF9VWX_0vTVVLs7C3IiA>
    <xmx:v8GZaqnXyQfVjzMXKbGRiWQAp8z4w0UbtwG44Oe3XuOyV-yEco4HOA>
    <xmx:v8GZamL6wCvPOuNpG_RTbzNPzrmsF-pkLZB_762F2GSzZF3sTj_WRz0c>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 3 Sep 2026 14:51:43 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Yannik Tausch <dev@ytausch.de>
Cc: git@vger.kernel.org,  dc@diogocastro.com
Subject: Re: pathspec: match and original in pathspec_item are const
In-Reply-To: <4439BA70-2C03-499D-B3CE-E43700C0A8DA@ytausch.de> (Yannik
	Tausch's message of "Thu, 3 Sep 2026 20:37:57 +0200")
References: <AA085B7A-F528-458A-8AA9-7664480997AE@ytausch.de>
	<xmqqecfbk2eb.fsf@gitster.g>
	<81EC0E28-13E7-4D10-BD07-3601124CBD77@ytausch.de>
	<886A25E6-8854-4AF6-BF0B-CFB57B673026@ytausch.de>
	<27FF785F-F5D5-44EC-93C2-5BD67BD99147@ytausch.de>
	<xmqq4ig6cihc.fsf@gitster.g> <xmqqy0dib3ue.fsf_-_@gitster.g>
	<4439BA70-2C03-499D-B3CE-E43700C0A8DA@ytausch.de>
Date: Thu, 03 Sep 2026 11:51:42 -0700
Message-ID: <xmqqbjaeb22p.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Yannik Tausch <dev@ytausch.de> writes:

>> I just found [1], which is related to this patch series. I didn’t review the discussion in detail yet, will follow up.
>
> I read this as you came to the same conclusion as me independently discovering the same issue in July. Perfect! I hope it’s fine that I took over the fix that way.
>
>> Junio C Hamano <gitster@pobox.com> writes:
>> 
>>> This unfortunately triggers
>>> 
>>> t/unit-tests/u-dir.c: In function 'test_dir__common_prefix_skips_excluded_pathspec_items':
>>> t/unit-tests/u-dir.c:53:34: error: initialization discards 'const' qualifier from pointer target type [-Werror=discarded-qualifiers]
>>>   53 |                         .match = "unrelated/path",
>>>      |                                  ^~~~~~~~~~~~~~~~
>>> 
>>> Other than that, looking good.
>> 
>> We may want a preparatory patch before this step.
>
> Thanks, I will include your preparatory patch in v3. 

The 'const' patch will be queued separately, and a synthetic base will
be prepared for your two-patch series by merging the 'const' patch on
a recent tip of master.

Unless you have other changes, there is no need for you to send a
three-patch series.  We do not need to take the 'const' patch hostage
to the 'pathspec' patch.

Thanks.
