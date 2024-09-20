Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 278311CAA4
	for <git@vger.kernel.org>; Fri, 20 Sep 2024 10:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726828938; cv=none; b=NnR15R9kAF85L7GMgZ5zk3D1BjW/IVa8unmAMn8sBpcZxQXxvwQPzUUledBzgk8R2B1EB9Yjy1ZiMWDfoR23j0PaG4RIesBVk30yYql20TMkS5tvHVeOZ5U06rijGY6R6nStwRwzQ8Az3guJWKlkjucINgeO9RwfjgbQiGQ9HOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726828938; c=relaxed/simple;
	bh=1x8ejhHJzJs4KiXHdPchnIiAlbhIz47//JV2V7RyjoI=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ojRJuIjnfknrSeoqUeSYzfpkcIM0Apk599cVbE5F1OlrkDU4iZBILJ/49J1H8yWQak2ZAVbZOOS1GiBTPGV3czqPgXaaJ5bjcvvXgBYNJvahsAksaEKN5/tcpirga/y3i5OAgdS4/5NB7bR+rduzP26nCt5OS/zJfOyVvhCw2zQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T+b9p66B; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T+b9p66B"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-42ca6ba750eso11945665e9.0
        for <git@vger.kernel.org>; Fri, 20 Sep 2024 03:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726828935; x=1727433735; darn=vger.kernel.org;
        h=mime-version:user-agent:autocrypt:references:in-reply-to:date:to
         :from:subject:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=I4GbcmqxkiWBQbzAT23sfbfqNEAcGpu0XlMyagrGRb8=;
        b=T+b9p66BIxacgN/qoGG8F8vrxg4La6XP8+PbOd6zMRwn1nIYqrEEXdwHOotZtcTmmf
         HOZmtJSbJm+sbXZpf9rR1HbR4sRm+RvpDyJhMhsSnxpZS+c+voaCbC8pnYyPfIb01WsR
         vNewD3g80vpPJWeBxasUfoX+qeX254JqpgGGDmRIWi94ZtlDAOuf1UFTvrsBOG/uQHFU
         Z+RDFAvT2bR+OhwKidb4GcWaAYClrT8WQNr9Gi6+jtrPnRaozeSUOBDjXbqllw+FP+7M
         G4rCZsZi8XDP++KwxeBkMPhok1lmzkfoRV3VIqeCPIA7WIThpCsjm2h0NHRGViuMuKNp
         d1Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726828935; x=1727433735;
        h=mime-version:user-agent:autocrypt:references:in-reply-to:date:to
         :from:subject:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I4GbcmqxkiWBQbzAT23sfbfqNEAcGpu0XlMyagrGRb8=;
        b=g17zUA2mGL3mGBnPwtVLaSDZFYMn4q/cw+Cyw5SxNQHRPtAVXEecrta9LFqnik4qqi
         ObshCegdGrDAKCRZK0BXBgZOCy1jAdePax4RKh2SW8orejnymLwmn3XWK91Qn9zODa2L
         g6wB0sC/EB+Z7cDLmP8UhdDZ9BFK5IwKDYHcFpNnk5ixQzaAxyPyvl1zqO6H0zLYRut5
         GiPJox/IY/WUY0E5vYyOEvH8D7ZFDaSwGYyT3UQ2sfZOGor6F/NqU+UAVNXDcoerCJqn
         ecWIWO5JYC9UVe3/M4Y2HI5wTgWJI6CIsrrGVWxzNGxljmfHbvBK2WxO8IxNMJ2eOfu4
         yUMw==
X-Gm-Message-State: AOJu0YyNn8MKjlrw/HY2QIzMw3kE+ii7N0Q2qg0lt7cfUk9Al8XHw38q
	+DvAqb5by1mXRVl7XASKwT7Z4yD2rY/4g+LVlreiedK+ic8bmsuKV09NhTEEPg==
X-Google-Smtp-Source: AGHT+IFL3wEU9SyZUpQ4br509ok99l9s02NRqyalgNmj45VRQLocnG0NiYjdPrE6dfGeq1oxEpqK5Q==
X-Received: by 2002:a05:600c:1e01:b0:426:67f9:a7d8 with SMTP id 5b1f17b1804b1-42e7a8daa02mr16203945e9.9.1726828935097;
        Fri, 20 Sep 2024 03:42:15 -0700 (PDT)
