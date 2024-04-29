Received: from pb-sasl-trial20.pobox.com (pb-sasl-trial20.pobox.com [173.228.157.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A73907F
	for <git@vger.kernel.org>; Mon, 29 Apr 2024 01:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714355794; cv=none; b=MxVW+JTdIWCawUfso8d7RAQjryxkckgRc4aKt7cT1Ny/9ZbbCsUoNIh8l6MdPu0BXK6Y+hUm0VI9Fdkf1mZkNgVS22dCFbZWWQTGFqwrJn6Wx/LkxvU7/zNbDbWHdpxWZEgc21QStj5IaO6zCCteQ6WiHa77To3Z0SLyDEDL4Mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714355794; c=relaxed/simple;
	bh=dCdzv1e/OgSVleDoMiyac0WA/sV6JSncbt3+U74k0Ik=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=aTT0E46WNPXXUen4HVnxDk5fpEv0wr4RDabWQQdVfGTjWFQ191V5Oyfew/L85HaJvSbT88NGuPjGGFDRnkUOpM6+raIY7S4uvwDhO+V0m2mXKHVftwY4l+a9q50CXu6jEAcCwZvRkJfCwStaawJFU4mmsOwgEcDWg+I2/UgpebM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=KVAkIS0l; arc=none smtp.client-ip=173.228.157.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="KVAkIS0l"
Received: from pb-sasl-trial20.pobox.com (localhost.local [127.0.0.1])
	by pb-sasl-trial20.pobox.com (Postfix) with ESMTP id 4A8A13A007;
	Sun, 28 Apr 2024 21:46:57 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=S1EEt+SgVwdeONRzjTUFnxFarY8=; b=KVAkIS
	0lAK/7rR4Iq2BcV/X8uyJiORDxBjTwsqbwsvAZihGotfMQNubCRPpHeCSXWFgppA
	U3adwQHuN8WiiGcvT4wdU305w+nM71rngEcbR91+DG/f8EM8O+9j5ZHTaExWAKJI
	EImn4N6yWT2um4reMkMCgAq9g+8B+SF4QMARA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; q=dns; s=sasl; b=WN0cGyituzDS9ndPi6wPYf62RAzoHAso
	8egI+SBlVeAgCQ8zXsk9u47Db7qV/s3mxP8badl3ECGMVRkBTpF6yUf1Drn+RqJi
	VNRKZ8chiYKEYrMGm5NA6nv9Y5hGEVJY6eir5ImkmGr7NkGgyyyFE2Y0K6hfRo62
	sLK6iv4o3n4=
Received: from pb-smtp21.sea.icgroup.com (pb-smtp21.pobox.com [10.110.30.21])
	by pb-sasl-trial20.pobox.com (Postfix) with ESMTP id 3BD673A004;
	Sun, 28 Apr 2024 21:46:57 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.120.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 76BD931AD6;
	Sun, 28 Apr 2024 21:46:51 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jiang Xin <worldhello.net@gmail.com>
Cc: Git List <git@vger.kernel.org>,  Alexander Shopov <ash@kambanaria.org>,
  Jordi Mas <jmas@softcatala.org>,  Ralf Thielow <ralf.thielow@gmail.com>,
  Jimmy Angelakos <vyruss@hellug.gr>,  Christopher =?utf-8?Q?D=C3=ADaz?=
 <christopher.diaz.riv@gmail.com>,  =?utf-8?Q?Jean-No=C3=ABl?= Avila
 <jn.avila@free.fr>,
  Bagas Sanjaya <bagasdotme@gmail.com>,  Alessandro Menti
 <alessandro.menti@alessandromenti.it>,  Gwan-gyeong Mun
 <elongbug@gmail.com>,  Arusekk <arek_koz@o2.pl>,  Dimitriy Ryazantcev
 <DJm00n@mail.ru>,  Peter Krefting <peter@softwolves.pp.se>,  Emir SARI
 <bitigchi@me.com>,  Arkadii Yakovets <ark@cho.red>,  =?utf-8?B?VHLhuqdu?=
 =?utf-8?B?IE5n4buNYyBRdcOibg==?=
 <vnwildman@gmail.com>,  =?utf-8?B?VsWpIFRp4bq/biBIxrBuZw==?=
 <newcomerminecraft@gmail.com>,  Teng
 Long <dyroneteng@gmail.com>,  Yi-Jyun Pan <pan93412@gmail.com>,  Git l10n
 discussion group <git-l10n@googlegroups.com>
Subject: Re: [L10N] Kickoff for Git 2.45.0
In-Reply-To: <20240415072226.15005-1-worldhello.net@gmail.com> (Jiang Xin's
	message of "Mon, 15 Apr 2024 15:22:26 +0800")
References: <20240415072226.15005-1-worldhello.net@gmail.com>
Date: Sun, 28 Apr 2024 18:46:49 -0700
Message-ID: <xmqqa5ld2b5i.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 598CC9B2-05CA-11EF-8474-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Jiang Xin <worldhello.net@gmail.com> writes:

> Before the upcoming release of v2.45.0-rc0, let's start a new round of
> l10n for Git 2.45.0.  This time there are 78 updated messages need to be
> translated since the last release. Please send your pull request to the
> l10n coordinator's repository below before this update window closes on
> Sun, 28 Apr 2024.

In whose timezone and at what time???
