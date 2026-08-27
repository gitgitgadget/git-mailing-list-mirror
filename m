Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD87822A4E9
	for <git@vger.kernel.org>; Thu, 27 Aug 2026 06:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787810917; cv=none; b=r5lJ0JaSDisOrdpzhtkESWDbkE8R2nxWe38/RzdrZsLePHRdE9crpxFT8hYQ1GXkomkm81scVu4XnKUOws0rTj4n/fHnWGfOnDrRu+G32+JT3hI9Nlis+GyETeqdAO+2g0uDRUTIw1Vklq2U/Hm7GgKutWQLG/bsGlsmmDEVqSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787810917; c=relaxed/simple;
	bh=hznz0MKZlIoKGiXwXnzfH8AhO1AOYef72PFsQD10Zh4=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=jCMMqTxSNrDDGpLESD5MjhpEm/M91n/YPkRyR8nG1/19vQPtF5gZ2nsJhu9j5hiR/+lNhpaItAOF0E0LSOS5vvB9gOyh+pXnWI44qawoiIUxemCf5Z+R+PytFJBajduQU4xd3Lk/nd2e5B+hDrRzmfygPoXsSP0LV7JCL4qBcyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=FxjPGvSv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=APVHJzUu; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="FxjPGvSv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="APVHJzUu"
Received: from ams-compute-01.internal (ams-compute-01.internal [10.64.2.61])
	by mailfout.stl.internal (Postfix) with ESMTP id 840C31D00095;
	Thu, 27 Aug 2026 02:08:34 -0400 (EDT)
Received: from ams-imap-15 ([10.64.2.35])
  by ams-compute-01.internal (MEProxy); Thu, 27 Aug 2026 02:08:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1787810913;
	 x=1787897313; bh=JpDCjOC7mEHMGff+I5OjxpDY7iOLYZ3TyXbN6jbgM+8=; b=
	FxjPGvSv3sNVHKtXQaCuRJmeQFfjbPXc8DvtgxMhZwH9DhoPoZ7YcUbQuCA55CNK
	np5DKjkl7a8copOwPCp5THcxy5A+OojXUTGIeRxB+9ZHKr996t1PhFLeu1y1z/a1
	s0Kw6oBpK/ci5G9RQjEGKWZg86VQ8ADhXR+lKSDPRXUJIvcLXc4gPI3f3B3s/lM6
	Z/jDBG4cpm4foF78KoFF1t7uKZDuVn6AMP/ZB/95Kgvw0mE8mZ9emClzs+6De4S5
	vso15rzXympT/s0m3zISOzQjboYyjyQJqgpOwzMaQBF4aNL2NC8Mi2RTTkmQoQFU
	wVB36bYsnSbjJQBb3BThLw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1787810913; x=
	1787897313; bh=JpDCjOC7mEHMGff+I5OjxpDY7iOLYZ3TyXbN6jbgM+8=; b=A
	PVHJzUuHI8J3XHaFEAPxYC/MLPpSXx8i/0+88pxzbPgPJMbfkrhpDUm8KgOJu/l+
	Rg+dagyT52v8nGu1uLSigZfvPjpSALxqEw4gwahkXHmJgW78KBZuCI1Ck/1QCFMl
	DulMKcNtXM+m9wWPboR1zcfGNf+FBCxwU0yEusoesnO1qsrHit8VQ+ugJAT7wBdi
	4oxvcAVoxwNx36I9og77bY1XLjsTnL3zvw2y5le2KScGvqUy3wzrx9Lj2kaD3b3h
	AaLG/X3MjgFFPGAvev+a175ztvXQLGyJ2yMSBhJbLsAd981YESRD80gSO9IPJYb6
	RILFo++txnjQt3er2U4Iw==
X-ME-Sender: <xms:X9SPav4pkwr4bp1S1hyrKz4qtTHbU68KqA64lP1VeIvJLXAnBlCV86c>
    <xme:X9SPavvoGY6Bz60UMtzuA5jIrtQ0d236OXySMk2YJU5gDXkKJ5I6sjxfKsJT74LvD
    eq2VAKrj3xJTicL6mMJVxi3AOuh5ryptlK4M0SYw6I30h2a1ZZcVpw>
X-ME-Proxy-Cause: dmFkZTEc/b3fZhd+ohHNKwPh5ZtXiCjQ+QiYGPVynG8un8DJmOTLdZLTMcrBxdD3ftfhkQ
    3WX3n3IcYnpsjKSBd9r33rWCeol/02xaAfl61uZGArRXpE7bNMaWwJj2Di7AbZ55jeniIE
    cWoRJAgfO1j8UtaYEdfv3MkCzNHjMBJ5BWV+Wdoj41XldV5QfPfwhWytu3emIjwbgg3d/J
    fd2BQjrWOltvuh/XjeQK2hXex2n5r7LEIquAIDgJE+lyxvmT5K/2m08EF7G1mOGJs+a1zf
    xWsl0G5sLLiVbMPKOfK7om5y6q0dQ+4PEXCpD0Q+ThCZIXHlh5ouV9xiQM6x/t/gTgW0lS
    MMHcyv0svIeO/QT2wKSAbnC555rXncRRz3FGuLpeHfh50xi+yPgXaqKd2BMR0H40YcWeTu
    RztfH44LZPExYeblTnNRTe97vbKslTxwuR96U32xHsEpb4PtNFgcVJsDMx2/IVLYmCfjjk
    5k4LFthFSa9preb1c+UFQ4n7S9f2KP3qvXsucaVg9UZan509/+dXDZlfaQ0tH2qcJ6+8va
    PblKZyr20QSTMcDbCbtLwuWwWoJ6mntRQqRswBJ1WC6+ed/CBvhuves7Oqa9GOIU/HdjZy
    eT+e+8hbJgHgByhzuKFm7azDnTcwvYJznWVd7vs6FubaM1DyvgZyUNX053Qw
