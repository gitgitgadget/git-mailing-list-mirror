Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 554CF32A3D7
	for <git@vger.kernel.org>; Fri, 24 Oct 2025 15:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761319858; cv=none; b=Lgfk7s8v/oQIu9VFWLNNUnT6HeAIl1gSdlKVdSHHRi0jAzhU6lSuJDjb01lB3c6KJ1Af9c8LGPY0yXVRwRfeKQ6fb3Thfinn8qqboUAcDSnZElgdNAK2moOXlO86KBmDGGQfSwGq2e1GMMgtA/Qa/kwMVQsSVmKKHcBOGICH+oU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761319858; c=relaxed/simple;
	bh=4tvOraaASLVmNDz5b12Sh7iN3Nwo0BfXqDgdEguLdmY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZdPyUnbq8Bp5uocV5OU0xeLrvaXf5QuywhRVX8qNtjgWAfCQ0MH+EOqs7k7aVVM+T5gd083bfq7m4fKkfgQoARakGXUzes/qVFN/zXukn+6RnnTW0UuQmIxT7GN/LfpKKeZaTlBZgrGUQidyChgQPOh/dmgcM5T2PxL73al9OL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Pvt4M5Pe; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ybP+JPqC; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Pvt4M5Pe";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ybP+JPqC"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 262A11D001B6;
	Fri, 24 Oct 2025 11:30:55 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Fri, 24 Oct 2025 11:30:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1761319855; x=1761406255; bh=DL5EZu3aeM
	EvB2oiPSUA2Nlb1pOSJjA3mwN4MvjI8os=; b=Pvt4M5PefeKsNS3PgoIkTfwRre
	EM8jGNtlV8/U2l6nZpEi55iQQNN50n5MhPGBm4M/HO483hshL4iX5OfrDRqSnww4
	hcrk2woFtZcqytJkocSXRIMNAYs2g40uMXD6o6dpnA2G1atMiawa2td/rijdHolD
	oV57hn1hDpjwT6PY+SomIIJ1cNqySJ77m3hXEeI9qKemj3/0H5IvzXOlJ5nZOXCn
	5klea/lGyZunNTirqGEuVDkgeNEybRCCkN9caRp+MSkiEK8NT4sPcSoKA82kwrof
	GlNNNJ5iUDuMMCtoFhQSnoWIIWqfSgse5RZNKHC1C4WcKzGIIGAW1huDI3rw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1761319855; x=1761406255; bh=DL5EZu3aeMEvB2oiPSUA2Nlb1pOSJjA3mwN
	4MvjI8os=; b=ybP+JPqCO8vCF3qXDNsZ5+/ETVxl8Unoe2eIfCX04aFZy/WrV8b
	EGlffRm59AiOjWsSKjlT94Bfh92w0uO3jXOYsM/ZlBTnVXFhGLvLo3rgqtZn17Jr
	YEb8vTSGVXC1yrJWssuJ//rdhsMaIyTWNtOm/E6cbKuizorJCy7/Xo/EXOUkQgCf
	SBQIyxt3AqxcUeB3JqG1cXm7yPkcBhiWhaAYSISa99k2Hzb0AqstXZ9ooZeBFi1f
	oAhnfCtyCRY6JGx2pi3CKy5CZxI1b4/BIPeOZ5UJs54gFdk4He3AMR5nYQMKGKeK
	UT9DG/XfFhi7063oS/WZ8DSjOGDjtzNDyjA==
X-ME-Sender: <xms:rpv7aKoxI-dcLYMRZt-HqYRnPjzPNxHishggJ61d_yasCjnFb7XYnw>
    <xme:rpv7aDD2h8RWi8ffC3CGB3htTiSQWSWGbX01EHDcvmuZfLTFf4D-ZldzdVe1OgLF5
    RCLMCdDh3ErjDXIscJejr6bgV5O79_7p7o-0b6s6s8cSrVZ-QVW>
X-ME-Received: <xmr:rpv7aFWSGRaRynm5CjQJEwd6CEZnLsmsQE0z7O0EBgVDRXtcdlq5_t_bYqIBlYktXdRjeNrFRX5zrqgQea2cMmtKoIudPuG9exD2>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugeeljedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepudehpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopegthhhrihhsthhirghnrdgtohhuuggvrhesghhmrg
    hilhdrtghomhdprhgtphhtthhopehsihguughhrghrthhhrghsthhhrghnrgefudesghhm
    rghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtghomhdprhgt
    phhtthhopehphhhilhhlihhprdifohhougesughunhgvlhhmrdhorhhgrdhukhdprhgtph
    htthhopehnvgifrhgvnhesghhmrghilhdrtghomhdprhgtphhtthhopehpshesphhkshdr
    ihhmpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtph
    htthhopegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvg
