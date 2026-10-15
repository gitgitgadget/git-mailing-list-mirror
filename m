Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5435656C645
	for <git@vger.kernel.org>; Thu, 15 Oct 2026 20:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792096954; cv=none; b=P4fQ2VUZd8tcfku1a2yYoozcATqrbsncd4NVT/iMuaryu+MsAJ4jOi6dI99PizyeH/N5crN4hj0sLdpHxMd4s6owUxXr7GO7jKVcl8+6d2pmdA/WvQo8Gr9yqgvm6oF7sgdK4ZLBey5ba2Ti4p4397cnQsvvY3uqpeDQDMwL5xA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792096954; c=relaxed/simple;
	bh=zfq21Y61kSyZfrwQFgdEK02FEM8tRXT7u1qcuvNHHnA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JWmd9e/Q/SCVvQzqV3vBD+uCxvH0xMemFwNv/Fu2zsmdHGng9TfVbepmjk2qFgQ4E+4GSw0/EXDwuAjocbNEsw5C0QrZgn0bGgEERVGRN0up4XrNrb9Ct6a1MNV+/eAvnrAw41m3xwacyF+ki/etSwOLBYBimR+4ZLugEGCD+Gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=qMHqST1R; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="qMHqST1R"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1792096949; x=1792701749; i=l.s.r@web.de;
	bh=rpnW8JicHCW+XGs+Lz/p7ZBYTkWglplOQt8nbVwpdMc=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=qMHqST1RYy2Vk2cM0l5nLLPgqmmd0afTTbo4pnV03AINMW8fvTnAHhGSpSovayTA
	 uL28hPtUEXlhHsJclXC3AhhtCCEFeSlyGJLlOkXeBIlQWSsD+rjmluhURXu/geIdr
	 d88vWs7CT1XR0cD3adygY0WZaa/DOHC5fdxjNguXd8IxQO8kbXLMTcRoJ/xvKHzVB
	 SLDf8r3p/Y+EoVu2Dc4iQpjzoOpCQP2GnWB4v5GqTNSOpaL3edAUmrX0GD67HLNVw
	 Xr7qRKDeZODRSI6hNm28lwOJs7OEQzRwzd+vDDcPm6Hn1h4N/RcvXIXDaWlpgS1vC
	 9L8KzjLiEQ68Eo+CsA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Mw9xG-1wRy7c49Jc-00s77t; Thu, 15
 Oct 2026 22:42:29 +0200
Message-ID: <fc0dabfb-3dda-4b12-a1fb-184d1e553623@web.de>
Date: Thu, 15 Oct 2026 22:42:28 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pretty: fix lost indent after newline in %w()
To: Andy Koppe <andy.koppe@gmail.com>, git@vger.kernel.org
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <20261014172333.2224123-1-andy.koppe@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <20261014172333.2224123-1-andy.koppe@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:KrRYaYOZ8UEtrqL2NglCuAXx+7GPPF8t4dCwE5zuSXNjB6PRynR
 8yz2lrueg+baylzmSL7/i9qqdVwp+RQKb4ZESbosnNaAO8o3CViaG9sUOHHgb/sckR/QirV
 LLZ64QW2VzCE3dWuIRyZkY1ZzG2o9b5g1UZOvt9x6Hh7YHOETWOh92QcJaXRaPPshT8kMQL
 88PfoMeMJW4oWFkIcA2Dg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:PTHRyeQwGOg=;OTHX+ENCIWD4BfiQiral4bx7GIa
 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
 GW7uNWf9/9Xj4RiIX6B4a9Q5rRe3n22gTrnZfQ=

On 10/14/26 7:23 PM, Andy Koppe wrote:
> When strbuf_add_wrapped_text() meets a newline followed by a
> non-alphanumeric character, it treats it as a hard line break and jumps
> to the new_line label.=20

I assume you're referring to ae0b270230 (print_wrapped_text(): allow
hard newlines, 2007-11-11), which started to replace single newlines
preceding alphanumeric characters with a space, and to keep double
newlines and calling them hard.

E.g. the following format pairs are equivalent:

   - hard newline:                    "%w(9)%n%nA" =3D=3D "%n%nA"
   - replace newline before alpha:    "%w(9)%nA"   =3D=3D " A"
   - keep newline before punctuation: "%w(9)%n-A"  =3D=3D "%n-A"

> That code was written for the case where a line
> gets too long. It moves past the space where the line was broken by
> setting the next line's start to 'space + isspace(*space)'.
>=20
> After a hard line break, 'space' already points to the first character
> of the next line. If that character is whitespace, it was wrongly
> skipped, so the line lost one column of indentation. For example,
>=20
>   git log --format=3D"%w(11) This is%n  the %s%n  commit."
>=20
> printed " the ..." and " commit." rather than "  the ..." and
> "  commit.".

So currently a newline before whitespace is kept, but that whitespace
gets eaten, and you want to keep it instead:

  - now:   "%w(9)%n A" =3D=3D "%nA"
  - patch: "%w(9)%n A" =3D=3D "%n A"

The commit message of ae0b270230 doesn't mention this case specifically.
I also get the impression that this consumption of the first whitespace
character was not intended.

> Fix this by skipping the space only in the line-too-long case. In the
> double-newline case, skip the second newline explicitly, because that
> case relied on the old skipping.
>=20
> Add a test for this, and update the expected output of the "magical
> wrapping directives" test in t4205. There, %+d emits a newline followed
> by " (tag: ...)", and that leading space is no longer lost. With a wrap
> width of 1, the space now causes an extra line break.

This behavior stood for more than 18 years.  Someone might be relying
on it -- this test is one example.  And you can easily work around it
by adding one more space to the format.

On the other hand this hard newline concept is not explained in the
docs as far as I can see.  That makes it fair game for change in my
book (within reason), as long as that doc gap is filled.  My 2ct..

Ren=C3=A9