X-ME-Proxy: <xmx:YNSPaqkMFBg_DDMJOZuuBLDXPaUozNqhhoov-18A8VAyloFvQ-dGcg>
    <xmx:YNSPavyCj6VATmtZboJTO7ozsUGdskriq-w0eeXyW7MMYXa01EzOKg>
    <xmx:YNSPagOr359zZTUQhy7iJ5l_YjO4xq8Z2CUdEqtiVk1dyQr9bWa4tw>
    <xmx:YNSParRtPORHzP5paca9rY9Ujbom5pLz3D-vo1s3w2AhMSm21KNKHA>
    <xmx:YdSPageRM-32K6sskbaJZuO0MXdDND2uhOp4JZ3k1ZUBDq0LZuTT1UKS>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id 6668222C007A; Thu, 27 Aug 2026 02:08:31 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AZTdDQX8qfvR
Date: Thu, 27 Aug 2026 08:08:11 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: edvard.jo@gmail.com
Cc: git@vger.kernel.org
Message-Id: <9dca592c-c683-4cf4-b7c4-e08c338e7582@app.fastmail.com>
In-Reply-To: <779B6ED0-EA2F-4CCE-9616-BFA958DEC560@gmail.com>
References: <03ce12c7-a0c1-43a9-9198-ace60c8ba9a8@app.fastmail.com>
 <779B6ED0-EA2F-4CCE-9616-BFA958DEC560@gmail.com>
Subject: =?UTF-8?Q?Re:_Whatchanged_=E2=80=94i-still-use-this?=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 26, 2026, at 14:12, edvard.jo@gmail.com wrote:
> Hi!=20
>
> Answers inline:
>
>> 26 aug. 2026 kl. 09:47 skrev Kristoffer Haugsbakk <kristofferhaugsbak=
k@fastmail.com>:
>>=20
>> =EF=BB=BFHi
>>=20
>>> On Wed, Aug 26, 2026, at 09:18, edvard.jo@gmail.com wrote:
>>> I was encouraged by git cli to send you an email when using the comm=
and
>>> =E2=80=9Dwhatchanged=E2=80=9D that now needs =E2=80=9D=E2=80=94i-sti=
ll-use-this=E2=80=9D.
>>=20
>> Are you running Git v2.51.0 or something?
> Correct! I wasn=E2=80=99t aware since it was on a server I don=E2=80=99=
t maintain. I=20
> checked version now and it was 2.51.0.
>
>> That older message (since
>> updated) does ask you to send an email with no ifs and buts:
>>=20
>>     'git whatchanged' is nominated for removal.
>>     If you still use this command, please add an extra
>>     option, '--i-still-use-this', on the command line
>>     and let us know you still use it by sending an e-mail
>>     to <git@vger.kernel.org>.  Thanks.
>>=20
>> But the updated one has some alternatives:
>>=20
>>    'git whatchanged' is nominated for removal.
>>=20
>>    hint: You can replace 'git whatchanged <opts>' with:
>>    hint:   git log <opts> --raw --no-merges
>>    hint: Or make an alias:
>>    hint:   git config set --global alias.whatchanged 'log --raw --no-=
merges'
>>=20
>>    If you still use this command, here's what you can do:
>>=20
>>    - read https://git-scm.com/docs/BreakingChanges.html
>>    - check if anyone has discussed this on the mailing
>>      list and if they came up with something that can
>>      help you: https://lore.kernel.org/git/?q=3Dgit%20whatchanged
>>    - send an email to <git@vger.kernel.org> to let us
>>      know that you still use this command and were unable
>>      to determine a suitable replacement
>>=20
>>    fatal: refusing to run without --i-still-use-this
>>=20
>>>=20
>>> For my purposes, I could instead use
>>> git log =E2=80=94oneline =E2=80=94name-status
>>> Or
>>> git diff =E2=80=94stat main
>>=20
>> Yeah, those are similar, and more =E2=80=9Chuman friendly=E2=80=9D th=
an `--raw`. What do
>> you like about the command, the specific output or the command name
>> itself (muscle memory maybe)? If it=E2=80=99s the latter, you can mak=
e an alias
>> with more human friendly options than `--raw`:
>>=20
>>    git config set --global alias.whatchanged 'log --stat --no-merges'
> Yes I mainly use it because it=E2=80=99s easier to remember and can be=20
> tab-completed very quickly. As long as I see file names I=E2=80=99m ha=
ppy. So=20
> yes, alias will work great for me!=20

Good. Just remember to Reply All so that it goes to the Git list as well=
. Thanks
