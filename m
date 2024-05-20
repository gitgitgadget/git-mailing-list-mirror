Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72CC6134CC
	for <git@vger.kernel.org>; Mon, 20 May 2024 19:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716232920; cv=none; b=cj4fRx/PMikS3/lVmhJS89GCa///OIxXV8njOJ4Lkj1HN+OZB4AqdbMPWeWmek/JHzfCFYXDPviZblT9Hle+jb5wu+ATGxxMpnAknHJ8KtlYpASUey4v97e7+E8ASdkea8vLdK3mw0gblfrObXtD+4azBxruJrlUFRAsfMD9X44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716232920; c=relaxed/simple;
	bh=2TazSG9Ff5a21IOeZ6wBHemx9yfUDLbROR2s9c9Rzdk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BKjC//uAcbrEB5rJlDSQnZautySnRHQeLKhRhxHdblRLDKr/D3LYoZbs1pBl0WXEhvE08OEJlSFyeMJMboBxeRuNWockkWO/YF0/Krp0X+qantrEPqiBb3bX/fwp4onuWel06N9YdVSpBU8RAfvuRz4AriAAOIC0Pr9yywiCGNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=tboegi@web.de header.b=NL8jzCjJ; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=tboegi@web.de header.b="NL8jzCjJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1716232906; x=1716837706; i=tboegi@web.de;
	bh=J+Yo9d/a9t45/P+FBIqw1qVzRNMLhemG+453n1BNbMg=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=NL8jzCjJuBv4uoFEESonukG48LZ6CMuReaSLjlBjsa1KgcqBv91l1KG8wTnwhqx+
	 5nS3FmEyGKEadXGmhFLlwHpJ19bo9SZBsszPg1qvt/eym2VJM5H6OFX3d5Irgqzf7
	 ury6b/rBORhJN0W7evGveGbDaQ3Q+ODWUZzCK7T2aEqJgtXMzwik/r4AXGp/TV+/l
	 D/05kXE0lPPNio+vfHqxbiqMw2fM9qZl0cMSy1+FjKZDPqIOt2O/AQkmWdJ+zNPU3
	 ca9u7INWdjKvWyCuBOEbzteSQmakn88j9SPiZUQqAREO6vm19cTrYo2RDrkbXPzuq
	 0mKsCYnL0BlZc1yLaw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from localhost ([213.65.201.17]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MECCP-1sIjV91gMn-00AMxf; Mon, 20
 May 2024 21:21:46 +0200
Date: Mon, 20 May 2024 21:21:44 +0200
From: Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To: Junio C Hamano <gitster@pobox.com>
Cc: "Jun. T" <takimoto-j@kba.biglobe.ne.jp>, git@vger.kernel.org
Subject: Re: [PATCH v2 1/1] macOS: ls-files path fails if path of workdir is
 NFD
Message-ID: <20240520192144.GA4111@tb-raspi4>
References: <20240430032717281.IXLP.121462.mail.biglobe.ne.jp@biglobe.ne.jp>
 <20240509161110.12121-1-tboegi@web.de>
 <98AD4B35-ECE2-4349-AEA9-86F5CA52EA9B@kba.biglobe.ne.jp>
 <20240520160601.GA29154@tb-raspi4>
 <xmqqikz8gxuc.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <xmqqikz8gxuc.fsf@gitster.g>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Provags-ID: V03:K1:QZRQ0wWZPu89HZyFB0eqgQhXIX4hIbGM4ROm7Y8Lc27MGgwzfzJ
 EH6zAY1vhfy8oykl9wMJBXw9GWGYx/QIMA8rFVXzyQKK+xAq/t/2CoS0fHCP165jV2TomiV
 N04DSxM+KubD8QNxVdTGYUm5w93hoNO7/fdN57VrR99OI3B4Xp7L403xXo7QTV+J9DIYjO3
 t96mjbTOfHo1WW0hHKY+Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:vZ23e/8jdls=;/sZXIMT7BHOneXOwf58ibreFWha
 MgBbqyj8cKQP+caJa9tAxe6be/zpdg5W1H8wFWZS8EVYYPPqjwJYJq1WBAI+uCc3AkzgSxtRd
 OGHVifdgpqjUAmp3nxwDm+SMKfIdSgeQr7QQhTmMdkGimQpWmub/r5WfLXqo7OcFa685ixEmg
 RUgkF+WFQ6tX+9uHJLDslKxi94JHUAZGEr5HxjSskP5589Qi1k3otx8AVwTno28UkCKyLQw+e
 Q70CoifeOyXx9dZJ5gs4dlgMQQx1LX0lWmj5M11DRbL8rdLr+KwldRU7tp2OkGNXAK7ZBwDcq
 4l4uTL91E+QX6IgTIqdFkxaLilA0RfDJJKb0HALTki9XvJtmS89GtclLu59EaDnu/PcQ1AUGw
 mf5/96yWS6D+EcIHXRSsRhOvbFzobAFbZ9r5lGmHJMSQeVpk5cHTeawottdKPezgcYmGX5nL4
 aWn8WF71x9MvXo5ONo0b+LEGwgZMeap3ENaV8wI2wx8figbvL5LGc8/ID/jJ04sOc6IeMhyWJ
 NkPir8vdnqZAZxgPvNjwNrwezL+asV3PN2DOaQG6H0TyKkZHK0TXNJlsA4Cpc9LFPYyR4WqmJ
 QeBVmeHBIOmLCrMqrM3eOWgR8zzxL27n5cvobwU1QU00RoV7Ap76Hvh21PykdbqbHqBc0tdfJ
 B5vRj39tJVrRJBuXu30jeOTvCGfYRWN3pNwJMwWLZRkZUoXDwRRghuzztNFOYQl2q8emBaU8x
 AV383MlSvPoje2HXqqyjA1f6AC+/P0I/awlH81bSN/y205eBOFY385ZF7Jie7TiU+pcoPLMi9
 BNdrrrlymtuVpsaEqKJ7PvuBIp0vHFnu0YucDvMJRtLGk=

On Mon, May 20, 2024 at 11:08:43AM -0700, Junio C Hamano wrote:
> Torsten B=F6gershausen <tboegi@web.de> writes:
>
> > Thanks so much for the detailed analysis, that is appreciated.
> > To be honest, I have set core.precomposeunicode true globally,
> > ...
> > ...
> > I am happy to provide a patch (a new testcase is already there),
> > but for a change in the codebase I would need some help from an expert=
,
> > to get the config-reading right both for hash_initialized
> > (that is may be not about the hash-algorithn at all ?)
> > and precompose.
>
> It does not sound like an issue with the hash algorithm.
>
> Why isn't the local config (presumably set with auto-probing when
> the repository was initialized) being read?

I have the same question, kind of. The callstack provided does give some
hints, but I was lost...


> Are we reading the core.precomposeunicode in some funny ways?
Not what I am aware of. But the order of initialization, when a git comman=
d
is executed, some need a worktree or .git directory, some not, is somewhat
beyond my yet expertise.

>Is per-worktree config  involved that is trying to read from one but the =
auto-probing code
> is setting it to another, or something silly like that?
No, not to my understanding.
We have a "local" config (per repo), that is there and has the right value=
.
However, for some reason we miss to read the repo-config here,
when argv[] needs to be precomposed.
Reading the global config does work, but if core.precomposeunicode is
not set here, but set in the repo-config, we miss that.

>
> Thanks for working well together, both of you.
Yes, please let someone join the force, reading the callstack(s) and
try to find what is wrong here. I will try to do the same.
