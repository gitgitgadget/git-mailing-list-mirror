Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F60D19C57D
	for <git@vger.kernel.org>; Thu, 10 Oct 2024 17:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728582781; cv=none; b=YtjYvfzzNMKZX/HF9ha30ffYlorzjpoJdMibmWts4arAwcMz2FVu+EoiXU6Vwi6WN9TPXktv+puiYy0B37QpwsYrG7I6ox2da4k5PGU59Ic2D7xird9RVKvGg55NU1uFRsCowq+EJ9Ky5VhO3HfTP4+k7cktpPwNCR+Psh6Lpa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728582781; c=relaxed/simple;
	bh=zO0SUxvvbxeInYclhs3bJbmzqNO+uTEceWzkfgyXUsw=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lMclWkmJVpVm3zp33KYjgRg39UPjbP2szK0qv2wtBW6x2RLX0cO0ZKnuStSW/fKkkje+pzSu9AIaHDKAVbHNWgdPpZe2f1iwYgcpLmttn5YtQejKXpAbImjtpK+eYZ9Ifto/z3rE1VjidCmzifWx9daaLLspfttUlm2DUReoK68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=hI60FqOX; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="hI60FqOX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1728582771; x=1728841971;
	bh=zO0SUxvvbxeInYclhs3bJbmzqNO+uTEceWzkfgyXUsw=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=hI60FqOXdw5utFPkgRkcOSNv5nNADSbuV6NcVt0kDB1QUTao0SvXf4NjqS3cbvvgl
	 4LghxoNq33oPO52Cgwen1Q0N/xEfleqpICtGw7CI9cn7lWysvDgVRinjBI/WcbXX6S
	 ucPwpSulstvG7HzG8V/VUOq9EWLh3CVyRw2QhUQ71OOylUZFa5mirkCpwfBiZ/6cJh
	 xweO9qlGeg/jdCaZ7yku77VZdACpzxTe25ZCXWULWmQby6w0xR9QEqVC8aUpnRmyka
	 GHufo7w181uR0DDJG3IU2jcjFx33keMsITcBp1RW2iBnqzMBfIvZeeYkU7orNmB3b0
	 1MW5iZKlAYQ6g==
Date: Thu, 10 Oct 2024 17:52:49 +0000
To: shejialuo <shejialuo@gmail.com>
From: Caleb White <cdwhite3@pm.me>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v3 1/3] worktree: refactor infer_backlink() to use *strbuf
Message-ID: <J1frhnJqftB1IUvIGDnJiz6uYTDNl_Bc92NLj1gXJtgRxapI3Uy-fyFHYtv5_p8e7yzF0pegawV6NlHQTn0GHcXP8MZ_1X8CNkIvO3_MP9c=@pm.me>
In-Reply-To: <ZwgOURNkNhg8BsaU@ArchLinux>
References: <20241007-wt_relative_paths-v3-0-622cf18c45eb@pm.me> <20241007-wt_relative_paths-v3-1-622cf18c45eb@pm.me> <Zwf4PT-vaLX35ELL@ArchLinux> <e1RptKNShhPZHXDhBkQBaCNCmKBKik4nQzRShqtgVfjcH7vBWpuLYV60PSHaJ0diX-oG3XiKHc7IebhIZM4eSkeYdQQZ_QYK2ixxsK-XwrE=@pm.me> <ZwgOURNkNhg8BsaU@ArchLinux>
Feedback-ID: 31210263:user:proton
X-Pm-Message-ID: 4dfd31188a3e9ca7548eb779d255c33b358eb87b
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha256; boundary="------72cb826018ba015d6d96343dd02b0cbafe11d2bfa79f40a60ccd329039f99cdc"; charset=utf-8

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------72cb826018ba015d6d96343dd02b0cbafe11d2bfa79f40a60ccd329039f99cdc
Content-Type: multipart/mixed;boundary=---------------------b80ee5430c168d4abe06791fd569472f

-----------------------b80ee5430c168d4abe06791fd569472f
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;charset=utf-8

