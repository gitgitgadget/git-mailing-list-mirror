Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC23CB660
	for <git@vger.kernel.org>; Thu, 17 Oct 2024 00:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729125393; cv=none; b=WBXvhRDBHM0mdJStBuCzllfHfsr7P7knS4A6jaMlkjl1s432wwjcRKbQno9/xq+/vSfBqjXJZKkXim511xuhhl3W79t7Z3fh4ROK8i6Qr9yoD5YzrlmXlPyNCeli71tdvQiG9qOgUW0bH8/urQB3nw9BcTlg+8SJQ5Ctr0UiXJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729125393; c=relaxed/simple;
	bh=4zOfEYtUPoBLzqReFM69SG5eJzQ2SqBxsFalbpNyZqk=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=dkjJsjbm+lrywP5hko1EIJDAA4f9wwB+4acPlQ8PhuH3HX0eUyKUkT99V1kxSiMUxbzeZqoEfgS81JYMPMh2F78KiHrUreLVEV/mUgK9dGo3TFmWYt7DKdr02jjokgyYp9l0tkXIES9iOlj69jI/s7mx0j8klNH7o2ezso0l6eM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rwsh.org; spf=pass smtp.mailfrom=rwsh.org; dkim=pass (2048-bit key) header.d=rwsh.org header.i=@rwsh.org header.b=RkgoqQcV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bkGcb8Jd; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rwsh.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rwsh.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rwsh.org header.i=@rwsh.org header.b="RkgoqQcV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bkGcb8Jd"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B601F2540095;
	Wed, 16 Oct 2024 20:36:29 -0400 (EDT)
Received: from phl-imap-04 ([10.202.2.82])
  by phl-compute-05.internal (MEProxy); Wed, 16 Oct 2024 20:36:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rwsh.org; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1729125389;
	 x=1729211789; bh=tVeGydmxaS1hXogXR0aPRhQ1SEa8Ayi+iSud4JC/0Sw=; b=
	RkgoqQcV4wNH6yUBbp+tfXN8j2WyRi9YvuJX0O3x+ZbCZQyPuBBT74tw2dBp/JWu
	RwQsnYt4CysPhht6CJKt5+CvgEzl3vSNNZi64l+vSF/7zRZO7G7BiAYpvIEpu9v4
	+t1XVHyB/eopIhJOmgRXQOvhAaVc4bJw955v2qSa1kKFxQYmN/feiLiAbXgQt39q
	/AchSMKH7k7+riVHg/BMy2RYJd1/TdsoHcQ113WUPVJGTDPV3o2b+Sm0EYu9piDF
	rEdsNa+jUGJBf7XFptEdB58hZzZi14aJ8ajLa3TecSiRt+UOapLaXXDqF1rEJZND
	0HHGimk3W4LQV6OeFo6ATg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1729125389; x=
	1729211789; bh=tVeGydmxaS1hXogXR0aPRhQ1SEa8Ayi+iSud4JC/0Sw=; b=b
	kGcb8JdpxF/W7Ka5RTHYw3wfUCC/mas0/334q1meD3AlkUwHFa54r7gcCdLYJh0K
	ka2I/8pcJDF/bFGGdP2KgAyhI6DOrP/gQHP3TRqtmrKgmor02I9nZVhYVf9Vo6sH
	QsRHXOWHNMb+A3Gvf2U1UKQlmKBfT4cwO9WuZwomOBQ6P0aywrUUyq+hdI7NpGlj
	+0XTyGudqtQ5kXwBKKeJC5n5SJOIqZHbcFEOAIXW/MPc/Dn/9Dj9skddcMsyMVF9
	cZW0VK15QowtM6su8sYueDrh3uDlSTWNqE2/+4qa7Mu0vWD7vqTHJvp8tlv37Tif
	1ps9lsHRbwr1iSW+VWbNg==
