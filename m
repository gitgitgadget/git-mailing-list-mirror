Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1D06282F21
	for <git@vger.kernel.org>; Sat, 18 Jul 2026 06:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784356548; cv=none; b=iwUoK3pW7f4UypA1HlQG6oJauxPKWuRoBgJBUOSSolLgKnXw/kuUsyFVOnpLCn9fMqymxx4tcbNGeaYh0V0uy2xVQgBfKmP5+zaB30HS75XaJ20GneH1jEHi9luHCazGlXsUxdoHxxcmVSc3KKhnetOvQd3tzRV08c/qLpr3T/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784356548; c=relaxed/simple;
	bh=39SFLNMaZkdHKnmzlV7GbtHtObhRCf+uEViDGlo22oc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SjcQRNWXsvuvpLsziMbw3d7hbRHouSSdxowJpHiI4DgQG2HSiLNH+6NbD9bU3Cfemy3HQMp+9WjaEyBTrKrBwt3u9TVT1ML8Hf49kHl8ljpN9ccCOZfIZ/tJrYXwmtnm/kMlI7kmHhVAwwkSki/cfHuUXDmCrarKncW6gWi29Io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=fRldVh7i; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="fRldVh7i"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1784356537; x=1784961337; i=l.s.r@web.de;
	bh=Xv6fOQnYfLG5MRCB32gBDVzdkuO4pbgtnPiiadZv0RI=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=fRldVh7i7/lcPKIW1r/6nhcHXoKgSRIwfxPdDP2PzjBo/4/P3QyTj07kCQs3qnT7
	 XJAIxT8Vkrtk5e4AGpIQCTgfZouGluvkGv3vbutpGWoj4FohaydbnA51LknHS77+n
	 DBsHEi51aVodKpMpU7e+9r4sIaUf5MeBHA80IGbPTuioZRGYf4ddQaOGd3Bq2yeXn
	 luvd2UiBK78x3rpNO7XLqXtOIv9q6GvDO/16vaAvEiWWkeuw0TsaiRZlsSxlOXWPr
	 U/cQA/MlouVDOLdsW0LPwhFMpW8XlCI/993AbezP4dAgHA91WwFUxae6fHtT7xqXV
	 03wcF3q/EiqJCSI15A==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MmQcl-1xSs6S3jjV-00bxyu; Sat, 18
 Jul 2026 08:35:37 +0200
Message-ID: <3c0a8031-7082-422a-b474-938418682b60@web.de>
Date: Sat, 18 Jul 2026 08:35:37 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] use repo_hold_lock_file_for_update{,_mode,_timeout}()
 with custom repos
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
References: <20260714175956.54601-1-l.s.r@web.de>
 <20260714175956.54601-6-l.s.r@web.de> <aldYW4TPUqgDMRcf@pks.im>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <aldYW4TPUqgDMRcf@pks.im>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:kwLJJavr84eviDx418bTYNQCmImR70ifaE/nHKcQWewsMYoPHgB
 EBzqhufvRbu1npA6+FUN4hQNFKoRpEx7sNzh7E8gTgVnAy+dj5Wpun1wGv6TTsvj/yjruYe
 Fk9Va+8ss3SJwE1+g35eD88YfuW5GY/OMcWvDCmrMSlgIHgZ6IZnamWG3spuks8FfO7qieQ
 KZwP8zjACNfq9gdXQUBeA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:xttGRnp3eMk=;06+rzaJRGP1MfrGooJ+UT/pRvwG
 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

On 7/15/26 11:52 AM, Patrick Steinhardt wrote:
> On Tue, Jul 14, 2026 at 07:59:56PM +0200, Ren=C3=A9 Scharfe wrote:
>> Apply the config setting core.sharedRepository from the repository at
>> hand instead of from the_repository.
>=20
> We only do this for a subset of callsites, apparently. How did you
> select which subsystems to convert and which not to? To make this
> explicit: I don't mind a partial migration, but I think the commit
> message should briefly explain the reasoning behind it.

All those that have a repository reference other than the_repository.

> Also, as you don't get rid of the old functions that still implicitly
> depend on `the_repository`, I think we should have an additional commit
> on top that guards all functions that have this implicit dependency with
> `USE_THE_REPOSITORY_VARIABLE`. This ensures that we cannot accidentally
> call such functions from other subsystems that already got rid of the
> global dependency.
Probably, but the lockfile conversions deserve their own patch series.
Patch 5 is only included here because it was easy to write.  We can drop
it and leave the low-hanging fruit on the tree if that's preferable.

Ren=C3=A9


