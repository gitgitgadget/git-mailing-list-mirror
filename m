Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BED76329C58
	for <git@vger.kernel.org>; Tue, 25 Nov 2025 20:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764101780; cv=none; b=fXVVd1f27LdDivsIacDCwVqScag2shLnRRV3tnLBiS2IJ/h7UERPk9bX+rs01ia7CO3LrAVmm26OSqyEEsCjvSdgUMkTIk4MIv9jE45ud37AMD0J7Rws6VECQZqYiNnkySGIQSDoAGGCljlKT70lCH7W4yjmxMbJ1rOIc6UdvGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764101780; c=relaxed/simple;
	bh=GOrf3Yu/IAveQc/9Ri5Hz/3+rU2zkZwc3HemxZFhR08=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=qjzjMpby2ljWTcLyieGhUaK0CrXy69PFGGQLi8BWrFXGzhN2rSrvfQhf3PRvYYOlRBg6iBRy2w3V9OFTy419S3hRtZ0jOVxGMR2BKZcJDwJmHQUw9gYAtqq37V180A3dHhsaH20VfHrdnXbRgvjGtT5JcgI8B99Rz6Q7HqcgF9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=JzX+VZBi; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="JzX+VZBi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1764101774; x=1764706574;
	i=johannes.schindelin@gmx.de;
	bh=eQdPrZpnMa+b7KWvAC3uj9HiT9zhGoRPsHYcGLmW4Hk=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=JzX+VZBijHUuBvl8MjZmL6jetU8oN0Bhmy9eyUfguFSnH4vOa/qS9VeAa3vITps6
	 fiUopJfTOxyjyAVH2WPu5pkRhd+uGiUiOpOEPu0Caak7EeNbrq0J2/dvvDEDUey78
	 mzdhrgLvPT+Lzu3CrOmMkPfCcubtSX79CW5JKrHbr3qiEziVFVUIEYDLMODAejzUg
	 RRM5doeu7DaxXmvn9B28pZ0ipLwDPsecFGBVhStaFpUYdZCPdDUEyOzZrvvEJjJ7s
	 vxqsdbsdWwB9KYRrcVLhiEvcw/tCGZ0y49kseE6rd23ZuJ1fW/GjoRkZqjRRRYpw1
	 X8pE4j2i0GG/X6vIAg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([89.1.213.165]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MdvmO-1vvfVw1H1C-00cbAX; Tue, 25
 Nov 2025 21:16:14 +0100
Date: Tue, 25 Nov 2025 21:16:13 +0100 (CET)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: "D. Ben Knoble" <ben.knoble@gmail.com>
cc: Ran Ari-Gur <ran.arigur+git@samsara.com>, git@vger.kernel.org, 
    Jeff King <peff@peff.net>, "raa.lkml@gmail.com" <raa.lkml@gmail.com>
Subject: Re: [BUG] `git clone '-c KEY=VALUE'` no longer works
In-Reply-To: <CALnO6CBJppT3ELyu54rJvP+uqcMomJS9Nr_JTgfssn8iqG7MWA@mail.gmail.com>
Message-ID: <bb7791ea-cfdb-842e-c079-b62b0f183fe1@gmx.de>
References: <CAN1UxBvk_GJjLWd0XexRxp8FFhYozGCNcodai0eqnjrhjKEh7Q@mail.gmail.com> <CALnO6CBJppT3ELyu54rJvP+uqcMomJS9Nr_JTgfssn8iqG7MWA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-161376711-1764101774=:6624"
X-Provags-ID: V03:K1:n9ykaqRjpp0Y9Z3l9nZraTgdN8Z8MyvMkTFyjrTK0GULsDgrtV0
 KyvGQDdxYxURpsqXd8b+dTqKokmzboXFRQVnpxM4oxrVaO0uFu9EL/4050Wlgv19vPIBFgY
 rErH9xoE1vTQNAo4PRlvRfiazvQdcJtTbby+tdVUCaYJDUuOn6WbgEMFZxi3BvWMrABeTJl
 1jIf+fqK/DK/Jrz4CFq8w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:7DZmfp1vowM=;NmP9U3c/rSyGvzXrMiGKZ7gWebg
 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
 ZHB98RC0QX/kRQ0tH0cK

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-161376711-1764101774=:6624
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Ran & Ben,

On Mon, 24 Nov 2025, D. Ben Knoble wrote:

> On Mon, Nov 24, 2025 at 12:23=E2=80=AFAM Ran Ari-Gur <ran.arigur+git@sam=
sara.com> wrote:
> >
> > There's a small regression in Git v2.52.0; it used to be that a comman=
d of the
> > form
> >
> >     git clone '-c KEY=3DVALUE' ...
> >
> > or
> >
> >     git clone '--config=3D KEY=3DVALUE' ...
> >
> > would trim whitespace around KEY, making the command equivalent to thi=
s:
> >
> >     git clone --config=3DKEY=3DVALUE ...
> >
> > The relevant code was here:
> > https://github.com/git/git/blob/v2.51.2/config.c#L649
> >
> > That functionality was removed in this refactoring commit:
> > https://github.com/git/git/commit/dcecac2580ef871186fdc4e9efc87815a4ce=
4c66
> >
> > As a result, a command like the above will now fail, with an error suc=
h as this:
> >
> >     error: invalid key:  advice.detachedHead=3Dfalse
> >     fatal: unable to write parameters to config file
> >
> > because config keys are not allowed to contain whitespace.
> >
> > I believe this change was unintentional; it was not mentioned in the c=
ommit
> > message or the release notes.
> >
> > This probably isn't a common case, and the project where I ran into th=
is issue
> > has already fixed it on their end (they now pass -c and KEY=3DVALUE as=
 separate
> > arguments); but since Git aims to ensure backward-compatibility where =
possible,
> > I figured I should report it.

This has also been reported in
https://github.com/git-for-windows/git/issues/5972 as breaking Git LFS.

> Thanks! As far as backward compatibility, I think this behavior has
> been around since 2010's 8b1fa77867 (Allow passing of configuration
> parameters in the command line, 2010-03-26) which morphed via
> 572e4f6a0c (Use strbufs instead of open-coded string manipulation,
> 2010-03-26) into the strbuf_trim(pair[0]) that you pointed to as
> disappearing.
>=20
> Interestingly, I note that we dropped the trim around pair[1] in
> 06eb708f33 (config: always parse GIT_CONFIG_PARAMETERS during
> git_config, 2011-05-24), but I don't see that discussed in the commit
> message either. I tried a handful of mailing list searches around
> 20110524224955.GC24527@sigill.intra.peff.net, but didn't find any
> relevant discussion (though my lore-search skills are mediocre).