X-ME-Proxy: <xmx:rpv7aFDQHhqnupxAX32Clsh4Xu-4SDh5LGKYVW7WPy9PB3I0ZbksNQ>
    <xmx:rpv7aCeXMcwLKjYrIQIf57ButO7-zrRJ4ZKtVisOvPUJUwYyXn_HKw>
    <xmx:rpv7aMrYiNxICp7EsdHtuvYxK9ltyOUKsD4_k9qigfDIkC9hfjNw_Q>
    <xmx:rpv7aDQ6JUC2BmZsFOd0RcVKrfdozl_FYkG9Jz__1Q70NhprXXxKHQ>
    <xmx:rpv7aOGa7LLIzJHteBU3FyQEymve3z1LC1Ya8FvCwTZsMKqPcLO63rec>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 24 Oct 2025 11:30:54 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: Siddharth Asthana <siddharthasthana31@gmail.com>,  git@vger.kernel.org,
  phillip.wood123@gmail.com,  phillip.wood@dunelm.org.uk,
  newren@gmail.com,  ps@pks.im,  karthik.188@gmail.com,
  code@khaugsbakk.name,  rybak.a.v@gmail.com,  jltobler@gmail.com,
  toon@iotcl.com,  johncai86@gmail.com,  johannes.schindelin@gmx.de
Subject: Re: [PATCH v4 3/3] replay: add replay.refAction config option
In-Reply-To: <CAP8UFD3Bz+Yn4qtCrFoKcE=u-dAtK0cXON1nFMRL8n9wBSS8pg@mail.gmail.com>
	(Christian Couder's message of "Fri, 24 Oct 2025 13:01:32 +0200")
References: <20251013183311.33329-1-siddharthasthana31@gmail.com>
	<20251022185045.29256-1-siddharthasthana31@gmail.com>
	<20251022185045.29256-4-siddharthasthana31@gmail.com>
	<CAP8UFD3Bz+Yn4qtCrFoKcE=u-dAtK0cXON1nFMRL8n9wBSS8pg@mail.gmail.com>
Date: Fri, 24 Oct 2025 08:30:53 -0700
Message-ID: <xmqq7bwkqpua.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Christian Couder <christian.couder@gmail.com> writes:

> It seems to me that a dedicated function could handle this a bit
> better. Maybe something like:
>
> static enum ref_action_mode get_ref_action_mode(const char *ref_action_str)
> {
>      const char *config_value = NULL;
>
>      if (!strcmp(ref_action_str, "update"))
>              return REF_ACTION_UPDATE;
>       if (!strcmp(ref_action_str, "print"))
>             return REF_ACTION_PRINT;
>       if (ref_action_str)
>             die(_("unknown --ref-action mode '%s'"), ref_action_str);
>
>       if (repo_config_get_string_tmp(repo, "replay.refAction", &config_value))
>              return REF_ACTION_UPDATE; /* default */
>
>       if (!strcmp(config_value, "update"))
>              return REF_ACTION_UPDATE;
>       if (!strcmp(config_value, "print"))
>             return REF_ACTION_PRINT;
>       die(_("invalid value for replay.refAction: '%s'"), config_value);
> }

You'd want to do "string to enum" helper function just once and call
that helper from the above function, once for the command line option
and again for the configuration variable.

Or do so where you would add a call to the above function directly
without your helper.  I am not convinced that "here is the command
line option (or perhaps we got nothing); what is the desired
setting, taking configuration also into consideration?" is
particularly a good abstraction.  It is more common to have
git_config() to grab replay.refAction string, and if there is a
string value, pass the last one to "string to enum" helper and
remember the result, then call parse_options() to further overwrite
the result from the command line option string (which again will use
the "string to enum" helper).  The structure that requires your helper
function smells rather unusual.

> [...]
>
>> +test_expect_success 'replay.refAction config option' '
>> +       # Store original state
>> +       START=$(git rev-parse topic2) &&
>> +       test_when_finished "git branch -f topic2 $START && git config --unset replay.refAction" &&
>> +
>> +       # Set config to print
>> +       git config replay.refAction print &&
>> +       git replay --onto main topic1..topic2 >output &&
>> +       test_line_count = 1 output &&
>> +       grep "^update refs/heads/topic2 " output &&
>
> Nit: here and below, it's a bit better to use test_grep instead of
> grep for better error reporting.

Yes, "a bit" -> "much".

Thanks.
