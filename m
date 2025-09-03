Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 571B22C18A
	for <git@vger.kernel.org>; Wed,  3 Sep 2025 20:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756931520; cv=none; b=HzsuO5ODqa8xFIelgBOrRc1uBfeNc2tJmmhZLPzrArW68DEAAlcahu8k7t7DwVqtm+2sAJJ/0b6vrZA4r4xWOuuvfSqRhKSp9d4REcUCEdw9MzwjBCE1NfHXGUq4AMzkD/NjsMbi7xtrFIp/8bSgMBfFvltwG0QGyvXNdwSzZxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756931520; c=relaxed/simple;
	bh=RJ5wcEzBuUaw9yGeu1/8B6is8URTJEC0z8Db4KdbyjM=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=gercZf8exKDshVQgSn1+TseQDmdU9Ac8cQVKTigAKgOjOpEK1o1ntqFmhMhaYOprdNxKs7crhpXqNRll0GUxpTvLBIijQLmvn3h1+nqJwYl7xCOqDP6jDJeRKBmDTn9AK5rpCE0KC0mUPHm9NFk9derpEY+M+RT6HIbnLYE0wlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CBD6s8ki; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CBD6s8ki"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b047f28a83dso9352766b.2
        for <git@vger.kernel.org>; Wed, 03 Sep 2025 13:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756931516; x=1757536316; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=W8sAfUFhiDIxytcQZcm7ITFGHJsLgNIRGScO2jI5B6o=;
        b=CBD6s8kiufwG0Xch26pz5d/hskjVVNairb3zJiBCUQI0V+1PEqpoeL2YoelEVo0uCH
         IeIjOuPd1zF/8kkj7zRWEUTZSjoQluRnnsUyN1Wlrs7mSlM5Q+gC2DqXeEvYhLNA4zEi
         rpnqUemXcEWEG7kueR8Mzap+7BVIHru0FuxeqNUZCARBa/Y4lPHHv6HyBVnLr6i0gba7
         IMCLlZBAJDFBa5CTo379hregjcgPZVbhFveJypST/+Mi/2Lpp6B689HsoNOD7DwogYhn
         VrDoZNOYhxbH1ZvBMzwmocPHXvuevN7QkIEM1eSI1UM81eU7wd0Dg5Fd8JZHGit9vXk8
         9/NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756931516; x=1757536316;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W8sAfUFhiDIxytcQZcm7ITFGHJsLgNIRGScO2jI5B6o=;
        b=hbj55FMkdDQUQ5JXNQmLlS+RglfRbSZ2fE/IJOpP5URsXyhzzXrgkxzH3Kct9Jxfg8
         kPvdELwsMoYZRwbzEjxCsj6z2eH9J+I3xmtRUmGFyK0aBBGNGabIgbhEOWeJfx/dSWr7
         RY/ek9Xiy7I/frgz+4LRLKw+de9g7ufafiaMnzb6bYGacDddmbZrLOWhXXX2nNQsob08
         yVk7lVCW/ip1aO9fg0erqH6XEg94cdCWbsGGGbmUl5szWh4ThhmAn3+oBmWfmQyGFncY
         ZugDPp7jExIcrZ1siuaXtc8JHGKmafnev2sC+INDMI4ZE0eSjHZ4WduBDLuiTa7lOaZS
         vTcw==
X-Gm-Message-State: AOJu0Yz3agFXsMWYzwnoJSNp2/omH4sRzWandi6w2jFk2JaAXMRQIo6z
	+ipJelvygLmaAwjiltL6j8UBu8eaF5GbCFASGibFO6JYlqP0R+wFAzy+2xAIHVYFgs2VkBJhmTh
	oeAaZqvfUGAPGUGDJMBcqrP75fkYFSA3GCaiB
X-Gm-Gg: ASbGnct5sX+14R6gYj37Jq9KfxV+ii+Mn5D0pSzjeumQvJECUEqN6e4F3CyTF/BJQSs
	1K4NMLjSzFg5LLK0B575XvxeyB5ESyBMDKqqyRJIvfW8XQkazlMZ+oxEUhRuDFUfeH3ks4hMT9m
	QxPCb+0BaU/SutDFGYvqJ7HtV9DZ4EtnScs9uT+wIZDt6tQbPtsOsbry5xGnx0sceWRAXokrqOz
	kqpAg0++gE1sA5Q/dve94XP0B5emIkM+IoTiEMQgxizaxIzG4PulCGfDk1RsYU=
X-Google-Smtp-Source: AGHT+IHnRDo14vbT1EtpAfjoey8TbicUHdsy4fHamCo0IWFcLcEfFv6yy3sCWFPdVk/CUgXi6AGzV21tkZplkH30tec=
X-Received: by 2002:a17:907:72c4:b0:b04:274a:fc87 with SMTP id
 a640c23a62f3a-b04274b17e4mr1318683866b.4.1756931514906; Wed, 03 Sep 2025
 13:31:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Wed, 3 Sep 2025 16:31:44 -0400
X-Gm-Features: Ac12FXzGb48uckVkUCyI6logAUdgxeic1eXXbU45JBRkHrTm5egehpfsArTlzzI
Message-ID: <CALnO6CA3FkiOeF4w1TUf9S_UDTG_1iRxjEZcAkfrL_eqY+P26w@mail.gmail.com>
Subject: Performance (self-compiled vs. distributed)
To: Git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I have an installation of Git at /usr/local/bin/git managed by
Homebrew. I'm also tinkering with building my own Git (+ patches) to
experiment with new features. Today I used "make install =E2=80=A6" to get
that in ~/bin/git, but I'm noticing some performance problems. My
shell prompt started coming back slower, especially in a large
monorepo.

For example, inside said monorepo (apologies in advance; output is on
a computer I can't easily copy from):

    hyperfine -Ni -w10 {/usr/local,$HOME}/bin/git
    =E2=80=A6
    /usr/local/bin/git ran 4.99 +/- 1.69 times faster than ~/bin/git

The difference is 22ms +/- 6.5ms (15.3ms=E2=80=9356.3ms) compared to 109.7m=
s
+/- 17.8ms (91.1ms=E2=80=93159.9ms).

My build recipe was

    export DEVELOPER=3D1
    export XML_CATALOG_FILES=3D/usr/local/etc/xml/catalog
    make -j "$(nproc)" all doc
    make install install-doc install-html

Which differs somewhat from Homebrew's recipe (namely, Perl & Python
path aren't set; nor is USE_LIBPCRE nor INSTALL_SYMLINKS=E2=80=A6 I'm ignor=
ing
the "extras" for now). I wouldn't particularly expect any of those to
create an issue, though.

Any tips on debugging this would be greatly appreciated.

Some other tidbits:

    ls -lh@ {/usr/local,$HOME}/bin/git
    -rwxr-xr-x@ =E2=80=A6 4.4M =E2=80=A6 ~/bin/git
        com.apple.provenance     11B
    -r-xr-xr-x@ =E2=80=A6 3.5M =E2=80=A6 /usr/local/bin/git
        com.apple.provenance     11B

I wondered if quarantining was at play, and this seems to indicate it
isn't. It is interesting that my binary is so much bigger!

Source I compiled: https://github.com/benknoble/git/tree/ps-jj

PS I also noticed we put all the RelNotes in
$prefix/share/doc/git-doc/RelNotes/*.adoc; I might have expected those
to get turned into HTML, too?

--=20
D. Ben Knoble