I am awfully pinched on time right now, but I _think_ that this could be
the start of a fix:

=2D- snipsnap --
diff --git a/config.c b/config.c
index f1def0dcfba..2b2efe479dc 100644
=2D-- a/config.c
+++ b/config.c
@@ -637,7 +637,7 @@ int git_config_parse_parameter(const char *text,
=20
 	kvi_from_param(&kvi);
=20
-	string_list_split(&pair, text, "=3D", 1);
+	string_list_split_f(&pair, text, "=3D", 1, STRING_LIST_SPLIT_TRIM_FIRST)=
;
 	if (!pair.nr)
 		return error(_("bogus config parameter: %s"), text);
=20
diff --git a/string-list.c b/string-list.c
index 08dc00984cc..9b5f1d71a9d 100644
=2D-- a/string-list.c
+++ b/string-list.c
@@ -326,6 +326,13 @@ static int split_string(struct string_list *list, con=
st char *string, const char
 	else if (!in_place && !list->strdup_strings)
 		BUG("string_list_split() called without strdup_strings");
=20
+	if (flags & STRING_LIST_SPLIT_TRIM_FIRST) {
+		if (flags & STRING_LIST_SPLIT_TRIM)
+			flags &=3D ~STRING_LIST_SPLIT_TRIM_FIRST;
+		else
+			flags |=3D STRING_LIST_SPLIT_TRIM;
+	}
+
 	for (;;) {
 		char *end;
=20
@@ -345,6 +352,9 @@ static int split_string(struct string_list *list, cons=
t char *string, const char
 		if (!end)
 			return count;
 		p =3D end + 1;
+
+		if (flags & STRING_LIST_SPLIT_TRIM_FIRST)
+			flags &=3D ~STRING_LIST_SPLIT_TRIM;
 	}
 }
=20
diff --git a/string-list.h b/string-list.h
index fa6ba07853c..938707bf09a 100644
=2D-- a/string-list.h
+++ b/string-list.h
@@ -297,6 +297,8 @@ enum {
 	STRING_LIST_SPLIT_TRIM =3D (1 << 0),
 	/* omit adding empty string piece to the resulting list */
 	STRING_LIST_SPLIT_NONEMPTY =3D (1 << 1),
+	/* trim only the first */
+	STRING_LIST_SPLIT_TRIM_FIRST =3D (1 << 2),
 };
=20
 int string_list_split_f(struct string_list *, const char *string,

--8323328-161376711-1764101774=:6624--
