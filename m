Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD8DC188714
	for <git@vger.kernel.org>; Mon, 30 Sep 2024 16:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727712385; cv=none; b=J9J6STGLdlLjOWA6QSMEXoqHyg8KpwPbF0v9DuX4PXpDmcwcdkPEgRhkmhR+YrtRg1BfZOmf5Xm2QbYnTgaHQvrEa3iWmdFmJkGmSRUpdlbQUiM4vFXYtcJQYqDXNMyvLZO9WxNMQH7o4xHei/Yw2r7tGrix3/gIhKQq1lD95HQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727712385; c=relaxed/simple;
	bh=2I0gYoInelN/CIHkAG8/JeHYICL5hAlOR3ljYh0qK7s=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=U3Ja0wgXxkwTrMxG/hT0qlkit0IH1hhaD4h2fCp8eVdpZPaQ4xSKmiC+2Q92s3YXERs1lz/TTlo6XG9aRglV2w5IFdZKdmno7hzExbnQ0BK4FJ7jkbdf4y8DXvaxVaB6/XFaeC2LG3CWHd4tC+J463JZR4YCyAOTU9aDk+r64/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=hgoZ2QFR; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="hgoZ2QFR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1727712337; x=1728317137;
	i=johannes.schindelin@gmx.de;
	bh=e3hsRtYO/wPZx4RTUKEj6hBPRW7uRWsmunhyYMwxglU=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=hgoZ2QFRKJKvaWFAu+ysYoVGxxGAG1huke0FWlu4i9WMOyWcuH+Zf9nDWMPMgewI
	 IZAjRMimudGHUDgra5B6TotCAg96mB1FVFNsjt6Z4VZ5/teRMq3TeZ+KV4YHc+72R
	 9IJSl/tvhSKGb8DgA1AZH+sbNcax1xuJnt1+XY+5vhFsueQ+aBe/pVTCr8U+zhSJU
	 RdK7ORf7gfgu1Nl+tLS9pJGG0UwKIM532AijVsesGekTL37fp+aIlSC6NIkKkKsJd
	 0n21I5y9MtS74JvSvvVIXyAj/tMGJFwLBvRv59xGn92jdW61zEcgOWrOo3P1tnUbQ
	 tsKr4w/N+UIU0xxQdA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([91.13.166.221]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MhlKy-1sHaQi3WHA-00bLzt; Mon, 30
 Sep 2024 18:05:36 +0200
Date: Mon, 30 Sep 2024 18:05:35 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: phillip.wood@dunelm.org.uk
cc: Eli Schwartz <eschwartz@gentoo.org>, Junio C Hamano <gitster@pobox.com>, 
    Patrick Steinhardt <ps@pks.im>, Henrik Holst <henrik.holst@outlook.com>, 
    "git@vger.kernel.org" <git@vger.kernel.org>, 
    Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: ./configure fails to link test program due to missing
 dependencies
In-Reply-To: <a43fa510-9a96-4b92-8107-0c00209d5161@gmail.com>
Message-ID: <3b12cfe9-0291-87ba-6324-232a86ed716a@gmx.de>
References: <GV1PR02MB848925A79A9DD733848182D58D662@GV1PR02MB8489.eurprd02.prod.outlook.com> <xmqqldzsrhyp.fsf@gitster.g> <ZufjWR6AJM-DIWPR@pks.im> <29c5c9c0-aa61-415a-9cfa-d64a6b946a48@gmail.com> <xmqqy13oa8oe.fsf@gitster.g> <ZvKsH1Ct-YwBPA_f@pks.im>
 <b6b131cb-683c-4140-9769-290b622721e1@gentoo.org> <ZvOTL0cG8qRY8OXe@pks.im> <1f002f86-9212-4639-8804-898bc62726e5@gentoo.org> <ZvOn_wChzEgXtpMd@pks.im> <3a303c6e-35b0-4428-9d23-799b33194330@gmail.com> <xmqqv7yil70d.fsf@gitster.g> <39508a38-d98f-3883-3887-971385a3805a@gmx.de>
 <d3900cc3-8a0a-4da1-829b-5bcdd7ebca28@gentoo.org> <a43fa510-9a96-4b92-8107-0c00209d5161@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:o+oLTCF1dtEiHTrglOBlYDMxDjISmFFmtS9Vk7qYRWvQIM6oZyB
 zha7LK97Eqkxu4Myx1nFe0U0HPkhdOZDgp9UcLefvLVA/c4wjLrzFXU83ONcagsjrx00vt9
 DVcPxOlvraqA/9JcuHTjwg9EfP6l7vUQYc4EsHIrlFZZ070vdi8tPxb2/7LmSW4kvknL/ON
 eO/iQEh7lp6iejH/U8qww==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:HHtDEfmzIX0=;vuA10WJh4HpAZz2VUWg7hdvijTL
 pjRZekqKbaKlN3bPogdiwtq7ZG1KDFVD7xJJUBmCRH/Ft9iegPqcGZdKRto89z/wPd62YznXd
 CGMtwJPO3zxXv+Py3KCSnN/o7h1QQdSqBp+mRGur8/TpWk8jb3rO6I0H7UBE1U1hdcC9KlHGl
 txsyItMaLgFfk1NE9kllsf9p6nQDAu4U9VRR5e2xHKnu7SFmOfv2QLb0/9f3Lo7/G3FAC5ebQ
 gemKvnvyDpnAwu9/5fqjVAqYvyN6CEGG7i+RmVsVQlylYSnT9HlPCb64sEvvUr847kAzmv0/W
 X58nOYpVPtsfpGVgZiiAOBGzNRGgR06Btx2Y31jC7KNKveAtM3svmjn1lkYNooe0XLbf/NiZc
 Gov/XXJwVdfbqZYx2z+vS/DwCJDoK0urtrl6kGbHB6JFVrJrIEk4B322FxjAk7MuEM9wYpK0M
 MCRNjLQk7jrkauxUf9mWWehAcJOwSJZCmZXNOeDVeCxfh6DdZtAhKcY7UDYxpQ/ilpNkNhyvU
 y8TuNOnkpHHE88Ddu0sB1UUwgidbvXdaFhXuLd0iAGrNTDUCdcYEM5YEKWSELO1etuHVj0Vof
 cih39HAhsOHvUd8WqdMeGuY3KydLjDLdqreCevf17klsN/GeolDE80vNSQ54lk/QP3iS79Upn
 G3DhoHtRCGRMqIwc6nhat9TyAZ/nXxZyJc6VyuqO6UbxRCp/5QPsGTdmU0UeInKQH019nHn7l
 Yaw+8sK8llbSYTrw+uYrdSb2XHNft6KxqI/okqTyYfS4g46Rytkv/EeVnv+XN5EvNHclUsS1e
 4bXfogvMyUaYOzbbI+zzixtg==
Content-Transfer-Encoding: quoted-printable

Hi Phillip,

On Mon, 30 Sep 2024, Phillip Wood wrote:

> On 29/09/2024 19:10, Eli Schwartz wrote:
> > On 9/29/24 1:56 PM, Johannes Schindelin wrote:
> > > Meson came up as an alternative, so the obvious question is whether =
it
> > > could be used conveniently from within Visual Studio. It takes but o=
ne
> > > look at https://mesonbuild.com/Using-with-Visual-Studio.html to see =
that
> > > no, the instructions ask the developed to use a command-line interfa=
ce,
> > > which is the opposite of integrating well with an IDE.
> > >
> > > In short: If we're serious that we want to stop treating Windows-bas=
ed
> > > developers as if they were unwanted here, we'll need to stick to CMa=
ke.
> >
> > I guess you didn't read the previous comments in this thread? Maybe yo=
u
> > should take more than one look. :)
>
> We cannot expect everyone who wants to build git using meson in Visual S=
tudio
> to read this thread and find the message that mentions installing a plug=
in. It
> is much more likely that they, like Johannes, will find the documentatio=
n on
> the meson website and conclude they need to run some commands on the
> commandline. That's a problem with the documentation, not the person rea=
ding
> it. Even if they do find the plugin [1] it is not clear that it helps - =
no
> where does it say "this enables you to build software with meson", inste=
ad it
> talks about syntax highlighting, code snippets and linting for meson fil=
es.

