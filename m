Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3761D1946B
	for <git@vger.kernel.org>; Fri, 23 Feb 2024 08:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708677231; cv=none; b=hcriY7vpU4N96TxwPWzqTVcA9JFByT+c6Rm9qDprp9Dyr7Ydanp4LV2FD/GwfHyzutekyVl1295wTZr5WUcOlCG3PEF+NselEnOy3gAOaDkIwNnSQf870AAP0A66eFDG/1VVI7dRDtgiSYfxW6QA1mO+gzM2402etVSD9z+1Sh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708677231; c=relaxed/simple;
	bh=vetnRTFHmCEicz/qmgTFgS6uk3AQEf+izxD1rXi5f+s=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=PTQS81/1q1ZilAuV+G6lR3TA4p0ofmsHcpRoxopgxxkjEZIwOFfLMr4wCyGGF64jBqByhxEy/qz+W8mHOoohbffKG8Wcq37H2nqySskyHZVd/HLHQ2UfEToyG8CGt9sGraN2YKeCbWO4K0duGD42heAAM59M2cfC9xvq/0EnswE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=LrwRMip1; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="LrwRMip1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1708677220; x=1709282020; i=johannes.schindelin@gmx.de;
	bh=vetnRTFHmCEicz/qmgTFgS6uk3AQEf+izxD1rXi5f+s=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:
	 References;
	b=LrwRMip1TKNVe5WYbBAFKo1wNbdP+/Tz6ENZhQVP+rROOipV8zvCMEtPmmnQWKwY
	 yvbKuwk+HurkX4q1BpED6ZoLbqXM0be/4dR5821AyQ9qXfVa9U4ygOmVJ5HdSPsSt
	 FBRhEEdbge70RgjlQ21oY+4wPWEDV3Wu7WeT3TUpAFI7LXjG+0TmQXC2Sg17c5+yI
	 /dOX7YVeOD3xHYDDU9zHaEA202S64UvZS51tIsmANKkjxGfxZXRYIRbC4WLRGre+H
	 k5xJr1JBjJZYZk/JpxCVqG5zdYvDXocZDpYR1rxUtzg6Dquva9+Bctr05pqseTXcD
	 I+4Gf00g8xxUcHxsjQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([89.1.212.33]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MmlT2-1rErg208V4-00jrxT; Fri, 23
 Feb 2024 09:33:40 +0100
Date: Fri, 23 Feb 2024 09:33:38 +0100 (CET)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
cc: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>, 
    git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>, 
    Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 4/5] Always check `parse_tree*()`'s return value
In-Reply-To: <xmqqplwoe5yv.fsf@gitster.g>
Message-ID: <883087b8-b013-7b30-5485-719a1c310608@gmx.de>
References: <pull.1651.v2.git.1707324461.gitgitgadget@gmail.com> <pull.1651.v3.git.1708612605.gitgitgadget@gmail.com> <9e4dc94ef036882c3ce27208ca9fa545d018f199.1708612605.git.gitgitgadget@gmail.com> <xmqqplwoe5yv.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1469773583-1708677220=:518"
X-Provags-ID: V03:K1:J+iYrZcRhfGHElS5DQ6Cm0mel/VjYwJsoV9P1z6USSF0dSFH9rm
 9uIbRFu7BPb8Vn1PLO3QCGW/8LvSlKRDDoaO8sn3RUyemy1ENyj1HjZ6AnshV9WaVrsa8yQ
 QHVci9dDLEEUWTP5+ESMEGmGs7KyTICiJXw4Hff12NjqLKmwij1oPfFoeJb3UBuyZW/wCOA
 wAbfs4Y4pI8mGGfLShrxw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:CnIEG+e4HaQ=;VTuMnNqL4Z+ifglyjvOQP03hWtO
 fdI06FT4NAbgECyffvl4QAQz0zX4HqlUPZ0W3SWZ99HEwiQIf9Qv2r/YD16JSSyJKl0JZx56M
 ej0VREoxkSShq3k2Zz5ZrnLhJorFOyZSlqJLYDszfUTlQbdhWB310iCy3PJM4IlK5YTp58cSB
 nsqs2E3BgtJvmaQs4/fWF0J7xlaUOTz4R3okEPQq+x1YM+WdUmcnc/xQaXeuZ4Y0BXt05dng8
 VBDctTWbyDwmPsrnxqIkau5vbD+z9HF3z/Telc9zYfZMMT70rvIGSvysieJep4NWNh2TGAOMm
 TV+maaqCLKTjmtqK8BMqc3Maz+TMnyDIlRobYU5on4Y36I1uZnz3nl1kgVpz9FrkDEFn8CLlh
 mVu2PPbO4pzqrl/CyC6Op987S3GQd4On/Prg3gnm6X+lcTOpzNtvzmP0N/q1OBiUJebSnIsyw
 TmqhUXbYlgR3h5LT23YyoBDSidEn9lEp2ej7lkA0Qmo7xnH8HSLHIhVdFrHQDbYAQLdT0D3fo
 pMjYquhBRKsrtErpRi/aIaXqjE4NBHix82nNKvOUZ21+T3lxX+bQXCEY4jvaZhGsGmSAmtDDW
 aRwQ48jljDpyjR/B/aD83Bg8K4NDASNraFVCSUsdBfLYzzTpQuUvbv+e5Gg7H6/R4obaUM518
 33OtMc3rLIdIgvBW+eJmceiL7of0bOkFQT+ChdRpNBG/5AOBP0YE4oOne2YhOAjzioOuRpnOh
 5VUR3maTXXPko3do+O7khiS21dWTUN9IQkjyjJsHSSz0RaqpOjVHdYCYG/QtOoEs6ThGGYuF6
 rabz5vkThszv+XdnjTBrDd6qcykzKkiTqFZIkfPV3pbPI=

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1469773583-1708677220=:518
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Junio,

thank you so much for reviewing!

On Thu, 22 Feb 2024, Junio C Hamano wrote:

> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
>
> > +	} else {
> >  		new_tree =3D repo_get_commit_tree(the_repository,
> >  						new_branch_info->commit);
> > +		if (!new_tree)
> > +			return error(_("unable to read tree %s"),
> > +				     oid_to_hex(&new_branch_info->commit->object.oid));
>
> We can help translators by enclosing %s inside a pair of parentheses.
>
>     $ git grep -h 'msgid .*unable to read tree' po | sort | uniq -c
>      18 msgid "unable to read tree (%s)"

Right. I had used

  $ git grep 'unable to read tree .*%s' | sed -n 's/.*_("\([^"]*\).*/\1/p'=
 | sort | uniq -c
       11 unable to read tree %s
        3 unable to read tree (%s)

only to realize that the 11 were the ones I added.=F0=9F=A4=A6 Re-running =
the same
command on v2.43.0 reports only the 3 parenthesized ones.

I've fixed those error messages in v4, and also added a patch to adjust
the one error message that I imitated (and to mark it for translation).
This patch might be slightly controversial because, in what is probably
only a hypothetical scenario, users might have scripted around `git
bisect` to parse error messages _and_ special-cased the "unable to read
tree" message to be able to deal with the missing tree in a programmatical
manner. I might be misjudging the likelihood for something like that, but
I vividly remember the, ahem, "exciting times" I had after 7560f547e61
(treewide: correct several "up-to-date" to "up to date", 2017-08-23). If
that patch is too concerning, I am open to dropping it.

Ciao,
Johannes

--8323328-1469773583-1708677220=:518--
