Received: from mail-24421.protonmail.ch (mail-24421.protonmail.ch [109.224.244.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0ED421FF4D
	for <git@vger.kernel.org>; Mon,  4 Aug 2025 15:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754322792; cv=none; b=a51RYIGXM01vKwnXVidqgLWofP35j/s0dChNnXj8vPu04BY5CN9S3vdk3BxrxOJr1fSfeQz1SNQFZoX01mqfYCuLOZtl8QupytnMLQB3Qf0e3KN+NfzriIPUv5b4w+LBRnXLthQ2HqPhfMzb1vqpsWZDenyZAtoGD6eX/OSUu/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754322792; c=relaxed/simple;
	bh=iUMKx6Q7mGxrsPRrJqqE605YcBmLW4pU6Zl7QyC/g+I=;
	h=Date:To:From:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IQvvRHz9WQNa+Tu9+f3wWUSM3maJI2WOccwVo2dfL32xf7T5ijRovyciJ1N3LYJZQ0aMSVnNJTt1NH8TDnZZseJDLvq3sp8MoNxsXQCV/WBMI4meBoFOKZouvdU+PA296OkvbBznS/7uSrgiZtC5dleKGeDPgU1XX8GOwFl/VJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fmorschel.dev; spf=pass smtp.mailfrom=fmorschel.dev; dkim=pass (2048-bit key) header.d=fmorschel.dev header.i=@fmorschel.dev header.b=kzMAB+8c; arc=none smtp.client-ip=109.224.244.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fmorschel.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fmorschel.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fmorschel.dev header.i=@fmorschel.dev header.b="kzMAB+8c"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fmorschel.dev;
	s=protonmail2; t=1754322786; x=1754581986;
	bh=dkd+2jaNSpruL3iz85Cllxv3gQ0nIl7/uOjQFkfN0Fs=;
	h=Date:To:From:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=kzMAB+8cf82MIXe6FUgzI7AkuxSpIOZByjRggdso89LHaKtjtUfu6kLVciq/6C0sW
	 OUuO/lvFU7WFNfrmlmioQRuEst8LwO+R+YHyb+pknNTlrYahcDDlLO9MAu2M1/NmyQ
	 +DbDuD18UsP3ivR1fbPm2s3kW4yug86M8XxJDPECncqFR98u8ao04deEJYILp2gEHP
	 pBftbMKdMMc2hUqxCMWHcEU56kcbJVRZCaQJNYRyh2p3ys6H6sNt/HDcnxjw1cHLfT
	 p37k0thVuD7cHVZQA2x3V0ldbeQ7L426KJLih0V1LGQYwWJAtP+JdTHM4EgWdWjrQ1
	 3Nfz3oCYUJLzA==
Date: Mon, 04 Aug 2025 15:53:03 +0000
To: git@vger.kernel.org
From: FMorschel <git@fmorschel.dev>
Subject: Re: Feature Request: git mv --after (new flag)
Message-ID: <917aa62f-5f2a-40d7-8fa5-f19a14926241@fmorschel.dev>
In-Reply-To: <hi7t3qk7difgzip7syscarnf5ui5avnhmjxil4vzurwcfo7a6x@drccf7gibn72>
References: <1fa7a8d8-3ae5-4913-b3b5-21d8f67e567d@fmorschel.dev> <0afc01b2-11a2-4f77-a858-7a444e8bb1d4@fmorschel.dev> <2f505f75-112a-4b71-bb05-ea0cb7731cd7@fmorschel.dev> <hi7t3qk7difgzip7syscarnf5ui5avnhmjxil4vzurwcfo7a6x@drccf7gibn72>
Feedback-ID: 127627349:user:proton
X-Pm-Message-ID: 09be017bcc810c61909d8212026ac08ae018da18
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Wow, this seems to me a really weird design choice.

Do you have any insight on to why is this?

And do you have any idea if this behaviour is tracked to change=20
somewhere? Maybe by project config? Like, one project could opt-in for=20
an actual "rename" history.

On 04/08/2025 12:02, Konstantin Khomoutov wrote:
> On Mon, Aug 04, 2025 at 02:05:32PM +0000, FMorschel wrote:
>
>> This is a request to add an =E2=80=93after mode to git mv command to exp=
licitly
>> mark a filesystem rename after it has occurred (analogous to mercurial
>> =3D> hg mv =E2=80=93after).
>>
>> This would allow IDE/Language refactor renames/moves and would make sure
>> git still detects the moves correctly for keeping the correct commit
>> history.
> Git does not track renames in the commits in creates, so, basically, if y=
ou
> have a file foo.txt under the Git's control, and do
>
>    $ git mv foo.txt bar.txt
>    $ git commit
>
> The recorded commit will reference a tree object which will - compared
> to the tree object of the preceding commit - have an entry for bar.txt
> and not have an entry for foo.txt.
>
> Hence a command like "git mv --after", if implemented, would be a pure
> syntactic sugar for "git rm <old_name> && git add <new_name>".
>