I had actually read it. Not wanting to be xkcd 386, I had decided to
refrain from replying. But it would appear that I have to.

> [1] https://marketplace.visualstudio.com/items?itemName=3Dmesonbuild.mes=
onbuild

Thank you for providing an actual link, it was missing in this thread
(handwaving is not really good enough, I would say).

On that page, we see a serious flaw in the argument made in
https://lore.kernel.org/git/71ed5967-0302-42bc-97c7-81886408d688@gentoo.or=
g/:

	Visual Studio Code>Programming Languages>Meson

	[...]

	Meson for Visual Studio Code

Now, I am the first to admit that it is confusing that there is Visual
Studio Code and then there is Visual Studio, and those two products share
mostly the "Visual Studio" in their name, but little else.

Most notably, you cannot install VS Code Extensions into Visual Studio,
and vice versa Visual Studio extensions cannot be installed into VS Code.
See https://www.freecodecamp.org/news/visual-studio-vs-visual-studio-code/
or https://dev.to/hadil/the-difference-between-visual-studio-vs-visual-stu=
dio-code-35oh
for more detailed explanations.

And when you navigate on that Marketplace to the Visual Studio extensions
(sans "Code"), you will find that, frustratingly,
https://marketplace.visualstudio.com/search?term=3Dmeson&target=3DVS comes=
 up
empty:

	Your search for 'meson' didn't match any extensions

In other words: Visual Studio, _the_ most prevalent IDE for Windows-based
C/C++ developers, has no Meson support worth talking about. None.

Now, how about instead suggesting VS Code to direct Windows-based
developers who are eager to contribute to Git? Alas, VS Code does not come
with a C/C++ compiler. Not even a canonical extension to compile C. Even
if there were, the user experience of having to scour around for plugins
and 3rd-party software to install, and _then_ somehow getting the needed
libraries like libcurl into that setup, _just_ to build Git (and we are
not even yet talking about running tests from Git's test suite that do not
eagerly lend themselves to be run from common test frameworks that would
be supported by VS Code _extensions_) is about 100x worse than telling
contributors to simply open their git.git checkout in Visual Studio and
let CMake do its thing.

Yes, I made up that "100x" from thin air, but it's easy to imagine that
some (most?) developers would contend that this is a few orders of
magnitude too generous.

Personally, I have to admit that I find very, very little consolation in
the suggestion that these days, Meson will "automatically do the right
thing", without requiring to be run in a VS Developer Prompt:
_These commands still have to be run in a Command Prompt_, i.e. completely
outside of Visual Studio, in a text-based terminal that Windows-based
developers will find off-putting to the point of rolling their eyes at the
suggestion.

In summary: From my perspective, these quite serious flaws put quite a
huge dent into the credibility of these arguments pro Meson (and contra
CMake). Forcing Windows-based developers away from CMake and toward Meson
would definitely make the developer experience substantially worse. To be
honest, I hoped that we would make the experience better. Certainly not
worse.

Ciao,
Johannes
