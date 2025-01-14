Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 246F023242D
	for <git@vger.kernel.org>; Tue, 14 Jan 2025 14:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736863409; cv=none; b=MH4IeVLaL+q+id94pvPumwl+uxPtrPwfbRnzS7BnQtkpWaaMyGpbJJXgl6JTnbt9o+joqJSXtT8QklD+wtHTusbMH8laFmBp7uXs8c+9zK4tPNCv7XksGL07vjGw2Ec8dQ7O4OCRxSiGhMDtdGg4GYGFfqO4bdFZdbYqv9G80HY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736863409; c=relaxed/simple;
	bh=FalF68Lv2aZgpQJd2D4ik2jcsou+ETz6xBfAzYVwHcQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mi3jHuRROw9NIz6AGqBIlIawCcPS+rdwLhS/HKOrwO1IGElkrBAz/LRIIoIjDGYNgDdJQCF0sD+mIbtn4JWWBczHJWXgLr83GyCmC63c8DrKNen/qCJ42X3siloY54EvnYmxS1XIBflrjDHTKfqJDzg0utx5bLF4QGn8UHkH0A0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
From: Sam James <sam@gentoo.org>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Eli Schwartz <eschwartz@gentoo.org>
Subject: Re: [PATCH] meson: fix perl dependencies for Documentation
In-Reply-To: <Z4TOTVZbDlxh4Uuy@pks.im> (Patrick Steinhardt's message of "Mon,
	13 Jan 2025 09:26:59 +0100")
Organization: Gentoo
References: <79de1bcf31f708960a889066ce3d986e55155ad8.1736577530.git.sam@gentoo.org>
	<Z4TOTVZbDlxh4Uuy@pks.im>
User-Agent: mu4e 1.12.7; emacs 31.0.50
Date: Tue, 14 Jan 2025 14:03:21 +0000
Message-ID: <87r055wl06.fsf@gentoo.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> On Sat, Jan 11, 2025 at 06:38:50AM +0000, Sam James wrote:
>> diff --git a/Documentation/technical/meson.build b/Documentation/technical/meson.build
>> index 21dfb8b5c9..8c93da3566 100644
>> --- a/Documentation/technical/meson.build
>> +++ b/Documentation/technical/meson.build
>> @@ -42,6 +42,7 @@ api_index = custom_target(
>>      '@OUTPUT@',
>>    ],
>>    env: script_environment,
>> +  depends: documentation_deps,
>>    input: api_docs,
>>    output: 'api-index.txt',
>>  )
>
> Wait, this doesn't make a lot of sense to me. "api-index.sh" does not
> care about "asciidoc.conf" at all, so why is this dependency needed?

You're completely right -- I thought I'd found that api-index.sh *did*
need it, but it definitely doesn't upon checking.

>
>> @@ -60,6 +61,7 @@ foreach article : api_docs + articles
>>      command: asciidoc_html_options,
>>      input: article,
>>      output: fs.stem(article) + '.html',
>> +    depends: documentation_deps,
>>      install: true,
>>      install_dir: get_option('datadir') / 'doc/git-doc/technical',
>>    )
>
> This one looks as expected, though.
>
> Thanks!

I'll respin. Thanks.

>
> Patrick
