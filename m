Received: from pb-sasl-trial20.pobox.com (pb-sasl-trial20.pobox.com [173.228.157.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 059B541A82
	for <git@vger.kernel.org>; Sat, 10 Feb 2024 17:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707586295; cv=none; b=aR1f83fxAEfU5U4AMWUy1MsfHLAJkCoU1B8J8mLx6Jw0IeeTEMCG2X20Xa8bHLDgzYHevWOLrYSogFU4OUCYfAOKXjSz1D00TX3xs6BMIMB21c6NmXHqTFMl6oFyfVuX9NZIgPdVPsoQy75IldFKaLnMjRKCK80bvW9uq+iclo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707586295; c=relaxed/simple;
	bh=cNkEp1+yCKCRM9hGf2r03El4twu0vqiZPKfcQX0W4Og=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IhpMNeLUT1JdIA2jnlio1T2CoZE5eOHsAyYojNfiDSGkcp5b73hS7IJIZgfvbAtOTrGmJH8OB8SNFIJ1n7R76zrHj8Kv7u6PENXQ+QJ5dZPgBXmLOSuIw51P7H7TUcMLL3t4Zkcvc6EayY0yy9ZbMpTnT9v9W779Ks4O1in33Do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=NIP5Xfj3; arc=none smtp.client-ip=173.228.157.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="NIP5Xfj3"
Received: from pb-sasl-trial20.pobox.com (localhost.local [127.0.0.1])
	by pb-sasl-trial20.pobox.com (Postfix) with ESMTP id 0B5CC24D22;
	Sat, 10 Feb 2024 12:22:02 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=9C9nBFqcV+RZKROX3KvwOIkmnZU=; b=NIP5Xf
	j3VRk3rN/UJ1sSNkZ6S0rbCTOEhcfXApoijJmC0ktvNRDAt0za4DZLUelbtqoQ4X
	gRo4iFURL3/lERSfJiMc+FVTqJS57KAqWOyjF3ig9v/iZzhVPxwEN/uzFoXmiDT4
	tdk3HM+iQFoVFikExnkxHitIXEoHpQoo1RuYY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; q=dns; s=sasl; b=FOrEqbVTBlu58Jegpdv2h3y3MvCGuXUf
	KZUfGWE5N/8Xe/JAZnDqtfUtIvNzuYw5hYwC7o3c3YzGS2UhMardhvx5Xr6RGh0l
	kI/pJcsRnCU6LmrNghePovqMlrXNDnRWp+rsPbjXy1DuuUf7b/nr3/eOFbCxdhSZ
	HsHvFEDClWU=
Received: from pb-smtp20.sea.icgroup.com (pb-smtp20.pobox.com [10.110.30.20])
	by pb-sasl-trial20.pobox.com (Postfix) with ESMTP id F1DF524D21;
	Sat, 10 Feb 2024 12:22:01 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id F349124EBB;
	Sat, 10 Feb 2024 12:21:58 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jiang Xin <worldhello.net@gmail.com>
Cc: Git List <git@vger.kernel.org>,  Git l10n discussion group
 <git-l10n@googlegroups.com>,  Alexander Shopov <ash@kambanaria.org>,
  Jordi Mas <jmas@softcatala.org>,  Ralf Thielow <ralf.thielow@gmail.com>,
  Jimmy Angelakos <vyruss@hellug.gr>,  Christopher =?utf-8?Q?D=C3=ADaz?=
 <christopher.diaz.riv@gmail.com>,  =?utf-8?Q?Jean-No=C3=ABl?= Avila
 <jn.avila@free.fr>,
  Bagas Sanjaya <bagasdotme@gmail.com>,  Alessandro Menti
 <alessandro.menti@alessandromenti.it>,  Gwan-gyeong Mun
 <elongbug@gmail.com>,  Arusekk <arek_koz@o2.pl>,  Daniel Santos
 <dacs.git@brilhante.top>,  Dimitriy Ryazantcev <DJm00n@mail.ru>,  Peter
 Krefting <peter@softwolves.pp.se>,  Emir SARI <bitigchi@me.com>,  Arkadii
 Yakovets <ark@cho.red>,  =?utf-8?B?VHLhuqduIE5n4buNYyBRdcOibg==?=
 <vnwildman@gmail.com>,  Teng Long
 <dyroneteng@gmail.com>,  Yi-Jyun Pan <pan93412@gmail.com>,  Patrick
 Steinhardt <ps@pks.im>
Subject: Re: [L10N] Kickoff for Git 2.44.0 round #1
In-Reply-To: <20240210104321.3303-1-worldhello.net@gmail.com> (Jiang Xin's
	message of "Sat, 10 Feb 2024 18:43:21 +0800")
References: <20240210104321.3303-1-worldhello.net@gmail.com>
Date: Sat, 10 Feb 2024 09:21:57 -0800
Message-ID: <xmqqjzncb5fu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 E59475E2-C838-11EE-A005-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Jiang Xin <worldhello.net@gmail.com> writes:

> Git v2.44.0-rc0 has been released, and it's time to start new round of
> git l10n.  This time there are 52 updated messages need to be translated
> since last release. Please send your pull request to the l10n coordinator's
> repository below before this update window closes on Sun, 18 Feb 2024. 

Thanks.
