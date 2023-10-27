Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2475171DC
	for <git@vger.kernel.org>; Fri, 27 Oct 2023 09:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="Tp9NMEx3"
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [172.105.110.227])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26E1B192
	for <git@vger.kernel.org>; Fri, 27 Oct 2023 02:25:52 -0700 (PDT)
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (3072 bits) server-digest SHA256)
	(No client certificate requested)
	by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 3BAE25B098;
	Fri, 27 Oct 2023 09:25:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1698398751;
	bh=mMB/3ajpDJKfXJQt1MiaOxG/73NwBfbg8dWJ/kyt7w8=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=Tp9NMEx3jyiOhktNYv2/ybApjRbM4/UkrGVlPSL81jyK4NkHf4N6uK3ksYTy+y/Ar
	 ywZi0kbM6cwq0vF96CobnWUYiV7wJL8EzG1ecqX/yLe1XF1fho7GyEvgY7UUB4mOMv
	 9C+YRgNZxa+zeokQHlpQ+NcQtKkJ20rKUjBE4hG1eDkpE8jZRsW9D/fh5wpOJSkQYp
	 /9s4bqtc0PYkJHR2mlrtLynD+d/kx/UFkotkagBln8J4tafYI0sd5BctO8InXRcwXo
	 yWNeAM+MCw3zNprpx1fGhnRhURRBu+x9BCW2P3t3eLnboSD0YcMsLn82S3KSrLhrt9
	 Suus+ovDk+EJOREGBGhbiEfrHKR+41LXp+8lBol9ceSoVuhVGHzqsjsLb203YOYUD4
	 FMhQfOGtSlIMAb0c3ONnR3sMPf8Uc2IyEwRWDupG3NJLb7VfJfr7qcMzJojKJ4ei/+
	 kzOvDB2/HaiQBx7WfSm+yJyJoI9d33+78pandknEY885md82rU4
Date: Fri, 27 Oct 2023 09:25:49 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: John <john@quantbo.com>
Cc: git@vger.kernel.org
Subject: Re: GFW fails with ST3 on Windows 11
Message-ID: <ZTuCHVwAhAGJcQDd@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	John <john@quantbo.com>, git@vger.kernel.org
References: <cd248c66-fc71-4783-9195-02c8811744b8@app.fastmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Sa1WU6PkT9MPsex3"
Content-Disposition: inline
In-Reply-To: <cd248c66-fc71-4783-9195-02c8811744b8@app.fastmail.com>
User-Agent: Mutt/2.2.12 (2023-09-09)


--Sa1WU6PkT9MPsex3
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2023-10-27 at 07:31:32, John wrote:
> I have been using Sublime Text 3 as the editor on Git for Windows for yea=
rs, on Windows 10. I recently purchased a Windows 11 machine. On that machi=
ne, when I give GFW the following command, I get the response shown:
>=20
> $ git commit -a
> [=E2=80=A6]
> hint: Waiting for your editor to close the file=E2=80=A6 C:\Program Files=
\Sublime Text 3\sublime_text.exe: C:Program: command not found
> error: There was a problem with the editor =E2=80=98C:\Program Files\Subl=
ime Text 3\sublime_text.exe=E2=80=99.
> Please supply the message using either -m or -F option.

I think the "command not found" indicates that you may have specified
your editor incorrectly.  In Git Bash, can you try the following
commands, one at a time, and then commit between each one to see if one
of them works?

  git config --global core.editor '"C:/Program Files/Sublime Text 3/sublime=
_text.exe"'
  git config --global core.editor '"C:\Program Files\Sublime Text 3\sublime=
_text.exe"'

I believe that both should work here.

My guess is that this is the situation hinted at in the FAQ[0], where,
because the editor is passed to the shell (bash), you need to use double
quotes to prevent it from thinking that you have a program named
"C:\Program" with arguments "Files\Sublime", "Text", and
"3\sublime_text.exe".

Hopefully this works; if not, please let us know, and hopefully someone
on the list who uses Windows can provide some help.  I'm afraid that, as
a Linux user, I'm not able to provide more than a guess here.

[0] https://git-scm.com/docs/gitfaq#configure-editor
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--Sa1WU6PkT9MPsex3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.40 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZTuCHQAKCRB8DEliiIei
gaA1AQDH6spw/e61SkRcZb5XrIBWhdPbBNFD35D3mGMHmT9p6gEA3Grjc1W5epd6
2uZTbDBNJj2tINkrBhjF75IzG1eMRQo=
=OKvH
-----END PGP SIGNATURE-----

--Sa1WU6PkT9MPsex3--
