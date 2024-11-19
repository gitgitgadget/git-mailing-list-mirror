Received: from aib29agh126.zrh1.oracleemaildelivery.com (aib29agh126.zrh1.oracleemaildelivery.com [192.29.178.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E69D61C1F1B
	for <git@vger.kernel.org>; Tue, 19 Nov 2024 11:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.29.178.126
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732015704; cv=none; b=JDNgUIr7+NsUnMQZNhEPGd88jRGTk425tK7CP0CwvNe57lPbkJI5M7b+SLskz1KolY8+KiwvuoDqG3LhVcJOGlMvOADNUs4nA3wjN5MkQs7aob8yE8peT/EoC98yFa44MBdECzME5w6tP1ZgVLKOGqtvE8rNiR8aKoyX2i6cmcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732015704; c=relaxed/simple;
	bh=/BoE1DKufkbmQSiu1JFDygZBt1TuyX1mSD37QoHm9og=;
	h=MIME-version:Content-type:Date:Message-id:Subject:Cc:To:From:
	 References:In-reply-to; b=UrmCojbIHHPPptDuCEMEVyq5n25z96GjDUR+GVqoaY8Asv5YmQFB3MSGWUxS9nnm34lHGeefQ6uTBwpC3BWPnHTOQScvPdaAXArYSuP1AB8VnQ5BLNdiSVmTPU6JKUgPS6ts9L3Rh9oFgQVrHWCLhGAil5Oi0edXA1P3a99Ines=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com; dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b=UGRwGPxE; arc=none smtp.client-ip=192.29.178.126
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b="UGRwGPxE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=prod-zrh-20200406;
 d=zrh1.rp.oracleemaildelivery.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender:List-Unsubscribe:List-Unsubscribe-Post;
 bh=o/fQxAsaboBatxE+HqJFFJI+ln25NWq8ey6VlJIfYTc=;
 b=UGRwGPxEeMvZsZZHs17fnGLTiJqkfJzlb6irqt14f6BxZiL4kXHstIa2smTeNWde3uonlnqCnthc
   k7bLc/2XHNGJMWZwwkkWheVSF8iIWrUPD/7EjVMVBIzRgMiuQa6BypUEbqTOZ8EfbRpdVZL/TYyD
   bB9GxP0jcrGULDy/jpKqxd66ao/og5X1cZYtq48zBEgNatyoO715UXuok23vbPDFqzIy/axpWTlQ
   2Y0iYdKU40HylcCHqx4J1joHbgY9+KBaEe/PG0driHoWkbJArIoqrRAYJ1JCtYHrraKkkMKQJ7ZV
   I6gePIrewd0i4E3IkzhK8PYutUTauGCfIjEj9w==
Received: by omta-ad1-fd3-401-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com
 (Oracle Communications Messaging Server 8.1.0.1.20241024 64bit (built Oct 24
 2024))
 with ESMTPS id <0SN700K033V62PB0@omta-ad1-fd3-401-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com> for
 git@vger.kernel.org; Tue, 19 Nov 2024 11:28:18 +0000 (GMT)
List-Unsubscribe-Post: List-Unsubscribe=One-Click
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-version: 1.0
Content-transfer-encoding: quoted-printable
Content-type: text/plain; charset=UTF-8
Date: Tue, 19 Nov 2024 12:27:25 +0100
Message-id: <D5Q4AYZ9WSPP.3KOENYK0R7XB5@ferdinandy.com>
Subject: Re: [PATCH v13 8/9] fetch: set remote/HEAD if it does not exist
Cc: <git@vger.kernel.org>, <phillip.wood@dunelm.org.uk>,
 =?utf-8?q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
 "Johannes Schindelin" <Johannes.Schindelin@gmx.de>, <karthik.188@gmail.com>,
 "Taylor Blau" <me@ttaylorr.com>, "Patrick Steinhardt" <ps@pks.im>
To: "Junio C Hamano" <gitster@pobox.com>
From: "Bence Ferdinandy" <bence@ferdinandy.com>
References: <20241023153736.257733-1-bence@ferdinandy.com>
 <20241118151755.756265-1-bence@ferdinandy.com>
 <20241118151755.756265-9-bence@ferdinandy.com> <xmqq5xojgbfl.fsf@gitster.g>
In-reply-to: <xmqq5xojgbfl.fsf@gitster.g>
Reporting-Meta:
 AAHIATIbPOwlSPb0c5ZOweDbho4xn0bKSaEvwKHbnE52BfMmbMDm7omK3A7m/rkl
 j8F2Fld+0BvYmV21qPHKpnVpIN+VaAE6vZn50CXGyAD4xsYDC1eVzZ70Snqcud9N
 tK78LHVSTMWFAGAcynsF21zdq81tvQhOZKE18soZqLT8bwNJwIvT1mLej9tVh8AQ
 YKatF/cS21IxFOHu6PszOnuW/qdbHZ83ozaFCI52KKLzzBqCGrNO6hOsZeGXfr4j
 OtsSlBjeblywU3GPMQbYYiOtz8veDnXFbSwic9MVmzzCzdLfFOQcDxJDuJ0zErBi
 TXoEPy2A262g3GPjw0yk6vTEbQLdqiEW2NScJ951Lc73eI0qlhk5zbRRZLooxWq+
 NDi2/9oRJ8p+BcojzPDhzdExDzeggPdNgiTXbTTonoNKpxqoMB2BvVf/VYacot/V
 5L2qVfgHe6jQbNkO5Piv8sKEj71ay+rSzJawxaoIHHFhr4XLbioo+JrL


On Tue Nov 19, 2024 at 04:16, Junio C Hamano <gitster@pobox.com> wrote:
> Bence Ferdinandy <bence@ferdinandy.com> writes:
>
>> If the user has remote/HEAD set already and it looks like it has changed
>> on the server, then print a message, otherwise set it if we can.
>
> The user uses remote/origin/HEAD to point at the "primary thing the
> user is interested in at the remote 'origin'".  "git clone"
> propagates remote's HEAD to local because their HEAD is the opinion
> of the remote which branch they want the users to consider the
> primary thing.  But the user can have valid reasons to consider a
> branch different from what the remote suggests as the primary thing,
> and an explicit "set-head" is a way to do so.
>
> After such a set-up is made and the user is perfectly happy, would
> it make sense to repeatedly remind that their HEAD points at
> something the user is not interested in?
>
> Perhaps it may make sense when given the "--verbose" option, or
> after the first time the difference was noticed, but otherwise, I
> suspect it becomes annoying to those who keep them deliberately
> different from each other.
>
> I wonder if it is more sensible to automate for these two different
> classes of users with a new configuration per remote.

Since this discussion reaches a bit back I looked up the first message wher=
e
the current behaviour was discussed, and where in the end it was said we do=
n't
need configuration (the very first implementation always updated HEAD).
Starting here:

https://lore.kernel.org/git/xmqqseu7cfsl.fsf@gitster.g/

That being said:

Your suggestion seems to be the original tri-state configuration that came =
up
in one of the original discussions. It was recently requested again for fet=
ch
to just do this automatically
(https://lore.kernel.org/git/CAAHKNRGv19rhnqCkJMpE2FomNQBHvSS36aC=3Dfh0UwO+=
9-6RRfA@mail.gmail.com),
so at least some people would like to have this fully automated.

>
>  - When "git clone" initially sets up, or "git remote set-head
>    --auto" matches the local to the remote, we set the new
>    "remote.$name.autoUpdateHEAD" configuration variable to true.

I think this is a good default. -> Coming back here I think "warn" is a bet=
ter
default see below.

>
>  - When "git remote set-head" explicitly sets remote/$name/HEAD
>    to some value (if we can detect the case where it is different
>    from what the remote has, that would be a plus, but it incurrs
>    network traffic, so care must be taken to design this part), we
>    drop the "remote.$name.autoUpdateHEAD" configuration variable,
>    if and only if it is set to true.

I also agree with this. I don't think it would be necessary to do a network
check at this point. If somebody is deliberately changing the remote head
manually, they are probably aware of the current situation and can always s=
et
their configuration to "warn" if they care, or just check manually once in
a while. At least I feel needing network connection to do this would be mor=
e
a hindrance than useful.

>
>  - When remote.$name.autoUpdateHEAD configuration is true, "git
>    fetch" automatically matches remote/$name/HEAD to what the HEAD
>    at the remote points at.  If remote.$name.autoUpdateHEAD is set
>    to some other value (e.g., "warn"), show the warning so that the
>    user can choose to do "git remote set-head" to a specific value
>    (which would not drop the remote.$name.autoUpdateHEAD set to
>    "warn") or "git remote set-head --auto" (which would start to
>    follow whatever remote uses).

Make sense.=20

One thing you haven't mentioned is when you start locally with git init && =
git
remote add && git fetch. But since this whole series started by wanting to =
make
this the same as cloning I assume it should be "true" as well. In fact, if =
the
default behaviour is true this would just work.=20

On the other hand: considering your points in the linked very early discuss=
ion,
maybe "warn" would be a better default? I'm not sure. Most people would not=
 see
warnings anyway since I doubt a) many users change their remote/HEAD manual=
ly
or b) many projects change their HEAD at all or if they do, more than once.
Gaving "true" as default would change the current behaviour with silently
updating existing remote/HEADs. The warning could also tell them that `remo=
te
set-head --auto` will set this to automatic in the future as well and thus
remove any warnings or that if they know what they want the can set it to f=
alse.

>
> With something like the above, those who just want to follow along
> would get remote.$name.autoUpdateHEAD=3Dtrue and silently follow
> along, while those who want to explicitly control would be able to
> do so.  I dunno, but I am fairly negative on a persistent warning
> message that tells the user that the only normal case is to have
> remote/origin/HEAD point at the same branch the remote's HEAD points
> at.

Fair point.

This series has a tendency for growing in complication in each iteration :)

Best,
Bence