Received: from ?IPv6:2001:8e0:3bcd:3801:7951:2497:3f96:12ee? (2001-8e0-3bcd-3801-7951-2497-3f96-12ee.bbcs.ip6.as8758.net. [2001:8e0:3bcd:3801:7951:2497:3f96:12ee])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42e7540e464sm45873985e9.4.2024.09.20.03.42.14
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Sep 2024 03:42:14 -0700 (PDT)
Message-ID: <6102c928cb2f2e9afbc93e89737556c9d66b68eb.camel@gmail.com>
Subject: Re: Bug: `git init` with hook `reference-transaction` running `git
 rev-parse --git-dir` fails
From: Gabriel =?ISO-8859-1?Q?N=FCtzi?= <gnuetzi@gmail.com>
To: git@vger.kernel.org
Date: Fri, 20 Sep 2024 12:42:13 +0200
In-Reply-To: <0084cc18b6d90ba14849a7f788939f4a1d0d61c9.camel@gmail.com>
References: <0084cc18b6d90ba14849a7f788939f4a1d0d61c9.camel@gmail.com>
Autocrypt: addr=gnuetzi@gmail.com; prefer-encrypt=mutual;
 keydata=mDMEZkXiuBYJKwYBBAHaRw8BAQdAGuoC79ZXUA/zkkAgeLEElUIBjYsvKXPlkbWqF5RcZ
 q+0N0dhYnJpZWwgTsO8dHppIChFZDI1NTE5L0N1cnZlMjU1MTkpIDxnbnVldHppQGdtYWlsLmNvbT
 6IkwQTFgoAOxYhBPJPUqh3/IpkCoNuHfnjsP+dTnqBBQJmReK4AhsDBQsJCAcCAiICBhUKCQgLAgQ
 WAgMBAh4HAheAAAoJEPnjsP+dTnqBOsoBAMzBqtykviO+gsSRXCRLsoy2qtxZbZjR/ES9zZLTobhn
 AQDZJiTrILQTFNHNJ26NLVDM+Av+cjgeOezlCEcAa/N0Aw==
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-4gIzEzcs5AetOu/KvsrU"
User-Agent: Evolution 3.52.4 
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0


--=-4gIzEzcs5AetOu/KvsrU
Content-Type: multipart/alternative; boundary="=-x+NyyT6R3nIrRU2VEsNZ"

--=-x+NyyT6R3nIrRU2VEsNZ
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

The same happens with `git rev-parse --git-comon-dir` and=20
`git config a.a "hello"` (which might be ok, since the config file is not y=
et setup at this point...)

