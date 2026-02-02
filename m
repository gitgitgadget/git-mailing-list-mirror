Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E04E27F005
	for <git@vger.kernel.org>; Mon,  2 Feb 2026 16:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770049492; cv=none; b=Bwv/BuU8u6ASPjSmi8WcrvlMRiuV7S6XDlCWubKQYD27QIgyNDxiwajAIZRPNamO6dl5hkJVX0vN5X9fpIgm0bn0NS5/8XyFHGAfTyvH0yclxR3ypBNYSMY2IVZCN2Z+hXpKkg8yZwkjOFqEwOfaI4XwGA4S3UpVn2RezDB85U0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770049492; c=relaxed/simple;
	bh=FlxaOnvYi+vVFwtf4i3clTHO+IfAL5vf0bJ5+X9EfZc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VO9uOmW9CSlgj0gMdhqqzELQNwi3/j7ENMc2JvQ2BFUQPTz91olqxDe0hUFVXVj6wt1vcjakLIAHnE3Eh3Ka4dZqfRe3jvpVdxc+2j4JVODPZH/krz6AyaxRAZO/jmH0vWqqVRXYHXSR9PHkb0FgfmSQ9dT6hOx6TTHRgqbWpJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=gKNdG+WG; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="gKNdG+WG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1770049486; x=1770654286; i=l.s.r@web.de;
	bh=CB0fiJdJV7nCP7foKzW54jTsJSmjaafkEYWjmXJjSRg=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=gKNdG+WGlZa90amzXY3jtf+Q2RglZS8etfYgi7UqGdcJ46jpheowbDBPi2rAG12k
	 q6nlh4OLPchgkAnjZMK7QoUi+RXrL0n8gTB/QWGW1FEj2cuD+v0fkBUcD6WQ6f7dn
	 tYbhRFlyFkz5Vn5B86ShCbK1g/dE9lvQ6audXSWdgmcxMD/fvBiCJQNch4am+HW9Q
	 YhLBZWlLH6mHeQKUgR9OU2jF+AIVohoU0ScTYUn96rL8gWaAMgktO77ub0KB2fxMb
	 w69DZg3rTUqfhOVpPFFn+YAlDBV/7YRyV+o1DpXL4A3VxMt+Z3L3sIOjotw3f6wmb
	 6tmaMg/Rv+YFsf6wAg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.2.31] ([79.203.22.157]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MKMA7-1w8aJO42tL-00LqIt; Mon, 02
 Feb 2026 17:24:46 +0100
Message-ID: <62e3ab10-bfa4-4ec7-9838-0bad89d04edd@web.de>
Date: Mon, 2 Feb 2026 17:24:45 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] blame: fix coloring for repeated suspects
To: Junio C Hamano <gitster@pobox.com>
Cc: Seth McDonald <sethmcmail@pm.me>, git@vger.kernel.org
References: <aX8BjoOGPIytGXjD@McDaDebianPC>
 <28ac1ee6-f3e9-4789-92b7-903788430697@web.de> <xmqqfr7j2u6q.fsf@gitster.g>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <xmqqfr7j2u6q.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:fBcXVDmxhckomYzfRr75g14uH4JEyxW7cNyE87CAA7ywmYi9oXS
 Mc44efhsd26K2qNOF+T9PrSPxzPSnGEvt6cLkjIK5Sn8eOE4F6ZYP+QRzMnVssE4TsXKyeM
 YDIKT+Fxy6NYFqmZmDSFx8Qt1mAd+AcEElLYPNp5Pnc8vCyni8AjWIvYrijVylpSHeKF3Y4
 dBQP3kjVG8ac2YfdJ84kg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:lxoRplJsvg4=;ttQgTr0CwgLhEdJ+3hkuPuRX928
 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

On 2/2/26 1:42 PM, Junio C Hamano wrote:
> Ren=C3=A9 Scharfe <l.s.r@web.de> writes:
>=20
>> The option --ignore-rev passes the blame to an older commit.  This can
>> cause adjacent scoreboard entries to blame the same commit.  Currently
>> we only look a the present entry when determining whether a line needs
>=20
> "look at"?

Yes.

>> to be colored for --color-lines.  Check the previous entry as well.
>=20
> While this should work, I am kind of surprised that this has to done
> as a sepecial case.  It often happens that two adjacent blocks may
> be originally pass their blames to different parents of a merge, but
> then the blame passes down through both branches down to the same
> ancestor, at which point these two blocks need to be merged back
> into the same source again, and I was hoping that a helper function
> for it would be called to take care of this case as well.
Do you mean blame_coalesce()?  It is called, but won't merge entries
that are not ignored with those that are.  And we do need to keep them
separate for blame.markignoredlines to work.

Ren=C3=A9