On Thursday, October 10th, 2024 at 12:26, shejialuo <shejialuo@gmail.com> =
wrote:

> > > We have two signals to indicate the success. I think it's a bad idea=
 to
> > > use "inferred.buf.len". Let me give you an example here:
> > =


> > I don't see a problem with this---the two "signals" are guaranteed to
> > always be in sync (either the return is 1 and len is > 0, or return is
> > 0 and len is 0). Having the boolean return gives you flexibility in ho=
w
> > you can call the function (if it can be placed inside an if condition)=
.
> =


> Yes, there is nothing wrong with this. But we also introduce a burden he=
re,
> when we need to change/refactor `infer_backlink`, the developer should
> have the knowledge "when the return is 1 and len is >0 or return is 0
> and len is 0".
> =


> If so, why not just return "infer_backlink.len"?

I would say because the purpose of the return is a boolean,
either the call was successful or it wasn't. The developer
knowledge that you speak of should be a given---if the
function returned true then there's obviously a path
in the strbuf.

> I am sorry for this, I gave a wrong example here, it should be the
> following (I copied the wrong line in the previous email):
> =


> struct strbuf inferred_backlink =3D STRBUF_INIT;
> infer_backlink(realdotgit.buf, &inferred_backlink);
> =


> // What if I wronly use the following statements?
> strbuf_addstr(&inferred_backlink, "foo");

There's nothing wrong with this, it's on the developer
to check the error condition before proceeding to use
the strbuf.

> Actually, I am not against your way. Instead, you should mention why you
> choose "inferred_backlink.len" as the signal in the commit message.
> That's the main reason why I think we may add some comments here. The
> caller may do not know we should use "inferred_backlink.len" to indicate
> that we have successfully found the inferred backlink especially there
> is already a return code in the function.

I think the intent is fairly self-evident and does not warrant a
comment in the commit message? If the strbuf does not have a
length then it should be obvious there is no inferred backlink?

> > > If you insist using "inferred_backlink.buf.len" as the result, this
> > > function should return `void`. And you should add some comments for =
this
> > > function.
> > =


> > I can add comments, and I can change the return type to `void` if ther=
e's
> > consensus, but I really don't see any issue with leaving it as-is.
> =


> I agree with you that this function is NOT harmful. Actually, I do not
> think using "void" as the return type is a good idea. If we decide to
> use two signals, let's leave it as-is. Some comments should be enough.

I've added a comment to the function docs.

> The original patch has three lines. So it should use `{`. After your
> change, it only has one line, isn't it?
> =


> You could refer to this to see the code style.
> =


> https://github.com/git/git/blob/master/Documentation/CodingGuidelines

Ah I'm sorry, you're right---I'll adjust.

Best,
-----------------------b80ee5430c168d4abe06791fd569472f--

--------72cb826018ba015d6d96343dd02b0cbafe11d2bfa79f40a60ccd329039f99cdc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wsBzBAEBCAAnBYJnCBRjCZAy5Kywm9vL4hYhBE+hHqFr3OG0O+P29TLkrLCb
28viAAAo6Qf/b2/z4HMzeMgCUE3kaiWSrJxa00bDHrU8ugrG8Lp8R2zlW/g4
lweBLT1ceWa3l3+lMRfLzgCXDGVGU1LA+e40zTIFud+FutTchC+lG/hf9HIr
RCLOuyeMJR4Cm1X/GkIqfAAiCrQOBMzugvmH85c3H4caPPacNi+VLb2hhSJN
P5WcURbBCdP6iK0jhTEzmTLGPLgmgK6SAqyUp5Hhp/hvEu7Jb7uiwGsi31Hx
pQzbd02JN0Klv9DDQ9YLjYXITnKEj9afsKuHhP5w5X81j6gz0lYIxe4gSrx6
djER7zO1egOmIMhfAkG2tuIqZJ2WbLTa/FOwq+GngT0ogO7qL3qwSQ==
=Gqod
-----END PGP SIGNATURE-----


--------72cb826018ba015d6d96343dd02b0cbafe11d2bfa79f40a60ccd329039f99cdc--