On Fri, 2024-09-20 at 12:07 +0200, Gabriel N=C3=BCtzi wrote:
> Thank you for filling out a Git bug report! =20
> Please answer the following questions to help us understand your issue.
>=20
> What did you do before the bug happened? (Steps to reproduce your =20
> issue)
>=20
> I set `git config --global core.hooksPath ~/myhooks` and placed a =20
> `reference-transaction` hook in `~/myhooks/reference-transaction` =20
> with the content:
>=20
> ```shell =20
> #!/usr/bin/env bash
>=20
> set -e =20
> echo "$GIT_DIR" =20
> git rev-parse --absolute-git-dir =20
> ```
>=20
> then I ran
>=20
> ```shell =20
> mkdir ~/test && cd test =20
> git init =20
> ```
>=20
> What did you expect to happen? (Expected behavior)
>=20
> The Git repo `~/test` should have been initialized (and the hook =20
> `reference-transaction` would have passed successfully.)
>=20
>=20
> What happened instead? (Actual behavior)
>=20
> The hook `reference-transaction` crashes since `git rev-parse -- =20
> absolute-git-dir` with =20
> ``` =20
> failed: not a git repository: ... =20
> ```
>=20
> What's different between what you expected and what actually happened?
>=20
> The documentation says that `git rev-parse --absolute-git-dir` inside =
=20
> the `reference-transaction` hooks read "$GIT_DIR" if defined (which is =
=20
> defined!) so the `reference-transaction` should have passed. I assume =
=20
> that hooks should be executed on properly initialized repositories, =20
> right? Therefore I do not understand why `git rev-parse --absolute-git- =
=20
> dir` fails -> Bug?
>=20
> Anything else you want to add:
>=20
> This came up with `Githooks` hooks manager =20
> [https://github.com/gabyx/Githooks](https://github.com/gabyx/Githooks)=C2=
=A0where we use this command =20
> to locate the current Git dir...
>=20
> Please review the rest of the bug report below. =20
> You can delete any lines you don't wish to share.
>=20
>=20
> [System Info] =20
> git version: =20
> git version 2.46.0 =20
> cpu: x86_64 =20
> no commit associated with this build =20
> sizeof-long: 8 =20
> sizeof-size_t: 8 =20
> shell-path: /nix/store/izpf49b74i15pcr9708s3xdwyqs4jxwl-bash- =20
> 5.2p32/bin/bash =20
> libcurl: 8.9.1 =20
> OpenSSL: OpenSSL 3.0.14 4 Jun 2024 =20
> zlib: 1.3.1 =20
> uname: Linux 6.6.45 #1-NixOS SMP PREEMPT_DYNAMIC Sun Aug 11 10:47:28 =20
> UTC 2024 x86_64 =20
> compiler info: gnuc: 13.3 =20
> libc info: glibc: 2.39 =20
> $SHELL (typically, interactive shell): /run/current-system/sw/bin/zsh
>=20

--=-x+NyyT6R3nIrRU2VEsNZ
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

<p>The same happens with <code>git rev-parse --git-comon-dir</code> and
<code>git config a.a &quot;hello&quot;</code> (which might be ok, since the=
 config file is not yet setup at this point...)</p>
<p>On Fri, 2024-09-20 at 12:07 +0200, Gabriel N=C3=BCtzi wrote:</p>
<blockquote type=3D"cite">
<p>Thank you for filling out a Git bug report!<br />
Please answer the following questions to help us understand your issue.</p>
<p>What did you do before the bug happened? (Steps to reproduce your<br />
issue)</p>
<p>I set <code>git config --global core.hooksPath ~/myhooks</code> and plac=
ed a<br />
<code>reference-transaction</code> hook in <code>~/myhooks/reference-transa=
ction</code><br />
with the content:</p>
<pre><code class=3D"language-shell">#!/usr/bin/env bash

set -e =20
echo &quot;$GIT_DIR&quot; =20
git rev-parse --absolute-git-dir =20
</code></pre>
<p>then I ran</p>
<pre><code class=3D"language-shell">mkdir ~/test &amp;&amp; cd test =20
git init =20
</code></pre>
<p>What did you expect to happen? (Expected behavior)</p>
<p>The Git repo <code>~/test</code> should have been initialized (and the h=
ook<br />
<code>reference-transaction</code> would have passed successfully.)</p>
<p>What happened instead? (Actual behavior)</p>
<p>The hook <code>reference-transaction</code> crashes since <code>git rev-=
parse --   absolute-git-dir</code> with</p>
<pre><code>failed: not a git repository: ... =20
</code></pre>
<p>What's different between what you expected and what actually happened?</=
p>
<p>The documentation says that <code>git rev-parse --absolute-git-dir</code=
> inside<br />
the <code>reference-transaction</code> hooks read &quot;$GIT_DIR&quot; if d=
efined (which is<br />
defined!) so the <code>reference-transaction</code> should have passed. I a=
ssume<br />
that hooks should be executed on properly initialized repositories,<br />
right? Therefore I do not understand why <code>git rev-parse --absolute-git=
-   dir</code> fails -&gt; Bug?</p>
<p>Anything else you want to add:</p>
<p>This came up with <code>Githooks</code> hooks manager<br />
<a href=3D"https://github.com/gabyx/Githooks">https://github.com/gabyx/Gith=
ooks</a>=C2=A0where we use this command<br />
to locate the current Git dir...</p>
<p>Please review the rest of the bug report below.<br />
You can delete any lines you don't wish to share.</p>
<p>[System Info]<br />
git version:<br />
git version 2.46.0<br />
cpu: x86_64<br />
no commit associated with this build<br />
sizeof-long: 8<br />
sizeof-size_t: 8<br />
shell-path: /nix/store/izpf49b74i15pcr9708s3xdwyqs4jxwl-bash-<br />
5.2p32/bin/bash<br />
libcurl: 8.9.1<br />
OpenSSL: OpenSSL 3.0.14 4 Jun 2024<br />
zlib: 1.3.1<br />
uname: Linux 6.6.45 #1-NixOS SMP PREEMPT_DYNAMIC Sun Aug 11 10:47:28<br />
UTC 2024 x86_64<br />
compiler info: gnuc: 13.3<br />
libc info: glibc: 2.39<br />
$SHELL (typically, interactive shell): /run/current-system/sw/bin/zsh</p>
</blockquote>

--=-x+NyyT6R3nIrRU2VEsNZ--

--=-4gIzEzcs5AetOu/KvsrU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTyT1Kod/yKZAqDbh3547D/nU56gQUCZu1RhQAKCRD547D/nU56
gWDfAPkBX7WQzkH85KKgKhuNSoDCXan764HXUtYDce4YHwjh6wEAtMrZXwGqCTsJ
sbmpuD1Q+lCh2hy+nSgK7XOhALJgCQo=
=VjMP
-----END PGP SIGNATURE-----

--=-4gIzEzcs5AetOu/KvsrU--
