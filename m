Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FE9B2DA765
	for <git@vger.kernel.org>; Sun, 12 Jul 2026 08:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783845926; cv=none; b=RcIqevtnpDltTi+I/36nIsdtO9fwhyPEQsbs9qk7Ml83z8L0qodPcqb4N+t8OXzHWUwWAjnf5r3+WA5fMwt+DtLO9voEN7WwDzxeh5oNh5PZ+kiBqxbaOynDiSzCeOmVak5z6m5oDurO5wNNdstI/CXjgMsyIZh6yvICDD1vRcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783845926; c=relaxed/simple;
	bh=issZX0zgLtx3LT1zAOuQm5J79lnBy1/9mC1se9gHW1g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gF5V91mqhyGy39M8W1+CmwPEzIt1o4xhEnLrflmhrNwHXcZK7DK+XC7Y1VSBjMMlLlRUcR4TAIgPXTByIBgqRHwsBPzoLyeN+B8Vs96oaWauC8VXN5Pf9e+R9eEHYd6T0KU6jtGi8A/3VvBGYQq+CjBqq0uGyJ/73sxdH7MQNiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=oswald.buddenhagen@gmx.de header.b=QvEDcHZc; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=oswald.buddenhagen@gmx.de header.b="QvEDcHZc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1783845922; x=1784450722;
	i=oswald.buddenhagen@gmx.de;
	bh=cbTzc+ogM/6bLhkZq/MDFNlnlu4iacx2+NCx8/6aP/o=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:In-Reply-To:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=QvEDcHZcdYwfxoB1vy3cKWKTw/a64+8TU/Kp4VT4JAe3fwVt9eWSCMs50DIWxJ5C
	 FYOVu8KB32ihbA5seV+GVCYfzt5MxwXt5up3Ml8fE4p3SSGVvAWV+Y5bmh65TCVz+
	 LDfPdI5CxYYjFGcq0aZ019plccwKMXdz9VFTUTiMQNvr6/S9ATlUJ8yOqR2qet5/7
	 +Y7s9HsPti57h47C6azvWcqWZZNBIpBliJtcIz1rhrsQvy8nTGAACUQx5uSyEBVO0
	 tsM7HwdcZjmUOUC3Qp8EwshdLLHaSwqzwHHqOhhS35B8mNGTfNTXk+I1YBJDsy9KR
	 nURKfvEgT36z+Bn/+w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N33Ib-1xCMoh0Y5l-016JcR; Sun, 12
 Jul 2026 10:45:22 +0200
Received: by ugly.fritz.box (MasqMail 1.0.0, from userid 1000)
	id 1wipoP-Bhj-00; Sun, 12 Jul 2026 10:45:21 +0200
Date: Sun, 12 Jul 2026 10:45:21 +0200
From: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
Cc: Jeff King <peff@peff.net>, Omri Sarig <omri.sarig13@gmail.com>,
	git@vger.kernel.org
Subject: Re: Understanding why Git defaults to show author date and not
 committer date
Message-ID: <alNUIWZ7W38ABxU5@ugly.lan>
References: <CAP9es6tyaGwfTguz5zgBmE5xN7MLDN3-rxRfo_JJBf79RCNzgg@mail.gmail.com>
 <20260711080331.GB1470749@coredump.intra.peff.net>
 <xmqq4ii5b639.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <xmqq4ii5b639.fsf@gitster.g>
X-Provags-ID: V03:K1:dBryBNXK0K2uXqFb+O4N+0yf9DwrLLDXuAMrNvlkp3Sw8UD4xid
 A5acXT32tV7FFTT5S/JVOXAOpFR29I+Go1VQyqRG/MIkFpnFADp79pScjuxzmgzkJPpRc/z
 JcsO7xO52cbg7cL5GCyg3gSwy28vIXR6714HPjnhjb6mEK5Wr8zGOxoVFZZw4gj7xcWAPt+
 F4mjWapXlXJfbAN+PBR1w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Q0+JAJwhloA=;V6dBTah7UknbUKeLlXhGNMugx1L
 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
 0m/8viqrtYXR/YX10TjfHkydBeabVW
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 11, 2026 at 01:54:02PM -0700, Junio C Hamano wrote:
>Jeff King <peff@peff.net> writes:
>> In a workflow based on mailing patches, the committer date is usually
>> much less interesting. It is "when the maintainer happened to pick up
>> your patch", as opposed to when you wrote it.
>
>True.  In mailing list workflow, the author date recorded is usually
>the date that the patch was sent to the mailing list, which may be
>later than when you wrote it, but is much more relevant as that is
>closer to the time when anybody other than the author have seen the
>patch for the first time.
>
but why do you consider this more interesting than when the commit=20
actually hit the target branch? why would most people exploring branch=20
histories care more for the "meta" surrounding submissions rather than=20
when they actually started to matter to users?

>> Likewise, we show the author's name by default, not the committer's.
>
which should be kept, because the committer identity is much less=20
interesting in most workflows.

showing author name + committer date by default may seem unclean, but=20
it's what is most *useful*.

if the change was to be made, it would have to be visualized to avoid=20
confusion. i kinda like s/Date:/Stamp:/ because it's short and the=20
metaphor kinda makes sense. "Committed:" seems worse. format=3Dfuller's=20
"CommitDate" seems even worse in this context.

the new default should get a new somewhat arbitrary name like "compact".
note that i'm not worried about backwards compatibility, as somebody=20
parsing the porcelain output without even specifying a format doesn't=20
deserve differently.
