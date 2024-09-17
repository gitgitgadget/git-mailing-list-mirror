Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42329F510
	for <git@vger.kernel.org>; Tue, 17 Sep 2024 21:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726610071; cv=none; b=doIoGsk3xgDmaB8Qq02A683ieZxsjzztCHYr0VgCiI6EWWZDijBM7k1OvQF8TPVoPPrKLP/4Bx2uVWvjhqO8jy0NbyTR0qrLRK98X203aWbsMZm/R7bQWFejo3Z28aRwdYPco8CoO7RiIY7ChqbR29v2OrLDwk3aZzXrv8LUoec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726610071; c=relaxed/simple;
	bh=uA7uFPqCjtfrGQT7BjzrukEV1mW/6BGCCKUWmIFmZEI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jLgIJTTowJs5SSK2Wiw4EkgS9PPzkjyAZPVq4hrSSNWmri3iczjtghJR8bgEi39fsyPnjtz59oPh2hgQeIKo+zi37buD+1Xp5H2Whi6yUr7iIjuGR+Le7oJjf5/X2cKXgCBtA5Z+Mq13OCotYoysAJ24JnDloiJ3i5UWT/xc12c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=I0+67poW; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="I0+67poW"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id CA93B28B74;
	Tue, 17 Sep 2024 17:54:28 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=uA7uFPqCjtfrGQT7BjzrukEV1mW/6BGCCKUWmI
	FmZEI=; b=I0+67poWRgeO5h3eWUEsw7McxQFHZBHifLnMELDgwrSbJLyWAYw715
	09zSi8gY7exU/BZY+ONBLKg2J/tdl91V9cg+W2FlUzGBccw1EIGLGB/OrtonmFo7
	T6gZPwkP2T6z8GrssP3bEGE5CcFUEjf5oJ9ddPQAkyP1IGg58Qv5Q=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id C2B1628B73;
	Tue, 17 Sep 2024 17:54:28 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 392EC28B72;
	Tue, 17 Sep 2024 17:54:28 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc: Beat Bolli <dev+git@drbeat.li>,  git@vger.kernel.org
Subject: Re: [PATCH] unicode: update the width tables to Unicode 16
In-Reply-To: <7449ce5b-5308-ce6e-394d-43dec511ef16@gmx.de> (Johannes
	Schindelin's message of "Tue, 17 Sep 2024 14:37:17 +0200 (CEST)")
References: <20240912204047.1020213-1-dev+git@drbeat.li>
	<7449ce5b-5308-ce6e-394d-43dec511ef16@gmx.de>
Date: Tue, 17 Sep 2024 14:54:26 -0700
Message-ID: <xmqqy13qhrot.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 6957C48E-753F-11EF-9BFF-9B0F950A682E-77302942!pb-smtp2.pobox.com

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi Beat,
>
> On Thu, 12 Sep 2024, Beat Bolli wrote:
>
>> Unicode 16 has been announced on 2024-09-10 [0], so update the character
>> width tables to the new version.
>>
>> [0] https://blog.unicode.org/2024/09/announcing-unicode-standard-version-160.html
>
> I can confirm that the output is identical to the result of running
> ./contrib/update-unicode/update_unicode.sh.

Thanks for double checking.  I did the same when I queued the patch
and it indeed looked good.

> Maybe we should add an automated, scheduled workflow for these updates?

We could, but the consortium aims to issue major updates once a year
in September, with minor versions and updates "will be avoided", so
we may need to devise automation that makes better use of resources
than to scrape http://www.unicode.org/Public/UCD/latest/ucd/ daily.

44dc651132 2024-09-12T22:40:47+02:00 unicode: update the width tables to Unicode 16
872976c37e 2023-09-25T21:07:04+02:00 unicode: update the width tables to Unicode 15.1
b10cbdac4c 2023-03-30T21:15:17+02:00 unicode: update the width tables to Unicode 15
187fc8b8b6 2021-09-17T12:19:20-07:00 unicode: update the width tables to Unicode 14
65588b0b2e 2020-03-17T16:36:05+01:00 unicode: update the width tables to Unicode 13.0
5817f9caa3 2019-05-29T22:50:45+02:00 unicode: update the width tables to Unicode 12.1
584b62c37b 2019-03-21T22:06:17+01:00 unicode: update the width tables to Unicode 12
570951eea2 2018-07-09T21:44:52+02:00 unicode: update the width tables to Unicode 11
e233bef43e 2018-04-10T14:26:17-07:00 unicode_width.h: rename to use dash in file name
