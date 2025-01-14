Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6822A232437
	for <git@vger.kernel.org>; Tue, 14 Jan 2025 14:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736865305; cv=none; b=DzDvPy9mUYD/FMAoHU8pPQN61VlrbW2dYb1VTD5DC6fxphjEcVQZKZG6Zrpg0lpU+K6BzLEJKXsetFKYSfr6XWaGegibjCO8TWSOLHhMuIV00Kp93PiZhppcV4lGH2+kmqqcBJqpRoQ1M/dzxK2h3Sxl7e5+utIAyB4e0aEbJiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736865305; c=relaxed/simple;
	bh=jnq1E8Q3adC0S+kaW50+3BuQggm7ctaDmCmL61FlXqI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jnmTtWL8BM6ChCLCbv55aXD2HSjWyYDTNN3h1FtF984LArbFm+y0dNl266u0wb8RIQwbJHFjC6zYqDfMJymQPqzrEM5OYaxP0UunUknUl91/8jVAUJAofKLqJQqtztURn453YKN72J+J5KtW04LGOc9tONAv29ErcuUpnXBtKDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
From: Sam James <sam@gentoo.org>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Eli Schwartz <eschwartz@gentoo.org>
Subject: Re: [PATCH v2] meson: fix perl dependencies for Documentation
In-Reply-To: <Z4Z0Fxj87XrqdZl7@pks.im> (Patrick Steinhardt's message of "Tue,
	14 Jan 2025 15:26:31 +0100")
Organization: Gentoo
References: <5114dc9a00377826a55f6bab007d2ad1a4de8bc5.1736863427.git.sam@gentoo.org>
	<Z4Z0Fxj87XrqdZl7@pks.im>
User-Agent: mu4e 1.12.7; emacs 31.0.50
Date: Tue, 14 Jan 2025 14:35:00 +0000
Message-ID: <87ikqhwjjf.fsf@gentoo.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> On Tue, Jan 14, 2025 at 02:03:47PM +0000, Sam James wrote:
>> We need an explicit `depends: documentation_deps` so that all of our
>> Documentation targets know they require asciidoc.conf. This shows up
>> as parallel build failures with it not yet being available.
>> 
>> Other targets look OK already.
>> 
>> Signed-off-by: Sam James <sam@gentoo.org>
>> ---
>> v2: Drop incorrect dep I'd added for api-index.sh as pointed out by Patrick.
>> 
>>  Documentation/technical/meson.build | 1 +
>>  1 file changed, 1 insertion(+)
>> 
>> diff --git a/Documentation/technical/meson.build b/Documentation/technical/meson.build
>> index 21dfb8b5c9..3a65ee59b3 100644
>> --- a/Documentation/technical/meson.build
>> +++ b/Documentation/technical/meson.build
>> @@ -60,6 +60,7 @@ foreach article : api_docs + articles
>>      command: asciidoc_html_options,
>>      input: article,
>>      output: fs.stem(article) + '.html',
>> +    depends: documentation_deps,
>>      install: true,
>>      install_dir: get_option('datadir') / 'doc/git-doc/technical',
>>    )
>
> Okay, this looks good to me now, thanks. One last nit on the subject
> though: as far as I can see the change doesn't have anything to do with
> Perl, so it is somewhat confusing. How about:
>
>    meson: fix missing deps for technical articles

Agreed. Not sure where that came from.

I'll send v3 for that then.

>
> Thanks!
>
> Patrick
