Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0634E42A792
	for <git@vger.kernel.org>; Sat, 26 Sep 2026 10:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790419916; cv=none; b=JrlMufZwkGZiB05jgBRttkgqWkcdMXuh27tQLvsYB3uqbXkjjeWXC4K2STVDHdv6Uq3loEU6IQBnSFJn06Hz32xxoKOiU4edFkewfoOFInjYPkYnI0ERGtv3wTfgf9cNiUYIhL/P1zPr+x04YPBAppckpfTMogRgemEGfWuuiWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790419916; c=relaxed/simple;
	bh=v8/Tw9HhseN2Gq1XL2uKpWbwOBrFSxZd/suJ4+/pvnw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HCPcJYuvIUNXIxD45gUB289IsuyK990EWZTqRKOY+gXsZcwmcOFwhHv8TOMwJ0MLwrjtZYK/s1R932HlU1Ybg2I9Vb86KKUM7O08Qi5bk578BBbZPgKRb/oxT9ZZYeDOm220EP7bzomyRw7gjG7XUUx3XGKHKi1kqb306JOaDuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=kC9TQ29q; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="kC9TQ29q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1790419891; x=1791024691; i=l.s.r@web.de;
	bh=/D3oGAB2TRrQxViUXunFTwLGwzp+T+CCnwuTBO5lY3Y=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=kC9TQ29qu0I5N+XQ7FjFBomdUVkoHRbGJMtPFpM62Oal/X11QdZs62aAoP4dAYt/
	 sTasVGvE1Hwplf/8F4V9KB5E8lgBzU+kPI2XhmPVTjTYcX7JfZwqdNlloBWS8YL5Y
	 1YaGBe+cPCkUwMz8sgTV0dr4FGwCZTj4/K3pi8CN8RkNna0ubdgPChrL9U4Qc+mQ3
	 JarQznMR3Z7nuhinJVIAmEendZ5wpMqGWL3x/TP0VBPoae2I7BW7LgV7UnJHqIDvF
	 JfjIekpv6vKeJMAXsihQPLywzAKvJkDX04hO5zC/PnP/i5cpkUuIDAA7xEfAcgBXL
	 Mf9wBl1r1m8DDRquGQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Mtgyj-1wt2FA1jLD-00xSgG; Sat, 26
 Sep 2026 12:51:31 +0200
Message-ID: <78937658-ac31-4ec9-8f8a-ce8fb74ed196@web.de>
Date: Sat, 26 Sep 2026 12:51:30 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dir: skip excluded directory with nested repo on prefix
 match
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, 81625@debbugs.gnu.org,
 Lester Longley <lester@ieee.org>, Sean Whitton <spwhitton@spwhitton.name>,
 Elijah Newren <newren@gmail.com>, =?UTF-8?Q?Martin_=C3=85gren?=
 <martin.agren@gmail.com>
References: <87ld94klhf.fsf@athena.silentflame.com>
 <be53c379-b0e1-4242-8504-e96c2c49d294@web.de> <xmqqjyodj320.fsf@gitster.g>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <xmqqjyodj320.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:LlAMg8V18Kmbqky7RKcACSda4Eh9p/BImMq3kYyHGwiFdXtCTxQ
 32rd24woaNKElS+GV1c1uGCMmQ7nSo4KnPI2MrbogfWbW6bELEuge0uGFp7mw3h7WcQmrvg
 HR2+S1IqEfpuunZiDr0ZRxxrqSfNN6BSE9IsjMFj8Ot03086BS4RjewsTtIl+Ee69DrevSQ
 AlzMsRsIawB9MSAtZuFyA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:cEsZ92XIAKo=;GmJFoG9Yjsi95XLDzDVVa9/VqCH
 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
 Q4gMnRwMY3MXI5yG/+krrf6N/Oy3rUVXR+w==

On 9/22/26 6:57 AM, Junio C Hamano wrote:
> Ren=C3=A9 Scharfe <l.s.r@web.de> writes:
>=20
>> @@ -2034,8 +2040,13 @@ static enum path_treatment treat_directory(struc=
t dir_struct *dir,
>>  		strbuf_release(&sb);
>> =20
>>  		if (nested_repo) {
>> -			if ((dir->flags & DIR_SKIP_NESTED_GIT) ||
>> -				(matches_how =3D=3D MATCHED_RECURSIVELY_LEADING_PATHSPEC))
>> +			if (dir->flags & DIR_SKIP_NESTED_GIT)
>> +				return path_none;
>> +			if (!matches_how)
>> +				matches_how =3D dir_match(istate, pathspec,
>> +							dirname, len);
>> +			if (!matches_how ||
>> +			    matches_how =3D=3D MATCHED_RECURSIVELY_LEADING_PATHSPEC)
>>  				return path_none;
>=20
> Here, we do not know if we have pathspec=3D=3DNULL.  Shouldn't "make
> sure we have a result from dir_match() and return path_none as
> appropriate" be done only when pathspec !=3D NULL or something like
> that, since dir_match() will crash if pathspec is NULL?

Ugh, nasty, that was silly of me.  Thanks for finding this bug!

Ren=C3=A9