X-ME-Sender: <xms:DVwQZ9KOUMY-5w_teDMTNi-ttfnVOSZ92CKMjT1dJaUxVBd1TB-M-w>
    <xme:DVwQZ5KXK97ajpp9X1RAQJPWS7sWy4jqHFwlR5J12RvsudWUIj_hfxj-qjlxH2Ufj
    h-iUnkkmucVluU3lTo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdehtddgfeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefoggffhf
    fvvefkjghfufgtgfesthejredtredttdenucfhrhhomhepfdfurghmucfpvgifsgholhgu
    fdcuoehsrghmsehrfihshhdrohhrgheqnecuggftrfgrthhtvghrnhepuedttdelleeute
    evfeejhefguedthefgjeevtefggfehudeglefhudeggfdujefhnecuvehluhhsthgvrhfu
    ihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepshgrmhesrhifshhhrdhorhhgpd
    hnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehphhhi
    lhhlihhprdifohhougesughunhgvlhhmrdhorhhgrdhukhdprhgtphhtthhopehsthhorh
    hmtghrohifsehprhhivhgrthgvrdhpshgvnhgvmhhoshdrnhhupdhrtghpthhtohepmhgv
    sehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvg
    hlrdhorhhg
X-ME-Proxy: <xmx:DVwQZ1sNtRCB0oo6Bv6-1OPx4boX5mPBwKLGZlBPVHV-UcaCZQZtHg>
    <xmx:DVwQZ-bd3UXTMKHn5EmyH4DPSKLy0El-dPY9oWa71Mv6Bn3oIe6l3g>
    <xmx:DVwQZ0bjH1XWmKOFsl_lWkE6H-I0JFyGcUPznbeAjklBKLi0NsbSLw>
    <xmx:DVwQZyBFM57ViljYzVARnX615rlIY4wBuhbBctVylilC1NIP5TszOQ>
    <xmx:DVwQZ8Eu0_96nWbStbbe7wOihZGgTokZCgfeoIc2Ylf3pYWnla720RS7>
Feedback-ID: ie52944fa:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 19F852E60084; Wed, 16 Oct 2024 20:36:29 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 16 Oct 2024 20:36:08 -0400
From: "Sam Newbold" <sam@rwsh.org>
To: "Taylor Blau" <me@ttaylorr.com>, phillip.wood@dunelm.org.uk
Cc: git@vger.kernel.org
Message-Id: <38af2f33-f793-46f8-a0a0-c63ab70e764e@app.fastmail.com>
In-Reply-To: <ZxAjLrrqM5i2kdBz@nand.local>
References: <20241016022613.37813826@scaldcrow>
 <dea863c3-7b54-4f8d-b6b0-6087b4cb1abe@gmail.com>
 <932d1aab-26e8-4c27-a3dd-a7191e8e71dd@gmail.com>
 <ZxAjLrrqM5i2kdBz@nand.local>
Subject: Re: core.hooksPath cannot revert to the default locally
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Great! I'll reply to this thread when I have some code to be reviewed.

On Wed, Oct 16, 2024, at 16:33, Taylor Blau wrote:
> On Wed, Oct 16, 2024 at 02:42:57PM +0100, Phillip Wood wrote:
>> On 16/10/2024 10:03, Phillip Wood wrote:
>> > I'm pretty sure I've used "git -c core.hookspath=/dev/null ..."
>>
>> Looking at the code that will unfortunately disable all hooks including
>> the ones in .git/hooks. It would make sense to allow an empty
>> core.hooksPath mean "use .git/hooks". If you're interested in working
>> on this then I think doing something like
>
> Thanks for providing a helpful suggestion.
>
> I agree that the behavior you suggested here when specifying an empty
> value for 'core.hooksPath' would be an improvement here as a means to
> override system/global-level configuration.
>
>> diff --git a/config.c b/config.c
>> index a11bb85da30..91f190a1ce1 100644
>> --- a/config.c
>> +++ b/config.c
>> @@ -1437,7 +1437,10 @@ static int git_default_core_config(const char *var, const char *value,
>>          if (!strcmp(var, "core.hookspath")) {
>>                  FREE_AND_NULL(git_hooks_path);
>> -                return git_config_pathname(&git_hooks_path, var, value);
>> +                if (value)
>
> I think this should read "if (value && *value)" instead, to ensure that
> things like:
>
>     git -c core.hooksPath= ...
>
> work as expected.
>
> Thanks,
> Taylor
